/*
 * This is an example to read analog data at high frequency using the I2S peripheral
 * Run a wire between pins 27 & 32
 * The readings from the device will be 12bit (0-4096) 
 */
#include <driver/i2s.h>

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

const int ledPin = 33;  // 33 corresponds to GPIO33
  

void i2sInit()
{
   i2s_config_t i2s_config = {
    .mode = (i2s_mode_t)(I2S_MODE_MASTER | I2S_MODE_RX | I2S_MODE_ADC_BUILT_IN),
    .sample_rate =  I2S_SAMPLE_RATE,              // The format of the signal using ADC_BUILT_IN
    .bits_per_sample = I2S_BITS_PER_SAMPLE_16BIT, // is fixed at 12bit, stereo, MSB
    .channel_format = I2S_CHANNEL_FMT_RIGHT_LEFT,
    .communication_format = I2S_COMM_FORMAT_I2S_MSB,
    .intr_alloc_flags = ESP_INTR_FLAG_LEVEL1,
    .dma_buf_count = 4,
    .dma_buf_len = 8,
    .use_apll = false,
    .tx_desc_auto_clear = false,
    .fixed_mclk = 0
   };
   i2s_driver_install(I2S_NUM_0, &i2s_config, 0, NULL);
   i2s_set_adc_mode(ADC_UNIT_1, ADC_INPUT);
   i2s_adc_enable(I2S_NUM_0);
}

void reader(void *pvParameters) {
  uint32_t read_counter = 0;
  uint64_t read_sum = 0;
// The 4 high bits are the channel, and the data is inverted
  uint16_t offset = (int)ADC_INPUT * 0x1000 + 0xFFF;
  size_t bytes_read;
  while(1){
    uint16_t buffer[1] = {0};
    i2s_read(I2S_NUM_0, &buffer, sizeof(buffer), &bytes_read, 15);
    Serial.printf("%d\n", offset - buffer[0]);

    #if 0
    if (bytes_read == sizeof(buffer)) {
      read_sum += offset - buffer[0];
      read_sum += offset - buffer[1];
      read_counter++;
    } else {
      Serial.println("buffer empty");
    }

    if (read_counter == I2S_SAMPLE_RATE) {
      adc_reading = read_sum / I2S_SAMPLE_RATE / 2;
      Serial.printf("avg: %d millis: ", adc_reading);
      Serial.println(millis());
      read_counter = 0;
      read_sum = 0;
      i2s_adc_disable(I2S_NUM_0);
      delay(READ_DELAY);
      i2s_adc_enable(I2S_NUM_0);
    }
    #endif
  }
}

void setup() {
  Serial.begin(115200);
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

void loop() {
  delay(1020);
  Serial.printf("ADC reading: %d\n", adc_reading);
  delay(READ_DELAY);
}
