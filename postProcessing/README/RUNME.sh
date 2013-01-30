#!/bin/bash

GREEN="\\033[1;32m" 
NORMAL="\\033[0;39m" 
RED="\\033[1;31m" 
BLUE="\\033[1;34m" 


echo 
echo
echo Hello
echo What do you want to know about the post-processing ?
echo
echo "               [1]  The content and files of the post-processing"
echo
echo "               [2]  How to quickly run the post-processing"
echo
echo \(type a number...\)
read wish


# ===========================================================================
# Pay attention first to change in the job_step* scripts
# - all links
# - all file names
# - my email adress
# Change also the links in the compilation script ./compil

#Questions, requests, frustration ? Write me: prudent[at]physik.tu-dresden.de
# ===========================================================================

# =====================
# ==== CONTENT ========
# =====================

if [[ $wish == 1 ]]
then
echo 
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    The different files and directories in the post-processing package are:"
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo -e "$RED" [ dd_xenon100_2012.dat ] "$NORMAL"
echo "      XENON100 data (WIMP mass versus cross section) for AstroFit"
echo
echo -e "$RED" [ preparFittinoInput.sh ] "$NORMAL"
echo "      To extract the observables from the Fittino input file and display them in an easy-to-handle text file"
echo
echo -e "$RED" [ CMSSM_to_NUHM ] "$NORMAL"
echo "      To convert the CMSSM fits into NUHM1/2 fits by fixing M0H = M0 (for NUHM1) and M0Hu = M0Hd = M0 (for NUHM2)"
echo
echo -e "$RED" [ edgeDetection ] "$NORMAL"
echo "      Calculation of the splines for the removal of the buggy points (cf. step 3)"
echo
echo -e "$RED" [ cleaning.h ] "$NORMAL"
echo "      To remove the multiple points (cf. step 1 ) and the buggy points (cf. step 3)"
echo
echo -e "$RED" [ astrofit.h ] "$NORMAL"
echo "      Calculation of the AstroFit chi2"
echo
echo -e "$RED" [ Higgs.h ] "$NORMAL"
echo "      Calculation of the Higgs chi2 with HiggsSignal"
echo
echo -e "$RED" [ LHC.h ] "$NORMAL"
echo "      Calculation of the LHC chi2"
echo
echo -e "$RED" [ postProcessing.cc ] "$NORMAL"
echo "      Main program for the processing"
echo
echo -e "$RED" [ postProcessing.h ] "$NORMAL"
echo "      Header where all the chi2 calculations are performed"
echo
echo -e "$RED" [ compil ] "$NORMAL"
echo "      Simple script to compil the processing package"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi


# =======================
# ==== QUICK HOW TO =====
# =======================

if [[ $wish == 2 ]]
then
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    The post-processing consists in 4 successive steps:"
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo -e "$RED" [ STEP 1 ] "$NORMAL"
echo "      Removal of multiple points to increase the processing speed"
echo
echo -e "$RED" [ STEP 2 ] "$NORMAL"
echo "      Calculation of the chi2 for a given set of observables"
echo
echo -e "$RED" [ STEP 3 ] "$NORMAL"
echo "      Removal of the buggy points using a contrast detection algorithm"
echo
echo -e "$RED" [ STEP 4 ] "$NORMAL"
echo "      Creation of toys, where for each toy the observables are smeared around their values at the point of lowest chi2"
echo
echo Which step do you want to perform?
echo
echo \(type a number...\)
read step

if [[ $step == 1 ]]
then
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    STEP 1: Removal of multiple points to increase the processing speed."
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo "      Look into multiplePointsRemoval/"
echo
echo "      Change the links and options in the batch-job script:"
echo -e "$RED" "> job_multiplePointsRemoval" "$NORMAL"
echo
echo "      Use the script makeAllJobs to create the batch-job scripts for each fit"
echo "      Change the links in the scripts"
echo "      Check that a file 'listOfFits_X.txt' exist for each fit generation (Look into listOfFits)"
echo "      where X is the number of the fit"
echo
echo "      Create the batch-job scripts for each fit"
echo -e "$RED" "> makeAllJobs 1 " "$NORMAL"
echo
echo "      Send all the batch-job scripts to batch"
echo -e "$RED" "> makeAllJobs 2 " "$NORMAL"
echo
echo "      Remove all the batch scripts"
echo -e "$RED" "> makeAllJobs 3 " "$NORMAL"
echo
echo "      The step 'makeAllJobs 2' submit each batch-job script"
echo -e "$RED" "> qsub job_multiplePointsRemoval " "$NORMAL"
echo
echo "      Output of that step: root files FIT_cleaned.root (->without multiple points)"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi

if [[ $step == 2 ]]
then
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    STEP 2: Calculation of the chi2 for a given set of observables."
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo "      Look into calculationChi2/"
echo
echo "      Input: FIT_cleaned.root (see step 1)"
echo
echo "      Change the links and options in the batch-job script"
echo -e "$RED" "> job_postProcessing " "$NORMAL"
echo
echo "      Use the script makeAllJobs to create the batch-job scripts for each fit"
echo "      Change the links in the scripts"
echo "      Check that a file 'listOfFits_X.txt' exist for each fit generation (Look into listOfFits)"
echo "      where X is the number of the fit"
echo
echo "      Create the batch-job scripts for each fit"
echo -e "$RED" "> makeAllJobs 1 " "$NORMAL"
echo
echo "      Send all the batch-job scripts to batch"
echo -e "$RED" "> makeAllJobs 2 " "$NORMAL"
echo
echo "      Remove all the batch scripts"
echo -e "$RED" "> makeAllJobs 3 " "$NORMAL"
echo
echo "      The step 'makeAllJobs 2' submit each batch-job script"
echo -e "$RED" "> qsub job_postProcessing " "$NORMAL"
echo
echo "      Simple script to check whether your jobs created an output"
echo -e "$RED" "> checkIfJobsSucceeded " "$NORMAL"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi

if [[ $step == 3 ]]
then
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    STEP 3: Removal of the buggy points using a contrast detection algorithm."
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo "       [1] Add all similar fits together:"
echo -e "$RED" "> hadd FIT_total.root FIT_1.root FIT_2.root ..." "$NORMAL"
echo "           Pay attention that the fits 3 to 6 are ALL CMSSM"
echo
echo "       [2] Check the upper limit of your scans by drawing"
echo -e "$RED" "> markovChain->Draw("P_X:chi2") " "$NORMAL"
echo "           where X = M12, M0..."
echo "           some limits for the parameters are hard-coded in  EdgeDetection.h"
echo
echo "       [3] In /fittino/postProcessing/edgeDetection"
echo "           Give in ChainBuilder.C the link to FIT_total.root"
echo "           Change in EdgeDetection.h the model considered (0=CMSSM, 1=NUHM1, 2=NUHM2)"
echo "           Run the following:"
echo -e "$RED" "> root -l -b " "$NORMAL"
echo -e "$RED" "> .X ChainBuilder.C " "$NORMAL"
echo -e "$RED" "> chain.Process("EdgeDetection.C") " "$NORMAL"
echo -e "$RED" "> .L EdgeDetectionAlgorithm.C+  " "$NORMAL"
echo -e "$RED" "> EdgeDetectionAlgorithm()  " "$NORMAL"
echo "           Attention, a maximal value of chi2 is hard-coded !!"
echo
echo "      Output: all splines in Splines.root, result plots ResultChi2Vs*.eps"
echo
echo "       [4] Run the cleaning, check the link to Splines.root in the batch-scripts job_**"
echo "           Look into buggyPointRemoval/"
echo "           Change the links and options in the batch-job script"
echo -e "$RED" "> job_bpr " "$NORMAL"
echo
echo "       [5] Create the batch-job scripts for each fit"
echo -e "$RED" "> makeJobsForMe 1 " "$NORMAL"
echo
echo "       [6] Send all the batch-job scripts to batch"
echo -e "$RED" "> makeJobsForMe 2 " "$NORMAL"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi

if [[ $step == 4 ]]
then
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    STEP 4: Creation of toys."
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo
echo "       For each toy the observables are smeared around their values at the point of lowest chi2"
echo "       Only 1 toy per job, all points are written in the ntuple."
echo "       In order to reduce the output size and get rid of the buggy points, are removed all the points"
echo "          with lowest chi2 as long as the point density is low."
echo
echo "       Look into toys/"
echo 
echo "       [1] Change the links and options in the batch-job script"
echo -e "$RED" "> job_toys" "$NORMAL"
echo
echo "       [2] Change the links in the script makeJobsForMe used to create the batch-job scripts"
echo
echo "       [3] Create the batch-job scripts for the toys"
echo -e "$RED" "> makeJobsForMe 1" "$NORMAL"
echo
echo "       [4] Send all the batch-job scripts to batch"
echo -e "$RED" "> makeJobsForMe 2" "$NORMAL"
echo
echo "       [5] Create the batch-job scripts for the extraction of the best fit points and their gathering in a single file"
echo -e "$RED" "> makeJobsForMe 3" "$NORMAL"
echo
echo "       [6] The step 'makeJobsForMe 2' submit each batch-job script"
echo -e "$RED" "> qsub job_toys" "$NORMAL"
echo
echo "       [7] Simple script to check whether your jobs created an output"
echo -e "$RED" "> checkIfJobsSucceeded" "$NORMAL"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi
fi