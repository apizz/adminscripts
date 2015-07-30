#!/bin/bash
for u in /Users/*
do
user=$(echo $u | cut -d'/' -f3)
if [[ "$user" = "Shared" ]] || [[ "$user" = "Deleted Users" ]];then
	:
else
  echo "Do something"
fi
done
