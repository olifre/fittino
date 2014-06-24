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


      /*! \endcond UML */

  };


}

#endif
