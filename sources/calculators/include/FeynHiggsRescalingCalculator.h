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

      double _zero;

      double _i_Gamma_h_g_g;

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

      /*! \endcond UML */

  };


}

#endif
