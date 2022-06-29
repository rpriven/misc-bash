# DOWNLOAD SORTER SCRIPT v1.0
# Written 081920

# This script analyzes file extensions in the current folder,
# creates the necessary directories and sorts the files into
# the proper folders by extension.


# To create folder names based on existing extensions in folder

ls cut -d >> 



# Create recursive directories for extension type

mkdir -pv folder/{mpg,png,gif,webm,jpg,webp,txt,avi,mkv,mod,mp3,vid,jpeg,mov,mp4}/



# Moves all file types to their corresponding folders

find . -iname '*.jpg' -exec mv -iv {} folder/jpg/ \;
find . -iname '*.mp4' -exec mv -iv {} folder/mp4/ \;

### Update : Moves all files to their corresponding folders
for EXT in ext.list
do 
    find . -iname "*.${EXT}" -exec mv -iv {} "${NEWDIR}/${EXT}/" \;
done

