EESchema Schematic File Version 4
LIBS:pcb-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 15
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
	5200 3500 5100 3500
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
F 0 "#PWR044" H 4800 2600 50  0001 C CNN
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
F 0 "R12" H 4870 3096 50  0000 L CNN
F 1 "4.7k" H 4870 3005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4730 3050 50  0001 C CNN
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
	5600 3500 5700 3500
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
F 0 "#PWR045" H 5900 3800 50  0001 C CNN
F 1 "GND" H 5905 3877 50  0000 C CNN
F 2 "" H 5900 4050 50  0001 C CNN
F 3 "" H 5900 4050 50  0001 C CNN
	1    5900 4050
	1    0    0    -1  
$EndComp
Text HLabel 4050 3500 0    50   Input ~ 0
pin_value
Wire Wire Line
	5100 3500 5100 3700
Wire Wire Line
	5100 3700 5200 3700
Connection ~ 5100 3500
Wire Wire Line
	5600 3700 5700 3700
Wire Wire Line
	5700 3700 5700 3500
Connection ~ 5700 3500
Wire Wire Line
	5700 3500 5900 3500
$Comp
L custom_symbols:SW_Push_1571563-4 SW1
U 1 1 607B3BD3
P 5400 3500
AR Path="/6035EFCE/607B3BD3" Ref="SW1"  Part="1" 
AR Path="/6036C998/607B3BD3" Ref="SW2"  Part="1" 
AR Path="/60374312/607B3BD3" Ref="SW4"  Part="1" 
AR Path="/6037BC78/607B3BD3" Ref="SW4_reset1"  Part="1" 
F 0 "SW2" H 5400 3785 50  0000 C CNN
F 1 "SW_Push_1571563-4" H 5400 3694 50  0000 C CNN
F 2 "custom_footprints:SW_1571563-4" H 5400 3700 50  0001 C CNN
F 3 "~" H 5400 3700 50  0001 C CNN
F 4 "1" H 5400 3500 50  0001 C CNN "min_qty"
F 5 "0.082" H 5400 3500 50  0001 C CNN "price"
F 6 "https://uk.farnell.com/alcoswitch-te-connectivity/1571563-4/tactile-switch-0-05a-24vdc-260gf/dp/3397757?st=surface%20mount%20button" H 5400 3500 50  0001 C CNN "purchase_link"
	1    5400 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 4000 4800 4050
$Comp
L Device:C C18
U 1 1 60913F70
P 4800 3850
AR Path="/6036C998/60913F70" Ref="C18"  Part="1" 
AR Path="/6035EFCE/60913F70" Ref="C17"  Part="1" 
AR Path="/60374312/60913F70" Ref="C19"  Part="1" 
AR Path="/6037BC78/60913F70" Ref="C20"  Part="1" 
F 0 "C18" H 4915 3896 50  0000 L CNN
F 1 "100nF" H 4915 3805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4838 3700 50  0001 C CNN
F 3 "~" H 4800 3850 50  0001 C CNN
	1    4800 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR074
U 1 1 6091378B
P 4800 4050
AR Path="/6035EFCE/6091378B" Ref="#PWR074"  Part="1" 
AR Path="/6036C998/6091378B" Ref="#PWR075"  Part="1" 
AR Path="/60374312/6091378B" Ref="#PWR076"  Part="1" 
AR Path="/6037BC78/6091378B" Ref="#PWR077"  Part="1" 
AR Path="/603C8DCA/6091378B" Ref="#PWR?"  Part="1" 
AR Path="/603D0726/6091378B" Ref="#PWR?"  Part="1" 
AR Path="/603D8094/6091378B" Ref="#PWR?"  Part="1" 
F 0 "#PWR077" H 4800 3800 50  0001 C CNN
F 1 "GND" H 4805 3877 50  0000 C CNN
F 2 "" H 4800 4050 50  0001 C CNN
F 3 "" H 4800 4050 50  0001 C CNN
	1    4800 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3500 4800 3700
Wire Wire Line
	4800 3500 5100 3500
$EndSCHEMATC
