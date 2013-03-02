#!/usr/bin/env bash




echo "\\documentclass[10pt]{beamer}"
echo "\\usepackage{graphics}"
echo "\\begin{document}"


echo "\\begin{frame}"
echo "\\frametitle{Sets of obervables}"
echo "0: full obs\\\\"
echo "1: full obs, but only mh\\\\"
echo "2: only LHC and h0\\\\"
echo "3: only LHC and h0 with only mh\\\\"
echo "4: LEO and AF\\\\"
echo "5: full set without Bsmumu\\\\"
echo "6: full set with the world average of B to tau nu\\\\"
echo "7: full set with no B physics input\\\\"
echo "8: full set with no Omega\\\\"
echo "9: full set with no gmin2\\\\"
echo "10: full set with no Omega and no gmin2\\\\"
echo "11: full set with lower Higgs uncertainty with mh only (1GeV)\\\\"
echo "12: full set with lower Higgs uncertainty with mh only (0.5GeV)\\\\"
echo "13: full set with more precise rate measurement (20\\% of now)\\\\"
echo "14: full set with more precise rate measurement (5\\% of now)\\\\" 
echo "15: full set with more precise Higgs measurement (mass: 25\\%, rate: 5\\%)\\\\"
echo "16: full obs with no LHC correction applied\\\\"
echo "17: full obs of the 2012 paper\\\\"
echo " "
echo "For all sets the HiggsBound chi2 is added\\"
echo "\\end{frame}"



for obs in {0..17}; do

    if [ $obs -eq 13 -o $obs -eq 14 -o $obs -eq 15 ]
        then 
	continue;
    fi

    for model in CMSSM NUHM1 NUHM2; do

	if [ $model == CMSSM ]; then
	    list=(M0 A0 TanBeta M12 MassTop)
	fi

	if [ $model == NUHM1 ]; then
	    list=(M0 A0 TanBeta M12 MassTop M0H)
	fi

	if [ $model == NUHM2 ]; then
	    list=(M0 A0 TanBeta M12 MassTop M0Hu M0Hd)
	fi

	for parameter in ${list[@]} ; do
	
	    echo "\\begin{frame}"
	    echo "\\frametitle{obs=$obs, model=$model, para=$parameter}"
	    echo "\\includegraphics[width=0.48\linewidth]{$cut_directory/$obs/$model/ResultChi2Vs${parameter}}"
	    echo "\\includegraphics[width=0.48\linewidth]{$output_PLOTS1D/$obs/$model/ResultChi2Vs${parameter}}"
	    echo "\\end{frame}"

	done

    done





done


echo "\\end{document}"

