#!/usr/bin/python
# -*- coding: utf-8 -*-
import serial
import serial.tools.list_ports
import os
import sys
import subprocess


# Definiciones de constantes
openocdRuta = '/usr/local/share/openocd/scripts/'
openocdInterface = 'interface/stlink-v2-1.cfg'
openocdAdapterSpeed = '1800'
openocdTarget = 'target/stm32f7x.cfg'

bpsUart = 576000

CC = 'arm-none-eabi-'
QSPISection = 'ExtFlashSection'#'.ExtQSPIFlashSection'

## On my programs, QSPI section is named '.ExtQSPIFlashSection'
## On touchgfx programs, linker script defaults to 'ExtFlashSection'

# Funciones!

def ReadMem(addr, length, outfile):
    # Write Key
    print('Inserting Key')
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x31))
    # Opcode
    print('Starting Memory Dump Operation')
    ser.write(chr(0x30))

    # Wait ACK
    ACK = ser.read(1);
    if int(ACK.encode('hex'), 16) == 0xaa:
        print('Acknowledge received: ' + hex(ord(ACK)))
	
	# Write Length and Addr
        ser.write(chr(((length-1)&(0xFF)) >> 0));
        ser.write(chr(((length-1)&(0xFF00)) >> 8));
        ser.write(chr(((length-1)&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        ser.write(chr((addr&(0xFF)) >> 0));
        ser.write(chr((addr&(0xFF00)) >> 8));
        ser.write(chr((addr&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

	print('Starting memory dump')

	# Dump memory contents to file.
        with open(outfile, "wb") as f:
            for index in range(length):
                data = ser.read(1)
                f.write(data)

def WriteMem(addr, length, infile):
    # Write Key
    print('Inserting Key')
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x30))
    ser.write(chr(0x31))
    # Opcode 
    print('Starting Memory Write Operation')
    ser.write(chr(0x31))

    # Wait ACK
    ACK = ser.read(1);
    if int(ACK.encode('hex'), 16) == 0xBB:
        print('Acknowledge received: ' + hex(ord(ACK)))

	# Write Length and Addr
        ser.write(chr(((length)&(0xFF)) >> 0));
        ser.write(chr(((length)&(0xFF00)) >> 8));
        ser.write(chr(((length)&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

        ser.write(chr((addr&(0xFF)) >> 0));
        ser.write(chr((addr&(0xFF00)) >> 8));
        ser.write(chr((addr&(0xFF0000)) >> 16));
        ser.write(chr(0x00));

	# Wait while erasing blocks
	ser.timeout = 100
	print('Erasing Corresponding QSPI Blocks')	

        ACK2 = ser.read(1)

	ser.timeout = 10
	
        if int(ACK2.encode('hex'), 16) == 0xAA:
	    print('Acknowledge received: ' + hex(ord(ACK2)))
	    print('Start Data Transmission')
	    # Start memory contents update
            with open(infile, "rb") as f:
                for index in range(length//0x1000):
		    print('Writing block. Start Addr = ' + hex(index*0x1000))
                    data = f.read(0x1000)
                    ser.write(data)
                    ACK3 = ser.read(1)
                    if int(ACK3.encode('hex'), 16) != 0xAA:
                        print('Error!!!')
                if (length//0x1000)*0x1000 != length:
		    print(str((length//0x1000)*0x1000))
		    print(str(length))
                    data = f.read(length - (length//0x1000)*0x1000)
                    ser.write(data)
                    ACK3 = ser.read(1)
                    if int(ACK3.encode('hex'), 16) != 0xAA:
                        print('Error!!!')


#####################
######  Main!  ######
#####################

# Get ports
ports = serial.tools.list_ports.comports()

i = 0
puertos = []
print('Available ports:')
for port in ports:
    print('[' + str(i) + ']: ' + port.device)
    puertos.append(port)
    i = i + 1

# Choose destination port
index = int(raw_input('Insert destination port: '))

ser = serial.Serial();

# Configure Port
ser.port = (puertos[index]).device
ser.baudrate = bpsUart
ser.bytesize = serial.EIGHTBITS #number of bits per bytes
ser.parity = serial.PARITY_NONE #set parity check: no parity
ser.stopbits = serial.STOPBITS_ONE #number of stop bits
ser.timeout = 10

# Flash QSPI loader
subprocess.call(['openocd', '-s', openocdRuta, '-f', openocdInterface, '-c', 'adapter_khz ' + openocdAdapterSpeed, '-f', openocdTarget, '-c', 'reset_config srst_only srst_nogate', '-c', 'init', '-c', 'targets', '-c', 'reset halt', '-c', 'program QSPI_Programmer.elf verify reset exit'])

# Open Port
ser.open();

# Choose Operation
print('-----------------')
print('Select Operation:')
print('[0]: Write Memory')
print('[1]: Memory Dump')

op = int(raw_input('OP: '))

# Perform operations
if op==1:
    addr = int(raw_input('Addr: '))
    length = int(raw_input('Length: '))
    outfile = raw_input('Output filename: ')
    ReadMem(addr, length, outfile)
else:
    infile = raw_input('Input ELF filename: ')
	
    # Extract QSPI Flash Section
    subprocess.call([CC+'objcopy', '--only-section='+QSPISection, '-O', 'binary', infile, '.tmpextflashdump'])

    length = os.stat('.tmpextflashdump').st_size
    print('File length = ' + str(length))
    WriteMem(0, length, '.tmpextflashdump')
    
    subprocess.call(['rm', './.tmpextflashdump'])
    
    # Remove internal QSPI section
    subprocess.call([CC+'objcopy', '--remove-section='+QSPISection, infile, 'outputElf.elf'])

    # Load Internal Flash Contents
    subprocess.call(['openocd', '-s', openocdRuta, '-f', openocdInterface, '-c', 'adapter_khz ' + openocdAdapterSpeed, '-f', openocdTarget, '-c', 'reset_config srst_only srst_nogate', '-c', 'init', '-c', 'targets', '-c', 'reset halt', '-c', 'program outputElf.elf verify reset exit'])

    subprocess.call(['rm', './outputElf.elf'])

# Close Serial port and exit
print('')
print('')
print('Done!')
print('Closing serial Port')
print('Exiting')

ser.close();






