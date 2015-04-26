#include <fstream>
#include <iostream>
#include <string>

#include "HepMCSplitCalculator.h"

Fittino::HepMCSplitCalculator::HepMCSplitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  SetName( "HepMCSplitCalculator" );
  SetTag( "HepMCSplit" );

}

Fittino::HepMCSplitCalculator::~HepMCSplitCalculator() {

}

void Fittino::HepMCSplitCalculator::CalculatePredictions() {

}

void Fittino::HepMCSplitCalculator::Initialize() {

}
