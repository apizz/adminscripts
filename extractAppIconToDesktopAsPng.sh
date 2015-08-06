#!/bin/bash
# Find out the name of the icon
if [[ -z "$1" ]];then
	echo "Please provide a path to an .app";exit 1
else
	# Check the Info.plist for the icon's name
	iconFile=$(defaults read "$1"/Contents/Info.plist CFBundleIconFile)
	echo "Icon file is: $iconFile"

	# Convert it to PNG using sips and put it on the Desktop
	sips -s format png "$1"/Contents/Resources/"$iconFile" --out ~/Desktop/"$iconFile".png
fi