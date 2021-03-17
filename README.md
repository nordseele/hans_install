Todo  => compile and add binary

### 1 - Software install

Use the Raspberry Pi Imager to instal Raspberry Pi OS <u>Lite 32bits</u> on your SD card. (under Raspberry Os - Other)

https://www.raspberrypi.org/downloads/

At the end of the process 

Mount the SD Card again, open a terminal and in enter the following command:

```shell
cd /volumes/boot && touch ssh
```



#### A - Connection over Wifi 

We need to create a *WPA_supplicant.conf* file:

Open a text editor and paste the following lines. Edit the name of your wifi router and your wifi key (keep the " ") and replace the ISO country code. 

**Important: This file must have a ***.conf*** extension.** (Windows, might force a .txt extension, you'll have to navigate to the Win folder settings and uncheck the option "Hide known file type extensions" before you being able to remove the .txt extension)

    country=se
    update_config=1
    ctrl_interface=/var/run/wpa_supplicant
    network={
    scan_ssid=1
    ssid="Name of your router"
    psk="Your key"
    }


Save the file and drop it at the root of the sd card (partition named "Boot").

Eject the card, put it in the Raspberry Pi and power the Pi up.


Open a terminal window and connect to the Raspberry Pi via SSH. The password is "raspberry".

```shell
ssh pi@raspberrypi.local 
```

`ssh-keygen -R raspberrypi.local` if you encounter an "host/key verification" error. Note that it can take a few minutes until the pi connects to your wifi network. Check with Lanscan when it's connected and ready.

#### B - Environment and configuration

The whole install process is now scripted.

```shell
wget https://raw.githubusercontent.com/nordseele/hans_install/master/install.sh
chmod +x install.sh && ./install.sh
```

#### Optional: install Rust if you want to edit the code and compile it.

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

Compiling: from the hans directory run

`cargo build --release`


#### Bluetooth

Connect via SSH from a terminal -> ssh pi@hans.local (password: raspberry)
```
sudo bluetoothctl
 	scan on 
	devices (copy the address of your device)

	connect 48:B6:20:03:18:5B (replace the MAC addres with yours)
    exit


test: aconnect -i (check if your ble device is listed here, amidiauto should connect it to all Midi routes available)


___
#### Notes

If you want to prevent Hans from starting automatically, use: `sudo systemctl disable hans` 

<u>Reminder is you want to start and stop Hans manually:</u>

Start: `sudo systemctl start hans`

Stop: `sudo systemctl stop hans`

journalctl -u hans

____ 


#### Bill of material REV C

[Bom rev C](bom_revC.md)

https://octopart.com/bom-tool/wrAAEbXP


____

#### Additional ressources

##### 1 - A

- https://www.raspberrypi.org/documentation/configuration/wireless/headless.md

- https://www.raspberrypi.org/documentation/remote-access/ssh/windows10.md

- https://learn.adafruit.com/adafruits-raspberry-pi-lesson-6-using-ssh/ssh-under-windows

- https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes
