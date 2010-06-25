/* $Id: OptimizerFactory.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        OptimizerFactory.cpp                                             *
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

#include "MinuitOptimizer.h"
#include "OptimizerFactory.h"
#include "ParticleSwarmOptimizer.h"

Fittino::OptimizerFactory::OptimizerFactory() {

}

Fittino::OptimizerBase* const Fittino::OptimizerFactory::CreateOptimizer( const Fittino::OptimizerBase::OptimizerType& optimizerType, Fittino::ModelBase* model ) const {

    switch ( optimizerType ) {

        case Fittino::OptimizerBase::MINUITOPTIMIZER:
            return new MinuitOptimizer( model );

        case Fittino::OptimizerBase::PARTICLESWARMOPTIMIZER:
            return new ParticleSwarmOptimizer( model );

    }

}

Fittino::OptimizerFactory::~OptimizerFactory() {

}
