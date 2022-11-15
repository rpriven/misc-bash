#!/bin/bash

# Shell addons for fun
# thanks https://linoxide.com/linux-fun-terminal-crazy-output/

sudo apt install cowsay lolcat fortune cmatrix figlet aview imagemagick neofetch

mkdir ~/.oh-my-zsh/custom/plugins/chucknorris
cd ~/.oh-my-zsh/custom/plugins/chucknorris
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/chucknorris/chucknorris.plugin.zsh
mkdir ~/.oh-my-zsh/custom/plugins/chucknorris/fortunes
cd ~/.oh-my-zsh/custom/plugins/chucknorris/fortunes
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/chucknorris/fortunes/chucknorris
cd

figlet shell addons installed -f slant | lolcat

# useful commands
# cowsay -l
# cowsay -f <name>
# showfigfonts
# figlet -f <font-name>
# asciiview <filename>