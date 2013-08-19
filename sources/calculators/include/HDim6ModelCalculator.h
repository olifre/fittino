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

struct effinputs;
struct sminputs;

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
                   HDim6ModelCalculator( const PhysicsModelBase* model );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~HDim6ModelCalculator();

    public:
      virtual void CalculatePredictions();
      virtual void Initialize() const;

    private:  
      std::string  _pdfDirectory;
      std::string  _pdfSet;
      sminputs*    _smvalues;
      effinputs*   _effvalues;

    private:   
      void         CalculateGamma();
      void         CalculateTripleGaugeCouplings();
      void         CalculateQuarticGaugeCouplings();
      void         CalculateXS();
      void         InitializeSimpleOutputDataStorage();

    private:
      virtual void CallExecutable();
      virtual void CallFunction();
      virtual void ConfigureInput();

  };

}

#endif // FITTINO_HDIM6MODELCALCULATOR_H
