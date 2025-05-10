#!/usr/bin/bash

sudo apt install openssh-server -y
setxkbmap fr


sudo chmod +x /home/osboxes.org/setup_tomcat.sh
/home/osboxes.org/setup_tomcat.sh