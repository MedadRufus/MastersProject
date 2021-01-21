# MastersProject
 
# Requirements
Design a data logger for E bikes that can record:


It needs to 
* measure: battery current, voltage, inclination of road, humidity(as proxy for rain), tempreature of battery, external temperature, e-bike velocity, accleration.
* run off the battery pack
* consume minimal power
* be sturdy enough to survive near the battery pack
* Measure the environmental values(temperature, humidity) without being affected by the system(e.g. heat from the battery)
* measure at least 2 weeks of non stop data
* option to auto upload to the cloud, when connected to wifi.
* cloud dashboard
* log data at max data rate of 1 sample per second

The idea is to see how estimate battery discharge profiles to do accurate range and state of charge estimations.



Hardware ideas:
* Accleration/tilt from LSM9DS1. Tilt can be measured from sensor fusino on the mcu
* Processor: ESP32
* Current sensor: ACS758LCB-050B-PFF-T Allegro Microsystems, Linear Hall Effect Sensor, 5-Pin CB PFF
* GPS: Ublox with antenna
