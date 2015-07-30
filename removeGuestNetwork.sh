#!/bin/bash
# Jacob Salmela
# 2015-07-15
undesiredNetwork="SSID"
wifiOrAirport=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
wirelessDevice=$(networksetup -listallhardwareports | awk "/$wifiOrAirport/,/Device/" | awk 'NR==2' | cut -d " " -f 2)
currentNetwork=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/[^B]SSID/ {print $2}')

echo "The current network is: $currentNetwork"
if [[ "$currentNetwork" = "$undesiredNetwork" ]];then
    echo "Service Name: $wifiOrAirport"
    echo "Device ID: $wirelessDevice"
    echo "Removing $undesiredNetwork from the preferred list..."
    networksetup -removepreferredwirelessnetwork "$wirelessDevice" "$undesiredNetwork"
    echo "Disassociating from $undesiredNetwork..."
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --disassociate
else
    echo "Service Name: $wifiOrAirport"
    echo "Device ID: $wirelessDevice"
    echo "Checking if $undesiredNetwork exists in the preferred list..."
    networksetup -removepreferredwirelessnetwork "$wirelessDevice" "$undesiredNetwork"
fi
