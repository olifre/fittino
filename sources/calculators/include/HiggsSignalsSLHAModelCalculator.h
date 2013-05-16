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
       *  Calculates the limit of BRInvisible and returns a chi2.
       */
      double       CalculateLimitofBRInvisible( double x );
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
       *  Calculates the loop-induced coupling of the Higgs boson to gluons\n
       *  from the couplings to the particles contributing to the loop.
       */
      double       Calculateg2hgg( 
                                        double ghbb,
                                        double ghtt,
                                        double massh 
                                         );
      /*!
       *  Calculates the loop-induced coupling of the Higgs boson to photons\n
       *  from the couplings to the particles contributing to the loop. 
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
       *  Calculates the total width of the Higgs boson depending on its mass\n
       *  and couplings: FORMULA! The Sum is over all couplings that were provided with the corresponding SM-Branching Ratio from Higgs Signals. GammaInvisible is used as free parameter in the model. If GammaTotal exceeds 1 GeV, the Chi2 contribution rises to 1M, forcing the MarkovChain backwards.
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
      /*!
       *  Set the (relative) rate uncertainties.
       */
      void         SetRateUncertainties(
                                        double g2hjbb_s,
                                        double g2hjbb_p,
                                        double g2hjgg,
                                        double massh
                                       );

    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSSIGNALSSLHAMODELCALCULATOR_H
