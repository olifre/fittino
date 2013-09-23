/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.h                                           *
*                                                                              *
* Description Wrapper class for HDim6                                          *
*                                                                              *
* Authors     Bastian Heller    <bastian.heller@rwth-aachen.de>                *
*             Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HDIM6MODELCALCULATOR_H
#define FITTINO_HDIM6MODELCALCULATOR_H

#include <map>
#include "ModelCalculatorBase.h"

struct effinputs;
struct sminputs;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HDim6 
   */
  class HDim6ModelCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                               HDim6ModelCalculator( const PhysicsModelBase* model );

    public:
      /*!
       *  Standard destructor.
       */
      virtual                  ~HDim6ModelCalculator();

    public:
      virtual void             CalculatePredictions();
      virtual void             Initialize() const;

    private:  
      double                   _Delta_g1_gaga;
      double                   _Delta_g1_Gamma;
      double                   _Delta_g1_WW;
      double                   _Delta_g1_Z;
      double                   _Delta_g1_Zga;
      double                   _Delta_g1_ZZ;
      double                   _Delta_g2_gaga;
      double                   _Delta_g2_WW;
      double                   _Delta_g2_Zga;
      double                   _Delta_g2_ZZ;
      double                   _Delta_kappa_Gamma;
      double                   _Delta_kappa_Z;
      double                   _Gamma_hbb;
      double                   _Gamma_hcc;
      double                   _Gamma_hgaga;
      double                   _Gamma_hgg;
      double                   _Gamma_hmumu;
      double                   _Gamma_hss;
      double                   _Gamma_htautau;
      double                   _Gamma_hWW;
      double                   _Gamma_hZga;
      double                   _Gamma_hZZ;
      double                   _normSM_Gamma_hbb;
      double                   _normSM_Gamma_hcc;
      double                   _normSM_Gamma_hgaga;
      double                   _normSM_Gamma_hgg;
      double                   _normSM_Gamma_hmumu;
      double                   _normSM_Gamma_hZga;
      double                   _normSM_Gamma_hss;
      double                   _normSM_Gamma_htautau;
      double                   _normSM_Gamma_hWW;
      double                   _normSM_Gamma_hZZ;
      double                   _normSM_xs_bbh;
      double                   _normSM_xs_bh;
      double                   _normSM_xs_ggh;
      double                   _normSM_xs_qqh;
      double                   _normSM_xs_tth;
      double                   _normSM_xs_Wh;
      double                   _normSM_xs_Zh;
      double                   _SM_Gamma_hbb;
      double                   _SM_Gamma_hcc;
      double                   _SM_Gamma_hgg;
      double                   _SM_Gamma_hgaga;
      double                   _SM_Gamma_hmumu;
      double                   _SM_Gamma_hss;
      double                   _SM_Gamma_htautau;
      double                   _SM_Gamma_hWW;
      double                   _SM_Gamma_hZga;
      double                   _SM_Gamma_hZZ;
      double                   _SM_xs_ggh;
      double                   _SM_xs_qqh;
      double                   _SM_xs_Wh;
      double                   _SM_xs_Zh;
      double                   _xs_ggh;
      double                   _xs_qqh;
      double                   _xs_Wh;
      double                   _xs_Zh;
      std::string              _pdfDirectory;
      std::string              _pdfSet;
      effinputs*               _effsmvalues;
      effinputs*               _effvalues;
      effinputs*               _previousEffValues;
      sminputs*                _previousSMValues;
      sminputs*                _smvalues;

    private:  
      const double&            _f_B;
      const double&            _f_BB;
      const double&            _f_gg;
      const double&            _f_b;
      const double&            _f_c;
      const double&            _f_d;
      const double&            _f_e;
      const double&            _f_mu;
      const double&            _f_s;
      const double&            _f_t;
      const double&            _f_tau;
      const double&            _f_u;
      const double&            _f_W;
      const double&            _f_WW;
      const double&            _mass_h;

      
/*       double _kappa_BB; */
/*       double _kappa_GG; */

/*       double _c_H;  */
/*       double _c_V_p;  */

/*       double _k_m; */

/*       double _kappa_HV_m; */
/*       double _c_V_m;  */



    private:   
      void                     ComparePreviousEffValues();
      void                     ComparePreviousSMValues();

    private:
      virtual void             CallExecutable();
      virtual void             CallFunction();
      virtual void             ConfigureInput();

  };

}

#endif // FITTINO_HDIM6MODELCALCULATOR_H
