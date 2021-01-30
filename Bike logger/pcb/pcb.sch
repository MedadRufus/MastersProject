EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 11
Title "Design of E bike datalogger"
Date "2021-01-21"
Rev "v0.1"
Comp ""
Comment1 "Ref: https://randomnerdtutorials.com/esp32-adc-analog-read-arduino-ide/"
Comment2 "Based on design: https://www.pedelecforum.de/wiki/doku.php?id=elektrotechnik:forumscontroller"
Comment3 ""
Comment4 ""
$EndDescr
Text Label 13600 2200 0    50   ~ 0
SCL1
Text Label 13600 2100 0    50   ~ 0
SDA1
Text Label 5200 5200 2    50   ~ 0
SDA1
Text Label 5200 5300 2    50   ~ 0
SCL1
Wire Wire Line
	4800 5200 5750 5200
Wire Wire Line
	4800 5300 5750 5300
Text Label 900  1650 0    50   ~ 0
SPI_CLK
Text Label 900  1350 0    50   ~ 0
SPI_SD_CS
Text Label 900  1450 0    50   ~ 0
MOSI
Text Label 900  1850 0    50   ~ 0
MISO
Wire Wire Line
	4800 5000 5750 5000
Wire Wire Line
	4800 4300 5750 4300
Text Label 5200 4600 2    50   ~ 0
SPI_CLK
Text Label 5200 4700 2    50   ~ 0
SPI_SD_CS
Wire Wire Line
	4800 5100 5750 5100
Text Label 5200 4400 2    50   ~ 0
MISO
Text Label 5200 4500 2    50   ~ 0
MOSI
Wire Wire Line
	4800 5400 5750 5400
Text Notes 4250 7050 0    50   ~ 0
Note: ADC2 pins cannot be used when Wi-Fi is used. \nADC2 pins are: GPIO 4, 0, 2, 15, 13, 12, 14, 27, 25, 26
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 600A1449
P 8700 1200
F 0 "J2" H 8780 1192 50  0000 L CNN
F 1 "Conn_01x08" H 8780 1101 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4_1x04_P5.00mm_Horizontal" H 8700 1200 50  0001 C CNN
F 3 "~" H 8700 1200 50  0001 C CNN
	1    8700 1200
	1    0    0    -1  
$EndComp
Text Label 7750 1600 0    50   ~ 0
Throttle
Wire Wire Line
	8500 1600 7750 1600
Wire Wire Line
	3600 4100 2850 4100
Wire Wire Line
	3600 4000 2850 4000
Text Label 2850 4000 0    50   ~ 0
PAS_ADC
$Comp
L power:GND #PWR01
U 1 1 600A7F85
P 3100 2150
F 0 "#PWR01" H 3100 1900 50  0001 C CNN
F 1 "GND" H 3105 1977 50  0000 C CNN
F 2 "" H 3100 2150 50  0001 C CNN
F 3 "" H 3100 2150 50  0001 C CNN
	1    3100 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR02
U 1 1 600AA2CB
P 4200 3600
F 0 "#PWR02" H 4200 3450 50  0001 C CNN
F 1 "+3.3V" H 4215 3773 50  0000 C CNN
F 2 "" H 4200 3600 50  0001 C CNN
F 3 "" H 4200 3600 50  0001 C CNN
	1    4200 3600
	1    0    0    -1  
$EndComp
Wire Notes Line
	15650 3750 15650 750 
Wire Notes Line
	15650 750  9950 750 
Text Notes 13900 950  0    50   ~ 0
Pressure/temperature/humidity
Wire Notes Line
	12950 800  12950 3750
Wire Notes Line
	2450 2800 2450 7850
Wire Notes Line
	2450 7850 6950 7850
Wire Notes Line
	6950 7850 6950 2800
Wire Notes Line
	6950 2800 2450 2800
Text Notes 2550 3100 0    50   ~ 0
ESP32 processor and WIFI/bluetooth
Text Notes 900  800  0    50   ~ 0
SD card Reader
Wire Notes Line
	600  650  600  2650
Wire Notes Line
	600  2650 3700 2650
Wire Notes Line
	3700 2650 3700 650 
Wire Notes Line
	3700 650  600  650 
NoConn ~ 1400 2150
NoConn ~ 1400 2050
NoConn ~ 1400 1250
$Comp
L power:+3.3V #PWR012
U 1 1 600E8BB8
P 13250 6150
F 0 "#PWR012" H 13250 6000 50  0001 C CNN
F 1 "+3.3V" H 13265 6323 50  0000 C CNN
F 2 "" H 13250 6150 50  0001 C CNN
F 3 "" H 13250 6150 50  0001 C CNN
	1    13250 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	13250 6150 13250 6300
$Comp
L power:GND #PWR013
U 1 1 600E9DF7
P 13500 8850
F 0 "#PWR013" H 13500 8600 50  0001 C CNN
F 1 "GND" H 13505 8677 50  0000 C CNN
F 2 "" H 13500 8850 50  0001 C CNN
F 3 "" H 13500 8850 50  0001 C CNN
	1    13500 8850
	1    0    0    -1  
$EndComp
Wire Wire Line
	13500 8850 13500 8800
$Comp
L power:GND #PWR03
U 1 1 600FEC39
P 4200 6400
F 0 "#PWR03" H 4200 6150 50  0001 C CNN
F 1 "GND" H 4205 6227 50  0000 C CNN
F 2 "" H 4200 6400 50  0001 C CNN
F 3 "" H 4200 6400 50  0001 C CNN
	1    4200 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4100 5750 4100
Text Label 5200 4100 2    50   ~ 0
TX0
Text Label 5200 3900 2    50   ~ 0
RX0
Wire Wire Line
	14150 7600 14600 7600
Text Label 14600 7700 2    50   ~ 0
RX0
Wire Wire Line
	14150 7700 14600 7700
Text Label 14600 7600 2    50   ~ 0
TX0
$Comp
L Device:C C4
U 1 1 6012D893
P 13900 6450
F 0 "C4" H 13785 6404 50  0000 R CNN
F 1 "10uF" H 13785 6495 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 13938 6300 50  0001 C CNN
F 3 "~" H 13900 6450 50  0001 C CNN
	1    13900 6450
	-1   0    0    1   
$EndComp
Wire Wire Line
	13250 6300 13450 6300
$Comp
L power:GND #PWR020
U 1 1 601334EB
P 13900 6600
F 0 "#PWR020" H 13900 6350 50  0001 C CNN
F 1 "GND" H 13905 6427 50  0000 C CNN
F 2 "" H 13900 6600 50  0001 C CNN
F 3 "" H 13900 6600 50  0001 C CNN
	1    13900 6600
	1    0    0    -1  
$EndComp
Wire Notes Line
	15500 9300 11100 9300
Wire Notes Line
	11100 5900 15500 5900
Text Notes 11250 6100 0    50   ~ 0
USB to UART
Wire Notes Line
	6200 600  6200 2650
Wire Notes Line
	6200 2650 9650 2650
Wire Notes Line
	9650 2650 9650 600 
Wire Notes Line
	9650 600  6200 600 
Text Notes 6350 700  0    50   ~ 0
Inputs
Wire Wire Line
	14000 2200 13600 2200
Wire Wire Line
	14000 2100 13600 2100
$Comp
L power:GND #PWR016
U 1 1 600A9865
P 14400 2500
F 0 "#PWR016" H 14400 2250 50  0001 C CNN
F 1 "GND" H 14405 2327 50  0000 C CNN
F 2 "" H 14400 2500 50  0001 C CNN
F 3 "" H 14400 2500 50  0001 C CNN
	1    14400 2500
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR015
U 1 1 600AEB50
P 14400 1250
F 0 "#PWR015" H 14400 1100 50  0001 C CNN
F 1 "+3.3V" H 14415 1423 50  0000 C CNN
F 2 "" H 14400 1250 50  0001 C CNN
F 3 "" H 14400 1250 50  0001 C CNN
	1    14400 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	14400 1250 14400 1700
Connection ~ 14400 1250
Wire Wire Line
	14650 1250 14400 1250
$Comp
L Device:C C5
U 1 1 6013D55A
P 14650 1400
F 0 "C5" H 14765 1446 50  0000 L CNN
F 1 "C" H 14765 1355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 14688 1250 50  0001 C CNN
F 3 "~" H 14650 1400 50  0001 C CNN
	1    14650 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 601415DC
P 14650 1550
F 0 "#PWR021" H 14650 1300 50  0001 C CNN
F 1 "GND" H 14655 1377 50  0000 C CNN
F 2 "" H 14650 1550 50  0001 C CNN
F 3 "" H 14650 1550 50  0001 C CNN
	1    14650 1550
	1    0    0    -1  
$EndComp
Text Label 7750 1500 0    50   ~ 0
PAS
Wire Wire Line
	8500 1500 7750 1500
Wire Wire Line
	13450 8700 13450 8800
Wire Wire Line
	13450 8800 13500 8800
Wire Wire Line
	13550 8800 13550 8700
Connection ~ 13500 8800
Wire Wire Line
	13500 8800 13550 8800
Wire Wire Line
	13250 6300 13250 6800
Connection ~ 13250 6300
Wire Wire Line
	13450 6800 13450 6300
Connection ~ 13450 6300
$Comp
L power:VBUS #PWR09
U 1 1 60130B9C
P 12550 7200
F 0 "#PWR09" H 12550 7050 50  0001 C CNN
F 1 "VBUS" H 12565 7373 50  0000 C CNN
F 2 "" H 12550 7200 50  0001 C CNN
F 3 "" H 12550 7200 50  0001 C CNN
	1    12550 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	12550 7300 12550 7200
NoConn ~ 12750 7900
NoConn ~ 12750 8000
NoConn ~ 12750 8100
NoConn ~ 12750 8200
NoConn ~ 12750 8400
NoConn ~ 14150 8400
NoConn ~ 14150 8300
NoConn ~ 14150 8200
NoConn ~ 14150 8000
NoConn ~ 14150 7100
NoConn ~ 14150 7200
NoConn ~ 14150 7400
Wire Wire Line
	12750 7100 12750 6300
Wire Wire Line
	12750 6300 13250 6300
$Comp
L Transistor_BJT:MMBT5551L Q1
U 1 1 60150D6F
P 2200 9300
F 0 "Q1" H 2391 9346 50  0000 L CNN
F 1 "MMBT5551L" H 2391 9255 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2400 9225 50  0001 L CIN
F 3 "www.onsemi.com/pub/Collateral/MMBT5550LT1-D.PDF" H 2200 9300 50  0001 L CNN
F 4 "5" H 2200 9300 50  0001 C CNN "min_qty"
F 5 "0.165" H 2200 9300 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/on-semiconductor/mmbt5551lt1g/transistor-npn-sot-23/dp/1459109?st=mmbt5551l" H 2200 9300 50  0001 C CNN "purchase_link"
	1    2200 9300
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:MMBT5551L Q2
U 1 1 60151B9F
P 2200 9900
F 0 "Q2" H 2391 9854 50  0000 L CNN
F 1 "MMBT5551L" H 2391 9945 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2400 9825 50  0001 L CIN
F 3 "www.onsemi.com/pub/Collateral/MMBT5550LT1-D.PDF" H 2200 9900 50  0001 L CNN
F 4 "5" H 2200 9900 50  0001 C CNN "min_qty"
F 5 "0.165" H 2200 9900 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/on-semiconductor/mmbt5551lt1g/transistor-npn-sot-23/dp/1459109?st=mmbt5551l" H 2200 9900 50  0001 C CNN "purchase_link"
	1    2200 9900
	1    0    0    1   
$EndComp
Wire Wire Line
	2300 10100 2300 10250
Wire Wire Line
	2300 10250 2850 10250
Wire Wire Line
	2300 9100 2300 8900
Wire Wire Line
	2300 8900 2850 8900
Wire Wire Line
	2300 9500 1700 9500
Wire Wire Line
	1700 9500 1700 9900
$Comp
L Device:R R4
U 1 1 601657EE
P 1850 9900
F 0 "R4" V 1643 9900 50  0000 C CNN
F 1 "10k" V 1734 9900 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1780 9900 50  0001 C CNN
F 3 "~" H 1850 9900 50  0001 C CNN
	1    1850 9900
	0    1    1    0   
$EndComp
Connection ~ 1700 9900
Wire Wire Line
	1700 9900 1700 10250
$Comp
L Device:R R3
U 1 1 601663DB
P 1850 9300
F 0 "R3" V 1643 9300 50  0000 C CNN
F 1 "10k" V 1734 9300 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 1780 9300 50  0001 C CNN
F 3 "~" H 1850 9300 50  0001 C CNN
	1    1850 9300
	0    1    1    0   
$EndComp
Wire Wire Line
	2300 9700 2300 9650
Wire Wire Line
	2300 9650 1500 9650
Wire Wire Line
	1500 9650 1500 9300
Wire Wire Line
	1500 9300 1700 9300
Wire Wire Line
	1500 9300 1500 8850
Connection ~ 1500 9300
Wire Wire Line
	4800 3800 5250 3800
Text Label 1500 8850 3    50   ~ 0
RTS
Text Label 14600 7900 2    50   ~ 0
RTS
Wire Wire Line
	14150 7900 14600 7900
Text Label 2850 8900 2    50   ~ 0
GPIO0
Text Label 5250 3800 2    50   ~ 0
GPIO0
Text Label 2850 10250 2    50   ~ 0
RESET
Text Label 1700 10250 1    50   ~ 0
DTR
Text Label 2850 3800 0    50   ~ 0
RESET
Wire Wire Line
	2850 3800 3600 3800
Text Label 14600 7300 2    50   ~ 0
DTR
Wire Wire Line
	14150 7300 14600 7300
Wire Notes Line
	11100 5900 11100 9300
Wire Notes Line
	15500 5900 15500 9300
Wire Notes Line
	1000 8350 3200 8350
Wire Notes Line
	3200 8350 3200 10800
Wire Notes Line
	3200 10800 1000 10800
Wire Notes Line
	1000 10800 1000 8350
Text Notes 1150 8500 0    50   ~ 0
Programming intricacies of ESP32
Text Notes 700  2950 0    50   ~ 0
Pedal Assist Sensing
Wire Notes Line
	600  3950 2300 3950
Wire Notes Line
	600  2800 2300 2800
Text Notes 700  4100 0    50   ~ 0
Throttle Sensing
Wire Notes Line
	600  4750 2300 4750
Text Label 2850 4100 0    50   ~ 0
throttle_ADC
Wire Wire Line
	12750 7300 12550 7300
$Comp
L Interface_USB:CP2104 U5
U 1 1 600F44E2
P 13450 7700
F 0 "U5" H 12700 6400 50  0000 C CNN
F 1 "CP2104" H 12700 6600 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 13600 6750 50  0001 L CNN
F 3 "https://www.silabs.com/documents/public/data-sheets/cp2104.pdf" H 12900 8950 50  0001 C CNN
	1    13450 7700
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR08
U 1 1 60133918
P 12450 8100
F 0 "#PWR08" H 12450 7950 50  0001 C CNN
F 1 "VBUS" H 12465 8273 50  0000 C CNN
F 2 "" H 12450 8100 50  0001 C CNN
F 3 "" H 12450 8100 50  0001 C CNN
	1    12450 8100
	1    0    0    -1  
$EndComp
NoConn ~ 1400 1950
Wire Wire Line
	1400 1850 900  1850
Wire Wire Line
	1400 1650 900  1650
Wire Wire Line
	1400 1450 900  1450
Wire Wire Line
	1400 1350 900  1350
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
Text Notes 800  2550 0    50   ~ 0
Wired according to: \nhttps://community.st.com/s/contentdocument/0690X00000604T2QAI
Text Notes 4450 6850 0    50   ~ 0
TODO: verify the miso/mosi connections on MCU
Wire Wire Line
	750  1750 750  2150
$Comp
L power:GND #PWR029
U 1 1 602639C7
P 750 2150
F 0 "#PWR029" H 750 1900 50  0001 C CNN
F 1 "GND" H 755 1977 50  0000 C CNN
F 2 "" H 750 2150 50  0001 C CNN
F 3 "" H 750 2150 50  0001 C CNN
	1    750  2150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR07
U 1 1 60267CA7
P 750 1050
F 0 "#PWR07" H 750 900 50  0001 C CNN
F 1 "+3V3" H 765 1223 50  0000 C CNN
F 2 "" H 750 1050 50  0001 C CNN
F 3 "" H 750 1050 50  0001 C CNN
	1    750  1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 1550 750  1550
Wire Wire Line
	750  1550 750  1050
Wire Wire Line
	750  1750 1400 1750
$Comp
L Connector_Generic:Conn_01x05 J5
U 1 1 601071EE
P 4700 1600
F 0 "J5" H 4618 1175 50  0000 C CNN
F 1 "Conn_01x05" H 4618 1266 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4_1x04_P5.00mm_Horizontal" H 4700 1600 50  0001 C CNN
F 3 "~" H 4700 1600 50  0001 C CNN
	1    4700 1600
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J4
U 1 1 60109051
P 4300 9150
F 0 "J4" H 4500 8700 50  0000 C CNN
F 1 "Conn_01x04" H 4450 8800 50  0000 C CNN
F 2 "Connector:NS-Tech_Grove_1x04_P2mm_Vertical" H 4300 9150 50  0001 C CNN
F 3 "~" H 4300 9150 50  0001 C CNN
	1    4300 9150
	-1   0    0    1   
$EndComp
Text Label 4900 9150 2    50   ~ 0
SDA1
Text Label 4900 9250 2    50   ~ 0
SCL1
Wire Wire Line
	4500 9150 4900 9150
Wire Wire Line
	4500 9250 4900 9250
$Comp
L power:+3.3V #PWR031
U 1 1 6011E472
P 4850 8950
F 0 "#PWR031" H 4850 8800 50  0001 C CNN
F 1 "+3.3V" H 4865 9123 50  0000 C CNN
F 2 "" H 4850 8950 50  0001 C CNN
F 3 "" H 4850 8950 50  0001 C CNN
	1    4850 8950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 9050 4850 9050
Wire Wire Line
	4850 9050 4850 8950
$Comp
L power:GND #PWR032
U 1 1 6012326B
P 4500 8600
F 0 "#PWR032" H 4500 8350 50  0001 C CNN
F 1 "GND" H 4505 8427 50  0000 C CNN
F 2 "" H 4500 8600 50  0001 C CNN
F 3 "" H 4500 8600 50  0001 C CNN
	1    4500 8600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4500 8950 4650 8950
Wire Notes Line
	3800 8250 3800 9950
Wire Notes Line
	3800 9950 5550 9950
Wire Notes Line
	5550 9950 5550 8250
Wire Notes Line
	5550 8250 3800 8250
Text Notes 3850 8400 0    50   ~ 0
I2C OLED display
Text Notes 4200 950  0    50   ~ 0
U-blox GPS module connector
Wire Notes Line
	3900 650  3900 2650
Wire Notes Line
	3900 2650 6000 2650
Wire Notes Line
	6000 2650 6000 650 
Wire Notes Line
	6000 650  3900 650 
Text Label 5300 1500 2    50   ~ 0
GPS_RX
Text Label 5300 1600 2    50   ~ 0
GPS_TX
Wire Wire Line
	4900 1500 5300 1500
Wire Wire Line
	4900 1600 5300 1600
$Comp
L power:+3.3V #PWR033
U 1 1 6013BDFD
P 5250 1300
F 0 "#PWR033" H 5250 1150 50  0001 C CNN
F 1 "+3.3V" H 5265 1473 50  0000 C CNN
F 2 "" H 5250 1300 50  0001 C CNN
F 3 "" H 5250 1300 50  0001 C CNN
	1    5250 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1400 5250 1400
Wire Wire Line
	5250 1400 5250 1300
$Comp
L power:GND #PWR034
U 1 1 6013BE09
P 5250 1950
F 0 "#PWR034" H 5250 1700 50  0001 C CNN
F 1 "GND" H 5255 1777 50  0000 C CNN
F 2 "" H 5250 1950 50  0001 C CNN
F 3 "" H 5250 1950 50  0001 C CNN
	1    5250 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 1800 5250 1800
Wire Wire Line
	5250 1800 5250 1950
Text Label 5300 1700 2    50   ~ 0
PPS
Wire Wire Line
	4900 1700 5300 1700
Text Label 5200 4900 2    50   ~ 0
GPS_RX
Text Label 5200 4800 2    50   ~ 0
GPS_TX
Wire Wire Line
	4800 4900 5750 4900
Wire Wire Line
	4800 4800 5750 4800
$Comp
L custom_symbols:STH0548S3V3 U7
U 1 1 601216DB
P 7400 8900
F 0 "U7" H 7400 8965 50  0000 C CNN
F 1 "STH0548S3V3" H 7400 8874 50  0000 C CNN
F 2 "custom_footprints:STH0548S3V3" H 7400 8900 50  0001 C CNN
F 3 "" H 7400 8900 50  0001 C CNN
F 4 "1" H 7400 8900 50  0001 C CNN "min_qty"
F 5 "7.45" H 7400 8900 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/xp-power/sth0548s3v3/dc-dc-converter-3-3v-0-5a/dp/3212474" H 7400 8900 50  0001 C CNN "purchase_link"
	1    7400 8900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 9300 6050 9150
$Comp
L power:+3.3V #PWR035
U 1 1 601234F2
P 6050 9150
F 0 "#PWR035" H 6050 9000 50  0001 C CNN
F 1 "+3.3V" H 6065 9323 50  0000 C CNN
F 2 "" H 6050 9150 50  0001 C CNN
F 3 "" H 6050 9150 50  0001 C CNN
	1    6050 9150
	1    0    0    -1  
$EndComp
$Comp
L custom_symbols:VBATT #PWR037
U 1 1 6014B49A
P 6050 8550
F 0 "#PWR037" H 6050 8400 50  0001 C CNN
F 1 "VBATT" H 6065 8723 50  0000 C CNN
F 2 "" H 6050 8550 50  0001 C CNN
F 3 "" H 6050 8550 50  0001 C CNN
	1    6050 8550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 8950 6400 9150
$Comp
L power:GND #PWR039
U 1 1 6015C1A0
P 8400 9400
F 0 "#PWR039" H 8400 9150 50  0001 C CNN
F 1 "GND" H 8405 9227 50  0000 C CNN
F 2 "" H 8400 9400 50  0001 C CNN
F 3 "" H 8400 9400 50  0001 C CNN
	1    8400 9400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 9150 8400 9150
Wire Wire Line
	8400 9150 8400 9300
Wire Wire Line
	7950 9300 8400 9300
Connection ~ 8400 9300
Wire Wire Line
	8400 9300 8400 9400
$Comp
L power:GND #PWR036
U 1 1 6018051F
P 6050 9700
F 0 "#PWR036" H 6050 9450 50  0001 C CNN
F 1 "GND" H 6055 9527 50  0000 C CNN
F 2 "" H 6050 9700 50  0001 C CNN
F 3 "" H 6050 9700 50  0001 C CNN
	1    6050 9700
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 9600 6050 9700
$Comp
L power:GND #PWR038
U 1 1 60186C96
P 6400 10050
F 0 "#PWR038" H 6400 9800 50  0001 C CNN
F 1 "GND" H 6405 9877 50  0000 C CNN
F 2 "" H 6400 10050 50  0001 C CNN
F 3 "" H 6400 10050 50  0001 C CNN
	1    6400 10050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C11
U 1 1 6018709B
P 6050 9450
F 0 "C11" H 5935 9404 50  0000 R CNN
F 1 "10uF" H 5935 9495 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6088 9300 50  0001 C CNN
F 3 "~" H 6050 9450 50  0001 C CNN
	1    6050 9450
	-1   0    0    1   
$EndComp
Connection ~ 6050 9300
$Comp
L Device:C C12
U 1 1 60187E4E
P 6400 9850
F 0 "C12" H 6285 9804 50  0000 R CNN
F 1 "10uF" H 6285 9895 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6438 9700 50  0001 C CNN
F 3 "~" H 6400 9850 50  0001 C CNN
	1    6400 9850
	-1   0    0    1   
$EndComp
Wire Wire Line
	6400 10000 6400 10050
Wire Wire Line
	6050 9300 6850 9300
Wire Wire Line
	6400 9150 6400 9700
Connection ~ 6400 9150
Wire Wire Line
	6400 9150 6850 9150
NoConn ~ 6850 9450
NoConn ~ 7950 9450
Wire Notes Line
	5800 10300 8900 10300
Wire Notes Line
	8900 7900 5800 7900
Text Notes 5900 8050 0    50   ~ 0
3.3V regulator that converts Vbatt(36-42V input) to 3.3V.
Wire Wire Line
	4500 8600 4500 8500
Wire Wire Line
	4500 8500 4650 8500
Wire Wire Line
	4650 8500 4650 8950
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 60208D6F
P 11600 4250
F 0 "H1" V 11837 4253 50  0000 C CNN
F 1 "MountingHole_Pad" V 11746 4253 50  0000 C CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 11600 4250 50  0001 C CNN
F 3 "~" H 11600 4250 50  0001 C CNN
	1    11600 4250
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 6021C578
P 11600 4650
F 0 "H2" V 11837 4653 50  0000 C CNN
F 1 "MountingHole_Pad" V 11746 4653 50  0000 C CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 11600 4650 50  0001 C CNN
F 3 "~" H 11600 4650 50  0001 C CNN
	1    11600 4650
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 6021C836
P 11600 5000
F 0 "H3" V 11837 5003 50  0000 C CNN
F 1 "MountingHole_Pad" V 11746 5003 50  0000 C CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 11600 5000 50  0001 C CNN
F 3 "~" H 11600 5000 50  0001 C CNN
	1    11600 5000
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 6021CA96
P 11600 5400
F 0 "H4" V 11837 5403 50  0000 C CNN
F 1 "MountingHole_Pad" V 11746 5403 50  0000 C CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 11600 5400 50  0001 C CNN
F 3 "~" H 11600 5400 50  0001 C CNN
	1    11600 5400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	11700 4250 12000 4250
$Comp
L power:GND #PWR0101
U 1 1 602271B8
P 12000 5550
F 0 "#PWR0101" H 12000 5300 50  0001 C CNN
F 1 "GND" H 12005 5377 50  0000 C CNN
F 2 "" H 12000 5550 50  0001 C CNN
F 3 "" H 12000 5550 50  0001 C CNN
	1    12000 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	11700 5400 12000 5400
Wire Wire Line
	12000 4250 12000 4650
Connection ~ 12000 5400
Wire Wire Line
	12000 5400 12000 5550
Wire Wire Line
	11700 5000 12000 5000
Connection ~ 12000 5000
Wire Wire Line
	12000 5000 12000 5400
Wire Wire Line
	11700 4650 12000 4650
Connection ~ 12000 4650
Wire Wire Line
	12000 4650 12000 5000
Wire Notes Line
	10950 3800 13650 3800
Wire Notes Line
	13650 3800 13650 5800
Wire Notes Line
	13650 5800 10950 5800
Wire Notes Line
	10950 5800 10950 3800
Text Notes 11050 3900 0    50   ~ 0
Mounting Holes
$Comp
L power:GND #PWR011
U 1 1 60276B94
P 11300 3050
F 0 "#PWR011" H 11300 2800 50  0001 C CNN
F 1 "GND" H 11305 2877 50  0000 C CNN
F 2 "" H 11300 3050 50  0001 C CNN
F 3 "" H 11300 3050 50  0001 C CNN
	1    11300 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 3000 11250 3050
Wire Wire Line
	11250 3050 11300 3050
Wire Wire Line
	11350 3000 11350 3050
Wire Wire Line
	11350 3050 11300 3050
Connection ~ 11300 3050
$Comp
L power:+3.3V #PWR010
U 1 1 60287440
P 11250 1350
F 0 "#PWR010" H 11250 1200 50  0001 C CNN
F 1 "+3.3V" H 11265 1523 50  0000 C CNN
F 2 "" H 11250 1350 50  0001 C CNN
F 3 "" H 11250 1350 50  0001 C CNN
	1    11250 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1350 11250 1800
Connection ~ 11250 1350
Wire Wire Line
	11500 1350 11250 1350
$Comp
L Device:C C2
U 1 1 6028744D
P 11500 1500
F 0 "C2" H 11615 1546 50  0000 L CNN
F 1 "C" H 11615 1455 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 11538 1350 50  0001 C CNN
F 3 "~" H 11500 1500 50  0001 C CNN
	1    11500 1500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR017
U 1 1 60287457
P 11500 1650
F 0 "#PWR017" H 11500 1400 50  0001 C CNN
F 1 "GND" H 11505 1477 50  0000 C CNN
F 2 "" H 11500 1650 50  0001 C CNN
F 3 "" H 11500 1650 50  0001 C CNN
	1    11500 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1800 11350 1800
Connection ~ 11250 1800
Wire Wire Line
	10650 2600 10250 2600
Wire Wire Line
	10650 2500 10250 2500
Text Label 10250 2600 0    50   ~ 0
SCL1
Text Label 10250 2500 0    50   ~ 0
SDA1
$Comp
L Sensor_Motion:LSM6DS3 U4
U 1 1 60257B3F
P 11250 2400
F 0 "U4" H 11894 2446 50  0000 L CNN
F 1 "LSM6DS3" H 11894 2355 50  0000 L CNN
F 2 "Package_LGA:LGA-14_3x2.5mm_P0.5mm_LayoutBorder3x4y" H 10850 1700 50  0001 L CNN
F 3 "www.st.com/resource/en/datasheet/lsm6ds3.pdf" H 11350 1750 50  0001 C CNN
	1    11250 2400
	1    0    0    -1  
$EndComp
NoConn ~ 10650 2100
NoConn ~ 10650 2200
NoConn ~ 10650 2300
NoConn ~ 10650 2700
Text Notes 10250 1050 0    50   ~ 0
Acclerometer/gyro
$Sheet
S 700  4250 900  300 
U 60156738
F0 "throttle protection" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1600 4450 50 
F3 "protected_adc_input" I R 1600 4350 50 
$EndSheet
Text Label 2150 4350 2    50   ~ 0
throttle_ADC
Wire Wire Line
	2150 4350 1600 4350
Text Label 2150 4450 2    50   ~ 0
Throttle
Wire Wire Line
	1600 4450 2150 4450
Text Label 2200 3600 2    50   ~ 0
PAS
Text Label 2200 3500 2    50   ~ 0
PAS_ADC
Wire Wire Line
	1650 3600 2200 3600
$Sheet
S 750  3400 900  300 
U 601BF9C2
F0 "PAS protection" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1650 3600 50 
F3 "protected_adc_input" I R 1650 3500 50 
$EndSheet
Wire Wire Line
	2200 3500 1650 3500
$Comp
L Connector:TestPoint TP9
U 1 1 6024B8B0
P 5750 4400
F 0 "TP9" V 5750 5000 50  0000 L CNN
F 1 "TestPoint" V 5750 4600 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4400 50  0001 C CNN
F 3 "~" H 5950 4400 50  0001 C CNN
	1    5750 4400
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4400 4800 4400
$Comp
L Connector:TestPoint TP10
U 1 1 6027077D
P 5750 4500
F 0 "TP10" V 5750 5100 50  0000 L CNN
F 1 "TestPoint" V 5750 4700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4500 50  0001 C CNN
F 3 "~" H 5950 4500 50  0001 C CNN
	1    5750 4500
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4500 4800 4500
$Comp
L Connector:TestPoint TP11
U 1 1 602766BD
P 5750 4600
F 0 "TP11" V 5750 5200 50  0000 L CNN
F 1 "TestPoint" V 5750 4800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4600 50  0001 C CNN
F 3 "~" H 5950 4600 50  0001 C CNN
	1    5750 4600
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4600 4800 4600
$Comp
L Connector:TestPoint TP12
U 1 1 6027C73C
P 5750 4700
F 0 "TP12" V 5750 5300 50  0000 L CNN
F 1 "TestPoint" V 5750 4900 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4700 50  0001 C CNN
F 3 "~" H 5950 4700 50  0001 C CNN
	1    5750 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4700 4800 4700
$Comp
L Connector:TestPoint TP13
U 1 1 60282CBC
P 5750 5500
F 0 "TP13" V 5750 6100 50  0000 L CNN
F 1 "TestPoint" V 5750 5700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5500 50  0001 C CNN
F 3 "~" H 5950 5500 50  0001 C CNN
	1    5750 5500
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 5500 4800 5500
$Comp
L Connector:TestPoint TP14
U 1 1 60282CC7
P 5750 5600
F 0 "TP14" V 5750 6200 50  0000 L CNN
F 1 "TestPoint" V 5750 5800 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5600 50  0001 C CNN
F 3 "~" H 5950 5600 50  0001 C CNN
	1    5750 5600
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 5600 4800 5600
$Comp
L Connector:TestPoint TP15
U 1 1 60282CD2
P 5750 5700
F 0 "TP15" V 5750 6300 50  0000 L CNN
F 1 "TestPoint" V 5750 5900 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5700 50  0001 C CNN
F 3 "~" H 5950 5700 50  0001 C CNN
	1    5750 5700
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 5700 4800 5700
$Comp
L Connector:TestPoint TP18
U 1 1 6028A447
P 5750 6000
F 0 "TP18" V 5750 6600 50  0000 L CNN
F 1 "TestPoint" V 5750 6200 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 6000 50  0001 C CNN
F 3 "~" H 5950 6000 50  0001 C CNN
	1    5750 6000
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 6000 4800 6000
$Comp
L Connector:TestPoint TP19
U 1 1 6028A452
P 5750 6100
F 0 "TP19" V 5750 6700 50  0000 L CNN
F 1 "TestPoint" V 5750 6300 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 6100 50  0001 C CNN
F 3 "~" H 5950 6100 50  0001 C CNN
	1    5750 6100
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 6100 4800 6100
$Comp
L RF_Module:ESP32-WROOM-32 U1
U 1 1 60094C13
P 4200 5000
F 0 "U1" H 4200 6700 50  0000 C CNN
F 1 "ESP32-WROOM-32" H 4200 6800 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 4200 3500 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32_datasheet_en.pdf" H 3900 5050 50  0001 C CNN
	1    4200 5000
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP7
U 1 1 602C4207
P 5750 4000
F 0 "TP7" V 5750 4600 50  0000 L CNN
F 1 "TestPoint" V 5750 4200 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4000 50  0001 C CNN
F 3 "~" H 5950 4000 50  0001 C CNN
	1    5750 4000
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4000 4800 4000
$Comp
L Connector:TestPoint TP8
U 1 1 602CC0FB
P 5750 4200
F 0 "TP8" V 5750 4800 50  0000 L CNN
F 1 "TestPoint" V 5750 4400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4200 50  0001 C CNN
F 3 "~" H 5950 4200 50  0001 C CNN
	1    5750 4200
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 4200 4800 4200
Wire Wire Line
	13450 6300 13900 6300
NoConn ~ 13650 6800
$Comp
L custom_symbols:MS8607-02BA U3
U 1 1 60333A79
P 14400 2100
F 0 "U3" H 14730 2146 50  0000 L CNN
F 1 "MS8607-02BA" H 14730 2055 50  0000 L CNN
F 2 "Package_LGA:LGA-8_3x5mm_P1.25mm" H 14400 2100 50  0001 C CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS8607-02BA01%7FB3%7Fpdf%7FEnglish%7FENG_DS_MS8607-02BA01_B3.pdf%7FCAT-BLPS0018" H 14400 2100 50  0001 C CNN
	1    14400 2100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP20
U 1 1 603578CE
P 11850 2100
F 0 "TP20" V 11850 2700 50  0000 L CNN
F 1 "TestPoint" V 11850 2300 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 12050 2100 50  0001 C CNN
F 3 "~" H 12050 2100 50  0001 C CNN
	1    11850 2100
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP21
U 1 1 603578D9
P 11850 2200
F 0 "TP21" V 11850 2800 50  0000 L CNN
F 1 "TestPoint" V 11850 2400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 12050 2200 50  0001 C CNN
F 3 "~" H 12050 2200 50  0001 C CNN
	1    11850 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	8500 1400 7750 1400
Text Label 7750 1300 0    50   ~ 0
Motor_pulse_A
Wire Wire Line
	8500 1300 7750 1300
Text Label 7750 1400 0    50   ~ 0
Motor_pulse_B
Text Notes 11850 9200 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
Text Notes 1150 10600 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
$Comp
L Diode:BAT54C D3
U 1 1 601A08A3
P 6400 8750
F 0 "D3" H 6400 8975 50  0000 C CNN
F 1 "BAT54C" H 6400 8884 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6475 8875 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 6320 8750 50  0001 C CNN
	1    6400 8750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 8750 6100 8750
$Comp
L power:VBUS #PWR028
U 1 1 601C526F
P 6700 8550
F 0 "#PWR028" H 6700 8400 50  0001 C CNN
F 1 "VBUS" H 6715 8723 50  0000 C CNN
F 2 "" H 6700 8550 50  0001 C CNN
F 3 "" H 6700 8550 50  0001 C CNN
	1    6700 8550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 8550 6700 8750
Wire Wire Line
	6050 8550 6050 8750
Wire Notes Line
	5800 7900 5800 10300
Wire Notes Line
	8900 7900 8900 10300
Wire Wire Line
	9950 7600 9950 8000
Wire Wire Line
	9650 7600 9650 8000
Text Label 9950 8000 1    50   ~ 0
SCL1
Text Label 9650 8000 1    50   ~ 0
SDA1
$Comp
L Device:R R7
U 1 1 6016D596
P 9650 7450
F 0 "R7" H 9720 7496 50  0000 L CNN
F 1 "4.7k" H 9720 7405 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9580 7450 50  0001 C CNN
F 3 "~" H 9650 7450 50  0001 C CNN
	1    9650 7450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 6016E102
P 9950 7450
F 0 "R8" H 10020 7496 50  0000 L CNN
F 1 "4.7k" H 10020 7405 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9880 7450 50  0001 C CNN
F 3 "~" H 9950 7450 50  0001 C CNN
	1    9950 7450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR040
U 1 1 6017645E
P 9800 7000
F 0 "#PWR040" H 9800 6850 50  0001 C CNN
F 1 "+3.3V" H 9815 7173 50  0000 C CNN
F 2 "" H 9800 7000 50  0001 C CNN
F 3 "" H 9800 7000 50  0001 C CNN
	1    9800 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 7300 9650 7000
Wire Wire Line
	9650 7000 9800 7000
Wire Wire Line
	9800 7000 9950 7000
Wire Wire Line
	9950 7000 9950 7300
Connection ~ 9800 7000
Wire Notes Line
	9250 8750 10250 8750
Wire Notes Line
	10250 6650 9250 6650
Text Notes 9350 6750 0    50   ~ 0
Pullup I2C1
Text Label 5050 5900 2    50   ~ 0
SDA2
Text Label 5050 5800 2    50   ~ 0
SCL2
Wire Wire Line
	9950 9700 9950 10100
Wire Wire Line
	9650 9700 9650 10100
Text Label 9950 10100 1    50   ~ 0
SCL2
Text Label 9650 10100 1    50   ~ 0
SDA2
$Comp
L Device:R R9
U 1 1 601C8D39
P 9650 9550
F 0 "R9" H 9720 9596 50  0000 L CNN
F 1 "4.7k" H 9720 9505 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9580 9550 50  0001 C CNN
F 3 "~" H 9650 9550 50  0001 C CNN
	1    9650 9550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 601C8D43
P 9950 9550
F 0 "R10" H 10020 9596 50  0000 L CNN
F 1 "4.7k" H 10020 9505 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9880 9550 50  0001 C CNN
F 3 "~" H 9950 9550 50  0001 C CNN
	1    9950 9550
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR041
U 1 1 601C8D4D
P 9800 9100
F 0 "#PWR041" H 9800 8950 50  0001 C CNN
F 1 "+3.3V" H 9815 9273 50  0000 C CNN
F 2 "" H 9800 9100 50  0001 C CNN
F 3 "" H 9800 9100 50  0001 C CNN
	1    9800 9100
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 9400 9650 9100
Wire Wire Line
	9650 9100 9800 9100
Wire Wire Line
	9800 9100 9950 9100
Wire Wire Line
	9950 9100 9950 9400
Connection ~ 9800 9100
Wire Notes Line
	9250 10950 10250 10950
Text Notes 9350 8850 0    50   ~ 0
Pullup I2C2
Wire Notes Line
	9250 6650 9250 10950
Wire Notes Line
	10250 6650 10250 10950
Wire Wire Line
	4800 5800 5750 5800
Wire Wire Line
	4800 5900 5750 5900
$Comp
L Connector:TestPoint TP23
U 1 1 601F2F60
P 5750 5100
F 0 "TP23" V 5750 5700 50  0000 L CNN
F 1 "TestPoint" V 5750 5300 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5100 50  0001 C CNN
F 3 "~" H 5950 5100 50  0001 C CNN
	1    5750 5100
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP22
U 1 1 601F2F56
P 5750 5000
F 0 "TP22" V 5750 5600 50  0000 L CNN
F 1 "TestPoint" V 5750 5200 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5000 50  0001 C CNN
F 3 "~" H 5950 5000 50  0001 C CNN
	1    5750 5000
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP26
U 1 1 60224D56
P 5750 5400
F 0 "TP26" V 5750 6000 50  0000 L CNN
F 1 "TestPoint" V 5750 5600 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5400 50  0001 C CNN
F 3 "~" H 5950 5400 50  0001 C CNN
	1    5750 5400
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP31
U 1 1 6022E192
P 5750 4300
F 0 "TP31" V 5750 4900 50  0000 L CNN
F 1 "TestPoint" V 5750 4500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4300 50  0001 C CNN
F 3 "~" H 5950 4300 50  0001 C CNN
	1    5750 4300
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP17
U 1 1 6022E70B
P 5750 4900
F 0 "TP17" V 5750 5500 50  0000 L CNN
F 1 "TestPoint" V 5750 5100 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4900 50  0001 C CNN
F 3 "~" H 5950 4900 50  0001 C CNN
	1    5750 4900
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP16
U 1 1 6022E715
P 5750 4800
F 0 "TP16" V 5750 5400 50  0000 L CNN
F 1 "TestPoint" V 5750 5000 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4800 50  0001 C CNN
F 3 "~" H 5950 4800 50  0001 C CNN
	1    5750 4800
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP28
U 1 1 60237D56
P 5750 5900
F 0 "TP28" V 5750 6500 50  0000 L CNN
F 1 "TestPoint" V 5750 6100 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5900 50  0001 C CNN
F 3 "~" H 5950 5900 50  0001 C CNN
	1    5750 5900
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP27
U 1 1 60237D60
P 5750 5800
F 0 "TP27" V 5750 6400 50  0000 L CNN
F 1 "TestPoint" V 5750 6000 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5800 50  0001 C CNN
F 3 "~" H 5950 5800 50  0001 C CNN
	1    5750 5800
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP25
U 1 1 60254B67
P 5750 5300
F 0 "TP25" V 5750 5900 50  0000 L CNN
F 1 "TestPoint" V 5750 5500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5300 50  0001 C CNN
F 3 "~" H 5950 5300 50  0001 C CNN
	1    5750 5300
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP24
U 1 1 60254B71
P 5750 5200
F 0 "TP24" V 5750 5800 50  0000 L CNN
F 1 "TestPoint" V 5750 5400 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 5200 50  0001 C CNN
F 3 "~" H 5950 5200 50  0001 C CNN
	1    5750 5200
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP30
U 1 1 602705B5
P 5750 4100
F 0 "TP30" V 5750 4700 50  0000 L CNN
F 1 "TestPoint" V 5750 4300 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 4100 50  0001 C CNN
F 3 "~" H 5950 4100 50  0001 C CNN
	1    5750 4100
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP29
U 1 1 602705BF
P 5750 3900
F 0 "TP29" V 5750 4500 50  0000 L CNN
F 1 "TestPoint" V 5750 4100 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5950 3900 50  0001 C CNN
F 3 "~" H 5950 3900 50  0001 C CNN
	1    5750 3900
	0    1    1    0   
$EndComp
Wire Notes Line
	9950 3750 15650 3750
Wire Notes Line
	9950 800  9950 3750
$Comp
L Connector:TestPoint TP33
U 1 1 602C04FD
P 12200 7350
F 0 "TP33" V 12200 7950 50  0000 L CNN
F 1 "TestPoint" V 12200 7550 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 12400 7350 50  0001 C CNN
F 3 "~" H 12400 7350 50  0001 C CNN
	1    12200 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	12200 7350 12200 7600
$Comp
L Connector:TestPoint TP34
U 1 1 602C0508
P 12300 7350
F 0 "TP34" V 12300 7950 50  0000 L CNN
F 1 "TestPoint" V 12300 7550 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 12500 7350 50  0001 C CNN
F 3 "~" H 12500 7350 50  0001 C CNN
	1    12300 7350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP32
U 1 1 602C9A17
P 10550 6950
F 0 "TP32" V 10550 7550 50  0000 L CNN
F 1 "TestPoint" V 10550 7150 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 10750 6950 50  0001 C CNN
F 3 "~" H 10750 6950 50  0001 C CNN
	1    10550 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	10550 6950 10550 7200
Wire Wire Line
	12300 7350 12300 7700
Connection ~ 12200 7600
Wire Wire Line
	12200 7600 12150 7600
$Comp
L power:GND #PWR030
U 1 1 602443BD
P 11400 7300
F 0 "#PWR030" H 11400 7050 50  0001 C CNN
F 1 "GND" H 11405 7127 50  0000 C CNN
F 2 "" H 11400 7300 50  0001 C CNN
F 3 "" H 11400 7300 50  0001 C CNN
	1    11400 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	11400 7100 11400 7300
Wire Wire Line
	11850 7100 11400 7100
$Comp
L Connector:USB_B_Micro J3
U 1 1 600ED098
P 11850 7700
F 0 "J3" H 11620 7597 50  0000 R CNN
F 1 "USB_B_Micro" H 11620 7688 50  0000 R CNN
F 2 "Connector_USB:USB_Micro-B_Molex-105017-0001" H 12000 7650 50  0001 C CNN
F 3 "~" H 12000 7650 50  0001 C CNN
	1    11850 7700
	1    0    0    1   
$EndComp
Wire Wire Line
	12150 7700 12300 7700
Connection ~ 11850 7300
Wire Wire Line
	12150 8100 12450 8100
NoConn ~ 12150 7500
Wire Wire Line
	12150 7900 12150 8100
Wire Wire Line
	11850 7300 11850 7100
Wire Wire Line
	11750 7300 11850 7300
Connection ~ 12300 7700
Wire Wire Line
	12200 7600 12750 7600
Wire Wire Line
	12300 7700 12750 7700
Wire Wire Line
	4800 3900 5750 3900
$Sheet
S 7650 4200 550  200 
U 6035EFCE
F0 "button_up" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 8200 4300 50 
$EndSheet
$Sheet
S 7650 4650 550  200 
U 6036C998
F0 "button_down" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 8200 4750 50 
$EndSheet
$Sheet
S 7650 5050 550  200 
U 60374312
F0 "button_select" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 8200 5150 50 
$EndSheet
$Sheet
S 7650 5450 550  200 
U 6037BC78
F0 "button_extra" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 8200 5550 50 
$EndSheet
Wire Notes Line
	7450 3800 7450 6000
Wire Notes Line
	7450 6000 9300 6000
Wire Notes Line
	9300 6000 9300 3750
Wire Notes Line
	9300 3750 7450 3750
Text Notes 7550 3900 0    50   ~ 0
Buttons for interface
NoConn ~ 3600 5000
NoConn ~ 3600 5100
NoConn ~ 3600 5200
NoConn ~ 3600 5300
NoConn ~ 3600 5400
NoConn ~ 3600 5500
Text Notes 2500 4950 0    50   ~ 0
Connected internally to flash.\nNot recommended for use.
Text Label 8350 4300 0    50   ~ 0
button_up
Wire Wire Line
	8350 4300 8200 4300
Text Label 8350 4750 0    50   ~ 0
button_down
Wire Wire Line
	8200 4750 8350 4750
Text Label 8350 5150 0    50   ~ 0
button_select
Wire Wire Line
	8350 5150 8200 5150
Text Label 8350 5550 0    50   ~ 0
button_extra
Wire Wire Line
	8200 5550 8350 5550
Text Notes 750  4900 0    50   ~ 0
Motor monitoring
$Sheet
S 750  5050 900  300 
U 6040F615
F0 "sheet6040F615" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1650 5250 50 
F3 "protected_adc_input" I R 1650 5150 50 
$EndSheet
Text Label 2200 5150 2    50   ~ 0
Motor_B_adc
Wire Wire Line
	2200 5150 1650 5150
Wire Wire Line
	1650 5250 2200 5250
Text Label 2200 5250 2    50   ~ 0
Motor_pulse_B
$Sheet
S 750  5700 900  300 
U 6042797A
F0 "sheet6042797A" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1650 5900 50 
F3 "protected_adc_input" I R 1650 5800 50 
$EndSheet
Text Label 2200 5800 2    50   ~ 0
Motor_A_adc
Wire Wire Line
	2200 5800 1650 5800
Wire Wire Line
	1650 5900 2200 5900
Text Label 2200 5900 2    50   ~ 0
Motor_pulse_A
Text Label 5000 6000 0    50   ~ 0
Motor_B_adc
Text Label 5000 6100 0    50   ~ 0
Motor_A_adc
Wire Wire Line
	8500 1200 7750 1200
Text Label 7750 1100 0    50   ~ 0
misc_adc_raw_1
Wire Wire Line
	8500 1100 7750 1100
Text Label 7750 1200 0    50   ~ 0
misc_adc_raw_2
Wire Notes Line
	600  6250 2300 6250
Text Label 2250 6800 2    50   ~ 0
misc_adc_raw_1
Wire Wire Line
	1550 6800 2250 6800
Wire Wire Line
	2250 6700 1550 6700
$Sheet
S 650  6600 900  300 
U 60465E6A
F0 "sheet60465E6A" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1550 6800 50 
F3 "protected_adc_input" I R 1550 6700 50 
$EndSheet
Text Label 2250 6700 2    50   ~ 0
misc_adc_1
Text Label 5700 5800 2    50   ~ 0
misc_adc_1
Text Label 5700 5900 2    50   ~ 0
misc_adc_2
Text Notes 9350 10550 0    50   ~ 0
Must not be \npopulated if I2C2\npins are used as ADC
Text Label 2250 7400 2    50   ~ 0
misc_adc_raw_2
Wire Wire Line
	1550 7400 2250 7400
Wire Wire Line
	2250 7300 1550 7300
Text Label 2250 7300 2    50   ~ 0
misc_adc_2
$Sheet
S 650  7200 900  300 
U 6049D147
F0 "sheet6049D147" 50
F1 "ADC_input_protected.sch" 50
F2 "raw_adc_input" I R 1550 7400 50 
F3 "protected_adc_input" I R 1550 7300 50 
$EndSheet
Text Notes 700  6350 0    50   ~ 0
Misc ADC inputs
Wire Notes Line
	600  7700 2300 7700
Wire Notes Line
	2300 2800 2300 7700
Wire Notes Line
	600  2800 600  7700
Text Label 5000 5400 0    50   ~ 0
button_up
Text Label 5000 5500 0    50   ~ 0
button_down
Text Label 5000 5600 0    50   ~ 0
button_select
Text Label 5000 5700 0    50   ~ 0
button_extra
$EndSCHEMATC
