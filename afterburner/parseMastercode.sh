#!/bin/bash
echo "parsing ./SPheno.spc.stdslha.mastercode"
ls -l ./SPheno.spc.stdslha.mastercode

cat SPheno.spc.stdslha.mastercode | grep -A 29 'BLOCK PREDICT' >>SPheno.spc

mv SPheno.spc.stdslha.mastercode.last SPheno.spc.stdslha.mastercode.last2
mv SPheno.spc.stdslha.mastercode SPheno.spc.stdslha.mastercode.last
