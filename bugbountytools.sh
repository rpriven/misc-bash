#!/bin/bash

# Installs useful Bug Bounty tools
echo "[*] Installing Bug Bounty Tool Suite"

cd /opt

# Burp Suite
echo "[+] Installing Burp Suite"
sudo apt install burpsuite

# WFuzz
echo "[+] Installing WFuzz..."
pip install wfuzz

# dirb / dirbuster / gobuster
echo "[+] Installing dirb, dirbuster and gobuster..."
sudo apt install dirb dirbuster gobuster

# Knockpy
echo "[+] Installing Knockpy..."
sudo git clone https://github.com/guelfoweb/knock.git
cd knock
pip3 install -r requirements.txt

cd /opt

# Sublist3r
echo "[+] Installing Sublist3r..."
sudo git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt

cd /opt

# SecLists
echo "[+] Installing SecLists..."
sudo apt install seclists -y

# Scrapy
echo "[+] Installing Scrapy..."
pip install scrapy

# SQLmap
echo "[+] Installing SQLMap"
sudo apt install sqlmap

# Striker
echo "[+] Installing Striker..."
sudo git clone https://github.com/s0md3v/Striker.git
cd Striker
pip install -r requirements.txt

cd /opt

echo "[*] Installation Complete"