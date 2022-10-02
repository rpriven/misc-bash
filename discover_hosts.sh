#!/bin/bash

# Basic Host Discovery Tool 
# by @rpriven
# I created this to help automate the process of
# finding various CTF/VulnHub VMs on my network
# that I couldn't login to get the ip

if [ $1 == "" ]
then
    echo "Error! No IP address entered"
    echo "Syntax: ./host_discover.sh 192.168.226.0/24"

else
    printf "[*] Host Discovery Tool [*]\n\n"

    echo "[+] Running Netdiscover..."
    sudo netdiscover -i eth0 -P -r $1 > hosts_detailed.txt
    cat hosts_detailed.txt | grep -e ^.[0-9] | cut -d " " -f 2 > hosts

    echo "[+] Running Nmap..."
    nmap -sn $1 > nmap.txt | grep [0-9]$ | cut -d " " -f 5 >> hosts
    cat nmap.txt >> hosts_detailed.txt
    rm nmap.txt

    echo "[+] Running fping..."
    fping -a -g $1 >> hosts 2>/dev/null

    printf "\n[-] Scans Complete\n\n"
    printf "[*] Hosts Found:\n\n"
    cat hosts | sort | uniq > hosts.txt
    cat hosts.txt
    rm hosts

    printf "\nSee hosts_detailed.txt for more information"
fi