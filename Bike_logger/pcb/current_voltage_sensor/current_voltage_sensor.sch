EESchema Schematic File Version 4
LIBS:current_voltage_sensor-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Design of the shunt module"
Date "2021-01-29"
Rev ""
Comp ""
Comment1 "The design features a shunt resistor and the LTC4151 to convert"
Comment2 "the analogue signal to a digital I2C signal."
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 6015676D
P 9450 2800
F 0 "J1" H 9530 2792 50  0000 L CNN
F 1 "Conn_01x04" H 9530 2701 50  0000 L CNN
F 2 "Connector:NS-Tech_Grove_1x04_P2mm_Vertical" H 9450 2800 50  0001 C CNN
F 3 "~" H 9450 2800 50  0001 C CNN
	1    9450 2800
	1    0    0    -1  
$EndComp
Text Label 7100 3350 2    50   ~ 0
SCL
Text Label 7100 3450 2    50   ~ 0
SDA
Text Label 9000 2700 0    50   ~ 0
SCL
Wire Wire Line
	9250 2700 9000 2700
Text Label 9000 2800 0    50   ~ 0
SDA
Wire Wire Line
	9250 2800 9000 2800
Wire Wire Line
	9250 3000 9150 3000
Wire Wire Line
	9150 3000 9150 3100
$Comp
L power:GND #PWR05
U 1 1 6015C57C
P 9150 3100
F 0 "#PWR05" H 9150 2850 50  0001 C CNN
F 1 "GND" H 9155 2927 50  0000 C CNN
F 2 "" H 9150 3100 50  0001 C CNN
F 3 "" H 9150 3100 50  0001 C CNN
	1    9150 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 6015DC4C
P 6650 4100
F 0 "#PWR03" H 6650 3850 50  0001 C CNN
F 1 "GND" H 6655 3927 50  0000 C CNN
F 2 "" H 6650 4100 50  0001 C CNN
F 3 "" H 6650 4100 50  0001 C CNN
	1    6650 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 3650 6650 3650
Wire Wire Line
	6650 3650 6650 4100
Wire Wire Line
	9250 2900 8800 2900
Wire Wire Line
	8800 2900 8800 2850
$Comp
L power:+3.3V #PWR04
U 1 1 6015E541
P 8800 2850
F 0 "#PWR04" H 8800 2700 50  0001 C CNN
F 1 "+3.3V" H 8815 3023 50  0000 C CNN
F 2 "" H 8800 2850 50  0001 C CNN
F 3 "" H 8800 2850 50  0001 C CNN
	1    8800 2850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 6016433A
P 3550 2250
F 0 "R1" V 3343 2250 50  0000 C CNN
F 1 "0.02 ohm" V 3434 2250 50  0000 C CNN
F 2 "Resistor_SMD:R_Shunt_Ohmite_LVK25" V 3480 2250 50  0001 C CNN
F 3 "~" H 3550 2250 50  0001 C CNN
	1    3550 2250
	0    1    1    0   
$EndComp
Wire Wire Line
	3400 2250 3200 2250
Wire Wire Line
	3700 2250 3850 2250
Text Label 3200 2450 3    50   ~ 0
SENSE+
Wire Wire Line
	3200 2250 3200 2450
Connection ~ 3200 2250
Wire Wire Line
	3200 2250 2750 2250
Text Label 3850 2450 3    50   ~ 0
SENSE-
Wire Wire Line
	3850 2450 3850 2250
Connection ~ 3850 2250
Wire Wire Line
	3850 2250 4200 2250
Text Label 2750 2250 0    50   ~ 0
Vin
Text Label 4200 2250 2    50   ~ 0
Vout
Text Label 5050 3450 0    50   ~ 0
SENSE+
Text Label 5050 3350 0    50   ~ 0
SENSE-
Text Label 5050 3550 0    50   ~ 0
Vin
$Comp
L power:GND #PWR01
U 1 1 60169873
P 3800 3500
F 0 "#PWR01" H 3800 3250 50  0001 C CNN
F 1 "GND" H 3805 3327 50  0000 C CNN
F 2 "" H 3800 3500 50  0001 C CNN
F 3 "" H 3800 3500 50  0001 C CNN
	1    3800 3500
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP1
U 1 1 6016B1C6
P 7200 3550
F 0 "TP1" V 7154 3738 50  0000 L CNN
F 1 "TestPoint" V 7245 3738 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 7400 3550 50  0001 C CNN
F 3 "~" H 7400 3550 50  0001 C CNN
	1    7200 3550
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 6016EB9B
P 7200 3750
F 0 "TP2" V 7154 3938 50  0000 L CNN
F 1 "TestPoint" V 7245 3938 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 7400 3750 50  0001 C CNN
F 3 "~" H 7400 3750 50  0001 C CNN
	1    7200 3750
	0    1    1    0   
$EndComp
Wire Wire Line
	6400 3550 7200 3550
Wire Wire Line
	6400 3750 7200 3750
Wire Wire Line
	5050 3450 5400 3450
Wire Wire Line
	5050 3350 5400 3350
Wire Wire Line
	5050 3550 5400 3550
Text Label 2900 3500 0    50   ~ 0
Vin
Wire Wire Line
	5400 3650 5050 3650
Wire Wire Line
	5400 3750 5050 3750
Text Label 5050 3650 0    50   ~ 0
ADR1
Text Label 5050 3750 0    50   ~ 0
ADR0
Text Label 3400 3800 3    50   ~ 0
ADR1
Wire Wire Line
	2900 3500 3200 3500
Wire Wire Line
	3800 3500 3600 3500
Wire Wire Line
	3400 3650 3400 3800
$Comp
L Connector_Generic:Conn_01x01 J2
U 1 1 6018A246
P 9200 4200
F 0 "J2" H 9280 4242 50  0000 L CNN
F 1 "Conn_01x01" H 9280 4151 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282834-2_1x02_P2.54mm_Horizontal" H 9200 4200 50  0001 C CNN
F 3 "~" H 9200 4200 50  0001 C CNN
	1    9200 4200
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J3
U 1 1 6018A9BE
P 9200 4450
F 0 "J3" H 9280 4492 50  0000 L CNN
F 1 "Conn_01x01" H 9280 4401 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282834-2_1x02_P2.54mm_Horizontal" H 9200 4450 50  0001 C CNN
F 3 "~" H 9200 4450 50  0001 C CNN
	1    9200 4450
	1    0    0    -1  
$EndComp
Text Label 8750 4200 0    50   ~ 0
Vout
Text Label 8750 4450 0    50   ~ 0
Vin
Wire Wire Line
	8750 4450 9000 4450
Wire Wire Line
	9000 4200 8750 4200
$Comp
L Jumper:SolderJumper_3_Open JP2
U 1 1 60192D28
P 3400 3500
F 0 "JP2" H 3400 3705 50  0000 C CNN
F 1 "SolderJumper_3_Open" H 3400 3614 50  0000 C CNN
F 2 "Jumper:SolderJumper-3_P2.0mm_Open_TrianglePad1.0x1.5mm_NumberLabels" H 3400 3500 50  0001 C CNN
F 3 "~" H 3400 3500 50  0001 C CNN
	1    3400 3500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 6019AFDD
P 3750 4450
F 0 "#PWR06" H 3750 4200 50  0001 C CNN
F 1 "GND" H 3755 4277 50  0000 C CNN
F 2 "" H 3750 4450 50  0001 C CNN
F 3 "" H 3750 4450 50  0001 C CNN
	1    3750 4450
	1    0    0    -1  
$EndComp
Text Label 2850 4450 0    50   ~ 0
Vin
Wire Wire Line
	2850 4450 3150 4450
Wire Wire Line
	3750 4450 3550 4450
Wire Wire Line
	3350 4600 3350 4750
$Comp
L Jumper:SolderJumper_3_Open JP1
U 1 1 6019AFEC
P 3350 4450
F 0 "JP1" H 3350 4655 50  0000 C CNN
F 1 "SolderJumper_3_Open" H 3350 4564 50  0000 C CNN
F 2 "Jumper:SolderJumper-3_P2.0mm_Open_TrianglePad1.0x1.5mm_NumberLabels" H 3350 4450 50  0001 C CNN
F 3 "~" H 3350 4450 50  0001 C CNN
	1    3350 4450
	1    0    0    -1  
$EndComp
Text Label 3350 4750 3    50   ~ 0
ADR0
Wire Notes Line
	2350 3100 4500 3100
Wire Notes Line
	4500 3100 4500 5350
Wire Notes Line
	4500 5350 2350 5350
Wire Notes Line
	2350 5350 2350 3100
Text Notes 2450 3200 0    50   ~ 0
I2C address selection
Text Notes 2650 1800 0    50   ~ 0
Shunt resistor section
Wire Notes Line
	2450 1650 2450 2900
Wire Notes Line
	2450 2900 4450 2900
Wire Notes Line
	4450 2900 4450 1650
Wire Notes Line
	4450 1650 2450 1650
Wire Notes Line
	8450 5000 10350 5000
Wire Notes Line
	10350 5000 10350 2350
Wire Notes Line
	10350 2350 8450 2350
Wire Notes Line
	8450 3600 10350 3600
Wire Notes Line
	8450 2350 8450 5000
Text Notes 8600 2500 0    50   ~ 0
Connection to mother board
Text Notes 8550 3800 0    50   ~ 0
Connection to High current path to measure
Text Notes 5150 2250 0    50   ~ 0
LTC4151 sensor IC
Wire Notes Line
	4750 1900 4750 4900
Wire Notes Line
	4750 4900 7900 4900
Wire Notes Line
	7900 4900 7900 1900
Wire Notes Line
	7900 1900 4750 1900
$Comp
L Connector:TestPoint TP3
U 1 1 601F9105
P 6500 2900
F 0 "TP3" V 6454 3088 50  0000 L CNN
F 1 "TestPoint" V 6545 3088 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 6700 2900 50  0001 C CNN
F 3 "~" H 6700 2900 50  0001 C CNN
	1    6500 2900
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 601F910F
P 6750 3000
F 0 "TP4" V 6704 3188 50  0000 L CNN
F 1 "TestPoint" V 6795 3188 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 6950 3000 50  0001 C CNN
F 3 "~" H 6950 3000 50  0001 C CNN
	1    6750 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3350 6500 2900
Wire Wire Line
	6750 3450 6750 3000
Text Label 4250 6800 1    50   ~ 0
SCL
Text Label 4000 6800 1    50   ~ 0
SDA
$Comp
L Device:R R2
U 1 1 601FDDA5
P 4000 6400
F 0 "R2" H 4070 6446 50  0000 L CNN
F 1 "2K" H 4070 6355 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3930 6400 50  0001 C CNN
F 3 "~" H 4000 6400 50  0001 C CNN
	1    4000 6400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 601FDDAF
P 4250 6400
F 0 "R3" H 4320 6446 50  0000 L CNN
F 1 "2K" H 4320 6355 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4180 6400 50  0001 C CNN
F 3 "~" H 4250 6400 50  0001 C CNN
	1    4250 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 6550 4000 6800
$Comp
L power:+3.3V #PWR02
U 1 1 601FDDC0
P 4100 6000
F 0 "#PWR02" H 4100 5850 50  0001 C CNN
F 1 "+3.3V" H 4115 6173 50  0000 C CNN
F 2 "" H 4100 6000 50  0001 C CNN
F 3 "" H 4100 6000 50  0001 C CNN
	1    4100 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 6250 4000 6100
Wire Wire Line
	4000 6100 4100 6100
Wire Wire Line
	4100 6100 4100 6000
Wire Wire Line
	4250 6100 4100 6100
Connection ~ 4100 6100
Wire Wire Line
	4250 6100 4250 6250
$Comp
L custom_symbols:LTC4151 U1
U 1 1 6015A2EC
P 5900 3250
F 0 "U1" H 5900 3415 50  0000 C CNN
F 1 "LTC4151" H 5900 3324 50  0000 C CNN
F 2 "Package_DFN_QFN:DFN-10-1EP_3x3mm_P0.5mm_EP1.55x2.48mm" H 5800 3250 50  0001 C CNN
F 3 "" H 5800 3250 50  0001 C CNN
F 4 "1" H 5900 3250 50  0001 C CNN "min_qty"
F 5 "1.96" H 5900 3250 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/linear-technology/ltc4151cdd-pbf/monitor-current-voltage-i2c-10dfn/dp/2295457?scope=partnumberlookahead&ost=LTC4151CDD%23PBF&searchref=searchlookahead&exaMfpn=true" H 5900 3250 50  0001 C CNN "purchase_link"
	1    5900 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 3350 6500 3350
Wire Wire Line
	6400 3450 6750 3450
Connection ~ 6750 3450
Wire Wire Line
	6750 3450 7100 3450
Connection ~ 6500 3350
Wire Wire Line
	6500 3350 7100 3350
Wire Wire Line
	4250 6550 4250 6800
Wire Notes Line
	3600 5600 4700 5600
Wire Notes Line
	4700 5600 4700 7150
Wire Notes Line
	4700 7150 3600 7150
Wire Notes Line
	3600 7150 3600 5600
Text Notes 3750 5700 0    50   ~ 0
I2C pullups
$Comp
L Connector:TestPoint TP5
U 1 1 60217198
P 6400 5600
F 0 "TP5" V 6354 5788 50  0000 L CNN
F 1 "TestPoint" V 6445 5788 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 6600 5600 50  0001 C CNN
F 3 "~" H 6600 5600 50  0001 C CNN
	1    6400 5600
	0    1    1    0   
$EndComp
Wire Wire Line
	5950 5600 6400 5600
Text Label 5950 5600 0    50   ~ 0
Vin
$Comp
L Connector:TestPoint TP6
U 1 1 6021987E
P 6400 5800
F 0 "TP6" V 6354 5988 50  0000 L CNN
F 1 "TestPoint" V 6445 5988 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_D2.0mm_Drill1.0mm" H 6600 5800 50  0001 C CNN
F 3 "~" H 6600 5800 50  0001 C CNN
	1    6400 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	5950 5800 6400 5800
Text Label 5950 5800 0    50   ~ 0
SENSE-
Wire Notes Line
	5500 5250 7300 5250
Wire Notes Line
	7300 5250 7300 6150
Wire Notes Line
	7300 6150 5500 6150
Wire Notes Line
	5500 6150 5500 5250
Text Notes 5550 5400 0    50   ~ 0
Test points to verify voltage drop
$Comp
L Analog_ADC:INA226 U?
U 1 1 6021BFB1
P 13200 3700
F 0 "U?" H 13200 4381 50  0000 C CNN
F 1 "INA226" H 13200 4290 50  0000 C CNN
F 2 "Package_SO:MSOP-10_3x3mm_P0.5mm" H 13250 3800 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ina226.pdf" H 13550 3600 50  0001 C CNN
	1    13200 3700
	1    0    0    -1  
$EndComp
$EndSCHEMATC
