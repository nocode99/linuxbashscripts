#! /bin/bash

# This is to configure and update bluetooth on a pre-15.05 Ubuntu based OS.
# The OS currently ships with an outdated version of Bluez which assists with
# connecting bluetooth devices to the laptop.  This is specifically written
# for the Varmilo VB87M keyboard.

# OPTIONS
# add 'yes' as a parameter if you need to update bluetooth/bluez.  This is
# generally needed if you are running for the first time.

UDEV_LINE=(ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up")
UDEV_FILE='/etc/udev/rules.d/10-local.rules'
# Check if sudo
if [[ $EUID -ne 0  ]]; then
    echo "This script must be run as root"
    echo "$ sudo bluetooth.sh"
    exit 1
fi

# UPDATE SOFTWARE
function update_apt() {
    add-apt-repository -y ppa:vidplace7/bluez5
    apt-get update
    apt-get install bluez bluetooth
}

function clean_apt() {
    killall apt-get
    rm /var/lib/dpkg/lock
    dpkg --configure -a
}

function configure_bluetooth() {
    hciconfig hci0 up
    # Check to see if udev is configured to load bluetooth upon startup.
    if ! grep -Fxq $UDEV_LINE $UDEV_FILE then
        echo "$UDEV_LINE" > $UDEV_FILE
    fi

    # TO DO
    bluetoothctl
    # Load output into variable and find VB87MS
}

# If script is passed with arguments yes, update apt and bluetooth/bluez
if [ $1 == yes ] ; then
    update_apt
    sleep 10
    clean_apt
else
