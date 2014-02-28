/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHACalculator.h                                        *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSSLHACALCULATOR_H
#define FITTINO_FEYNHIGGSSLHACALCULATOR_H

#include "FeynHiggsCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsSLHACalculator : public FeynHiggsCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    FeynHiggsSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
     ~FeynHiggsSLHACalculator();

      /*! \cond UML */
    private:
      void         ConfigureInput();

      /*! \endcond UML */

  };

}

#endif
