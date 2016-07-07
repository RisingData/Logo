#!/bin/bash
/usr/local/i3/usbreset $(ls /dev/bus/usb/001/$( lsusb | grep 0403:6014 | cut -d ' ' -f 4 | cut -c-3))
