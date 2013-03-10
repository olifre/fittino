/* $Id: SLHAModelCalculatorBase.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAModelCalculatorBase.h                                        *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAMODELCALCULATORBASE_H
#define FITTINO_SLHAMODELCALCULATORBASE_H

#include "TString.h"

#include "ModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHADataStorageBase;

  /*!
   *  \ingroup calculators
   *  \brief Base class for SLHA compatible model calculators.
   */
  /*!
   *  \todo Short-term: The method CallExecutable() is copied from the old fittino code. It should\n
   *  be eventually replaced.
   */
  class SLHAModelCalculatorBase : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                           SLHAModelCalculatorBase();
      /*!
       *  Standard destructor.
       */
                           ~SLHAModelCalculatorBase();
      virtual void         CalculatePredictions( PhysicsModelBase* model );
      SLHADataStorageBase* GetDataStorage();

    protected:
      TString              _slhaInputFileName;
      TString              _slhaOutputFileName;
      SLHADataStorageBase* _slhaInputDataStorage;
      SLHADataStorageBase* _slhaOutputDataStorage;

    protected:
      virtual void         CallExecutable();
      virtual void         CallFunction();

  };

}

#endif // FITTINO_SLHAMODELCALCULATORBASE_H
