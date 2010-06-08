/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.cpp                                              *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Configuration.h"
#include "RosenbrockModel.h"

Fittino::RosenbrockModel::RosenbrockModel()
        : _x ( 0. ),
          _y ( 0. ) {

    Configuration* configuration = Configuration::GetInstance();

    _x = configuration->GetSteeringParameter( "X", 0. );
    _y = configuration->GetSteeringParameter( "Y", 0. );

}

Fittino::RosenbrockModel::~RosenbrockModel() {

}
