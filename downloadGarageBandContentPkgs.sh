#!/bin/bash
# Jacob Salmela
# Bash version of https://github.com/erikng/adminscripts/blob/master/download-gb-content.py
downloadFolder=/tmp

# Put all the package names into an array
# https://jamfnation.jamfsoftware.com/discussion.html?id=14594#responseChild93147
# http://www.amsys.co.uk/2015/blog/download-garageband-logic-pro-x-content-loops-deployment/
content2015=('MAContent10_GarageBandCoreContent_v3.pkg'
'MAContent10_PremiumPreLoopsChillwave.pkg'
'MAContent10_PremiumPreLoopsDeepHouse.pkg'
'MAContent10_PremiumPreLoopsDubstep.pkg'
'MAContent10_PremiumPreLoopsElectroHouse.pkg'
'MAContent10_PremiumPreLoopsGarageBand.pkg'
'MAContent10_PremiumPreLoopsHipHop.pkg'
'MAContent10_PremiumPreLoopsJamPack1.pkg'
'MAContent10_PremiumPreLoopsModernRnB.pkg'
'MAContent10_PremiumPreLoopsRemixTools.pkg'
'MAContent10_PremiumPreLoopsRhythmSection.pkg'
'MAContent10_PremiumPreLoopsSymphony.pkg'
'MAContent10_PremiumPreLoopsTechHouse.pkg'
'MAContent10_PremiumPreLoopsWorld.pkg'
'MAContent10_GarageBandCoreContent2.pkg'
'ProAudioCoreContent10.pkg')

# Loop through each one and download it to the downloads folder, then optionally, (uncomment) install it
echo "** Downloading 2015 content..."
for ((i = 0; i < "${#content2015[@]}"; i++))
do
	curl -o "$downloadFolder"/"${content2015[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2015/"${content2015[$i]}"
	#installer -pkg "$downloadFolder"/"${content2015[$i]}" -target /
done

# https://www.afp548.com/2012/08/07/garageband-deployment-quick-tip/
content2013=('MAContent10_GarageBandPremiumContent.pkg'
'MAContent10_GB_StereoDrumKitsAlternative.pkg'
'MAContent10_GB_StereoDrumKitsRock.pkg'
'MAContent10_GB_StereoDrumKitsRnB.pkg'
'MAContent10_GB_StereoDrumKitsSongWriter.pkg')

echo "** Downloading 2013 content..."
for ((i = 0; i < "${#content2013[@]}"; i++))
do
	curl -o "$downloadFolder"/"${content2013[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2013/"${content2013[$i]}"
	#installer -pkg "$downloadFolder"/"${content2013[$i]}" -target /
done

# https://jamfnation.jamfsoftware.com/discussion.html?id=6464#responseChild40895
legacyContent=('http://downloads.apple.com/static/gb/gb11bc/GarageBandBasicContent.pkg'
'http://swcdn.apple.com/content/downloads/43/39/061-5890/y2FxthySsyd2PSt3zfZ4mz3XkbqdGZPDZc/GarageBandExtraContent.tar'
'http://audiocontentdownload.apple.com/lp9_ms2_content_2011/MGBContentCompatibility.pkg')

echo "** Downloading legacy content..."
for ((i = 0; i < "${#legacyContent[@]}"; i++))
do
	filename=$(echo "${legacyContent[$i]}" | awk -F'/' '{print $NF}')
	if [[ "$filename" = "GarageBandExtraContent.tar" ]];then
		curl -o "$downloadFolder"/"$filename" "${legacyContent[$i]}"
		# Unarchive to get the .pkg
		tar -xf "$downloadFolder"/"$filename" -C /tmp
		filenamePkg=$(echo "$filename" | cut -d'.' -f-1)
		tar -xf "$downloadFolder"/"$filenamePkg".pkg.tar -C /tmp
		#installer -pkg "$downloadFolder"/"$filenamePkg".pkg -target /
	else
		curl -o "$downloadFolder"/"$filename" "${legacyContent[$i]}"
		#installer -pkg "$downloadFolder"/"${legacyContent[$i]}" -target /
	fi
done

# https://groups.google.com/d/msg/macenterprise/GMGONqr17CM/wQZs6wLAa0AJ
lessons=('2Z695-0098_Rock%20Guitar%201_Power%20Chord%20Punk.pkg'
'2Z695-0099_Rock%20Guitar%202_Suspended%20Chords%20and%20Arpeggios.pkg'
'2Z695-0100_Rock%20Guitar%203_Drop%20D%20and%20Heavy%20Riffs.pkg'
'2Z695-0101_Rock%20Guitar%204_Melodies%20and%20Two%20Note%20Chords.pkg'
'2Z695-0102_Rock%20Guitar%205_Classic%20Riffs.pkg'
'2Z695-0050_Guitar%20Lesson%202_Chords%20-%20G,%20C.pkg'
'2Z695-0051_Guitar%20Lesson%203_Chords%20-%20A,%20D.pkg'
'2Z695-0052_Guitar%20Lesson%204_Minor%20Chords.pkg'
'2Z695-0053_Guitar%20Lesson%205_Single%20Note%20Melodies.pkg'
'2Z695-0054_Guitar%20Lesson%206_Power%20Chords.pkg'
'2Z695-0055_Guitar%20Lesson%207_Major%20Barre%20Chords.pkg'
'2Z695-0056_Guitar%20Lesson%208_Minor%20Barre%20Chords.pkg'
'2Z695-0057_Guitar%20Lesson%209_Blues%20Lead.pkg'
'2Z695-0091_Blues%20Guitar%201_12%20Bar%20Blues%20in%20A.pkg'
'2Z695-0092_Blues%20Guitar%202_Minor%20Pentatonic%20Scale.pkg'
'2Z695-0093_Blues%20Guitar%203_Blues%20Rhythm%20Riffs.pkg'
'2Z695-0094_Blues%20Guitar%204_12%20Bar%20Blues%20in%20Other%20Keys.pkg'
'2Z695-0095_Blues%20Guitar%205_Bends%20and%20Vibrato.pkg'
'2Z695-0096_Blues%20Guitar%206_Hammers,%20Pulls,%20and%20Slides.pkg'
'2Z695-0097_Blues%20Guitar%207_Blues%20Scale%20and%20Quarter%20Bends.pkg'
'2Z695-0103_Pop%20Piano%201_Major%20and%20Minor%20Chords.pkg'
'2Z695-0104_Pop%20Piano%202_Inversions%20and%20Broken%20Chords.pkg'
'2Z695-0105_Pop%20Piano%203_Suspended%20Chords.pkg'
'2Z695-0106_Pop%20Piano%204_7th%20Chords.pkg'
'2Z695-0107_Pop%20Piano%205_Slash%20Chords.pkg'
'2Z695-0108_Pop%20Piano%206_Melodic%20Embellishment.pkg'
'2Z695-0109_Classical%20Piano%201_Mozart%20Minuet.pkg'
'2Z695-0110_Classical%20Piano%202_Bach%20Musette.pkg'
'2Z695-0111_Classical%20Piano%203_Beethoven%20Fuer%20Elise.pkg'
'2Z695-0112_Classical%20Piano%204_Chopin%20Prelude.pkg'
'2Z695-0042_Piano%20Lesson%202_Right%20Hand.pkg'
'2Z695-0043_Piano%20Lesson%203_Left%20Hand.pkg'
'2Z695-0044_Piano%20Lesson%204_Rhythm.pkg'
'2Z695-0045_Piano%20Lesson%205_Sharps%20and%20Flats.pkg'
'2Z695-0046_Piano%20Lesson%206_Rhythmic%20Accents.pkg'
'2Z695-0047_Piano%20Lesson%207_Major%20and%20Minor%20Chords.pkg'
'2Z695-0048_Piano%20Lesson%208_Scales.pkg'
'2Z695-0049_Piano%20Lesson%209_Playing%20the%20Blues.pkg')

echo "** Downloading lessons..."
for ((i = 0; i < "${#lessons[@]}"; i++))
do
	filename=$(echo "${lessons[$i]}" | cut -d'_' -f2- | tr -d '%20')
	curl -o "$downloadFolder"/"$filename" http://downloads.apple.com/pub/lessons/basic/"${lessons[$i]}"
	#installer -pkg "$downloadFolder"/"$filename" -target /
done

# http://thestuff.info/garageband-and-logic-pro-x-additional-content/
logicContent=('MGBContentCompatibility.pkg'
'GarageBandBasicContent.pkg'
'JamPack1.pkg'
'JamPack4_Instruments.pkg'
'MAContent10_AppleLoopsChillwave.pkg'
'MAContent10_AppleLoopsDeepHouse.pkg'
'MAContent10_AppleLoopsDubstep.pkg'
'MAContent10_AppleLoopsElectroHouse.pkg'
'MAContent10_AppleLoopsHipHop.pkg'
'MAContent10_AppleLoopsLegacy1.pkg'
'MAContent10_AppleLoopsLegacyRemix.pkg'
'MAContent10_AppleLoopsLegacyRhythm.pkg'
'MAContent10_AppleLoopsLegacySymphony.pkg'
'MAContent10_AppleLoopsLegacyVoices.pkg'
'MAContent10_AppleLoopsLegacyWorld.pkg'
'MAContent10_AppleLoopsModernRnB.pkg'
'MAContent10_AppleLoopsTechHouse.pkg'
'MAContent10_ElectronicDrumKits.pkg'
'MAContent10_GarageBand6Legacy.pkg'
'MAContent10_InstrumentsBass.pkg'
'MAContent10_InstrumentsGuitar.pkg'
'MAContent10_InstrumentsMallet.pkg'
'MAContent10_InstrumentsOrchestralBrass.pkg'
'MAContent10_InstrumentsOrchestralChoir.pkg'
'MAContent10_InstrumentsOrchestralHarp.pkg'
'MAContent10_InstrumentsOrchestralKeyboard.pkg'
'MAContent10_InstrumentsOrchestralPercussion.pkg'
'MAContent10_InstrumentsOrchestralPipeOrgan.pkg'
'MAContent10_InstrumentsOrchestralStrings.pkg'
'MAContent10_InstrumentsOrchestralWoodwinds.pkg'
'MAContent10_InstrumentsPiano.pkg'
'MAContent10_InstrumentsWorldKeyboards.pkg'
'MAContent10_InstrumentsWorldPercussion.pkg'
'MAContent10_InstrumentsWorldStringed.pkg'
'MAContent10_InstrumentsWorldVoice.pkg'
'MAContent10_InstrumentsWorldWoodwind.pkg'
'MAContent10_IRsStereo.pkg'
'MAContent10_IRsSurround.pkg'
'MAContent10_Logic9Legacy.pkg'
'MAContent10_ProducerBirchKit.pkg'
'MAContent10_ProducerClassicSixtiesKit.pkg'
'MAContent10_ProducerModernMapleKit.pkg'
'MAContent10_ProducerPatches.pkg'
'MAContent10_ProducerPawnShopKit.pkg'
'MAContent10_ProducerSeventiesPlexiKit.pkg'
'MAContent10_ProducerStadiumKit.pkg'
'MAContent10_ProducerStudioKit.pkg')

echo "** Downloading Logic content..."
for ((i = 0; i < "${#logicContent[@]}"; i++))
do
	filename=$(echo "${logicContent[$i]}" | cut -d'_' -f2-)
	curl -o "$downloadFolder"/"$filename" http://downloads.apple.com/pub/lessons/basic/"${logicContent[$i]}"
	#installer -pkg "$downloadFolder"/"$filename" -target /
done
