/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHACalculatorBase.h                                             *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHACALCULATORBASE_H
#define FITTINO_SLHACALCULATORBASE_H

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHADataStorageBase;

  /*!
   *  \ingroup calculators
   *  \brief Base class for SLHA compatible model calculators.
   */
  class SLHACalculatorBase : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      SLHACalculatorBase( const PhysicsModel* model );
      /*!
       *  Standard destructor.
       */
      ~SLHACalculatorBase();
      SLHADataStorageBase* GetDataStorage();
      /*!
       *  Converts a double variable to a string.
       */
      std::string          String( double x );

    protected:
      std::string          _slhaInputFileName;
      std::string          _slhaOutputFileName;
      SLHADataStorageBase* _slhaInputDataStorage;
      SLHADataStorageBase* _slhaOutputDataStorage;

  };

}

#endif // FITTINO_SLHACALCULATORBASE_H
