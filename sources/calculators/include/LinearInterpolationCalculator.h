/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LinearInterpolationCalculator.h                                  *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LINEARINTERPOLATIONCALCULATOR_H
#define FITTINO_LINEARINTERPOLATIONCALCULATOR_H

#include <vector>

#include "THnSparse.h"

#include "LinearInterpolationCalculatorBase.h"

class TH1D;
/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Quantity;

    /*!
   *  \ingroup calculators
   *  \brief
   */
  class LinearInterpolationCalculator : public LinearInterpolationCalculatorBase {

    public:

                           LinearInterpolationCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
                           ~LinearInterpolationCalculator();

  };

}

#endif
