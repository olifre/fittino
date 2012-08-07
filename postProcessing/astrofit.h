#ifndef ASTROFIT_H
#define ASTROFIT_H

TGraph* graph = 0;
double valAtZero = 0;
double relativeTheoUnc = 0.50;

// == Calculate parabola width at a given point
double parabolaWidth( double WIMPmass, double WIMPcs, double theoUnc){

  // Upper limit on cross section at that point
  double upperLimit = graph->Eval( WIMPmass );
  
  // Width of parabola at that point, for 1D 90%CL, chi2=1.28
    // Chi2 = (cs/sigma)^2
  double width = upperLimit / TMath::Sqrt(1.28);
  
  // Add theoretical uncertainty of 50% on cross section from form factors
  double theo = theoUnc * WIMPcs;
  double totalWidth = TMath::Sqrt( width*width + theo*theo  );

  return totalWidth;
}


// == Function per toy
void smearAstrofit( double bestWIMPmass, double bestWIMPcs ){

  // Xenon100 data: WIMP mass vs. direct cross section
  if( graph == 0 ) graph = new TGraph("dd_xenon100_2012.dat");

  // Total width including theoretical uncertainty
  double totalWidth = parabolaWidth( bestWIMPmass, bestWIMPcs, relativeTheoUnc );

  // Smear the position of the parabola
  TRandom3 rand(0);
  double smearedBestFitcs = rand.Gaus( bestWIMPcs, totalWidth );

  // Value at cross section=zero of the smeared parabola at best fit point
  valAtZero = TMath::Power( smearedBestFitcs / totalWidth, 2 );
  
  return;
}



// Function per event
double astrofitChi2( double WIMPmass, double WIMPcs ){
  
   // Total width including theoretical uncertainty
   double totalWidth = parabolaWidth( WIMPmass, WIMPcs, relativeTheoUnc );
  
  // Require constant chi2 for null cross section
  double cs0 = totalWidth * TMath::Sqrt( valAtZero );

  // Calculate chi2 for that point
  // Set the parabola to zero below the minimum
  double chi2 = 0;
  if( WIMPcs > cs0 ) chi2 = TMath::Power( ( WIMPcs - cs0 ) / totalWidth, 2 );
  else chi2 = 0;

  return chi2;
}

#endif
