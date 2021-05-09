#!/bin/sh
sudo pacman -S virtualbox-guest-utils
sudo groupadd vboxsf
sudo gpasswd -a $USER vboxsf
sudo modprobe -a vboxguest vboxsf vboxvideo
