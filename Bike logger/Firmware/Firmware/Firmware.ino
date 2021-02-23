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
#include <StateMachine.h>
#include "SparkFunLSM6DS3.h"
#include "Wire.h"
#include "SPI.h"


/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */

#define LED_PIN 27

/* ==================================================================== */
/* ======================== global variables ========================== */
/* ==================================================================== */

/* Global variables definitions go here */

StateMachine blinker1(100, true);
StateMachine poll_imu(10, true);
StateMachine poll_baro(10, true);
StateMachine poll_gps(1000, true);
StateMachine poll_IN226(1, true);
StateMachine write_to_sd(1, true);

const int led1 = LED_PIN;
bool state1 = false;   // false is OFF, true is ON


LSM6DS3 myIMU; //Default constructor is I2C, addr 0x6B


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
  pinMode(led1, OUTPUT);
  digitalWrite(led1, state1 ? HIGH : LOW);
  Wire.begin(21,22); // Acclerometer/gyro/temperature/pressure/humidity sensor

  Serial.begin(115200);
  Serial.println("=======================================================");
  Serial.println("================ Ebike BlackBox =======================");
  Serial.println("============== By Medad Rufus Newman ==================");
  Serial.println("======= with assistance from Richard Ibbotson =========");
  Serial.println("=======================================================");

  //Call .begin() to configure the IMU
  myIMU.begin();
}


void loop()
{
  if (blinker1.update()) {
    state1 = !state1;
    digitalWrite(led1, state1 ? HIGH : LOW);
  }

  if (poll_imu.update()) {
    update_imu_data();
  }

  if (poll_baro.update()) {
    update_baro_data();
  }
  
  if (poll_gps.update()) {
  }

  if (poll_IN226.update()) {
  }

  if (write_to_sd.update()) {
  }
}


/* Update the sensor data struct with baro values
 *  
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

/* Update the sensor data struct with imu values
 *  
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

/* Inefficient way of printing out imu values, since we
 *  are reading the values all over again
 */
void print_imu_values()
{
  Serial.print("x_gyro:");
  Serial.print(myIMU.readFloatGyroX(), 4);
  Serial.print(",");
  Serial.print("y_gyro:");
  Serial.print(myIMU.readFloatGyroY(), 4);
  Serial.print(",");
  Serial.print("z_gyro ");
  Serial.println(myIMU.readFloatGyroZ(), 4);


  Serial.print("x_acc:");
  Serial.print(myIMU.readFloatAccelX(), 4);
  Serial.print(",");
  Serial.print("y_acc:");
  Serial.print(myIMU.readFloatAccelY(), 4);
  Serial.print(",");
  Serial.print("z_acc:");
  Serial.println(myIMU.readFloatAccelZ(), 4);


  Serial.print("Degrees_C:");
  Serial.println(myIMU.readTempC(), 4);
}
