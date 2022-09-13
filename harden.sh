#!/bin/bash

# Linux Hardening Script & Guidelines
# Thanks to NetworkChuck for the guide here

## 1. Enable Automatic Updates
sudo apt install unattended-upgrades -y
dpkg-reconfigure --priority=low unattended-upgrades


## 2. Limited User Account
# Create another user with sudo access so you are not logged in as root

# adduser usernamehere
# usermod -aG sudo usernamehere


## 3. Passwords are for suckers
# Create an authentication key-pair for security
# mkdir ~/.ssh && chmod 700 ~/.ssh

## cmd
# ssh-keygen -b 4096

# Private Key = id_rsa
# Public Key = id_rsa.pub

#### Upload public key to server
# Windows:
# scp $env:USERPROFILE/.ssh/id_rsa.pub usernamehere@ipaddress:~/.ssh/authorized_keys

# Linux:
# ssh-copy-id username@ipaddress

#### Now you can ssh in using your authentication, no password
#ssh username@ipadddress


## 4. Lockdown Logins
# Allow only authentication keys, no passwords
# sudo nano /etc/ssh/sshd_config

# Change a few things:
# 1. Port - Change from default 22 to a higher random number (717, 7777)
# 2. AddressFamily - uncomment and change 'any' to inet (changes to ipv4 only)
# 3. PermitRootLogin - change from 'yes' to 'no'
# 4. PasswordAuthentication - change from 'yes' to 'no' (nobody can login with a password)
# Save file and restart ssh daemon
# sudo systemctl restart sshd

# Connect on custom port
# ssh username@ipaddress -p portnumberyoupickedabove


## 5. Firewall it up
# See what ports are in use, what holes are open, what is being allowed into your server
# sudo ss -tupln

# Install UFW
sudo apt install ufw

#### Put in a door for you to get in (on custom port you chose)
# sudo ufw allow 717
# sudo ufw enable

# check status
# sudo ufw status

### *** Before you disconnect, make sure you can login from another shell/terminal window or you will lock yourself out ***
# Install and enable webserver (apache2)
# sudo apt install apache2
# sudo systemctl start apache2

# Notice the new connection
# sudo ss -tupln
# You should see an active webserver on port 80
# Now you need to allow connections to it through the firewall
# sudo ufw allow 80/tcp
# Sometimes you may need to reload your firewall

### Block pings to stay hidden
# Edit the following file:
# sudo nano /etc/ufw/before.rules

# Add one line at the top of the section:   # ok icmp codes for INPUT
# -A ufw-before-input -p icmp --icmp-type echo-request -j DROP
# CTRL + X, CTRL + Y, ENTER

# Restart firewall, test and reboot if not working
# sudo ufw reload

# or reboot if test fails
# sudo reboot
