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
echo "               [1]  What is the post-processing ?"
echo
echo "               [2]  The content and files of the post-processing"
echo
echo "               [3]  How to quickly run the post-processing"
echo
echo "               [4] Questions, requests, frustration ?"
echo
echo \(type a number...\)
read wish


# =====================
# ==== DESCRIPTION ========
# =====================

if [[ $wish == 1 ]]
then
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo "    What the post-processing is"
echo -e "$BLUE" "======================================================================="  "$NORMAL"
echo 
echo "The SUSY parameter space have been sampled using millions of points"
echo "for each of these points we want to know the chi2, considering theoretical predictions"
echo "and experimental constraints. The theoretical predictions being fixed,"
echo "if the experimental constraints (called 'observables') are updated, then"
echo "the chi2 needs to be recalculated for each point: this is the POST-PROCESSING."
echo
echo -e "$RED" We have 18 sets of observables, numerated to 0 to 17: "$NORMAL"
echo " [0] full observable set"
echo " [1] full observable set, but only m(h0)"
echo " [2] only LHC and h0"
echo " [3] only LHC and h0 with only m(h0)"
echo " [4] LEO and AF"
echo " [5] full set without Bs->mumu"
echo " [6] full set with the world average of B->tau nu"
echo " [7] full set with no B physics input"
echo " [8] full set with no Omega"
echo " [9] full set with no gmin2"
echo " [10] full set with no Omega and no gmin2"
echo " [11] full set with lower Higgs uncertainty with m(h0) only (1GeV)"
echo " [12] full set with lower Higgs uncertainty with m(h0) only (0.5GeV)"
echo " [13] full set with more precise rate measurement (20% of now)"
echo " [14] full set with more precise rate measurement (5% of now)"
echo " [15] full set with more precise Higgs measurement (mass: 25%, rate: 5%)"
echo " [16] full observable set with no A0-TanBeta correction to the LHC chi2 (to be compared to '0')"
echo " [17] full observable set of the previous 2012 paper"
echo
echo "Due to the very high computing time required by the sampling (called 'fit'), they were performed in parallel 9 times"
echo -e "$RED" We have 9 SUSY samplings, numerated from 3 to 13 "$NORMAL"
echo -e "$RED" The samplings 3 to 6 are _all_ from CMSSM, no matter their names are "$NORMAL"
echo
echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi

# =====================
# ==== CONTENT ========
# =====================

if [[ $wish == 2 ]]
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

if [[ $wish == 3 ]]
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
echo "      You will have to modify compiling script:"
echo -e "$RED" "[ fittino/postProcessing/compil ]"  "$NORMAL"
echo " - The link to HiggsSignals"
echo " - The link to the directory of the LHC chi2 tools"
echo
echo "      You will have to modify the batch-job script:"
echo -e "$RED" "[ multiplePointsRemoval/job_multiplePointsRemoval ]"  "$NORMAL"
echo " - The email adress                                                     'MYADRESS@physik.MYUNIVERSITY.de'"
echo " - The link to the Fittino input file with the experimental constraints 'input_file'"
echo " - The link to the output directory                                     'output_destination'"
echo " - The link to the directory with the post-processing program           'working_directory'"
echo " - The link to the directory of the LHC chi2 tools                      'tools_directory'"
echo " - The link for the ROOT compilation of these LHC tools                 'LD_LIBRARY_PATH'"
echo " - All other aliases: 'FIT_TO_BE_PROCESSED', 'INPUT_DIR', 'XX' are modified by the script 'makeAllJobs' when creating the batch-job scripts for all fits and all observables"
echo
echo "      You will have to modify the script:"
echo -e "$RED" "[ multiplePointsRemoval/makeJobsForMe ]"  "$NORMAL"
echo " - The link to the directory of the ntuples to process                  'input'"
echo " - The link to the list of available fits (Look into listOfFits)        'listOfFits_.txt'"
echo
echo "      You will have to modify the script:"
echo -e "$RED" "[ multiplePointsRemoval/makeAllJobs ]"  "$NORMAL"
echo " - The observables sets you want to use (numerated from 0 to 17)        'obs'"
echo " - The fits you want to process                                         'fit'"
echo " - The link to the directory where all batch-job scripts have been created"
echo
echo "      Use the script makeAllJobs to create the batch-job scripts for each fit"
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
echo "      Output of that step: root files FIT_cleaned.root (->without multiple points\)"
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
echo "      You will have to modify the batch-job script:"
echo -e "$RED" "[ calculationChi2/job_multiplePointsRemoval ]"  "$NORMAL"
echo " - The email adress                                                     'MYADRESS@physik.MYUNIVERSITY.de'"
echo " - The link to the Fittino input file with the experimental constraints 'input_file'"
echo " - The link to the input directory                                      'input_directory'"
echo " - The link to the output directory                                     'output_destination'"
echo " - The link to the directory with the post-processing program           'working_directory'"
echo " - The link to the directory of the LHC chi2 tools                      'tools_directory'"
echo " - The link for the ROOT compilation of these LHC tools                 'LD_LIBRARY_PATH'"
echo " - All other aliases: 'FIT_TO_BE_PROCESSED', 'WHICH_OBS', 'XX' are modified by the script 'makeAllJobs' when creating the batch-job scripts for all fits and all observables"
echo
echo "      You will have to modify the script:"
echo -e "$RED" "[ calculationChi2/makeJobsForMe ]"  "$NORMAL"
echo " - The link to the list of available fits (Look into listOfFits)        'listOfFits_.txt'"
echo " - The batch parameter for that job                                     'HOUR, MINUTE'"
echo
echo "      You will have to modify the script:"
echo -e "$RED" "[ calculationChi2/makeAllJobs ]"  "$NORMAL"
echo " - The observables sets you want to use (numerated from 0 to 17)        'obs'"
echo " - The fits you want to process                                         'fit'"
echo " - The link to the directory where all batch-job scripts have been created"
echo
echo "      Use the script makeAllJobs to create the batch-job scripts for each fit"
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
echo "           some limits for the parameters are hard-coded in  EdgeDetection.C"
echo
echo "       [3] In /fittino/postProcessing/edgeDetection"
echo "      You will have to modify the macros:"
echo -e "$RED" "[ edgeDetection/ChainBuilder.C ]"  "$NORMAL"
echo " - The link to the merged ROOT file FIT_total.root"
echo -e "$RED" "[ edgeDetection/EdgeDetection.h ]"  "$NORMAL"
echo " - The model under study (0=CMSSM, 1=NUHM1, 2=NUHM2)"
echo -e "$RED" "[ edgeDetection/EdgeDetection.C ]"  "$NORMAL"
echo " - The upper and lower values of the parameter range in the histograms"
echo
echo "       [4] Then run the following:"
echo -e "$RED" "> root -l -b " "$NORMAL"
echo -e "$RED" "> .X ChainBuilder.C " "$NORMAL"
echo -e "$RED" "> chain.Process("EdgeDetection.C") " "$NORMAL"
echo -e "$RED" "> .L EdgeDetectionAlgorithm.C+  " "$NORMAL"
echo -e "$RED" "> EdgeDetectionAlgorithm()  " "$NORMAL"
echo "           Attention, a maximal value of chi2 is hard-coded !!"
echo
echo "      Output: all splines in Splines.root, result plots ResultChi2Vs*.eps"
echo
echo "       [5] Use the splines to remove the buggy points"
echo "      You will have to modify the script:"
echo -e "$RED" "[ buggyPointRemoval/job_bpr ]"  "$NORMAL"
echo " - The email adress                                                     'MYADRESS@physik.MYUNIVERSITY.de'"
echo " - The link to the Fittino input file with the experimental constraints 'input_file'"
echo " - The link to the input directory                                      'input_directory'"
echo " - The link to the output directory                                     'output_destination'"
echo " - The link to the directory with the post-processing program           'working_directory'"
echo " - The link to the directory of the LHC chi2 tools                      'tools_directory'"
echo " - The link for the ROOT compilation of these LHC tools                 'LD_LIBRARY_PATH'"
echo " - The link to the splines                                              'FILECUTS'"
echo " - All other aliases: 'FIT_TO_BE_PROCESSED', 'XXMODEL', 'XXOBS' are modified by the script 'makeAllJobs' when creating the batch-job scripts for all fits and all observables"
echo
echo "      You will have to modify the script:"
echo -e "$RED" "[ buggyPointRemoval/makeJobsForMe ]"  "$NORMAL"
echo " - The observables sets you want to use (numerated from 0 to 17)        'obs'"
echo " - The model under study (CMSSM NUHM1 NUHM2)                            'model'"
echo " - The link to the directory where all batch-job scripts have been created"
echo
echo "       [6] Create the batch-job scripts for each fit"
echo -e "$RED" "> makeJobsForMe 1 " "$NORMAL"
echo
echo "       [7] Send all the batch-job scripts to batch"
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
echo "       [1] You will have to modify the scrip:"
echo -e "$RED" "[ toys/job_bpr ]"  "$NORMAL"
echo " - The email adress                                                     'MYADRESS@physik.MYUNIVERSITY.de'"
echo " - The link to the Fittino input file with the experimental constraints 'input_file'"
echo " - The link to the input directory                                      'input_directory'"
echo " - The link to the output directory                                     'output_destination'"
echo " - The link to the directory with the post-processing program           'working_directory'"
echo " - The link to the directory of the LHC chi2 tools                      'tools_directory'"
echo " - The link for the ROOT compilation of these LHC tools                 'LD_LIBRARY_PATH'"
echo " - All other aliases: 'XXMODEL', 'XXOBS', 'XXTOYS' are modified by the script 'makeJobsForMe' when creating the batch-job scripts for all fits and all observables"
echo
echo "       [2] You will have to modify the script:"
echo -e "$RED" "[ toys/makeJobsForMe ]"  "$NORMAL"
echo " - The observables sets you want to use (numerated from 0 to 17)        'obs'"
echo " - The model under study (CMSSM NUHM1 NUHM2)                            'model'"
echo " - The number of toys to run (1 toy per job)                            'toy'"
echo " - The link to the directory where all batch-job scripts have been created"
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
echo "       [8] Extract for each toy the point of lowest chi2 and save all these minima in an ntuple"
echo "        You will have to modify the script:"
echo -e "$RED" "[ toys/job_extract ]"  "$NORMAL"
echo " - The email adress                                                     'MYADRESS@physik.MYUNIVERSITY.de'"
echo " - The link to the Fittino input file with the experimental constraints 'input_file'"
echo " - The link to the input directory                                      'input_directory'"
echo " - The link to the output directory                                     'output_destination'"
echo " - The link to the directory with the post-processing program           'working_directory'"
echo " - The link to the directory of the LHC chi2 tools                      'tools_directory'"
echo " - The number of toys to consider                                       'NB_TOYS'"
echo " - The link for the ROOT compilation of these LHC tools                 'LD_LIBRARY_PATH'"
echo " - All other aliases: 'XXMODEL', 'XXOBS', 'XXTOYS' are modified by the script 'makeAllJobs' when creating the batch-job scripts for all fits and all observables"

echo -e "$BLUE" "======================================================================="  "$NORMAL"
fi
fi

# =====================
# ==== CONTACT ========
# =====================

if [[ $wish == 4 ]]
then
echo "Write me at prudent[at]physik.tu-dresden.de (Xavier Prudent)"
fi
