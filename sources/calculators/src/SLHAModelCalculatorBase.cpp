/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAModelCalculatorBase.cpp                                      *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Factory.h"
#include "SLHAModelCalculatorBase.h"
#include "SLHAeaSLHADataStorage.h"

Fittino::SLHAModelCalculatorBase::SLHAModelCalculatorBase( const PhysicsModelBase* model )
        : ModelCalculatorBase( model ),
          _slhaInputFileName( "" ),
          _slhaOutputFileName( "" ),
          _slhaInputDataStorage( 0 ),
          _slhaOutputDataStorage( 0 ) {

    Factory factory;
    _slhaInputDataStorage  = factory.CreateSLHAeaSLHADataStorage();
    _slhaOutputDataStorage = factory.CreateSLHAeaSLHADataStorage();

}

Fittino::SLHAModelCalculatorBase::~SLHAModelCalculatorBase() {

}

std::string Fittino::SLHAModelCalculatorBase::String( double x ) {

    std::stringstream tmpStream_x;
    std::string tmpString_x;

    tmpStream_x << x;
    tmpStream_x >> tmpString_x;

    return tmpString_x;

}

void Fittino::SLHAModelCalculatorBase::CalculatePredictions() {

    ConfigureInput();

    switch ( _callMethod ) {

        case EXECUTABLE: {

            _slhaInputDataStorage->WriteFile( _slhaInputFileName );
            CallExecutable();
            _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );
	    break;

        }

        case FUNCTION: {

            CallFunction();
            _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );
	    break;

        }

    }

}

Fittino::SLHADataStorageBase* Fittino::SLHAModelCalculatorBase::GetDataStorage() {

    return _slhaOutputDataStorage;

}
