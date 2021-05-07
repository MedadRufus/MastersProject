/**
 * @file pulse_counter_adc.ino
 * @author Medad Rufus Newman (mailto@medadnewman.co.uk)
 * @brief 
 * @version 0.1
 * @date 2021-04-19
 * 
 * @copyright Copyright (c) 2021
 * 
 * 
 * Voltage values are all in milliVolt
 * 
 */
#include "Arduino.h"
#include <filters.h>
#include <driver/i2s.h>
#include <ESPNtpClient.h>
#include "../../RTOS_sampling.h"

/*
 * This is an example to read analog data at high frequency using the I2S peripheral
 * Run a wire between pins 27 & 32
 * The readings from the device will be 12bit (0-4096) 
 */

#define I2S_SAMPLE_RATE 2442
#define SPEED_ADC_CHANNEL ADC1_CHANNEL_7 //pin 35 Motor A
#define BRAKE_ADC_CHANNEL ADC1_CHANNEL_3 //pin 39 Throttle

#define LOW_THRESHOLD_SPEED 400   //mV
#define HIGH_THRESHOLD_SPEED 4600 //mV

#define SPEED_LINE_VOLTAGE_MIN 0    //mV
#define SPEED_LINE_VOLTAGE_MAX 5000 //mV
#define SPEED_LINE_ADC_MIN 1876
#define SPEED_LINE_ADC_MAX 4096

#define MAX_INTERVAL_BETWEEN_PULSES 2400000 // microseconds
#define MIN_INTERVAL_BETWEEN_PULSES 10000   // microseconds

#define BRAKE_CHECK_INTERVAL 1 // millisecond

// setting PWM properties for test pwm signal
const int freq = 6;
const int ledChannel = 0;
const int resolution = 10;
const int dutyCycle = 250;

const int ledPin = 33; // 33 corresponds to GPIO33

const int brakePin = 39;

const float cutoff_freq = 1000.0;                       //Cutoff frequency in Hz
const float sampling_time = (float)1 / I2S_SAMPLE_RATE; //Sampling time in seconds.
IIR::ORDER order_brake = IIR::ORDER::OD3;               // Order (OD1 to OD4)

// Low-pass filter
Filter f_b(cutoff_freq, sampling_time, order_brake);

typedef enum
{
  POS = 0,
  NEG,
} edge_t;

typedef enum
{
  LINE_HIGH = 0,
  LINE_LOW,
  UNDEFINED_LINE_STATE
} line_state_t;

typedef struct
{
  uint16_t deadzone_low;
  uint16_t deadzone_high;
  edge_t edge;
  i2s_port_t i2s_num;
  adc_unit_t adc_unit;
  adc1_channel_t adc_channel;
  uint16_t line_voltage_min;
  uint16_t line_voltage_max;
  uint16_t line_adc_min;
  uint16_t line_adc_max;
  uint16_t offset;
  line_state_t previous_line_state;
} Edge_detector_t;

Edge_detector_t brake_edge_detector{
    .deadzone_low = LOW_THRESHOLD_SPEED,
    .deadzone_high = HIGH_THRESHOLD_SPEED,
    .edge = NEG,
    .i2s_num = I2S_NUM_1,
    .adc_unit = ADC_UNIT_1,
    .adc_channel = BRAKE_ADC_CHANNEL,
    .line_voltage_min = SPEED_LINE_VOLTAGE_MIN,
    .line_voltage_max = SPEED_LINE_VOLTAGE_MAX,
    .line_adc_min = SPEED_LINE_ADC_MIN,
    .line_adc_max = SPEED_LINE_ADC_MAX,
    .offset = (int)BRAKE_ADC_CHANNEL * 0x1000 + 0xFFF,

};

/**
 * @brief Function prototypes
 * 
 */
uint16_t adc_to_voltage_b(signed adc_value, signed adc_min, signed adc_max, signed voltage_min, signed voltage_max);
bool is_edge_b(Edge_detector_t *edge_detector_obj, uint16_t current_v);

/**
 * @brief Function definitions
 * 
 */
void gpio_input_pin_init()
{
  // initialize the pushbutton pin as an input
  pinMode(brakePin, INPUT);
}

uint16_t read_gpio_value()
{
  return digitalRead(brakePin);
}

void reader_b(void *pvParameters)
{

  Edge_detector_t edge_detector = *(Edge_detector_t *)pvParameters;

  // Initialize the I2S peripheral
  gpio_input_pin_init();

  unsigned long startTime = micros();

  TickType_t xLastWakeTime;
  const TickType_t xFrequency = BRAKE_CHECK_INTERVAL;

  // Initialise the xLastWakeTime variable with the current time.
  xLastWakeTime = xTaskGetTickCount();
  for (;;)
  {
    // Wait for the next cycle.
    vTaskDelayUntil(&xLastWakeTime, xFrequency);

    uint16_t gpio_value = read_gpio_value();
    float filteredval = f_b.filterIn((float)gpio_value);

    bool is_edge_state = is_edge_b(&edge_detector, filteredval);

    Serial.printf("Filtered value: %f Edge_state:%d\n", filteredval, is_edge_state);

    if (is_edge_state)
    {
      unsigned long current_time = micros();
      unsigned long elapsed_time = current_time - startTime;
      startTime = current_time;

      if (elapsed_time > MIN_INTERVAL_BETWEEN_PULSES)
      {
        Serial.printf("%d\n", elapsed_time);

        char msg_buffer[100];

        sprintf(msg_buffer, "%s,motor_speed,%d\n",
                NTP.getTimeDateStringUs(),
                elapsed_time);

        //save_to_sd(msg_buffer);
      }
    }
  }
}

uint16_t adc_to_voltage_b(signed adc_value, signed adc_min, signed adc_max, signed voltage_min, signed voltage_max)
{
  adc_value = constrain(adc_value, adc_min, adc_max);
  return map(adc_value, adc_value, adc_min, voltage_min, voltage_max);
}

/**
 * @brief Returns true if x is in range [low..high], else false
 * 
 * @param low 
 * @param high 
 * @param x 
 * @return bool
 */
bool in_range_b(signed low, signed high, signed x)
{
  return (low <= x && x <= high);
}

line_state_t voltage_to_linestate_b(Edge_detector_t *edge_detector_obj, signed voltage)
{
  if (voltage == 0)
  {
    return LINE_LOW;
  }
  else if (voltage == 1)
  {
    return LINE_HIGH;
  }

  return UNDEFINED_LINE_STATE;
}

/**
 * @brief Check if an edge occured
 * 
 * @param edge_detector_obj Object containing all the edge params
 * @param current_v in millivolts. Must be free of noise.
 * @return true yes there was an edge
 * @return false no edge here
 */
bool is_edge_b(Edge_detector_t *edge_detector_obj, uint16_t current_v)
{
  /**
   * @brief Reject if voltage is in dead zone.
   */
  // if (in_range_b(edge_detector_obj->deadzone_low, edge_detector_obj->deadzone_high, current_v))
  // {
  //   return false;
  // }

  /**
   * @brief Check current line state and then check if it is different from previous state
   * 
   */
  line_state_t current_line_state = voltage_to_linestate_b(edge_detector_obj, current_v);

  bool res = false;

  switch (edge_detector_obj->edge)
  {
  case NEG:
  {
    if ((edge_detector_obj->previous_line_state == LINE_HIGH) && (current_line_state == LINE_LOW))
    {
      res = true;
    }
    break;
  }
  case POS:
  {
    if ((edge_detector_obj->previous_line_state == LINE_LOW) && (current_line_state == LINE_HIGH))
    {
      res = true;
    }
    break;
  }
  }

  /**
   * @brief Update previous line state with current state.
   * 
   */
  edge_detector_obj->previous_line_state = current_line_state;

  return res;
}

void init_state_logger()
{
  // Create a task that will read the data
  xTaskCreatePinnedToCore(reader_b, "ADC_reader_MOTOR", 2048, &brake_edge_detector, 4, NULL, 0);
}

#if 0
void setup()
{
  Serial.begin(2000000);

  // Put a signal out on pin

  // configure LED PWM functionalitites
  ledcSetup(ledChannel, freq, resolution);

  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin, ledChannel);

  // Generate PWM signal
  ledcWrite(ledChannel, dutyCycle);
}

void loop()
{
}
#endif
