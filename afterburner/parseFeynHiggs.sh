#!/bin/bash
echo "parsing ./SPheno.spc.stdslha.fh-001"
ls -lrt SPheno.spc.*
ls -l ./SPheno.spc.stdslha.fh-001
# if [ -e ./SPheno.spc.stdslha.fh-001 ]
# then
#     echo file there!
# else
#     echo file not there!
#     cp SPheno.spc.stdslha SPheno.spc.stdslha.fh-001
# fi
massh=`grep '# Mh0' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
massH=`grep '# MHH' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
massA=`grep '# MA0' ./SPheno.spc.stdslha.fh-001 | grep -v 'MA02' | awk '{print $2}'`
massHp=`grep '# MHp' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
gm2mu=`grep '# gminus2mu' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
mwmssm=`grep '# MWMSSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
mwsm=`grep '# MWSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
bsgmssm=`grep '# bsgammaMSSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
bsgsm=`grep '# bsgammaSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
SW2effMSSM=`grep '# SW2effMSSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
SW2effSM=`grep '# SW2effSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
DeltaMsMSSM=`grep '# DeltaMsMSSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`
DeltaMsSM=`grep '# DeltaMsSM' ./SPheno.spc.stdslha.fh-001 | awk '{print $2}'`

echo "Block FeynHiggs # FeynHiggs observables" >> SPheno.spc
echo "    1    $massh # massh" >> SPheno.spc
echo "    2    $massH # massH" >> SPheno.spc
echo "    3    $massA # massA" >> SPheno.spc
echo "    4    $massHp # massHp" >> SPheno.spc
echo "    5    $gm2mu # gm2mu" >> SPheno.spc
echo "    6    $mwmssm # mwmssm" >> SPheno.spc
echo "    7    $mwsm # mwsm" >> SPheno.spc
echo "    8    $bsgmssm # bsgmssm" >> SPheno.spc
echo "    9    $bsgsm # bsgsm" >> SPheno.spc
echo "   10    $SW2effMSSM # SW2effMSSM" >> SPheno.spc
echo "   11    $SW2effSM # SW2effSM" >> SPheno.spc
echo "   12    $DeltaMsMSSM # DeltaMsMSSM" >> SPheno.spc
echo "   13    $DeltaMsSM # DeltaMsSM" >> SPheno.spc

mv ./SPheno.spc.stdslha.fh-001.last ./SPheno.spc.stdslha.fh-001.last2
mv ./SPheno.spc.stdslha.fh-001 ./SPheno.spc.stdslha.fh-001.last
