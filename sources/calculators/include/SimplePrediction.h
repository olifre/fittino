/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePrediction.h                                               *
*                                                                              *
* Description Class for simple predicitions                                    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEPREDICTION_H
#define FITTINO_SIMPLEPREDICTION_H

#include "PredictionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class CalculatorBase;

  /*!
   *  \ingroup kernel
   *  \brief Class for simple predictions.
   */
  class SimplePrediction : public PredictionBase {

    public:
      /*!
       *  Constructor taking name, unit and value.
       */
      SimplePrediction( std::string   name,
                        std::string   unit,
                        const double& value );
      /*!
       *  Constructor taking name, plotName, unit, plotUnit, lowerBound, upperBound and value.
       */
      SimplePrediction( std::string   name,
                        std::string   plotName,
                        std::string   unit,
                        std::string   plotUnit,
                        double        lowerBound,
                        double        upperBound,
                        const double& value );
      /*!
       *  Constructor taking name, plotName, unit, plotUnit, lowerBound, upperBound and a calculator.
       */
      SimplePrediction( std::string           name,
                        std::string           plotName,
                        std::string           unit,
                        std::string           plotUnit,
                        double                lowerBound,
                        double                upperBound,
                        const CalculatorBase* calculator );
      /*!
       *  Standard constructor.
       */
      SimplePrediction( const boost::property_tree::ptree& ptree, const double& value );
      /*!
       *  Alternative constructor.
       */
      SimplePrediction( const boost::property_tree::ptree& ptree, const CalculatorBase* calculator );
      /*!
       *  Standard destructor.
       */
      ~SimplePrediction();

    public:
      virtual void          Update();
      virtual const double& GetValue() const;

    private:
      const double&         _referenceValue;

  };

}

#endif // FITTINO_SIMPLEPREDICTION_H
