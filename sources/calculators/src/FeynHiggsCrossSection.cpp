/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsCrossSection.cpp                                        *
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

#include "boost/lexical_cast.hpp"

#include "CFeynHiggs.h"

#include "FeynHiggsCrossSection.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsCrossSection::FeynHiggsCrossSection( std::string sqrts )
:CalculatorBase( 0 ),
prodxs( new FHRealType[nprodxs] ),
_h0( prodxs, 1, sqrts ),
_H0( prodxs, 2, sqrts ),
_A0( prodxs, 3, sqrts ){

    _tag = "";

    _sqrts = boost::lexical_cast<double>( sqrts );

    for ( unsigned int iQuantity = 0; iQuantity <_h0.GetCollectionOfQuantities().GetNumberOfElements(); iQuantity++ ) {

        AddQuantity( _h0.GetCollectionOfQuantities().At( iQuantity ) );
        AddQuantity( _H0.GetCollectionOfQuantities().At( iQuantity ) );
        AddQuantity( _A0.GetCollectionOfQuantities().At( iQuantity ) );

    }

    _tag = "CrossSection_" + sqrts + "TeV";

    AddQuantity( new SimplePrediction( "tHm"   , "", _tHm    ) );
    AddQuantity( new SimplePrediction( "tHm2"  , "", _tHm2   ) );
    AddQuantity( new SimplePrediction( "tHm2lo", "", _tHm2lo ) );
    AddQuantity( new SimplePrediction( "tHm2hi", "", _tHm2hi ) );

}

Fittino::FeynHiggsCrossSection::~FeynHiggsCrossSection() {

    
}

void Fittino::FeynHiggsCrossSection::CalculatePredictions() {

    FHHiggsProd( &_error , _sqrts, prodxs );


    if ( _error ) {


    }

    _h0.CalculatePredictions();
    _H0.CalculatePredictions();
    _A0.CalculatePredictions();

    _tHm    = tHm;
    _tHm2   = tHm2;
    _tHm2lo = tHm2lo;
    _tHm2hi = tHm2hi;

}