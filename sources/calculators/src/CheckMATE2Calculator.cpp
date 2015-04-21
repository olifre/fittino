#include <iostream>
#include <boost/property_tree/ptree.hpp>
#include <fstream>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#include "Executor.h"
#include "SimplePrediction.h"
#include "CheckMATE2Calculator.h"

Fittino::CheckMATE2Calculator::CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase( model, &ptree ) {

  SetName( "CheckMATE2Calculator" );
  SetTag( "CheckMATE2" );


  AddQuantity(new SimplePrediction( "r", "", _r));

}

Fittino::CheckMATE2Calculator::~CheckMATE2Calculator() {

} 

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

  std::string inputfile = "/lustre/user/range/fittino/bin/LHC-MSSM.hepmc";
 
  Executor executor("/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.1.16/bin/CheckMATE","CheckMATE");
  executor.AddArgument( "-n" );
  executor.AddArgument( "/lustre/user/range/fittino/bin/New_Run" );
  executor.AddArgument( "-a" );
  executor.AddArgument( "atlas_conf_2013_047" );
  executor.AddArgument( "-p" );
  executor.AddArgument( "gluinogluino" );
  executor.AddArgument( "-xs" );
  executor.AddArgument( "3.53*FB" );
  executor.AddArgument( "-xse" );
  executor.AddArgument( "1e-5*PB" );
  executor.AddArgument( inputfile );
  executor.Execute();

  // std::ifstream file;
  //std::string line;

  //file.open("evaluation/best_signal_regions.txt");
  
  //while(getline(file, line)) {

  //typedef std::vector< std::string> split_vector_type;
    
    //split_vector_type SplitVec;
    //split( SplitVec, line, boost::is_any_of(" "), boost::token_compress_on);

    //}

  // file.close();


}

void Fittino::CheckMATE2Calculator::SetupMeasuredValues() {

}

void Fittino::CheckMATE2Calculator::Initialize() {

}
