#include "postProcessing.h" 
#include "cleaning.h"


// =====================================
// Arguments:
// argv[1]: name of the fit
// argv[2]: input directory
// argv[3]: output directory
// argv[4]: histogram file for LHC chi2
// argv[5]: signal file for LHC chi2

int main( int argc, char** argv ){


  // == Removal of multiple points
  cleaningInputFile( argv[1], argv[2], argv[3] );


  // == Initialization of all variables, fit, model, options
  initialize( argv[1], argv[2], argv[3], argv[4], argv[5] );


  // Prepar input and output files
  openIOfiles( fit );


  // == Get experimental values
  assignLEObs();


  // == Run toys (0) or process real data (1)
  int PP_or_Toys = atoi( getenv( "DATATOYS" ) );
  processData( PP_or_Toys );


  // == Write all histograms and trees and close files
  writeAndClose( PP_or_Toys );


  return 0;
}


