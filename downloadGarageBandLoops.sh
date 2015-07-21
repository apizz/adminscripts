#!/bin/bash
# .pkgs to download: https://jamfnation.jamfsoftware.com/discussion.html?id=14594#responseChild93147
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
'MAContent10_GarageBandCoreContent2.pkg')

content2013=('MAContent10_GarageBandPremiumContent.pkg'
'MAContent10_GB_StereoDrumKitsAlternative.pkg'
'MAContent10_GB_StereoDrumKitsRock.pkg'
'MAContent10_GB_StereoDrumKitsRnB.pkg'
'MAContent10_GB_StereoDrumKitsSongWriter.pkg')

# Loop through each one and download it to the downloads folder
for ((i = 0; i < "${#content2015[@]}"; i++))
do
	curl -o ~/Downloads/"${content2015[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2015/"${content2015[$i]}"
done

for ((i = 0; i < "${#content2013[@]}"; i++))
do
	curl -o ~/Downloads/"${content2013[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2013/"${content2013[$i]}"
done