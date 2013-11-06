/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RegressionMVA.cpp                                                  *
*                                                                              *
* Description Helper class for RegressionCalculator                            *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>
#include <boost/property_tree/ptree.hpp>

#include "ConfigurationException.h"
#include "RegressionCalculator.h"
#include "RegressionMVA.h"
#include "SimplePrediction.h"

Fittino::RegressionMVA::RegressionMVA( TMVA::Reader& reader, const boost::property_tree::ptree& ptree )
  :_reader( reader ),
   _name( ptree.get<std::string>("WeightFile") ) {

  _reader.BookMVA( _name, _name );

  BOOST_FOREACH(  const boost::property_tree::ptree::value_type& node, ptree ) {
    
    if ( node.first == "Target" ) {
      
      std::string targetName = node.second.get_value<std::string>(); 
      double* doubleTarget   = new double();

      _collectionOfQuantities.AddElement( new SimplePrediction ( targetName , "", *doubleTarget ) );
      _vectorOfDoubleTargets.push_back( doubleTarget );

    }

  }

}

Fittino::RegressionMVA::~RegressionMVA() {


}


const std::string& Fittino::RegressionMVA::GetName() const {

  return _name;

}

void Fittino::RegressionMVA::Update() {

  _vectorOfFloatTargets = _reader.EvaluateRegression( _name );

  if ( _vectorOfFloatTargets.size() != _vectorOfDoubleTargets.size() ) {

    throw ConfigurationException( "Wrong number of targets given." );

  }


  for ( unsigned int i = 0; i < _vectorOfFloatTargets.size(); ++i ) {

    *_vectorOfDoubleTargets.at(i) = _vectorOfFloatTargets.at(i);

  }
  
}


Fittino::Collection<Fittino::PredictionBase*>&  Fittino::RegressionMVA::GetCollectionOfQuantities() {

  return _collectionOfQuantities;

}
