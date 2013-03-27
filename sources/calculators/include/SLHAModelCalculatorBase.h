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
      SLHADataStorageBase* GetDataStorage();

    public:
      virtual void         CalculatePredictions( PhysicsModelBase* model );

    protected:
      TString              _slhaInputFileName;
      TString              _slhaOutputFileName;
      SLHADataStorageBase* _slhaInputDataStorage;
      SLHADataStorageBase* _slhaOutputDataStorage;

  };

}

#endif // FITTINO_SLHAMODELCALCULATORBASE_H
