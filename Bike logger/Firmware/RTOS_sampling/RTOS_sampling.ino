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
#include <INA226_WE.h>



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

#define INA_226_I2C_ADDRESS 0x41



/* Config section */

/* 
  Set to true or false to poll/not poll
*/
#define POLL_BARO   (true)
#define POLL_GPS    (true)
#define POLL_IMU    (true)
#define POLL_INA226 (true)

/* poll intervals in milliseconds */
#define INA226_SAMPLE_INTERVAL 10
#define GNSS_SAMPLE_INTERVAL 250
#define BARO_SAMPLE_INTERVAL 100
#define IMU_SAMPLE_INTERVAL 1000
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
INA226_WE ina226;
TwoWire I2CINA226 = TwoWire(1);

SemaphoreHandle_t  xMutex;

File imu_file;
File gnss_file;
File ina226_file;
File baro_file;

char buffer_gnss [400];
char buffer_imu [400];
static char sprintfBuffer[400];
char buffer1 [400];


const uint32_t SERIAL_SPEED = 2000000;     ///< Use fast serial speed
const uint32_t I2C_SPEED = 1000000; // 1 Mbits/s
/* Pin numbers for the i2c ports */
const uint16_t sda1 = 21;
const uint16_t scl1 = 22;
const uint16_t sda2 = 19;
const uint16_t scl2 = 18;
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

  Wire.begin(sda1, scl1, I2C_SPEED); // Acclerometer/gyro/temperature/pressure/humidity sensor
  I2CINA226.begin(sda2, scl2, I2C_SPEED); // port for INA226 only

  Serial.begin(SERIAL_SPEED);
  Serial.println("=======================================================");
  Serial.println("================ Ebike BlackBox =======================");
  Serial.println("============== By Medad Rufus Newman ==================");
  Serial.println("======= with assistance from Richard Ibbotson =========");
  Serial.println("=======================================================");

  sd_manager.SD_Manager_init();
  imu_file = SD.open("/imu.csv", FILE_APPEND);
  gnss_file = SD.open("/gnss.csv", FILE_APPEND);
  ina226_file = SD.open("/ina226.csv", FILE_APPEND);
  baro_file = SD.open("/baro.csv", FILE_APPEND);

  
  init_all_sensors();


  xMutex = xSemaphoreCreateMutex();
  if (xMutex == NULL) {
    Serial.println("Mutex can not be created");
  }

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
    ,  12000  // This stack size can be checked & adjusted by reading the Stack Highwater
    ,  NULL
    ,  1  // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);


  xTaskCreatePinnedToCore(
    TaskReadBaro
    ,  "TaskReadBaro"
    ,  6000  // Stack size
    ,  NULL
    ,  1  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
    TaskManageINA226
    ,  "TaskManageINA226"
    ,  90000  // Stack size
    ,  NULL
    ,  2  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);


  xTaskCreatePinnedToCore(
    TaskReadImu
    ,  "TaskReadImu"
    ,  50000  // Stack size
    ,  NULL
    ,  3   // Priority
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
    xSemaphoreTake(xMutex, portMAX_DELAY);
    update_baro_data();
    xSemaphoreGive(xMutex); // release mutex

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
       
        
    xSemaphoreTake(xMutex, portMAX_DELAY);
    update_imu_data();
    xSemaphoreGive(xMutex); // release mutex

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
#if POLL_BARO
  //Get all parameters
  float temperature;
  float pressure;
  float humidity;

  m_ms8607.read_temperature_pressure_humidity(&temperature, &pressure, &humidity);
  /* Write baro data to file */
  sprintf (buffer1, "temp:%f,pressure:%f,humidity:%f\n", temperature, pressure, humidity);
  Serial.print(buffer1);
  sd_manager.appendFile(&baro_file, buffer1);
#endif
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
#if POLL_IMU
  float temp;  //This is to hold read data

  //Now loop until FIFO is empty.  NOTE:  As the FIFO is only 8 bits wide,
  //the channels must be synchronized to a known position for the data to align
  //properly.  Emptying the fifo is one way of doing this (this example)
  while ( ( myIMU.fifoGetStatus() & 0x1000 ) == 0 ) {


    sprintf (buffer_imu, "%f,%f,%f,%f,%f,%f\n",
             myIMU.calcGyro(myIMU.fifoRead()),
             myIMU.calcGyro(myIMU.fifoRead()),
             myIMU.calcGyro(myIMU.fifoRead()),
             myIMU.calcAccel(myIMU.fifoRead()),
             myIMU.calcAccel(myIMU.fifoRead()),
             myIMU.calcAccel(myIMU.fifoRead())
            );

    Serial.print(buffer_imu);
    sd_manager.appendFile(&imu_file, buffer_imu);
  }
#endif
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
#if POLL_GPS
  sprintf (buffer_gnss, "%02u,%02u,%02u,%03u,%d,%d,%d,%d,%d,%d,%d\n",
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

  Serial.print("gps:");
  Serial.print(buffer_gnss);
  sd_manager.appendFile(&gnss_file, buffer_gnss);
#endif
}

/* Initialise the INA226 module */
void init_ina226()
{
  ina226.begin(INA_226_I2C_ADDRESS, &I2CINA226);

  /* Set Number of measurements for shunt and bus voltage which shall be averaged
    Mode *     * Number of samples
    AVERAGE_1            1 (default)
    AVERAGE_4            4
    AVERAGE_16          16
    AVERAGE_64          64
    AVERAGE_128        128
    AVERAGE_256        256
    AVERAGE_512        512
    AVERAGE_1024      1024
  */
  //ina226.setAverage(AVERAGE_16); // choose mode and uncomment for change of default

  /* Set conversion time in microseconds
     One set of shunt and bus voltage conversion will take:
     number of samples to be averaged x conversion time x 2

       Mode *         * conversion time
     CONV_TIME_140          140 µs
     CONV_TIME_204          204 µs
     CONV_TIME_332          332 µs
     CONV_TIME_588          588 µs
     CONV_TIME_1100         1.1 ms (default)
     CONV_TIME_2116       2.116 ms
     CONV_TIME_4156       4.156 ms
     CONV_TIME_8244       8.244 ms
  */
  //ina226.setConversionTime(CONV_TIME_1100); //choose conversion time and uncomment for change of default

  /* Set measure mode
    POWER_DOWN - INA226 switched off
    TRIGGERED  - measurement on demand
    CONTINUOUS  - continuous measurements (default)
  */
  //ina226.setMeasureMode(CONTINUOUS); // choose mode and uncomment for change of default

  /* Set Current Range
      Mode *   * Max Current
     MA_400          400 mA
     MA_800          800 mA (default)
  */
  //ina226.setCurrentRange(MA_800); // choose gain and uncomment for change of default

  /* If the current values delivered by the INA226 differ by a constant factor
     from values obtained with calibrated equipment you can define a correction factor.
     Correction factor = current delivered from calibrated equipment / current delivered by INA226
  */
  // ina226.setCorrectionFactor(0.95);


  ina226.waitUntilConversionCompleted(); //if you comment this line the first data might be zero
}

/* Poll the INA226 once */
void poll_ina226() {


#if POLL_INA226
  float shuntVoltage_mV = 0.0;
  float loadVoltage_V = 0.0;
  float busVoltage_V = 0.0;
  float current_mA = 0.0;
  float power_mW = 0.0;

  ina226.readAndClearFlags();
  shuntVoltage_mV = ina226.getShuntVoltage_mV();
  busVoltage_V = ina226.getBusVoltage_V();
  current_mA = ina226.getCurrent_mA();
  power_mW = ina226.getBusPower();
  loadVoltage_V  = busVoltage_V + (shuntVoltage_mV / 1000);


  sprintf(sprintfBuffer, "Bus_voltage[V]:%f, shunt_v_drop[mV]:%f, shunt_curr[mA]:%f, power[mW]:%f\n",
          busVoltage_V,
          shuntVoltage_mV,
          current_mA,
          power_mW
         );

  Serial.print(sprintfBuffer);

  sd_manager.appendFile(&ina226_file, sprintfBuffer);
#endif

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

  init_imu();
  /* INIT INA226 */
  init_ina226();

}
