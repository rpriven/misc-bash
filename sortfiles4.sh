#!/bin/bash

# FILE SORTER SCRIPT v1.4
# By @rpriven
# Written 081920
# Re-written 120320

# This script analyzes file extensions in the current folder,
# creates the necessary directories and sorts the files into
# the proper folders by their extension.
#
# Due to safety issues, this copies the files instead of 
# moving them.  If you would like to move instead of copy, 
# change line 27 from 'cp' to 'mv'.

# Asks user if they want to copy or move
# Coming soon

# For each file, grab just the extension and remove duplicates.
for f in $(ls)
  do
    echo "${f##*.}" >> /tmp/extraw.txt
    sort -u /tmp/extraw.txt > /tmp/ext.txt
  done

# For each extension type, create a directory and copy or move files.
for x in $(cat /tmp/ext.txt)
  do
    mkdir "${x}"
    cp -iv *."${x}" "${x}"
  done
