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

  class Quantity;

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
      double _BR_hbb;
      double _BR_hcc;
      double _BR_hgaga;
      double _BR_hgg;
      double _BR_hHH;
      double _BR_hInvisible;
      double _BR_hmumu;
      double _BR_hss;
      double _BR_htautau;
      double _BR_hWW;
      double _BR_hZga;
      double _BR_hZZ;
      double _chi2;
      double _chi2_mass_h;
      double _chi2_mu;
      double  _CP;
      double _Gamma_hbb;
      double _Gamma_hcc;
      double _Gamma_hgaga;
      double _Gamma_hgg;
      double _Gamma_hmumu;
      double _Gamma_hss;
      double _Gamma_htautau;
      double _Gamma_hTotal;
      double _Gamma_hWW;
      double _Gamma_hZga;
      double _Gamma_hZZ;
      double _normSM_BR_hbb;
      double _normSM_BR_hcc;
      double _normSM_BR_hgaga;
      double _normSM_BR_hgg;
      double _normSM_BR_hmumu;
      double _normSM_BR_hss;
      double _normSM_BR_htautau;
      double _normSM_BR_hWW;
      double _normSM_BR_hZga;
      double _normSM_BR_hZZ;
      double _normSM_Gamma_hTotal;
      double _normSM_xs_h;
      double _normSM_xs_lep;
      double _normSM_xs_tev;
      double _pvalue;
      double _SM_BR_hbb;
      double _SM_BR_hcc;
      double _SM_BR_hgaga;
      double _SM_BR_hgg;
      double _SM_BR_hmumu;
      double _SM_BR_hss;
      double _SM_BR_htautau;
      double _SM_BR_hWW;
      double _SM_BR_hZga;
      double _SM_BR_hZZ;
      double _SM_Gamma_hbb;
      double _SM_Gamma_hcc;
      double _SM_Gamma_hgaga;
      double _SM_Gamma_hgg;
      double _SM_Gamma_hmumu;
      double _SM_Gamma_hss;
      double _SM_Gamma_htautau;
      double _SM_Gamma_hTotal;
      double _SM_Gamma_hWW;
      double _SM_Gamma_hZga;
      double _SM_Gamma_hZZ;
      double _SM_xs_bbh;
      double _SM_xs_ggh;
      double _SM_xs_h;
      double _weight_xs_bbh;
      double _weight_xs_bbh_2;
      double _weight_xs_ggh;
      double _weight_xs_ggh_2;
      int _mode;
      int _nobs;

    private:
      const double& _mass_h;
      const double& _normSM_Gamma_hbb;
      const double& _normSM_Gamma_hcc;
      const double& _normSM_Gamma_hgaga;
      const double& _normSM_Gamma_hgg;
      const double& _normSM_Gamma_hmumu;
      const double& _normSM_Gamma_hss;
      const double& _normSM_Gamma_htautau;
      const double& _normSM_Gamma_hWW;
      const double& _normSM_Gamma_hZga;
      const double& _normSM_Gamma_hZZ;
      const double& _normSM_xs_bbh;
      const double& _normSM_xs_bh;
      const double& _normSM_xs_ggh;
      const double& _normSM_xs_qqh;
      const double& _normSM_xs_tth;
      const double& _normSM_xs_Wh;
      const double& _normSM_xs_Zh;

      const double* _direct;

    private:
      virtual void CallExecutable();
      virtual void CallFunction();
      virtual void ConfigureInput();

  };

}

#endif // FITTINO_HIGGSSIGNALSHADXSMODELCALCULATOR_H
