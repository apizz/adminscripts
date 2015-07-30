#!/bin/bash
volumeName=$(diskutil info / | awk '/Volume Name/ {print substr ($0, index ($0,$3))}')

if [ "$volumeName" != "Macintosh HD" ];then
	echo "<result>Incorrect</result>"
else
	echo "<result>Correct</result>"
fi
