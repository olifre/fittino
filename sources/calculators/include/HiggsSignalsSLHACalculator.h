/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHACalculator.h                                     *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSSLHACALCULATOR_H
#define FITTINO_HIGGSSIGNALSSLHACALCULATOR_H

#include "SLHAModelCalculatorBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals.
   */
  class HiggsSignalsSLHACalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      HiggsSignalsSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HiggsSignalsSLHACalculator();

    public:
      virtual void  Initialize() const;
      virtual void CalculatePredictions();

      /*! \cond UML */
    private:
      /*!
       *  Calculates the uncertainty on the "SingleH" production mode (see e.g.\n
       *  the HiggsSignals manual) by interpolating between pure bbh and ggh\n
       *  production.
       */
      double        CalculateSinglehUncertainty(
                                                 double d_hbb,
                                                 double d_hgg,
                                                 double g2_hbb,
                                                 double g2_hgg,
                                                 double mass_h
                                               );
      /*!
       *  Set the (relative) rate uncertainties.
       */
      void          SetRateUncertainties       (
                                                 double g2_hibb_s,
                                                 double g2_hibb_p,
                                                 double g2_higg,
                                                 double mass_h
                                               );

      /*! \endcond UML */

    private:
      double        _Gamma_hTotal;
      double        _BR_hss;
      double        _BR_hcc;
      double        _BR_hbb;
      double        _BR_htt;
      double        _BR_hmumu;
      double        _BR_htautau;
      double        _BR_hWW;
      double        _BR_hZZ;
      double        _BR_hZgamma;
      double        _BR_hgammagamma;
      double        _BR_hgg;
      double        _BR_hss_SM;
      double        _BR_hcc_SM;
      double        _BR_hbb_SM;
      double        _BR_htt_SM;
      double        _BR_hmumu_SM;
      double        _BR_htautau_SM;
      double        _BR_hWW_SM;
      double        _BR_hZZ_SM;
      double        _BR_hZgamma_SM;
      double        _BR_hgammagamma_SM;
      double        _BR_hgg_SM;
      double        _BR_hInvisible;
      double        _g2_SM_hgammagamma;
      double        _g2_SM_hgg;
      double        _BR_hInvisible_Limit;
      double        _chi2;
      double        _chi2_massh;
      double        _chi2_mu;
      /*!
       *
       */
      double        _dm;
      /*!
       *
       */
      double        _Gamma_hTotal_Penalty;
      double        _Mu_hgammgamma_1lep_ATL;
      double        _Mu_hgammgamma_conv_central_highPTt_ATL;
      double        _Mu_hgammgamma_conv_central_lowPTt_ATL;
      double        _Mu_hgammgamma_conv_rest_highPTt_ATL;
      double        _Mu_hgammgamma_conv_rest_lowPTt_ATL;
      double        _Mu_hgammgamma_conv_trans_ATL;
      double        _Mu_hgammgamma_ETmiss_ATL;
      double        _Mu_hgammgamma_highmass2jetloose_ATL;
      double        _Mu_hgammgamma_highmass2jettight_ATL;
      double        _Mu_hgammgamma_lowmass2jet_ATL;
      double        _Mu_hgammgamma_unconv_central_highPTt_ATL;
      double        _Mu_hgammgamma_unconv_central_lowPTt_ATL;
      double        _Mu_hgammgamma_unconv_rest_highPTt_ATL;
      double        _Mu_hgammgamma_unconv_rest_lowPTt_ATL;
      double        _Mu_htautau_ATL;
      double        _Mu_hWWlnulnu_ATL;
      double        _Mu_VBFWWlnulnu_ATL;
      double        _Mu_hZZ4l_ATL;
      double        _Mu_VhVbb_ATL;
      double        _Mu_hgammagamma_CDF;
      double        _Mu_htautau_CDF;
      double        _Mu_hWW_CDF;
      double        _Mu_tthttbb_CDF;
      double        _Mu_VhVbb_CDF;
      double        _Mu_hgammagamma_2jet_CMS;
      double        _Mu_hgammagamma_2jetloose_CMS;
      double        _Mu_hgammagamma_2jettight_CMS;
      double        _Mu_hgammagamma_e_CMS;
      double        _Mu_hgammagamma_inclusive_CMS;
      double        _Mu_hgammagamma_ETmiss_CMS;
      double        _Mu_hgammagamma_mu_CMS;
      double        _Mu_htautau_01jet_CMS;
      double        _Mu_hWW_01jet_CMS;
      double        _Mu_hZZ4l_01jet_CMS;
      double        _Mu_hZZ4l_2jet_CMS;
      double        _Mu_tthttbb_CMS;
      double        _Mu_VBFtautau_CMS;
      double        _Mu_VBFWW_CMS;
      double        _Mu_VhVbb_CMS;
      double        _Mu_VhVtautau_CMS;
      double        _Mu_WhWWW_CMS;
      double        _Mu_hbb_D0;
      double        _Mu_hgammagamma_D0;
      double        _Mu_htautau_D0;
      double        _Mu_hWW_D0;
      double        _pvalue;
      double        _range;
      double        _R_H_WW;
      double        _R_H_ZZ;
      double        _R_H_gammagamma;
      double        _R_H_tautau;
      double        _R_H_bb;
      double        _R_VH_bb;
      /*!
       *  4 0 = HZ production.
       */
      int           _channelID;
      /*!
       *  collider = 1, 2, 3 for TEV, LHC7 or LHC8.
       */
      int           _collider;
      /*!
       *  0: writes only block HiggsSignalsResults, 1: writes all blocks.
       */
      int           _detailed;
      /*!
       *
       */
      int           _iterations;
      /*!
       *  1, 2, 3 for peak-centered, masse-centered chi^2 method or both.
       */
      int           _mode;
      /*!
       *
       */
      int           _nChannels;
      /*!
       *  Number of Higgs particles.
       */
      int           _nH;
      /*!
       *
       */
      int           _nHplus;
      /*!
       *
       */
      int           _nHzero;
      /*!
       *
       */
      int           _nobs;
      /*!
       *  0: silent, 1: screen output, 2: even more output.
       */
      int           _output_level;
      /*!
       *  1: box, 2: gaussian, 3: both.
       */
      int           _pdf;

    private:
      double const& _BR_hihjhj;
      double const& _g_hiss_s;
      double const& _g_hiss_p;
      double const& _g_hicc_s;
      double const& _g_hicc_p;
      double const& _g_hibb_s;
      double const& _g_hibb_p;
      double const& _g_hitt_s;
      double const& _g_hitt_p;
      double const& _g_himumu_s;
      double const& _g_himumu_p;
      double const& _g_hitautau_s;
      double const& _g_hitautau_p;
      double const& _g_hiWW;
      double const& _g_hiZZ;
      double const& _g_hiZga;
      double const& _g_higaga;
      double const& _g_higg;
      double const& _g_higgZ;
      double const& _g_hihjZ;
      double const& _GammaInvisible;
      double const& _mass_h;

    private:
      double        CalculateBRhInvisible( double Gamma_hTotal, double Gamma_hInvisible );
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
      double        CalculateBRhInvisibleLimit( double x );
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
      double        Calculateg2hgg        (
                                            double g_hbb,
                                            double g_htt,
                                            double mass_h
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
      double        Calculateg2hgammagamma(
                                            double g_hbb,
                                            double g_htt,
                                            double g_htautau,
                                            double g_hWW,
                                            double g_hZZ,
                                            double mass_h
                                          );
      /*!
       *  Calculates the total width of the Higgs boson depending on its mass\n
       *  and couplings: \n
       *  \f$(1+\sum_i((\Delta_i-1)*(SMBR)_i(m_H)))\f$ + Gamma-Invisible \n
       *  The Sum is over all couplings that were provided with the \n
       *  corresponding SM-Branching Ratio from Higgs Signals. \n
       *  GammaInvisible is used as free parameter in the model. \n
       *  If GammahTotal exceeds 1 GeV, the Chi2 contribution rises to 1M,\n
       *  forcing the MarkovChain backwards.
       */
      double        CalculateGammahTotal  (
                                            double mass_h,
                                            double g2_hiss_s,
                                            double g2_hicc_s,
                                            double g2_hibb_s,
                                            double g2_hitt_s,
                                            double g2_himumu_s,
                                            double g2_hitautau_s,
                                            double g2_hiWW,
                                            double g2_hiZZ,
                                            double g2_hiZga,
                                            double g2_higaga,
                                            double g2_higg,
                                            double Gamma_hInvisible
                                          );

      /*!
       *  Calculates the total width of the Higgs boson depending on its mass\n
       *  and couplings: \n
       *  \f$(1+\sum_i((\Delta_i-1)*(SMBR)_i(m_H)))\f$ + Gamma-Invisible \n
       *  The Sum is over all couplings that were provided with the \n
       *  corresponding SM-Branching Ratio from Higgs Signals. \n
       *  GammaInvisible is used as free parameter in the model. \n
       *  If GammahTotal exceeds 1 GeV, the Chi2 contribution rises to 1M,\n
       *  forcing the MarkovChain backwards.
       */
      double        CalculateBR           (
                                            double g2_hixx,
                                            double mass_h,
                                            double Gamma_hTotal,
                                            double BR_SM
                                          );

  };

}

#endif // FITTINO_HIGGSSIGNALSSLHACALCULATOR_H
