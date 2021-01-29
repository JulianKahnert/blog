---
title: Raspberry Pi Temperatursensor
bigimg:  /img/pi-temperature.jpg
tags: hacking
---

Im Rahmen von meiner Heimautomation mit [HomeAssistant](http://home-assistant.io/) (eine sehr interessantes Projekt mit unzähligen Möglichkeiten) wollte ich die Temperatur in einem Raum messen und habe hierfür eine einfache und kostengünstige Lösung gesucht.
Da ich ohnehin schon einen Raspberry Pi für andere Dinge nutze, bot es sich an diesen auch als Temperatursensor zu verwenden und so bin ich auf [dieses](http://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/temperature/) Tutorial gestoßen.
Die Einrichtung ist extrem einfach und die Kosten bleiben im einstelligen Euro-Bereich (sofern ein Raspberry Pi schon vorhanden ist).

### Komponenten
Die folgenden Komponenten werden benötigt:

* Raspberry Pi
* 1x Temperatursensor (`DS18B20`)
* 1x Widerstand (`4.7kΩ`)
* 1x Steckbrett (z.B. [diese](https://www.amazon.de/gp/product/B00LO32MBM))
* 3x male-female Jumper-Kabel (z.B. [diese](https://www.amazon.de/dp/B00DI4ZSRU))

Anstelle des Steckbretts und der Jumper-Kabel kann der Sensor natürlich auch an den Raspberry Pi gelötet werden.

### Verbindung
Der Temperatursensor mit wie folgt mit dem Raspberry Pi (ausgeschaltet) verbunden werden:

![Temperatursensor](http://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/temperature/sensor-connection.png)

Die Pin-Belegung des Raspberry Pis sind z.B. [hier](https://www.raspberrypi.org/documentation/usage/gpio/) zu finden.

**Wichtig:** Wenn der Sensor angeschlossen ist und der Raspberry Pi zum ersten Mal gestartet wird, sollte man den Sensor anfassen und prüfen, ob er nach 4-5 Sekunden heiß wird.
Ist dies der Fall, ist er nicht richtig verbunden und die Schaltung muss nochmal überprüft werden.

### Programmierungen
Zunächst muss der `1-Wire` Sensor in der Raspberry Pi Konfiguration aktiviert werde:

```sh
sudo raspi-config
# Interfacing Options > 1-Wire > enable

sudo modprobe w1-gpio
sudo modprobe w1-therm

# Pi ggf. neu starten
sudo reboot
```

Anschließend wird der Name des Sensors gesucht:

```sh
ls /sys/bus/w1/devices/

# nun sollte der Name zu sehen sein
28-0416869dcaff  w1_bus_master1

# hier: 28-0416869dcaff
```

Die Temperatur kann schon jetzt ausgelesen werde `cat /sys/bus/w1/devices/28-0416869dcaff/w1_slave` (Name entsprechend anpassen):

```sh
2e 01 4b 46 7f ff 0c 10 e4 : crc=e4 YES
2e 01 4b 46 7f ff 0c 10 e4 t=18875
```

Der Wert `t=18875` entspricht der Temperatur in `1/1000 ˚C`.
Dies wird mit dem folgenden Python Skript (`temperature.py`) auf eine Nachkommastelle gerundet und anschließend ausgegeben.

```python
#!/usr/bin/env python

# CHANGE THIS - device id from "ls /sys/bus/w1/devices/"
device_id = "28-0416869dcaff"

# get temperature data
tfile = open("/sys/bus/w1/devices/" + device_id + "/w1_slave")  
text = tfile.read()
tfile.close()

# parse and format temperature data
secondline = text.split("\n")[1]
temperaturedata = secondline.split(" ")[9]
temperature = float(temperaturedata[2:])

# round to one decimal place
temperature = round(temperature / 1000, 1)
print temperature
```

Nun lassen sich unterschiedliche Anwendungen realisieren.
In meinem Fall lese ich die Werte des Raspberry Pis via `ssh` aus:

```sh
ssh pi@192.168.178.101 "python temperature.py"
```

In einem weiteren Anwendungsbeispiel könnte man einen Cronjob einrichten, sodass der Raspberry Pi die Temperatur an eine [MQTT-Datenbank](https://home-assistant.io/components/mqtt/) überträgt.

----

**Anmerkung zum Bild:** Es hat sich herausgestellt, dass es ratsam ist, den Temperatursensor nicht direkt auf dem Raspberry Pi zu befestigen, da die Abwärme die Temperaturmessung stark verfälscht, selbst wenn keine anspruchsvollen Berechnungen ausgeführt werden.
