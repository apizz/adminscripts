#!/bin/bash
# Set the path where you want the files to go
desiredDir=~/Dropbox

# Set an icon here if you don't like the terminal icon
iconPath=/Applications/Preview.app/Contents/Resources/Preview.icns

# Grab just the filename
filenameWithExtension=$(basename "$1")
filename="${filenameWithExtension%.*}";

# Scanner Pro's default naming convention is something like "Scan Nov 10, 2015"
# Rearrange the month, day, and year to a better format
newFilename=$(echo "$filename" | awk -F' ' '{sub(/\r$/,""); print $4, $2, $3, $5}')

# Remove spaces and replace them with dashes
newFilename=$(echo "$newFilename" | tr -d ',' | tr ' ' -)

# Get just the month name to determine the correct number
month=$(echo "$newFilename" | cut -d- -f2)

# Convert the named month into a number
case "$month" in
    Jan) finalFilename=$(echo "$newFilename" | sed 's/Jan/01/');;
    Feb) finalFilename=$(echo "$newFilename" | sed 's/Feb/02/');;
    Mar) finalFilename=$(echo "$newFilename" | sed 's/Mar/03/');;
    Apr) finalFilename=$(echo "$newFilename" | sed 's/Apr/04/');;
    May) finalFilename=$(echo "$newFilename" | sed 's/May/05/');;
    Jun) finalFilename=$(echo "$newFilename" | sed 's/Jun/06/');;
    Jul) finalFilename=$(echo "$newFilename" | sed 's/Jul/07/');;
    Aug) finalFilename=$(echo "$newFilename" | sed 's/Aug/08/');;
    Sep) finalFilename=$(echo "$newFilename" | sed 's/Sep/09/');;
    Oct) finalFilename=$(echo "$newFilename" | sed 's/Oct/10/');;
    Nov) finalFilename=$(echo "$newFilename" | sed 's/Nov/11/');;
    Dec) finalFilename=$(echo "$newFilename" | sed 's/Dec/12/');;
    *) echo "Could not change file name";;
esac
# Now the filename will be formatting like YYYY-MM-DD.HH-MM.pdf
newFullPath="$desiredDir"/"$finalFilename.pdf"

# Make the PDF searchable
ocrmypdf "$1" "$newFullPath"

# If the previous command was successful
if [[ $? -eq 0 ]];then
    # Get the directory name of the new file
    directoryName=$(dirname "$newFullPath")
    # Store the thumbnail of that file in the same directory
    qlmanage -ti "$newFullPath" -s 512 -o "$directoryName"/
    # Use the thumbnail to display in the notification so the user might be able to recognize the file
    terminal-notifier -title "OCR complete" -message "$finalFilename.pdf" -appIcon "$iconPath" -contentImage "$newFullPath".png
    # Clean up by removing the old file and the thumbnail
    rm "$1"
    rm "$newFullPath".png
else
    terminal-notifier -title "Something went wrong" -message " On this file: $finalFilename.pdf" -appIcon "$iconPath" -contentImage "$newFullPath".png
fi
