#!/bin/bash
# List only the .panic files and count how many lines
numOfPanics=$(ls -l /Library/Logs/DiagnosticReports/*.panic | wc -l | sed 's/ //g')

echo "<result>$numOfPanics</result>"
