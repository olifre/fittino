/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        MicromegasWrapper.h                                              *
 *                                                                              *
 * Description Wrapper class for Micromegas                                     *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/


#ifndef FITTINO_MICROMEGASWRAPPER_H
#define FITTINO_MICROMEGASWRAPPER_H

#include "CalculatorBase.h"

namespace Fittino {

    class MicromegasWrapper: public CalculatorBase {

    public:

        MicromegasWrapper( const PhysicsModel* model );
        ~MicromegasWrapper();
        void CalculatePredictions();

    };

}

#endif
