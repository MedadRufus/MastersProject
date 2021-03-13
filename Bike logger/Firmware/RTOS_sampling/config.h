#ifdef __cplusplus
extern "C"
{
#endif

#ifndef Config_h
#define Config_h


/* ==================================================================== */
/* ========================== include files =========================== */
/* ==================================================================== */

/* Inclusion of system and local header files goes here */



/* ==================================================================== */
/* ============================ constants ============================= */
/* ==================================================================== */

/* #define and enum statements go here */

#define LED_BUILTIN 27
#define RXD2 17
#define TXD2 16

#define INA_226_I2C_ADDRESS 0x41

/* Config section */

/*
  Set to true or false to poll/not poll
*/
#define POLL_BARO (false)
#define POLL_GPS (false)
#define POLL_IMU (false)
#define POLL_INA226 (true)
#define POLL_BRAKE (false)
#define POLL_SPEED (false)

#define HEAP_ANALYSIS (false)
#define PERIODIC_CLOSE_FILE (true)
#define INTERVAL_BETWEEN_FLUSHING_FILE 10000UL

/* poll intervals in milliseconds */
#define INA226_SAMPLE_INTERVAL 10
#define GNSS_SAMPLE_INTERVAL 100
#define BARO_SAMPLE_INTERVAL 250
#define IMU_SAMPLE_INTERVAL 500
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

/* Number of GPS fixes in a second */
#define FIXS_PER_SECOND 4

/* INA226 info */
#define FULL_RANGE_VOLTAGE_DROP (float) 0.08192 // Volts
#define SHUNT_RESISTANCE (float)0.0024 // Ohms

/* I = V/R */
#define INA226_FULL_CURRENT_RANGE (float)(FULL_RANGE_VOLTAGE_DROP/SHUNT_RESISTANCE) // Amps

/* ==================================================================== */
/* ========================== public data ============================= */
/* ==================================================================== */

/* Definition of public (external) data types go here */





/* ==================================================================== */
/* ======================= public functions =========================== */
/* ==================================================================== */

/* Function prototypes for public (external) functions go here */


#endif
#ifdef __cplusplus
}
#endif
