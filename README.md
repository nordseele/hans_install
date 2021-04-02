### Hans environment install

Use the Raspberry Pi Imager (minimum version: 1.6) to instal Raspberry Pi OS <u>Lite 32bits</u> on your SD card. (under Raspberry Os - Other)

https://www.raspberrypi.org/downloads/

Before writing the image, type CMD + SHIFT + X (or ctrl + shift + X on Win), this will open a new window, make the following changes:

- Check "Enable SSH" 
- Enter your WIFI network Details
- Change Locale and country
- You can leave the hostname to raspberrypi. The install script will modify this to "hans" later. 

Press the "Write" button to start writing the image to your SD. It will take a few minutes.

At the end of the process, RPI imager will unmount the card. Put it in the Raspberry Pi and power the Pi up.

Open a terminal window and connect to the Raspberry Pi via SSH. The password is "raspberry".

```shell
ssh pi@raspberrypi.local 
```


The whole install process is now scripted.

```shell
wget https://raw.githubusercontent.com/nordseele/hans_install/master/install.sh
chmod +x install.sh && ./install.sh
```

This script doesn't compile nor install Hans_Rust and Hans_ii_midi. This needs to be done separately, the instructions are available in their respective folders

https://github.com/nordseele/hans_ii_midi_c (for Teletype to MIDI)




___

### Notes

##### SSH host verification error

`ssh-keygen -R raspberrypi.local` or `ssh-keygen -R hans.local`

##### Bluetooth (WIP)

Connect via SSH from a terminal -> ssh pi@hans.local (password: raspberry)
```
sudo bluetoothctl
 	scan on 
	devices (copy the MAC address of your device)

	connect 48:B6:20:03:18:5B (replace the address with yours)
    exit
```

test: aconnect -i (check if your ble device is listed here, amidiauto should connect it to all Midi routes available)

##### Services

If you want to prevent Hans_ii_midi from starting automatically, use: `sudo systemctl disable hans_ii_midi` 
If you want to prevent Hans_russt from starting automatically, use: `sudo systemctl disable hans` 

<u>Reminder is you want to start and stop Hans manually:</u>

Start: `sudo systemctl start hans`

Stop: `sudo systemctl stop hans`

journalctl -u hans 

____ 


#### Bill of material REV C

[Bom rev C](bom_revC.md)

https://octopart.com/bom-tool/wrAAEbXP

