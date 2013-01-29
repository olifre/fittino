


 ===========================================================================
 Pay attention first to change in the job_step* scripts
 - all links
 - all file names
 - my email adress
 Change also the links in the compilation script ./compil

Questions, requests, frustration ? Write me: prudent[at]physik.tu-dresden.de
 ===========================================================================

 =====================
 ==== CONTENT ========
 =====================


 [dd_xenon100_2012.dat]

XENON100 data (WIMP mass versus cross section) for AstroFit

 [preparFittinoInput.sh]

To extract the observables from the Fittino input file and display them in 
an easy-to-handle text file

 [cleaning.h]

To remove the multiple points (cf. step 1 ) and the buggy points (cf. step 3)

 [CMSSM_to_NUHM]

To convert the CMSSM fits into NUHM1/2 fits by fixing 
M0H = M0 (for NUHM1) and M0Hu = M0Hd = M0 (for NUHM2)

 [astrofit.h]

Calculation of the AstroFit chi2

 [dd_xenon100_2012.dat]

XENON100 data (WIMP mass versus cross section) for AstroFit

 [Higgs.h]

Calculation of the Higgs chi2 with HiggsSignal

 [LHC.h]

Calculation of the LHC chi2

 [edgeDetection]

Calculation of the splines for the removal of the buggy points (cf. step 3)

 [compil]

Simple script to compil the processing package

 [postProcessing.cc]

Main program for the processing

 [postProcessing.h]

Header where all the chi2 calculations are performed




			=================
			==== STEP 1 =====
			=================

Removal of multiple points to increase the processing speed
Look into multiplePointsRemoval/

Change the links and options in the batch-job script
> job_multiplePointsRemoval

Use these scripts to create the batch-job scripts for each fit 
Change the links in these scripts
Check that a file 'listOfFits_X.txt' exist for each fit generation (Look into listOfFits)
where X is the number of the fit

Create the batch-job scripts for each fit
> makeAllJobs 1
Send all the batch-job scripts to batch
> makeAllJobs 2
Remove all the batch scripts
> makeAllJobs 3

The step 'makeAllJobs 2' submit each batch-job script
> qsub job_multiplePointsRemoval

Output: FIT_cleaned.root (->without multiple points)




			=================
			==== STEP 2 =====
			=================

Calculation of the chi2 for a given set of observables
Input: FIT_cleaned.root (see step 1)

Look into calculationChi2/

Change the links and options in the batch-job script
> job_postProcessing

Use these scripts to create the batch-job scripts for each fit
Change the links in these scripts
Check that a file 'listOfFits_X.txt' exist for each fit generation (Look into listOfFits)
where X is the number of the fit

Create the batch-job scripts for each fit
> makeAllJobs 1
Send all the batch-job scripts to batch
> makeAllJobs 2
Remove all the batch scripts
> makeAllJobs 3

The step 'makeAllJobs 2' submit each batch-job script
> qsub job_postProcessing

Simple script to check whether your jobs created an output
> checkIfJobsSucceeded


                      =================
                      ==== STEP 3 =====
                      =================

Removal of the buggy points using a contrast detection algorithm

 [1] Add all similar fits together:
   hadd FIT_total.root FIT_1.root FIT_2.root ...
   Pay attention that the fits 3 to 6 are ALL CMSSM

 [2] Check the upper limit of your scans by drawing 
   > markovChain->Draw("P_X:chi2")
   where X = M12, M0...
   some limits for the parameters are hard-coded in  EdgeDetection.h

 [3] In /fittino/postProcessing/edgeDetection
   Give in ChainBuilder.C the link to FIT_total.root
   Change in EdgeDetection.h the model considered (0=CMSSM, 1=NUHM1, 2=NUHM2)
   Run the following:
   > root -l -b
   > .X ChainBuilder.C
   > chain.Process("EdgeDetection.C")
   > .L EdgeDetectionAlgorithm.C+ 
   > EdgeDetectionAlgorithm()
   Attention, a maximal value of chi2 is hard-coded !!
Output: all splines in Splines.root, result plots ResultChi2Vs*.eps

 - Run the cleaning, check the link to Splines.root
Look into buggyPointRemoval/
Change the links and options in the batch-job script
> job_bpr

Create the batch-job scripts for each fit
> makeJobsForMe 1
Send all the batch-job scripts to batch
> makeJobsForMe 2


			=================
			==== STEP 4 =====
			=================	

Creation of toys, where for each toy the observables are smeared around their values at the point of lowest chi2
Only 1 toy per job, all points are written in the ntuple.
In order to reduce the output size and get rid of the buggy points, are removed all the points with lowest chi2 as long
as the point density is low.

Look into toys/

Change the links and options in the batch-job script
> job_toys

Use these scripts to create the batch-job scripts
Change the links in these scripts

Create the batch-job scripts for the toys
> makeJobsForMe 1
Send all the batch-job scripts to batch
> makeJobsForMe 2
Create the batch-job scripts for the extraction of the best fit points and their gathering in a single file
> makeJobsForMe 3

The step 'makeJobsForMe 2' submit each batch-job script
> qsub job_toys

Simple script to check whether your jobs created an output
> checkIfJobsSucceeded


