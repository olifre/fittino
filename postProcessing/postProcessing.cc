#include "postProcessing.h" 

int main( int argc, char** argv ){

  // == Initialization of all variables, fit, model, options
  initialize( argv[1], argv[2], argv[3], argv[4], argv[5] );


  // Prepar input and output files
  openIOfiles( fit );


  // == Get experimental values
  assignLEObs();


  // == Get best fit point
  bestFitPoint();


  // == Run toys (0) or process real data (1)
  int realFit = atoi( argv[6] );
  processData( realFit );
  //plot_af_chi2();

  // == Write all histograms and trees and close files
  writeAndClose( realFit );
  
  return 0;
}


