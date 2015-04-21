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

  double XSect;
  double XSectErr;

  std::ofstream myfile;
  myfile.open("Parameter.txt");
    myfile << "##General Options\n";
    myfile << "[Manodatory Parameters]\n";
    myfile << "Name: Last_Run\n";
    myfile << "Analyses: atlas_conf_2013_047\n";
    myfile << "\n";
    myfile << "[Optional Parameters]";
    myfile << "\n";
    myfile << "## Process Information\n";
    myfile << "XSect: \n";
    myfile << "XSectErr: \n";
    myfile << "Events: LHC-MSSM.hepmc\n";
  myfile.close();
  
  //std::string inputfile = "/lustre/user/range/fittino/bin/Parameter.txt";

  //Executor executor("./CheckMATE","CheckMATE");
  //executor.AddArgument(inputfile);

  //executor.Execute();

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
