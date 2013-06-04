f(x) = a*x**10 + b*x**9 + c*x**8 + d*x**7 + e*x**6 + f*x**5 +g*x**4 + h*x**3 +i*x**2
h(x) =  (x>=1) ? 3.322*x**2 + 4.92* x : 0/0 #The numerical values were calculated by curve discussion.
set style line 1 lt 3 lw 1 pt 6 ps 1
set xlabel "BR(h->Invisible)"
set ylabel "Chi2"
set mxtics 5
set mytics 4
set xrange [-0.05:2]
set yrange [0:40]
set key left top
fit [0:1] f(x) "brinvisible.txt" via a, b, c, d, e, f, g, h, i
set term png
set output "Brinvisible_plot.png"
plot "brinvisible.txt" with points ls 1,  f(x) t "fit" lt -1, h(x) t "parabel" lt 1
