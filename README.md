# MastersProject
 
# Requirements
Design a data logger for E bikes that can record:


It needs to 
* measure: battery current for output and charging(1mA precision), voltage(10mV precision), inclination of road, humidity(as proxy for rain), tempreature of battery, external temperature, e-bike velocity, accleration.
* run off the battery pack
* consume minimal power
* be sturdy enough to survive near the battery pack
* Measure the environmental values(temperature, humidity) without being affected by the system(e.g. heat from the battery)
* measure at least 2 weeks of non stop data
* option to auto upload to the cloud, when connected to wifi.
* cloud dashboard
* log data at max data rate of 1 sample per second
* Needs to handle significant noise in power supply generated by Motor
* Need to handle inductive currents from motor
* Needs isolation from motor.


The idea is to see how estimate battery discharge profiles to do accurate range and state of charge estimations.



Hardware ideas:
* Accleration/tilt from LSM9DS1. Tilt can be measured from sensor fusino on the mcu
* Processor: ESP32
* Current sensor: INA226, 500 kHz +/- 30% sample rate. Up to 36V.
* GPS: Ublox with antenna


# Overall System diagram
![image](https://user-images.githubusercontent.com/26815217/105333825-1219bf80-5bce-11eb-83dc-ac001538fb16.png)

# Basic physical design
![image](https://github.com/MedadRufus/MastersProject/blob/main/Bike%20logger/Images/system_diagram.png)

# Uses of sensor variables

![Picture2](https://user-images.githubusercontent.com/26815217/105344719-3760fa80-5bdb-11eb-9e97-bf75274aea7c.png)

# Software development

### Objectives

- [ ] Mercury
- [x] Venus
- [x] Earth (Orbit/Moon)
- [x] Mars
- [ ] Jupiter
- [ ] Saturn
- [ ] Uranus
- [ ] Neptune
- [ ] Comet Haley


# Software development

The following commands must be run as workarounds on the eBike Blackbox.

## How to disable strapping pin function of the MTDI pin(IO12)

On the PCB, the MTDI pin, IO12, is connected to the SD card MISO pin. In order to boot up, IO12 must be held low. Otherwise, it will brownout. 

Some explanation can be found on the [documentation](https://github.com/espressif/esptool/wiki/ESP32-Boot-Mode-Selection#other-pins).
```
If driven High, flash voltage (VDD_SDIO) is 1.8V not default 3.3V. Has internal pull-down, so unconnected = Low = 3.3V. May prevent flashing and/or booting if 3.3V flash is used and this pin is pulled high, causing the flash to brownout. See the ESP32 datasheet for more details.
```

Unfortunately, when SD card is inserted, MISO pin gets pulled up, causing continuous resets(boot loop).

So to disable this strapping function, we need to set the efuses to disable its functionality. 

So we need to install esptool. On windows 10, using conda terminal, run:
```bash
pip install esptool
```
Then run the following command to actually set the fuses. Set the `-p` argument to the port your esp32 is connected to.
```bash
python -m espefuse set_flash_voltage 3.3V -p COM6
```

You should be done now!


References:  
[https://www.esp32.com/viewtopic.php?t=5970](https://www.esp32.com/viewtopic.php?t=5970)  
[https://forum.micropython.org/viewtopic.php?t=4387#p25381](https://forum.micropython.org/viewtopic.php?t=4387#p25381)  



