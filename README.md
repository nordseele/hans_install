### Incomplete | draft | do not use

# Software install

Use the Raspberry Pi Imager to instal Raspberry Pi OS <u>Lite 32bits</u> on your SD card. 

https://www.raspberrypi.org/downloads/

Mount the SD Card and 

```shell
cd /volumes/boot && touch ssh
```



#### Connection over Wifi 

Then we need to create a *WPA_supplicant.conf* file. It contains your network info. Follow these instructions: 

https://www.raspberrypi.org/documentation/configuration/wireless/headless.md

and drop the file at the root of the sd card. 

Eject the card, put it in the Raspberry Pi and power the Pi up.

(If you prefer, you can connect the Pi Zero W using a micro USB to Ethernet adaptor/hub or using its OTG capability.)


Open a terminal window and connect to the Raspberry Pi via SSH. The password is "raspberry".

```shell
ssh pi@raspberrypi.local 
```

`ssh-keygen -R raspberrypi.local` if you encounter an "host/key verification" error. Note that it can take a few minutes until the pi connects to your wifi network. Check with Lanscan when it's connected and ready.

#### Environment and configuration

The whole install process is now scripted.

```shell
wget https://raw.githubusercontent.com/nordseele/hans_install/master/install.sh
chmod +x install.sh && ./install.sh
```

## Notes


If you want to prevent Hans from starting automatically, use: `sudo systemctl disable hans` 

<u>Reminder is you want to start and stop Hans manually:</u>

Start: `sudo systemctl start hans`

Stop: `sudo systemctl stop hans`

journalctl -u hans
