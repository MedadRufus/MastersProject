EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 15
Title "E bike blackbox"
Date "2021-02-01"
Rev "v0.1"
Comp ""
Comment1 "Ref: https://randomnerdtutorials.com/esp32-adc-analog-read-arduino-ide/"
Comment2 "Based on design: https://www.pedelecforum.de/wiki/doku.php?id=elektrotechnik:forumscontroller"
Comment3 ""
Comment4 ""
$EndDescr
Text Label 7700 9600 0    50   ~ 0
SCL1
Text Label 7700 9500 0    50   ~ 0
SDA1
Text Label 5200 5200 2    50   ~ 0
SDA1
Text Label 5200 5300 2    50   ~ 0
SCL1
Wire Wire Line
	4800 5200 5750 5200
Wire Wire Line
	4800 5300 5750 5300
Text Label 1200 1650 0    50   ~ 0
SPI_CLK
Text Label 1200 1350 0    50   ~ 0
SPI_SD_CS
Text Label 1200 1450 0    50   ~ 0
MOSI
Text Label 1200 1850 0    50   ~ 0
MISO
Wire Wire Line
	4800 5000 5750 5000
Wire Wire Line
	4800 5100 5750 5100
Wire Wire Line
	4800 5400 5750 5400
Text Notes 4250 7050 0    50   ~ 0
Note: ADC2 pins cannot be used when Wi-Fi is used. \nADC2 pins are: GPIO 4, 0, 2, 15, 13, 12, 14, 27, 25, 26
Text Label 6450 2350 0    50   ~ 0
Throttle
Wire Wire Line
	7200 2350 6450 2350
Wire Wire Line
	3600 4100 2850 4100
Wire Wire Line
	3600 4000 2850 4000
Text Label 2850 4000 0    50   ~ 0
PAS_ADC
$Comp
L power:GND #PWR01
U 1 1 600A7F85
P 3400 2150
F 0 "#PWR01" H 3400 1900 50  0001 C CNN
F 1 "GND" H 3405 1977 50  0000 C CNN
F 2 "" H 3400 2150 50  0001 C CNN
F 3 "" H 3400 2150 50  0001 C CNN
	1    3400 2150
	1    0    0    -1  
$EndComp
Wire Notes Line
	9750 11150 9750 8150
Text Notes 7250 8350 0    50   ~ 0
Pressure/temperature/humidity
Wire Notes Line
	7050 8200 7050 11150
Wire Notes Line
	2450 2800 2450 7850
Wire Notes Line
	6950 2800 2450 2800
Text Notes 2550 3100 0    50   ~ 0
ESP32 processor and WIFI/bluetooth
Text Notes 1200 800  0    50   ~ 0
SD card Reader
Wire Notes Line
	500  650  500  2650
Wire Notes Line
	3700 2650 3700 650 
NoConn ~ 1700 1250
$Comp
L power:+3.3V #PWR012
U 1 1 600E8BB8
P 14550 6300
F 0 "#PWR012" H 14550 6150 50  0001 C CNN
F 1 "+3.3V" H 14565 6473 50  0000 C CNN
F 2 "" H 14550 6300 50  0001 C CNN
F 3 "" H 14550 6300 50  0001 C CNN
	1    14550 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	14550 6300 14550 6450
$Comp
L power:GND #PWR013
U 1 1 600E9DF7
P 14800 9000
F 0 "#PWR013" H 14800 8750 50  0001 C CNN
F 1 "GND" H 14805 8827 50  0000 C CNN
F 2 "" H 14800 9000 50  0001 C CNN
F 3 "" H 14800 9000 50  0001 C CNN
	1    14800 9000
	1    0    0    -1  
$EndComp
Wire Wire Line
	14800 9000 14800 8950
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
	15450 7750 15900 7750
Text Label 15900 7850 2    50   ~ 0
RX0
Wire Wire Line
	15450 7850 15900 7850
Text Label 15900 7750 2    50   ~ 0
TX0
$Comp
L Device:C C4
U 1 1 6012D893
P 15100 6600
F 0 "C4" H 14985 6554 50  0000 R CNN
F 1 "10uF" H 14985 6645 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 15138 6450 50  0001 C CNN
F 3 "~" H 15100 6600 50  0001 C CNN
F 4 "0.1644" H 15100 6600 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/kemet/c0603c106m9pactu/cap-10-f-6-3v-20-x5r-0603/dp/1288201?st=10uf%200603" H 15100 6600 50  0001 C CNN "purchase_link"
	1    15100 6600
	-1   0    0    1   
$EndComp
Wire Wire Line
	14550 6450 14750 6450
$Comp
L power:GND #PWR020
U 1 1 601334EB
P 15100 6750
F 0 "#PWR020" H 15100 6500 50  0001 C CNN
F 1 "GND" H 15105 6577 50  0000 C CNN
F 2 "" H 15100 6750 50  0001 C CNN
F 3 "" H 15100 6750 50  0001 C CNN
	1    15100 6750
	1    0    0    -1  
$EndComp
Text Notes 12550 6250 0    50   ~ 0
USB to UART
Wire Notes Line
	9650 2650 9650 600 
Text Notes 6450 1900 0    50   ~ 0
ADC inputs
Wire Wire Line
	8100 9600 7700 9600
Wire Wire Line
	8100 9500 7700 9500
$Comp
L power:GND #PWR016
U 1 1 600A9865
P 8500 9900
F 0 "#PWR016" H 8500 9650 50  0001 C CNN
F 1 "GND" H 8505 9727 50  0000 C CNN
F 2 "" H 8500 9900 50  0001 C CNN
F 3 "" H 8500 9900 50  0001 C CNN
	1    8500 9900
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR015
U 1 1 600AEB50
P 8500 8650
F 0 "#PWR015" H 8500 8500 50  0001 C CNN
F 1 "+3.3V" H 8515 8823 50  0000 C CNN
F 2 "" H 8500 8650 50  0001 C CNN
F 3 "" H 8500 8650 50  0001 C CNN
	1    8500 8650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 8650 8500 9100
Connection ~ 8500 8650
Wire Wire Line
	8750 8650 8500 8650
$Comp
L Device:C C5
U 1 1 6013D55A
P 8750 8800
F 0 "C5" H 8865 8846 50  0000 L CNN
F 1 "1uF" H 8865 8755 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 8788 8650 50  0001 C CNN
F 3 "~" H 8750 8800 50  0001 C CNN
F 4 "0.0902" H 8750 8800 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/06033d105kat2a/cap-1-f-25v-10-x5r-0603/dp/1658868?st=1uf%200603" H 8750 8800 50  0001 C CNN "purchase_link"
	1    8750 8800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR021
U 1 1 601415DC
P 8750 8950
F 0 "#PWR021" H 8750 8700 50  0001 C CNN
F 1 "GND" H 8755 8777 50  0000 C CNN
F 2 "" H 8750 8950 50  0001 C CNN
F 3 "" H 8750 8950 50  0001 C CNN
	1    8750 8950
	1    0    0    -1  
$EndComp
Text Label 6450 2250 0    50   ~ 0
PAS
Wire Wire Line
	7200 2250 6450 2250
Wire Wire Line
	14750 8850 14750 8950
Wire Wire Line
	14750 8950 14800 8950
Wire Wire Line
	14850 8950 14850 8850
Connection ~ 14800 8950
Wire Wire Line
	14800 8950 14850 8950
Wire Wire Line
	14550 6450 14550 6950
Connection ~ 14550 6450
Wire Wire Line
	14750 6950 14750 6450
Connection ~ 14750 6450
$Comp
L power:VBUS #PWR09
U 1 1 60130B9C
P 13850 7350
F 0 "#PWR09" H 13850 7200 50  0001 C CNN
F 1 "VBUS" H 13865 7523 50  0000 C CNN
F 2 "" H 13850 7350 50  0001 C CNN
F 3 "" H 13850 7350 50  0001 C CNN
	1    13850 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	13850 7450 13850 7350
NoConn ~ 14050 8050
NoConn ~ 14050 8150
NoConn ~ 14050 8250
NoConn ~ 14050 8350
NoConn ~ 14050 8550
NoConn ~ 15450 8550
NoConn ~ 15450 8450
NoConn ~ 15450 8350
NoConn ~ 15450 8150
NoConn ~ 15450 7250
NoConn ~ 15450 7350
NoConn ~ 15450 7550
Wire Wire Line
	14050 7250 14050 6450
Wire Wire Line
	14050 6450 14550 6450
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
Text Label 10900 6950 3    50   ~ 0
RTS
Text Label 15900 8050 2    50   ~ 0
RTS
Wire Wire Line
	15450 8050 15900 8050
Text Label 12250 7000 2    50   ~ 0
GPIO0
Text Label 12250 8350 2    50   ~ 0
RESET
Text Label 11100 8350 1    50   ~ 0
DTR
Text Label 2850 3800 0    50   ~ 0
RESET
Wire Wire Line
	2850 3800 3600 3800
Text Label 15900 7450 2    50   ~ 0
DTR
Wire Wire Line
	15450 7450 15900 7450
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
	14050 7450 13850 7450
$Comp
L Interface_USB:CP2104 U5
U 1 1 600F44E2
P 14750 7850
F 0 "U5" H 14000 6550 50  0000 C CNN
F 1 "CP2104" H 14000 6750 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm" H 14900 6900 50  0001 L CNN
F 3 "https://www.silabs.com/documents/public/data-sheets/cp2104.pdf" H 14200 9100 50  0001 C CNN
F 4 "https://uk.farnell.com/silicon-labs/cp2104-f03-gmr/usb-to-uart-bridge-40-to-85deg/dp/2930581?st=cp2104" H 14750 7850 50  0001 C CNN "purchase_link"
	1    14750 7850
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR08
U 1 1 60133918
P 13750 8250
F 0 "#PWR08" H 13750 8100 50  0001 C CNN
F 1 "VBUS" H 13765 8423 50  0000 C CNN
F 2 "" H 13750 8250 50  0001 C CNN
F 3 "" H 13750 8250 50  0001 C CNN
	1    13750 8250
	1    0    0    -1  
$EndComp
NoConn ~ 1700 1950
Wire Wire Line
	1700 1850 1200 1850
Wire Wire Line
	1700 1650 1200 1650
Wire Wire Line
	1700 1450 1200 1450
Wire Wire Line
	1700 1350 1200 1350
Text Notes 800  2550 0    50   ~ 0
Wired according to: \nhttps://community.st.com/s/contentdocument/0690X00000604T2QAI
Wire Wire Line
	1050 1750 1050 2150
$Comp
L power:GND #PWR029
U 1 1 602639C7
P 1050 2150
F 0 "#PWR029" H 1050 1900 50  0001 C CNN
F 1 "GND" H 1055 1977 50  0000 C CNN
F 2 "" H 1050 2150 50  0001 C CNN
F 3 "" H 1050 2150 50  0001 C CNN
	1    1050 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR07
U 1 1 60267CA7
P 1050 1050
F 0 "#PWR07" H 1050 900 50  0001 C CNN
F 1 "+3V3" H 1065 1223 50  0000 C CNN
F 2 "" H 1050 1050 50  0001 C CNN
F 3 "" H 1050 1050 50  0001 C CNN
	1    1050 1050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 1550 1050 1550
Wire Wire Line
	1050 1550 1050 1100
Wire Wire Line
	1050 1750 1700 1750
Text Notes 4100 800  0    50   ~ 0
U-blox GPS module connector(Grove)
Wire Wire Line
	4800 4900 5750 4900
$Comp
L Mechanical:MountingHole_Pad H1
U 1 1 60208D6F
P 10550 3450
F 0 "H1" V 10787 3453 50  0000 C CNN
F 1 "MountingHole_Pad" V 10696 3453 50  0000 C CNN
F 2 "custom_footprints:MountingHole_2.7mm_M2.5_custom" H 10550 3450 50  0001 C CNN
F 3 "~" H 10550 3450 50  0001 C CNN
	1    10550 3450
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H2
U 1 1 6021C578
P 10550 3850
F 0 "H2" V 10787 3853 50  0000 C CNN
F 1 "MountingHole_Pad" V 10696 3853 50  0000 C CNN
F 2 "custom_footprints:MountingHole_2.7mm_M2.5_custom" H 10550 3850 50  0001 C CNN
F 3 "~" H 10550 3850 50  0001 C CNN
	1    10550 3850
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H3
U 1 1 6021C836
P 10550 4200
F 0 "H3" V 10787 4203 50  0000 C CNN
F 1 "MountingHole_Pad" V 10696 4203 50  0000 C CNN
F 2 "custom_footprints:MountingHole_2.7mm_M2.5_custom" H 10550 4200 50  0001 C CNN
F 3 "~" H 10550 4200 50  0001 C CNN
	1    10550 4200
	0    -1   -1   0   
$EndComp
$Comp
L Mechanical:MountingHole_Pad H4
U 1 1 6021CA96
P 10550 4600
F 0 "H4" V 10787 4603 50  0000 C CNN
F 1 "MountingHole_Pad" V 10696 4603 50  0000 C CNN
F 2 "custom_footprints:MountingHole_2.7mm_M2.5_custom" H 10550 4600 50  0001 C CNN
F 3 "~" H 10550 4600 50  0001 C CNN
	1    10550 4600
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 602271B8
P 10950 4750
F 0 "#PWR0101" H 10950 4500 50  0001 C CNN
F 1 "GND" H 10955 4577 50  0000 C CNN
F 2 "" H 10950 4750 50  0001 C CNN
F 3 "" H 10950 4750 50  0001 C CNN
	1    10950 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 4600 10950 4600
Wire Wire Line
	10950 4600 10950 4750
Wire Wire Line
	10650 3850 10950 3850
Wire Notes Line
	9900 5000 9900 3000
Text Notes 10000 3100 0    50   ~ 0
Mounting Holes
$Comp
L power:GND #PWR011
U 1 1 60276B94
P 5400 10450
F 0 "#PWR011" H 5400 10200 50  0001 C CNN
F 1 "GND" H 5405 10277 50  0000 C CNN
F 2 "" H 5400 10450 50  0001 C CNN
F 3 "" H 5400 10450 50  0001 C CNN
	1    5400 10450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 10400 5350 10450
Wire Wire Line
	5350 10450 5400 10450
Wire Wire Line
	5450 10400 5450 10450
Wire Wire Line
	5450 10450 5400 10450
Connection ~ 5400 10450
Wire Wire Line
	5350 9200 5450 9200
Wire Wire Line
	4750 10000 4350 10000
Wire Wire Line
	4750 9900 4350 9900
Text Label 4350 10000 0    50   ~ 0
SCL1
Text Label 4350 9900 0    50   ~ 0
SDA1
$Comp
L Sensor_Motion:LSM6DS3 U4
U 1 1 60257B3F
P 5350 9800
F 0 "U4" H 5994 9846 50  0000 L CNN
F 1 "LSM6DS3" H 5994 9755 50  0000 L CNN
F 2 "Package_LGA:LGA-14_3x2.5mm_P0.5mm_LayoutBorder3x4y" H 4950 9100 50  0001 L CNN
F 3 "www.st.com/resource/en/datasheet/lsm6ds3.pdf" H 5450 9150 50  0001 C CNN
F 4 "3.348" H 5350 9800 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/stmicroelectronics/lsm6dsmtr/mems-3d-accelero-gyroscope-lga/dp/2664522?st=lsm%20lga-14" H 5350 9800 50  0001 C CNN "purchase_link"
	1    5350 9800
	1    0    0    -1  
$EndComp
NoConn ~ 4750 9500
NoConn ~ 4750 9600
NoConn ~ 4750 9700
NoConn ~ 4750 10100
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
	5750 5500 4800 5500
Wire Wire Line
	5750 5600 4800 5600
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
	14750 6450 15100 6450
NoConn ~ 14950 6950
$Comp
L custom_symbols:MS8607-02BA U3
U 1 1 60333A79
P 8500 9500
F 0 "U3" H 8830 9546 50  0000 L CNN
F 1 "MS8607-02BA" H 8830 9455 50  0000 L CNN
F 2 "Package_LGA:LGA-8_3x5mm_P1.25mm" H 8500 9500 50  0001 C CNN
F 3 "https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS8607-02BA01%7FB3%7Fpdf%7FEnglish%7FENG_DS_MS8607-02BA01_B3.pdf%7FCAT-BLPS0018" H 8500 9500 50  0001 C CNN
F 4 "1" H 8500 9500 50  0001 C CNN "min_qty"
F 5 "6.564" H 8500 9500 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/sensor-solutions-te-connectivity/ms860702ba01-50/pressure-sensor-10mbar-29psi-qfn/dp/2748850?st=ms8607" H 8500 9500 50  0001 C CNN "purchase_link"
	1    8500 9500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 2150 6450 2150
Text Label 6450 2050 0    50   ~ 0
Motor_pulse_A
Wire Wire Line
	7200 2050 6450 2050
Text Label 6450 2150 0    50   ~ 0
Motor_pulse_B
Text Notes 13150 9350 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
Text Notes 10550 8700 0    50   ~ 0
Ref: https://learn.adafruit.com/assets/41630
Text Label 5100 5100 2    50   ~ 0
SDA2
Text Label 5100 5000 2    50   ~ 0
SCL2
Wire Wire Line
	15450 4850 15450 5250
$Comp
L Device:R R10
U 1 1 601C8D43
P 15450 4700
F 0 "R10" H 15520 4746 50  0000 L CNN
F 1 "4.7k" H 15520 4655 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 15380 4700 50  0001 C CNN
F 3 "~" H 15450 4700 50  0001 C CNN
	1    15450 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	15450 4250 15450 4550
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
	4050 11150 9750 11150
Wire Notes Line
	4050 8200 4050 11150
$Comp
L Connector:TestPoint TP33
U 1 1 602C04FD
P 13500 7500
F 0 "TP33" V 13500 8100 50  0000 L CNN
F 1 "TestPoint" V 13500 7700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 13700 7500 50  0001 C CNN
F 3 "~" H 13700 7500 50  0001 C CNN
	1    13500 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	13500 7500 13500 7750
$Comp
L Connector:TestPoint TP34
U 1 1 602C0508
P 13600 7500
F 0 "TP34" V 13600 8100 50  0000 L CNN
F 1 "TestPoint" V 13600 7700 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 13800 7500 50  0001 C CNN
F 3 "~" H 13800 7500 50  0001 C CNN
	1    13600 7500
	1    0    0    -1  
$EndComp
Wire Wire Line
	13600 7500 13600 7850
Connection ~ 13500 7750
Wire Wire Line
	13500 7750 13450 7750
$Comp
L power:GND #PWR030
U 1 1 602443BD
P 12700 7450
F 0 "#PWR030" H 12700 7200 50  0001 C CNN
F 1 "GND" H 12705 7277 50  0000 C CNN
F 2 "" H 12700 7450 50  0001 C CNN
F 3 "" H 12700 7450 50  0001 C CNN
	1    12700 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	12700 7250 12700 7450
Wire Wire Line
	13150 7250 12700 7250
$Comp
L Connector:USB_B_Micro J3
U 1 1 600ED098
P 13150 7850
F 0 "J3" H 12920 7747 50  0000 R CNN
F 1 "USB_B_Micro" H 12920 7838 50  0000 R CNN
F 2 "Connector_USB:USB_Micro-B_Molex-105017-0001" H 13300 7800 50  0001 C CNN
F 3 "~" H 13300 7800 50  0001 C CNN
F 4 "1" H 13150 7850 50  0001 C CNN "min_qty"
F 5 "0.8484" H 13150 7850 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/molex/105017-0001/usb-conn-2-0-micro-usb-type-b/dp/2293836?st=molex-105017-0001" H 13150 7850 50  0001 C CNN "purchase_link"
	1    13150 7850
	1    0    0    1   
$EndComp
Wire Wire Line
	13450 7850 13600 7850
Connection ~ 13150 7450
Wire Wire Line
	13450 8250 13750 8250
NoConn ~ 13450 7650
Wire Wire Line
	13450 8050 13450 8250
Wire Wire Line
	13150 7450 13150 7250
Wire Wire Line
	13050 7450 13150 7450
Connection ~ 13600 7850
Wire Wire Line
	13500 7750 14050 7750
Wire Wire Line
	13600 7850 14050 7850
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
button_reset
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
Text Label 5750 5400 2    50   ~ 0
button_up
Wire Wire Line
	2650 12650 2750 12650
Wire Notes Line
	3950 2650 3950 600 
Wire Notes Line
	6050 600  6050 2650
Wire Notes Line
	8050 600  8050 2650
Wire Wire Line
	5100 2250 5500 2250
Wire Wire Line
	5100 2350 5500 2350
Text Label 5500 2350 2    50   ~ 0
SCL1
Text Label 5500 2250 2    50   ~ 0
SDA1
Text Notes 6550 550  0    50   ~ 0
Connectors
$Comp
L power:VBUS #PWR028
U 1 1 601C526F
P 1600 9850
F 0 "#PWR028" H 1600 9700 50  0001 C CNN
F 1 "VBUS" H 1615 10023 50  0000 C CNN
F 2 "" H 1600 9850 50  0001 C CNN
F 3 "" H 1600 9850 50  0001 C CNN
	1    1600 9850
	1    0    0    -1  
$EndComp
Text Notes 650  8200 0    50   ~ 0
Switching regulator that converts \nVbatt(36-42V input) to 5V.
Wire Wire Line
	1200 9150 1200 9200
$Comp
L Device:C C12
U 1 1 60187E4E
P 1200 9000
F 0 "C12" H 1085 8954 50  0000 R CNN
F 1 "10uF 100V" H 1085 9045 50  0000 R CNN
F 2 "Capacitor_SMD:CP_Elec_6.3x7.7" H 1238 8850 50  0001 C CNN
F 3 "~" H 1200 9000 50  0001 C CNN
F 4 "1" H 1200 9000 50  0001 C CNN "min_qty"
F 5 "0.2004" H 1200 9000 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/kemet/edk106m100a9haa/cap-10-f-100v-radial-smd-reel/dp/2068705" H 1200 9000 50  0001 C CNN "purchase_link"
	1    1200 9000
	-1   0    0    1   
$EndComp
$Comp
L Device:C C11
U 1 1 6018709B
P 3550 9000
F 0 "C11" H 3435 8954 50  0000 R CNN
F 1 "10uF" H 3435 9045 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3588 8850 50  0001 C CNN
F 3 "~" H 3550 9000 50  0001 C CNN
F 4 "0.1644" H 3550 9000 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/kemet/c0603c106m9pactu/cap-10-f-6-3v-20-x5r-0603/dp/1288201?st=10uf%200603" H 3550 9000 50  0001 C CNN "purchase_link"
	1    3550 9000
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR038
U 1 1 60186C96
P 1200 9200
F 0 "#PWR038" H 1200 8950 50  0001 C CNN
F 1 "GND" H 1205 9027 50  0000 C CNN
F 2 "" H 1200 9200 50  0001 C CNN
F 3 "" H 1200 9200 50  0001 C CNN
	1    1200 9200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 9150 3550 9300
$Comp
L power:GND #PWR036
U 1 1 6018051F
P 3550 9300
F 0 "#PWR036" H 3550 9050 50  0001 C CNN
F 1 "GND" H 3555 9127 50  0000 C CNN
F 2 "" H 3550 9300 50  0001 C CNN
F 3 "" H 3550 9300 50  0001 C CNN
	1    3550 9300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR039
U 1 1 6015C1A0
P 2500 9250
F 0 "#PWR039" H 2500 9000 50  0001 C CNN
F 1 "GND" H 2505 9077 50  0000 C CNN
F 2 "" H 2500 9250 50  0001 C CNN
F 3 "" H 2500 9250 50  0001 C CNN
	1    2500 9250
	1    0    0    -1  
$EndComp
$Comp
L custom_symbols:VBATT #PWR037
U 1 1 6014B49A
P 1200 8450
F 0 "#PWR037" H 1200 8300 50  0001 C CNN
F 1 "VBATT" H 1215 8623 50  0000 C CNN
F 2 "" H 1200 8450 50  0001 C CNN
F 3 "" H 1200 8450 50  0001 C CNN
	1    1200 8450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 8850 3550 8650
Wire Notes Line
	6950 7850 6950 2800
Wire Notes Line
	15950 5900 15950 9500
Wire Notes Line
	15950 9500 10150 9500
Wire Notes Line
	10150 9500 10150 5900
Wire Notes Line
	12350 5900 12350 9500
Wire Notes Line
	10150 5900 15950 5900
Text Notes 4300 1900 0    50   ~ 0
I2C OLED display Connector(Grove)
Wire Notes Line
	600  8000 3850 8000
Wire Wire Line
	10700 2000 11800 2000
Text Label 12150 1900 1    50   ~ 0
SCL2
Text Notes 9750 800  0    50   ~ 0
Connector for External I2C devices(Grove)
Text Notes 9800 2550 0    50   ~ 0
The Voltage/current sensors connect here.
$Comp
L Device:C C13
U 1 1 606F9EF7
P 12150 2250
AR Path="/606F9EF7" Ref="C13"  Part="1" 
AR Path="/60156738/606F9EF7" Ref="C?"  Part="1" 
AR Path="/601BF9C2/606F9EF7" Ref="C?"  Part="1" 
AR Path="/601E52DF/606F9EF7" Ref="C?"  Part="1" 
AR Path="/6018BFA2/606F9EF7" Ref="C?"  Part="1" 
AR Path="/6040F615/606F9EF7" Ref="C?"  Part="1" 
AR Path="/6042797A/606F9EF7" Ref="C?"  Part="1" 
AR Path="/6045D11E/606F9EF7" Ref="C?"  Part="1" 
AR Path="/60465E6A/606F9EF7" Ref="C?"  Part="1" 
AR Path="/6049D147/606F9EF7" Ref="C?"  Part="1" 
F 0 "C13" H 12265 2296 50  0000 L CNN
F 1 "100nF" H 12265 2205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 12188 2100 50  0001 C CNN
F 3 "~" H 12150 2250 50  0001 C CNN
F 4 "0.0271" H 12150 2250 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 12150 2250 50  0001 C CNN "purchase_link"
	1    12150 2250
	1    0    0    -1  
$EndComp
Connection ~ 12150 2100
$Comp
L power:GND #PWR067
U 1 1 606F9F06
P 12850 2400
AR Path="/606F9F06" Ref="#PWR067"  Part="1" 
AR Path="/60156738/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/601BF9C2/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/601E52DF/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/6042797A/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/6045D11E/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/606F9F06" Ref="#PWR?"  Part="1" 
AR Path="/6049D147/606F9F06" Ref="#PWR?"  Part="1" 
F 0 "#PWR067" H 12850 2150 50  0001 C CNN
F 1 "GND" H 12855 2227 50  0000 C CNN
F 2 "" H 12850 2400 50  0001 C CNN
F 3 "" H 12850 2400 50  0001 C CNN
	1    12850 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR065
U 1 1 606F9F0D
P 12150 2400
AR Path="/606F9F0D" Ref="#PWR065"  Part="1" 
AR Path="/60156738/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/601BF9C2/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/601E52DF/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/6042797A/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/6045D11E/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/606F9F0D" Ref="#PWR?"  Part="1" 
AR Path="/6049D147/606F9F0D" Ref="#PWR?"  Part="1" 
F 0 "#PWR065" H 12150 2150 50  0001 C CNN
F 1 "GND" H 12155 2227 50  0000 C CNN
F 2 "" H 12150 2400 50  0001 C CNN
F 3 "" H 12150 2400 50  0001 C CNN
	1    12150 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 2100 12150 2100
Wire Wire Line
	11800 2000 11800 1050
Wire Notes Line
	13250 600  13250 2650
$Comp
L power:+3.3V #PWR0102
U 1 1 6077D383
P 12850 1800
F 0 "#PWR0102" H 12850 1650 50  0001 C CNN
F 1 "+3.3V" H 12865 1973 50  0000 C CNN
F 2 "" H 12850 1800 50  0001 C CNN
F 3 "" H 12850 1800 50  0001 C CNN
	1    12850 1800
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0103
U 1 1 6077CD6E
P 12650 750
F 0 "#PWR0103" H 12650 600 50  0001 C CNN
F 1 "+3.3V" H 12800 800 50  0000 C CNN
F 2 "" H 12650 750 50  0001 C CNN
F 3 "" H 12650 750 50  0001 C CNN
	1    12650 750 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR064
U 1 1 6070F09F
P 12150 1350
AR Path="/6070F09F" Ref="#PWR064"  Part="1" 
AR Path="/60156738/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/601BF9C2/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/601E52DF/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/6042797A/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/6045D11E/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/6070F09F" Ref="#PWR?"  Part="1" 
AR Path="/6049D147/6070F09F" Ref="#PWR?"  Part="1" 
F 0 "#PWR064" H 12150 1100 50  0001 C CNN
F 1 "GND" H 12155 1177 50  0000 C CNN
F 2 "" H 12150 1350 50  0001 C CNN
F 3 "" H 12150 1350 50  0001 C CNN
	1    12150 1350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR066
U 1 1 6070F094
P 12650 1350
AR Path="/6070F094" Ref="#PWR066"  Part="1" 
AR Path="/60156738/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/601BF9C2/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/601E52DF/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/6042797A/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/6045D11E/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/6070F094" Ref="#PWR?"  Part="1" 
AR Path="/6049D147/6070F094" Ref="#PWR?"  Part="1" 
F 0 "#PWR066" H 12650 1100 50  0001 C CNN
F 1 "GND" H 12655 1177 50  0000 C CNN
F 2 "" H 12650 1350 50  0001 C CNN
F 3 "" H 12650 1350 50  0001 C CNN
	1    12650 1350
	1    0    0    -1  
$EndComp
Text Label 12150 850  1    50   ~ 0
SDA2
NoConn ~ 1700 2150
NoConn ~ 1700 2050
$Comp
L Connector:Micro_SD_Card_Det_Hirose_DM3AT J1
U 1 1 6009789F
P 2600 1650
F 0 "J1" H 2550 2467 50  0000 C CNN
F 1 "Micro_SD_Card" H 2550 2376 50  0000 C CNN
F 2 "Connector_Card:microSD_HC_Hirose_DM3AT-SF-PEJM5" H 3750 1950 50  0001 C CNN
F 3 "http://katalog.we-online.de/em/datasheet/693072010801.pdf" H 2600 1650 50  0001 C CNN
F 4 "https://uk.farnell.com/hirose-hrs/dm3at-sf-pejm5/connector-micro-sd-standard-8pos/dp/2427719?st=dm3at-sf-pejm5" H 2600 1650 50  0001 C CNN "purchase_link"
	1    2600 1650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR035
U 1 1 607F043C
P 3550 8500
F 0 "#PWR035" H 3550 8350 50  0001 C CNN
F 1 "+5V" H 3565 8673 50  0000 C CNN
F 2 "" H 3550 8500 50  0001 C CNN
F 3 "" H 3550 8500 50  0001 C CNN
	1    3550 8500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR068
U 1 1 607F1631
P 1000 9850
F 0 "#PWR068" H 1000 9700 50  0001 C CNN
F 1 "+5V" H 1015 10023 50  0000 C CNN
F 2 "" H 1000 9850 50  0001 C CNN
F 3 "" H 1000 9850 50  0001 C CNN
	1    1000 9850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C14
U 1 1 6087BB45
P 1400 10550
F 0 "C14" H 1285 10504 50  0000 R CNN
F 1 "1uF" H 1285 10595 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1438 10400 50  0001 C CNN
F 3 "~" H 1400 10550 50  0001 C CNN
F 4 "0.0902" H 1400 10550 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/06033d105kat2a/cap-1-f-25v-10-x5r-0603/dp/1658868?st=1uf%200603" H 1400 10550 50  0001 C CNN "purchase_link"
	1    1400 10550
	-1   0    0    1   
$EndComp
Wire Wire Line
	1600 9850 1600 10050
$Comp
L Regulator_Linear:XC6220B331MR U2
U 1 1 60817C70
P 2650 10350
F 0 "U2" H 2650 10717 50  0000 C CNN
F 1 "XC6210" H 2650 10626 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 2650 10350 50  0001 C CNN
F 3 "https://www.torexsemi.com/file/xc6220/XC6220.pdf" H 3400 9350 50  0001 C CNN
F 4 "1" H 2650 10350 50  0001 C CNN "min_qty"
F 5 "1.00092" H 2650 10350 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/torex/xc6210b332mr/ic-v-reg-cmos-ldo-3-3v-smd-6210/dp/1057803?st=voltage%20regulator%20sot%2023" H 2650 10350 50  0001 C CNN "purchase_link"
	1    2650 10350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR071
U 1 1 60859ADD
P 2650 10750
F 0 "#PWR071" H 2650 10500 50  0001 C CNN
F 1 "GND" H 2655 10577 50  0000 C CNN
F 2 "" H 2650 10750 50  0001 C CNN
F 3 "" H 2650 10750 50  0001 C CNN
	1    2650 10750
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR073
U 1 1 60864A43
P 3400 10150
F 0 "#PWR073" H 3400 10000 50  0001 C CNN
F 1 "+3.3V" H 3415 10323 50  0000 C CNN
F 2 "" H 3400 10150 50  0001 C CNN
F 3 "" H 3400 10150 50  0001 C CNN
	1    3400 10150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 10250 3200 10250
Wire Wire Line
	3400 10250 3400 10150
$Comp
L Diode:BAT54C D3
U 1 1 601A08A3
P 1300 10050
F 0 "D3" H 1300 10275 50  0000 C CNN
F 1 "BAT54C" H 1300 10184 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 1375 10175 50  0001 L CNN
F 3 "http://www.diodes.com/_files/datasheets/ds11005.pdf" H 1220 10050 50  0001 C CNN
F 4 "5" H 1300 10050 50  0001 C CNN "min_qty"
F 5 "0.128" H 1300 10050 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/nexperia/bat54c-215/diode-schottky-30v-sot23/dp/1081192?st=bat54c" H 1300 10050 50  0001 C CNN "purchase_link"
	1    1300 10050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 10250 1400 10250
Wire Wire Line
	2150 10450 2150 10250
Connection ~ 2150 10250
Wire Wire Line
	1400 10400 1400 10250
$Comp
L power:GND #PWR069
U 1 1 608C0587
P 1400 10750
F 0 "#PWR069" H 1400 10500 50  0001 C CNN
F 1 "GND" H 1405 10577 50  0000 C CNN
F 2 "" H 1400 10750 50  0001 C CNN
F 3 "" H 1400 10750 50  0001 C CNN
	1    1400 10750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 10700 1400 10750
Connection ~ 1400 10250
Wire Wire Line
	1400 10250 1850 10250
$Comp
L Device:C C15
U 1 1 608D76D3
P 1850 10550
F 0 "C15" H 1735 10504 50  0000 R CNN
F 1 "1uF" H 1735 10595 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 1888 10400 50  0001 C CNN
F 3 "~" H 1850 10550 50  0001 C CNN
F 4 "0.0902" H 1850 10550 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/06033d105kat2a/cap-1-f-25v-10-x5r-0603/dp/1658868?st=1uf%200603" H 1850 10550 50  0001 C CNN "purchase_link"
	1    1850 10550
	-1   0    0    1   
$EndComp
Wire Wire Line
	1850 10400 1850 10250
$Comp
L power:GND #PWR070
U 1 1 608D76DE
P 1850 10750
F 0 "#PWR070" H 1850 10500 50  0001 C CNN
F 1 "GND" H 1855 10577 50  0000 C CNN
F 2 "" H 1850 10750 50  0001 C CNN
F 3 "" H 1850 10750 50  0001 C CNN
	1    1850 10750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1850 10700 1850 10750
Connection ~ 1850 10250
Wire Wire Line
	1850 10250 2000 10250
$Comp
L Device:C C16
U 1 1 608E3116
P 3200 10550
F 0 "C16" H 3085 10504 50  0000 R CNN
F 1 "1uF" H 3085 10595 50  0000 R CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 3238 10400 50  0001 C CNN
F 3 "~" H 3200 10550 50  0001 C CNN
F 4 "0.0902" H 3200 10550 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/06033d105kat2a/cap-1-f-25v-10-x5r-0603/dp/1658868?st=1uf%200603" H 3200 10550 50  0001 C CNN "purchase_link"
	1    3200 10550
	-1   0    0    1   
$EndComp
Wire Wire Line
	3200 10400 3200 10250
$Comp
L power:GND #PWR072
U 1 1 608E3121
P 3200 10750
F 0 "#PWR072" H 3200 10500 50  0001 C CNN
F 1 "GND" H 3205 10577 50  0000 C CNN
F 2 "" H 3200 10750 50  0001 C CNN
F 3 "" H 3200 10750 50  0001 C CNN
	1    3200 10750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 10700 3200 10750
Connection ~ 3200 10250
Wire Wire Line
	3200 10250 3400 10250
Wire Notes Line
	600  11150 3850 11150
Wire Notes Line
	600  8000 600  11150
Wire Notes Line
	3850 8000 3850 11150
Wire Notes Line
	600  9550 3850 9550
Text Notes 1950 9750 0    50   ~ 0
ORing to switch between regulated +5V and \nUSB VBUS. Then generate 3.3V bus.
Text Label 5750 5500 2    50   ~ 0
button_down
Text Label 5750 5600 2    50   ~ 0
button_select
Text Label 3150 3800 0    50   ~ 0
button_reset
$Comp
L Connector:TestPoint TP1
U 1 1 609DDD43
P 750 10300
F 0 "TP1" V 750 10900 50  0000 L CNN
F 1 "TestPoint" V 750 10500 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_1.0x1.0mm" H 950 10300 50  0001 C CNN
F 3 "~" H 950 10300 50  0001 C CNN
	1    750  10300
	-1   0    0    1   
$EndComp
Wire Wire Line
	1000 9850 1000 10050
$Comp
L power:+5V #PWR0104
U 1 1 609EC29B
P 750 10300
F 0 "#PWR0104" H 750 10150 50  0001 C CNN
F 1 "+5V" H 765 10473 50  0000 C CNN
F 2 "" H 750 10300 50  0001 C CNN
F 3 "" H 750 10300 50  0001 C CNN
	1    750  10300
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 609ED29F
P 2000 10250
F 0 "#FLG0101" H 2000 10325 50  0001 C CNN
F 1 "PWR_FLAG" H 2000 10423 50  0000 C CNN
F 2 "" H 2000 10250 50  0001 C CNN
F 3 "~" H 2000 10250 50  0001 C CNN
	1    2000 10250
	1    0    0    -1  
$EndComp
Connection ~ 2000 10250
Wire Wire Line
	2000 10250 2150 10250
$Comp
L Device:C C21
U 1 1 609F15AE
P 650 1400
F 0 "C21" H 765 1446 50  0000 L CNN
F 1 "100nF" H 765 1355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 688 1250 50  0001 C CNN
F 3 "~" H 650 1400 50  0001 C CNN
F 4 "0.0271" H 650 1400 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 650 1400 50  0001 C CNN "purchase_link"
	1    650  1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	650  1250 650  1100
Wire Wire Line
	650  1100 1050 1100
Connection ~ 1050 1100
Wire Wire Line
	1050 1100 1050 1050
$Comp
L power:GND #PWR031
U 1 1 60A34CE0
P 650 1550
F 0 "#PWR031" H 650 1300 50  0001 C CNN
F 1 "GND" H 655 1377 50  0000 C CNN
F 2 "" H 650 1550 50  0001 C CNN
F 3 "" H 650 1550 50  0001 C CNN
	1    650  1550
	1    0    0    -1  
$EndComp
Wire Notes Line
	500  650  3700 650 
Wire Notes Line
	500  2650 3700 2650
Text Label 5450 1300 2    50   ~ 0
GPS_RX
Text Label 5450 1200 2    50   ~ 0
GPS_TX
Wire Wire Line
	5050 1200 5450 1200
Wire Wire Line
	5050 1300 5450 1300
$Sheet
S 4450 1100 600  250 
U 60AB9C64
F0 "gps_ublox" 50
F1 "grove_connector.sch" 50
F2 "grove_pin_1" I R 5050 1300 50 
F3 "grove_pin_2" I R 5050 1200 50 
$EndSheet
$Sheet
S 4500 2150 600  250 
U 60B6A54A
F0 "Oled display connector" 50
F1 "grove_connector.sch" 50
F2 "grove_pin_1" I R 5100 2350 50 
F3 "grove_pin_2" I R 5100 2250 50 
$EndSheet
$Sheet
S 10100 1900 600  250 
U 60B80021
F0 "External I2C devices" 50
F1 "grove_connector.sch" 50
F2 "grove_pin_1" I R 10700 2100 50 
F3 "grove_pin_2" I R 10700 2000 50 
$EndSheet
Wire Notes Line
	3950 1650 6050 1650
Wire Wire Line
	8800 1050 9500 1050
Wire Wire Line
	8800 1150 9500 1150
$Sheet
S 8200 950  600  250 
U 60BA371C
F0 "misc adc inputs" 50
F1 "grove_connector.sch" 50
F2 "grove_pin_1" I R 8800 1150 50 
F3 "grove_pin_2" I R 8800 1050 50 
$EndSheet
Text Label 9500 1050 2    50   ~ 0
misc_adc_raw_1
Text Label 9500 1150 2    50   ~ 0
misc_adc_raw_2
$Comp
L power:+5V #PWR032
U 1 1 60BE6A07
P 7150 1100
F 0 "#PWR032" H 7150 950 50  0001 C CNN
F 1 "+5V" V 7165 1228 50  0000 L CNN
F 2 "" H 7150 1100 50  0001 C CNN
F 3 "" H 7150 1100 50  0001 C CNN
	1    7150 1100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4800 3800 5750 3800
Wire Wire Line
	4800 3900 5750 3900
Wire Wire Line
	5750 4200 4800 4200
Wire Wire Line
	5750 4000 4800 4000
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
Wire Wire Line
	5750 4700 4800 4700
Wire Wire Line
	5750 4600 4800 4600
Wire Wire Line
	5750 4500 4800 4500
Wire Wire Line
	5750 4400 4800 4400
Wire Wire Line
	4800 4800 5750 4800
Text Label 5200 4800 2    50   ~ 0
GPS_TX
Text Label 5200 4900 2    50   ~ 0
GPS_RX
Text Label 5250 3800 2    50   ~ 0
GPIO0
Text Label 5200 3900 2    50   ~ 0
RX0
Text Label 5200 4100 2    50   ~ 0
TX0
Wire Wire Line
	4800 4100 5750 4100
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
Text Label 5200 4500 2    50   ~ 0
MOSI
Text Label 5200 4400 2    50   ~ 0
MISO
Text Label 5200 4700 2    50   ~ 0
SPI_SD_CS
Text Label 5200 4600 2    50   ~ 0
SPI_CLK
Wire Wire Line
	4800 4300 5750 4300
$Comp
L power:GND #PWR033
U 1 1 60C23B72
P 7150 1200
F 0 "#PWR033" H 7150 950 50  0001 C CNN
F 1 "GND" V 7150 1000 50  0000 C CNN
F 2 "" H 7150 1200 50  0001 C CNN
F 3 "" H 7150 1200 50  0001 C CNN
	1    7150 1200
	0    1    1    0   
$EndComp
$Comp
L power:+3.3V #PWR034
U 1 1 60BE7C15
P 7150 1300
F 0 "#PWR034" H 7150 1150 50  0001 C CNN
F 1 "+3.3V" V 7150 1550 50  0000 C CNN
F 2 "" H 7150 1300 50  0001 C CNN
F 3 "" H 7150 1300 50  0001 C CNN
	1    7150 1300
	0    -1   -1   0   
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 600A1449
P 7350 1200
F 0 "J2" H 7430 1192 50  0000 L CNN
F 1 "Conn_01x04" H 7430 1101 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4-5.08_1x04_P5.08mm_Horizontal" H 7350 1200 50  0001 C CNN
F 3 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 7350 1200 50  0001 C CNN
F 4 "1" H 7350 1200 50  0001 C CNN "min_qty"
F 5 "0.94" H 7350 1200 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 7350 1200 50  0001 C CNN "purchase_link"
	1    7350 1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR062
U 1 1 60CE83B3
P 7150 1400
F 0 "#PWR062" H 7150 1150 50  0001 C CNN
F 1 "GND" V 7150 1200 50  0000 C CNN
F 2 "" H 7150 1400 50  0001 C CNN
F 3 "" H 7150 1400 50  0001 C CNN
	1    7150 1400
	0    1    1    0   
$EndComp
$Comp
L Device:C C26
U 1 1 60CF4FA6
P 15500 6600
F 0 "C26" H 15385 6554 50  0000 R CNN
F 1 "100nF" H 15385 6645 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 15538 6450 50  0001 C CNN
F 3 "~" H 15500 6600 50  0001 C CNN
F 4 "0.0271" H 15500 6600 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 15500 6600 50  0001 C CNN "purchase_link"
	1    15500 6600
	-1   0    0    1   
$EndComp
Wire Wire Line
	15100 6450 15500 6450
Connection ~ 15100 6450
$Comp
L power:GND #PWR089
U 1 1 60D008C8
P 15500 6750
F 0 "#PWR089" H 15500 6500 50  0001 C CNN
F 1 "GND" H 15505 6577 50  0000 C CNN
F 2 "" H 15500 6750 50  0001 C CNN
F 3 "" H 15500 6750 50  0001 C CNN
	1    15500 6750
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D10
U 1 1 60D28495
P 8200 6600
F 0 "D10" H 8193 6345 50  0000 C CNN
F 1 "LED" H 8193 6436 50  0000 C CNN
F 2 "LED_SMD:LED_0402_1005Metric" H 8200 6600 50  0001 C CNN
F 3 "~" H 8200 6600 50  0001 C CNN
	1    8200 6600
	-1   0    0    1   
$EndComp
$Comp
L Device:R R23
U 1 1 60D2940A
P 7900 6600
F 0 "R23" V 7693 6600 50  0000 C CNN
F 1 "R" V 7784 6600 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 7830 6600 50  0001 C CNN
F 3 "~" H 7900 6600 50  0001 C CNN
	1    7900 6600
	0    1    1    0   
$EndComp
Text Label 5750 5700 2    50   ~ 0
LED
Text Label 8550 6600 2    50   ~ 0
LED
Wire Wire Line
	7750 6600 7600 6600
Wire Notes Line
	7500 6150 7500 6950
Wire Notes Line
	8600 6950 8600 6150
Wire Notes Line
	8600 6150 7500 6150
Text Notes 7600 6250 0    50   ~ 0
LED indicator
Wire Wire Line
	2500 9200 2500 9250
Wire Wire Line
	2450 9200 2500 9200
$Comp
L custom_symbols:XP_Power_STH U6
U 1 1 60D68665
P 2500 8400
F 0 "U6" H 2500 8465 50  0000 C CNN
F 1 "XP_Power_STH" H 2500 8374 50  0000 C CNN
F 2 "custom_footprints:STH0548S3V3" H 2500 8400 50  0001 C CNN
F 3 "" H 2500 8400 50  0001 C CNN
F 4 "1" H 2500 8400 50  0001 C CNN "min_qty"
F 5 "8.94" H 2500 8400 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/xp-power/sth0548s05/dc-dc-converter-5v-0-5a/dp/3212470" H 2500 8400 50  0001 C CNN "purchase_link"
	1    2500 8400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 60E01756
P 3300 9300
F 0 "#PWR0105" H 3300 9050 50  0001 C CNN
F 1 "GND" H 3305 9127 50  0000 C CNN
F 2 "" H 3300 9300 50  0001 C CNN
F 3 "" H 3300 9300 50  0001 C CNN
	1    3300 9300
	1    0    0    -1  
$EndComp
Connection ~ 2500 9200
Wire Wire Line
	2500 9200 2550 9200
$Comp
L Device:R R25
U 1 1 60E0D84F
P 3300 9150
F 0 "R25" H 3370 9196 50  0000 L CNN
F 1 "R" H 3370 9105 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3230 9150 50  0001 C CNN
F 3 "~" H 3300 9150 50  0001 C CNN
	1    3300 9150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 60E0E529
P 3300 8850
F 0 "R24" H 3230 8804 50  0000 R CNN
F 1 "R" H 3230 8895 50  0000 R CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3230 8850 50  0001 C CNN
F 3 "~" H 3300 8850 50  0001 C CNN
	1    3300 8850
	-1   0    0    1   
$EndComp
Wire Wire Line
	1200 8450 1200 8650
Wire Wire Line
	3050 8800 3050 9000
Wire Wire Line
	3050 9000 3300 9000
Connection ~ 3300 9000
Wire Wire Line
	1950 8650 1200 8650
Connection ~ 1200 8650
Wire Wire Line
	1200 8650 1200 8850
NoConn ~ 1950 8800
Wire Wire Line
	3300 8700 3300 8650
Wire Wire Line
	3050 8650 3300 8650
Wire Wire Line
	3300 8650 3550 8650
Connection ~ 3300 8650
Connection ~ 3550 8650
Wire Wire Line
	3550 8650 3550 8500
Wire Wire Line
	8350 6600 8550 6600
$Comp
L power:+3.3V #PWR0106
U 1 1 60F54529
P 7600 6600
F 0 "#PWR0106" H 7600 6450 50  0001 C CNN
F 1 "+3.3V" H 7615 6773 50  0000 C CNN
F 2 "" H 7600 6600 50  0001 C CNN
F 3 "" H 7600 6600 50  0001 C CNN
	1    7600 6600
	1    0    0    -1  
$EndComp
Wire Notes Line
	8050 1700 9650 1700
Text Notes 8150 750  0    50   ~ 0
Connector for misc adc inputs(Grove)
Text Notes 8150 1850 0    50   ~ 0
E bike batt power input
$Comp
L custom_symbols:VBATT #PWR090
U 1 1 60F966C2
P 8200 2550
F 0 "#PWR090" H 8200 2400 50  0001 C CNN
F 1 "VBATT" H 8215 2723 50  0000 C CNN
F 2 "" H 8200 2550 50  0001 C CNN
F 3 "" H 8200 2550 50  0001 C CNN
	1    8200 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 2550 8200 2600
Wire Wire Line
	8650 2150 8400 2150
Wire Wire Line
	8400 2150 8400 2250
$Comp
L power:GND #PWR091
U 1 1 60FB0CB3
P 8400 2250
F 0 "#PWR091" H 8400 2000 50  0001 C CNN
F 1 "GND" V 8400 2050 50  0000 C CNN
F 2 "" H 8400 2250 50  0001 C CNN
F 3 "" H 8400 2250 50  0001 C CNN
	1    8400 2250
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J9
U 1 1 60FB896F
P 7400 2150
F 0 "J9" H 7480 2142 50  0000 L CNN
F 1 "Conn_01x04" H 7480 2051 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4-5.08_1x04_P5.08mm_Horizontal" H 7400 2150 50  0001 C CNN
F 3 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 7400 2150 50  0001 C CNN
F 4 "1" H 7400 2150 50  0001 C CNN "min_qty"
F 5 "0.94" H 7400 2150 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 7400 2150 50  0001 C CNN "purchase_link"
	1    7400 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	14500 4250 14800 4250
Wire Wire Line
	15150 4250 15450 4250
Wire Wire Line
	14950 4250 15150 4250
Connection ~ 14950 4250
Connection ~ 15150 4250
Connection ~ 14800 4250
Wire Wire Line
	14800 4250 14950 4250
Wire Wire Line
	14500 4850 14500 5250
Text Label 14800 5250 1    50   ~ 0
SCL1
Text Label 14500 5250 1    50   ~ 0
SDA1
$Comp
L Device:R R7
U 1 1 6016D596
P 14500 4700
F 0 "R7" H 14570 4746 50  0000 L CNN
F 1 "4.7k" H 14570 4655 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 14430 4700 50  0001 C CNN
F 3 "~" H 14500 4700 50  0001 C CNN
	1    14500 4700
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR040
U 1 1 6017645E
P 14950 4250
F 0 "#PWR040" H 14950 4100 50  0001 C CNN
F 1 "+3.3V" H 14965 4423 50  0000 C CNN
F 2 "" H 14950 4250 50  0001 C CNN
F 3 "" H 14950 4250 50  0001 C CNN
	1    14950 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	14500 4550 14500 4250
Text Notes 14850 4000 0    50   ~ 0
Pullup I2C
Wire Wire Line
	15150 4550 15150 4250
$Comp
L Device:R R9
U 1 1 601C8D39
P 15150 4700
F 0 "R9" H 15220 4746 50  0000 L CNN
F 1 "4.7k" H 15220 4655 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 15080 4700 50  0001 C CNN
F 3 "~" H 15150 4700 50  0001 C CNN
	1    15150 4700
	1    0    0    -1  
$EndComp
Text Label 15150 5250 1    50   ~ 0
SDA2
Text Label 15450 5250 1    50   ~ 0
SCL2
Wire Wire Line
	15150 4850 15150 5250
Wire Wire Line
	14800 4250 14800 4550
$Comp
L Device:R R8
U 1 1 6016E102
P 14800 4700
F 0 "R8" H 14870 4746 50  0000 L CNN
F 1 "4.7k" H 14870 4655 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 14730 4700 50  0001 C CNN
F 3 "~" H 14800 4700 50  0001 C CNN
	1    14800 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	14800 4850 14800 5250
Text Notes 9750 900  0    50   ~ 0
Uses I2C2
Text Notes 4300 2000 0    50   ~ 0
Uses I2C1
Text Notes 4350 8550 0    50   ~ 0
Uses I2C1
Text Notes 7250 8450 0    50   ~ 0
Uses I2C1
Wire Notes Line
	9900 3000 11150 3000
Wire Notes Line
	11150 3000 11150 5000
Wire Notes Line
	11150 5000 9900 5000
Wire Notes Line
	14300 3750 14300 5350
Wire Notes Line
	14300 5350 15700 5350
Wire Notes Line
	15700 5350 15700 3750
Wire Notes Line
	15700 3750 14300 3750
Text Notes 6450 900  0    50   ~ 0
Misc power output
Wire Notes Line
	3950 600  15300 600 
Wire Notes Line
	3950 2650 15300 2650
Wire Notes Line
	15300 600  15300 2650
$Comp
L Connector_Generic:Conn_01x04 J8
U 1 1 6112CCC8
P 8850 2250
F 0 "J8" H 8930 2242 50  0000 L CNN
F 1 "Conn_01x04" H 8930 2151 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4-5.08_1x04_P5.08mm_Horizontal" H 8850 2250 50  0001 C CNN
F 3 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 8850 2250 50  0001 C CNN
F 4 "1" H 8850 2250 50  0001 C CNN "min_qty"
F 5 "0.94" H 8850 2250 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/camdenboss/ctbp0108-2/tb-wire-to-brd-2way-12awg/dp/3228564" H 8850 2250 50  0001 C CNN "purchase_link"
	1    8850 2250
	1    0    0    -1  
$EndComp
Connection ~ 12150 1050
Wire Wire Line
	11800 1050 12150 1050
$Comp
L Device:C C10
U 1 1 6070F07E
P 12150 1200
AR Path="/6070F07E" Ref="C10"  Part="1" 
AR Path="/60156738/6070F07E" Ref="C?"  Part="1" 
AR Path="/601BF9C2/6070F07E" Ref="C?"  Part="1" 
AR Path="/601E52DF/6070F07E" Ref="C?"  Part="1" 
AR Path="/6018BFA2/6070F07E" Ref="C?"  Part="1" 
AR Path="/6040F615/6070F07E" Ref="C?"  Part="1" 
AR Path="/6042797A/6070F07E" Ref="C?"  Part="1" 
AR Path="/6045D11E/6070F07E" Ref="C?"  Part="1" 
AR Path="/60465E6A/6070F07E" Ref="C?"  Part="1" 
AR Path="/6049D147/6070F07E" Ref="C?"  Part="1" 
F 0 "C10" H 12265 1246 50  0000 L CNN
F 1 "100nF" H 12265 1155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 12188 1050 50  0001 C CNN
F 3 "~" H 12150 1200 50  0001 C CNN
F 4 "0.0271" H 12150 1200 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 12150 1200 50  0001 C CNN "purchase_link"
	1    12150 1200
	1    0    0    -1  
$EndComp
$Comp
L Diode:BAT54S D9
U 1 1 606F9F00
P 12850 2100
AR Path="/606F9F00" Ref="D9"  Part="1" 
AR Path="/60156738/606F9F00" Ref="D?"  Part="1" 
AR Path="/601BF9C2/606F9F00" Ref="D?"  Part="1" 
AR Path="/601E52DF/606F9F00" Ref="D?"  Part="1" 
AR Path="/6018BFA2/606F9F00" Ref="D?"  Part="1" 
AR Path="/6040F615/606F9F00" Ref="D?"  Part="1" 
AR Path="/6042797A/606F9F00" Ref="D?"  Part="1" 
AR Path="/6045D11E/606F9F00" Ref="D?"  Part="1" 
AR Path="/60465E6A/606F9F00" Ref="D?"  Part="1" 
AR Path="/6049D147/606F9F00" Ref="D?"  Part="1" 
F 0 "D9" V 12896 2188 50  0000 L CNN
F 1 "BAT54S" V 12805 2188 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 12925 2225 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 12730 2100 50  0001 C CNN
F 4 "5" H 12850 2100 50  0001 C CNN "min_qty"
F 5 "0.1332" H 12850 2100 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/nexperia/bat54s-215/diode-schoty-dual-30v-0-2a-sot23/dp/1081194?st=bat54s" H 12850 2100 50  0001 C CNN "purchase_link"
	1    12850 2100
	0    1    -1   0   
$EndComp
Wire Wire Line
	12150 2100 12650 2100
$Comp
L Diode:BAT54S D8
U 1 1 6070F08A
P 12650 1050
AR Path="/6070F08A" Ref="D8"  Part="1" 
AR Path="/60156738/6070F08A" Ref="D?"  Part="1" 
AR Path="/601BF9C2/6070F08A" Ref="D?"  Part="1" 
AR Path="/601E52DF/6070F08A" Ref="D?"  Part="1" 
AR Path="/6018BFA2/6070F08A" Ref="D?"  Part="1" 
AR Path="/6040F615/6070F08A" Ref="D?"  Part="1" 
AR Path="/6042797A/6070F08A" Ref="D?"  Part="1" 
AR Path="/6045D11E/6070F08A" Ref="D?"  Part="1" 
AR Path="/60465E6A/6070F08A" Ref="D?"  Part="1" 
AR Path="/6049D147/6070F08A" Ref="D?"  Part="1" 
F 0 "D8" V 12696 1138 50  0000 L CNN
F 1 "BAT54S" V 12605 1138 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 12725 1175 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 12530 1050 50  0001 C CNN
F 4 "5" H 12650 1050 50  0001 C CNN "min_qty"
F 5 "0.1332" H 12650 1050 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/nexperia/bat54s-215/diode-schoty-dual-30v-0-2a-sot23/dp/1081194?st=bat54s" H 12650 1050 50  0001 C CNN "purchase_link"
	1    12650 1050
	0    1    -1   0   
$EndComp
Wire Wire Line
	12150 1050 12450 1050
Wire Wire Line
	12150 850  12150 1050
Wire Wire Line
	12150 2100 12150 1900
NoConn ~ 5950 9500
NoConn ~ 5950 9600
Wire Wire Line
	10950 3850 10950 4600
Connection ~ 10950 4600
NoConn ~ 10650 4200
NoConn ~ 10650 3450
Wire Wire Line
	8650 2600 8650 2450
Wire Wire Line
	8200 2600 8650 2600
Text Notes 700  7950 0    50   ~ 10
Power supply
Wire Notes Line
	7500 6950 8600 6950
Connection ~ 5350 9200
Wire Notes Line
	2450 7850 6950 7850
Text Notes 6850 8100 0    50   ~ 10
Sensors
Text Notes 4350 8450 0    50   ~ 0
Acclerometer/gyro
$Comp
L power:GND #PWR017
U 1 1 60287457
P 5600 9050
F 0 "#PWR017" H 5600 8800 50  0001 C CNN
F 1 "GND" H 5605 8877 50  0000 C CNN
F 2 "" H 5600 9050 50  0001 C CNN
F 3 "" H 5600 9050 50  0001 C CNN
	1    5600 9050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 6028744D
P 5600 8900
F 0 "C2" H 5715 8946 50  0000 L CNN
F 1 "100nF" H 5715 8855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5638 8750 50  0001 C CNN
F 3 "~" H 5600 8900 50  0001 C CNN
F 4 "0.0271" H 5600 8900 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 5600 8900 50  0001 C CNN "purchase_link"
	1    5600 8900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 8750 5350 8750
Connection ~ 5350 8750
Wire Wire Line
	5350 8750 5350 9200
$Comp
L power:+3.3V #PWR010
U 1 1 60287440
P 5350 8750
F 0 "#PWR010" H 5350 8600 50  0001 C CNN
F 1 "+3.3V" H 5365 8923 50  0000 C CNN
F 2 "" H 5350 8750 50  0001 C CNN
F 3 "" H 5350 8750 50  0001 C CNN
	1    5350 8750
	1    0    0    -1  
$EndComp
Wire Notes Line
	9750 8150 4050 8150
Text Notes 10200 5850 0    50   ~ 10
Programming
$EndSCHEMATC
