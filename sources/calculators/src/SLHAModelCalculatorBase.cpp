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

#include "SLHAModelCalculatorBase.h"
#include "SLHAeaSLHADataStorage.h"

Fittino::SLHAModelCalculatorBase::SLHAModelCalculatorBase()
        : _slhaInputFileName( "" ),
          _slhaOutputFileName( "" ),
          _slhaInputDataStorage( new SLHAeaSLHADataStorage() ),
          _slhaOutputDataStorage( new SLHAeaSLHADataStorage() ) {

}

Fittino::SLHAModelCalculatorBase::~SLHAModelCalculatorBase() {

}

void Fittino::SLHAModelCalculatorBase::CalculatePredictions( Fittino::PhysicsModelBase* model ) {

    ConfigureInput( model );

    switch ( _callMethod ) {

        case EXECUTABLE: {

            _slhaInputDataStorage->WriteFile( _slhaInputFileName );
            CallExecutable();
            _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );
	    break;

        }

        case FUNCTION: {

            CallFunction( model );
            _slhaOutputDataStorage->ReadFile( _slhaOutputFileName );
	    break;

        }

    }

}

Fittino::SLHADataStorageBase* Fittino::SLHAModelCalculatorBase::GetDataStorage() {

    return _slhaOutputDataStorage;

}
