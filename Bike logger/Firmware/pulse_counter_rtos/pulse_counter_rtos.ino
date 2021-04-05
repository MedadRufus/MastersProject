#include "driver/mcpwm.h"



const uint32_t SERIAL_SPEED = 115200; // Use fast serial speed 2 Mbits/s


// the number of the LED pin
const int ledPin = 27;
const int MotorAPin = 35;



// setting PWM properties
const int freq = 5;  // set this
const int downtime_dutyCycle = 83; // set this

const int ledChannel = 0;
const int resolution = 8;
const int dutyCycle = downtime_dutyCycle * 255 / 100;

void setup() {
  Serial.begin(SERIAL_SPEED);
  Serial.println("=======================================================");

  // configure LED PWM functionalitites
  ledcSetup(ledChannel, freq, resolution);

  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin, ledChannel);
  ledcWrite(ledChannel, dutyCycle);


  // Read pwm
  mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM0A, MotorAPin);
  mcpwm_capture_enable(MCPWM_UNIT_0, MCPWM_SELECT_CAP0, MCPWM_NEG_EDGE, 0);
}

void loop() {
  unsigned int number = mcpwm_capture_signal_get_value(MCPWM_UNIT_0, MCPWM_SELECT_CAP0);
  Serial.print("PWM_input_value: ");
  Serial.println(number);
  delay(300);

}
