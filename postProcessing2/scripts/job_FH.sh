#!/usr/bin/env zsh
#$ -j y
#$ -cwd
#$ -l h_cpu=12:00:00 
#$ -l h_vmem=1.5G
#$ -l site=hh 
#$ -w e

date
echo "Script started"

source $FITTINO_SETUP

model=$1
firstEvent=$2
numberOfEvents=$3

echo "model $model"
echo "numberOfEvents $numberOfEvents"

outputDir=$FITTINO_FH/outputs/$model

if [ ! -d "$outputDir" ]; then

    mkdir -p  $outputDir

fi

exePath=$FITTINO/postProcessing2/source/runFH
exeName=`basename $exePath`


cd $TMP

cp $exePath .
cp $FITTINO/postProcessing2/FHeffC-calculator/FHeffC2 .
cp /afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/SPheno-3.1.11/bin/SPheno .


./$exeName $model $firstEvent $numberOfEvents

cp *.root $outputDir

echo "Script finished"
date

