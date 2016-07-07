
import serial
import os
import re
import time

file = ''
for f in os.listdir('/dev'):
    if re.match('ttyUSB', f):
        file = '/dev/' + f
        break
if file == '':
    print "Can't find file"
    exit(1)

ser = serial.Serial(file, 19200, parity=serial.PARITY_NONE,
                                bytesize=8,
                                stopbits=1)
def dowait():
    time.sleep(0.05)

ser.setDTR(True)
ser.setRTS(False)
dowait()
ser.setDTR(False)
