#!/bin/bash
# Cancel all jobs on all destinations and their corresponding data files
cancel -ax

# Cancel all jobs using another method
lprm -

for printer in $(lpstat -p | awk '{print $2}')
do
  # Set the printer to abort stuck jobs from now on
  lpadmin -p $P -o printer-error-policy=abort-job

  # Cancel all jobs and their corresponding data files
  cancel -ax $printer

  # Cancel all jobs using another method: lprm
  lprm -P $printer

  # Cancel jobs and disable CUPS
  cupsdisable -c $printer

  # Cancel jobs while re-enabling CUPS
  cupsenable -c $printer

# Complete the for loop
done
