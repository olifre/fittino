/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsCalculatorBase.h                                        *
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

#ifndef FITTINO_FEYNHIGGSCALCULATORBASE_H
#define FITTINO_FEYNHIGGSCALCULATORBASE_H

#include "ModelCalculatorBase.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsCalculatorBase : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsCalculatorBase( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual ~FeynHiggsCalculatorBase();

    protected:  
      int         _error;
      std::string _fileName;


    protected:  
      void Calculate();
      void SetFlags();

      /*! \cond UML */
    private:  

      double _mass_h;

      double _normSM_sigma_ggh;
      double _normSM_sigma_ggh_2;
      double _normSM_sigma_bbh;
      double _normSM_sigma_qqh;
      double _normSM_sigma_tth;
      double _normSM_sigma_Wh;
      double _normSM_sigma_Zh;

      double _normSM_Gamma_h_tau_tau;
      double _normSM_Gamma_h_c_c;
      double _normSM_Gamma_h_s_s;
      double _normSM_Gamma_h_b_b;
      double _normSM_Gamma_h_gamma_gamma;
      double _normSM_Gamma_h_Z_gamma;
      double _normSM_Gamma_h_Z_Z;
      double _normSM_Gamma_h_W_W;
      double _normSM_Gamma_h_g_g;
      double _normSM_Gamma_h_total;
      
      /*! \endcond UML */

  };

}

#endif
