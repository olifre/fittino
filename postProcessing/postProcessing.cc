#include "postProcessing.h" 
#include "cleaning.h"


// =====================================
// Arguments:
// argv[1]: name of the fit
// argv[2]: input directory
// argv[3]: output directory

int main( int argc, char** argv ){

  // == Convert arguments
  // Data post-processing (1) or toy study (0)
  int PP_or_Toys = atoi( getenv( "DATATOYS" ) );
  // Removal of multiple points (1) or of buggy points (2)
  int step = atoi( getenv("STEP") );


  // == Initialization of all variables, fit, model, options
  initialize( argv[1], argv[2], argv[3], PP_or_Toys );


  // =======================================================
  // == 1st step of post-processing: calculation of the chi2
  if( step == 1 )
    {
      
      // == Removal of multiple points, not for toys
      if( PP_or_Toys == 1 ) cleaningInputFile( "multiplePointsRemoval", argv[1], argv[2], argv[3] );
      
      
      // Prepar input and output files
      openIOfiles( PP_or_Toys, fit );
      
      
      // == Get experimental values
      assignLEObs();
      
      
      // == Run toys (0) or process real data (1)
      processData( PP_or_Toys );
      
      
      // == Write all histograms and trees and close files
      writeAndClose( PP_or_Toys );
    }


 // =======================================================
  // == 2nd step of post-processing: all fits are merged 
  // (allObs, HiggsObs, noObs, point1, point2), buggy points
  // are cut out and the best fit point is identified and saved in a text file
  if( step == 2 )
    {
      cleaningInputFile( "buggyPointsRemoval", argv[1], argv[2], argv[3] );
    }

  return 0;
}


