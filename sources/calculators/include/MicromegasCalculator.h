/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MicromegasCalculator.h                                           *
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

#ifndef FITTINO_MICROMEGASCALCULATOR_H
#define FITTINO_MICROMEGASCALCULATOR_H

#include "CalculatorBase.h"
#include "MicromegasWrapper.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for Micromegas.
   */
  class MicromegasCalculator : public MicromegasWrapper, public CalculatorBase {

    public:
      MicromegasCalculator(const ModelBase *model, boost::property_tree::ptree &ptree);
      ~MicromegasCalculator();
      void CalculatePredictions();

  };

}

#endif // FITTINO_MICROMEGASCALCULATOR_H
