/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculator.cpp                                          *
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

#include "FeynHiggsCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsCalculator::FeynHiggsCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
  : FeynHiggsCalculatorBase( model, ptree ) {

    _fileName = "FeynHiggs.in";

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {
    
      if( node.first == "Parameter" ) {

        std::string name     = node.second.get<std::string>( "Name"     );
        std::string quantity = node.second.get<std::string>( "Quantity" );

        const double& value = _model->GetCollectionOfQuantities().At( quantity )->GetValue();

        _input.AddElement( new SimplePrediction( name, "" , value ) ) ;

      }

    }

}

Fittino::FeynHiggsCalculator::~FeynHiggsCalculator() {

}

void Fittino::FeynHiggsCalculator::CalculatePredictions() {

    if ( boost::filesystem::exists( _fileName ) ) {

        boost::filesystem::rename( _fileName, _fileName + ".last" );

    }
   
    std::ofstream file( _fileName.c_str() );

    for ( int i = 0; i < _input.GetNumberOfElements(); i++ ) {

        file<<boost::format( "%-25s % 25.16e\n" ) % _input.At( i )->GetName() % _input.At( i )->GetValue();

    }

    file.close();

    SetFlags();

    RealType    record     [nrecord];
    COMPLEX     slhadata   [nslhadata];
    FHReadRecord( &_error, record, slhadata, _fileName.c_str() ); 

    if ( _error != 2 ) {
      
    }

    FHLoopRecord( &_error, record );

    if ( _error != 0 ) {

    }

    FHSetRecord ( &_error, record );

    if ( _error != 0 ) {

    }

    Calculate();

    FHLoopRecord( &_error, record );

    if ( _error != -1 ) {
      
    }

}

