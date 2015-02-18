/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        UncertaintyBase.cpp                                              *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "AstroExclusion.h"
#include "Quantity.h"
#include <boost/property_tree/ptree.hpp>
#include <cstddef>
#include "TGraph.h"
#include "TMath.h"
#include "ModelBase.h"

Fittino::AstroExclusion::AstroExclusion(ModelBase const *model, const Measurement *observable, const boost::property_tree::ptree &ptree)
: UncertaintyBase(model, observable, ptree) {


    std::string fileName = ptree.get<std::string>( "File" );
    _graph = new TGraph( fileName.c_str() );

    std::string massName = ptree.get<std::string>( "WimpMass" );
    _mass = model->GetCollectionOfQuantities().At( massName );


    double confidenceLevel = ptree.get<double>( "ConfidenceLevel" );
    _quantile = TMath::NormQuantile( confidenceLevel );
    // _quantile = TMath::Sqrt( 1.64 ); this reproduces the former result

    Update();

}

Fittino::AstroExclusion::~AstroExclusion() {

    delete _graph;

}

void Fittino::AstroExclusion::Update() {

    _value = _graph->Eval( _mass->GetValue() ) / _quantile;

}
