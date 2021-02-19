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



/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */

#define LED_BUILTIN 33

/* ==================================================================== */
/* ======================== global variables ========================== */
/* ==================================================================== */

/* Global variables definitions go here */

long lastTime = 0;

/* ==================================================================== */
/* ============================== data ================================ */
/* ==================================================================== */

/* Definition of datatypes go here */



/* ==================================================================== */
/* ==================== function prototypes =========================== */
/* ==================================================================== */

/* Function prototypes for public (external) functions go here */
void blink_led(bool reset = false);


/* @prog __ApplicationName ****************************************************
**
** Logs all data to SD card
**
******************************************************************************/

/* ==================================================================== */
/* ============================ functions ============================= */
/* ==================================================================== */
#include <StateMachine.h>

StateMachine blinker1(1000, true);
StateMachine blinker2(1010, true);
StateMachine blinker3(1020, true);

const int led1 = LED_BUILTIN;
const int led2 = 5;
const int led3 = 3;

bool state1 = false;   // false is OFF, true is ON
bool state2 = false;   // false is OFF, true is ON
bool state3 = false;   // false is OFF, true is ON

void setup() 
{
  pinMode(led1, OUTPUT);
  digitalWrite(led1, state1 ? HIGH : LOW);
  pinMode(led2, OUTPUT);
  digitalWrite(led2, state2 ? HIGH : LOW);
  pinMode(led3, OUTPUT);
  digitalWrite(led3, state3 ? HIGH : LOW);
}


void loop() 
{
  if (blinker1.update()) {
    state1 = !state1;
    digitalWrite(led1, state1 ? HIGH : LOW);
  }
  if (blinker2.update()) {
    state2 = !state2;
    digitalWrite(led2, state2 ? HIGH : LOW);
  }
  if (blinker3.update()) {
    state3 = !state3;
    digitalWrite(led3, state3 ? HIGH : LOW);
  }
}
