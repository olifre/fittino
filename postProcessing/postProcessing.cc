#include "postProcessing.h" 

int main( int argc, char** argv ){


  // == Initialization of all variables, fit, model, options
  initialize( argv[1], argv[2], argv[3] );


  // Prepar input and output files
  openIOfiles( fit );


  // == Get experimental values
  assignLEObs();


  // == Calculate chi2 of each point
  calculateChi2();


  // == Get best fit point
  bestFitPoint();


  // == Run toys and get minimal chi2 for each  
  simulateToys();


  // == Write all histograms and trees and close files
  writeAndClose();
  
  return 0;
}


