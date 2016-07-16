#!/bin/bash
# Jacob Salmela
# Bash version of https://github.com/erikng/adminscripts/blob/master/download-gb-content.py
# Also downloads GarageBand Lessons and Logic Pro content
downloadFolder="/Users/Shared"
log="/path/to/GB/downloadinstall.log"
writelog() {
	if [ $? = 0 ]; then
		/bin/echo $(date) "${1}" >> $log
	else
		/bin/echo $(date) "${2}" >> $log
	fi
}

# Creates log if it doesn't exist
if [ ! -f $log ]; then
	/usr/bin/touch $log
	writelog "Garageband Loops Log: Creation Successful." "Garageband Loops Log: Creation Failed."
	/usr/sbin/chown root:wheel $log
	/bin/chmod 644 $log
	writelog "Garageband Loops Log Permissions: Successful." "Garageband Loops Log Permissions: Failed."
	/bin/echo "----------- Begin Garageband Loops Download & Install Script -----------" >> $log
else
	/bin/echo "Garageband Loops Log Exists. Beginning Loop Download & Install Script." >> $log
	/bin/echo "----------- Begin Garageband Loops Download & Install Script -----------" >> $log
fi

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
'ProAudioCoreContent10.pkg'
'MAContent10_IRsStereo.pkg'
'MAContent10_ElectronicDrumKits.pkg'
'MAContent10_InstrumentsCinematic.pkg'
'MAContent10_InstrumentsMellotron.pkg'
'MAContent10_LogicCoreContent2Assets.pkg'
'MAContent10_LogicCoreContent2Presets.pkg'
'MAContent10_AlchemyPatchesACPs_Atmospheric.pkg'
'MAContent10_AlchemyPatchesACPs_BasicAdd.pkg'
'MAContent10_AlchemyPatchesACPs_Cinematic.pkg'
'MAContent10_AlchemyPatchesACPs_Dance.pkg'
'MAContent10_AlchemyPatchesACPs_ModernSongwriter.pkg'
'MAContent10_AlchemyPatchesACPs_ModernSynth.pkg'
'MAContent10_AlchemyPatchesACPs_TexturesNEffects.pkg'
'MAContent10_AlchemyPatchesACPs_VintageSynth.pkg'
'MAContent10_AssetPack_0002_AlchemyOrgans.pkg'
'MAContent10_AssetPack_0003_AlchemyBrass.pkg'
'MAContent10_AssetPack_0004_AlchemyWoodwinds.pkg'
'MAContent10_AssetPack_0005_AlchemyStrings.pkg'
'MAContent10_AssetPack_0006_AlchemyKeysOtherNCustom.pkg'
'MAContent10_AssetPack_0007_AlchemyKeysElectric.pkg'
'MAContent10_AssetPack_0008_AlchemyKeysAcoustic.pkg'
'MAContent10_AssetPack_0009_AlchemyMalletsSynthetic.pkg'
'MAContent10_AssetPack_0010_AlchemyMalletsMisc.pkg'
'MAContent10_AssetPack_0011_AlchemyLoopsBeatBoxBreaks.pkg'
'MAContent10_AssetPack_0012_AlchemyLoopsBeatBoxDance.pkg'
'MAContent10_AssetPack_0013_AlchemyLoopsBeatBoxDrumnBass.pkg'
'MAContent10_AssetPack_0014_AlchemyLoopsBeatBoxDubstep.pkg'
'MAContent10_AssetPack_0015_AlchemyLoopsBeatBoxHipHop.pkg'
'MAContent10_AssetPack_0016_AlchemyLoopsBeatBoxPhrases.pkg'
'MAContent10_AssetPack_0017_AlchemyLoopsDrum.pkg'
'MAContent10_AssetPack_0018_AlchemyLoopsEffect.pkg'
'MAContent10_AssetPack_0019_AlchemyLoopsMelodic.pkg'
'MAContent10_AssetPack_0020_AlchemyLoopsMisc.pkg'
'MAContent10_AssetPack_0021_AlchemyDrumsReal.pkg'
'MAContent10_AssetPack_0022_AlchemyDrumsMisc.pkg'
'MAContent10_AssetPack_0023_AlchemyDrumsBeatBoxProcessed.pkg'
'MAContent10_AssetPack_0024_AlchemyDrumsBeatBoxRR.pkg'
'MAContent10_AssetPack_0025_AlchemyDrumsBeatBoxVelocity.pkg'
'MAContent10_AssetPack_0026_AlchemyDrumsBeatBoxVox.pkg'
'MAContent10_AssetPack_0027_AlchemyDrumsElectronicMisc.pkg'
'MAContent10_AssetPack_0028_AlchemyDrumsUnusualIceFX.pkg'
'MAContent10_AssetPack_0029_AlchemyDrumsUnusualDeep.pkg'
'MAContent10_AssetPack_0030_AlchemyDrumsUnusualCymbalFX.pkg'
'MAContent10_AssetPack_0031_AlchemyDrumsUnusualDarkStrike.pkg'
'MAContent10_AssetPack_0032_AlchemyDrumsUnusualDarkThunderDrum.pkg'
'MAContent10_AssetPack_0033_AlchemyDrumsUnusualCaveDrum.pkg'
'MAContent10_AssetPack_0034_AlchemyDrumsUnusualCupOfTea.pkg'
'MAContent10_AssetPack_0035_AlchemyDrumsUnusualLightSpaceKit.pkg'
'MAContent10_AssetPack_0036_AlchemyDrumsUnusualMisc.pkg'
'MAContent10_AssetPack_0037_AlchemyPadsCustomNSingle.pkg'
'MAContent10_AssetPack_0038_AlchemyPadsDigitalEatherDrone.pkg'
'MAContent10_AssetPack_0040_AlchemyPadsDigitalPhasedPad.pkg'
'MAContent10_AssetPack_0041_AlchemyPadsDigitalBeginPad.pkg'
'MAContent10_AssetPack_0042_AlchemyPadsDigitalEmotionalHeights.pkg'
'MAContent10_AssetPack_0043_AlchemyPadsDigitalBuzzPad.pkg'
'MAContent10_AssetPack_0044_AlchemyPadsDigitalJunglePad.pkg'
'MAContent10_AssetPack_0045_AlchemyPadsDigitalRedspace.pkg'
'MAContent10_AssetPack_0046_AlchemyPadsDigitalGuitarPad.pkg'
'MAContent10_AssetPack_0047_AlchemyPadsDigitalSteamChoir.pkg'
'MAContent10_AssetPack_0048_AlchemyPadsDigitalHolyGhost.pkg'
'MAContent10_AssetPack_0049_AlchemyPadsDigitalMenangeriePad.pkg'
'MAContent10_AssetPack_0050_AlchemyPadsDigitalDustWorldSweep.pkg'
'MAContent10_AssetPack_0051_AlchemyPadsDigitalDreamstealer.pkg'
'MAContent10_AssetPack_0052_AlchemyPadsDigitalInterferencePad.pkg'
'MAContent10_AssetPack_0054_AlchemyPadsDigitalVikingLongboat.pkg'
'MAContent10_AssetPack_0055_AlchemyPadsDigitalEndless.pkg'
'MAContent10_AssetPack_0056_AlchemyPadsDigitalSunspots.pkg'
'MAContent10_AssetPack_0058_AlchemyPadsDigitalSeismicShift.pkg'
'MAContent10_AssetPack_0061_AlchemyPadsDigitalMisc.pkg'
'MAContent10_AssetPack_0062_AlchemyPadsAnalog80s.pkg'
'MAContent10_AssetPack_0063_AlchemyPadsAnalogChoirLike.pkg'
'MAContent10_AssetPack_0064_AlchemyPadsAnalogTwinStrings.pkg'
'MAContent10_AssetPack_0065_AlchemyPadsAnalogMisc.pkg'
'MAContent10_AssetPack_0066_AlchemySoundscapesCustomNSingle.pkg'
'MAContent10_AssetPack_0067_AlchemySoundscapesWater.pkg'
'MAContent10_AssetPack_0068_AlchemySoundscapesDroneFX.pkg'
'MAContent10_AssetPack_0069_AlchemySoundscapesMicroForest.pkg'
'MAContent10_AssetPack_0071_AlchemySoundscapesMetalWall.pkg'
'MAContent10_AssetPack_0072_AlchemySoundscapesRelevent.pkg'
'MAContent10_AssetPack_0073_AlchemySoundscapesWaveTraveller.pkg'
'MAContent10_AssetPack_0074_AlchemySoundscapesJungleGhosts.pkg'
'MAContent10_AssetPack_0075_AlchemySoundscapesRecalculation.pkg'
'MAContent10_AssetPack_0076_AlchemySoundscapesArtefact.pkg'
'MAContent10_AssetPack_0078_AlchemySoundscapesStrungNBow.pkg'
'MAContent10_AssetPack_0079_AlchemySoundscapesWaterNAqua.pkg'
'MAContent10_AssetPack_0080_AlchemySoundscapesComplexSynthesis.pkg'
'MAContent10_AssetPack_0083_AlchemySoundscapesSpareAtmosphere.pkg'
'MAContent10_AssetPack_0084_AlchemySoundscapesTheDream.pkg'
'MAContent10_AssetPack_0085_AlchemySoundscapesOrangeDirt.pkg'
'MAContent10_AssetPack_0086_AlchemySoundscapesEtherVent.pkg'
'MAContent10_AssetPack_0087_AlchemySoundscapesSunriseOverIceland.pkg'
'MAContent10_AssetPack_0088_AlchemySoundscapesMisc.pkg'
'MAContent10_AssetPack_0089_AlchemyBassCustomNSingle.pkg'
'MAContent10_AssetPack_0090_AlchemyBass80s.pkg'
'MAContent10_AssetPack_0091_AlchemyBassMini3VCOSaws.pkg'
'MAContent10_AssetPack_0092_AlchemyBassMini3VCOSquares.pkg'
'MAContent10_AssetPack_0093_AlchemyBassAnalogVCO1Squ.pkg'
'MAContent10_AssetPack_0094_AlchemyBassAnalogVCO1ResSaw.pkg'
'MAContent10_AssetPack_0095_AlchemyBassAnalogSquOscReset.pkg'
'MAContent10_AssetPack_0096_AlchemyBassAnalogRoundAttackBass.pkg'
'MAContent10_AssetPack_0097_AlchemyBassAnalogTechno.pkg'
'MAContent10_AssetPack_0098_AlchemyVocalsVocalPhrasesAmanda.pkg'
'MAContent10_AssetPack_0099_AlchemyBassAnalogAnalogRingMod.pkg'
'MAContent10_AssetPack_0100_AlchemyBassAnalogAnalogFizzBass.pkg'
'MAContent10_AssetPack_0101_AlchemyBassAnalogSquelchBass.pkg'
'MAContent10_AssetPack_0102_AlchemyBassAnalogRestrainedBass.pkg'
'MAContent10_AssetPack_0103_AlchemyBassAnalogLondonBuzz.pkg'
'MAContent10_AssetPack_0104_AlchemyBassAnalogNasalBoostBass.pkg'
'MAContent10_AssetPack_0105_AlchemyBassAnalogAnalogMisc.pkg'
'MAContent10_AssetPack_0106_AlchemyBassMini.pkg'
'MAContent10_AssetPack_0107_AlchemyBassAnalogMisc.pkg'
'MAContent10_AssetPack_0108_AlchemyBassDigitalABass.pkg'
'MAContent10_AssetPack_0109_AlchemyBassDigitalCBass.pkg'
'MAContent10_AssetPack_0110_AlchemyBassDigitalFM.pkg'
'MAContent10_AssetPack_0111_AlchemyBassDigitalMBass.pkg'
'MAContent10_AssetPack_0112_AlchemyBassDigitalSBass.pkg'
'MAContent10_AssetPack_0113_AlchemyBassDigitalVBass.pkg'
'MAContent10_AssetPack_0114_AlchemyBassDigitalWBass.pkg'
'MAContent10_AssetPack_0115_AlchemyBassDigitalXBass.pkg'
'MAContent10_AssetPack_0116_AlchemyBassDigitalMisc.pkg'
'MAContent10_AssetPack_0117_AlchemyBassRealMM.pkg'
'MAContent10_AssetPack_0118_AlchemyBassUpright.pkg'
'MAContent10_AssetPack_0119_AlchemyBassJazz.pkg'
'MAContent10_AssetPack_0120_AlchemyBassRealEUpright.pkg'
'MAContent10_AssetPack_0121_AlchemyBassRealSemiAcoustic.pkg'
'MAContent10_AssetPack_0122_AlchemyBassRealTrad.pkg'
'MAContent10_AssetPack_0123_AlchemyBassRealEBass.pkg'
'MAContent10_AssetPack_0124_AlchemyBassRealEletric.pkg'
'MAContent10_AssetPack_0125_AlchemyBassRealPM.pkg'
'MAContent10_AssetPack_0126_AlchemyBassRealMisc.pkg'
'MAContent10_AssetPack_0127_AlchemyGuitarsSingle.pkg'
'MAContent10_AssetPack_0128_AlchemyGuitarsAcousticYAcoustic.pkg'
'MAContent10_AssetPack_0129_AlchemyGuitarsAcousticAcoustic.pkg'
'MAContent10_AssetPack_0130_AlchemyGuitarsAcousticTrad.pkg'
'MAContent10_AssetPack_0131_AlchemyGuitarsAcousticMisc.pkg'
'MAContent10_AssetPack_0132_AlchemyGuitarsPluckedBandura.pkg'
'MAContent10_AssetPack_0133_AlchemyGuitarsPluckedEdo.pkg'
'MAContent10_AssetPack_0134_AlchemyGuitarsPluckedManyStrings.pkg'
'MAContent10_AssetPack_0135_AlchemyGuitarsPluckedMasterpiecePluck.pkg'
'MAContent10_AssetPack_0136_AlchemyGuitarsPluckedPadAsiaSpring.pkg'
'MAContent10_AssetPack_0137_AlchemyGuitarsPluckedGlass.pkg'
'MAContent10_AssetPack_0138_AlchemyGuitarsPluckedForgottenHarp.pkg'
'MAContent10_AssetPack_0139_AlchemyGuitarsPluckedEthnicWonder.pkg'
'MAContent10_AssetPack_0140_AlchemyGuitarsPluckedStringBell.pkg'
'MAContent10_AssetPack_0141_AlchemyGuitarsPluckedDulimar.pkg'
'MAContent10_AssetPack_0142_AlchemyGuitarsPluckedNagoyaHarp.pkg'
'MAContent10_AssetPack_0143_AlchemyGuitarsPluckedPM.pkg'
'MAContent10_AssetPack_0144_AlchemyGuitarsPluckedSitar.pkg'
'MAContent10_AssetPack_0145_AlchemyGuitarsPluckedHarp.pkg'
'MAContent10_AssetPack_0146_AlchemyGuitarsPluckedFM.pkg'
'MAContent10_AssetPack_0147_AlchemyGuitarsPluckedMisc.pkg'
'MAContent10_AssetPack_0148_AlchemyGuitarsElectricBari.pkg'
'MAContent10_AssetPack_0149_AlchemyGuitarsElectricPM80s.pkg'
'MAContent10_AssetPack_0151_AlchemyGuitarsElectricPositional.pkg'
'MAContent10_AssetPack_0152_AlchemyGuitarsElectric12StringPluck.pkg'
'MAContent10_AssetPack_0153_AlchemyGuitarsElectricPlectR.pkg'
'MAContent10_AssetPack_0154_AlchemyGuitarsElectricDistorto.pkg'
'MAContent10_AssetPack_0155_AlchemyGuitarsElectricHighGranularHarmonic.pkg'
'MAContent10_AssetPack_0157_AlchemyGuitarsElectricVibratoHard.pkg'
'MAContent10_AssetPack_0158_AlchemyGuitarsElectricFatFingersRR.pkg'
'MAContent10_AssetPack_0159_AlchemyGuitarsElectricMagnetBow.pkg'
'MAContent10_AssetPack_0161_AlchemyGuitarsElectricPadScratching.pkg'
'MAContent10_AssetPack_0162_AlchemyGuitarsElectricPadShamanStrings.pkg'
'MAContent10_AssetPack_0163_AlchemyGuitarsElectricFatPlectRR.pkg'
'MAContent10_AssetPack_0164_AlchemyGuitarsElectricHighAdditiveHarmonic.pkg'
'MAContent10_AssetPack_0165_AlchemyGuitarsElectricLowAdditiveHarmonic.pkg'
'MAContent10_AssetPack_0166_AlchemyGuitarsElectricFormerBellGuita.pkg'
'MAContent10_AssetPack_0167_AlchemyGuitarsElectricFatGlissRR.pkg'
'MAContent10_AssetPack_0168_AlchemyGuitarsElectricCleanChorus.pkg'
'MAContent10_AssetPack_0169_AlchemyGuitarsElectricBigBuzz.pkg'
'MAContent10_AssetPack_0170_AlchemyGuitarsElectricTrad.pkg'
'MAContent10_AssetPack_0171_AlchemyGuitarsElectricGliss.pkg'
'MAContent10_AssetPack_0172_AlchemyGuitarsElectricToneBend.pkg'
'MAContent10_AssetPack_0173_AlchemyGuitarsElectricAmpedLead.pkg'
'MAContent10_AssetPack_0174_AlchemyGuitarsElectricChorusf.pkg'
'MAContent10_AssetPack_0175_AlchemyGuitarsElectricBowed.pkg'
'MAContent10_AssetPack_0176_AlchemyGuitarsElectricKey.pkg'
'MAContent10_AssetPack_0177_AlchemyGuitarsElectricModern.pkg'
'MAContent10_AssetPack_0178_AlchemyGuitarsElectricPhase.pkg'
'MAContent10_AssetPack_0180_AlchemyGuitarsElectricStereoSteel.pkg'
'MAContent10_AssetPack_0182_AlchemyGuitarsElectricBadMood.pkg'
'MAContent10_AssetPack_0183_AlchemyGuitarsElectricCleanPhased.pkg'
'MAContent10_AssetPack_0184_AlchemyGuitarsElectricDeepFlatTrap.pkg'
'MAContent10_AssetPack_0186_AlchemyGuitarsElectricSmooth.pkg'
'MAContent10_AssetPack_0187_AlchemyGuitarsElectricSoftCrunchy.pkg'
'MAContent10_AssetPack_0188_AlchemyGuitarsElectricTremolo.pkg'
'MAContent10_AssetPack_0189_AlchemyGuitarsElectricOverdrive.pkg'
'MAContent10_AssetPack_0191_AlchemyGuitarsElectricOrangeSkin.pkg'
'MAContent10_AssetPack_0192_AlchemyGuitarsElectricPadTripode.pkg'
'MAContent10_AssetPack_0193_AlchemyGuitarsElectricRainBowQueen.pkg'
'MAContent10_AssetPack_0194_AlchemyGuitarsElectricPadRoomPluck.pkg'
'MAContent10_AssetPack_0195_AlchemyGuitarsElectricPlucked.pkg'
'MAContent10_AssetPack_0196_AlchemyGuitarsElectricPadRoomHardHands.pkg'
'MAContent10_AssetPack_0197_AlchemyGuitarsElectricMisc.pkg'
'MAContent10_AssetPack_0198_AlchemySynthsSingleNCustom.pkg'
'MAContent10_AssetPack_0199_AlchemySynthsAnalog1974.pkg'
'MAContent10_AssetPack_0200_AlchemySynthsAnalogAnalog.pkg'
'MAContent10_AssetPack_0201_AlchemySynthsAnalog80s.pkg'
'MAContent10_AssetPack_0202_AlchemySynthsAnalogHiSaw.pkg'
'MAContent10_AssetPack_0203_AlchemySynthsAnalogPolyphonic.pkg'
'MAContent10_AssetPack_0204_AlchemySynthsAnalogRetroModular.pkg'
'MAContent10_AssetPack_0205_AlchemySynthsAnalogDream.pkg'
'MAContent10_AssetPack_0206_AlchemySynthsAnalogUnisonPulse.pkg'
'MAContent10_AssetPack_0207_AlchemySynthsAnalogFatNDirty.pkg'
'MAContent10_AssetPack_0208_AlchemySynthsAnalogPulse.pkg'
'MAContent10_AssetPack_0209_AlchemySynthsAnalogAdditiveSweeper.pkg'
'MAContent10_AssetPack_0210_AlchemySynthsAnalogAmberCheeseHorror.pkg'
'MAContent10_AssetPack_0211_AlchemySynthsAnalogBrightClav.pkg'
'MAContent10_AssetPack_0212_AlchemySynthsAnalogDancePhaser.pkg'
'MAContent10_AssetPack_0213_AlchemySynthsAnalogDetuned.pkg'
'MAContent10_AssetPack_0214_AlchemySynthsAnalogSweep.pkg'
'MAContent10_AssetPack_0215_AlchemySynthsAnalogDualTriangles.pkg'
'MAContent10_AssetPack_0216_AlchemySynthsAnalogElectricKeys.pkg'
'MAContent10_AssetPack_0217_AlchemySynthsAnalogFatStrings.pkg'
'MAContent10_AssetPack_0218_AlchemySynthsAnalogFilterDirtLead.pkg'
'MAContent10_AssetPack_0219_AlchemySynthsAnalogGlissTriangles.pkg'
'MAContent10_AssetPack_0220_AlchemySynthsAnalogHandmadeSynth.pkg'
'MAContent10_AssetPack_0221_AlchemySynthsAnalogHugeSquare.pkg'
'MAContent10_AssetPack_0222_AlchemySynthsAnalogMiniMAttack.pkg'
'MAContent10_AssetPack_0223_AlchemySynthsAnalogMocha.pkg'
'MAContent10_AssetPack_0224_AlchemySynthsAnalogPercentileChord.pkg'
'MAContent10_AssetPack_0225_AlchemySynthsAnalogPhaseSaw.pkg'
'MAContent10_AssetPack_0226_AlchemySynthsAnalogResonant.pkg'
'MAContent10_AssetPack_0227_AlchemySynthsAnalogStereoPWM.pkg'
'MAContent10_AssetPack_0228_AlchemySynthsAnalogSync.pkg'
'MAContent10_AssetPack_0229_AlchemySynthsAnalogTransmitted.pkg'
'MAContent10_AssetPack_0230_AlchemySynthsAnalogUnisonSaw.pkg'
'MAContent10_AssetPack_0231_AlchemySynthsAnalogWallPolly.pkg'
'MAContent10_AssetPack_0232_AlchemySynthsAnalogWaveshapedSines.pkg'
'MAContent10_AssetPack_0233_AlchemySynthsAnalogWavetableRM.pkg'
'MAContent10_AssetPack_0234_AlchemySynthsAnalogMisc.pkg'
'MAContent10_AssetPack_0235_AlchemySynthsDigitalSweep.pkg'
'MAContent10_AssetPack_0236_AlchemySynthsDigitalPad.pkg'
'MAContent10_AssetPack_0237_AlchemySynthsDigitalMetal.pkg'
'MAContent10_AssetPack_0238_AlchemySynthsDigitalPluck.pkg'
'MAContent10_AssetPack_0239_AlchemySynthsDigitalAnalogPolyLead.pkg'
'MAContent10_AssetPack_0240_AlchemySynthsDigitalBrokenDreams.pkg'
'MAContent10_AssetPack_0241_AlchemySynthsDigitalDarknessSight.pkg'
'MAContent10_AssetPack_0242_AlchemySynthsDigitalDirtySynthSwell.pkg'
'MAContent10_AssetPack_0243_AlchemySynthsDigitalDistortedSonarbM.pkg'
'MAContent10_AssetPack_0244_AlchemySynthsDigitalFormy.pkg'
'MAContent10_AssetPack_0245_AlchemySynthsDigitalFrogHop.pkg'
'MAContent10_AssetPack_0246_AlchemySynthsDigitalGrainSeed.pkg'
'MAContent10_AssetPack_0247_AlchemySynthsDigitalMajesticSaw.pkg'
'MAContent10_AssetPack_0248_AlchemySynthsDigitalMysticIndia.pkg'
'MAContent10_AssetPack_0249_AlchemySynthsDigitalNumber22.pkg'
'MAContent10_AssetPack_0250_AlchemySynthsDigitalPlanetaryChord.pkg'
'MAContent10_AssetPack_0251_AlchemySynthsDigitalRackChord.pkg'
'MAContent10_AssetPack_0252_AlchemySynthsDigitalResonantWaves.pkg'
'MAContent10_AssetPack_0253_AlchemySynthsDigitalRobotics.pkg'
'MAContent10_AssetPack_0254_AlchemySynthsDigitalSPersonality.pkg'
'MAContent10_AssetPack_0255_AlchemySynthsDigitalSculptStruck.pkg'
'MAContent10_AssetPack_0256_AlchemySynthsDigitalTablemorph.pkg'
'MAContent10_AssetPack_0257_AlchemySynthsDigitalMisc.pkg'
'MAContent10_AssetPack_0258_AlchemyVocalsSpeechNInstruments.pkg'
'MAContent10_AssetPack_0259_AlchemyVocalsChoirFemale.pkg'
'MAContent10_AssetPack_0260_AlchemyVocalsChoirMale.pkg'
'MAContent10_AssetPack_0261_AlchemyVocalsChoirWordsFXNCinematic.pkg'
'MAContent10_AssetPack_0262_AlchemyVovalsSynthVocalsChoir.pkg'
'MAContent10_AssetPack_0263_AlchemyVovalsSynthVocalsNatureChoir.pkg'
'MAContent10_AssetPack_0264_AlchemyVovalsSynthVocalsMellotronChoir.pkg'
'MAContent10_AssetPack_0265_AlchemyVovalsSynthVocalsHuman.pkg'
'MAContent10_AssetPack_0266_AlchemyVocalsFXNNoisesBeatBoxFX.pkg'
'MAContent10_AssetPack_0267_AlchemyVocalsFXNNoisesSingleSamples.pkg'
'MAContent10_AssetPack_0268_AlchemyVocalsFXNNoisesSonghellirSingingCave.pkg'
'MAContent10_AssetPack_0269_AlchemyVocalsFXNNoisesIcelandicFXKit.pkg'
'MAContent10_AssetPack_0270_AlchemyVocalsFXNNoisesEleanor.pkg'
'MAContent10_AssetPack_0271_AlchemyVocalsFXNNoisesGargleVox.pkg'
'MAContent10_AssetPack_0272_AlchemyVocalsFXNNoisesPercussionKit.pkg'
'MAContent10_AssetPack_0273_AlchemyVocalsFXNNoisesMisc.pkg'
'MAContent10_AssetPack_0274_AlchemyVocalsVocalPhrasesCherry.pkg'
'MAContent10_AssetPack_0275_AlchemyVocalsVocalPhrasesEleanor.pkg'
'MAContent10_AssetPack_0276_AlchemyVocalsVocalPhrasesIcelandicChoir.pkg'
'MAContent10_AssetPack_0277_AlchemyVocalsSoloVocalsStaccato.pkg'
'MAContent10_AssetPack_0278_AlchemyVocalsSoloVocalsMorphsAmanda.pkg'
'MAContent10_AssetPack_0279_AlchemyVocalsSoloVocalsMorphsAnastacia.pkg'
'MAContent10_AssetPack_0280_AlchemyVocalsSoloVocalsMorphsCherry.pkg'
'MAContent10_AssetPack_0281_AlchemyVocalsSoloVocalsMorphsEleanor.pkg'
'MAContent10_AssetPack_0282_AlchemyVocalsSoloVocalsSustainEleanor.pkg'
'MAContent10_AssetPack_0283_AlchemyVocalsSoloVocalsSustainAnastacia.pkg'
'MAContent10_AssetPack_0284_AlchemyVocalsSoloVocalsSustainAmanda.pkg'
'MAContent10_AssetPack_0285_AlchemyVocalsSoloVocalsSustainCherry.pkg'
'MAContent10_AssetPack_0286_AlchemyVocalsSoloVocalsSustainMisc.pkg'
'MAContent10_AssetPack_0287_AlchemySoundEffectsTransitionsNCustom.pkg'
'MAContent10_AssetPack_0288_AlchemySoundEffectsImpacts.pkg'
'MAContent10_AssetPack_0289_AlchemySoundEffectsNatural.pkg'
'MAContent10_AssetPack_0290_AlchemySoundEffectsToyPercussion.pkg'
'MAContent10_AssetPack_0291_AlchemySoundEffectsFoley.pkg'
'MAContent10_AssetPack_0292_AlchemySoundEffectsInstruments.pkg'
'MAContent10_AssetPack_0293_AlchemySoundEffectsTechnology.pkg'
'MAContent10_AssetPack_0294_AlchemySoundEffectsAmbienceCity.pkg'
'MAContent10_AssetPack_0295_AlchemySoundEffectsAmbienceNature.pkg'
'MAContent10_AssetPack_0296_AlchemySoundEffectsSynths.pkg'
'MAContent10_AssetPack_0297_AlchemyDrumsElectronicAI.pkg'
'MAContent10_AssetPack_0298_AlchemyBassThroaty.pkg'
'MAContent10_AssetPack_0299_AlchemyMalletsMetal.pkg'
'MAContent10_AssetPack_0300_AlchemyVovalsSynthVocalsVocoder.pkg'
'MAContent10_AssetPack_0301_AlchemyDrumsElectronicAlchemy.pkg'
'MAContent10_AssetPack_0305_AlchemyVocalsVocalPhrasesAnastacia.pkg'
'MAContent10_AssetPack_0307_AlchemyBasicAdd.pkg')

# Loop through each one and download it to the downloads folder, then optionally, (uncomment) install it
writelog "START: Downloading 2015 content..."
for ((i = 0; i < "${#content2015[@]}"; i++))
do
	writelog "Downloading ${content2015[$i]}..."
	curl -o "$downloadFolder"/"${content2015[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2015/"${content2015[$i]}"
	writelog "${content2015[$i]} Download: Successful." "${content2015[$i]} Download: Failed."
	installer -pkg "$downloadFolder"/"${content2015[$i]}" -target /
	if [ $? = 0 ]; then
		/bin/echo "$(date) ${content2015[$i]} Install: Successful." >> "$log"
		/bin/rm -rf "$downloadFolder"/"${content2015[$i]}"
		writelog "${content2015[$i]} Deletion: Successful." "${content2015[$i]} Deletion: Failed."
	else
		/bin/echo "$(date) ${content2015[$i]} Install: Failed." >> "$log"
		/bin/echo "$(date) ${content2015[$i]} available for examination in ${downloadFolder}." >> "$log"
	fi
done

# https://www.afp548.com/2012/08/07/garageband-deployment-quick-tip/
content2013=('MAContent10_GarageBandPremiumContent.pkg'
'MAContent10_GB_StereoDrumKitsAlternative.pkg'
'MAContent10_GB_StereoDrumKitsRock.pkg'
'MAContent10_GB_StereoDrumKitsRnB.pkg'
'MAContent10_GB_StereoDrumKitsSongWriter.pkg')

writelog "Beginning to download 2013 content..."
for ((i = 0; i < "${#content2013[@]}"; i++))
do
	writelog "Downloading ${content2013[$i]}..."
	curl -o "$downloadFolder"/"${content2013[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2013/"${content2013[$i]}"
	writelog "${content2013[$i]} Download: Successful." "${content2013[$i]} Download: Failed."
	installer -pkg "$downloadFolder"/"${content2013[$i]}" -target /
	if [ $? = 0 ]; then
		/bin/echo "$(date) ${content2013[$i]} Install: Successful." >> "$log"
		/bin/rm -rf "$downloadFolder"/"${content2013[$i]}"
		writelog "${content2013[$i]} Deletion: Successful." "${content2013[$i]} Deletion: Failed."
	else
		/bin/echo "$(date) ${content2013[$i]} Install: Failed." >> "$log"
		/bin/echo "$(date) ${content2013[$i]} available for examination in ${downloadFolder}." >> "$log"
	fi
done

content2016=('MAContent10_AssetPack_0048_AlchemyPadsDigitalHolyGhost.pkg'
'MAContent10_AssetPack_0315_AppleLoopsElectroHouse1.pkg'
'MAContent10_AssetPack_0318_AppleLoopsTechHouse.pkg'
'MAContent10_AssetPack_0319_AppleLoopsDeepHouse.pkg'
'MAContent10_AssetPack_0324_AppleLoopsBluesGarage.pkg'
'MAContent10_AssetPack_0325_AppleLoopsGarageBand1.pkg'
'MAContent10_AssetPack_0326_AppleLoopsJamPack1.pkg'
'MAContent10_AssetPack_0327_AppleLoopsJamPackRemixTools.pkg'
'MAContent10_AssetPack_0328_AppleLoopsJamRhythmSection.pkg'
'MAContent10_AssetPack_0329_AppleLoopsJamPackOrchestra.pkg'
'MAContent10_AssetPack_0330_AppleLoopsJamPackWorld.pkg'
'MAContent10_AssetPack_0354_EXS_PianoSteinway.pkg'
'MAContent10_AssetPack_0355_EXS_PianoGrand.pkg'
'MAContent10_AssetPack_0360_EXS_BassElectricLiverpool.pkg'
'MAContent10_AssetPack_0361_EXS_BassElectricMuted.pkg'
'MAContent10_AssetPack_0362_EXS_BassElectricPicked.pkg'
'MAContent10_AssetPack_0364_EXS_BassElectricStinger.pkg'
'MAContent10_AssetPack_0370_EXS_MalletsVibraphone.pkg'
'MAContent10_AssetPack_0371_EXS_GuitarsAcoustic.pkg'
'MAContent10_AssetPack_0373_EXS_GuitarsAcousticClassical.pkg'
'MAContent10_AssetPack_0375_EXS_GuitarsVintageStrat.pkg'
'MAContent10_AssetPack_0376_EXS_GuitarsWarmElectric.pkg'
'MAContent10_AssetPack_0443_EXS_WorldAfricanMarimba.pkg'
'MAContent10_AssetPack_0483_EXS_OrchWoodwindBasson.pkg'
'MAContent10_AssetPack_0484_EXS_OrchWoodwindClarinetSolo.pkg'
'MAContent10_AssetPack_0487_EXS_OrchWoodwindFluteSolo.pkg'
'MAContent10_AssetPack_0489_EXS_OrchWoodwindOboeSolo.pkg'
'MAContent10_AssetPack_0491_EXS_OrchBrass.pkg'
'MAContent10_AssetPack_0492_EXS_OrchKit.pkg'
'MAContent10_AssetPack_0494_EXS_OrchPercGlockenspiel.pkg'
'MAContent10_AssetPack_0500_EXS_OrchHarp.pkg'
'MAContent10_AssetPack_0501_EXS_OrchOrgan.pkg'
'MAContent10_AssetPack_0503_EXS_ChoirChamberClassical.pkg'
'MAContent10_AssetPack_0510_EXS_Strings.pkg'
'MAContent10_AssetPack_0536_DrummerClapsCowbell.pkg'
'MAContent10_AssetPack_0537_DrummerShaker.pkg'
'MAContent10_AssetPack_0538_DrummerSticks.pkg'
'MAContent10_AssetPack_0539_DrummerTambourine.pkg'
'MAContent10_AssetPack_0544_EXS_GuitarsGB.pkg'
'MAContent10_AssetPack_0545_EXS_DrumsGB.pkg'
'MAContent10_AssetPack_0547_EXS_StringsGB.pkg'
'MAContent10_AssetPack_0548_EXS_iOSInstruments.pkg'
'MAContent10_AssetPack_0549_AppleLoopsHipHop2.pkg'
'MAContent10_AssetPack_0550_AppleLoopsElectroHouse2.pkg'
'MAContent10_AssetPack_0551_AppleLoopsDubstep2.pkg'
'MAContent10_AssetPack_0552_AppleLoopsModernRnB2.pkg'
'MAContent10_AssetPack_0553_AppleLoopsChillwave2.pkg'
'MAContent10_AssetPack_0554_AppleLoopsDiscoFunk2.pkg'
'MAContent10_AssetPack_0555_AppleLoopsGarageBand2.pkg'
'MAContent10_AssetPack_0561_DrummerBluebirdGBLogic.pkg'
'MAContent10_AssetPack_0563_DrummerBrooklynGBLogic.pkg'
'MAContent10_AssetPack_0565_DrummerDetroitGarageGBLogic.pkg'
'MAContent10_AssetPack_0567_DrummerEastBayGBLogic.pkg'
'MAContent10_AssetPack_0569_DrummerFourOnTheFloorGBLogic.pkg'
'MAContent10_AssetPack_0571_DrummerHeavyGBLogic.pkg'
'MAContent10_AssetPack_0573_DrummerLiverpoolGBLogic.pkg'
'MAContent10_AssetPack_0575_DrummerManchesterGBLogic.pkg'
'MAContent10_AssetPack_0577_DrummerMotownRevisitedGBLogic.pkg'
'MAContent10_AssetPack_0579_DrummerNeoSoulGBLogic.pkg'
'MAContent10_AssetPack_0581_DrummerPortlandGBLogic.pkg'
'MAContent10_AssetPack_0583_DrummerRetroRockGBLogic.pkg'
'MAContent10_AssetPack_0585_DrummerRootsGBLogic.pkg'
'MAContent10_AssetPack_0587_DrummerScientificMethodGBLogic.pkg'
'MAContent10_AssetPack_0589_DrummerSlowJamGBLogic.pkg'
'MAContent10_AssetPack_0591_DrummerSmashGBLogic.pkg'
'MAContent10_AssetPack_0593_DrummerSoCalGBLogic.pkg'
'MAContent10_AssetPack_0595_DrummerSunsetGBLogic.pkg'
'MAContent10_AssetPack_0599_GBLogicAlchemyEssentials.pkg')

writelog "Beginning to download 2016 content..."
for ((i = 0; i < "${#content2016[@]}"; i++))
do
	writelog "Downloading ${content2016[$i]}..."
	curl -o "$downloadFolder"/"${content2016[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2016/"${content2016[$i]}"
	writelog "${content2016[$i]} Download: Successful." "${content2016[$i]} Download: Failed."
	installer -pkg "$downloadFolder"/"${content2016[$i]}" -target /
	if [ $? = 0 ]; then
		/bin/echo "$(date) ${content2016[$i]} Install: Successful." >> "$log"
		/bin/rm -rf "$downloadFolder"/"${content2016[$i]}"
		writelog "${content2016[$i]} Deletion: Successful." "${content2016[$i]} Deletion: Failed."
	else
		/bin/echo "$(date) ${content2016[$i]} Install: Failed." >> "$log"
		/bin/echo "$(date) ${content2016[$i]} available for examination in ${downloadFolder}." >> "$log"
	fi
done

# Content from 10.1.2 (Chinese insruments)
content2016garageband1012=('MAContent10_AssetPack_0601_AppleLoopsChineseTraditional.pkg'
'MAContent10_AssetPack_0602_EXS_WorldChineseKit.pkg'
'MAContent10_AssetPack_0603_EXS_WorldErhu.pkg'
'MAContent10_AssetPack_0604_EXS_WorldPipa.pkg'
'MAContent10_AssetPack_0605_EXS_ClassicalGrand.pkg')

writelog "Beginning to download Chinese instruments..."
for ((i = 0; i < "${#content2016garageband1012[@]}"; i++))
do
	writelog "Downloading ${content2016garageband1012[$i]}..."
	curl -o "$downloadFolder"/"${content2016garageband1012[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2016/"${content2016garageband1012[$i]}"
	writelog "${content2016garageband1012[$i]} Download: Successful." "${content2016garageband1012[$i]} Download: Failed."
	installer -pkg "$downloadFolder"/"${content2016garageband1012[$i]}" -target /
	if [ $? = 0 ]; then
		/bin/echo "$(date) ${content2016garageband1012[$i]} Install: Successful." >> "$log"
		/bin/rm -rf "$downloadFolder"/"${content2016garageband1012[$i]}"
		writelog "${content2016garageband1012[$i]} Deletion: Successful." "${content2016garageband1012[$i]} Deletion: Failed."
	else
		/bin/echo "$(date) ${content2016garageband1012[$i]} Install: Failed." >> "$log"
		/bin/echo "$(date) ${content2016garageband1012[$i]} available for examination in ${downloadFolder}." >> "$log"
	fi
done

# https://jamfnation.jamfsoftware.com/discussion.html?id=6464#responseChild40895
legacyContent=('http://downloads.apple.com/static/gb/gb11bc/GarageBandBasicContent.pkg'
'http://swcdn.apple.com/content/downloads/43/39/061-5890/y2FxthySsyd2PSt3zfZ4mz3XkbqdGZPDZc/GarageBandExtraContent.tar'
'http://audiocontentdownload.apple.com/lp9_ms2_content_2011/MGBContentCompatibility.pkg')

writelog "Beginning to download legacy content..."
for ((i = 0; i < "${#legacyContent[@]}"; i++))
do
	filename=$(echo "${legacyContent[$i]}" | awk -F'/' '{print $NF}')
	if [[ "$filename" = "GarageBandExtraContent.tar" ]];then
		writelog "Downloading $filename..."
		curl -o "$downloadFolder"/"$filename" "${legacyContent[$i]}"
		writelog "${filename} Download: Successful." "${filename} Download: Failed."
		# Unarchive to get the .pkg
		tar -xf "$downloadFolder"/"$filename" -C "$downloadFolder"
		writelog "${filename} Unarchive: Successful." "${filename} Unarchive: Failed."
		filenamePkg=$(echo "$filename" | cut -d'.' -f-1)
		tar -xf "$downloadFolder"/"$filenamePkg".pkg.tar -C "$downloadFolder"
		writelog "${filenamePkg}.pkg.tar Unarchive: Successful." "${filenamePkg}.pkg.tar Unarchive: Failed."
		/bin/rm -rf "$downloadFolder"/"$filenamePkg".pkg.tar
		writelog "${filename}.pkg.tar Deletion: Successful." "${filenamePkg}.pkg.tar Deletion: Failed."
		/bin/rm -rf "$downloadFolder"/"$filename"
		writelog "${filename} Deletion: Successful." "${filename} Deletion: Failed."
		/bin/rm -rf "$downloadFolder"/signature
		writelog "${downloadFolder}/signature Deletion: Successful." "${downloadFolder}/signature Deletion: Failed."
		installer -pkg "$downloadFolder"/"$filenamePkg".pkg -target /
		if [ $? = 0 ]; then
			/bin/echo "$(date) ${filenamePkg}.pkg Install: Successful." >> "$log"
			/bin/rm -rf "$downloadFolder"/"${filenamePkg}.pkg"
			writelog "${filenamePkg}.pkg Deletion: Successful." "${filenamePkg}.pkg Deletion: Failed."
		else
			/bin/echo "$(date) ${filenamePkg}.pkg Install: Failed." >> "$log"
			/bin/echo "$(date) ${filenamePkg}.pkg available for examination in ${downloadFolder}." >> "$log"
		fi
	else
		/bin/echo "Downloading $filename ..." >> "$log"
		curl -o "$downloadFolder"/"$filename" "${legacyContent[$i]}"
		writelog "${filename} Download: Successful." "${filename} Download: Failed."
		installer -pkg "$downloadFolder"/"$filename" -target /
		if [ $? = 0 ]; then
			/bin/echo "$(date) ${filename} Install: Successful." >> "$log"
			/bin/rm -rf "$downloadFolder"/"${filename}"
			writelog "${filename} Deletion: Successful." "${filename} Deletion: Failed."
		else
			/bin/echo "$(date) ${filename} Install: Failed." >> "$log"
			/bin/echo "$(date) ${filename} available for examination in ${downloadFolder}." >> "$log"
		fi
	fi
done

# Commented out Garageband lesson PKGs

# https://groups.google.com/d/msg/macenterprise/GMGONqr17CM/wQZs6wLAa0AJ
#lessons=('2Z695-0098_Rock%20Guitar%201_Power%20Chord%20Punk.pkg'
#'2Z695-0099_Rock%20Guitar%202_Suspended%20Chords%20and%20Arpeggios.pkg'
#'2Z695-0100_Rock%20Guitar%203_Drop%20D%20and%20Heavy%20Riffs.pkg'
#'2Z695-0101_Rock%20Guitar%204_Melodies%20and%20Two%20Note%20Chords.pkg'
#'2Z695-0102_Rock%20Guitar%205_Classic%20Riffs.pkg'
#'2Z695-0050_Guitar%20Lesson%202_Chords%20-%20G,%20C.pkg'
#'2Z695-0051_Guitar%20Lesson%203_Chords%20-%20A,%20D.pkg'
#'2Z695-0052_Guitar%20Lesson%204_Minor%20Chords.pkg'
#'2Z695-0053_Guitar%20Lesson%205_Single%20Note%20Melodies.pkg'
#'2Z695-0054_Guitar%20Lesson%206_Power%20Chords.pkg'
#'2Z695-0055_Guitar%20Lesson%207_Major%20Barre%20Chords.pkg'
#'2Z695-0056_Guitar%20Lesson%208_Minor%20Barre%20Chords.pkg'
#'2Z695-0057_Guitar%20Lesson%209_Blues%20Lead.pkg'
#'2Z695-0091_Blues%20Guitar%201_12%20Bar%20Blues%20in%20A.pkg'
#'2Z695-0092_Blues%20Guitar%202_Minor%20Pentatonic%20Scale.pkg'
#'2Z695-0093_Blues%20Guitar%203_Blues%20Rhythm%20Riffs.pkg'
#'2Z695-0094_Blues%20Guitar%204_12%20Bar%20Blues%20in%20Other%20Keys.pkg'
#'2Z695-0095_Blues%20Guitar%205_Bends%20and%20Vibrato.pkg'
#'2Z695-0096_Blues%20Guitar%206_Hammers,%20Pulls,%20and%20Slides.pkg'
#'2Z695-0097_Blues%20Guitar%207_Blues%20Scale%20and%20Quarter%20Bends.pkg'
#'2Z695-0103_Pop%20Piano%201_Major%20and%20Minor%20Chords.pkg'
#'2Z695-0104_Pop%20Piano%202_Inversions%20and%20Broken%20Chords.pkg'
#'2Z695-0105_Pop%20Piano%203_Suspended%20Chords.pkg'
#'2Z695-0106_Pop%20Piano%204_7th%20Chords.pkg'
#'2Z695-0107_Pop%20Piano%205_Slash%20Chords.pkg'
#'2Z695-0108_Pop%20Piano%206_Melodic%20Embellishment.pkg'
#'2Z695-0109_Classical%20Piano%201_Mozart%20Minuet.pkg'
#'2Z695-0110_Classical%20Piano%202_Bach%20Musette.pkg'
#'2Z695-0111_Classical%20Piano%203_Beethoven%20Fuer%20Elise.pkg'
#'2Z695-0112_Classical%20Piano%204_Chopin%20Prelude.pkg'
#'2Z695-0042_Piano%20Lesson%202_Right%20Hand.pkg'
#'2Z695-0043_Piano%20Lesson%203_Left%20Hand.pkg'
#'2Z695-0044_Piano%20Lesson%204_Rhythm.pkg'
#'2Z695-0045_Piano%20Lesson%205_Sharps%20and%20Flats.pkg'
#'2Z695-0046_Piano%20Lesson%206_Rhythmic%20Accents.pkg'
#'2Z695-0047_Piano%20Lesson%207_Major%20and%20Minor%20Chords.pkg'
#'2Z695-0048_Piano%20Lesson%208_Scales.pkg'
#'2Z695-0049_Piano%20Lesson%209_Playing%20the%20Blues.pkg')

#writelog "Beginning to download lessons..."
#for ((i = 0; i < "${#lessons[@]}"; i++))
#do
#	filename=$(echo "${lessons[$i]}" | cut -d'_' -f2- | tr -d '%20')
#	echo "Downloading $filename..."
#	curl -o "$downloadFolder"/"$filename" http://downloads.apple.com/pub/lessons/basic/"${lessons[$i]}"
#	#installer -pkg "$downloadFolder"/"$filename" -target /
#done

# http://thestuff.info/garageband-and-logic-pro-x-additional-content/
# https://brianli.com/download-logic-pro-x-additional-content-files/
# http://audiocontentdownload.apple.com/lp10_ms3_content_2015/logicpro1010.plist
#logicContent=('MAContent10_AppleLoopsChillwave.pkg'
#'MAContent10_AppleLoopsDeepHouse.pkg'
#'MAContent10_AppleLoopsDubstep.pkg'
#'MAContent10_AppleLoopsElectroHouse.pkg'
#'MAContent10_AppleLoopsHipHop.pkg'
#'MAContent10_AppleLoopsModernRnB.pkg'
#'MAContent10_AppleLoopsTechHouse.pkg'
#'ProAudioCoreContent10.pkg'
#'MAContent10_ElectronicDrumKits.pkg'
#'MAContent10_GarageBandPremiumContent.pkg'
#'GarageBandBasicContent.pkg'
#'MAContent10_GarageBand6Legacy.pkg'
#'MAContent10_IRsStereo.pkg'
#'MAContent10_IRsSurround.pkg'
#'MAContent10_InstrumentsBass.pkg'
#'MAContent10_InstrumentsGuitar.pkg'
#'MAContent10_InstrumentsMallet.pkg'
#'MAContent10_InstrumentsOrchestralBrass.pkg'
#'MAContent10_InstrumentsOrchestralChoir.pkg'
#'MAContent10_InstrumentsOrchestralHarp.pkg'
#'MAContent10_InstrumentsOrchestralKeyboard.pkg'
#'MAContent10_InstrumentsOrchestralPercussion.pkg'
#'MAContent10_InstrumentsOrchestralPipeOrgan.pkg'
#'MAContent10_InstrumentsOrchestralStrings.pkg'
#'MAContent10_InstrumentsOrchestralWoodwinds.pkg'
#'MAContent10_InstrumentsPiano.pkg'
#'MAContent10_InstrumentsWorldKeyboards.pkg'
#'MAContent10_InstrumentsWorldPercussion.pkg'
#'MAContent10_InstrumentsWorldStringed.pkg'
#'MAContent10_InstrumentsWorldVoice.pkg'
#'MAContent10_InstrumentsWorldWoodwind.pkg'
#'MAContent10_AppleLoopsLegacy1.pkg'
#'JamPack1.pkg'
#'MAContent10_AppleLoopsLegacyRemix.pkg'
#'RemixTools_Instruments.pkg'
#'MAContent10_AppleLoopsLegacyRhythm.pkg'
#'RhythmSection_Instruments.pkg'
#'MAContent10_AppleLoopsLegacySymphony.pkg'
#'JamPack4_Instruments.pkg'
#'MAContent10_AppleLoopsLegacyVoices.pkg'
#'Voices_Instruments.pkg'
#'MAContent10_AppleLoopsLegacyWorld.pkg'
#'WorldMusic_Instruments.pkg'
#'MAContent10_Logic9Legacy.pkg'
#'MGBContentCompatibility.pkg'
#'MAContent10_ProducerBirchKit.pkg'
#'MAContent10_ProducerClassicSixtiesKit.pkg'
#'MAContent10_ProducerModernMapleKit.pkg'
#'MAContent10_ProducerPatches.pkg'
#'MAContent10_ProducerPawnShopKit.pkg'
#'MAContent10_ProducerSeventiesPlexiKit.pkg'
#'MAContent10_ProducerStadiumKit.pkg'
#'MAContent10_ProducerStudioKit.pkg'
#'MAContent10_ProducerTightMapleKit.pkg'
#'MAContent10_StereoDrumKitsAlternative.pkg'
#'MAContent10_StereoDrumKitsRnB.pkg'
#'MAContent10_StereoDrumKitsRockB.pkg'
#'MAContent10_StereoDrumKitsRock.pkg'
#'MAContent10_StereoDrumKitsSongwriter.pkg')

#echo "** Downloading Logic content..."
#for ((i = 0; i < "${#logicContent[@]}"; i++))
#do
#	echo "Downloading ${logicContent[$i]}..."
#	curl -o "$downloadFolder"/"${logicContent[$i]}" http://audiocontentdownload.apple.com/lp10_ms3_content_2013/"${logicContent[$i]}"
#	#installer -pkg "$downloadFolder"/"${logicContent[$i]}" -target /
#done

writelog "Completed download & install of all Garageband Loops."

writelog "----------- Garageband Loops Download & Install Script Finished -----------"

exit
