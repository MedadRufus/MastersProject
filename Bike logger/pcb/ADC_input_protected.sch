EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 3
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
F 0 "R5" H 6020 2996 50  0000 L CNN
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
F 0 "R6" H 6020 3296 50  0000 L CNN
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
F 0 "#PWR024" H 5950 3150 50  0001 C CNN
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
F 0 "C6" H 6415 3296 50  0000 L CNN
F 1 "C" H 6415 3205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 6338 3100 50  0001 C CNN
F 3 "~" H 6300 3250 50  0001 C CNN
	1    6300 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 3100 6300 3100
Connection ~ 6300 3100
Wire Wire Line
	6300 3100 6800 3100
$Comp
L Diode:BAT54S D?
U 1 1 60179E35
P 6800 3100
AR Path="/60179E35" Ref="D?"  Part="1" 
AR Path="/60156738/60179E35" Ref="D1"  Part="1" 
AR Path="/601BF9C2/60179E35" Ref="D2"  Part="1" 
AR Path="/601E52DF/60179E35" Ref="D?"  Part="1" 
F 0 "D2" V 6846 3188 50  0000 L CNN
F 1 "BAT54S" V 6755 3188 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6875 3225 50  0001 L CNN
F 3 "https://www.diodes.com/assets/Datasheets/ds11005.pdf" H 6680 3100 50  0001 C CNN
	1    6800 3100
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60179E3B
P 6800 3400
AR Path="/60179E3B" Ref="#PWR?"  Part="1" 
AR Path="/60156738/60179E3B" Ref="#PWR023"  Part="1" 
AR Path="/601BF9C2/60179E3B" Ref="#PWR027"  Part="1" 
AR Path="/601E52DF/60179E3B" Ref="#PWR?"  Part="1" 
F 0 "#PWR027" H 6800 3150 50  0001 C CNN
F 1 "GND" H 6805 3227 50  0000 C CNN
F 2 "" H 6800 3400 50  0001 C CNN
F 3 "" H 6800 3400 50  0001 C CNN
	1    6800 3400
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR?
U 1 1 60179E41
P 6800 2800
AR Path="/60179E41" Ref="#PWR?"  Part="1" 
AR Path="/60156738/60179E41" Ref="#PWR022"  Part="1" 
AR Path="/601BF9C2/60179E41" Ref="#PWR026"  Part="1" 
AR Path="/601E52DF/60179E41" Ref="#PWR?"  Part="1" 
F 0 "#PWR026" H 6800 2650 50  0001 C CNN
F 1 "+3.3V" H 6815 2973 50  0000 C CNN
F 2 "" H 6800 2800 50  0001 C CNN
F 3 "" H 6800 2800 50  0001 C CNN
	1    6800 2800
	1    0    0    -1  
$EndComp
Text HLabel 7000 3100 2    50   Input ~ 0
protected_adc_input
$Comp
L power:GND #PWR?
U 1 1 6017A19E
P 6300 3400
AR Path="/6017A19E" Ref="#PWR?"  Part="1" 
AR Path="/60156738/6017A19E" Ref="#PWR018"  Part="1" 
AR Path="/601BF9C2/6017A19E" Ref="#PWR025"  Part="1" 
AR Path="/601E52DF/6017A19E" Ref="#PWR?"  Part="1" 
F 0 "#PWR025" H 6300 3150 50  0001 C CNN
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
$EndSCHEMATC
