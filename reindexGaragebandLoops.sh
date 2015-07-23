#!/bin/bash
# Jacob Salmela
# Re-indexes GarageBand loops for for version prior to GarageBand 10.
	
# Copy ALPIndex.app into /Applications on each machine that the script will run on
#----------VARIABLES---------	
indexLoops="/Applications/ALPIndex.app/Contents/MacOS/ALPIndex"
localIndicies="/Library/Audio/Apple Loops Index"
loopsLocation="/Library/Audio/Apple Loops/Apple"

#----------SCRIPT------------
echo "** Removing bad index files..."
rm -rf "$localIndicies"/*

# Index each collection of loops
for loopCollection in "$loopsLocation"/*; do
	collectionName=$(echo "$loopCollection" | awk -F'/' '{print $NF}')
	echo "** Indexing: $collectionName..."
 	$indexLoops "$loopsLocation"/"$collectionName" &>/dev/null
done
echo ""

# List how many compilations were indexed
$indexLoops -p | grep 'Total number of indexed directories'