#!/bin/bash
# Phrase to search for
phrase="verification of insurance"

# Comma separated tags that should be applied to any files matched
tags="Insurance,Geico"

# Where to move the file if a match if found
moveToFolder=~/Dropbox/Documents/Insurance/Auto/

# Get just the file name
filenameWithExtension=$(basename "$1")

# Search for the phrase in the PDF
pdfgrep -i "$phrase" "$1"

# If it is successfull
if [[ $? -eq 0 ]];then
    # Apply the tags to the file
    tag --add "$tags" "$1"
    # Move the PDF into the folder
    mv "$1" "$moveToFolder"
    # And send a notification that it did
    terminal-notifier -title "$filenameWithExtension" -subtitle "Tagged and moved to..." -message "$moveToFolder"
else
    # If it failed, send a message so the user knows
    terminal-notifier -title "$filenameWithExtension" -subtitle "! Failed to move file" -message "Something went wrong."
fi
