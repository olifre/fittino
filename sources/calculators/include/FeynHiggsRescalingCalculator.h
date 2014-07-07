/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsRescalingCalculator.h                                   *
*                                                                              *
* Description Decoupling fix                                                   *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSRESCALINGCALCULATOR_H
#define FITTINO_FEYNHIGGSRESCALINGCALCULATOR_H

#include "CalculatorBase.h"
#include "Collection.h"
#include "PtreeForwardDeclaration.h"


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;

  /*!
   *  \ingroup calculators
   *  \brief Decoypling fix
   */
  class FeynHiggsRescalingCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsRescalingCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual ~FeynHiggsRescalingCalculator();

      void CalculatePredictions();


      /*! \cond UML */

    private:

      // we have to recalculate these
      
      double _zero; // this will be Gamma, NormSM_Gamma, BR, NormSM_BR for A0/H0->gg 
      double _i_Gamma_h_g_g;   
      double _i_BR_h_g_g;   
      double _i_normSM_Gamma_h_g_g;   
      double _i_normSM_BR_h_g_g;   
      double _SM_Gamma_h_g_g;   
      double _SM_BR_h_g_g;   

      // these are the rescaled quantities

      double _GammaTotal_h0;      
      double _Gamma_h_g_g;  
      double _Gamma_h_Wp_Wm;
      double _Gamma_h_Z0_Z0;
      double _Gamma_h_Z0_gamma;
      double _Gamma_h_gamma_gamma;
      double _Gamma_h_nue_nue;
      double _Gamma_h_e_e;
      double _Gamma_h_numu_numu;
      double _Gamma_h_mu_mu;
      double _Gamma_h_nutau_nutau;
      double _Gamma_h_tau_tau;
      double _Gamma_h_u_u;
      double _Gamma_h_d_d;
      double _Gamma_h_c_c;
      double _Gamma_h_s_s;
      double _Gamma_h_b_b;

      double _normSM_GammaTotal_h0;
      double _normSM_Gamma_h_g_g;
      double _normSM_Gamma_h_Wp_Wm;
      double _normSM_Gamma_h_Z0_Z0;
      double _normSM_Gamma_h_Z0_gamma;
      double _normSM_Gamma_h_gamma_gamma;
      double _normSM_Gamma_h_nue_nue;
      double _normSM_Gamma_h_e_e;
      double _normSM_Gamma_h_numu_numu;
      double _normSM_Gamma_h_mu_mu;
      double _normSM_Gamma_h_nutau_nutau;
      double _normSM_Gamma_h_tau_tau;
      double _normSM_Gamma_h_u_u;
      double _normSM_Gamma_h_d_d;
      double _normSM_Gamma_h_c_c;
      double _normSM_Gamma_h_s_s;
      double _normSM_Gamma_h_b_b;

      double _BR_h_g_g;
      double _BR_h_Wp_Wm;
      double _BR_h_Z0_Z0;
      double _BR_h_Z0_gamma;
      double _BR_h_gamma_gamma;
      double _BR_h_nue_nue;
      double _BR_h_e_e;
      double _BR_h_numu_numu;
      double _BR_h_mu_mu;
      double _BR_h_nutau_nutau;
      double _BR_h_tau_tau;
      double _BR_h_u_u;
      double _BR_h_d_d;
      double _BR_h_c_c;
      double _BR_h_s_s;
      double _BR_h_b_b;
      double _BR_h_chi10_chi10;
     
      double _normHB_GammaTotal;
      double _normHB_BR_h_g_g;
      double _normHB_BR_h_Wp_Wm;
      double _normHB_BR_h_Z0_Z0;
      double _normHB_BR_h_Z0_gamma;
      double _normHB_BR_h_gamma_gamma;
      double _normHB_BR_h_tau_tau;
      double _normHB_BR_h_mu_mu;
      double _normHB_BR_h_c_c;
      double _normHB_BR_h_s_s;
      double _normHB_BR_h_b_b;
      
      double _normSM_BR_h_g_g;
      double _normSM_BR_h_Wp_Wm;
      double _normSM_BR_h_Z0_Z0;
      double _normSM_BR_h_Z0_gamma;
      double _normSM_BR_h_gamma_gamma;
      double _normSM_BR_h_nue_nue;
      double _normSM_BR_h_e_e;
      double _normSM_BR_h_numu_numu;
      double _normSM_BR_h_mu_mu;
      double _normSM_BR_h_nutau_nutau;
      double _normSM_BR_h_tau_tau;
      double _normSM_BR_h_u_u;
      double _normSM_BR_h_d_d;
      double _normSM_BR_h_c_c;
      double _normSM_BR_h_s_s;
      double _normSM_BR_h_b_b;

      double _TEV_ggh;
      double _TEV_bbh;
      double _TEV_btagbh;
      double _TEV_Wh;
      double _TEV_Zh;
      double _TEV_qqh;
      double _TEV_tth;
    
      double _LHC7_ggh;
      double _LHC7_bbh;
      double _LHC7_btagbh;
      double _LHC7_Wh;
      double _LHC7_Zh;
      double _LHC7_qqh;
      double _LHC7_tth;

      double _LHC8_ggh;
      double _LHC8_bbh;
      double _LHC8_btagbh;
      double _LHC8_Wh;
      double _LHC8_Zh;
      double _LHC8_qqh;
      double _LHC8_tth;
      
      double _LHC14_ggh;
      double _LHC14_bbh;
      double _LHC14_btagbh;
      double _LHC14_Wh;
      double _LHC14_Zh;
      double _LHC14_qqh;
      double _LHC14_tth;
      
      double _normSM_TEV_ggh;
      double _normSM_TEV_bbh;
      double _normSM_TEV_btagbh;
      double _normSM_TEV_Wh;
      double _normSM_TEV_Zh;
      double _normSM_TEV_qqh;
      double _normSM_TEV_tth;
    
      double _normSM_LHC7_ggh;
      double _normSM_LHC7_bbh;
      double _normSM_LHC7_btagbh;
      double _normSM_LHC7_Wh;
      double _normSM_LHC7_Zh;
      double _normSM_LHC7_qqh;
      double _normSM_LHC7_tth;

      double _normSM_LHC8_ggh;
      double _normSM_LHC8_bbh;
      double _normSM_LHC8_btagbh;
      double _normSM_LHC8_Wh;
      double _normSM_LHC8_Zh;
      double _normSM_LHC8_qqh;
      double _normSM_LHC8_tth;
      
      double _normSM_LHC14_ggh;
      double _normSM_LHC14_bbh;
      double _normSM_LHC14_btagbh;
      double _normSM_LHC14_Wh;
      double _normSM_LHC14_Zh;
      double _normSM_LHC14_qqh;
      double _normSM_LHC14_tth;
      
      double _normSM_g_Abs2_h_Z0_Z0;
      double _normSM_g_Abs2_h_b_b;
      double _normSM_g_Abs2_h_tau_tau;

      
      const double& _i_GammaTotal_h0;
      // h->gg is recalculated, see above
      const double& _i_Gamma_h_Wp_Wm;
      const double& _i_Gamma_h_Z0_Z0;
      const double& _i_Gamma_h_Z0_gamma;
      const double& _i_Gamma_h_gamma_gamma;
      const double& _i_Gamma_h_nue_nue;
      const double& _i_Gamma_h_e_e;
      const double& _i_Gamma_h_numu_numu;
      const double& _i_Gamma_h_mu_mu;
      const double& _i_Gamma_h_nutau_nutau;
      const double& _i_Gamma_h_tau_tau;
      const double& _i_Gamma_h_u_u;
      const double& _i_Gamma_h_d_d;
      const double& _i_Gamma_h_c_c;
      const double& _i_Gamma_h_s_s;
      const double& _i_Gamma_h_b_b;
      const double& _i_Gamma_h_chi10_chi10;

      const double& _SM_GammaTotal_h0; 
      // h-> gg is recalculated, see above
      const double& _SM_Gamma_h_Wp_Wm;
      const double& _SM_Gamma_h_Z0_Z0;
      const double& _SM_Gamma_h_Z0_gamma;
      const double& _SM_Gamma_h_gamma_gamma;
      const double& _SM_Gamma_h_nue_nue;
      const double& _SM_Gamma_h_e_e;
      const double& _SM_Gamma_h_numu_numu;
      const double& _SM_Gamma_h_mu_mu;
      const double& _SM_Gamma_h_nutau_nutau;
      const double& _SM_Gamma_h_tau_tau;
      const double& _SM_Gamma_h_u_u;
      const double& _SM_Gamma_h_d_d;
      const double& _SM_Gamma_h_c_c;
      const double& _SM_Gamma_h_s_s;
      const double& _SM_Gamma_h_b_b;

      const double& _i_TEV_ggh;
      const double& _i_TEV_bbh;
      const double& _i_TEV_btagbh;
      const double& _i_TEV_Wh;
      const double& _i_TEV_Zh;
      const double& _i_TEV_qqh;
      const double& _i_TEV_tth;

      const double& _i_LHC7_ggh;
      const double& _i_LHC7_bbh;
      const double& _i_LHC7_btagbh;
      const double& _i_LHC7_Wh;
      const double& _i_LHC7_Zh;
      const double& _i_LHC7_qqh;
      const double& _i_LHC7_tth;
      
      const double& _i_LHC8_ggh;
      const double& _i_LHC8_bbh;
      const double& _i_LHC8_btagbh;
      const double& _i_LHC8_Wh;
      const double& _i_LHC8_Zh;
      const double& _i_LHC8_qqh;
      const double& _i_LHC8_tth;
      
      const double& _i_LHC14_ggh;
      const double& _i_LHC14_bbh;
      const double& _i_LHC14_btagbh;
      const double& _i_LHC14_Wh;
      const double& _i_LHC14_Zh;
      const double& _i_LHC14_qqh;
      const double& _i_LHC14_tth;


      const double& _SM_TEV_ggh;
      const double& _SM_TEV_bbh;
      const double& _SM_TEV_btagbh;
      const double& _SM_TEV_Wh;
      const double& _SM_TEV_Zh;
      const double& _SM_TEV_qqh;
      const double& _SM_TEV_tth;

      const double& _SM_LHC7_ggh;
      const double& _SM_LHC7_bbh;
      const double& _SM_LHC7_btagbh;
      const double& _SM_LHC7_Wh;
      const double& _SM_LHC7_Zh;
      const double& _SM_LHC7_qqh;
      const double& _SM_LHC7_tth;
      
      const double& _SM_LHC8_ggh;
      const double& _SM_LHC8_bbh;
      const double& _SM_LHC8_btagbh;
      const double& _SM_LHC8_Wh;
      const double& _SM_LHC8_Zh;
      const double& _SM_LHC8_qqh;
      const double& _SM_LHC8_tth;

      const double& _SM_LHC14_ggh;
      const double& _SM_LHC14_bbh;
      const double& _SM_LHC14_btagbh;
      const double& _SM_LHC14_Wh;
      const double& _SM_LHC14_Zh;
      const double& _SM_LHC14_qqh;
      const double& _SM_LHC14_tth;

      const double& _i_normSM_g_Abs2_h_Z0_Z0;
      const double& _i_normSM_g_Abs2_h_b_b;
      const double& _i_normSM_g_Abs2_h_tau_tau;

      const double& _i_FeynHiggs_Mass_h0;

      /*! \endcond UML */

  };


}

#endif
