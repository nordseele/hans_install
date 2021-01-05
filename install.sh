#!/bin/sh

sudo apt update

PACKAGES="libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev libasound2-dev libjack-jackd2-dev git"

sudo apt-get install $PACKAGES -y

cd && git clone https://github.com/nordseele/hans_install.git 

#MIDI 
cd && git clone https://github.com/nordseele/tty.git
cd tty
make
sudo make install

cd 

wget https://github.com/antiprism/amidiauto/releases/download/v1.01Raspbian/amidiauto-1.01_buster.deb
sudo apt install ./amidiauto-1.01_buster.deb
sudo cp /home/pi/hans_install/files/amidiauto.conf /etc/amidiauto.conf
sudo systemctl enable amidiauto

sudo cp /home/pi/hans_install/files/ttymidi.service /etc/systemd/system/ttymidi.service
sudo systemctl enable ttymidi.service

#I2C
sudo raspi-config nonint do_i2c 0
sudo cp /home/pi/hans_install/files/config.txt /boot/config.txt

sudo raspi-config nonint do_hostname hans
sudo raspi-config nonint do_expand_rootfs

sudo sed -i 's/console=serial0,115200 //' /boot/cmdline.txt

#RUST
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#TODO => ADD hans binary and Hans service

sudo reboot
