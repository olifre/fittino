#include "postProcessing.h" 
#include "cleaning.h"


// =====================================
// Arguments:
// argv[1]: name of the fit
// argv[2]: input directory
// argv[3]: output directory

int main( int argc, char** argv ){


  // == Process
  // 1=post-processing
  // 0=toy study
  // 2=toy test
  int PP_or_Toys = atoi( getenv( "DATATOYS" ) );


  // 1=Removal of multiple points (calculation of chi2 for the nominal fit ot the toy)
  // 2=Removal of buggy points
  // 3=Identification of the best fit point
  int step = atoi( getenv("STEP") );


  // == Initialization of all variables, fit, model, options
  initialize( argv[1], argv[2], argv[3], PP_or_Toys, step );


  // =======================================================
  // == Test of the toy
  if( PP_or_Toys == 2 ){
    openIOfiles( PP_or_Toys, fit );
    assignLEObs();
    testToy();
    writeAndClose( PP_or_Toys );
    return 0;
  }

  
 // =======================================================
  // == preliminary step: removal of multiple points, not for toys
  if( step == 0 ) cleaningInputFile( "multiplePointsRemoval", argv[1], argv[2], argv[3] );


  // =======================================================
  // == 1st step of post-processing: calculation of the chi2
  if( step == 1 )
    {         
      
      // Prepar input and output files
      openIOfiles( PP_or_Toys, fit );
      
      
      // == Get experimental values
      assignLEObs();
      
      
      // == Calculate the chi2
      processData( PP_or_Toys );
      
      
      // == Write all histograms and trees and close files
      writeAndClose( PP_or_Toys );

      // == For toys, rough identification of the lowest chi2 point
      if( PP_or_Toys == 0 ) skimToyTrees( fit );
    }


 // =======================================================
  // == Removal of buggy points
  if( step == 2 ) cleaningInputFile( "buggyPointsRemoval", argv[1], argv[2], argv[3] ); 
    

 // =======================================================
  // == Identification of the best fit point
  if( step == 3 ) saveBestFitPoint( PP_or_Toys );    
  //if( step == 3 ) skimToyTrees( fit );


  return 0;
}


