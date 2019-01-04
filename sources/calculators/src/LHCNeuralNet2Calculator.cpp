#define BOOST_NO_CXX11_SCOPED_ENUMS


#include <boost/filesystem.hpp>
#include "LHCNeuralNet2Calculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "ModelParameter.h"
#include <string>
#include <iostream>
#include <fstream>

Fittino::LHCNeuralNet2Calculator::LHCNeuralNet2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ),
    _scynet (ptree.get<std::string>("scynet_script")), 
    _scynet_out (ptree.get<std::string>("scynet_out")) 
{
    
    SetName( "SCYNet2" );
    
    AddOutput( "Chi2" );

    AddInput( "M1"  );
    AddInput( "M2"  );
    AddInput( "M3"  );
    AddInput( "MQ1" );
    AddInput( "MQ3" );
    AddInput( "ML1" );
    AddInput( "ML3" );
    AddInput( "MA0" );
    AddInput( "Mu" );
    AddInput( "TanBeta" );
    AddInput( "A" );

}

Fittino::LHCNeuralNet2Calculator::~LHCNeuralNet2Calculator() {


}

void Fittino::LHCNeuralNet2Calculator::CalculatePredictions() {

   UpdateInput();

   // Read in input parameters

     std::vector<double> parpoints;
     parpoints.push_back(GetInput( "M1" )) ;
     parpoints.push_back(GetInput( "M2" )) ;
     parpoints.push_back(GetInput( "M3" )) ;
     parpoints.push_back(GetInput( "MQ1" )) ;
     parpoints.push_back(GetInput( "MQ3" )) ;
     parpoints.push_back(GetInput( "ML1" )) ;
     parpoints.push_back(GetInput( "ML3" )) ;
     parpoints.push_back(GetInput( "MA0" )) ;
     parpoints.push_back(GetInput( "A" )) ;
     parpoints.push_back(GetInput( "Mu" )) ;
     parpoints.push_back(GetInput( "TanBeta" )) ;
    
   // Make strings out of input parameters 
   
   std::string parpoint_1;
   std::string parpoint_2;
   std::string parpoint_3;
   std::string parpoint_4;
   std::string parpoint_5;
   std::string parpoint_6;
   std::string parpoint_7;
   std::string parpoint_8;
   std::string parpoint_9;
   std::string parpoint_10;
   std::string parpoint_11;
   parpoint_1 = std::to_string(parpoints[0]);
   parpoint_2 = std::to_string(parpoints[1]);
   parpoint_3 = std::to_string(parpoints[2]);
   parpoint_4 = std::to_string(parpoints[3]);
   parpoint_5 = std::to_string(parpoints[4]);
   parpoint_6 = std::to_string(parpoints[5]);
   parpoint_7 = std::to_string(parpoints[6]);
   parpoint_8 = std::to_string(parpoints[7]);
   parpoint_9 = std::to_string(parpoints[8]);
   parpoint_10 = std::to_string(parpoints[10]);
   parpoint_11 = std::to_string(parpoints[11]);
   
   // external python script calling the net is used
   
   std::string execute;
   execute = "python -c \"from scynet import SCYNet as bla; print bla.main([[" + parpoint_1 + "," + parpoint_2 + "," + parpoint_3 + "," + parpoint_4 + "," + parpoint_5 + "," + parpoint_6 + "," + parpoint_7 + "," + parpoint_8 + "," + parpoint_9 + "," + parpoint_10 + ","+ parpoint_11 +"]])\" ";
    const char *python = execute.c_str();
    std::cout << execute ;
    std::system(python);
 
   // Check if scynet worked and produced an output and read in output

   if (!boost::filesystem::exists (_scynet_out)){
        throw CalculatorException(_name, "SCYNet_Error");}
   else{
   double bla;
   double chi_2;
   std::string line;
   std::ifstream infile(_scynet_out) ;
   std::cout << "Hallo";
   while(std::getline(infile, line)){
      std::cout << "Test";
      if(line.empty()) break;

     std::istringstream ss(line);
     ss >> bla>> bla>> bla>> bla>> bla>> bla>> bla>> bla>> bla>> bla>> bla >> chi_2;
   }
   infile.close(); 
   // Set ScyNet_Chi2
   SetOutput("Chi2", chi_2); }


}
