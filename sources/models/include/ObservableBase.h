/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ObservableBase.h                                                 *
*                                                                              *
* Description Base class for observables                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OBSERVABLEBASE_H
#define FITTINO_OBSERVABLEBASE_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for observables.
   */
  class ObservableBase {

    public:
      /*!
       *  Standard constructor.
       */
                   ObservableBase( std::string name,
                                   double      measuredValue,
                                   double      measuredError );
      /*!
       *  Standard destructor.
       */
                   ~ObservableBase();
      virtual void UpdatePrediction() = 0;
      void         PrintStatus() const;
      double       GetMeasuredError() const;
      double       GetMeasuredValue() const;
      double       GetPredictedValue() const;

    protected:
      double       _deviation;
      double       _measuredError;
      double       _measuredValue;
      double       _predictedValue;
      std::string  _name;

    protected:
      double       CalculateDeviation();

  };

}

#endif // FITTINO_OBSERVABLEBASE_H
