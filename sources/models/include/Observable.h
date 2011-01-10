/* $Id: Observable.h 844 2011-01-10 13:52:15Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Observable.h                                                     *
*                                                                              *
* Description Class for observables                                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OBSERVABLE_H
#define FITTINO_OBSERVABLE_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for observables.
   */
  class Observable {

    public:
      /*!
       *  Standard constructor.
       */
                  Observable();
      /*!
       *  Standard destructor.
       */
                  ~Observable();
      void        UpdatePredictedValue();

    private:
      double      _error;
      double      _measuredValue;
      double      _predictedValue;
      std::string _name;

  };

}

#endif // FITTINO_OBSERVABLE_H
