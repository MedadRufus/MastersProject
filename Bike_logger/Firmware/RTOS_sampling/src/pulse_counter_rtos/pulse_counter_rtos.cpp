/* MCPWM basic config example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

/*
 * This example will show you how to use each submodule of MCPWM unit.
 * The example can't be used without modifying the code first.
 * Edit the macros at the top of mcpwm_example_basic_config.c to enable/disable the submodules which are used in the example.
 * 
 * Connect pin 21 to pin 22 to see test signal
 * Connect 5V pwm pulse to pin 39 to also see test signal
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


#define CAP_SIG_NUM 3   //Three capture signals

#define CAP0_INT_EN BIT(27)  //Capture 0 interrupt bit
#define CAP1_INT_EN BIT(28)  //Capture 1 interrupt bit
#define CAP2_INT_EN BIT(29)  //Capture 2 interrupt bit

#define GPIO_CAP0_IN   39   //Set GPIO 39 as  CAP0
#define GPIO_CAP1_IN   25   //Set GPIO 25 as  CAP1
#define GPIO_CAP2_IN   22   //Set GPIO 22 as  CAP2

#define LED_BUILTIN 27
#define TEST_TOGGLE_PIN_1 16
#define TEST_TOGGLE_PIN_2 21


typedef struct {
  uint32_t capture_signal;
  mcpwm_capture_signal_t sel_cap_signal;
  uint32_t edge_direction;
} capture;




xQueueHandle cap_queue;
static mcpwm_dev_t *MCPWM[2] = {&MCPWM0, &MCPWM1};

static void mcpwm_example_gpio_initialize(void)
{
    Serial.printf("initializing mcpwm gpio...\n");

    mcpwm_pin_config_t pin_config = {
        .mcpwm0a_out_num = -1,
        .mcpwm0b_out_num = -1,
        .mcpwm1a_out_num = -1,
        .mcpwm1b_out_num = -1,
        .mcpwm2a_out_num = -1,
        .mcpwm2b_out_num = -1,
        .mcpwm_sync0_in_num  = -1,
        .mcpwm_sync1_in_num  = -1,
        .mcpwm_sync2_in_num  = -1,
        .mcpwm_fault0_in_num = -1,
        .mcpwm_fault1_in_num = -1,
        .mcpwm_fault2_in_num = -1,
        .mcpwm_cap0_in_num   = GPIO_CAP0_IN,
        .mcpwm_cap1_in_num   = GPIO_CAP1_IN,
        .mcpwm_cap2_in_num   = GPIO_CAP2_IN
    };
    mcpwm_set_pin(MCPWM_UNIT_0, &pin_config);


    gpio_pullup_en((gpio_num_t)GPIO_CAP0_IN);    //Enable pull down on CAP0   signal
    gpio_pullup_en((gpio_num_t)GPIO_CAP1_IN);    //Enable pull down on CAP1   signal
    gpio_pullup_en((gpio_num_t)GPIO_CAP2_IN);    //Enable pull down on CAP2   signal
}

/**
 * @brief Set gpio 21 as our test signal that generates high-low waveform continuously, connect this gpio to capture pin.
 */
static void gpio_test_signal(void *arg)
{
    Serial.printf("intializing test signal...\n");
    gpio_config_t gp;
    gp.intr_type = GPIO_INTR_DISABLE;
    gp.mode = GPIO_MODE_OUTPUT;
    gp.pin_bit_mask = GPIO_SEL_21;
    gpio_config(&gp);
    while (1) {
        //here the period of test signal is 20ms
        gpio_set_level(GPIO_NUM_21, 1); //Set high
        vTaskDelay(pdMS_TO_TICKS(30));          //delay of 500ms
        gpio_set_level(GPIO_NUM_21, 0); //Set low
        vTaskDelay(pdMS_TO_TICKS(160));         //delay of 500ms
    }
}



static void log_signal(int index, capture evt, uint32_t *current_cap_value, uint32_t *previous_cap_value, uint32_t *edge_direction_value)
{
  current_cap_value[index] = evt.capture_signal - previous_cap_value[index];
  previous_cap_value[index] = evt.capture_signal;
  current_cap_value[index] = (current_cap_value[index] / 10000) * (10000000000 / rtc_clk_apb_freq_get());
  edge_direction_value[index] = evt.edge_direction;

  Serial.printf("CAP%d, Period %d us, DIRECTION : %d\n", index, current_cap_value[index], edge_direction_value[index]);

}

/**
 * @brief When interrupt occurs, we receive the counter value and display the time between two rising edge
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


static void set_queue(uint32_t mcpwm_intr_status, mcpwm_capture_signal_t channel, capture evt)
{
  evt.capture_signal = mcpwm_capture_signal_get_value(MCPWM_UNIT_0, channel); //get capture signal counter value
  evt.sel_cap_signal = channel;
  evt.edge_direction = mcpwm_capture_signal_get_edge(MCPWM_UNIT_0, channel);
  xQueueSendFromISR(cap_queue, &evt, NULL);
}


/**
 * @brief this is ISR handler function, here we check for interrupt that triggers rising edge on CAP0 signal and according take action
 */
static void IRAM_ATTR isr_handler(void*)
{
  uint32_t mcpwm_intr_status;
  capture evt;
  mcpwm_intr_status = MCPWM[MCPWM_UNIT_0]->int_st.val; //Read interrupt status

  if (mcpwm_intr_status & CAP0_INT_EN) //Check for interrupt on edge of CAP0 signal
  { 
    set_queue(mcpwm_intr_status, MCPWM_SELECT_CAP0, evt);
  }

  if (mcpwm_intr_status & CAP1_INT_EN)
  {
    set_queue(mcpwm_intr_status, MCPWM_SELECT_CAP1, evt);
  }

  if (mcpwm_intr_status & CAP2_INT_EN)
  {
    set_queue(mcpwm_intr_status, MCPWM_SELECT_CAP2, evt);
  }


  MCPWM[MCPWM_UNIT_0]->int_clr.val = mcpwm_intr_status; // clear interrupt status

}

/**
 * @brief Configure whole MCPWM module
 */
static void mcpwm_example_config(void *arg)
{
    //1. mcpwm gpio initialization
    mcpwm_example_gpio_initialize();

     //7. Capture configuration
    //comment if you don't want to use capture submodule, also u can comment the capture gpio signals
    //configure CAP0, CAP1 and CAP2 signal to start capture counter on rising edge
    //we generate a gpio_test_signal of 20ms on GPIO 12 and connect it to one of the capture signal, the disp_captured_function displays the time between rising edge
    //In general practice you can connect Capture  to external signal, measure time between rising edge or falling edge and take action accordingly
    mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP0, MCPWM_POS_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second
    mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP1, MCPWM_POS_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second
    mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP2, MCPWM_POS_EDGE, 0);  //capture signal on rising edge, prescale = 0 i.e. 800,000,000 counts is equal to one second

    //enable interrupt, so each this a rising edge occurs interrupt is triggered
    MCPWM[MCPWM_UNIT_0]->int_ena.val = CAP0_INT_EN | CAP1_INT_EN | CAP2_INT_EN;  //Enable interrupt on  CAP0, CAP1 and CAP2 signal
    mcpwm_isr_register(MCPWM_UNIT_0, isr_handler, NULL, ESP_INTR_FLAG_IRAM, NULL);  //Set ISR Handler


    vTaskDelete(NULL);
}

void setup_pulse_counter(void)
{
    Serial.printf("Testing MCPWM...\n");
    cap_queue = xQueueCreate(1, sizeof(capture)); //comment if you don't want to use capture module
    xTaskCreate(disp_captured_signal, "mcpwm_config", 4096, NULL, 5, NULL);  //comment if you don't want to use capture module
    xTaskCreate(gpio_test_signal, "gpio_test_signal", 4096, NULL, 5, NULL); //comment if you don't want to use capture module
    xTaskCreate(mcpwm_example_config, "mcpwm_example_config", 4096, NULL, 5, NULL);
}

