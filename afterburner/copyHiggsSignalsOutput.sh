cat SPheno.spc.temp.1 | grep 'HiggsSignalsResults' >> SPheno.spc
cat SPheno.spc.temp.1 | grep 'Total Chi-squared' >> SPheno.spc 
cat SPheno.spc.temp.1 | grep 'HiggsSignalsPeakObservables' >> SPheno.spc
cat SPheno.spc.temp.1 | grep 'Mass and signal strength modifier of the dominant Higgs boson' >> SPheno.spc

mv SPheno.spc.temp.1.last SPheno.spc.temp.1.last2
mv SPheno.spc.temp.1 SPheno.spc.temp.1.last
