/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAObservable.h                                                 *
*                                                                              *
* Description Class for SLHA observables                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAOBSERVABLE_H
#define FITTINO_SLHAOBSERVABLE_H

#include <string>

#include "ObservableBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHAModelCalculatorBase;

  /*!
   *  \ingroup models
   *  \brief Class for SLHA observables.
   */
  class SLHAObservable : public ObservableBase {

    public:
      /*!
       *  Standard constructor.
       */
                               SLHAObservable( std::string              name,
                                               double                   measuredValue,
                                               double                   measuredError,
                                               SLHAModelCalculatorBase* slhaModelCalculator,
					       std::string              blockName,
                                               int                      id,
                                               int                      columnIndex );
      /*!
       *  Standard destructor.
       */
                               ~SLHAObservable();
      virtual void             UpdatePrediction();

    private:
      int                      _columnIndex;
      int                      _id;
      std::string              _blockName;
      SLHAModelCalculatorBase* _slhaModelCalculator;

  };

}

#endif // FITTINO_SLHAOBSERVABLE_H
