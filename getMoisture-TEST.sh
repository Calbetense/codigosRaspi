#!/bin/bash

# Compile C program
gcc -o getC_TEST getC_TEST.c

# Send a Byte with Moisture's ID
i2ctransfer -y 1 w1@0x08 0x00

# Waits until GPIO14 gets HIGH
while raspi-gpio get 14 | grep -q "level=0"
        do
                echo '.'
                sleep 1
        done

# Then reads the values and store it in a variable
data=$(i2ctransfer -y 1 r20@0x08)

#TODO gambiarra test
#data="0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x11 0x22 0x33 0x44"

#echo "Data: ${data[*]}"

# Split data in an array of bytes
splited=($(echo $data | tr ' ' '\n'))

#echo "Splited elements: $splited"

# Every 4 bytes send to C program TODO
mod=4  # Modulus
ret="" # Returned values
for((i=0; i < ${#splited[@]}; i+=mod))
do
  toSend=""

  part=( "${splited[@]:i:mod}" )
  #echo "Part generated: ${part[*]}"

  for val in "${part[@]}"
  do
    toSend="$toSend $val"
  done
  #echo "Values to send $toSend"

  # Transfer data to C program
  ret="$ret,$(./getC_TEST $toSend)"
  #echo "returned value $ret"
done

#echo "Returned elements: "
echo ${ret:1}

