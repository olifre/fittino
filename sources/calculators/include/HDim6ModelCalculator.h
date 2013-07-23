/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.h                                           *
*                                                                              *
* Description Wrapper class for HDim6                                          *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HDIM6MODELCALCULATOR_H
#define FITTINO_HDIM6MODELCALCULATOR_H

#include "ModelCalculatorBase.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HDim6 
   */
  class HDim6ModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   HDim6ModelCalculator();
      /*!
       *  Standard destructor.
       */
      virtual      ~HDim6ModelCalculator();

    public:
      virtual void CalculatePredictions( PhysicsModelBase* model );
      virtual void Initialize() const;

    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );

  };

}

#endif // FITTINO_HDIM6MODELCALCULATOR_H
