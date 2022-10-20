## Installing the software environment 

#### 1) Raspberry Pi OS

Download the Raspberry Pi Imager (minimum version: 1.6) to instal Raspberry Pi OS <u>Lite 32bits</u> on your SD card.

https://www.raspberrypi.org/downloads/

Select the 32bit (Lite) Raspberry PI OS. (Other versions -> RPI Lite)

#### 2) Network settings and SSH

Before writing the image, type CMD + SHIFT + X (or ctrl + shift + X on Win), this will open a new window, make the following changes:

- Check "Enable SSH" 
- Change the hostname to "hans.local" (or another unique name if you have multiple RPi/Hans install on your network)
- Enter your WIFI network Details
- Change Locale and country
- You can leave the hostname to raspberrypi. The install script will modify this to "hans" later. 

Press the "Write" button to start writing the image to your SD. It will take a few minutes.

At the end of the process, RPI imager will unmount the card. 

Put it in the Raspberry Pi and power the Pi on. 

Note: Don't try to remove the Pi from its 3d printed case when the SD card is still present in the slot. You may damage it.

#### 3) SSH into the PI from a terminal

It may take a few minutes the first time until the Pi shows up on the network.

Open a terminal window and connect to the Raspberry Pi via SSH. The password is "raspberry".

```shell
ssh hans.local 
```
You can modify the password if you wish.

`sudo su`
`passwd pi`
`exit`

#### 4) Hans install

```shell
wget --no-cache https://raw.githubusercontent.com/nordseele/hans_install/main/install.sh
chmod +x install.sh && ./install.sh
```

Press enter to proceed with the full install or select a custom option. Installing Rust and compiling Hans_rust will take approx. 20 minutes.


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

