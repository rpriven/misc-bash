#!/bin/bash

# Rob Pratt
# v1.0

# This script, when executed, shows current price of node investments
# and profits to date.  This accounts for profits from rewards as
# well as profits from increase in token price as necessary.


# Define variables

# Define functions

function fulloutput() {
echo " "
}

function addnode(){
echo "What is the 
}

# Security Check
echo "[+] Security Check [+]"
read -sp "Please enter your password to continue...: " pass
if [[ $pass != "password" ]]; then
    printf "\nERROR: You are Not Authorized!\n";
    exit 1;
fi

# Script options

echo "[+] Investment Script Active! Please choose from the following options: [+]"

echo "   [1] Display Current Node Investments"
echo "   [2] Add a Node Project to the Investment List"
echo "   [3] Modify Existing Node Projects"
echo "   [9] Exit"
read -p "What would you like to do?" options
if [[ ${0} == 1 ]];
    fulloutput;
elif [[ ${0} == 2 ]];
    addnode;
elif [[ ${0} == 3 ]];
    modify;
elif [[ ${0} == 9 ]];
    exit 9;
fi

# Get current date


# Get current prices

# Determine initial investment amounts




# Output
echo "Test"
echo "