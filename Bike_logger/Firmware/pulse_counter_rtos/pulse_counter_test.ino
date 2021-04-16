#include "pulse_counter_rtos.hpp"
#include "stdint.h"

const uint32_t SERIAL_SPEED = 115200; // Use fast serial speed 2 Mbits/s


void setup(void)
{
  Serial.begin(SERIAL_SPEED);
  setup_pulse_counter();
}


void loop()
{
  
}