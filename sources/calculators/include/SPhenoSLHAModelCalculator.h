/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHAModelCalculator.h                                      *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SPHENOSLHAMODELCALCULATOR_H
#define FITTINO_SPHENOSLHAMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for SPheno.
   */
  class SPhenoSLHAModelCalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   SPhenoSLHAModelCalculator( const PhysicsModelBase* model );
      /*!
       *  Standard destructor.
       */
                   ~SPhenoSLHAModelCalculator();

    public:
      virtual void Initialize() const;

      /*! \cond UML */
    private:
    /*!
     *  \todo Short-term: The method CallExecutable() is copied from the old fittino code. It should\n
     *  be eventually replaced.
     */
      virtual void CallExecutable();
      virtual void CallFunction();
      virtual void ConfigureInput();

      /*! \endcond UML */

  };

}

#endif // FITTINO_SPHENOSLHAMODELCALCULATOR_H
