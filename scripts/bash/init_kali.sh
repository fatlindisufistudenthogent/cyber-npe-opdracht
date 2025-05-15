#!/usr/bin/bash

# sudo apt install ssh -y >/dev/null 2>&1
apt install ssh -y >/dev/null 2>&1

setxkbmap be >/dev/null 2>&1

sudo tee /etc/network/interfaces <<EOF >/dev/null 2>&1
auto eth0
iface eth0 inet static
    address 10.10.10.3
    netmask 255.255.255.0
    gateway 10.10.10.1
    dns-nameservers 8.8.8.8
EOF

sudo echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
sudo nmcli dev set eth0 managed no
sudo ip addr flush dev eth0
sudo ip link set eth0 down
sudo ip link set eth0 up
sudo systemctl restart networking

# ssh osboxes@localhost -p 2222