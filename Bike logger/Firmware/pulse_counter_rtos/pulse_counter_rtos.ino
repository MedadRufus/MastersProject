



// the number of the LED pin
const int ledPin = 27;



// setting PWM properties
const int freq = 5;  // set this
const int downtime_dutyCycle = 83; // set this

const int ledChannel = 0;
const int resolution = 8;
const int dutyCycle = downtime_dutyCycle * 255 / 100;

void setup() {
  // configure LED PWM functionalitites
  ledcSetup(ledChannel, freq, resolution);

  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin, ledChannel);

  ledcWrite(ledChannel, dutyCycle);
}

void loop() {
  // increase the LED brightness

}
