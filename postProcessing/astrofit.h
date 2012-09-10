#ifndef ASTROFIT_H
#define ASTROFIT_H

TGraph* graph = 0;
//double valAtZero = 0;
double shiftAtBestFitPoint = 0;
double relativeTheoUnc = 0.50;

// ===================================================================
// == Calculate parabola width at a given point
//double parabolaWidth( double WIMPmass, double theoUnc){//**
  double parabolaWidth( double WIMPmass, double WIMPcs, double theoUnc){

  // Upper limit on cross section at that point
  double upperLimit = graph->Eval( WIMPmass );

  // Width of parabola at that point, for one-sided 1D 90%CL, chi2=1.64: Chi2 = (cs/sigma)^2
  double width = upperLimit / TMath::Sqrt(1.64);
  
  // Add theoretical uncertainty of 50% on cross section from form factors
  //double theo = theoUnc * upperLimit;//**
  double theo = theoUnc * WIMPcs;

  double totalWidth = TMath::Sqrt( width*width + theo*theo  );

  return totalWidth;
}

// ===================================================================
// == Function per toy
void setAstrofit( int PP_or_Toys, double bestWIMPmass, double bestWIMPcs, bool verb ){
  
  if( verb ) cout << "   > Import the Xenon100 data.." << endl;
  
  // Xenon100 data: WIMP mass vs. direct cross section
  if( graph == 0 ) graph = new TGraph("dd_xenon100_2012.dat");
  
  // Total width including theoretical uncertainty
  //double totalWidth = parabolaWidth( bestWIMPmass, relativeTheoUnc );//**
  double totalWidth = parabolaWidth( bestWIMPmass, bestWIMPcs, relativeTheoUnc );
  
  // Minimum of the parabola shifted
  double parabolaMean = 0;
  // For toys
  if( PP_or_Toys == 0 ){
  // Smear the position of the parabola
    TRandom3 rand(0);
    parabolaMean = rand.Gaus( bestWIMPcs, totalWidth );
  }
  // For post-processing
  if( PP_or_Toys == 1 ) parabolaMean = bestWIMPcs;
  
  // Value at cross section=zero of the parabola at best fit point
  //valAtZero = TMath::Power( parabolaMean / totalWidth, 2 );

  // Shift of the parabola's mean: parabolaMean - upperLimit
  shiftAtBestFitPoint = parabolaMean - ( graph->Eval( bestWIMPmass ) );

  return;
}


// ===================================================================
// Function per event
double astrofitChi2( double WIMPmass, double WIMPcs, bool verbose ){
  
   // Total width including theoretical uncertainty
  double totalWidth = parabolaWidth( WIMPmass, WIMPcs, relativeTheoUnc );
  //double totalWidth = parabolaWidth( WIMPmass, relativeTheoUnc );//**

  // Require constant chi2 for null cross section
  //double cs0 = totalWidth * TMath::Sqrt( valAtZero );
  double cs0 = WIMPcs + shiftAtBestFitPoint;

  // Calculate chi2 for that point by setting the parabola to zero below the minimum
  double chi2 = 0;
  if( WIMPcs > cs0 ) chi2 = TMath::Power( ( WIMPcs - cs0 ) / totalWidth, 2 );
  else{
    if( verbose ) cout << "Cross section in the non excluded region " << WIMPcs << " < " << cs0 << endl;
    chi2 = 0;
  }
  
  return chi2;
}





#endif
