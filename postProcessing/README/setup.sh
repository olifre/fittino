#!/bin/bash

################################
# Set general variables used by the scripts
################################

######## Position of the setup file
###############################
whereIsSetup=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/README


######## Email adress
###############################
mymail=prudent@physik.tu-dresden.de


######## Toys
###############################

# output of the toys
output_TOYS=/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/toys/

# Where all the batch-job scripts for the toys
job_directory_TOYS=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_toys/


######## Buggy point removal
###############################

# output of the buggy point removal
output_BPR=/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/final/

# Where the splines lie
cut_directory=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/edgeDetection/

# Where all the batch-job scripts for the buggy point removal
job_directory_BPR=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_buggyPointRemoval/


######## Chi2 calculation
###############################

# Output of the chi2 calculation
output_CHI2=/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/

# Where all the batch-job scripts for the chi2 calculation lie
job_directory_CHI2=/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/postProcessing_2012/jobs/

# Fittino input file with the description of all observables
input_obs=/afs/naf.desy.de/user/p/prudent/fittino/inputs/summer2012/postProcessing


######## Multiple point removal
###############################

# Output of the multiple point removal
output_MPR=/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_multiplePointsRemoval/doublePointsRemoved/

# Where all the batch-job scripts for the multiple point removal lie
job_directory_MPR=/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_multiplePointsRemoval/




######## Links to tools
###############################

# Where all the list of the fits to be processed lie
directory_listFits=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/README/listOfFits

# Where the processing programs lie
working_directory=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing

# Where to retrieve the LHC chi2 tools from
tools_directory=/afs/naf.desy.de/user/p/prudent/fittino/tools/GetToyLHCChi2/ProfileLikelihood/

