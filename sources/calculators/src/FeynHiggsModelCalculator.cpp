/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculator.cpp                                     *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <fstream>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>
#include "boost/format.hpp"
#include <boost/filesystem.hpp>

#include "TMath.h"

#include "CFeynHiggs.h"
#include "CSLHA.h"

#include "FeynHiggsModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsModelCalculator::FeynHiggsModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree )
  : FeynHiggsModelCalculatorBase( model, ptree ) {


    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {
    
      if( node.first == "Parameter" ) {

        std::string name     = node.second.get<std::string>( "Name"     );
        std::string quantity = node.second.get<std::string>( "Quantity" );

        const double& value = _model->GetCollectionOfQuantities().At( quantity )->GetValue();
        // std::string   unit  = _model->GetCollectionOfQuantities().At( quantity )->GetUnit(); Quantity does not yet have a unit

        _input.AddElement( new SimplePrediction( name, "" , value ) ) ;

      }

    }
    

}

Fittino::FeynHiggsModelCalculator::~FeynHiggsModelCalculator() {

}

void Fittino::FeynHiggsModelCalculator::ConfigureInput() {

    std::string fileName = "FeynHiggs.in";

    if ( boost::filesystem::exists( fileName ) ) {

        boost::filesystem::rename( fileName, fileName + ".last" );

    }
   
    std::ofstream file( fileName.c_str() );

    for ( int i = 0; i < _input.GetNumberOfElements(); i++ ) {

        file<<boost::format( "%-25s % 25.16e\n" ) % _input.At( i )->GetName() % _input.At( i )->GetValue();

    }

    file.close();
    
    int         fast = 0;
    double      sqrts = 8;
    ComplexType SAeff;
    ComplexType UHiggs     [3][3];
    ComplexType ZHiggs     [3][3];
    ComplexType couplings  [ncouplings];
    ComplexType couplingsms[ncouplingsms];
    RealType    MHiggs     [4];
    RealType    gammas     [ngammas];
    RealType    gammasms   [ngammasms];
    RealType    record     [nrecord];
    RealType    prodxs     [nprodxs];
    COMPLEX     slhadata   [nslhadata];

    FHReadRecord( &_error, record, slhadata, fileName.c_str() ); 

    if ( _error != 2 ) {
      
    }

}

 
  


void Fittino::FeynHiggsModelCalculator::Initialize() const {

}


