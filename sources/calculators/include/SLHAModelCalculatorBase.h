/* $Id$ */

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

#include <string>

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
                           SLHAModelCalculatorBase( const PhysicsModelBase* model );
      /*!
       *  Standard destructor.
       */
                           ~SLHAModelCalculatorBase();
      SLHADataStorageBase* GetDataStorage();
      /*!   
       *  Converts a double variable to a string.
       */
      std::string          String( double x );

    public:

    protected:
      std::string          _slhaInputFileName;
      std::string          _slhaOutputFileName;
      SLHADataStorageBase* _slhaInputDataStorage;
      SLHADataStorageBase* _slhaOutputDataStorage;

  };

}

#endif // FITTINO_SLHAMODELCALCULATORBASE_H
