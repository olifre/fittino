/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculator.h                                       *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSMODELCALCULATOR_H
#define FITTINO_FEYNHIGGSMODELCALCULATOR_H

#include <complex>

#include "Collection.h"
#include "ModelCalculatorBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare >
      class basic_ptree;

    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    FeynHiggsModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                   ~FeynHiggsModelCalculator();

      virtual void CalculatePredictions();
      virtual void Initialize() const;

      /*! \cond UML */
    private:
      virtual void CallExecutable();
      virtual void CallFunction();
      void         ConfigureInput();

    private:
      void         Couplings();
      void         HiggsCorr();
      void         Production();
      void         SetParameters();
      void         SetSMParameters();

    private:  
      int    _error;
      double _derror;
      
      double _alphaem_inv;
      double _alphas_mass_Z;
      double _GF;
    
      double _mass_e;
      double _mass_mu;
      double _mass_tau;

      double _mass_u_2GeV;
      double _mass_d_2GeV;
      double _mass_s_2GeV;
      double _mass_c_mass_c;
      double _mass_b_mass_b;

      double _mass_W;
      double _mass_Z;

      double _CKM_lambda;
      double _CKM_A;
      double _CKM_rhobar;
      double _CKM_etabar;

      double _mass_t;

      double _m_susy;

      double _m_1;
      double _m_2;
      double _m_3;

      double _m_sl_1;
      double _m_sl_2;
      double _m_sl_3;

      double _m_se_1;
      double _m_se_2;
      double _m_se_3;
    
      double _m_sq_1;
      double _m_sq_2;
      double _m_sq_3;

      double _m_su_1;
      double _m_su_2;
      double _m_su_3;

      double _m_sd_1;
      double _m_sd_2;
      double _m_sd_3;

      double _mass_A0;
      double _mass_Hp;

      double _Re_mu;
      double _Im_mu;
      std::complex<double> _mu;

      double _tanBeta;

      double _Re_A_t;
      double _Im_A_t;
      std::complex<double> _A_t;

      double _Re_A_b;
      double _Im_A_b;
      std::complex<double> _A_b;

      double _Re_A_c;
      double _Im_A_c;
      std::complex<double> _A_c;

      double _Re_A_s;
      double _Im_A_s;
      std::complex<double> _A_s;

      double _Re_A_d;
      double _Im_A_d;
      std::complex<double> _A_d;

      double _Re_A_u;
      double _Im_A_u;
      std::complex<double> _A_u;

      double _Re_A_tau;
      double _Im_A_tau;
      std::complex<double> _A_tau;

      double _Re_A_mu;
      double _Im_A_mu;
      std::complex<double> _A_mu;

      double _Re_A_e;
      double _Im_A_e;
      std::complex<double> _A_e;

      double _Q_tau;
      double _Q_t;
      double _Q_b;

      double _scalefactor;

      double _m_h;

      double _sigma_ggh_smratio;
      double _sigma_ggh2_smratio;
      double _sigma_bbh_smratio;
      double _sigma_qqh_smratio;
      double _sigma_tth_smratio;
      double _sigma_Wh_smratio;
      double _sigma_Zh_smratio;

      double _gamma_h_tautau;
      double _gamma_h_tautau_sm;
      double _gamma_h_tautau_smratio;
  
      double _gamma_h_cc;
      double _gamma_h_cc_sm;
      double _gamma_h_cc_smratio;
  
      double _gamma_h_ss;
      double _gamma_h_ss_sm;
      double _gamma_h_ss_smratio;
  
      double _gamma_h_bb;
      double _gamma_h_bb_sm;
      double _gamma_h_bb_smratio;

      double _gamma_h_gaga;
      double _gamma_h_gaga_sm;
      double _gamma_h_gaga_smratio;

      double _gamma_h_Zga_smratio;

      double _gamma_h_ZZ_smratio;
  
      double _gamma_h_WW_smratio;

      double _gamma_h_gg_smratio;

      double _gamma_h_tot_smratio;
      
      Collection<SimplePrediction*> _input;
      
      /*! \endcond UML */

  };

}

#endif // FITTINO_FEYNHIGGSMODELCALCULATOR_H
