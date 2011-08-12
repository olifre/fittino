#!/bin/bash
echo "parsing ./susyhit_slha.out.stdslha.fh-001"
ls -l ./susyhit_slha.out.stdslha.fh-001
massh=`grep '# Mh0' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
massH=`grep '# MHH' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
massA=`grep '# MA0' ./susyhit_slha.out.stdslha.fh-001 | grep -v 'MA02' | awk '{print $2}'`
massHp=`grep '# MHp' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
gm2mu=`grep '# gminus2mu' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
mwmssm=`grep '# MWMSSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
mwsm=`grep '# MWSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
bsgmssm=`grep '# bsgammaMSSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
bsgsm=`grep '# bsgammaSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
SW2effMSSM=`grep '# SW2effMSSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
SW2effSM=`grep '# SW2effSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
DeltaMsMSSM=`grep '# DeltaMsMSSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`
DeltaMsSM=`grep '# DeltaMsSM' ./susyhit_slha.out.stdslha.fh-001 | awk '{print $2}'`

echo "Block FeynHiggs # FeynHiggs observables" >> susyhit_slha.out
echo "    1    $massh # massh" >> susyhit_slha.out
echo "    2    $massH # massH" >> susyhit_slha.out
echo "    3    $massA # massA" >> susyhit_slha.out
echo "    4    $massHp # massHp" >> susyhit_slha.out
echo "    5    $gm2mu # gm2mu" >> susyhit_slha.out
echo "    6    $mwmssm # mwmssm" >> susyhit_slha.out
echo "    7    $mwsm # mwsm" >> susyhit_slha.out
echo "    8    $bsgmssm # bsgmssm" >> susyhit_slha.out
echo "    9    $bsgsm # bsgsm" >> susyhit_slha.out
echo "   10    $SW2effMSSM # SW2effMSSM" >> susyhit_slha.out
echo "   11    $SW2effSM # SW2effSM" >> susyhit_slha.out
echo "   12    $DeltaMsMSSM # DeltaMsMSSM" >> susyhit_slha.out
echo "   13    $DeltaMsSM # DeltaMsSM" >> susyhit_slha.out
