EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "Design of E bike datalogger"
Date "2021-01-21"
Rev ""
Comp ""
Comment1 "Ref: https://randomnerdtutorials.com/esp32-adc-analog-read-arduino-ide/"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Sensor_Motion:LSM9DS1 U2
U 1 1 6009312A
P 11700 2250
F 0 "U2" H 11700 1150 50  0000 C CNN
F 1 "LSM9DS1" H 11700 1050 50  0000 C CNN
F 2 "Package_LGA:LGA-24L_3x3.5mm_P0.43mm" H 13200 3000 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/1e/3f/2a/d6/25/eb/48/46/DM00103319.pdf/files/DM00103319.pdf/jcr:content/translations/en.DM00103319.pdf" H 11700 2350 50  0001 C CNN
	1    11700 2250
	1    0    0    -1  
$EndComp
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 60094C13
P 5200 5750
F 0 "U1" H 5200 7450 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 5200 7550 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 5200 4250 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 4900 5800 50  0001 C CNN
	1    5200 5750
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Pressure:MS5607-02BA U3
U 1 1 600959C0
P 14400 2100
F 0 "U3" H 14730 2146 50  0000 L CNN
F 1 "MS5607-02BA" H 14730 2055 50  0000 L CNN
F 2 "Package_LGA:LGA-8_3x5mm_P1.25mm" H 14400 2100 50  0001 C CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5607-02BA03%7FB2%7Fpdf%7FEnglish%7FENG_DS_MS5607-02BA03_B2.pdf%7FCAT-BLPS0035" H 14400 2100 50  0001 C CNN
	1    14400 2100
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Current:ACS758xCB-200B-PFF U4
U 1 1 60096B8D
P 12700 4900
F 0 "U4" H 13000 5350 50  0000 L CNN
F 1 "ACS758xCB-200B-PFF" H 12450 5450 50  0000 L CNN
F 2 "Sensor_Current:Allegro_CB_PFF" H 12700 4900 50  0001 C CNN
F 3 "http://www.allegromicro.com/~/media/Files/Datasheets/ACS758-Datasheet.ashx?la=en" H 12700 4900 50  0001 C CNN
	1    12700 4900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Micro_SD_Card_Det_Hirose_DM3AT J1
U 1 1 6009789F
P 2300 1650
F 0 "J1" H 2250 2467 50  0000 C CNN
F 1 "Micro_SD_Card" H 2250 2376 50  0000 C CNN
F 2 "Connector_Card:microSD_HC_Hirose_DM3AT-SF-PEJM5" H 3450 1950 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 2300 1650 50  0001 C CNN
	1    2300 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	14000 2200 13600 2200
Wire Wire Line
	14000 2100 13600 2100
Text Label 13600 2200 0    50   ~ 0
SCL1
Text Label 13600 2100 0    50   ~ 0
SDA1
Text Label 6200 5950 2    50   ~ 0
SDA1
Text Label 6200 6050 2    50   ~ 0
SCL1
Wire Wire Line
	5800 5950 6200 5950
Wire Wire Line
	5800 6050 6200 6050
Wire Wire Line
	5800 6550 6200 6550
Wire Wire Line
	5800 6650 6200 6650
Text Label 6200 6550 2    50   ~ 0
SCL2
Text Label 6200 6650 2    50   ~ 0
SDA2
Wire Wire Line
	11000 1850 10600 1850
Wire Wire Line
	11000 1950 10600 1950
Text Label 10600 1850 0    50   ~ 0
SCL2
Text Label 10600 1950 0    50   ~ 0
SDA2
Wire Wire Line
	1400 1650 1000 1650
Wire Wire Line
	1400 1450 1000 1450
Text Label 1000 1650 0    50   ~ 0
SPI_CLK
Text Label 1000 1450 0    50   ~ 0
SPI_SD_CS
Wire Wire Line
	1400 1850 1000 1850
Text Label 1000 1850 0    50   ~ 0
MOSI
Wire Wire Line
	1400 1950 1000 1950
Text Label 1000 1950 0    50   ~ 0
MISO
Wire Wire Line
	5800 5750 6200 5750
Wire Wire Line
	5800 5050 6200 5050
Text Label 6200 5750 2    50   ~ 0
SPI_CLK
Text Label 6200 5050 2    50   ~ 0
SPI_SD_CS
Wire Wire Line
	5800 5850 6200 5850
Text Label 6200 5850 2    50   ~ 0
MISO
Text Label 6200 6150 2    50   ~ 0
MOSI
Wire Wire Line
	5800 6150 6200 6150
Wire Wire Line
	13100 4900 13600 4900
Text Label 13600 4900 2    50   ~ 0
Current_Adc
Wire Wire Line
	5800 6750 6300 6750
Text Label 6300 6750 2    50   ~ 0
Current_Adc
Text Notes 5250 7800 0    50   ~ 0
Note: ADC2 pins cannot be used when Wi-Fi is used. 
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 600A1449
P 8700 1200
F 0 "J2" H 8780 1192 50  0000 L CNN
F 1 "Conn_01x08" H 8780 1101 50  0000 L CNN
F 2 "" H 8700 1200 50  0001 C CNN
F 3 "~" H 8700 1200 50  0001 C CNN
	1    8700 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 600A2093
P 15100 4550
F 0 "R1" H 15170 4596 50  0000 L CNN
F 1 "R" H 15170 4505 50  0000 L CNN
F 2 "" V 15030 4550 50  0001 C CNN
F 3 "~" H 15100 4550 50  0001 C CNN
	1    15100 4550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 600A24E6
P 15100 4850
F 0 "R2" H 15170 4896 50  0000 L CNN
F 1 "R" H 15170 4805 50  0000 L CNN
F 2 "" V 15030 4850 50  0001 C CNN
F 3 "~" H 15100 4850 50  0001 C CNN
	1    15100 4850
	1    0    0    -1  
$EndComp
$Comp
L custom_symbols:VBATT #PWR0101
U 1 1 600A3C45
P 15100 4400
F 0 "#PWR0101" H 15100 4250 50  0001 C CNN
F 1 "VBATT" H 15115 4573 50  0000 C CNN
F 2 "" H 15100 4400 50  0001 C CNN
F 3 "" H 15100 4400 50  0001 C CNN
	1    15100 4400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 600A4EB2
P 15100 5000
F 0 "#PWR0102" H 15100 4750 50  0001 C CNN
F 1 "GND" H 15105 4827 50  0000 C CNN
F 2 "" H 15100 5000 50  0001 C CNN
F 3 "" H 15100 5000 50  0001 C CNN
	1    15100 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	15100 4700 14450 4700
Connection ~ 15100 4700
Text Label 14450 4700 0    50   ~ 0
BATT_V_ADC
Wire Wire Line
	5800 6850 6300 6850
Text Label 6300 6850 2    50   ~ 0
BATT_V_ADC
Text Label 7750 1600 0    50   ~ 0
Throttle
Wire Wire Line
	8500 1600 7750 1600
Wire Wire Line
	8500 1500 7750 1500
Text Label 7750 1500 0    50   ~ 0
PAS
Text Label 3850 4850 0    50   ~ 0
Throttle
Wire Wire Line
	4600 4850 3850 4850
Wire Wire Line
	4600 4750 3850 4750
Text Label 3850 4750 0    50   ~ 0
PAS
$Comp
L power:GND #PWR?
U 1 1 600A7F85
P 3100 2150
F 0 "#PWR?" H 3100 1900 50  0001 C CNN
F 1 "GND" H 3105 1977 50  0000 C CNN
F 2 "" H 3100 2150 50  0001 C CNN
F 3 "" H 3100 2150 50  0001 C CNN
	1    3100 2150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600A8B86
P 11600 3050
F 0 "#PWR?" H 11600 2800 50  0001 C CNN
F 1 "GND" H 11605 2877 50  0000 C CNN
F 2 "" H 11600 3050 50  0001 C CNN
F 3 "" H 11600 3050 50  0001 C CNN
	1    11600 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600A963D
P 11800 3050
F 0 "#PWR?" H 11800 2800 50  0001 C CNN
F 1 "GND" H 11805 2877 50  0000 C CNN
F 2 "" H 11800 3050 50  0001 C CNN
F 3 "" H 11800 3050 50  0001 C CNN
	1    11800 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600A9865
P 14400 2500
F 0 "#PWR?" H 14400 2250 50  0001 C CNN
F 1 "GND" H 14405 2327 50  0000 C CNN
F 2 "" H 14400 2500 50  0001 C CNN
F 3 "" H 14400 2500 50  0001 C CNN
	1    14400 2500
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 600AA2CB
P 5200 4350
F 0 "#PWR?" H 5200 4200 50  0001 C CNN
F 1 "+3.3V" H 5215 4523 50  0000 C CNN
F 2 "" H 5200 4350 50  0001 C CNN
F 3 "" H 5200 4350 50  0001 C CNN
	1    5200 4350
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 600AAC2A
P 11700 1300
F 0 "#PWR?" H 11700 1150 50  0001 C CNN
F 1 "+3.3V" H 11715 1473 50  0000 C CNN
F 2 "" H 11700 1300 50  0001 C CNN
F 3 "" H 11700 1300 50  0001 C CNN
	1    11700 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	11700 1300 11800 1300
Wire Wire Line
	12100 1300 12100 1450
Wire Wire Line
	12000 1450 12000 1300
Connection ~ 12000 1300
Wire Wire Line
	12000 1300 12100 1300
Wire Wire Line
	11800 1450 11800 1300
Connection ~ 11800 1300
Wire Wire Line
	11800 1300 12000 1300
Wire Wire Line
	11700 1450 11700 1300
Connection ~ 11700 1300
$Comp
L power:+3.3V #PWR?
U 1 1 600ADE9F
P 12700 4600
F 0 "#PWR?" H 12700 4450 50  0001 C CNN
F 1 "+3.3V" H 12715 4773 50  0000 C CNN
F 2 "" H 12700 4600 50  0001 C CNN
F 3 "" H 12700 4600 50  0001 C CNN
	1    12700 4600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600AE477
P 12700 5200
F 0 "#PWR?" H 12700 4950 50  0001 C CNN
F 1 "GND" H 12705 5027 50  0000 C CNN
F 2 "" H 12700 5200 50  0001 C CNN
F 3 "" H 12700 5200 50  0001 C CNN
	1    12700 5200
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 600AEB50
P 14400 1700
F 0 "#PWR?" H 14400 1550 50  0001 C CNN
F 1 "+3.3V" H 14415 1873 50  0000 C CNN
F 2 "" H 14400 1700 50  0001 C CNN
F 3 "" H 14400 1700 50  0001 C CNN
	1    14400 1700
	1    0    0    -1  
$EndComp
Wire Notes Line
	9950 800  9950 3750
Wire Notes Line
	15650 3750 15650 750 
Wire Notes Line
	15650 750  9950 750 
Text Notes 10150 900  0    50   ~ 0
Acclerometer/gyro/magnetometer
Text Notes 13900 950  0    50   ~ 0
Pressure/temperature/humidity
Wire Notes Line
	12950 800  12950 3750
Wire Notes Line
	9950 3750 15650 3750
Wire Notes Line
	3600 3500 3600 8550
Wire Notes Line
	3600 8550 8100 8550
Wire Notes Line
	8100 8550 8100 3500
Wire Notes Line
	8100 3500 3600 3500
Text Notes 3700 3800 0    50   ~ 0
ESP32 processor and WIFI/bluetooth
Text Notes 900  800  0    50   ~ 0
SD card
Wire Notes Line
	600  650  600  2650
Wire Notes Line
	600  2650 3700 2650
Wire Notes Line
	3700 2650 3700 650 
Wire Notes Line
	3700 650  600  650 
Wire Notes Line
	11900 3950 11900 5700
Wire Notes Line
	11900 5700 13950 5700
Wire Notes Line
	13950 5700 13950 3950
Wire Notes Line
	13950 3950 11900 3950
Text Notes 12000 4150 0    50   ~ 0
Current Sensing
Wire Notes Line
	14150 3950 14150 5550
Wire Notes Line
	14150 5550 15650 5550
Wire Notes Line
	15650 5550 15650 3950
Wire Notes Line
	15650 3950 14150 3950
Text Notes 14250 4100 0    50   ~ 0
Voltage Sensing
$EndSCHEMATC
