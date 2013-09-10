/* $Id: Observable.h 1444 2013-07-16 16:54:46Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Observable.h                                                     *
*                                                                              *
* Description Class for observables                                            *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OBSERVABLE_H
#define FITTINO_OBSERVABLE_H

#include "TRandom.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PredictionBase;

  /*!
   *  \ingroup models
   *  \brief Class for observables.
   */
  class Observable {

    public:
      /*!
       *  Constructor.
       */
                      Observable( PredictionBase* prediction,
                                  double          measuredValue,
                                  double          measuredError );
      /*!
       *  Standard destructor.
       */
                      ~Observable();
      void            PrintStatus() const;
      double          GetMeasuredError() const;
      double          GetMeasuredValue() const;
      PredictionBase* GetPrediction();
			void						SetBestFitPrediction( double );

    public:
      virtual void    UpdatePrediction();
			virtual void		SmearMeasuredValue( TRandom* );

    protected:
      double          _deviation;
      double          _measuredError;
      double          _measuredValue;
			double					_bestFitPrediction;
      PredictionBase* _prediction;

    protected:
      double          CalculateDeviation();

  };

}

#endif // FITTINO_OBSERVABLE_H
