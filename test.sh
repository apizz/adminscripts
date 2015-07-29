#!/bin/bash
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
	echo curl -o "$downloadFolder"/"$filename" http://downloads.apple.com/pub/lessons/basic/"${logicContent[$i]}"
	#installer -pkg "$downloadFolder"/"$filename" -target /
done
