#!/bin/bash
sudo rm -f /etc/init/network-manager.conf
sudo rm -f /etc/xdg/autostart/nm-applet.desktop

sudo cp -f /etc/network/interfaces.nmdisabled /etc/network/interfaces
echo "manual" | sudo tee /etc/init/network-manager.override
echo rebooting with network manager disabled - auto connect to I3 wireless
sleep 5
sudo reboot

