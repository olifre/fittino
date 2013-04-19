/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PredictionBase.h                                                 *
*                                                                              *
* Description Base class for predictions                                       *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PREDICTIONBASE_H
#define FITTINO_PREDICTIONBASE_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for predictions.
   */
  class PredictionBase {

    public:
      /*!
       *  Standard constructor.
       */
                     PredictionBase( std::string name, 
                                     std::string unit );
      /*!
       *  Standard destructor.
       */
                     ~PredictionBase();
      std::string    GetName() const;
      std::string    GetUnit() const;

    public:
      virtual void   UpdatePrediction() = 0;
      virtual void   PrintStatus() const;
      virtual double GetPredictedValue() const;

    protected:
      double         _predictedValue;
      std::string    _name;
      std::string    _unit;

  };

}

#endif // FITTINO_PREDICTIONBASE_H
