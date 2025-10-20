#!/usr/bin/env sh

# System tools & utilities
pacman -S --noconfirm neovim vi fasd fzf ripgrep moreutils tree zip unzip p7zip rsync hugo neofetch less man-db git lazygit git-delta

# Audio tools: Pipewire, pamixer, and pavucontrol
pacman -S --noconfirm pamixer pavucontrol

# X Server & i3-related stuff
pacman -S --noconfirm i3-wm i3blocks i3lock i3status xsel xclip

# Terminal & Shell setup
pacman -S --noconfirm alacritty fish fisher

# Bluetooth tools
pacman -S --noconfirm bluez bluez-utils blueberry

# Disk mounting tools
pacman -S --noconfirm udisks2 udiskie

# Power management (backlight, battery, etc.)
pacman -S --noconfirm acpi brightnessctl cbatticon

# Notifications and utilities
pacman -S --noconfirm dunst feh direnv picom mesa mesa-demos

# Password manager & security
pacman -S --noconfirm pass pass-otp

# Network utilities & tools
pacman -S --noconfirm inetutils tcpdump bind network-manager-applet

# System management tools
pacman -S --noconfirm stow docker

# File management
pacman -S --noconfirm ctpv

# Development tools & languages
pacman -S --noconfirm go go-tools nodejs npm python3 python-pip

# Communication tools
pacman -S --noconfirm telegram-desktop signal-desktop

# File & media management
pacman -S --noconfirm libreoffice-fresh okular ffmpeg vlc mpv sxiv flameshot
pacman -S --noconfirm thunar tumbler gvfs sshfs

# Syncing & cloud
pacman -S --noconfirm syncthing

# Fonts
sudo pacman -S --noconfirm noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ttf-jetbrains-mono ttf-jetbrains-mono-nerd powerline-fonts
