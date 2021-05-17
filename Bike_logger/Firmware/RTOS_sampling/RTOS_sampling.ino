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
#include "heap_analysis.hpp"

#include "src/pulse_counter_adc/pulse_counter_adc.hpp"
#include "src/pulse_counter_rtos/pulse_counter_rtos.hpp"
#include "src/state_logger/state_logger.hpp"

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
const uint32_t I2C_SPEED = 400000;     // 1 Mbits/s
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
  init_mutexes();
#if POLL_MOTOR_SPEED
  init_adc_edge_detect();
#endif

#if POLL_PAS
  setup_pulse_counter();
#endif

#if POLL_BRAKE
  init_state_logger();
#endif

  start_tasks();
}

void init_mutexes()
{
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
  const char *format = "%s,baro,%f,%f,%f\n";
  sprintf(buffer1, format, NTP.getTimeDateStringUs(), temperature, pressure, humidity);
  //Serial.print(buffer1);

  save_to_sd(buffer1);
}

/**
 * @brief Initialise IMU
 * 
 */
void init_imu()
{
  //Call .begin() to configure the IMUs
  if (myIMU.begin() != 0)
  {
    Serial.println("Problem starting the sensor with CS @ Pin 10.");
  }
  else
  {
    Serial.println("Sensor with CS @ Pin 10 started.");
  }

  /**
   * @brief Pull-up is enabled if bit SIM = 1 (SPI 3-wire) in reg 12h.
   * force pull up the SD0 pin for I2C to ensure its least significant bit is always 1, not floating
   * IN the hardware, it was not pulled up(or down), which it should have been.
   */
  myIMU.LSM6DS3_ACC_GYRO_W_SPI_Mode(LSM6DS3_ACC_GYRO_SIM_3_WIRE);

  /**
   * @brief Pull-up is enabled if bit PULL_UP_EN = 1 in reg 1Ah
   * It is necessary to pull up the SDx and SCx pins, to save power. However, it was
   * not done in the hardware, hence doing by software workaround.   * 
   */
  myIMU.LSM6DS3_ACC_GYRO_W_PULL_UP_EN(LSM6DS3_ACC_GYRO_PULL_UP_EN_ENABLED);
}

/* Update the sensor data struct with imu values
*/
void update_imu_data()
{

  xSemaphoreTake(I2C1_Mutex, portMAX_DELAY);

  sprintf(buffer_imu, "%s,imu,%f,%f,%f,%f,%f,%f\n",
          NTP.getTimeDateStringUs(),
          myIMU.readFloatAccelX(),
          myIMU.readFloatAccelY(),
          myIMU.readFloatAccelZ(),
          myIMU.readFloatGyroX(),
          myIMU.readFloatGyroY(),
          myIMU.readFloatGyroZ());

  xSemaphoreGive(I2C1_Mutex); // release mutex

  //Serial.print(buffer_imu);

  save_to_sd(buffer_imu);
}

void save_to_sd(const char *message)
{
  xSemaphoreTake(SPI_SD_Mutex, portMAX_DELAY);
  sd_manager.appendFile(&data_file, message);
  xSemaphoreGive(SPI_SD_Mutex); // release mutex
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

  sprintf(buffer_gnss, "%s,gps,%02u,%02u,%02u,%03u,%f,%f,%f,%f,%d,%d,%d,%d\n",
          NTP.getTimeDateStringUs(),
          ubxDataStruct.hour,
          ubxDataStruct.min,
          ubxDataStruct.sec,
          ubxDataStruct.iTOW % 1000,
          (float)ubxDataStruct.lat / 1e7,
          (float)ubxDataStruct.lon / 1e7,
          (float)ubxDataStruct.height / 1000,   /* m altitude */
          (float)ubxDataStruct.gSpeed * 0.0036, /* km/h */
          ubxDataStruct.numSV,
          ubxDataStruct.flags.bits.gnssFixOK,
          ubxDataStruct.fixType,
          (float)ubxDataStruct.headVeh / 1e5);

  //Serial.print(buffer_gnss);

  save_to_sd(buffer_gnss);
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
    Serial.println("systime is already synced with GPS. no need to sync.");
    return false;
  }

  if (settimeofday(&newtime, NULL))
  {
    // hard adjustment
    Serial.println("systime is not synced. Hard ajustment.");
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
  ina226.setResistorRange(SHUNT_RESISTANCE, INA226_FULL_CURRENT_RANGE);

  /* If the current values delivered by the INA226 differ by a constant factor
     from values obtained with calibrated equipment you can define a correction factor.
     Correction factor = current delivered from calibrated equipment / current delivered by INA226
  */
  // ina226.setCorrectionFactor(0.95);

  //ina226.waitUntilConversionCompleted(); //if you comment this line the first data might be zero
  delay(10);
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

  //Serial.print(sprintfBuffer);

  save_to_sd(sprintfBuffer);
}

/**
 * @brief Initialise GPS
 * 
 */
void init_gps()
{
  /* Setup GNSS */
  Serial1.begin(9600, SERIAL_8N1, RXD2, TXD2);
  if (myGNSS.begin(Serial1) == false) //Connect to the u-blox module using Wire port
  {
    Serial.println(F("u-blox GNSS not detected"));
  }

  //myGNSS.factoryReset();
  myGNSS.setDynamicModel(DYN_MODEL_PORTABLE);
  delay(1000);                                    /* Allow gps to restart */
  myGNSS.setUART1Output(COM_TYPE_UBX);            //Set the UART port to output UBX only (turn off NMEA noise)
  myGNSS.setNavigationFrequency(FIXS_PER_SECOND); //Produce five solutions per second
  myGNSS.setAutoPVTcallback(&logPVTdata);         // Enable automatic NAV PVT messages with callback to printPVTdata
  myGNSS.saveConfiguration();
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

  //The sensor has 6 resolution levels. The higher the resolution the longer each
  //reading takes to complete.
  //  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_256); //1ms per reading, 0.11mbar resolution
  //  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_512); //2ms per reading, 0.062mbar resolution
  //  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_1024); //3ms per reading, 0.039mbar resolution
  //  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_2048); //5ms per reading, 0.028mbar resolution
  //  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_4096); //9ms per reading, 0.021mbar resolution
  m_ms8607.set_pressure_resolution(ms8607_pressure_resolution_osr_8192); //17ms per reading, 0.016mbar resolution
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
