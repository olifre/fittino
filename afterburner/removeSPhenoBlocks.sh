#!/bin/bash

FILE=SPheno.spc.last

START=`cat -n $FILE | grep "Block HiggsBoundsInputHiggsCouplingsBosons" | awk '{ print $1}'`
NEXT=`cat -n $FILE | grep "Block SPhenoLowEnergy" | awk '{ print $1}'`
END=`expr $NEXT - 1`

sed "$START,$END d" $FILE

echo $START $END
