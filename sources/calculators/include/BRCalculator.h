/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        BRCalculator.h                                                   *
*                                                                              *
* Description Calculates branching ratios from partial widths                  *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_BRCALCULATOR_H
#define FITTINO_BRCALCULATOR_H

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \ingroup calculators
   *  \brief Calculates branching ratios from partial widths
   */
  class BRCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    BRCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual      ~BRCalculator();

    public:
      virtual void CalculatePredictions();

     private:
      double _GammaTotal;
      std::vector<std::string> _channels;


  };

}

#endif
