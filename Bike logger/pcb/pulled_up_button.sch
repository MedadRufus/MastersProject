EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 7
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
L Switch:SW_Push SW1
U 1 1 6035FB21
P 5400 3500
AR Path="/6035EFCE/6035FB21" Ref="SW1"  Part="1" 
AR Path="/6036C998/6035FB21" Ref="SW2"  Part="1" 
AR Path="/60374312/6035FB21" Ref="SW3"  Part="1" 
AR Path="/6037BC78/6035FB21" Ref="SW4"  Part="1" 
AR Path="/603C8DCA/6035FB21" Ref="SW?"  Part="1" 
AR Path="/603D0726/6035FB21" Ref="SW?"  Part="1" 
AR Path="/603D8094/6035FB21" Ref="SW?"  Part="1" 
F 0 "SW?" H 5400 3785 50  0000 C CNN
F 1 "SW_Push" H 5400 3694 50  0000 C CNN
F 2 "" H 5400 3700 50  0001 C CNN
F 3 "~" H 5400 3700 50  0001 C CNN
	1    5400 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 3500 4800 3500
Wire Wire Line
	4800 3500 4800 3200
$Comp
L power:+3.3V #PWR04
U 1 1 6035FF80
P 4800 2750
AR Path="/6035EFCE/6035FF80" Ref="#PWR04"  Part="1" 
AR Path="/6036C998/6035FF80" Ref="#PWR06"  Part="1" 
AR Path="/60374312/6035FF80" Ref="#PWR042"  Part="1" 
AR Path="/6037BC78/6035FF80" Ref="#PWR044"  Part="1" 
AR Path="/603C8DCA/6035FF80" Ref="#PWR?"  Part="1" 
AR Path="/603D0726/6035FF80" Ref="#PWR?"  Part="1" 
AR Path="/603D8094/6035FF80" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 4800 2600 50  0001 C CNN
F 1 "+3.3V" H 4815 2923 50  0000 C CNN
F 2 "" H 4800 2750 50  0001 C CNN
F 3 "" H 4800 2750 50  0001 C CNN
	1    4800 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 603613F2
P 4800 3050
AR Path="/6035EFCE/603613F2" Ref="R11"  Part="1" 
AR Path="/6036C998/603613F2" Ref="R12"  Part="1" 
AR Path="/60374312/603613F2" Ref="R13"  Part="1" 
AR Path="/6037BC78/603613F2" Ref="R14"  Part="1" 
AR Path="/603C8DCA/603613F2" Ref="R?"  Part="1" 
AR Path="/603D0726/603613F2" Ref="R?"  Part="1" 
AR Path="/603D8094/603613F2" Ref="R?"  Part="1" 
F 0 "R?" H 4870 3096 50  0000 L CNN
F 1 "R" H 4870 3005 50  0000 L CNN
F 2 "" V 4730 3050 50  0001 C CNN
F 3 "~" H 4800 3050 50  0001 C CNN
	1    4800 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 2900 4800 2750
Wire Wire Line
	4800 3500 4050 3500
Connection ~ 4800 3500
Wire Wire Line
	5900 3500 5900 4050
Wire Wire Line
	5600 3500 5900 3500
$Comp
L power:GND #PWR05
U 1 1 60361937
P 5900 4050
AR Path="/6035EFCE/60361937" Ref="#PWR05"  Part="1" 
AR Path="/6036C998/60361937" Ref="#PWR019"  Part="1" 
AR Path="/60374312/60361937" Ref="#PWR043"  Part="1" 
AR Path="/6037BC78/60361937" Ref="#PWR045"  Part="1" 
AR Path="/603C8DCA/60361937" Ref="#PWR?"  Part="1" 
AR Path="/603D0726/60361937" Ref="#PWR?"  Part="1" 
AR Path="/603D8094/60361937" Ref="#PWR?"  Part="1" 
F 0 "#PWR?" H 5900 3800 50  0001 C CNN
F 1 "GND" H 5905 3877 50  0000 C CNN
F 2 "" H 5900 4050 50  0001 C CNN
F 3 "" H 5900 4050 50  0001 C CNN
	1    5900 4050
	1    0    0    -1  
$EndComp
Text HLabel 4050 3500 0    50   Input ~ 0
pin_value
$EndSCHEMATC
