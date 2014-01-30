/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHAModelCalculator.h                                   *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSSLHAMODELCALCULATOR_H
#define FITTINO_FEYNHIGGSSLHAMODELCALCULATOR_H

#include "FeynHiggsModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsSLHAModelCalculator : public FeynHiggsModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    FeynHiggsSLHAModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
     ~FeynHiggsSLHAModelCalculator();

      /*! \cond UML */
    private:
      void         CalculatePredictions();

      /*! \endcond UML */

  };

}

#endif
