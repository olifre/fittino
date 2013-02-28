#!/usr/bin/env zsh
#$ -j y
##$ -l os=sld5
#$ -cwd
#$ -P atlas
#$ -l h_cpu=00:59:00 
#$ -l h_vmem=1G
#$-l site=hh 
#$ -w e
##$ -m ae -M $mymail


whereIsSetup=$1
obs=$2

date
echo " --- Script started"

source $whereIsSetup/setup.sh 

cd $output_CHI2/$obs

hadd CMSSM.root 3/*.root 4/*.root 5/*.root 6/*.root 7/*.CMSSM.*.root 8/*.CMSSM.*.root 9/*.CMSSM.*.root 10/*.CMSSM.*.root 11/*.CMSSM.*.root 

hadd NUHM1.root 7/*.NUHM1.*.root 8/*.NUHM1.*.root 9/*.NUHM1.*.root 10/*.NUHM1.*.root 11/*.NUHM1.*.root 12/*.NUHM1.*.root 13/*.NUHM1.*.root 

hadd NUHM2.root 7/*.NUHM2.*.root 8/*.NUHM2.*.root 9/*.NUHM2.*.root 10/*.NUHM2.*.root 11/*.NUHM2.*.root 12/*.NUHM2.*.root 13/*.NUHM2.*.root 

echo " --- Script finished"
date
