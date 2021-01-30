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
P 7350 1650
F 0 "J2" H 7430 1642 50  0000 L CNN
F 1 "Conn_01x08" H 7430 1551 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4_1x04_P5.00mm_Horizontal" H 7350 1650 50  0001 C CNN
F 3 "~" H 7350 1650 50  0001 C CNN
	1    7350 1650
	1    0    0    -1  
$EndComp
Text Label 6400 2050 0    50   ~ 0
Throttle
Wire Wire Line
	7150 2050 6400 2050
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
P 14600 6300
F 0 "#PWR012" H 14600 6150 50  0001 C CNN
F 1 "+3.3V" H 14615 6473 50  0000 C CNN
F 2 "" H 14600 6300 50  0001 C CNN
F 3 "" H 14600 6300 50  0001 C CNN
	1    14600 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	14600 6300 14600 6450
$Comp
L power:GND #PWR013
U 1 1 600E9DF7
P 14850 9000
F 0 "#PWR013" H 14850 8750 50  0001 C CNN
F 1 "GND" H 14855 8827 50  0000 C CNN
F 2 "" H 14850 9000 50  0001 C CNN
F 3 "" H 14850 9000 50  0001 C CNN
	1    14850 9000
	1    0    0    -1  
$EndComp
Wire Wire Line
	14850 9000 14850 8950
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
	15500 7750 15950 7750
Text Label 15950 7850 2    50   ~ 0
RX0
Wire Wire Line
	15500 7850 15950 7850
Text Label 15950 7750 2    50   ~ 0
TX0
$Comp
L Device:C C4
U 1 1 6012D893
P 15250 6600
F 0 "C4" H 15135 6554 50  0000 R CNN
F 1 "10uF" H 15135 6645 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 15288 6450 50  0001 C CNN
F 3 "~" H 15250 6600 50  0001 C CNN
	1    15250 6600
	-1   0    0    1   
$EndComp
Wire Wire Line
	14600 6450 14800 6450
$Comp
L power:GND #PWR020
U 1 1 601334EB
P 15250 6750
F 0 "#PWR020" H 15250 6500 50  0001 C CNN
F 1 "GND" H 15255 6577 50  0000 C CNN
F 2 "" H 15250 6750 50  0001 C CNN
F 3 "" H 15250 6750 50  0001 C CNN
	1    15250 6750
	1    0    0    -1  
$EndComp
Text Notes 12600 6250 0    50   ~ 0
USB to UART
Wire Notes Line
	9650 2650 9650 600 
Text Notes 6300 800  0    50   ~ 0
Generic and ADC inputs
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
Text Label 6400 1950 0    50   ~ 0
PAS
Wire Wire Line
	7150 1950 6400 1950
Wire Wire Line
	14800 8850 14800 8950
Wire Wire Line
	14800 8950 14850 8950
Wire Wire Line
	14900 8950 14900 8850
Connection ~ 14850 8950
Wire Wire Line
	14850 8950 14900 8950
Wire Wire Line
	14600 6450 14600 6950
Connection ~ 14600 6450
Wire Wire Line
	14800 6950 14800 6450
Connection ~ 14800 6450
$Comp
L power:VBUS #PWR09
U 1 1 60130B9C
P 13900 7350
F 0 "#PWR09" H 13900 7200 50  0001 C CNN
F 1 "VBUS" H 13915 7523 50  0000 C CNN
F 2 "" H 13900 7350 50  0001 C CNN
F 3 "" H 13900 7350 50  0001 C CNN
	1    13900 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	13900 7450 13900 7350
NoConn ~ 14100 8050
NoConn ~ 14100 8150
NoConn ~ 14100 8250
NoConn ~ 14100 8350
NoConn ~ 14100 8550
NoConn ~ 15500 8550
NoConn ~ 15500 8450
NoConn ~ 15500 8350
NoConn ~ 15500 8150
NoConn ~ 15500 7250
NoConn ~ 15500 7350
NoConn ~ 15500 7550
Wire Wire Line
	14100 7250 14100 6450
Wire Wire Line
	14100 6450 14600 6450
$Comp
L Transistor_BJT:MMBT5551L Q1
U 1 1 60150D6F
P 11600 7400
F 0 "Q1" H 11791 7446 50  0000 L CNN
F 1 "MMBT5551L" H 11791 7355 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 11800 7325 50  0001 L CIN
F 3 "www.onsemi.com/pub/Collateral/MMBT5550LT1-D.PDF" H 11600 7400 50  0001 L CNN
F 4 "5" H 11600 7400 50  0001 C CNN "min_qty"
F 5 "0.165" H 11600 7400 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/on-semiconductor/mmbt5551lt1g/transistor-npn-sot-23/dp/1459109?st=mmbt5551l" H 11600 7400 50  0001 C CNN "purchase_link"
	1    11600 7400
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:MMBT5551L Q2
U 1 1 60151B9F
P 11600 8000
F 0 "Q2" H 11791 7954 50  0000 L CNN
F 1 "MMBT5551L" H 11791 8045 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 11800 7925 50  0001 L CIN
F 3 "www.onsemi.com/pub/Collateral/MMBT5550LT1-D.PDF" H 11600 8000 50  0001 L CNN
F 4 "5" H 11600 8000 50  0001 C CNN "min_qty"
F 5 "0.165" H 11600 8000 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/on-semiconductor/mmbt5551lt1g/transistor-npn-sot-23/dp/1459109?st=mmbt5551l" H 11600 8000 50  0001 C CNN "purchase_link"
	1    11600 8000
	1    0    0    1   
$EndComp
Wire Wire Line
	11700 8200 11700 8350
Wire Wire Line
	11700 8350 12250 8350
Wire Wire Line
	11700 7200 11700 7000
Wire Wire Line
	11700 7000 12250 7000
Wire Wire Line
	11700 7600 11100 7600
Wire Wire Line
	11100 7600 11100 8000
$Comp
L Device:R R4
U 1 1 601657EE
P 11250 8000
F 0 "R4" V 11043 8000 50  0000 C CNN
F 1 "10k" V 11134 8000 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 11180 8000 50  0001 C CNN
F 3 "~" H 11250 8000 50  0001 C CNN
	1    11250 8000
	0    1    1    0   
$EndComp
Connection ~ 11100 8000
Wire Wire Line
	11100 8000 11100 8350
$Comp
L Device:R R3
U 1 1 601663DB
P 11250 7400
F 0 "R3" V 11043 7400 50  0000 C CNN
F 1 "10k" V 11134 7400 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 11180 7400 50  0001 C CNN
F 3 "~" H 11250 7400 50  0001 C CNN
	1    11250 7400
	0    1    1    0   
$EndComp
Wire Wire Line
	11700 7800 11700 7750
Wire Wire Line
	11700 7750 10900 7750
Wire Wire Line
	10900 7750 10900 7400
Wire Wire Line
	10900 7400 11100 7400
Wire Wire Line
	10900 7400 10900 6950
Connection ~ 10900 7400
Wire Wire Line
	4800 3800 5250 3800
Text Label 10900 6950 3    50   ~ 0
RTS
Text Label 15950 8050 2    50   ~ 0
RTS
Wire Wire Line
	15500 8050 15950 8050
Text Label 12250 7000 2    50   ~ 0
GPIO0
Text Label 5250 3800 2    50   ~ 0
GPIO0
Text Label 12250 8350 2    50   ~ 0
RESET
Text Label 11100 8350 1    50   ~ 0
DTR
Text Label 2850 3800 0    50   ~ 0
RESET
Wire Wire Line
	2850 3800 3600 3800
Text Label 15950 7450 2    50   ~ 0
DTR
Wire Wire Line
	15500 7450 15950 7450
Text Notes 10550 6600 0    50   ~ 0
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
	14100 7450 13900 7450
$Comp
L Interface_USB:CP2104 U5
U 1 1 600F44E2
P 14800 7850
F 0 "U5" H 14050 6550 50  0000 C CNN
F 1 "CP2104" H 14050 6750 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 14950 6900 50  0001 L CNN
F 3 "https://www.silabs.com/documents/public/data-sheets/cp2104.pdf" H 14250 9100 50  0001 C CNN
	1    14800 7850
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR08
U 1 1 60133918
P 13800 8250
F 0 "#PWR08" H 13800 8100 50  0001 C CNN
F 1 "VBUS" H 13815 8423 50  0000 C CNN
F 2 "" H 13800 8250 50  0001 C CNN
F 3 "" H 13800 8250 50  0001 C CNN
	1    13800 8250
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
P 4550 1600
F 0 "J5" H 4468 1175 50  0000 C CNN
F 1 "Conn_01x05" H 4468 1266 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4_1x04_P5.00mm_Horizontal" H 4550 1600 50  0001 C CNN
F 3 "~" H 4550 1600 50  0001 C CNN
	1    4550 1600
	-1   0    0    1   
$EndComp
Text Notes 8150 800  0    50   ~ 0
I2C OLED display Connector
Text Notes 4100 800  0    50   ~ 0
U-blox GPS module connector
Text Label 5150 1500 2    50   ~ 0
GPS_RX
Text Label 5150 1600 2    50   ~ 0
GPS_TX
Wire Wire Line
	4750 1500 5150 1500
Wire Wire Line
	4750 1600 5150 1600
$Comp
L power:+3.3V #PWR033
U 1 1 6013BDFD
P 5100 1300
F 0 "#PWR033" H 5100 1150 50  0001 C CNN
F 1 "+3.3V" H 5115 1473 50  0000 C CNN
F 2 "" H 5100 1300 50  0001 C CNN
F 3 "" H 5100 1300 50  0001 C CNN
	1    5100 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 1400 5100 1400
Wire Wire Line
	5100 1400 5100 1300
$Comp
L power:GND #PWR034
U 1 1 6013BE09
P 5100 1950
F 0 "#PWR034" H 5100 1700 50  0001 C CNN
F 1 "GND" H 5105 1777 50  0000 C CNN
F 2 "" H 5100 1950 50  0001 C CNN
F 3 "" H 5100 1950 50  0001 C CNN
	1    5100 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4750 1800 5100 1800
Wire Wire Line
	5100 1800 5100 1950
Text Label 5150 1700 2    50   ~ 0
PPS
Wire Wire Line
	4750 1700 5150 1700
Text Label 5200 4900 2    50   ~ 0
GPS_RX
Text Label 5200 4800 2    50   ~ 0
GPS_TX
Wire Wire Line
	4800 4900 5750 4900
Wire Wire Line
	4800 4800 5750 4800
Wire Wire Line
	8850 1300 9000 1300
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
	14800 6450 15250 6450
NoConn ~ 15000 6950
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
	7150 1850 6400 1850
Text Label 6400 1750 0    50   ~ 0
Motor_pulse_A
Wire Wire Line
	7150 1750 6400 1750
Text Label 6400 1850 0    50   ~ 0
Motor_pulse_B
Text Notes 13200 9350 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
Text Notes 10550 8700 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
Wire Wire Line
	7900 6800 7900 7200
Wire Wire Line
	7600 6800 7600 7200
Text Label 7900 7200 1    50   ~ 0
SCL1
Text Label 7600 7200 1    50   ~ 0
SDA1
$Comp
L Device:R R7
U 1 1 6016D596
P 7600 6650
F 0 "R7" H 7670 6696 50  0000 L CNN
F 1 "4.7k" H 7670 6605 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7530 6650 50  0001 C CNN
F 3 "~" H 7600 6650 50  0001 C CNN
	1    7600 6650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 6016E102
P 7900 6650
F 0 "R8" H 7970 6696 50  0000 L CNN
F 1 "4.7k" H 7970 6605 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7830 6650 50  0001 C CNN
F 3 "~" H 7900 6650 50  0001 C CNN
	1    7900 6650
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR040
U 1 1 6017645E
P 7750 6200
F 0 "#PWR040" H 7750 6050 50  0001 C CNN
F 1 "+3.3V" H 7765 6373 50  0000 C CNN
F 2 "" H 7750 6200 50  0001 C CNN
F 3 "" H 7750 6200 50  0001 C CNN
	1    7750 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 6500 7600 6200
Wire Wire Line
	7600 6200 7750 6200
Wire Wire Line
	7750 6200 7900 6200
Wire Wire Line
	7900 6200 7900 6500
Connection ~ 7750 6200
Wire Notes Line
	7200 7950 8200 7950
Wire Notes Line
	8200 5850 7200 5850
Text Notes 7300 5950 0    50   ~ 0
Pullup I2C1
Text Label 5050 5900 2    50   ~ 0
SDA2
Text Label 5050 5800 2    50   ~ 0
SCL2
Wire Wire Line
	7900 8900 7900 9300
Wire Wire Line
	7600 8900 7600 9300
Text Label 7900 9300 1    50   ~ 0
SCL2
Text Label 7600 9300 1    50   ~ 0
SDA2
$Comp
L Device:R R9
U 1 1 601C8D39
P 7600 8750
F 0 "R9" H 7670 8796 50  0000 L CNN
F 1 "4.7k" H 7670 8705 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7530 8750 50  0001 C CNN
F 3 "~" H 7600 8750 50  0001 C CNN
	1    7600 8750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 601C8D43
P 7900 8750
F 0 "R10" H 7970 8796 50  0000 L CNN
F 1 "4.7k" H 7970 8705 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7830 8750 50  0001 C CNN
F 3 "~" H 7900 8750 50  0001 C CNN
	1    7900 8750
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR041
U 1 1 601C8D4D
P 7750 8300
F 0 "#PWR041" H 7750 8150 50  0001 C CNN
F 1 "+3.3V" H 7765 8473 50  0000 C CNN
F 2 "" H 7750 8300 50  0001 C CNN
F 3 "" H 7750 8300 50  0001 C CNN
	1    7750 8300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 8600 7600 8300
Wire Wire Line
	7600 8300 7750 8300
Wire Wire Line
	7750 8300 7900 8300
Wire Wire Line
	7900 8300 7900 8600
Connection ~ 7750 8300
Wire Notes Line
	7200 10150 8200 10150
Text Notes 7300 8050 0    50   ~ 0
Pullup I2C2
Wire Notes Line
	7200 5850 7200 10150
Wire Notes Line
	8200 5850 8200 10150
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
P 13550 7500
F 0 "TP33" V 13550 8100 50  0000 L CNN
F 1 "TestPoint" V 13550 7700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 13750 7500 50  0001 C CNN
F 3 "~" H 13750 7500 50  0001 C CNN
	1    13550 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	13550 7500 13550 7750
$Comp
L Connector:TestPoint TP34
U 1 1 602C0508
P 13650 7500
F 0 "TP34" V 13650 8100 50  0000 L CNN
F 1 "TestPoint" V 13650 7700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 13850 7500 50  0001 C CNN
F 3 "~" H 13850 7500 50  0001 C CNN
	1    13650 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	13650 7500 13650 7850
Connection ~ 13550 7750
Wire Wire Line
	13550 7750 13500 7750
$Comp
L power:GND #PWR030
U 1 1 602443BD
P 12750 7450
F 0 "#PWR030" H 12750 7200 50  0001 C CNN
F 1 "GND" H 12755 7277 50  0000 C CNN
F 2 "" H 12750 7450 50  0001 C CNN
F 3 "" H 12750 7450 50  0001 C CNN
	1    12750 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	12750 7250 12750 7450
Wire Wire Line
	13200 7250 12750 7250
$Comp
L Connector:USB_B_Micro J3
U 1 1 600ED098
P 13200 7850
F 0 "J3" H 12970 7747 50  0000 R CNN
F 1 "USB_B_Micro" H 12970 7838 50  0000 R CNN
F 2 "Connector_USB:USB_Micro-B_Molex-105017-0001" H 13350 7800 50  0001 C CNN
F 3 "~" H 13350 7800 50  0001 C CNN
	1    13200 7850
	1    0    0    1   
$EndComp
Wire Wire Line
	13500 7850 13650 7850
Connection ~ 13200 7450
Wire Wire Line
	13500 8250 13800 8250
NoConn ~ 13500 7650
Wire Wire Line
	13500 8050 13500 8250
Wire Wire Line
	13200 7450 13200 7250
Wire Wire Line
	13100 7450 13200 7450
Connection ~ 13650 7850
Wire Wire Line
	13550 7750 14100 7750
Wire Wire Line
	13650 7850 14100 7850
Wire Wire Line
	4800 3900 5750 3900
$Sheet
S 7400 3300 550  200 
U 6035EFCE
F0 "button_up" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 7950 3400 50 
$EndSheet
$Sheet
S 7400 3750 550  200 
U 6036C998
F0 "button_down" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 7950 3850 50 
$EndSheet
$Sheet
S 7400 4150 550  200 
U 60374312
F0 "button_select" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 7950 4250 50 
$EndSheet
$Sheet
S 7400 4550 550  200 
U 6037BC78
F0 "button_extra" 50
F1 "pulled_up_button.sch" 50
F2 "pin_value" I R 7950 4650 50 
$EndSheet
Wire Notes Line
	7200 2900 7200 5100
Wire Notes Line
	7200 5100 9050 5100
Wire Notes Line
	9050 5100 9050 2850
Wire Notes Line
	9050 2850 7200 2850
Text Notes 7300 3000 0    50   ~ 0
Buttons for interface
NoConn ~ 3600 5000
NoConn ~ 3600 5100
NoConn ~ 3600 5200
NoConn ~ 3600 5300
NoConn ~ 3600 5400
NoConn ~ 3600 5500
Text Notes 2500 4950 0    50   ~ 0
Connected internally to flash.\nNot recommended for use.
Text Label 8100 3400 0    50   ~ 0
button_up
Wire Wire Line
	8100 3400 7950 3400
Text Label 8100 3850 0    50   ~ 0
button_down
Wire Wire Line
	7950 3850 8100 3850
Text Label 8100 4250 0    50   ~ 0
button_select
Wire Wire Line
	8100 4250 7950 4250
Text Label 8100 4650 0    50   ~ 0
button_extra
Wire Wire Line
	7950 4650 8100 4650
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
	7150 1650 6400 1650
Text Label 6400 1550 0    50   ~ 0
misc_adc_raw_1
Wire Wire Line
	7150 1550 6400 1550
Text Label 6400 1650 0    50   ~ 0
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
Text Notes 7300 9750 0    50   ~ 0
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
Wire Wire Line
	2650 12650 2750 12650
$Comp
L Connector:TestPoint TP1
U 1 1 6053DE3B
P 5150 1700
F 0 "TP1" V 5150 2300 50  0000 L CNN
F 1 "TestPoint" V 5150 1900 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 5350 1700 50  0001 C CNN
F 3 "~" H 5350 1700 50  0001 C CNN
	1    5150 1700
	0    1    1    0   
$EndComp
Wire Notes Line
	3950 2650 3950 600 
Wire Notes Line
	3950 2650 9650 2650
Wire Notes Line
	3950 600  9650 600 
Wire Notes Line
	6050 600  6050 2650
Wire Notes Line
	8050 600  8050 2650
Wire Wire Line
	8850 1950 9250 1950
Wire Wire Line
	9000 1300 9000 1750
Wire Wire Line
	8850 1400 8850 1300
Wire Wire Line
	8850 1750 9000 1750
$Comp
L power:GND #PWR032
U 1 1 6012326B
P 8850 1400
F 0 "#PWR032" H 8850 1150 50  0001 C CNN
F 1 "GND" H 8855 1227 50  0000 C CNN
F 2 "" H 8850 1400 50  0001 C CNN
F 3 "" H 8850 1400 50  0001 C CNN
	1    8850 1400
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9200 1850 9200 1750
Wire Wire Line
	8850 1850 9200 1850
$Comp
L power:+3.3V #PWR031
U 1 1 6011E472
P 9200 1750
F 0 "#PWR031" H 9200 1600 50  0001 C CNN
F 1 "+3.3V" H 9215 1923 50  0000 C CNN
F 2 "" H 9200 1750 50  0001 C CNN
F 3 "" H 9200 1750 50  0001 C CNN
	1    9200 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2050 9250 2050
Text Label 9250 2050 2    50   ~ 0
SCL1
Text Label 9250 1950 2    50   ~ 0
SDA1
$Comp
L Connector_Generic:Conn_01x04 J4
U 1 1 60109051
P 8650 1950
F 0 "J4" H 8850 1500 50  0000 C CNN
F 1 "Conn_01x04" H 8800 1600 50  0000 C CNN
F 2 "Connector:NS-Tech_Grove_1x04_P2mm_Vertical" H 8650 1950 50  0001 C CNN
F 3 "~" H 8650 1950 50  0001 C CNN
	1    8650 1950
	-1   0    0    1   
$EndComp
Text Notes 12750 700  0    50   ~ 0
Sensors
Text Notes 6550 550  0    50   ~ 0
Connectors
Wire Wire Line
	3850 8800 3850 9000
Wire Wire Line
	4500 8800 4500 9000
$Comp
L power:VBUS #PWR028
U 1 1 601C526F
P 4500 8800
F 0 "#PWR028" H 4500 8650 50  0001 C CNN
F 1 "VBUS" H 4515 8973 50  0000 C CNN
F 2 "" H 4500 8800 50  0001 C CNN
F 3 "" H 4500 8800 50  0001 C CNN
	1    4500 8800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 9000 3900 9000
$Comp
L Diode:BAT54C D3
U 1 1 601A08A3
P 4200 9000
F 0 "D3" H 4200 9225 50  0000 C CNN
F 1 "BAT54C" H 4200 9134 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 4275 9125 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 4120 9000 50  0001 C CNN
	1    4200 9000
	1    0    0    -1  
$EndComp
Text Notes 3700 8300 0    50   ~ 0
3.3V regulator that converts Vbatt(36-42V input) to 3.3V.
NoConn ~ 5750 9700
NoConn ~ 4650 9700
Wire Wire Line
	4200 9400 4650 9400
Connection ~ 4200 9400
Wire Wire Line
	4200 9400 4200 9950
Wire Wire Line
	3850 9550 4650 9550
Wire Wire Line
	4200 10250 4200 10300
$Comp
L Device:C C12
U 1 1 60187E4E
P 4200 10100
F 0 "C12" H 4085 10054 50  0000 R CNN
F 1 "10uF" H 4085 10145 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 4238 9950 50  0001 C CNN
F 3 "~" H 4200 10100 50  0001 C CNN
	1    4200 10100
	-1   0    0    1   
$EndComp
Connection ~ 3850 9550
$Comp
L Device:C C11
U 1 1 6018709B
P 3850 9700
F 0 "C11" H 3735 9654 50  0000 R CNN
F 1 "10uF" H 3735 9745 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3888 9550 50  0001 C CNN
F 3 "~" H 3850 9700 50  0001 C CNN
	1    3850 9700
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR038
U 1 1 60186C96
P 4200 10300
F 0 "#PWR038" H 4200 10050 50  0001 C CNN
F 1 "GND" H 4205 10127 50  0000 C CNN
F 2 "" H 4200 10300 50  0001 C CNN
F 3 "" H 4200 10300 50  0001 C CNN
	1    4200 10300
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 9850 3850 9950
$Comp
L power:GND #PWR036
U 1 1 6018051F
P 3850 9950
F 0 "#PWR036" H 3850 9700 50  0001 C CNN
F 1 "GND" H 3855 9777 50  0000 C CNN
F 2 "" H 3850 9950 50  0001 C CNN
F 3 "" H 3850 9950 50  0001 C CNN
	1    3850 9950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 9550 6200 9650
Connection ~ 6200 9550
Wire Wire Line
	5750 9550 6200 9550
Wire Wire Line
	6200 9400 6200 9550
Wire Wire Line
	5750 9400 6200 9400
$Comp
L power:GND #PWR039
U 1 1 6015C1A0
P 6200 9650
F 0 "#PWR039" H 6200 9400 50  0001 C CNN
F 1 "GND" H 6205 9477 50  0000 C CNN
F 2 "" H 6200 9650 50  0001 C CNN
F 3 "" H 6200 9650 50  0001 C CNN
	1    6200 9650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 9200 4200 9400
$Comp
L custom_symbols:VBATT #PWR037
U 1 1 6014B49A
P 3850 8800
F 0 "#PWR037" H 3850 8650 50  0001 C CNN
F 1 "VBATT" H 3865 8973 50  0000 C CNN
F 2 "" H 3850 8800 50  0001 C CNN
F 3 "" H 3850 8800 50  0001 C CNN
	1    3850 8800
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR035
U 1 1 601234F2
P 3850 9400
F 0 "#PWR035" H 3850 9250 50  0001 C CNN
F 1 "+3.3V" H 3865 9573 50  0000 C CNN
F 2 "" H 3850 9400 50  0001 C CNN
F 3 "" H 3850 9400 50  0001 C CNN
	1    3850 9400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 9550 3850 9400
$Comp
L custom_symbols:STH0548S3V3 U7
U 1 1 601216DB
P 5200 9150
F 0 "U7" H 5200 9215 50  0000 C CNN
F 1 "STH0548S3V3" H 5200 9124 50  0000 C CNN
F 2 "custom_footprints:STH0548S3V3" H 5200 9150 50  0001 C CNN
F 3 "" H 5200 9150 50  0001 C CNN
F 4 "1" H 5200 9150 50  0001 C CNN "min_qty"
F 5 "7.45" H 5200 9150 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/xp-power/sth0548s3v3/dc-dc-converter-3-3v-0-5a/dp/3212474" H 5200 9150 50  0001 C CNN "purchase_link"
	1    5200 9150
	1    0    0    -1  
$EndComp
Wire Notes Line
	6950 7850 6950 2800
Wire Notes Line
	2450 7850 6950 7850
Wire Notes Line
	15950 5900 15950 9500
Wire Notes Line
	15950 9500 10150 9500
Wire Notes Line
	10150 9500 10150 5900
Wire Notes Line
	12500 5900 12500 9500
Wire Notes Line
	10150 5900 15950 5900
Wire Notes Line
	3000 8050 6500 8050
Wire Notes Line
	6500 8050 6500 10900
Wire Notes Line
	6500 10900 3000 10900
Wire Notes Line
	3000 10900 3000 8050
$EndSCHEMATC
