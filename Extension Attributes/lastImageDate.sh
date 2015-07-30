#!/bin/bash
# Last image (install) date
# https://jamfnation.jamfsoftware.com/discussion.html?id=6020
declare -x perl="/usr/bin/perl"
declare -x date="/bin/date"
declare -xi FIRST_BOOT_EPOCH="$($perl -e 'print ((stat($ARGV[0]))[9]);' /var/db/SystemKey)"
declare -x  FIRST_BOOT_GUESS="$($date -r $FIRST_BOOT_EPOCH "+%Y-%m-%d %H:%M:%S")"

printf "<result>%s</result>\n" "$FIRST_BOOT_GUESS"
