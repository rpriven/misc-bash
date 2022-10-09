#!/bin/bash

# Juice Shop Install Script

echo "Juice Shop Installation Script"
printf "How do you want to install Juice Shop?\n"
echo "1) From Source"
echo "2) Docker Container"
read inst

if [ ! $inst ]; then
    echo "Error, choose either 1 or 2"
fi
if [ $inst == '1' ]; then
    echo "[+] Installing Juice Shop from Source..."
    # install node.js
    cd /opt
    sudo git clone https://github.com/juice-shop/juice-shop.git --depth 1
    cd juice-shop
    npm install
    npm start
fi
if [ $inst == '2' ]; then
    echo "[+] Installing Juice Shop to Docker Container..."
    # install docker
    sudo apt install docker.io
    sudo systemctl enable docker --now
    sudo usermod -aG docker $USER
    # user will need to logout and log in again
    echo "Logout and log in again to finish installing docker"
    docker pull bkimminich/juice-shop
    docker run --rm -p 3000:3000 bkimminich/juice-shop
fi

echo "[*] Juice Shop has been successfully installed!"
echo "Please browse to http://localhost:3000 to use"