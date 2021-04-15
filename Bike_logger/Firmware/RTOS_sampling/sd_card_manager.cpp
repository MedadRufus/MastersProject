/*
   Connect the SD card to the following pins:

   SD Card | ESP32
      D2       -
      D3       SS
      CMD      MOSI
      VSS      GND
      VDD      3.3V
      CLK      SCK
      VSS      GND
      D0       MISO
      D1       -
*/
#include "sd_card_manager.h"
#include "SPI.h"

SPIClass spiSD(HSPI);

// Chip select for SD card
#define SD_CS 15
#define SDSPEED 80000000

SD_Manager::SD_Manager(void)
{

}

void SD_Manager::SD_Manager_init()
{
  spiSD.begin(14, 12, 13, 15); //SCK,MISO,MOSI,SS //HSPI1
  
  Serial.println("SD card Tests");

  if (!SD.begin( SD_CS, spiSD, SDSPEED)) {
    Serial.println("Card Mount Failed");
    return;
  }
  uint8_t cardType = SD.cardType();

  if (cardType == CARD_NONE) {
    Serial.println("No SD card attached");
    return;
  }

  Serial.print("SD Card Type: ");
  if (cardType == CARD_MMC) {
    Serial.println("MMC");
  } else if (cardType == CARD_SD) {
    Serial.println("SDSC");
  } else if (cardType == CARD_SDHC) {
    Serial.println("SDHC");
  } else {
    Serial.println("UNKNOWN");
  }

  uint64_t cardSize = SD.cardSize() / (1024 * 1024);
  Serial.printf("SD Card Size: %lluMB\n", cardSize);


}

void SD_Manager::appendFile(File *file, const char * message) {

  if (!file) {
    Serial.println("Failed to open file for appending");
    return;
  }
  if (file->print(message)) {
    //Serial.println("Message appended");
  } else {
    Serial.println("Append failed");
  }
}
