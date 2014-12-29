/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsHadXSCalculator.h                                    *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hec              *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSHECCALCULATOR_H
#define FITTINO_HIGGSSIGNALSHECCALCULATOR_H

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals using whichinput=hadr
   */
  class HiggsSignalsHECCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    HiggsSignalsHECCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~HiggsSignalsHECCalculator();

    public:
      virtual void CalculatePredictions();
      virtual void Initialize();

    private:  

      double _chi2;
      double _chi2_mass_h;
      double _chi2_mu;
      double _pvalue;

      double _mh;        

      double _gammaTotal;

      double _g2hjss_s; 
      double _g2hjcc_s;
      double _g2hjbb_s;
      double _g2hjtt_s;
      double _g2hjmumu_s;
      double _g2hjtautau_s;

      double _g2hjss_p; 
      double _g2hjcc_p;
      double _g2hjbb_p;
      double _g2hjtt_p;
      double _g2hjmumu_p;
      double _g2hjtautau_p;

      double _g2hjWW;
      double _g2hjZZ;
      double _g2hjZga;
      double _g2hjgaga;
      double _g2hjgg;
      double _g2hjggZ;
      double _g2hjhiZ;

      double _BR_hjinvisible;
      double _BR_hjhihi;

  };

}

#endif 
