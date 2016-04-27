#!/usr/bin/python
# -*- coding: utf-8 -*-
import serial
import serial.tools.list_ports
import os
import sys


# Funciones!

def ReadMem(addr, length):
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x31))
    ser.write(chr(0x30))

    ACK = ser.read(1);

    if ACK == 0xAA:
        print(hex(ord(ACK)))
        ser.write((addr&(0xFF)) >> 0); 
        ser.write((addr&(0xFF00)) >> 8); 
        ser.write((addr&(0xFF0000)) >> 16); 
        ser.write(0x00); 
	
        ser.write((addr&(0xFF)) >> 0); 
        ser.write((addr&(0xFF00)) >> 8); 
      	ser.write((addr&(0xFF0000)) >> 16); 
        ser.write(0x00); 

        with open("testfile.bin", "wb") as f:
            for index in range(length):
                data = ser.read(1)
                f.write(data)
            

# Main!
ports = serial.tools.list_ports.comports()

i = 0
puertos = []
print('Available ports:')
for port in ports:
    print('[' + str(i) + ']: ' + port.device)
    puertos.append(port)
    i = i + 1

index = int(raw_input('Insert destination port: '))

ser = serial.Serial();

ser.port = (puertos[index]).device
ser.baudrate = 1152000
ser.bytesize = serial.EIGHTBITS #number of bits per bytes
ser.parity = serial.PARITY_NONE #set parity check: no parity
ser.stopbits = serial.STOPBITS_ONE #number of stop bits
ser.timeout = 1

ser.open();

ReadMem(0,1000)

ser.close();

