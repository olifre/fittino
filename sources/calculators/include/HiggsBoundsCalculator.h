/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsCalculator.h                                     *
*                                                                              *
* Description Wrapper class for HiggsBounds                                   *
*                                                                              *
* Authors     Matthias Hamer        <mhamer@gwdg.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSBOUNDSCALCULATOR_H
#define FITTINO_HIGGSBOUNDSCALCULATOR_H

#include "PtreeForwardDeclaration.h"

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsBounds.
   */
  class HiggsBoundsCalculator : public CalculatorBase { 

    public:
      /*!
       *  Standard constructor.
       */
      HiggsBoundsCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HiggsBoundsCalculator();

    public:
      virtual void  Initialize();
      virtual void  CalculatePredictions();
      virtual void  SetupMeasuredValues();

      /*! \cond UML */

    private:
      /*!
       *
       */
      double        _dm;
      /*!
       *
       */
      /*!
       * 
       */
      std::string _whichAnalyses;
      /*!
       *  Number of Higgs particles.
       */
      int           _nH;
      /*!
       *
       */
      int           _nHplus;
      /*!
       *
       */
      int           _nHzero;
      /*!
       * 
       */
      double        _globalHiggsBoundsChi2;
      /*!
       *
       */
      int           _HBresult;
      int           _channel;
      double        _obsratio;
      int           _ncombined;
      double        _theoryUncertainty1s;
      double        _chi2WithTheory;
      double        _chi2WithoutTheory;
      int           _bestChannelChi2;

    private:
      void CallHiggsBounds();
      double call_HiggsBoundsWithSLHA();

  };

}

#endif // FITTINO_HIGGSBOUNDSCALCULATOR_H
