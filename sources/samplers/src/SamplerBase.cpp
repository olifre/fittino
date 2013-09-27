/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SamplerBase.cpp                                                  *
*                                                                              *
* Description Base class for Fittino parameter samplers                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Messenger.h"
#include "SamplerBase.h"

Fittino::SamplerBase::SamplerBase( ModelBase* model, int randomSeed )
    : AnalysisTool( model, randomSeed ) {

}

Fittino::SamplerBase::~SamplerBase() {

}

void Fittino::SamplerBase::PrintResult() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;

}
