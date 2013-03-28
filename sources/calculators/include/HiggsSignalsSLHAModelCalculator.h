/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.h                                *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
#define FITTINO_HIGGSSIGNALSMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

extern "C" {
    
  void finish_higgssignals_();
  void get_rates_(int* a, int* b, int* c, int* d, double* rate);
  void higgsbounds_neutral_input_effc_( double* Mh, double* GammaTotal, double* g2hjss_s, double* g2hjss_p, double* g2hjcc_s,
      double* g2hjcc_p, double* g2hjbb_s, double* g2hjbb_p, double* g2hjtt_s, double* g2hjtt_p, double* g2hjmumu_s, double* g2hjmumu_p,
      double* g2hjtautau_s, double* g2hjtautau_p, double* g2hjWW, double* g2hjZZ, double* g2hjZga, double* g2hjgaga, double* g2hjgg,
      double* g2hjggZ, double* g2hjhiZ, double* BR_hjinvisible, double* BR_hjhihi );
  void higgssignals_neutral_input_massuncertainty_( double* dm );
  void initialize_higgssignals_latestresults_( int* nHzero, int* nHplus );
  void run_higgssignals_( int* a , double* Chisq_mu, double* Chisq_mh, double* Chisq, int* ndf, double* Pvalue );
  void setup_higgs_to_peaks_assignment_iterations_( int* iterations );
  void setup_output_level_( int* output_level );
  void setup_pdf_( int* pdf );  
  void setup_rate_uncertainty_( double* dCS[], double* dBR[] );
  double smbr_hbb_( double* x );
  double smbr_hcc_( double* x );
  double smbr_hgamgam_( double* x );
  double smbr_hgg_( double* x );
  double smbr_hmumu_( double* x );
  double smbr_hss_( double* x );
  double smbr_htautau_( double* x );
  double smbr_htoptop_( double* x );
  double smbr_hww_( double* x );
  double smbr_hzgam_( double* x );
  double smbr_hzz_( double* x );
  double smgamma_h_( double* x );

  double lhc8_rh_gg_( double* x);
  double lhc8_rh_bb_( double* x);
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

     // double       get_g2hgaga();
      double get_g2hgaga(double ghbb, double ghtt, double ghtautau, double ghWW, double ghZZ);
      double get_singleh_uncertainty(double dggh, double dbbh, double g2hgg, double g2hbb, double mh);

    public:
      virtual void Initialize() const;

      /*! \cond UML */
    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
