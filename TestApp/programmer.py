#!/usr/bin/python
# -*- coding: utf-8 -*-
import serial
import serial.tools.list_ports
import os
import sys
import subprocess

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
    if int(ACK.encode('hex'), 16) == 0xaa:
        print(hex(ord(ACK)))
        ser.write(chr(((length-1)&(0xFF)) >> 0));
        ser.write(chr(((length-1)&(0xFF00)) >> 8));
        ser.write(chr(((length-1)&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        ser.write(chr((addr&(0xFF)) >> 0));
        ser.write(chr((addr&(0xFF00)) >> 8));
        ser.write(chr((addr&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        with open("testfile.bin", "wb") as f:
            for index in range(length):
                data = ser.read(1)
                f.write(data)

def WriteMem(addr, length):
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x31))
    ser.write(chr(0x31))

    ACK = ser.read(1);
    if int(ACK.encode('hex'), 16) == 0xBB:
        print(hex(ord(ACK)))
        ser.write(chr(((length-1)&(0xFF)) >> 0));
        ser.write(chr(((length-1)&(0xFF00)) >> 8));
        ser.write(chr(((length-1)&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        print(str(((length)&(0xFF)) >> 0))
        print(str(((length)&(0xFF00)) >> 8))
        print(str(((length)&(0xFF0000)) >> 16))

        ser.write(chr((addr&(0xFF)) >> 0));
        ser.write(chr((addr&(0xFF00)) >> 8));
        ser.write(chr((addr&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        ACK2 = ser.read(1)
        if int(ACK2.encode('hex'), 16) == 0xAA:
            with open("extflash.bin", "rb") as f:
                for index in range(length//0x1000):
                    data = f.read(0x1000)
                    ser.write(data)
                    ACK3 = ser.read(1)
                    if int(ACK3.encode('hex'), 16) != 0xAA:
                        print('Error!!!')
                if (length//2)*length != length:
                    data = f.read(length - (length//2)*length)
                    ser.write(data)
                    ACK3 = ser.read(1)
                    if int(ACK3.encode('hex'), 16) != 0xAA:
                        print('Error!!!')


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
ser.baudrate = 576000
ser.bytesize = serial.EIGHTBITS #number of bits per bytes
ser.parity = serial.PARITY_NONE #set parity check: no parity
ser.stopbits = serial.STOPBITS_ONE #number of stop bits
ser.timeout = 100

ruta = '/usr/local/share/openocd/scripts/'

subprocess.call(['openocd', '-s', ruta, '-f', 'interface/stlink-v2-1.cfg', '-c', 'adapter_khz 1800', '-f', 'target/stm32f7x.cfg', '-c', 'reset_config srst_only srst_nogate', '-c', 'init', '-c', 'targets', '-c', 'reset halt', '-c', 'program QSPI_Programmer.elf verify reset exit'])

ser.open();

print('-----------------')
print('Select Operation:')
print('[0]: Write Memory')
print('[1]: Memory Dump')

op = int(raw_input('OP: '))

addr = int(raw_input('Addr: '))
length = int(raw_input('Length: '))

if op==1:
    ReadMem(addr,length)
else:
    WriteMem(addr, length)

ser.close();

subprocess.call(['openocd', '-s', ruta, '-f', 'interface/stlink-v2-1.cfg', '-c', 'adapter_khz 1800', '-f', 'target/stm32f7x.cfg', '-c', 'reset_config srst_only srst_nogate', '-c', 'init', '-c', 'targets', '-c', 'halt', '-c', 'exit'])
#subprocess.call(['openocd', '-f', 'interface/stlink-v2-1.cfg', '-c', 'adapter_khz 1800', '-f', 'target/stm32f7x.cfg', '-c', 'reset_config srst_only srst_nogate', '-c', 'init', '-c', 'targets', '-c', 'reset halt', '-c', 'program SI_P1.elf verify reset exit'])

