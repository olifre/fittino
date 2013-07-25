/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAPrediction.h                                                 *
*                                                                              *
* Description Class for SLHA predicitions                                      *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAPREDICTION_H
#define FITTINO_SLHAPREDICTION_H

#include <string>

#include "PredictionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHAModelCalculatorBase;

  /*!
   *  \ingroup models
   *  \brief Class for SLHA observables.
   */
  class SLHAPrediction : public PredictionBase {

    public:
      /*!
       *  Standard constructor.
       */
                               SLHAPrediction( std::string              name,
                                               std::string              plotName,
                                               std::string              unit,
                                               std::string              plotUnit,
                                               double                   plotLowerBound,
                                               double                   plotUpperBound,
                                               SLHAModelCalculatorBase* slhaModelCalculator,
                                               std::string              blockName,
                                               std::string              id,
                                               int                      columnIndex );
      /*!
       *  Alternative constructor.
       */
                               SLHAPrediction( std::string              name,
                                               std::string              plotName,
                                               std::string              unit,
                                               std::string              plotUnit,
                                               double                   plotLowerBound,
                                               double                   plotUpperBound,
                                               SLHAModelCalculatorBase* slhaModelCalculator,
                                               std::string              blockName,
                                               std::string              firstId,
                                               std::string              secondId,
                                               int                      columnIndex );
      /*!
       *  Standard destructor.
       */
                               ~SLHAPrediction();
       std::string             GetPlotUnit() const;

    public:
      virtual void             Update();
      virtual std::string      GetPlotName() const;

    private:
      int                      _columnIndex;
      std::string              _firstId;
      std::string              _secondId;
      std::string              _blockName;
      SLHAModelCalculatorBase* _slhaModelCalculator;

  };

}

#endif // FITTINO_SLHAPREDICTION_H
