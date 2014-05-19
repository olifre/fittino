/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        NewHiggsSignalsHadXSCalculator.h                                   *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=had              *
*                                                                              *
* Authors     Matthias Hamer      <mhamer@cbpf.br>                             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_NEWHIGGSSIGNALSHADXSCALCULATOR_H
#define FITTINO_NEWHIGGSSIGNALSHADXSCALCULATOR_H

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
  class NewHiggsSignalsHadXSCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    NewHiggsSignalsHadXSCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~NewHiggsSignalsHadXSCalculator();

    public:
      virtual void CalculatePredictions();
      virtual void Initialize();
      virtual void SetupMeasuredValues();
      double       RunHiggsBounds();
      void         CallHiggsBounds();
      void         SetupHiggsBounds();

    private:
      double        _chi2;
      double        _chi2_mass_h;
      double        _chi2_mu;
      double        _pvalue;
      double        _R_H_WW;
      double        _R_H_ZZ;
      double        _R_H_gaga;
      double        _R_H_bb;
      double        _R_H_tautau;
      double        _R_VH_bb;
      double        _weight_xs_bbh;
      double        _weight_xs_ggh;
      int           _mode;
      int           _nobs;
      
      int           _nH;
      int           _nHplus;
      int           _nHzero;
      double        _globalHiggsBoundsChi2;
      int           _HBresult;
      int           _channel;
      double        _obsratio;
      int           _ncombined;
      double        _theoryUncertainty1s;
      double        _chi2WithTheory;
      double        _chi2WithoutTheory;
      int           _bestChannelChi2;
      std::string   _whichAnalyses;


      std::vector<double>      _mass_h_neutral_shift;
      std::vector<double>      _mass_h_charged_shift;
      std::vector<std::string> _name_mass_h_neutral_shift;
      std::vector<std::string> _name_mass_h_charged_shift;

      std::vector<std::string> _name_mass_h_neutral;
      std::vector<std::string> _name_Gamma_Total_neutral;
      std::vector<std::string> _name_mass_h_charged;
      std::vector<std::string> _name_Gamma_Total_charged;
      std::vector<std::string> _name_CP;
      
      std::vector<std::string> _name_CS_lep_hjZ_ratio;
      std::vector<std::string> _name_CS_lep_bbhj_ratio;
      std::vector<std::string> _name_CS_lep_tautauhj_ratio;
      std::vector<std::vector<std::string> > _name_CS_lep_hjhi_ratio;
      
      std::vector<std::string> _name_CS_tev_gghj_ratio;
      std::vector<std::string> _name_CS_tev_bbhj_ratio;
      std::vector<std::string> _name_CS_tev_hjb_ratio;
      std::vector<std::string> _name_CS_tev_hjW_ratio;
      std::vector<std::string> _name_CS_tev_hjZ_ratio;
      std::vector<std::string> _name_CS_tev_vbf_ratio;
      std::vector<std::string> _name_CS_tev_tthj_ratio;
      
      std::vector<std::string> _name_CS_lhc7_gghj_ratio;
      std::vector<std::string> _name_CS_lhc7_bbhj_ratio;
      std::vector<std::string> _name_CS_lhc7_hjb_ratio;
      std::vector<std::string> _name_CS_lhc7_hjW_ratio;
      std::vector<std::string> _name_CS_lhc7_hjZ_ratio;
      std::vector<std::string> _name_CS_lhc7_vbf_ratio;
      std::vector<std::string> _name_CS_lhc7_tthj_ratio;
      
      std::vector<std::string> _name_CS_lhc8_gghj_ratio;
      std::vector<std::string> _name_CS_lhc8_bbhj_ratio;
      std::vector<std::string> _name_CS_lhc8_hjb_ratio;
      std::vector<std::string> _name_CS_lhc8_hjW_ratio;
      std::vector<std::string> _name_CS_lhc8_hjZ_ratio;
      std::vector<std::string> _name_CS_lhc8_vbf_ratio;
      std::vector<std::string> _name_CS_lhc8_tthj_ratio;
      
      std::vector<std::string> _name_BR_hjss;
      std::vector<std::string> _name_BR_hjcc;
      std::vector<std::string> _name_BR_hjbb;
      std::vector<std::string> _name_BR_hjmumu;
      std::vector<std::string> _name_BR_hjtautau;
      std::vector<std::string> _name_BR_hjWW;
      std::vector<std::string> _name_BR_hjZZ;
      std::vector<std::string> _name_BR_hjZga;
      std::vector<std::string> _name_BR_hjgaga;
      std::vector<std::string> _name_BR_hjgg;
      std::vector<std::string> _name_BR_hjchi10chi10;
      std::vector<std::string> _name_BR_hjnuenue;
      std::vector<std::string> _name_BR_hjnumunumu;
      std::vector<std::string> _name_BR_hjnutaunutau;
      std::vector<std::vector<std::string> > _name_BR_hjhihi;
      std::vector<std::string> _name_CS_lep_HpjHmi_ratio;
      std::vector<std::string> _name_BR_tWpb;
      std::vector<std::string> _name_BR_tHpjb;
      std::vector<std::string> _name_BR_Hpjcs;
      std::vector<std::string> _name_BR_Hpjcb;
      std::vector<std::string> _name_BR_Hptaunu;
     
  };

}

#endif // FITTINO_NEWHIGGSSIGNALSHADXSCALCULATOR_H
