#!/bin/bash

# picoCTF Flag Puller for binary files
# thanks to SYREAL for his awesome ltdis.sh script
# also thanks to John Hammond for info on this

# if file doesn't exist, exit with error
if [ ! -e $1 ]
then
        echo "Error!"
        echo "File: ${1} not found!"
        exit

# else continue
else
        echo "... Pulling picoCTF flag from $1 ..."

        objdump -Dj .text $1 > $1.ltdis.txt

        # if disassembled file is not empty

        if [ -s "$1.ltdis.txt" ]
        then
                echo "Disassembly success!"
                strings -a -t x $1 > $1.ltdis.txt

                # grep -o (only) -E (extended regex) to get just the flag
                cat $1.ltdis.txt | grep -oE "picoCTF{.*}" > $1.flag.txt

                printf "Flag captured!\n\n"
                echo $(cat $1.flag.txt)

        # else exit with other errors

        else
                echo "Error!"
                echo "Usage: ./bin_flag.sh <filename>"
        fi
fi
