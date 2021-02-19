/*********************************************************************
** @source __ApplicationName__
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



/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */

#define LED_BUILTIN 33

/* ==================================================================== */
/* ======================== global variables ========================== */
/* ==================================================================== */

/* Global variables definitions go here */

StateMachine blinker1(100, true);
StateMachine poll_accel(10, true);
StateMachine poll_gps(1000, true);
StateMachine poll_IN226(1, true);

const int led1 = LED_BUILTIN;
bool state1 = false;   // false is OFF, true is ON

struct sensor_data
{
  /* GPS related */
  uint32_t longitude;
  uint32_t latitude;
  uint32_t altitude;
  uint32_t velocity;
  uint32_t sats;

  /* Acceleration/Gyroscope */
  int16_t acc_x;
  int16_t acc_y;
  int16_t acc_z;
  int16_t gyro_x;
  int16_t gyro_y;
  int16_t gyro_z;

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

/* ==================================================================== */
/* ============================== data ================================ */
/* ==================================================================== */

/* Definition of datatypes go here */



/* ==================================================================== */
/* ==================== function prototypes =========================== */
/* ==================================================================== */

/* Function prototypes for public (external) functions go here */

/* @prog __ApplicationName ****************************************************
**
** Logs all data to SD card
**
******************************************************************************/

/* ==================================================================== */
/* ============================ functions ============================= */
/* ==================================================================== */

void setup() 
{
  pinMode(led1, OUTPUT);
  digitalWrite(led1, state1 ? HIGH : LOW);
}


void loop() 
{
  if (blinker1.update()) {
    state1 = !state1;
    digitalWrite(led1, state1 ? HIGH : LOW);
  }
}
