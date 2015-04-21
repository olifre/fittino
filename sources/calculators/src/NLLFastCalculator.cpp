#include <iostream>
#include <string>

#include "NLLFastCalculator.h"
#include "Executor.h"


Fittino::NLLFastCalculator::NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  SetName( "NLLFastCalculator" );
  SetTag( "NLLFast" );

}

Fittino::NLLFastCalculator::~NLLFastCalculator() {

}

void Fittino::NLLFastCalculator::CalculatePredictions() {

}

void Fittino::NLLFastCalculator::Initialize() {

}
