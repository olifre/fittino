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
echo "For all sets the HiggsBound chi2 is added"
echo "\\end{frame}"



for obs in {0..17}; do

    if [ $obs -eq 13 -o $obs -eq 14 -o $obs -eq 15 -o $obs -eq 1 -o $obs -eq 2 -o $obs -eq 3 -o $obs -eq 8 -o $obs -eq 10 -o $obs -eq 11  ]
        then 
	continue;
    fi

    for model in CMSSM NUHM1 NUHM2; do

	if [ $model == CMSSM ]; then
	    list=(P_A0_P_M0 P_A0_P_M12 P_A0_P_TanBeta P_M0_P_M12 P_M0_P_TanBeta P_M12_P_TanBeta P_massTop_P_A0 P_massTop_P_M0 P_massTop_P_M12 P_massTop_P_TanBeta)
	fi

	if [ $model == NUHM1 ]; then
	    list=( P_A0_P_TanBeta P_M0_P_M12 P_M0_P_TanBeta P_M12_P_TanBeta P_massTop_P_A0 P_massTop_P_M0 P_massTop_P_M12 P_massTop_P_TanBeta  P_M0H_P_TanBeta P_M0H_P_M12 P_massTop_P_M0H)
	fi

	if [ $model == NUHM2 ]; then
	    list=(  P_A0_P_TanBeta P_M0_P_M12 P_M0_P_TanBeta P_M12_P_TanBeta P_massTop_P_A0 P_massTop_P_M0 P_massTop_P_M12 P_massTop_P_TanBeta  P_M0Hu_P_TanBeta P_M0Hu_P_M12 P_massTop_P_M0Hu  P_M0Hd_P_TanBeta P_M0Hd_P_M12 P_massTop_P_M0Hd P_M0Hd_P_M0Hu )
	fi

	for parameter in ${list[@]} ; do

	
	    echo "\\begin{frame}"
	    echo "\\frametitle{obs=$obs, model=$model}"
	    echo "\\includegraphics[width=0.7\linewidth]{$output_PLOTS/$obs/$model/markovChain2D2sContours_${parameter}_}"
	    echo "\\end{frame}"

	done

    done





done


echo "\\end{document}"

