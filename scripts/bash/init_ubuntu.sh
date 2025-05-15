#!/usr/bin/bash

# Dit als je niet als root bent ingelogd
# apt install ssh -y >/dev/null 2>&1

# Dit als je wel als root bent ingelogd, dus via sharedfolder
apt install ssh -y >/dev/null 2>&1
sudo systemctl start ssh
sudo systemctl enable ssh

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

# ssh osboxes@localhost -p 2222