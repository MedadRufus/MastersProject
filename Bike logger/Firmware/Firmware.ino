#define LED_BUILTIN 33

void blink_led(bool reset = false);
long lastTime = 0; 

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {

  blink_led();
}



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
