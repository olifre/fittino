#include "decay.h"

void initeffwidths_( sminputs * smpar, effinputs * effpar )
{
  /* H_gluglu & H_Digamma and HZgamma */
  hglgl_( smpar, effpar, &T_hglgl_eff, &err_hglgl_eff );
  hgaga_( smpar, effpar, &T_hgaga_eff, &err_hgaga_eff );
  hgaz_(  smpar, effpar, &T_hgaz_eff,  &err_hgaz_eff  );
  /* H_difermion */
  // helel_( smpar, effpar, &T_helel_eff, &err_helel_eff );
  hmumu_( smpar, effpar, &T_hmumu_eff, &err_hmumu_eff );
  htata_( smpar, effpar, &T_htata_eff, &err_htata_eff );
  // hupup_( smpar, effpar, &T_hupup_eff, &err_hupup_eff );
  // hdodo_( smpar, effpar, &T_hdodo_eff, &err_hdodo_eff );
  hchch_( smpar, effpar, &T_hchch_eff, &err_hchch_eff );
  hstst_( smpar, effpar, &T_hstst_eff, &err_hstst_eff );
  hbobo_( smpar, effpar, &T_hbobo_eff, &err_hbobo_eff );
  chi_hmumu_eff = 1; chi_htata_eff = 1; chi_hchch_eff = 1; chi_hstst_eff = 1;
  chi_hbobo_eff = 1; chi_hgaga_eff = 1; chi_hglgl_eff = 1; chi_hgaz_eff  = 1;
  
  hzz_( smpar, effpar, &T_hzz_eff, &err_hzz_eff, &chi_hzz_eff );
  hww_( smpar, effpar, &T_hww_eff, &err_hww_eff, &chi_hww_eff );

  T_eff = T_hglgl_eff+T_hgaga_eff+T_hmumu_eff+T_htata_eff+T_hbobo_eff+T_hchch_eff+T_hstst_eff+T_hww_eff+T_hzz_eff+T_hgaz_eff;
  err_T_eff = err_hww_eff + err_hzz_eff; /* Die anderen werden nicht numerisch berechnet, Fehler sind daher hier Null */
};

void initsmwidths_( sminputs * smpar )
{
  effinputs temp;
  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
  
  /* H_gluglu & H_Digamma and HZgamma */
  hglgl_( smpar, &temp, &T_hglgl_sm, &err_hglgl_sm );
  hgaga_( smpar, &temp, &T_hgaga_sm, &err_hgaga_sm );
  hgaz_(  smpar, &temp, &T_hgaz_sm,  &err_hgaz_sm  );
  /* H_difermion */                                                                                                                                                                                  
  hmumu_( smpar, &temp, &T_hmumu_sm, &err_hmumu_sm );
  htata_( smpar, &temp, &T_htata_sm, &err_htata_sm );
  hchch_( smpar, &temp, &T_hchch_sm, &err_hchch_sm );
  hstst_( smpar, &temp, &T_hstst_sm, &err_hstst_sm );
  hbobo_( smpar, &temp, &T_hbobo_sm, &err_hbobo_sm );
  chi_hmumu_sm = 1; chi_htata_sm = 1; chi_hchch_sm = 1; chi_hstst_sm = 1;
  chi_hbobo_sm = 1; chi_hgaga_sm = 1; chi_hglgl_sm = 1; chi_hgaz_sm  = 1;

  hzz_( smpar, &temp, &T_hzz_sm, &err_hzz_sm, &chi_hzz_sm );
  hww_( smpar, &temp, &T_hww_sm, &err_hww_sm, &chi_hww_sm );

  T_sm = T_hglgl_sm+T_hgaga_sm+T_hmumu_sm+T_htata_sm+T_hbobo_sm+T_hchch_sm+T_hstst_sm+T_hww_sm+T_hzz_sm+T_hgaz_sm;
  err_T_sm = err_hww_sm + err_hzz_sm; /* Die anderen werden nicht numerisch berechnet, Fehler sind daher hier Null */

};

/* Returns the total width of H in the effective framework */

void totalwidth_( sminputs * smpar, effinputs * effpar, double * tWidth, double * tError, double * tChi )
{
  *tWidth = T_eff / T_sm * smpar->sm_width;
  *tError = (err_T_eff / T_sm + err_T_eff / pow( T_sm, 2) * err_T_sm)*smpar->sm_width + T_eff/T_sm * smpar->sm_width_err;
  *tChi = ( fabs( chi_hww_eff - 1 ) > fabs( chi_hzz_eff -1 ) ? chi_hww_eff : chi_hzz_eff );
};

/* Verzweigungsverhaeltnisse des Higgs Bosons im Rahmen der K-Faktor-Beruecksichtigung der Korrekturrechnungen */

void br_hbb_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hbobo_eff/T_eff*T_sm/T_hbobo_sm*smpar->br_h_bb;
  *err = T_hbobo_eff/T_eff*T_sm/T_hbobo_sm*smpar->err_h_bb;
  *chi = chi_hbobo_eff;
};

void br_hcc_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hchch_eff/T_eff*T_sm/T_hchch_sm*smpar->br_h_cc;
  *err = T_hchch_eff/T_eff*T_sm/T_hchch_sm*smpar->err_h_cc;
  *chi = chi_hchch_eff;
};

void br_hss_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hstst_eff/T_eff*T_sm/T_hstst_sm*smpar->br_h_ss;
  *err = T_hstst_eff/T_eff*T_sm/T_hstst_sm*smpar->err_h_ss;
  *chi = chi_hchch_eff;
};

void br_htautau_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_htata_eff/T_eff*T_sm/T_htata_sm*smpar->br_h_tautau;
  *err = T_htata_eff/T_eff*T_sm/T_htata_sm*smpar->err_h_tautau;
  *chi = chi_htata_eff;
};

void br_hww_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hww_eff/T_eff*T_sm/T_hww_sm*smpar->br_h_ww;
  *err = (err_hww_eff/T_eff*T_sm/T_hww_sm + T_hww_eff/pow(T_eff,2)*err_T_eff*T_sm/T_hww_sm + \
          T_hww_eff/T_eff*err_T_sm/T_hww_sm + T_hww_eff/T_eff*T_sm/pow(T_hww_sm,2)*err_hww_sm)*smpar->br_h_ww+\
          T_hww_eff/T_eff*T_sm/T_hww_sm*smpar->err_h_ww;
  *chi = chi_hww_eff;
};

void br_hgaga_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hgaga_eff/T_eff*T_sm/T_hgaga_sm*smpar->br_h_yy;
  *err = T_hgaga_eff/T_eff*T_sm/T_hgaga_sm*smpar->err_h_gg;
  *chi = chi_hgaga_eff;
};

void br_hglgl_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br =  T_hglgl_eff/T_eff*T_sm/T_hglgl_sm*smpar->br_h_gg;
  *err = T_hglgl_eff/T_eff*T_sm/T_hglgl_sm*smpar->err_h_gg;
  *chi = chi_hglgl_eff;
};

void br_hgaz_(  sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hgaz_eff/T_eff*T_sm/T_hgaz_sm*smpar->br_h_yz;
  *err = T_hgaz_eff/T_eff*T_sm/T_hgaz_sm*smpar->err_h_yz;
  *chi = chi_hgaz_eff;
};

void br_hzz_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi )
{
  *br = T_hzz_eff/T_eff*T_sm/T_hzz_sm*smpar->br_h_zz;
  *err = (err_hzz_eff/T_eff*T_sm/T_hzz_sm + T_hzz_eff/pow(T_eff,2)*err_T_eff*T_sm/T_hzz_sm + \
          T_hzz_eff/T_eff*err_T_sm/T_hzz_sm + T_hzz_eff/T_eff*T_sm/pow(T_hzz_sm,2)*err_hzz_sm)*smpar->br_h_zz+\
          T_hzz_eff/T_eff*T_sm/T_hzz_sm*smpar->err_h_zz;
  *chi = chi_hzz_eff;
};

/* K-Faktoren der branching Rations BR(eff)/BR(SM)|Tree */

void k_hbb_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hbobo_eff/T_hbobo_sm;
  *err = err_hbobo_eff/T_hbobo_sm;
  *chi = chi_hbobo_eff;
};

void k_hcc_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hchch_eff/T_hchch_sm;
  *err = err_hchch_eff/T_hchch_sm;
  *chi = chi_hchch_eff;
};

void k_hss_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hstst_eff/T_hstst_sm;
  *err = err_hstst_eff/T_hstst_sm;
  *chi = chi_hchch_eff;
};

void k_htautau_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_htata_eff/T_htata_sm;
  *err = err_htata_eff/T_htata_sm;
  *chi = chi_htata_eff;
};

void k_hww_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hww_eff/T_hww_sm;
  *err = (err_hww_eff/T_hww_sm + T_hww_eff/pow(T_hww_sm,2)*err_hww_sm);
  *chi = chi_hww_eff;
};

void k_hgaga_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hgaga_eff/T_hgaga_sm;
  *err = err_hgaga_eff/T_hgaga_sm;
  *chi = chi_hgaga_eff;
};

void k_hglgl_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k =  T_hglgl_eff/T_hglgl_sm;
  *err = err_hglgl_eff/T_hglgl_sm;
  *chi = chi_hglgl_eff;
};

void k_hgaz_(  sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hgaz_eff/T_hgaz_sm;
  *err = err_hgaz_eff/T_hgaz_sm;
  *chi = chi_hgaz_eff;
};

void k_hzz_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi )
{
  *k = T_hzz_eff/T_hzz_sm;
  *err = (err_hzz_eff/T_hzz_sm + T_hzz_eff/pow(T_hzz_sm,2)*err_hzz_sm);
  *chi = chi_hzz_eff;
};


/* Die folgenden Funktionen berechnen die Zerfallsbreiten des Higgs-Bosons im Rahmen der effektiven Feldtheorie auf Tree-Level */
/* Die verwendeten Formeln sind dem PDG Review (rpp2012-rev-cross-section-formulae.pdf) entnommen, aufgerufen am 23.05.2012    */
/* Leptonische Zweikoerperzerfaelle */

void hglgl_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf[] = {smpar->mup, smpar->mdo, smpar->mch, smpar->mst, smpar->mto, smpar->mbo };
  double ef[] = {2./3.,      -1./3.,     2./3.,      -1./3.,     2./3.,      -1./3.     };
  double ff[] = {effpar->fuph, effpar->fdoh, effpar->fchh, effpar->fsth, effpar->ftoh, effpar->fboh };
  complex<double> Af(0,0); // Fermionschleife
  double tau = 0;
  for( int i = 0; i < 6; i++ )
    {
      complex<double> eins(1,0);
      tau = 4.0*pow(mf[i],2)/pow(smpar->mh,2);
      Af += -2.0*tau*(eins+(1-tau)*f_(tau))*3.0*ef[i]*ef[i]*smpar->alphas/2.0/M_PI/smpar->vev*(1-pow(smpar->vev,3)/sqrt(2.0)/mf[i]*ff[i]);
    }; 

  complex<double> Aano(-4*ghgg_( smpar, effpar, smpar->mh ), 0);
 
  complex< double > A = Af + Aano;
  double Gamma = pow(smpar->mh,3)/64.0/M_PI*abs(A)*abs(A);
  
  *pWidth = Gamma;
  *pError = 0;
};

void hgaga_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf[] = {smpar->mup, smpar->mdo, smpar->mch, smpar->mst, smpar->mto, smpar->mbo, smpar->mel, smpar->mmu, smpar->mta };
  double ef[] = {2./3.,      -1./3.,     2./3.,      -1./3.,     2./3.,      -1./3.,     -1,         -1,         -1         };
  double Nc[] = {3,          3,          3,          3,          3,          3,          1,          1,          1          };
  double ff[] = {effpar->fuph, effpar->fdoh, effpar->fchh, effpar->fsth, effpar->ftoh, effpar->fboh, effpar->felh, effpar->fmuh, effpar->ftah };
  complex<double> Af(0,0); // Fermionschleife
  complex<double> Aw(0,0); //W-Schleife
  double tau = 0;
  for( int i = 0; i < 9; i++ )
    {
      complex<double> eins(1,0);
      tau = 4.0*pow(mf[i],2)/pow(smpar->mh,2);
      Af += -2.0*tau*(eins+(1-tau)*f_(tau))*Nc[i]*ef[i]*ef[i]*smpar->alphae/2.0/M_PI/smpar->vev*(1-pow(smpar->vev,3)/sqrt(2.0)/mf[i]*ff[i]);
    };
  double cw = sqrt(1-pow(smpar->sw,2));
  tau = 4.0*pow(smpar->mz*cw/smpar->mh,2);
  Aw  = (complex<double>(2+3*tau,0)+3.0*tau*(2.0-tau)*f_(tau))*smpar->alphae/2.0/M_PI/smpar->vev;

  complex<double> Aano(-4*ghyy_( smpar, effpar, smpar->mh ), 0);
 
  complex< double > A = Af + Aw + Aano;
  double Gamma = 1.0*pow(smpar->mh,3)/64.0/M_PI*abs(A)*abs(A);
  
  *pWidth = Gamma;
  *pError = 0;
};

void hgaz_(  sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf[]    = {smpar->mup, smpar->mdo, smpar->mch, smpar->mst, smpar->mto, smpar->mbo, smpar->mel, smpar->mmu, smpar->mta};
  double t3[]    = {0.5,        -0.5,       0.5,        -0.5,       0.5,        -0.5,       -0.5,       -0.5,       -0.5      };
  double ef[]    = {2./3.,      -1./3.,     2./3.,      -1./3.,     2./3.,      -1./3.,     -1,         -1,         -1        };
  double Nc[]    = {3,          3,          3,          3,          3,          3,          1,          1,          1         };
  double ff[]    = {effpar->fuph, effpar->fdoh, effpar->fchh, effpar->fsth, effpar->ftoh, effpar->fboh, effpar->felh, effpar->fmuh, effpar->ftah };
  double mz      = smpar->mz;
  double sw      = smpar->sw;
  double cw      = sqrt(1-sw*sw);
  double mw      = mz*cw;
  double mh      = smpar->mh;

  double g1hzy   = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy   = g2hzy_( smpar, effpar, smpar->mh );

  complex< double > Af( 0, 0 );
  complex< double > Aw( 0, 0 );
  
  double tau = 0, lambda = 0;
  /* Fermion-Amplitude */
  for( int i = 0; i < 9; i++ )
    {
      tau    = 4.0*pow(mf[i]/mh,2);
      lambda = 4.0*pow(mf[i]/mz,2);
      Af+=smpar->alphae/2.0/M_PI/smpar->vev * Nc[i]*(-2.0*ef[i])*(t3[i]-2.0*ef[i]*sw*sw)/sw/cw*(I1_(tau,lambda)-I2_(tau,lambda))*(1-pow(smpar->vev,3)/sqrt(2)/mf[i]*ff[i]);
    };
  double tauw    = 4*pow(mw/mh,2);
  double lambdaw = 4*pow(mw/mz,2);
  Aw = -cw/sw*(4.0*(3-pow(sw/cw,2))*I2_(tauw,lambdaw) + ((1.0+2.0/tauw)*pow(sw/cw,2)-(5+2.0/tauw))*I1_(tauw,lambdaw))*smpar->alphae/2.0/M_PI/smpar->vev;
  complex< double > Aano(-g1hzy-2*g2hzy,0);
  complex< double > A = Aw + Af + Aano;
  double Gamma = pow(mh,3)*pow(1-pow(mz/mh,2),3)/32.0/M_PI*abs(A)*abs(A);
  
  *pWidth = Gamma;
  *pError = 0;
};

// Zerfaelle in zwei Leptonen

void htata_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf  = smpar->mta;
  double mh  = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->ftah;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2.)/mf*ffH,2)*pow(1.-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hmumu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mmu;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fmuh;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*pow(1-pow(2.*mf/mh,2),1.5);  
  *pError = 0;
};

/*
void helel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mel;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->felh;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};*/

/* Zerfaelle in zwei Quarks */
/*
void hupup_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mup;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fuph;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hdodo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mdo;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fdoh;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};
*/

void hchch_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mch;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fchh;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hstst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mst;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fsth;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hbobo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mbo;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = effpar->fboh;
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(1-pow(v,3.)/sqrt(2)/mf*ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

/* Zerfaelle in zwei Eichbosonen, gebildet durch Summierung der zugehoerigen Dreikoerperzerfaelle */

void hzz_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * pChi )
{
  double width = 0, error = 0, chi = 1;
  double buffer1 = 0, buffer2 = 0, buffer3 = 0;
  hztata_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzmumu_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzelel_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzupup_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzdodo_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzchch_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzstst_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hzbobo_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hznunu_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  *pWidth = width;
  *pError = error;
  *pChi   = chi;
};

void hww_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * pChi )
{  
  double width = 0, error = 0, chi = 1;
  double buffer1 = 0, buffer2 = 0, buffer3 = 0;
  hwtanta_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwmunmu_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwelnel_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwupdo_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwupst_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwupbo_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwchdo_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwchst_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  hwchbo_( smpar, effpar, &buffer1, &buffer2, &buffer3 );  width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
  *pWidth = width;
  *pError = error;
  *pChi   = chi;
};

/* Dreikoerperzerfaelle in ein on-shell und ein off-shell Eichboson mit anschliessendem Zerfall des Eichbosons */

void hznunu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{  
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, 0, 0, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0, 
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZnN, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    { 
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hztata_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{  
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mta, smpar->mta, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZlL, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {   
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hzmumu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mmu, smpar->mmu, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZlL, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {  
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hzelel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mel, smpar->mel, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy }; 
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZlL, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    { 
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hzdodo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;

  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mdo, smpar->mdo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZdD, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  *pWidth = result;
  *pError = error;
};

void hzupup_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mup, smpar->mup, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZuU, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hzstst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;

  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mst, smpar->mst, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZdD, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  *pWidth = result;
  *pError = error;
};

void hzchch_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{  
  size_t dim = 2;

  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mch, smpar->mch, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZuU, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hzbobo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;

  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mbo, smpar->mbo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHZdD, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwtanta_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, 0, smpar->mta, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWl, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    { 
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwmunmu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, 0, smpar->mmu, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWl, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwelnel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, 0, smpar->mel, sqrt( smpar->alphae*4*M_PI ), smpar->sw, 0,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWl, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwupdo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mup, smpar->mdo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vud,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwupst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mup, smpar->mst, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vus,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwupbo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mup, smpar->mbo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vub, 
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwchdo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;

  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mch, smpar->mdo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vcd,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    { 
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
   *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwchst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mch, smpar->mst, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vcs,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

void hwchbo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi )
{
  size_t dim = 2;
  double g1hww = g1hww_( smpar, effpar, smpar->mh );
  double g2hww = g2hww_( smpar, effpar, smpar->mh );
  double g3hww = g3hww_( smpar, effpar, smpar->mh );
  double g1hzz = g1hzz_( smpar, effpar, smpar->mh );
  double g2hzz = g2hzz_( smpar, effpar, smpar->mh );
  double g3hzz = g3hzz_( smpar, effpar, smpar->mh );
  double g1hzy = g1hzy_( smpar, effpar, smpar->mh );
  double g2hzy = g2hzy_( smpar, effpar, smpar->mh );

  double par[] = { smpar->mh, smpar->mz, smpar->mch, smpar->mbo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->vcb,
                   g1hzz, g2hzz, g3hzz, g1hww, g2hww, g3hww, g1hzy, g2hzy };
  double result, error;
  
  double xl[] = { 0, 0 };
  double xu[] = { 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = DCalls;
  gsl_monte_function G = { mHWqqp, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    }
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps));
    *chi = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  
  *pWidth = result;
  *pError = error;
};

double mHWl( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  double ml =  _par[3];
  double ee =  _par[4];
  double sw =  _par[5];
  //double CKM = _par[6];
  //double g1hzz = _par[7];
  //double g2hzz = _par[8];
  //double g3hzz = _par[9];
  double g1hww = _par[10];
  double g2hww = _par[11];
  double g3hww = _par[12];
  //double g1hzy = _par[13];
  //double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * (pow( mh - mw, 2 ) - pow( ml, 2 )) + pow( ml, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow( ml, 2),0, pow(mw,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  //double m13sq = pow(mh,2)+pow(ml,2)+pow(mw,2) - m12sq - m23sq;  
  
  double g144,g137,g51,g146,g130,g123,g22,g140,g9,g124,g4,g150,g17,g5,g134,g117,g30,g7,g6,g16,g8,g10,g11,g44,g47,g132,g129,g135,g159,g24,g13,g122,g14,g143,g15,g139,
       g19,g20,g142,g21,g126,g23,g64,g25,g49,g52,g65,g34,g27,g28,g46,g29,g31,g32,g45,g33,g35,g36,g69,g37,g38,g39,g40,g50,g125,g147,g41,g42,g43,g54,g53,g63,g118,g57,
       g74,g58,g59,g60,g61,g70,g71,g131,g76,g77,g78,g79,g80,g83,g90,g85,g88,g87,g96,g100,g102,g127,g186,g161,g191,g162,g163,g197,g164,g185,g179,g168,g171,g172,g173,
       g174,g175,g176,g177,g178,g180,g181,g182,g183,g184,g187,g188,g189,g190,g192,g193,g194,g195,g196,g198,g199,g202,g115,msq,t0;
    {
    g144=ee*ee;
    g137=g144*sw;
    g51=g137*sw;
    g146=mw*mw;
    g130=g146*mw;
    g123=g130*mw;
    g22=g123*g51;
    g140=mh*mh;
    g9=g140*g22;
    g124=ml*ml;
    g4=g124*g9;
    g150=g3hww*g3hww;
    g17=g150*g51;
    g5=g140*g17;
    g134=g123*mw;
    g117=g134*mw;
    g30=g117*g51;
    g7=g124*g30;
    g6=g7*m23sq;
    g16=g124*g22;
    g8=g16*m12sq;
    g10=g146*g17;
    g11=g140*g30;
    g44=g3hww*g1hww;
    g47=mw*ee;
    g132=g47*g47;
    g129=g132*sw;
    g135=g117*mw;
    g159=g51*mw;
    g24=g159*g135;
    g13=g140*g24;
    g122=g124*g124;
    g14=g122*g22;
    g143=m23sq*m23sq;
    g15=g143*g22;
    g139=g2hww*g2hww;
    g19=g139*g30;
    g20=g30*m12sq;
    g142=m12sq*m12sq;
    g21=g142*g30;
    g126=g130*g117;
    g23=g159*g126;
    g64=g129*g47;
    g25=g140*g64;
    g49=g124*m12sq;
    g52=g49*m12sq;
    g65=g137*ee;
    g34=g134*g65;
    g27=g49*g34;
    g28=g34*m23sq;
    g46=g124*g65;
    g29=g142*g46;
    g31=g64*g3hww;
    g32=g122*g34;
    g45=g135*g65;
    g33=g124*g45;
    g35=g122*g65;
    g36=g132*g132*g124;
    g69=g140*m12sq;
    g37=g122*g69;
    g38=g146*g49;
    g39=g65*m12sq;
    g40=g124*g36;
    g50=g124*mw;
    g125=g144*g144;
    g147=g50*g50;
    g41=g147*g125;
    g42=g52*m12sq;
    g43=g65*g1hww;
    g54=g125*g117;
    g53=g146*g54;
    g63=g135*g39;
    g118=g140*g140;
    g57=g118*g1hww;
    g74=g140*g1hww;
    g58=g74*g28;
    g59=g22*m23sq;
    g60=g142*m23sq;
    g61=g69*g7;
    g70=g124*g118;
    g71=g1hww*m23sq;
    g131=g1hww*g1hww;
    g76=g1hww*m12sq;
    g77=g131*g13;
    g78=g124*g2hww;
    g79=g2hww*m12sq;
    g80=g140*g2hww;
    g83=g142*g3hww;
    g90=g3hww*g2hww;
    g85=g3hww*m23sq;
    g88=m23sq*m12sq;
    g87=g2hww*g1hww;
    g96=g44*g9;
    g100=g19*m12sq;
    g102=g3hww*mw;
    g127=g142*m12sq;
    g186=4.0*g54*m23sq;
    g161=g186+8.0*(g28*g3hww-(g139*g23));
    g191=16.0*g139*g24;
    g162=g191-(16.0*g87*g11);
    g163=-(2.0*g5)-(6.0*g10);
    g197=4.0*g4;
    g164=g197-(4.0*g11);
    g185=8.0*m12sq;
    g179=4.0*g71;
    g168=g42-(2.0*g140*g52);
    g171=8.0*g1hww;
    g172=16.0*g2hww;
    g173=4.0*g129*g44*sw;
    g174=8.0*g32;
    g175=8.0*g45;
    g176=4.0*g23;
    g177=16.0*g78;
    g178=16.0*g6;
    g180=4.0*g3hww;
    g181=16.0*g27;
    g182=16.0*g33;
    g183=2.0*g118*g3hww;
    g184=4.0*g5*m23sq;
    g187=8.0*g126*g43;
    g188=16.0*g139*g6;
    g189=4.0*g36;
    g190=6.0*g36;
    g192=9.0*g54;
    g193=8.0*g135*g43;
    g194=8.0*g7;
    g195=8.0*g20;
    g196=4.0*g15;
    g198=8.0*g11;
    g199=16.0*g11;
    g202=sw*sw;
    g115=g117*g202*g202;
    {
        t0=(-(8.0*g31)-(4.0*g10))*(g49*m23sq+g70)+(12.0*g3hww-g179)*(g49*g25-(
         g130*g29))+(g185+4.0*m23sq)*(g117*g17+g77+g53)+m12sq*(6.0*g40-g188-g161
         -(8.0*g58))+g2hww*8.0*(-(g134*g29)-(g83*g16))+g3hww*(16.0*g63+18.0*(g27
         -g32)-g182)+g5*(6.0*g38-(2.0*g147)-(4.0*g117))+g19*(8.0*g127+16.0*g60)+
         g35*(4.0*g130*g57-(24.0*g135*g2hww))+g44*(12.0*g6+8.0*g13)+g50*(g183*
         g39+g184*mw)+g52*(g163+g173*m23sq)+g140*m23sq*(g189-(g173*g49)-g193)+
         g140*g63*(-g172-g171)+g146*g125*(g168+2.0*g37)+g69*(g190+4.0*g102*g35)+
         g71*(12.0*g33+g195*g71+32.0*g21*g2hww-g181)+g140*g131*(-g176-(8.0*g6))+
         g74*(12.0*g32+4.0*(-g27-g33)-(32.0*g6*g2hww))+g124*g70*(g173-g17)+g79*(
         g174+8.0*g33-(32.0*g71*g11));
        t0=t0+g80*(g174+8.0*g27+g194*g80)+g122*g90*(8.0*g9-(24.0*g30))+g85*(g175
         -(g172*g8)+g180*g16)+g131*g88*(2.0*g164-(12.0*g24))+g88*(-g191-g189-(
         8.0*g96)-(g199*g139))+g90*(g178+16.0*g21)+g122*g25*(-g180-(4.0*g76))+
         g143*g34*8.0*(g76-g3hww)+g126*g2hww*16.0*(g39-g46)+g140*g3hww*(8.0*g28-
         g175)+g124*g49*(12.0*g31-g163)+g131*m23sq*(g176+12.0*g21)+2*g168*g102*
         g65+g24*g3hww*(16.0*g79-g177)+g79*g3hww*(g194+8.0*(g14+g4)-g199)+g71*
         g24*(g177-(32.0*g79)-g179)+g76*g2hww*(16.0*g13-g178)+g57*g2hww*16.0*(g7
         +g20)+g44*m23sq*(8.0*(g30*m23sq-g24)-g198-(16.0*g8)-(12.0*g4))+g44*
         m12sq*(8.0*g15-g198-g197)+g2hww*m23sq*(g182-g181)+g35*mw*(-g183-(2.0*
         g83));
        msq=(t0+g118*(8.0*g100+g125*g38+12.0*g44*g16-g189-g41)+g122*(12.0*g96-
         g192-g162)+g123*(g184-(4.0*g88*g17))+g124*(g161+4.0*g77+8.0*(g85*g25-
         g53)+12.0*(g57*g34-g58)+g191*m23sq)+g131*(4.0*(g60*g9-(g127*g59))-(8.0*
         g61))+g140*(g187+g186-(2.0*g40)+4.0*(-g53-(g44*g7))-g188)+g142*(g162-
         g41+g171*g28+g172*g45+8.0*g59*g44-g190)+g143*(g193-(4.0*g54)+16.0*g100+
         32.0*g87*g20)+g49*g17*(g118-g49)+g150*(9.0*(g8-g14)-g196-g194)+g79*g79*
         (-g199-g194)+g74*g74*(g195+4.0*(-g8-g14))+g76*g76*(g164-g196)+g42*g17+
         g177*g78*g11-(g173*g37)-(16.0*g87*g61)-(g187*m23sq)+g192*g49)/(g115*
         m12sq*(g185-(16.0*g146))+8.0*g123*g115);
      };
  }; 
  msq = msq * (pow(mh - mw,2) - pow(ml,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq;
  return 2*width; // Factor 2 because there is W-
};

double mHWqqp( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  double m3 =  _par[2];
  double m4 =  _par[3];
  double ee =  _par[4];
  double sw =  _par[5];
  double CKM = _par[6];
  //double g1hzz = _par[7];
  //double g2hzz = _par[8];
  //double g3hzz = _par[9];
  double g1hww = _par[10];
  double g2hww = _par[11];
  double g3hww = _par[12];
  //double g1hzy = _par[13];
  //double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * (pow( mh - mw, 2 ) - pow( m3 + m4, 2 )) + pow( m3 + m4, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(m3,2), pow(m4,2), pow(mw,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  //double m13sq = pow(mh,2)+pow(m3,2) + pow(m4, 2) + pow(mw,2) - m12sq - m23sq;
  
  double g204,g218,g83,g72,g227,g224,g217,g50,g228,g225,g84,g4,g213,g198,g77,g36,g230,g21,g5,g215,g25,g6,g229,g75,g94,g53,g210,g7,g219,g26,g8,g81,g64,g11,g9,g158,g65,
         g10,g12,g79,g33,g14,g13,g15,g214,g24,g17,g18,g19,g20,g222,g196,g78,g34,g22,g23,g113,g67,g27,g28,g182,g76,g244,g117,g66,g43,g46,g31,g70,g82,g211,g32,g69,g37,
         g38,g216,g96,g73,g197,g80,g85,g63,g160,g62,g44,g59,g45,g47,g61,g48,g68,g205,g56,g54,g55,g95,g74,g57,g221,g116,g86,g123,g111,g106,g93,g90,g129,g92,g112,g97,g98,
         g130,g99,g100,g233,g109,g105,g110,g108,g115,g223,g122,g121,g124,g128,g131,g132,g133,g134,g232,g138,g139,g140,g142,g146,g148,g208,g166,g170,g206,g175,g181,g328,
         g274,g250,g321,g251,g260,g266,g326,g265,g253,g279,g252,g254,g325,g255,g258,g256,g264,g315,g318,g257,g332,g333,g259,g299,g261,g262,g263,g267,g343,g268,g269,g270,
         g271,g322,g272,g273,g334,g275,g341,g276,g300,g277,g308,g278,g303,g302,g290,g282,g298,g316,g285,g286,g287,g288,g289,g291,g292,g293,g294,g295,g296,g297,g301,g304,g305, 
         g306,g307,g309,g310,g311,g312,g313,g314,g317,g319,g320,g323,g324,g327,g329,g330 ,g331,g335,g336,g337,g338,g339,g340,g342,g344,g345,g346,g347,g348,msq,t0;
    {
    g204=CKM*CKM;
    g218=m4*m4;
    g83=g218*g204;
    g72=g83*m12sq;
    g227=mw*mw;
    g224=g227*mw;
    g217=g224*mw;
    g50=g217*g72;
    g228=ee*ee;
    g225=g228*sw;
    g84=g225*sw;
    g4=g84*g50;
    g213=g217*mw;
    g198=g213*mw;
    g77=g204*g198;
    g36=g84*g77;
    g230=g2hww*g2hww;
    g21=g230*g36;
    g5=g218*g21;
    g215=mh*mh;
    g25=g215*g36;
    g6=g218*g25;
    g229=sw*sw;
    g75=g229*g217;
    g94=g228*g204;
    g53=g94*g75;
    g210=g215*g215;
    g7=g210*g53;
    g219=g1hww*g1hww;
    g26=g219*g53;
    g8=g215*g26;
    g81=g204*g1hww;
    g64=g84*g81*g3hww;
    g11=g215*g64;
    g9=g11*m12sq;
    g158=g3hww*g2hww;
    g65=g215*g158;
    g10=g204*g84*g65;
    g12=g227*g64;
    g79=g3hww*sw;
    g33=g94*g79*g79;
    g14=g227*g33;
    g13=g215*g14;
    g15=g215*g33;
    g214=m3*m3;
    g24=g214*g36;
    g17=g24*m23sq;
    g18=g24*m12sq;
    g19=g214*g53;
    g20=g218*g33;
    g222=g198*mw;
    g196=g222*mw;
    g78=g204*g196;
    g34=g84*g78;
    g22=g218*g34;
    g23=g214*g34;
    g113=g225*ee;
    g67=g113*g83;
    g27=g224*g67;
    g28=g53*g3hww;
    g182=g2hww*g1hww;
    g76=g213*sw;
    g244=g228*ee;
    g117=g244*g76;
    g66=g204*g117;
    g43=g215*g66;
    g46=g218*g66;
    g31=g46*g1hww;
    g70=mw*ee;
    g82=g215*g204;
    g211=g70*g70*g70;
    g32=g211*g82*sw;
    g69=g82*m12sq;
    g37=g214*g69;
    g38=g94*g76*g76;
    g216=g244*ee;
    g96=g227*g216;
    g73=g204*g96;
    g197=m12sq*m12sq;
    g80=g228*g79*g70;
    g85=g204*g113;
    g63=g197*g85;
    g160=g3hww*mw;
    g62=g85*m12sq;
    g44=g224*g62;
    g59=g214*g85;
    g45=g197*g59;
    g47=g222*g59;
    g61=g222*g85;
    g48=g215*g61;
    g68=g113*g81;
    g205=g211*g70;
    g56=g205*g204;
    g54=g62*g3hww;
    g55=g62*g2hww;
    g95=g216*g214;
    g74=g204*g95;
    g57=g198*g74;
    g221=g197*m12sq;
    g116=g216*g77;
    g86=g227*g218;
    g123=g215*g214;
    g111=g215*g123;
    g106=g218*g197;
    g93=g217*g214;
    g90=g214*g197;
    g129=g214*g1hww;
    g92=g129*g1hww;
    g112=g1hww*m12sq;
    g97=g215*g112;
    g98=g214*g129;
    g130=g1hww*m23sq;
    g99=g130*m23sq;
    g100=g214*m23sq;
    g233=g112*m23sq;
    g109=g219*g215;
    g105=g33*m12sq;
    g110=g218*m12sq;
    g108=g218*m23sq;
    g115=g216*g78;
    g223=g196*mw;
    g122=g218*g215;
    g121=g213*g54;
    g124=g214*m12sq;
    g128=g215*g1hww;
    g131=g218*g2hww;
    g132=g2hww*m12sq;
    g133=g217*g33;
    g134=m23sq*m12sq;
    g232=g3hww*g3hww;
    g138=g227*g9;
    g139=g218*g1hww;
    g140=g3hww*m23sq;
    g142=g3hww*m12sq;
    g146=g197*g3hww;
    g148=g134*g34;
    g208=g218*g218;
    g166=g44*g3hww;
    g170=g32*g3hww;
    g206=g215*m12sq;
    g175=g27*g3hww;
    g181=g112*g2hww;
    g328=6.0*g13;
    g274=-g328-(6.0*g215*g56);
    g250=g274+24.0*g213*g55;
    g321=48.0*g215*g21;
    g251=g321+36.0*g43*g1hww;
    g260=-(3.0*g197*g73)-(6.0*g160*g63);
    g266=3.0*g210*g73+6.0*g215*g82*g80;
    g326=24.0*g43*g2hww;
    g265=g266-g326;
    g253=g265-g260;
    g279=-(12.0*g116)-(24.0*g66*g3hww);
    g252=2.25*g279-g253+6.0*g96*g69+12.0*g215*g54*mw;
    g254=12.0*(g97*g27+g86*g9);
    g325=48.0*g5;
    g255=-g325-g321-(48.0*g31);
    g258=24.0*(g61*g2hww+g158*g36);
    g256=12.0*g166-g258;
    g264=6.0*(g14+g56);
    g315=24.0*g8;
    g318=6.0*g15;
    g257=g318+g315+g264;
    g332=12.0*g116*m23sq;
    g333=24.0*g230*g38;
    g259=g333-g332;
    g299=12.0*g38;
    g261=g299+24.0*g23;
    g262=12.0*(g20-g105);
    g263=-(12.0*g9)-(24.0*g10*m12sq);
    g267=84.0*(g18+g17);
    g343=24.0*g36*m12sq;
    g268=g343-(12.0*g34);
    g269=-g250-(24.0*g132*g28);
    g270=12.0*(g92*g7-(g111*g12));
    g271=g318+3.0*g264;
    g322=36.0*g31;
    g272=-g325-g322;
    g273=-(24.0*g223*g68)-(48.0*g47*g2hww);
    g334=24.0*g21;
    g275=6.0*g20-g334;
    g341=3.0*g33;
    g276=12.0*(g224*g68+g12)-g341;
    g300=48.0*g182*g36;
    g277=g334+g300;
    g308=48.0*g129;
    g278=48.0*g130-g308;
    g303=12.0*m23sq;
    g302=24.0*m12sq;
    g290=24.0*g48;
    g282=-g290-(84.0*g47);
    g298=36.0*g1hww;
    g316=24.0*g99;
    g285=g57+g232*g19;
    g286=2.0*g277;
    g287=2.0*g260;
    g288=2.0*g258;
    g289=36.0*g36;
    g291=24.0*g61;
    g292=24.0*g140;
    g293=24.0*g28;
    g294=12.0*g3hww;
    g295=48.0*g3hww;
    g296=24.0*g46;
    g297=24.0*g43;
    g301=24.0*g134;
    g304=48.0*m23sq;
    g305=48.0*g132;
    g306=12.0*g128;
    g307=24.0*g130;
    g309=24.0*g6;
    g310=48.0*g18;
    g311=48.0*g17;
    g312=48.0*g23;
    g313=12.0*g100;
    g314=12.0*g8;
    g317=12.0*g27;
    g319=12.0*g15;
    g320=48.0*g182*g25;
    g323=48.0*g182*g24;
    g324=24.0*g5;
    g327=12.0*g138;
    g329=12.0*g106*g12;
    g330=48.0*g230*g22;
    g331=3.0*g221*g73;
    g335=3.0*g20;
    g336=24.0*g11;
    g337=36.0*g11;
    g338=24.0*g10;
    g339=48.0*g10;
    g340=12.0*g26;
    g342=12.0*g7;
    g344=48.0*g34;
    g345=24.0*g24;
    g346=36.0*g24;
    g347=24.0*g4;
    g348=-(48.0*g2hww);
    {
        t0=g276*(g123*g123+g122*g122-(g221*g214))+(g316-(24.0*g98))*(g28*m12sq+
         g213*g62)+(g298+24.0*g2hww)*(g213*g45+g146*g19)+g285*(g303+15.0*m12sq)+
         (g303+g302)*(g109*g34+g115)+m12sq*(g270+g259)+m23sq*(g330+g329+g273-
         g254-(24.0*g121))+g2hww*(g344*g97+g308*g38)+g37*(-(6.0*g205)-(12.0*g117
         *g1hww))+g47*(g306-g295)+g221*g160*6.0*(g59+g67)+g218*g93*(-g339-g337)+
         g90*(g275-g257-(g303*g12)+g336*g227)+g92*(g309-g299)+g93*(g319+g263+
         g337*m23sq)+g98*(60.0*g61-(g302*g32))+g100*(g327+g251+2.0*g250+24.0*
         g166)+g111*g1hww*(-(12.0*g44)-(24.0*g27))+g233*g112*(g289+24.0*g19)+
         g106*(g314-g271-(g293*g2hww))+g214*g110*(-g319-(24.0*g14))+g108*(g288-(
         2.0*g274)+g298*g61-(g300*m12sq)-(g337*g217));
        t0=t0+g109*(g310-g261+12.0*g22+24.0*g17+g347*m23sq)+g110*(g326+g266+18.0
         *g13-(g341*g110))+g111*(g275+3.0*g105)+g112*(g282+g313*g32)+g216*g215*(
         18.0*g50-(12.0*g78))+g215*g122*(g300-(2.0*g264))+g287*g122+g123*(g287+
         g272)+g124*(g265-g255-g328)+2.0*g253*g218*g214+g282*g130+g131*(96.0*g47
         +g310*g1hww-(g344*g131))+g132*(g344*g132-(g311*g2hww)-(72.0*g47)-(48.0*
         g48)-(g304*g46))+g134*(g255-(g340*g134))+g214*g198*(g339+12.0*g11)+g139
         *(-(36.0*g47)-(12.0*g48)-(g342*g139))+g140*(g297+g296+g291+g305*g19+
         g348*g4)+g215*g27*(g292+36.0*g142)+g197*g130*(g317+g293)+g224*g45*(-
         g294-(12.0*g130))+g208*g32*(-g294-(12.0*g112))+g217*m23sq*(g319+g262-(
         24.0*g9))+g158*(-g311-(48.0*g22)-(72.0*g18));
        t0=t0+g271*g208*m12sq+g214*g124*(g300+g257)+g214*g3hww*(g297+84.0*g46)+
         g219*m23sq*(g261-g309)+g198*m23sq*(12.0*g33-g336)+g170*(-(12.0*g124)-(
         24.0*g100))+g272*g215*m23sq+g215*g206*(g335+g277)+g286*g134*m23sq+g197*
         m23sq*(g314+g286)+g175*(-g301-(48.0*g124))+g230*g23*(-g304-(48.0*m12sq)
         )+g219*m12sq*(36.0*g23-g311-g309)+g181*m23sq*96.0*(-g34-g25)+g3hww*
         g1hww*(60.0*g23+g289*g108-g267-(12.0*g6))+g181*(-(48.0*g6)-(144.0*g17))
         +g139*g3hww*(36.0*g7-g346)+g34*g3hww*(g305-g307)+g131*g3hww*(g343+96.0*
         g24)+g4*g3hww*(-g306-g278)+g278*g22*g2hww+g130*g2hww*(-g312-(96.0*g6))+
         g128*g2hww*(1.14286*g267-g312)+g14*m12sq*(g313-(12.0*g108))+g100*m12sq*
         (12.0*g56-g315)+g36*g3hww*(g316+60.0*g98);
        t0=t0+g98*g2hww*(g344-(48.0*g25))+g90*g1hww*(24.0*g32-g317)+g196*(g336-(
         24.0*g74))+g197*(g288-(g296*g2hww)-g324-g323-g321-g320)+g198*(2.0*(g263
         -g262)-g319)+g208*(g320-g269+3.0*g256+g252+g251-g327)+g210*(g324-g323+
         g322-(24.0*g175))+g214*g214*(g269+g256+g252+12.0*g170-(24.0*g138)-(27.0
         *g133))+g213*(g307*g63+g292*g59)+g214*(g333+g331+g330-g329+3.0*g254+
         30.0*g121+g338*g93)+g215*(g332-g273+12.0*g57-(24.0*g92*g4))+g216*(27.0*
         g198*g72-(g303*g50)-(12.0*g86*g37))+g218*(g331+42.0*g285+2.0*g270-g259+
         24.0*(-g115-(g80*g37))-(g295*g61))+g219*(-(36.0*g148)-(g301*g25))+g221*
         (g335+g334-(g303*g26)+12.0*g219*g19)+g222*(48.0*g54+24.0*g218*g55)+g223
         *(48.0*g55+60.0*g59*g1hww+g348*g67);
        msq=(t0+g232*(27.0*g4-g345)+g86*g86*(g338+g337-(27.0*g33))+m23sq*m23sq*(
         g279-(12.0*g133))+g124*g124*(g276-g340)+g128*g128*(g343-(12.0*g4)-g345)
         +g129*g129*(g268-(24.0*g25)-g342)+g268*g130*g130+g112*g112*(-g346-(12.0
         *g25))+g347*g65-(48.0*g230*g148)-(g290*g3hww)+54.0*g142*g46-(36.0*g146*
         g27)+g291*g99-(12.0*g206*g31)-(g297*g233)-(24.0*g95*g50))/(g229*g229*
         8.0*(g198*g197+g223*mw)-(16.0*g75*g75*m12sq));
      };
  };
  msq = msq * (pow(mh - mw,2) - pow(m3 + m4,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq;
  return 2*width;	// Factor 2 because there is W-
};

/* differentielle Zerfallsbreite H_ZdD (down-typ Quarks)*/

double mHZdD( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  double mQ =  _par[2];
  // double mQ =  _par[3]; // Massen der FS Fermionen sind gleich
  double ee =  _par[4];
  double sw =  _par[5];
  //double CKM = _par[6];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  //double g3hzz = _par[9];
  //double g1hww = _par[10];
  //double g2hww = _par[11];
  //double g3hww = _par[12];
  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  double mq = mQ;
  
  //printf("Parameter: ee = %f, sw = %f, mQ = %f, mh = %f, mz = %f\n", ee,sw,mQ,mh,mz);
  //printf("g1hzz = %f, g2hzz = %f, g3hzz = %f, g1hzy = %f, g2hzy = %f\n", g1hzz, g2hzz, g3hzz, g1hzy, g2hzy);
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mQ + mQ, 2 )) + pow( mQ + mQ, 2 );
  //double m12sq = x[0]*( pow( mh - mz, 2 ) - pow( 0.05,2)) + pow(0.05,2);
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mQ,2), pow(mQ,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mQ,2) + pow(mQ, 2) + pow(mz,2) - m12sq - m23sq;
  double g87,g88,g44,g86,g9,g98,g4,g90,g40,g5,g39,g49,g6,g38,g7,g46,g82,g11,g8,g97,g45,g14,g10,g96,g12,g95,g13,g62,g15,g43,g83,g19,g16,g17,g18,g26,g20,g28,g21,g23,g27,g42,g99,
       g31,g29,g80,g30,g66,g32,g47,g34,g33,g35,g36,g37,g48,g50,g51,g89,g53,g54,g55,g61,g60,g74,g75,g81,g105,g106,g107,g131,g108,g109,g133,g134,g110,g111,g112,g115,g137,g113,
       g114,g122,g127,g116,g135,g117,g118,g128,g120,g121,g123,g124,g125,g126,g129,g130,g132,g136,msq1;
{
    double t0 = 0;
    g87=ee*ee;
    g88=mq*mq;
    g44=g88*g87;
    g86=mh*mh;
    g9=g86*g44;
    g98=g2hzy*g2hzy;
    g4=g98*g9;
    g90=mz*mz;
    g40=g90*m23sq;
    g5=g87*g86*g40;
    g39=g87*m13sq;
    g49=g90*g88;
    g6=g49*g39;
    g38=g87*m12sq;
    g7=g49*g38;
    g46=g90*g87;
    g82=g88*g88;
    g11=g82*g46;
    g8=g98*g11;
    g97=g1hzy*g1hzy;
    g45=g97*g87;
    g14=g90*g45;
    g10=g86*g86*g14;
    g96=m23sq*m23sq;
    g12=g96*g14;
    g95=m13sq*m13sq;
    g13=g95*g14;
    g62=g2hzy*g1hzy;
    g15=g62*g46;
    g43=g98*g87;
    g83=g90*g90;
    g19=g83*g43;
    g16=g19*m23sq;
    g17=g19*m13sq;
    g18=g90*g43;
    g26=g83*g45;
    g20=g26*m23sq;
    g28=g86*g45;
    g21=g86*g28;
    g23=g26*m13sq;
    g27=g96*g45;
    g42=m13sq*g1hzy;
    g99=g42*g42;
    g31=g99*g87;
    g29=g97*g44;
    g80=g90*g83;
    g30=g80*g43;
    g66=g88*m12sq;
    g32=g66*g1hzy;
    g47=g87*g62;
    g34=g83*g47;
    g33=g34*m23sq;
    g35=g80*g47;
    g36=g97*g39;
    g37=g97*g38;
    g48=g83*g2hzy;
    g50=g96*g15;
    g51=g95*g15;
    g89=m12sq*m12sq;
    g53=g89*g14;
    g54=g97*g11;
    g55=g97*g9;
    g61=m13sq*m12sq;
    g60=g62*g11;
    g74=g6*m12sq;
    g75=g5*m13sq;
    g81=g88*g82;
    g105=3.0*(-(g31*m23sq)-(g27*m13sq));
    g106=12.0*(-g23-g20);
    g107=16.0*(g17+g16);
    g131=16.0*g35;
    g108=8.0*(g13+g12)-g131;
    g109=16.0*(g34*m13sq+g33);
    g133=4.0*g36;
    g134=4.0*g45*m23sq;
    g110=-g134-g133;
    g111=g31+g27;
    g112=8.0*g5*m12sq-(16.0*g86*g7);
    g115=16.0*g19-(8.0*g26);
    g137=16.0*g34;
    g113=-g137-g115;
    g114=48.0*(g86*g6+g88*g5);
    g122=4.0*m23sq;
    g127=4.0*m13sq;
    g116=-g127-g122;
    g135=4.0*g29;
    g117=g37-g135;
    g118=-g28-(6.0*g29);
    g128=16.0*m13sq;
    g120=g53-(2.0*g89*g15);
    g121=8.0*g116;
    g123=4.0*m12sq;
    g124=7.0*m12sq;
    g125=32.0*m12sq;
    g126=48.0*m12sq;
    g129=4.0*g21;
    g130=4.0*g21*m23sq;
    g132=16.0*g30;
    g136=16.0*g18*m23sq;
    {
        t0=(g128+8.0*m12sq)*(g96*g18+g20-(3.0*g33))+g116*(g120+g10)+m12sq*(8.0*
         g23-(48.0*g17)-g105)+m13sq*(g130+16.0*g50)+m23sq*(112.0*g60+16.0*g51)+
         g8*(g125+4.0*g116)+g9*(8.0*g99-(96.0*g48*g1hzy))+g12*(-g128-g124-g122)+
         g13*(-g127-g124-(16.0*m23sq))+g16*(-g126-(48.0*m13sq))+g82*g28*(6.0*
         g116-g123)+g30*(g126-g121)+g35*(g125-g121)+g54*(19.0*g116-(28.0*m12sq))
         +g86*g61*8.0*(g14+g15)+g61*(g136+4.0*g55-(24.0*g34))+g62*(g114+g112-(
         96.0*g6*m23sq))+g82*m23sq*(56.0*g36+12.0*g37)+g89*m23sq*(2.0*g36-g135)+
         g66*(96.0*g19-(6.0*g27)-(16.0*g26))+g95*m12sq*(g118+8.0*g18)+g86*m12sq*
         (g115-g27)+g98*m23sq*32.0*(-g7-g6)+g97*m23sq*(28.0*g7+72.0*g6)+g61*
         m23sq*(2*g118-(14.0*g14));
        t0=t0+g55*m23sq*(g123+32.0*m13sq)+g42*g2hzy*(112.0*g11-(16.0*g5))+g80*(
         g110+4.0*g28+8.0*g29)+g81*(16.0*g28+56.0*g14-(96.0*g15)+32.0*g18+8.0*(
         g110-g37))+g82*(g129+20*g111+32.0*g26-(144.0*g34)+48.0*g19+12.0*g36*
         m12sq)+g83*(g129-(32.0*g4)+24.0*g55)+g86*(g109+g108+g107+g106+2.66667*
         g105+68.0*g54-(80.0*g60)-(16.0*g8)+4.0*g53-g132)+g88*(8.0*g120+7.0*g109
         +4.0*g108+g107+2.66667*g106+9.33333*g105+24.0*g10+32.0*(-g51-g50)-(g127
         *g21)+16.0*g81*g45-g130)+g89*(g111-(g127*g29)-g137)+g90*(g128*g4-g132-
         g131)+g96*m23sq*(g133+g117)+g95*m13sq*(g134+g117)+g95*(g136+g113+8.0*
         g27)+g96*(g113+8.0*g55)+g97*(g112+28.0*g74+20.0*g75-(1.08333*g114))+g98
         *(-(32.0*g74)-(16.0*g75));
        msq1=(t0+g87*g32*(4.0*g32+48.0*g48)+16.0*g40*g4)/(6.0*g90*g89);
    }
}
double g485,g293,g490,g220,g483,g153,g470,g143,g302,g501,g265,g221,g399,g292,g222,g320,g374,g146,g211,g170,g147,g471,g475,g149,g495,g408,g496,g407,g381,g152,g499,g482,g175,g306,
       g275,g237,g210,g176,g307,g429,g253,g156,g238,g236,g181,g157,g268,g376,g269,g377,g239,g192,g474,g194,g267,g229,g274,g200,g464,g166,g167,g168,g478,g277,g243,g169,g314,g171,
       g208,g373,g177,g309,g178,g217,g179,g213,g365,g280,g367,g421,g183,g197,g198,g420,g428,g379,g223,g224,g366,g191,g279,g195,g344,g356,g247,g196,g199,g353,g362,g303,g204,g205,
       g455,g206,g324,g207,g341,g228,g212,g393,g214,g215,g266,g500,g231,g216,g218,g219,g463,g304,g273,g230,g395,g271,g232,g233,g234,g235,g454,g241,g244,g242,g287,g245,g355,g345,
       g246,g443,g248,g283,g249,g261,g250,g251,g422,g252,g282,g254,g465,g378,g264,g257,g258,g259,g260,g262,g343,g263,g270,g281,g276,g305,g313,g284,g288,g289,g290,g291,g354,g295,
       g297,g352,g298,g299,g361,g315,g316,g317,g400,g323,g325,g326,g328,g330,g334,g335,g336,g338,g342,g348,g364,g481,g394,g418,g423,g424,g426,g552,g514,g634,g523,g536,g600,g542,
       g550,g513,g518,g524,g623,g515,g626,g559,g516,g630,g517,g568,g522,g529,g519,g525,g535,g555,g538,g520,g539,g602,g637,g521,g534,g526,g533,g528,g547,g633,g527,g530,g545,g548,
       g531,g543,g627,g532,g635,g537,g544,g612,g540,g546,g549,g551,g553,g636,g554,g556,g558,g561,g562,g563,g564,g566,g622,g639,g567,g569,g611,g571,g583,g604,g574,g618,g575,g619,
       g620,g579,g580,g581,g584,g638,g585,g586,g609,g616,g606,g607,g593,g594,g595,g597,g598,g599,g601,g603,g605,g608,g610,g613,g614,g615,g617,g621,g624,g625,g628,g629,g631,g632,
       g640,msq2;
{
    double t0 = 0;
    g485=mz*mz;
    g293=g485*g1hzy;
    g490=ee*ee;
    g220=g490*g293*g1hzz;
    g483=mh*mh;
    g153=g483*g220;
    g470=mq*mq;
    g143=g470*g153;
    g302=g485*ee;
    g501=g302*g302;
    g265=g501*g2hzz;
    g221=g470*g265;
    g399=g483*g2hzy;
    g292=g501*g1hzz;
    g222=g292*g2hzy;
    g320=g470*g222;
    g374=g483*g1hzy;
    g146=g374*g221;
    g211=g292*g1hzy;
    g170=g470*g211;
    g147=g483*g170;
    g471=g483*g483;
    g475=g470*g470;
    g149=g475*g153;
    g495=m23sq*m23sq;
    g408=g495*m13sq;
    g496=m13sq*m13sq;
    g407=g496*m23sq;
    g381=g495*m12sq;
    g152=g381*g220;
    g499=sw*sw;
    g482=g499*sw;
    g175=g482*g220;
    g306=g490*g482;
    g275=g499*g306;
    g237=g275*g1hzy;
    g210=g237*g1hzz;
    g176=g485*g210;
    g307=g490*mw*ee;
    g429=g2hzy*m12sq;
    g253=g429*g307;
    g156=g485*g483*g253;
    g238=g499*g307;
    g236=g238*g1hzy;
    g181=g483*g236;
    g157=g470*g181;
    g268=g306*g2hzy;
    g376=g483*g2hzz;
    g269=g275*g2hzy;
    g377=g483*g1hzz;
    g239=g275*g1hzz;
    g192=g482*g222;
    g474=g499*g482;
    g194=g474*g222;
    g267=g306*g1hzy;
    g229=g237*g2hzz;
    g274=g306*g2hzz;
    g200=g470*g274;
    g464=g485*g485;
    g166=g464*g200;
    g167=g474*g221;
    g168=g377*g267;
    g478=g485*g464;
    g277=g490*g478;
    g243=g483*g277;
    g169=g470*g243;
    g314=g475*g464;
    g171=g314*g239;
    g208=g464*g210;
    g373=g470*g2hzy;
    g177=g373*g238;
    g309=g485*g475;
    g178=g309*g238;
    g217=g470*g236;
    g179=g485*g217;
    g213=g220*sw;
    g365=g490*sw;
    g280=g365*g2hzy;
    g367=g475*g2hzz;
    g421=g277*g2hzy;
    g183=g421*g2hzz*m23sq;
    g197=g475*g274;
    g198=g367*g275;
    g420=g2hzy*m13sq;
    g428=g277*g2hzz;
    g379=g265*g2hzy;
    g223=g478*g268;
    g224=g478*g269;
    g366=g475*g1hzz;
    g191=g366*g280;
    g279=g365*g1hzy;
    g195=g367*g279;
    g344=m23sq*g1hzy;
    g356=g490*g2hzz;
    g247=g356*g344;
    g196=g478*g247;
    g199=g221*sw;
    g353=m13sq*g1hzy;
    g362=g482*g1hzy;
    g303=g478*g470;
    g204=g303*g237;
    g205=g366*g279;
    g455=g1hzz*m23sq;
    g206=g455*g277;
    g324=g482*g211;
    g207=g324*m23sq;
    g341=g483*sw;
    g228=g478*g267;
    g212=g228*g1hzz;
    g393=g464*g2hzy;
    g214=g393*g238;
    g215=g429*g238;
    g266=g485*g307;
    g500=m12sq*m12sq;
    g231=g500*g266;
    g216=g499*g231;
    g218=g374*g266;
    g219=g485*g236;
    g463=g485*g478;
    g304=g490*g463;
    g273=g304*g1hzz;
    g230=g482*g273;
    g395=g463*g2hzy;
    g271=g464*g307;
    g232=g483*g271;
    g233=g464*g236;
    g234=g495*g266;
    g235=g496*g266;
    g454=g2hzz*m13sq;
    g241=g454*g279;
    g244=sw*m12sq;
    g242=g356*g244;
    g287=g496*g2hzz;
    g245=g365*g287;
    g355=sw*m13sq;
    g345=g355*g1hzz;
    g246=g490*g345;
    g443=g2hzy*m23sq;
    g248=g443*g307;
    g283=g307*m13sq;
    g249=g470*g283;
    g261=g344*g307;
    g250=g470*g261;
    g251=g421*g1hzz;
    g422=g277*g1hzy;
    g252=g422*g1hzz;
    g282=g304*g2hzz;
    g254=g282*g2hzy;
    g465=g475*g470;
    g378=g465*sw;
    g264=g495*g2hzz;
    g257=g273*g2hzy;
    g258=g282*g1hzy;
    g259=g500*sw;
    g260=g273*sw*g1hzy;
    g262=g283*g1hzy;
    g343=m12sq*g1hzy;
    g263=g343*g307;
    g270=g501*g302*mw;
    g281=g500*g1hzy;
    g276=g478*m12sq;
    g305=g464*m23sq;
    g313=g485*m12sq;
    g284=g313*g248;
    g288=g478*g2hzy;
    g289=g485*m23sq;
    g290=g485*m13sq;
    g291=g464*m12sq;
    g354=g471*g211;
    g295=g324*m13sq;
    g297=g478*m13sq;
    g352=g474*g1hzy;
    g298=g352*g206;
    g299=g362*g206;
    g361=g496*m12sq;
    g315=g470*m12sq;
    g316=m23sq*m12sq;
    g317=m13sq*m12sq;
    g400=g478*m23sq;
    g323=m23sq*m13sq;
    g325=g463*g210;
    g326=g478*g210;
    g328=g485*g205;
    g330=g482*g470;
    g334=g470*sw;
    g335=g474*g153;
    g336=g483*g482;
    g338=g482*g143;
    g342=g482*m13sq;
    g348=m23sq*sw;
    g364=g242*g2hzy;
    g481=g485*g463;
    g394=g249*g1hzy;
    g418=g482*m23sq;
    g423=g1hzz*g2hzy;
    g424=g1hzz*g1hzy;
    g426=g169*sw;
    g552=112.0*g470*g192-(48.0*g320*sw)-(64.0*g470*g194);
    g514=g552+16.0*(g179+g233);
    g634=56.0*g212;
    g523=70.0*g324*m12sq+3.0*(g483*g263-(g307*g281))-g634;
    g536=16.0*g475*g176-(28.0*g475*g175);
    g600=g474*g170-(1.75*g482*g170);
    g542=32.0*g600;
    g550=16.0*g483*g208+12.0*g341*g211;
    g513=2.0*g550+3.5*g542+5.0*g536+g523+g514+18.0*g470*g263-(56.0*g338);
    g518=g550+2.0*g536;
    g524=2.0*g552-(6.0*g218)+24.0*g233;
    g623=16.0*g157;
    g515=g623+g524+3.0*g518+48.0*g179-(16.0*g214);
    g626=18.0*g261;
    g559=-g626-(18.0*g262);
    g516=g559-(48.0*g217);
    g630=96.0*g367*g280;
    g517=224.0*g197*g2hzy-g630-(128.0*g198*g2hzy);
    g568=32.0*g194-(56.0*g192);
    g522=g568-(40.0*g208);
    g529=64.0*g474*g379-(112.0*g482*g379);
    g519=g529+g522-(12.0*g219)-(24.0*g217)-(4.0*g181);
    g525=48.0*(g428*g353+g196);
    g535=96.0*(g428*g420+g183);
    g555=18.0*(-(g407*g220)-(g408*g220));
    g538=g555+1.5*g525;
    g520=-g538-(3.0*g535)-(24.0*g149)-(72.0*g147)-(48.0*g146);
    g539=32.0*g483*g229-(56.0*g376*g267);
    g602=2.0*g539;
    g637=28.0*g168;
    g521=-g637-g602;
    g534=144.0*g146+96.0*(g483*g320+g399*g221)-(72.0*g149)-(12.0*g471*g470*g220)
     -(132.0*g147);
    g526=g534-(144.0*g196)-(288.0*g183);
    g533=32.0*g464*g229-(56.0*g362*g265);
    g528=g568+g533;
    g547=28.0*g470*g175-(12.0*g470*g213)-(16.0*g470*g176);
    g633=16.0*g208;
    g527=2.0*g547+g528-(16.0*g217)-g633;
    g530=1.33333*g555-(6.0*g152);
    g545=112.0*g377*g268-(64.0*g399*g239);
    g548=224.0*g376*g268-(128.0*g376*g269);
    g531=g548+g545;
    g543=96.0*g191-(120.0*g205);
    g627=16.0*g181;
    g532=1.5*g543+g517-(112.0*g217)+64.0*g177+336.0*g195-g627;
    g635=28.0*g207;
    g537=g635+28.0*g295;
    g544=-(28.0*g230)-(6.0*g231);
    g612=48.0*g178;
    g540=12.0*g232-(8.0*g216)-(240.0*g171)-g612-g544;
    g546=24.0*(g496*g143+g495*g143)-(144.0*g420*g206);
    g549=9.0*(-g235-g234);
    g551=g535-(36.0*g152);
    g553=256.0*g254*m23sq-(8.0*g361*g153)-(160.0*g429*g206);
    g636=96.0*g454*g280;
    g554=g636+48.0*g241;
    g556=-g612-g549;
    g558=112.0*g166-(48.0*g199)-(64.0*g167);
    g561=8.0*g176-(14.0*g175)+6.0*g213;
    g562=24.0*g143+120.0*g170;
    g563=-(48.0*g258)-(96.0*g254);
    g564=g551+4.66667*g538;
    g566=g531-g602;
    g622=32.0*g236;
    g639=84.0*g168;
    g567=96.0*g463*g247-(12.0*g354*m13sq);
    g569=1.33333*g520+384.0*g254;
    g611=12.0*m23sq;
    g571=-g611-(12.0*m13sq);
    g583=112.0*g223-(64.0*g224);
    g604=112.0*g228;
    g574=32.0*(-g316-g317);
    g618=24.0*g222;
    g575=g618-(30.0*g211);
    g619=24.0*g252;
    g620=48.0*g251;
    g579=320.0*g470*g224-(560.0*g470*g223);
    g580=3.0*g547+g519;
    g581=g539-g639;
    g584=32.0*g214-(12.0*g250);
    g638=56.0*g168;
    g585=48.0*g364-g638;
    g586=120.0*g251-g619;
    g609=12.0*g271;
    g616=96.0*g2hzy;
    g606=32.0*g210;
    g607=64.0*g229;
    g593=448.0*g198-(784.0*g197);
    g594=112.0*g268-(48.0*g280);
    g595=8.0*(g290+g289);
    g597=16.0*g325+12.0*g260;
    g598=1.33333*g499*g156-g156;
    g599=g463*g229+g395*g239-(1.75*g230*g2hzy);
    g601=2.0*g559;
    g603=12.0*g249;
    g605=96.0*g242;
    g608=96.0*g257;
    g610=96.0*g246;
    g613=48.0*g341;
    g614=288.0*g1hzy;
    g615=48.0*g2hzy;
    g617=192.0*g2hzy;
    g621=16.0*g236;
    g624=12.0*g218;
    g625=6.0*g261;
    g628=32.0*g215;
    g629=24.0*g253;
    g631=24.0*g263;
    g632=36.0*g263;
    g640=24.0*g241;
    {
        t0=96.0*(g352*g169*g1hzz-(g288*g245))+g561*(g317*g317+g316*g316+4.0*g323
         *g323+8.0*g470*g465+16.0*(-(g465*m13sq)-(g465*m23sq))+2.0*(g407*m13sq+
         g408*m23sq+g471*g323))+(g547-(3.0*g263)+28.0*g324-(12.0*g211*sw)-g633)*
         (g496*m13sq+g495*m23sq)+(g579-(128.0*g204))*(g1hzz*m13sq+g455)+(g618-(
         12.0*g211))*(g259*m13sq+g259*m23sq)+g595*(g181*m12sq+9.0*g205*m12sq)+
         g593*(g305*g1hzy+g464*g353)+(g616+48.0*g1hzy)*(g305*g245-(g277*g264*sw)
         )+(16.0*g216-(12.0*g231)+192.0*g171)*(g443+g420)+g583*(2.5*g317*g1hzz+
         g500*g1hzz+g496*g1hzz+g495*g1hzz+5.0*g366)+g574*(8.0*g167*g2hzy-(14.0*
         g166*g2hzy)+6.0*g199*g2hzy-(1.5*g475*g236))+g558*(6.0*g323*g1hzy+4.0*
         g323*g2hzy);
        t0=t0+g534*(1.33333*g499*g418-(2.33333*g418))+g571*(g598+28.0*g475*g192-
         (g470*g218)+1.33333*(g471*g208+g325))+(2.0*(g529+g528)-(16.0*g219)-(
         64.0*g208))*(g408+g407)+(g561+4.0*g236)*(g361*m13sq+g381*m23sq-(8.0*
         g465*m12sq)+2.0*g500*g323)+(g639-g622-g566)*(g400+g297)+(g619+84.0*g170
         -g620)*(g496*sw+g495*sw)+(2.0*g558-g609)*(g496*g1hzy+g495*g1hzy)+(128.0
         *g323-g574)*(g474*g143-(1.75*g338))+48.0*(g222-g211)*(g496*g348+g495*
         g355)+g530*(1.33333*g499*g336-(2.33333*g336))+g600*(256.0*g323-(5.0*
         g574))+(16.0*g215+60.0*g205)*(g496*g485+g495*g485)+(g606-g607)*(g297*
         m13sq+g400*m23sq)+(-(32.0*m12sq)-(64.0*m13sq))*(1.75*g299-g298)+(g604+
         2.0*g583)*(g287+g264);
        t0=t0+g599*(128.0*m12sq-(10.6667*g571))+sw*(g567+g546)+g244*(g608+g520)+
         g249*(-(48.0*g393)-(36.0*g293*m12sq))+g378*g265*(g617-g614)+g259*(24.0*
         g170-(48.0*g422*g2hzz)-g620)+g276*(g638-g622-g531+g606*m13sq-(g607*
         m12sq))+g483*g305*(24.0*g242*g1hzy-g554)+g281*(g603+g558-g609)+g470*
         g288*(576.0*g242+240.0*g246)+g303*g1hzy*(144.0*g242-g610)+g290*(g626*
         m12sq-g623)+g291*(g543-(2.0*g517)+g516+12.0*g248+32.0*g177)+g463*g1hzy*
         (g605+448.0*g200+12.0*(-g307-g246))+g303*(2.0*g548+4.0*g545+6.0*g521)+
         g532*g305+g470*g464*(g632-g629-(48.0*g248))+g309*(g632-g601-(48.0*g253)
         )+g313*(g615*g249-g623-(36.0*g250))+g314*(g548+3.0*g545-(10.0*g539)-(
         364.0*g168))+g315*(g624+112.0*g212+g621*g315);
        t0=t0+g515*g316+g317*(g515+140.0*g207-g634)+g323*(5.0*g550+14.0*g536+2.0
         *g524+64.0*g179)+g483*g464*(156.0*g205-(240.0*g195)-(144.0*g191)-g630)+
         1.33333*g564*g499*g330+g330*(-(10.8889*g555)-(2.33333*g551)-(784.0*g196
         ))+g334*(g564+192.0*(-g257-g258)-(112.0*g334*g334*g153))+g341*(g563+
         g535+g530+g525-(48.0*g257))+g342*(4.66667*g563-(2.33333*g526)+28.0*g316
         *g153)+g343*(g556-(160.0*g171))+g344*(g540+12.0*g235)+g348*(g608+g534-(
         12.0*g354)+192.0*g254)+g353*(g540+12.0*g234+48.0*g206*sw)+g526*g355+
         g361*(g580-(9.0*g261))+g483*g210*(-(32.0*g276)-(48.0*g297))+g481*g2hzz*
         (2.0*g594+112.0*g267-(48.0*g279)-(128.0*g269))+g594*g481*g1hzz+g475*
         g271*(g616-(108.0*g1hzy))+g373*(96.0*g270+24.0*g231);
        t0=t0+g374*(16.0*g178+208.0*g171-(12.0*g270))+g470*g1hzy*(1.33333*g549+
         2.0*g544-(48.0*g270)-(72.0*g232))+g378*(48.0*g153-(4.0*g575))+g475*
         m12sq*(g601-(224.0*g192)-g627)+g381*(g519-(9.0*g262))+g464*m13sq*(g532-
         (36.0*g261)+12.0*g253)+g500*m13sq*(g527-g625)+g482*m12sq*(-(1.75*g569)-
         (224.0*g258))+g474*m13sq*(1.33333*g526+256.0*g254)+g569*g474*m12sq+g471
         *sw*(12.0*g252+72.0*g170)+2.0*g586*g470*g244+g584*g483*m12sq+g394*(36.0
         *g316-(48.0*g289))+g395*(g610-(64.0*g485*g239))+g478*g1hzy*(-(1.28571*
         g593)-(48.0*g245))+g575*g495*g244+g496*g244*(g575-(6.0*g153))+g527*g500
         *m23sq+g426*g2hzz*(-g617-g614)+g426*(72.0*g424-(192.0*g423))+g244*g243*
         (48.0*g423-(24.0*g424));
        t0=t0+g429*(128.0*g171+24.0*(g271*m12sq-g232)-(1.33333*g556))+g345*g243*
         (g615-(36.0*g1hzy))+g206*g2hzy*(g613+336.0*g342-(120.0*g244)+240.0*g334
         )+g323*g222*(48.0*g244-g613)+g206*g1hzy*(24.0*g244-(96.0*g334)-(36.0*
         g341))+g323*sw*(96.0*g143+192.0*g170)+g323*g244*(-(12.0*g153)-(60.0*
         g211))+g316*m13sq*(2.0*g580-(16.0*g335))+g305*m13sq*(g566-(140.0*g168))
         +g200*g1hzy*(-(336.0*g276)-(784.0*g297))+g291*m23sq*(g636+g581)+g581*
         g291*m13sq+g177*m12sq*(-(8.0*g595)-(32.0*g313))+g289*m13sq*(g628+g627+
         168.0*g205)+g244*m13sq*(g562-g586)+g562*g244*m23sq+g2hzz*m12sq*(2.4*
         g579+192.0*g204+g604*m12sq)+g1hzz*m12sq*(g579-(64.0*g204))+g463*(g621+
         2.0*g554+g531+g521+288.0*g364);
        t0=t0+g464*(96.0*g157+84.0*(g394+g250)+24.0*g259*g247)+g465*(g631-(12.0*
         g533)+32.0*g219+64.0*g335-(280.0*g324)+4.0*(g529-g522)-(24.0*g266*g1hzy
         ))+g470*(24.0*g598+2.0*g597+48.0*g284+224.0*(g299+g212*m13sq)-(256.0*
         g599))+g471*(g635+3.0*g542+g536+16.0*g326-(28.0*g212)+12.0*g328)+g474*(
         g553+1.33333*g546)+g475*(15.0*g537+4.0*g523+144.0*g233+128.0*(g326-g214
         )-g624)+g478*(g631+g629-g628+g627-(3.0*g517)-(1.33333*g516)-(128.0*g177
         )+96.0*g205-(432.0*g195)-(240.0*g191))+g482*(-(2.33333*g567)-(1.75*g553
         ))+g483*(g597-(48.0*g298)+g625*g317-(g603*g343)+g640*g291+g605*g288)+
         g495*(g513+112.0*g295)+g496*(g513+112.0*g207)+g316*g236*(4.0*g316+12.0*
         g496)+g317*g236*(4.0*g317+12.0*g495);
        msq2=(t0+g500*(g542+g537+g518+g514+24.0*g328-g584)+g289*g289*(g585+g554)
         +g585*g290*g290+g313*g313*(g640-g637)-(g607*g481)-(g611*g260)-(24.0*
         g284*m13sq)-(g623*g289))/(cw*cw*cw*12.0*(g464*g244*g244-(g499*g276)));
    }
}
double g1167,g904,g1210,g1214,g754,g1168,g1206,g953,g649,g1216,g648,g1193,g1202,g957,g919,g816,g733,g650,g1156,g1141,g952,g845,g653,g1165,g651,g939,g844,g656,g652,g927,g1155,
       g654,g926,g1154,g655,g946,g874,g1215,g1208,g1148,g873,g1221,g658,g872,g659,g1196,g1169,g1146,g871,g870,g712,g713,g714,g715,g716,g667,g668,g669,g670,g671,g897,g1218,g866,
       g770,g865,g771,g896,g864,g772,g863,g773,g862,g774,g1192,g1195,g895,g722,g1064,g854,g842,g782,g707,g694,g1164,g857,g708,g695,g784,g709,g696,g785,g710,g786,g711,g760,g699,
       g761,g700,g762,g701,g763,g702,g764,g703,g717,g718,g705,g719,g706,g720,g721,g855,g723,g910,g803,g724,g725,g918,g817,g726,g1056,g1200,g884,g727,g951,g728,g1048,g729,g1219,
       g750,g730,g752,g731,g732,g868,g734,g867,g735,g736,g1023,g824,g737,g860,g916,g1194,g738,g1057,g828,g739,g888,g843,g829,g740,g890,g802,g741,g1209,g889,g742,g954,g1220,g885,
       g744,g748,g749,g751,g747,g869,g755,g758,g759,g767,g775,g776,g1139,g898,g861,g777,g899,g778,g859,g858,g973,g1100,g781,g1212,g917,g787,g856,g788,g789,g790,g853,g791,g795,
       g792,g909,g793,g977,g794,g883,g1135,g796,g879,g797,g924,g880,g798,g799,g1217,g1007,g800,g801,g804,g836,g815,g805,g806,g998,g913,g807,g908,g808,g1201,g809,g810,g811,g812,
       g974,g903,g813,g814,g818,g999,g886,g819,g825,g826,g827,g1058,g850,g837,g849,g838,g839,g840,g841,g846,g847,g848,g891,g851,g852,g875,g1144,g1205,g1204,g1005,g881,g894,g882,
       g943,g892,g893,g1054,g902,g906,g914,g907,g1001,g911,g925,g941,g962,g980,g940,g1017,g932,g930,g938,g961,g935,g1018,g1047,g965,g991,g1166,g948,g955,g959,g960,g963,g966,g970,
       g972,g975,g978,g979,g982,g1003,g1004,g1006,g1027,g1028,g1026,g1024,g1020,g1022,g1038,g1046,g1051,g1055,g1066,g1083,g1086,g1099,g1150,g1248,g1300,g1325,g1287,g1299,g1251,
       g1258,g1260,g1265,g1282,g1283,g1249,g1277,g1284,g1250,g1329,g1252,g1367,g1254,g1253,g1278,g1305,g1255,g1256,g1257,g1302,g1259,g1272,g1261,g1262,g1382,g1388,g1263,g1307,
       g1292,g1393,g1264,g1286,g1295,g1373,g1309,g1313,g1266,g1389,g1267,g1268,g1269,g1270,g1304,g1271,g1273,g1274,g1275,g1360,g1276,g1311,g1279,g1280,g1281,g1359,g1285,g1293,
       g1297,g1326,g1288,g1289,g1321,g1290,g1327,g1291,g1368,g1294,g1322,g1296,g1298,g1301,g1303,g1306,g1377,g1308,g1310,g1363,g1312,g1314,g1315,g1378,g1316,g1319,g1317,g1320,
       g1324,g1330,g1331,g1333,g1361,g1334,g1336,g1338,g1370,g1345,g1357,g1358,g1362,g1364,g1365,g1366,g1369,g1371,g1372,g1374,g1375,g1376,g1379,g1380,g1381,g1383,g1384,g1385,
       g1386,g1387,g1390,g1391,g1392,g1394,g1403,g1157,msq3;
{
    double t0 = 0;
    g1167=mz*mz;
    g904=g1167*ee;
    g1210=g1hzz*g1hzz;
    g1214=g904*g904;
    g754=g1214*g1210;
    g1168=mq*mq;
    g1206=mh*mh;
    g953=g1206*g1168;
    g649=g953*g754;
    g1216=m23sq*m23sq;
    g648=g1216*g649;
    g1193=ee*ee;
    g1202=g1193*ee;
    g957=g1202*mw;
    g919=g957*g1hzz;
    g816=g1167*g919;
    g733=g1168*g816;
    g650=g1206*g733;
    g1156=g1167*g1167;
    g1141=g1167*g1156;
    g952=g1141*m23sq;
    g845=g1193*g952;
    g653=g953*g845;
    g1165=g2hzz*g2hzz;
    g651=g1165*g653;
    g939=g1141*m13sq;
    g844=g1193*g939;
    g656=g953*g844;
    g652=g1165*g656;
    g927=g1168*m23sq;
    g1155=g1206*g1206;
    g654=g1155*g927*g754;
    g926=g1206*m23sq;
    g1154=g1168*g1168;
    g655=g1154*g926*g754;
    g946=g1206*g1hzz;
    g874=g946*sw;
    g1215=sw*sw;
    g1208=g1215*sw;
    g1148=g1208*sw;
    g873=g1193*g1148;
    g1221=g946*g946;
    g658=g1221*g873;
    g872=g1208*g946;
    g659=g1193*g872*g872;
    g1196=g1215*g1148;
    g1169=g1196*sw;
    g1146=g1169*sw;
    g871=g1193*g1146;
    g870=g1215*g871;
    g712=g1215*g754;
    g713=g1148*g754;
    g714=g1196*g754;
    g715=g1146*g754;
    g716=g1215*g715;
    g667=g712*m13sq;
    g668=g713*m13sq;
    g669=g714*m13sq;
    g670=g715*m13sq;
    g671=g716*m13sq;
    g897=sw*ee;
    g1218=g897*g897;
    g866=g1218*g1141;
    g770=g1210*g866;
    g865=g1141*g873;
    g771=g1210*g865;
    g896=g1215*g873;
    g864=g1141*g896;
    g772=g1210*g864;
    g863=g1141*g871;
    g773=g1210*g863;
    g862=g1141*g870;
    g774=g1210*g862;
    g1192=mw*mw;
    g1195=g1202*ee;
    g895=g1195*g1192;
    g722=g1215*g895;
    g1064=g1206*m12sq;
    g854=g1148*g895;
    g842=g854*m12sq;
    g782=g1167*g866;
    g707=g1206*g782;
    g694=g1165*g707;
    g1164=g1167*g1141;
    g857=g1164*g873;
    g708=g1206*g857;
    g695=g1165*g708;
    g784=g1164*g896;
    g709=g1206*g784;
    g696=g1165*g709;
    g785=g1164*g871;
    g710=g1206*g785;
    g786=g1164*g870;
    g711=g1206*g786;
    g760=g1165*g866;
    g699=g1154*g760;
    g761=g1165*g865;
    g700=g1154*g761;
    g762=g1165*g864;
    g701=g1154*g762;
    g763=g1165*g863;
    g702=g1154*g763;
    g764=g1165*g862;
    g703=g1154*g764;
    g717=g1168*g866;
    g718=g1168*g865;
    g705=g1165*g718;
    g719=g1168*g864;
    g706=g1165*g719;
    g720=g1168*g863;
    g721=g1168*g862;
    g855=g1167*g895;
    g723=g1206*g855;
    g910=g957*m12sq;
    g803=g1206*g910*g2hzz;
    g724=g1156*g803;
    g725=g957*g872;
    g918=g1156*g1hzz;
    g817=g957*g918;
    g726=g953*g817;
    g1056=g1hzz*mw;
    g1200=g1218*g897;
    g884=g1200*g1056;
    g727=g1168*g884;
    g951=g1168*g953;
    g728=g951*g816;
    g1048=g1216*m12sq;
    g729=g1048*g816;
    g1219=g1148*sw;
    g750=g1219*g816;
    g730=g750*m12sq;
    g752=g1169*g816;
    g731=g752*m12sq;
    g732=g733*m23sq;
    g868=g1218*g1165;
    g734=g868*m23sq;
    g867=g1165*g873;
    g735=g867*m23sq;
    g736=g1165*g844*m23sq;
    g1023=g2hzz*g1hzz;
    g824=g1023*g873;
    g737=g1154*g824;
    g860=g1168*ee;
    g916=g1141*g1hzz;
    g1194=g860*g860;
    g738=g1194*g916*g2hzz;
    g1057=g2hzz*mw;
    g828=g1200*g1057;
    g739=g1168*g828;
    g888=g897*g873;
    g843=g888*mw;
    g829=g843*g2hzz;
    g740=g1168*g829;
    g890=g897*g896;
    g802=g1057*g890;
    g741=g1156*g802;
    g1209=g1214*g904;
    g889=g1209*mw;
    g742=g946*g889;
    g954=g1168*g1167;
    g1220=g954*g954;
    g885=g1056*g890;
    g744=g1154*g885;
    g748=g1219*g817;
    g749=g1169*g817;
    g751=g1208*g816;
    g747=g1154*g751;
    g869=g1165*g896;
    g755=g1168*g869;
    g758=g1168*g868;
    g759=g1168*g867;
    g767=g784*m23sq;
    g775=g784*m13sq;
    g776=g1168*g854;
    g1139=g1167*g1164;
    g898=g1193*g1139;
    g861=g1165*g898;
    g777=g1206*g861;
    g899=g1156*g2hzz;
    g778=g1194*g899*g899;
    g859=g899*m23sq;
    g858=g899*m13sq;
    g973=g1hzz*m23sq;
    g1100=g973*g2hzz;
    g781=g1100*g844;
    g1212=m13sq*m13sq;
    g917=g1212*g1hzz;
    g787=g957*g917*sw;
    g856=g1156*g895;
    g788=g1168*g856;
    g789=g1168*g855;
    g790=g1156*g854;
    g853=g1216*g895;
    g791=g1168*g853;
    g795=g1212*g895;
    g792=g1168*g795;
    g909=g1168*mw;
    g793=g909*m12sq;
    g977=m23sq*m12sq;
    g794=g1193*g977;
    g883=g1216*g1hzz;
    g1135=g883*g2hzz;
    g796=g1135*g844;
    g879=g917*g2hzz;
    g797=g879*g845;
    g924=g1141*m12sq;
    g880=g1193*g924;
    g798=g1135*g880;
    g799=g880*g879;
    g1217=m12sq*m12sq;
    g1007=g1217*g1023;
    g800=g1007*g845;
    g801=g1007*g844;
    g804=g910*g899;
    g836=g1217*g957;
    g815=g836*sw;
    g805=g815*g2hzz;
    g806=g899*g836;
    g998=g1hzz*sw;
    g913=g1202*g998;
    g807=g913*g909;
    g908=g1154*g1hzz;
    g808=g957*g908*sw;
    g1201=g1194*g860;
    g809=g1201*g998*mw;
    g810=g889*m23sq;
    g811=g884*m23sq;
    g812=g889*m13sq;
    g974=g1hzz*m13sq;
    g903=g1202*g974;
    g813=g903*mw;
    g814=g817*m12sq;
    g818=g857*m13sq;
    g999=g1215*g1hzz;
    g886=g999*g2hzz;
    g819=g898*g886;
    g825=g1023*g896;
    g826=g1023*g871;
    g827=g1023*g870;
    g1058=g843*g1hzz;
    g850=g895*m13sq;
    g837=g1206*g850;
    g849=g895*m23sq;
    g838=g849*m12sq;
    g839=g1154*g850;
    g840=g850*m12sq;
    g841=g849*m13sq;
    g846=g861*m23sq;
    g847=g861*m13sq;
    g848=g861*m12sq;
    g891=g895*m12sq;
    g851=g1206*g891;
    g852=g855*m12sq;
    g875=g1215*m12sq;
    g1144=g1168*g1154;
    g1205=g1216*m23sq;
    g1204=g1212*m13sq;
    g1005=g2hzz*sw;
    g881=g1005*g957;
    g894=g1164*m12sq;
    g882=g919*g894;
    g943=g1208*g813;
    g892=g1156*g943;
    g893=g1217*g1206;
    g1054=g813*sw;
    g902=g913*m23sq;
    g906=g926*sw;
    g914=g1167*m23sq;
    g907=g1217*g914;
    g1001=g1148*g1hzz;
    g911=g1001*g2hzz;
    g925=g1167*m12sq;
    g941=g1219*g1hzz;
    g962=g1168*sw;
    g980=g1148*g962;
    g940=g1215*g980;
    g1017=g733*m13sq;
    g932=g1167*m13sq;
    g930=g932*g727;
    g938=g1168*m13sq;
    g961=g1156*m12sq;
    g935=g1048*g722;
    g1018=g1212*m12sq;
    g1047=g1217*m13sq;
    g965=g1206*g1167;
    g991=g1168*g1141;
    g1166=g1167*g1139;
    g948=g1148*g1141;
    g955=g1215*m23sq;
    g959=g1156*m23sq;
    g960=g1156*m13sq;
    g963=g1208*g814;
    g966=g1167*g808;
    g970=g1141*g803;
    g972=g1168*g1hzz;
    g975=g1206*g781;
    g978=m13sq*m12sq;
    g979=g1168*m12sq;
    g982=g1206*g1146;
    g1003=g1208*g650;
    g1004=g1212*g649;
    g1006=g793*sw;
    g1027=g1208*m12sq;
    g1028=g1219*m12sq;
    g1026=g1169*m12sq;
    g1024=m23sq*m13sq;
    g1020=g1146*g1023;
    g1022=g1024*g649;
    g1038=g1146*g649;
    g1046=g974*g810;
    g1051=g927*g722;
    g1055=g914*g727;
    g1066=g1146*m12sq;
    g1083=g1146*g738;
    g1086=g729*sw;
    g1099=g2hzz*m12sq;
    g1150=g875*g875;
    g1248=1728.0*g848+1152.0*g847+576.0*(g797+g796-g975-(g1193*g858*g858)+g652-(
     g1193*g859*g859)+g651-g777)+288.0*(g801+g800+g799+g798)+72.0*(g1004+g648)-(
     216.0*g655)-(36.0*g654);
    g1300=8.0*g1206*g842-(12.0*g1064*g722);
    g1325=8.0*g1167*g842-(12.0*g925*g722);
    g1287=g1325+g1300;
    g1299=64.0*g1206*g774-(224.0*g1206*g773)+328.0*g1206*g772-(240.0*g1206*g771)
     +72.0*g1206*g770;
    g1251=g1299-g1287+336.0*g1208*g804-(120.0*g1210*g857);
    g1258=512.0*g1165*g786-(1792.0*g1165*g785);
    g1260=448.0*g1154*g715-(656.0*g1154*g714)+480.0*g1154*g713-(144.0*g1154*g712
     )-(128.0*g1154*g716);
    g1265=g1251-(18.0*g789)+36.0*g1003+216.0*g747;
    g1282=64.0*g1168*g749-(160.0*g1168*g748)-(576.0*g1165*g717);
    g1283=168.0*g1141*g884-(160.0*g916*g843);
    g1249=g1283+g1282+g1265-(1.25*g1260)-g1258-(84.0*g963)-(576.0*g706)+1152.0*
     g705;
    g1277=80.0*g748-(32.0*g749);
    g1284=112.0*g773-(164.0*g772)+120.0*g771-(36.0*g770)-(32.0*g774);
    g1250=2.0*g1284+g1277;
    g1329=32.0*g731-(80.0*g730);
    g1252=112.0*g715*m12sq-(164.0*g714*m12sq)+120.0*g713*m12sq-(36.0*g712*m12sq)
     -g1329-(32.0*g716*m12sq);
    g1367=3.0*g1258;
    g1254=g1367-g1299+36.0*g723;
    g1253=2.0*g1282-(3.0*g1260)-g1254+36.0*g789-(5248.0*g706)+3840.0*g705+64.0*
     g790+1008.0*g747;
    g1278=32.0*g671-(112.0*g670)+164.0*g669-(120.0*g668)+36.0*g667;
    g1305=32.0*g716*m23sq-(112.0*g715*m23sq)+164.0*g714*m23sq-(120.0*g713*m23sq)
     +36.0*g712*m23sq;
    g1255=4.0*(-g1305-g1278);
    g1256=8.0*g795+16.0*g841-(32.0*g723);
    g1257=1536.0*g1146*g848-(32.0*g1146*g654)-(192.0*g1146*g655)+64.0*(g1146*
     g648+g1146*g1004)+256.0*(g1146*g798+g1146*g799+g1146*g800+g1146*g801+g1146*
     g1022)+1024.0*(g1146*g846+g1146*g847)+512.0*(g1146*g651+g1146*g652-(g1146*
     g975)+g1146*g796+g1146*g797-(g1146*g777));
    g1302=32.0*g1216*g716-(112.0*g1216*g715)+164.0*g1216*g714-(120.0*g1216*g713)
     +36.0*g1216*g712;
    g1259=g1260-g1302;
    g1272=8.0*g842-(12.0*g722*m12sq)-g1252;
    g1261=g1284+g1272+84.0*g751*m12sq-(36.0*g1167*g727);
    g1262=-(24.0*g1047*g722)-(36.0*g1018*g722);
    g1382=36.0*g837;
    g1388=72.0*g723;
    g1263=g1388+g1382;
    g1307=32.0*g1221*g870-(112.0*g1221*g871);
    g1292=g1307+164.0*g659-(120.0*g658)+36.0*g1193*g874*g874;
    g1393=48.0*g722;
    g1264=g1292-g1393;
    g1286=g1250+288.0*g760;
    g1295=256.0*g764-(896.0*g763);
    g1373=128.0*g741;
    g1309=g1373-(48.0*g776);
    g1313=g1295+1312.0*g762;
    g1266=g1313+g1309+g1286-(960.0*g761);
    g1389=32.0*g790;
    g1267=g1389+36.0*g856;
    g1268=9.0*(g1204*g895+g1205*g895);
    g1269=32.0*(-g850-g849);
    g1270=3.0*g1284+2.0*(g1313+g1277);
    g1304=128.0*g1168*g786-(448.0*g1168*g785)-(480.0*g1168*g857)+144.0*g1168*
     g782;
    g1271=328.0*g767-g1304;
    g1273=128.0*(-(g939*g802)-(g952*g802));
    g1274=32.0*g1169*g729-(80.0*g1219*g729)-(36.0*g1086);
    g1275=9.0*(-g851-g852);
    g1360=g1164*g885-(2.5*g1164*g1058);
    g1276=64.0*g1360;
    g1311=128.0*(-(g1217*g1017)-(g1217*g732))-(192.0*g1164*g813);
    g1279=g1311+64.0*g889*g883+256.0*g1046;
    g1280=640.0*g740-(672.0*g739);
    g1281=64.0*g711-(224.0*g710)+328.0*g709-(240.0*g708)+72.0*g707;
    g1359=7.0*g1139*g826-(10.25*g1139*g825)+7.5*g1139*g824-(2.25*g819)-(2.0*
     g1139*g827);
    g1285=256.0*g1359;
    g1293=672.0*g720-(192.0*g721);
    g1297=32.0*g786-(112.0*g785)+36.0*g782;
    g1326=-(16.0*g1297)-(2624.0*g784);
    g1288=g1326+2.66667*g1293;
    g1289=576.0*g734-(1920.0*g735);
    g1321=720.0*g718-(216.0*g717)-(984.0*g719);
    g1290=g1297-g1293-g1321;
    g1327=-(12.0*g722)-(80.0*g750);
    g1291=g1327+32.0*g752;
    g1368=256.0*g802;
    g1294=640.0*g829-(672.0*g828)-g1368;
    g1322=-(84.0*g725)-(504.0*g727);
    g1296=2.0*g1322-g1264+432.0*g807;
    g1298=-(192.0*g744)-(144.0*g805);
    g1301=288.0*(-(g1024*g804)-g970)+144.0*(-(g1212*g804)-(g1216*g804));
    g1303=32.0*g716-(112.0*g715)+164.0*g714-(120.0*g713)+36.0*g712;
    g1306=96.0*g1154*g838+24.0*g977*g795+8.0*g1192*g794*g794;
    g1377=32.0*g776;
    g1308=g1298-(72.0*g808)-g1377;
    g1310=480.0*g739-(1280.0*g740);
    g1363=4.0*g1300;
    g1312=432.0*g809-g1363;
    g1314=4800.0*g818-(6560.0*g775);
    g1315=-(576.0*g881)-(1024.0*g802);
    g1378=36.0*g787;
    g1316=128.0*g744-g1378;
    g1319=-(64.0*g742)-(128.0*g724);
    g1317=g1319-(64.0*g726);
    g1320=1792.0*g826-(512.0*g827);
    g1324=4.0*g1287+g1258;
    g1330=656.0*(g775+g767);
    g1331=g1373-g1377;
    g1333=36.0*(m13sq+m23sq);
    g1361=14.2222*g1333;
    g1334=480.0*(-g973-g974);
    g1336=192.0*g729-(256.0*g724);
    g1338=512.0*g781+1024.0*g738;
    g1370=512.0*g736;
    g1345=128.0*(-g978-g977);
    g1357=-(2.66667*g961*g722)-(4.66667*g961*g725)-(9.33333*g1208*g724);
    g1358=g1165*g711-(3.5*g1165*g710);
    g1362=20.0*g1304;
    g1364=3.0*g1289;
    g1365=8.0*g1281;
    g1366=1.125*g1269;
    g1369=72.0*g1054*m12sq;
    g1371=54.0*m12sq;
    g1372=36.0*g650;
    g1374=7872.0*g767;
    g1375=6080.0*g755;
    g1376=3456.0*g758;
    g1379=72.0*g787;
    g1380=432.0*g808;
    g1381=72.0*g849;
    g1383=144.0*g809;
    g1384=576.0*g738;
    g1385=72.0*g1144*g895;
    g1386=1920.0*g824;
    g1387=9.0*g795;
    g1390=24.0*g725;
    g1391=168.0*g725;
    g1392=144.0*g807;
    g1394=-(168.0*g811);
    g1403=cw*cw*cw;
    g1157=g1403*g1403;
    {
        t0=1.125*g1306-(3.5*g1257)+4.0*(g1297*g972*g972+g1327*g979*g979)+(g1290+
         164.0*g784)*(g974*g974+g973*g973)+256.0*(-g656-g653)*(g941*g941-(3.5*
         g1001*g1001)-(3.75*g999*g999)-(4.0*g1215*g1020)+14.0*g1020+8.25*g911+
         1.125*(g998*g998-g886))+1312.0*(-(g1196*g656)-(g1196*g653))*(g1210-(
         3.34146*g1023))+128.0*(g728-g726)*(1.125*sw*m12sq+2.5*g1028-g1026)+(
         144.0*g728-(72.0*g726)-(1.125*g1319))*(sw*m13sq+m23sq*sw)+(g1288-(
         2336.0*g719)+1344.0*g718-(288.0*g717))*(g1135+g879)+g1289*(g924*m13sq+
         g1212*g1141-(g1206*g939))+g1277*2.0*(g926*m12sq-(g926*m13sq)-(g1155*
         m12sq)+g1206*g978+g893);
        t0=t0+(-(384.0*g927)-(64.0*g926))*(g731*m13sq-(2.5*g730*m13sq)+g671*
         m12sq-(3.5*g670*m12sq)+5.125*g669*m12sq-(3.75*g668*m12sq)+1.125*g667*
         m12sq)+336.0*(g960+g959)*(g727*m12sq+3.80952*g740*m12sq-(4.0*g739*m12sq
         ))+144.0*(g812+g810)*(2.0*g962*g2hzz+g1005*m12sq+1.33333*g1026*g1hzz+
         3.5*g1027*g1hzz+2.22222*g1028*g2hzz-(2.33333*g1027*g2hzz)-(2.66667*g940
         *g1hzz)+6.66667*g1168*g941)+(512.0*g974-(2048.0*g972))*(g711*g2hzz-(3.5
         *g710*g2hzz))+(-(480.0*g941)-(216.0*g998))*(g812*m12sq+g810*m12sq)+36.0
         *(-(g1204*sw)-(g1205*sw))*(g816*m12sq-g733)+g1334*(2.13333*g1099*g721-(
         7.46667*g1099*g720)+10.9333*g1099*g719-(8.0*g1099*g718)+2.4*g1099*g717+
         2.66667*g1099*g786-(9.33333*g1099*g785)+3.0*g1099*g782);
        t0=t0+g1333*(g1357+42.6667*g1215*g1083-(149.333*g1083)+186.667*g1196*
         g738+9.33333*g1208*g806)+g1317*(g1169*m13sq+g1169*m23sq)+12.0*(g1329+
         g1284)*(g1154*m13sq+g1154*m23sq)+(g1370+g1338)*(g1215*g1066-(3.5*g1066)
         +5.125*g1196*m12sq)+(-(2.5*g1317)-(320.0*g806))*(g1219*m13sq+g1219*
         m23sq)+g1322*(g1212*g925+g1216*g925)+g1293*5.33333*(g1165*g977+g1165*
         g1024)+g1345*(1.125*g1154*g722-(g1169*g650)+2.5*g1219*g650-(g1215*g1038
         )+3.5*g1038-(5.125*g1196*g649)+3.75*g1148*g649-(2.0*g1210*g721)+7.0*
         g1210*g720-(10.25*g1210*g719)+7.5*g1210*g718-(2.25*g1210*g717)-(2.625*
         g1003))+g1278*(-(7.0*g1216*g1168)-(2.0*g1216*g1206))+g1303*(4.0*g1206*
         g1144-(g1204*g1168)-(g1205*g1168));
        t0=t0+(-g1370-(1536.0*g738))*(g1215*g982-(3.5*g982))+(g1336-(384.0*g742)
         )*(2.5*g980-g940)+(g1310+g1296-(3456.0*g737))*(g952+g939)+g1360*(-(
         256.0*m12sq)-(192.0*m23sq))+(g1361+512.0*m12sq)*(g1358+5.125*g696-(3.75
         *g695)+1.125*g694-g1359)+m12sq*(g1273+g1268-g1385)+m13sq*(3.0*g1274-(
         36.0*g935)-(640.0*g941*g810)-(g1374*g1165))+sw*(g1301-(1.125*g1279)+
         288.0*g882)+g1262*m23sq+g699*(48.0*g1333+1152.0*m12sq)+g700*(-(74.6667*
         g1333)-(3840.0*m12sq))+g701*(5248.0*m12sq-(8.88889*g1333))+g702*(
         49.7778*g1333-(3584.0*m12sq))+g703*(1024.0*m12sq-g1361)+g1220*g843*(
         320.0*g1hzz*m12sq-g1334-(160.0*g946)-(1280.0*g1099))+g788*(-g1333-(
         144.0*m12sq))+g791*(-g1371-(54.0*m13sq))+g792*(-g1371-(54.0*m23sq));
        t0=t0+g839*(108.0*m12sq+216.0*m23sq)+g875*(1.125*g1338+144.0*g649*m23sq)
         +g1141*g890*g793*(256.0*g2hzz-(384.0*g1hzz))+g894*(g1376-g1364+g1294+
         288.0*g881+15744.0*g755-(11520.0*g759))+g1312*g914+g1164*mw*(216.0*g902
         -(72.0*g1202*g874))+g916*(960.0*g888*g793-(144.0*g815))+g924*(g1393+
         g1292-g1280-(3840.0*g737)-(1008.0*g727))+g925*(288.0*g809-g1387)+g927*(
         g1324+g1263)+g1156*g938*(-g1390-g1264)+g932*(g1312-(18.0*g838)+96.0*
         g930+g1394*g932)+g938*(g1388+g1324-(108.0*g838))+g1167*g965*(g1369+64.0
         *g744+216.0*g808)+g1167*g991*(g1315-(8832.0*g735)+4032.0*g734)+g1154*
         g1141*(g1315+2560.0*g829-(960.0*g828))+g1166*g1165*(1792.0*g871-(512.0*
         g870))+g1269*g948+g1217*g1168*(g1366+g1255-(256.0*g741));
        t0=t0+g1168*g954*(g1381-(216.0*g787))+8.0*g1300*g954+g955*(g1384+24.0*
         g955*g840)+g1294*g1217*g1141+g959*(g1379+g1369+g1308+g1386*g959)+g960*(
         g1308+g1394*m12sq+g1386*g960)+g961*(144.0*g808+g1386*g961-g1316-(128.0*
         g776))+g962*(1.125*g1336-(288.0*g742)+48.0*g962*g962*g817)+g1316*g1217*
         g1167+g1210*g1168*(2.0*g1281-g1330)+g977*(g1253-(18.0*g837))+g978*(
         g1253+144.0*g1051+432.0*g732*sw-(g1391*g914))+g979*(g1382-(6.0*g1302)+
         2.0*g1254)+g1206*g1196*(-(2624.0*g736)-(6144.0*g738))+g1212*g1206*(
         g1252-(2.0*g1305))+g1212*g1168*(6.0*g1252-(7.0*g1305))+g991*(6.0*g1307+
         768.0*g659+864.0*g725+288.0*(-g658-g722))+g1007*(2.66667*g1321+g1288)+
         2.0*g1290*g1210*g1024;
        t0=t0+g1217*g1024*(168.0*g751+64.0*g752-(160.0*g750))+g1018*(3.0*g1305+
         g1266+216.0*g733*sw)+g1024*(g1389-g1367+4.0*g1282+2.0*g1265-(3.5*g1260)
         -(6400.0*g706)+6144.0*g705)+g1216*sw*(36.0*g814+108.0*g1017-g1372)+
         g1209*g793*(432.0*g998-(288.0*g1005))+g1165*g978*(5.33333*g1293-(1728.0
         *g782))+g1331*g1047+g1048*(3.0*g1278+g1266)+g1154*g725*(144.0*(-g932-
         g914)-(336.0*g925))+g1156*g927*(g1393-g1390)+g1054*72.0*(g914*g914-g907
         )+g1055*(96.0*g914-(1008.0*g978))+g1148*m12sq*(96.0*g839-(1920.0*g781))
         +g1165*m12sq*(1.2*g1314-g1374)+g1064*(g1259-g1387)+g1217*m23sq*(g1331+
         2.0*g1278)+g1216*m13sq*(g1270-(1920.0*g761)+576.0*g760)+g1212*m23sq*(
         3.0*g1329+g1270)+g1154*m12sq*(8.0*g1284+512.0*g741);
        t0=t0+g1210*m23sq*(-g1304-g1281)+g1210*m13sq*(g1271-g1281)+g1164*m13sq*(
         g1375-g1364-(8832.0*g759)+4032.0*g758)+g1144*g751*(-(12.0*g1333)-(672.0
         *m12sq))+g1212*sw*(108.0*g732-g1372)+1.5*g1260*g1206*m13sq+g1202*g1006*
         576.0*(g858+g859)+g1100*m13sq*(10.6667*g1293-(9920.0*g719)+6528.0*g718-
         (1728.0*g717)-(48.0*g1297))+g1100*(g1365+g1362+5760.0*g818)+g650*sw*(
         1.125*g1345-(72.0*g1024))+g1023*m12sq*(g1365+g1314-(20.0*g1271))+g977*
         m13sq*2.0*(g1309+g1250)+g707*g2hzz*(576.0*g974-(1728.0*g972))+g708*
         g2hzz*(6528.0*g972-(1920.0*g974))+g709*g2hzz*(2624.0*g974-(9920.0*g972)
         )+g974*g2hzz*(g1362-g1374)+20.0*g1330*g972*g2hzz+g959*m13sq*(g1391+
         g1264+528.0*g727-g1392)+g649*m13sq*(144.0*g875+288.0*g955);
        t0=t0+g741*m12sq*512.0*(-g938-g927)+g808*m13sq*432.0*(-g925-g914)+g914*
         m12sq*(-g1380-(108.0*g787))+5.0*g1326*g908*g2hzz+g1139*(2.0*g1289+128.0
         *g885-(320.0*g1058)+336.0*g884-(3456.0*g755)+6912.0*g759-(144.0*g913*mw
         )-g1376)+g1141*(g1366-(2.0*g1298)-(36.0*g891)+192.0*g776-(32.0*g842)-
         g1380-g1379)+g1168*g1144*(4.0*g1303+288.0*g751)+g1144*(6.75*g1269+2.0*
         g1255-(72.0*g855)+2944.0*g762+768.0*g761+4.0*(g1295-g1286)-(8.0*g1272))
         +g1148*(g1306-(3.33333*g1248)-(960.0*g1022)+8064.0*g778)+g1256*g1150+
         g1154*(g1367+6.0*g1283+g1267-(2.0*g1263)-(336.0*g963)-(216.0*g892)+
         108.0*(g853+g795)+4.0*(g1275+g1251))+g1155*(4.0*g1325+36.0*g852+168.0*
         g963+72.0*(-g789-(g814*sw)));
        t0=t0+g1156*(g1383-g1363+144.0*(-(g1006*g903)-(g902*g793))+36.0*(g841-
         g851)+72.0*(g838+g840-(g906*g813)))+g1164*(32.0*g854+36.0*g895+9600.0*
         g737+504.0*(-g943-g811)+4800.0*g911*g794-(2.0*g1310)-g1296)+g1166*(
         g1386+g1320+1920.0*g867-(576.0*g868)+2624.0*(-g869-g825))+g1167*(72.0*
         g839-(576.0*g819)+g1393*g893-(36.0*g883*g815)+144.0*g1144*g725+288.0*
         g954*g805+g1375*g952)+g1168*(6.0*g1276-(6400.0*g696)+6144.0*g695-(
         2304.0*g694)+2.0*(-g1268-g1262)+4.0*(g1285-g1273)+72.0*(g935-g1357)-(
         1024.0*g1358))+g1169*(g1279+128.0*g916*g836)+g1196*(4.55556*g1248+
         1312.0*g1022+5248.0*g846+960.0*g778)+g1215*m13sq*(g1384+252.0*g1086)+
         g793*g793*(36.0*g1195+32.0*g1200*g897)+g1204*(g1305+g1261);
        t0=t0+g1205*(g1278+g1261)+g1206*(g1385+g1285+g1276-g1274-(512.0*g703)+
         1792.0*g702-(2624.0*g701)+1920.0*g700-(576.0*g699)+72.0*(g788+g918*g815
         )+18.0*(g792+g791)+g1378*g925+g1369*g914+g1368*g924+2304.0*g1141*g737)+
         g1208*672.0*(g1046+g970-g882)+g1220*g954*(2.0*g1320-(4096.0*g825)+
         1536.0*g824)+g1212*(2.0*g1302+g1249-(108.0*g1055))+g977*g751*(84.0*g977
         +252.0*g1212)+g1215*(g1257+g1248-(5184.0*g778)+64.0*g948*g787)+g1216*(
         g1275+g1249+27.0*g840-(168.0*g892)-(108.0*g930)-(216.0*g966))+g1217*(
         1.125*g1256+48.0*g1051-(144.0*g966)+336.0*(g747-g930)+2.0*(g1283+g1267)
         -g1259)+g1219*(2.22222*g1301-(2.5*g1311))+g1220*(g1264-(216.0*g811)-(
         120.0*g725))+g972*g784*(656.0*g972+13120.0*g1099);
        msq3=(t0+g978*g978*(g1303+g1291+84.0*g751)+g925*g925*(g1280-(96.0*g722)-
         g1391)+g965*g965*(g1392-(144.0*g727))+g1291*g977*g977+g1168*g962*(-(
         576.0*g804)-(288.0*g1154*g816))-(g1383*g965)+72.0*g906*g814-(336.0*g907
         *g727)+144.0*g1201*g1192*g860-(g1381*g951)+36.0*g953*g838)/(g1157*g1148
         *(48.0*g1139-(96.0*g894))+48.0*g1157*g1150*g1141);
    }
}

  double msq_tot = ( msq1 +msq2 + msq3 ) * (pow(mh - mz,2) - pow(mQ + mQ,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq_tot;
  if( width < 0 ) return 0;
  return width;
};

double mHZuU( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  double mQ =  _par[2];
  // double mQ =  _par[3]; // Massen der FS Fermionen sind gleich
  double ee =  _par[4];
  double sw =  _par[5];
  //double CKM = _par[6];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  //double g3hzz = _par[9];
  //double g1hww = _par[10];
  //double g2hww = _par[11];
  //double g3hww = _par[12];
  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mQ + mQ, 2 )) + pow( mQ + mQ, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mQ,2), pow(mQ,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mQ,2) + pow(mQ, 2) + pow(mz,2) - m12sq - m23sq;

  double g87,g88,g44,g86,g9,g98,g4,g90,g40,g5,g39,g49 ,g6,g38,g7,g46,g82,g11,g8,g97,g45,g14,g10,g96,g12,g95,g13,g62,g15,g43,g83,g19,g16,g17,g18,g26,
	 g20,g28,g21,g23,g27,g42,g99,g31,g29,g80,g30,g66,g32 ,g47,g34,g33,g35,g36,g37,g48,g50,g51,g89,g53,g54,g55,g61,g60,g74,g75,g81,g105, g106,g107,g131,
	 g108,g109,g133,g134,g110,g136,g111,g112,g115,g138,g113,g114,g122 ,g127,g116,g135,g117,g118,g128,g120,g121,g123,g124,g125,g126,g129,g130,g132, g137,msq1;
    {
    double t0 = 0;
    g87=ee*ee;
    g88=mQ*mQ;
    g44=g88*g87;
    g86=mh*mh;
    g9=g86*g44;
    g98=g2hzy*g2hzy;
    g4=g98*g9;
    g90=mz*mz;
    g40=g90*m23sq;
    g5=g87*g86*g40;
    g39=g87*m13sq;
    g49=g90*g88;
    g6=g49*g39;
    g38=g87*m12sq;
    g7=g49*g38;
    g46=g90*g87;
    g82=g88*g88;
    g11=g82*g46;
    g8=g98*g11;
    g97=g1hzy*g1hzy;
    g45=g97*g87;
    g14=g90*g45;
    g10=g86*g86*g14;
    g96=m23sq*m23sq;
    g12=g96*g14;
    g95=m13sq*m13sq;
    g13=g95*g14;
    g62=g2hzy*g1hzy;
    g15=g62*g46;
    g43=g98*g87;
    g83=g90*g90;
    g19=g83*g43;
    g16=g19*m23sq;
    g17=g19*m13sq;
    g18=g90*g43;
    g26=g83*g45;
    g20=g26*m23sq;
    g28=g86*g45;
    g21=g86*g28;
    g23=g26*m13sq;
    g27=g96*g45;
    g42=m13sq*g1hzy;
    g99=g42*g42;
    g31=g99*g87;
    g29=g97*g44;
    g80=g90*g83;
    g30=g80*g43;
    g66=g88*m12sq;
    g32=g66*g1hzy;
    g47=g87*g62;
    g34=g83*g47;
    g33=g34*m23sq;
    g35=g80*g47;
    g36=g97*g39;
    g37=g97*g38;
    g48=g83*g2hzy;
    g50=g96*g15;
    g51=g95*g15;
    g89=m12sq*m12sq;
    g53=g89*g14;
    g54=g97*g11;
    g55=g97*g9;
    g61=m13sq*m12sq;
    g60=g62*g11;
    g74=g6*m12sq;
    g75=g5*m13sq;
    g81=g88*g82;
    g105=6.0*(-(g31*m23sq)-(g27*m13sq));
    g106=24.0*(-g23-g20);
    g107=32.0*(g17+g16);
    g131=32.0*g35;
    g108=16.0*(g13+g12)-g131;
    g109=32.0*(g34*m13sq+g33);
    g133=8.0*g36;
    g134=8.0*g45*m23sq;
    g110=-g134-g133;
    g136=2.0*g27;
    g111=g136+2.0*g31;
    g112=16.0*g5*m12sq-(32.0*g86*g7);
    g115=32.0*g19-(16.0*g26);
    g138=32.0*g34;
    g113=-g138-g115;
    g114=96.0*(g86*g6+g88*g5);
    g122=8.0*m23sq;
    g127=8.0*m13sq;
    g116=-g127-g122;
    g135=8.0*g29;
    g117=2.0*g37-g135;
    g118=-(2.0*g28)-(12.0*g29);
    g128=32.0*m13sq;
    g120=g53-(2.0*g89*g15);
    g121=8.0*g116;
    g123=8.0*m12sq;
    g124=14.0*m12sq;
    g125=64.0*m12sq;
    g126=96.0*m12sq;
    g129=8.0*g21;
    g130=8.0*g21*m23sq;
    g132=32.0*g30;
    g137=32.0*g18*m23sq;
    {
        t0=(g128+16.0*m12sq)*(g96*g18+g20-(3.0*g33))+g116*(g120+g10)+m12sq*(16.0
         *g23-(96.0*g17)-g105)+m13sq*(g130+32.0*g50)+m23sq*(224.0*g60+32.0*g51)+
         g8*(g125+4.0*g116)+g9*(16.0*g99-(192.0*g48*g1hzy))+g12*(-g128-g124-g122
         )+g13*(-g127-g124-(32.0*m23sq))+g16*(-g126-(96.0*m13sq))+g82*g28*(6.0*
         g116-g123)+g30*(g126-g121)+g35*(g125-g121)+g54*(19.0*g116-(56.0*m12sq))
         +g86*g61*16.0*(g14+g15)+g61*(g137+8.0*g55-(48.0*g34))+g62*(g114+g112-(
         192.0*g6*m23sq))+g82*m23sq*(112.0*g36+24.0*g37)+g89*m23sq*(4.0*g36-g135
         )+g66*(192.0*g19-(12.0*g27)-(32.0*g26))+g95*m12sq*(g118+16.0*g18)+g86*
         m12sq*(g115-g136)+g98*m23sq*64.0*(-g7-g6)+g97*m23sq*(56.0*g7+144.0*g6);
        t0=t0+g61*m23sq*(2.0*g118-(28.0*g14))+g55*m23sq*(g123+64.0*m13sq)+g42*
         g2hzy*(224.0*g11-(32.0*g5))+g80*(g110+8.0*g28+16.0*g29)+g81*(8.0*g110+
         32.0*g28+112.0*g14-(192.0*g15)+64.0*g18-(16.0*g37))+g82*(g129+20.0*g111
         +64.0*g26-(288.0*g34)+96.0*g19+24.0*g36*m12sq)+g83*(g129-(64.0*g4)+48.0
         *g55)+g86*(g109+g108+g107+g106+2.66667*g105+136.0*g54-(160.0*g60)-(32.0
         *g8)+8.0*g53-g132)+g88*(16.0*g120+7.0*g109+4.0*g108+g107+2.66667*g106+
         9.33333*g105+48.0*g10+64.0*(-g51-g50)-(g127*g21)+32.0*g81*g45-g130)+g89
         *(g111-(g127*g29)-g138)+g90*(g128*g4-g132-g131)+g96*m23sq*(g133+g117)+
         g95*m13sq*(g134+g117)+g95*(g137+g113+16.0*g27)+g96*(g113+16.0*g55)+g97*
         (g112+56.0*g74+40.0*g75-(1.08333*g114));
        msq1=(t0+g98*(-(64.0*g74)-(32.0*g75))+g87*g32*(8.0*g32+96.0*g48)+32.0*
         g40*g4)/(3.0*g90*g89);
      };
  };
 float g486,g294,g491,g221,g484,g154,g471,g144,g303,g502,g266,g222,g400,g293,g223,g321,g375,g147,g212,g171,g148,g472,g476,g150,g496,g409,g497,g408,g382,g153,g500,g483,
       g176,g307,g276,g238,g211,g177,g308,g430,g254,g157,g239,g237,g182,g158,g269,g377,g270, g378,g240,g193,g475,g195,g268,g230,g275,g201,g465,g167,g168,g169,g479,g278,
       g244,g170,g315,g172,g209,g374,g178,g310,g179,g218,g180,g214,g366,g281,g368,g422,g184,g198,g199,g421,g429,g380,g224,g225,g367,g192,g280,g196,g345,g357,g248,g197,
       g200,g354,g363,g304,g205,g206,g456,g207,g325,g208,g342,g229,g213,g394,g215,g216,g267,g501,g232,g217,g219,g220,g464,g305,g274,g231,g396,g272,g233,g234,g235,g236,
       g455,g242,g245,g243,g288,g246,g356,g346,g247,g444,g249,g284,g250,g262,g251,g252,g423,g253,g283,g255,g466,g379,g265,g258,g259,g260,g261,g263,g344,g264,g271,g282,
       g277,g306,g314,g285,g289,g290,g291,g292,g355,g296,g298,g353,g299,g300,g362,g316,g317,g318,g401,g324,g326,g327,g329,g331,g335,g336,g337,g339,g343,g349,g365,g482,
       g395,g419,g424,g425,g427,g553,g515,g635,g524,g537,g601,g543,g551,g514,g519,g525,g624,g516,g627,g560,g517,g631,g518,g569,g523,g530,g520,g526,g536,g556,g539,g521,
       g540,g603,g638,g522,g535,g527,g534,g529,g548,g634,g528,g531,g546,g549,g532,g544,g628,g533,g636,g538,g545,g613,g541,g547,g550,g552,g554,g637,g555,g557,g559,g562,
       g563,g564,g565,g567,g623,g640,g568,g570,g612,g572,g584,g605,g575,g619,g576,g620,g621,g580,g581,g582,g585,g639,g586,g587,g610,g617,g607,g608,g594,g595,g596,g598,
       g599,g600,g602,g604,g606,g609,g611,g614,g615,g616,g618,g622,g625,g626,g629,g630,g632,g633,g641,msq2;
    {
    double t0 = 0;
    g486=mz*mz;
    g294=g486*g1hzy;
    g491=ee*ee;
    g221=g491*g294*g1hzz;
    g484=mh*mh;
    g154=g484*g221;
    g471=mQ*mQ;
    g144=g471*g154;
    g303=g486*ee;
    g502=g303*g303;
    g266=g502*g2hzz;
    g222=g471*g266;
    g400=g484*g2hzy;
    g293=g502*g1hzz;
    g223=g293*g2hzy;
    g321=g471*g223;
    g375=g484*g1hzy;
    g147=g375*g222;
    g212=g293*g1hzy;
    g171=g471*g212;
    g148=g484*g171;
    g472=g484*g484;
    g476=g471*g471;
    g150=g476*g154;
    g496=m23sq*m23sq;
    g409=g496*m13sq;
    g497=m13sq*m13sq;
    g408=g497*m23sq;
    g382=g496*m12sq;
    g153=g382*g221;
    g500=sw*sw;
    g483=g500*sw;
    g176=g483*g221;
    g307=g491*g483;
    g276=g500*g307;
    g238=g276*g1hzy;
    g211=g238*g1hzz;
    g177=g486*g211;
    g308=g491*mw*ee;
    g430=g2hzy*m12sq;
    g254=g430*g308;
    g157=g486*g484*g254;
    g239=g500*g308;
    g237=g239*g1hzy;
    g182=g484*g237;
    g158=g471*g182;
    g269=g307*g2hzy;
    g377=g484*g2hzz;
    g270=g276*g2hzy;
    g378=g484*g1hzz;
    g240=g276*g1hzz;
    g193=g483*g223;
    g475=g500*g483;
    g195=g475*g223;
    g268=g307*g1hzy;
    g230=g238*g2hzz;
    g275=g307*g2hzz;
    g201=g471*g275;
    g465=g486*g486;
    g167=g465*g201;
    g168=g475*g222;
    g169=g378*g268;
    g479=g486*g465;
    g278=g491*g479;
    g244=g484*g278;
    g170=g471*g244;
    g315=g476*g465;
    g172=g315*g240;
    g209=g465*g211;
    g374=g471*g2hzy;
    g178=g374*g239;
    g310=g486*g476;
    g179=g310*g239;
    g218=g471*g237;
    g180=g486*g218;
    g214=g221*sw;
    g366=g491*sw;
    g281=g366*g2hzy;
    g368=g476*g2hzz;
    g422=g278*g2hzy;
    g184=g422*g2hzz*m23sq;
    g198=g476*g275;
    g199=g368*g276;
    g421=g2hzy*m13sq;
    g429=g278*g2hzz;
    g380=g266*g2hzy;
    g224=g479*g269;
    g225=g479*g270;
    g367=g476*g1hzz;
    g192=g367*g281;
    g280=g366*g1hzy;
    g196=g368*g280;
    g345=m23sq*g1hzy;
    g357=g491*g2hzz;
    g248=g357*g345;
    g197=g479*g248;
    g200=g222*sw;
    g354=m13sq*g1hzy;
    g363=g483*g1hzy;
    g304=g479*g471;
    g205=g304*g238;
    g206=g367*g280;
    g456=g1hzz*m23sq;
    g207=g456*g278;
    g325=g483*g212;
    g208=g325*m23sq;
    g342=g484*sw;
    g229=g479*g268;
    g213=g229*g1hzz;
    g394=g465*g2hzy;
    g215=g394*g239;
    g216=g430*g239;
    g267=g486*g308;
    g501=m12sq*m12sq;
    g232=g501*g267;
    g217=g500*g232;
    g219=g375*g267;
    g220=g486*g237;
    g464=g486*g479;
    g305=g491*g464;
    g274=g305*g1hzz;
    g231=g483*g274;
    g396=g464*g2hzy;
    g272=g465*g308;
    g233=g484*g272;
    g234=g465*g237;
    g235=g496*g267;
    g236=g497*g267;
    g455=g2hzz*m13sq;
    g242=g455*g280;
    g245=sw*m12sq;
    g243=g357*g245;
    g288=g497*g2hzz;
    g246=g366*g288;
    g356=sw*m13sq;
    g346=g356*g1hzz;
    g247=g491*g346;
    g444=g2hzy*m23sq;
    g249=g444*g308;
    g284=g308*m13sq;
    g250=g471*g284;
    g262=g345*g308;
    g251=g471*g262;
    g252=g422*g1hzz;
    g423=g278*g1hzy;
    g253=g423*g1hzz;
    g283=g305*g2hzz;
    g255=g283*g2hzy;
    g466=g476*g471;
    g379=g466*sw;
    g265=g496*g2hzz;
    g258=g274*g2hzy;
    g259=g283*g1hzy;
    g260=g501*sw;
    g261=g274*sw*g1hzy;
    g263=g284*g1hzy;
    g344=m12sq*g1hzy;
    g264=g344*g308;
    g271=g502*g303*mw;
    g282=g501*g1hzy;
    g277=g479*m12sq;
    g306=g465*m23sq;
    g314=g486*m12sq;
    g285=g314*g249;
    g289=g479*g2hzy;
    g290=g486*m23sq;
    g291=g486*m13sq;
    g292=g465*m12sq;
    g355=g472*g212;
    g296=g325*m13sq;
    g298=g479*m13sq;
    g353=g475*g1hzy;
    g299=g353*g207;
    g300=g363*g207;
    g362=g497*m12sq;
    g316=g471*m12sq;
    g317=m23sq*m12sq;
    g318=m13sq*m12sq;
    g401=g479*m23sq;
    g324=m23sq*m13sq;
    g326=g464*g211;
    g327=g479*g211;
    g329=g486*g206;
    g331=g483*g471;
    g335=g471*sw;
    g336=g475*g154;
    g337=g484*g483;
    g339=g483*g144;
    g343=g483*m13sq;
    g349=m23sq*sw;
    g365=g243*g2hzy;
    g482=g486*g464;
    g395=g250*g1hzy;
    g419=g483*m23sq;
    g424=g1hzz*g2hzy;
    g425=g1hzz*g1hzy;
    g427=g170*sw;
    g553=176.0*g471*g193-(48.0*g321*sw)-(128.0*g471*g195);
    g515=g553+32.0*(g180+g234);
    g635=88.0*g213;
    g524=110.0*g325*m12sq+3.0*(g484*g264-(g308*g282))-g635;
    g537=32.0*g476*g177-(44.0*g476*g176);
    g601=g475*g171-(1.375*g483*g171);
    g543=64.0*g601;
    g551=32.0*g484*g209+12.0*g342*g212;
    g514=2.0*g551+3.5*g543+5.0*g537+g524+g515+18.0*g471*g264-(88.0*g339);
    g519=g551+2.0*g537;
    g525=2.0*g553-(6.0*g219)+48.0*g234;
    g624=32.0*g158;
    g516=g624+g525+3.0*g519+96.0*g180-(32.0*g215);
    g627=18.0*g262;
    g560=-g627-(18.0*g263);
    g517=g560-(96.0*g218);
    g631=96.0*g368*g281;
    g518=352.0*g198*g2hzy-g631-(256.0*g199*g2hzy);
    g569=64.0*g195-(88.0*g193);
    g523=g569-(80.0*g209);
    g530=128.0*g475*g380-(176.0*g483*g380);
    g520=g530+g523-(24.0*g220)-(48.0*g218)-(8.0*g182);
    g526=48.0*(g429*g354+g197);
    g536=96.0*(g429*g421+g184);
    g556=18.0*(-(g408*g221)-(g409*g221));
    g539=g556+1.5*g526;
    g521=-g539-(3.0*g536)-(24.0*g150)-(72.0*g148)-(48.0*g147);
    g540=64.0*g484*g230-(88.0*g377*g268);
    g603=2.0*g540;
    g638=44.0*g169;
    g522=-g638-g603;
    g535=144.0*g147+96.0*(g484*g321+g400*g222)-(72.0*g150)-(12.0*g472*g471*g221)
     -(132.0*g148);
    g527=g535-(144.0*g197)-(288.0*g184);
    g534=64.0*g465*g230-(88.0*g363*g266);
    g529=g569+g534;
    g548=44.0*g471*g176-(12.0*g471*g214)-(32.0*g471*g177);
    g634=32.0*g209;
    g528=2.0*g548+g529-(32.0*g218)-g634;
    g531=1.33333*g556-(6.0*g153);
    g546=176.0*g378*g269-(128.0*g400*g240);
    g549=352.0*g377*g269-(256.0*g377*g270);
    g532=g549+g546;
    g544=96.0*g192-(120.0*g206);
    g628=32.0*g182;
    g533=1.5*g544+g518-(224.0*g218)+128.0*g178+336.0*g196-g628;
    g636=44.0*g208;
    g538=g636+44.0*g296;
    g545=-(44.0*g231)-(6.0*g232);
    g613=96.0*g179;
    g541=12.0*g233-(16.0*g217)-(480.0*g172)-g613-g545;
    g547=24.0*(g497*g144+g496*g144)-(144.0*g421*g207);
    g550=9.0*(-g236-g235);
    g552=g536-(36.0*g153);
    g554=512.0*g255*m23sq-(16.0*g362*g154)-(320.0*g430*g207);
    g637=96.0*g455*g281;
    g555=g637+48.0*g242;
    g557=-g613-g550;
    g559=176.0*g167-(48.0*g200)-(128.0*g168);
    g562=16.0*g177-(22.0*g176)+6.0*g214;
    g563=24.0*g144+120.0*g171;
    g564=-(48.0*g259)-(96.0*g255);
    g565=g552+4.66667*g539;
    g567=g532-g603;
    g623=64.0*g237;
    g640=132.0*g169;
    g568=96.0*g464*g248-(12.0*g355*m13sq);
    g570=2.66667*g521+768.0*g255;
    g612=12.0*m23sq;
    g572=-g612-(12.0*m13sq);
    g584=176.0*g224-(128.0*g225);
    g605=176.0*g229;
    g575=64.0*(-g317-g318);
    g619=24.0*g223;
    g576=g619-(30.0*g212);
    g620=24.0*g253;
    g621=48.0*g252;
    g580=640.0*g471*g225-(880.0*g471*g224);
    g581=3.0*g548+g520;
    g582=g540-g640;
    g585=64.0*g215-(12.0*g251);
    g639=88.0*g169;
    g586=48.0*g365-g639;
    g587=120.0*g252-g620;
    g610=12.0*g272;
    g617=96.0*g2hzy;
    g607=64.0*g211;
    g608=128.0*g230;
    g594=896.0*g199-(1232.0*g198);
    g595=176.0*g269-(48.0*g281);
    g596=16.0*(g291+g290);
    g598=32.0*g326+12.0*g261;
    g599=2.66667*g500*g157-g157;
    g600=g464*g230+g396*g240-(1.375*g231*g2hzy);
    g602=2.0*g560;
    g604=12.0*g250;
    g606=96.0*g243;
    g609=96.0*g258;
    g611=96.0*g247;
    g614=48.0*g342;
    g615=288.0*g1hzy;
    g616=48.0*g2hzy;
    g618=192.0*g2hzy;
    g622=32.0*g237;
    g625=12.0*g219;
    g626=6.0*g262;
    g629=64.0*g216;
    g630=24.0*g254;
    g632=24.0*g264;
    g633=36.0*g264;
    g641=24.0*g242;
    {
        t0=g562*(g318*g318+g317*g317+4.0*g324*g324+8.0*g471*g466+16.0*(-(g466*
         m13sq)-(g466*m23sq))+2.0*(g408*m13sq+g409*m23sq+g472*g324))+(g548-(3.0*
         g264)+44.0*g325-(12.0*g212*sw)-g634)*(g497*m13sq+g496*m23sq)+(g580-(
         256.0*g205))*(g1hzz*m13sq+g456)+(g619-(12.0*g212))*(g260*m13sq+g260*
         m23sq)+g596*(g182*m12sq+4.5*g206*m12sq)+g594*(g306*g1hzy+g465*g354)+(
         g617+48.0*g1hzy)*(g306*g246-(g278*g265*sw))+(32.0*g217-(12.0*g232)+
         384.0*g172)*(g444+g421)+g584*(2.5*g318*g1hzz+g501*g1hzz+g497*g1hzz+g496
         *g1hzz+5.0*g367)+g575*(8.0*g168*g2hzy-(11.0*g167*g2hzy)+3.0*g200*g2hzy-
         (1.5*g476*g237))+g559*(6.0*g324*g1hzy+4.0*g324*g2hzy)+g535*(2.66667*
         g500*g419-(3.66667*g419));
        t0=t0+g572*(g599+44.0*g476*g193-(g471*g219)+2.66667*(g472*g209+g326))+(
         2.0*(g530+g529)-(32.0*g220)-(128.0*g209))*(g409+g408)+(g562+8.0*g237)*(
         g362*m13sq+g382*m23sq-(8.0*g466*m12sq)+2.0*g501*g324)+(g640-g623-g567)*
         (g401+g298)+(g620+84.0*g171-g621)*(g497*sw+g496*sw)+(2.0*g559-g610)*(
         g497*g1hzy+g496*g1hzy)+(256.0*g324-g575)*(g475*g144-(1.375*g339))+48.0*
         (g223-g212)*(g497*g349+g496*g356)+g531*(2.66667*g500*g337-(3.66667*g337
         ))+g601*(512.0*g324-(5.0*g575))+(32.0*g216+60.0*g206)*(g497*g486+g496*
         g486)+(g607-g608)*(g298*m13sq+g401*m23sq)+(-(64.0*m12sq)-(128.0*m13sq))
         *(1.375*g300-g299)+(g605+2.0*g584)*(g288+g265)+g600*(256.0*m12sq-(
         21.3333*g572))+sw*(g568+g547);
        t0=t0+g245*(g609+g521)+g250*(-(48.0*g394)-(36.0*g294*m12sq))+g379*g266*(
         g618-g615)+g260*(24.0*g171-(48.0*g423*g2hzz)-g621)+g277*(g639-g623-g532
         +g607*m13sq-(g608*m12sq))+g484*g306*(24.0*g243*g1hzy-g555)+g282*(g604+
         g559-g610)+g471*g289*(576.0*g243+240.0*g247)+g304*g1hzy*(144.0*g243-
         g611)+g291*(g627*m12sq-g624)+g292*(g544-(2.0*g518)+g517+12.0*g249+64.0*
         g178)+g464*g1hzy*(g606+704.0*g201+12.0*(-g308-g247))+g304*(2.0*g549+4.0
         *g546+6.0*g522)+g533*g306+g471*g465*(g633-g630-(48.0*g249))+g310*(g633-
         g602-(48.0*g254))+g314*(g616*g250-g624-(36.0*g251))+g315*(g549+3.0*g546
         -(10.0*g540)-(572.0*g169))+g316*(g625+176.0*g213+g622*g316)+g516*g317+
         g318*(g516+220.0*g208-g635);
        t0=t0+g324*(5.0*g551+14.0*g537+2.0*g525+128.0*g180)+g484*g465*(156.0*
         g206-(240.0*g196)-(144.0*g192)-g631)+2.66667*g565*g500*g331+g331*(-(
         17.1111*g556)-(3.66667*g552)-(1232.0*g197))+g335*(g565+192.0*(-g258-
         g259)-(176.0*g335*g335*g154))+g342*(g564+g536+g531+g526-(48.0*g258))+
         g343*(7.33333*g564-(3.66667*g527)+44.0*g317*g154)+g344*(g557-(320.0*
         g172))+g345*(g541+12.0*g236)+g349*(g609+g535-(12.0*g355)+192.0*g255)+
         g354*(g541+12.0*g235+48.0*g207*sw)+g527*g356+g362*(g581-(9.0*g262))+
         g484*g211*(-(64.0*g277)-(96.0*g298))+g482*g2hzz*(2.0*g595+176.0*g268-(
         48.0*g280)-(256.0*g270))+g595*g482*g1hzz+g476*g272*(g617-(108.0*g1hzy))
         +g374*(96.0*g271+24.0*g232)+g375*(32.0*g179+416.0*g172-(12.0*g271));
        t0=t0+g471*g1hzy*(1.33333*g550+2.0*g545-(48.0*g271)-(72.0*g233))+g379*(
         48.0*g154-(4.0*g576))+g476*m12sq*(g602-(352.0*g193)-g628)+g382*(g520-(
         9.0*g263))+g465*m13sq*(g533-(36.0*g262)+12.0*g254)+g501*m13sq*(g528-
         g626)+g483*m12sq*(-(1.375*g570)-(352.0*g259))+g475*m13sq*(2.66667*g527+
         512.0*g255)+g570*g475*m12sq+g472*sw*(12.0*g253+72.0*g171)+2.0*g587*g471
         *g245+g585*g484*m12sq+g395*(36.0*g317-(48.0*g290))+g396*(g611-(128.0*
         g486*g240))+g479*g1hzy*(-(1.28571*g594)-(48.0*g246))+g576*g496*g245+
         g497*g245*(g576-(6.0*g154))+g528*g501*m23sq+g427*g2hzz*(-g618-g615)+
         g427*(72.0*g425-(192.0*g424))+g245*g244*(48.0*g424-(24.0*g425))+g430*(
         256.0*g172+24.0*(g272*m12sq-g233)-(1.33333*g557));
        t0=t0+g346*g244*(g616-(36.0*g1hzy))+g207*g2hzy*(g614+528.0*g343-(120.0*
         g245)+240.0*g335)+g324*g223*(48.0*g245-g614)+g207*g1hzy*(24.0*g245-(
         96.0*g335)-(36.0*g342))+g324*sw*(96.0*g144+192.0*g171)+g324*g245*(-(
         12.0*g154)-(60.0*g212))+g317*m13sq*(2.0*g581-(32.0*g336))+g306*m13sq*(
         g567-(220.0*g169))+g201*g1hzy*(-(528.0*g277)-(1232.0*g298))+g292*m23sq*
         (g637+g582)+g582*g292*m13sq+g178*m12sq*(-(8.0*g596)-(64.0*g314))+g290*
         m13sq*(g629+g628+168.0*g206)+g245*m13sq*(g563-g587)+g563*g245*m23sq+
         g2hzz*m12sq*(2.4*g580+384.0*g205+g605*m12sq)+g1hzz*m12sq*(g580-(128.0*
         g205))+g464*(g622+2.0*g555+g532+g522+288.0*g365)+g465*(192.0*g158+84.0*
         (g395+g251)+24.0*g260*g248);
        t0=t0+g466*(g632-(12.0*g534)+64.0*g220+128.0*g336-(440.0*g325)+4.0*(g530
         -g523)-(24.0*g267*g1hzy))+g471*(24.0*g599+2.0*g598+48.0*g285+352.0*(
         g300+g213*m13sq)-(512.0*g600))+g472*(g636+3.0*g543+g537+32.0*g327-(44.0
         *g213)+12.0*g329)+g475*(g554+2.66667*g547)+g476*(15.0*g538+4.0*g524+
         288.0*g234+256.0*(g327-g215)-g625)+g479*(g632+g630-g629+g628-(3.0*g518)
         -(1.33333*g517)-(256.0*g178)+96.0*g206-(432.0*g196)-(240.0*g192))+g483*
         (-(3.66667*g568)-(1.375*g554))+g484*(g598-(96.0*g299)+g626*g318-(g604*
         g344)+g641*g292+g606*g289)+g496*(g514+176.0*g296)+g497*(g514+176.0*g208
         )+g317*g237*(8.0*g317+24.0*g497)+g318*g237*(8.0*g318+24.0*g496)+g501*(
         g543+g538+g519+g515+24.0*g329-g585);
        msq2=(t0+g290*g290*(g586+g555)+g586*g291*g291+g314*g314*(g641-g638)-(
         96.0*g289*g246)-(g608*g482)+192.0*g353*g170*g1hzz-(g612*g261)-(24.0*
         g285*m13sq)-(g624*g290))/(cw*cw*cw*6.0*(g465*g245*g245-(g500*g277)));
      };
  };
  double g1168,g905,g1211,g1215,g755,g1169,g1207,g954,g650,g1217,g649,g1194,g1203,g958,g920,g817,g734,g651,g1157,g1142,g953,g846,g654,g1166,g652,g940,g845,g657,g653,g928,
         g1156,g655,g927,g1155,g656,g947,g875,g1216,g1209,g1149,g874,g1222,g659,g873,g660,g1197,g1170,g1147,g872,g871,g713,g714,g715,g716,g717,g668,g669,g670,g671,g672,g898,
	 g1219,g867,g771,g866,g772,g897,g865,g773,g864,g774,g863,g775,g1193,g1196,g896,g723,g1065,g855,g843,g783,g708,g695,g1165,g858,g709,g696,g785,g710,g697,g786,g711,g698,
         g787,g712,g699,g761,g700,g762,g701,g763,g702,g764,g703,g765,g704,g718,g719,g706,g720,g707,g721,g722,g856,g724,g911,g804,g725,g726,g919,g818,g727,g1057,g1201,
	 g885,g728,g952,g1049,g730,g1220,g751,g731,g753,g732,g733,g869,g735,g868,g736, g737,g1024,g825,g738,g861,g917,g1195,g739,g1058,g829,g740,g889,g844,g830,g741,
	 g891,g803,g742,g1210,g890,g743,g955,g1221,g886,g745,g749,g750,g752,g748,g870, g756,g759,g760,g768,g776,g777,g1140,g899,g862,g778,g900,g779,g860,g859,g974,g1101,
	 g782,g1213,g918,g788,g857,g789,g790,g791,g854,g792,g796,g793,g910,g794, g978,g795,g884,g1136,g797,g880,g798,g925,g881,g799,g800,g1218,g1008,g801,g802, g805,g837,g816,
	 g806,g807,g999,g914,g808,g909,g809,g1202,g810,g811,g812,g813, g975,g904,g814,g815,g819,g1000,g887,g820,g826,g827,g828,g1059,g851,g838,g850,g839,g840,g841,g842,g847,
	 g848,g849,g892,g852,g853,g876,g1145,g1206,g1205,g1006, g882,g895,g883,g944,g893,g894,g1055,g903,g907,g915,g908,g1002,g912,g926,g942,g963,g981,g941,g1018,g933,g931,
	 g939,g962,g936,g1019,g1048,g966,g992,g1167,g949, g956,g960,g961,g964,g967,g971,g973,g976,g979,g980,g983,g1004,g1005,g1007,g1028, g1029,g1027,g1025,g1021,g1023,g1039,
	 g1047,g1052,g1056,g1067,g1084,g1087,g1100, g1151,g1249,g1300,g1330,g1288,g1299,g1252,g1259,g1261,g1266,g1283,g1284,g1250, g1278,g1285,g1316,g1251,g1328,g1253,g1367,
	 g1389,g1255,g1254,g1279,g1306,g1256, g1388,g1257,g1258,g1303,g1260,g1273,g1262,g1263,g1383,g1390,g1264,g1308,g1293, g1395,g1265,g1287,g1296,g1309,g1373,g1329,g1267,
	 g1391,g1268,g1269,g1270,g1271, g1305,g1272,g1274,g1275,g1276,g1362,g1277,g1313,g1280,g1281,g1282,g1361,g1286, g1294,g1298,g1331,g1289,g1290,g1324,g1291,g1332,g1292,
	 g1368,g1295,g1325,g1297, g1301,g1302,g1304,g1307,g1310,g1378,g1311,g1312,g1364,g1314,g1317,g1318,g1379, g1319,g1322,g1320,g1375,g1323,g1327,g1333,g1334,g1336,g1337,
	 g1339,g1341,g1370, g1348,g1360,g1363,g1365,g1366,g1369,g1371,g1372,g1374,g1376,g1377,g1380,g1381, g1382,g1384,g1385,g1386,g1387,g1392,g1393,g1394,g1396,g1405,g1158,msq3;
    {
    double t0 = 0;
    g1168=mz*mz;
    g905=g1168*ee;
    g1211=g1hzz*g1hzz;
    g1215=g905*g905;
    g755=g1215*g1211;
    g1169=mQ*mQ;
    g1207=mh*mh;
    g954=g1207*g1169;
    g650=g954*g755;
    g1217=m23sq*m23sq;
    g649=g1217*g650;
    g1194=ee*ee;
    g1203=g1194*ee;
    g958=g1203*mw;
    g920=g958*g1hzz;
    g817=g1168*g920;
    g734=g1169*g817;
    g651=g1207*g734;
    g1157=g1168*g1168;
    g1142=g1168*g1157;
    g953=g1142*m23sq;
    g846=g1194*g953;
    g654=g954*g846;
    g1166=g2hzz*g2hzz;
    g652=g1166*g654;
    g940=g1142*m13sq;
    g845=g1194*g940;
    g657=g954*g845;
    g653=g1166*g657;
    g928=g1169*m23sq;
    g1156=g1207*g1207;
    g655=g1156*g928*g755;
    g927=g1207*m23sq;
    g1155=g1169*g1169;
    g656=g1155*g927*g755;
    g947=g1207*g1hzz;
    g875=g947*sw;
    g1216=sw*sw;
    g1209=g1216*sw;
    g1149=g1209*sw;
    g874=g1194*g1149;
    g1222=g947*g947;
    g659=g1222*g874;
    g873=g1209*g947;
    g660=g1194*g873*g873;
    g1197=g1216*g1149;
    g1170=g1197*sw;
    g1147=g1170*sw;
    g872=g1194*g1147;
    g871=g1216*g872;
    g713=g1216*g755;
    g714=g1149*g755;
    g715=g1197*g755;
    g716=g1147*g755;
    g717=g1216*g716;
    g668=g713*m13sq;
    g669=g714*m13sq;
    g670=g715*m13sq;
    g671=g716*m13sq;
    g672=g717*m13sq;
    g898=sw*ee;
    g1219=g898*g898;
    g867=g1219*g1142;
    g771=g1211*g867;
    g866=g1142*g874;
    g772=g1211*g866;
    g897=g1216*g874;
    g865=g1142*g897;
    g773=g1211*g865;
    g864=g1142*g872;
    g774=g1211*g864;
    g863=g1142*g871;
    g775=g1211*g863;
    g1193=mw*mw;
    g1196=g1203*ee;
    g896=g1196*g1193;
    g723=g1216*g896;
    g1065=g1207*m12sq;
    g855=g1149*g896;
    g843=g855*m12sq;
    g783=g1168*g867;
    g708=g1207*g783;
    g695=g1166*g708;
    g1165=g1168*g1142;
    g858=g1165*g874;
    g709=g1207*g858;
    g696=g1166*g709;
    g785=g1165*g897;
    g710=g1207*g785;
    g697=g1166*g710;
    g786=g1165*g872;
    g711=g1207*g786;
    g698=g1166*g711;
    g787=g1165*g871;
    g712=g1207*g787;
    g699=g1166*g712;
    g761=g1166*g867;
    g700=g1155*g761;
    g762=g1166*g866;
    g701=g1155*g762;
    g763=g1166*g865;
    g702=g1155*g763;
    g764=g1166*g864;
    g703=g1155*g764;
    g765=g1166*g863;
    g704=g1155*g765;
    g718=g1169*g867;
    g719=g1169*g866;
    g706=g1166*g719;
    g720=g1169*g865;
    g707=g1166*g720;
    g721=g1169*g864;
    g722=g1169*g863;
    g856=g1168*g896;
    g724=g1207*g856;
    g911=g958*m12sq;
    g804=g1207*g911*g2hzz;
    g725=g1157*g804;
    g726=g958*g873;
    g919=g1157*g1hzz;
    g818=g958*g919;
    g727=g954*g818;
    g1057=g1hzz*mw;
    g1201=g1219*g898;
    g885=g1201*g1057;
    g728=g1169*g885;
    g952=g1169*g954;
    g1049=g1217*m12sq;
    g730=g1049*g817;
    g1220=g1149*sw;
    g751=g1220*g817;
    g731=g751*m12sq;
    g753=g1170*g817;
    g732=g753*m12sq;
    g733=g734*m23sq;
    g869=g1219*g1166;
    g735=g869*m23sq;
    g868=g1166*g874;
    g736=g868*m23sq;
    g737=g1166*g845*m23sq;
    g1024=g2hzz*g1hzz;
    g825=g1024*g874;
    g738=g1155*g825;
    g861=g1169*ee;
    g917=g1142*g1hzz;
    g1195=g861*g861;
    g739=g1195*g917*g2hzz;
    g1058=g2hzz*mw;
    g829=g1201*g1058;
    g740=g1169*g829;
    g889=g898*g874;
    g844=g889*mw;
    g830=g844*g2hzz;
    g741=g1169*g830;
    g891=g898*g897;
    g803=g1058*g891;
    g742=g1157*g803;
    g1210=g1215*g905;
    g890=g1210*mw;
    g743=g947*g890;
    g955=g1169*g1168;
    g1221=g955*g955;
    g886=g1057*g891;
    g745=g1155*g886;
    g749=g1220*g818;
    g750=g1170*g818;
    g752=g1209*g817;
    g748=g1155*g752;
    g870=g1166*g897;
    g756=g1169*g870;
    g759=g1169*g869;
    g760=g1169*g868;
    g768=g785*m23sq;
    g776=g785*m13sq;
    g777=g1169*g855;
    g1140=g1168*g1165;
    g899=g1194*g1140;
    g862=g1166*g899;
    g778=g1207*g862;
    g900=g1157*g2hzz;
    g779=g1195*g900*g900;
    g860=g900*m23sq;
    g859=g900*m13sq;
    g974=g1hzz*m23sq;
    g1101=g974*g2hzz;
    g782=g1101*g845;
    g1213=m13sq*m13sq;
    g918=g1213*g1hzz;
    g788=g958*g918*sw;
    g857=g1157*g896;
    g789=g1169*g857;
    g790=g1169*g856;
    g791=g1157*g855;
    g854=g1217*g896;
    g792=g1169*g854;
    g796=g1213*g896;
    g793=g1169*g796;
    g910=g1169*mw;
    g794=g910*m12sq;
    g978=m23sq*m12sq;
    g795=g1194*g978;
    g884=g1217*g1hzz;
    g1136=g884*g2hzz;
    g797=g1136*g845;
    g880=g918*g2hzz;
    g798=g880*g846;
    g925=g1142*m12sq;
    g881=g1194*g925;
    g799=g1136*g881;
    g800=g881*g880;
    g1218=m12sq*m12sq;
    g1008=g1218*g1024;
    g801=g1008*g846;
    g802=g1008*g845;
    g805=g911*g900;
    g837=g1218*g958;
    g816=g837*sw;
    g806=g816*g2hzz;
    g807=g900*g837;
    g999=g1hzz*sw;
    g914=g1203*g999;
    g808=g914*g910;
    g909=g1155*g1hzz;
    g809=g958*g909*sw;
    g1202=g1195*g861;
    g810=g1202*g999*mw;
    g811=g890*m23sq;
    g812=g885*m23sq;
    g813=g890*m13sq;
    g975=g1hzz*m13sq;
    g904=g1203*g975;
    g814=g904*mw;
    g815=g818*m12sq;
    g819=g858*m13sq;
    g1000=g1216*g1hzz;
    g887=g1000*g2hzz;
    g820=g899*g887;
    g826=g1024*g897;
    g827=g1024*g872;
    g828=g1024*g871;
    g1059=g844*g1hzz;
    g851=g896*m13sq;
    g838=g1207*g851;
    g850=g896*m23sq;
    g839=g850*m12sq;
    g840=g1155*g851;
    g841=g851*m12sq;
    g842=g850*m13sq;
    g847=g862*m23sq;
    g848=g862*m13sq;
    g849=g862*m12sq;
    g892=g896*m12sq;
    g852=g1207*g892;
    g853=g856*m12sq;
    g876=g1216*m12sq;
    g1145=g1169*g1155;
    g1206=g1217*m23sq;
    g1205=g1213*m13sq;
    g1006=g2hzz*sw;
    g882=g1006*g958;
    g895=g1165*m12sq;
    g883=g920*g895;
    g944=g1209*g814;
    g893=g1157*g944;
    g894=g1218*g1207;
    g1055=g814*sw;
    g903=g914*m23sq;
    g907=g927*sw;
    g915=g1168*m23sq;
    g908=g1218*g915;
    g1002=g1149*g1hzz;
    g912=g1002*g2hzz;
    g926=g1168*m12sq;
    g942=g1220*g1hzz;
    g963=g1169*sw;
    g981=g1149*g963;
    g941=g1216*g981;
    g1018=g734*m13sq;
    g933=g1168*m13sq;
    g931=g933*g728;
    g939=g1169*m13sq;
    g962=g1157*m12sq;
    g936=g1049*g723;
    g1019=g1213*m12sq;
    g1048=g1218*m13sq;
    g966=g1207*g1168;
    g992=g1169*g1142;
    g1167=g1168*g1140;
    g949=g1149*g1142;
    g956=g1216*m23sq;
    g960=g1157*m23sq;
    g961=g1157*m13sq;
    g964=g1209*g815;
    g967=g1168*g809;
    g971=g1142*g804;
    g973=g1169*g1hzz;
    g976=g1207*g782;
    g979=m13sq*m12sq;
    g980=g1169*m12sq;
    g983=g1207*g1147;
    g1004=g1209*g651;
    g1005=g1213*g650;
    g1007=g794*sw;
    g1028=g1209*m12sq;
    g1029=g1220*m12sq;
    g1027=g1170*m12sq;
    g1025=m23sq*m13sq;
    g1021=g1147*g1024;
    g1023=g1025*g650;
    g1039=g1147*g650;
    g1047=g975*g811;
    g1052=g928*g723;
    g1056=g915*g728;
    g1067=g1147*m12sq;
    g1084=g1147*g739;
    g1087=g730*sw;
    g1100=g2hzz*m12sq;
    g1151=g876*g876;
    g1249=1728.0*g849+1152.0*g848+576.0*(g798+g797-g976-(g1194*g859*g859)+g653-(
     g1194*g860*g860)+g652-g778)+288.0*(g802+g801+g800+g799)+72.0*(g1005+g649)-(
     216.0*g656)-(36.0*g655);
    g1300=32.0*g1207*g843-(24.0*g1065*g723);
    g1330=32.0*g1168*g843-(24.0*g926*g723);
    g1288=g1330+g1300;
    g1299=256.0*g1207*g775-(704.0*g1207*g774)+712.0*g1207*g773-(336.0*g1207*g772
     )+72.0*g1207*g771;
    g1252=g1299-g1288+528.0*g1209*g805-(168.0*g1211*g858);
    g1259=2048.0*g1166*g787-(5632.0*g1166*g786);
    g1261=1408.0*g1155*g716-(1424.0*g1155*g715)+672.0*g1155*g714-(144.0*g1155*
     g713)-(512.0*g1155*g717);
    g1266=g1252-(18.0*g790)+36.0*g1004+216.0*g748;
    g1283=256.0*g1169*g750-(448.0*g1169*g749)-(576.0*g1166*g718);
    g1284=264.0*g1142*g885-(448.0*g917*g844);
    g1250=g1284+g1283+g1266-(1.25*g1261)-g1259-(132.0*g964)-(576.0*g707)+1152.0*
     g706;
    g1278=224.0*g749-(128.0*g750);
    g1285=352.0*g774-(356.0*g773)-(36.0*g771)-(128.0*g775);
    g1316=g1285+168.0*g772;
    g1251=2.0*g1316+g1278;
    g1328=128.0*g732-(224.0*g731);
    g1253=352.0*g716*m12sq-(356.0*g715*m12sq)+168.0*g714*m12sq-(36.0*g713*m12sq)
     -g1328-(128.0*g717*m12sq);
    g1367=3.0*g1259;
    g1389=36.0*g724;
    g1255=g1389+g1367-g1299;
    g1254=2.0*g1283-(3.0*g1261)-g1255+36.0*g790-(11392.0*g707)+5376.0*g706+256.0
     *g791+1584.0*g748;
    g1279=128.0*g672-(352.0*g671)+356.0*g670-(168.0*g669)+36.0*g668;
    g1306=128.0*g717*m23sq-(352.0*g716*m23sq)+356.0*g715*m23sq-(168.0*g714*m23sq
     )+36.0*g713*m23sq;
    g1256=4.0*(-g1306-g1279);
    g1388=9.0*g796;
    g1257=g1388+18.0*g842-g1389;
    g1258=6144.0*g1147*g849-(128.0*g1147*g655)-(768.0*g1147*g656)+256.0*(g1147*
     g649+g1147*g1005)+1024.0*(g1147*g799+g1147*g800+g1147*g801+g1147*g802+g1147
     *g1023)+4096.0*(g1147*g847+g1147*g848)+2048.0*(g1147*g652+g1147*g653-(g1147
     *g976)+g1147*g797+g1147*g798-(g1147*g778));
    g1303=128.0*g1217*g717-(352.0*g1217*g716)+356.0*g1217*g715-(168.0*g1217*g714
     )+36.0*g1217*g713;
    g1260=g1261-g1303;
    g1273=32.0*g843-(24.0*g723*m12sq)-g1253;
    g1262=g1316+g1273+132.0*g752*m12sq-(36.0*g1168*g728);
    g1263=-(48.0*g1048*g723)-(72.0*g1019*g723);
    g1383=36.0*g838;
    g1390=72.0*g724;
    g1264=g1390+g1383;
    g1308=128.0*g1222*g871-(352.0*g1222*g872);
    g1293=g1308+356.0*g660-(168.0*g659)+36.0*g1194*g875*g875;
    g1395=96.0*g723;
    g1265=g1293-g1395;
    g1287=g1251+288.0*g761;
    g1296=1024.0*g765-(2816.0*g764);
    g1309=g1296+2848.0*g763;
    g1373=512.0*g742;
    g1329=g1373-(192.0*g777);
    g1267=g1329+g1309+g1287-(1344.0*g762);
    g1391=128.0*g791;
    g1268=g1391+36.0*g857;
    g1269=9.0*(g1205*g896+g1206*g896);
    g1270=36.0*(-g851-g850);
    g1271=3.0*g1285+504.0*g772+2.0*(g1309+g1278);
    g1305=512.0*g1169*g787-(1408.0*g1169*g786)-(672.0*g1169*g858)+144.0*g1169*
     g783;
    g1272=712.0*g768-g1305;
    g1274=512.0*(-(g940*g803)-(g953*g803));
    g1275=128.0*g1170*g730-(224.0*g1220*g730)-(36.0*g1087);
    g1276=9.0*(-g852-g853);
    g1362=g1165*g886-(1.75*g1165*g1059);
    g1277=256.0*g1362;
    g1313=144.0*(-(g1218*g1018)-(g1218*g733))-(216.0*g1165*g814);
    g1280=g1313+72.0*g890*g884+288.0*g1047;
    g1281=1792.0*g741-(1056.0*g740);
    g1282=256.0*g712-(704.0*g711)+712.0*g710-(336.0*g709)+72.0*g708;
    g1361=19.5556*g1140*g827-(19.7778*g1140*g826)+9.33333*g1140*g825-(2.0*g820)-
     (7.11111*g1140*g828);
    g1286=288.0*g1361;
    g1294=2112.0*g721-(768.0*g722);
    g1298=128.0*g787-(352.0*g786)+36.0*g783;
    g1331=-(16.0*g1298)-(5696.0*g785);
    g1289=g1331+2.66667*g1294;
    g1290=576.0*g735-(2688.0*g736);
    g1324=1008.0*g719-(216.0*g718)-(2136.0*g720);
    g1291=g1298-g1294-g1324;
    g1332=-(24.0*g723)-(224.0*g751);
    g1292=g1332+128.0*g753;
    g1368=1024.0*g803;
    g1295=1792.0*g830-(1056.0*g829)-g1368;
    g1325=-(132.0*g726)-(792.0*g728);
    g1297=2.0*g1325-g1265+432.0*g808;
    g1301=288.0*(-(g1025*g805)-g971)+144.0*(-(g1213*g805)-(g1217*g805));
    g1302=-(768.0*g745)-(144.0*g806);
    g1304=128.0*g717-(352.0*g716)+356.0*g715-(168.0*g714)+36.0*g713;
    g1307=4.66667*g1249+1344.0*g1023;
    g1310=108.0*g1155*g839+27.0*g978*g796+9.0*g1193*g795*g795;
    g1378=128.0*g777;
    g1311=g1302-(72.0*g809)-g1378;
    g1312=1248.0*g740-(3584.0*g741);
    g1364=4.0*g1300;
    g1314=432.0*g810-g1364;
    g1317=6720.0*g819-(14240.0*g776);
    g1318=-(576.0*g882)-(4096.0*g803);
    g1379=36.0*g788;
    g1319=512.0*g745-g1379;
    g1322=-(72.0*g743)-(144.0*g725);
    g1320=3.55556*g1322-(256.0*g727);
    g1375=144.0*g952*g817;
    g1323=5632.0*g827-(2048.0*g828);
    g1327=4.0*g1288+g1259;
    g1333=1424.0*(g776+g768);
    g1334=g1373-g1378;
    g1336=36.0*(m13sq+m23sq);
    g1337=1152.0*(-g974-g975);
    g1339=216.0*g730-(288.0*g725);
    g1341=576.0*g782+1152.0*g739;
    g1370=2048.0*g737;
    g1348=144.0*(-g979-g978);
    g1360=-(5.33333*g962*g723)-(7.33333*g962*g726)-(14.6667*g1209*g725);
    g1363=20.0*g1305;
    g1365=3.0*g1290;
    g1366=8.0*g1282;
    g1369=72.0*g1055*m12sq;
    g1371=54.0*m12sq;
    g1372=36.0*g651;
    g1374=17088.0*g768;
    g1376=9152.0*g756;
    g1377=3456.0*g759;
    g1380=72.0*g788;
    g1381=432.0*g809;
    g1382=72.0*g850;
    g1384=144.0*g810;
    g1385=576.0*g739;
    g1386=72.0*g1145*g896;
    g1387=2688.0*g825;
    g1392=120.0*g726;
    g1393=264.0*g726;
    g1394=144.0*g808;
    g1396=-(264.0*g812);
    g1405=cw*cw*cw;
    g1158=g1405*g1405;
    {
        t0=g1310-(2.75*g1258)+4.0*(g1298*g973*g973+g1332*g980*g980)+3.55556*(
         g1270*g949+g1257*g1151)+(g1291+356.0*g785)*(g975*g975+g974*g974)+288.0*
         (-g657-g654)*(3.55556*g942*g942-(9.77778*g1002*g1002)-(4.66667*g1000*
         g1000)+g999*g999-(14.2222*g1216*g1021)+39.1111*g1021+12.6667*g912-g887)
         +2848.0*(-(g1197*g657)-(g1197*g654))*(g1211-(3.69663*g1024))+(g1375-(
         144.0*g727))*(sw*m12sq+6.22222*g1029-(3.55556*g1027))+(g1375-g1322-(
         72.0*g727))*(sw*m13sq+m23sq*sw)+(g1289-(5408.0*g720)+2112.0*g719-(288.0
         *g718))*(g1136+g880)+g1290*(g925*m13sq+g1213*g1142-(g1207*g940))+g1278*
         2.0*(g927*m12sq-(g927*m13sq)-(g1156*m12sq)+g1207*g979+g894);
        t0=t0+(-(432.0*g928)-(72.0*g927))*(9.88889*g670*m12sq-(4.66667*g669*
         m12sq)+g668*m12sq+3.55556*(g732*m13sq+g672*m12sq)-(6.22222*g731*m13sq)-
         (9.77778*g671*m12sq))+528.0*(g961+g960)*(g728*m12sq+6.78788*g741*m12sq-
         (4.0*g740*m12sq))+144.0*(g813+g811)*(2.0*g963*g2hzz+g1006*m12sq+5.33333
         *g1027*g1hzz+5.5*g1028*g1hzz+6.22222*g1029*g2hzz-(3.66667*g1028*g2hzz)-
         (10.6667*g941*g1hzz)+18.6667*g1169*g942)+(2048.0*g975-(8192.0*g973))*(
         g712*g2hzz-(2.75*g711*g2hzz))+(-(1344.0*g942)-(216.0*g999))*(g813*m12sq
         +g811*m12sq)+36.0*(-(g1205*sw)-(g1206*sw))*(g817*m12sq-g734)+g1337*(
         3.55556*g1100*g722-(9.77778*g1100*g721)+9.88889*g1100*g720-(4.66667*
         g1100*g719)+g1100*g718+4.44444*g1100*g787-(12.2222*g1100*g786)+1.25*
         g1100*g783);
        t0=t0+g1336*(g1360+170.667*g1216*g1084-(469.333*g1084)+442.667*g1197*
         g739+14.6667*g1209*g807)+g1320*(g1170*m13sq+g1170*m23sq)+12.0*(g1328+
         g1316)*(g1155*m13sq+g1155*m23sq)+(g1370+3.55556*g1341)*(g1216*g1067-(
         2.75*g1067)+2.78125*g1197*m12sq)+(-(1.75*g1320)-(896.0*g807))*(g1220*
         m13sq+g1220*m23sq)+g1325*(g1213*g926+g1217*g926)+g1294*5.33333*(g1166*
         g978+g1166*g1025)+g1348*(6.22222*g1220*g651+9.77778*g1039-(9.88889*
         g1197*g650)+4.66667*g1149*g650-(7.11111*g1211*g722)+19.5556*g1211*g721-
         (19.7778*g1211*g720)+9.33333*g1211*g719-(3.66667*g1004)+3.55556*(-(
         g1170*g651)-(g1216*g1039))+2.0*(g1155*g723-(g1211*g718)))+g1279*(-(7.0*
         g1217*g1169)-(2.0*g1217*g1207));
        t0=t0+g1304*(4.0*g1207*g1145-(g1205*g1169)-(g1206*g1169))+(-g1370-(
         6144.0*g739))*(g1216*g983-(2.75*g983))+(3.55556*g1339-(1536.0*g743))*(
         1.75*g981-g941)+(g1312+g1297-(5760.0*g738))*(g953+g940)+g1362*(-(1024.0
         *m12sq)-(768.0*m23sq))+(16.0*g1336+576.0*m12sq)*(3.55556*g699-(9.77778*
         g698)+9.88889*g697-(4.66667*g696)+g695-g1361)+m12sq*(g1274+g1269-g1386)
         +m13sq*(3.0*g1275-(72.0*g936)-(1792.0*g942*g811)-(g1374*g1166))+sw*(
         g1301-g1280+288.0*g883)+g1263*m23sq+g700*(48.0*g1336+1152.0*m12sq)+g701
         *(-(53.3333*g1336)-(5376.0*m12sq))+g702*(11392.0*m12sq-(94.2222*g1336))
         +g703*(156.444*g1336-(11264.0*m12sq))+g704*(4096.0*m12sq-(56.8889*g1336
         ));
        t0=t0+g1221*g844*(896.0*g1hzz*m12sq-(1.16667*g1337)-(448.0*g947)-(3584.0
         *g1100))+g789*(-g1336-(144.0*m12sq))+g792*(-g1371-(54.0*m13sq))+g793*(-
         g1371-(54.0*m23sq))+g840*(108.0*m12sq+216.0*m23sq)+g876*(g1341+144.0*
         g650*m23sq)+g1142*g891*g794*(1024.0*g2hzz-(1536.0*g1hzz))+g895*(g1377-
         g1365+g1295+288.0*g882+34176.0*g756-(16128.0*g760))+g1314*g915+g1165*mw
         *(216.0*g903-(72.0*g1203*g875))+g917*(2688.0*g889*g794-(144.0*g816))+
         g925*(g1395+g1293-g1281-(5376.0*g738)-(1584.0*g728))+g926*(288.0*g810-
         g1388)+g928*(g1327+g1264)+g1157*g939*(-g1392-g1265)+g933*(g1314-(18.0*
         g839)+192.0*g931+g1396*g933)+g939*(g1390+g1327-(108.0*g839))+g1168*g966
         *(g1369+256.0*g745+216.0*g809);
        t0=t0+g1168*g992*(g1318-(9600.0*g736)+4032.0*g735)+g1155*g1142*(g1318+
         7168.0*g830-(2496.0*g829))+g1167*g1166*(5632.0*g872-(2048.0*g871))+
         g1218*g1169*(g1270+g1256-(1024.0*g742))+g1169*g955*(g1382-(216.0*g788))
         +8.0*g1300*g955+g956*(g1385+96.0*g956*g841)+g1295*g1218*g1142+g960*(
         g1380+g1369+g1311+g1387*g960)+g961*(g1311+g1396*m12sq+g1387*g961)+g962*
         (144.0*g809+g1387*g962-g1319-(512.0*g777))+g963*(g1339-(288.0*g743)+
         240.0*g963*g963*g818)+g1319*g1218*g1168+g1211*g1169*(2.0*g1282-g1333)+
         g978*(g1254-(18.0*g838))+g979*(g1254+288.0*g1052+432.0*g733*sw-(g1393*
         g915))+g980*(g1383-(6.0*g1303)+2.0*g1255)+g1207*g1197*(-(5696.0*g737)-(
         15360.0*g739))+g1213*g1207*(g1253-(2.0*g1306));
        t0=t0+g1213*g1169*(6.0*g1253-(7.0*g1306))+g992*(6.0*g1308+1920.0*g660+
         1440.0*g726+576.0*(-g659-g723))+g1008*(2.66667*g1324+g1289)+2.0*g1291*
         g1211*g1025+g1218*g1025*(264.0*g752+256.0*g753-(448.0*g751))+g1019*(3.0
         *g1306+g1267+216.0*g734*sw)+g1025*(g1391-g1367+4.0*g1283+2.0*g1266-(3.5
         *g1261)-(12544.0*g707)+7680.0*g706)+g1217*sw*(36.0*g815+108.0*g1018-
         g1372)+g1210*g794*(432.0*g999-(288.0*g1006))+g1166*g979*(5.33333*g1294-
         (1728.0*g783))+g1334*g1048+g1049*(3.0*g1279+g1267)+g1155*g726*(144.0*(-
         g933-g915)-(528.0*g926))+g1157*g928*(g1395-g1392)+g1055*72.0*(g915*g915
         -g908)+g1056*(192.0*g915-(1584.0*g979))+g1149*m12sq*(384.0*g840-(2688.0
         *g782))+g1166*m12sq*(1.2*g1317-g1374);
        t0=t0+g1065*(g1260-g1388)+g1218*m23sq*(g1334+2.0*g1279)+g1217*m13sq*(
         g1271-(2688.0*g762)+576.0*g761)+g1213*m23sq*(3.0*g1328+g1271)+g1155*
         m12sq*(8.0*g1316+2048.0*g742)+g1211*m23sq*(-g1305-g1282)+g1211*m13sq*(
         g1272-g1282)+g1165*m13sq*(g1376-g1365-(9600.0*g760)+4032.0*g759)+g1145*
         g752*(-(12.0*g1336)-(1056.0*m12sq))+g1213*sw*(108.0*g733-g1372)+1.5*
         g1261*g1207*m13sq+g1203*g1007*576.0*(g859+g860)+g1101*m13sq*(10.6667*
         g1294-(22208.0*g720)+9600.0*g719-(1728.0*g718)-(48.0*g1298))+g1101*(
         g1366+g1363+8064.0*g819)+g651*sw*(g1348-(72.0*g1025))+g1024*m12sq*(
         g1366+g1317-(20.0*g1272))+g978*m13sq*2.0*(g1329+g1251)+g708*g2hzz*(
         576.0*g975-(1728.0*g973))+g709*g2hzz*(9600.0*g973-(2688.0*g975));
        t0=t0+g710*g2hzz*(5696.0*g975-(22208.0*g973))+g975*g2hzz*(g1363-g1374)+
         20.0*g1333*g973*g2hzz+g960*m13sq*(g1393+g1265+912.0*g728-g1394)+g650*
         m13sq*(144.0*g876+288.0*g956)+g742*m12sq*2048.0*(-g939-g928)+g809*m13sq
         *432.0*(-g926-g915)+g915*m12sq*(-g1381-(108.0*g788))+5.0*g1331*g909*
         g2hzz+g1140*(2.0*g1290+512.0*g886-(896.0*g1059)+528.0*g885-(3456.0*g756
         )+6912.0*g760-(144.0*g914*mw)-g1377)+g1142*(g1270-(36.0*g892)+768.0*
         g777-(128.0*g843)-g1381-g1380-(2.0*g1302))+g1169*g1145*(4.0*g1304+288.0
         *g752)+g1145*(6.0*g1270+2.0*g1256-(72.0*g856)+9088.0*g763-(768.0*g762)+
         4.0*(g1296-g1287)-(8.0*g1273))+g1149*(3.55556*g1310-g1307+5760.0*g779);
        t0=t0+g1155*(g1367+6.0*g1284+g1268-(2.0*g1264)-(528.0*g964)-(504.0*g893)
         +108.0*(g854+g796)+4.0*(g1276+g1252))+g1156*(4.0*g1330+36.0*g853+264.0*
         g964+72.0*(-g790-(g815*sw)))+g1157*(g1384-g1364+144.0*(-(g1007*g904)-(
         g903*g794))+36.0*(g842-g852)+72.0*(g839+g841-(g907*g814)))+g1165*(128.0
         *g855+36.0*g896+13440.0*g738+792.0*(-g944-g812)+6720.0*g912*g795-(2.0*
         g1312)-g1297)+g1167*(g1387+g1323+2688.0*g868-(576.0*g869)+5696.0*(-g870
         -g826))+g1168*(72.0*g840-(576.0*g820)+g1395*g894-(36.0*g884*g816)+144.0
         *g1145*g726+288.0*g955*g806+g1376*g953)+g1169*(6.0*g1277+144.0*g936-(
         4096.0*g699)+11264.0*g698-(12544.0*g697)+7680.0*g696-(2304.0*g695)+2.0*
         (-g1269-g1263)+4.0*(g1286-g1274)-(72.0*g1360));
        t0=t0+g1170*(3.55556*g1280+512.0*g917*g837)+g1197*(2.11905*g1307+11392.0
         *g847+10176.0*g779)+g1216*m13sq*(g1385+396.0*g1087)+g794*g794*(36.0*
         g1196+128.0*g1201*g898)+g1205*(g1306+g1262)+g1206*(g1279+g1262)+g1207*(
         g1386+g1286+g1277-g1275-(2048.0*g704)+5632.0*g703-(5696.0*g702)+2688.0*
         g701-(576.0*g700)+72.0*(g789+g919*g816)+18.0*(g793+g792)+g1379*g926+
         g1369*g915+g1368*g925+4608.0*g1142*g738)+g1209*1056.0*(g1047+g971-g883)
         +g1221*g955*(2.0*g1323-(10240.0*g826)+3072.0*g825)+g1213*(2.0*g1303+
         g1250-(108.0*g1056))+g978*g752*(132.0*g978+396.0*g1213)+g1216*(g1258+
         g1249-(5184.0*g779)+256.0*g949*g788)+g1217*(g1276+g1250+27.0*g841-(
         264.0*g893)-(108.0*g931)-(216.0*g967));
        msq3=(t0+g1218*(g1257+96.0*g1052-(144.0*g967)+528.0*(g748-g931)+2.0*(
         g1284+g1268)-g1260)+g1220*6.22222*(g1301-g1313)+g1221*(g1265-(504.0*
         g812)-(24.0*g726))+g973*g785*(1424.0*g973+28480.0*g1100)+g979*g979*(
         g1304+g1292+132.0*g752)+g926*g926*(g1281-(192.0*g723)-g1393)+g966*g966*
         (g1394-(144.0*g728))+g1292*g978*g978+g1169*g963*(-(576.0*g805)-(288.0*
         g1155*g817))-(g1384*g966)+72.0*g907*g815-(528.0*g908*g728)+144.0*g1202*
         g1193*g861-(g1382*g952)+36.0*g954*g839)/(g1158*g1149*(48.0*g1140-(96.0*
         g895))+48.0*g1158*g1151*g1142);
      };
  };


  double msq_tot = ( msq1 + msq2 + msq3 ) * (pow(mh - mz,2) - pow(mQ + mQ,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq_tot;
  if ( width < 0 ) return 0;
  return width;
};

double mHZlL( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  double mt =  _par[2];
  // double mQ =  _par[3]; // Massen der FS Fermionen sind gleich
  double ee =  _par[4];
  double sw =  _par[5];
  //double CKM = _par[6];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  //double g3hzz = _par[9];
  //double g1hww = _par[10];
  //double g2hww = _par[11];
  //double g3hww = _par[12];
  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mt + mt, 2 )) + pow( mt + mt, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mt,2), pow(mt,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mt,2) + pow(mt, 2) + pow(mz,2) - m12sq - m23sq;
  double g1913,g1922,g1870,g1915,g1833,g1923,g1828,g1914,g1867,g1829,g1868,g1877,g1830,g1831,g1875,g1907,g1834,g1832,g1916,g1871,g1857,g1849,g1835,g1921,g1843,g1836,g1920,
       g1873,g1846,g1837,g1919,g1856,g1838,g1889,g1839,g1852,g1840,g1880,g1844,g1905,g1841,g1874,g1845,g1842,g1847,g1853,g1850,g1854,g1851,g1855,g1869,g1858,g1872,g1859,
       g1860,g1861,g1862,g1864,g1863,g1865,g1866,g1881,g1882,g1883,g1885,g1888,g1892,g1895,g1899,g1901,g1906,g1912,g1929,g1930,g1931,g1932,g1951,g1933,g1956,g1957,g1958,
       g1934,g1935,g1936,g1952,g1937,g1940,g1949,g1938,g1941,g1942,g1943,g1944,g1945,g1946,g1947,g1948,g1950,g1953,g1954,g1955,g1959,g1960,msq1;
    {
    double t0 = 0;
    g1913=mt*mt;
    g1922=ee*ee;
    g1870=g1922*g1913;
    g1915=mh*mh;
    g1833=g1915*g1870;
    g1923=g2hzy*g2hzy;
    g1828=g1923*g1833;
    g1914=mz*mz;
    g1867=g1914*g1870;
    g1829=g1867*m23sq;
    g1868=g1922*m13sq;
    g1877=g1915*g1914;
    g1830=g1877*g1868;
    g1831=g1867*m12sq;
    g1875=g1922*g1914;
    g1907=g1913*g1913;
    g1834=g1907*g1875;
    g1832=g1923*g1834;
    g1916=g1hzy*g1hzy;
    g1871=g1922*g1916;
    g1857=g1915*g1871;
    g1849=g1915*g1857;
    g1835=g1914*g1849;
    g1921=m23sq*m23sq;
    g1843=g1921*g1875;
    g1836=g1916*g1843;
    g1920=m13sq*m13sq;
    g1873=g1920*g1914;
    g1846=g1922*g1873;
    g1837=g1916*g1846;
    g1919=m12sq*m12sq;
    g1856=g1919*g1871;
    g1838=g1914*g1856;
    g1889=g2hzy*g1hzy;
    g1839=g1889*g1875;
    g1852=g1871*m23sq;
    g1840=g1852*m12sq;
    g1880=g1923*m23sq;
    g1844=g1922*g1880;
    g1905=g1914*g1914;
    g1841=g1905*g1844;
    g1874=g1914*g1875;
    g1845=g1923*g1874;
    g1842=g1845*m13sq;
    g1847=g1905*g1852;
    g1853=g1905*g1871;
    g1850=g1853*m13sq;
    g1854=g1921*g1871;
    g1851=g1854*m13sq;
    g1855=g1920*g1871;
    g1869=g1907*g1870;
    g1858=g1914*g1869;
    g1872=g1914*g1874;
    g1859=g1923*g1872;
    g1860=g1916*g1870;
    g1861=g1854*m23sq;
    g1862=g1855*m13sq;
    g1864=g1889*g1874;
    g1863=g1864*m23sq;
    g1865=g1889*g1872;
    g1866=g1916*g1868;
    g1881=g1921*g1839;
    g1882=g1916*g1834;
    g1883=g1916*g1833;
    g1885=g1913*g1830;
    g1888=g1889*g1834;
    g1892=g1864*m13sq;
    g1895=g1852*m13sq;
    g1899=g1839*m23sq;
    g1901=g1830*m23sq;
    g1906=g1913*g1907;
    g1912=g1920*g1852;
    g1929=12.0*(-g1850-g1847);
    g1930=16.0*(g1892+g1863);
    g1931=16.0*(g1842+g1841);
    g1932=8.0*(g1837+g1836)-(16.0*g1865);
    g1951=4.0*g1849;
    g1933=-g1951-(4.0*g1856)-(12.0*g1840);
    g1956=8.0*g1853;
    g1957=16.0*g1864;
    g1958=16.0*g1845;
    g1934=g1956+8.0*g1883-g1958-g1957;
    g1935=g1855+g1854;
    g1936=g1958-g1935;
    g1952=4.0*g1852;
    g1937=-g1952-(4.0*g1866);
    g1940=4.0*m13sq;
    g1949=4.0*m23sq;
    g1938=g1949+g1940;
    g1941=48.0*m13sq;
    g1942=8.0*g1830;
    g1943=16.0*g1831;
    g1944=32.0*g1829;
    g1945=4.0*m12sq;
    g1946=7.0*m12sq;
    g1947=32.0*m12sq;
    g1948=48.0*m12sq;
    g1950=16.0*m23sq;
    g1953=4.0*g1849*m23sq;
    g1954=8.0*g1840;
    g1955=8.0*g1899;
    g1959=16.0*g1914*g1872;
    g1960=16.0*g1844;
    {
        t0=g1938*(28.0*g1888-g1835-g1838)+m12sq*(g1862+3.0*g1851+8.0*g1850-(24.0
         *g1892)-(48.0*g1842)+g1949*g1883)+m13sq*(g1953+4.0*g1912+16.0*(g1881+
         g1847))+g1832*(g1947-(4.0*g1938))+g1836*(-g1946-(16.0*m13sq))+g1837*(-
         g1950-g1946)+g1841*(-g1948-g1941)+g1907*g1857*(-g1945-(6.0*g1938))+
         g1859*(g1948+32.0*m13sq)+g1861*(g1940+m12sq)+g1863*(-g1941-(24.0*m12sq)
         )+g1865*(g1947+8.0*g1938)+g1920*g1913*(-(32.0*g1839)-(28.0*g1852))+
         g1919*g1913*(-g1952-(16.0*g1839))+g1882*(-(19.0*g1938)-(28.0*m12sq))+
         g1916*g1915*(-g1943-(52.0*g1829))+g1914*m13sq*(16.0*g1828-(14.0*g1840)+
         g1960*m12sq)+g1915*m12sq*(g1955+g1936-g1956)+g1889*(48.0*g1885+g1942*
         m12sq-(96.0*g1829*m13sq)-g1959-(16.0*g1901));
        t0=t0+g1915*g1889*(48.0*g1829-g1943)+g1916*m12sq*(g1942-(8.0*g1869)+28.0
         *g1829)+g1913*m12sq*(6*g1936-(16.0*g1853)+48.0*g1864)+g1933*g1913*m13sq
         +g1923*m12sq*(8.0*(g1846+g1843)-g1944)+g1923*m13sq*(16.0*g1843-(32.0*
         g1831)-g1944)+g1916*m13sq*(28.0*g1831+72.0*g1829)+g1883*m13sq*(g1945+
         32.0*m23sq)+g1905*(g1954+g1951-(32.0*g1828)+24.0*g1883-(96.0*g1889*
         g1833))+g1906*(8.0*g1937-(96.0*g1839)+16.0*g1857)+g1907*(20*g1935-g1933
         +56.0*g1895+32.0*g1853-(144.0*g1864)+48.0*g1845+12.0*g1866*m12sq)+g1914
         *g1905*(g1937+4.0*g1857+8.0*g1860)+g1913*(4.0*g1932+g1931+7.0*g1930+
         2.66667*g1929+24.0*g1835-(32.0*g1881)+8.0*g1838-(28.0*g1851)+16.0*g1906
         *g1871-g1953);
        msq1=(t0+g1914*(32.0*g1841+4.0*(-g1862-g1861)+g1950*g1828)+g1915*(g1932+
         g1931+g1930+g1929+4.0*g1838+68.0*g1882-(80.0*g1888)+16.0*(-g1832-g1859)
         +8.0*(-g1912-g1851)-(2.0*g1840*m13sq))+g1916*(20.0*g1901-(52.0*g1885)+
         56.0*g1858)+g1919*(g1955+g1935+2.0*g1895+8.0*g1839*m13sq-g1957)+g1920*(
         g1934+3.0*g1840+8.0*g1854+16.0*g1899-(g1940*g1860))+g1921*(g1934-(g1949
         *g1860))+g1923*(32.0*g1858-g1959)-(16.0*g1880*g1830)+g1960*g1873+g1954*
         g1877)/(2.0*g1919*g1914);
      };
  };
  float g2310,g2113,g2309,g2039,g2297,g2308,g2140,g1965,g2087,g2173,g1981,g2287,g2126,g2315,g2084,g2040,g2108,g2028,g1968,g2202,g1997,g1969,g2288,g2131,g1970,g2146,g2311,
	g2115,g2312,g2216,g2209,g1974,g2314,g2302,g1977,g2291,g1978,g2059,g2101,g2128,g2112,g1979,g2109,g2038,g1980,g2098,g2265,g2041,g2099,g2095,g2042,g2286,g2058,g2057,
	g2094,g2086,g2079,g2102,g2022,g2023,g2266,g2027,g2085,g2080,g1994,g2170,g1995,g1996,g2196,g1998,g2056,g2052,g1999,g2138,g2000,g2054,g2001,g2015,g2002,g2106,g2005,
	g2006,g2156,g2007,g2008,g2009,g2010,g2012,g2212,g2013,g2014,g2127,g2105,g2172,g2016,g2129,g2083,g2104,g2018,g2107,g2203,g2021,g2082,g2024,g2025,g2026,g2072,g2029,
	g2081,g2160,g2136,g2130,g2031,g2069,g2070,g2034,g2036,g2037,g2279,g2050,g2043,g2204,g2267,g2045,g2046,g2048,g2268,g2049,g2051,g2103,g2313,g2053,g2089,g2078,g2055,
	g2076,g2060,g2061,g2100,g2264,g2062,g2207,g2243,g2093,g2123,g2213,g2092,g2205,g2096,g2091,g2071,g2068,g2073,g2077,g2088,g2125,g2111,g2149,g2114,g2116,g2124,g2182,
	g2195,g2194,g2122,g2154,g2295,g2155,g2139,g2141,g2142,g2145,g2152,g2281,g2159,g2161,g2163,g2166,g2169,g2174,g2175,g2178,g2177,g2253,g2179,g2180,g2296,g2193,g2293,
	g2206,g2211,g2214,g2229,g2304,g2303,g2242,g2246,g2316,g2447,g2357,g2365,g2331,g2363,g2444,g2352,g2431,g2433,g2369,g2432,g2339,g2361,g2353,g2417,g2332,g2367,g2337,
	g2355,g2439,g2333,g2334,g2437,g2335,g2336,g2338,g2347,g2366,g2371,g2412,g2340,g2341,g2342,g2351,g2446,g2343,g2409,g2344,g2404,g2345,g2346,g2418,g2348,g2445,g2349,
	g2350,g2354,g2427,g2356,g2360,g2423,g2358,g2410,g2359,g2382,g2364,g2429,g2436,g2368,g2370,g2373,g2372,g2375,g2419,g2420,g2376,g2381,g2416,g2377,g2379,g2380,g2383,
	g2393,g2424,g2384,g2422,g2386,g2388,g2443,g2387,g2389,g2391,g2396,g2394,g2430,g2395,g2399,g2402,g2403,g2408,g2411,g2413,g2414,g2415,g2421,g2425,g2426,g2428,g2434,
	g2435,g2438,g2440,g2441,g2442,g2448,g2449,g2450,msq2;
    {
    double t0 = 0;
    g2310=ee*ee;
    g2113=g2310*g1hzy;
    g2309=mz*mz;
    g2039=g2309*g2113*g1hzz;
    g2297=mh*mh;
    g2308=mt*mt;
    g2140=g2308*g2297;
    g1965=g2140*g2039;
    g2087=g2310*g2308;
    g2173=g2297*g2hzz;
    g1981=g2173*g2087*g2hzy;
    g2287=g2309*g2309;
    g2126=g2309*ee;
    g2315=g2126*g2126;
    g2084=g2315*g1hzz;
    g2040=g2084*g2hzy;
    g2108=g2315*g2hzz;
    g2028=g2108*g1hzy;
    g1968=g2140*g2028;
    g2202=g2297*g1hzy;
    g1997=g2202*g2084;
    g1969=g2308*g1997;
    g2288=g2308*g2308;
    g2131=g2297*g2288;
    g1970=g2131*g2039;
    g2146=g2297*g2140;
    g2311=m23sq*m23sq;
    g2115=g2311*m13sq;
    g2312=m13sq*m13sq;
    g2216=g2312*m23sq;
    g2209=g2311*m12sq;
    g1974=g2209*g2039;
    g2314=sw*sw;
    g2302=g2314*sw;
    g1977=g2302*g2039;
    g2291=g2314*g2302;
    g1978=g2291*g2039;
    g2059=g2309*m12sq;
    g2101=g2308*g2hzy;
    g2128=g2310*mw*ee;
    g2112=g2128*g2059;
    g1979=g2112*g2101;
    g2109=g2128*g1hzy;
    g2038=g2309*g2109;
    g1980=g2140*g2038;
    g2098=g2310*g2302;
    g2265=g2hzz*g2hzy;
    g2041=g2265*g2098;
    g2099=g2310*g2291;
    g2095=g2099*g2hzz;
    g2042=g2095*g2hzy;
    g2286=g2309*g2287;
    g2058=g2286*g2098;
    g2057=g2286*g2099;
    g2094=g2098*g1hzz;
    g2086=g2094*g2hzy;
    g2079=g2099*g1hzz;
    g2102=g2288*g2hzy;
    g2022=g2302*g2040;
    g2023=g2291*g2040;
    g2266=g2hzz*g1hzy;
    g2027=g2266*g2098;
    g2085=g2095*g1hzy;
    g2080=g2094*g1hzy;
    g1994=g2308*g2080;
    g2170=g2286*g1hzz;
    g1995=g2170*g2087;
    g1996=g2288*g2080;
    g2196=g2287*g1hzy;
    g1998=g2196*g2079;
    g2056=g2314*g2128;
    g2052=g2056*g2hzy;
    g1999=g2309*g2052;
    g2138=g2308*g2287;
    g2000=g2138*g2056;
    g2054=g2056*g1hzy;
    g2001=g2288*g2054;
    g2015=g2308*g2054;
    g2002=g2309*g2015;
    g2106=g2hzy*m13sq;
    g2005=g2108*g2106;
    g2006=g2086*m23sq;
    g2156=m23sq*m13sq;
    g2007=g2156*g2040;
    g2008=g2297*g2027;
    g2009=g2028*m23sq;
    g2010=g2297*g2095;
    g2012=g2039*sw;
    g2212=g2054*m23sq;
    g2013=g2297*g2212;
    g2014=g2297*g2112;
    g2127=g2310*sw;
    g2105=g2127*g2hzz;
    g2172=g2287*g2hzy;
    g2016=g2172*g2105;
    g2129=g2286*g2hzy;
    g2083=g2310*g2129;
    g2104=g2310*m12sq;
    g2018=g2172*g2104*g2hzz;
    g2107=g2127*g1hzz;
    g2203=g2297*g1hzz;
    g2021=g2040*sw;
    g2082=g2286*g2105;
    g2024=g2308*g2082;
    g2025=g2288*g2105;
    g2026=g2028*sw;
    g2072=g2107*g1hzy;
    g2029=g2287*g2072;
    g2081=g2113*m23sq;
    g2160=g2309*g2297;
    g2136=g2309*g2160;
    g2130=g2309*g2136;
    g2031=g2287*g2080;
    g2069=g2113*m13sq;
    g2070=g2104*g1hzy;
    g2034=g2287*g2052;
    g2036=g2314*g2038;
    g2037=g2054*m12sq;
    g2279=g2309*g2286;
    g2050=g2279*g2094;
    g2043=g2050*g2hzy;
    g2204=g2279*g2079;
    g2267=g1hzz*g2hzy;
    g2045=g2267*g2058;
    g2046=g2267*g2057;
    g2048=g2204*g1hzy;
    g2268=g1hzz*g1hzy;
    g2049=g2268*g2057;
    g2051=g2268*g2058;
    g2103=g2128*g2hzy;
    g2313=m12sq*m12sq;
    g2053=g2313*g2103;
    g2089=g2287*g2128;
    g2078=g2089*g1hzy;
    g2055=g2308*g2078;
    g2076=g2109*m23sq;
    g2060=g2076*m12sq;
    g2061=g2109*m13sq;
    g2100=g2279*g2127;
    g2264=g2100*g2hzy;
    g2062=g2264*g2hzz;
    g2207=g2287*m23sq;
    g2243=g2309*g2207;
    g2093=g2243*m23sq;
    g2123=g2287*m13sq;
    g2213=g2309*g2123;
    g2092=g2213*m13sq;
    g2205=g2287*m12sq;
    g2096=g2309*g2205;
    g2091=g2096*m12sq;
    g2071=g2100*g1hzy;
    g2068=g2081*g2hzz;
    g2073=g2103*m23sq;
    g2077=g2109*m12sq;
    g2088=g2315*g2126*mw;
    g2125=g2291*g2279;
    g2111=g2308*m12sq;
    g2149=g2291*g2028;
    g2114=g2149*m13sq;
    g2116=g2196*g2025;
    g2124=g2312*m12sq;
    g2182=g2297*m13sq;
    g2195=g2297*m12sq;
    g2194=g1995*g1hzy;
    g2122=g2291*g2194;
    g2154=g2308*m23sq;
    g2295=g2297*m23sq;
    g2155=g2308*m13sq;
    g2139=g2286*g2072;
    g2141=m23sq*m12sq;
    g2142=m13sq*m12sq;
    g2145=g2279*g2041;
    g2152=g2312*g2018;
    g2281=g2308*g2288;
    g2159=g2309*m13sq;
    g2161=g2291*g1997;
    g2163=g2309*m23sq;
    g2166=g2308*g2302;
    g2169=m23sq*sw;
    g2174=g1hzz*sw;
    g2175=sw*m13sq;
    g2178=m13sq*g1hzy;
    g2177=m23sq*g1hzy;
    g2253=g1995*g2hzy;
    g2179=g2253*sw;
    g2180=g2194*sw;
    g2296=g2297*g2297;
    g2193=g2141*g1999;
    g2293=g2309*g2279;
    g2206=g2071*g1hzz;
    g2211=g2027*m13sq;
    g2214=g2042*m13sq;
    g2229=g2027*m23sq;
    g2304=g2311*m23sq;
    g2303=g2312*m13sq;
    g2242=g2009*sw;
    g2246=g1997*sw;
    g2316=g2059*g2059;
    g2447=16.0*g2287*g2054;
    g2357=g2447-(64.0*g2266*g2057);
    g2365=80.0*g2308*g2022-(64.0*g2308*g2023);
    g2331=g2365+g2357+16.0*g2002-(64.0*g2046)+80.0*g2045;
    g2363=16.0*g1998+4.0*g2029;
    g2444=20.0*g2031;
    g2352=g2444-g2363;
    g2431=32.0*g2023;
    g2433=8.0*g2021;
    g2369=g2433+g2431;
    g2432=40.0*g2022;
    g2339=g2369+2.5*g2352-g2432;
    g2361=12.0*g2036-(3.0*g2038);
    g2353=-g2361-(24.0*g2015);
    g2417=16.0*g1999;
    g2332=g2417+g2353+g2339+16.0*g2016;
    g2367=-g2433-(2.0*g2038);
    g2337=g2367+g2363-g2417;
    g2355=20.0*g2308*g1977-(4.0*g2308*g2012)-(16.0*g2308*g1978);
    g2439=16.0*g2015;
    g2333=g2444-g2439+g2431+2.0*g2355-g2337-(8.0*g2036);
    g2334=4.0*g2037-g2077;
    g2437=4.0*g2061;
    g2335=g2437+4.0*g2076;
    g2336=128.0*g2102*g2079-(160.0*g2288*g2086)+32.0*g2107*g2102;
    g2338=-(4.0*g2109)-(40.0*g1994);
    g2347=128.0*g2042*m23sq-(160.0*g2041*m23sq);
    g2366=g2347-(80.0*g2006);
    g2371=80.0*g2308*g2027-(64.0*g2308*g2085);
    g2412=2.0*g2371;
    g2340=g2412+g2366;
    g2341=160.0*g2288*g2041-(128.0*g2288*g2042);
    g2342=2.0*g2369-(1.33333*g2361)+4.0*g2352+12.0*g2037;
    g2351=2.0*g2365+1.5*g2357;
    g2446=48.0*g2001;
    g2343=g2446+g2351+48.0*g2002-(16.0*g2034)-(160.0*g2046);
    g2409=g2071*g2hzz+4.0*g2204*g2hzy+g2264*g1hzz;
    g2344=80.0*g2043-(16.0*g2409)-(4.0*g2088*g1hzy);
    g2404=32.0*g2049-(g2313*g2109);
    g2345=g2404-(3.0*g2060);
    g2346=320.0*g2288*g2085-(400.0*g2288*g2027);
    g2418=8.0*g2170*g2070;
    g2348=4.0*g2146*g2039+24.0*g1970+44.0*g1969-(48.0*g1968)+32.0*(-(g2140*g2040
     )-(g2287*g1981))-g2418;
    g2445=16.0*g2001;
    g2349=32.0*g2034-g2445;
    g2350=g2371-(40.0*g2211);
    g2354=g2331-(40.0*g2051)+4.0*(-g2078-(g2103*g2059));
    g2427=80.0*g2008;
    g2356=160.0*g1994-g2427-(7.0*g2371);
    g2360=6.0*(-(g2216*g2039)-(g2115*g2039));
    g2423=16.0*g2203*g2083;
    g2358=g2423-g2360-(8.0*g1970)-(24.0*g1969)-(16.0*g1968);
    g2410=4.0*g2161-(5.0*g2302*g1997);
    g2359=4.0*g2410+32.0*g2291*g2009-(40.0*g2302*g2009);
    g2382=8.0*g2312*g1965+64.0*(-(g2111*g2005)-(g2286*g1981));
    g2364=g2382+8.0*g2195*g2009-(16.0*g2182*g2009);
    g2429=12.0*g2038;
    g2436=64.0*g2016;
    g2368=10.0*g2363-g2436-g2429;
    g2370=16.0*g2049-(20.0*g2051);
    g2373=g2336+200.0*g1996;
    g2372=1.5*g2373+1.4*g2346+g2341;
    g2375=g2418+2.0*g1974;
    g2419=8.0*g1997;
    g2420=32.0*g2005;
    g2376=g2420+g2419+8.0*g1965;
    g2381=96.0*(g2000-g2024);
    g2416=20.0*g2050;
    g2377=g2416-(1.16667*g2381);
    g2379=8.0*g1978-(10.0*g1977)+2.0*g2012;
    g2380=4.0*(g1980*m23sq+g1980*m13sq+g1980*m12sq)-(2.0*g2178*g2014);
    g2383=g2429-(15.0*g2363);
    g2393=g2423-g2348;
    g2424=32.0*g2173*g2083;
    g2384=g2424+g2393;
    g2422=4.0*m23sq;
    g2386=-g2422-(4.0*m13sq);
    g2388=128.0*g2042-(160.0*g2041);
    g2443=80.0*g2027;
    g2387=g2443-g2388;
    g2389=4.0*g2014+64.0*g2000+32.0*g2024;
    g2391=8.0*(g2142+g2141);
    g2396=8.0*(g2127*g2092+g2127*g2093);
    g2394=-(40.0*g2008)-(200.0*g1994);
    g2430=8.0*g2026;
    g2395=g2430-g2432;
    g2399=4.0*g2106*g2089+16.0*g2007*sw;
    g2402=12.0*(g2130*g2069+g2130*g2081);
    g2403=128.0*g2101*g2057-(160.0*g2101*g2058);
    g2408=16.0*g2314*g1979-(4.0*g1979);
    g2411=g2309*g2053+4.0*g2048;
    g2413=6.0*g2371;
    g2414=8.0*g2334;
    g2415=32.0*g2169;
    g2421=96.0*m12sq;
    g2425=48.0*g1hzy;
    g2426=128.0*g2hzy;
    g2428=4.0*g2038;
    g2434=32.0*g2021;
    g2435=32.0*g2016;
    g2438=12.0*g2061;
    g2440=8.0*g2103*m12sq;
    g2441=8.0*g2013;
    g2442=16.0*g2013;
    g2448=120.0*g1994;
    g2449=140.0*g1994;
    g2450=16.0*g2054;
    {
        t0=g2380+4.0*(-(g2380*g2314)-(g2140*g2060))+(g2379+4.0*g2054)*(g2142*
         g2142+g2141*g2141+2.0*g2313*g2156)+g2379*(g2303*m12sq+g2304*m12sq+28.0*
         g2288*g2156-(g2297*g2124)+16.0*(-(g2281*m13sq)-(g2281*m23sq))+8.0*(
         g2308*g2281-(g2281*m12sq)+g2297*g2281)+2.0*(g2140*g2140+g2303*m23sq+
         g2304*m13sq+g2296*g2156-(g2182*g2141))+10.0*(g2155*g2155+g2154*g2154)+
         4.0*(g2111*g2111+g2156*g2156))+(g2355+g2352+g2334)*(g2304+g2303)+g2403*
         (6.0*g2hzz*m12sq+g2hzz*m13sq+g2hzz*m23sq+2.5*(g1hzz*m12sq+g1hzz*m13sq+
         g1hzz*m23sq))+(g2424+g2358)*(sw*m12sq-(5.0*g2302*m12sq))+g2396*(g2268-(
         4.0*g2265))+(-(2.0*g2396)-(16.0*g2127*g2091))*(g2267+g2266)+(g2391+32.0
         *g2156)*(g1965*sw+4.0*g2291*g1965-(5.0*g2302*g1965));
        t0=t0+(4.66667*g2360-(12.0*g1974))*(g2308*sw+4.0*g2314*g2166-(5.0*g2166)
         )+(1.5*g2391+20.0*g2156)*(g2410+g2246)+g2352*(g2297*g2182+g2297*g2295)+
         g2402*(5.0*g2302*g1hzz-g2174-(4.0*g2291*g1hzz))+g2393*4.0*(g2291*m13sq+
         g2291*m23sq)+g2384*(g2175-(5.0*g2302*m13sq))+(1.33333*g2360-(16.0*g2007
         )-g2375)*(g2297*sw+4.0*g2297*g2291)+g2347*2.0*(-(g2287*g2111)-(g2308*
         g2123))+g2391*(12.0*g2288*g1978-(15.0*g2288*g1977)+3.0*g2288*g2012)+
         g2386*(g2411+g2408)+(4.0*g2376+64.0*g2018)*(g2311*g2291-(1.25*g2311*
         g2302))+g2334*(-(g2182*m13sq)-(g2295*m23sq))+(2.0*g2367+7.0*g2363-(32.0
         *g2026)+6.0*g2077)*(g2155*m13sq+g2154*m23sq)+g2387*(g2093+g2092)+g2409*
         (32.0*m12sq-(8.0*g2386));
        t0=t0+m12sq*(g2399-(16.0*g2180)+80.0*g2179)+m13sq*(32.0*g2193+112.0*
         g2116)+g2364*sw+g2043*160.0*(-m13sq-m12sq)+g2055*(12.0*m12sq-(7.0*g2386
         ))+g2059*(g2441-(8.0*g2073*m13sq)-g2446)+g2062*(g2421-(16.0*g2386))+
         g2096*(120.0*g2229-(384.0*g2214)+200.0*g2006+80.0*g1994+3.0*(-g2350-
         g2347)-(24.0*g2068*sw)+480.0*g2041*m13sq+g2426*g2010-(32.0*g2052))+
         g2102*(32.0*g2089-(16.0*g2112))+g2106*(g2389+80.0*g1995*sw)+g2125*g2hzz
         *128.0*(g2070+g2069)+g2115*(2.0*g2395+g2342)-(g2366*g2297*g2123)+g2122*
         (32.0*g2386-(64.0*m12sq))+g2372*g2123+g2124*(3.0*g2355+g2332)+g2130*(
         g2450-g2448+g2413+g2366)+g2131*(4.0*g2077-g2435-g2428)+g2136*(g2341-(
         1.5*g2336)+g2335-(260.0*g1996)-g2440-g2346);
        t0=t0+g2111*m12sq*(2.0*g2337+g2335-(16.0*g2026))+g2138*(-g2440-(16.0*
         g2073)-(128.0*g1999))+g2141*(g2343-(96.0*g2082*g2hzy))+g2142*(g2343+
         200.0*g2045-g2441)+g2288*g2138*(2.0*g2388+480.0*g2027)+g2145*(-(320.0*
         m13sq)-(480.0*m12sq))+6.0*g2363*g2146+g2302*g2297*(5.0*g2375-(6.66667*
         g2360))+g2155*(12.0*g2060-(96.0*g2242))+g2156*(4.0*g2370+2.0*g2351+64.0
         *g2002-(192.0*g2046))+g2159*(g2442-g2446)+g2160*(g2445-(g2448*g2160))+
         g2169*(g2384+80.0*g2253+16.0*g2170*g2069)+g2177*(g2377-(2.0*g2014))+
         g2377*g2178+g2286*g2010*(128.0*g2106+64.0*(g2178+g2177))+g2182*(2.0*
         g2060-g2447)+g2297*g2142*(g2439+g2430-g2417)+g2394*g2287*g2141+g2194*(-
         g2415-(32.0*g2175))+g2349*g2195;
        t0=t0+g2293*g2hzy*(-(64.0*g2079)-(16.0*g2107)-(32.0*g2105))+g2202*(g2381
         -g2416)+g2203*(4.0*g2071-(2.0*g2403))+g2205*(g2373-(2.0*g2341)+4.0*
         g2073-(6.0*g2061))+g2207*(g2372-g2438)+g2288*m12sq*(64.0*g1999-g2438-
         g2368)+g2209*(g2332-(3.0*g2061))+g2313*m23sq*(g2333-(2.0*g2061))+g2213*
         (g2356-(32.0*g2054)-(3.0*g2366))+g2279*m12sq*(384.0*g2042-(160.0*g2027)
         )+g2216*(g2435+g2342)+g2288*m23sq*(g2383-g2435)+g2383*g2288*m13sq+g2313
         *m13sq*(g2395+g2333)+5.0*g2348*g2302*m23sq+g2291*m12sq*(4.0*g2358+64.0*
         g2007)+g2279*g2010*(-g2426-(64.0*g1hzy))+g2288*sw*(112.0*g2009+52.0*
         g1997-g2420)+g2312*sw*(g2419+16.0*g2009)+g2356*g2243+g2376*g2311*sw+
         g2123*m12sq*(g2394+g2366+32.0*g2010*g1hzy);
        t0=t0+g2hzz*sw*(1.33333*g2402-(24.0*g2096*g2069))+g2174*g2083*(-(5.0*
         g2391)-(48.0*g2156))+g2005*sw*(32.0*g2141-(64.0*g2154))+g2154*m13sq*
         16.0*(g2363-g2038)+g2029*m13sq*(40.0*g2111-(20.0*g2141))+g2141*m13sq*(
         6.0*g2355+2.0*g2353-(80.0*g1998)+100.0*g2031)+g2123*m23sq*(g2427+g2413-
         (320.0*g1994))+g2111*m23sq*(g2368-g2434)+g2111*m13sq*(160.0*g1998-g2434
         -g2429)+g2106*g2082*(-g2421-(96.0*m23sq))+g2389*g2hzy*m23sq+g2024*m12sq
         *(g2425+192.0*g2hzy)+g2000*m12sq*(32.0*g2hzy-g2425)+g2279*(g2450+g2427+
         2.0*g2340+g2338+256.0*g2214+160.0*(-g2229-g2211)-(4.0*g2174*g2069))+
         g2281*(g2436-g2414+2.66667*g2361-(4.0*g2339)-(384.0*g2149)-(96.0*g2026)
         );
        t0=t0+g2286*(g2440-g2414-(1.8*g2346)-(3.0*g2341)-(2.5*g2336)+2.0*g2335-(
         32.0*g2212)+64.0*g2015-(160.0*g1996)+240.0*g2156*g2027-(48.0*g2175*
         g2068)-(144.0*g2025*g1hzy))+g2287*(8.0*g2053-(6.0*g2060)+144.0*g2001-(
         g2443*g2115)-g2442)+g2288*(4.0*g2345+32.0*g2139-(36.0*g2078)-(128.0*
         g2034)+208.0*g2161)+g2291*(4.0*g2364+64.0*g2152)+g2293*(g2387-(64.0*
         g2085)+80.0*g2086-(16.0*g2105*g1hzy))+g2296*(g2370+4.0*g2139)+g2297*(
         2.0*g2408+g2344+96.0*g2122-(80.0*g2116)-(64.0*g2179)+160.0*g2145-(32.0*
         g2062)+16.0*(g2048-g2193)+24.0*(g2180-g2055)-(g2437*g2111)-(g2428*g2156
         )-(g2415*g2005))+g2302*(-(5.0*g2382)-(80.0*g2152))+g2308*(4.0*(g2344-
         g2399)+8.0*(g2411+g2206))+g2311*(g2404+g2354+64.0*g2114);
        msq2=(t0+g2312*(2.0*g2359+g2354+g2345)+g2313*(g2359-g2349+g2331+4.0*
         g2246+32.0*g2114+8.0*g2242)+g2316*(g2350+g2338-(40.0*g2006))+g2159*
         g2159*(g2340-g2449)+g2163*g2163*(g2412-g2449)+96.0*g2129*g2025+128.0*
         g2125*g2068+g2443*g2091-(g2422*g2206)+32.0*g2101*g2088-(g2446*g2163)+
         g2442*g2111)/(g2314*cw*cw*cw*4.0*(g2316-g2096));
      };
  };
double g3001,g3011,g2718,g2979,g2965,g2561,g2978,g2980,g2755,g2458,g3009,g2677,g2614,g2994,g2730,g2459,g2960,g2753,g2664,g2462,g3004,g2663,g2465,g2733,g2749,g2748,g3012,
       g2521,g2962,g3000,g2990,g2522,g2972,g2967,g2523,g2966,g2955,g2524,g2983,g2525,g2693,g2767,g2712,g3008,g2530,g2481,g2713,g2692,g2531,g2482,g2714,g2691,g2532,g2483,
       g2715,g2690,g2533,g2484,g2716,g2689,g2534,g2485,g2968,g2711,g2686,g2586,g2992,g2662,g2685,g2587,g2953,g2601,g2511,g2498,g2602,g2512,g2499,g2603,g2513,g2500,g2604,
       g2514,g2688,g2515,g2683,g2508,g2503,g2682,g2509,g2504,g2681,g2510,g2505,g2519,g2520,g2684,g2573,g2516,g2517,g2518,g2594,g2536,g2526,g2593,g2537,g2527,g2592,g2538,
       g2678,g2591,g2539,g2676,g2647,g2542,g2757,g2661,g2648,g2660,g2649,g2787,g2545,g2546,g2547,g2704,g2639,g2754,g2548,g2702,g2609,g2549,g2728,g2550,g2556,g2557,g2680,
       g2553,g2679,g2554,g2703,g2555,g2778,g2756,g2558,g2559,g2560,g2562,g2564,g2565,g2568,g2569,g2570,g2571,g2572,g3010,g2717,g2687,g2578,g2579,g2580,g2581,g2708,g2659,
       g2588,g2707,g2658,g2951,g2595,g2596,g2597,g2598,g2833,g2625,g2600,g2950,g2621,g2606,g2700,g2725,g2632,g2607,g2631,g2724,g2610,g2701,g2818,g2611,g2722,g2612,g2613,
       g2615,g2616,g2675,g2617,g2674,g2618,g2620,g2619,g2999,g2622,g2646,g2623,g2624,g2908,g2723,g2626,g2627,g2638,g2628,g2695,g2751,g2727,g2696,g2850,g2633,g2635,g2636,
       g2637,g2705,g2645,g2641,g2642,g2643,g2726,g2961,g2651,g2848,g2694,g2666,g2655,g2656,g2668,g2657,g2670,g2697,g2698,g2699,g2706,g2752,g2709,g2710,g2719,g2747,g2731,
       g2750,g2845,g2798,g2735,g2746,g2743,g2744,g2745,g2742,g2760,g2762,g2763,g2764,g2765,g2855,g2779,g2861,g2786,g2788,g2789,g2790,g2791,g2792,g2793,g2794,g2797,g2800,
       g2805,g2806,g2868,g2809,g2811,g2813,g2817,g2828,g2825,g2830,g2878,g2880,g2885,g2909,g2907,g3026,g3124,g3185,g3058,g3070,g3096,g3133,g3043,g3188,g3046,g3117,g3190,
       g3056,g3059,g3066,g3187,g3094,g3041,g3087,g3090,g3081,g3183,g3047,g3082,g3042,g3115,g3197,g3044,g3051,g3078,g3057,g3076,g3069,g3085,g3045,g3178,g3048,g3179,g3049,
       g3186,g3050,g3180,g3052,g3053,g3054,g3067,g3055,g3060,g3061,g3073,g3093,g3062,g3063,g3118,g3064,g3091,g3126,g3065,g3098,g3068,g3121,g3071,g3072,g3074,g3075,g3153,
       g3077,g3122,g3079,g3080,g3176,g3083,g3084,g3086,g3088,g3089,g3161,g3092,g3164,g3095,g3097,g3099,g3165,g3100,g3109,g3101,g3106,g3102,g3104,g3123,g3107,g3108,g3157,
       g3174,g3110,g3111,g3112,g3113,g3114,g3194,g3116,g3119,g3120,g3160,g3125,g3127,g3128,g3129,g3131,g3132,g3135,g3136,g3155,g3154,g3150,g3151,g3152,g3156,g3158,g3159,
       g3162,g3163,g3166,g3167,g3168,g3169,g3170,g3171,g3172,g3173,g3175,g3177,g3181,g3182,g3184,g3189,g3191,g3192,g3193,g3195,g3196,g3198,g3199,g3200,g3207,msq3;
    {
    double t0 = 0;
    g3001=g1hzz*g1hzz;
    g3011=ee*ee;
    g2718=g3011*g3001;
    g2979=mz*mz;
    g2965=g2979*g2979;
    g2561=g2965*g2718;
    g2978=mh*mh;
    g2980=mt*mt;
    g2755=g2980*g2978;
    g2458=g2755*g2561;
    g3009=m23sq*m23sq;
    g2677=g2979*mw;
    g2614=g2980*g2677;
    g2994=g3011*ee;
    g2730=g2994*g1hzz;
    g2459=g2978*g2730*g2614;
    g2960=g2979*g2965;
    g2753=g3011*g2960;
    g2664=g2753*m23sq;
    g2462=g2755*g2664;
    g3004=g2hzz*g2hzz;
    g2663=g2753*m13sq;
    g2465=g2755*g2663;
    g2733=g2561*m23sq;
    g2749=g2980*g2755;
    g2748=g2978*g2755;
    g3012=sw*sw;
    g2521=g3012*g2561;
    g2962=g2980*g2980;
    g3000=g3012*sw;
    g2990=g3000*sw;
    g2522=g2990*g2561;
    g2972=g2990*sw;
    g2967=g2972*sw;
    g2523=g2967*g2561;
    g2966=g2967*sw;
    g2955=g2966*sw;
    g2524=g2955*g2561;
    g2983=g3012*g2955;
    g2525=g2983*g2561;
    g2693=sw*ee;
    g2767=g2980*g2979;
    g2712=g2965*g2767;
    g3008=g2693*g2693;
    g2530=g3008*g2712;
    g2481=g2530*m12sq;
    g2713=g3011*g2990;
    g2692=g2960*g2713;
    g2531=g2980*g2692;
    g2482=g2531*m12sq;
    g2714=g3011*g2967;
    g2691=g2960*g2714;
    g2532=g2980*g2691;
    g2483=g2532*m12sq;
    g2715=g3011*g2955;
    g2690=g2960*g2715;
    g2533=g2980*g2690;
    g2484=g2533*m12sq;
    g2716=g3012*g2715;
    g2689=g2960*g2716;
    g2534=g2980*g2689;
    g2485=g2534*m12sq;
    g2968=g2994*ee;
    g2711=g2968*mw*mw;
    g2686=g3012*g2711;
    g2586=g2980*g2686;
    g2992=g3008*g2693;
    g2662=g2992*mw;
    g2685=g2693*g2662*mw;
    g2587=g2980*g2685;
    g2953=g2979*g2960;
    g2601=g3008*g2953;
    g2511=g2980*g2601;
    g2498=g3004*g2511;
    g2602=g2953*g2713;
    g2512=g2980*g2602;
    g2499=g3004*g2512;
    g2603=g2953*g2714;
    g2513=g2980*g2603;
    g2500=g3004*g2513;
    g2604=g2953*g2715;
    g2514=g2980*g2604;
    g2688=g2953*g2716;
    g2515=g2980*g2688;
    g2683=g3008*g3004;
    g2508=g2960*g2683;
    g2503=g2962*g2508;
    g2682=g3004*g2713;
    g2509=g2960*g2682;
    g2504=g2962*g2509;
    g2681=g3004*g2714;
    g2510=g2960*g2681;
    g2505=g2962*g2510;
    g2519=g2962*g2690;
    g2520=g2962*g2689;
    g2684=g2960*g2718;
    g2573=g3012*g2684;
    g2516=g2962*g2573;
    g2517=g2962*g2692;
    g2518=g2962*g2691;
    g2594=g2990*g2684;
    g2536=g2978*g2594;
    g2526=g2978*g2536;
    g2593=g2967*g2684;
    g2537=g2978*g2593;
    g2527=g2978*g2537;
    g2592=g2955*g2684;
    g2538=g2978*g2592;
    g2678=g3001*g2716;
    g2591=g2960*g2678;
    g2539=g2978*g2591;
    g2676=g2979*g2711;
    g2647=g2662*g2hzz;
    g2542=g2980*g2647;
    g2757=g2994*mw;
    g2661=g2972*g2757;
    g2648=g2661*g2hzz;
    g2660=g2966*g2757;
    g2649=g2660*g2hzz;
    g2787=g2980*g1hzz;
    g2545=g2787*g2662;
    g2546=g2787*g2661;
    g2547=g2787*g2660;
    g2704=g2730*mw;
    g2639=g2978*g2704;
    g2754=g2980*g2767;
    g2548=g2754*g2639;
    g2702=g3009*g2730;
    g2609=g2702*g2677;
    g2549=g2609*m12sq;
    g2728=g2979*g1hzz;
    g2550=g2728*g2662;
    g2556=g2728*g2661;
    g2557=g2728*g2660;
    g2680=g3004*g2715;
    g2553=g2680*m23sq;
    g2679=g3004*g2716;
    g2554=g2960*g2679;
    g2703=g2965*g2704;
    g2555=g2962*g2703;
    g2778=g2979*g2978;
    g2756=g2979*g2778;
    g2558=g2756*g2662;
    g2559=g2756*g2661;
    g2560=g2756*g2660;
    g2562=g3004*g2601;
    g2564=g3004*g2603;
    g2565=g2953*g2679;
    g2568=g2978*g2601;
    g2569=g2978*g2602;
    g2570=g2978*g2603;
    g2571=g2978*g2604;
    g2572=g2978*g2688;
    g3010=m13sq*m13sq;
    g2717=g3010*g2960;
    g2687=g3011*g2717;
    g2578=g2990*g2687;
    g2579=g2967*g2687;
    g2580=g2955*g2687;
    g2581=g2983*g2687;
    g2708=g3009*m12sq;
    g2659=g2753*g2708;
    g2588=g2978*g2676;
    g2707=g2711*m12sq;
    g2658=g2978*g2707;
    g2951=g2979*g2953;
    g2595=g2951*g2683;
    g2596=g2951*g2682;
    g2597=g2951*g2681;
    g2598=g2951*g2680;
    g2833=g2hzz*g1hzz;
    g2625=g2833*g2664;
    g2600=g3012*g2625;
    g2950=sw*m12sq;
    g2621=g2950*mw;
    g2606=g2994*g2621*g2hzz;
    g2700=g2757*sw;
    g2725=g2980*g2700;
    g2632=g2725*g1hzz;
    g2607=g2632*m23sq;
    g2631=g2639*sw;
    g2724=g2730*g2621;
    g2610=g2965*g2724;
    g2701=g3010*g2730;
    g2818=g2677*sw;
    g2611=g2818*g2701;
    g2722=g2818*g2730;
    g2612=g2722*m13sq;
    g2613=g2614*sw;
    g2615=g2968*g2677*g2614;
    g2616=g2980*g2676;
    g2675=g3009*g2711;
    g2617=g2980*g2675;
    g2674=g3010*g2711;
    g2618=g2980*g2674;
    g2620=g2677*m12sq;
    g2619=g2620*sw;
    g2999=m12sq*m12sq;
    g2622=g2999*g2711;
    g2646=g3008*g2833;
    g2623=g2646*m13sq;
    g2624=g2646*m12sq;
    g2908=g2hzz*m12sq;
    g2723=g2908*g2757;
    g2626=g2965*g2723;
    g2627=g2960*g2723;
    g2638=g2999*g2700;
    g2628=g2638*g2hzz;
    g2695=g2757*m23sq;
    g2751=g2999*g2hzz;
    g2727=g2965*g2751;
    g2696=g2757*m13sq;
    g2850=g2960*g1hzz;
    g2633=g2850*g2695;
    g2635=g2965*g2702*mw;
    g2636=g2965*g2695*g1hzz;
    g2637=g2703*m12sq;
    g2705=g3011*g2833;
    g2645=g2983*g2705;
    g2641=g2953*g2645;
    g2642=g2990*g2705;
    g2643=g2967*g2705;
    g2726=g2965*g2754;
    g2961=g2980*g2962;
    g2651=g2961*g2703;
    g2848=g2960*mw;
    g2694=g2999*g2960;
    g2666=g2711*m23sq;
    g2655=g2666*m13sq;
    g2656=g2666*m12sq;
    g2668=g2711*m13sq;
    g2657=g2668*m12sq;
    g2670=g2676*m12sq;
    g2697=g2961*g2711;
    g2698=g2675*m23sq;
    g2699=g2674*m13sq;
    g2706=g2960*g2724;
    g2752=g2979*g2767;
    g2709=g2752*g2606;
    g2710=g2953*m12sq;
    g2719=g2730*m23sq;
    g2747=g2965*m23sq;
    g2731=g2747*g2606;
    g2750=g2978*m13sq;
    g2845=g2960*m13sq;
    g2798=g3010*g2550;
    g2735=g2798*m12sq;
    g2746=g2978*m12sq;
    g2743=g3010*g2979;
    g2744=g2979*m23sq;
    g2745=g2979*m13sq;
    g2742=g2745*g2545;
    g2760=g2980*sw;
    g2762=m23sq*sw;
    g2763=g3012*m23sq;
    g2764=sw*m13sq;
    g2765=g3012*m13sq;
    g2855=g2765*sw;
    g2779=g2979*m12sq;
    g2861=g2979*g2747;
    g2786=g2960*g2606;
    g2788=g2978*g1hzz;
    g2789=g1hzz*m23sq;
    g2790=g1hzz*m13sq;
    g2791=g2980*m12sq;
    g2792=m23sq*m12sq;
    g2793=m13sq*m12sq;
    g2794=g2953*g2553;
    g2797=g2980*m23sq;
    g2800=g2979*g2545;
    g2805=g3009*g2980;
    g2806=g3010*g2980;
    g2868=g2978*m23sq;
    g2809=g3012*g1hzz;
    g2811=g2990*g1hzz;
    g2813=g1hzz*sw;
    g2817=g3010*g2458;
    g2828=m23sq*m13sq;
    g2825=g2828*g2550;
    g2830=g2955*g2458;
    g2878=g2573*m13sq;
    g2880=g2573*m12sq;
    g2885=g2555*sw;
    g2909=g2789*m13sq;
    g2907=g2788*g2hzz;
    g3026=g2767*g2767;
    g3124=4.0*g3012*g2658-(8.0*g2990*g2658);
    g3185=32.0*g2953*g2678;
    g3058=g3185+g3124-(4.0*g2968*g2621*g2621);
    g3070=64.0*g2539-(160.0*g2538)+136.0*g2537-(48.0*g2536)+8.0*g2978*g2573;
    g3096=16.0*g2586*m12sq-(32.0*g2587*m12sq);
    g3133=4.0*g2610+g2622;
    g3043=g3133+1.5*g3096+g3070+g3058-(2.0*g2616);
    g3188=512.0*g2565;
    g3046=1280.0*g3004*g2604-g3188;
    g3117=1088.0*g2564+64.0*g2562;
    g3190=384.0*g3004*g2602;
    g3056=g3117-g3190;
    g3059=32.0*g2962*g2525-(80.0*g2962*g2524)+68.0*g2962*g2523-(24.0*g2962*g2522
     )+4.0*g2962*g2521;
    g3066=-g2658-g2670;
    g3187=512.0*g2641;
    g3094=-g3187-g3056;
    g3041=g3094+g3066+5.0*g3059+g3046+g3043;
    g3087=48.0*g2556*m12sq-(32.0*g2557*m12sq);
    g3090=32.0*g2525*m12sq-(80.0*g2524*m12sq)+68.0*g2523*m12sq-(24.0*g2522*m12sq
     )+4.0*g2521*m12sq;
    g3081=g3090-g3087;
    g3183=4.0*g2573;
    g3047=g3081-(4.0*g2730*g2619)-(32.0*g2591)+80.0*g2592-(68.0*g2593)+24.0*
     g2594-g3183;
    g3082=80.0*g2524*m13sq-(68.0*g2523*m13sq)+24.0*g2522*m13sq-(4.0*g2521*m13sq)
     -(32.0*g2525*m13sq);
    g3042=g3047-g3082;
    g3115=4.0*(-g2657-g2656);
    g3197=4.0*g2622;
    g3044=g3197-(3.0*g3115);
    g3051=320.0*g2484-(272.0*g2483)+96.0*g2482-(16.0*g2481)-(128.0*g2485);
    g3078=128.0*g2515-(320.0*g2514);
    g3057=g3078+272.0*g2513-(96.0*g2512)+16.0*g2511;
    g3076=256.0*g2520-(640.0*g2519);
    g3069=g3076+544.0*g2518-(192.0*g2517);
    g3085=64.0*g2572-(160.0*g2571)+136.0*g2570-(48.0*g2569)+8.0*g2568;
    g3045=-g3085-(1.5*g3069)-g3057-(2.0*g3051);
    g3178=4.0*g2588;
    g3048=g3070+12.0*g3059-(3.0*g3056)+4.0*g2616-(1280.0*g2641)-g3178;
    g3179=8.0*g2588;
    g3049=g3179-(12.0*g2655);
    g3186=64.0*g2600;
    g3050=-g3190-g3186;
    g3180=4.0*g2611;
    g3052=-g3180-(4.0*g2609*sw);
    g3053=640.0*g2519*m12sq-(544.0*g2518*m12sq)+192.0*g2517*m12sq+256.0*(-(g2520
     *m12sq)-(g2983*g2465)-(g2983*g2462))+48.0*(g2578*m12sq+g2990*g2659)+136.0*(
     -(g2579*m12sq)-(g2967*g2659))+160.0*(g2580*m12sq+g2955*g2659)+64.0*(-(g2581
     *m12sq)-(g2983*g2659));
    g3054=128.0*g2966*g2626-(192.0*g2972*g2626)+80.0*g3000*g2626;
    g3067=80.0*g3009*g2524-(68.0*g3009*g2523)+24.0*g3009*g2522-(4.0*g3009*g2521)
     -(32.0*g3009*g2525);
    g3055=4.0*g3059-g3067;
    g3060=256.0*g2554-(640.0*g2960*g2680);
    g3061=32.0*g2525*m23sq-(80.0*g2524*m23sq)+68.0*g2523*m23sq-(24.0*g2522*m23sq
     )+4.0*g2521*m23sq;
    g3073=68.0*g2603-(24.0*g2602)+4.0*g2601-(80.0*g2604);
    g3093=480.0*g2533-(192.0*g2534);
    g3062=2.66667*g3093-(16.0*g3073);
    g3063=8.0*g3009*g2458-(4.0*g2748*g2733)-(24.0*g2749*g2733)-(256.0*g2980*
     g2951*g2705)+64.0*(g3004*g2465+g3004*g2462);
    g3118=144.0*g2531-(24.0*g2530)-(408.0*g2532);
    g3064=g3073-g3118-g3093;
    g3091=544.0*g2510-(192.0*g2509)+32.0*g2508;
    g3126=4.0*g3012*g2676-(8.0*g2990*g2676);
    g3065=g3126+g3091;
    g3098=48.0*g2726*g2704+8.0*(g2848*g2701+g2848*g2702);
    g3068=5.0*g3098+40.0*(g2953*g2639-(g2793*g2636))+80.0*(g2704*g2694+g2727*
     g2696+g2727*g2695-(g2627*m23sq));
    g3121=64.0*g2547-(96.0*g2546);
    g3071=2.0*g3121+80.0*g2545;
    g3072=48.0*g2972*g2637-(20.0*g3000*g2637)-(32.0*g2966*g2637);
    g3074=128.0*g2509+64.0*(-g2510-g2508);
    g3075=8.0*(g2668+g2666);
    g3153=8.0*g2951*g2679+17.0*g2597-(6.0*g2596)+g2595;
    g3077=1280.0*g2598-(64.0*g3153);
    g3122=256.0*g2980*g2649-(384.0*g2980*g2648);
    g3079=2.0*g3122+224.0*g2542;
    g3080=6.0*g3063+192.0*g2999*g2625;
    g3176=4.0*g2655;
    g3083=g3176-(2.0*g3115);
    g3084=32.0*g2557-(48.0*g2556)+20.0*g2550;
    g3086=240.0*g2955*g2663-(204.0*g2967*g2663)+72.0*g2990*g2663-(96.0*g2983*
     g2663);
    g3088=32.0*g2525-(80.0*g2524)+68.0*g2523-(24.0*g2522)+4.0*g2521;
    g3089=g2698*m12sq+g2699*m12sq+4.0*(-(g2960*g2666)-(g2960*g2668)-(g2960*g2707
     ))-(8.0*g2697*m12sq);
    g3161=3.0*g3071;
    g3092=48.0*g2632-g3161;
    g3164=16.0*g2548;
    g3095=-g3164-(88.0*g2555);
    g3097=192.0*g2744*g2546-(128.0*g2744*g2547);
    g3099=384.0*g2648-(256.0*g2649);
    g3165=8.0*g2555;
    g3100=g3164-g3165;
    g3109=1280.0*g2955*g2705-(512.0*g2645);
    g3101=1088.0*g2643-(384.0*g2642)-g3109;
    g3106=40.0*(-(g2850*g2696)-g2633);
    g3102=g3106-(20.0*g2549)+160.0*g2627;
    g3104=8.0*g2635-(32.0*g2633)-(12.0*g2549);
    g3123=-(5.0*g3104)-(80.0*g2627);
    g3107=16.0*g2586-(32.0*g2587);
    g3108=g3062-(1056.0*g2532)+320.0*g2531-(32.0*g2530);
    g3157=2.0*g3091;
    g3174=512.0*g2554;
    g3110=-g3174-g3157;
    g3111=-g3122-(160.0*g2542);
    g3112=544.0*(-(g2967*g2465)-(g2967*g2462));
    g3113=96.0*g2581-(240.0*g2580)+204.0*g2579-(72.0*g2578);
    g3114=-g3121-(24.0*g2545);
    g3194=16.0*g2606;
    g3116=g3121-g3194;
    g3119=g3065+g3060;
    g3120=20.0*g2550*m12sq+4.0*(g2730*g2613-g2800);
    g3160=2.0*g3082;
    g3125=-g3160-(8.0*g2612);
    g3127=192.0*g2555*m23sq-(128.0*g2651);
    g3128=4.0*(-m23sq-m13sq);
    g3129=80.0*g2626-(40.0*g2636);
    g3131=80.0*(-g2793-g2792);
    g3132=192.0*g2661-(80.0*g2662)-(128.0*g2660);
    g3135=g3107-(16.0*g2628);
    g3136=g3099-(160.0*g2647);
    g3155=32.0*g3128;
    g3154=12.0*g3128;
    g3150=g3004*g2520-(2.5*g3004*g2519);
    g3151=10.0*g3004*g2514-(4.0*g3004*g2515);
    g3152=1.33333*g2978*g2539-(3.33333*g2978*g2538);
    g3156=4.0*g3126;
    g3158=4.0*g3088;
    g3159=12.0*g3087;
    g3162=3.0*g3046;
    g3163=4.0*g2459;
    g3166=32.0*g2624;
    g3167=128.0*g2624;
    g3168=64.0*g2623;
    g3169=8.0*g2631*m13sq;
    g3170=16.0*g2607;
    g3171=48.0*g2607;
    g3172=32.0*g2628;
    g3173=48.0*g2612;
    g3175=2.0*g2655;
    g3177=1280.0*g2845*g2553;
    g3181=4.0*g3009*g2459;
    g3182=32.0*g3012*g2465;
    g3184=8.0*g2610;
    g3189=1536.0*g2565;
    g3191=640.0*g2811;
    g3192=6.0*m12sq;
    g3193=16.0*m12sq;
    g3195=32.0*g2606;
    g3196=8.0*g2631;
    g3198=8.0*g2622;
    g3199=-(16.0*g2638);
    g3200=-(64.0*g2hzz);
    g3207=cw*cw*cw;
    {
        t0=g3089+5.33333*(g3093*g3004*g2828+g3113*g2789*g2hzz)+2.0*(g3132*g2710*
         g1hzz-(g3096*g2778))+8.0*(g3044*g2990*g2962-(g2756*g2607))+g3084*(g2792
         *g2792+4.0*g2791*g2791+2.0*g2999*g2828)+g3064*(g2790*g2790+2.0*g3001*
         g2828)+192.0*(g2465+g2462)*(g2809*g2809-(13.3333*g2955*g2833))+g3073*(
         g2788*g2788+4.0*g2787*g2787-(80.0*g2962*g2833))+(32.0*g2992*g2693+4.0*
         g2968)*(2.0*g2620*g2620+g2614*g2614)+(-g3101-(64.0*g2646))*(g2979*g2951
         -(2.0*g2951*m23sq)+g2978*g2951)+(2.83333*g3080+136.0*g2817)*(g2967-(
         1.17647*g2955))+g3126*4.0*(g2746*m13sq-(g2978*g2746)+g2746*m12sq)+(2.0*
         g3111+g3071)*(g2747*m12sq+g2965*g2793);
        t0=t0+40.0*(-g2790-g2789)*(g2558*m12sq+25.6*g2485*g2hzz+54.4*g2483*g2hzz
         -(19.2*g2482*g2hzz)+3.2*g2481*g2hzz-(12.8*g2572*g2hzz)+32.0*g2571*g2hzz
         -(27.2*g2570*g2hzz)+9.6*g2569*g2hzz-(38.4*g2520*g2hzz)+96.0*g2519*g2hzz
         -(78.4*g2518*g2hzz)+22.4*g2517*g2hzz+160.0*g2514*g2hzz-(136.0*g2513*
         g2hzz)+48.0*g2512*g2hzz-(8.0*g2511*g2hzz)-(80.0*g2908*g2604)+68.0*g2908
         *g2603-(24.0*g2908*g2602)+4.0*g2908*g2601+4.8*g2953*g2660-(7.2*g2953*
         g2661)+3.0*g2953*g2662+64.0*(-(g2484*g2hzz)-(g2515*g2hzz))+1.6*(g2560*
         m12sq-(g2568*g2hzz))-(2.4*g2559*m12sq))+g3082*(12.0*g2791*m23sq+2.0*
         g2868*m23sq+g2748)+g3131*(g2558*g2hzz-(3.0*g2962*g2550)+1.2*g2990*g2458
         +2.4*(g2972*g2459-(g2559*g2hzz))+1.6*(g2560*g2hzz-(g2966*g2459)));
        t0=t0+(64.0*g2560-(96.0*g2559)+40.0*g2558)*(g2909-(g2999*g1hzz))+24.0*(
         g2696+g2695)*(1.33333*g2712*g2hzz*sw+g2953*g2813)+g3086*(1.33333*g3001*
         g2792+5.33333*(g2907*m23sq-(g2908*g2789)))+g3051*8.0*(g3004*m13sq+g3004
         *m23sq)+(80.0*(-g2548-g2555)-(3.0*g3106)-(20.0*g2635))*(1.6*g2966*m12sq
         -(2.4*g2972*m12sq)+g3000*m12sq)+(1.6*g3123-(192.0*g2555))*(g2966*m13sq-
         (1.5*g2972*m13sq))+g3101*2.0*(g2951*m12sq+g2951*m13sq)+(256.0*g2828-(
         1.6*g3131))*(g3012*g2830-(2.5*g2830)+2.125*g2967*g2458)+g3088*(-(g2806*
         m13sq)-(g2805*m23sq))+g3128*(6.0*g2706-(16.0*g2709)-(4.0*g2786))+g3129*
         (1.6*g3010*g2966-(2.4*g3010*g2972))+g3083*(8.0*g2990*g2965-(4.0*g3012*
         g2965))+g3075*(g2754-g2749);
        t0=t0+g3071*(-(g2999*g2745)-(1.5*g2743*m12sq))+g3153*(192.0*m12sq-g3155)
         +(6.0*g3128+24.0*m12sq)*(g3152+2.83333*g2527-g2526)+(g3154-(32.0*m12sq)
         )*(g2516-(4.0*g2503))+g3150*(128.0*g3128+1024.0*m12sq)+(g3155-(768.0*
         m12sq))*(g3151+g2504)+m12sq*(16.0*g2885-g3177)+m13sq*(3840.0*g2794-(
         32.0*g2731))+sw*(16.0*g2651-g3181-g3098)+g2462*(g3191*g2811-(32.0*g2813
         *g2813))+g2498*(384.0*m12sq-(112.0*g3128))+g2499*(288.0*g3128-(2304.0*
         m12sq))+g2500*(6528.0*m12sq-(368.0*g3128))+g2505*(208.0*g3128+2176.0*
         m12sq)+g2598*(-(2560.0*m13sq)-(3840.0*m12sq))+g2615*(g3128-g3193)+g2617
         *(-g3192-(6.0*m13sq))+g2618*(-g3192-(6.0*m23sq))+g2694*(g3136+32.0*
         g2623);
        t0=t0+g2708*(g3119-(3.0*g3082)-(120.0*g2800)-(8.0*g2573))+g2710*(g3136+
         3840.0*g2553)+g2712*(-g3195-(32.0*g2631))+g2717*(g3166-(1280.0*g2553))+
         g2726*(g3168+g3167+4.0*g3099-(448.0*g2647)+g3200*g2700)+g2965*g2750*(
         g3194+g3114)+g3114*g2978*g2747+g2965*g2746*(g3071-g3111)+g2743*12.0*(
         g2607-(g2545*m23sq))+g2744*(g3169*m12sq-g3096)+g2745*(g3171*m12sq-g3096
         )+g2746*(g3180-g3175+g3056-g3055-g3046-(40.0*g2825))+g2747*(g3135-g3169
         )+g2750*(g3117-g3096-(6.0*g3059)+g3050-g3046)+g2752*(g3172-g3169)+g2755
         *(g3176-g3115-(16.0*g2610))+g2760*(24.0*g2549+12.0*g2609*m13sq)+g2762*(
         g3100-(12.0*g2762*g2657)-(8.0*g2459*m13sq))+g2764*(g3104+g3100)+g2855*
         m13sq*(g3163+g3129)+g3000*g2978*(g3165+g3102);
        t0=t0+g2978*g2972*(-(2.4*g3102)-(96.0*g2555))+g2978*g2966*(1.6*g3102+
         64.0*g2555)+g2861*m23sq*(g3168+g3166)+g2999*g2980*(-(2.0*g3125)-(4.0*
         g3061))+g2791*(6.0*g3067+g3049+24.0*g2611)+g2792*(g3048-(12.0*g2611)-(
         240.0*g2742)-(16.0*g2878)-g3189)+g2793*(g3186+g3162+3.0*g3097+g3048)+
         g3010*g2978*(-g3081-(2.0*g3061))+g2980*g2749*(g3158+16.0*g2550)+g2797*(
         g3179+24.0*g2797*g2550-g3197)+g2965*g2778*(6.0*g3121+224.0*g2545)+g3001
         *g2978*(g3069+g3057+g3051)+g2805*(7.0*g3082+g3074)+g2806*(g3074-(7.0*
         g3061)-(6.0*g3090))+g2990*g2828*(16.0*g2622-(192.0*g2458))+g3009*g2833*
         (g3108-(5.33333*g3086))+g3108*g3010*g2833+g2828*(3.0*g3094+14.0*g3059+
         2.0*(g3054+g3043)-g3189)+g3000*g2459*(8.0*g2828-g3131);
        t0=t0+g2833*(g3182-(3.82353*g3112)-(4.0*g3053))+g2845*(g3092+g3079)-(3.0
         *g3121*g2979*g2708)+g2951*g1hzz*(-g3132-(16.0*g2700))+g3010*sw*(8.0*
         g2636-g3163)+g2855*(g3123+g3095)+g2861*(g3196-g3161+g3079)+g2965*m13sq*
         (g3135-g3170)+g2980*m13sq*(g3179-(4.0*g3133))+g2962*m23sq*(-g3173-g3159
         )+g2962*m12sq*(g3156-g3173)+g2999*m23sq*(g3125+g3107)+g2868*(g3188+
         g3184-g3096+g3056)+g2965*m12sq*(g3169-g3170)+g3107*g2999*m13sq+g3001*
         m23sq*(g3045-g3113)+g2978*g2868*(-g3183-g3082)+g3010*m23sq*(-g3110-(3.0
         *g3087)-(12.0*g2573))+g3045*g3001*m13sq+g3009*m13sq*(g3157+2.0*g3060)+
         g3010*m12sq*(g3119+3.0*g3061)+g3095*g3000*m23sq-(g3159*g2962*m13sq)+
         g2961*g2550*(g3154-(160.0*m12sq))+g2960*m12sq*(-g3161-g3111);
        t0=t0+g2909*g2hzz*(10.6667*g3093-(48.0*g3073)-(4288.0*g2532)+1408.0*
         g2531-(192.0*g2530))+g2907*(768.0*g2517-(4288.0*g2513)+1408.0*g2512-(
         192.0*g2511)-(16.0*g3078)-(6.0*g3076)-(3072.0*g2518))+g2833*m12sq*(8.0*
         g3085+20.0*g3057)+g2462*g2hzz*(32.0*g2809-(576.0*g2811))+g2797*m13sq*(
         1024.0*g2509-(256.0*g2508)-(2304.0*g2510))+g2792*m13sq*(g3174+2.0*g3065
         )+g2459*m12sq*16.0*(-g2764-g2762)+g2763*g2458*(g3193+32.0*m13sq)+g2751*
         g1hzz*(g3062+2.66667*(g3118-g3086))+g2750*m23sq*(g3110+2.0*g3087)+g2747
         *m13sq*(4.0*g3121+144.0*g2545)+g2746*m23sq*(g3160+g3156)+g2951*(g3167+
         128.0*g2623-(2560.0*g2553))+g2953*(g3195-g3092-(2.0*g3079)-(16.0*g2686)
         +4.0*g2711+32.0*(g2685+g2724)+g3200*g2725-g3196);
        t0=t0+g2980*g2961*(g3158+16.0*g2711+32.0*(g2550-g2722))+g2960*(g3172+
         g3171+g3169-(6.0*g3107))+g2961*(g3173-(3.0*g3075)+4.0*g3060+1920.0*
         g2510-(256.0*g2509)-(128.0*g2508)+8.0*(-g3061-g3042-g2676)+48.0*g2818*
         g2719)+g2962*(4*g3066+6.0*g3052-g3050-(2.0*g3049)+g3044+24.0*g2798-(
         2560.0*g2641)+2496.0*g2564-(576.0*g2562)+48.0*(g2825-(g2719*g2619))+
         12.0*(g2674+g2675)+4.0*(g3058+g3054)+g3199*g2728-g3162)+g2965*(g3083+
         4.0*(g3124+g3096-g2658))+g2966*(1.6*g3068-g3127)+g2968*(-(16.0*g2613*
         g2613)-(32.0*g2619*g2619))+g2972*(1.5*g3127-(2.4*g3068))+g2978*g2978*(
         g3185-g3184-(2.0*g3072)+g3059-(8.0*g2616)+4.0*(g2670+g2880-g2878));
        t0=t0+g2978*(g3177-(512.0*g3150)+g3077-(20.0*g2735)+24.0*g2885+16.0*
         g2731-(1280.0*g2794)-(1088.0*g2505)+384.0*g2504-(64.0*g2503)-(2304.0*
         g2500)+1024.0*g2499+32.0*(g2516-g2709-g2786)+8.0*(g2697+g2615)+2.0*(
         g2618+g2617)+256.0*(g3151-g2498)+4.0*g2549*sw)+g3077*g2979+g2980*(144.0
         *g3152+48.0*g2706-(96.0*g2526)+768.0*g2596+384.0*(g2527-g2597-g2595)+
         2.0*(-g2699-g2698)-(16.0*g2754*g2631))+g2983*(1.33333*g3080+64.0*g2817)
         +g2990*(8.0*g3089-g3080)+g2999*(g3097+g3055+g3052+32.0*g2600+g3170*
         g2979-g3187-g3178)+g3000*(g3181+g3068+48.0*g2651)+g3001*(g3112+g3053-
         g3182)+g3026*g2767*(2.0*g3109-(2048.0*g2643)+512.0*g2642)+g3009*m23sq*(
         g3120+g3042)+g3010*m13sq*(g3120+g3061+g3047);
        msq3=(t0+g3009*(g3054+g3041+3.0*g2657+12.0*(-g2742-g2878))+g3010*(g3186+
         g3072-(2.0*g3067)+g3041-(8.0*g2880)+3.0*g2656)+g3012*(g3063-(4.0*g3089)
         )+g2744*g2545*(32.0*g2744-(80.0*g2999))+g2811*g2465*(g3191-(576.0*g2hzz
         ))+g2789*g2789*(g3086+g3064)+g2764*g2764*(8.0*g2458-(12.0*g2656))+g2765
         *g2458*(g3193-(48.0*g2765))+g2793*g2793*(g3088+g3084)+g3116*g2744*g2744
         +g2745*g2745*(g3116+32.0*g2545)+g2779*g2779*(g3196+g3111)+g2778*g2778*
         16.0*(g2632-g2545)+12.0*g3115*g2760*g2760+g2763*g2763*(g3198+24.0*g2657
         )+g2765*g2765*(g3198+24.0*g2656)-(64.0*g3026*g2606)+g3164*g2950+60.0*
         g2735*m23sq+g3199*g2850-(g3175*g2779))/(g2990*g3207*g3207*(16.0*(g2694+
         g2951)-(32.0*g2710)));
      };
  };
  double msq_tot = ( msq1 + msq2 + msq3 ) * (pow(mh - mz,2) - pow(mt + mt,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq_tot;
  return width;
};

double mHZnN( double * x, size_t dim, void * par )
{
  double * _par = (double*) par;
  double mh =  _par[0];
  double mz =  _par[1];
  // double mQ =  _par[3]; // Massen der FS Fermionen sind gleich
  double ee =  _par[4];
  double sw =  _par[5];
  //double CKM = _par[6];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  //double g3hzz = _par[9];
  //double g1hww = _par[10];
  //double g2hww = _par[11];
  //double g3hww = _par[12];
  //double g1hzy = _par[13];
  //double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * pow( mh - mz, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), 0, 0, pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2) + pow(mz,2) - m12sq - m23sq;
  
  double g219,g225,g84,g243,g229,g257,g4,g240,g54,g241,g5,g83,g228,g224,g6,g217,g7,g247,g8,g82,g9,g10,g119,
       g96,g120,g11,g63,g12,g64,g13,g105,g235,g242,g56,g35,g106,g57,g36,g107,g58,g37,g132,g99,g98,g75,g162,
       g232,g78,g77,g104,g245,g80,g218,g29,g81,g30,g31,g41,g226,g215,g211,g108,g233,g42,g55,g213,g109,g79,
       g51,g52,g53,g246,g115,g59,g244,g121,g60,g93,g61,g62,g94,g65,g153,g95,g66,g67,g117,g69,g116,g70,g71,
       g212,g97,g74,g85,g112,g86,g87,g88,g152,g89,g227,g103,g90,g111,g91,g160,g100,g110,g113,g118,g122,g123,
       g231,g126,g127,g128,g129,g130,g134,g140,g141,g144,g151,g150,g199,g159,g161,g250,g258,g259,g269,g276,
       g260,g265,g308,g261,g262,g263,g264,g266,g279,g267,g268,g319,g270,g271,g272,g273,g275,g280,g274,g277,
       g278,g281,g313,g315,g316,g283,g285,g311,g291,g292,g314,g320,g321,g300,g301,g302,g303,g304,g305,g306,
       g307,g309,g310,g312,g317,g318,g329,g216,g214,msq;
    {
    double t0 = 0;
    g219=mz*mz;
    g225=ee*ee;
    g84=g225*g219;
    g243=mh*mh;
    g229=g243*g2hzz;
    g257=g84*g2hzz;
    g4=g257*g229;
    g240=sw*sw;
    g54=g240*g84;
    g241=m23sq*m23sq;
    g5=g241*g54;
    g83=g241*g84;
    g228=g240*sw;
    g224=g228*sw;
    g6=g224*g83;
    g217=g240*g224;
    g7=g217*g83;
    g247=m13sq*m13sq;
    g8=g247*g54;
    g82=g247*g84;
    g9=g224*g82;
    g10=g217*g82;
    g119=g2hzz*g1hzz;
    g96=g225*g119;
    g120=g240*g96;
    g11=g243*g120;
    g63=g224*g96;
    g12=g243*g63;
    g64=g217*g96;
    g13=g243*g64;
    g105=sw*ee;
    g235=g1hzz*g1hzz;
    g242=g105*g105;
    g56=g242*g235;
    g35=g243*g56;
    g106=g225*g224;
    g57=g235*g106;
    g36=g243*g57;
    g107=g228*g1hzz;
    g58=g225*g107*g107;
    g37=g243*g58;
    g132=m13sq*m12sq;
    g99=g224*m12sq;
    g98=g225*m13sq;
    g75=g217*g98;
    g162=g219*m12sq;
    g232=g2hzz*g2hzz;
    g78=g242*g232;
    g77=g232*g106;
    g104=g228*g2hzz;
    g245=g104*g104;
    g80=g245*g225;
    g218=g243*g243;
    g29=g218*g54;
    g81=g218*g84;
    g30=g224*g81;
    g31=g217*g81;
    g41=g219*g105;
    g226=g41*g41;
    g215=g219*g219;
    g211=g224*g215;
    g108=g219*ee;
    g233=g108*g108;
    g42=g235*g233;
    g55=g235*g84;
    g213=g243*g218;
    g109=g243*g1hzz;
    g79=g109*m23sq;
    g51=g241*g56;
    g52=g241*g57;
    g53=g241*g58;
    g246=m12sq*m12sq;
    g115=g246*g1hzz;
    g59=g257*g115;
    g244=g225*ee;
    g121=g244*mw;
    g60=g121*g104;
    g93=g219*g121;
    g61=g109*g93;
    g62=g215*g96;
    g94=g215*g121;
    g65=g107*g94;
    g153=g242*g105*mw;
    g95=g153*g1hzz;
    g66=g218*g95;
    g67=g241*g93;
    g117=g241*g1hzz;
    g69=g247*g93;
    g116=g247*g1hzz;
    g70=g121*g116;
    g71=g121*g115;
    g212=g219*g215;
    g97=g225*g212;
    g74=g97*m23sq;
    g85=g240*m12sq;
    g112=g121*sw;
    g86=g112*m23sq;
    g87=g112*m13sq;
    g88=g95*m13sq;
    g152=g1hzz*m12sq;
    g89=g152*g121;
    g227=mw*mw;
    g103=g244*g227*ee;
    g90=g219*g103;
    g111=g1hzz*m13sq;
    g91=g111*g2hzz;
    g160=g243*sw;
    g100=g103*m23sq;
    g110=g1hzz*m23sq;
    g113=g219*m23sq;
    g118=g219*m13sq;
    g122=g228*g71;
    g123=g243*g228;
    g231=g247*m13sq;
    g126=g224*g62;
    g127=g228*m23sq;
    g128=g228*m13sq;
    g129=g228*m12sq;
    g130=g215*g60;
    g134=g231*g54;
    g140=sw*m12sq;
    g141=g110*g2hzz;
    g144=sw*g1hzz;
    g151=m23sq*m12sq;
    g150=g246*m23sq;
    g199=g4*m13sq;
    g159=g111*g86;
    g161=g89*sw;
    g250=g85*g85;
    g258=2.0*(g37*m23sq+g35*m23sq)-(4.0*g36*m23sq);
    g259=2.0*g218*g57-(g218*g56)-(g218*g58);
    g269=2.0*(g215*g75+g226*m13sq)-(4.0*g211*g98);
    g276=8.0*g99*g84*m13sq+4.0*(-(g162*g75)-(g132*g54));
    g260=-g276-g269;
    g265=7.0*(g10+g8)-(14.0*g9);
    g308=40.0*g269;
    g261=g308-(6.85714*g265);
    g262=16.0*(g215*g80+g232*g226)-(32.0*g215*g77);
    g263=2.0*(g10*m12sq+g8*m12sq)-(4.0*g9*m12sq);
    g264=2.0*g52-g51-g53;
    g266=2.0*(g7*m12sq+g5*m12sq)-(4.0*g6*m12sq);
    g279=96.0*g199*m23sq-(3.0*g225*g79*g79)-(g213*g55);
    g267=g279+3.0*g231*g55+16.0*(-(g59*m13sq)-(g59*m23sq));
    g268=g37-(2.0*g36)+g35;
    g319=2.0*g224*g42;
    g270=g319-(8.0*g219*g60);
    g271=5.0*(g31+g29)-(10.0*g30);
    g272=16.0*g219*g77+8.0*(-(g219*g80)-(g232*g54));
    g273=2.0*(g31*m12sq+g29*m12sq)-(4.0*g30*m12sq);
    g275=16.0*(g13+g11)-(32.0*g12);
    g280=128.0*g243*g77+64.0*(-(g243*g80)-(g243*g78));
    g274=3.0*g275-(1.5*g280);
    g277=32.0*(g218*g80+g218*g78)-(64.0*g218*g77);
    g278=5.0*(g7+g5)-(10.0*g6);
    g281=2.0*(g112*g1hzz-g95);
    g313=96.0*m23sq;
    g315=6.0*g70;
    g316=2.0*g121*g117;
    g283=-g316-g315-(12.0*g61);
    g285=-(88.0*g247*g4)-(24.0*g241*g4);
    g311=8.0*g87;
    g291=g316+10.0*g70;
    g292=16.0*g64-(32.0*g63);
    g314=16.0*g2hzz;
    g320=16.0*g4;
    g321=16.0*g62;
    g300=g71*sw-g122;
    g301=g53*m23sq-(2*g52*m23sq)+g51*m23sq;
    g302=2.0*g212*g77-(g212*g78);
    g303=3.2*g278;
    g304=2.0*g277;
    g305=16.0*g276;
    g306=4.0*g275;
    g307=2.0*g272;
    g309=10.2857*g265;
    g310=6.0*m12sq;
    g312=10.0*g87;
    g317=3.0*g103*m13sq;
    g318=32.0*g97*m12sq;
    g329=cw*cw*cw;
    g216=g329*g329;
    g214=g219*g216;
    {
        t0=(2.0*g57-g56-g58)*(g132*g132+g243*g213+7*g247*g151+5*(g231*m23sq-(
         g213*m13sq))+3*(g231*m12sq-(g213*m23sq))+2*(g231*m13sq-(g213*m12sq)+
         g150*m13sq))+(g321+g320)*(g129*g129-(2.0*g250)+3.0*g217*g151)+(g272+
         g268)*(g241*m23sq+2.0*g246*m13sq)+(-g316-(20.0*g61))*(sw*m13sq-g128)+(-
         g315-(8.0*g61))*(sw*m23sq-g127)+(48.0*g85-(96.0*g99))*(g4*m23sq+1.66667
         *g199)+(80.0*g118+48.0*g113)*(g13*m12sq-(2.0*g12*m12sq)+g11*m12sq)+g268
         *(8*g247*m12sq+4*g241*m12sq+7*g241*m13sq)+(-g314-(4.0*g1hzz))*(g226*g41
         *mw-(g233*g108*sw*mw))+g292*(g219*g213+2.0*(-(g212*m12sq)-(g212*m23sq)-
         (g231*g219))-(4.0*g212*m13sq))+2.0*(-m13sq-m23sq)*(g300-(12.0*g130));
        t0=t0+(-g311-(4.0*g86))*(g218*g1hzz-(2.0*g219*g152))+(-g311-(8.0*g86))*(
         3.0*g215*g2hzz+g229*g219)+(14.0*g69+2.0*g67)*(g144-g107)+(-m12sq-m13sq)
         *(g301+g100)+g302*(g313+32.0*m12sq+128.0*m13sq)+m12sq*(-g317-(8.0*g159)
         )+g65*(8.0*m12sq+14.0*m13sq+6.0*m23sq)+g66*(8.0*m13sq+4.0*(m12sq+m23sq)
         )+g79*(g312+g310*g112)+g90*(2.0*m12sq+m13sq-m23sq)+g91*(-g303-(11.2*
         g271))+g160*g94*(g314+10.0*g1hzz)+g243*m12sq*(2.0*g103+g312*g1hzz-(10.0
         *g88))+g113*(-g277-(12.0*g88)-(8.0*g228*g89))+g118*(g314*g86-g304-(7.0*
         g258))+g119*(-(16.0*g273)-(8.0*g266)-(24.0*g263)-(32.0*g134))-(g291*
         g123)-(g283*g129)+g132*(5*g264+7*g259+6.0*g258)+g109*g1hzz*(-g278-(
         1.28571*g265)-g260)+g275*g246*g219;
        t0=t0+g140*(g283+g320*g140)+g141*(g305-(4.8*g271)+g261)+g153*g79*(-g310-
         (10.0*m13sq))+g307*g150+g151*(3.0*g262+5*g259+8.0*g88)+g246*g54*16.0*(-
         g91-g141)+g240*g119*(-g318-(32.0*g74))+g243*g60*8.0*(g118+g113)+g226*
         g2hzz*(80.0*g116+16.0*(g115+g117))+g160*(g291+2.0*g71)+g162*(-g277-(2.0
         *g258)-(16.0*g88))+g215*g1hzz*(-(14.0*g87)-(6.0*g86))+g232*m23sq*(g305+
         80.0*g269-g309)+g232*m12sq*(g261-g303)+g235*m23sq*(g271+g265+g260)+g235
         *m13sq*(g278+1.4*g271)-(1.16667*g274*g215*m23sq)+g215*m13sq*(2.75*g280-
         (7.5*g275))+g215*m12sq*(g280-g306)-(8.0*g278*g232*m13sq)+g308*g119*
         m12sq+g113*m13sq*(g306-(16.0*g60))+g109*g2hzz*(g309+1.6*g278)+g2hzz*sw*
         8.0*(g69+g67)+11*g259*m23sq*m13sq+g212*(g274-(128.0*g232*g75));
        t0=t0+g213*(g281+16.0*g119*g54-g307)+g215*(g304+g258-(8.0*g161))+g217*(
         g267+80.0*g132*g4)+g218*(6.0*g144*g93-g319-(4.0*g161)-g103-(96.0*g126))
         +g219*(g301+4.0*g300+12.0*g159-(6.0*g66)-(48.0*g302))+g219*g212*(g292+
         16.0*g120+48.0*g80)+g224*2.0*(g285-g267)+g226*(g109*g109-(g110*g110)-(
         g111*g111)+48.0*(g141*m12sq+g218*g119))+g227*(g84*g84-(2.0*g98*g98))+
         g231*(5.0*g272+7*g268-(2.0*g281))+g235*(g273+g266+g263+3.0*g134)+g240*(
         g279-(64.0*g97*g91)-g285)+g241*(g270+3.5*g262-(32.0*g126))+g243*(g317+
         g100-g90-(2.0*g122)-(10.0*g65)-(16.0*g130))+g245*(-g318-(96.0*g74))+
         g246*(g264+g262+g259+g258-g103)+g247*(g270+4*g264+7.5*g262+9*g259+6.5*
         g258-(160.0*g126));
        msq=(t0+g127*g127*(g321+24.0*g4-g42)+g128*g128*(88.0*g4-g42+80.0*g62)+
         g123*g123*(g42+48.0*g62)-(g313*g99*g62))/(g219*(4.0*g216*g211-(8.0*g214
         *g99))+4.0*g250*g214);
      };
  };
  double msq_tot = msq * pow(mh - mz,2) * (m23max - m23min);
  double width = 1./pow(2.*M_PI,3)/32./pow(mh,3)*msq_tot;
  return width;
};

double _E2S(double m12, double m1sq, double m2sq)
{
  return (pow(m12,2) - m1sq + m2sq )/2./m12;
};

double _E3S(double Msq, double m12, double m3sq)
{
  return (Msq - pow(m12, 2) - m3sq ) / 2. / m12;
};

void _m23lim(double Msq, double m1sq, double m2sq, double m3sq, double m12, double * m23max, double * m23min )
{
  double E2 = _E2S( m12, m1sq, m2sq );
  double E3 = _E3S( Msq, m12, m3sq );
  double E2sq = pow( E2, 2 );
  double E3sq = pow( E3, 2 );
  * m23max = pow(E2 + E3,2) - pow(sqrt(E2sq - m2sq) - sqrt(E3sq - m3sq), 2);
  * m23min = pow(E2 + E3,2) - pow(sqrt(E2sq - m2sq) + sqrt(E3sq - m3sq), 2);
};

/* Hilfsfunktionen fuer Zerfaelle in yy,Zy und gg */

complex< double > f_( double tau )
{
  if( tau >= 1.0 )
    {
      complex< double > temp( pow(asin(1/sqrt(tau)),2) , 0 );
      return temp;
    }
  else
    {
      double np = 1+sqrt(1-tau);
      double nm = 1-sqrt(1-tau);
      double re = log(np/nm);
      double im = -M_PI;
      complex< double > temp( re, im );
      return -1.0/4.0*pow(temp,2);
    };
};

complex< double > g_( double tau )
{
  if( tau >= 1.0 )
    {
      complex< double > temp( asin(1/sqrt(tau)), 0 );
      return sqrt(tau-1)*temp;
    }
  else
    {
      double np = 1+sqrt(1-tau);
      double nm = 1-sqrt(1-tau);
      double re = log(np/nm);
      double im = -M_PI;
      complex< double > temp( re, im );
      return 0.5*sqrt(1-tau)*temp;
    };
};

complex< double > I1_( double a, double b )
{
  complex< double > eins( 1, 0 );
  complex< double > I1;
  I1 = a*b/2.0/(a-b)*eins + pow(a*b,2)/2.0/pow(a-b,2)*(f_(a)-f_(b)) + pow(a,2)*b/pow(a-b,2)*(g_(a)-g_(b));
  return I1;
};

complex< double > I2_( double a, double b )
{
  return -a*b/2.0/(a-b)*(f_(a)-f_(b));
};
