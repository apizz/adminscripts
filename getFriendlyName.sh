#!/bin/bash
# If this variable does not work, change the number eight to a nine
# It is set up to use the US locale by default
# Some people said it worked using the last three digits others said it worked with the last four
lastCharsInSerialNum=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-)

# Use curl to query Apple's servers while inserting the variable that contains the last characters in the Serial Number into the URL
# Pipe it into awk and use <configCode> as the new delimiter, printing the second field
# Pipe it into awk again but use </configCode> as the new delimiter, this time, printing the first field
# This leaves you with just the computer friendly name
curl -s http://support-sp.apple.com/sp/product?cc="$lastCharsInSerialNum" | awk -F'<configCode>' '{print $2}' | awk -F'</configCode>' '{print $1}'
