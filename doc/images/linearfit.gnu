f(x) = a*x + b
set style line 1 lt 3 lw 1 pt 6 ps 1 
set xlabel "Higgs mass [GeV]"
set ylabel ""
set mxtics 5
set mytics 4
set key left top 
fit [123:129] f(x) "hgg.txt" using 1:3 via a, b # 1:3 means plot the first column vs the third
set term png
set output "hgg_tt.png"
plot "hgg.txt" using 1:3 with points ls 1 t "tb coupling", f(x) lt 1 t "fit" # ls 1 displays the data with blue circles
# Both the fit and plot command will produce a single plot for the tt coupling. 
# To get all the plots for different couplings as shown in the documentation, 
# simply exchange the third column with 4, 5, 6, ... etc. in both command lines. And don't forget to change the output name.
