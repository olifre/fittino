/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoInputFileInterpreter.cpp                                  *
*                                                                              *
* Description Class for reading and interpreting Fittino input files           *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "FittinoInputFileInterpreter.h"
#include "InputException.h"

Fittino::FittinoInputFileInterpreter::FittinoInputFileInterpreter() {

}

Fittino::FittinoInputFileInterpreter::~FittinoInputFileInterpreter() {

}

void Fittino::FittinoInputFileInterpreter::Parse( const TString& fittinoInputFileName ) const {

    throw InputException( "Fittino input files not supported yet" );

}
