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
*       published by the Free Software Foundation; either version 3 of   *
*       the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_OBSERVABLE_H
#define FITTINO_OBSERVABLE_H

#include <boost/property_tree/ptree.hpp>

#include "TRandom3.h"

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
                                  double          measuredError,
                                  double          bestFitPrediction = 0,
                                  bool            noFit = false );
      /*!
       *  Standard constructor
       */
                      Observable( const boost::property_tree::ptree& ptree, PredictionBase* prediction );
      /*!
       *  Standard destructor.
       */
                      ~Observable();
      void            PrintStatus() const;
      const double&   GetMeasuredError() const;
      const double&   GetMeasuredValue() const;
      double          GetBestFitPrediction() const;
      PredictionBase* GetPrediction();
      void            SetBestFitPrediction( double );
      void            SetMeasuredValue( double );
      bool            IsNoFitObservable();

    public:
      virtual void    UpdatePrediction();
      virtual void    SmearMeasuredValue( TRandom3* );

    protected:
      double          _deviation;
      double          _measuredError;
      double          _measuredValue;
      double          _bestFitPrediction;
      bool            _noFit;
      PredictionBase* _prediction;

    protected:
      double          CalculateDeviation();

  };

}

#endif // FITTINO_OBSERVABLE_H
