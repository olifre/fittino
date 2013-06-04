/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.h                                *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSSLHAMODELCALCULATOR_H
#define FITTINO_HIGGSSIGNALSSLHAMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

extern "C" {

  double smbr_hss_( double* massh );
  double smbr_hcc_( double* massh );
  double smbr_hbb_( double* massh );
  double smbr_htoptop_( double* massh );
  double smbr_hmumu_( double* massh );
  double smbr_htautau_( double* massh );
  double smbr_hgamgam_( double* massh );
  double smbr_hgg_( double* massh );
  double smbr_hww_( double* massh );
  double smbr_hzgam_( double* massh );
  double smbr_hzz_( double* massh );
  double smgamma_h_( double* massh );

  double __theory_collidersfunctions_MOD_lhc8_rh_bb( double* massh );
  double __theory_collidersfunctions_MOD_lhc8_rh_gg( double* massh );

  void finish_higgssignals_();
  void get_rates_(
                   int*    ii,
                   int*    collider,
                   int*    Nchannels,
                   int*    IDchannels,
                   double* rate
                 ); 
  void get_rvalues_(
                   int*    nH,
                   int*    collider,
                   double* R_H_WW,
                   double* R_H_ZZ,
                   double* R_H_gaga,
                   double* R_H_tautau,
                   double* R_H_bb,
                   double* R_VH_bb
                   );
  void higgsbounds_neutral_input_effc_(
                   double* massh,
                   double* GammaTotal,
                   double* g2hjss_s,
                   double* g2hjss_p,
                   double* g2hjcc_s,
                   double* g2hjcc_p,
                   double* g2hjbb_s,
                   double* g2hjbb_p,
                   double* g2hjtt_s,
                   double* g2hjtt_p,
                   double* g2hjmumu_s,
                   double* g2hjmumu_p,
                   double* g2hjtautau_s,
                   double* g2hjtautau_p,
                   double* g2hjWW,
                   double* g2hjZZ,
                   double* g2hjZga,
                   double* g2hjgaga,
                   double* g2hjgg,
                   double* g2hjggZ,
                   double* g2hjhiZ,
                   double* BR_hjinvisible,
                   double* BR_hjhihi
                                      );
  void higgssignals_neutral_input_massuncertainty_( double* dm );
  void initialize_higgssignals_for_fittino_( int* nHzero, int* nHplus );
  void initialize_higgssignals_latestresults_( int* nHzero, int* nHplus );
  void run_higgssignals_(
                   int*    mode,
                   double* Chisq_mu,
                   double* Chisq_mh,
                   double* Chisq,
                   int*    nobs,
                   double* Pvalue
                        );
  void setup_assignmentrange_( double* range );
  void setup_correlations_( int* corr_mu, int* corr_mh);
  void setup_higgs_to_peaks_assignment_iterations_( int* iterations );
  void setup_output_level_( int* output_level );
  void setup_pdf_( int* pdf );
  void setup_rate_uncertainties_( double dCS[], double dBR[] );
 
  void __io_MOD_higgssignals_create_slha_output_default( int* detailed );
  
}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals.
   */
  class HiggsSignalsSLHAModelCalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   HiggsSignalsSLHAModelCalculator();
      /*!
       *  Standard destructor.
       */
                   ~HiggsSignalsSLHAModelCalculator();

    public:
      virtual void Initialize() const;

      /*! \cond UML */
    private:
      /*!
       *  Returns a linear function mx + b, given by two coordinates.
       */     
      double       Linearfunction( double massh, double x2, double x1, double y2, double y1 );
      /*!   
       *  Matches scaling factors to the higgs gluon couplings in dependence to the
       *  higgs mass.
       */
      double       Scaleg2hgg( std::string column, double massh );
      /*!
       *  Matches scaling factors to the higgs gamma couplings in dependence to the
       *  higgs mass.
       */
      double       Scaleg2hgammagamma( std::string column, double massh );
      /*!
       *  Calculates the uncertainty on the "SingleH" production mode (see e.g.\n
       *  the HiggsSignals manual) by interpolating between pure bbh and ggh\n
       *  production.
       */
      double       CalculateSinglehUncertainty(
                                        double dhbb,
                                        double dhgg,
                                        double g2hbb,
                                        double g2hgg,
                                        double massh
                                              );
      /*!
       *  Set the (relative) rate uncertainties.
       */
      void         SetRateUncertainties(
                                        double g2hjbb_s,
                                        double g2hjbb_p,
                                        double g2hjgg,
                                        double massh
                                       );

      /*! \endcond UML */

    private:
      /*!
       *  Calculates the limit of BRInvisible and returns a \f$ \chi^{2}\f$. The calculation \n
       *  is given by a polynomial fit of 10th degree. \n
       *  @image html grad10_parabel_small40.png
       *  fit = \f$3090.5x^{10} - 16155x^{9} + 36200.6x^{8} - 45432.4x^{7}\f$ \n
       *  \f$+ 35006.7x^{6} - 17068.7x^{5} + 5228.65x^{4} - 963.046x^{3}\f$ \n
       *  \f$+ 100.961x^{2}\f$ \n
       *  This fit is used between BRInvisible = 0 and 1 . For the region > 1 the fit \n
       *  is replaced by a function of second degree, in order to have a physical  \n
       *  continuation of the data.\n
       *  parabel = \f$3.322x^{2} + 4.92x\f$ \n
       *  The data shown in the fit can found in the images directory of the documentation, called brinvisible.txt
       */
      double       CalculateLimitofBRInvisible( double x );
      /*!
       *  Calculates the SM Delta for the gluon gluon coupling that consists of \n
       *  other Higgs couplings: \n
       *  \f$\Delta_{SM}=\sqrt{\sum_{i,j}((\Delta_i+1)*(\Delta_j+1)*Scale(m_H))}-1\f$ \n
       *  The Scalefunction only works in the higgs mass range of 123-129 GeV and is  \n
       *  a linear fit of the corresponding numerical values. These values \n
       *  can be found in the images directory of the documentation, called hgg.txt \n
       *  These are the linear fits for the gluon scaling terms:
       *  @image html hgg_tt+bb+tb.png
       *  tt: \f$-9.1*10^{-4}x + 1.23\f$ bb: \f$-2.86*10^{-4}x + 0.047\f$ \f$1.12*10^{-3}x - 0.27\f$ \n
       *  A gnuplot script to reproduce the plots, called linearfit.gnu, \n
       *  can be found in the images directory of the documentation.
       */
     double       Calculateg2hgg(
                                        double ghbb,
                                        double ghtt,
                                        double massh
                                         );
      /*!
       *  Calculates the SM Delta for the phonton photon coupling that consists of \n
       *  other Higgs couplings: \n
       *  \f$\Delta_{SM}=\sqrt{\sum_{i,j}((\Delta_i+1)*(\Delta_j+1)*Scale(m_H))}-1\f$ \n
       *  The Scalefunction only works in the higgs mass range of 123-129 GeV and is \n
       *  a linear a linear fit of the corresponding numerical values. These values\n
       *  can be found in the images directory of the documentation, called hgaga.txt \n
       *  These are the linear fits for the gamma scaling terms:
       *  @image html hgaga_tt+bb+tb.png
       *  tt: \f$-5.85*10^{-4}x + 0.145\f$ bb: \f$-6.74*10^{-7}x + 1.04*10^{-4}\f$ tb: \f$3.51*10^{-5}x - 6.16*10^{-3}\f$
       *  @image html hgaga_WW+tW+bW.png
       *  WW: \f$-2.48*10^{-3}x + 1.9\f$ tW: \f$3.3*10^{-3}x - 1.09\f$ bW: \f$-1.39*10^{-4}x - 0.0258\f$
       *  @image html hgaga_tautau+ttau+btau.png
       *  tautau: \f$-7.89*10^{-7}x + 1.22*10^{-4}\f$ tW: \f$3.78*10^{-5}x - 6.64*10^{-3}\f$ 
       *  bW: \f$-1.46*10^{-6}x + 2.25*10^{-4}\f$
       *  @image html hgaga_tauW.png
       *  tauW: \f$-1.5*10^{-4}x + 0.0278\f$ \n
       *  A gnuplot script to reproduce the plots, called linearfit.gnu, \n
       *  can be found in the images directory of the documentation.
       */
      double       Calculateg2hgammagamma(
                                        double ghbb,
                                        double ghtt,
                                        double ghtautau,
                                        double ghWW,
                                        double ghZZ,
                                        double massh
                                         );
      /*!
       *  Calculates the total width of the Higgs boson depending on its mass\n
       *  and couplings: \n
       *  \f$(1+\sum_i((\Delta_i-1)*(SMBR)_i(m_H)))\f$ + Gamma-Invisible \n
       *  The Sum is over all couplings that were provided with the \n
       *  corresponding SM-Branching Ratio from Higgs Signals. \n
       *  GammaInvisible is used as free parameter in the model. \n
       *  If GammaTotal exceeds 1 GeV, the Chi2 contribution rises to 1M,\n
       *  forcing the MarkovChain backwards.
       */
      double       CalculateGammaTotal(
                                        double massh,
                                        double g2hjss_s,
                                        double g2hjcc_s,
                                        double g2hjbb_s,
                                        double g2hjtt_s,
                                        double g2hjmumu_s,
                                        double g2hjtautau_s,
                                        double g2hjWW,
                                        double g2hjZZ,
                                        double g2hjZga,
                                        double g2hjgaga,
                                        double g2hjgg,
                                        double GammaInvisible
                                      );

    /*! \cond UML */
    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );

    /*! \endcond UML */   

  };

}

#endif // FITTINO_HIGGSSIGNALSSLHAMODELCALCULATOR_H
