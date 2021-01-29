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
Comment1 "The design features a shunt resistor and the LTC4151 to convert the analogue signal to a digital I2C signal."
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 6015676D
P 8600 3550
F 0 "J1" H 8680 3542 50  0000 L CNN
F 1 "Conn_01x04" H 8680 3451 50  0000 L CNN
F 2 "Connector:NS-Tech_Grove_1x04_P2mm_Vertical" H 8600 3550 50  0001 C CNN
F 3 "~" H 8600 3550 50  0001 C CNN
	1    8600 3550
	1    0    0    -1  
$EndComp
Text Label 7100 3350 2    50   ~ 0
SCL
Wire Wire Line
	6400 3350 6750 3350
Text Label 7100 3450 2    50   ~ 0
SDA
Text Label 8150 3450 0    50   ~ 0
SCL
Wire Wire Line
	8400 3450 8150 3450
Text Label 8150 3550 0    50   ~ 0
SDA
Wire Wire Line
	8400 3550 8150 3550
Wire Wire Line
	8400 3750 8300 3750
Wire Wire Line
	8300 3750 8300 3850
$Comp
L power:GND #PWR05
U 1 1 6015C57C
P 8300 3850
F 0 "#PWR05" H 8300 3600 50  0001 C CNN
F 1 "GND" H 8305 3677 50  0000 C CNN
F 2 "" H 8300 3850 50  0001 C CNN
F 3 "" H 8300 3850 50  0001 C CNN
	1    8300 3850
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
	8400 3650 7950 3650
Wire Wire Line
	7950 3650 7950 3600
$Comp
L power:+3.3V #PWR04
U 1 1 6015E541
P 7950 3600
F 0 "#PWR04" H 7950 3450 50  0001 C CNN
F 1 "+3.3V" H 7965 3773 50  0000 C CNN
F 2 "" H 7950 3600 50  0001 C CNN
F 3 "" H 7950 3600 50  0001 C CNN
	1    7950 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 60160E84
P 6500 3050
F 0 "R2" H 6570 3096 50  0000 L CNN
F 1 "2K" H 6570 3005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6430 3050 50  0001 C CNN
F 3 "~" H 6500 3050 50  0001 C CNN
	1    6500 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 601617D0
P 6750 3050
F 0 "R3" H 6820 3096 50  0000 L CNN
F 1 "2K" H 6820 3005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 6680 3050 50  0001 C CNN
F 3 "~" H 6750 3050 50  0001 C CNN
	1    6750 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 3200 6500 3450
Wire Wire Line
	6400 3450 6500 3450
Connection ~ 6500 3450
Wire Wire Line
	6500 3450 7100 3450
Wire Wire Line
	6750 3200 6750 3350
Connection ~ 6750 3350
Wire Wire Line
	6750 3350 7100 3350
$Comp
L power:+3.3V #PWR02
U 1 1 601621A6
P 6600 2650
F 0 "#PWR02" H 6600 2500 50  0001 C CNN
F 1 "+3.3V" H 6615 2823 50  0000 C CNN
F 2 "" H 6600 2650 50  0001 C CNN
F 3 "" H 6600 2650 50  0001 C CNN
	1    6600 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 2900 6500 2750
Wire Wire Line
	6500 2750 6600 2750
Wire Wire Line
	6600 2750 6600 2650
Wire Wire Line
	6750 2750 6600 2750
Connection ~ 6600 2750
Wire Wire Line
	6750 2750 6750 2900
$Comp
L Device:R R1
U 1 1 6016433A
P 4650 2250
F 0 "R1" V 4443 2250 50  0000 C CNN
F 1 "0.02 ohm" V 4534 2250 50  0000 C CNN
F 2 "Resistor_SMD:R_Shunt_Ohmite_LVK25" V 4580 2250 50  0001 C CNN
F 3 "~" H 4650 2250 50  0001 C CNN
	1    4650 2250
	0    1    1    0   
$EndComp
Wire Wire Line
	4500 2250 4300 2250
Wire Wire Line
	4800 2250 4950 2250
Text Label 4300 2450 3    50   ~ 0
SENSE+
Wire Wire Line
	4300 2250 4300 2450
Connection ~ 4300 2250
Wire Wire Line
	4300 2250 3850 2250
Text Label 4950 2450 3    50   ~ 0
SENSE-
Wire Wire Line
	4950 2450 4950 2250
Connection ~ 4950 2250
Wire Wire Line
	4950 2250 5300 2250
Text Label 3850 2250 0    50   ~ 0
Vin
Text Label 5300 2250 2    50   ~ 0
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
P 6700 4600
F 0 "J2" H 6780 4642 50  0000 L CNN
F 1 "Conn_01x01" H 6780 4551 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282834-2_1x02_P2.54mm_Horizontal" H 6700 4600 50  0001 C CNN
F 3 "~" H 6700 4600 50  0001 C CNN
	1    6700 4600
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x01 J3
U 1 1 6018A9BE
P 6700 4850
F 0 "J3" H 6780 4892 50  0000 L CNN
F 1 "Conn_01x01" H 6780 4801 50  0000 L CNN
F 2 "TerminalBlock_TE-Connectivity:TerminalBlock_TE_282834-2_1x02_P2.54mm_Horizontal" H 6700 4850 50  0001 C CNN
F 3 "~" H 6700 4850 50  0001 C CNN
	1    6700 4850
	1    0    0    -1  
$EndComp
Text Label 6250 4600 0    50   ~ 0
Vout
Text Label 6250 4850 0    50   ~ 0
Vin
Wire Wire Line
	6250 4850 6500 4850
Wire Wire Line
	6500 4600 6250 4600
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
$EndSCHEMATC
