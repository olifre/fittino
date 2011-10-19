#!/bin/bash
echo "parsing ./SPheno.spc.stdslha.mastercode"
ls -l ./SPheno.spc.stdslha.mastercode

cat SPheno.spc.stdslha.mastercode | grep -A 29 'BLOCK PREDICT' >>SPheno.spc
