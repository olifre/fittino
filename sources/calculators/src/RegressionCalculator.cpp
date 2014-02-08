/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RegressionCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for TMVA::Reader::EvaluateRegression()             *
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

#include "PhysicsModel.h"
#include "RegressionCalculator.h"
#include "RegressionMVA.h"

Fittino::RegressionCalculator::RegressionCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree  )
  :CalculatorBase( model ),
   _reader ( "!Color:!Silent" ) {

  _name = ptree.get<std::string>("name");

   BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

     if ( node.first == "Variable" ) {

       std::string name             = node.second.get<std::string>("Name"            );
       std::string nameInWeightFile = node.second.get<std::string>("NameInWeightFiles");
       
       const double* doubleVariable = &_model->GetCollectionOfQuantities().At( name )->GetValue();
       float*        floatVariable  = new float();

       _vectorOfDoubleVariables.push_back( doubleVariable );
       _vectorOfFloatVariables .push_back( floatVariable  );
       
       _reader.AddVariable( nameInWeightFile, floatVariable );
       
     }
     else if ( node.first == "MVA" ) {

       RegressionMVA* mva = new RegressionMVA( _reader, node.second );

       Collection< PredictionBase*>& col = mva->GetCollectionOfQuantities();

       for ( unsigned int i = 0; i < col.GetNumberOfElements(); ++i ) {

         AddQuantity( col.At( i ) );
         
       }

       _collectionOfMVAs.AddElement( mva ); 

     }

   }

}
   
Fittino::RegressionCalculator::~RegressionCalculator() {

} 

void Fittino::RegressionCalculator::CalculatePredictions() {

  for ( unsigned int i = 0; i < _vectorOfFloatVariables.size(); ++i ) {

    *_vectorOfFloatVariables.at( i ) = *_vectorOfDoubleVariables.at( i );

  }

  for ( unsigned int i = 0; i < _collectionOfMVAs.GetNumberOfElements(); ++i ) {

    _collectionOfMVAs.At( i )->Update();

  }

}

void Fittino::RegressionCalculator::Initialize() const {

}

