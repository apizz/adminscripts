#!/bin/bash
# This is the Apple-approved way to get the currently logged in user
# https://developer.apple.com/library/mac/qa/qa1133/_index.html
currentUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`

# Below are alternate ways to get the currently logged in user
#currentUser=$(stat -f "%Su" /dev/console)
# Alternate ways to get the currently logged in user
#	currentUser=$(who | grep console | awk '{print $1}')
#	currentUser=$(logname)
#	currentUser=$(ls -l /dev/console | cut -d " " -f4)
#	currentUser=$(printf "get State:/Users/ConsoleUser\nd.show" | scutil | awk '/kCGSSessionUserNameKey/ {print $3}')

echo "$currentUser"
