/* $Id: InputFileInterpreterFactory.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        InputFileInterpreterFactory.cpp                                  *
*                                                                              *
* Description Factory class for input file interpreters                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "InputFileInterpreterFactory.h"
#include "FittinoInputFileInterpreter.h"
#include "XMLInputFileInterpreter.h"

Fittino::InputFileInterpreterFactory::InputFileInterpreterFactory() {

}

const Fittino::InputFileInterpreterBase* const Fittino::InputFileInterpreterFactory::CreateInputFileInterpreter( const Fittino::InputFileInterpreterBase::InputFileFormat& inputFileFormat ) const {

    switch ( inputFileFormat ) {

        case Fittino::InputFileInterpreterBase::XMLINPUTFILE:
            return new XMLInputFileInterpreter();

        case Fittino::InputFileInterpreterBase::FITTINOINPUTFILE:
            return new FittinoInputFileInterpreter();

    }

}

Fittino::InputFileInterpreterFactory::~InputFileInterpreterFactory() {

}
