#include <filters.h>
#include <ESPNtpClient.h>

#define target_pin 33


#ifndef WIFI_CONFIG_H
#define YOUR_WIFI_SSID "YOUR_WIFI_SSID"
#define YOUR_WIFI_PASSWD "YOUR_WIFI_PASSWD"
#endif // !WIFI_CONFIG_H

const float cutoff_freq = 1000.0;   //Cutoff frequency in Hz
const float sampling_time = 0.005;  //Sampling time in seconds.
IIR::ORDER order = IIR::ORDER::OD4; // Order (OD1 to OD4)

// Low-pass filter
Filter f(cutoff_freq, sampling_time, order);

typedef enum
{
  POS = 0,
  NEG,
} edge_t;

int low_threshold = 400;   //mV
int high_threshold = 3500; //mV


float previous_v = 0;

/**
 * @brief Init ntp
 * 
 */
void init_ntp()
{
  WiFi.begin(YOUR_WIFI_SSID, YOUR_WIFI_PASSWD);
  NTP.setTimeZone(TZ_Etc_UTC);
  NTP.begin();
}

/**
 * @brief Returns true if x is in range [low..high], else false
 * 
 * @param low 
 * @param high 
 * @param x 
 * @return bool
 */
bool inRange(signed low, signed high, signed x)
{
  return (low <= x && x <= high);
}

/**
 * @brief 
 * 
 * @param direction 
 * @param previous_v 
 * @param current_v 
 * @return true 
 * @return false 
 */
bool is_edge(edge_t direction, float previous_v, float current_v)
{
  if (inRange(low_threshold, high_threshold, current_v))
  {
    return false;
  }

  switch (direction)
  {
  case POS:
  {
    if ((previous_v < low_threshold) && (current_v > high_threshold))
    {
      return true;
    }
    break;
  }

  case NEG:
  {
    if ((previous_v > high_threshold) && (current_v < low_threshold))
    {
      return true;
    }
    break;
  }
  }

  return false;
}

void read_task(void *pvParameters)
{

  while (1)
  {
    int value = analogRead(target_pin);
    float filteredval = f.filterIn(value);
    
    bool edge_state = is_edge(NEG,previous_v,filteredval);
    previous_v = filteredval;

    if (edge_state)
    {
      Serial.printf("edge detected at %s",NTP.getTimeDateStringUs());
    }


    //View with Serial Plotter
    Serial.print(value, DEC);
    Serial.print(",");
    Serial.println(filteredval, 4);

    delay(5); // Loop time will approx. match the sampling time.
  }
}

void setup()
{
  Serial.begin(115200);
  init_ntp();

  xTaskCreatePinnedToCore(read_task, "ADC_reader", 2048, NULL, 1, NULL, 1);
}

void loop()
{
}