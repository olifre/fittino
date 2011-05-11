#!/bin/bash

# This script removes non-standard SLHA blocks written by SPheno.
# This is needed to feed SPheno spectrum files into programs which
# do not ignore unknown blocks and thus do not work properly.

FILE=SPheno.spc.last
TMPFILESUFFIX=tmp

STARTINFO=`cat -n $FILE | grep "Block SPhenoINFO" | awk '{ print $1}'`
AFTERINFO=`cat -n $FILE | grep "Block MODSEL" | awk '{ print $1}'`
ENDINFO=`expr $AFTERINFO - 1`

sed "$STARTINFO,$ENDINFO d" $FILE > $FILE.${TMPFILESUFFIX}1

STARTHB=`cat -n $FILE.${TMPFILESUFFIX}1 | grep "Block HiggsBoundsInputHiggsCouplingsFermions" | awk '{ print $1}'`
AFTERHB=`cat -n $FILE.${TMPFILESUFFIX}1 | grep "Block SPhenoLowEnergy" | awk '{ print $1}'`
ENDHB=`expr $AFTERHB - 1`

sed "$STARTHB,$ENDHB d" $FILE.${TMPFILESUFFIX}1 > $FILE.${TMPFILESUFFIX}2

STARTLE=`cat -n $FILE.${TMPFILESUFFIX}2 | grep "Block SPhenoLowEnergy" | awk '{ print $1}'`
#AFTERLE=`cat -n $FILE.${TMPFILESUFFIX}2 | grep "BLOCK PREDICT" | awk '{ print $1}'`
#ENDLE=`expr $AFTERLE - 1`
ENDLE=`wc -l $FILE.${TMPFILESUFFIX}2 | awk '{ print $1 }'`

sed "$STARTLE,$ENDLE d" $FILE.${TMPFILESUFFIX}2 > $FILE.${TMPFILESUFFIX}3

rm -f $FILE.${TMPFILESUFFIX}1 $FILE.${TMPFILESUFFIX}2
mv $FILE.${TMPFILESUFFIX}3 $FILE.std