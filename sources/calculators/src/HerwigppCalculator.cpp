#include <iostream>
#include <string>

#include "HerwigppCalculator.h"
#include "Executor.h"

Fittino::HerwigppCalculator::HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  SetName( "HerwigppCalculator" );
  SetTag( "Herwigpp" );

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

}

void Fittino::HerwigppCalculator::Initialize(){

}
