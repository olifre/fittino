#!/bin/bash

bsg=`grep '# BR(b->s gamma)' ./output.flha | awk '{print $3}' | head -n 1`
Bsmumu=`grep '# BR(B_s->mu+ mu-)' ./output.flha | awk '{print $3}' | head -n 1`
Butaunu=`grep '# BR(B_u->tau nu)' ./output.flha | grep -v 'MA02' | awk '{print $3}' | head -n 1`
Dstaunu=`grep '# BR(D_s->tau nu)' ./output.flha | awk '{print $3}' | head -n 1`
Dsmunu=`grep '# BR(D_s->mu nu)' ./output.flha | awk '{print $3}' | head -n 1`
BpD0taunu=`grep '# BR(B+->D0 tau nu)' ./output.flha | awk '{print $3}' | head -n 1`
KmunuPimunu=`grep '# BR(K->mu nu)/BR(pi->mu nu)' ./output.flha | awk '{print $3}' | head -n 1`

echo "Block SuperIso # SuperIso observables" >> SPheno.spc
echo "    1    $bsg # BR(b->s gamma)" >> SPheno.spc
echo "    2    $Bsmumu # BR(B_s->mu+ mu-)" >> SPheno.spc
echo "    3    $Butaunu # BR(B_u->tau nu)" >> SPheno.spc
echo "    4    $Dstaunu # BR(D_s->tau nu)" >> SPheno.spc
echo "    5    $Dsmunu # BR(D_s->mu nu)" >> SPheno.spc
echo "    6    $BpD0taunu # BR(B+->D0 tau nu)" >> SPheno.spc
echo "    7    $KmunuPimunu # BR(K->mu nu)/BR(pi->mu nu)" >> SPheno.spc

mv output.flha.last output.flha.last2
mv output.flha output.flha.last
