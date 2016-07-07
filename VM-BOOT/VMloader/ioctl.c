//
//  main.c
//  ioctl
//
//  Created by Windows on 2012-11-17.
//  Copyright (c) 2012 Playful Invention. All rights reserved.
//

#include <stdio.h>
#include <termios.h>
#include <fcntl.h>
#include <sys/ioctl.h>

int main(int argc, const char * argv[])
{
    if (argc < 2)
        return 2;
    
    int fd = open(argv[1], O_RDONLY); // Open the serial port.
    printf("Port opened: %d\n", fd);
    
    if (-1 == fd)
        return 3;
    
    int status;
    ioctl(fd, TIOCMGET, &status);
    printf("Status before: %d\n", status);
    
    if (argc > 3) {
        int dtr = '0' == argv[2][0];
        int rts = '0' == argv[3][0];
        printf("dtr: %d rts: %d\n", dtr, rts);

        if (rts) status |= TIOCM_RTS;
        else status &= ~TIOCM_RTS;
        
        if (dtr) status |= TIOCM_DTR;
        else status &= ~TIOCM_DTR;
        
    printf("trying to set: %d\n", status);
       if (ioctl(fd, TIOCMSET, &status))
        {
            perror("ioctl");
            return 1;
        }
    }
    
    ioctl(fd, TIOCMGET, &status);
    printf("Status after: %d\n", status);

    return 0;
}

