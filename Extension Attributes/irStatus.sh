#!/bin/bash
# Checks if the IR kext is installed or not
#
# Works if the AppleIRController.kext is completely removed:
#
#		srm -r /System/Library/Extensions/AppleIRController.kext
#		touch /System/Library/Extensions/
#
irStatus=$(kextstat -b com.apple.driver.AppleIRController | awk NR==2)
if [ -z "$irStatus" ];then
	echo "<result>Disabled</result>"
else
	echo "<result>Enabled</result>"
fi
