#!/bin/bash

# JRE Switcher
# BurpSuite uses jre 17
# neo4j/Bloodhound uses jre 11

# if not run as root, exit
if ! [ $(id -u) = 0 ]; then
    echo -e "[-] Please run as root"
	echo -e "Syntax: sudo $0 <option>"
    exit 1
fi

echo "[*] JRE Version Switcher Script"

ver=$(java --version | grep openjdk | cut -d " " -f 2 | cut -d "." -f 1)

if [ "$1" == "B" ] || [ "$1" == "b" ] || [ "$1" == "burp" ]; then
    sudo update-java-alternatives --jre --set java-1.17.0-openjdk-amd64
    if (( $ver == 17 )); then
        echo "[+] JRE version has been changed to 17"
        exit 0
    elif (( $ver != 17 )); then
        echo "[+] Installing JRE version 17"
        sudo apt-get install openjdk-17-jre
        echo "[+] JRE version 17 installed"
        sudo update-java-alternatives --jre --set java-1.17.0-openjdk-amd64
        echo "[+] JRE version has been changed to 17"
        exit 0
    else
        echo "[-] Error, failed to change JRE to version 17"
        echo "Please try again"
        exit 2
    fi

elif [ "$1" == "N" ] || [ "$1" == "n" ] || [ "$1" == "neo" ]; then
    sudo update-java-alternatives --jre --set java-1.11.0-openjdk-amd64
    if (( $ver == 11 )); then
        echo "[+] JRE version has been changed to 11"
        exit 0
    elif (( $ver != 11 )); then
        echo "[+] Installing JRE version 11"
        sudo apt-get install openjdk-11-jre
        echo "[+] JRE version 11 installed"
        sudo update-java-alternatives --jre --set java-1.11.0-openjdk-amd64
        echo "[+] JRE version has been changed to 11"
        exit 0
    else
        echo "[-] Error, failed to change JRE to version 11"
        echo "Please try again"
        exit 2
    fi

elif ( $# == 0 ); then
    echo -e "[-] No option specified. Options: "
	echo -e "   B - To fix Burp Suite           (switch to jre 17)"
	echo -e "   N - To fix neo4j / Bloodhound   (switch to jre 11)"
	echo -e "Syntax: sudo $0 <option>"
    exit 1
else
    echo -e "Error, exiting"
	echo -e "Syntax: sudo $0 <option>"
    exit 2
fi