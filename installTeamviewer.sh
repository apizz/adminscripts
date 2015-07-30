#!/bin/bash
# Download the latest version of TeamViewer to the Downloads folder
curl -o ~/Downloads/TeamViewer.dmg http://downloadus3.teamviewer.com/download/TeamViewer.dmg

# Mount the .dmg
hdiutil mount ~/Downloads/TeamViewer.dmg

# Insall TeamViewer silently
if [][ $? = 0 ]];then
  sudo /usr/sbin/installer -pkg /Volumes/TeamViewer/Install\ TeamViewer.pkg -target "/Volumes/Macintosh HD"
else
  echo ".dmg not mounted."
  exit 1
fi

# Unmount the volume when done
umount /Volumes/TeamViewer

# Clean up
rm -f ~/Downloads/TeamViewer.dmg

#pkgutil --expand /Volumes/TeamViewer/Install\ TeamViewer.pkg /tmp/TeamViewer
