#include <filters.h>
#include <ESPNtpClient.h>
#include <driver/i2s.h>

#define target_pin 33

#ifndef WIFI_CONFIG_H
#define YOUR_WIFI_SSID "YOUR_WIFI_SSID"
#define YOUR_WIFI_PASSWD "YOUR_WIFI_PASSWD"
#endif // !WIFI_CONFIG_H

/*
 * This is an example to read analog data at high frequency using the I2S peripheral
 * Run a wire between pins 27 & 32
 * The readings from the device will be 12bit (0-4096) 
 */

#define I2S_SAMPLE_RATE 2442
#define ADC_INPUT ADC1_CHANNEL_4 //pin 32
#define OUTPUT_VALUE 3800
#define READ_DELAY 9000 //microseconds

uint16_t adc_reading;

// setting PWM properties
const int freq = 6;
const int ledChannel = 0;
const int resolution = 10;
const int dutyCycle = 250;

const int ledPin = 33; // 33 corresponds to GPIO33

const float cutoff_freq = 10000.0;   //Cutoff frequency in Hz
const float sampling_time = 1/2442;  //Sampling time in seconds.
IIR::ORDER order = IIR::ORDER::OD4; // Order (OD1 to OD4)

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
  LINE_LOW

} line_state_t;

int low_threshold = 400;   //mV
int high_threshold = 3500; //mV

float previous_v = 0;

void i2sInit()
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
  i2s_driver_install(I2S_NUM_0, &i2s_config, 0, NULL);
  i2s_set_adc_mode(ADC_UNIT_1, ADC_INPUT);
  i2s_adc_enable(I2S_NUM_0);
}

void reader(void *pvParameters)
{
  uint32_t read_counter = 0;
  uint64_t read_sum = 0;
  // The 4 high bits are the channel, and the data is inverted
  uint16_t offset = (int)ADC_INPUT * 0x1000 + 0xFFF;
  size_t bytes_read;
  while (1)
  {
    uint16_t buffer[1] = {0};
    i2s_read(I2S_NUM_0, &buffer, sizeof(buffer), &bytes_read, 15);

    uint16_t adc_value = offset - buffer[0];

    float filteredval = f.filterIn((float)adc_value);

    Serial.printf("%d, %f\n", adc_value, filteredval);

    bool is_edge_state = is_edge(NEG, previous_v, filteredval);
    previous_v = filteredval;

    if (is_edge_state)
    {
      Serial.printf("edge detected at %s", NTP.getTimeDateStringUs());
    }
  }
}

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

void setup()
{
  Serial.begin(115200);

  // ntp for timestamp
  init_ntp();

  // Put a signal out on pin

  // configure LED PWM functionalitites
  ledcSetup(ledChannel, freq, resolution);

  // attach the channel to the GPIO to be controlled
  ledcAttachPin(ledPin, ledChannel);

  // Generate PWM signal
  ledcWrite(ledChannel, dutyCycle);

  // Initialize the I2S peripheral
  i2sInit();
  // Create a task that will read the data
  xTaskCreatePinnedToCore(reader, "ADC_reader", 2048, NULL, 1, NULL, 1);
}

void loop()
{
}