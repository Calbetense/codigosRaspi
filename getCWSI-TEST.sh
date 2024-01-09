#!/bin/bash

# Compile C program
gcc -o getC getC.c

#TODO!! The Address may change!
# Send a Byte with Moisture's ID
i2ctransfer -y 1 w1@0x09 0x00

# TODO!! NOT THE GPIO14
# Waits until GPIO14 gets HIGH
while raspi-gpio get 14 | grep -q "level=0"
        do
                echo '.'
                sleep 1
        done

# Then reads the values and store it in a variable
data=$(i2ctransfer -y 1 r20@0x08)

# Must be commented once everything is running
printf "byte recived: %s\n" $data

# Transfer data to C program
./getC $data

