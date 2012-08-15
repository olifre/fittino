#ifndef ASTROFIT_H
#define ASTROFIT_H

TGraph* graph = 0;
double valAtZero = 0;
double relativeTheoUnc = 0.50;
bool check=0;

// == Calculate parabola width at a given point
double parabolaWidth( double WIMPmass, double theoUnc){

  // Upper limit on cross section at that point
  double upperLimit = graph->Eval( WIMPmass );
  //cout << "Upper limit = " << upperLimit << endl;

  // Width of parabola at that point, for one-sided 1D 90%CL, chi2=1.64
  // Chi2 = (cs/sigma)^2
  double width = upperLimit / TMath::Sqrt(1.64);
  //cout << "Width = " << width << endl;
  
  // Add theoretical uncertainty of 50% on cross section from form factors
  double theo = theoUnc * upperLimit;
  double totalWidth;
  if( check ) totalWidth = width;
  if( !check ) totalWidth = TMath::Sqrt( width*width + theo*theo  );

  return totalWidth;
}

// ===================================================================
// == Function per toy
void smearAstrofit( double bestWIMPmass, double bestWIMPcs, bool verb ){

  //  cout << "Best values: mass = " << bestWIMPmass << " cs = " << bestWIMPcs << endl;
  
  if( verb ) cout << "   > Smear Xenon100 contour.." << endl;

  // Xenon100 data: WIMP mass vs. direct cross section
  if( graph == 0 ) graph = new TGraph("dd_xenon100_2012.dat");

  // Total width including theoretical uncertainty
  double totalWidth = parabolaWidth( bestWIMPmass, relativeTheoUnc );
  //cout << "Total width = " << totalWidth << endl;
  
  // Smear the position of the parabola
  TRandom3 rand(0);
  double smearedBestFitcs = 0;
  if( !check ) smearedBestFitcs = rand.Gaus( bestWIMPcs, totalWidth );
  
  // Value at cross section=zero of the smeared parabola at best fit point
  if( !check ) valAtZero = TMath::Power( smearedBestFitcs / totalWidth, 2 );
  //cout << "Value of af_chi2 at zero: " << valAtZero << endl;

  return;
}


// ===================================================================
// Function per event
double astrofitChi2( double WIMPmass, double WIMPcs, bool verbose ){
  
   // Total width including theoretical uncertainty
   double totalWidth = parabolaWidth( WIMPmass, relativeTheoUnc );
   //cout << "Total width of the parabola = " << totalWidth << endl;

  // Require constant chi2 for null cross section
  double cs0 = totalWidth * TMath::Sqrt( valAtZero );
  //cout << "Mean of the parabola = " << cs0 << endl;

  // Calculate chi2 for that point
  // Set the parabola to zero below the minimum
  double chi2 = 0;
  if( !check ) {
    if( WIMPcs > cs0 ) chi2 = TMath::Power( ( WIMPcs - cs0 ) / totalWidth, 2 );
    else{
      if( verbose ) cout << "Cross section in the non excluded region " << WIMPcs << " < " << cs0 << endl;
      chi2 = 0;
    }
  }
  if( check ) chi2 = TMath::Power( ( WIMPcs ) / totalWidth, 2 );

  return chi2;
}





#endif
