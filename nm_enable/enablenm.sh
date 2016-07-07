#!/bin/bash
sudo cp -f /usr/local/i3/nm_enable/network-manager.conf /etc/init
sudo cp -f /usr/local/i3/nm_enable/nm-applet.desktop    /etc/xdg/autostart

sudo cp -f /etc/network/interfaces.save /etc/network/interfaces.nmdisabled
sudo cp -f /usr/local/i3/nm_enable/interfaces.nmenabled /etc/network/interfaces
sudo rm -f /etc/init/network-manager.override
echo rebooting with network manager enabled
sleep 5
sudo reboot

