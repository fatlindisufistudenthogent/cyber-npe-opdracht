#!/usr/bin/bash

sudo apt install openssh-server -y >/dev/null 2>&1

setxkbmap fr >/dev/null 2>&1

# Lees de tijdelijke bestand, schrijft stdout op scherm en append aan het bestand interfaces; /dev/null zorgt ervoor dat er geen stdout op het scherm toont
sudo tee -a /etc/network/interfaces <<EOF >/dev/null
auto eth0
iface eth0 inet static
    address 10.10.10.3
    netmask 255.255.255.0
    gateway 10.10.10.1
    dns-nameservers 8.8.8.8
EOF

sudo ifdown eth0 && sudo ifup eth0 >/dev/null
