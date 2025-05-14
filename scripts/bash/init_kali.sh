#!/usr/bin/bash

sudo apt install openssh-server -y > /dev/null 2>&1
setxkbmap fr > /dev/null 2>&1

cat /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 10.10.10.3/24
      gateway4: 10.10.10.1
      nameservers:
        addresses: [8.8.8.8]
EOF
