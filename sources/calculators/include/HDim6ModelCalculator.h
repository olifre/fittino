/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.h                                           *
*                                                                              *
* Description Wrapper class for HDim6                                          *
*                                                                              *
* Authors     Bastian Heller    <bastian.heller@rwth-aachen.de>                *
*             Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
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
      virtual                  ~HDim6ModelCalculator();

    public:
      virtual void             CalculatePredictions();
      virtual void             Initialize() const;

    private:  
      bool                     _interpolateGamma;
      std::string              _pdfDirectory;
      std::string              _pdfSet;
      std::vector<std::string> _decayChannels;
      effinputs*               _effsmvalues;
      effinputs*               _effvalues;
      sminputs*                _smvalues;

    private:   
      void                     CalculateBR();
      void                     CalculateBRSM();
      void                     CalculateGamma();
      void                     CalculateGammaLO( bool doSM );
      void                     CalculateGammaNormSM();
      void                     CalculateGammaSM();
      void                     CalculateTripleGaugeCouplings();
      void                     CalculateQuarticGaugeCouplings();
      void                     CalculateXS();
      void                     InitializeSimpleOutputDataStorage();

    private:
      virtual void             CallExecutable();
      virtual void             CallFunction();
      virtual void             ConfigureInput();

  };

}

#endif // FITTINO_HDIM6MODELCALCULATOR_H
