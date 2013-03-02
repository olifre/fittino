#!/bin/bash

################################
# Set general variables used by the scripts
################################

#Bjoern
export fittinoPath=/afs/naf.desy.de/user/s/sarrazin/sarrazin/FittinoTrunk
export scratchPath=/scratch/hh/dust/naf/atlas/user/sarrazin/postProcessing_2012
export scratchPathForSed="\/scratch\/hh\/dust\/naf\/atlas\/user\/sarrazin\/postProcessing_2012"
export whereIsSetupForSed="\/afs\/naf.desy.de\/user\/s\/sarrazin\/sarrazin\/FittinoTrunk\/postProcessing\/README"

#Philip


#Xavier


#Matthias

################### VERBOSITY ################################

export VERBOSE=0 

######################## ROOT ##########################
export ROOTSYS=/afs/naf.desy.de/products/root/amd64_rhel50/5.34.00
export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH

####################### gcc and working dir ################
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./:/afs/naf.desy.de/group/atlas/software/lcg/external/gcc/4.3.2/lib64

######## Position of the setup file ###############################
export whereIsSetup=$fittinoPath/postProcessing/README

######## Plots ###############################


export job_directory_PLOTS=$scratchPath/jobs/plots  #was plotDir
export job_directoryForSed_PLOTS="$scratchPathForSed\/jobs\/plots"

export job_directory_PLOTS1D=$scratchPath/jobs/plots1d

export output_PLOTS=$scratchPath/outputs/plots # was plotOutputDir
export output_PLOTS1D=$scratchPath/outputs/plots1d # was plotOutputDir

######## Toys ###############################

# output of the toys
export output_TOYS=$scratchPath/outputs/toys

# Where all the batch-job scripts for the toys
export job_directory_TOYS=$scratchPath/jobs/jobs_for_toys  

######## Splines creation ###############################

export job_directory_SPLINES=$scratchPath/jobs/jobs_for_splines

# Where the splines lie
export cut_directory=$scratchPath/outputs/splines # cut be called output_SPLINES

######## MERGING ###############################

export job_directory_MERGE=$scratchPath/jobs/jobs_for_merge



######## Buggy point removal ###############################

# output of the buggy point removal
export output_BPR=$scratchPath/outputs/final
export outputForSed_BPR="$scratchPathForSed\/outputs\/final"


# Where all the batch-job scripts for the buggy point removal
export job_directory_BPR=$scratchPath/jobs/jobs_for_buggyPointRemoval


######## Chi2 calculation ###############################

# Output of the chi2 calculation
export output_CHI2=$scratchPath/outputs/chi2  

# Where all the batch-job scripts for the chi2 calculation lie
export job_directory_CHI2=$scratchPath/jobs/jobs_for_chi2

# Fittino input file with the description of all observables
export input_obs=$fittinoPath/inputs/summer2012/postProcessing


######## Multiple point removal ###############################

# Output of the multiple point removal
export output_MPR=$scratchPath/jobs/jobs_for_multiplePointsRemoval/doublePointsRemoved  #FIXME - shouldn't this be in outputs ?

# Where all the batch-job scripts for the multiple point removal lie
export job_directory_MPR=$scratchPath/jobs/jobs_for_multiplePointsRemoval


######## Links to tools ###############################

# Where all the list of the fits to be processed lie
export directory_listFits=$fittinoPath/postProcessing/README/listOfFits

# Where the processing programs lie
export working_directory=$fittinoPath/postProcessing

# Where to retrieve the LHC chi2 tools from
export tools_directory=$fittinoPath/tools/GetToyLHCChi2/ProfileLikelihood

