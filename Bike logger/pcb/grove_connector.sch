EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 13 15
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3950 2350 4100 2350
Wire Wire Line
	3950 2450 3950 2350
Wire Wire Line
	3950 2800 4100 2800
$Comp
L power:GND #PWR?
U 1 1 60ACA7BE
P 3950 2450
AR Path="/60ACA7BE" Ref="#PWR?"  Part="1" 
AR Path="/60AB9C64/60ACA7BE" Ref="#PWR063"  Part="1" 
AR Path="/60B6A54A/60ACA7BE" Ref="#PWR080"  Part="1" 
AR Path="/60B80021/60ACA7BE" Ref="#PWR083"  Part="1" 
AR Path="/60BA371C/60ACA7BE" Ref="#PWR086"  Part="1" 
AR Path="/6109851E/60ACA7BE" Ref="#PWR?"  Part="1" 
F 0 "#PWR086" H 3950 2200 50  0001 C CNN
F 1 "GND" H 3955 2277 50  0000 C CNN
F 2 "" H 3950 2450 50  0001 C CNN
F 3 "" H 3950 2450 50  0001 C CNN
	1    3950 2450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4300 2900 4300 2800
Wire Wire Line
	3950 2900 4300 2900
$Comp
L power:+3.3V #PWR?
U 1 1 60ACA7C6
P 4300 2800
AR Path="/60ACA7C6" Ref="#PWR?"  Part="1" 
AR Path="/60AB9C64/60ACA7C6" Ref="#PWR078"  Part="1" 
AR Path="/60B6A54A/60ACA7C6" Ref="#PWR081"  Part="1" 
AR Path="/60B80021/60ACA7C6" Ref="#PWR084"  Part="1" 
AR Path="/60BA371C/60ACA7C6" Ref="#PWR087"  Part="1" 
AR Path="/6109851E/60ACA7C6" Ref="#PWR?"  Part="1" 
F 0 "#PWR087" H 4300 2650 50  0001 C CNN
F 1 "+3.3V" H 4315 2973 50  0000 C CNN
F 2 "" H 4300 2800 50  0001 C CNN
F 3 "" H 4300 2800 50  0001 C CNN
	1    4300 2800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 60ACA7CD
P 3750 3000
AR Path="/60ACA7CD" Ref="J?"  Part="1" 
AR Path="/60AB9C64/60ACA7CD" Ref="J4"  Part="1" 
AR Path="/60B6A54A/60ACA7CD" Ref="J5"  Part="1" 
AR Path="/60B80021/60ACA7CD" Ref="J6"  Part="1" 
AR Path="/60BA371C/60ACA7CD" Ref="J7"  Part="1" 
AR Path="/6109851E/60ACA7CD" Ref="J?"  Part="1" 
F 0 "J5" H 3950 2550 50  0000 C CNN
F 1 "Conn_01x04" H 3900 2650 50  0000 C CNN
F 2 "Connector:NS-Tech_Grove_1x04_P2mm_Vertical" H 3750 3000 50  0001 C CNN
F 3 "~" H 3750 3000 50  0001 C CNN
	1    3750 3000
	-1   0    0    1   
$EndComp
Wire Wire Line
	4100 2350 4100 2800
$Comp
L Device:C C?
U 1 1 60ACA7D4
P 4650 3200
AR Path="/60ACA7D4" Ref="C?"  Part="1" 
AR Path="/60AB9C64/60ACA7D4" Ref="C22"  Part="1" 
AR Path="/60B6A54A/60ACA7D4" Ref="C23"  Part="1" 
AR Path="/60B80021/60ACA7D4" Ref="C24"  Part="1" 
AR Path="/60BA371C/60ACA7D4" Ref="C25"  Part="1" 
AR Path="/6109851E/60ACA7D4" Ref="C?"  Part="1" 
F 0 "C23" H 4765 3246 50  0000 L CNN
F 1 "100nF" H 4765 3155 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4688 3050 50  0001 C CNN
F 3 "~" H 4650 3200 50  0001 C CNN
	1    4650 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 3050 4650 2900
$Comp
L power:GND #PWR?
U 1 1 60ACA7DB
P 4650 3350
AR Path="/60ACA7DB" Ref="#PWR?"  Part="1" 
AR Path="/60AB9C64/60ACA7DB" Ref="#PWR079"  Part="1" 
AR Path="/60B6A54A/60ACA7DB" Ref="#PWR082"  Part="1" 
AR Path="/60B80021/60ACA7DB" Ref="#PWR085"  Part="1" 
AR Path="/60BA371C/60ACA7DB" Ref="#PWR088"  Part="1" 
AR Path="/6109851E/60ACA7DB" Ref="#PWR?"  Part="1" 
F 0 "#PWR088" H 4650 3100 50  0001 C CNN
F 1 "GND" H 4655 3177 50  0000 C CNN
F 2 "" H 4650 3350 50  0001 C CNN
F 3 "" H 4650 3350 50  0001 C CNN
	1    4650 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2900 4650 2900
Connection ~ 4300 2900
Text HLabel 3950 3100 2    50   Input ~ 0
grove_pin_1
Text HLabel 3950 3000 2    50   Input ~ 0
grove_pin_2
$EndSCHEMATC
