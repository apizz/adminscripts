#!/bin/bash
for printer in $(lpstat -p | awk '{print $2}')
do
  echo Deleting $printer...
  lpadmin -x $printer
done
