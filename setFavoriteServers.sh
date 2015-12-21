#!/bin/bash
# Jacob Salmela
# Sets Favorite Servers
bud='/usr/libexec/Plistbuddy'
plist=$HOME'/Library/Preferences/com.apple.sidebarlists.plist'

servers=('afp://servername'
'smb://servername'
'vnc://servername'
'ftp://servername')

killall cfprefsd
echo "Setting servers for $plist"
echo "Removing previous entries..."
${bud} -c "Delete favoriteservers" ${plist}

echo "Creating new list..."
${bud} -c "Add favoriteservers:Controller string CustomListItems" ${plist}
${bud} -c "Add favoriteservers:CustomListItems array" ${plist}

for i in "${!servers[@]}"
do
	echo "Adding to Favorite Servers: ${servers[$i]}..."
	${bud} -c "Add favoriteservers:CustomListItems:$i:Name string ${servers[$i]}" ${plist}
	${bud} -c "Add favoriteservers:CustomListItems:$i:URL string ${servers[$i]}" ${plist}
done

echo "Finalizing settings..."
killall cfprefsd
defaults read ${plist} favoriteservers > /dev/null
