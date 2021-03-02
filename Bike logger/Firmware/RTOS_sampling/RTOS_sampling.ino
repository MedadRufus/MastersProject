/*********************************************************************
** @source Ebike Blackbox datalogger
**
** Main code for the Ebike logger
**
** @author Copyright (C) 2021  Medad Rufus Newman
** @version v0.1
** Mutex tips from https://microcontrollerslab.com/arduino-freertos-mutex-tutorial-priority-inversion-priority-inheritance/
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
#include "RTOS_sampling.h"

#include <ESPNtpClient.h>
#include <WiFi.h>
#include "WifiConfig.h"
#include <list>

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
#define POLL_BARO (true)
#define POLL_GPS (true)
#define POLL_IMU (true)
#define POLL_INA226 (true)
#define POLL_BRAKE (true)
#define POLL_SPEED (true)

/* poll intervals in milliseconds */
#define INA226_SAMPLE_INTERVAL 10
#define GNSS_SAMPLE_INTERVAL 250
#define BARO_SAMPLE_INTERVAL 250
#define IMU_SAMPLE_INTERVAL 300
#define BLINK_INTERVAL 100
#define BRAKE_INTERVAL 100
#define SPEED_INTERVAL 100

#ifndef WIFI_CONFIG_H
#define YOUR_WIFI_SSID "YOUR_WIFI_SSID"
#define YOUR_WIFI_PASSWD "YOUR_WIFI_PASSWD"
#endif // !WIFI_CONFIG_H

#define MOTOR_PULSE_A_PIN 35
#define MOTOR_PULSE_B_PIN 34
#define PAS 36
#define THROTTLE 39

/* ==================================================================== */
/* ======================== global variables ========================== */
/* ==================================================================== */

/* Global variables definitions go here */
typedef enum
{
  CHARGE = 0,
  DISCHARGE
} INA226_STATUS;
/** Structure to initialize INA226 task */
typedef struct
{
  INA226_STATUS ina226_status;
} ina226_config_t;

ina226_config_t charge_config = {.ina226_status = CHARGE};
ina226_config_t discharge_config = {.ina226_status = DISCHARGE};

static ms8607 m_ms8607;
LSM6DS3 myIMU; //Default constructor is I2C, addr 0x6B
SD_Manager sd_manager;
SFE_UBLOX_GNSS myGNSS;
INA226_WE ina226;
TwoWire I2CINA226 = TwoWire(1);

SemaphoreHandle_t I2C1_Mutex;
SemaphoreHandle_t I2C2_Mutex;
SemaphoreHandle_t SPI_SD_Mutex;

File data_file;

char buffer_gnss[400];
char buffer_imu[400];
static char sprintfBuffer[400];
char buffer1[400];
char buffer_speed[400];
char brake_buffer[400];

const uint32_t SERIAL_SPEED = 2000000; // Use fast serial speed 2 Mbits/s
const uint32_t I2C_SPEED = 1000000;    // 1 Mbits/s
/* Pin numbers for the i2c ports */
const uint16_t sda1 = 21;
const uint16_t scl1 = 22;
const uint16_t sda2 = 19;
const uint16_t scl2 = 18;

TaskHandle_t Handle_gps_Task;
TaskHandle_t Handle_baroTask;
TaskHandle_t Handle_imu_Task;
TaskHandle_t Handle_ina1_Task;
TaskHandle_t Handle_ina2_Task;
TaskHandle_t Handle_blink_Task;
TaskHandle_t Handle_speed_Task;
TaskHandle_t Handle_brake_Task;

// TaskHandle_t taskhandles [] = {&Handle_gps_Task,&Handle_baroTask, &Handle_imu_Task,&Handle_ina1_Task,
//  &Handle_ina2_Task,&Handle_blink_Task,&Handle_speed_Task,&Handle_brake_Task};

std::list<TaskHandle_t> taskhandles = {&Handle_gps_Task, &Handle_baroTask, &Handle_imu_Task, &Handle_ina1_Task,
                                       &Handle_ina2_Task, &Handle_blink_Task, &Handle_speed_Task, &Handle_brake_Task};

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

void setup()
{

  Wire.begin(sda1, scl1, I2C_SPEED);      // Acclerometer/gyro/temperature/pressure/humidity sensor
  I2CINA226.begin(sda2, scl2, I2C_SPEED); // port for INA226 only

  Serial.begin(SERIAL_SPEED);
  Serial.println("=======================================================");
  Serial.println("================ Ebike BlackBox =======================");
  Serial.println("============== By Medad Rufus Newman ==================");
  Serial.println("======= with assistance from Richard Ibbotson =========");
  Serial.println("=======================================================");

  init_ntp();

  sd_manager.SD_Manager_init();
  data_file = SD.open("/data.csv", FILE_APPEND);

  init_all_sensors();

  I2C1_Mutex = xSemaphoreCreateMutex();
  if (I2C1_Mutex == NULL)
  {
    Serial.println("Mutex can not be created");
  }

  I2C2_Mutex = xSemaphoreCreateMutex();
  if (I2C2_Mutex == NULL)
  {
    Serial.println("Mutex can not be created");
  }

  SPI_SD_Mutex = xSemaphoreCreateMutex();
  if (SPI_SD_Mutex == NULL)
  {
    Serial.println("Mutex can not be created");
  }
  
  start_tasks();

}

void start_tasks()
{
  // Now set up tasks to run independently.
  xTaskCreatePinnedToCore(
      TaskBlink, "TaskBlink" // A name just for humans
      ,
      1024 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_blink_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskBrake, "TaskBrake" // A name just for humans
      ,
      8024 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_brake_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskSpeed, "TaskSpeed" // A name just for humans
      ,
      8024 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_speed_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskManageGPS, "TaskManageGPS" // A name just for humans
      ,
      20000 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_gps_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskReadBaro, "TaskReadBaro", 20000 // Stack size
      ,
      NULL, 2 // Priority
      ,
      &Handle_baroTask, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskManageINA226, "TaskManageINA226_charge", 22000 // Stack size
      ,
      &charge_config, 3 // Priority
      ,
      &Handle_ina1_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskManageINA226, "TaskManageINA226_discharge", 22000 // Stack size
      ,
      &discharge_config, 3 // Priority
      ,
      &Handle_ina2_Task, ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
      TaskReadImu, "TaskReadImu", 50000 // Stack size
      ,
      NULL, 3 // Priority
      ,
      &Handle_imu_Task, ARDUINO_RUNNING_CORE);

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
  (void)pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BARO_SAMPLE_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // run task here.
    update_baro_data();

    delay(5000);
    data_file.close();
    data_file = SD.open("/data.csv", FILE_APPEND);
  }
}

void TaskSpeed(void *pvParameters)
{
  (void)pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = SPEED_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    check_speed();
  }
}

void TaskBrake(void *pvParameters)
{
  (void)pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BRAKE_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    check_brake();
  }
}

void TaskReadImu(void *pvParameters)
{
  (void)pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = IMU_SAMPLE_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    update_imu_data();
  }
}

/*
  Blink
  Turns on an LED on for BLINK_INTERVAL, then off for BLINK_INTERVAL, repeatedly.
*/
void TaskBlink(void *pvParameters) // This is a task.
{
  (void)pvParameters;
  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BLINK_INTERVAL;

  bool led_state = false; // false is OFF, true is ON

  // initialize digital LED_BUILTIN on pin 13 as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, led_state ? HIGH : LOW);

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);
    led_state = !led_state;
    digitalWrite(LED_BUILTIN, led_state ? HIGH : LOW);
    heap_analysis();
  }
}

void TaskManageGPS(void *pvParameters)
{
  (void)pvParameters;

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = GNSS_SAMPLE_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // run task here.
    update_gnss_data();
  }
}

void TaskManageINA226(void *pvParameters)
{
  //(void) pvParameters;

  ina226_config_t our_config = *(ina226_config_t *)pvParameters;

  Serial.print("charge config: ");
  Serial.println(our_config.ina226_status);

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = INA226_SAMPLE_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    // run task here.
    poll_ina226(our_config.ina226_status);
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

  xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);
  m_ms8607.read_temperature_pressure_humidity(&temperature, &pressure, &humidity);
  xSemaphoreGive(I2C1_Mutex); // release mutex

  /* Write baro data to file */
  sprintf(buffer1, "%s temp:%f,pressure:%f,humidity:%f\n", NTP.getTimeDateStringUs(), temperature, pressure, humidity);
  Serial.print(buffer1);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, buffer1);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex

#endif
}

void init_imu()
{

  //Over-ride default settings if desired
  myIMU.settings.gyroEnabled = 1;        //Can be 0 or 1
  myIMU.settings.gyroRange = 2000;       //Max deg/s.  Can be: 125, 245, 500, 1000, 2000
  myIMU.settings.gyroSampleRate = 833;   //Hz.  Can be: 13, 26, 52, 104, 208, 416, 833, 1666
  myIMU.settings.gyroBandWidth = 200;    //Hz.  Can be: 50, 100, 200, 400;
  myIMU.settings.gyroFifoEnabled = 1;    //Set to include gyro in FIFO
  myIMU.settings.gyroFifoDecimation = 1; //set 1 for on /1

  myIMU.settings.accelEnabled = 1;
  myIMU.settings.accelRange = 16;         //Max G force readable.  Can be: 2, 4, 8, 16
  myIMU.settings.accelSampleRate = 833;   //Hz.  Can be: 13, 26, 52, 104, 208, 416, 833, 1666, 3332, 6664, 13330
  myIMU.settings.accelBandWidth = 200;    //Hz.  Can be: 50, 100, 200, 400;
  myIMU.settings.accelFifoEnabled = 1;    //Set to include accelerometer in the FIFO
  myIMU.settings.accelFifoDecimation = 1; //set 1 for on /1
  myIMU.settings.tempEnabled = 1;

  //Non-basic mode settings
  myIMU.settings.commMode = 1;

  //FIFO control settings
  myIMU.settings.fifoThreshold = 4095; //Can be 0 to 4095 (16 bit bytes)
  myIMU.settings.fifoSampleRate = 100; //Hz.  Can be: 10, 25, 50, 100, 200, 400, 800, 1600, 3300, 6600
  myIMU.settings.fifoModeWord = 6;     //FIFO mode.
  //FIFO mode.  Can be:
  //  0 (Bypass mode, FIFO off)
  //  1 (Stop when full)
  //  3 (Continuous during trigger)
  //  4 (Bypass until trigger)
  //  6 (Continous mode)

  //Call .begin() to configure the IMUs
  if (myIMU.begin() != 0)
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
  float temp; //This is to hold read data

  Serial.println("START SAVING IMU DATA");

  //Now loop until FIFO is empty.  NOTE:  As the FIFO is only 8 bits wide,
  //the channels must be synchronized to a known position for the data to align
  //properly.  Emptying the fifo is one way of doing this (this example)
  while ((myIMU.fifoGetStatus() & 0x1000) == 0)
  {

    xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);

    sprintf(buffer_imu, "%f,%f,%f,%f,%f,%f\n",
            myIMU.calcGyro(myIMU.fifoRead()),
            myIMU.calcGyro(myIMU.fifoRead()),
            myIMU.calcGyro(myIMU.fifoRead()),
            myIMU.calcAccel(myIMU.fifoRead()),
            myIMU.calcAccel(myIMU.fifoRead()),
            myIMU.calcAccel(myIMU.fifoRead()));

    xSemaphoreGive(I2C1_Mutex); // release mutex

    //Serial.print(buffer_imu);
    xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
    sd_manager.appendFile(&data_file, buffer_imu);
    xSemaphoreGive(SPI_SD_Mutex); // release mutex
  }
  Serial.println("SAVED IMU DATA");

#endif
}

/* Update GNSS data */
void update_gnss_data()
{
  myGNSS.checkUblox();     // Check for the arrival of new data and process it.
  myGNSS.checkCallbacks(); // Check if any callbacks are waiting to be processed.
}

/*  Callback: printPVTdata will be called when new NAV PVT data arrives
    See u-blox_structs.h for the full definition of UBX_NAV_PVT_data_t
*/
void logPVTdata(UBX_NAV_PVT_data_t ubxDataStruct)
{
#if POLL_GPS
  sprintf(buffer_gnss, "%s gps:%02u,%02u,%02u,%03u,%d,%d,%d,%d,%d,%d,%d\n",
          NTP.getTimeDateStringUs(),
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
          ubxDataStruct.fixType);

  Serial.print(buffer_gnss);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, buffer_gnss);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex

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
void poll_ina226(INA226_STATUS ina226_status)
{

#if POLL_INA226
  float shuntVoltage_mV = 0.0;
  float loadVoltage_V = 0.0;
  float busVoltage_V = 0.0;
  float current_mA = 0.0;
  float power_mW = 0.0;

  xSemaphoreTake(I2C2_Mutex, portMAX_DELAY);

  ina226.readAndClearFlags();
  shuntVoltage_mV = ina226.getShuntVoltage_mV();
  busVoltage_V = ina226.getBusVoltage_V();
  current_mA = ina226.getCurrent_mA();
  power_mW = ina226.getBusPower();
  loadVoltage_V = busVoltage_V + (shuntVoltage_mV / 1000);

  xSemaphoreGive(I2C2_Mutex); // release mutex

  sprintf(sprintfBuffer, "%s role: %d, Bus_voltage[V]:%f, shunt_v_drop[mV]:%f, shunt_curr[mA]:%f, power[mW]:%f\n",
          NTP.getTimeDateStringUs(),
          ina226_status,
          busVoltage_V,
          shuntVoltage_mV,
          current_mA,
          power_mW);

  //Serial.print(sprintfBuffer);
  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, sprintfBuffer);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
#endif
}

/* Check the brake */
void check_speed()
{

#if POLL_SPEED
  // range of 0 - 5 volts, input values of 0 - 1023( must be adjusted)
  float speed_voltage = map(analogRead(MOTOR_PULSE_A_PIN), 0, 1023, 0, 5);

  sprintf(buffer_speed, "%s speed_voltage[mV]:%f\n",
          NTP.getTimeDateStringUs(),
          speed_voltage);

  Serial.print(buffer_speed);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, buffer_speed);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
#endif
}

/* Check the brake */
void check_brake()
{

#if POLL_BRAKE
  // range of 0 - 5 volts, input values of 0 - 1023( must be adjusted)
  float brake_voltage = map(analogRead(THROTTLE), 0, 1023, 0, 5);

  sprintf(brake_buffer, "%s brake_voltage[mV]:%f\n",
          NTP.getTimeDateStringUs(),
          brake_voltage);

  Serial.print(brake_buffer);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, brake_buffer);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
#endif
}

void init_gps()
{
  /* Setup GNSS */
  Serial1.begin(9600, SERIAL_8N1, RXD2, TXD2);
  //myGNSS.enableDebugging(); // Uncomment this line to enable helpful debug messages on Serial
  if (myGNSS.begin(Serial1) == false) //Connect to the u-blox module using Wire port
  {
    Serial.println(F("u-blox GNSS not detected"));
  }
  myGNSS.setI2COutput(COM_TYPE_UBX);      //Set the I2C port to output UBX only (turn off NMEA noise)
  myGNSS.setNavigationFrequency(2);       //Produce two solutions per second
  myGNSS.setAutoPVTcallback(&logPVTdata); // Enable automatic NAV PVT messages with callback to printPVTdata
}

void init_baro()
{
  m_ms8607.begin();
  if (m_ms8607.is_connected() == true)
  {
    m_ms8607.reset();
  }

  boolean connected = m_ms8607.is_connected();
  Serial.println(connected ? "MS8607 Sensor connencted" : "MS8607 Sensor disconnected");
}

void init_all_sensors()
{
  /* INIT baro sensor */
  init_baro();
  /* INIT GPS */
  init_gps();
  /* INIT IMU */
  init_imu();
  /* INIT INA226 */
  init_ina226();
}

void init_ntp()
{
  WiFi.begin(YOUR_WIFI_SSID, YOUR_WIFI_PASSWD);
  NTP.setTimeZone(TZ_Etc_UTC);
  NTP.begin();
}

void heap_analysis()
{
  int x;
  int measurement;

  Serial.flush();
  Serial.println("");
  Serial.println("****************************************************");
  Serial.print("Free Heap: ");
  Serial.print(xPortGetFreeHeapSize());
  Serial.println(" bytes");

  Serial.print("Min Heap: ");
  Serial.print(xPortGetMinimumEverFreeHeapSize());
  Serial.println(" bytes");
  Serial.flush();

#if 0 
  Serial.println("****************************************************");
  Serial.println("Task            ABS             %Util");
  Serial.println("****************************************************");

  //vTaskGetRunTimeStats(ptrTaskList); //save stats to char array
  Serial.println(ptrTaskList); //prints out already formatted stats
  Serial.flush();

  Serial.println("****************************************************");
  Serial.println("Task            State   Prio    Stack   Num     Core" );
  Serial.println("****************************************************");

  //vTaskList(ptrTaskList); //save stats to char array
  Serial.println(ptrTaskList); //prints out already formatted stats
  Serial.flush();

  Serial.println("****************************************************");
  Serial.println("[Stacks Free Bytes Remaining] ");
#endif

  for (const TaskHandle_t &taskhandle : taskhandles)
  {
    measurement = uxTaskGetStackHighWaterMark(taskhandle);
    Serial.print("Thread A: ");
    Serial.println(measurement);
  }

  measurement = uxTaskGetStackHighWaterMark(Handle_baroTask);
  Serial.print("Thread B: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_imu_Task);
  Serial.print("Monitor Stack: ");
  Serial.println(measurement);

  Serial.println("****************************************************");
  Serial.flush();
}
