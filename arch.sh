#!/usr/bin/env sh

sudo pacman -Syu docker

# Power button setup
printf '%s\n' \
  'HandlePowerKey=suspend' \
  'HandlePowerKeyLongPress=poweroff' |
sudo tee -a /etc/systemd/logind.conf >/dev/null

