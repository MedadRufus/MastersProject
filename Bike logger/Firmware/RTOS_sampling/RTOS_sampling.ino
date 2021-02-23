#include "ms8607.h"
#include "Wire.h"
#include "SparkFunLSM6DS3.h"
#include "sd_card_manager.h"


#if CONFIG_FREERTOS_UNICORE
#define ARDUINO_RUNNING_CORE 0
#else
#define ARDUINO_RUNNING_CORE 1
#endif

#define LED_BUILTIN 27



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


// define two tasks for Blink & AnalogRead
void TaskBlink( void *pvParameters );
void TaskAnalogReadA3( void *pvParameters );

// the setup function runs once when you press reset or power the board
void setup() {

  Wire.begin(21, 22); // Acclerometer/gyro/temperature/pressure/humidity sensor

  Serial.begin(115200);
  Serial.println("=======================================================");
  Serial.println("================ Ebike BlackBox =======================");
  Serial.println("============== By Medad Rufus Newman ==================");
  Serial.println("======= with assistance from Richard Ibbotson =========");
  Serial.println("=======================================================");



  // Now set up tasks to run independently.
  xTaskCreatePinnedToCore(
    TaskBlink
    ,  "TaskBlink"   // A name just for humans
    ,  1024  // This stack size can be checked & adjusted by reading the Stack Highwater
    ,  NULL
    ,  2  // Priority, with 3 (configMAX_PRIORITIES - 1) being the highest, and 0 being the lowest.
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);

  xTaskCreatePinnedToCore(
    TaskReadBaro
    ,  "TaskReadBaro"
    ,  1024  // Stack size
    ,  NULL
    ,  1  // Priority
    ,  NULL
    ,  ARDUINO_RUNNING_CORE);


  xTaskCreatePinnedToCore(
    TaskReadImu
    ,  "TaskReadImu"
    ,  1024  // Stack size
    ,  NULL
    ,  1  // Priority
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

  m_ms8607.begin();
  if (m_ms8607.is_connected() == true) {
    m_ms8607.reset();
  }

  boolean connected = m_ms8607.is_connected();
  Serial.println(connected ? "MS8607 Sensor connencted" : "MS8607 Sensor disconnected");


  for (;;) // A Task shall never return or exit.
  {
    update_baro_data();
    vTaskDelay(100);  // one tick delay (15ms) in between reads for stability
  }
}


void TaskReadImu(void *pvParameters)
{
  (void) pvParameters;

  //Call .begin() to configure the IMU
  myIMU.begin();


  for (;;) // A Task shall never return or exit.
  {
    update_imu_data();
    vTaskDelay(10);  // one tick delay (15ms) in between reads for stability
  }
}

void TaskBlink(void *pvParameters)  // This is a task.
{
  (void) pvParameters;

  /*
    Blink
    Turns on an LED on for one second, then off for one second, repeatedly.

    If you want to know what pin the on-board LED is connected to on your ESP32 model, check
    the Technical Specs of your board.
  */

  // initialize digital LED_BUILTIN on pin 13 as an output.
  pinMode(LED_BUILTIN, OUTPUT);

  for (;;) // A Task shall never return or exit.
  {
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    vTaskDelay(100);  // one tick delay (15ms) in between reads for stability
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
    vTaskDelay(100);  // one tick delay (15ms) in between reads for stability
  }
}





/* Update the sensor data struct with baro values

*/
void update_baro_data()
{
  //Get all parameters
  m_ms8607.read_temperature_pressure_humidity(&sensor_data.temperature, &sensor_data.pressure, &sensor_data.humidity);

  print_baro_values();
}

void print_baro_values()
{
  Serial.print("Tempeature = ");
  Serial.print(sensor_data.temperature);
  Serial.print((char)176);
  Serial.println(" C");

  Serial.print("Pressure = ");
  Serial.print(sensor_data.pressure);
  Serial.println(" hPa");

  Serial.print("Humidity = ");
  Serial.print(sensor_data.humidity);
  Serial.println(" %RH");

  Serial.println("");

}




/* Update the sensor data struct with imu values

*/
void update_imu_data()
{
  //Get all parameters
  sensor_data.acc_x = myIMU.readFloatAccelX();
  sensor_data.acc_y = myIMU.readFloatAccelY();
  sensor_data.acc_z = myIMU.readFloatAccelZ();

  sensor_data.gyro_x = myIMU.readFloatGyroX();
  sensor_data.gyro_y = myIMU.readFloatGyroY();
  sensor_data.gyro_z = myIMU.readFloatGyroZ();

  sensor_data.imu_temperature = myIMU.readTempC();

  print_imu_values();

}

/* Print out all IMU values
*/
void print_imu_values()
{
  Serial.print("x_gyro:");
  Serial.print(sensor_data.gyro_x, 4);
  Serial.print(",");
  Serial.print("y_gyro:");
  Serial.print(sensor_data.gyro_y, 4);
  Serial.print(",");
  Serial.print("z_gyro:");
  Serial.println(sensor_data.gyro_z, 4);


  Serial.print("x_acc:");
  Serial.print(sensor_data.acc_x, 4);
  Serial.print(",");
  Serial.print("y_acc:");
  Serial.print(sensor_data.acc_y, 4);
  Serial.print(",");
  Serial.print("z_acc:");
  Serial.println(sensor_data.acc_z, 4);


  Serial.print("Imu Degrees_C:");
  Serial.println(sensor_data.imu_temperature, 4);
}
