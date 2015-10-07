/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GM2CalcCalculator.h                                              *
*                                                                              *
* Description Wrapper class for GM2Calc                                        *
*                                                                              *
* Authors     Bjoern Sarrazin                                                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_GM2CALCCALCULATOR_H
#define FITTINO_GM2CALCCALCULATOR_H

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for GM2Calc.
   */
  class GM2CalcCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      GM2CalcCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~GM2CalcCalculator();

    public:
      virtual void CalculatePredictions();

  };

}

#endif
