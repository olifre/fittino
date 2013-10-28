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

#include <boost/property_tree/ptree.hpp>

#include "Quantity.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for predictions.
   */
  class PredictionBase : public Quantity {

    public:
      /*!
       *  Constructor taking name, plotName, unit, plotUnit, plotLowerBound and plotUpperBound as an input 
       */
                   PredictionBase( std::string name,
                                   std::string plotName,
                                   std::string unit,
                                   std::string plotUnit,
                                   double      plotLowerBound,
                                   double      plotUpperBound );
      /*!
       *  Standard constructor
       */
                   PredictionBase( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                   ~PredictionBase();
      std::string  GetUnit() const;
      std::string  GetPlotUnit() const;

    public:
      virtual void Update() = 0;
      virtual void PrintStatus() const;

    protected:
      std::string  _unit;
      std::string  _plotUnit;

  };

}

#endif // FITTINO_PREDICTIONBASE_H
