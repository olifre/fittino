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
      virtual void Initialize();
      virtual void SetupMeasuredValues();
      double       RunHiggsBounds();
      void         CallHiggsBounds();
      void         UpdateNeutralInput(bool shiftHiggsMas = false);
      void         UpdateChargedInput(bool shiftHiggsMas = false);
      void         UpdateMassUncertainties();


    private:
      std::vector<std::string> _h0;
      std::vector<std::string> _hp;

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
      
      int           _nHplus;
      int           _nHzero;
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
      std::string   _whichAnalyses;
      
      std::vector<double>      _predicted_mu_fromHSresult;
      std::vector<double>      _dominant_higgs_fromHSresult;
      std::vector<double>      _ncombined_fromHSresult;
      std::vector<double>      _chi2_mu_from_peak;
      std::vector<double>      _chi2_mh_from_peak;
      std::vector<double>      _chi2_max_from_peak;
      std::vector<double>      _chi2_tot_from_peak;
      std::vector<double>      _mass_h_neutral_shift;
      std::vector<double>      _mass_h_charged_shift;

     private:

     const double& GetHiggsInput( std::string name, std::string higgs );
     const double& GetHiggsInput( std::string name, std::string higgs1, std::string higgs2 );

  };

}

#endif
