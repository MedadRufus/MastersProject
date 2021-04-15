// Potentiometer is connected to GPIO 34 (Analog ADC1_CH6) 
const int potPin = 36;

// output pin
const int potPin = 36;

// variable for storing the potentiometer value
int potValue = 0;

void setup() {
  Serial.begin(115200);

  
}

void loop() {
  // Reading potentiometer value
  potValue = analogRead(potPin);
  Serial.println(potValue);
  delay(10);
}
