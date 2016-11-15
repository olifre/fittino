/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHACalculatorBase.cpp                                           *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Factory.h"
#include "SLHACalculatorBase.h"

Fittino::SLHACalculatorBase::SLHACalculatorBase( const ModelBase* model, const boost::property_tree::ptree* ptree  )
    : CalculatorBase( model, ptree ),
      _slhaInputFileName( "" ),
      _slhaOutputFileName( "" ) {

    Factory factory;

    _slhaInputDataStorage  = factory.CreateSLHAeaSLHADataStorage();
    _slhaOutputDataStorage = factory.CreateSLHAeaSLHADataStorage();

}

Fittino::SLHACalculatorBase::~SLHACalculatorBase() {

}
