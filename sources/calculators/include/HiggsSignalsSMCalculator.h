/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSMCalculator.h                                       *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSSMCALCULATOR_H
#define FITTINO_HIGGSSIGNALSSMCALCULATOR_H

#include "CalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals
   */
  class HiggsSignalsSMCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    HiggsSignalsSMCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual      ~HiggsSignalsSMCalculator();

    public:
      virtual void CalculatePredictions();

    private:
      double _BR_h_W_W;
      double _BR_h_Z_Z;
      double _BR_h_b_b;
      double _BR_h_tau_tau;
      double _BR_h_gamma_gamma;
      double _BR_h_g_g;
      double _BR_h_t_t;
      double _BR_h_c_c;
      double _BR_h_s_s;
      double _BR_h_mu_mu;
      double _BR_h_Z_gamma;
      double _BR_h_Others;
      double _Gamma_h_Total;
      double _Gamma_t_W_b;
      double _xs_TEV_Wh;
      double _xs_TEV_Zh;
      double _xs_TEV_ggh;
      double _xs_TEV_bbh;
      double _xs_TEV_qqh;
      double _xs_TEV_bh;
      double _xs_TEV_tth;
      double _xs_LHC_7TeV_Wh;
      double _xs_LHC_7TeV_Zh;
      double _xs_LHC_7TeV_ggh;
      double _xs_LHC_7TeV_bbh;
      double _xs_LHC_7TeV_qqh;
      double _xs_LHC_7TeV_tth;
      double _xs_LHC_8TeV_Wh;
      double _xs_LHC_8TeV_Zh;
      double _xs_LHC_8TeV_ggh;
      double _xs_LHC_8TeV_bbh;
      double _xs_LHC_8TeV_qqh;
      double _xs_LHC_8TeV_tth;

  };

}

#endif
