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
#define ADC_INPUT ADC1_CHANNEL_7 //pin 35 Motor A

#define low_threshold_speed 400   //mV
#define high_threshold_speed 4600 //mV

#define SPEED_LINE_VOLTAGE_MIN 0    //mV
#define SPEED_LINE_VOLTAGE_MAX 5000 //mV
#define SPEED_LINE_ADC_MIN 1876
#define SPEED_LINE_ADC_MAX 4096

#define MAX_INTERVAL_BETWEEN_PULSES 2400000 // microseconds

// setting PWM properties for test pwm signal
const int freq = 6;
const int ledChannel = 0;
const int resolution = 10;
const int dutyCycle = 250;

const int ledPin = 33; // 33 corresponds to GPIO33

uint16_t offset = (int)ADC_INPUT * 0x1000 + 0xFFF;
size_t bytes_read;

const float cutoff_freq = 1000.0;                       //Cutoff frequency in Hz
const float sampling_time = (float)1 / I2S_SAMPLE_RATE; //Sampling time in seconds.
IIR::ORDER order = IIR::ORDER::OD3;                     // Order (OD1 to OD4)

// Low-pass filter
Filter f(cutoff_freq, sampling_time, order);

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
  line_state_t previous_line_state;
} Edge_detector_t;

Edge_detector_t speed_edge_detector{
    .deadzone_low = low_threshold_speed,
    .deadzone_high = high_threshold_speed,
    .edge = NEG,
    .i2s_num = I2S_NUM_0,
    .adc_unit = ADC_UNIT_1,
    .adc_channel = ADC_INPUT,
    .line_voltage_min = SPEED_LINE_VOLTAGE_MIN,
    .line_voltage_max = SPEED_LINE_VOLTAGE_MAX,
    .line_adc_min = SPEED_LINE_ADC_MIN,
    .line_adc_max = SPEED_LINE_ADC_MAX,
};

/**
 * @brief Function prototypes
 * 
 */
uint16_t adc_to_voltage(signed adc_value, signed adc_min, signed adc_max, signed voltage_min, signed voltage_max);
bool is_edge(Edge_detector_t *edge_detector_obj, uint16_t current_v);

/**
 * @brief Function definitions
 * 
 */
void i2sInit(i2s_port_t i2s_num, adc_unit_t adc_unit, adc1_channel_t adc_channel)
{
  i2s_config_t i2s_config = {
      .mode = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_RX | I2S_MODE_ADC_BUILT_IN),
      .sample_rate = I2S_SAMPLE_RATE,               // The format of the signal using ADC_BUILT_IN
      .bits_per_sample = I2S_BITS_PER_SAMPLE_16BIT, // is fixed at 12bit, stereo, MSB
      .channel_format = I2S_CHANNEL_FMT_RIGHT_LEFT,
      .communication_format = I2S_COMM_FORMAT_I2S_MSB,
      .intr_alloc_flags = ESP_INTR_FLAG_LEVEL1,
      .dma_buf_count = 4,
      .dma_buf_len = 8,
      .use_apll = false,
      .tx_desc_auto_clear = false,
      .fixed_mclk = 0};
  i2s_driver_install(i2s_num, &i2s_config, 0, NULL);
  i2s_set_adc_mode(adc_unit, adc_channel);
  i2s_adc_enable(i2s_num);
}

uint16_t read_adc_value_from_buffer(i2s_port_t i2s_num)
{
  uint16_t buffer[1] = {0};
  i2s_read(i2s_num, &buffer, sizeof(buffer), &bytes_read, 15);
  uint16_t adc_value = offset - buffer[0];
  return adc_value;
}

void reader(void *pvParameters)
{

  Edge_detector_t edge_detector = *(Edge_detector_t *)pvParameters;

  // Initialize the I2S peripheral
  i2sInit(edge_detector.i2s_num, edge_detector.adc_unit, edge_detector.adc_channel);

  unsigned long startTime = micros();

  while (1)
  {
    uint16_t adc_value = read_adc_value_from_buffer(edge_detector.i2s_num);
    float filteredval = f.filterIn((float)adc_value);

    uint16_t filtered_adc_voltage = adc_to_voltage(filteredval, edge_detector.line_adc_min, edge_detector.line_adc_max, edge_detector.line_voltage_min, edge_detector.line_voltage_max);

    //Serial.printf("%d, %f\n", adc_value, filteredval);

    bool is_edge_state = is_edge(&speed_edge_detector, filtered_adc_voltage);

    if (is_edge_state)
    {
      unsigned long current_time = micros();
      unsigned long elapsed_time = current_time - startTime;
      startTime = current_time;

      if (elapsed_time < MAX_INTERVAL_BETWEEN_PULSES)
      {
        Serial.printf("%d\n", elapsed_time);

        char msg_buffer[100];

        sprintf(msg_buffer, "%s,motor_speed,%d\n",
                NTP.getTimeDateStringUs(),
                elapsed_time);

        save_to_sd(msg_buffer);
      }
    }
  }
}

uint16_t adc_to_voltage(signed adc_value, signed adc_min, signed adc_max, signed voltage_min, signed voltage_max)
{
  /**
   * @brief  TODO: check the resolution of the ADC
   * TODO: use defined numbers
   * 
   */

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
bool in_range(signed low, signed high, signed x)
{
  return (low <= x && x <= high);
}

line_state_t voltage_to_linestate(Edge_detector_t *edge_detector_obj, signed voltage)
{
  if (voltage < edge_detector_obj->deadzone_low)
  {
    return LINE_LOW;
  }
  else if (voltage > edge_detector_obj->deadzone_high)
  {
    return LINE_HIGH;
  }

  return UNDEFINED_LINE_STATE;
}

void init_edge_detector(Edge_detector_t *edge_detector_obj, uint16_t deadzone_low_voltage, uint16_t deadzone_high_voltage, edge_t edge)
{
  edge_detector_obj->deadzone_high = deadzone_high_voltage;
  edge_detector_obj->deadzone_low = deadzone_low_voltage;
  edge_detector_obj->edge = edge;
}

/**
 * @brief Check if an edge occured
 * 
 * @param edge_detector_obj Object containing all the edge params
 * @param current_v in millivolts. Must be free of noise.
 * @return true yes there was an edge
 * @return false no edge here
 */
bool is_edge(Edge_detector_t *edge_detector_obj, uint16_t current_v)
{
  /**
   * @brief Reject if voltage is in dead zone.
   */
  if (in_range(edge_detector_obj->deadzone_low, edge_detector_obj->deadzone_high, current_v))
  {
    return false;
  }

  /**
   * @brief Check current line state and then check if it is different from previous state
   * 
   */
  line_state_t current_line_state = voltage_to_linestate(edge_detector_obj, current_v);

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

void init_adc_edge_detect()
{
  // Create a task that will read the data
  xTaskCreatePinnedToCore(reader, "ADC_reader_MOTOR", 2048, &speed_edge_detector, 4, NULL, 0);
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
