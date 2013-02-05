#!/bin/bash

#
# Set general variables used by the scripts
#


# Where the processing programs lie
working_directory=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing

# Where to retrieve the LHC chi2 tools from
tools_directory=/afs/naf.desy.de/user/p/prudent/fittino/tools/GetToyLHCChi2/ProfileLikelihood/

# Output of the multiple point removal
output_destination=/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_multiplePointsRemoval/doublePointsRemoved/

# Fittino input file with the description of all observables
input_file=/afs/naf.desy.de/user/p/prudent/fittino/inputs/summer2012/fittino.in.point1.CMSSM.allObs.summer2012

# Where all the batch-job scripts lie
job_directory=/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/postProcessing_2012/jobs/jobs_for_multiplePointsRemoval/

# Where all the list of the fits to be processed lie
directory_listFits=/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/README/listOfFits
