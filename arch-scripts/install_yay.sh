#!/bin/bash
sudo pacman -Syu
mkdir /tmp/yay
cd /tmp/yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
rm -rf /tmp/yay
yay --version
