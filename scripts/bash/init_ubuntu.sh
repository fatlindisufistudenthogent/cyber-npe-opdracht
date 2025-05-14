#!/usr/bin/bash

sudo apt install openssh-server -y
setxkbmap fr

cat /etc/netplan/01-netcfg.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 10.10.10.2/24
      gateway4: 10.10.10.1
      nameservers:
        addresses: [8.8.8.8]
EOF

# ?
sudo chmod +x /home/osboxes.org/setup_tomcat.sh
/home/osboxes.org/setup_tomcat.sh
