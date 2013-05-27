#!/usr/bin/env zsh

######################## FITTINO ##########################



export FITTINO=/afs/naf.desy.de/user/s/sarrazin/sarrazin/FittinoTrunk
export FITTINO_MAIL=bjorn.sarrazin@cern.ch
export FITTINO_PROJECT=atlas
export FITTINO_FH=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2/FH

export FITTINO_THEORY=/afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes

export FITTINO_INTERFACE=$FITTINO_THEORY/interface_files
# expected substructure $FITTINO_INTERFACE/FH_noHiggsRates/CMSSM/event.txt

export FITTINO_LOCKING=$FITTINO_THEORY/locking
# expected substructure $FITTINO_LOCKING/FH_noHiggsRates/CMSSM/

export FITTINO_SORT=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2/sort
export FITTINO_SETUP=$FITTINO/postProcessing2/setup.sh

######################## ROOT ##########################

ini root534

######################## gcc ##########################

source /afs/naf.desy.de/group/atlas/software/lcg/external/gcc/setup-4.3.2.sh

#####################################################################

export LD_LIBRARY_PATH=$FITTINO/tools/GetToyLHCChi2/ProfileLikelihood:$LD_LIBRARY_PATH

####################################################################

# not used by for SPhenp+FH
export FITTINO_SCRATCH=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2
export FITTINO_MPR=$FITTINO_SCRATCH/mpr
export FITTINO_HS=$FITTINO_SCRATCH/HS

