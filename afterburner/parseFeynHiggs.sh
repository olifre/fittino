#!/bin/bash

massh=`grep '# Mh0' ./SPheno.spc.fh | awk '{print $2}'`
massH=`grep '# MHH' ./SPheno.spc.fh | awk '{print $2}'`
massA=`grep '# MA0' ./SPheno.spc.fh | grep -v 'MA02' | awk '{print $2}'`
massHp=`grep '# MHp' ./SPheno.spc.fh | awk '{print $2}'`
gm2mu=`grep '# gminus2mu' ./SPheno.spc.fh | awk '{print $2}'`
mwmssm=`grep '# MWMSSM' ./SPheno.spc.fh | awk '{print $2}'`
mwsm=`grep '# MWSM' ./SPheno.spc.fh | awk '{print $2}'`
bsgmssm=`grep '# bsgammaMSSM' ./SPheno.spc.fh | awk '{print $2}'`
bsgsm=`grep '# bsgammaSM' ./SPheno.spc.fh | awk '{print $2}'`

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