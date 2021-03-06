/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCChi2Calculator.h                                            *
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

#ifndef FITTINO_LHCCHI2CALCULATOR_H
#define FITTINO_LHCCHI2CALCULATOR_H

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
  class LHCChi2Calculator : public LinearInterpolationCalculatorBase {

    public:

                           LHCChi2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
                           ~LHCChi2Calculator();
  };

}

#endif
