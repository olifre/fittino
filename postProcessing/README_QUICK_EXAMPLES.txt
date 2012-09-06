


 ===========================================================================
 Pay attention first to change in the job_step* scripts
 - all links
 - all file names
 - my email adress
 Change also the links in ./compil

Questions, requests, frustration ? Write me: prudent[at]physik.tu-dresden.de
 ===========================================================================


			=================
			==== STEP 1 =====
			=================

Removal of multiple points and calculation of the desired chi2 for a given fit 'FIT'
> qsub job_step1

Output: FIT.root, FIT_cleaned.root (->without multiple points)


			=================
			==== STEP 2 =====
			=================

Removal of the buggy points

 - Add all similar together:
   hadd FIT_total.root FIT_1.root FIT_2.root ...

 - In /fittino/postProcessing/edgeDetection
   Give in ChainBuilder.C the link to FIT_total.root
   Run the following:
   > root -l -b
   > .X ChainBuilder.C
   > chain.Process("EdgeDetection.C")
   > .L EdgeDetectionAlgorithm.C+ 
   > EdgeDetectionAlgorithm()
   Attention, a maximal value of chi2 is hard-coded !!
Output: all splines in Splines.root, result plots ResultChi2Vs*.eps

 - Run the cleaning, check the link to Splines.root
   > qsub job_step2


			=================
			==== STEP 3 =====
			=================	

Run of toys, if only 1 toy is asked, all points are written in the output ntuple, and not only the best fit point
> qsub job_step3
