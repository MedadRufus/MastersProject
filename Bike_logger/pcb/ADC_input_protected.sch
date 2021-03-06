EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 11 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R?
U 1 1 60179E16
P 5950 2950
AR Path="/60179E16" Ref="R?"  Part="1" 
AR Path="/60156738/60179E16" Ref="R1"  Part="1" 
AR Path="/601BF9C2/60179E16" Ref="R5"  Part="1" 
AR Path="/601E52DF/60179E16" Ref="R?"  Part="1" 
AR Path="/6018BFA2/60179E16" Ref="R?"  Part="1" 
AR Path="/6040F615/60179E16" Ref="R15"  Part="1" 
AR Path="/6042797A/60179E16" Ref="R17"  Part="1" 
AR Path="/6045D11E/60179E16" Ref="R?"  Part="1" 
AR Path="/60465E6A/60179E16" Ref="R19"  Part="1" 
AR Path="/6049D147/60179E16" Ref="R21"  Part="1" 
F 0 "R21" H 6020 2996 50  0000 L CNN
F 1 "R" H 6020 2905 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5880 2950 50  0001 C CNN
F 3 "~" H 5950 2950 50  0001 C CNN
	1    5950 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 60179E1C
P 5950 3250
AR Path="/60179E1C" Ref="R?"  Part="1" 
AR Path="/60156738/60179E1C" Ref="R2"  Part="1" 
AR Path="/601BF9C2/60179E1C" Ref="R6"  Part="1" 
AR Path="/601E52DF/60179E1C" Ref="R?"  Part="1" 
AR Path="/6018BFA2/60179E1C" Ref="R?"  Part="1" 
AR Path="/6040F615/60179E1C" Ref="R16"  Part="1" 
AR Path="/6042797A/60179E1C" Ref="R18"  Part="1" 
AR Path="/6045D11E/60179E1C" Ref="R?"  Part="1" 
AR Path="/60465E6A/60179E1C" Ref="R20"  Part="1" 
AR Path="/6049D147/60179E1C" Ref="R22"  Part="1" 
F 0 "R22" H 6020 3296 50  0000 L CNN
F 1 "R" H 6020 3205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5880 3250 50  0001 C CNN
F 3 "~" H 5950 3250 50  0001 C CNN
	1    5950 3250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60179E22
P 5950 3400
AR Path="/60179E22" Ref="#PWR?"  Part="1" 
AR Path="/60156738/60179E22" Ref="#PWR014"  Part="1" 
AR Path="/601BF9C2/60179E22" Ref="#PWR024"  Part="1" 
AR Path="/601E52DF/60179E22" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/60179E22" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/60179E22" Ref="#PWR046"  Part="1" 
AR Path="/6042797A/60179E22" Ref="#PWR050"  Part="1" 
AR Path="/6045D11E/60179E22" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/60179E22" Ref="#PWR054"  Part="1" 
AR Path="/6049D147/60179E22" Ref="#PWR058"  Part="1" 
F 0 "#PWR058" H 5950 3150 50  0001 C CNN
F 1 "GND" H 5955 3227 50  0000 C CNN
F 2 "" H 5950 3400 50  0001 C CNN
F 3 "" H 5950 3400 50  0001 C CNN
	1    5950 3400
	1    0    0    -1  
$EndComp
Connection ~ 5950 3100
$Comp
L Device:C C?
U 1 1 60179E2C
P 6300 3250
AR Path="/60179E2C" Ref="C?"  Part="1" 
AR Path="/60156738/60179E2C" Ref="C1"  Part="1" 
AR Path="/601BF9C2/60179E2C" Ref="C6"  Part="1" 
AR Path="/601E52DF/60179E2C" Ref="C?"  Part="1" 
AR Path="/6018BFA2/60179E2C" Ref="C?"  Part="1" 
AR Path="/6040F615/60179E2C" Ref="C3"  Part="1" 
AR Path="/6042797A/60179E2C" Ref="C7"  Part="1" 
AR Path="/6045D11E/60179E2C" Ref="C?"  Part="1" 
AR Path="/60465E6A/60179E2C" Ref="C8"  Part="1" 
AR Path="/6049D147/60179E2C" Ref="C9"  Part="1" 
F 0 "C9" H 6415 3296 50  0000 L CNN
F 1 "100nF" H 6415 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6338 3100 50  0001 C CNN
F 3 "~" H 6300 3250 50  0001 C CNN
F 4 "0.0271" H 6300 3250 50  0001 C CNN "price"
F 5 "https://uk.farnell.com/avx/0402yc104kat2a/cap-0-1-f-16v-10-x7r-0402/dp/1833861" H 6300 3250 50  0001 C CNN "purchase_link"
	1    6300 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 3100 6300 3100
Text HLabel 7200 2450 2    50   Input ~ 0
protected_adc_input
$Comp
L power:GND #PWR?
U 1 1 6017A19E
P 6300 3400
AR Path="/6017A19E" Ref="#PWR?"  Part="1" 
AR Path="/60156738/6017A19E" Ref="#PWR018"  Part="1" 
AR Path="/601BF9C2/6017A19E" Ref="#PWR025"  Part="1" 
AR Path="/601E52DF/6017A19E" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/6017A19E" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/6017A19E" Ref="#PWR047"  Part="1" 
AR Path="/6042797A/6017A19E" Ref="#PWR051"  Part="1" 
AR Path="/6045D11E/6017A19E" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/6017A19E" Ref="#PWR055"  Part="1" 
AR Path="/6049D147/6017A19E" Ref="#PWR059"  Part="1" 
F 0 "#PWR059" H 6300 3150 50  0001 C CNN
F 1 "GND" H 6305 3227 50  0000 C CNN
F 2 "" H 6300 3400 50  0001 C CNN
F 3 "" H 6300 3400 50  0001 C CNN
	1    6300 3400
	1    0    0    -1  
$EndComp
Text HLabel 5750 2500 0    50   Input ~ 0
raw_adc_input
Wire Wire Line
	5750 2500 5950 2500
Wire Wire Line
	5950 2500 5950 2800
Text Notes 5850 2200 0    50   ~ 0
Scale and protect ADC input
Connection ~ 6300 3100
$Comp
L power:+3.3V #PWR?
U 1 1 60179E41
P 7550 2800
AR Path="/60179E41" Ref="#PWR?"  Part="1" 
AR Path="/60156738/60179E41" Ref="#PWR022"  Part="1" 
AR Path="/601BF9C2/60179E41" Ref="#PWR026"  Part="1" 
AR Path="/601E52DF/60179E41" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/60179E41" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/60179E41" Ref="#PWR048"  Part="1" 
AR Path="/6042797A/60179E41" Ref="#PWR052"  Part="1" 
AR Path="/6045D11E/60179E41" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/60179E41" Ref="#PWR056"  Part="1" 
AR Path="/6049D147/60179E41" Ref="#PWR060"  Part="1" 
F 0 "#PWR060" H 7550 2650 50  0001 C CNN
F 1 "+3.3V" H 7565 2973 50  0000 C CNN
F 2 "" H 7550 2800 50  0001 C CNN
F 3 "" H 7550 2800 50  0001 C CNN
	1    7550 2800
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60179E3B
P 7550 3400
AR Path="/60179E3B" Ref="#PWR?"  Part="1" 
AR Path="/60156738/60179E3B" Ref="#PWR023"  Part="1" 
AR Path="/601BF9C2/60179E3B" Ref="#PWR027"  Part="1" 
AR Path="/601E52DF/60179E3B" Ref="#PWR?"  Part="1" 
AR Path="/6018BFA2/60179E3B" Ref="#PWR?"  Part="1" 
AR Path="/6040F615/60179E3B" Ref="#PWR049"  Part="1" 
AR Path="/6042797A/60179E3B" Ref="#PWR053"  Part="1" 
AR Path="/6045D11E/60179E3B" Ref="#PWR?"  Part="1" 
AR Path="/60465E6A/60179E3B" Ref="#PWR057"  Part="1" 
AR Path="/6049D147/60179E3B" Ref="#PWR061"  Part="1" 
F 0 "#PWR061" H 7550 3150 50  0001 C CNN
F 1 "GND" H 7555 3227 50  0000 C CNN
F 2 "" H 7550 3400 50  0001 C CNN
F 3 "" H 7550 3400 50  0001 C CNN
	1    7550 3400
	-1   0    0    -1  
$EndComp
$Comp
L Diode:BAT54S D?
U 1 1 60179E35
P 7550 3100
AR Path="/60179E35" Ref="D?"  Part="1" 
AR Path="/60156738/60179E35" Ref="D1"  Part="1" 
AR Path="/601BF9C2/60179E35" Ref="D2"  Part="1" 
AR Path="/601E52DF/60179E35" Ref="D?"  Part="1" 
AR Path="/6018BFA2/60179E35" Ref="D?"  Part="1" 
AR Path="/6040F615/60179E35" Ref="D4"  Part="1" 
AR Path="/6042797A/60179E35" Ref="D5"  Part="1" 
AR Path="/6045D11E/60179E35" Ref="D?"  Part="1" 
AR Path="/60465E6A/60179E35" Ref="D6"  Part="1" 
AR Path="/6049D147/60179E35" Ref="D7"  Part="1" 
F 0 "D7" V 7596 3188 50  0000 L CNN
F 1 "BAT54S" V 7505 3188 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7625 3225 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 7430 3100 50  0001 C CNN
F 4 "5" H 7550 3100 50  0001 C CNN "min_qty"
F 5 "0.1332" H 7550 3100 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/nexperia/bat54s-215/diode-schoty-dual-30v-0-2a-sot23/dp/1081194?st=bat54s" H 7550 3100 50  0001 C CNN "purchase_link"
	1    7550 3100
	0    1    -1   0   
$EndComp
Wire Wire Line
	6300 3100 7050 3100
Wire Wire Line
	7200 2450 7050 2450
Wire Wire Line
	7050 2450 7050 3100
Connection ~ 7050 3100
Wire Wire Line
	7050 3100 7350 3100
$EndSCHEMATC
