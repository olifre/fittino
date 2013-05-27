#!/usr/bin/env zsh

######################## FITTINO ##########################



export FITTINO=/afs/naf.desy.de/user/s/sarrazin/sarrazin/FittinoTrunk
export FITTINO=/afs/naf.desy.de/user/s/sarrazin/sarrazin/FittinoTrunk

export FITTINO_MAIL=bjorn.sarrazin@cern.ch
export FITTINO_PROJECT=atlas
export FITTINO_FH=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2/FH

export FITTINO_INTERFACE=$FITTINO/postProcessing2/interface_files
export FITTINO_LOCKING=$FITTINO/postProcessing2/locking


######################## ROOT ##########################

ini root534

######################## gcc ##########################

source /afs/naf.desy.de/group/atlas/software/lcg/external/gcc/setup-4.3.2.sh

#####################################################################

export LD_LIBRARY_PATH=$FITTINO/tools/GetToyLHCChi2/ProfileLikelihood:$LD_LIBRARY_PATH


####################################################################

export FITTINO_SCRATCH=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2
export FITTINO_SORT=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing/2/sort
export FITTINO_SETUP=$FITTINO/postProcessing2/setup.sh
export FITTINO_MPR=$FITTINO_SCRATCH/mpr
export FITTINO_HS=$FITTINO_SCRATCH/HS

