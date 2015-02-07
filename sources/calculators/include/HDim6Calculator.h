/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6Calculator.h                                                *
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

#ifndef FITTINO_HDIM6CALCULATOR_H
#define FITTINO_HDIM6CALCULATOR_H

#include "CalculatorBase.h"

struct effinputs;
struct pominput;
struct sminputs;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HDim6.
   */
  class HDim6Calculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      HDim6Calculator(const ModelBase *model, boost::property_tree::ptree &ptree);

    public:
      /*!
       *  Standard destructor.
       */
      virtual       ~HDim6Calculator();
      virtual void  CalculatePredictions();
      virtual void  Initialize();

    private:
      bool          _calculate_Gamma_hWW ;
      bool          _calculate_Gamma_hZZ;
      bool          _calculate_xs_qqh_2flavor;
      bool          _calculate_xs_qqh_5flavor;
      bool          _calculate_xs_Wh;
      bool          _calculate_xs_Zh;
      bool          _first;
      double        _Delta_g1_gaga;
      double        _Delta_g1_Gamma;
      double        _Delta_g1_WW;
      double        _Delta_g1_Z;
      double        _Delta_g1_Zga;
      double        _Delta_g1_ZZ;
      double        _Delta_g2_gaga;
      double        _Delta_g2_WW;
      double        _Delta_g2_Zga;
      double        _Delta_g2_ZZ;
      double        _Delta_kappa_Gamma;
      double        _Delta_kappa_Z;
      double        _f_g;
      double        _Gamma_hbb;
      double        _Gamma_hcc;
      double        _Gamma_hgaga;
      double        _Gamma_hgg;
      double        _Gamma_hmumu;
      double        _Gamma_hss;
      double        _Gamma_htautau;
      double        _Gamma_hWW;
      double        _Gamma_hZga;
      double        _Gamma_hZZ;
      double        _normSM_Gamma_hbb;
      double        _normSM_Gamma_hcc;
      double        _normSM_Gamma_hgaga;
      double        _normSM_Gamma_hgg;
      double        _normSM_Gamma_hmumu;
      double        _normSM_Gamma_hZga;
      double        _normSM_Gamma_hss;
      double        _normSM_Gamma_htautau;
      double        _normSM_Gamma_hWW;
      double        _normSM_Gamma_hZZ;

      double        _previous_f_B;
      double        _previous_f_BB;
      double        _previous_f_W;
      double        _previous_f_WW;
      double        _previous_f_Phi_2;
      double        _previous_mass_h;
      double        _SM_Gamma_hbb;
      double        _SM_Gamma_hcc;
      double        _SM_Gamma_hgg;
      double        _SM_Gamma_hgaga;
      double        _SM_Gamma_hmumu;
      double        _SM_Gamma_hss;
      double        _SM_Gamma_htautau;
      double        _SM_Gamma_hWW;
      double        _SM_Gamma_hZga;
      double        _SM_Gamma_hZZ;

      std::vector<double>        _SM_xs_qqh_2flavor;
      std::vector<double>        _SM_xs_qqh_5flavor;
      std::vector<double>        _SM_xs_Wh;
      std::vector<double>        _SM_xs_Zh;

      std::vector<double>        _xs_qqh_2flavor;
      std::vector<double>        _xs_qqh_5flavor;
      std::vector<double>        _xs_Wh;
      std::vector<double>        _xs_Zh;

      std::vector<double>        _normSM_xs_bbh;
      std::vector<double>        _normSM_xs_bh;
      std::vector<double>        _normSM_xs_ggh;
      std::vector<double>        _normSM_xs_qqh_2flavor;
      std::vector<double>        _normSM_xs_qqh_5flavor;
      std::vector<double>        _normSM_xs_tth;
      std::vector<double>        _normSM_xs_Wh;
      std::vector<double>        _normSM_xs_Zh;

      std::string   _pdfDirectory;
      std::string   _pdfSet;
      effinputs*    _effsmvalues;
      effinputs*    _effvalues;
      sminputs*     _smvalues;

      std::vector< double > _energies;


    private:
      virtual void  CallFunction();
      virtual void  ConfigureInput();

  };

}

#endif // FITTINO_HDIM6CALCULATOR_H
