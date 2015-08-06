#!/bin/bash
# Jacob Salmela
# Find out the name of the icon of the .app passed to this script as an argument
if [[ -z "$1" ]];then
	echo "Please provide a path to an .app";exit 1
else
	if [[ $1 !=  *.app ]];then
		:
	else
		# Check the Info.plist for the icon's name
		iconFile=$(defaults read "$1"/Contents/Info.plist CFBundleIconFile 2>/dev/null)
		# If there is no icon, there is nothing to do
		if [[ -z "$iconFile" ]];then
			:
		else
			# Get the file extension as some values don't have it in the .plist but the actual file does
			extension="${iconFile##*.}"
			# So if there is no file extension, set one so it can be appended to the filename so it can be used in the sips command
			if [[ "$extension" != "icns" ]];then
				fileExtension="icns"
				echo "* Converting $iconFile.$fileExtension to a PNG..."
				sips -s format png "$1"/Contents/Resources/"$iconFile.$fileExtension" --out ~/Desktop/"$iconFile".png
			else
				# Nothing else to do 
				:
			fi
		fi
	fi
fi