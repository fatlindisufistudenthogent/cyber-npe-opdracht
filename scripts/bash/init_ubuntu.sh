#!/usr/bin/bash

sudo apt install openssh-server -y >/dev/null 2>&1

sudo tee /etc/netplan/01-network-manager-all.yaml <<EOF >/dev/null 2>&1
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    enp0s3:
      dhcp4: no
      addresses: [10.10.10.4/24]
      gateway4: 10.10.10.1
      nameservers:
        addresses: [8.8.8.8]
EOF

sudo netplan apply >/dev/null 2>&1
