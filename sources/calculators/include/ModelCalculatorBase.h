/* $Id: ModelCalculatorBase.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorBase.h                                            *
*                                                                              *
* Description Base class for model calculators                                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELCALCULATORBASE_H
#define FITTINO_MODELCALCULATORBASE_H

#include "TString.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PhysicsModelBase;

  /*!
   *  \defgroup calculators
   */
  /*!
   *  \ingroup calculators
   *  \brief Base class for model calculators.
   */
  class ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   ModelCalculatorBase();
      /*!
       *  Standard destructor.
       */
                   ~ModelCalculatorBase();
      std::string  GetName() const;

    public:
      virtual void CalculatePredictions( PhysicsModelBase* model ) = 0;
      virtual void Initialize() = 0;

    protected:
      enum         CallMethod { EXECUTABLE, FUNCTION };

    protected:
      std::string  _name;
      TString      _executableName;
      CallMethod   _callMethod;

    protected:
      virtual void CallExecutable() = 0;
      virtual void CallFunction( PhysicsModelBase* model ) = 0;
      virtual void ConfigureInput( PhysicsModelBase* model ) = 0;

  };

}

#endif // FITTINO_MODELCALCULATORBASE_H
