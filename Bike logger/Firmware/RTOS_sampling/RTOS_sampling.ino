/*********************************************************************
** @source Ebike Blackbox datalogger
**
** Main code for the Ebike logger
**
** @author Copyright (C) 2021  Medad Rufus Newman
** @version v0.1
********************************************************************/


/* ==================================================================== */
/* ========================== include files =========================== */
/* ==================================================================== */


/* Inclusion of system and local header files goes here */
#include "ms8607.h"
#include "Wire.h"
#include "SparkFunLSM6DS3.h"
#include "sd_card_manager.h"
#include <SparkFun_u-blox_GNSS_Arduino_Library.h>
#include <INA.h>  // Zanshin INA Library


/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */
#if CONFIG_FREERTOS_UNICORE
#define ARDUINO_RUNNING_CORE 0
#else
#define ARDUINO_RUNNING_CORE 1
#endif

#define LED_BUILTIN 27
#define RXD2 17
#define TXD2 16

#define INA226_SAMPLE_INTERVAL 510
#define GNSS_SAMPLE_INTERVAL 250
#define BARO_SAMPLE_INTERVAL 480
#define IMU_SAMPLE_INTERVAL 260
#define BLINK_INTERVAL 100

/* ==================================================================== */
/* ======================== global variables ========================== */
/* ==================================================================== */

/* Global variables definitions go here */

struct SensorData
{
  public:
    /* GPS related */
    uint32_t longitude;
    uint32_t latitude;
    uint32_t altitude;
    uint32_t velocity;
    uint32_t sats;

    /* Acceleration/Gyroscope */
    float acc_x;
    float acc_y;
    float acc_z;
    float gyro_x;
    float gyro_y;
    float gyro_z;
    float imu_temperature;

    /* Current voltage */
    int32_t current_discharge;
    int32_t voltage_discharge;
    int32_t current_charge;
    int32_t voltage_charge;

    /* Temperature/pressure/humidity */
    float temperature;
    float pressure;
    float humidity;

    /* Other physical inputs */
    int32_t pedal_rpm;
    bool brake_state;
    int32_t motor_speed;
};

SensorData sensor_data;
static ms8607 m_ms8607;
LSM6DS3 myIMU; //Default constructor is I2C, addr 0x6B
SD_Manager sd_manager;
SFE_UBLOX_GNSS myGNSS;


char buffer_gnss [400];
char buffer_imu [200];


const uint32_t SERIAL_SPEED = 2000000;     ///< Use fast serial speed
const uint32_t SHUNT_MICRO_OHM = 100000;  ///< Shunt resistance in Micro-Ohm, e.g. 100000 is 0.1 Ohm
const uint16_t MAXIMUM_AMPS = 1;          ///< Max expected amps, clamped from 1A to a max of 1022A
uint8_t        devicesFound{0};          ///< Number of INAs found
INA_Class      INA;                      ///< INA class instantiation to use EEPROM
// INA_Class      INA(0);                 ///< INA class instantiation to use EEPROM
// INA_Class      INA(5);                 ///< INA class instantiation to use dynamic memory rather
//   than EEPROM. Allocate storage for up to (n) devices

/* ==================================================================== */
/* ============================== data ================================ */
/* ==================================================================== */

/* Definition of datatypes go here */



/* ==================================================================== */
/* ==================== function prototypes =========================== */
/* ==================================================================== */

/* Function prototypes for public (external) functions go here */


/* ==================================================================== */
/* ============================ functions ============================= */
/* ==================================================================== */

void setup() {

  Wire.begin(21, 22); // Acclerometer/gyro/temperature/pressure/humidity sensor
  Wire.setClock(400000);

  Serial.begin(SERIAL_SPEED);
  Serial.println("=======================================================");
  Serial.println("================ Ebike BlackBox =======================");
  Serial.println("============== By Medad Rufus Newman ==================");
  Serial.println("======= with assistance from Richard Ibbotson =========");
  Serial.println("=======================================================");

  sd_manager.SD_Manager_init();
  init_all_sensors();

  // Now set up tasks to run independently.
  xTaskCreatePinnedToCore(
    TaskBlink
    ,  "TaskBlink"   // A name just for humans
    ,  1024  // This stack size can be checked & adjusted by reading the Stack Highwater
    ,  NULL
    ,  1  // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
    TaskManageGPS
    ,  "TaskManageGPS"   // A name just for humans
    ,  10024  // This stack size can be checked & adjusted by reading the Stack Highwater
    ,  NULL
    ,  1  // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);


  xTaskCreatePinnedToCore(
    TaskReadBaro
    ,  "TaskReadBaro"
    ,  10024  // Stack size
    ,  NULL
    ,  1  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
    TaskManageINA226
    ,  "TaskManageINA226"
    ,  10024  // Stack size
    ,  NULL
    ,  2  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);


  xTaskCreatePinnedToCore(
    TaskReadImu
    ,  "TaskReadImu"
    ,  10024  // Stack size
    ,  NULL
    ,  2   // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  // Now the task scheduler, which takes over control of scheduling individual tasks, is automatically started.
}

void loop()
{
  // Empty. Things are done in Tasks.
}

/*--------------------------------------------------*/
/*---------------------- Tasks ---------------------*/
/*--------------------------------------------------*/

void TaskReadBaro(void *pvParameters)
{
  (void) pvParameters;



  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BARO_SAMPLE_INTERVAL;



  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount ();
  for ( ;; )
  {
    // Wait for the next cycle.
    vTaskDelayUntil( &xLastWakeTime, xFrequency );

    // run task here.

    update_baro_data();

  }
}


void TaskReadImu(void *pvParameters)
{
  (void) pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = IMU_SAMPLE_INTERVAL;



  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount ();
  for ( ;; )
  {
    // Wait for the next cycle.
    vTaskDelayUntil( &xLastWakeTime, xFrequency );
    update_imu_data();

  }
}

/*
  Blink
  Turns on an LED on for BLINK_INTERVAL, then off for BLINK_INTERVAL, repeatedly.
*/
void TaskBlink(void *pvParameters)  // This is a task.
{
  (void) pvParameters;
  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BLINK_INTERVAL;

  bool led_state = false;   // false is OFF, true is ON

  // initialize digital LED_BUILTIN on pin 13 as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, led_state ? HIGH : LOW);

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount ();
  for ( ;; )
  {
    // Wait for the next cycle.
    vTaskDelayUntil( &xLastWakeTime, xFrequency );
    led_state = !led_state;
    digitalWrite(LED_BUILTIN, led_state ? HIGH : LOW);
  }

}


void TaskManageGPS(void *pvParameters)
{
  (void) pvParameters;

  /* Setup GNSS */
  Serial1.begin(9600, SERIAL_8N1, RXD2, TXD2);
  //myGNSS.enableDebugging(); // Uncomment this line to enable helpful debug messages on Serial
  if (myGNSS.begin(Serial1) == false) //Connect to the u-blox module using Wire port
  {
    Serial.println(F("u-blox GNSS not detected"));
  }
  myGNSS.setI2COutput(COM_TYPE_UBX); //Set the I2C port to output UBX only (turn off NMEA noise)
  myGNSS.setNavigationFrequency(2); //Produce two solutions per second
  myGNSS.setAutoPVTcallback(&logPVTdata); // Enable automatic NAV PVT messages with callback to printPVTdata


  TickType_t xLastWakeTime;
  const TickType_t xFrequency = GNSS_SAMPLE_INTERVAL;


  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount ();
  for ( ;; )
  {
    // Wait for the next cycle.
    vTaskDelayUntil( &xLastWakeTime, xFrequency );

    // run task here.
    update_gnss_data();
  }

}


void TaskManageINA226(void *pvParameters)
{
  (void) pvParameters;


  TickType_t xLastWakeTime;
  const TickType_t xFrequency = INA226_SAMPLE_INTERVAL;


  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount ();
  for ( ;; )
  {
    // Wait for the next cycle.
    vTaskDelayUntil( &xLastWakeTime, xFrequency );

    // run task here.
    poll_ina226();
  }

}

/*--------------------------------------------------*/
/*--------------- Other Functions ------------------*/
/*--------------------------------------------------*/


/* Update the sensor data struct with baro values

*/
void update_baro_data()
{
  //Get all parameters
  m_ms8607.read_temperature_pressure_humidity(&sensor_data.temperature, &sensor_data.pressure, &sensor_data.humidity);
  /* Write baro data to file */
  char buffer1 [100];
  sprintf (buffer1, "temp:%f,pressure:%f,humidity:%f\n", sensor_data.temperature, sensor_data.pressure, sensor_data.humidity);
  Serial.print(buffer1);
  sd_manager.appendFileSimple("/baro.csv", buffer1);
}



void init_imu()
{

  //Over-ride default settings if desired
  myIMU.settings.gyroEnabled = 1;  //Can be 0 or 1
  myIMU.settings.gyroRange = 2000;   //Max deg/s.  Can be: 125, 245, 500, 1000, 2000
  myIMU.settings.gyroSampleRate = 833;   //Hz.  Can be: 13, 26, 52, 104, 208, 416, 833, 1666
  myIMU.settings.gyroBandWidth = 200;  //Hz.  Can be: 50, 100, 200, 400;
  myIMU.settings.gyroFifoEnabled = 1;  //Set to include gyro in FIFO
  myIMU.settings.gyroFifoDecimation = 1;  //set 1 for on /1

  myIMU.settings.accelEnabled = 1;
  myIMU.settings.accelRange = 16;      //Max G force readable.  Can be: 2, 4, 8, 16
  myIMU.settings.accelSampleRate = 833;  //Hz.  Can be: 13, 26, 52, 104, 208, 416, 833, 1666, 3332, 6664, 13330
  myIMU.settings.accelBandWidth = 200;  //Hz.  Can be: 50, 100, 200, 400;
  myIMU.settings.accelFifoEnabled = 1;  //Set to include accelerometer in the FIFO
  myIMU.settings.accelFifoDecimation = 1;  //set 1 for on /1
  myIMU.settings.tempEnabled = 1;

  //Non-basic mode settings
  myIMU.settings.commMode = 1;

  //FIFO control settings
  myIMU.settings.fifoThreshold = 4095;  //Can be 0 to 4095 (16 bit bytes)
  myIMU.settings.fifoSampleRate = 100;  //Hz.  Can be: 10, 25, 50, 100, 200, 400, 800, 1600, 3300, 6600
  myIMU.settings.fifoModeWord = 6;  //FIFO mode.
  //FIFO mode.  Can be:
  //  0 (Bypass mode, FIFO off)
  //  1 (Stop when full)
  //  3 (Continuous during trigger)
  //  4 (Bypass until trigger)
  //  6 (Continous mode)

  //Call .begin() to configure the IMUs
  if ( myIMU.begin() != 0 )
  {
    Serial.println("Problem starting the sensor with CS @ Pin 10.");
  }
  else
  {
    Serial.println("Sensor with CS @ Pin 10 started.");
  }

  Serial.print("Configuring FIFO with no error checking...");
  myIMU.fifoBegin();
  Serial.print("Done!\n");

  Serial.print("Clearing out the FIFO...");
  myIMU.fifoClear();
  Serial.print("Done!\n");
}

/* Update the sensor data struct with imu values
*/
void update_imu_data()
{

  sprintf (buffer_imu, "imu: %f,%f,%f,%f,%f,%f\n",
           myIMU.readFloatAccelX(),
           myIMU.readFloatAccelY(),
           myIMU.readFloatAccelZ(),
           myIMU.readFloatGyroX(),
           myIMU.readFloatGyroY(),
           myIMU.readFloatGyroZ()
          );

  Serial.print(buffer_imu);
  sd_manager.appendFileSimple("/imu.csv", buffer_imu);
}



/* Update GNSS data */
void update_gnss_data()
{
  myGNSS.checkUblox(); // Check for the arrival of new data and process it.
  myGNSS.checkCallbacks(); // Check if any callbacks are waiting to be processed.
}

/*  Callback: printPVTdata will be called when new NAV PVT data arrives
    See u-blox_structs.h for the full definition of UBX_NAV_PVT_data_t
*/
void logPVTdata(UBX_NAV_PVT_data_t ubxDataStruct)
{

  sprintf (buffer_gnss, "gps: %02u,%02u,%02u,%03u,%d,%d,%d,%d,%d,%d,%d\n",
           ubxDataStruct.hour,
           ubxDataStruct.min,
           ubxDataStruct.sec,
           ubxDataStruct.iTOW % 1000,
           ubxDataStruct.lat,
           ubxDataStruct.lon,
           ubxDataStruct.hMSL,
           ubxDataStruct.numSV,
           ubxDataStruct.gSpeed,
           ubxDataStruct.flags.bits.gnssFixOK,
           ubxDataStruct.fixType
          );

  Serial.print(buffer_gnss);
  sd_manager.appendFileSimple("/gnss.csv", buffer_gnss);
}

/* Initialise the INA226 module */
void init_ina226()
{
  Serial.print(" - Searching & Initializing INA devices\n");
  /************************************************************************************************
  ** The INA.begin call initializes the device(s) found with an expected ±1 Amps maximum current **
  ** and for a 0.1Ohm resistor, and since no specific device is given as the 3rd parameter all   **
  ** devices are initially set to these values.                                                  **
  ************************************************************************************************/
  devicesFound = INA.begin(MAXIMUM_AMPS, SHUNT_MICRO_OHM);  // Expected max Amp & shunt resistance
  while (devicesFound == 0) {
    Serial.println(F("No INA device found, retrying in 10 seconds..."));
    delay(10000);                                             // Wait 10 seconds before retrying
    devicesFound = INA.begin(MAXIMUM_AMPS, SHUNT_MICRO_OHM);  // Expected max Amp & shunt resistance
  }                                                           // while no devices detected
  Serial.print(F(" - Detected "));
  Serial.print(devicesFound);
  Serial.println(F(" INA devices on the I2C bus"));
  INA.setBusConversion(8500);             // Maximum conversion time 8.244ms
  INA.setShuntConversion(8500);           // Maximum conversion time 8.244ms
  INA.setAveraging(128);                  // Average each reading n-times
  INA.setMode(INA_MODE_CONTINUOUS_BOTH);  // Bus/shunt measured continuously
  INA.alertOnBusOverVoltage(true, 5000);  // Trigger alert if over 5V on bus
}

/* Poll the INA226 once */
void poll_ina226() {
  /*!
     @brief    Arduino method for the main program loop
     @details  This is the main program for the Arduino IDE, it is an infinite loop and keeps on
     repeating. In order to format the output use is made of the "sprintf()" function, but in the
     Arduino implementation it has no support for floating point output, so the "dtostrf()" function
     is used to convert the floating point numbers into formatted strings.
     @return   void
  */
  static uint16_t loopCounter = 0;     // Count the number of iterations
  static char     sprintfBuffer[150];  // Buffer to format output
  static char     busChar[8], shuntChar[10], busMAChar[10], busMWChar[10];  // Output buffers

  for (uint8_t i = 0; i < devicesFound; i++)  // Loop through all devices
  {
    dtostrf(INA.getBusMilliVolts(i) / 1000.0, 7, 4, busChar);      // Convert floating point to char
    dtostrf(INA.getShuntMicroVolts(i) / 1000.0, 9, 4, shuntChar);  // Convert floating point to char
    dtostrf(INA.getBusMicroAmps(i) / 1000.0, 9, 4, busMAChar);     // Convert floating point to char
    dtostrf(INA.getBusMicroWatts(i) / 1000.0, 9, 4, busMWChar);    // Convert floating point to char
    sprintf(sprintfBuffer, "dev_id:%2d, dev_add:%3d, dev_type:%s, voltage:%sV, shunt_v_drop:%smV, shunt_curr:%smA, power%smW\n", i + 1, INA.getDeviceAddress(i),
            INA.getDeviceName(i), busChar, shuntChar, busMAChar, busMWChar);
    Serial.print(sprintfBuffer);
  }  // for-next each INA device loop

}


void init_all_sensors()
{
  /* INIT baro sensor */
  m_ms8607.begin();
  if (m_ms8607.is_connected() == true) {
    m_ms8607.reset();
  }

  boolean connected = m_ms8607.is_connected();
  Serial.println(connected ? "MS8607 Sensor connencted" : "MS8607 Sensor disconnected");

  /* INIT IMU */
  myIMU.begin();

  /* INIT INA226 */
  init_ina226();

}
