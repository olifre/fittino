/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleDoubleCut.cpp                                              *
*                                                                              *
* Description Base class for cuts                                              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TFile.h"
#include "TSpline.h"
#include "TDirectory.h"

#include "SimpleDoubleCut.h"

Fittino::SimpleDoubleCut::SimpleDoubleCut( ModelBase* model, const boost::property_tree::ptree& ptree ) 
    : CutBase( ptree ),
      _testValue    ( model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Quantity" ) )->GetValue() ) {
      
    _lowerBound                   = ptree.get<double>     ( "LowerBound", model->GetCollectionOfQuantities().At( ptree.get<std::string>("Quantity"))->GetLowerBound() );
    _upperBound                   = ptree.get<double>     ( "UpperBound", model->GetCollectionOfQuantities().At( ptree.get<std::string>("Quantity"))->GetUpperBound() );

}

Fittino::SimpleDoubleCut::~SimpleDoubleCut() {

}

bool Fittino::SimpleDoubleCut::IsPassed() {
    
    if( _testValue < _lowerBound ) return false;
    if( _testValue > _upperBound ) return false;
    return true;

}
