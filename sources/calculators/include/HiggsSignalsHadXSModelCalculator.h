/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsHadXSModelCalculator.h                               *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hadr             *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSHADXSMODELCALCULATOR_H
#define FITTINO_HIGGSSIGNALSHADXSMODELCALCULATOR_H

#include "ModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals using whichinput=hadr
   */
  class HiggsSignalsHadXSModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   HiggsSignalsHadXSModelCalculator( const PhysicsModelBase* model );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~HiggsSignalsHadXSModelCalculator();

    public:
      virtual void CalculatePredictions();
      virtual void Initialize() const;

    private:   
      void         InitializeSimpleOutputDataStorage(); 

    private:
      virtual void CallExecutable();
      virtual void CallFunction();
      virtual void ConfigureInput();

  };

}

#endif // FITTINO_HIGGSSIGNALSHADXSMODELCALCULATOR_H
