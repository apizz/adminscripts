#!/bin/bash
# http://osxdaily.com/2014/03/12/send-sms-text-message-from-command-line/
# Just change the phone number
# Whatever is passed as an argument to this function will serve as the message to be sent
curl http://textbelt.com/text -d number=5551113333 -d "message=$1"

echo "Message sent."
