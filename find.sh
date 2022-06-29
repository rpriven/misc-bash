# Find Script - find.sh
# Created 8/20/2020
#
# This script helps you find files easier, just
# type f and then the name of the file you are
# looking for within the folder

echo "What are some characters in the name of the file are you looking for?"
read file
find . -iname *'$file'*