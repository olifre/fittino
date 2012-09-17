/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FittinoFileHandlerBase.h                                         *
*                                                                              *
* Description Base class for reading and interpreting Fittino input files      *
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

#include "InputException.h"
#include "FittinoFileHandlerBase.h"

Fittino::FittinoFileHandlerBase::FittinoFileHandlerBase() {

}

Fittino::FittinoFileHandlerBase::~FittinoFileHandlerBase() {

}

void Fittino::FittinoFileHandlerBase::WriteFile( const TString& outputFileName ) const {

    throw InputException( "Writing of Fittino files is not impelemented yet." );

}
