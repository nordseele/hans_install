Todo  => compile and add binary

### Software install

Use the Raspberry Pi Imager to instal Raspberry Pi OS <u>Lite 32bits</u> on your SD card. (under Raspberry Os - Other)

https://www.raspberrypi.org/downloads/

At the end of the process 

Mount the SD Card again, open a terminal and in enter the following command:

```shell
cd /volumes/boot && touch ssh
```



#### Connection over Wifi 

We need to create a *WPA_supplicant.conf* file. It contains your network info. Follow these instructions: 

https://www.raspberrypi.org/documentation/configuration/wireless/headless.md or use this website https://steveedson.co.uk/tools/wpa/ to create a file directly.

Drop the file at the root of the sd card ("Boot") 

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

#### Optional: install Rust if you want to edit the code and compile it.

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

Compiling: from the hans directory run

`cargo build --release`


#### Notes

If you want to prevent Hans from starting automatically, use: `sudo systemctl disable hans` 

<u>Reminder is you want to start and stop Hans manually:</u>

Start: `sudo systemctl start hans`

Stop: `sudo systemctl stop hans`

journalctl -u hans


#### Bill of material REV C

[Bom rev C](bom_revC.md)

https://octopart.com/bom-tool/wrAAEbXP
