/* $Id: ObservableBase.h 844 2011-01-10 13:52:15Z uhlenbrock $ */

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
                     ObservableBase( std::string name, int id );
      /*!
       *  Standard destructor.
       */
                     ~ObservableBase();
      double         GetChi2() const;
      double         GetDeviation() const;
      int            GetID() const;
      std::string    GetName() const;
      virtual void   PrintStatus() const = 0;
      virtual void   UpdatePrediction() = 0;

    protected:
      virtual double CalculateChi2() = 0;
      virtual double CalculateDeviation() = 0;

    protected:
      double         _chi2;
      double         _deviation;
      int            _id;
      std::string    _name;

  };

}

#endif // FITTINO_OBSERVABLEBASE_H
