/* MCPWM basic config example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

/*
   This example will show you how to use each submodule of MCPWM unit.
   The example can't be used without modifying the code first.
   Edit the macros at the top of mcpwm_example_basic_config.c to enable/disable the submodules which are used in the example.
*/

#include <stdio.h>
#include "string.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "esp_attr.h"
#include "soc/rtc.h"
#include "driver/mcpwm.h"
#include "soc/mcpwm_reg.h"
#include "soc/mcpwm_struct.h"

const uint32_t SERIAL_SPEED = 115200; // Use fast serial speed 2 Mbits/s


#define MCPWM_EN_CARRIER 0   //Make this 1 to test carrier submodule of mcpwm, set high frequency carrier parameters
#define MCPWM_EN_DEADTIME 0  //Make this 1 to test deadtime submodule of mcpwm, set deadtime value and deadtime mode
#define MCPWM_EN_FAULT 0     //Make this 1 to test fault submodule of mcpwm, set action on MCPWM signal on fault occurence like overcurrent, overvoltage, etc
#define MCPWM_EN_SYNC 0      //Make this 1 to test sync submodule of mcpwm, sync timer signals
#define MCPWM_EN_CAPTURE 1   //Make this 1 to test capture submodule of mcpwm, measure time between rising/falling edge of captured signal
#define MCPWM_GPIO_INIT 0    //select which function to use to initialize gpio signals
#define CAP_SIG_NUM 3   //Three capture signals

#define CAP0_INT_EN BIT(27)  //Capture 0 interrupt bit
#define CAP1_INT_EN BIT(28)  //Capture 1 interrupt bit
#define CAP2_INT_EN BIT(29)  //Capture 2 interrupt bit


#define GPIO_PWM0A_OUT 19   //Set GPIO 19 as PWM0A
#define GPIO_PWM0B_OUT 18   //Set GPIO 18 as PWM0B
#define GPIO_PWM1A_OUT 17   //Set GPIO 17 as PWM1A
#define GPIO_PWM1B_OUT 16   //Set GPIO 16 as PWM1B
#define GPIO_PWM2A_OUT 15   //Set GPIO 15 as PWM2A
#define GPIO_PWM2B_OUT 14   //Set GPIO 14 as PWM2B
#define GPIO_CAP1_IN   18   //Set GPIO 39 as  CAP1
#define GPIO_CAP0_IN   25   //Set GPIO 36 as  CAP0
#define GPIO_CAP2_IN   26   //Set GPIO 26 as  CAP2
#define GPIO_SYNC0_IN   2   //Set GPIO 02 as SYNC0
#define GPIO_SYNC1_IN   4   //Set GPIO 04 as SYNC1
#define GPIO_SYNC2_IN   5   //Set GPIO 05 as SYNC2
#define GPIO_FAULT0_IN 39   //Set GPIO 32 as FAULT0
#define GPIO_FAULT1_IN 34   //Set GPIO 34 as FAULT1
#define GPIO_FAULT2_IN 34   //Set GPIO 34 as FAULT2

typedef struct {
  uint32_t capture_signal;
  mcpwm_capture_signal_t sel_cap_signal;
  uint32_t edge_direction;
} capture;

typedef struct {
  uint32_t high_period;
  uint32_t low_period;
} duty_cycle_params_t;



duty_cycle_params_t dcycle_params[CAP_SIG_NUM];


xQueueHandle cap_queue;
#if MCPWM_EN_CAPTURE
static mcpwm_dev_t *MCPWM[2] = {&MCPWM0, &MCPWM1};
#endif

static void mcpwm_example_gpio_initialize(void)
{
  Serial.print("initializing mcpwm gpio...\n");

  mcpwm_pin_config_t pin_config = {
    .mcpwm_cap0_in_num   = GPIO_CAP0_IN,
    .mcpwm_cap1_in_num   = GPIO_CAP1_IN,
    .mcpwm_cap2_in_num   = GPIO_CAP2_IN
  };
  mcpwm_set_pin(MCPWM_UNIT_0, &pin_config);


  gpio_pullup_en((gpio_num_t)GPIO_CAP0_IN);    //Enable pull down on CAP0   signal
  gpio_pulldown_en((gpio_num_t)GPIO_CAP1_IN);    //Enable pull down on CAP1   signal
  gpio_pullup_en((gpio_num_t)GPIO_CAP2_IN);    //Enable pull down on CAP2   signal
}

/**
   @brief Set gpio 12 as our test signal that generates high-low waveform continuously, connect this gpio to capture pin.
*/
static void gpio_test_signal(void *arg)
{
  Serial.print("intializing test signal...\n");

  // setting PWM properties
  const int freq = 5;  // set this
  const int downtime_dutyCycle = 83; // set this

  const int ledChannel = 0;
  const int resolution = 8; // number of bits
  const int dutyCycle = downtime_dutyCycle * (1 << resolution) / 100;

  init_blink(ledChannel, freq, 27, dutyCycle, resolution);
  init_blink(ledChannel, freq, 19, dutyCycle, resolution);

  vTaskDelete(NULL);

}

void init_blink(int ledChannel, int freq, int ledPin, int dutyCycle, int resolution)
{
  // configure LED PWM functionalitites
  ledcSetup(ledChannel, freq, resolution);

  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin, ledChannel);

  ledcWrite(ledChannel, dutyCycle);


}

/**
   @brief When interrupt occurs, we receive the counter value and display the time between two rising edge
*/
static void disp_captured_signal(void *arg)
{
  uint32_t *current_cap_value = (uint32_t *)malloc(CAP_SIG_NUM * sizeof(uint32_t));
  uint32_t *previous_cap_value = (uint32_t *)malloc(CAP_SIG_NUM * sizeof(uint32_t));
  uint32_t *edge_direction_value = (uint32_t *)malloc(CAP_SIG_NUM * sizeof(uint32_t));
  capture evt;
  while (1) {
    xQueueReceive(cap_queue, &evt, portMAX_DELAY);
    if (evt.sel_cap_signal == MCPWM_SELECT_CAP0) {
      log_signal(MCPWM_SELECT_CAP0, evt, current_cap_value, previous_cap_value, edge_direction_value);
    }
    if (evt.sel_cap_signal == MCPWM_SELECT_CAP1) {
      log_signal(MCPWM_SELECT_CAP1, evt, current_cap_value, previous_cap_value, edge_direction_value);
    }
    if (evt.sel_cap_signal == MCPWM_SELECT_CAP2) {
      log_signal(MCPWM_SELECT_CAP2, evt, current_cap_value, previous_cap_value, edge_direction_value);
    }
  }
}

static void log_signal(int index, capture evt, uint32_t *current_cap_value, uint32_t *previous_cap_value, uint32_t *edge_direction_value)
{
  current_cap_value[index] = evt.capture_signal - previous_cap_value[index];
  previous_cap_value[index] = evt.capture_signal;
  current_cap_value[index] = (current_cap_value[index] / 10000) * (10000000000 / rtc_clk_apb_freq_get());
  edge_direction_value[index] = evt.edge_direction;

  switch (evt.edge_direction)
  {
    case 1:
      dcycle_params[index].low_period = current_cap_value[index];
      break;
    case 2:
      dcycle_params[index].high_period = current_cap_value[index];
      break;
  }

  float d_cycle = duty_cycle(dcycle_params[index].low_period, dcycle_params[index].high_period);

  Serial.printf("CAP%d : %d us DIRECTION : %d Duty_cycle: %f\n", index, current_cap_value[index], edge_direction_value[index], d_cycle);
}

static float duty_cycle(int low, int high)
{
  return (float)high / (float)(low + high);
}

#if MCPWM_EN_CAPTURE
/**
   @brief this is ISR handler function, here we check for interrupt that triggers rising edge on CAP0 signal and according take action
*/
static void IRAM_ATTR isr_handler(void*)
{
  uint32_t mcpwm_intr_status;
  capture evt;
  mcpwm_intr_status = MCPWM[MCPWM_UNIT_0]->int_st.val; //Read interrupt status
  if (mcpwm_intr_status & CAP0_INT_EN) { //Check for interrupt on rising edge on CAP0 signal
    evt.capture_signal = mcpwm_capture_signal_get_value(MCPWM_UNIT_0, MCPWM_SELECT_CAP0); //get capture signal counter value
    evt.sel_cap_signal = MCPWM_SELECT_CAP0;
    evt.edge_direction = mcpwm_capture_signal_get_edge(MCPWM_UNIT_0, MCPWM_SELECT_CAP0);
    xQueueSendFromISR(cap_queue, &evt, NULL);
  }
  if (mcpwm_intr_status & CAP1_INT_EN) { //Check for interrupt on rising edge on CAP0 signal
    evt.capture_signal = mcpwm_capture_signal_get_value(MCPWM_UNIT_0, MCPWM_SELECT_CAP1); //get capture signal counter value
    evt.sel_cap_signal = MCPWM_SELECT_CAP1;
    evt.edge_direction = mcpwm_capture_signal_get_edge(MCPWM_UNIT_0, MCPWM_SELECT_CAP1);
    xQueueSendFromISR(cap_queue, &evt, NULL);
  }
  if (mcpwm_intr_status & CAP2_INT_EN) { //Check for interrupt on rising edge on CAP0 signal
    evt.capture_signal = mcpwm_capture_signal_get_value(MCPWM_UNIT_0, MCPWM_SELECT_CAP2); //get capture signal counter value
    evt.sel_cap_signal = MCPWM_SELECT_CAP2;
    evt.edge_direction = mcpwm_capture_signal_get_edge(MCPWM_UNIT_0, MCPWM_SELECT_CAP2);
    xQueueSendFromISR(cap_queue, &evt, NULL);
  }
  MCPWM[MCPWM_UNIT_0]->int_clr.val = mcpwm_intr_status;
}
#endif

/**
   @brief Configure whole MCPWM module
*/
static void mcpwm_example_config(void *arg)
{
  //1. mcpwm gpio initialization
  mcpwm_example_gpio_initialize();

  //2. initialize mcpwm configuration
  Serial.print("Configuring Initial Parameters of mcpwm...\n");


#if MCPWM_EN_CAPTURE
  //7. Capture configuration
  //comment if you don't want to use capture submodule, also u can comment the capture gpio signals
  //configure CAP0, CAP1 and CAP2 signal to start capture counter on rising edge
  //we generate a gpio_test_signal of 20ms on GPIO 19 and connect it to one of the capture signal, the disp_captured_function displays the time between rising edge
  //In general practice you can connect Capture  to external signal, measure time between rising edge or falling edge and take action accordingly
  mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP0, MCPWM_BOTH_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second
  mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP1, MCPWM_BOTH_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second
  mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP2, MCPWM_BOTH_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second

  //enable interrupt, so each this a rising edge occurs interrupt is triggered
  MCPWM[MCPWM_UNIT_0]->int_ena.val = CAP0_INT_EN | CAP1_INT_EN | CAP2_INT_EN;  //Enable interrupt on  CAP0, CAP1 and CAP2 signal
  mcpwm_isr_register(MCPWM_UNIT_0, isr_handler, NULL, ESP_INTR_FLAG_IRAM, NULL);  //Set ISR Handler
#endif
  vTaskDelete(NULL);
}

void setup(void)
{
  Serial.begin(SERIAL_SPEED);
  Serial.print("Testing MCPWM...\n");
  cap_queue = xQueueCreate(1, sizeof(capture)); //comment if you don't want to use capture module
  xTaskCreate(disp_captured_signal, "mcpwm_config", 4096, NULL, 5, NULL);  // view duty cycle values
  xTaskCreate(gpio_test_signal, "gpio_test_signal", 4096, NULL, 5, NULL); //comment if you don't want to generate test signal on pin 19
  xTaskCreate(mcpwm_example_config, "mcpwm_example_config", 4096, NULL, 5, NULL);
}


void loop()
{

}
