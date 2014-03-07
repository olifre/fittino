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

#include <string>

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for Micromegas.
   */
  class MicromegasWrapper: public CalculatorBase {

    public:
      MicromegasWrapper( const PhysicsModel* model );
      void        CalculatePredictions();

    public:
      virtual     ~MicromegasWrapper();

    protected:
      double      _omegah2;
      std::string _inputFile;

  };

}

#endif // FITTINO_MICROMEGASWRAPPER_H
