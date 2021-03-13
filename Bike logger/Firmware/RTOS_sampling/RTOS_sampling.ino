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
#include "config.h"
#include <bitset>

/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */
#if CONFIG_FREERTOS_UNICORE
#define ARDUINO_RUNNING_CORE 0
#else
#define ARDUINO_RUNNING_CORE 1
#endif

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

uint16_t readings_in_one_go = 8;
uint16_t bytes_in_one_reading = 12;
uint16_t bytes_to_read = bytes_in_one_reading * readings_in_one_go;
uint16_t fifo_capacity = 4095;
long lastTime = 0; //Simple local timer.

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

#if POLL_BRAKE
  xTaskCreatePinnedToCore(
      TaskBrake, "TaskBrake" // A name just for humans
      ,
      10024 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_brake_Task, ARDUINO_RUNNING_CORE);
#endif

#if POLL_SPEED
  xTaskCreatePinnedToCore(
      TaskSpeed, "TaskSpeed" // A name just for humans
      ,
      10024 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 1 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_speed_Task, ARDUINO_RUNNING_CORE);
#endif

#if POLL_GPS
  xTaskCreatePinnedToCore(
      TaskManageGPS, "TaskManageGPS" // A name just for humans
      ,
      10000 // This stack size can be checked & adjusted by reading the Stack Highwater
      ,
      NULL, 2 // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
      ,
      &Handle_gps_Task, ARDUINO_RUNNING_CORE);
#endif

#if POLL_BARO
  xTaskCreatePinnedToCore(
      TaskReadBaro, "TaskReadBaro", 10000 // Stack size
      ,
      NULL, 2 // Priority
      ,
      &Handle_baroTask, ARDUINO_RUNNING_CORE);
#endif

#if POLL_INA226
  xTaskCreatePinnedToCore(
      TaskManageINA226, "TaskManageINA226_charge", 10000 // Stack size
      ,
      &charge_config, 2 // Priority
      ,
      &Handle_ina1_Task, ARDUINO_RUNNING_CORE);
#endif

#if 0 // to poll the charger IMU226.
  xTaskCreatePinnedToCore(
      TaskManageINA226, "TaskManageINA226_discharge", 10000 // Stack size
      ,
      &discharge_config, 2 // Priority
      ,
      &Handle_ina2_Task, ARDUINO_RUNNING_CORE);
#endif

#if POLL_IMU
  xTaskCreatePinnedToCore(
      TaskReadImu, "TaskReadImu", 20000 // Stack size
      ,
      NULL, 2 // Priority
      ,
      &Handle_imu_Task, ARDUINO_RUNNING_CORE);
#endif

  xTaskCreatePinnedToCore(
      TaskReopen_File, "TaskReopen_File", 2000 // Stack size
      ,
      NULL, 1 // Priority
      ,
      NULL, ARDUINO_RUNNING_CORE);

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
  }
}

void TaskReopen_File(void *pvParameters)
{
  for (;;)
  {
#if PERIODIC_CLOSE_FILE
    delay(INTERVAL_BETWEEN_FLUSHING_FILE);
    xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
    data_file.flush();
    xSemaphoreGive(SPI_SD_Mutex);

#endif
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
#if HEAP_ANALYSIS
    heap_analysis();
#endif
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
  //Get all parameters
  float temperature;
  float pressure;
  float humidity;

  xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);
  m_ms8607.read_temperature_pressure_humidity(&temperature, &pressure, &humidity);
  xSemaphoreGive(I2C1_Mutex); // release mutex

  /* Write baro data to file */
  sprintf(buffer1, "%s,baro,%f,%f,%f\n", NTP.getTimeDateStringUs(), temperature, pressure, humidity);
  Serial.print(buffer1);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, buffer1);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
}

/**
 * @brief Initialise IMU
 * 
 */
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
  myIMU.settings.tempEnabled = 0;

  //Non-basic mode settings
  myIMU.settings.commMode = 1;

  //FIFO control settings
  myIMU.settings.fifoThreshold = fifo_capacity; //Can be 0 to 4095 (16 bit bytes)
  myIMU.settings.fifoSampleRate = 100;          //Hz.  Can be: 10, 25, 50, 100, 200, 400, 800, 1600, 3300, 6600
  myIMU.settings.fifoModeWord = 1;              //FIFO mode.
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
  float temp; //This is to hold read data

  log_d("%s", "START SAVING IMU DATA");

  //Now loop until FIFO is empty.  NOTE:  As the FIFO is only 8 bits wide,
  //the channels must be synchronized to a known position for the data to align
  //properly.  Emptying the fifo is one way of doing this (this example)
  uint16_t bytes_left;

  xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);
  uint16_t fifo_status = myIMU.fifoGetStatus();
  xSemaphoreGive(I2C1_Mutex); // release mutex

  // uses binary print out implementation from : https://stackoverflow.com/a/31660310/13737285
  log_d("fifo_Status : %s", std::bitset<sizeof(fifo_status) * 8>(fifo_status).to_string().insert(0, "0b").c_str());

  lastTime = millis(); //Update the timer

  if ((fifo_status & 0b0001000000000000) == 0) // not empty
  {
    bytes_left = (fifo_status & 0x7FF);

    log_d("bytes in fifo:%d", bytes_left);

    bytes_left = (bytes_left == 0) ? fifo_capacity / 2 : bytes_left;

    for (bytes_left; bytes_left > bytes_to_read * 4; bytes_left = bytes_left - bytes_to_read)
    {
      uint8_t data_bytes[bytes_to_read];
      xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);
      myIMU.readRegisterRegion(data_bytes, LSM6DS3_ACC_GYRO_FIFO_DATA_OUT_L, sizeof(data_bytes));
      xSemaphoreGive(I2C1_Mutex); // release mutex

      for (int i = 0; i < readings_in_one_go; i++)
      {
        int16_t x_acc = convert(data_bytes, i * bytes_in_one_reading + 0);
        int16_t y_acc = convert(data_bytes, i * bytes_in_one_reading + 2);
        int16_t z_acc = convert(data_bytes, i * bytes_in_one_reading + 4);
        int16_t x_gyro = convert(data_bytes, i * bytes_in_one_reading + 6);
        int16_t y_gyro = convert(data_bytes, i * bytes_in_one_reading + 8);
        int16_t z_gyro = convert(data_bytes, i * bytes_in_one_reading + 10);

        sprintf(buffer_imu, "%s,imu,%d,%d,%d,%d,%d,%d\n",
                NTP.getTimeDateStringUs(),
                x_acc,
                y_acc,
                z_acc,
                x_gyro,
                y_gyro,
                z_gyro);

        Serial.print(buffer_imu);

        xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
        sd_manager.appendFile(&data_file, buffer_imu);
        xSemaphoreGive(SPI_SD_Mutex); // release mutex
      }
    }
  }

  log_d("IMU read/save duration[ms]:%d", millis() - lastTime);
}
/**
 * @brief Convert a 2 byte array into a int16_t
 * 
 * @param bytes_source 
 * @param start 
 * @return int16_t 
 */
int16_t convert(uint8_t *bytes_source, uint16_t start)
{
  return (int16_t)bytes_source[start] | int16_t(bytes_source[start + 1] << 8);
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
  /* sync systime if it has not yet been done */
  set_sys_time_ublox(ubxDataStruct);

  sprintf(buffer_gnss, "%s,gps,%02u,%02u,%02u,%03u,%d,%d,%d,%d,%d,%d,%d\n",
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
}

/**
 * @brief Set the sys time ublox object.
 * Set only when systime is 1 second out of sync with gps
 * Set systime only when ublox has good fix.
 * 
 * @param ubxDataStruct 
 * @return true 
 * @return false 
 */
bool set_sys_time_ublox(UBX_NAV_PVT_data_t ubxDataStruct)
{

  if (ubxDataStruct.flags.bits.gnssFixOK == 0) // not a fix. Don't sync systime
  {
    return false;
  }

  timeval newtime;
  timeval currenttime;

  gettimeofday(&currenttime, NULL);

  struct tm t;
  time_t t_of_day;

  t.tm_year = ubxDataStruct.year - 1900; // Year - 1900
  t.tm_mon = ubxDataStruct.month - 1;    // Month, where 0 = jan
  t.tm_mday = ubxDataStruct.day;         // Day of the month
  t.tm_hour = ubxDataStruct.hour;
  t.tm_min = ubxDataStruct.min;
  t.tm_sec = ubxDataStruct.sec;
  t.tm_isdst = 0; // Is DST on? 1 = yes, 0 = no, -1 = unknown
  t_of_day = mktime(&t);

  Serial.printf("Seconds since the Epoch: %ld\n", (uint32_t)t_of_day);

  newtime.tv_sec = t_of_day;
  newtime.tv_usec = ubxDataStruct.iTOW % 1000 * 1000;

  Serial.printf("newtime  %ld.%ld\n", newtime.tv_sec, newtime.tv_usec);

  if (currenttime.tv_sec == newtime.tv_sec)
  {
    // systime is already synced with GPS. no need to sync.
    return false;
  }

  if (settimeofday(&newtime, NULL))
  {
    // hard adjustment
    return false;
  }

  return true;
}

/**
 * @brief Initialise the INA226 module
 * 
 */
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


  /* Set calibration based on resistor value and current range
   *  Takes in Resistance value in Ohms, max current in A
  */
  ina226.setResistorRange(SHUNT_RESISTANCE,INA226_FULL_V_RANGE);


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

  sprintf(sprintfBuffer, "%s,ina226,%d,%f,%f,%f,%f\n",
          NTP.getTimeDateStringUs(),
          ina226_status,
          busVoltage_V,
          shuntVoltage_mV,
          current_mA,
          power_mW);

  Serial.print(sprintfBuffer);
  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, sprintfBuffer);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
}

/* Check the speed */
void check_speed()
{
  // range of 0 - 5 volts, input values of 0 - 1023( must be adjusted)
  float speed_voltage = map(analogRead(MOTOR_PULSE_A_PIN), 0, 1023, 0, 5);

  sprintf(buffer_speed, "%s,speed,%f\n",
          NTP.getTimeDateStringUs(),
          speed_voltage);

  Serial.print(buffer_speed);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, buffer_speed);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
}

/* Check the brake */
void check_brake()
{
  // range of 0 - 5 volts, input values of 0 - 1023( must be adjusted)
  float brake_voltage = map(analogRead(THROTTLE), 0, 1023, 0, 5);

  sprintf(brake_buffer, "%s,brake,%f\n",
          NTP.getTimeDateStringUs(),
          brake_voltage);

  Serial.print(brake_buffer);

  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, brake_buffer);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
}
/**
 * @brief Initialise GPS
 * 
 */
void init_gps()
{
  /* Setup GNSS */
  Serial1.begin(9600, SERIAL_8N1, RXD2, TXD2);
  //myGNSS.enableDebugging(); // Uncomment this line to enable helpful debug messages on Serial
  if (myGNSS.begin(Serial1) == false) //Connect to the u-blox module using Wire port
  {
    Serial.println(F("u-blox GNSS not detected"));
  }
  myGNSS.setI2COutput(COM_TYPE_UBX);              //Set the I2C port to output UBX only (turn off NMEA noise)
  myGNSS.setNavigationFrequency(FIXS_PER_SECOND); //Produce five solutions per second
  myGNSS.setAutoPVTcallback(&logPVTdata);         // Enable automatic NAV PVT messages with callback to printPVTdata
}

/**
 * @brief Initliase Barometer
 * 
 */
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

/**
 * @brief Initilise all sensors
 * 
 */
void init_all_sensors()
{
#if POLL_BARO
  /* INIT baro sensor */
  init_baro();
#endif

#if POLL_GPS
  /* INIT GPS */
  init_gps();
#endif

#if POLL_IMU
  /* INIT IMU */
  init_imu();
#endif

#if POLL_INA226
  /* INIT INA226 */
  init_ina226();
#endif
}

/**
 * @brief Init ntp
 * 
 */
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

  measurement = uxTaskGetStackHighWaterMark(Handle_gps_Task);
  Serial.print("Handle_gps_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_baroTask);
  Serial.print("Handle_baroTask: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_imu_Task);
  Serial.print("Handle_imu_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_ina1_Task);
  Serial.print("Handle_ina1_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_ina2_Task);
  Serial.print("Handle_ina2_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_blink_Task);
  Serial.print("Handle_blink_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_speed_Task);
  Serial.print("Handle_speed_Task: ");
  Serial.println(measurement);

  measurement = uxTaskGetStackHighWaterMark(Handle_brake_Task);
  Serial.print("Handle_brake_Task: ");
  Serial.println(measurement);

  Serial.println("****************************************************");
  Serial.flush();
}
