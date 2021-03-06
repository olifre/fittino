/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsCalculator.h                                         *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=had              *
*                                                                              *
* Authors     Bjoern Sarrazin                                                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSCALCULATOR_H
#define FITTINO_HIGGSSIGNALSCALCULATOR_H

#include "CalculatorBase.h"
#include "Redirector.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals using whichinput=hadr
   */
  class HiggsSignalsCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      HiggsSignalsCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );

    public:
      /*!
       *  Standard destructor.
       */
      virtual      ~HiggsSignalsCalculator();

    public:
      virtual void CalculatePredictions();

      // todo: review these functions. why are they public?
      double       RunHiggsBounds();
      void         CallHiggsBounds();
      void         AssignMeasurements();

  private:
      Redirector _redirector;
      bool _runHiggsBounds;
      bool _runHiggsSignals;
      bool _useInitialPredictionsAsMeasurements;
      std::vector<std::string> _names_h0;
      std::vector<std::string> _names_hp;
      int _npeakmu;

      static bool _HBisInitialized;
      static bool _HSisInitialized;
      static unsigned int _initialized_nHzero;
      static unsigned int _initialized_nHplus;
      static std::string _initialized_whichAnalyses;
      static std::string _initialized_expData;

     // arguments for HiggsBounds_charged_input, in the order required by this function
      std::vector<double> _chargedInput_MHplus;
      std::vector<double> _chargedInput_GammaTot;
      std::vector<double> _chargedInput_CS_lep_HpjHmj_ratio;
      double              _chargedInput_BR_tWpb;
      std::vector<double> _chargedInput_BR_tHpjb;
      std::vector<double> _chargedInput_BR_Hpjcs;
      std::vector<double> _chargedInput_BR_Hpjcb;
      std::vector<double> _chargedInput_BR_Hptaunu;

      // arguments for HiggsBounds_neutral_input_hadr, in the order required by this function
      std::vector<double> _neutralInput_Mh;
      std::vector<double> _neutralInput_GammaTot;
      std::vector<double> _neutralInput_CP;
      std::vector<double> _neutralInput_CS_lep_hjZ_ratio;
      std::vector<double> _neutralInput_CS_lep_bbhj_ratio;
      std::vector<double> _neutralInput_CS_lep_tautauhj_ratio;
      std::vector<double> _neutralInput_CS_lep_hjhi_ratio;
      std::vector<double> _neutralInput_CS_tev_hj_ratio;
      std::vector<double> _neutralInput_CS_tev_hjb_ratio;
      std::vector<double> _neutralInput_CS_tev_hjW_ratio;
      std::vector<double> _neutralInput_CS_tev_hjZ_ratio;
      std::vector<double> _neutralInput_CS_tev_vbf_ratio;
      std::vector<double> _neutralInput_CS_tev_tthj_ratio;
      std::vector<double> _neutralInput_CS_lhc7_hj_ratio;
      std::vector<double> _neutralInput_CS_lhc7_hjb_ratio;
      std::vector<double> _neutralInput_CS_lhc7_hjW_ratio;
      std::vector<double> _neutralInput_CS_lhc7_hjZ_ratio;
      std::vector<double> _neutralInput_CS_lhc7_vbf_ratio;
      std::vector<double> _neutralInput_CS_lhc7_tthj_ratio;
      std::vector<double> _neutralInput_CS_lhc8_hj_ratio;
      std::vector<double> _neutralInput_CS_lhc8_hjb_ratio;
      std::vector<double> _neutralInput_CS_lhc8_hjW_ratio;
      std::vector<double> _neutralInput_CS_lhc8_hjZ_ratio;
      std::vector<double> _neutralInput_CS_lhc8_vbf_ratio;
      std::vector<double> _neutralInput_CS_lhc8_tthj_ratio;
      std::vector<double> _neutralInput_BR_hjss;
      std::vector<double> _neutralInput_BR_hjcc;
      std::vector<double> _neutralInput_BR_hjbb;
      std::vector<double> _neutralInput_BR_hjmumu;
      std::vector<double> _neutralInput_BR_hjtautau;
      std::vector<double> _neutralInput_BR_hjWW;
      std::vector<double> _neutralInput_BR_hjZZ;
      std::vector<double> _neutralInput_BR_hjZga;
      std::vector<double> _neutralInput_BR_hjgaga;
      std::vector<double> _neutralInput_BR_hjgg;
      std::vector<double> _neutralInput_BR_hjinvisible;
      std::vector<double> _neutralInput_BR_hjhihi;

      // arguments for higgsbounds_set_mass_uncertainties, in the order required by this function
      std::vector<double> _massUncertainty_HB_neutral;
      std::vector<double> _massUncertainty_HB_charged;

      // argument for higgssignals_neutral_input_massuncertainty
      std::vector<double> _massUncertainty_HS_neutral;

      // arguments for get_peakinfo_from_hsresults, in the order required by this function
      std::vector<double> _peakInfoFromHSresults_mupred;
      std::vector<double> _peakInfoFromHSresults_domH;
      std::vector<double> _peakInfoFromHSresults_nHcomb;

      // for HB shift the higgs mass prediction instead of the measurement, when doing toys
      std::vector<double> _mass_h_neutral_shift;
      std::vector<double> _mass_h_charged_shift;

    // todo: review these HS variables
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
      int           _nobs;

      // todo: review these HB variables:
      double        _globalHiggsBoundsChi2;
      int           _HBresult;
      double        _HBresult_double;
      int           _channel;
      double        _channel_double;
      double        _obsratio;
      int           _ncombined;
      double        _theoryUncertainty1s;
      double        _chi2WithTheory;
      double        _chi2WithoutTheory;
      int           _bestChannelChi2;
      double        _bestChannelChi2_double;

      // measured values
      std::vector<double> _measurement_mu;
      std::vector<double> _measurement_mass;
      std::vector<double> _error_mass;
      std::vector<double> _error_up_mu;
      std::vector<double> _error_down_mu;
      std::vector<int>    _obsID;

  private:
      void         AddInputs();
      void         AddChargedHiggs( const boost::property_tree::ptree &ptree );
      void         AddNeutralHiggs( const boost::property_tree::ptree &ptree );
      void         AddHiggsPairProductionLEP( const boost::property_tree::ptree &ptree );
      void         CheckMatrices();
      void         AddOutputs();
      void         InitializeMeasurements();
      void         DetermineNumberOfPeaks();
      void         DetermineObsIDs();
      void InitializeHBandHS(bool print);
      void Setup(bool print);
      void         ResizeInputArrays();
      void         ResizePeakArrays();
      void         Run();
      void         UpdateChargedInput( bool shiftHiggsMass );
      void         UpdateNeutralInput( bool shiftHiggsMass );
      void         UpdateOutput();
      void         UpdateMassUncertainties();

  };

}

#endif
