/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePrediction.h                                               *
*                                                                              *
* Description Class for simple predicitions                                    *
*                                                                              *
* Authors     Bjoern Sarrazin   <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLEPREDICTION_H
#define FITTINO_SIMPLEPREDICTION_H

#include <string>

#include "PredictionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelCalculatorBase;

  /*!
   *  \ingroup models
   *  \brief Class for simple predictions
   */
  class SimplePrediction : public PredictionBase {

    public:
      /*!
       *  Standard constructor.
       */
                    SimplePrediction( std::string name,
                                      std::string plotName,
                                      std::string unit,
                                      std::string plotUnit,
                                      double plotLowerBound,
                                      double plotUpperBound,
                                      const double& value );

      /*!
       *  Alternative constructor.
       */
                    SimplePrediction( std::string name,
                                      std::string plotName,
                                      std::string unit,
                                      std::string plotUnit,
                                      double plotLowerBound,
                                      double plotUpperBound,
                                      const ModelCalculatorBase* calculator );

      /*!
       *  Standard destructor.
       */
                    ~SimplePrediction();

    public:
      virtual void  Update();

    private:
      const double& _referenceValue;       

  };

}

#endif // FITTINO_SIMPLEPREDICTION_H