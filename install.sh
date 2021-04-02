#! /bin/bash

# test bash
 
echo ============
echo
echo Hans install 
echo
echo ============

echo

function fresh_start() {
    cd /home/pi && git clone https://github.com/nordseele/hans_install.git 
}

function install_dependencies() {
    echo installing dependencies 
    sudo apt update
    PACKAGES="libdbus-1-dev libglib2.0-dev libusb-dev libudev-dev libical-dev libreadline-dev libasound2-dev libjack-jackd2-dev git autotools-dev libtool autoconf pigpio"
    sudo apt-get install -y $PACKAGES

    #MIDI 
    cd && git clone https://github.com/nordseele/tty.git
    cd /home/pi/tty
    make
    sudo make install

    cd /home/pi

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
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}


function install_iimidi() {
    echo Installing hans_ii_midi (Teletype to Midi)
    cd /home/pi
    git clone https://github.com/nordseele/hans_ii_midi_c.git
    cd /home/pi/hans_ii_midi_c
    g++ -Wall -D__LINUX_ALSA__ -o hans_ii_midi main.cpp RtMidi.cpp -lpigpio -lasound -lpthread
    echo Enabling service
    sudo cp /home/pi/hans_ii_midi_c/hans_ii_midi.service /etc/systemd/system/
    sudo systemctl enable hans_ii_midi.service
}

function install_ii() {
    echo Installing hans_rust (ER301, Txo, etc)
    cd /home/pi
    git clone https://github.com/nordseele/hans_rust.git
    cd /home/pi/hans_rust
    cargo build
    echo Enabling service
    sudo cp /home/pi/hans_install/hans.service /etc/systemd/system/
    sudo systemctl enable hans.service
}

function no_services() {
    echo Disabling services
    sudo systemctl disable hans.service
    sudo systemctl disable hans_ii_midi.service
    sudo systemctl disable ttymidi.service
    sudo systemctl disable amidiauto.service
}

function reboot() {
    echo ========================
    echo
    echo Hans install - Rebooting
    echo
    echo ========================
    sudo reboot
}

function full_install() {
    fresh_start
    install_dependencies
    install_ii
    install_iimidi
    reboot
}
function full_install_noTT() {
    fresh_start
    install_dependencies
    install_ii
    reboot
}
function full_install_noSC() {
    fresh_start
    install_dependencies
    install_ii_midi
    reboot
}

function cleanup() {
    sudo systemctl stop hans
    sudo systemctl stop hans_ii_midi
    sudo systemctl stop ttymidi
    no_services
    sudo rm -f -R /home/pi/hans_ii_midi_c
    sudo rm -f -R /home/pi/hans_rust
    sudo rm -f -R /home/pi/hans_install
    sudo rm -f -R /home/pi/tty
}



menu(){
echo -ne "
Hans install
1) Full install
2) Install without support for Teletype
3) Install without support for Er-301 and Txo
4) Remove services
5) Clean up
0) Exit
Choose an option: "
        read a
        case $a in
	        1) full_install ;;
	        2) full_install_noTT ;;
	        3) full_install_noSC ;;
	        4) no_services ;;
	        5) cleanup ;;
			0) exit 0 ;;
			*) full_install ; exit 0;
        esac
}


menu 

