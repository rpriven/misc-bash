#!/bin/bash

# Defensive Lab Setup Script

# General Updates
sudo apt update && sudo apt upgrade -y

# Enable Automatic updates
sudo apt install unattended-upgrades -y

# Wireshark, Snort
sudo apt install wireshark snort
