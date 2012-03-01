//indirect detection: 

{


/*These are the graphs for photon flux upper limits from indirect detection
 taken from 1001.4531 for the Fermi bb upper limit on Ursa Minor
 and directly from the authors of 1012.5602 for the HESS bb bar upper limits
 on Sculptor and  Carina */

/*all graphs are given in (#, energy, flux upper limit)
 with units (-, GeV, 10^-9 cm^-2 s^-1)*/

//Photon flux upper limits, Carina and Sculptor from HESS

TGraph *graph = new TGraph(5);
graph->SetName("Carina");
graph->SetTitle("bb upper limits from Carina dSPh");
graph->SetFillColor(2);
graph->SetLineStyle(7);
graph->SetLineWidth(2);
graph->SetMarkerStyle(20);
graph->SetMarkerSize(0.5);

graph->SetPoint(0, 0.5e+3, 6.346818e-4);
graph->SetPoint(1, 1.0e+3, 4.629363e-4);
graph->SetPoint(2, 5.0e+3, 2.517554e-4);
graph->SetPoint(3, 1.0e+4, 2.11414e-4);
graph->SetPoint(4, 2.0e+4, 1.853522e-4);


TGraph *graph = new TGraph(5);
graph->SetName("Sculptor");
graph->SetTitle("bb upper limits from Sculptor dSPh");
graph->SetFillColor(2);
graph->SetLineStyle(7);
graph->SetLineWidth(2);
graph->SetMarkerStyle(21);
graph->SetMarkerSize(0.5);

graph->SetPoint(0, 0.5e+3, 1.2512e-3);
graph->SetPoint(1, 1.0e+3, 9.89672e-4);
graph->SetPoint(2, 5.0e+3, 6.671185e-4);
graph->SetPoint(3, 1.0e+4, 5.948565e-4);
graph->SetPoint(4, 2.0e+4, 5.449245e-4);


//Photn flux upper limits, Ursa Minor from Fermi-LAT


TGraph *graph = new TGraph(10);
graph->SetName("UMi");
graph->SetTitle("bb upper limits from Ursa Minor dSPh");
graph->SetFillColor(2);
graph->SetLineStyle(7);
graph->SetLineWidth(2);
graph->SetMarkerStyle(22);
graph->SetMarkerSize(0.5);

graph->SetPoint(0, 0.1e+2, 7.73e-1);
graph->SetPoint(1, 0.2e+2, 4.60e-1);
graph->SetPoint(2, 0.5e+2, 2.53e-1);
graph->SetPoint(3, 0.8e+2, 1.91e-1);
graph->SetPoint(4, 0.1e+3, 1.69e-1);
graph->SetPoint(5, 0.2e+3, 1.23e-1);
graph->SetPoint(6, 0.3e+3, 1.06e-1);
graph->SetPoint(7, 0.5e+3, 9.31e-2);
graph->SetPoint(8, 0.8e+3, 8.46e-2);
graph->SetPoint(9, 1.0e+3, 8.17e-2);




/*Here are upper limits on the annihilation cross-section,
 graphs are given in (#, mass, thermal average cross-section)
 with units (-, GeV, 10^-26 cm^3 s^-1) */


// Segue 1, given directly by Pat Scott

TGraph *graph = new TGraph(10);
graph->SetName("Segue1");
graph->SetTitle("bb upper limits from Segue1");
graph->SetFillColor(2);
graph->SetLineStyle(7);
graph->SetLineWidth(2);
graph->SetMarkerStyle(20);
graph->SetMarkerSize(0.5);

graph->SetPoint(0, 1.0e+1, 0.8e+1); 
graph->SetPoint(1, 2.0e+1, 0.95e+1); 
graph->SetPoint(2, 5.0e+1, 2.0e+1); 
graph->SetPoint(3, 8.0e+1, 3.5e+1); 
graph->SetPoint(4, 0.1e+3, 4.5e+1); 
graph->SetPoint(5, 0.2e+3, 1.0e+2); 
graph->SetPoint(6, 0.3e+3, 1.5e+2); 
graph->SetPoint(7, 0.5e+3, 3.0e+2); 
graph->SetPoint(8, 0.8e+3, 5.0e+2); 
graph->SetPoint(9, 1.0e+3, 7.0e+2); 


// joint likelihood from 10 dSph taken from [1108.3546]


TGraph *graph = new TGraph(129);
graph->SetName("JointLikelihood");
graph->SetTitle("bb upper limits, joint likelihood of 10 dSph");
graph->SetFillColor(2);
graph->SetLineStyle(7);
graph->SetLineWidth(2);
graph->SetMarkerStyle(21);
graph->SetMarkerSize(0.5);

graph->SetPoint(0, 1.005e+1,  1.5703);
graph->SetPoint(1, 1.031e+1,  1.6102);
graph->SetPoint(2, 1.063e+1,  1.6511);
graph->SetPoint(3, 1.097e+1,  1.6930);
graph->SetPoint(4, 1.131e+1,  1.7360);
graph->SetPoint(5, 1.155e+1,  1.7801);
graph->SetPoint(6, 1.179e+1,  1.7801);
graph->SetPoint(7, 1.210e+1,  1.8253);
graph->SetPoint(8, 1.241e+1,  1.8716);
graph->SetPoint(9, 1.267e+1,  1.9192);
graph->SetPoint(10, 1.307e+1,  1.9679);
graph->SetPoint(11, 1.341e+1,  2.0179);
graph->SetPoint(12, 1.383e+1,  2.0179);
graph->SetPoint(13, 1.420e+1,  2.0691);
graph->SetPoint(14, 1.464e+1,  2.1216);
graph->SetPoint(15, 1.534e+1,  2.1755);
graph->SetPoint(16, 1.582e+1,  2.2307);
graph->SetPoint(17, 1.632e+1,  2.2874);
graph->SetPoint(18, 1.683e+1,  2.3455);
graph->SetPoint(19, 1.736e+1,  2.4050);
graph->SetPoint(20, 1.781e+1,  2.4050);
graph->SetPoint(21, 1.828e+1,  2.4661);
graph->SetPoint(22, 1.885e+1,  2.5287);
graph->SetPoint(23, 1.944e+1,  2.5929);
graph->SetPoint(24, 2.037e+1,  2.6587);
graph->SetPoint(25, 2.123e+1,  2.6587);
graph->SetPoint(26, 2.201e+1,  2.7262);
graph->SetPoint(27, 2.270e+1,  2.7955);
graph->SetPoint(28, 2.329e+1,  2.7955);
graph->SetPoint(29, 2.402e+1,  2.8664);
graph->SetPoint(30, 2.491e+1,  2.9392);
graph->SetPoint(31, 2.569e+1,  2.9392);
graph->SetPoint(32, 2.677e+1,  3.0139);
graph->SetPoint(33, 2.761e+1,  3.0904);
graph->SetPoint(34, 2.834e+1,  3.0904);
graph->SetPoint(35, 2.923e+1,  3.1688);
graph->SetPoint(36, 3.014e+1,  3.2493);
graph->SetPoint(37, 3.109e+1,  3.2493);
graph->SetPoint(38, 3.224e+1,  3.3318);
graph->SetPoint(39, 3.377e+1,  3.4164);
graph->SetPoint(40, 3.483e+1,  3.5031);
graph->SetPoint(41, 3.611e+1,  3.5031);
graph->SetPoint(42, 3.744e+1,  3.5921);
graph->SetPoint(43, 3.861e+1,  3.6833);
graph->SetPoint(44, 4.003e+1,  3.6833);
graph->SetPoint(45, 4.150e+1,  3.7768);
graph->SetPoint(46, 4.303e+1,  3.8727);
graph->SetPoint(47, 4.461e+1,  3.8727);
graph->SetPoint(48, 4.601e+1,  3.9711);
graph->SetPoint(49, 4.746e+1,  4.0719);
graph->SetPoint(50, 4.946e+1,  4.0719);
graph->SetPoint(51, 5.181e+1,  4.1753);
graph->SetPoint(52, 5.371e+1,  4.2813);
graph->SetPoint(53, 5.569e+1,  4.3900);
graph->SetPoint(54, 5.774e+1,  4.5015);
graph->SetPoint(55, 5.986e+1,  4.6157);
graph->SetPoint(56, 6.206e+1,  4.6157);
graph->SetPoint(57, 6.401e+1,  4.7329);
graph->SetPoint(58, 6.602e+1,  4.8531);
graph->SetPoint(59, 6.845e+1,  4.9763);
graph->SetPoint(60, 7.060e+1,  4.9763);
graph->SetPoint(61, 7.319e+1,  5.1027);
graph->SetPoint(62, 7.511e+1,  5.2323);
graph->SetPoint(63, 7.827e+1,  5.3651);
graph->SetPoint(64, 8.115e+1,  5.5013);
graph->SetPoint(65, 8.370e+1,  5.5013);
graph->SetPoint(66, 8.677e+1,  5.6410);
graph->SetPoint(67, 9.043e+1,  5.7842);
graph->SetPoint(68, 9.424e+1,  5.9311);
graph->SetPoint(69, 9.720e+1,  5.9311);
graph->SetPoint(70, 1.012e+2,  6.0817);
graph->SetPoint(71, 1.050e+2,  6.3945);
graph->SetPoint(72, 1.083e+2,  6.3945);
graph->SetPoint(73, 1.111e+2,  6.5568);
graph->SetPoint(74, 1.158e+2,  6.7233);
graph->SetPoint(75, 1.200e+2,  6.8940);
graph->SetPoint(76, 1.245e+2,  7.0691);
graph->SetPoint(77, 1.284e+2,  7.2485);
graph->SetPoint(78, 1.317e+2,  7.4326);
graph->SetPoint(79, 1.366e+2,  7.6213);
graph->SetPoint(80, 1.416e+2,  7.8148);
graph->SetPoint(81, 1.468e+2,  8.0132);
graph->SetPoint(82, 1.530e+2,  8.2167);
graph->SetPoint(83, 1.578e+2,  8.6393);
graph->SetPoint(84, 1.636e+2,  8.8586);
graph->SetPoint(85, 1.696e+2,  9.3142);
graph->SetPoint(86, 1.749e+2,  9.3142);
graph->SetPoint(87, 1.814e+2,  9.7932);
graph->SetPoint(88, 1.890e+2,  1.0041e+1);
graph->SetPoint(89, 1.980e+2,  1.0558e+1);
graph->SetPoint(90, 2.085e+2,  1.1101e+1);
graph->SetPoint(91, 2.173e+2,  1.1383e+1);
graph->SetPoint(92, 2.241e+2,  1.1968e+1);
graph->SetPoint(93, 2.323e+2,  1.2272e+1);
graph->SetPoint(94, 2.459e+2,  1.2583e+1);
graph->SetPoint(95, 2.562e+2,  1.3231e+1);
graph->SetPoint(96, 2.657e+2,  1.3567e+1);
graph->SetPoint(97, 2.797e+2,  1.4626e+1);
graph->SetPoint(98, 2.945e+2,  1.4998e+1);
graph->SetPoint(99, 3.085e+2,  1.5769e+1);
graph->SetPoint(100, 3.215e+2,  1.6580e+1);
graph->SetPoint(101, 3.368e+2,  1.7433e+1);
graph->SetPoint(102, 3.510e+2,  1.8329e+1);
graph->SetPoint(103, 3.677e+2,  1.9272e+1);
graph->SetPoint(104, 3.832e+2,  2.0263e+1);
graph->SetPoint(105, 3.952e+2,  2.1305e+1);
graph->SetPoint(106, 4.183e+2,  2.2401e+1);
graph->SetPoint(107, 4.359e+2,  2.3553e+1);
graph->SetPoint(108, 4.519e+2,  2.4764e+1);
graph->SetPoint(109, 4.685e+2,  2.5393e+1);
graph->SetPoint(110, 4.883e+2,  2.6699e+1);
graph->SetPoint(111, 5.062e+2,  2.8072e+1);
graph->SetPoint(112, 5.275e+2,  2.9515e+1);
graph->SetPoint(113, 5.497e+2,  3.1033e+1);
graph->SetPoint(114, 5.700e+2,  3.1821e+1);
graph->SetPoint(115, 5.848e+2,  3.2629e+1);
graph->SetPoint(116, 6.063e+2,  3.4307e+1);
graph->SetPoint(117, 6.319e+2,  3.6071e+1);
graph->SetPoint(118, 6.619e+2,  3.8889e+1);
graph->SetPoint(119, 6.934e+2,  4.0889e+1);
graph->SetPoint(120, 7.263e+2,  4.4084e+1);
graph->SetPoint(121, 7.569e+2,  4.6351e+1);
graph->SetPoint(122, 7.847e+2,  4.8734e+1);
graph->SetPoint(123, 8.178e+2,  5.1241e+1);
graph->SetPoint(124, 8.522e+2,  5.3876e+1);
graph->SetPoint(125, 8.973e+2,  5.8085e+1);
graph->SetPoint(126, 9.303e+2,  6.1072e+1);
graph->SetPoint(127, 9.595e+2,  6.4212e+1);
graph->SetPoint(128, 9.846e+2,  6.4212e+1);

}
