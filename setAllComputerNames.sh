#!/bin/bash
# Set all four computer names
scutil --set LocalHostName "HHS-Student-"
scutil --set ComputerName "HHS-Student"
scutil --set HostName "HHS-Student"
serialNum=$(ioreg -l | awk '/IOPlatformSerialNumber/ { split($0, line, "\""); printf("%s\n", line[4]); }')
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$serialNum"
