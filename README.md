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
* Current sensor: https://czh-labs.com/products/panel-mount-100amp-ac-dc-current-sensor-module-board-based-on-acs758?gclid=Cj0KCQiA5bz-BRD-ARIsABjT4nioMhV6DkzQXXQlWWHhvIdOrb4SGj647ZOateWpy3lJSrJUT42GOLYaAohTEALw_wcB
* GPS: Ublox with antenna


# System diagram
![image](https://user-images.githubusercontent.com/26815217/105333825-1219bf80-5bce-11eb-83dc-ac001538fb16.png)

# Uses of sensor variables

![image](https://user-images.githubusercontent.com/26815217/105334068-5dcc6900-5bce-11eb-9cbd-acdfb5919756.png)



