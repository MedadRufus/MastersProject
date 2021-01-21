EESchema Schematic File Version 4
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
P 9150 2300
F 0 "U2" H 9150 1411 50  0000 C CNN
F 1 "LSM9DS1" H 9150 1320 50  0000 C CNN
F 2 "Package_LGA:LGA-24L_3x3.5mm_P0.43mm" H 10650 3050 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/1e/3f/2a/d6/25/eb/48/46/DM00103319.pdf/files/DM00103319.pdf/jcr:content/translations/en.DM00103319.pdf" H 9150 2400 50  0001 C CNN
	1    9150 2300
	1    0    0    -1  
$EndComp
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 60094C13
P 6650 5450
F 0 "U1" H 6650 7031 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 6650 6940 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 6650 3950 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 6350 5500 50  0001 C CNN
	1    6650 5450
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Pressure:MS5607-02BA U3
U 1 1 600959C0
P 10500 6100
F 0 "U3" H 10830 6146 50  0000 L CNN
F 1 "MS5607-02BA" H 10830 6055 50  0000 L CNN
F 2 "Package_LGA:LGA-8_3x5mm_P1.25mm" H 10500 6100 50  0001 C CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5607-02BA03%7FB2%7Fpdf%7FEnglish%7FENG_DS_MS5607-02BA03_B2.pdf%7FCAT-BLPS0035" H 10500 6100 50  0001 C CNN
	1    10500 6100
	1    0    0    -1  
$EndComp
$Comp
L Sensor_Current:ACS758xCB-200B-PFF U4
U 1 1 60096B8D
P 12950 2500
F 0 "U4" H 13250 2950 50  0000 L CNN
F 1 "ACS758xCB-200B-PFF" H 12700 3050 50  0000 L CNN
F 2 "Sensor_Current:Allegro_CB_PFF" H 12950 2500 50  0001 C CNN
F 3 "http://www.allegromicro.com/~/media/Files/Datasheets/ACS758-Datasheet.ashx?la=en" H 12950 2500 50  0001 C CNN
	1    12950 2500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Micro_SD_Card_Det_Hirose_DM3AT J1
U 1 1 6009789F
P 4900 1550
F 0 "J1" H 4850 2367 50  0000 C CNN
F 1 "Micro_SD_Card" H 4850 2276 50  0000 C CNN
F 2 "Connector_Card:microSD_HC_Hirose_DM3AT-SF-PEJM5" H 6050 1850 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 4900 1550 50  0001 C CNN
	1    4900 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	10100 6200 9700 6200
Wire Wire Line
	10100 6100 9700 6100
Text Label 9700 6200 0    50   ~ 0
SCL1
Text Label 9700 6100 0    50   ~ 0
SDA1
Text Label 7650 5650 2    50   ~ 0
SDA1
Text Label 7650 5750 2    50   ~ 0
SCL1
Wire Wire Line
	7250 5650 7650 5650
Wire Wire Line
	7250 5750 7650 5750
Wire Wire Line
	7250 6250 7650 6250
Wire Wire Line
	7250 6350 7650 6350
Text Label 7650 6250 2    50   ~ 0
SCL2
Text Label 7650 6350 2    50   ~ 0
SDA2
Wire Wire Line
	8450 1900 8050 1900
Wire Wire Line
	8450 2000 8050 2000
Text Label 8050 1900 0    50   ~ 0
SCL2
Text Label 8050 2000 0    50   ~ 0
SDA2
Wire Wire Line
	4000 1550 3600 1550
Wire Wire Line
	4000 1350 3600 1350
Text Label 3600 1550 0    50   ~ 0
SPI_CLK
Text Label 3600 1350 0    50   ~ 0
SPI_SD_CS
Wire Wire Line
	4000 1750 3600 1750
Text Label 3600 1750 0    50   ~ 0
MOSI
Wire Wire Line
	4000 1850 3600 1850
Text Label 3600 1850 0    50   ~ 0
MISO
Wire Wire Line
	7250 5450 7650 5450
Wire Wire Line
	7250 4750 7650 4750
Text Label 7650 5450 2    50   ~ 0
SPI_CLK
Text Label 7650 4750 2    50   ~ 0
SPI_SD_CS
Wire Wire Line
	7250 5550 7650 5550
Text Label 7650 5550 2    50   ~ 0
MISO
Text Label 7650 5850 2    50   ~ 0
MOSI
Wire Wire Line
	7250 5850 7650 5850
Wire Wire Line
	13350 2500 13850 2500
Text Label 13850 2500 2    50   ~ 0
Current_Adc
Wire Wire Line
	7250 6450 7750 6450
Text Label 7750 6450 2    50   ~ 0
Current_Adc
Text Notes 6700 7500 0    50   ~ 0
Note: ADC2 pins cannot be used when Wi-Fi is used. 
$Comp
L Connector_Generic:Conn_01x08 J?
U 1 1 600A1449
P 4250 3300
F 0 "J?" H 4330 3292 50  0000 L CNN
F 1 "Conn_01x08" H 4330 3201 50  0000 L CNN
F 2 "" H 4250 3300 50  0001 C CNN
F 3 "~" H 4250 3300 50  0001 C CNN
	1    4250 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 600A2093
P 4050 4950
F 0 "R?" H 4120 4996 50  0000 L CNN
F 1 "R" H 4120 4905 50  0000 L CNN
F 2 "" V 3980 4950 50  0001 C CNN
F 3 "~" H 4050 4950 50  0001 C CNN
	1    4050 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 600A24E6
P 4050 5250
F 0 "R?" H 4120 5296 50  0000 L CNN
F 1 "R" H 4120 5205 50  0000 L CNN
F 2 "" V 3980 5250 50  0001 C CNN
F 3 "~" H 4050 5250 50  0001 C CNN
	1    4050 5250
	1    0    0    -1  
$EndComp
$Comp
L custom_symbols:VBATT #PWR?
U 1 1 600A3C45
P 4050 4800
F 0 "#PWR?" H 4050 4650 50  0001 C CNN
F 1 "VBATT" H 4065 4973 50  0000 C CNN
F 2 "" H 4050 4800 50  0001 C CNN
F 3 "" H 4050 4800 50  0001 C CNN
	1    4050 4800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600A4EB2
P 4050 5400
F 0 "#PWR?" H 4050 5150 50  0001 C CNN
F 1 "GND" H 4055 5227 50  0000 C CNN
F 2 "" H 4050 5400 50  0001 C CNN
F 3 "" H 4050 5400 50  0001 C CNN
	1    4050 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 5100 3400 5100
Connection ~ 4050 5100
Text Label 3400 5100 0    50   ~ 0
BATT_V_ADC
Wire Wire Line
	7250 6550 7750 6550
Text Label 7750 6550 2    50   ~ 0
BATT_V_ADC
Text Label 3300 3700 0    50   ~ 0
Throttle
Wire Wire Line
	4050 3700 3300 3700
Wire Wire Line
	4050 3600 3300 3600
Text Label 3300 3600 0    50   ~ 0
PAS
Text Label 5300 4550 0    50   ~ 0
Throttle
Wire Wire Line
	6050 4550 5300 4550
Wire Wire Line
	6050 4450 5300 4450
Text Label 5300 4450 0    50   ~ 0
PAS
$EndSCHEMATC
