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

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {

  blink_led();
}


/* ==================================================================== */
/* ============================ functions ============================= */
/* ==================================================================== */


void blink_led(bool reset)
{
  const uint32_t LED_DELAY = 1000;
  static enum { LED_TOGGLE, WAIT_DELAY } state = LED_TOGGLE;
  static uint32_t timeLastTransition = 0;

  if (reset)
  {
    state = LED_TOGGLE;
    digitalWrite(LED_BUILTIN, LOW);
  }

  switch (state)
  {
    case LED_TOGGLE:   // toggle the LED
      digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
      timeLastTransition = millis();
      state = WAIT_DELAY;
      break;

    case WAIT_DELAY:   // wait for the delay period
      if (millis() - timeLastTransition >= LED_DELAY)
      {
        state = LED_TOGGLE;
      }
      break;

    default:
      state = LED_TOGGLE;
      break;
  }
}
