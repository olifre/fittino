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
      ///*!   
      // *  Matches scaling factors to the higgs gluon couplings in dependence to the
      // *  higgs mass.
      // */
      //double       Scaleg2hgg( std::string column, double massh );
      ///*!
      // *  Matches scaling factors to the higgs gamma couplings in dependence to the
      // *  higgs mass.
      // */
      //double       Scaleg2hgammagamma( std::string column, double massh );
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
       *
       */
      double       dm;
      /*!
       *
       */
      double       range;
      /*!
       *  4 0 = HZ production.
       */
      int          ChannelID;
      /*!
       *  collider = 1, 2, 3 for TEV, LHC7 or LHC8.
       */
      int          collider;
      /*!
       *  0: writes only block HiggsSignalsResults, 1: writes all blocks.
       */
      int          detailed;
      /*!
       *
       */
      int          iterations;
      /*!
       *  1, 2, 3 for peak-centered, masse-centered chi^2 method or both.
       */
      int          mode;
      /*!
       *
       */
      int          NChannels;
      /*!
       *  Number of Higgs particles.
       */
      int          nH;
      /*!
       *
       */
      int          nHplus;
      /*!
       *
       */
      int          nHzero;
      /*!
       *
       */
      int          nobs;
      /*!
       *  0: silent, 1: screen output, 2: even more output.
       */
      int          output_level;
      /*!
       *  1: box, 2: gaussian, 3: both.
       */
      int          pdf;

    private:
      double       CalculateBRhInvisible( double GammaTotal, double GammahInvisible );
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
      double       CalculateBRhInvisibleLimit( double x );
      /*!
       *  Calculates the SM Delta for the gluon gluon coupling that consists of \n
       *  other Higgs couplings: \n
       *  \f$\Delta_{SM}=\sqrt{\sum_{i,j}((\Delta_i+1)*(\Delta_j+1)*Scale(m_H))}-1\f$ \n
       *  The Scalefunction only works in the higgs mass range of 123-129 GeV and is  \n
       *  a linear fit of the corresponding numerical values. These values can be found\n
       *  in the images directory of the documentation, called hgg.txt and are also shown here: \n
       *  \verbatim
       m_H   G_gg               G_tt/G_gg        G_bb/G_gg         G_tb/G_gg 
       123.  0.3266293773E-03   1.113237058      0.1217362210E-01 -0.1254106798 
       124.  0.3345572863E-03   1.112305225      0.1186383935E-01 -0.1241690646 
       125.  0.3426180698E-03   1.111385465      0.1156395457E-01 -0.1229494194 
       126.  0.3508150440E-03   1.110471156      0.1127364780E-01 -0.1217448033 
       127.  0.3591490973E-03   1.109564189      0.1099182783E-01 -0.1205560165 
       128.  0.3676219090E-03   1.108663766      0.1071899652E-01 -0.1193827622 
       129.  0.3762328605E-03   1.107775663      0.1045447756E-01 -0.1182301408 
         \endverbatim
       *  <table border="1" rules="cols" cellspacing="1" cellpadding="2">
       *  <tr>
       *  <td> m_H       </td>
       *  <td> G_gg      </td>
       *  <td> G_tt/G_gg </td>
       *  <td> G_bb/G_gg </td>
       *  <td> G_tb/G_gg </td>
       *  </tr>
       *  <tr>
       *  <td> 123. </td>
       *  <td> 0.3266293773E-03 </td>
       *  <td> 1.113237058 </td>
       *  <td> 0.1217362210E-01 </td>
       *  <td> -0.1254106798 </td>
       *  </tr>
       *  <tr>
       *  <td> 124. </td>
       *  <td> 0.3345572863E-03 </td>
       *  <td> 1.112305225 </td>
       *  <td> 0.1186383935E-01 </td>
       *  <td> -0.1241690646 </td>
       *  </tr>
       *  <tr>
       *  <td> 125. </td>
       *  <td> 0.3426180698E-03 </td>
       *  <td> 1.111385465 </td>
       *  <td> 0.1156395457E-01 </td>
       *  <td> -0.1229494194 </td>
       *  </tr>
       *  <tr>
       *  <td> 126. </td>
       *  <td> 0.3508150440E-03 </td>
       *  <td> 1.110471156 </td>
       *  <td> 0.1127364780E-01 </td>
       *  <td> -0.1217448033 </td>
       *  </tr>
       *  <tr>
       *  <td> 127. </td>
       *  <td> 0.3591490973E-03 </td>
       *  <td> 1.109564189 </td>
       *  <td> 0.1099182783E-01 </td>
       *  <td> -0.1205560165 </td>
       *  </tr>
       *  <tr>
       *  <td> 128. </td>
       *  <td> 0.3676219090E-03 </td>
       *  <td> 1.108663766 </td>
       *  <td> 0.1071899652E-01 </td>
       *  <td> -0.1193827622 </td>
       *  </tr>
       *  <tr>
       *  <td> 129. </td>
       *  <td> 0.3762328605E-03 </td>
       *  <td> 1.107775663 </td>
       *  <td> 0.1045447756E-01 </td>
       *  <td> -0.1182301408 </td>
       *  </tr>
       *  </table>
       *  These are the linear fits for the gluon scaling terms:
       *  @image html hgg_tt+bb+tb.png
       *  tt: \f$-9.10*10^{-4}x + 1.23*10^{0}\f$ bb: \f$-2.86*10^{-4}x + 4.74*10^{-2}\f$ \f$1.12*10^{-3}x - 2.73*10^{-1}\f$ \n
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
       *  a linear a linear fit of the corresponding numerical values. These values can be found \n
       *  in the images directory of the documentation, called hgaga.txt and are also shown here:\n
       *  \verbatim
       m_H   G_gaga       G_tt/G_gaga  G_bb/G_gaga   G_WW/G_gaga G_tb/G_gaga 
       123.  0.86609E-05  0.72602E-01  0.20885E-04   1.5934     -0.18391E-02 
       124.  0.89615E-05  0.72048E-01  0.20152E-04   1.5911     -0.18029E-02 
       125.  0.92729E-05  0.71482E-01  0.19444E-04   1.5887     -0.17672E-02 
       126.  0.95959E-05  0.70904E-01  0.18760E-04   1.5863     -0.17319E-02 
       127.  0.99309E-05  0.70312E-01  0.18099E-04   1.5838     -0.16970E-02 
       128.  0.10279E-04  0.69708E-01  0.17460E-04   1.5812     -0.16625E-02 
       129.  0.10640E-04  0.69090E-01  0.16842E-04   1.5785     -0.16283E-02 
     
       m_H  G_tW/G_gaga  G_bW/G_gaga G_ll/G_gaga  G_tl/G_gaga  G_bl/G_gaga  G_lW/G_gaga
       123.  -0.68026      0.86351E-02 0.25148E-04 -0.19851E-02  0.45838E-04  0.93221E-02
       124.  -0.67717      0.84914E-02 0.24292E-04 -0.19461E-02  0.44253E-04  0.91672E-02
       125.  -0.67400      0.83495E-02 0.23464E-04 -0.19077E-02  0.42720E-04  0.90143E-02
       126.  -0.67074      0.82093E-02 0.22663E-04 -0.18696E-02  0.41239E-04  0.88634E-02
       127.  -0.66741      0.80708E-02 0.21888E-04 -0.18321E-02  0.39806E-04  0.87144E-02
       128.  -0.66399      0.79339E-02 0.21138E-04 -0.17949E-02  0.38421E-04  0.85671E-02
       129.  -0.66048      0.77984E-02 0.20411E-04 -0.17581E-02  0.37079E-04  0.84215E-02   
         \endverbatim
       *  <table border="1" rules="cols" cellspacing="1" cellpadding="2">
       *  <tr>
       *  <td> m_H             </td>
       *  <td> G_gaga          </td>
       *  <td> G_tt/G_gaga     </td>
       *  <td> G_bb/G_gaga     </td>
       *  <td> G_WW/G_gaga     </td>
       *  <td> G_tb/G_gaga     </td>
       *  </tr>
       *  <tr>
       *  <td> 123. </td>
       *  <td> 0.86609E-05 </td>
       *  <td> 0.72602E-01 </td>
       *  <td> 0.20885E-04 </td>
       *  <td> 1.5934 </td>
       *  <td> -0.18391E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 124. </td>
       *  <td> 0.89615E-05 </td>
       *  <td> 0.72048E-01 </td>
       *  <td> 0.20152E-04 </td>
       *  <td> 1.5911 </td>
       *  <td> -0.18029E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 125. </td>
       *  <td> 0.92729E-05 </td>
       *  <td> 0.71482E-01 </td>
       *  <td> 0.19444E-04 </td>
       *  <td> 1.5887 </td>
       *  <td> -0.17672E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 126. </td>
       *  <td> 0.95959E-05 </td>
       *  <td> 0.70904E-01 </td>
       *  <td> 0.18760E-04 </td>
       *  <td> 1.5863 </td>
       *  <td> -0.17319E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 127. </td>
       *  <td> 0.99309E-05 </td>
       *  <td> 0.70312E-01 </td>
       *  <td> 0.18099E-04 </td>
       *  <td> 1.5838 </td>
       *  <td> -0.16970E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 128. </td>
       *  <td> 0.10279E-04 </td>
       *  <td> 0.69708E-01 </td>
       *  <td> 0.17460E-04 </td>
       *  <td> 1.5812 </td>
       *  <td> -0.16625E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 129. </td>
       *  <td> 0.10640E-04 </td>
       *  <td> 0.69090E-01 </td>
       *  <td> 0.16842E-04 </td>
       *  <td> 1.5785 </td>
       *  <td> -0.16283E-02 </td>
       *  </tr>
       *  </table>
       *  <table border="1" rules="cols" cellspacing="1" cellpadding="2">
       *  <tr>
       *  <td> m_H             </td>
       *  <td> G_tW            </td>
       *  <td> G_bW/G_gaga     </td>
       *  <td> G_tautau/G_gaga </td>
       *  <td> G_ttau/G_gaga   </td>
       *  <td> G_btau/G_gaga   </td>
       *  <td> G_tauW/G_gaga   </td>
       *  </tr>
       *  <tr>
       *  <td> 123. </td>
       *  <td> -0.68026 </td>
       *  <td> 0.86351E-02 </td>
       *  <td> 0.25148E-04 </td>
       *  <td> -0.19851E-02 </td>
       *  <td> 0.45838E-04 </td>
       *  <td> 0.93221E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 124. </td>
       *  <td> -0.67717 </td>
       *  <td> 0.84914E-02 </td>
       *  <td> 0.24292E-04 </td>
       *  <td> -0.19461E-02 </td>
       *  <td> 0.44253E-04 </td>
       *  <td> 0.91672E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 125. </td>
       *  <td> -0.67400 </td>
       *  <td> 0.83495E-02 </td>
       *  <td> 0.23464E-04 </td>
       *  <td> -0.19077E-02 </td>
       *  <td> 0.42720E-04 </td>
       *  <td> 0.90143E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 126. </td>
       *  <td> -0.67074 </td>
       *  <td> 0.82093E-02 </td>
       *  <td> 0.22663E-04 </td>
       *  <td> -0.18696E-02 </td>
       *  <td> 0.41239E-04 </td>
       *  <td> 0.88634E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 127. </td>
       *  <td> -0.66741 </td>
       *  <td> 0.80708E-02 </td>
       *  <td> 0.21888E-04 </td>
       *  <td> -0.18321E-02 </td>
       *  <td> 0.39806E-04 </td>
       *  <td> 0.87144E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 128. </td>
       *  <td> -0.66399 </td>
       *  <td> 0.79339E-02 </td>
       *  <td> 0.21138E-04 </td>
       *  <td> -0.17949E-02 </td>
       *  <td> 0.38421E-04 </td>
       *  <td> 0.85671E-02 </td>
       *  </tr>
       *  <tr>
       *  <td> 129. </td>
       *  <td> 	-0.66048 </td>
       *  <td> 0.77984E-02 </td>
       *  <td> 0.20411E-04 </td>
       *  <td> -0.17581E-02 </td>
       *  <td> 0.37079E-04 </td>
       *  <td> 0.84215E-02 </td>
       *  </tr>
       *  </table>
       *  These are the linear fits for the gamma scaling terms:
       *  @image html hgaga_tt+bb+tb.png
       *  tt: \f$-5.85*10^{-4}x + 1.45*10^{-1}\f$ bb: \f$-6.74*10^{-7}x + 1.04*10^{-4}\f$ tb: \f$3.51*10^{-5}x - 6.16*10^{-3}\f$
       *  @image html hgaga_WW+tW+bW.png
       *  WW: \f$-2.48*10^{-3}x + 1.90*10^{0}\f$ tW: \f$3.30*10^{-3}x - 1..09*10^{0}\f$ bW: \f$-1.39*10^{-4}x - 2.58*10^{-2}\f$
       *  @image html hgaga_tautau+ttau+btau.png
       *  tautau: \f$-7.89*10^{-7}x + 1.22*10^{-4}\f$ tW: \f$3.78*10^{-5}x - 6.64*10^{-3}\f$ 
       *  bW: \f$-1.46*10^{-6}x + 2.25*10^{-4}\f$
       *  @image html hgaga_tauW.png
       *  tauW: \f$-1.50*10^{-4}x + 2.78*10^{-2}\f$ \n
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
      double       CalculateBR(
                                        double g2hjxx,
                                        double massh,
                                        double GammaTotal,
                                        double BR_SM
                                      );


    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );
  
  };

}

#endif // FITTINO_HIGGSSIGNALSSLHAMODELCALCULATOR_H
