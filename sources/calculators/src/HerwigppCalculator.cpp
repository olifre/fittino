#include <iostream>
#include <string>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

#include "HerwigppCalculator.h"
#include "Executor.h"

Fittino::HerwigppCalculator::HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  SetName( "HerwigppCalculator" );
  SetTag( "Herwigpp" );

  AddOutput("Total_Xsec", _Total_Xsec);

}

Fittino::HerwigppCalculator::~HerwigppCalculator() {

}

void Fittino::HerwigppCalculator::CalculatePredictions() {

  std::string inputfileRead = "/lustre/user/range/fittino/bin/LHC-MSSM.in";

  Executor executorRead( "/cvmfs/sft.cern.ch/lcg/external/MCGenerators_lcgcmt65a/herwig++/2.7.0/x86_64-slc6-gcc47-opt/bin/Herwig++", "Herwig++ read" );
  executorRead.AddArgument( "read" );
  executorRead.AddArgument( inputfileRead );
  executorRead.Execute();

  std::string inputfileRun = "/lustre/user/range/fittino/bin/LHC-MSSM.run";

  Executor executorRun( "/cvmfs/sft.cern.ch/lcg/external/MCGenerators_lcgcmt65a/herwig++/2.7.0/x86_64-slc6-gcc47-opt/bin/Herwig++", "Herwig++ run" );
  executorRun.AddArgument( "run" );
  executorRun.AddArgument( inputfileRun );
  executorRun.AddArgument( "-N50" );
  executorRun.AddArgument( "-d1" );
  executorRun.Execute();

  std::fstream file;
  std::string line;

  file.open( "/lustre/user/range/fittino/bin/LHC-MSSM.out" ); 
  while( getline( file, line ) ){

    typedef std::vector< std::string > split_vector_type;
      
      split_vector_type SplitVec;
      split( SplitVec, line, boost::is_any_of(" "), boost::token_compress_on);

      if( SplitVec.size() > 5 ){
	if ( SplitVec[0] == "Total" ){
	  if( SplitVec[2] == "unweighted" ){
	    
	    std::string Total_Xsec = SplitVec[6]; 
	    split_vector_type SplitVecNumber;
	    split( SplitVecNumber, Total_Xsec, boost::is_any_of("()"), boost::token_compress_on);
	    std::string number1 = SplitVecNumber[0];
	    std::string number3 = SplitVecNumber[2];
	    std::string total_xsec = number1 + number3;  
	    _Total_Xsec = boost::lexical_cast<double>(total_xsec);
	    std::cout << "Total crossection: " << _Total_Xsec << std::endl;
	    
	  }
	}
      }
  }

    

  file.close();

}

void Fittino::HerwigppCalculator::Initialize(){

}
