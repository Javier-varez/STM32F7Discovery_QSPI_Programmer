
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <termios.h>


void configureSerialPort(int fd);


int main(int argc, char *argv[]) {
	
	if (argc >= 2) 
		if (!strcmp(argv[1], "dump")) {
			if (argc < 3) return;
			
			int destination = open(argv[2], O_RDWR);
			if (destination == -1) {
				printf("Error opening destination file!\n");
				return;
			}
			
			int serialP = open("/dev/ttyACM0", O_RDWR | O_NOCTTY );
	
			configureSerialPort(serialP);
			
			printf("Port opened and configured\n");			

			int n = write(serialP, "000000010", 9);
			if (n != 9) { printf("Error writing command\n"); close (serialP); return; }

			uint8_t ACK = 0;
			n = read(serialP, &ACK, 1);
			if (!n) {printf("Didn't acknowledge!\n"); close (serialP); return;}
			else if (ACK = 0xAA) {
				printf("ACK is correct, sending length and addr\n");
				uint8_t data[] = {0x0f, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00};	
				n = write(serialP, data, 8);
				if (n != 8) {printf("Didn't write lenght and addr!\n"); close (serialP); return;}

				uint8_t data_out[4096];
				n = read(serialP, data_out, 0x0f);
				if (n != 0x0f) {printf("Didn't receive all data!!\n"); close (serialP); return;}

				n = write(destination, data_out, 0x0f);
				if (n != 0x0f) {printf("Error writing to file\n"); close (serialP); return;}
			}
			else {printf("Incorrect ACK\n"); close (serialP); return;}
		}
		else if (!strcmp(argv[1], "flash")) {
			printf("option not yet implemented");
		}
	
	return 0;
}


void configureSerialPort(int fd) {
	
	struct termios options;

	tcgetattr(fd, &options);
	cfsetispeed(&options, 9600);
	cfsetospeed(&options, 9600);

	options.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
        | INLCR | IGNCR | ICRNL | IXON);
	options.c_oflag &= ~OPOST; 
	options.c_cflag |= (CLOCAL | CREAD);
	options.c_cflag &= ~PARENB;
	options.c_cflag &= ~CSTOPB;
	options.c_cflag &= ~CSIZE; /* Mask the character size bits */
	options.c_cflag |= CS8;    /* Select 8 data bits */

	tcsetattr(fd, TCSANOW, &options);	
}

