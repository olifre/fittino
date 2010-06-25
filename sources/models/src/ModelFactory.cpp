/* $Id: ModelFactory.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelFactory.cpp                                                 *
*                                                                              *
* Description Factory class for models                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "ModelFactory.h"
#include "RosenbrockModel.h"

Fittino::ModelFactory::ModelFactory() {

}

Fittino::ModelBase* const Fittino::ModelFactory::CreateModel( const Fittino::ModelBase::ModelType& modelType ) const {

    switch ( modelType ) {

        case Fittino::ModelBase::ROSENBROCKMODEL:
            return new RosenbrockModel();

    }

}

Fittino::ModelFactory::~ModelFactory() {

}
