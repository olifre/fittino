/* $Id$ */

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
#include <Quantity.h>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PredictionBase;
    class Quantity;

  /*!
   *  \ingroup models
   *  \brief Class for observables.
   */
  class Observable {

    public:
      /*!
       *  Constructor.
       */
                      Observable(Quantity *prediction,
                              double measuredValue,
                              double measuredError,
                              double bestFitPrediction = 0,
                              bool noFit = false,
                              bool noSmear = false,
                              bool noUpdate = false);
      /*!
       *  Standard constructor
       */
                      Observable(const boost::property_tree::ptree &ptree, Quantity *prediction);
      /*!
       *  Standard destructor.
       */
                      ~Observable();
      void            PrintStatus() const;
      const double&   GetMeasuredError() const;
      const double&   GetMeasuredValue() const;
      double          GetBestFitPrediction() const;
      Quantity* GetPrediction();
      void            SetBestFitPrediction( double );
      void            SetMeasuredValue( double );
      bool            IsNoFitObservable();
      bool            IsNoSmearObservable();
      std::string     GetSmearingType();
      bool            IsNoUpdateObservable();
      double          GetRelativeError();
      double&         GetDeviation();

    public:
      virtual void    UpdatePrediction();
      virtual void    SmearMeasuredValue( );

    protected:
      double          _error1;
      double          _error2;
      double          _error3;
      double          _relativeError;
      double          _deviation;
      double          _measuredError;
      double          _measuredValue;
      double          _bestFitPrediction;
      bool            _noFit;
      bool            _noSmear;
      bool            _noUpdate;
      Quantity* _prediction;
      std::string     _smearingType;

    protected:
      double          CalculateDeviation();

  };

}

#endif // FITTINO_OBSERVABLE_H
