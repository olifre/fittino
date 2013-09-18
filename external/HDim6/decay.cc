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
  double ff[] = { fuph_( smpar, effpar, smpar->mh ),
		  fdoh_( smpar, effpar, smpar->mh ), 
		  fchh_( smpar, effpar, smpar->mh ),
		  fsth_( smpar, effpar, smpar->mh ), 
		  ftoh_( smpar, effpar, smpar->mh ),
		  fboh_( smpar, effpar, smpar->mh ) };
  complex<double> Af(0,0); // Fermionschleife
  double tau = 0;
  for( int i = 0; i < 6; i++ )
    {
      tau = 4.0*pow(mf[i],2)/pow(smpar->mh,2);
      Af += -tau*(complex<double>(1,0)+(1-tau)*f_(tau))*sqrt(2)*smpar->alphas/M_PI/smpar->vev*ff[i];
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
  double ff[] = { fuph_( smpar, effpar, smpar->mh ),
		  fdoh_( smpar, effpar, smpar->mh ),
		  fchh_( smpar, effpar, smpar->mh ), 
		  fsth_( smpar, effpar, smpar->mh ), 
		  ftoh_( smpar, effpar, smpar->mh ),
		  fboh_( smpar, effpar, smpar->mh ),
		  felh_( smpar, effpar, smpar->mh ),
		  fmuh_( smpar, effpar, smpar->mh ), 
		  ftah_( smpar, effpar, smpar->mh ) };
  complex<double> Af(0,0); // Fermionschleife
  complex<double> Aw(0,0); //W-Schleife
  double tau = 0;
  for( int i = 0; i < 9; i++ )
    {
      complex<double> eins(1,0);
      tau = 4.0*pow(mf[i],2)/pow(smpar->mh,2);
      Af += -2.0*tau*(eins+(1-tau)*f_(tau))*Nc[i]*ef[i]*ef[i]*smpar->alphae/2.0/M_PI/smpar->vev*ff[i];
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
  double ff[] = { fuph_( smpar, effpar, smpar->mh ),
		  fdoh_( smpar, effpar, smpar->mh ),
		  fchh_( smpar, effpar, smpar->mh ), 
		  fsth_( smpar, effpar, smpar->mh ), 
		  ftoh_( smpar, effpar, smpar->mh ),
		  fboh_( smpar, effpar, smpar->mh ),
		  felh_( smpar, effpar, smpar->mh ),
		  fmuh_( smpar, effpar, smpar->mh ), 
		  ftah_( smpar, effpar, smpar->mh ) };
 
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
      Af+=smpar->alphae/2.0/M_PI/smpar->vev * Nc[i]*(-2.0*ef[i])*(t3[i]-2.0*ef[i]*sw*sw)/sw/cw*(I1_(tau,lambda)-I2_(tau,lambda))*ff[i];
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
  double ffH = ftah_( smpar, effpar, mh );
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(ffH,2)*pow(1.-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hmumu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mmu;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = fmuh_( smpar, effpar, mh );
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(ffH,2)*pow(1-pow(2.*mf/mh,2),1.5);  
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
  double ffH = fchh_( smpar, effpar, mh );
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hstst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mst;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = fsth_( smpar, effpar, mh );
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
  *pError = 0;
};

void hbobo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError )
{
  double mf = smpar->mbo;
  double mh = smpar->mh;
  double v   = smpar->vev;
  double ffH = fboh_( smpar, effpar, mh );
  *pWidth = pow(mf,2.)*mh/8./M_PI/v/v*pow(ffH,2)*3.*pow(1-pow(2.*mf/mh,2),1.5);
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
  double ee =  _par[4];
  double sw =  _par[5];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  double g3hzz = _par[9];
  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  double mq = mQ;
  
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mQ + mQ, 2 )) + pow( mQ + mQ, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mQ,2), pow(mQ,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mQ,2) + pow(mQ, 2) + pow(mz,2) - m12sq - m23sq;

  // Matrixelemente
double g89,g98,g46,g91,g9,g99,g4,g90,g43,g5,g44,g53,g6,g7,g51,g83,g10,g8,g92,g47,g33,g25,g11,g97,g19,g12,g96,g49,g22,g13,g95,g32,g14,g65,g15,g28,g16,g56,g20,g81,g17,g50,g21,g18,g23,g29,g26,g30,g27 ,g31,g45,g34,g48,g35,g36,g37,g38,g40,g39,g41,g42,g57,g58,g59,g61,g64,g68,g71,g75,g77,g82,g88,g105,g106,g107,g108,g127,g109,g132,g133,g134,g110,g111,g112,g128,g113,g116,g125,g114,g117,g118,g119,g120,g121,g122,g123,g124,g126,g129,g130 ,g131,g135,g136,msq1;
{
    double t0 = 0;
    g89=mq*mq;
    g98=ee*ee;
    g46=g98*g89;
    g91=mh*mh;
    g9=g91*g46;
    g99=g2hzy*g2hzy;
    g4=g99*g9;
    g90=mz*mz;
    g43=g90*g46;
    g5=g43*m23sq;
    g44=g98*m13sq;
    g53=g91*g90;
    g6=g53*g44;
    g7=g43*m12sq;
    g51=g98*g90;
    g83=g89*g89;
    g10=g83*g51;
    g8=g99*g10;
    g92=g1hzy*g1hzy;
    g47=g98*g92;
    g33=g91*g47;
    g25=g91*g33;
    g11=g90*g25;
    g97=m23sq*m23sq;
    g19=g97*g51;
    g12=g92*g19;
    g96=m13sq*m13sq;
    g49=g96*g90;
    g22=g98*g49;
    g13=g92*g22;
    g95=m12sq*m12sq;
    g32=g95*g47;
    g14=g90*g32;
    g65=g2hzy*g1hzy;
    g15=g65*g51;
    g28=g47*m23sq;
    g16=g28*m12sq;
    g56=g99*m23sq;
    g20=g98*g56;
    g81=g90*g90;
    g17=g81*g20;
    g50=g90*g51;
    g21=g99*g50;
    g18=g21*m13sq;
    g23=g81*g28;
    g29=g81*g47;
    g26=g29*m13sq;
    g30=g97*g47;
    g27=g30*m13sq;
    g31=g96*g47;
    g45=g83*g46;
    g34=g90*g45;
    g48=g90*g50;
    g35=g99*g48;
    g36=g92*g46;
    g37=g30*m23sq;
    g38=g31*m13sq;
    g40=g65*g50;
    g39=g40*m23sq;
    g41=g65*g48;
    g42=g92*g44;
    g57=g97*g15;
    g58=g92*g10;
    g59=g92*g9;
    g61=g89*g6;
    g64=g65*g10;
    g68=g40*m13sq;
    g71=g28*m13sq;
    g75=g15*m23sq;
    g77=g6*m23sq;
    g82=g89*g83;
    g88=g96*g28;
    g105=12.0*(-g26-g23);
    g106=16.0*(g68+g39);
    g107=16.0*(g18+g17);
    g108=8.0*(g13+g12)-(16.0*g41);
    g127=4.0*g25;
    g109=-g127-(4.0*g32)-(12.0*g16);
    g132=8.0*g29;
    g133=16.0*g40;
    g134=16.0*g21;
    g110=g132+8.0*g59-g134-g133;
    g111=g31+g30;
    g112=g134-g111;
    g128=4.0*g28;
    g113=-g128-(4.0*g42);
    g116=4.0*m13sq;
    g125=4.0*m23sq;
    g114=g125+g116;
    g117=48.0*m13sq;
    g118=8.0*g6;
    g119=16.0*g7;
    g120=32.0*g5;
    g121=4.0*m12sq;
    g122=7.0*m12sq;
    g123=32.0*m12sq;
    g124=48.0*m12sq;
    g126=16.0*m23sq;
    g129=4.0*g25*m23sq;
    g130=8.0*g16;
    g131=8.0*g75;
    g135=16.0*g90*g48;
    g136=16.0*g20;
    {
        t0=g114*(28.0*g64-g11-g14)+m12sq*(g38+3.0*g27+8.0*g26-(24.0*g68)-(48.0*
         g18)+g125*g59)+m13sq*(g129+4.0*g88+16.0*(g57+g23))+g8*(g123-(4.0*g114))
         +g12*(-g122-(16.0*m13sq))+g13*(-g126-g122)+g17*(-g124-g117)+g83*g33*(-
         g121-(6.0*g114))+g35*(g124+32.0*m13sq)+g37*(g116+m12sq)+g39*(-g117-(
         24.0*m12sq))+g41*(g123+8.0*g114)+g96*g89*(-(32.0*g15)-(28.0*g28))+g95*
         g89*(-g128-(16.0*g15))+g58*(-(19.0*g114)-(28.0*m12sq))+g92*g91*(-g119-(
         52.0*g5))+g90*m13sq*(16.0*g4-(14.0*g16)+g136*m12sq)+g91*m12sq*(g131+
         g112-g132)+g65*(48.0*g61+g118*m12sq-(96.0*g5*m13sq)-g135-(16.0*g77))+
         g91*g65*(48.0*g5-g119)+g92*m12sq*(g118-(8.0*g45)+28.0*g5)+g89*m12sq*(6*
         g112-(16.0*g29)+48.0*g40)+g109*g89*m13sq;
        t0=t0+g99*m12sq*(8.0*(g22+g19)-g120)+g99*m13sq*(16.0*g19-(32.0*g7)-g120)
         +g92*m13sq*(28.0*g7+72.0*g5)+g59*m13sq*(g121+32.0*m23sq)+g81*(g130+g127
         -(32.0*g4)+24.0*g59-(96.0*g65*g9))+g82*(8.0*g113-(96.0*g15)+16.0*g33)+
         g83*(20*g111-g109+56.0*g71+32.0*g29-(144.0*g40)+48.0*g21+12.0*g42*m12sq
         )+g90*g81*(g113+4.0*g33+8.0*g36)+g89*(4.0*g108+g107+7.0*g106+2.66667*
         g105+24.0*g11-(32.0*g57)+8.0*g14-(28.0*g27)+16.0*g82*g47-g129)+g90*(
         32.0*g17+4.0*(-g38-g37)+g126*g4)+g91*(g108+g107+g106+g105+4.0*g14+68.0*
         g58-(80.0*g64)+16.0*(-g8-g35)+8.0*(-g88-g27)-(2.0*g16*m13sq))+g92*(20.0
         *g77-(52.0*g61)+56.0*g34)+g95*(g131+g111+2.0*g71+8.0*g15*m13sq-g133);
        msq1=(t0+g96*(g110+3.0*g16+8.0*g30+16.0*g75-(g116*g36))+g97*(g110-(g125*
         g36))+g99*(32.0*g34-g135)-(16.0*g56*g6)+g136*g49+g130*g53)/(6.0*g95*g90
         );
    };
};
double g593,g594,g319,g298,g243,g581,g582,g369,g141,g341,g550,g283,g350,g142,g558,g344,g267,g247,g300,g246,g245,g302,g244,g469,g146,g147,g346,g148,g370,g573,g413,g595,g470,g311,g325,g274,g569,g565,g586,g184,g154,g343,g314,g268,g185,g155,g345,g295,g273,g339,g324,g234,g158,g264,g200,g159,g248,g439,g546,g304,g271,g575,g351,g312,g272,g601,g270,g568,g442,g212,g213,g368,g315,g437,g254,g352,g269,g353,g354,g303 ,g257,g258,g356,g176,g355,g177,g446,g557,g447,g266,g357,g186,g265,g236,g250,g188,g251,g189,g415,g190,g309,g389,g191,g216,g217,g197,g199,g201,g301,g299,g418 ,g317,g596,g435,g551,g221,g349,g342,g297,g310,g296,g224,g225,g515,g226,g448,g231,g228,g232,g534,g233,g307,g235,g237,g238,g239,g512,g292,g240,g241,g513,g291 ,g242,g249,g556,g461,g252,g320,g294,g336,g293,g318,g263,g276,g388,g549,g277,g278,g514,g279,g280,g321,g284,g285,g287,g516,g577,g305,g306,g308,g313,g340,g326 ,g327,g328,g436,g332,g337,g338,g600,g360,g361,g362,g487,g373,g374,g378,g379,g580,g419,g387,g390,g392,g393,g394,g398,g414,g505,g412,g599,g411,
g410,g422,g431 ,g438,g440,g445,g451,g458,g460,g475,g477,g587,g489,g491,g493,g508,g507,g504,g499,g562,g667,g630,g757,g642,g652,g639,g612,g636,g645,g754,g661,g673,g728,g614 ,g662,g623,g611,g637,g621,g613,g631,g748,g752,g615,g628,g644,g616,g618,g730,g625,g657,g684,g649,g685,g619,g620,g751,g638,g646,g651,g750,g622,g624,g668,g744 ,g626,g627,g723,g629,g632,g704,g633,g734,g634,g745,g635,g749,g654,g640,g705,g641,g722,g724,g725,g643,g647,g648,g655,g650,g653,g656,g658,g659,g660,g663,g664 ,g677,g670,g665,g666,g699,g669,g759,g760,g671,g672,g731,g674,g675,g681,g732,g676,g678,g679,g680,g683,g686,g687,g689,g700,g693,g695,g697,g698,g702,g740,g736 ,g735,g738,g717,g719,g726,g727,g729,g733,g737,g739,g741,g742,g743,g746,g747,g753,g755,g756,g758,g761,msq2;
{
    double t0 = 0;
    g593=mz*mz;
    g594=ee*ee;
    g319=g594*g593;
    g298=g319*g1hzy;
    g243=g298*g1hzz;
    g581=mh*mh;
    g582=mq*mq;
    g369=g582*g581;
    g141=g369*g243;
    g341=g594*g2hzy;
    g550=g3hzz*m12sq;
    g283=g550*g341;
    g350=g593*g582;
    g142=g350*g283;
    g558=g593*g593;
    g344=g594*g558;
    g267=g344*g2hzz;
    g247=g267*g2hzy;
    g300=g558*g341;
    g246=g300*g1hzz;
    g245=g298*g3hzz;
    g302=g344*g1hzy;
    g244=g581*g302;
    g469=g582*g244;
    g146=g469*g2hzz;
    g147=g469*g1hzz;
    g346=g582*g369;
    g148=g346*g243;
    g370=g581*g369;
    g573=m23sq*m23sq;
    g413=g573*m13sq;
    g595=m13sq*m13sq;
    g470=g595*m23sq;
    g311=g594*g573;
    g325=g593*m12sq;
    g274=g325*g311;
    g569=sw*sw;
    g565=g569*sw;
    g586=g569*g565;
    g184=g565*g298;
    g154=g582*g184;
    g343=g594*g565;
    g314=g569*g343;
    g268=g314*g1hzy;
    g185=g593*g268;
    g155=g582*g185;
    g345=g581*m12sq;
    g295=g594*g345;
    g273=g593*g295;
    g339=g594*mw*ee;
    g324=g569*g339;
    g234=g324*g2hzy;
    g158=g582*g234;
    g264=g324*g1hzy;
    g200=g581*g264;
    g159=g582*g200;
    g248=g343*g3hzz;
    g439=g248*g2hzy;
    g546=g3hzz*g2hzy;
    g304=g546*g319;
    g271=g565*g341;
    g575=g593*g558;
    g351=g575*g271;
    g312=g575*g341;
    g272=g586*g312;
    g601=g350*g350;
    g270=g558*g314;
    g568=g582*g582;
    g442=g568*g2hzy;
    g212=g565*g246;
    g213=g586*g246;
    g368=g558*g248;
    g315=g582*g3hzz;
    g437=g248*g1hzy;
    g254=g268*g3hzz;
    g352=g575*g1hzy;
    g269=g594*g352;
    g353=g565*g269;
    g354=g575*g268;
    g303=g343*g1hzy;
    g257=g303*g2hzz;
    g258=g268*g2hzz;
    g356=g582*g565;
    g176=g356*g267;
    g355=g569*g356;
    g177=g355*g267;
    g446=g568*g1hzz;
    g557=g582*g568;
    g447=g565*g1hzz;
    g266=g593*g339;
    g357=g582*sw;
    g186=g357*g357*g266;
    g265=g266*g1hzy;
    g236=g582*g265;
    g250=g271*g2hzz;
    g188=g250*m23sq;
    g251=g314*g2hzz*g2hzy;
    g189=g251*m23sq;
    g415=g1hzz*m23sq;
    g190=g415*g271;
    g309=g594*m23sq;
    g389=g586*g2hzy;
    g191=g389*g309*g1hzz;
    g216=g437*m12sq;
    g217=g254*m12sq;
    g197=g357*g298;
    g199=g234*m12sq;
    g201=g558*g283;
    g301=g312*sw;
    g299=g344*g3hzz;
    g418=g594*g1hzy;
    g317=g418*sw;
    g596=m12sq*m12sq;
    g435=g596*g1hzy;
    g551=sw*g1hzy;
    g221=g551*g267;
    g349=g581*g558;
    g342=g593*g349;
    g297=g342*g309;
    g310=g594*m13sq;
    g296=g342*g310;
    g224=g267*m13sq;
    g225=g267*m23sq;
    g515=g1hzz*sw;
    g226=g515*g302;
    g448=g557*sw;
    g231=g243*sw;
    g228=g568*g231;
    g232=g575*g295*g1hzz;
    g534=g2hzy*m12sq;
    g233=g534*g266;
    g307=g558*g339;
    g235=g582*g307;
    g237=g265*m13sq;
    g238=g595*g265;
    g239=g573*g264;
    g512=m12sq*g1hzy;
    g292=g512*g339;
    g240=g595*g292;
    g241=g264*m23sq;
    g513=m13sq*g1hzy;
    g291=g513*g339;
    g242=g582*g291;
    g249=g596*g299;
    g556=g593*g575;
    g461=g556*g1hzz;
    g252=g461*g271;
    g320=g556*g341;
    g294=g320*g1hzz;
    g336=g556*g1hzy;
    g293=g594*g336;
    g318=g596*g339;
    g263=g318*g2hzy;
    g276=sw*m12sq;
    g388=g418*g276;
    g549=g3hzz*g1hzy;
    g277=g549*g309;
    g278=g549*g310;
    g514=m23sq*g1hzy;
    g279=g514*g339;
    g280=g312*g276;
    g321=g595*g1hzy;
    g284=g301*g2hzz;
    g285=g320*g2hzz;
    g287=g301*g1hzz;
    g516=g2hzz*sw;
    g577=g593*g556;
    g305=g577*g341;
    g306=g575*g339;
    g308=g318*g1hzy;
    g313=g575*m12sq;
    g340=g596*g582;
    g326=g352*g248;
    g327=g593*m23sq;
    g328=g596*m13sq;
    g436=g573*g1hzy;
    g332=g581*m13sq;
    g337=g595*g1hzz;
    g338=m23sq*m12sq;
    g600=g338*g338;
    g360=g593*m13sq;
    g361=g582*m12sq;
    g362=m13sq*m12sq;
    g487=g575*m13sq;
    g373=m23sq*sw;
    g374=m23sq*m13sq;
    g378=g593*g581;
    g379=g581*g565;
    g580=g581*g581;
    g419=g580*g374;
    g387=g224*g2hzy;
    g390=sw*m13sq;
    g392=g581*sw;
    g393=g516*g269;
    g394=g515*g269;
    g398=g2hzy*sw;
    g414=g1hzz*g1hzy;
    g505=g3hzz*m23sq;
    g412=g595*m12sq;
    g599=g573*m23sq;
    g411=g599*g1hzz;
    g410=g337*m13sq;
    g422=g565*g141;
    g431=g362*g264;
    g438=g327*g199;
    g440=g325*g158;
    g445=g305*g1hzz;
    g451=g573*m12sq;
    g458=g278*g276;
    g460=g581*m23sq;
    g475=g565*g1hzy;
    g477=g231*m23sq;
    g587=g582*g557;
    g489=g565*m12sq;
    g491=g565*m23sq;
    g493=g565*m13sq;
    g508=g2hzz*m13sq;
    g507=g1hzz*m13sq;
    g504=g3hzz*m13sq;
    g499=g2hzz*m23sq;
    g562=g276*g276;
    g667=112.0*g351*g1hzz-(64.0*g272*g1hzz);
    g630=g667-(48.0*g287);
    g757=12.0*g236;
    g642=16.0*g569*g236-g757;
    g652=112.0*g582*g212-(48.0*g357*g246)-(64.0*g582*g213);
    g639=g652+g642;
    g612=g639+g630-(48.0*g393);
    g636=8.0*g596*g254-(14.0*g435*g248);
    g645=16.0*g354*g1hzz-(28.0*g353*g1hzz);
    g754=12.0*g233;
    g661=g754+g636;
    g673=56.0*g582*g216-(24.0*g388*g315)-(32.0*g582*g217);
    g728=2.0*g645;
    g614=g728-(1.5*g673)-g661;
    g662=224.0*g575*g250-(128.0*g575*g251);
    g623=g662-(96.0*g284);
    g611=g623+g614+g612-(3.0*g308)+60.0*g228;
    g637=56.0*g568*g437-(24.0*g568*g317*g3hzz)-(32.0*g568*g254);
    g621=-(3.0*g637)-(16.0*g159);
    g613=g728+2.0*g652+3.0*g642-g621+72.0*g228;
    g631=16.0*g446*g268-(28.0*g446*g303);
    g748=8.0*g241;
    g752=32.0*g158;
    g615=2.0*g631-g752-g748;
    g628=64.0*g582*g354-(112.0*g582*g353)+48.0*g357*g269;
    g644=128.0*g442*g270-(224.0*g601*g271)+96.0*g568*g300*sw;
    g616=g644-g628;
    g618=128.0*g582*g272-(224.0*g582*g351)+96.0*g582*g301;
    g730=2.0*g618;
    g625=96.0*g280-g730;
    g657=112.0*g557*g184-(48.0*g448*g298)-(64.0*g557*g185);
    g684=28.0*g447*g302-(16.0*g558*g268*g1hzz);
    g649=g684-(12.0*g226);
    g685=32.0*g213-(56.0*g212);
    g619=g685+2.5*g649;
    g620=12.0*g569*g240-(9.0*g240);
    g751=16.0*g199;
    g638=12.0*g534*g339-g751;
    g646=8.0*g217-(14.0*g216);
    g651=560.0*g568*g257-(320.0*g568*g258);
    g750=16.0*g200;
    g622=g638-(15.0*g631)+64.0*g158-g750-(1.4*g651)-(6.0*g646);
    g624=6.0*g345*g279-(32.0*g575*g264);
    g668=56.0*g593*g439-(24.0*g304*sw)-(32.0*g586*g304);
    g744=24.0*g221;
    g626=g744+g668+g649;
    g627=g757+g754+g673;
    g723=1.33333*g461*g268+g515*g293-(2.33333*g447*g293);
    g629=12.0*g723;
    g632=-g646-(3.0*g292);
    g704=-(12.0*g242)-(6.0*g237);
    g633=g637-g704;
    g734=24.0*g369*g245;
    g634=g734-(12.0*g370*g243)-(72.0*g148)-(132.0*g147)+144.0*g146+96.0*(g369*
     g246+g369*g247+g142);
    g745=48.0*g221;
    g635=g745+4.0*g649-(3.0*g646);
    g749=4.0*g200;
    g654=g668-g749;
    g640=2.0*g654-(60.0*g226);
    g705=24.0*(-(g595*g141)-(g573*g141));
    g641=1.33333*g705+64.0*(-(g321*g225)-(g436*g224))+32.0*(-(g435*g224)-(g435*
     g225)-(g201*m13sq)-(g201*m23sq));
    g722=g556*g258-(1.75*g556*g257);
    g724=8.0*(-(g516*g293)-(g294*sw));
    g725=g586*g294-(1.75*g252);
    g643=6.0*g724+64.0*(-g725-g722);
    g647=12.0*(-g291-g279);
    g648=g632-(6.0*g388*g3hzz);
    g655=18.0*(-(g470*g243)-(g413*g243));
    g650=g734-g655-(24.0*g148)-(72.0*g147)-(48.0*g146);
    g653=-g667-g662;
    g656=64.0*g586*g247-(112.0*g565*g247);
    g658=32.0*g191-(56.0*g190);
    g659=24.0*(-g232-g249);
    g660=12.0*g238*m23sq+36.0*g512*g235+18.0*g338*g237+9.0*g238*m12sq+84.0*(g514
     *g235+g513*g235);
    g663=36.0*(-(g296*g1hzz)-(g297*g1hzz));
    g664=128.0*g189-(224.0*g188);
    g677=64.0*g315*g270-(112.0*g582*g368);
    g670=1.5*g677+72.0*g357*g299;
    g665=-(1.33333*g670)-(48.0*g235);
    g666=16.0*g505*g185-(28.0*g505*g184);
    g699=g748-(6.0*g279);
    g669=-g699-g626;
    g759=32.0*g254;
    g760=16.0*g264;
    g671=g760-g759;
    g672=48.0*(g296*g2hzz+g297*g2hzz);
    g731=48.0*g201;
    g674=1.33333*g655-(g731+48.0*g142);
    g675=1.5*g647+24.0*g241;
    g681=112.0*g176-(64.0*g177);
    g732=12.0*g307;
    g676=2.0*g681-g732;
    g678=112.0*g257-(64.0*g258);
    g679=g656+g619;
    g680=-g730-g657;
    g683=g672+g663;
    g686=-(7.0*g649)-(96.0*g221);
    g687=g744-(3.0*g649);
    g689=128.0*(m12sq+m13sq);
    g700=32.0*(-g362-g338);
    g693=336.0*g221-(180.0*g226);
    g695=-(12.0*g245)-(24.0*g246);
    g697=g664+2.0*g658;
    g698=g634+192.0*g285+24.0*g201;
    g702=128.0*g251-(224.0*g250);
    g740=48.0*g186;
    g736=24.0*g276;
    g735=24.0*g390;
    g738=24.0*g373;
    g717=g738+g735;
    g719=g649+g648;
    g726=2.0*g666;
    g727=2.0*g649;
    g729=2.0*g638;
    g733=48.0*g247;
    g737=96.0*g276;
    g739=96.0*g373;
    g741=12.0*g277;
    g742=6.0*g265;
    g743=36.0*g265;
    g746=288.0*g221;
    g747=24.0*g263;
    g753=32.0*g557*g264;
    g755=12.0*g237;
    g756=12.0*g239;
    g758=112.0*g439;
    g761=16.0*g234;
    {
        t0=g660+96.0*(g442*g307-(g516*g305))+64.0*(g550*g272+g389*g249)+1.33333*
         (g704*g562-(g660*g569))+(4.0*g264+6.0*g231)*(g362*g362+g412*m13sq+g451*
         m23sq)+g665*(g2hzy*m13sq+g2hzy*m23sq)+(8.0*g586*g274-(14.0*g565*g274)+
         6.0*g274*sw)*(3.0*g549-(4.0*g546)-(g581*g414)-(6.0*g582*g414))+g678*(
         3.0*g575*g374+g313*m12sq+g487*m13sq+g575*g573+6.0*g558*g557+1.5*(g313*
         m13sq+g313*m23sq))+(14.0*g565*g273-(6.0*g273*sw)-(8.0*g586*g273))*(g321
         *g1hzz+4.0*(-(g504*g2hzy)-(g505*g2hzy))+2.0*(g414*g374+g504*g1hzy+g505*
         g1hzy))+(6.0*g631+8.0*g200)*(g325*m13sq+g325*m23sq);
        t0=t0+(28.0*g154-(12.0*g197)-(16.0*g155))*(3.0*g337*m12sq+8.0*g374*g3hzz
         +6.0*g507*g338+g411+g410+2.0*(g328*g1hzz+g596*g3hzz+g595*g3hzz+g573*
         g3hzz+g596*g415))+(32.0*g586*g244-(56.0*g565*g244))*(g338*g2hzz+g362*
         g2hzz-(2.0*g374*g2hzz)+g505+g504)+g700*(3.0*g155*g3hzz-(5.25*g154*g3hzz
         )+2.25*g197*g3hzz+8.0*g177*g2hzy-(14.0*g176*g2hzy))+g695*(2.0*g373*g332
         -(g596*g373))+(2.33333*g670-g740)*(g514+g513)+16.0*(g415+g3hzz)*(g328*
         g185-(1.75*g328*g184))+(7.0*g628+g618-(288.0*g280)-g644)*(g508+g499)+(
         1.5*g644-(1.25*g625)+2.0*(g657-g628))*(g507+g415);
        t0=t0+(8.0*g185-(14.0*g184))*(6.0*g504*g338+8.0*g587*g1hzz+g410*m12sq+
         g411*m12sq+3.0*g412*g3hzz+g596*g337+g600*g1hzz+4.0*(g413*g3hzz+g573*
         g337)+2.0*(g410*m23sq+g411*m13sq+g419*g1hzz))+(g736+48.0*g373)*(g507*
         g269-(3.0*g508*g269)+g595*g246)+g634*(2.33333*(-g493-g491)+1.33333*(
         g569*g493+g569*g491))+g650*(1.33333*g569*g489-(2.33333*g489))+g649*(
         g581*g332+g581*g460-(10.0*g582*g338)-(g596*g581)-(6.0*g370))+g661*4.0*(
         g582*m13sq+g582*m23sq)+g702*(3.0*g556*m12sq+2.0*g556*m13sq-(g581*g556))
         +12.0*(m13sq+m23sq)*(5.33333*(g575*g254-g440)-g724-g723-(9.33333*g326))
         +6.0*(-(g594*g321*g3hzz)-(g549*g311))*(g596*sw-(g581*g276)+4.0*g558*sw)
         ;
        t0=t0+64.0*(g362-g332)*(g558*g191-(1.75*g558*g190)+2.0*g558*g189-(3.5*
         g558*g188))+(128.0*g374-g700)*(g569*g422-(1.75*g422))+(-g736-(48.0*g390
         ))*(1.5*g558*g277-(g573*g246))+(g751+5.0*g631)*(g360*m13sq+g593*g573)+
         g674*(1.33333*g569*g379-(2.33333*g379))+(g621-(12.0*g263))*(g360+g327)+
         g655*(6.22222*g355-(10.8889*g356))+g722*(g689+128.0*m23sq)+g725*g689+
         m13sq*(g624+32.0*g438)+sw*(24.0*g337*g269-g705-(48.0*g445))+g620*m23sq+
         g3hzz*(2.0*g616+48.0*g280-g680)+g231*(6.0*g600+12.0*g419+48.0*g587)+
         g276*(g650+96.0*g294+288.0*g285+24.0*g141*m23sq)+g293*(g737*g2hzz-(24.0
         *g3hzz*sw))+g313*(-g758-(3.0*g664)-(5.0*g658)-(32.0*g264))+g321*(g676+
         56.0*g368)+g340*sw*24.0*(g278+g277);
        t0=t0+g325*(g621-g756)+g328*(g685-g669)+g332*(g653+g627+g741*g276-g726)+
         g336*(56.0*g248-(12.0*g339))+g338*(g613+36.0*g242)+2.0*g669*g340+g342*(
         g697-g759)+g345*(g757+g653-g633)+g346*(156.0*g226+12.0*(g292-g265)-(
         240.0*g221))+g582*g573*(g686+18.0*g292)+g581*g573*(-g727-g632)+g349*(
         g651-g647+13.0*g631-g729)+g357*(4.66667*g655-g731)+g361*(g760*g361-(
         24.0*g239))+g362*(g756+2.5*g667+3.0*g662+g613)+g615*g325*m12sq+g373*(
         g698-(16.0*g373*g237))+g374*(4.0*g639+2.0*g614-(288.0*g284)+168.0*g228-
         (144.0*g287)+24.0*g374*g231)+g686*g595*g582+g332*m13sq*(g646-g727)+g637
         *g378+g631*g581*g378+g698*g390+g582*g276*192.0*(-g387-(g225*g2hzy))+
         g392*(g674-(96.0*g285));
        t0=t0+g398*(2.0*(g672-g659)-(1.33333*g663))+g412*(g679+g654)+g413*(g635+
         2.0*(g685+g656))+g582*g374*(-g746-(16.0*g649))+g595*g245*(g738+18.0*
         g276)+g581*g338*(g687-g742)+g435*(g681-g732)+g676*g436+g582*g306*(96.0*
         g2hzy-(48.0*g1hzy))+g581*g1hzy*(1.5*g665-(12.0*g306)+16.0*g186)+g448*(
         192.0*g247-(96.0*g246))+g558*m12sq*(g752+g675-(10.0*g631))+g568*m12sq*(
         g743+2.0*(g675+g640))+g451*(g679+9.0*(g265-g291)-g749)+g622*g558*m23sq+
         g558*m13sq*(6.0*g699+g622)+g581*g2hzz*(g625-g644-(6.0*g628))+g595*g276*
         (g733-(18.0*g277))+g460*(g627-g755)+g568*m23sq*(g743+g693)+g596*m23sq*(
         g742+g626)+g635*g470+g475*(56.0*g232-(2.33333*g683))+g569*g475*(1.33333
         *g683-(32.0*g232))+g477*12.0*(g328+g413);
        t0=t0+g581*g1hzz*(g680-(1.5*g616))+g693*g568*m13sq-(3.0*g697*g487)+g276*
         g269*(24.0*g415+48.0*g3hzz-(72.0*g499))+g512*(g670-g740)+g269*g3hzz*(
         2.0*g717-(24.0*g392))+g717*g244*g3hzz+g387*m23sq*(g737-(192.0*g357))+
         4.0*g681*g374*g2hzy+g374*g276*(36.0*g245+48.0*g246)+g374*g1hzy*(6.0*
         g681+168.0*g368)+g141*m13sq*(g739+g736)+g361*m13sq*(-(10.0*g649)-(48.0*
         g241))+g534*(64.0*g186-(24.0*g235)-g677)+g338*m13sq*(5.0*g684+g640)+
         g332*m23sq*(2.0*g646-g745-(5.0*g649))+g687*g332*m12sq+g328*sw*(-g741-
         g695)+g327*m13sq*(g750+14.0*g631)+g551*(g683+g659)+g1hzz*m12sq*(g657+
         2.5*g618+g616)+g2hzz*m12sq*(2.0*g644+3.0*g628+6.0*g618)+g556*(2.0*g697+
         g671)+g557*(4.0*(g656-g619)-g746-(8.0*g648)-(24.0*g265));
        t0=t0+g558*(g747+9.0*g637-(4.0*g636)+24.0*g431-(36.0*g458)+16.0*g239+
         96.0*(g159-(g374*g254)))+1.75*g641*g565+g568*(5.0*g630-(3.0*g623)+96.0*
         g394-(12.0*g308)+36.0*g237-(432.0*g393)+48.0*(g431-g233)-(108.0*g307*
         g1hzy))+g573*(g755+g611-(18.0*g458)+24.0*g394+g735*g245+g733*g276+96.0*
         g387*sw)+g575*(g750+g729+1.8*g651-(2.0*g647)-(8.0*g632)+4.0*g615)+g577*
         (g678-(48.0*g317*g2hzz)-g702)+g580*(g645+12.0*(g394+g228))+g581*(g643+
         g629-(16.0*g438)+32.0*g440+56.0*g326+3.0*g240-(g739*g387))+g582*(4.0*
         g643+2.0*(g629-g624-g620))+g586*(-g641-(64.0*g445))+g593*(g753+112.0*
         g252+g761*g328-(g751*g332))+g595*(g726+g611+96.0*g398*g225)+g596*(g666+
         g633+g612+4.0*g239+24.0*g228+g761*g327);
        msq2=(t0+g595*m13sq*(g719+12.0*g477)+g719*g599+g601*(144.0*g264-(128.0*
         g234))+g325*g325*(g760-g758+g658-(32.0*g234))+g360*g360*(g697+g671)+
         g327*g327*(56.0*g437-g759)-(24.0*g369*g233)+g747*g350-(g753*m12sq))/(cw
         *cw*cw*12.0*(g562*g558-(g569*g313)));
    };
};
double g1661,g1157,g1702,g1715,g981,g1666,g1351,g769,g1709,g1185,g982,g1680,g1231,g1151,g770,g1721,g1269,g1150,g771,g1691,g772,g1659,g1633,g1727,g1166,g978,g1289,g915,g1169,g1714,g1111,g790,g775,g1712,g1695,g1677,g1115,g791,g776,g1639,g1699,g1170,g1109,g792,g777,g1180,g1084,g1694,g1329,g1662,g1276,g1650,g918,g780,g1110,g919,g781,g920,g782,g1637,g1358,g1314,g1734,g1117,g785,g1102,g786,g787,g1168,g1112,g1722,g788,g1116,g789,g1106,g841,g958,g845,g986,g959,g1674,g847,g1172,g1651,g1105,g970,g1682,g1083,g1096,g971,g1101,g806,g800,g1108,g807,g801,g1100,g808,g802,g804,g805,g1114,g809 ,g1182,g987,g810,g1643,g1174,g1099,g934,g1337,g1733,g813,g822,g814,g1008,g823,g815,g1009,g824,g1010,g825,g1103,g833,g1113,g834,g819,g835,g820,g980,g821,g1097 ,g1642,g947,g826,g827,g979,g1328,g1161,g844,g842,g843,g1165,g846,g1684,g1176,g1095,g848,g1398,g1153,g1270,g1275,g896,g851,g1368,g856,g852,g1277,g864,g853,g1391,g894,g895,g857,g858,g859,g1203,g1154,g1152,g1126,g929,g1252,g1387,g1535,g1708,g1059,g1321,g956,g867,g957,g868,g875,g869,
g1229,g1031,g1346,g873,g874,g1082,g912,g1281,g1280,g905,g878,g879,g1149,g1283,g1282,g1259,g1159,g906,g1257,g1158,g907,g916,g917,g1208,g887,g888,g889,g890,g1511,g1461,g891,g1311,g904,g964,g1171,g897,g1503,g898,g899,g900,g901,g1179,g1394,g1065,g908,g1068,g1069,g911,g921,g922,g923,g924,g925,g926,g1502,g1297,g1085,g928,g930,g1713,g931,g1107,g1679,g932,g933,g946,g1181,g1081,g1288,g1390,g1254,g1080,g1475 ,g1477,g1001,g942,g1002,g943,g1003,g944,g1635,g945,g1004,g1005,g953,g960,g1118,g1032,g965,g1092,g972,g1641,g1173,g1104,g973,g976,g977,g988,g1007,g989,g990,g1184,g992,g1175,g1098,g993,g994,g1309,g1732,g997,g1731,g999,g1716,g1717,g1030,g1273,g1160,g1264,g1014,g1177,g1148,g1272,g1284,g1015,g1467,g1016,g1132,g1053,g1195,g1260,g1019,g1025,g1020,g1271,g1130,g1021,g1023,g1022,g1039,g1441,g1024,g1094,g1028,g1093,g1029,g1357,g1408,g1033,g1155,g1061,g1034,g1062,g1035,g1036,g1037,g1194,g1038,g1070,g1040,g1210,g1140,g1041,g1125,g1198,g1042,g1043,g1044,g1120,g1045,g1202,g1071,g1046,g1689,g1465,g1136,g1529,g1049,g1131,g1074,
g1051,g1052,g1075,g1054,g1133,g1055,g1134,g1057,g1135,g1058,g1060,g1183,g1711,g1139,g1468,g1201,g1138,g1067,g1267,g1137,g1469,g1076,g1090,g1077,g1078,g1079,g1088,g1091,g1167,g1121,g1122,g1123,g1143,g1124,g1631,g1393,g1274,g1464,g1144,g1147,g1163,g1164,g1178,g1320,g1645,g1186,g1409,g1193,g1292,g1192,g1191,g1197,g1196,g1268,g1205,g1206,g1207,g1263,g1211,g1364,g1265,g1266,g1730,g1253,g1262,g1258,g1255,g1261,g1729,g1256,g1601,g1602,g1286,g1638,g1300,g1298,g1299,g1486,g1338,g1487,g1719,g1514,g1491,g1307,g1308,g1312,g1313,g1315,g1317,g1327,g1339,g1332,g1334,g1340,g1341,g1342,g1343,g1345,g1496,g1497,g1352,g1353,g1354,g1355,g1356,g1359,g1365,g1369,g1370,g1376,g1377,g1378,g1406,g1382,g1407,g1395,g1420,g1423,g1426,g1436,g1442,g1446,g1447,g1448,g1454,g1462,g1483,g1510,g1495,g1498,g1512,g1517,g1519,g1530,g1658,g1683,g1752,g1704,g1764,g1793,g1810,g1802,g1813,g1969,g1840,g1864,g1779,g1791,g1801,g1970,g1804,g1819,g1839,g1778,g1808,g1784,g1780,g1884,g1901,g1781,g2078,g1782,g1936,g1897,g1815,g1854,g1908,g1783,g1785,g1847,
g1878,g1863,g1786,g1787,g1788,g1842,g1789,g1881,g1850,g2054,g1895,g1790,g2053,g1792,g1794,g2059,g1795,g1945,g1796,g1834,g1879,g1876,g2022,g1797,g1861,g1798,g1865,g1833,g1799,g1822,g1800,g1846,g1860,g1803,g1883,g1931,g2019,g1805,g1806,g2028,g1807,g2000,g1809,g1811,g1812,g1867,g1943,g1875,g1814,g1816,g1817,g1836,g1941,g1818,g1820,g1871,g2039,g1821,g1909,g1823,g2079,g2080,g1824,g1825,g1826,g1904,g1827,g1910,g1828,g1844,g1920,g1852,g1829,g1830,g2070,g1880,g1953,g1853,g1894,g1831,g2058,g1832,g1849,g1835,g1907,g1837,g1921,g1841,g1843,g1845,g1898,g2050,g1848,g1851,g1961,g1855,g2027,g1856,g1857,g1858,g2046,g1859,g1862,g1866,g1868,g1869,g1870,g1872,g1903,g1873,g1874,g1877,g2021,g2076,g1882,g1891,g1885,g2038,g1886,g2036,g1887,g1940,g1889,g1937,g1900,g1892,g1899,g2071,g1893,g1896,g1902,g1905,g1906,g2037,g1911,g1912,g1914,g1935,g1916,g2011,g1934,g1917,g1972,g1922,g2073,g1923,g1924,g1933,g2041,g1925,g1926,g1927,g1932,g1928,g1930,g2075,g1938,g2051,g1939,g2047,g1942,g1944,g2033,g1946,g1964,g1949,g1950,g1952,g1954,g1957,
g1958,g1959,g1960,g2044,g2014,g2032,g1977,g1979,g1984,g2035,g2065,g2008,g2009,g2010,g2012,g2013,g2015,g2016,g2017,g2018,g2020,g2023,g2024,g2025,g2026,g2029,g2030,g2031,g2034,g2040,g2042,g2043,g2045,g2048,g2049,g2052,g2055,g2056,g2057,g2060,g2061,g2062,g2063,g2064,g2066,g2067,g2068,g2069,g2072,g2074,g2077,g2081,g2082,g2083,g2094,g1667,msq3;
{
    double t0 = 0;
    g1661=mz*mz;
    g1157=g1661*ee;
    g1702=mh*mh;
    g1715=g1157*g1157;
    g981=g1715*g1702;
    g1666=mq*mq;
    g1351=g1666*g1hzz;
    g769=g1351*g981*g1hzz;
    g1709=m23sq*m23sq;
    g1185=g1702*g1661;
    g982=g1666*g1185;
    g1680=ee*ee;
    g1231=g1680*g3hzz;
    g1151=g1231*g1hzz;
    g770=g1151*g982;
    g1721=g1680*ee;
    g1269=g1721*mw;
    g1150=g1269*g1hzz;
    g771=g1150*g982;
    g1691=g3hzz*g3hzz;
    g772=g1691*g1680*g982;
    g1659=g1661*g1661;
    g1633=g1661*g1659;
    g1727=g2hzz*g2hzz;
    g1166=g1727*g1633;
    g978=g1680*g1166;
    g1289=g1702*g1666;
    g915=g1289*g978;
    g1169=sw*ee;
    g1714=g1169*g1169;
    g1111=g1714*g1702;
    g790=g1666*g1111;
    g775=g790*m23sq;
    g1712=sw*sw;
    g1695=g1712*sw;
    g1677=g1695*sw;
    g1115=g1680*g1677;
    g791=g1289*g1115;
    g776=g791*m23sq;
    g1639=g1677*sw;
    g1699=g1639*sw;
    g1170=g1699*g1680;
    g1109=g1702*g1170;
    g792=g1666*g1109;
    g777=g792*m23sq;
    g1180=g1680*m23sq;
    g1084=g1702*g1180;
    g1694=g1699*sw;
    g1329=g1694*g1666;
    g1662=g1329*sw;
    g1276=g1712*g1662;
    g1650=g1666*g1666;
    g918=g1650*g1111;
    g780=g1659*g918;
    g1110=g1650*g1115;
    g919=g1702*g1110;
    g781=g1659*g919;
    g920=g1650*g1109;
    g782=g1659*g920;
    g1637=g1712*g1699;
    g1358=g1637*g981;
    g1314=g1666*g1639;
    g1734=g1314*g1314;
    g1117=g1715*g1666;
    g785=g1712*g1117;
    g1102=g1659*g1115;
    g786=g1666*g1102;
    g787=g1699*g1117;
    g1168=g1680*g1637;
    g1112=g1666*g1168;
    g1722=g1hzz*g1hzz;
    g788=g1722*g1112;
    g1116=g1722*g1680;
    g789=g1276*g1116;
    g1106=g1659*g1116;
    g841=g1712*g1106;
    g958=g1722*g1102;
    g845=g1699*g1106;
    g986=g1715*g1637;
    g959=g1722*g986;
    g1674=g1712*g1637;
    g847=g1674*g1106;
    g1172=sw*mw;
    g1651=g1721*ee;
    g1105=g1651*g1172*g1172;
    g970=g1666*g1105;
    g1682=g1714*g1169;
    g1083=g1682*mw;
    g1096=g1169*g1083*mw;
    g971=g1666*g1096;
    g1101=g1714*g1691;
    g806=g1661*g1101;
    g800=g1650*g806;
    g1108=g1691*g1115;
    g807=g1661*g1108;
    g801=g1650*g807;
    g1100=g1691*g1170;
    g808=g1661*g1100;
    g802=g1650*g808;
    g804=g1666*g807;
    g805=g1666*g808;
    g1114=g1661*g1168;
    g809=g1691*g1114;
    g1182=g1712*g1168;
    g987=g1691*g1182;
    g810=g1661*g987;
    g1643=g1661*g1633;
    g1174=g1680*g1643;
    g1099=g1727*g1174;
    g934=g1666*g1099;
    g1337=g1666*sw;
    g1733=g1337*g1337;
    g813=g1733*g978;
    g822=g1633*g1110;
    g814=g1727*g822;
    g1008=g1633*g1170;
    g823=g1650*g1008;
    g815=g1727*g823;
    g1009=g1633*g1168;
    g824=g1650*g1009;
    g1010=g1633*g1182;
    g825=g1650*g1010;
    g1103=g1714*g1633;
    g833=g1666*g1103;
    g1113=g1633*g1115;
    g834=g1666*g1113;
    g819=g1727*g834;
    g835=g1666*g1008;
    g820=g1727*g835;
    g980=g1650*g1103;
    g821=g1722*g980;
    g1097=g1633*g1116;
    g1642=g1702*g1702;
    g947=g1642*g1097;
    g826=g1677*g947;
    g827=g1699*g947;
    g979=g1702*g1097;
    g1328=g1661*m13sq;
    g1161=g1328*g1hzz;
    g844=g1712*g1161;
    g842=g844*m23sq;
    g843=g1709*g1106;
    g1165=g1677*m12sq;
    g846=g1165*g1161;
    g1684=mw*mw;
    g1176=g1684*g1651;
    g1095=g1661*g1176;
    g848=g1702*g1095;
    g1398=g3hzz*g2hzz;
    g1153=g1182*g2hzz;
    g1270=g1666*g3hzz;
    g1275=g1712*g1661;
    g896=g1275*g1151;
    g851=g1702*g896;
    g1368=g1661*g3hzz;
    g856=g1368*g1115*g1hzz;
    g852=g1702*g856;
    g1277=g1699*g1151;
    g864=g1661*g1277;
    g853=g1702*g864;
    g1391=g3hzz*g1hzz;
    g894=g1391*g1112;
    g895=g1276*g1151;
    g857=g1709*g864;
    g858=g1666*g896;
    g859=g864*m23sq;
    g1203=g1650*g3hzz;
    g1154=g1680*g1203;
    g1152=g1154*m12sq;
    g1126=g1182*m12sq;
    g929=g1650*g1126;
    g1252=g1hzz*m12sq;
    g1387=g1252*g3hzz;
    g1535=g1126*g1hzz;
    g1708=m12sq*m12sq;
    g1059=g1708*g1151;
    g1321=g1661*g1059;
    g956=g1009*m13sq;
    g867=g1666*g956;
    g957=g1010*m13sq;
    g868=g1666*g957;
    g875=g1289*g1083;
    g869=g875*g3hzz;
    g1229=g1666*m12sq;
    g1031=g1229*mw;
    g1346=g1721*g1031;
    g873=g1639*g1346;
    g874=g1694*g1346;
    g1082=g1659*g1083;
    g912=g1666*g1082;
    g1281=g1639*g1150;
    g1280=g1694*g1150;
    g905=g1661*g1083;
    g878=g1650*g905;
    g879=g1666*g905;
    g1149=g1269*m12sq;
    g1283=g1650*g1639;
    g1282=g1666*g1329;
    g1259=g1702*m12sq;
    g1159=g1639*g1269;
    g906=g1702*g1159;
    g1257=g1661*m12sq;
    g1158=g1694*g1269;
    g907=g1702*g1158;
    g916=g1691*g1112;
    g917=g1666*g987;
    g1208=m23sq*m13sq;
    g887=g1714*g1208;
    g888=g1208*g1115;
    g889=g1208*g1170;
    g890=g1208*g1168;
    g1511=g1637*m13sq;
    g1461=g1712*g1511;
    g891=g1461*g1180;
    g1311=m23sq*m12sq;
    g904=g1311*g1168;
    g964=g1010*m23sq;
    g1171=g1712*g3hzz;
    g897=g1171*g981;
    g1503=g981*g3hzz;
    g898=g1677*g1503;
    g899=g1699*g1503;
    g900=g1358*g3hzz;
    g901=g1674*g1503;
    g1179=g1680*g1666;
    g1394=g2hzz*g1hzz;
    g1065=g1394*g1179;
    g908=g1708*g1082;
    g1068=g1659*g1159;
    g1069=g1659*g1158;
    g911=g1650*g1082;
    g921=g1709*g1101;
    g922=g1709*g1108;
    g923=g1709*g1100;
    g924=g1666*g1101;
    g925=g1666*g1108;
    g926=g1666*g1100;
    g1502=g1691*m12sq;
    g1297=g1680*m12sq;
    g1085=g1691*g1297;
    g928=g1637*g1085;
    g930=g987*m12sq;
    g1713=m13sq*m13sq;
    g931=g1713*g1101;
    g1107=m13sq*ee;
    g1679=g1107*g1107;
    g932=g1679*g1171*g1171;
    g933=g1713*g1100;
    g946=g1643*g1084;
    g1181=g1680*m13sq;
    g1081=g1727*g1181;
    g1288=g1702*g1643;
    g1390=g1709*m13sq;
    g1254=g1713*m23sq;
    g1080=g1727*g1297;
    g1475=g1709*m12sq;
    g1477=g1713*m12sq;
    g1001=g1714*g1643;
    g942=g1666*g1001;
    g1002=g1643*g1115;
    g943=g1666*g1002;
    g1003=g1643*g1170;
    g944=g1666*g1003;
    g1635=g1666*g1650;
    g945=g1635*g1106;
    g1004=g1643*g1168;
    g1005=g1674*g1174;
    g953=g1103*m13sq;
    g960=g1103*m23sq;
    g1118=g1712*m12sq;
    g1032=g1680*g1118;
    g965=g1633*g1032;
    g1092=g1176*m12sq;
    g972=g1650*g1092;
    g1641=g1721*g1661;
    g1173=g1641*g1157;
    g1104=g1684*g1173;
    g973=g1702*g1104;
    g976=g1712*g1092;
    g977=g1677*g1092;
    g988=g1635*g1101;
    g1007=g1635*g1115;
    g989=g1691*g1007;
    g990=g1635*g1100;
    g1184=g1708*g1680;
    g992=g1691*g1184;
    g1175=g1661*g1174;
    g1098=g1727*g1175;
    g993=g1666*g1098;
    g994=g1650*g1099;
    g1309=g1661*sw;
    g1732=g1309*g1309;
    g997=g1732*g2hzz;
    g1731=g1275*g1275;
    g999=g1731*g2hzz;
    g1716=g1709*m23sq;
    g1717=g1713*m13sq;
    g1030=g1172*m12sq;
    g1273=g1659*g1030;
    g1160=g1721*g1273;
    g1264=g1661*g1185;
    g1014=g1264*g1149;
    g1177=m23sq*mw;
    g1148=g1721*g1177;
    g1272=g1666*g1661;
    g1284=g1661*g1272;
    g1015=g1284*g1148;
    g1467=g1148*sw;
    g1016=g1650*g1467;
    g1132=g1150*sw;
    g1053=g1659*g1132;
    g1195=g1721*m13sq;
    g1260=g1661*g1328;
    g1019=g1260*g1148;
    g1025=g1272*g1172;
    g1020=g1195*g1025;
    g1271=g1721*g1172;
    g1130=g1713*g1271;
    g1021=g1666*g1130;
    g1023=g1641*g1030;
    g1022=g1702*g1023;
    g1039=g1661*g1271;
    g1441=g1708*g1hzz;
    g1024=g1441*g1039;
    g1094=g1709*g1176;
    g1028=g1666*g1094;
    g1093=g1713*g1176;
    g1029=g1666*g1093;
    g1357=g3hzz*m12sq;
    g1408=g1357*g2hzz;
    g1033=g1715*g1408;
    g1155=g1184*g3hzz;
    g1061=g1155*g2hzz;
    g1034=g1659*g1061;
    g1062=g1659*g1151;
    g1035=g1062*m23sq;
    g1036=g1062*m13sq;
    g1037=g1062*m12sq;
    g1194=g1659*g3hzz;
    g1038=g1271*g1194;
    g1070=g1083*g3hzz;
    g1040=g1070*m23sq;
    g1210=g1721*g3hzz;
    g1140=g1709*g1210;
    g1041=g1172*g1140;
    g1125=g1195*g3hzz;
    g1198=g1666*g1125;
    g1042=g1198*mw;
    g1043=g1070*m13sq;
    g1044=g1070*m12sq;
    g1120=g1149*g3hzz;
    g1045=g1661*g1120;
    g1202=g1708*g1269;
    g1071=g1202*g3hzz;
    g1046=g1071*m23sq;
    g1689=g1715*g1157;
    g1465=g1689*mw;
    g1136=g1465*g2hzz;
    g1529=g2hzz*m12sq;
    g1049=g1529*g1083;
    g1131=g1149*g2hzz;
    g1074=g1202*g2hzz;
    g1051=g1074*sw;
    g1052=g1666*g1132;
    g1075=g1083*g1hzz;
    g1054=g1075*m23sq;
    g1133=g1148*g1hzz;
    g1055=g1659*g1133;
    g1134=g1150*m13sq;
    g1057=g1659*g1134;
    g1135=g1149*g1hzz;
    g1058=g1659*g1135;
    g1060=g1650*g1085;
    g1183=m23sq*ee;
    g1711=g1183*g1183;
    g1139=g1711*g3hzz;
    g1468=g1633*g1hzz;
    g1201=g1633*g1391;
    g1138=g1394*g1175;
    g1067=g1465*g3hzz;
    g1267=g1174*ee;
    g1137=g1267*mw;
    g1469=g1666*g2hzz;
    g1076=g1633*g1150;
    g1090=g1176*m13sq;
    g1077=g1659*g1090;
    g1078=g1702*g1090;
    g1079=g1666*g1092;
    g1088=g1176*m23sq;
    g1091=g1661*g1092;
    g1167=g1661*g1175;
    g1121=g1702*g1635;
    g1122=g1716*g1666;
    g1123=g1717*g1666;
    g1143=g1210*g1030;
    g1124=g1143*m23sq;
    g1631=g1661*g1643;
    g1393=g1631*g2hzz;
    g1274=g1695*g1031;
    g1464=g1689*g1030;
    g1144=g1464*g2hzz;
    g1147=g1160*g1hzz;
    g1163=g1185*g1hzz;
    g1164=g1661*g1252;
    g1178=g1032*m13sq;
    g1320=g1677*g1633;
    g1645=g1661*g1320;
    g1186=g1661*g1645;
    g1409=g1679*g1357;
    g1193=g1194*g1hzz;
    g1292=g1633*g2hzz;
    g1192=g1292*g1hzz;
    g1191=g1259*g3hzz;
    g1197=g1172*g3hzz;
    g1196=g1721*g1197;
    g1268=g1708*g1702;
    g1205=g1666*m23sq;
    g1206=g1666*m13sq;
    g1207=g1691*m23sq;
    g1263=g1709*g1hzz;
    g1211=g1263*g1023;
    g1364=g1695*g1hzz;
    g1265=g1708*g1661;
    g1266=g1659*g1hzz;
    g1730=g1257*g1257;
    g1253=g1722*m12sq;
    g1262=g1713*g1hzz;
    g1258=g1659*m12sq;
    g1255=g1722*m13sq;
    g1261=g1633*m13sq;
    g1729=g1257*m13sq;
    g1256=g1722*m23sq;
    g1601=g1252*m23sq;
    g1602=g1252*m13sq;
    g1286=g1645*sw;
    g1638=g1286*sw;
    g1300=g1661*g1638;
    g1298=g1712*m23sq;
    g1299=g1712*m13sq;
    g1486=g1699*m23sq;
    g1338=m23sq*sw;
    g1487=g1699*m13sq;
    g1719=g1487*sw;
    g1514=g1699*m12sq;
    g1491=g1514*sw;
    g1307=g1643*g1075;
    g1308=g1633*g1075;
    g1312=m13sq*m12sq;
    g1313=g1695*g1666;
    g1315=g1694*g1067;
    g1317=g1712*g1666;
    g1327=g1661*m23sq;
    g1339=g1298*sw;
    g1332=g1708*g1042;
    g1334=g1712*g1702;
    g1340=g1639*m23sq;
    g1341=sw*m13sq;
    g1342=g1695*m13sq;
    g1343=g1639*m13sq;
    g1345=g1631*g1032;
    g1496=g1716*g1hzz;
    g1497=g1717*g1hzz;
    g1352=g1702*g1hzz;
    g1353=g1hzz*m23sq;
    g1354=g1hzz*m13sq;
    g1355=g1677*m23sq;
    g1356=g1677*m13sq;
    g1359=g1635*g978;
    g1365=g1637*g946;
    g1369=g3hzz*m13sq;
    g1370=g1659*g2hzz;
    g1376=sw*m12sq;
    g1377=g1708*g843;
    g1378=g3hzz*m23sq;
    g1406=g1661*g1327;
    g1382=g1695*g771;
    g1407=g1252*g2hzz;
    g1395=g1529*g1019;
    g1420=g1637*g770;
    g1423=g1637*g769;
    g1426=g1312*g843;
    g1436=g1252*g905;
    g1442=g1208*g856;
    g1446=g1208*g833;
    g1447=g1208*g834;
    g1448=g1208*g835;
    g1454=g1039*g1hzz;
    g1462=g1180*m12sq;
    g1483=g1076*sw;
    g1510=g1637*m23sq;
    g1495=g1023*g3hzz;
    g1498=g1022*g1hzz;
    g1512=g1637*m12sq;
    g1517=g912*g1hzz;
    g1519=g905*g1hzz;
    g1530=g1258*g2hzz;
    g1658=g1631*g1115;
    g1683=g1032*g1032;
    g1752=g1317*g1317;
    g1704=g997*g997;
    g1764=g1118*g1118;
    g1793=48.0*g970*m12sq+128.0*g874*g3hzz-(320.0*g873*g3hzz)-(32.0*g971*m12sq);
    g1810=-(18.0*g1666*g1095)-(72.0*g1666*g806);
    g1802=g1810-(72.0*g805)+144.0*g804;
    g1813=64.0*g1674*g979-(224.0*g1637*g979)+328.0*g1699*g979-(240.0*g1677*g979)
     +72.0*g1712*g979;
    g1969=64.0*g1674*g1321-(224.0*g1637*g1321);
    g1840=g1969+36.0*g1024;
    g1864=12.0*g1661*g976+84.0*g1357*g905-(8.0*g1661*g977);
    g1779=g1864-g1840+g1813+g1802+1.5*g1793+84.0*g1441*g905-(72.0*g869);
    g1791=32.0*g1650*g847-(112.0*g1650*g959)+164.0*g1650*g845-(120.0*g1650*g958)
     +36.0*g1650*g841;
    g1801=36.0*g1147-(144.0*g1160*g2hzz)+72.0*g1193*g1032;
    g1970=448.0*g1659*g894-(128.0*g1659*g895);
    g1804=g1970-(576.0*g1727*g833);
    g1819=84.0*g1695*g1058-(64.0*g1674*g1037)-(328.0*g1699*g1037);
    g1839=-(512.0*g1727*g1005)-(2624.0*g1727*g1003)-(576.0*g1727*g1001);
    g1778=g1839-g1819+g1804+g1801+5.0*g1791+g1779-(9.0*g1091)+168.0*g1308-(36.0*
     g1495)-(576.0*g820)+1152.0*g819;
    g1808=656.0*g1659*g1100-(480.0*g1691*g1102)+144.0*g1659*g1101;
    g1784=2.0*g1808-(36.0*g848);
    g1780=g1813+12.0*g1791+g1784-(336.0*g869)-(5248.0*g820)+3840.0*g819+656.0*
     g805-(480.0*g804)+2.0*(g1804-g1810);
    g1884=216.0*(g1040+g859);
    g1901=288.0*g853-(576.0*g852);
    g1781=g1901-(4.0*g1884)+216.0*g1088;
    g2078=72.0*g848;
    g1782=g2078+432.0*g922+216.0*(g857-g923-g921-g1041);
    g1936=8.0*g977-(12.0*g976);
    g1897=g1936+32.0*g930;
    g1815=g1897-(112.0*g928);
    g1854=84.0*g1044-g1815-(9.0*g1092);
    g1908=64.0*g1535*g1368-(224.0*g1387*g1114);
    g1783=g1908+g1854;
    g1785=128.0*g1502*g981+256.0*(-(g1477*g978)-(g1475*g978))+512.0*(g1702*g1138
     -(g1288*g1080)-(g1254*g978)-(g1390*g978)-(g915*m13sq)-(g1288*g1081)-(g915*
     m23sq)-(g1727*g946)+g1702*g1098)-(64.0*g1709*g769)-(1024.0*g1098*m23sq);
    g1847=164.0*g923-(120.0*g922)+36.0*g921;
    g1878=128.0*g917*m13sq-(448.0*g916*m13sq);
    g1863=g1878-(164.0*g933)+120.0*g932;
    g1786=g1863-g1847-(36.0*g931);
    g1787=108.0*g931-(18.0*g1078);
    g1788=4.0*g1969-(144.0*g1038);
    g1842=256.0*g825-(896.0*g824);
    g1789=g1842+1312.0*g823-(960.0*g822);
    g1881=112.0*g809-(32.0*g810);
    g1850=g1881+328.0*g853-(240.0*g852)+72.0*g851;
    g2054=168.0*g1040;
    g1895=g2054+656.0*g859;
    g1790=g1850-(1.5*g1895);
    g2053=72.0*g1053;
    g1792=g2053-(144.0*g806);
    g1794=112.0*g1702*g959-(164.0*g1702*g845)+120.0*g1702*g958-(36.0*g1702*g841)
     -(32.0*g1702*g847);
    g2059=32.0*g1659*g1096;
    g1795=g2059+36.0*g1104;
    g1945=2688.0*g867-(768.0*g868);
    g1796=g1945+3.0*g1789;
    g1834=96.0*g957-(336.0*g956)+492.0*g1008*m13sq-(360.0*g1113*m13sq)+108.0*
     g953;
    g1879=120.0*g1002-(36.0*g1001)-(164.0*g1003);
    g1876=g1879+112.0*g1004;
    g2022=1.33333*g1834;
    g1797=g2022+4.0*g1876;
    g1861=984.0*g835-(720.0*g834)+216.0*g833;
    g1798=g1861-g1834;
    g1865=240.0*g1113*m12sq-(72.0*g965)-(328.0*g1008*m12sq);
    g1833=g1865-(64.0*g1010*m12sq)+224.0*g1009*m12sq;
    g1799=1344.0*g834-(288.0*g833)-(512.0*g1005)-(4.0*g1833)-(2336.0*g835);
    g1822=32.0*g1005-g1876;
    g1800=g1833+g1822;
    g1846=480.0*g943-(144.0*g942)-(656.0*g944);
    g1860=64.0*g1005*m13sq-(224.0*g1004*m13sq)+328.0*g1003*m13sq-(240.0*g1002*
     m13sq)+72.0*g1001*m13sq;
    g1803=6.0*(-g1860-g1846);
    g1883=64.0*g1666*g1280-(160.0*g1666*g1281);
    g1931=2688.0*g894-(768.0*g895);
    g2019=6.0*g1883;
    g1805=g2019+g1931;
    g1806=9.0*(g1093+g1094);
    g2028=2.0*g1794;
    g1807=g2028-(448.0*g1391*g986);
    g2000=-g1783-(36.0*g1712*g1097);
    g1809=g2000-(32.0*g1694*g1120)+80.0*g1639*g1120+36.0*g1143;
    g1811=672.0*g1258*g788-(984.0*g1253*g787)+720.0*g1253*g786-(216.0*g1253*g785
     )-(192.0*g1258*g789);
    g1812=288.0*(g1043+g1040);
    g1867=448.0*g916-(128.0*g917);
    g1943=120.0*g807-(164.0*g808);
    g1875=g1943-(36.0*g806);
    g1814=g1875+1.5*g1867+g1794+432.0*g858;
    g1816=120.0*g786-(36.0*g785)-(164.0*g787);
    g1817=32.0*g987-(84.0*g1070);
    g1836=144.0*g1650*g992-(1.125*g1785);
    g1941=1024.0*(g1138*m13sq+g1138*m23sq)-(512.0*g1727*g1167);
    g1818=1.125*g1941+g1836-(576.0*g1394*g1167);
    g1820=512.0*g1270*g1153-(1792.0*g1398*g1112);
    g1871=128.0*g1276*g1084-(448.0*g1662*g1084);
    g2039=144.0*g775;
    g1821=480.0*g776-g2039-g1871-(656.0*g777);
    g1909=72.0*g1070-(144.0*g856);
    g1823=-(6.0*g1909)-(216.0*g1454)-(432.0*g896);
    g2079=168.0*g1075*m13sq;
    g2080=168.0*g1054;
    g1824=g2080+g2079;
    g1825=288.0*(g1172*g1125+g1467*g3hzz);
    g1826=2.0*(g1908-g1936);
    g1904=360.0*g1113*m23sq-(108.0*g960)-(492.0*g1008*m23sq);
    g1827=g1904-(96.0*g964)+336.0*g1009*m23sq;
    g1910=48.0*g970-(32.0*g971);
    g1828=g1910+g1867;
    g1844=128.0*g1282*g1149-(320.0*g1283*g1149);
    g1920=80.0*g1257*g906-(84.0*g1259*g905)-(32.0*g1257*g907);
    g1852=g1920+36.0*g1022;
    g1829=336.0*g912-(288.0*g878)-(4.0*g1852)-(3.0*g1844);
    g1830=896.0*g1633*g904-(256.0*g964*m12sq);
    g2070=36.0*g841;
    g1880=-g2070-(32.0*g847)-(164.0*g845);
    g1953=32.0*g1661*g1280-(80.0*g1661*g1281);
    g1853=g1953-g1880;
    g1894=240.0*g856-(72.0*g896);
    g1831=g1894+g1853;
    g2058=432.0*g1052;
    g1832=g2058-g1805;
    g1849=448.0*g1650*g1358-(128.0*g1734*g981);
    g1835=g1849-g1789-(656.0*g782)+480.0*g781-(144.0*g780);
    g1907=240.0*g888-(328.0*g889)-(72.0*g887);
    g1837=64.0*g891-(224.0*g890)-g1907;
    g1921=576.0*(-(g1650*g1136)-(g1469*g1137));
    g1841=112.0*(g788*m13sq+g788*m23sq)+32.0*(-(g789*m13sq)-(g789*m23sq));
    g1843=32.0*(-(g1633*g1088)-(g1633*g1090));
    g1845=4.0*g1816+384.0*g929+576.0*g919+288.0*(-g920-g918);
    g1898=480.0*g925-(144.0*g924)-(656.0*g926);
    g2050=18.0*g1088;
    g1848=g2050+g1898;
    g1851=144.0*g925+72.0*(g858-g926-g924);
    g1961=-(112.0*g959)-(120.0*g958);
    g1855=g1961-g1880;
    g2027=2.66667*g1798;
    g1856=-g2027-(2.66667*g1904);
    g1857=2.0*(g1881+g1875);
    g1858=224.0*g1365+240.0*g1677*g946-(72.0*g1712*g946)-(64.0*g1712*g1365);
    g2046=144.0*g1020;
    g1859=g2046+336.0*g878;
    g1862=144.0*(-(g1679*g1201)-(g1468*g1139));
    g1866=120.0*(g1717*g1115+g1716*g1115);
    g1868=-(96.0*g1426)-(1536.0*g994);
    g1869=g1953+g1894+g1817;
    g1870=-g1793-(72.0*g1124);
    g1872=32.0*g789-(112.0*g788);
    g1903=32.0*g1071-(64.0*g1076);
    g1873=128.0*g1659*g1131+32.0*(g1045-g1058)-g1903;
    g1874=128.0*g901-(448.0*g900)+656.0*g899-(480.0*g898)+144.0*g897;
    g1877=1792.0*g1637*g1065-(512.0*g1674*g1065);
    g2021=2.0*g1837;
    g2076=144.0*g790;
    g1882=-g2076-g2021;
    g1891=336.0*g912*m12sq-(144.0*g1666*g1160);
    g1885=g1891-(168.0*g908);
    g2038=288.0*g772;
    g1886=g2038-(36.0*g947)+4032.0*g934-(144.0*g972);
    g2036=960.0*g945;
    g1887=g2036-(1440.0*g1060)-(8832.0*g934)-(576.0*g772)+96.0*g972;
    g1940=112.0*g1009-(32.0*g1010);
    g1889=g1940-(164.0*g1008);
    g1937=320.0*g1708*g1068-(128.0*g1708*g1069);
    g1900=g1937-(336.0*g908);
    g1892=-(32.0*g1677*g972)-(36.0*g972);
    g1899=64.0*g769+128.0*g1035;
    g2071=256.0*g1033;
    g1893=g1899+64.0*g843-g2071;
    g1896=g1844-(256.0*g929*g3hzz)+896.0*g1637*g1152;
    g1902=168.0*g1075-(72.0*g1132);
    g1905=224.0*(g1713*g986+g1709*g986);
    g1906=g2078+36.0*g1078;
    g2037=32.0*g947;
    g1911=g2037+256.0*g772;
    g1912=11520.0*g934+960.0*g772;
    g1914=128.0*g1071-(384.0*g1076);
    g1935=128.0*(-(g1136*m13sq)-(g1136*m23sq));
    g1916=128.0*g1046-(4.0*g1935);
    g2011=g1354+g1353;
    g1934=336.0*g2011;
    g1917=1.28571*g1934-(288.0*g3hzz);
    g1972=72.0*(g1341+g1338);
    g1922=72.0*(g792+g790)-(144.0*g791);
    g2073=144.0*g1036;
    g1923=-g2073-(144.0*g1035);
    g1924=g1851+84.0*g1436+36.0*g1691*g1032;
    g1933=144.0*(g1650*g1195*g1172+g1016);
    g2041=216.0*g1021;
    g1925=g2041-(3.0*g1933);
    g1926=g1852+96.0*g912+216.0*g878;
    g1927=72.0*g1021-(2.0*g1933);
    g1932=480.0*g791-(656.0*g792);
    g1928=g2076-g1932;
    g1930=328.0*g864-g1831;
    g2075=144.0*g770;
    g1938=g2075-(240.0*g1037);
    g2051=36.0*g1088;
    g1939=g2051+36.0*g1090;
    g2047=288.0*g785;
    g1942=g2047+288.0*g787-(576.0*g786);
    g1944=8.0*g1880-(1728.0*g856);
    g2033=108.0*m13sq;
    g1946=g2033+108.0*m23sq;
    g1964=960.0*g999-(288.0*g997);
    g1949=1152.0*g1081-(2304.0*g1065);
    g1950=128.0*g1069-(320.0*g1068);
    g1952=128.0*(-g1311-g1312);
    g1954=320.0*g873-(128.0*g874);
    g1957=144.0*(g1014-g1019);
    g1958=128.0*g1036-g2071;
    g1959=3.0*g1847-(984.0*g857);
    g1960=g1883+336.0*g1049;
    g2044=256.0*g1208;
    g2014=4.74074*g1946;
    g2032=288.0*m12sq;
    g1977=72.0*g1121-(18.0*g1122);
    g1979=36.0*(-(g1713*g1210)-g1140);
    g1984=72.0*g1046-(144.0*g1067);
    g2035=896.0*g945;
    g2065=288.0*g869;
    g2008=g1727*g825-(3.5*g1727*g824);
    g2009=g1674*g934-(3.5*g1637*g934);
    g2010=1.33333*g1144-(2.0*g1464*g1hzz);
    g2012=2.625*g1952;
    g2013=2.66667*g1946;
    g2015=8.0*g1946;
    g2016=1.33333*g1945;
    g2017=6.0*g1908;
    g2018=3.0*g1896;
    g2020=4.0*g1877;
    g2023=1.33333*g1827;
    g2024=3.0*g1824;
    g2025=16.0*g1822;
    g2026=2.0*g1820;
    g2029=2880.0*g846;
    g2030=288.0*g2hzz;
    g2031=54.0*m12sq;
    g2034=36.0*g771;
    g2040=144.0*g1338;
    g2042=72.0*g1208;
    g2043=144.0*g1208;
    g2045=144.0*g1023;
    g2048=144.0*g1051;
    g2049=288.0*g1051;
    g2052=72.0*g1088;
    g2055=288.0*g851;
    g2056=36.0*g1025*g1hzz;
    g2057=168.0*g1364*g1019;
    g2060=288.0*g1038;
    g2061=72.0*g1053*m13sq;
    g2062=432.0*g1206;
    g2063=1792.0*g999*g999;
    g2064=3456.0*g993;
    g2066=144.0*g1143;
    g2067=864.0*g842;
    g2068=448.0*g986;
    g2069=112.0*g992;
    g2072=336.0*g904;
    g2074=72.0*g770;
    g2077=32.0*g848;
    g2081=672.0*g1049;
    g2082=164.0*g1085;
    g2083=48.0*g848;
    g2094=cw*cw*cw;
    g1667=g2094*g2094;
    {
        t0=672.0*(-(g1257*g869)-(g1732*g1309*g1074))+8.0*(g1833*g1702*g1398+
         g1930*g1635*m12sq+g1860*g1352*g2hzz+g1683*g1177*g1177)+6.0*(g1907*g1691
         *g1229-(g1824*g1666*g1633))+4.0*(g1977*g1196+g1896*g1370)+2.0*(g1939*
         g1666*g1272+g1853*g1708*g1208+g1900*g1469+g1891*g1702*g2hzz-(g1793*
         g1185))+1.125*(g1843+g1914*g1650*sw)+(-(112.0*g890)-(120.0*g888))*(2.0*
         g1164*g1164+g1163*g1163)+g1822*(g1352*g1352+4.0*g1351*g1351+16.0*g1702*
         g1407)+g1823*(g1206*g1206+g1205*g1205)+g1923*(g1733-(2.66667*g1734))+(
         1024.0*g978-(256.0*g1062))*(2.875*g1752*g1317+g1650*g1276-(1.125*g1712*
         g1635));
        t0=t0+(1.77778*g1921-(32.0*g1409*g1107*mw)+64.0*g1208*g1045+128.0*g1659*
         g1042+96.0*(-(g1254*g1120)-(g1390*g1120))+256.0*(g1395-(g1633*g1074)))*
         (g1694-(2.5*g1639))+(1536.0*g1080+1024.0*g1081-(256.0*g1151))*(g1731*
         g1731*g1275-(3.5*g1712*g1300))+(-g1900-(4.0*g1891))*(g2hzz*m13sq+g2hzz*
         m23sq)+(g1964-(216.0*g844))*(g1139*m12sq+4.0*g1152)+g1964*(g1155*m13sq+
         g1155*m23sq+g1409)+g1954*(3.0*g1161*m23sq-(g1264*g1hzz)-(2.0*g1264*
         g2hzz)+1.5*(g1661*g1262+g1661*g1263)+4.0*(g1260*g2hzz+g1370*m23sq))+(
         144.0*g1118-(480.0*g1165))*(g769*m13sq+g769*m23sq+2.0*(-(g770*m13sq)-(
         g770*m23sq)));
        t0=t0+g1816*(16.0*g1191*g2hzz+6.0*g1709*g1253+g1642*g1255+g1642*g1256+
         7.0*(g1722*g1254+g1709*g1255)+4.0*(g1602*g1252+g1601*g1252)+32.0*(-(
         g1398*g1312)-(g1398*g1311))+8.0*(g1191*g1hzz+g1369*g1252+g1378*g1252))+
         (128.0*g1193+512.0*(g1192+g1166))*(g891*m12sq-(3.5*g890*m12sq)+5.125*
         g889*m12sq-(3.75*g888*m12sq)+1.125*g887*m12sq)+128.0*(g1205+g1206)*(
         g810*m12sq-(3.5*g809*m12sq)-(7.5*g1708*g856))+g1861*(1.33333*(g1253*
         m13sq+g1253*m23sq)-(5.33333*g1407*m13sq))+36.0*(-g1023-g879)*(3.0*g1254
         *g1hzz+g1497+g1496)+g1820*(2.0*(g1258*m13sq+g1258*m23sq)-(g1702*g1258))
         +g1857*2.0*(g1259*m23sq-(g1642*m12sq));
        t0=t0+(80.0*g906-(32.0*g907))*(4.0*(g1530*m13sq+g1530*m23sq-(g1265*g3hzz
         ))+2.0*(g1260*g1252+g1261*g1hzz-(g1266*g1208)-(g1357*g1208)-(g1643*
         g1hzz)+g1633*g1353+g1406*g1252+g1730*g1hzz-(g1650*g1266))-(g1713*g1357)
         -(g1709*g1357))+(-g1954-(24.0*g875))*(g1260*g1hzz+g1266*m23sq)+g1872*(
         7.0*(-(g1659*g1254)-(g1709*g1260))+4.0*(-(g1729*g1257)-(g1730*m23sq)-(
         g1633*g1259))+6.0*(g1642*g1633-(g1709*g1258))+8.0*(g1261*m12sq-(g1702*
         g1261))-(g1713*g1260)-(g1709*g1406))+(4.0*g1889-(512.0*g787)+192.0*g786
         )*(g1262*g3hzz+g1263*g3hzz)+(256.0*g1292+128.0*g1194)*(g907*m12sq-(2.5*
         g906*m12sq));
        t0=t0+g1952*(7.5*g898*g2hzz-(2.25*g897*g2hzz)-(g1694*g771)+2.5*g1639*
         g771+7.0*(g900*g2hzz-g1420)+2.0*(g1069*g3hzz-(g901*g2hzz)+g1712*g1420)-
         (5.0*g1068*g3hzz)-(10.25*g899*g2hzz))+(g1972+168.0*(-g1342-g1339))*(
         g1014*g1hzz+2.0*g1014*g2hzz)+g1830*4.0*(g1351*g2hzz+g1469*g2hzz)+(
         1008.0*g1252-(144.0*g1352))*(g878*m13sq+g878*m23sq)+(1024.0*g1352-(
         2048.0*g1353))*(g868*g2hzz-(3.5*g867*g2hzz))+(384.0*g1353-(128.0*g1352)
         )*(g1005*g3hzz-(3.5*g1004*g3hzz)+5.125*g1003*g3hzz-(3.75*g1002*g3hzz)+
         1.125*g1001*g3hzz)+(4.57143*g1934-(1536.0*g1352))*(g825*g2hzz-(3.5*g824
         *g2hzz));
        t0=t0+g1934*(39.0476*g944*g2hzz-(28.5714*g943*g2hzz)-(4.0*g1203*g986)+
         11.7143*g835*g3hzz+2.57143*g833*g3hzz-(g1708*g879)-(11.4286*g1393*g1115
         )+8.57143*(g942*g2hzz-(g834*g3hzz)))+(384.0*g834+576.0*g833-(3520.0*
         g835))*(g1369*g2hzz+g1378*g2hzz)+g1837*(8.0*(-(g1529*g1194)-(g1702*
         g1192)-(g1702*g1166))-(g1691*g1259)-(2.0*g1702*g1193))+g1877*(g1708*
         g1633-(5.0*g1643*m12sq))+(g2035+112.0*g947)*(g1511+g1510)+(g1961-g1930)
         *(g1717*m12sq+g1716*m12sq)+g1855*(g1717*m23sq+g1716*m13sq)+(-g2037-(
         256.0*g1034))*(g1712*g1510+g1461)+g1935*(g1491+2.625*g1695*m12sq)+(
         g2038+1968.0*g1060-(1312.0*g1034)+6080.0*g934)*(g1487+g1486)+(216.0*
         g1132-(5.0*g1877))*(g1643*m13sq+g1643*m23sq);
        t0=t0+128.0*(g1015-g1137)*(g1694*g3hzz-(2.5*g1639*g3hzz))+g1883*(4.0*
         g1659*g1208-(g1702*g1260)-(g1264*m23sq)+2.0*(-(g1265*m13sq)-(g1265*
         m23sq)))+(72.0*g3hzz-(504.0*g1252))*(g1713*g879+g1709*g879)+(-(128.0*
         g3hzz)-(64.0*g1252))*(g1694*g1019-(2.5*g1639*g1019))+(256.0*g1311+384.0
         *g1208)*(g1633*g789-(3.5*g1633*g788))+(g2044-(1.5*g1952))*(g1694*g1076-
         (2.5*g1639*g1076))+(g2044-g1952)*(g1712*g1423-(3.5*g1423)+5.125*g1699*
         g769)+g1928*(g1691*g1312-(2.0*g1633*g1255))+g1889*8.0*(g1708*g1391-(
         g1722*g1635))+(g1889+g1816)*(g1497*g1hzz+g1496*g1hzz-(16.0*g1708*g1398)
         )+(g1877+6.0*g1872)*(g1713*g1633+g1709*g1633)+g2011*(g1891-(216.0*g911)
         )+(-g2065-g1793)*(g1328+g1327);
        t0=t0+(64.0*g1058-(128.0*g1045))*(g1694*g1642-(2.5*g1642*g1639))+(288.0*
         g1059-(576.0*g1061))*(3.33333*g1320-(g1712*g1633))+128.0*(g1042+g1076)*
         (g1491*m12sq-(2.5*g1708*g1639))+(g1873-(64.0*g1055))*(g1719*m13sq-(2.5*
         g1713*g1639))+(g1873-(64.0*g1057))*(g1486*g1338-(2.5*g1709*g1639))+(
         3.33333*g1949+5760.0*g1080)*(1.36667*g1300-g1186)+g1783*(g1713*g1702+
         g1709*g1702)+(192.0*(-g1134-g1133)+256.0*(-g1135-g1131))*(g1638*sw-(2.5
         *g1286))+(g1914+192.0*(g1057+g1055))*(2.5*g1283-g1282)+(g1846+1.5*g1835
         )*(g1256+g1255)+g2010*g1946+(g1909+72.0*g864)*(g1123+g1122)+(120.0*
         m12sq-(1.11111*g1946))*(1.36667*g827-g826)+(-g2032-(4.0*g1946))*(g821-(
         4.0*g813))+g2008*(1024.0*m12sq-g2014);
        t0=t0+g2009*(g2014+3072.0*m12sq)+m12sq*(-g2057-(36.0*g973)-(672.0*g1307)
         )+sw*(g1921-(144.0*g1332))+g3hzz*(2.0*g1937+4.0*g1885)+g800*(g2013-(
         144.0*m12sq))+g801*(480.0*m12sq-(5.33333*g1946))+g802*(g2013-(656.0*
         m12sq))+g814*(-(24.8889*g1946)-(3840.0*m12sq))+g815*(5248.0*m12sq-(
         2.96296*g1946))+g846*(720.0*g1139-(112.0*g1680*g846)-(480.0*g1084*g3hzz
         ))+g911*(1344.0*g1529-(336.0*g3hzz))+g972*(g1946+48.0*g1275)+g982*(
         g1825+288.0*g1143)+g988*(-g2032-g2015)+g989*(16.0*g1946+960.0*m12sq)+
         g990*(-g2015-(1312.0*m12sq))+g1025*(-(72.0*g1140)-(48.0*g1651*g1025))+
         g1028*(-g2031-(54.0*m13sq))+g1029*(-g2031-(54.0*m23sq))+g1067*(-g2040-(
         320.0*g1340))+g1077*(72.0*m12sq+36.0*m23sq);
        t0=t0+g1118*(1.125*g1911+3456.0*g934+48.0*g973+g2083*m13sq)+g1121*(144.0
         *(g1519-g1454)-(288.0*g1070))+g1393*g1252*(5248.0*g1170-(3840.0*g1115)-
         (3584.0*g1168))+g1689*g1274*(672.0*g2hzz-(1008.0*g1hzz))+g1154*(g2029-
         g2067)+g1161*(g2018-(432.0*g1016)-(g2072*g1161))+g1163*(g1933-g1896)+
         g1925*g1164+g1165*(g2036-g1912-(32.0*g973)-(112.0*g1165*g843))+g1176*(
         g1977-(18.0*g1123))+g1192*(8.0*g1871+1536.0*g1007+4384.0*g777-(2112.0*
         g776)+288.0*g775)+g1193*(g1871-(192.0*g1007)+368.0*g777+96.0*g776-g2039
         )+g1201*(4.0*g1882-(3648.0*g792)+2304.0*g791)+g1203*(432.0*g1130-g2045-
         g1950)+g1268*g3hzz*(336.0*g905-(144.0*g1039))+g1205*(g1906+4.0*g1840)+
         g1206*(g1788+g1782-(432.0*g1124)+3936.0*g859*m12sq);
        t0=t0+g1845*g1207+g1208*(g2059+4.0*g1804+14.0*g1791+528.0*g1517-(108.0*
         g1079)-(288.0*g1483)-(6400.0*g820)+6144.0*g819+72.0*(g1498+g1208*g841)+
         2.0*(g1811+g1779))+g1267*g1030*(g2030+288.0*g1hzz)+g1633*g1253*(g1932+
         g1882)+g1713*g1229*(1968.0*g864-(1440.0*g856))+g1229*(g1906-(2.0*g1959)
         )+g1252*(-(336.0*g911)-(1008.0*g1208*g879))+g1835*g1253+g1254*(g2053+
         3.0*g1851-(1.5*g1826)+g1807+96.0*g930)+g1258*(g2052+4.0*g1867-(2.33333*
         g1812))+g1259*(2.0*g1970+g1786)+g1260*(g1910+8.0*g1815-g2048)+g1261*(
         g2058-g2026-g2019+672.0*g1054)+g1926*g1262+g1263*(g1926+108.0*g1020-(
         g2033*g879))+g1266*(-g1896-(72.0*g1016))+g1268*(g1792+4.0*(g1943+g1881)
         )+g1274*(1008.0*g1125*m23sq-(14.0*g1979));
        t0=t0+g1712*g1631*(g1949-(288.0*g1151))+g1284*(g2049+48.0*g1650*g1075-
         g2051)+g1666*g1289*(g1812+216.0*g1053+336.0*g1044+448.0*g928-g2066-
         g2052)+g1288*(g2020+g1902+4.0*g1872)+g1289*(g2060+72.0*g1041+144.0*
         g1124-g2061)+g1292*(1920.0*g1292*g1115-(2.0*g1954))+g1708*g1666*(2.0*
         g1895-g1939)+g1298*(g1886-(48.0*g1077))+g1886*g1299+g1311*(g2061+g1787+
         g1780+3.0*(g1839-g1863))+g1312*(g1959+g1780)+g1313*(-(3.75*g1935)-(
         1152.0*g1067))+g1314*(1920.0*g1067-(2.5*g1916))+g1315*(1.18519*g1946+
         128.0*m12sq)+g1702*g1633*(g2081-g1824+g1805-(288.0*g1052))+g1916*g1329+
         g1339*m23sq*(g2034+216.0*g1042)+g1713*g1666*(g2017+g1884)+g1334*(48.0*
         g972+480.0*g1334*g1037)+g1337*(-(2.25*g1935)-(144.0*g1046));
        t0=t0+g1341*(g1984-(144.0*g1015*g1hzz))+2.22222*g1984*g1343+g1722*g1633*
         (g1866+2.0*g1821-(960.0*g1007))+g1352*(g1885-(120.0*g911))+g1355*(g1887
         -(g2069*g1355))+g1887*g1356+g1357*(g1859+g2067*g1179-g1925)+g1352*g1hzz
         *(g1789-g1860)+g1702*g1691*(g1942-(128.0*g929))+g1368*(g1844-g1927)+
         g1369*(g1829+864.0*g1016-(g2068*g1263))+g2017*g1709*g1666+g1376*(g2083*
         g1376-(g2030*g1019))+g1378*(g1829-(g2029*g1179)-g2046-g2041)+g1382*(
         g2042-g2012)+g1529*g986*m12sq*896.0*(g1369+g1378)+g1387*(g2025-g1905-(
         1.5*g1856))+g1390*(g2028+3.0*(g1815-g1908))+g1391*(g1849+1.5*g1830-
         g1803-g1796-(80.0*g782)-(672.0*g781)+432.0*g780+960.0*g1658-(864.0*g980
         ));
        t0=t0+g1394*(1152.0*g1345-(9920.0*g1448)+6528.0*g1447-(1728.0*g1446)-(
         8.0*g1858))+g1398*(8.0*g1842-g1830+768.0*(-g822-g943)+7040.0*(g823+g944
         )+1152.0*(-g980-g942))+g1650*g1394*(1152.0*g965+576.0*(g953+g960)-(80.0
         *g1822))+g1635*g1394*(32.0*g1940-(4096.0*g1008))+g1643*g1394*(12.0*
         g1882+4480.0*g904-(9920.0*g792)+6528.0*g791)+g1708*g1394*(-g2027-g2025-
         (2.66667*g1827))+g1942*g1642*g1391+g1406*(8.0*g1897+g1828-g2048)+g1407*
         (3.33333*g1803+1.33333*g1796)+g1408*(g2025+4.0*g1905+g1856)+g1917*g1635
         *g1039+g1635*g905*(-g1917-(672.0*g1252))+g1972*g1702*g1076+g1699*g770*(
         10.25*g1952-g2043)+g1709*g1312*(3.0*g1953+108.0*g841)+12.0*g1894*g1650*
         g1311+g1702*g878*(576.0*g3hzz-(336.0*g1252));
        t0=t0+g1436*252.0*(g1254+g1390)+g1709*g856*(-g2062-(1440.0*g1229))+g1441
         *(g1874+g1859)+g1712*g1208*(288.0*g769-g2075)+g1677*g1208*(288.0*g770-(
         960.0*g769))+g1826*g1702*g1208-(g1880*g1642*g1208)+g1702*g1030*(g1979+
         144.0*g1198)+g1666*g844*(288.0*g1155+216.0*g1139)+g1468*(3.0*g1954+
         864.0*g875)+g1702*m13sq*(g1870-g1970)+g1475*(g1850+g1814+27.0*g1090-(
         252.0*g1043))+g1650*m13sq*(g1781-(1344.0*g928))+g1477*(1.5*g1848+g1814+
         g1790)+g1708*m13sq*(g1910-g1895+g1848)+g1702*m23sq*(36.0*g1079-g2061-
         g1793)+g1709*sw*(-g2034-(72.0*g1076))+g1713*sw*(1.125*g1903-g2034)+
         g1635*g1hzz*(g1950+288.0*g1023)+g1639*m12sq*(-(2.5*g1935)-(320.0*g1067)
         )+g1633*m12sq*(g2024-g1931-g1820)+g1633*m23sq*(g1832-g2026);
        t0=t0+g1650*m12sq*(4.0*g1790-(1008.0*g1043))+g1642*g3hzz*(g2045+288.0*
         g879)+g1495*(144.0*g1205-g2042)+g1702*g3hzz*(g1927+g1844)+2.33333*g1957
         *g1695*g3hzz+g1502*(16.0*g1816-(656.0*g920)+480.0*g919-(144.0*g918)-
         g1866-g1821)+g1708*m23sq*(g1898+g1828+288.0*g858)+g1529*g2hzz*(g2016-(
         24.0*g1860))+g1512*(g2035-(3.5*g1911))+g1911*g1712*g1512+1.36667*g1912*
         g1514+g1691*m13sq*(g2039+g1845+144.0*g777-(288.0*g776))+g1635*m23sq*(
         g1944+864.0*g896)+g2016*g1727*m23sq+g1635*m13sq*(g1944+864.0*g864)+
         g1650*m23sq*(g2055+g1901)+g1407*m23sq*(40.0*g1879-(5.33333*g1861)-(
         1280.0*g1005))+g1391*g1208*(1344.0*g786-g2047-(2336.0*g787))+g1369*
         g1352*(368.0*g787+96.0*g786-(144.0*g785))+g822*g2hzz*(2304.0*g1352-(
         10.2857*g1934));
        t0=t0+g823*g2hzz*(20.0*g1934-(6144.0*g1352))+g1352*g3hzz*(g2022-g2023)+
         g1015*sw*(-(144.0*g3hzz)-(72.0*g1352))+g1327*g1hzz*(g2018+108.0*g1021)+
         g879*g3hzz*(g2043+g2012)+g771*sw*(1.125*g1952-g2042)+g1263*g2hzz*(g1799
         +4.0*g1797)+g1262*g2hzz*(16.0*g1876-(5.33333*g1827)+g1799)+g1259*m13sq*
         (g2054+2.0*g1857)+3.0*g1831*g1254*m12sq+g1601*(g1874+432.0*g1020)+g1874
         *g1602+g1208*m12sq*(g2028+g1857+656.0*g853)+g1208*g1hzz*(2.0*g1920+
         432.0*g878)+g1205*m13sq*(12.0*g1908-(432.0*g856*m13sq))+g1192*m13sq*(
         4384.0*g792-(2112.0*g791)+288.0*g790)+g1165*m13sq*(-g2077-(360.0*g843))
         +g848*m23sq*(48.0*g1118-(32.0*g1165))+g3hzz*sw*(144.0*g1137-g1957)+
         g1631*(g2020+2.0*g1902+128.0*g1280-(320.0*g1281)-(1312.0*g1277));
        t0=t0+g1633*(g2049+4.0*g1854-(6.0*g1828)+1.16667*g1812-g2066)+g1635*(
         576.0*g807+864.0*(g1043+g1231*g844)+2.0*(g1792-g1807)-g2055-(3.0*g1825)
         -(8.0*g1809)-g1781-(216.0*g1090)-(72.0*g1095)-(288.0*g808))+g1637*(3.5*
         g1868-(3.11111*g1818)-(3584.0*g1359))+g1642*(2.0*g1819+g1791-(144.0*
         g1517)+36.0*g1091-(72.0*g1147)+4.0*(g1802-g1864)-(288.0*g1210*g1025)+
         g2068*g1387)+g1643*(32.0*g1096-(48.0*g1105)+4.0*(g1841+g1820+g1817)-
         g2081-g2024-g1832)+g1650*(g1808+12.0*g1806+g1795-g1788-(2.0*g1782)+
         1728.0*g1442-(864.0*g932)+1008.0*g1308+432.0*(g933+g1207*g1032)+144.0*(
         g1498-g1024)+4.0*(g1801+g1787)-g2061)+g1659*(-g2065-g1878-(4.0*g1870)-(
         144.0*g1079));
        t0=t0+g1661*(g1892-(512.0*g1631*g1153*g1hzz)+1920.0*g1658*g1394)+g1666*(
         72.0*g973+1008.0*g1307-(288.0*g826)+576.0*g988+768.0*(g827-g1315)+216.0
         *(g1211-(g1140*g1030)-g2010)-(36.0*g1077))+g1674*(g1941-g1868-g1785+
         32.0*g1377)+g1666*g1635*(4.0*g1855+1.33333*g1823+144.0*g1176+288.0*
         g1519-(1152.0*g1108)+576.0*(g1196+g1100-g864))+g1677*(g1843+768.0*g1359
         +8064.0*g994+6912.0*g993+3.33333*(-g1862-g1836))+g1030*g1030*(12.0*(-(
         g1180*g1180)-(g1181*g1181))-(24.0*g1651*g1208)-(96.0*g1173)-(48.0*g1179
         *g1179))+g1684*(8.0*g1178*g1178+16.0*g1683*g1208+36.0*g1689*g1157)+
         g1031*g1031*(36.0*g1651+32.0*g1682*g1169)+g1691*(g2023+2.0*g1865-g1797+
         3072.0*g835-(1152.0*g834));
        t0=t0+g1679*g1107*(g2056+36.0*g1030*g3hzz-(72.0*g1666*g1197))+g1695*(
         1.66667*g1921+672.0*g1395+336.0*g1332)+g1699*(4.55556*g1818+164.0*g1377
         +492.0*g1426+960.0*g994+2624.0*g1394*g946-g2064)+g1702*(g2057-(1024.0*
         g2009)-(512.0*g2008)+g1892-(2624.0*g815)+1920.0*g814+1152.0*g801+576.0*
         (-g813-g989-g802-g800-(g1203*g1039))+288.0*(g821+g990+g988+g1154*g844-
         g1144)+18.0*(g1029+g1028)+g2040*g1042)+g1704*(1920.0*g1679+5760.0*g1462
         )+g1185*g1185*(g1841+144.0*(g1052-(g1391*g1032)))+g1708*(g2060+g1806+
         2.0*g1795+4.0*g1791-g1786+g1784-(144.0*g1483)+36.0*g1041+480.0*g1442-(
         328.0*g857)+336.0*g1308)+g1709*(g2061+g1778+108.0*g1125*g1030)+g1206*
         g864*(1312.0*g1708-g2062)+g1711*(g2063+1920.0*g1704+g2056*g1183);
        t0=t0+g1712*(g1862-(1.5*g1843)+g1818-(5184.0*g994)-g2064)+g1713*(g1811+
         g1778+36.0*g1382+108.0*g1124)+g1716*(g1924+g1809)+g1717*(g2000+g1924)+
         g1722*(g1858+1968.0*g1448-(1440.0*g1447)+432.0*g1446)+g1680*g842*(144.0
         *g1191-(240.0*g842))+g1312*g864*(-(328.0*g1312)-(3936.0*g1650))+g1730*(
         g1820+256.0*g987)+g1270*g1270*(432.0*g1178-(1344.0*g904)-(1728.0*g888)+
         864.0*(g889+g887)-g2068)+g1922*g1378*g1378+g1368*g1368*(g2021-(896.0*
         g904))+g1369*g1369*(g1922-g2072)+g1298*g1298*(g1938-(480.0*g1036)+g2082
         *g1298)+g1299*g1299*(g1938-(3.75*g1899)+g2082*g1299)+g1357*g1357*(g1837
         -(896.0*g986))+g1229*g1229*(4.0*g1869-(1312.0*g864))+g1311*g1311*(g2070
         +g1869)+g1356*g1356*(224.0*(-g769-g843)-g2069);
        t0=t0+g1312*g1312*(g1831+g1817)+g1313*g1313*(1312.0*g1037-(9.66667*g1923
         )-(5248.0*g1033))+g1339*g1339*(5.125*g1958-g2074)+g1958*g1340*g1340+
         g1342*g1342*(5.125*g1893-g2074)+g1893*g1343*g1343+g1370*g1370*(5376.0*
         g904-(6400.0*g792)+6144.0*g791-(2304.0*g790)-(24.0*g1837))+g1752*(2.0*
         g1923-(960.0*g1037))+g1338*g1338*(g2073-g2074)+g1341*g1341*(1.125*g1899
         -g2074)+g1266*g1266*(g1928+g1837)+g1353*g1353*(g1800+g1798)+g1354*g1354
         *(g1861+g1827+g1800)+g844*g844*(-(120.0*g1184)-(360.0*g1462))+g1764*(-
         g2077-(120.0*g843))+g1327*g1327*(g1960-g2079)+g1328*g1328*(g1960-g2080)
         +128.0*g1272*g1272*g987+g2063*g1679+1728.0*g1727*g1345-(144.0*g1155*
         g842)+1024.0*g1535*g1393-(328.0*g1364*g1364*g946)+288.0*g1273*g1125;
        msq3=(t0-(64.0*g1719*g1046)-(g2033*g1211)-(g2050*g1729))/(g1667*g1633*(
         48.0*g1764-(96.0*g1661*g1165))+48.0*g1667*g1186);
    };
};

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

  double ee =  _par[4];
  double sw =  _par[5];
  double g1hzz = _par[7];
  double g2hzz = _par[8];
  double g3hzz = _par[9];
  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  double mq = mQ;
  
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mQ + mQ, 2 )) + pow( mQ + mQ, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mQ,2), pow(mQ,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mQ,2) + pow(mQ, 2) + pow(mz,2) - m12sq - m23sq;

  // Matrixelemente //
  double g89,g98,g46,g91,g9,g99,g4,g90,g43,g5,g44,g53,g6,g7,g51,g83,g10,g8,g92,g47,g33,g25,g11,g97,g19,g12,g96,g49,g22,g13,g95,g32, g14,g65,g15,g28,g16,g56,g20,g81,g17,g50,g21,g18,g23,g29,g26,g30,g27,g31,g45,g34,g48,g35,g36,g37,g38,g40,g39,g41,g42,g57,g58,g59,g61,g64,g68,g71,g75,g77,g82,g88,g105,g106,g107,g108,g127,g109,g132,g133,g134,g110,g111,g112,g128, g113,g116,g125,g114,g117,g118,g119,g120,g121,g122,g123,g124,g126,g129,g130,g131,g135,g136,msq1; {
    double t0 = 0;
    g89=mq*mq;
    g98=ee*ee;
    g46=g98*g89;
    g91=mh*mh;
    g9=g91*g46;
    g99=g2hzy*g2hzy;
    g4=g99*g9;
    g90=mz*mz;
    g43=g90*g46;
    g5=g43*m23sq;
    g44=g98*m13sq;
    g53=g91*g90;
    g6=g53*g44;
    g7=g43*m12sq;
    g51=g98*g90;
    g83=g89*g89;
    g10=g83*g51;
    g8=g99*g10;
    g92=g1hzy*g1hzy;
    g47=g98*g92;
    g33=g91*g47;
    g25=g91*g33;
    g11=g90*g25;
    g97=m23sq*m23sq;
    g19=g97*g51;
    g12=g92*g19;
    g96=m13sq*m13sq;
    g49=g96*g90;
    g22=g98*g49;
    g13=g92*g22;
    g95=m12sq*m12sq;
    g32=g95*g47;
    g14=g90*g32;
    g65=g2hzy*g1hzy;
    g15=g65*g51;
    g28=g47*m23sq;
    g16=g28*m12sq;
    g56=g99*m23sq;
    g20=g98*g56;
    g81=g90*g90;
    g17=g81*g20;
    g50=g90*g51;
    g21=g99*g50;
    g18=g21*m13sq;
    g23=g81*g28;
    g29=g81*g47;
    g26=g29*m13sq;
    g30=g97*g47;
    g27=g30*m13sq;
    g31=g96*g47;
    g45=g83*g46;
    g34=g90*g45;
    g48=g90*g50;
    g35=g99*g48;
    g36=g92*g46;
    g37=g30*m23sq;
    g38=g31*m13sq;
    g40=g65*g50;
    g39=g40*m23sq;
    g41=g65*g48;
    g42=g92*g44;
    g57=g97*g15;
    g58=g92*g10;
    g59=g92*g9;
    g61=g89*g6;
    g64=g65*g10;
    g68=g40*m13sq;
    g71=g28*m13sq;
    g75=g15*m23sq;
    g77=g6*m23sq;
    g82=g89*g83;
    g88=g96*g28;
    g105=24.0*(-g26-g23);
    g106=32.0*(g68+g39);
    g107=32.0*(g18+g17);
    g108=16.0*(g13+g12)-(32.0*g41);
    g127=8.0*g25;
    g109=-g127-(8.0*g32)-(24.0*g16);
    g132=16.0*g29;
    g133=32.0*g40;
    g134=32.0*g21;
    g110=g132+16.0*g59-g134-g133;
    g111=2.0*(g31+g30);
    g112=g134-g111;
    g128=8.0*g28;
    g113=-g128-(8.0*g42);
    g116=8.0*m13sq;
    g125=8.0*m23sq;
    g114=g125+g116;
    g117=96.0*m13sq;
    g118=16.0*g6;
    g119=32.0*g7;
    g120=64.0*g5;
    g121=8.0*m12sq;
    g122=14.0*m12sq;
    g123=64.0*m12sq;
    g124=96.0*m12sq;
    g126=32.0*m23sq;
    g129=8.0*g25*m23sq;
    g130=16.0*g16;
    g131=16.0*g75;
    g135=32.0*g90*g48;
    g136=32.0*g20;
    {
        t0=g114*(28.0*g64-g11-g14)+m12sq*(2.0*g38+6.0*g27+16.0*g26-(48.0*g68)-(
         96.0*g18)+g125*g59)+m13sq*(g129+8.0*g88+32.0*(g57+g23))+g8*(g123-(4.0*
         g114))+g12*(-g122-(32.0*m13sq))+g13*(-g126-g122)+g17*(-g124-g117)+g83*
         g33*(-g121-(6.0*g114))+g35*(g124+64.0*m13sq)+g37*(g116+2.0*m12sq)+g39*(
         -g117-(48.0*m12sq))+g41*(g123+8.0*g114)+g96*g89*(-(64.0*g15)-(56.0*g28)
         )+g95*g89*(-g128-(32.0*g15))+g58*(-(19.0*g114)-(56.0*m12sq))+g92*g91*(-
         g119-(104.0*g5))+g90*m13sq*(32.0*g4-(28.0*g16)+g136*m12sq)+g91*m12sq*(
         g131+g112-g132)+g65*(96.0*g61+g118*m12sq-(192.0*g5*m13sq)-g135-(32.0*
         g77))+g91*g65*(96.0*g5-g119)+g92*m12sq*(g118-(16.0*g45)+56.0*g5)+g89*
         m12sq*(6.0*g112-(32.0*g29)+96.0*g40);
        t0=t0+g109*g89*m13sq+g99*m12sq*(16.0*(g22+g19)-g120)+g99*m13sq*(32.0*g19
         -(64.0*g7)-g120)+g92*m13sq*(56.0*g7+144.0*g5)+g59*m13sq*(g121+64.0*
         m23sq)+g81*(g130+g127-(64.0*g4)+48.0*g59-(192.0*g65*g9))+g82*(8.0*g113-
         (192.0*g15)+32.0*g33)+g83*(20.0*g111-g109+112.0*g71+64.0*g29-(288.0*g40
         )+96.0*g21+24.0*g42*m12sq)+g90*g81*(g113+8.0*g33+16.0*g36)+g89*(4.0*
         g108+g107+7.0*g106+2.66667*g105+48.0*g11-(64.0*g57)+16.0*g14-(56.0*g27)
         +32.0*g82*g47-g129)+g90*(64.0*g17+8.0*(-g38-g37)+g126*g4)+g91*(g108+
         g107+g106+g105+8.0*g14+136.0*g58-(160.0*g64)+32.0*(-g8-g35)+16.0*(-g88-
         g27)-(4.0*g16*m13sq))+g92*(40.0*g77-(104.0*g61)+112.0*g34)+g95*(g131+
         g111+4.0*g71+16.0*g15*m13sq-g133);
        msq1=(t0+g96*(g110+6.0*g16+16.0*g30+32.0*g75-(g116*g36))+g97*(g110-(g125
         *g36))+g99*(64.0*g34-g135)-(32.0*g56*g6)+g136*g49+g130*g53)/(3.0*g95*
         g90);
    }
}
double g593,g594,g319,g298,g243,g581,g582,g369,g141,g341,g550,g283,g350,g142,g558,g344,g267,g247,g300,g246,g245,g302,g244,g469,g146,g147,g346,g148,g370,g573,g413,g595,g470,g311,g325,g274,g569,g565,g586,g184,g154,g343,g314,g268,g185,g155,g345,g295,g273,g339,g324,g234,g158,g264,g200,g159,g248,g439,g546,g304,g271,g575,g351,g312,g272,g601,g270,g568,g442,g212,g213,g368,g315,g437,g254,g352,g269,g353,g354,g303,g257,g258,g356,g176,g355,g177,g446,g557,g447,g266,g357,g186,g265,g236,g250,g188,g251,g189,g415,g190,g309,g389,g191,g216,g217,g197,g199,g201,g301,g299,g418,g317,g596,g435,g551,g221,g349,g342,g297,g310,g296,g224,g225,g515,g226,g448,g231,g228,g232,g534,g233,g307,g235,g237,g238,g239,g512,g292,g240,g241,g513,g291,g242,g249,g556,g461,g252,g320,g294,g336,g293,g318,g263,g276,g388,g549,g277,g278,g514,g279,g280,g321,g284,g285,g287,g516,g577,g305,g306,g308,g313,g340,g327,g328,g436,g332,g337,g338,g600,g360,g361,g362,g487,g373,g374,g378,g379,g580,g419,g387,g390,g392,g393,g394,g398,g414,g505,g412,g599,g411,g410,g422,g431,
g438,g445,g451,g458,g460,g475,g477,g587,g489,g491,g493,g508,g507,g504,g499,g562,g667,g630,g757,g642,g652,g639,g612,g636,g645,g754,g661,g673,g728,g614,g662,g623,g611,g637,g621,g613,g631,g748,g752,g615,g628,g644,g616,g618,g730,g625,g657,g684,g649,g685,g619,g620,g751,g638,g646,g651,g750,g622,g624,g668,g744,g626,g627,g723,g629,g632,g704,g633,g734,g634,g745,g635,g749,g654,g640,g705,g641,g722,g724,g725,g643,g647,g648,g655,g650,g653,g656,g658,g659,g660,g663,g664,g677,g670,g665,g666,g699,g669,g759,g760,g671,g672,g731,g682,g674,g675,g681,g732,g676,g678,g679,g680,g701,g686,g687,g689,g700,g693,g695,g697,g698,g702,g740,g736,g735,g738,g717,g719,g721,g726,g727,g729,g733,g737,g739,g741,g742,g743,g746,g747,g753,g755,g756,g758,g761,msq2;
{
    double t0 = 0;
    g593=mz*mz;
    g594=ee*ee;
    g319=g594*g593;
    g298=g319*g1hzy;
    g243=g298*g1hzz;
    g581=mh*mh;
    g582=mq*mq;
    g369=g582*g581;
    g141=g369*g243;
    g341=g594*g2hzy;
    g550=g3hzz*m12sq;
    g283=g550*g341;
    g350=g593*g582;
    g142=g350*g283;
    g558=g593*g593;
    g344=g594*g558;
    g267=g344*g2hzz;
    g247=g267*g2hzy;
    g300=g558*g341;
    g246=g300*g1hzz;
    g245=g298*g3hzz;
    g302=g344*g1hzy;
    g244=g581*g302;
    g469=g582*g244;
    g146=g469*g2hzz;
    g147=g469*g1hzz;
    g346=g582*g369;
    g148=g346*g243;
    g370=g581*g369;
    g573=m23sq*m23sq;
    g413=g573*m13sq;
    g595=m13sq*m13sq;
    g470=g595*m23sq;
    g311=g594*g573;
    g325=g593*m12sq;
    g274=g325*g311;
    g569=sw*sw;
    g565=g569*sw;
    g586=g569*g565;
    g184=g565*g298;
    g154=g582*g184;
    g343=g594*g565;
    g314=g569*g343;
    g268=g314*g1hzy;
    g185=g593*g268;
    g155=g582*g185;
    g345=g581*m12sq;
    g295=g594*g345;
    g273=g593*g295;
    g339=g594*mw*ee;
    g324=g569*g339;
    g234=g324*g2hzy;
    g158=g582*g234;
    g264=g324*g1hzy;
    g200=g581*g264;
    g159=g582*g200;
    g248=g343*g3hzz;
    g439=g248*g2hzy;
    g546=g3hzz*g2hzy;
    g304=g546*g319;
    g271=g565*g341;
    g575=g593*g558;
    g351=g575*g271;
    g312=g575*g341;
    g272=g586*g312;
    g601=g350*g350;
    g270=g558*g314;
    g568=g582*g582;
    g442=g568*g2hzy;
    g212=g565*g246;
    g213=g586*g246;
    g368=g558*g248;
    g315=g582*g3hzz;
    g437=g248*g1hzy;
    g254=g268*g3hzz;
    g352=g575*g1hzy;
    g269=g594*g352;
    g353=g565*g269;
    g354=g575*g268;
    g303=g343*g1hzy;
    g257=g303*g2hzz;
    g258=g268*g2hzz;
    g356=g582*g565;
    g176=g356*g267;
    g355=g569*g356;
    g177=g355*g267;
    g446=g568*g1hzz;
    g557=g582*g568;
    g447=g565*g1hzz;
    g266=g593*g339;
    g357=g582*sw;
    g186=g357*g357*g266;
    g265=g266*g1hzy;
    g236=g582*g265;
    g250=g271*g2hzz;
    g188=g250*m23sq;
    g251=g314*g2hzz*g2hzy;
    g189=g251*m23sq;
    g415=g1hzz*m23sq;
    g190=g415*g271;
    g309=g594*m23sq;
    g389=g586*g2hzy;
    g191=g389*g309*g1hzz;
    g216=g437*m12sq;
    g217=g254*m12sq;
    g197=g357*g298;
    g199=g234*m12sq;
    g201=g558*g283;
    g301=g312*sw;
    g299=g344*g3hzz;
    g418=g594*g1hzy;
    g317=g418*sw;
    g596=m12sq*m12sq;
    g435=g596*g1hzy;
    g551=sw*g1hzy;
    g221=g551*g267;
    g349=g581*g558;
    g342=g593*g349;
    g297=g342*g309;
    g310=g594*m13sq;
    g296=g342*g310;
    g224=g267*m13sq;
    g225=g267*m23sq;
    g515=g1hzz*sw;
    g226=g515*g302;
    g448=g557*sw;
    g231=g243*sw;
    g228=g568*g231;
    g232=g575*g295*g1hzz;
    g534=g2hzy*m12sq;
    g233=g534*g266;
    g307=g558*g339;
    g235=g582*g307;
    g237=g265*m13sq;
    g238=g595*g265;
    g239=g573*g264;
    g512=m12sq*g1hzy;
    g292=g512*g339;
    g240=g595*g292;
    g241=g264*m23sq;
    g513=m13sq*g1hzy;
    g291=g513*g339;
    g242=g582*g291;
    g249=g596*g299;
    g556=g593*g575;
    g461=g556*g1hzz;
    g252=g461*g271;
    g320=g556*g341;
    g294=g320*g1hzz;
    g336=g556*g1hzy;
    g293=g594*g336;
    g318=g596*g339;
    g263=g318*g2hzy;
    g276=sw*m12sq;
    g388=g418*g276;
    g549=g3hzz*g1hzy;
    g277=g549*g309;
    g278=g549*g310;
    g514=m23sq*g1hzy;
    g279=g514*g339;
    g280=g312*g276;
    g321=g595*g1hzy;
    g284=g301*g2hzz;
    g285=g320*g2hzz;
    g287=g301*g1hzz;
    g516=g2hzz*sw;
    g577=g593*g556;
    g305=g577*g341;
    g306=g575*g339;
    g308=g318*g1hzy;
    g313=g575*m12sq;
    g340=g596*g582;
    g327=g593*m23sq;
    g328=g596*m13sq;
    g436=g573*g1hzy;
    g332=g581*m13sq;
    g337=g595*g1hzz;
    g338=m23sq*m12sq;
    g600=g338*g338;
    g360=g593*m13sq;
    g361=g582*m12sq;
    g362=m13sq*m12sq;
    g487=g575*m13sq;
    g373=m23sq*sw;
    g374=m23sq*m13sq;
    g378=g593*g581;
    g379=g581*g565;
    g580=g581*g581;
    g419=g580*g374;
    g387=g224*g2hzy;
    g390=sw*m13sq;
    g392=g581*sw;
    g393=g516*g269;
    g394=g515*g269;
    g398=g2hzy*sw;
    g414=g1hzz*g1hzy;
    g505=g3hzz*m23sq;
    g412=g595*m12sq;
    g599=g573*m23sq;
    g411=g599*g1hzz;
    g410=g337*m13sq;
    g422=g565*g141;
    g431=g362*g264;
    g438=g327*g199;
    g445=g305*g1hzz;
    g451=g573*m12sq;
    g458=g278*g276;
    g460=g581*m23sq;
    g475=g565*g1hzy;
    g477=g231*m23sq;
    g587=g582*g557;
    g489=g565*m12sq;
    g491=g565*m23sq;
    g493=g565*m13sq;
    g508=g2hzz*m13sq;
    g507=g1hzz*m13sq;
    g504=g3hzz*m13sq;
    g499=g2hzz*m23sq;
    g562=g276*g276;
    g667=176.0*g351*g1hzz-(128.0*g272*g1hzz);
    g630=g667-(48.0*g287);
    g757=12.0*g236;
    g642=32.0*g569*g236-g757;
    g652=176.0*g582*g212-(48.0*g357*g246)-(128.0*g582*g213);
    g639=g652+g642;
    g612=g639+g630-(48.0*g393);
    g636=16.0*g596*g254-(22.0*g435*g248);
    g645=32.0*g354*g1hzz-(44.0*g353*g1hzz);
    g754=12.0*g233;
    g661=g754+g636;
    g673=88.0*g582*g216-(24.0*g388*g315)-(64.0*g582*g217);
    g728=2.0*g645;
    g614=g728-(1.5*g673)-g661;
    g662=352.0*g575*g250-(256.0*g575*g251);
    g623=g662-(96.0*g284);
    g611=g623+g614+g612-(3.0*g308)+60.0*g228;
    g637=88.0*g568*g437-(24.0*g568*g317*g3hzz)-(64.0*g568*g254);
    g621=-(3.0*g637)-(32.0*g159);
    g613=g728+2.0*g652+3.0*g642-g621+72.0*g228;
    g631=32.0*g446*g268-(44.0*g446*g303);
    g748=16.0*g241;
    g752=64.0*g158;
    g615=2.0*g631-g752-g748;
    g628=128.0*g582*g354-(176.0*g582*g353)+48.0*g357*g269;
    g644=256.0*g442*g270-(352.0*g601*g271)+96.0*g568*g300*sw;
    g616=g644-g628;
    g618=256.0*g582*g272-(352.0*g582*g351)+96.0*g582*g301;
    g730=2.0*g618;
    g625=96.0*g280-g730;
    g657=176.0*g557*g184-(48.0*g448*g298)-(128.0*g557*g185);
    g684=44.0*g447*g302-(32.0*g558*g268*g1hzz);
    g649=g684-(12.0*g226);
    g685=64.0*g213-(88.0*g212);
    g619=g685+2.5*g649;
    g620=24.0*g569*g240-(9.0*g240);
    g751=32.0*g199;
    g638=12.0*g534*g339-g751;
    g646=16.0*g217-(22.0*g216);
    g651=880.0*g568*g257-(640.0*g568*g258);
    g750=32.0*g200;
    g622=g638-(15.0*g631)+128.0*g158-g750-(1.4*g651)-(6.0*g646);
    g624=6.0*g345*g279-(64.0*g575*g264);
    g668=88.0*g593*g439-(24.0*g304*sw)-(64.0*g586*g304);
    g744=24.0*g221;
    g626=g744+g668+g649;
    g627=g757+g754+g673;
    g723=2.66667*g461*g268-(3.66667*g447*g293)+g515*g293;
    g629=12.0*g723;
    g632=-g646-(3.0*g292);
    g704=-(12.0*g242)-(6.0*g237);
    g633=g637-g704;
    g734=24.0*g369*g245;
    g634=g734-(12.0*g370*g243)-(72.0*g148)-(132.0*g147)+144.0*g146+96.0*(g369*
     g246+g369*g247+g142);
    g745=48.0*g221;
    g635=g745+4.0*g649-(3.0*g646);
    g749=8.0*g200;
    g654=g668-g749;
    g640=2.0*g654-(60.0*g226);
    g705=24.0*(-(g595*g141)-(g573*g141));
    g641=2.66667*g705+128.0*(-(g321*g225)-(g436*g224))+64.0*(-(g435*g224)-(g435*
     g225)-(g201*m13sq)-(g201*m23sq));
    g722=g556*g258-(1.375*g556*g257);
    g724=8.0*(g516*g293+g294*sw);
    g725=g586*g294-(1.375*g252);
    g643=128.0*(-g725-g722)-(6.0*g724);
    g647=12.0*(-g291-g279);
    g648=g632-(6.0*g388*g3hzz);
    g655=18.0*(-(g470*g243)-(g413*g243));
    g650=g734-g655-(24.0*g148)-(72.0*g147)-(48.0*g146);
    g653=-g667-g662;
    g656=128.0*g586*g247-(176.0*g565*g247);
    g658=64.0*g191-(88.0*g190);
    g659=24.0*(-g232-g249);
    g660=12.0*g238*m23sq+36.0*g512*g235+18.0*g338*g237+9.0*g238*m12sq+84.0*(g514
     *g235+g513*g235);
    g663=36.0*(-(g296*g1hzz)-(g297*g1hzz));
    g664=256.0*g189-(352.0*g188);
    g677=128.0*g315*g270-(176.0*g582*g368);
    g670=1.5*g677+72.0*g357*g299;
    g665=-(1.33333*g670)-(48.0*g235);
    g666=32.0*g505*g185-(44.0*g505*g184);
    g699=g748-(6.0*g279);
    g669=-g699-g626;
    g759=64.0*g254;
    g760=32.0*g264;
    g671=g760-g759;
    g672=48.0*(g296*g2hzz+g297*g2hzz);
    g731=48.0*g201;
    g682=g731+48.0*g142;
    g674=1.33333*g655-g682;
    g675=1.5*g647+48.0*g241;
    g681=176.0*g176-(128.0*g177);
    g732=12.0*g307;
    g676=2.0*g681-g732;
    g678=176.0*g257-(128.0*g258);
    g679=g656+g619;
    g680=-g730-g657;
    g701=g672+g663;
    g686=-(7.0*g649)-(96.0*g221);
    g687=g744-(3.0*g649);
    g689=256.0*(m12sq+m13sq);
    g700=64.0*(-g362-g338);
    g693=336.0*g221-(180.0*g226);
    g695=-(12.0*g245)-(24.0*g246);
    g697=g664+2.0*g658;
    g698=g634+192.0*g285+24.0*g201;
    g702=256.0*g251-(352.0*g250);
    g740=96.0*g186;
    g736=24.0*g276;
    g735=24.0*g390;
    g738=24.0*g373;
    g717=g738+g735;
    g719=g649+g648;
    g721=10.6667*g325*g158+14.6667*g352*g248;
    g726=2.0*g666;
    g727=2.0*g649;
    g729=2.0*g638;
    g733=48.0*g247;
    g737=96.0*g276;
    g739=96.0*g373;
    g741=12.0*g277;
    g742=6.0*g265;
    g743=36.0*g265;
    g746=288.0*g221;
    g747=24.0*g263;
    g753=64.0*g557*g264;
    g755=12.0*g237;
    g756=24.0*g239;
    g758=176.0*g439;
    g761=32.0*g234;
    {
        t0=g660+96.0*(g442*g307-(g516*g305))+128.0*(g550*g272+g389*g249)+2.66667
         *(g674*g569*g379+g704*g562-(g660*g569))+(8.0*g264+6.0*g231)*(g362*g362+
         g412*m13sq+g451*m23sq)+g665*(g2hzy*m13sq+g2hzy*m23sq)+(16.0*g586*g274-(
         22.0*g565*g274)+6.0*g274*sw)*(3.0*g549-(4.0*g546)-(g581*g414)-(6.0*g582
         *g414))+g678*(3.0*g575*g374+g313*m12sq+g487*m13sq+g575*g573+6.0*g558*
         g557+1.5*(g313*m13sq+g313*m23sq))+(22.0*g565*g273-(6.0*g273*sw)-(16.0*
         g586*g273))*(g321*g1hzz+4.0*(-(g504*g2hzy)-(g505*g2hzy))+2.0*(g414*g374
         +g504*g1hzy+g505*g1hzy))+(6.0*g631+16.0*g200)*(g325*m13sq+g325*m23sq);
        t0=t0+(44.0*g154-(12.0*g197)-(32.0*g155))*(3.0*g337*m12sq+8.0*g374*g3hzz
         +6.0*g507*g338+g411+g410+2.0*(g328*g1hzz+g596*g3hzz+g595*g3hzz+g573*
         g3hzz+g596*g415))+(64.0*g586*g244-(88.0*g565*g244))*(g338*g2hzz+g362*
         g2hzz-(2.0*g374*g2hzz)+g505+g504)+g700*(3.0*g155*g3hzz-(4.125*g154*
         g3hzz)+1.125*g197*g3hzz+8.0*g177*g2hzy-(11.0*g176*g2hzy))+g695*(2.0*
         g373*g332-(g596*g373))+(2.33333*g670-g740)*(g514+g513)+32.0*(g415+g3hzz
         )*(g328*g185-(1.375*g328*g184))+(7.0*g628+g618-(288.0*g280)-g644)*(g508
         +g499)+(1.5*g644-(1.25*g625)+2.0*(g657-g628))*(g507+g415);
        t0=t0+(16.0*g185-(22.0*g184))*(6.0*g504*g338+8.0*g587*g1hzz+g410*m12sq+
         g411*m12sq+3.0*g412*g3hzz+g596*g337+g600*g1hzz+4.0*(g413*g3hzz+g573*
         g337)+2.0*(g410*m23sq+g411*m13sq+g419*g1hzz))+(g736+48.0*g373)*(g507*
         g269-(3.0*g508*g269)+g595*g246)+g634*(3.66667*(-g493-g491)+2.66667*(
         g569*g493+g569*g491))+g650*(2.66667*g569*g489-(3.66667*g489))+g649*(
         g581*g332+g581*g460-(10.0*g582*g338)-(g596*g581)-(6.0*g370))+(2.66667*
         g701-(64.0*g232))*(g569*g475-(1.375*g475))+g661*4.0*(g582*m13sq+g582*
         m23sq)+g702*(3.0*g556*m12sq+2.0*g556*m13sq-(g581*g556))+12.0*(m13sq+
         m23sq)*(g724-g723-g721+10.6667*g575*g254)+6.0*(-(g594*g321*g3hzz)-(g549
         *g311))*(g596*sw-(g581*g276)+4.0*g558*sw);
        t0=t0+128.0*(g362-g332)*(g558*g191-(1.375*g558*g190)+2.0*g558*g189-(2.75
         *g558*g188))+(256.0*g374-g700)*(g569*g422-(1.375*g422))+(-g736-(48.0*
         g390))*(1.5*g558*g277-(g573*g246))+(g751+5.0*g631)*(g360*m13sq+g593*
         g573)+(g621-(12.0*g263))*(g360+g327)+g655*(12.4444*g355-(17.1111*g356))
         +g722*(g689+256.0*m23sq)+g725*g689+m13sq*(g624+64.0*g438)+sw*(24.0*g337
         *g269-g705-(48.0*g445))+g620*m23sq+g3hzz*(2.0*g616+48.0*g280-g680)+g231
         *(6.0*g600+12.0*g419+48.0*g587)+g276*(g650+96.0*g294+288.0*g285+24.0*
         g141*m23sq)+g293*(g737*g2hzz-(24.0*g3hzz*sw))+g313*(-g758-(3.0*g664)-(
         5.0*g658)-(64.0*g264))+g321*(g676+88.0*g368)+g340*sw*24.0*(g278+g277)+
         g325*(g621-g756)+g328*(g685-g669);
        t0=t0+g332*(g653+g627+g741*g276-g726)+g336*(88.0*g248-(12.0*g339))+g338*
         (g613+36.0*g242)+2.0*g669*g340+g342*(g697-g759)+g345*(g757+g653-g633)+
         g346*(156.0*g226+12.0*(g292-g265)-(240.0*g221))+g582*g573*(g686+18.0*
         g292)+g581*g573*(-g727-g632)+g349*(g651-g647+13.0*g631-g729)+g357*(
         4.66667*g655-g731)+g361*(g760*g361-(48.0*g239))+g362*(g756+2.5*g667+3.0
         *g662+g613)+g615*g325*m12sq+g373*(g698-(32.0*g373*g237))+g374*(4.0*g639
         +2.0*g614-(288.0*g284)+168.0*g228-(144.0*g287)+24.0*g374*g231)+g686*
         g595*g582+g332*m13sq*(g646-g727)+g637*g378+g379*(3.66667*g682-(4.88889*
         g655))+g631*g581*g378+g698*g390+g582*g276*192.0*(-g387-(g225*g2hzy))+
         g392*(g674-(96.0*g285));
        t0=t0+g398*(2.0*(g672-g659)-(1.33333*g663))+g412*(g679+g654)+g413*(g635+
         2.0*(g685+g656))+g582*g374*(-g746-(16.0*g649))+g595*g245*(g738+18.0*
         g276)+g581*g338*(g687-g742)+g435*(g681-g732)+g676*g436+g582*g306*(96.0*
         g2hzy-(48.0*g1hzy))+g581*g1hzy*(1.5*g665-(12.0*g306)+32.0*g186)+g448*(
         192.0*g247-(96.0*g246))+g558*m12sq*(g752+g675-(10.0*g631))+g568*m12sq*(
         g743+2.0*(g675+g640))+g451*(g679+9.0*(g265-g291)-g749)+g622*g558*m23sq+
         g558*m13sq*(6.0*g699+g622)+g581*g2hzz*(g625-g644-(6.0*g628))+g595*g276*
         (g733-(18.0*g277))+g460*(g627-g755)+g568*m23sq*(g743+g693)+g596*m23sq*(
         g742+g626)+g635*g470+g477*12.0*(g328+g413)+g581*g1hzz*(g680-(1.5*g616))
         +g693*g568*m13sq-(3.0*g697*g487);
        t0=t0+g276*g269*(24.0*g415+48.0*g3hzz-(72.0*g499))+g512*(g670-g740)+g269
         *g3hzz*(2.0*g717-(24.0*g392))+g717*g244*g3hzz+g387*m23sq*(g737-(192.0*
         g357))+4.0*g681*g374*g2hzy+g374*g276*(36.0*g245+48.0*g246)+g374*g1hzy*(
         6.0*g681+264.0*g368)+g141*m13sq*(g739+g736)+g361*m13sq*(-(10.0*g649)-(
         96.0*g241))+g534*(128.0*g186-(24.0*g235)-g677)+g338*m13sq*(5.0*g684+
         g640)+g332*m23sq*(2.0*g646-g745-(5.0*g649))+g687*g332*m12sq+g328*sw*(-
         g741-g695)+g327*m13sq*(g750+14.0*g631)+g551*(g701+g659)+g1hzz*m12sq*(
         g657+2.5*g618+g616)+g2hzz*m12sq*(2.0*g644+3.0*g628+6.0*g618)+g556*(2.0*
         g697+g671)+g557*(4.0*(g656-g619)-g746-(8.0*g648)-(24.0*g265));
        t0=t0+g558*(g747+9.0*g637-(4.0*g636)+48.0*g431-(36.0*g458)+32.0*g239+
         192.0*(g159-(g374*g254)))+1.375*g641*g565+g568*(5.0*g630-(3.0*g623)-(
         12.0*g308)-(48.0*g233)+36.0*g237-(432.0*g393)+96.0*(g431+g394)-(108.0*
         g307*g1hzy))+g573*(g755+g611-(18.0*g458)+24.0*g394+g735*g245+g733*g276+
         96.0*g387*sw)+g575*(g750+g729+1.8*g651-(2.0*g647)-(8.0*g632)+4.0*g615)+
         g577*(g678-(48.0*g317*g2hzz)-g702)+g580*(g645+12.0*(g394+g228))+g581*(
         6.0*g721+g643+g629-(32.0*g438)+3.0*g240-(g739*g387))+g582*(4.0*g643+2.0
         *(g629-g624-g620))+g586*(-g641-(128.0*g445))+g593*(g753+176.0*g252+g761
         *g328-(g751*g332))+g595*(g726+g611+96.0*g398*g225)+g596*(g666+g633+g612
         +8.0*g239+24.0*g228+g761*g327);
        msq2=(t0+g595*m13sq*(g719+12.0*g477)+g719*g599+g601*(288.0*g264-(256.0*
         g234))+g325*g325*(g760-g758+g658-(64.0*g234))+g360*g360*(g697+g671)+
         g327*g327*(88.0*g437-g759)-(24.0*g369*g233)+g747*g350-(g753*m12sq))/(cw
         *cw*cw*6.0*(g562*g558-(g569*g313)));
    }
}
double g1661,g1157,g1702,g1715,g981,g1666,g1351,g769,g1709,g1185,g982,g1680,g1231,g1151,g770,g1721,g1269,g1150,g771,g1691,g772,g1659,g1633,g1727,g1166,g978,g1289,g915,g1169,g1714,g1111,g790,g775,g1712,g1695,g1677,g1115,g791,g776,g1639,g1699,g1170,g1109,g792,g777,g1180,g1084,g1694,g1329,g1662,g1276,g1650,g918,g780,g1110,g919,g781,g920,g782,g1637,g1358,g1314,g1734,g1117,g785,g1102,g786,g787,g1168,g1112,g1722,g788,g1116,g789,g1106,g841,g958,g845,g986,g959,g1674,g847,g1172,g1651,g1105,g970,g1682,g1083,g1096,g971,g1101,g806,g800,g1108,g807,g801,g1100,g808,g802,g804,g805,g1114,g809,g1182,g987,g810,g1643,g1174,g1099,g934,g1337,g1733,g813,g822,g814,g1008,g823,g815,g1009,g824,g1010,g825,g1103,g833,g1113,g834,g819,g835,g820,g980,g821,g1097,g1642,g947,g826,g827,g979,g1328,g1161,g844,g842,g843,g1165,g846,g1684,g1176,g1095,g848,g1398,g1153,g1270,g1275,g896,g851,g1368,g856,g852,g1277,g864,g853,g1391,g894,g895,g857,g858,g859,g1203,g1154,g1152,g1126,g929,g1252,g1387,g1535,g1708,g1059,g1321,g956,g867,g957,g868,g875,g869,
g1229,g1031,g1346,g873,g874,g1082,g912,g1281,g1280,g905,g878,g879,g1149,g1283,g1282,g1259,g1159,g906,g1257,g1158,g907,g916,g917,g1208,g887,g888,g889,g890,g1511,g1461,g891,g1311,g904,g964,g1171,g897,g1503,g898,g899,g900,g901,g1179,g1394,g1065,g908,g1068,g1069,g911,g921,g922,g923,g924,g925,g926,g1502,g1297,g1085,g928,g930,g1713,g931,g1107,g1679,g932,g933,g946,g1181,g1081,g1288,g1390,g1254,g1080,g1475,g1477,g1001,g942,g1002,g943,g1003,g944,g1635,g945,g949,g1004,g1005,g953,g960,g1118,g1032,g965,g1092,g972,g1641,g1173,g1104,g973,g976,g977,g988,g1007,g989,g990,g1184,g992,g1175,g1098,g993,g994,g1309,g1732,g997,g1731,g999,g1716,g1717,g1030,g1273,g1160,g1264,g1014,g1177,g1148,g1272,g1284,g1015,g1467,g1016,g1132,g1053,g1195,g1260,g1019,g1025,g1020,g1271,g1130,g1021,g1023,g1022,g1039,g1441,g1024,g1094,g1028,g1093,g1029,g1357,g1408,g1033,g1155,g1061,g1034,g1062,g1036,g1037,g1194,g1038,g1070,g1040,g1210,g1140,g1041,g1125,g1198,g1042,g1043,g1044,g1120,g1045,g1202,g1071,g1046,g1689,g1465,g1136,g1529,g1049,g1131,g1074,g1051,
g1052,g1075,g1054,g1133,g1055,g1134,g1057,g1135,g1058,g1060,g1183,g1711,g1139,g1468,g1201,g1138,g1067,g1267,g1137,g1469,g1076,g1090,g1077,g1078,g1079,g1088,g1091,g1167,g1121,g1122,g1123,g1143,g1124,g1631,g1393,g1274,g1464,g1144,g1147,g1163,g1164,g1178,g1320,g1645,g1186,g1409,g1193,g1292,g1192,g1191,g1197,g1196,g1268,g1205,g1206,g1207,g1263,g1211,g1364,g1265,g1266,g1730,g1253,g1262,g1258,g1255,g1261,g1729,g1256,g1601,g1602,g1286,g1638,g1300,g1298,g1299,g1486,g1338,g1487,g1719,g1514,g1491,g1307,g1308,g1312,g1313,g1315,g1317,g1327,g1339,g1332,g1334,g1340,g1341,g1342,g1343,g1345,g1496,g1497,g1352,g1353,g1354,g1355,g1356,g1359,g1365,g1369,g1370,g1376,g1377,g1378,g1406,g1382,g1407,g1395,g1420,g1423,g1426,g1436,g1442,g1446,g1447,g1448,g1454,g1462,g1483,g1510,g1495,g1498,g1512,g1517,g1519,g1530,g1658,g1683,g1752,g1704,g1764,g1793,g1810,g1802,g1813,g1973,g1840,g1864,g1779,g1791,g1801,g1974,g1804,g1818,g1839,g1778,g1808,g1784,g1780,g1884,g1902,g1781,g2082,g1782,g1938,g1898,g1815,g1856,g1910,g1783,g1785,g1847,g1878,
g1863,g1786,g1787,g1788,g1842,g1789,g1881,g1850,g2058,g1895,g1790,g2057,g1792,g1794,g2063,g1795,g1939,g1796,g1879,g1869,g1949,g2018,g1797,g1862,g1798,g1865,g1833,g1799,g1822,g1800,g1846,g1852,g1803,g1883,g1933,g2022,g1805,g1806,g2030,g1807,g2003,g1809,g1811,g1812,g1867,g1947,g1876,g1814,g1816,g1817,g1819,g1836,g1945,g1820,g1872,g2042,g1821,g1911,g1823,g2084,g2085,g1824,g1825,g1826,g1940,g1827,g1912,g1828,g1844,g1922,g1853,g1829,g1830,g2074,g1880,g1957,g1855,g1894,g1831,g2062,g1832,g1849,g1835,g1909,g1837,g1923,g1841,g1843,g1845,g1899,g2054,g1848,g1851,g1854,g1965,g1857,g2029,g1858,g1859,g1860,g2050,g1861,g1866,g1868,g1870,g1871,g1873,g2037,g1904,g1874,g1875,g1877,g2024,g2081,g1882,g1891,g1885,g2040,g2041,g1886,g2038,g1887,g1944,g1889,g1941,g1901,g1892,g2078,g1900,g2075,g1893,g1896,g1903,g1906,g1907,g1908,g1913,g1914,g1916,g1937,g1918,g2013,g1936,g1919,g1975,g1924,g2077,g1925,g1926,g1935,g2045,g1927,g1928,g1929,g1934,g1930,g1932,g2080,g1942,g2055,g1943,g2051,g1946,g1948,g2035,g1950,g1968,g1953,g1954,g1956,
g1958,g1961,g1962,g1963,g1964,g2017,g2034,g1980,g1982,g1987,g2039,g2043,g2069,g2010,g2011,g2012,g2014,g2015,g2016,g2019,g2020,g2021,g2023,g2025,g2026,g2027,g2028,g2031,g2032,g2033,g2036,g2044,g2046,g2047,g2048,g2049,g2052,g2053,g2056,g2059,g2060,g2061,g2064,g2065,g2066,g2067,g2068,g2070,g2071,g2072,g2073,g2076,g2079,g2083,g2086,g2087,g2088,g2099,g1667,msq3;
{
    double t0 = 0;
    g1661=mz*mz;
    g1157=g1661*ee;
    g1702=mh*mh;
    g1715=g1157*g1157;
    g981=g1715*g1702;
    g1666=mq*mq;
    g1351=g1666*g1hzz;
    g769=g1351*g981*g1hzz;
    g1709=m23sq*m23sq;
    g1185=g1702*g1661;
    g982=g1666*g1185;
    g1680=ee*ee;
    g1231=g1680*g3hzz;
    g1151=g1231*g1hzz;
    g770=g1151*g982;
    g1721=g1680*ee;
    g1269=g1721*mw;
    g1150=g1269*g1hzz;
    g771=g1150*g982;
    g1691=g3hzz*g3hzz;
    g772=g1691*g1680*g982;
    g1659=g1661*g1661;
    g1633=g1661*g1659;
    g1727=g2hzz*g2hzz;
    g1166=g1727*g1633;
    g978=g1680*g1166;
    g1289=g1702*g1666;
    g915=g1289*g978;
    g1169=sw*ee;
    g1714=g1169*g1169;
    g1111=g1714*g1702;
    g790=g1666*g1111;
    g775=g790*m23sq;
    g1712=sw*sw;
    g1695=g1712*sw;
    g1677=g1695*sw;
    g1115=g1680*g1677;
    g791=g1289*g1115;
    g776=g791*m23sq;
    g1639=g1677*sw;
    g1699=g1639*sw;
    g1170=g1699*g1680;
    g1109=g1702*g1170;
    g792=g1666*g1109;
    g777=g792*m23sq;
    g1180=g1680*m23sq;
    g1084=g1702*g1180;
    g1694=g1699*sw;
    g1329=g1694*g1666;
    g1662=g1329*sw;
    g1276=g1712*g1662;
    g1650=g1666*g1666;
    g918=g1650*g1111;
    g780=g1659*g918;
    g1110=g1650*g1115;
    g919=g1702*g1110;
    g781=g1659*g919;
    g920=g1650*g1109;
    g782=g1659*g920;
    g1637=g1712*g1699;
    g1358=g1637*g981;
    g1314=g1666*g1639;
    g1734=g1314*g1314;
    g1117=g1715*g1666;
    g785=g1712*g1117;
    g1102=g1659*g1115;
    g786=g1666*g1102;
    g787=g1699*g1117;
    g1168=g1680*g1637;
    g1112=g1666*g1168;
    g1722=g1hzz*g1hzz;
    g788=g1722*g1112;
    g1116=g1722*g1680;
    g789=g1276*g1116;
    g1106=g1659*g1116;
    g841=g1712*g1106;
    g958=g1722*g1102;
    g845=g1699*g1106;
    g986=g1715*g1637;
    g959=g1722*g986;
    g1674=g1712*g1637;
    g847=g1674*g1106;
    g1172=sw*mw;
    g1651=g1721*ee;
    g1105=g1651*g1172*g1172;
    g970=g1666*g1105;
    g1682=g1714*g1169;
    g1083=g1682*mw;
    g1096=g1169*g1083*mw;
    g971=g1666*g1096;
    g1101=g1714*g1691;
    g806=g1661*g1101;
    g800=g1650*g806;
    g1108=g1691*g1115;
    g807=g1661*g1108;
    g801=g1650*g807;
    g1100=g1691*g1170;
    g808=g1661*g1100;
    g802=g1650*g808;
    g804=g1666*g807;
    g805=g1666*g808;
    g1114=g1661*g1168;
    g809=g1691*g1114;
    g1182=g1712*g1168;
    g987=g1691*g1182;
    g810=g1661*g987;
    g1643=g1661*g1633;
    g1174=g1680*g1643;
    g1099=g1727*g1174;
    g934=g1666*g1099;
    g1337=g1666*sw;
    g1733=g1337*g1337;
    g813=g1733*g978;
    g822=g1633*g1110;
    g814=g1727*g822;
    g1008=g1633*g1170;
    g823=g1650*g1008;
    g815=g1727*g823;
    g1009=g1633*g1168;
    g824=g1650*g1009;
    g1010=g1633*g1182;
    g825=g1650*g1010;
    g1103=g1714*g1633;
    g833=g1666*g1103;
    g1113=g1633*g1115;
    g834=g1666*g1113;
    g819=g1727*g834;
    g835=g1666*g1008;
    g820=g1727*g835;
    g980=g1650*g1103;
    g821=g1722*g980;
    g1097=g1633*g1116;
    g1642=g1702*g1702;
    g947=g1642*g1097;
    g826=g1677*g947;
    g827=g1699*g947;
    g979=g1702*g1097;
    g1328=g1661*m13sq;
    g1161=g1328*g1hzz;
    g844=g1712*g1161;
    g842=g844*m23sq;
    g843=g1709*g1106;
    g1165=g1677*m12sq;
    g846=g1165*g1161;
    g1684=mw*mw;
    g1176=g1684*g1651;
    g1095=g1661*g1176;
    g848=g1702*g1095;
    g1398=g3hzz*g2hzz;
    g1153=g1182*g2hzz;
    g1270=g1666*g3hzz;
    g1275=g1712*g1661;
    g896=g1275*g1151;
    g851=g1702*g896;
    g1368=g1661*g3hzz;
    g856=g1368*g1115*g1hzz;
    g852=g1702*g856;
    g1277=g1699*g1151;
    g864=g1661*g1277;
    g853=g1702*g864;
    g1391=g3hzz*g1hzz;
    g894=g1391*g1112;
    g895=g1276*g1151;
    g857=g1709*g864;
    g858=g1666*g896;
    g859=g864*m23sq;
    g1203=g1650*g3hzz;
    g1154=g1680*g1203;
    g1152=g1154*m12sq;
    g1126=g1182*m12sq;
    g929=g1650*g1126;
    g1252=g1hzz*m12sq;
    g1387=g1252*g3hzz;
    g1535=g1126*g1hzz;
    g1708=m12sq*m12sq;
    g1059=g1708*g1151;
    g1321=g1661*g1059;
    g956=g1009*m13sq;
    g867=g1666*g956;
    g957=g1010*m13sq;
    g868=g1666*g957;
    g875=g1289*g1083;
    g869=g875*g3hzz;
    g1229=g1666*m12sq;
    g1031=g1229*mw;
    g1346=g1721*g1031;
    g873=g1639*g1346;
    g874=g1694*g1346;
    g1082=g1659*g1083;
    g912=g1666*g1082;
    g1281=g1639*g1150;
    g1280=g1694*g1150;
    g905=g1661*g1083;
    g878=g1650*g905;
    g879=g1666*g905;
    g1149=g1269*m12sq;
    g1283=g1650*g1639;
    g1282=g1666*g1329;
    g1259=g1702*m12sq;
    g1159=g1639*g1269;
    g906=g1702*g1159;
    g1257=g1661*m12sq;
    g1158=g1694*g1269;
    g907=g1702*g1158;
    g916=g1691*g1112;
    g917=g1666*g987;
    g1208=m23sq*m13sq;
    g887=g1714*g1208;
    g888=g1208*g1115;
    g889=g1208*g1170;
    g890=g1208*g1168;
    g1511=g1637*m13sq;
    g1461=g1712*g1511;
    g891=g1461*g1180;
    g1311=m23sq*m12sq;
    g904=g1311*g1168;
    g964=g1010*m23sq;
    g1171=g1712*g3hzz;
    g897=g1171*g981;
    g1503=g981*g3hzz;
    g898=g1677*g1503;
    g899=g1699*g1503;
    g900=g1358*g3hzz;
    g901=g1674*g1503;
    g1179=g1680*g1666;
    g1394=g2hzz*g1hzz;
    g1065=g1394*g1179;
    g908=g1708*g1082;
    g1068=g1659*g1159;
    g1069=g1659*g1158;
    g911=g1650*g1082;
    g921=g1709*g1101;
    g922=g1709*g1108;
    g923=g1709*g1100;
    g924=g1666*g1101;
    g925=g1666*g1108;
    g926=g1666*g1100;
    g1502=g1691*m12sq;
    g1297=g1680*m12sq;
    g1085=g1691*g1297;
    g928=g1637*g1085;
    g930=g987*m12sq;
    g1713=m13sq*m13sq;
    g931=g1713*g1101;
    g1107=m13sq*ee;
    g1679=g1107*g1107;
    g932=g1679*g1171*g1171;
    g933=g1713*g1100;
    g946=g1643*g1084;
    g1181=g1680*m13sq;
    g1081=g1727*g1181;
    g1288=g1702*g1643;
    g1390=g1709*m13sq;
    g1254=g1713*m23sq;
    g1080=g1727*g1297;
    g1475=g1709*m12sq;
    g1477=g1713*m12sq;
    g1001=g1714*g1643;
    g942=g1666*g1001;
    g1002=g1643*g1115;
    g943=g1666*g1002;
    g1003=g1643*g1170;
    g944=g1666*g1003;
    g1635=g1666*g1650;
    g945=g1635*g1106;
    g949=g1002*m13sq;
    g1004=g1643*g1168;
    g1005=g1674*g1174;
    g953=g1103*m13sq;
    g960=g1103*m23sq;
    g1118=g1712*m12sq;
    g1032=g1680*g1118;
    g965=g1633*g1032;
    g1092=g1176*m12sq;
    g972=g1650*g1092;
    g1641=g1721*g1661;
    g1173=g1641*g1157;
    g1104=g1684*g1173;
    g973=g1702*g1104;
    g976=g1712*g1092;
    g977=g1677*g1092;
    g988=g1635*g1101;
    g1007=g1635*g1115;
    g989=g1691*g1007;
    g990=g1635*g1100;
    g1184=g1708*g1680;
    g992=g1691*g1184;
    g1175=g1661*g1174;
    g1098=g1727*g1175;
    g993=g1666*g1098;
    g994=g1650*g1099;
    g1309=g1661*sw;
    g1732=g1309*g1309;
    g997=g1732*g2hzz;
    g1731=g1275*g1275;
    g999=g1731*g2hzz;
    g1716=g1709*m23sq;
    g1717=g1713*m13sq;
    g1030=g1172*m12sq;
    g1273=g1659*g1030;
    g1160=g1721*g1273;
    g1264=g1661*g1185;
    g1014=g1264*g1149;
    g1177=m23sq*mw;
    g1148=g1721*g1177;
    g1272=g1666*g1661;
    g1284=g1661*g1272;
    g1015=g1284*g1148;
    g1467=g1148*sw;
    g1016=g1650*g1467;
    g1132=g1150*sw;
    g1053=g1659*g1132;
    g1195=g1721*m13sq;
    g1260=g1661*g1328;
    g1019=g1260*g1148;
    g1025=g1272*g1172;
    g1020=g1195*g1025;
    g1271=g1721*g1172;
    g1130=g1713*g1271;
    g1021=g1666*g1130;
    g1023=g1641*g1030;
    g1022=g1702*g1023;
    g1039=g1661*g1271;
    g1441=g1708*g1hzz;
    g1024=g1441*g1039;
    g1094=g1709*g1176;
    g1028=g1666*g1094;
    g1093=g1713*g1176;
    g1029=g1666*g1093;
    g1357=g3hzz*m12sq;
    g1408=g1357*g2hzz;
    g1033=g1715*g1408;
    g1155=g1184*g3hzz;
    g1061=g1155*g2hzz;
    g1034=g1659*g1061;
    g1062=g1659*g1151;
    g1036=g1062*m13sq;
    g1037=g1062*m12sq;
    g1194=g1659*g3hzz;
    g1038=g1271*g1194;
    g1070=g1083*g3hzz;
    g1040=g1070*m23sq;
    g1210=g1721*g3hzz;
    g1140=g1709*g1210;
    g1041=g1172*g1140;
    g1125=g1195*g3hzz;
    g1198=g1666*g1125;
    g1042=g1198*mw;
    g1043=g1070*m13sq;
    g1044=g1070*m12sq;
    g1120=g1149*g3hzz;
    g1045=g1661*g1120;
    g1202=g1708*g1269;
    g1071=g1202*g3hzz;
    g1046=g1071*m23sq;
    g1689=g1715*g1157;
    g1465=g1689*mw;
    g1136=g1465*g2hzz;
    g1529=g2hzz*m12sq;
    g1049=g1529*g1083;
    g1131=g1149*g2hzz;
    g1074=g1202*g2hzz;
    g1051=g1074*sw;
    g1052=g1666*g1132;
    g1075=g1083*g1hzz;
    g1054=g1075*m23sq;
    g1133=g1148*g1hzz;
    g1055=g1659*g1133;
    g1134=g1150*m13sq;
    g1057=g1659*g1134;
    g1135=g1149*g1hzz;
    g1058=g1659*g1135;
    g1060=g1650*g1085;
    g1183=m23sq*ee;
    g1711=g1183*g1183;
    g1139=g1711*g3hzz;
    g1468=g1633*g1hzz;
    g1201=g1633*g1391;
    g1138=g1394*g1175;
    g1067=g1465*g3hzz;
    g1267=g1174*ee;
    g1137=g1267*mw;
    g1469=g1666*g2hzz;
    g1076=g1633*g1150;
    g1090=g1176*m13sq;
    g1077=g1659*g1090;
    g1078=g1702*g1090;
    g1079=g1666*g1092;
    g1088=g1176*m23sq;
    g1091=g1661*g1092;
    g1167=g1661*g1175;
    g1121=g1702*g1635;
    g1122=g1716*g1666;
    g1123=g1717*g1666;
    g1143=g1210*g1030;
    g1124=g1143*m23sq;
    g1631=g1661*g1643;
    g1393=g1631*g2hzz;
    g1274=g1695*g1031;
    g1464=g1689*g1030;
    g1144=g1464*g2hzz;
    g1147=g1160*g1hzz;
    g1163=g1185*g1hzz;
    g1164=g1661*g1252;
    g1178=g1032*m13sq;
    g1320=g1677*g1633;
    g1645=g1661*g1320;
    g1186=g1661*g1645;
    g1409=g1679*g1357;
    g1193=g1194*g1hzz;
    g1292=g1633*g2hzz;
    g1192=g1292*g1hzz;
    g1191=g1259*g3hzz;
    g1197=g1172*g3hzz;
    g1196=g1721*g1197;
    g1268=g1708*g1702;
    g1205=g1666*m23sq;
    g1206=g1666*m13sq;
    g1207=g1691*m23sq;
    g1263=g1709*g1hzz;
    g1211=g1263*g1023;
    g1364=g1695*g1hzz;
    g1265=g1708*g1661;
    g1266=g1659*g1hzz;
    g1730=g1257*g1257;
    g1253=g1722*m12sq;
    g1262=g1713*g1hzz;
    g1258=g1659*m12sq;
    g1255=g1722*m13sq;
    g1261=g1633*m13sq;
    g1729=g1257*m13sq;
    g1256=g1722*m23sq;
    g1601=g1252*m23sq;
    g1602=g1252*m13sq;
    g1286=g1645*sw;
    g1638=g1286*sw;
    g1300=g1661*g1638;
    g1298=g1712*m23sq;
    g1299=g1712*m13sq;
    g1486=g1699*m23sq;
    g1338=m23sq*sw;
    g1487=g1699*m13sq;
    g1719=g1487*sw;
    g1514=g1699*m12sq;
    g1491=g1514*sw;
    g1307=g1643*g1075;
    g1308=g1633*g1075;
    g1312=m13sq*m12sq;
    g1313=g1695*g1666;
    g1315=g1694*g1067;
    g1317=g1712*g1666;
    g1327=g1661*m23sq;
    g1339=g1298*sw;
    g1332=g1708*g1042;
    g1334=g1712*g1702;
    g1340=g1639*m23sq;
    g1341=sw*m13sq;
    g1342=g1695*m13sq;
    g1343=g1639*m13sq;
    g1345=g1631*g1032;
    g1496=g1716*g1hzz;
    g1497=g1717*g1hzz;
    g1352=g1702*g1hzz;
    g1353=g1hzz*m23sq;
    g1354=g1hzz*m13sq;
    g1355=g1677*m23sq;
    g1356=g1677*m13sq;
    g1359=g1635*g978;
    g1365=g1637*g946;
    g1369=g3hzz*m13sq;
    g1370=g1659*g2hzz;
    g1376=sw*m12sq;
    g1377=g1708*g843;
    g1378=g3hzz*m23sq;
    g1406=g1661*g1327;
    g1382=g1695*g771;
    g1407=g1252*g2hzz;
    g1395=g1529*g1019;
    g1420=g1637*g770;
    g1423=g1637*g769;
    g1426=g1312*g843;
    g1436=g1252*g905;
    g1442=g1208*g856;
    g1446=g1208*g833;
    g1447=g1208*g834;
    g1448=g1208*g835;
    g1454=g1039*g1hzz;
    g1462=g1180*m12sq;
    g1483=g1076*sw;
    g1510=g1637*m23sq;
    g1495=g1023*g3hzz;
    g1498=g1022*g1hzz;
    g1512=g1637*m12sq;
    g1517=g912*g1hzz;
    g1519=g905*g1hzz;
    g1530=g1258*g2hzz;
    g1658=g1631*g1115;
    g1683=g1032*g1032;
    g1752=g1317*g1317;
    g1704=g997*g997;
    g1764=g1118*g1118;
    g1793=96.0*g970*m12sq+512.0*g874*g3hzz-(896.0*g873*g3hzz)-(128.0*g971*m12sq)
     ;
    g1810=-(18.0*g1666*g1095)-(72.0*g1666*g806);
    g1802=g1810-(72.0*g805)+144.0*g804;
    g1813=256.0*g1674*g979-(704.0*g1637*g979)+712.0*g1699*g979-(336.0*g1677*g979
     )+72.0*g1712*g979;
    g1973=256.0*g1674*g1321-(704.0*g1637*g1321);
    g1840=g1973+36.0*g1024;
    g1864=24.0*g1661*g976+132.0*g1357*g905-(32.0*g1661*g977);
    g1779=g1864-g1840+g1813+g1802+1.5*g1793+132.0*g1441*g905-(72.0*g869);
    g1791=128.0*g1650*g847-(352.0*g1650*g959)+356.0*g1650*g845-(168.0*g1650*g958
     )+36.0*g1650*g841;
    g1801=36.0*g1147-(144.0*g1160*g2hzz)+72.0*g1193*g1032;
    g1974=1408.0*g1659*g894-(512.0*g1659*g895);
    g1804=g1974-(576.0*g1727*g833);
    g1818=132.0*g1695*g1058-(256.0*g1674*g1037)-(712.0*g1699*g1037);
    g1839=-(2048.0*g1727*g1005)-(5696.0*g1727*g1003)-(576.0*g1727*g1001);
    g1778=g1839-g1818+g1804+g1801+5.0*g1791+g1779-(9.0*g1091)+264.0*g1308-(36.0*
     g1495)-(576.0*g820)+1152.0*g819;
    g1808=1424.0*g1659*g1100-(672.0*g1691*g1102)+144.0*g1659*g1101;
    g1784=2.0*g1808-(36.0*g848);
    g1780=g1813+12.0*g1791+g1784-(528.0*g869)-(11392.0*g820)+5376.0*g819+1424.0*
     g805-(672.0*g804)+2.0*(g1804-g1810);
    g1884=216.0*(g1040+g859);
    g1902=288.0*g853-(576.0*g852);
    g1781=g1902-(4.0*g1884)+216.0*g1088;
    g2082=72.0*g848;
    g1782=g2082+432.0*g922+216.0*(g857-g923-g921-g1041);
    g1938=32.0*g977-(24.0*g976);
    g1898=g1938+128.0*g930;
    g1815=g1898-(352.0*g928);
    g1856=132.0*g1044-g1815-(9.0*g1092);
    g1910=256.0*g1535*g1368-(704.0*g1387*g1114);
    g1783=g1910+g1856;
    g1785=144.0*g1502*g981+288.0*(-(g1477*g978)-(g1475*g978))+576.0*(g1702*g1138
     -(g1288*g1080)-(g1254*g978)-(g1390*g978)-(g915*m13sq)-(g1288*g1081)-(g915*
     m23sq)-(g1727*g946)+g1702*g1098)-(72.0*g1709*g769)-(1152.0*g1098*m23sq);
    g1847=356.0*g923-(168.0*g922)+36.0*g921;
    g1878=512.0*g917*m13sq-(1408.0*g916*m13sq);
    g1863=g1878-(356.0*g933)+168.0*g932;
    g1786=g1863-g1847-(36.0*g931);
    g1787=108.0*g931-(18.0*g1078);
    g1788=4.0*g1973-(144.0*g1038);
    g1842=1024.0*g825-(2816.0*g824);
    g1789=g1842+2848.0*g823-(1344.0*g822);
    g1881=352.0*g809-(128.0*g810);
    g1850=g1881+712.0*g853-(336.0*g852)+72.0*g851;
    g2058=264.0*g1040;
    g1895=g2058+1424.0*g859;
    g1790=g1850-(1.5*g1895);
    g2057=72.0*g1053;
    g1792=g2057-(144.0*g806);
    g1794=352.0*g1702*g959-(356.0*g1702*g845)+168.0*g1702*g958-(36.0*g1702*g841)
     -(128.0*g1702*g847);
    g2063=128.0*g1659*g1096;
    g1795=g2063+36.0*g1104;
    g1939=8448.0*g867-(3072.0*g868);
    g1796=g1939+3.0*g1789;
    g1879=168.0*g1002-(36.0*g1001)-(356.0*g1003);
    g1869=g1879+352.0*g1004;
    g1949=-(1056.0*g956-(1068.0*g1008*m13sq)-(108.0*g953)-(384.0*g957))-(504.0*
     g1113*m13sq);
    g2018=1.33333*g1949;
    g1797=g2018+4.0*g1869;
    g1862=2136.0*g835-(1008.0*g834)+216.0*g833;
    g1798=g1862-g1949;
    g1865=336.0*g1113*m12sq-(72.0*g965)-(712.0*g1008*m12sq);
    g1833=g1865-(256.0*g1010*m12sq)+704.0*g1009*m12sq;
    g1799=2112.0*g834-(288.0*g833)-(2048.0*g1005)-(4.0*g1833)-(5408.0*g835);
    g1822=128.0*g1005-g1869;
    g1800=g1833+g1822;
    g1846=-(1424.0*g944)-(144.0*g942);
    g1852=256.0*g1005*m13sq-(704.0*g1004*m13sq)+712.0*g1003*m13sq+72.0*g1001*
     m13sq;
    g1803=2016.0*g949+6.0*(-g1852-g1846)-(4032.0*g943);
    g1883=256.0*g1666*g1280-(448.0*g1666*g1281);
    g1933=8448.0*g894-(3072.0*g895);
    g2022=6.0*g1883;
    g1805=g2022+g1933;
    g1806=9.0*(g1093+g1094);
    g2030=2.0*g1794;
    g1807=g2030-(1408.0*g1391*g986);
    g2003=-g1783-(36.0*g1712*g1097);
    g1809=g2003-(128.0*g1694*g1120)+224.0*g1639*g1120+36.0*g1143;
    g1811=2112.0*g1258*g788-(2136.0*g1253*g787)+1008.0*g1253*g786-(216.0*g1253*
     g785)-(768.0*g1258*g789);
    g1812=288.0*(g1043+g1040);
    g1867=1408.0*g916-(512.0*g917);
    g1947=168.0*g807-(356.0*g808);
    g1876=g1947-(36.0*g806);
    g1814=g1876+1.5*g1867+g1794+432.0*g858;
    g1816=168.0*g786-(36.0*g785)-(356.0*g787);
    g1817=128.0*g987-(132.0*g1070);
    g1819=2048.0*g1270*g1153-(5632.0*g1398*g1112);
    g1836=144.0*g1650*g992-g1785;
    g1945=1152.0*(g1138*m13sq+g1138*m23sq)-(576.0*g1727*g1167);
    g1820=g1945+g1836-(576.0*g1394*g1167);
    g1872=512.0*g1276*g1084-(1408.0*g1662*g1084);
    g2042=144.0*g775;
    g1821=672.0*g776-g2042-g1872-(1424.0*g777);
    g1911=72.0*g1070-(144.0*g856);
    g1823=-(6.0*g1911)-(216.0*g1454)-(432.0*g896);
    g2084=264.0*g1075*m13sq;
    g2085=264.0*g1054;
    g1824=g2085+g2084;
    g1825=288.0*(g1172*g1125+g1467*g3hzz);
    g1826=2.0*(g1910-g1938);
    g1940=-(1068.0*g1008*m23sq)-(108.0*g960)+504.0*g1113*m23sq;
    g1827=g1940-(384.0*g964)+1056.0*g1009*m23sq;
    g1912=96.0*g970-(128.0*g971);
    g1828=g1912+g1867;
    g1844=512.0*g1282*g1149-(896.0*g1283*g1149);
    g1922=224.0*g1257*g906-(132.0*g1259*g905)-(128.0*g1257*g907);
    g1853=g1922+36.0*g1022;
    g1829=528.0*g912-(288.0*g878)-(4.0*g1853)-(3.0*g1844);
    g1830=2816.0*g1633*g904-(1024.0*g964*m12sq);
    g2074=36.0*g841;
    g1880=-g2074-(128.0*g847)-(356.0*g845);
    g1957=128.0*g1661*g1280-(224.0*g1661*g1281);
    g1855=g1957-g1880;
    g1894=336.0*g856-(72.0*g896);
    g1831=g1894+g1855;
    g2062=432.0*g1052;
    g1832=g2062-g1805;
    g1849=1408.0*g1650*g1358-(512.0*g1734*g981);
    g1835=g1849-g1789-(1424.0*g782)+672.0*g781-(144.0*g780);
    g1909=336.0*g888-(712.0*g889)-(72.0*g887);
    g1837=256.0*g891-(704.0*g890)-g1909;
    g1923=576.0*(-(g1650*g1136)-(g1469*g1137));
    g1841=352.0*(g788*m13sq+g788*m23sq)+128.0*(-(g789*m13sq)-(g789*m23sq));
    g1843=36.0*(-(g1633*g1088)-(g1633*g1090));
    g1845=4.0*g1816+1536.0*g929+576.0*g919+288.0*(-g920-g918);
    g1899=672.0*g925-(144.0*g924)-(1424.0*g926);
    g2054=18.0*g1088;
    g1848=g2054+g1899;
    g1851=144.0*g925+72.0*(g858-g926-g924);
    g1854=144.0*(-(g1679*g1201)-(g1468*g1139));
    g1965=-(352.0*g959)-(168.0*g958);
    g1857=g1965-g1880;
    g2029=2.66667*g1798;
    g1858=-g2029-(2.66667*g1940);
    g1859=2.0*(g1881+g1876);
    g1860=704.0*g1365+336.0*g1677*g946-(72.0*g1712*g946)-(256.0*g1712*g1365);
    g2050=144.0*g1020;
    g1861=g2050+528.0*g878;
    g1866=168.0*(g1717*g1115+g1716*g1115);
    g1868=-(384.0*g1426)-(6144.0*g994);
    g1870=g1957+g1894+g1817;
    g1871=-g1793-(72.0*g1124);
    g1873=128.0*g789-(352.0*g788);
    g2037=72.0*g1076;
    g1904=36.0*g1071-g2037;
    g1874=512.0*g1659*g1131+128.0*(g1045-g1058)-(3.55556*g1904);
    g1875=512.0*g901-(1408.0*g900)+1424.0*g899-(672.0*g898)+144.0*g897;
    g1877=5632.0*g1637*g1065-(2048.0*g1674*g1065);
    g2024=2.0*g1837;
    g2081=144.0*g790;
    g1882=-g2081-g2024;
    g1891=528.0*g912*m12sq-(144.0*g1666*g1160);
    g1885=g1891-(264.0*g908);
    g2040=36.0*g947;
    g2041=288.0*g772;
    g1886=g2041-g2040+4032.0*g934-(288.0*g972);
    g2038=1344.0*g945;
    g1887=g2038-(2016.0*g1060)-(9600.0*g934)-(576.0*g772)+384.0*g972;
    g1944=352.0*g1009-(128.0*g1010);
    g1889=g1944-(356.0*g1008);
    g1941=896.0*g1708*g1068-(512.0*g1708*g1069);
    g1901=g1941-(528.0*g908);
    g1892=-(128.0*g1677*g972)-(36.0*g972);
    g2078=144.0*g1062*m23sq;
    g1900=g2078+72.0*g769;
    g2075=1024.0*g1033;
    g1893=3.55556*g1900+256.0*g843-g2075;
    g1896=g1844-(1024.0*g929*g3hzz)+2816.0*g1637*g1152;
    g1903=264.0*g1075-(72.0*g1132);
    g1906=704.0*(g1713*g986+g1709*g986);
    g1907=g1852-(336.0*g949);
    g1908=g2082+36.0*g1078;
    g1913=g2041+g2040;
    g1914=16128.0*g934+1344.0*g772;
    g1916=144.0*g1071-(432.0*g1076);
    g1937=288.0*(-(g1136*m13sq)-(g1136*m23sq));
    g1918=512.0*g1046-(7.11111*g1937);
    g2013=g1354+g1353;
    g1936=432.0*g2013;
    g1919=g1936-(288.0*g3hzz);
    g1975=72.0*(g1341+g1338);
    g1924=72.0*(g792+g790)-(144.0*g791);
    g2077=144.0*g1036;
    g1925=-g2078-g2077;
    g1926=g1851+132.0*g1436+36.0*g1691*g1032;
    g1935=144.0*(g1650*g1195*g1172+g1016);
    g2045=216.0*g1021;
    g1927=g2045-(3.0*g1935);
    g1928=g1853+192.0*g912+216.0*g878;
    g1929=72.0*g1021-(2.0*g1935);
    g1934=672.0*g791-(1424.0*g792);
    g1930=g2081-g1934;
    g1932=712.0*g864-g1831;
    g2080=144.0*g770;
    g1942=g2080-(336.0*g1037);
    g2055=36.0*g1088;
    g1943=g2055+36.0*g1090;
    g2051=288.0*g785;
    g1946=g2051+288.0*g787-(576.0*g786);
    g1948=8.0*g1880-(1728.0*g856);
    g2035=108.0*m13sq;
    g1950=g2035+108.0*m23sq;
    g1968=1344.0*g999-(288.0*g997);
    g1953=1152.0*g1081-(2304.0*g1065);
    g1954=512.0*g1069-(896.0*g1068);
    g1956=144.0*(-g1311-g1312);
    g1958=896.0*g873-(512.0*g874);
    g1961=144.0*(g1014-g1019);
    g1962=512.0*g1036-g2075;
    g1963=3.0*g1847-(2136.0*g857);
    g1964=g1883+528.0*g1049;
    g2017=18.963*g1950;
    g2034=288.0*m12sq;
    g1980=72.0*g1121-(18.0*g1122);
    g1982=36.0*(-(g1713*g1210)-g1140);
    g1987=72.0*g1046-(144.0*g1067);
    g2039=2816.0*g945;
    g2043=144.0*g1352;
    g2069=288.0*g869;
    g2010=g1727*g825-(2.75*g1727*g824);
    g2011=g1674*g934-(2.75*g1637*g934);
    g2012=1.33333*g1144-(2.0*g1464*g1hzz);
    g2014=3.66667*g1956;
    g2015=2.66667*g1950;
    g2016=8.0*g1950;
    g2019=1.33333*g1939;
    g2020=6.0*g1910;
    g2021=3.0*g1896;
    g2023=4.0*g1877;
    g2025=1.33333*g1827;
    g2026=3.0*g1824;
    g2027=16.0*g1822;
    g2028=2.0*g1819;
    g2031=4032.0*g846;
    g2032=288.0*g2hzz;
    g2033=54.0*m12sq;
    g2036=36.0*g771;
    g2044=144.0*g1338;
    g2046=72.0*g1208;
    g2047=144.0*g1208;
    g2048=1024.0*g1208;
    g2049=144.0*g1023;
    g2052=144.0*g1051;
    g2053=288.0*g1051;
    g2056=72.0*g1088;
    g2059=288.0*g851;
    g2060=36.0*g1025*g1hzz;
    g2061=264.0*g1364*g1019;
    g2064=288.0*g1038;
    g2065=72.0*g1053*m13sq;
    g2066=432.0*g1206;
    g2067=5632.0*g999*g999;
    g2068=3456.0*g993;
    g2070=144.0*g1143;
    g2071=864.0*g842;
    g2072=1408.0*g986;
    g2073=352.0*g992;
    g2076=1056.0*g904;
    g2079=72.0*g770;
    g2083=128.0*g848;
    g2086=1056.0*g1049;
    g2087=356.0*g1085;
    g2088=96.0*g848;
    g2099=cw*cw*cw;
    g1667=g2099*g2099;
    {
        t0=g1843+1056.0*(-(g1257*g869)-(g1732*g1309*g1074))+8.0*(g1833*g1702*
         g1398+g1932*g1635*m12sq+g1907*g1352*g2hzz)+6.0*(g1909*g1691*g1229-(
         g1824*g1666*g1633))+4.0*(g1980*g1196+g1896*g1370)+2.0*(g1943*g1666*
         g1272+g1855*g1708*g1208+g1901*g1469+g1891*g1702*g2hzz-(g1793*g1185))+(-
         (352.0*g890)-(168.0*g888))*(2.0*g1164*g1164+g1163*g1163)+g1822*(g1352*
         g1352+4.0*g1351*g1351+16.0*g1702*g1407)+g1823*(g1206*g1206+g1205*g1205)
         +g1925*(g1733-(10.6667*g1734))+(1152.0*g978-(288.0*g1062))*(7.88889*
         g1752*g1317+3.55556*g1650*g1276-(g1712*g1635))+(7.11111*g1923-(128.0*
         g1409*g1107*mw)+256.0*g1208*g1045+512.0*g1659*g1042+384.0*(-(g1254*
         g1120)-(g1390*g1120))+1024.0*(g1395-(g1633*g1074)))*(g1694-(1.75*g1639)
         );
        t0=t0+(6144.0*g1080+4096.0*g1081-(1024.0*g1151))*(g1731*g1731*g1275-(
         2.75*g1712*g1300))+(-g1901-(4.0*g1891))*(g2hzz*m13sq+g2hzz*m23sq)+(
         g1968-(216.0*g844))*(g1139*m12sq+4.0*g1152)+g1968*(g1155*m13sq+g1155*
         m23sq+g1409)+g1958*(3.0*g1161*m23sq-(g1264*g1hzz)-(2.0*g1264*g2hzz)+1.5
         *(g1661*g1262+g1661*g1263)+4.0*(g1260*g2hzz+g1370*m23sq))+(144.0*g1118-
         (672.0*g1165))*(g769*m13sq+g769*m23sq+2.0*(-(g770*m13sq)-(g770*m23sq)))
         +g1816*(16.0*g1191*g2hzz+6.0*g1709*g1253+g1642*g1255+g1642*g1256+7.0*(
         g1722*g1254+g1709*g1255)+4.0*(g1602*g1252+g1601*g1252)+32.0*(-(g1398*
         g1312)-(g1398*g1311))+8.0*(g1191*g1hzz+g1369*g1252+g1378*g1252));
        t0=t0+(144.0*g1193+576.0*(g1192+g1166))*(3.55556*g891*m12sq-(9.77778*
         g890*m12sq)+9.88889*g889*m12sq-(4.66667*g888*m12sq)+g887*m12sq)+512.0*(
         g1205+g1206)*(g810*m12sq-(2.75*g809*m12sq)-(2.625*g1708*g856))+g1862*(
         1.33333*(g1253*m13sq+g1253*m23sq)-(5.33333*g1407*m13sq))+36.0*(-g1023-
         g879)*(3.0*g1254*g1hzz+g1497+g1496)+g1819*(2.0*(g1258*m13sq+g1258*m23sq
         )-(g1702*g1258))+g1859*2.0*(g1259*m23sq-(g1642*m12sq))+(224.0*g906-(
         128.0*g907))*(4.0*(g1530*m13sq+g1530*m23sq-(g1265*g3hzz))+2.0*(g1260*
         g1252+g1261*g1hzz-(g1266*g1208)-(g1357*g1208)-(g1643*g1hzz)+g1633*g1353
         +g1406*g1252+g1730*g1hzz-(g1650*g1266))-(g1713*g1357)-(g1709*g1357))+(-
         g1958-(120.0*g875))*(g1260*g1hzz+g1266*m23sq);
        t0=t0+g1873*(7.0*(-(g1659*g1254)-(g1709*g1260))+4.0*(-(g1729*g1257)-(
         g1730*m23sq)-(g1633*g1259))+6.0*(g1642*g1633-(g1709*g1258))+8.0*(g1261*
         m12sq-(g1702*g1261))-(g1713*g1260)-(g1709*g1406))+(4.0*g1889-(1280.0*
         g787)+384.0*g786)*(g1262*g3hzz+g1263*g3hzz)+(1024.0*g1292+512.0*g1194)*
         (g907*m12sq-(1.75*g906*m12sq))+g1956*(9.33333*g898*g2hzz-(2.0*g897*
         g2hzz)-(3.55556*g1694*g771)+6.22222*g1639*g771+19.5556*(g900*g2hzz-
         g1420)+7.11111*(g1069*g3hzz-(g901*g2hzz)+g1712*g1420)-(12.4444*g1068*
         g3hzz)-(19.7778*g899*g2hzz))+(g1975+264.0*(-g1342-g1339))*(g1014*g1hzz+
         2.0*g1014*g2hzz)+g1830*4.0*(g1351*g2hzz+g1469*g2hzz)+(1584.0*g1252-
         g2043)*(g878*m13sq+g878*m23sq);
        t0=t0+(4096.0*g1352-(8192.0*g1353))*(g868*g2hzz-(2.75*g867*g2hzz))+(
         432.0*g1353-g2043)*(3.55556*g1005*g3hzz-(9.77778*g1004*g3hzz)+9.88889*
         g1003*g3hzz-(4.66667*g1002*g3hzz)+g1001*g3hzz)+g1936*(65.9259*g944*
         g2hzz-(31.1111*g943*g2hzz)+6.66667*g942*g2hzz-(9.77778*g1203*g986)+
         19.7778*g835*g3hzz-(9.33333*g834*g3hzz)+2.0*g833*g3hzz-(1.22222*g1708*
         g879)-(12.4444*g1393*g1115))+(1920.0*g834+576.0*g833-(9664.0*g835))*(
         g1369*g2hzz+g1378*g2hzz)+g1837*(8.0*(-(g1529*g1194)-(g1702*g1192)-(
         g1702*g1166))-(g1691*g1259)-(2.0*g1702*g1193))+g1877*(g1708*g1633-(5.0*
         g1643*m12sq))+(g2039+352.0*g947)*(g1511+g1510)+(g1965-g1932)*(g1717*
         m12sq+g1716*m12sq)+g1857*(g1717*m23sq+g1716*m13sq);
        t0=t0+(-(1024.0*g1034)-(128.0*g947))*(g1712*g1510+g1461)+g1937*(1.77778*
         g1491+1.83333*g1695*m12sq)+(g2041+4272.0*g1060-(2848.0*g1034)+9152.0*
         g934)*(g1487+g1486)+(216.0*g1132-(5.0*g1877))*(g1643*m13sq+g1643*m23sq)
         +512.0*(g1015-g1137)*(g1694*g3hzz-(1.75*g1639*g3hzz))+g1883*(4.0*g1659*
         g1208-(g1702*g1260)-(g1264*m23sq)+2.0*(-(g1265*m13sq)-(g1265*m23sq)))+(
         72.0*g3hzz-(792.0*g1252))*(g1713*g879+g1709*g879)+(-(512.0*g3hzz)-(
         256.0*g1252))*(g1694*g1019-(1.75*g1639*g1019))+(1024.0*g1311+1536.0*
         g1208)*(g1633*g789-(2.75*g1633*g788))+(9.77778*g1956-(2816.0*g1208))*(
         g1423-(1.01136*g1699*g769))+g1930*(g1691*g1312-(2.0*g1633*g1255))+g1889
         *8.0*(g1708*g1391-(g1722*g1635));
        t0=t0+(g1889+g1816)*(g1497*g1hzz+g1496*g1hzz-(16.0*g1708*g1398))+(g1877+
         6.0*g1873)*(g1713*g1633+g1709*g1633)+g2013*(g1891-(504.0*g911))+(-g2069
         -g1793)*(g1328+g1327)+(256.0*g1058-(512.0*g1045))*(g1694*g1642-(1.75*
         g1642*g1639))+(288.0*g1059-(576.0*g1061))*(4.66667*g1320-(g1712*g1633))
         +512.0*(g1042+g1076)*(g1491*m12sq-(1.75*g1708*g1639))+(g1874-(256.0*
         g1055))*(g1719*m13sq-(1.75*g1713*g1639))+(g1874-(256.0*g1057))*(g1486*
         g1338-(1.75*g1709*g1639))+(4.66667*g1953+8064.0*g1080)*(2.11905*g1300-
         g1186)+g1783*(g1713*g1702+g1709*g1702)+(768.0*(-g1134-g1133)+1024.0*(-
         g1135-g1131))*(g1638*sw-(1.75*g1286))+(3.55556*g1916+768.0*(g1057+g1055
         ))*(1.75*g1283-g1282);
        t0=t0+(g1846+1.5*g1835+672.0*g943)*(g1256+g1255)+g2012*g1950+(g1911+72.0
         *g864)*(g1123+g1122)+(168.0*m12sq-(1.55556*g1950))*(2.11905*g827-g826)+
         (-g2034-(4.0*g1950))*(g821-(4.0*g813))+g2010*(4096.0*m12sq-g2017)+g2011
         *(g2017+12288.0*m12sq)+m12sq*(-g2061-(36.0*g973)-(1056.0*g1307))+sw*(
         g1923-(144.0*g1332))+g3hzz*(2.0*g1941+4.0*g1885)+g800*(g2015-(144.0*
         m12sq))+g801*(672.0*m12sq-(5.33333*g1950))+g802*(g2015-(1424.0*m12sq))+
         g814*(-(17.7778*g1950)-(5376.0*m12sq))+g815*(11392.0*m12sq-(31.4074*
         g1950))+g846*(1008.0*g1139-(352.0*g1680*g846)-(672.0*g1084*g3hzz))+g911
         *(2112.0*g1529-(528.0*g3hzz))+g972*(g1950+96.0*g1275)+g982*(g1825+288.0
         *g1143)+g988*(-g2034-g2016);
        t0=t0+g989*(16.0*g1950+1344.0*m12sq)+g990*(-g2016-(2848.0*m12sq))+g1025*
         (-(72.0*g1140)-(96.0*g1651*g1025))+g1028*(-g2033-(54.0*m13sq))+g1029*(-
         g2033-(54.0*m23sq))+g1067*(-g2044-(896.0*g1340))+g1077*(72.0*m12sq+36.0
         *m23sq)+g1118*(g1913+3456.0*g934+96.0*g973+g2088*m13sq)+g1121*(144.0*(
         g1519-g1454)-(288.0*g1070))+g1393*g1252*(11392.0*g1170-(5376.0*g1115)-(
         11264.0*g1168))+g1689*g1274*(1056.0*g2hzz-(1584.0*g1hzz))+g1154*(g2031-
         g2071)+g1161*(g2021-(432.0*g1016)-(g2076*g1161))+g1163*(g1935-g1896)+
         g1927*g1164+g1165*(g2038-g1914-(128.0*g973)-(352.0*g1165*g843))+g1176*(
         g1980-(18.0*g1123))+g1192*(8.0*g1872+3072.0*g1007+10528.0*g777-(3648.0*
         g776)+288.0*g775);
        t0=t0+g1193*(g1872+192.0*g1007+1136.0*g777-(96.0*g776)-g2042)+g1201*(4.0
         *g1882-(8256.0*g792)+3456.0*g791)+g1203*(432.0*g1130-g2049-g1954)+g1268
         *g3hzz*(528.0*g905-(144.0*g1039))+g1205*(g1908+4.0*g1840)+g1206*(g1788+
         g1782-(432.0*g1124)+8544.0*g859*m12sq)+g1845*g1207+g1208*(g2063+4.0*
         g1804+14.0*g1791+912.0*g1517-(108.0*g1079)-(288.0*g1483)-(12544.0*g820)
         +7680.0*g819+72.0*(g1498+g1208*g841)+2.0*(g1811+g1779))+g1267*g1030*(
         g2032+288.0*g1hzz)+g1633*g1253*(g1934+g1882)+g1713*g1229*(4272.0*g864-(
         2016.0*g856))+g1229*(g1908-(2.0*g1963))+g1252*(-(528.0*g911)-(1584.0*
         g1208*g879))+g1835*g1253+g1254*(g2057+3.0*g1851-(1.5*g1826)+g1807+384.0
         *g930)+g1258*(g2056+4.0*g1867-(3.66667*g1812));
        t0=t0+g1259*(2.0*g1974+g1786)+g1260*(g1912+8.0*g1815-g2052)+g1261*(g2062
         -g2028-g2022+1056.0*g1054)+g1928*g1262+g1263*(g1928+108.0*g1020-(g2035*
         g879))+g1266*(-g1896-(72.0*g1016))+g1268*(g1792+4.0*(g1947+g1881))+
         g1274*(1584.0*g1125*m23sq-(22.0*g1982))+g1712*g1631*(g1953-(288.0*g1151
         ))+g1284*(g2053+240.0*g1650*g1075-g2055)+g1666*g1289*(g1812+216.0*g1053
         +528.0*g1044+1408.0*g928-g2070-g2056)+g1288*(g2023+g1903+4.0*g1873)+
         g1289*(g2064+72.0*g1041+144.0*g1124-g2065)+g1292*(2688.0*g1292*g1115-(
         2.0*g1958))+g1708*g1666*(2.0*g1895-g1943)+g1298*(g1886-(96.0*g1077))+
         g1886*g1299+g1311*(g2065+g1787+g1780+3.0*(g1839-g1863))+g1312*(g1963+
         g1780)+g1313*(-(4.33333*g1937)-(2304.0*g1067));
        t0=t0+g1314*(5376.0*g1067-(1.75*g1918))+g1315*(4.74074*g1950+512.0*m12sq
         )+g1702*g1633*(g2086-g1824+g1805-(288.0*g1052))+g1918*g1329+g1339*m23sq
         *(g2036+216.0*g1042)+g1713*g1666*(g2020+g1884)+g1334*(96.0*g972+672.0*
         g1334*g1037)+g1337*(-g1937-(144.0*g1046))+g1341*(g1987-(144.0*g1015*
         g1hzz))+6.22222*g1987*g1343+g1722*g1633*(g1866+2.0*g1821-(1344.0*g1007)
         )+g1352*(g1885-(24.0*g911))+g1355*(g1887-(g2073*g1355))+g1887*g1356+
         g1357*(g1861+g2071*g1179-g1927)+g1352*g1hzz*(g1789-g1907)+g1702*g1691*(
         g1946-(512.0*g929))+g1368*(g1844-g1929)+g1369*(g1829+864.0*g1016-(g2072
         *g1263))+g2020*g1709*g1666+g1376*(g2088*g1376-(g2032*g1019))+g1378*(
         g1829-(g2031*g1179)-g2050-g2045)+g1382*(g2046-g2014);
        t0=t0+g1529*g986*m12sq*2816.0*(g1369+g1378)+g1387*(g2027-g1906-(1.5*
         g1858))+g1390*(g2030+3.0*(g1815-g1910))+g1391*(g1849+1.5*g1830-g1803-
         g1796-(848.0*g782)-(480.0*g781)+432.0*g780+1344.0*g1658-(864.0*g980))+
         g1394*(1152.0*g1345-(22208.0*g1448)+9600.0*g1447-(1728.0*g1446)-(8.0*
         g1860))+g1398*(8.0*g1842-g1830+3840.0*(-g822-g943)+19328.0*(g823+g944)+
         1152.0*(-g980-g942))+g1650*g1394*(1152.0*g965+576.0*(g953+g960)-(80.0*
         g1822))+g1635*g1394*(32.0*g1944-(10240.0*g1008))+g1643*g1394*(12.0*
         g1882+14080.0*g904-(22208.0*g792)+9600.0*g791)+g1708*g1394*(-g2029-
         g2027-(2.66667*g1827))+g1946*g1642*g1391+g1406*(8.0*g1898+g1828-g2052)+
         g1407*(3.33333*g1803+1.33333*g1796)+g1408*(g2027+4.0*g1906+g1858);
        t0=t0+g1919*g1635*g1039+g1635*g905*(-g1919-(1056.0*g1252))+g1975*g1702*
         g1076+g1699*g770*(19.7778*g1956-g2047)+g1712*g1423*(g2048-(3.55556*
         g1956))+g1709*g1312*(3.0*g1957+108.0*g841)+g1639*g1076*(9.33333*g1956-(
         1792.0*g1208))+g1694*g1076*(g2048-(5.33333*g1956))+12.0*g1894*g1650*
         g1311+g1702*g878*(576.0*g3hzz-(528.0*g1252))+g1436*396.0*(g1254+g1390)+
         g1709*g856*(-g2066-(2016.0*g1229))+g1441*(g1875+g1861)+g1712*g1208*(
         288.0*g769-g2080)+g1677*g1208*(288.0*g770-(1344.0*g769))+g1826*g1702*
         g1208-(g1880*g1642*g1208)+g1702*g1030*(g1982+144.0*g1198)+g1666*g844*(
         288.0*g1155+216.0*g1139)+g1468*(3.0*g1958+1440.0*g875)+g1702*m13sq*(
         g1871-g1974)+g1475*(g1850+g1814+27.0*g1090-(396.0*g1043));
        t0=t0+g1650*m13sq*(g1781-(4224.0*g928))+g1477*(1.5*g1848+g1814+g1790)+
         g1708*m13sq*(g1912-g1895+g1848)+g1702*m23sq*(36.0*g1079-g2065-g1793)+
         g1916*g1650*sw+g1709*sw*(-g2037-g2036)+g1713*sw*(g1904-g2036)+g1635*
         g1hzz*(g1954+288.0*g1023)+g1639*m12sq*(-(3.11111*g1937)-(896.0*g1067))+
         g1633*m12sq*(g2026-g1933-g1819)+g1633*m23sq*(g1832-g2028)+g1650*m12sq*(
         4.0*g1790-(1584.0*g1043))+g1642*g3hzz*(g2049+288.0*g879)+g1495*(144.0*
         g1205-g2046)+g1702*g3hzz*(g1929+g1844)+3.66667*g1961*g1695*g3hzz+g1502*
         (16.0*g1816-(1424.0*g920)+672.0*g919-(144.0*g918)-g1866-g1821)+g1708*
         m23sq*(g1899+g1828+288.0*g858)+g1529*g2hzz*(g2019-(24.0*g1907))+g1512*(
         g2039-(9.77778*g1913))+3.55556*g1913*g1712*g1512+2.11905*g1914*g1514;
        t0=t0+g1691*m13sq*(g2042+g1845+144.0*g777-(288.0*g776))+g1635*m23sq*(
         g1948+864.0*g896)+g2019*g1727*m23sq+g1635*m13sq*(g1948+864.0*g864)+
         g1650*m23sq*(g2059+g1902)+g1407*m23sq*(40.0*g1879-(5.33333*g1862)-(
         5120.0*g1005))+g1391*g1208*(2112.0*g786-g2051-(5408.0*g787))+g1369*
         g1352*(1136.0*g787-(96.0*g786)-(144.0*g785))+g822*g2hzz*(4608.0*g1352-(
         13.3333*g1936))+g823*g2hzz*(36.8889*g1936-(15360.0*g1352))+g824*g2hzz*(
         16896.0*g1352-(39.1111*g1936))+g825*g2hzz*(14.2222*g1936-(6144.0*g1352)
         )+g1352*g3hzz*(g2018-g2025)+g1015*sw*(-(144.0*g3hzz)-(72.0*g1352))+
         g1327*g1hzz*(g2021+108.0*g1021)+g879*g3hzz*(g2047+g2014)+g771*sw*(g1956
         -g2046)+g1263*g2hzz*(g1799+4.0*g1797)+g1262*g2hzz*(16.0*g1869-(5.33333*
         g1827)+g1799);
        t0=t0+g1259*m13sq*(g2058+2.0*g1859)+3.0*g1831*g1254*m12sq+g1601*(g1875+
         432.0*g1020)+g1875*g1602+g1208*m12sq*(g2030+g1859+1424.0*g853)+g1208*
         g1hzz*(2.0*g1922+432.0*g878)+g1205*m13sq*(12.0*g1910-(432.0*g856*m13sq)
         )+g1192*m13sq*(10528.0*g792-(3648.0*g791)+288.0*g790)+g1165*m13sq*(-
         g2083-(504.0*g843))+g848*m23sq*(96.0*g1118-(128.0*g1165))+g3hzz*sw*(
         144.0*g1137-g1961)+g1631*(g2023+2.0*g1903+512.0*g1280-(896.0*g1281)-(
         2848.0*g1277))+g1633*(g2053+4.0*g1856-(6.0*g1828)+1.83333*g1812-g2070)+
         g1635*(576.0*g807+864.0*(g1043+g1231*g844)+2.0*(g1792-g1807)-g2059-(3.0
         *g1825)-(8.0*g1809)-g1781-(216.0*g1090)-(72.0*g1095)-(288.0*g808))+
         g1637*(2.75*g1868-(9.77778*g1820)-(11264.0*g1359));
        t0=t0+g1642*(2.0*g1818+g1791-(144.0*g1517)+36.0*g1091-(72.0*g1147)+4.0*(
         g1802-g1864)-(288.0*g1210*g1025)+g2072*g1387)+g1643*(128.0*g1096-(96.0*
         g1105)+4.0*(g1841+g1819+g1817)-g2086-g2026-g1832)+g1650*(g1808+12.0*
         g1806+g1795-g1788-(2.0*g1782)+1728.0*g1442-(864.0*g932)+1584.0*g1308+
         432.0*(g933+g1207*g1032)+144.0*(g1498-g1024)+4.0*(g1801+g1787)-g2065)+
         g1659*(-g2069-g1878-(4.0*g1871)-(144.0*g1079))+g1661*(g1892-(2048.0*
         g1631*g1153*g1hzz)+2688.0*g1658*g1394)+g1666*(72.0*g973+1584.0*g1307-(
         3072.0*g1315)+1920.0*g827+576.0*(g988-g826)+216.0*(g1211-(g1140*g1030)-
         g2012)-(36.0*g1077))+g1674*(128.0*g1377+3.55556*(g1945-g1785)-g1868);
        t0=t0+g1666*g1635*(4.0*g1857+1.33333*g1823+144.0*g1176+288.0*g1519-(
         1152.0*g1108)+576.0*(g1196+g1100-g864))+g1677*(3.55556*g1843-(768.0*
         g1359)+5760.0*g994+6912.0*g993+4.66667*(-g1854-g1836))+g1030*g1030*(
         24.0*(-(g1180*g1180)-(g1181*g1181))-(48.0*g1651*g1208)-(192.0*g1173)-(
         96.0*g1179*g1179))+g1684*(32.0*g1178*g1178+64.0*g1683*g1208+36.0*g1689*
         g1157)+g1031*g1031*(36.0*g1651+128.0*g1682*g1169)+g1691*(g2025+2.0*
         g1865-g1797+7680.0*g835-(2304.0*g834))+g1679*g1107*(g2060+36.0*g1030*
         g3hzz-(72.0*g1666*g1197))+g1695*(4.33333*g1923+1056.0*g1395+528.0*g1332
         )+g1699*(9.88889*g1820+356.0*g1377+1068.0*g1426+10176.0*g994+5696.0*
         g1394*g946-g2068);
        t0=t0+g1702*(g2061-(4096.0*g2011)-(2048.0*g2010)+g1892-(5696.0*g815)+
         2688.0*g814+1152.0*g801+576.0*(-g813-g989-g802-g800-(g1203*g1039))+
         288.0*(g821+g990+g988+g1154*g844-g1144)+18.0*(g1029+g1028)+g2044*g1042)
         +g1704*(2688.0*g1679+8064.0*g1462)+g1185*g1185*(g1841+144.0*(g1052-(
         g1391*g1032)))+g1708*(g2064+g1806+2.0*g1795+4.0*g1791-g1786+g1784-(
         144.0*g1483)+36.0*g1041+672.0*g1442-(712.0*g857)+528.0*g1308)+g1709*(
         g2065+g1778+108.0*g1125*g1030)+g1206*g864*(2848.0*g1708-g2066)+g1711*(
         g2067+2688.0*g1704+g2060*g1183)+g1712*(g1854-(2.66667*g1843)+g1820-(
         5184.0*g994)-g2068)+g1713*(g1811+g1778+36.0*g1382+108.0*g1124)+g1716*(
         g1926+g1809)+g1717*(g2003+g1926);
        t0=t0+g1722*(g1860+4272.0*g1448-(2016.0*g1447)+432.0*g1446)+g1680*g842*(
         144.0*g1191-(336.0*g842))+g1312*g864*(-(712.0*g1312)-(8544.0*g1650))+
         g1730*(g1819+1024.0*g987)+g1270*g1270*(432.0*g1178-(4224.0*g904)-(
         1728.0*g888)+864.0*(g889+g887)-g2072)+g1924*g1378*g1378+g1368*g1368*(
         g2024-(2816.0*g904))+g1369*g1369*(g1924-g2076)+g1298*g1298*(g1942-(
         672.0*g1036)+g2087*g1298)+g1299*g1299*(g1942-(4.66667*g1900)+g2087*
         g1299)+g1357*g1357*(g1837-(2816.0*g986))+g1229*g1229*(4.0*g1870-(2848.0
         *g864))+g1311*g1311*(g2074+g1870)+g1356*g1356*(704.0*(-g769-g843)-g2073
         )+g1312*g1312*(g1831+g1817)+g1313*g1313*(2848.0*g1037-(25.6667*g1925)-(
         11392.0*g1033))+g1339*g1339*(2.78125*g1962-g2079)+g1962*g1340*g1340;
        msq3=(t0+g1342*g1342*(2.78125*g1893-g2079)+g1893*g1343*g1343+g1370*g1370
         *(16896.0*g904-(12544.0*g792)+7680.0*g791-(2304.0*g790)-(24.0*g1837))+
         g1752*(6.0*g1925-(1344.0*g1037))+g1338*g1338*(g2077-g2079)+g1341*g1341*
         (g1900-g2079)+g1266*g1266*(g1930+g1837)+g1353*g1353*(g1800+g1798)+g1354
         *g1354*(g1862+g1827+g1800)+g844*g844*(-(168.0*g1184)-(504.0*g1462))+
         g1764*(-g2083-(168.0*g843))+g1327*g1327*(g1964-g2084)+g1328*g1328*(
         g1964-g2085)+512.0*g1272*g1272*g987+g2067*g1679+1728.0*g1727*g1345-(
         144.0*g1155*g842)+4096.0*g1535*g1393-(712.0*g1364*g1364*g946)+288.0*
         g1273*g1125-(256.0*g1719*g1046)-(g2035*g1211)-(g2054*g1729)+32.0*g1683*
         g1177*g1177)/(g1667*g1633*(48.0*g1764-(96.0*g1661*g1165))+48.0*g1667*
         g1186);
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
  double ee =  _par[4];
  double sw =  _par[5];

  double g1hzz = _par[7];
  double g2hzz = _par[8];
  double g3hzz = _par[9];

  double g1hzy = _par[13];
  double g2hzy = _par[14];
  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mt + mt, 2 )) + pow( mt + mt, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mt,2), pow(mt,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mt,2) + pow(mt, 2) + pow(mz,2) - m12sq - m23sq;
  
  double m = mt;
  // Matrixelemente //
  
  double g92,g98,g49,g103,g33,g102,g46,g96,g5,g95,g45,g61,g6,g44,g7,g8,g52,g14,g9,g85,g18,g10,g101,g25,g94,g11,g24,g12,g32,g97,g13,g88,g15,g51,g31,g16,g104,g17,g60,g42,g21,g28,g22,g38,g23,g87,g27,g26,g29,g30,g34,g81,g35,g36,g37,g50,g39,g40,g84,g41,g43,g47,g48,g53,g54,g55,g65,g66,g70,g77,g79,g90,g137,g109,g131,g110,g111,g112,g138,g140,g113,g114,g129,g130,g115,g116,g133,g134,g117,g118,g124,g119,g120,g121,g122,g123,g125,g126,g127,g128,g132,g135,g136,g139,msq1;
{
    double t0 = 0;
    g92=ee*ee;
    g98=g2hzy*g2hzy;
    g49=g98*g92;
    g103=mh*mh;
    g33=g103*g49;
    g102=mz*mz;
    g46=g102*g92;
    g96=g46*m13sq;
    g5=g98*g96;
    g95=m*m;
    g45=g95*g92;
    g61=g102*m23sq;
    g6=g61*g45;
    g44=g103*g46;
    g7=g44*m13sq;
    g8=g44*m12sq;
    g52=g102*g46;
    g14=g103*g52;
    g9=g98*g14;
    g85=g95*g95;
    g18=g85*g46;
    g10=g98*g18;
    g101=m23sq*m23sq;
    g25=g101*g46;
    g94=g1hzy*g1hzy;
    g11=g94*g25;
    g24=g96*m13sq;
    g12=g94*g24;
    g32=g94*g46;
    g97=m12sq*m12sq;
    g13=g97*g32;
    g88=g103*g103;
    g15=g88*g32;
    g51=g94*g92;
    g31=g103*g51;
    g16=g101*g31;
    g104=m13sq*m13sq;
    g17=g104*g31;
    g60=g2hzy*g1hzy;
    g42=g92*g60;
    g21=g97*g42;
    g28=g51*m23sq;
    g22=g28*m13sq;
    g38=g94*g45;
    g23=g38*m12sq;
    g87=g102*g102;
    g27=g87*g49;
    g26=g27*m23sq;
    g29=g87*g51;
    g30=g38*m13sq;
    g34=g95*g18;
    g81=m13sq*g1hzy;
    g35=g81*m23sq;
    g36=m23sq*m12sq*g1hzy;
    g37=g81*m12sq;
    g50=g95*g1hzy;
    g39=g92*g50*g50;
    g40=g95*g42;
    g84=g102*g87;
    g41=g84*g42;
    g43=g51*m13sq;
    g47=g84*g49;
    g48=g51*m12sq;
    g53=g102*g95;
    g54=g95*g28;
    g55=g85*g28;
    g65=g28*m12sq;
    g66=g27*m12sq;
    g70=g22*m12sq;
    g77=g7*m23sq;
    g79=g5*m23sq;
    g90=g95*g85;
    g137=4.0*g54;
    g109=2.0*g22-g137;
    g131=16.0*g33*m23sq;
    g110=g131-(16.0*g21);
    g111=76.0*(-(g18*m13sq)-(g18*m23sq));
    g112=72.0*g6*m13sq+12.0*(-(g14*m13sq)-(g14*m23sq));
    g138=8.0*g29;
    g140=16.0*g27;
    g113=g138+20.0*g39-(6.0*g23)-g140;
    g114=8.0*(g12+g11);
    g129=16.0*g104*g42;
    g130=16.0*g101*g42;
    g115=-g130-g129;
    g116=4.0*(g39-g30);
    g133=4.0*g43;
    g134=4.0*g28;
    g117=-g134-g133;
    g118=g48+4.0*(-g38-g32);
    g124=16.0*m13sq;
    g119=-g124-(16.0*m12sq);
    g120=4.0*(m13sq+m23sq);
    g121=7.0*m12sq;
    g122=32.0*m12sq;
    g123=48.0*m12sq;
    g125=16.0*m23sq;
    g126=16.0*g8;
    g127=8.0*g7;
    g128=8.0*g21;
    g132=8.0*g8*m23sq;
    g135=16.0*g5;
    g136=16.0*g41;
    g139=32.0*g29;
    {
        t0=g120*(g103*g23-g15-g13)+g119*(3.0*g26-g9)+m12sq*(16.0*g79+12.0*g55)+
         g10*(g122-g125)+g11*(-g124-g121)+g12*(-g125-g121)+g16*(-m12sq-(8.0*
         m13sq))+g17*(-m12sq-(8.0*m23sq))+g41*(32.0*m23sq-(2.0*g119))+g47*(g123+
         8.0*g120)+g53*(2.0*g115+g110-(144.0*g53*g42))+g103*g95*(g135+32.0*g22)+
         g103*g94*(68.0*g18-(52.0*g6))+g50*g1hzy*(24.0*g14-g126-(52.0*g7))+g103*
         g60*(48.0*g6-(80.0*g18))+g60*(g132-(1.33333*g112)-(1.47368*g111)-(16.0*
         g77)-(96.0*g34)+g127*m12sq)+g61*(g129+g128)+g87*g40*(g123+28.0*g120)+
         g85*g31*(-(4.0*m12sq)-(24.0*m13sq))+g95*m13sq*(g140-g139)+g98*m12sq*(
         8.0*(g24+g25)-(32.0*g6))+g102*m13sq*(g130+g128+28.0*g23-g131)+g94*m12sq
         *(g127-(8.0*g14)+28.0*(g6-g18));
        t0=t0+g50*g2hzy*(48.0*g7-(96.0*g14)-g126)+m13sq*m12sq*(g138+12.0*g39)+
         g52*g2hzy*(24.0*(-g37-g36)-(48.0*g35))+g84*(g117-(64.0*g40)-(16.0*g33)+
         4.0*g31+8.0*g38)+g85*(g139-g135+56.0*g22+48.0*g27)+g87*(g115+g110-(16.0
         *g23)+8.0*(g109+g65))+g88*(g116+4.0*(g22+g29)-g137)+g90*(16.0*g31+56.0*
         g32+8.0*(g117-g48))+g92*(8.0*g35*g35+g36*g36+g37*g37)+g94*(g132+g112+
         g111+20.0*g77)+g95*(4.0*g114+24.0*g15+96.0*g66-(12.0*g70)+16.0*(g26+g90
         *g51)+32.0*(-g79-g9)+8.0*(g17+g16+g13)-(g122*g5))+g97*(g116+g109)+g98*(
         32.0*g34+g125*g24)+g101*m23sq*(g133+g118)+g104*m13sq*(g134+g118)+g101*(
         g135+g113-(28.0*g30)+3.0*g43*m12sq)+g102*(-g136-(16.0*g47)-(14.0*g70));
        msq1=(t0+g103*(g114-(24.0*g55)+4.0*g13-(2.0*g70)-(16.0*g10)-g136)+g104*(
         g113-(28.0*g54)+3.0*g65)-(48.0*g66*m13sq))/(2.0*g102*g97);
    }
}
double g596,g322,g593,g574,g592,g341,g281,g582,g149,g579,g374,g284,g458,g366,g150,g594,g323,g280,g376,g151,g377,g152,g470,g307,g295,g585,g342,g153,g583,g331,g268,g394,g525,g180,g154,g327,g517,g364,g314,g340,g320,g460,g462,g337,g318,g466,g549,g263,g163,g434,g164,g303,g165,g571,g346,g301,g168,g166,g262,g199,g167,g235,g202,g338,g294,g171,g251,g172,g504,g393,g175,g339,g176,g429,g422,g292,g371,g283,g591,g372,g282,g375,g181,g182,g577,g324,g258,g183,g336,g552,g293,g184,g317,g463,g187,g185,g326,g313,g210,g296,g188,g259,g260,g569,g321,g319,g197,g198,g200,g279,g201,g203,g204,g205,g431,g206,g471,g207,g278,g209,g382,g286,g547,g230,g214,g212,g312,g419,g288,g213,g215,g216,g334,g333,g217,g417,g332,g238,g220,g290,g221,g222,g553,g223,g457,g311,g225,g224,g315,g518,g449,g316,g229,g523,g231,g465,g415,g234,g236,g556,g240,g241,g242,g264,g243,g266,g244,g245,g246,g247,g285,g248,g249,g485,g250,g566,g433,g252,g253,g455,g272,g254,g277,g255,g256,g563,g325,g350,g261,g270,g265,g564,g269,g456,g271,g273,g274,g275,g276,g522,g289,g306,g291,
g298,g297,g300,g305,g304,g521,g308,g309,g310,g330,g329,g450,g343,g345,g344,g448,g447,g403,g404,g392,g363,g362,g444,g358,g380,g378,g379,g381,g385,g386,g387,g388,g590,g589,g391,g407,g398,g408,g588,g432,g425,g430,g438,g483,g502,g503,g507,g512,g515,g776,g617,g775,g681,g620,g771,g777,g703,g649,g661,g773,g611,g612,g642,g650,g613,g732,g614,g632,g641,g615,g678,g760,g647,g616,g754,g701,g618,g693,g676,g619,g730,g621,g690,g768,g622,g656,g766,g672,g623,g753,g624,g671,g625,g751,g657,g659,g626,g761,g683,g759,g634,g757,g627,g680,g628,g629,g630,g778,g779,g631,g633,g664,g635,g743,g655,g636,g637,g679,g638,g639,g765,g640,g662,g700,g643,g774,g644,g762,g763,g645,g682,g741,g652,g646,g670,g674,g665,g648,g715,g651,g653,g654,g669,g727,g744,g658,g660,g663,g666,g667,g668,g673,g675,g677,g684,g685,g686,g702,g687,g688,g767,g691,g692,g694,g695,g725,g696,g697,g698,g713,g699,g704,g705,g706,g708,g710,g746,g711,g714,g716,g745,g750,g724,g726,g728,g729,g731,g733,g734,g735,g736,g737,g738,g739,g740,g742,g747,g748,g749,g752,g755,g756,g758,g764,
g769,g770,g772,g780,g781,msq2;
{
    double t0 = 0;
    g596=m23sq*m23sq;
    g322=g596*g1hzy;
    g593=sw*sw;
    g574=g593*sw;
    g592=ee*ee;
    g341=g592*g574;
    g281=g341*g322;
    g582=mh*mh;
    g149=g582*g281;
    g579=g593*g574;
    g374=g579*g1hzy;
    g284=g592*g374;
    g458=g582*m23sq;
    g366=g458*m23sq;
    g150=g366*g284;
    g594=m13sq*m13sq;
    g323=g594*g1hzy;
    g280=g592*g323;
    g376=g574*g280;
    g151=g582*g376;
    g377=g579*g280;
    g152=g582*g377;
    g470=m23sq*g1hzy;
    g307=g592*g470;
    g295=g307*m13sq;
    g585=mz*mz;
    g342=g585*g582;
    g153=g342*g295;
    g583=m*m;
    g331=g592*g583;
    g268=g331*g1hzy;
    g394=g585*m12sq;
    g525=g268*g1hzz;
    g180=g525*g394;
    g154=g582*g180;
    g327=g341*g2hzy;
    g517=g3hzz*m12sq;
    g364=g592*g2hzy;
    g314=g579*g364;
    g340=g574*g2hzz;
    g320=g592*g340;
    g460=g582*g2hzy;
    g462=g582*g2hzz;
    g337=g574*g1hzz;
    g318=g592*g337;
    g466=g582*g1hzz;
    g549=g3hzz*g1hzy;
    g263=g549*g341;
    g163=g582*g263;
    g434=g582*g3hzz;
    g164=g434*g284;
    g303=g320*g1hzy;
    g165=g582*g303;
    g571=g585*g585;
    g346=g592*g571;
    g301=g346*g1hzy;
    g168=g462*g301;
    g166=g168*m23sq;
    g262=g571*g284;
    g199=g262*g2hzz;
    g167=g199*m13sq;
    g235=g571*g318;
    g202=g262*g1hzz;
    g338=g585*g1hzy;
    g294=g592*g338*g1hzz;
    g171=g582*g458*g294;
    g251=g294*sw;
    g172=g582*g251;
    g504=g235*g1hzy;
    g393=g585*m13sq;
    g175=g525*g393;
    g339=g585*m23sq;
    g176=g339*g280;
    g429=g1hzz*m12sq;
    g422=g429*g1hzy;
    g292=g592*g422;
    g371=g582*g571;
    g283=g585*g284;
    g591=m12sq*m12sq;
    g372=g592*g591;
    g282=g372*m23sq;
    g375=g585*g282;
    g181=g574*g375;
    g182=g579*g375;
    g577=g583*g583;
    g324=g577*g1hzy;
    g258=g592*g324;
    g183=g342*g258*g1hzz;
    g336=g592*mw*ee;
    g552=g2hzy*m12sq;
    g293=g552*g336;
    g184=g342*g293;
    g317=g585*g336;
    g463=g582*g1hzy;
    g187=g463*g317;
    g185=g187*m23sq;
    g326=g593*g336;
    g313=g326*g1hzy;
    g210=g585*g313;
    g296=g372*g3hzz;
    g188=g585*g296*g2hzy;
    g259=g571*g327;
    g260=g571*g314;
    g569=g585*g571;
    g321=g569*g1hzy;
    g319=g592*g321;
    g197=g462*g319;
    g198=g571*g281;
    g200=g571*g376;
    g279=g591*g301;
    g201=g574*g279;
    g203=g574*g294;
    g204=g283*g1hzz;
    g205=g463*g318;
    g431=g569*g284;
    g206=g431*g1hzz;
    g471=g582*g466;
    g207=g471*g301;
    g278=g571*g326;
    g209=g582*g278;
    g382=g585*sw;
    g286=g382*m12sq;
    g547=g2hzz*g2hzy;
    g230=g547*g346;
    g214=g230*m23sq;
    g212=g214*sw;
    g312=g571*g331;
    g419=g2hzy*sw;
    g288=g419*g312;
    g213=g288*m13sq;
    g215=g583*g259;
    g216=g583*g260;
    g334=g592*sw;
    g333=g334*g2hzy;
    g217=g458*g333;
    g417=g582*sw;
    g332=g334*g3hzz;
    g238=g338*g332;
    g220=g238*m12sq;
    g290=g301*m13sq;
    g221=g290*m23sq;
    g222=g417*g301;
    g553=sw*g1hzy;
    g223=g553*g282;
    g457=g336*g1hzy;
    g311=g457*m12sq;
    g225=g593*g311;
    g224=g225*m23sq;
    g315=g569*g364;
    g518=g2hzz*sw;
    g449=g569*g2hzz;
    g316=g577*g2hzy;
    g229=g571*g334*g316;
    g523=g1hzz*sw;
    g231=g523*g315;
    g465=g569*g1hzz;
    g415=g571*g1hzz;
    g234=g415*g333;
    g236=g260*g1hzz;
    g556=g3hzz*m23sq;
    g240=g517*g312;
    g241=g263*m12sq;
    g242=g517*g268;
    g264=g296*g1hzy;
    g243=g583*g264;
    g266=g574*g319;
    g244=g266*m23sq;
    g245=g431*m23sq;
    g246=g518*g268;
    g247=g266*m13sq;
    g285=g569*g331;
    g248=g579*g285;
    g249=g574*g285;
    g485=g571*g2hzz;
    g250=g485*g258;
    g566=g571*sw;
    g433=g585*g566;
    g252=g433*g268;
    g253=g415*g268*sw;
    g455=g583*g336;
    g272=g455*g2hzy;
    g254=g571*g272;
    g277=g455*g1hzy;
    g255=g571*g277;
    g256=g277*m23sq;
    g563=g585*g569;
    g325=g592*g563;
    g350=g583*g1hzz;
    g261=g350*g325;
    g270=g563*g284;
    g265=g270*g2hzz;
    g564=g583*g577;
    g269=g564*g301;
    g456=g591*g336;
    g271=g456*g2hzy;
    g273=g336*g316;
    g274=g569*g313;
    g275=g278*g1hzy;
    g276=g456*g1hzy;
    g522=m12sq*g1hzy;
    g289=g522*g332;
    g306=g319*sw;
    g291=g582*g306;
    g298=g547*g325;
    g297=g298*sw;
    g300=g325*g1hzz*g2hzy;
    g305=g553*g325;
    g304=g306*g2hzz;
    g521=m13sq*g1hzy;
    g308=g521*g1hzz;
    g309=g457*m23sq;
    g310=g457*m13sq;
    g330=g583*g582;
    g329=g569*m12sq;
    g450=g574*g3hzz;
    g343=g450*g258;
    g345=g579*g258;
    g344=g345*g3hzz;
    g448=g577*m13sq;
    g447=g577*m12sq;
    g403=g574*g214;
    g404=g579*g214;
    g392=g583*m12sq;
    g363=g585*g339;
    g362=g583*m13sq;
    g444=g571*m12sq;
    g358=g444*g165;
    g380=g585*g583;
    g378=m23sq*sw;
    g379=m13sq*sw;
    g381=g583*sw;
    g385=m23sq*m12sq;
    g386=m13sq*m12sq;
    g387=sw*m12sq;
    g388=m23sq*m13sq;
    g590=g596*m23sq;
    g589=g594*m13sq;
    g391=g583*m23sq;
    g407=g593*g583;
    g398=g407*sw;
    g408=g594*g180;
    g588=g585*g563;
    g432=g596*sw;
    g425=g517*g284;
    g430=g3hzz*sw;
    g438=g386*g251;
    g483=g574*g261;
    g502=g240*g1hzy;
    g503=g235*g2hzy;
    g507=g223*g3hzz;
    g512=g209*g1hzy;
    g515=g175*sw;
    g776=32.0*g518*g315;
    g617=g776+128.0*g449*g314-(160.0*g340*g315);
    g775=16.0*g231;
    g681=g775+64.0*g465*g314-(80.0*g337*g315);
    g620=16.0*g275-g681;
    g771=32.0*g206;
    g777=8.0*g364*g286*g3hzz;
    g703=g771-g777;
    g649=g703+48.0*g579*g242;
    g661=g620+80.0*g266*g2hzz;
    g773=64.0*g431*g2hzz;
    g611=g661+g649-g617+28.0*g253+6.0*g220-g276-g773;
    g612=5.0*g681-(4.0*g703);
    g642=20.0*g470*g235-(16.0*g202*m23sq);
    g650=20.0*g504*m13sq-(16.0*g202*m13sq);
    g613=g650+g642;
    g732=3.0*g617;
    g614=g771-g732-(2.5*g681);
    g632=8.0*g210*m13sq-(4.0*g238*m13sq);
    g641=20.0*g574*g175-(16.0*g579*g175);
    g615=2.0*g641-g632-(32.0*g344);
    g678=20.0*g585*g263-(16.0*g283*g3hzz);
    g760=128.0*g236;
    g647=g760-(4.0*g678)-(16.0*g172)+80.0*g241;
    g616=g647+32.0*g225;
    g754=32.0*g229;
    g701=16.0*g252-g754;
    g618=40.0*(-g247-g244)-g701;
    g693=32.0*g517*g314-(40.0*g517*g327);
    g676=-g693-(4.0*g293);
    g619=8.0*g552*g332-g676;
    g730=2.0*g632;
    g621=16.0*g224+8.0*g220-g730;
    g690=20.0*g163*m23sq-(4.0*g417*g307*g3hzz)-(16.0*g164*m23sq);
    g768=32.0*g212;
    g622=g690-g614-g768;
    g656=g311+2.0*g289;
    g766=4.0*g225;
    g672=g766+10.0*g241;
    g623=g672-g656;
    g753=32.0*g213;
    g624=-g753-(8.0*g291);
    g671=32.0*g591*g260-(40.0*g591*g259);
    g625=g671-(80.0*g244);
    g751=16.0*g593*g317*g2hzy;
    g657=1.5*g678-g751;
    g659=-(12.0*g210)-(2.0*g172)-(40.0*g202);
    g626=g659-g657-(3.0*g309);
    g761=16.0*g234;
    g683=16.0*g210-g761;
    g759=8.0*g238;
    g634=g683-g759;
    g757=8.0*g172;
    g627=g757-(6.0*g672)+g634-(128.0*g199)+112.0*g202;
    g680=16.0*g270+4.0*g305;
    g628=48.0*g229-g680-(32.0*g252)-(12.0*g291);
    g629=4.0*(-(g277*m13sq)-g256);
    g630=g680-(20.0*g201);
    g778=4.0*g276;
    g779=4.0*g187;
    g631=g779+g778;
    g633=40.0*(g198+g200);
    g664=12.0*g371*g292-(8.0*g188);
    g635=g664-(4.0*g207)+112.0*g250+8.0*g154+16.0*g197;
    g743=128.0*g300;
    g655=g743-(96.0*g183)+256.0*g298+32.0*(g154+g243);
    g636=32.0*g188-g655-(16.0*g171);
    g637=g753-g754;
    g679=2.0*g276-(4.0*g271);
    g638=2.0*(-g690-g679);
    g639=64.0*g564*g230+2.0*(-(g594*g264)-(g596*g264))-(12.0*g408)-(80.0*g577*
     g168)-(16.0*g392*g168);
    g765=4.0*g185;
    g640=8.0*g184-g765;
    g662=32.0*g596*g260-(40.0*g596*g259);
    g700=32.0*g594*g260-(40.0*g594*g259);
    g643=g700+g662;
    g774=16.0*g304;
    g644=-g774-g773;
    g762=4.0*g310;
    g763=4.0*g309;
    g645=-g763-g762;
    g682=12.0*(-(g290*g3hzz)-(g556*g301));
    g741=4.0*g171;
    g652=g741+4.66667*g682+2.0*g664;
    g646=48.0*g166-g652-(96.0*g197);
    g670=80.0*g460*g318-(64.0*g466*g314);
    g674=160.0*g460*g320-(128.0*g462*g314);
    g665=g674+g670;
    g648=g665+80.0*g165;
    g715=g777-(48.0*g206);
    g651=g776+g715;
    g653=40.0*g163-(32.0*g164);
    g654=16.0*g274-(64.0*g265);
    g669=10.0*g585*g281-(8.0*g596*g283);
    g727=4.0*g669;
    g744=8.0*g222;
    g658=g744-g727;
    g660=120.0*g244-(96.0*g245);
    g663=20.0*g394*g163-(16.0*g394*g164);
    g666=g676-(4.0*g277)+3.0*g311;
    g667=-g674-(2.0*g670)-(240.0*g165);
    g668=g682+8.0*g166;
    g673=g751-g678;
    g675=10.0*(-g151-g149)+8.0*(g152+g150);
    g677=128.0*g404*m13sq-(160.0*g403*m13sq);
    g684=g617+g612;
    g685=4.0*g642+12.0*g224;
    g686=8.0*g234+6.0*g277;
    g702=160.0*g215-(128.0*g216);
    g687=g702+16.0*g306;
    g688=4.0*g693-g653;
    g767=16.0*g202;
    g691=g743-(32.0*g183)+384.0*g298;
    g692=g660+120.0*g247;
    g694=256.0*(g447*g230-(g392*g214))-(128.0*g448*g230);
    g695=g311-g766;
    g725=4.0*g254-g184;
    g696=16.0*g725-(112.0*g255);
    g697=160.0*g249-(128.0*g248);
    g698=4.0*g392*g187+2.0*(-(g185*m12sq)-(g388*g276))-(8.0*g254*m12sq);
    g713=8.0*g204-(10.0*g203);
    g699=g713+2.0*g251;
    g704=g761-(2.0*g657);
    g705=4.0*(-m13sq-m23sq);
    g706=-(72.0*g258)-(8.0*g280);
    g708=4.0*g306-(20.0*g266);
    g710=28.0*g176-(32.0*g153);
    g746=8.0*g258;
    g711=-g746-(2.0*g280);
    g714=16.0*g182-(20.0*g181);
    g716=-(64.0*g314)-(16.0*g333);
    g745=8.0*g379;
    g750=8.0*g394;
    g724=-(g305*g2hzz)-(g300*sw);
    g726=4.0*g675;
    g728=2.0*g643;
    g729=5.0*g642;
    g731=2.0*g619;
    g733=64.0*g284;
    g734=4.0*g223;
    g735=8.0*g223;
    g736=32.0*g262;
    g737=12.0*g242;
    g738=32.0*g217;
    g739=480.0*g340;
    g740=560.0*g250;
    g742=64.0*g197;
    g747=60.0*g258;
    g748=16.0*g280;
    g749=16.0*g387;
    g752=32.0*g3hzz;
    g755=40.0*g201;
    g756=48.0*g210;
    g758=64.0*g199;
    g764=16.0*g272;
    g769=32.0*g246;
    g770=40.0*g253;
    g772=32.0*g167;
    g780=10.0*g263;
    g781=-(96.0*g221);
    {
        t0=g698+80.0*(g588*g303+g422*g249)+1.5*(g645*g444+g616*g448)+8.0*(g713*
         g582*g564-(g566*g264)+g553*g261)+4.0*(g646*g593*g398+g640*g407+g629*
         g387*g387+g585*g507)+g699*(4.0*g392*g392+10.0*g362*g362+g589*m12sq+g590
         *m12sq+28.0*g577*g388+16.0*(-(g564*m13sq)-(g564*m23sq))+8.0*(g583*g564-
         (g564*m12sq))+2.0*(g330*g330+g589*m23sq+g590*m13sq-(g589*g583)-(g590*
         g583)))+(g623+20.0*g504-(4.0*g523*g301)-(8.0*g425)-g767)*(g590+g589)+
         g705*(g725+60.0*g316*g235+11.0*g350*g222-(2.0*g591*g234)+8.0*g274+10.0*
         g358)+(4.0*g153-(6.0*g176))*(5.0*g337*m12sq-(g387*g1hzz)-(4.0*g579*g429
         ))+g697*(g549-(1.5*g522*g2hzz))+g693*(g342*m13sq+4.0*g583*g339+g582*
         g339-(2.0*g585*g330));
        t0=t0+(16.0*g3hzz-(32.0*g350))*(g182*g1hzy-(1.25*g181*g1hzy))+g669*(6.0*
         g350*m12sq-(3.0*g386*g1hzz))+16.0*(-g386-g385)*(g278*g2hzy+8.0*g216*
         g1hzz-(10.0*g215*g1hzz)-(6.0*g577*g204)+7.5*g577*g203)+g702*2.0*(g386*
         g2hzz+g388*g1hzz)+(-g750-(32.0*g339))*(g152*g1hzz-(1.25*g151*g1hzz))+(-
         g750-(32.0*g393))*(g150*g1hzz-(1.25*g149*g1hzz))+(-g745-(8.0*g378))*(
         3.0*g517*g258-(g569*g292))+(112.0*g246+60.0*g205-g648)*(g571*g393+g571*
         g339)+(8.0*g705-(32.0*m12sq))*(g724+5.0*g563*g303-(4.0*g265))+(24.0*
         g221+8.0*(g153-g176))*(5.0*g450-g430)+g711*(5.0*g415*g387-(g434*g387))+
         g667*(g571*g362+g583*g363)+g677*m12sq+sw*(g639+24.0*g502)+m13sq*(g663-(
         16.0*g512)-g765);
        t0=t0+g3hzz*(g633+g624+64.0*g245+2.0*(g671-g630+g618))+g209*(32.0*g552-(
         16.0*g470))+g255*(12.0*m12sq-(7.0*g705))+g269*(g739+40.0*g523)+g297*(
         96.0*m12sq-(16.0*g705))+g714*g308+g329*(48.0*g246+40.0*g205+g733*g3hzz-
         g665)+g330*(g768-(2.0*g651)+g621+11.0*g613+192.0*g167-(64.0*g231)+16.0*
         g225*m13sq)+g571*g336*(4.0*(-g323-g322)-(36.0*g324))+g339*(g679+g764*
         m12sq)+g585*g350*(g726-g735)+g350*(160.0*g247-g755-g728-(3.5*g633)-(2.0
         *g625))+g688*g585*g362+g362*(g779-(4.0*g685)+g684-(64.0*g212)+48.0*g168
         *sw)+g619*g363+g339*m23sq*(g762+g666)+g366*(g656-g766)+g393*m13sq*(g763
         +g666)+g695*g594*g582+g583*g380*(12.0*g311-g688-(3.0*g645))+g583*g330*(
         4.0*g695+208.0*g202-g759);
        t0=t0+g371*(-g731-g645)+g433*sw*(-(128.0*g272)-(32.0*g293))+g374*(32.0*
         g261+96.0*g240)+g378*(g635+24.0*(g242*m13sq-(g175*m12sq))+g778*g378)+
         g379*(g741+g635-(16.0*g166)+8.0*(g243+g168*m12sq)+g778*g379)+g638*g380+
         g381*(g646+24.0*g207+g781*g2hzz)+g385*(g770+3.0*g615+g614+24.0*(-g304-(
         g377*g3hzz))+g780*g385)+g386*(g770+g729+1.5*g644-g622-(96.0*g344)-(2.0*
         g187)+12.0*g256)+g668*g387+g388*(2.0*g649+3.0*g620+8.0*g388*g251-g732)+
         g391*(g684+8.0*g632-(384.0*g167)-(24.0*g220)+20.0*g391*g251)+g392*(6.0*
         g632+2.0*g622-(10.0*g613))+g393*(g679-(16.0*g256)+g734*g1hzz-(g769*g393
         ))+g394*(g690+3.0*g629+16.0*(-g273-(g394*g246)))+g627*g596*g583+g594*
         g583*(2.0*g678+g627);
        t0=t0+g398*(5.0*g652-(120.0*g207))+g591*g583*(g634+32.0*g202-g758-(2.0*
         g673))+g585*g380*(6.0*g653-(48.0*g225)-(2.0*g693))+g571*g380*(-(2.0*
         g667)-(120.0*g205))+g596*g3hzz*(-g736-(24.0*g386*g284)-(8.0*g301*sw))+
         g415*(g726-(g747*g379)-(16.0*g217*m13sq)-g734)+g588*g2hzz*(2.0*g716-(
         16.0*g334*g1hzy)-g733)+g419*(64.0*(g285*g3hzz-g261)-(16.0*g240))+g433*
         g2hzz*(2.0*g706-(48.0*g295))+g433*g1hzz*(16.0*g295-(4.0*g711))+g432*
         g290*16.0*(g2hzz-g1hzz)+g3hzz*m13sq*(g687+g658+64.0*g431-g734)+g706*
         g571*g430+g591*g3hzz*(-g736-(g746*sw))+g429*(g643+1.25*g633+g624+g618)+
         g432*(g737-(12.0*g180)-(28.0*g175))+g596*g230*(g749+32.0*g379)+g585*
         g386*(g764+6.0*g309)+g583*g385*(g756-(2.0*g704));
        t0=t0+g579*g153*(128.0*g350-g752)+g579*g176*(g752-(112.0*g350))+g447*(
         g760-g653+4.0*g626-(12.0*g310))+g449*(g738-(576.0*g345))+g569*g258*(
         720.0*g340-(160.0*g337))+5.0*g710*g583*g337+g715*g458+g716*g588*g1hzz+
         g588*g2hzy*(80.0*g318+160.0*g320)+g637*g462+g564*g1hzy*(-(8.0*g317)-(
         200.0*g235))+g466*(g753+1.5*g701+g630)+g596*m12sq*(g751+g686+g659-(3.0*
         g310))+g585*g393*(g619-(12.0*g309)+24.0*g225-g653)+g594*m12sq*(g686+
         g626)+g708*g471+g596*g1hzz*(g744+2.0*g708)+g574*m23sq*(-g740-(1.25*g655
         ))+g579*m23sq*(g742+g655)+g574*m13sq*(1.25*g636-g740)+g579*m13sq*(g742-
         g636-(64.0*g166))+g574*m12sq*(-(1.25*g691)-(5.0*g682))+g579*m12sq*(g691
         +4.0*g668)+g596*m13sq*(g761-g757+3.0*g672-(6.0*g289));
        t0=t0+g594*g1hzz*(g658-(40.0*g266))+g483*(320.0*g2hzy-(40.0*g1hzy))+g577
         *g3hzz*(256.0*g260-(320.0*g259))+g582*m12sq*(g776+g775+g772-g771+g632+
         g629-(3.0*g613))+g696*g593*m23sq+g593*m13sq*(g696+16.0*g185)+g583*g2hzz
         *(4.0*g633+80.0*g201-(4.66667*g692))+g594*m23sq*(g758-g757-g683+30.0*
         g241)+g577*m23sq*(1.5*g647+448.0*g199+24.0*g238-g756)+g582*m13sq*(g775-
         g768-g729+g651-(8.0*g224))+g583*g3hzz*(g727-(48.0*g222))+g591*g1hzz*(
         4.0*g222-g669)+g577*g1hzz*(52.0*g222-(10.0*g669))+g591*m23sq*(g751-(8.0
         *g210)+32.0*g199)+g673*g591*m13sq+g517*(g675-(3.0*g669)-(6.0*g378*g280)
         )+g518*(g748*g363-(96.0*g269))+g523*g363*(-g748-g747)+g221*g1hzz*20.0*(
         g417-g387)+g385*m13sq*(g704+64.0*g236-(80.0*g503));
        t0=t0+g379*g279*(8.0*g2hzz-(4.0*g1hzz))+g648*g363*m13sq+g362*m23sq*(8.0*
         g678-(120.0*g241))+g362*m12sq*(4.0*g657+g653)+g350*sw*(64.0*g221-g710)+
         2.0*g676*g339*m13sq+g235*m12sq*(200.0*g324-(160.0*g316))+g556*(g687-(
         32.0*g288))+g1hzz*m23sq*(2.0*g700+g671+g628-(64.0*g213))+g1hzz*m13sq*(
         2.0*g662+g628+g625)+g3hzz*g2hzy*2.0*(-g714-g697)+g2hzz*m12sq*(g728+g692
         -(2.0*g637))+g2hzz*m13sq*(4.0*g662+2.0*g660-(80.0*g198)-g755-g754)+
         g2hzz*m23sq*(4.0*g700-(80.0*g200)-g755)+g563*(g648+16.0*g313-(4.0*g457)
         -(64.0*g246)+40.0*g263+20.0*(g337*g307-g205)+320.0*g340*g268)+g564*(8*
         g656+2.0*g634-g616-(384.0*g199)+64.0*g425+160.0*(g503+g202))+g569*(g731
         +g653-(2.0*g645)-(8.0*g623)-(16.0*g277)+32.0*g272);
        t0=t0+g571*(g638-(288.0*g344)+360.0*g343+24.0*g224+32.0*g273+g738*g350+
         16.0*g419*g296)+g574*(60.0*g408+20.0*g325*g308-(1.25*g694)-(120.0*g502)
         )+g577*(g732-g631+3.0*g621+15.0*g613-g612-(128.0*g404)+160.0*g403+144.0
         *g275+24.0*g438+448.0*g167-g768)+g579*(g694+4.0*g639-(16.0*g388*g264)+
         g781*g3hzz)+g582*g582*(g641+g613-(4.0*g515)+16.0*g206)+g582*(16.0*g724+
         g654-(24.0*g255)-(32.0*g297)+2.0*g386*g309-(4.0*g336*g321)+96.0*g330*
         g202-(g745*g242))+g583*(4.0*g654-g640+96.0*g512+80.0*g358+8.0*g507+2.0*
         (-g677-g663)+g739*g221)+g591*(g772+g661+g644-g629+g615+g613+40.0*g343+
         8.0*(g253-g515)+g767*g582+20.0*g388*g263)+g593*(-(4.0*g698)-(256.0*g483
         *g2hzy));
        msq2=(t0+g594*(g768+g685+g611+g737*sw-(g736*g3hzz)+g749*g230)+g339*g339*
         (-g769-(10.0*g292*sw))+g596*(4.0*g650+7.0*g641+g611+6.0*g438+64.0*g167-
         g774-g730)+g385*g251*(24.0*g577+2.0*g385)+g380*g380*(g674+3.0*g670-(
         260.0*g205)+400.0*g165)+g381*g381*(4.0*g631-(320.0*g381*g230))+g386*
         g386*(g780+g699)+g382*g382*(-(128.0*g273)-(32.0*g271))+16.0*g465*g217+
         g735*g485+448.0*g521*g248*g2hzz)/(cw*cw*cw*4.0*(g286*g286-(g593*g329)))
         ;
    }
}
double g1110,g1667,g1711,g1093,g1701,g866,g1662,g1707,g1688,g1650,g1666,g1169,g988,g1280,g1720,g1686,g1170,g987,g868,g1649,g1644,g1171,g986,g1640,g1172,g985,g1696,g871,g1281,g1663,g1107,g1464,g1039,g1105,g842,g1268,g843,g800,g1104,g844,g801,g1204,g1725,g822,g802,g1131,g1259,g1708,g823,g803,g1074,g1647,g824,g804,g1270,g1274,g1269,g1638,g1267,g825,g1266,g826,g1661,g1089,g1285,g965,g1511,g807,g1176,g1687,g1123,g1038,g808,g1208,g928,g809,g1691,g1094,g966,g1247,g813,g1132,g814,g815,g1103,g816,g1102,g817,g1643,g1073,g1250,g820,g1694,g1654,g1510,g827,g828,g829,g830,g831,g1284,g832,g1130,g1275,g833,g1679,g834,g835,g836,g1159,g1097,g870,g1173,g1096,g873,g1174,g1668,g997,g904,g1655,g1164,g908,g1684,g1282,g909,g993,g994,g847,g1106,g848,g1091,g849,g850,g851,g852,g853,g1100,g854,g855,g1101,g1699,g859,g1136,g1099,g860,g1098,g862,g1090,g863,g922,g923,g1161,g872,g867,g1469,g869,g1286,g1635,g874,g1669,g1660,g875,g1724,g876,g877,g1723,g878,g879,g880,g883,g884,g885,g1671,g891,g1689,g1095,g897,g898,g899,g900,g901,g902,g1160,
g903,g1659,g1636,g1179,g984,g1331,g1213,g1071,g1209,g936,g1070,g937,g1154,g911,g1472,g912,g1471,g1470,g1124,g1043,g915,g916,g1218,g917,g945,g1700,g918,g1251,g919,g920,g921,g1413,g950,g924,g1134,g951,g1214,g1254,g1253,g929,g1122,g1037,g1363,g1482,g1178,g1665,g932,g1030,g934,g1058,g1024,g935,g962,g1036,g1035,g1409,g941,g1034,g1693,g1207,g943,g1276,g944,g1262,g946,g1257,g947,g948,g1408,g949,g1256,g952,g1206,g953,g1072,g1287,g1288,g1205,g959,g1221,g1704,g1133,g1069,g1109,g969,g970,g996,g971,g972,g1474,g1271,g974,g1265,g975,g1283,g977,g978,g979,g980,g981,g1248,g1084,g983,g1175,g1713,g1092,g992,g995,g998,g1633,g1180,g999,g1634,g1264,g1000,g1003,g1001,g1258,g1140,g1317,g1002,g1212,g1004,g1359,g1005,g1360,g1006,g1009,g1007,g1008,g1088,g1010,g1011,g1047,g1012,g1108,g1087,g1017,g1018,g1019,g1020,g1627,g1023,g1166,g1168,g1025,g1626,g1026,g1028,g1027,g1029,g1184,g1113,g1031,g1057,g1032,g1119,g1379,g1033,g1040,g1041,g1042,g1044,g1198,g1121,g1120,g1056,g1060,g1059,g1061,g1475,g1692,g1065,g1118,g1068,g1273,g1272,g1079,
g1702,g1081,g1129,g1177,g1155,g1670,g1085,g1156,g1086,g1165,g1183,g1112,g1114,g1115,g1116,g1117,g1203,g1157,g1138,g1137,g1261,g1163,g1162,g1718,g1717,g1716,g1158,g1714,g1149,g1152,g1167,g1181,g1192,g1392,g1187,g1200,g1188,g1296,g1189,g1190,g1195,g1196,g1255,g1435,g1201,g1337,g1217,g1412,g1219,g1346,g1220,g1222,g1249,g1252,g1368,g1425,g1369,g1370,g1371,g1372,g1279,g1629,g1487,g1630,g1488,g1295,g1297,g1304,g1347,g1305,g1350,g1361,g1316,g1318,g1320,g1321,g1322,g1325,g1329,g1330,g1332,g1334,g1335,g1336,g1338,g1339,g1343,g1349,g1351,g1352,g1353,g1358,g1362,g1364,g1366,g1367,g1518,g1504,g1378,g1415,g1414,g1383,g1387,g1391,g1478,g1394,g1395,g1411,g1410,g1440,g1441,g1461,g1477,g1481,g1501,g1494,g1516,g1532,g1533,g1625,g1733,g1914,g1820,g1838,g1768,g1769,g1910,g2015,g1875,g1770,g1771,g1935,g1772,g1773,g1874,g1774,g1810,g1862,g1802,g2010,g1942,g1775,g1776,g1777,g1853,g1973,g1795,g1934,g1778,g1779,g1780,g1781,g1782,g1818,g1863,g1892,g1783,g1784,g1871,g1785,g1827,g1786,g1787,g1811,g1846,g1861,g1788,g1789,g1790,g1965,
g1791,g1873,g1792,g1837,g1859,g2018,g1793,g2023,g1901,g2004,g2006,g1794,g1867,g1809,g1796,g1797,g1841,g2021,g1798,g1799,g1823,g1800,g1801,g1916,g1803,g1845,g1848,g1804,g1829,g1805,g1819,g1978,g1806,g1967,g1807,g1808,g1830,g1852,g1821,g1814,g1815,g1894,g2002,g1923,g1816,g1817,g1847,g1822,g1824,g1825,g2013,g1826,g1885,g1932,g1828,g1905,g2022,g1832,g1865,g1891,g1971,g1833,g1907,g1893,g1834,g1903,g1868,g2014,g2005,g1836,g1839,g1866,g1840,g2017,g1842,g1843,g1844,g1849,g1850,g1851,g1854,g1855,g1890,g1919,g1856,g1889,g1987,g1857,g2026,g2027,g1858,g1888,g1860,g1864,g1869,g2011,g1870,g1877,g1876,g1887,g1878,g1945,g1989,g1880,g1886,g1900,g1882,g1883,g1884,g1895,g1896,g1897,g1899,g1898,g1902,g1904,g1906,g1908,g1909,g1911,g1912,g1913,g1915,g2001,g1918,g1921,g2003,g1991,g1925,g1927,g1926,g1940,g1939,g1933,g1936,g1938,g1946,g1947,g1975,g1949,g2025,g1951,g1952,g1998,g1960,g1961,g1964,g1966,g1968,g1969,g1970,g1972,g1974,g1976,g1977,g1979,g1980,g1981,g1982,g1983,g1984,g1985,g1986,g1988,g1990,g1992,g1993,g1994,g1995,g1996,
g1997,g1999,g2000,g2007,g2008,g2009,g2012,g2016,g2019,g2020,g2024,g2028,g2042,g1658,msq3;
{
    double t0 = 0;
    g1110=sw*ee;
    g1667=g1110*g1110;
    g1711=g1hzz*g1hzz;
    g1093=g1711*g1667;
    g1701=m23sq*m23sq;
    g866=g1701*g1093;
    g1662=mh*mh;
    g1707=sw*sw;
    g1688=g1707*sw;
    g1650=g1688*sw;
    g1666=ee*ee;
    g1169=g1666*g1650;
    g988=g1711*g1169;
    g1280=g1701*g1662;
    g1720=g1650*sw;
    g1686=g1720*sw;
    g1170=g1686*g1666;
    g987=g1711*g1170;
    g868=g1701*g987;
    g1649=g1686*sw;
    g1644=g1649*sw;
    g1171=g1666*g1644;
    g986=g1711*g1171;
    g1640=g1707*g1644;
    g1172=g1666*g1640;
    g985=g1711*g1172;
    g1696=m13sq*m13sq;
    g871=g1696*g1093;
    g1281=g1696*g1662;
    g1663=mz*mz;
    g1107=g1666*g1663;
    g1464=g3hzz*g1hzz;
    g1039=g1464*g1107;
    g1105=g1667*g1662;
    g842=g1663*g1105;
    g1268=g1662*g1650;
    g843=g1268*g1107;
    g800=g1464*g843;
    g1104=g1662*g1170;
    g844=g1663*g1104;
    g801=g1464*g844;
    g1204=g1663*g1110;
    g1725=g1204*g1204;
    g822=g1725*m13sq;
    g802=g822*m23sq;
    g1131=g1666*m13sq;
    g1259=g1707*g1663;
    g1708=g1259*g1259;
    g823=g1708*g1131;
    g803=g823*m23sq;
    g1074=g1686*g1131;
    g1647=g1663*g1663;
    g824=g1647*g1074;
    g804=g824*m23sq;
    g1270=g1663*sw;
    g1274=g1270*g1259;
    g1269=g1707*g1274;
    g1638=g1269*sw;
    g1267=g1707*g1638;
    g825=g1267*g1131;
    g1266=g1707*g1267;
    g826=g1266*g1131;
    g1661=m*m;
    g1089=g1666*g1661;
    g1285=g1663*g1hzz;
    g965=g1285*g1285*g1089;
    g1511=g1662*m12sq;
    g807=g1511*g965;
    g1176=g1663*mw;
    g1687=g1666*ee;
    g1123=g1687*g1176;
    g1038=g1123*g1hzz;
    g808=g1280*g1038;
    g1208=g1hzz*mw;
    g928=g1208*g1110*g1105;
    g809=g1663*g928;
    g1691=g3hzz*g3hzz;
    g1094=g1691*g1107;
    g966=g1662*g1094;
    g1247=g1661*m12sq;
    g813=g1105*m23sq;
    g1132=g1666*m23sq;
    g814=g1268*g1132;
    g815=g1104*m23sq;
    g1103=g1662*g1171;
    g816=g1103*m23sq;
    g1102=g1662*g1172;
    g817=g1102*m23sq;
    g1643=g1663*g1647;
    g1073=g1643*g1089;
    g1250=g1662*m13sq;
    g820=g1250*g1073;
    g1694=g2hzz*g2hzz;
    g1654=g1662*g1662;
    g1510=g1654*g965;
    g827=g1725*m23sq;
    g828=g1708*g1132;
    g829=g1638*g1132;
    g830=g1267*g1132;
    g831=g1266*g1132;
    g1284=g1643*m12sq;
    g832=g1667*g1284;
    g1130=g1666*m12sq;
    g1275=g1643*g1130;
    g833=g1650*g1275;
    g1679=g1708*g1259;
    g834=g1679*g1130;
    g835=g1644*g1275;
    g836=g1640*g1275;
    g1159=g1hzz*m23sq;
    g1097=g1663*g1159;
    g870=g1666*g1097*g1097;
    g1173=g1131*m13sq;
    g1096=g1647*g1173;
    g873=g1711*g1096;
    g1174=g1661*ee;
    g1668=g1174*g1174;
    g997=g1668*g1647;
    g904=g1711*g997;
    g1655=g1687*ee;
    g1164=g1655*mw*mw;
    g908=g1707*g1164;
    g1684=g1667*g1110;
    g1282=g1684*mw;
    g909=g1282*g1110*mw;
    g993=g1691*g1171;
    g994=g1691*g1172;
    g847=g1691*g1105;
    g1106=g1691*g1169;
    g848=g1662*g1106;
    g1091=g1691*g1170;
    g849=g1662*g1091;
    g850=g1707*g1094;
    g851=g1650*g1094;
    g852=g1663*g1091;
    g853=g1694*g1105;
    g1100=g1694*g1169;
    g854=g1662*g1100;
    g855=g1694*g1104;
    g1101=g1110*m23sq;
    g1699=g1101*g1101;
    g859=g1701*g1100;
    g1136=g1701*g1666;
    g1099=g1686*g1136;
    g860=g1694*g1099;
    g1098=g1694*g1173;
    g862=g1650*g1098;
    g1090=g1696*g1170;
    g863=g1694*g1090;
    g922=g1644*g1039;
    g923=g1640*g1039;
    g1161=g1hzz*m13sq;
    g872=g1259*g1161;
    g867=g872*m23sq;
    g1469=g1650*m13sq;
    g869=g1469*g1097;
    g1286=g1707*g1089;
    g1635=g1647*g1647;
    g874=g1635*g1286;
    g1669=g1270*g1270*g1270;
    g1660=g1669*g1270;
    g875=g1660*g1089;
    g1724=g1274*g1274;
    g876=g1724*g1089;
    g877=g1679*g1259*g1089;
    g1723=g1269*g1269;
    g878=g1723*g1089;
    g879=g1654*g988;
    g880=g1654*g987;
    g883=g1650*g1073;
    g884=g1644*g1073;
    g885=g1640*g1073;
    g1671=g1701*m23sq;
    g891=g1686*g1073;
    g1689=g1696*m13sq;
    g1095=g1668*g1643;
    g897=g1707*g1095;
    g898=g1650*g1095;
    g899=g1686*g1095;
    g900=g1644*g1095;
    g901=g1640*g1095;
    g902=g1707*g997;
    g1160=g1hzz*m12sq;
    g903=g1259*g1160;
    g1659=g1661*g1661;
    g1636=g1661*g1659;
    g1179=g1666*g1636;
    g984=g1647*g1179;
    g1331=g1711*g1662;
    g1213=g1687*mw;
    g1071=g1720*g1213;
    g1209=g1663*m12sq;
    g936=g1209*g1071;
    g1070=g1649*g1213;
    g937=g1209*g1070;
    g1154=g1650*m12sq;
    g911=g1154*g1089;
    g1472=g1686*m12sq;
    g912=g1472*g1089;
    g1471=g1644*m12sq;
    g1470=g1640*m12sq;
    g1124=g1666*g1464;
    g1043=g1650*g1124;
    g915=g1701*g1043;
    g916=g1464*g1099;
    g1218=g1696*m23sq;
    g917=g1218*g1039;
    g945=g1667*g1464;
    g1700=m12sq*m12sq;
    g918=g1700*g945;
    g1251=g1700*m23sq;
    g919=g1251*g1039;
    g920=g1650*g1039;
    g921=g1686*g1039;
    g1413=g1662*g3hzz;
    g950=g1413*g1123;
    g924=g1688*g950;
    g1134=g1647*g1213;
    g951=g1662*g1134;
    g1214=g1688*g951;
    g1254=g1154*sw;
    g1253=g1649*m12sq;
    g929=g1159*g951;
    g1122=g1661*g1213;
    g1037=g1647*g1122;
    g1363=g1720*m13sq;
    g1482=g1649*m13sq;
    g1178=m13sq*mw;
    g1665=g1667*m23sq;
    g932=g1665*g1178*g1101;
    g1030=g1038*sw;
    g934=g1218*g1038;
    g1058=g1661*g1282;
    g1024=g1058*m12sq;
    g935=g1663*g1024;
    g962=g1688*g1038;
    g1036=g1700*g1071;
    g1035=g1700*g1070;
    g1409=g3hzz*g2hzz;
    g941=g1667*g1409;
    g1034=g1089*g3hzz;
    g1693=g1209*g1209;
    g1207=g1643*m13sq;
    g943=g1665*g1207;
    g1276=g1662*g1647;
    g944=g1276*g1124;
    g1262=g1662*g1276;
    g946=g1262*g1124;
    g1257=g1647*g3hzz;
    g947=g1257*g1136;
    g948=g1096*g3hzz;
    g1408=g2hzz*g1hzz;
    g949=g1667*g1408;
    g1256=g1684*g3hzz;
    g952=g1256*g1176;
    g1206=g1256*mw;
    g953=g1662*g1206;
    g1072=g1700*g1213;
    g1287=g1643*g1071;
    g1288=g1643*g1070;
    g1205=g1684*g1647;
    g959=g1208*g1205;
    g1221=g1663*m23sq;
    g1704=g1221*g1221;
    g1133=g1696*g1213;
    g1069=g1647*g1133;
    g1109=g1691*g1667;
    g969=g1109*m13sq;
    g970=g1106*m13sq;
    g996=g1691*g1089;
    g971=g1686*g996;
    g972=g996*m23sq;
    g1474=g1700*m13sq;
    g1271=g1701*g1643;
    g974=g1271*g1131;
    g1265=g1696*g1643;
    g975=g1265*g1132;
    g1283=g1635*m13sq;
    g977=g1667*g1283;
    g978=g1660*g1131;
    g979=g1635*g1074;
    g980=g1708*g823;
    g981=g1723*g1131;
    g1248=g1711*m12sq;
    g1084=g1661*g1164;
    g983=g1662*g1084;
    g1175=g3hzz*m12sq;
    g1713=g1175*g1175;
    g1092=g1713*g1666;
    g992=g1701*g1091;
    g995=g1691*g1090;
    g998=g1691*g1668;
    g1633=g1666*g1643;
    g1180=g1663*g1633;
    g999=g1694*g1180;
    g1634=g1663*g1635;
    g1264=g1694*g1634;
    g1000=g1264*g1089;
    g1003=g1643*g1179;
    g1001=g1694*g1003;
    g1258=g1663*g1661;
    g1140=g1663*g1258;
    g1317=g1hzz*sw;
    g1002=g1317*g1140;
    g1212=g1659*g1317;
    g1004=g1663*g1212;
    g1359=g3hzz*m23sq;
    g1005=g1359*g1122;
    g1360=g3hzz*m13sq;
    g1006=g1360*g1122;
    g1009=g1037*m12sq;
    g1007=g1009*g2hzz;
    g1008=g1270*g1122;
    g1088=g1663*g1164;
    g1010=g1662*g1088;
    g1011=g1663*g1084;
    g1047=g1643*g1464;
    g1012=g1131*g1047;
    g1108=g1700*g1643;
    g1087=g1666*g1108;
    g1017=g1650*g1087;
    g1018=g1686*g1087;
    g1019=g1644*g1087;
    g1020=g1640*g1087;
    g1627=g3hzz*sw;
    g1023=g1627*g1122;
    g1166=g1643*g2hzz;
    g1168=m12sq*mw;
    g1025=g1687*g1168*g1166;
    g1626=g2hzz*m12sq;
    g1026=g1626*g1134;
    g1028=g1122*g2hzz;
    g1027=g1643*g1028;
    g1029=g1160*g1134;
    g1184=g1687*sw;
    g1113=g1208*g1184;
    g1031=g1661*g1113;
    g1057=g1643*g1122;
    g1032=g1057*g1hzz;
    g1119=g1659*g1213;
    g1379=g1647*g1hzz;
    g1033=g1379*g1119;
    g1040=g1109*m23sq;
    g1041=g1106*m23sq;
    g1042=g1091*m23sq;
    g1044=g1635*g1124;
    g1198=g1634*g1hzz;
    g1121=g1666*g1198*g2hzz;
    g1120=g1408*g1180;
    g1056=g1072*g3hzz;
    g1060=g1119*g3hzz;
    g1059=g1647*g1060;
    g1061=g1072*g2hzz;
    g1475=g1635*g1hzz;
    g1692=g1725*g1204;
    g1065=g1692*g1208;
    g1118=g1668*g1174*mw;
    g1068=g1379*g1118;
    g1273=g1691*g1130;
    g1272=g1691*g1636;
    g1079=g1264*g1131;
    g1702=g1107*g1107;
    g1081=g1702*g1168*mw;
    g1129=g1164*m12sq;
    g1177=m23sq*mw;
    g1155=g1177*mw;
    g1670=g1089*g1089;
    g1085=g1670*g1155;
    g1156=g1178*mw;
    g1086=g1670*g1156;
    g1165=g1647*g1180;
    g1183=g1184*g3hzz;
    g1112=g1183*g1168;
    g1114=g1168*m23sq;
    g1115=g1168*m13sq;
    g1116=g1636*g1164;
    g1117=g1627*g1118;
    g1203=g1701*m13sq;
    g1157=g1663*g1140;
    g1138=g1661*g945;
    g1137=g1643*g1138;
    g1261=g1661*g1258;
    g1163=g1700*g1663;
    g1162=g1662*g1661;
    g1718=g1161*g1161;
    g1717=g1160*g1160;
    g1716=g1159*g1159;
    g1158=g1661*g1hzz;
    g1714=g1158*g1158;
    g1149=g1663*g1158;
    g1152=g1157*g814;
    g1167=g1256*g1178;
    g1181=g1700*g1666;
    g1192=g1662*g1257;
    g1392=g1701*g3hzz;
    g1187=g1392*g1hzz;
    g1200=g1696*g3hzz;
    g1188=g1200*g1hzz;
    g1296=m23sq*m12sq;
    g1189=g1296*g909;
    g1190=g1247*m13sq;
    g1195=g1689*g3hzz;
    g1196=g1635*g1168*g2hzz;
    g1255=g1635*mw;
    g1435=g1643*m23sq;
    g1201=g1435*g1113;
    g1337=g1720*g1hzz;
    g1217=g1283*g949;
    g1412=g1635*m12sq;
    g1219=g1412*g949;
    g1346=g1647*m12sq;
    g1220=g1346*g945;
    g1222=g1696*m12sq;
    g1249=g1661*m13sq;
    g1252=g1691*m13sq;
    g1368=g1694*g836;
    g1425=g1711*m23sq;
    g1369=g1694*g835;
    g1370=g1694*g834;
    g1371=g1694*g833;
    g1372=g1694*g832;
    g1279=g1663*g1112;
    g1629=m23sq*sw;
    g1487=g1707*g1629;
    g1630=m13sq*sw;
    g1488=g1707*g1630;
    g1295=g1643*g1031;
    g1297=m13sq*m12sq;
    g1304=g1688*g1025;
    g1347=g1661*g1650;
    g1305=g1347*sw;
    g1350=g1707*m12sq;
    g1361=g1350*sw;
    g1316=g1647*g1005;
    g1318=g1644*g999;
    g1320=g1707*g999;
    g1321=g1707*g1661;
    g1322=g1686*g999;
    g1325=g1686*g998;
    g1329=g1647*m23sq;
    g1330=g1647*m13sq;
    g1332=g1650*g2hzz;
    g1334=g1707*g1hzz;
    g1335=g1686*g975;
    g1336=g1650*g1hzz;
    g1338=g1707*g972;
    g1339=g1650*g972;
    g1343=g1661*m23sq;
    g1349=g1636*g945;
    g1351=g1686*g944;
    g1352=g1661*g943;
    g1353=g1688*g1661;
    g1358=g1663*g3hzz;
    g1362=g1662*g1hzz;
    g1364=g1663*m13sq;
    g1366=g1661*g3hzz;
    g1367=g2hzz*m23sq;
    g1518=g1696*g1hzz;
    g1504=g1518*m13sq;
    g1378=g1647*g2hzz;
    g1415=g1175*g2hzz;
    g1414=g1661*g2hzz;
    g1383=g1686*g2hzz;
    g1387=g1686*g1160;
    g1391=g1659*g3hzz;
    g1478=g1060*sw;
    g1394=g1478*m23sq;
    g1395=g1688*g1060;
    g1411=g1662*sw;
    g1410=m23sq*m13sq;
    g1440=g867*g3hzz;
    g1441=g869*g3hzz;
    g1461=g1158*g948;
    g1477=g1061*sw;
    g1481=g1056*sw;
    g1501=g1650*m23sq;
    g1494=g1029*sw;
    g1516=g929*sw;
    g1532=g951*sw;
    g1533=g2hzz*m13sq;
    g1625=g1140*m12sq;
    g1733=g1258*g1258;
    g1914=8.0*g1511*g909-(4.0*g1511*g908);
    g1820=g1914-(32.0*g1285*g1035)+48.0*g1285*g1036-(20.0*g1700*g962);
    g1838=80.0*g1209*g993-(g1088*m12sq)-(32.0*g1209*g994);
    g1768=g1838-g1820-(g1662*g1129)+4.0*(g1494+g1481);
    g1769=64.0*g1288*g1hzz-(96.0*g1287*g1hzz)+40.0*g1065;
    g1910=48.0*g1175*g1071-(32.0*g1175*g1070);
    g2015=4.0*g1112;
    g1875=-g2015-g1910;
    g1770=4.0*g1875+96.0*(g970+g1041);
    g1771=16.0*g1189-(8.0*g1296*g908);
    g1935=g1768-(24.0*g1650*g1092)+4.0*g1707*g1092;
    g1772=g1935+256.0*g1368-(640.0*g1369)+544.0*g1370-(192.0*g1371)+32.0*g1372;
    g1773=16.0*(-g969-g1040);
    g1874=80.0*g1662*g993-(32.0*g1662*g994);
    g1774=g1874-(68.0*g849)+24.0*g848-(4.0*g847);
    g1810=80.0*g1281*g986-(68.0*g1281*g987)+24.0*g1281*g988-(4.0*g1662*g871)-(
     32.0*g1281*g985);
    g1862=80.0*g1280*g986-(68.0*g1662*g868)+24.0*g1280*g988-(4.0*g1662*g866)-(
     32.0*g1280*g985);
    g1802=g1862+g1810;
    g2010=48.0*g915;
    g1942=g2010-(136.0*g916);
    g1775=g1802-g1942;
    g1776=8.0*(g849+g847)-(16.0*g848);
    g1777=32.0*g836-(80.0*g835)+68.0*g834-(24.0*g833)+4.0*g832;
    g1853=8.0*g909-(4.0*g908);
    g1973=4.0*g1853;
    g1795=g1973+32.0*g1654*g985-(80.0*g1654*g986);
    g1934=32.0*g994-(80.0*g993);
    g1778=4.0*g1934+g1795+68.0*g880-(24.0*g879);
    g1779=4.0*(g1510*m13sq+g1510*m23sq)+24.0*(g1247*g873+g1247*g870)+16.0*(g1511
     *g904-(g1331*g984))+32.0*(g1248*g984-(g1247*g966)-(g1647*g1092))-(64.0*
     g1694*g820)-(192.0*g1264*g1130)-(128.0*g1264*g1132);
    g1780=4.0*(-(g1689*g1093)-(g1671*g1093))+24.0*(g1689*g988+g1671*g988)+68.0*(
     -(g1689*g987)-(g1671*g987))+80.0*(g1689*g986+g1671*g986)+32.0*(-(g1689*g985
     )-(g1671*g985));
    g1781=1280.0*g1644*g1120-(1088.0*g1686*g1120)+384.0*g1650*g1120-(512.0*g1640
     *g1120);
    g1782=4.0*g808*sw-(12.0*g934*sw);
    g1818=160.0*g980-(136.0*g979)+48.0*g978-(64.0*g981);
    g1863=320.0*g877-(128.0*g878);
    g1892=272.0*g876-(96.0*g875)+16.0*g874;
    g1783=g1892-g1863+g1818;
    g1784=96.0*g1425*g833-(16.0*g1425*g832)+512.0*g1368*m23sq-(1280.0*g1369*
     m23sq)+1088.0*g1370*m23sq-(384.0*g1371*m23sq)+64.0*g1372*m23sq+320.0*(g1425
     *g835+g1644*g919)+128.0*(-(g1425*g836)-(g1640*g919))-(272.0*g1425*g834);
    g1871=80.0*g825*m23sq-(32.0*g826*m23sq);
    g1785=68.0*g804-(24.0*g803)+4.0*g802-g1871;
    g1827=96.0*g1720*g1029-(64.0*g1649*g1029);
    g1786=g1827+256.0*g1649*g1026-(384.0*g1720*g1026)+160.0*g1688*g1026-(40.0*
     g1688*g1056);
    g1787=8.0*(g1086+g1085)-(32.0*g1117);
    g1811=16.0*g851+8.0*(g952-g852-g850);
    g1846=g1811-(8.0*g953);
    g1861=-(4.0*g1662*g1030)-(8.0*g1464*g842);
    g1788=g1861+g1846+4.0*g809-(8.0*g801)+16.0*g800;
    g1789=640.0*g900-(256.0*g901);
    g1790=16.0*g1863+768.0*g898;
    g1965=8.0*g1640*g1121-(20.0*g1644*g1121)+17.0*g1686*g1121-(6.0*g1650*g1121)+
     g1634*g949;
    g1791=-(64.0*g1965)-(4.0*g1081);
    g1873=192.0*g885-(480.0*g884);
    g1792=4.0*(-g1873-g1785);
    g1837=2.0*(g983-g1011);
    g1859=1280.0*g1318-(512.0*g1640*g999);
    g2018=48.0*g1707*g998;
    g1793=g2018+g1859+g1837+g1781+g1769-(120.0*g935*g1hzz)+24.0*g1160*g1008-(4.0
     *g1279)-(32.0*g1157*g949)-(96.0*g1650*g998)+8.0*(g1220-(g1663*g918))+48.0*(
     g1478-(g1261*g945));
    g2023=40.0*g928;
    g1901=-g2023-g1778-(4.0*g1654*g1093);
    g2004=48.0*g1031;
    g2006=64.0*g1699*g1694;
    g1794=g2006+g2004+g1901+1088.0*g860-(384.0*g859);
    g1867=68.0*g852-(24.0*g851)+4.0*g850;
    g1809=g1867+20.0*(g959-g953);
    g1796=g1861+g1809+20.0*g809-(136.0*g801)+48.0*g800;
    g1797=48.0*(g995+g992);
    g1841=96.0*g826*m12sq-(240.0*g825*m12sq)+204.0*g824*m12sq-(72.0*g823*m12sq)+
     12.0*g822*m12sq;
    g2021=144.0*g883;
    g1798=g1841-g2021;
    g1799=1280.0*g1259*g834-(1088.0*g1724*g1130)+384.0*g1660*g1130-(512.0*g1723*
     g1130);
    g1823=g1863-(48.0*g897);
    g1800=2.0*g1789-(832.0*g899)-(128.0*g898)+1472.0*g876-(1152.0*g875)+448.0*
     g874-(4.0*g1823);
    g1801=96.0*g1337*g951-(64.0*g1649*g951*g1hzz);
    g1916=68.0*g868+4.0*g866;
    g1803=g1916+4.0*g871;
    g1845=6.0*g1779+384.0*(g1408*g1165-(g1693*g1034*g2hzz));
    g1848=32.0*g1272*g1130+4.0*(-(g1689*g1273)-(g1671*g1273));
    g1804=6.0*g1848+g1845-(96.0*g1691*g997);
    g1829=160.0*g922*m12sq-(64.0*g923*m12sq);
    g1805=g1910+g1829;
    g1819=96.0*g831*m12sq-(240.0*g830*m12sq)+204.0*g829*m12sq-(72.0*g828*m12sq)+
     12.0*g827*m12sq;
    g1978=2.0*g1777;
    g1806=g1819-g1978;
    g1967=g1475*g1070-(1.5*g1475*g1071);
    g1807=64.0*g1967;
    g1808=640.0*g1019-(544.0*g1018)+192.0*g1017-(256.0*g1020);
    g1830=1024.0*g1001-(256.0*g1464*g984);
    g1852=512.0*g1694*g1165-(128.0*g807*m23sq);
    g1821=32.0*g826-(80.0*g825);
    g1814=g1821+68.0*g824-(24.0*g823)+4.0*g822;
    g1815=32.0*g831-(80.0*g830);
    g1894=g1815+68.0*g829-(24.0*g828)+4.0*g827;
    g2002=8.0*g1113;
    g1923=g2002+16.0*g945;
    g1816=320.0*g1644*g1124-g1923-(128.0*g1640*g1124);
    g1817=320.0*g1644*g1012-(272.0*g1686*g1012)-(128.0*g1640*g1012);
    g1847=80.0*g924-(4.0*g1010);
    g1822=g1847+3.0*g1769+4.0*(g983+g1011);
    g1824=-g1788-g1776;
    g1825=96.0*g1254*g951-(40.0*g1214*m12sq)-(64.0*g1253*g951);
    g2013=4.0*g1084;
    g1826=-g2013-(8.0*g1875);
    g1885=136.0*g921-(48.0*g920);
    g1932=160.0*g922-(64.0*g923);
    g1828=g1885-g1853-g1932;
    g1905=g1934+g1853;
    g2022=4.0*g1030;
    g1832=g1905-g2022;
    g1865=48.0*g1720*g1069-(32.0*g1649*g1069);
    g1891=96.0*g1363*g1037-(64.0*g1482*g1037);
    g1971=2.0*g1891;
    g1833=g1865-g1971;
    g1907=4.0*g962-(8.0*g921);
    g1893=g1907+16.0*g920;
    g1834=32.0*g1030-(8.0*g1893);
    g1903=-g2015-g1805;
    g1868=-g1903-(2.0*g1084)-(8.0*g971);
    g2014=8.0*g1023;
    g2005=64.0*g1707*g1098;
    g1836=g2005+1088.0*g863-(384.0*g862);
    g1839=32.0*g1704*g1070-(48.0*g1704*g1071);
    g1866=1280.0*g1694*g1103-(512.0*g1694*g1102);
    g1840=1088.0*g855-(384.0*g854)+64.0*g853-g1866;
    g2017=8.0*g983;
    g1842=g2017-(4.0*g1914);
    g1843=544.0*(-(g1686*g820)-(g1157*g815));
    g1844=128.0*g1640*g1044-(320.0*g1644*g1044)+272.0*g1686*g1044;
    g1849=640.0*g1157*g816-(256.0*g1157*g817);
    g1850=g1789-(544.0*g899)+192.0*g898;
    g1851=64.0*g1662*g1288-(96.0*g1662*g1287);
    g1854=128.0*g1647*g1035-(192.0*g1647*g1036)+80.0*g1274*g1072;
    g1855=64.0*(g1166*g1119+g1635*g1028);
    g1890=48.0*g936-(32.0*g937);
    g1919=32.0*g1035-(48.0*g1036);
    g1856=-g1919-g1890;
    g1889=16.0*(-(g966*m13sq)-(g966*m23sq));
    g1987=8.0*g1280*g1039;
    g1857=24.0*g917-g1987-(2.0*g1889);
    g2026=32.0*g814;
    g2027=16.0*g813;
    g1858=g2027-g2026+16.0*g815;
    g1888=g1774+20.0*g952;
    g1860=g1888-(6.0*g1084)-(24.0*g1023);
    g1864=16.0*g1855+768.0*g1057*g3hzz+128.0*(g1059-g1068);
    g1869=12.0*g1805-(88.0*g959);
    g2011=48.0*g970;
    g1870=8.0*g969-g2011;
    g1877=160.0*g816-(64.0*g817);
    g1876=g1877-(136.0*g815)+48.0*g814-(8.0*g813);
    g1887=g1987+g1889;
    g1878=96.0*g946-(6.0*g1887);
    g1945=128.0*g1470*g1089-(320.0*g1471*g1089);
    g1989=384.0*g1032;
    g1880=512.0*g1027-g1989-(192.0*g1033);
    g1886=32.0*(-g870-g873);
    g1900=32.0*g985-(80.0*g986)-(24.0*g988);
    g1882=g1900+68.0*g987;
    g1883=4.0*g1164+16.0*g1109;
    g1884=32.0*g959-(6.0*g1805);
    g1895=16.0*(g1161+g1159);
    g1896=80.0*g1026-(20.0*g1056)-(48.0*g1060);
    g1897=16.0*(-g1297-g1296);
    g1899=256.0*g1640*g2hzz-(640.0*g1644*g2hzz);
    g1898=-g1899-(544.0*g1383);
    g1902=g2011-(24.0*g969);
    g1904=48.0*g1297*g1005-(16.0*g1059);
    g1906=g1850-(32.0*g897);
    g1908=384.0*g999-(32.0*g944);
    g1909=192.0*g1025-(1.5*g1880);
    g1911=g1873+408.0*g891-g2021;
    g1912=g1857+32.0*g946;
    g1913=g1833-g1839;
    g1915=g1934-g1828;
    g2001=8.0*m13sq;
    g1918=g2001+8.0*m23sq;
    g1921=12.0*g934-(4.0*g808);
    g2003=96.0*g1043;
    g1991=16.0*g1005;
    g1925=g1991+16.0*g1006;
    g1927=32.0*g1662*g937-(48.0*g1662*g936);
    g1926=4.0*g1927-(80.0*g935);
    g1940=32.0*(-g1360-g1359);
    g1939=72.0*(g975+g974);
    g1933=g1783-(8.0*g977);
    g1936=-g2013-(272.0*g971);
    g1938=g2003+g1816;
    g1946=g1878+144.0*g917;
    g1947=24.0*g916-g2010;
    g1975=2.0*g1825;
    g1949=4.0*g1820-(32.0*g924);
    g2025=16.0*g902;
    g1951=8.0*(-g1195-(g1671*g3hzz));
    g1952=128.0*g1070-(192.0*g1071);
    g1998=16.0*g1209;
    g1960=g1825-g1851;
    g1961=g1897+32.0*g1247;
    g1964=2.0*g1025*sw+4.0*g1108*g949-(16.0*g1649*g1025);
    g1966=2.0*g1251*m13sq+3.0*g1203*m12sq;
    g1968=g1640*g1160-(2.5*g1644*g1160);
    g1969=1.5*g1254-g1253;
    g1970=4.0*g1899;
    g1972=3.0*g1868;
    g1974=2.0*g1839;
    g1976=4.0*g1824;
    g1977=4.0*g1796;
    g1979=4.0*g1777;
    g1980=4.0*g1774;
    g1981=16.0*g1072;
    g1982=3.0*g1218*m12sq;
    g1983=4.0*g1155;
    g1984=96.0*g929;
    g1985=16.0*g1002;
    g1986=64.0*g941;
    g1988=32.0*g1221;
    g1990=16.0*g1026;
    g1992=24.0*g1005;
    g1993=8.0*m12sq;
    g1994=24.0*m12sq;
    g1995=96.0*g807;
    g1996=96.0*g1391;
    g1997=384.0*g1332;
    g1999=48.0*g903;
    g2000=16.0*g822;
    g2007=40.0*g959;
    g2008=80.0*g1167;
    g2009=32.0*g918;
    g2012=64.0*g1649*g929;
    g2016=16.0*g1006*sw;
    g2019=384.0*g1000;
    g2020=32.0*g1157*g813;
    g2024=64.0*g949;
    g2028=-(20.0*g1168);
    g2042=cw*cw*cw;
    g1658=g2042*g2042;
    {
        t0=160.0*(-(g1247*g924)-(g1669*g1061))+32.0*(g1262*g1138+g1196*g1184-(
         g1411*g1025))+16.0*(g1276*g918+g1255*g1183)+24.0*(g1933*g1694*m12sq+
         g1212*g951)+2.0*(g1875*g1250*m23sq+g1916*g1364*g1364-(g1870*g1700*g1661
         ))+4.0*(g1828*g1700*g1249-(g1805*g1661*g1162)+g1856*g1391+g1829*g1162*
         m13sq+g1915*g1247*g1247)+g1882*(4.0*g1261*g1261+8.0*g1733*g1258)+g1876*
         (3.0*g1149*g1149+g1379*g1379+g1252*m12sq-(4.0*g1378*g1175)-(g1643*g1248
         )+2.0*(-(g1257*g1160)-(g1711*g1207)-(g1691*g1247))+8.0*(g1166*g1161+
         g1694*g1207-(g1635*g1408)-(g1694*g1157)-(g1378*g1378)))+(-(1.33333*
         g1939)-(256.0*g820))*(g1337*g1337-(2.5*g1336*g1336))+g1939*(g1334*g1334
         -(17.7778*g1332*g1332)+7.11111*g1694*g1640);
        t0=t0+g1893*(6.0*g1249*g1249-(g1689*g1661)-(g1671*g1661))+g1777*(2.0*
         g1711*g1250+32.0*(g1659*g1408-(g1694*g1249)-(g1533*g1158))+8.0*(g1367*
         g1367+g1711*g1249)-(16.0*g1662*g1409))+(128.0*(g944+g904-g972)-g1886)*(
         g1254*g1254-(2.5*g1154*g1154))+(144.0*g911-(24.0*g1286*m12sq)-(1.5*
         g1945)-(408.0*g912))*(g1360*g1360+g1359*g1359+2.0*g1252*m23sq+1.33333*
         g1192*g1hzz+2.66667*(g1358*g1358+g1192*g2hzz))+(g2025+2.0*g1785)*(g1717
         +2.0*g1160*g3hzz-(8.0*g1415))+(g1868+g1129+16.0*g1650*g996+8.0*(g1663*
         g1138-(g1707*g996))-g2014)*(g1689+g1671)+(g1852+1.33333*g1845-g1830-(
         1024.0*g1079)+128.0*(g1474*g996-(g807*m13sq)))*(2.5*g1644-g1640)+(64.0*
         g1007+32.0*g1027-(8.0*g1033))*(g1630+g1629);
        t0=t0+g1853*(8.0*g1647*g1297-(16.0*g1625)+6.0*(-(g1661*g1222)-(g1701*
         g1247))+4.0*(g1329*m13sq+g1663*g1190+g1654*g1209-(g1661*g1251)-(g1662*
         g1163)-(g1140*m13sq))-(g1696*g1209)-(g1701*g1209))+64.0*(g948+g947)*(
         g1968+3.0*g1154*g2hzz-(2.0*g1640*g1158)+5.0*g1644*g1158)+g1918*(g1964+
         8.0*g1157*g941+2.0*g1707*g807+g1081-(10.0*g1304)+12.0*(g1137-g1117))+
         g1927*(4.0*(g1158*m13sq+g1158*m23sq-(g1659*g1hzz))-g1518)+(-(960.0*
         g1160)-(1152.0*g1159))*(1.33333*g981*g2hzz-(3.33333*g980*g2hzz)+2.83333
         *g979*g2hzz-(g978*g2hzz));
        t0=t0+g1895*(96.0*g901*g2hzz-(240.0*g900*g2hzz)+196.0*g899*g2hzz-(56.0*
         g898*g2hzz)+4.0*g897*g2hzz+16.0*g1020*g2hzz-(40.0*g1019*g2hzz)+34.0*
         g1018*g2hzz-(12.0*g1017*g2hzz)+48.0*g885*g3hzz-(120.0*g884*g3hzz)+102.0
         *g891*g3hzz+60.0*g835*g3hzz-(51.0*g834*g3hzz)+18.0*g833*g3hzz-(3.0*g832
         *g3hzz)+g1700*g1008+24.0*(g1659*g937-(g836*g3hzz))+36.0*(-(g883*g3hzz)-
         (g1659*g936)))+(20.0*g1895+320.0*g1160)*(8.0*g878*g2hzz-(20.0*g877*
         g2hzz)+17.0*g876*g2hzz-(6.0*g875*g2hzz)+g874*g2hzz)+g1877*(4.0*g1175*
         g1149-(2.0*g1358*g1160*m13sq))+4.0*(-g1894-g1814)*(g1691*g1661+g1717*
         g1661+2.0*(g1175*g1158+g1700*g1409+g1711*g1636)-(8.0*g1414*g1175))+
         g1952*(g1207*g3hzz-(g1410*g1257)-(g1635*g3hzz)-(2.0*g1412*g2hzz));
        t0=t0+g1890*(12.0*g1410*g1158+8.0*g1636*g1hzz+6.0*(g1696*g1158+g1701*
         g1158)+4.0*(g1249*g3hzz+g1343*g3hzz))+g1940*(32.0*g885*g2hzz-(80.0*g884
         *g2hzz)+62.0*g891*g2hzz-(12.0*g883*g2hzz))+(-g1940-(64.0*g1366))*(8.0*
         g836*g2hzz-(20.0*g835*g2hzz)+17.0*g834*g2hzz-(6.0*g833*g2hzz)+g832*
         g2hzz)+(96.0*g3hzz-(128.0*g1367))*(8.0*g1158*g836-(20.0*g1158*g835)+
         17.0*g1158*g834-(6.0*g1158*g833)+g1158*g832)+g1898*(4.0*g1175*g997+g948
         *m12sq+g947*m12sq)+(g1975+g1854)*(g1533-(2.0*g1414)+g1367)+(4.0*g1008-
         g1890)*(g1504+g1671*g1hzz+3.0*g1701*g1161)+(g1885-g1832-(20.0*g962))*(
         8.0*g1636*m12sq-(g1689*m12sq)-(g1671*m12sq))+g1834*1.5*(g1636*m13sq+
         g1636*m23sq)+(224.0*g1027-(240.0*g1032)-(320.0*g1007))*(g1488+g1487);
        t0=t0+g1878*(3.33333*g1471-(1.33333*g1470))+(g1923-g2003)*(3.0*g1635*
         m23sq-(g1662*g1635))+16.0*(-g1115-g1114)*(3.0*g1687*g1004+g1687*g1002+
         10.0*g1205*g3hzz)+(512.0*g3hzz+128.0*g1159)*(g1649*g1009-(1.5*g1720*
         g1009))+288.0*(g1188+g1187)*(2.83333*g1663*g912-(g1663*g911))+g1945*(
         g1691*g1221+g1663*g1252)+(48.0*g1297-g1998)*(2.0*g1659*g909-(g1659*g908
         ))+g1897*(102.0*g1659*g921-(36.0*g1659*g920)-(24.0*g1659*g994)+60.0*
         g1659*g993-(51.0*g1325)+15.0*(g1395-(g1659*g962)))+g1911*(2.0*g1711*
         g1410-(2.66667*g1700*g1408))+(8.0*g1777-(1056.0*g891)+320.0*g883-(
         2.66667*g1873))*(g1696*g1408+g1701*g1408)+(g1856+120.0*g1024-(8.0*g1008
         ))*(g1392+g1200);
        t0=t0+g1814*(8.0*g1662*g1415+g1711*g1671-(6.0*g1714*g1662)-(7.0*g1716*
         g1661)+4.0*(g1413*g1160+g1187))+g1894*(g1504*g1hzz-(7.0*g1718*g1661)+
         4.0*g1188)+g1965*(16.0*g1918+128.0*m12sq)+(8.0*g1925+128.0*g950)*(g1700
         *g1649-(1.5*g1254*m12sq))+g1925*(12.0*g1662*g1254+5.0*(g1361*m12sq+
         g1274)-(8.0*g1662*g1253))+g1969*(g1989-(8.0*g1921))+g1785*(-(12.0*g1711
         *g1247)-(2.0*g1662*g1248))+g1966*g1832+g1967*(-(24.0*g1918)-(256.0*
         m12sq))+m12sq*(g1782+12.0*g1086)+sw*(16.0*(g1068-g1316)-g1904-g1855)+
         m13sq*(g2012+g1784+96.0*g1394+g1983*g1702+32.0*g1270*g1060)+m23sq*(3.0*
         g1844+4.0*g1817+48.0*g1295-(160.0*g1219))+g3hzz*(g2028*g1699*g1101+64.0
         *g1336*g984-g1975-g1971-(2.0*g1854));
        t0=t0+g932*(-(12.0*g1149)-(40.0*g1379)-(60.0*g1175))+g1004*(-g1981-(24.0
         *g1133))+g1047*(-(2.0*g1876)-(272.0*g1090))+g1058*(240.0*g1475-g1951)+
         g1074*(2176.0*g1264-(96.0*g1272))+g1085*(12.0*m12sq+24.0*m13sq)+g1116*(
         -g1993-(3.0*g1918))+g1982*g1905+g1140*(g1780+4.0*g1776-(256.0*g916)+
         64.0*g915-(2.0*g1802))+g1711*g1162*(8.0*g1785-g1979)+g1154*(g1946-(48.0
         *g948*g1hzz))+g1157*(224.0*g928+384.0*g880-(96.0*g879)+128.0*(g862+g859
         )+64.0*(-g863-g860)+6.0*(g1803+g1795)-g2006-g2005)+g1158*(g1974-(2.0*
         g1865)+6.0*g1851-(192.0*g943*g2hzz)-g1975)+g1159*(g1960+2.0*g1833+8.0*
         g1069*sw)+g1913*g1160+g1161*(g1960-g1974)+g1163*(g1942+4.0*g1874)+g1164
         *(g1982+g1966);
        t0=t0+g1166*(160.0*g1024-(64.0*g1667*g1166)-(8.0*g1919))+g1181*(96.0*
         g1441-(16.0*g1440))+g1190*(g1977-g1980)+g1692*g3hzz*80.0*(g1168+g1177)+
         g1636*g1256*(160.0*g1168+96.0*g1177)+g1684*g1255*(-(7.5*g1895)-(80.0*
         g3hzz)-(160.0*g1160))+g1198*(g1952+80.0*g1282)+g1201*(-g1994-(32.0*
         m13sq))+g1923*g1662*g1207+g1972*g1203+g1207*(g1794-(g1994*g1113)-(3.0*
         g1916))+g1209*(g2017+g2016)+g1217*(-(160.0*m12sq)-(192.0*m23sq))+g1218*
         (g1972-g2007)+g1221*(g1842+96.0*g1349-(g2001*g1112))+g1222*(g1860-g1796
         -(72.0*g1041)+12.0*g1040)+g1947*g1663*g1249+g1858*g1691*g1249+g1249*(
         g1949-(96.0*g1189))+g1251*(g1936+g1870)+g1258*(8.0*g1914+2.0*g1771)+
         g1666*g1633*(-g1983-(4.0*g1156))+g1261*(-g2009-(2.0*g1947))+g1938*g1265
         ;
        t0=t0+g1816*g1271+g1661*g1157*(-g1840-(48.0*g1113))+g1280*(g2014+g1875)+
         g1281*(g2014+g1903)+g1283*(3.0*g1923+g1840)+g1284*(g2004-g1973)+g1896*
         g1487*m23sq+g1488*m13sq*(g1992+g1896)+g1296*(g2018+3.0*g1859+g1822-(
         3264.0*g1322)-(192.0*g1320)+204.0*g995)+g1297*(g1822+204.0*g992+48.0*
         g1159*g1008)+g1305*(g1984-(384.0*g1025))+g1701*g1661*(g1902+g1884+g1846
         +g1776)+g1696*g1661*(g1884-g1824)+g1857*g1321+g1329*(g1826+2.0*g1810-
         g2008)+g1330*(2.0*g1862+g1826)+g1331*(g1933-g1906)+g1343*(g1949+24.0*
         g1343*g962)+g1662*g1162*(4.0*g1811-(16.0*g959))+g1346*(g1980-g1780+
         g1775-(g2024*g1346))+g1347*(-(2.0*g1912)-(192.0*g919))+g1686*g1661*(
         g1912+544.0*g919)+g1887*g1350+g1353*(340.0*g1353*g873-g1921);
        t0=t0+g1359*(g1926+128.0*g1288-(192.0*g1287))+g1360*(g1926+1632.0*g1097*
         g912)+5.0*g1921*g1361+g1891*g1362+g1363*(g1909+64.0*g1363*g870-g1984)+
         g1364*(g1842-g1771)+g1661*g1635*(2.0*g1866-(2304.0*g855)+1024.0*g854-(
         256.0*g853))+g1366*(24.0*g932-(32.0*g1214)-(8.0*g1927))+g1177*g1131*ee*
         (-g1985-(48.0*g1004))+g1413*g1158*(4.0*g1821+240.0*g824-(32.0*g823)-
         g2000)+g1411*m12sq*(g1925-(16.0*g1060))+12.0*g1907*g1659*g1410+g1694*
         g1410*(1024.0*g883-(5.33333*g1873)-(2304.0*g891))+g1408*(g2020-(4.0*
         g1849)-(3.82353*g1843)-(576.0*g1152)+1088.0*g1335)+g1409*(3968.0*(g899+
         g876)+128.0*(-g897-g874)-(2.0*g1808)-g1799-g1790-(8.0*g1789)-(768.0*
         g875));
        t0=t0+g1410*(g1786+4.0*g1769+96.0*(g1325-g1395)+2.0*(g1837+g1768)-(32.0*
         g1026*sw))+g1412*(g1986+4.0*g1923+g1840)+g1425*(1.5*g1906-g1933)+g1951*
         g1666*g903+g1643*g949*64.0*(g1218+g1203)+g1435*(g1901+g1836-(12.0*g871)
         )+g1643*g1183*16.0*(-g1178-g1177)+g1464*(3.0*g1906+g1808-g1799-(6.0*
         g1783)-(64.0*g943))-(2.83333*g1946*g1472)+g1701*m12sq*(1.5*g1870+g1860-
         g1809)+g1474*(g1936+136.0*g1042)+g1477*16.0*(-g1330-g1329)+g1478*(g1988
         -(3.0*g1897)-(32.0*g1250)-g1998)+g1688*g3hzz*(320.0*g1009-(384.0*g1057)
         )+g1880*g1482+g1643*g1hzz*(4.0*g1919-(240.0*g1024))+g1701*g1034*(g1999+
         24.0*g872)+g1501*sw*(g1909+768.0*g1007)+g1649*m23sq*(g1880-(512.0*g1007
         ))+g1629*m23sq*(-g1990-(24.0*g1006));
        t0=t0+g1630*m13sq*(-g1992-g1990)+g1659*sw*64.0*(-g1026-g950)+g1659*m23sq
         *(g1869+4.0*(-g1902-g1788))+g1659*m13sq*(g1976+g1869)+g1501*(384.0*
         g1012-g1995)+g1654*g3hzz*(4.0*g1890-(32.0*g1008))+g1700*sw*(-g1991-(
         16.0*g950))+g1694*m23sq*(24.0*g1818+g1800-(192.0*g977))+g1659*m12sq*(
         4.0*g1888+6.0*g1870-g1977)+g1654*m12sq*(g2007+4.0*g1867-(80.0*g952))+
         g1516*(g1993-g2001)+g1686*m13sq*272.0*(g807-g919)+g1800*g1694*m13sq+
         g1711*m13sq*(1.5*g1850+g1823-g1892)+g1359*m13sq*(2.0*g1856+16.0*g1134*
         sw)-(g1961*g1532*g2hzz)+g1532*m13sq*8.0*(g1160-g1158)+g1533*g1159*(16.0
         *g1777-(4288.0*g891)+1408.0*g883-(10.6667*g1873))+g1532*(32.0*g1366+
         16.0*(-g1175-(g1158*m12sq)));
        t0=t0+g1464*g1140*(240.0*g815-g2027-g2026-(2.0*g1877))+g1154*g997*(768.0
         *g1409-(192.0*g1464))+g1130*g872*(-g1996-(24.0*g1392))+g1391*g1hzz*(
         160.0*(-g823-g828)+752.0*(g824+g829)+12.0*(g1821+g1815)-g2000-(16.0*
         g827))+g1132*g903*(-g1996-(24.0*g1200))+g997*g3hzz*(256.0*g1968+544.0*
         g1387)+g974*g1hzz*(-g1997-(2.0*g1898))+g975*g1hzz*(2.0*g1899-g1997)+
         g820*g1hzz*(g1970-(576.0*g1332))+g1003*g1hzz*(512.0*g1332-g1970-(2048.0
         *g1383))+g1362*g3hzz*(g1792-(1600.0*g891)+512.0*g883+48.0*g902)+g1362*
         g2hzz*(g1790+6.0*g1789-(3072.0*g899)-(4288.0*g876)+1408.0*g875-(192.0*
         g874)-(8.0*g1818)-g1799)+g950*sw*(g1961+32.0*(g1249+g1343))+g928*m13sq*
         (40.0*g1329-(24.0*g1140));
        t0=t0+g1296*m13sq*(40.0*g952-(12.0*g1084)-(2.0*g1796))+g1005*m13sq*(-(
         384.0*g1969)-(16.0*g1270))+g1005*sw*(g1998+16.0*g1250)+g1249*m23sq*(2.0
         *g1788+144.0*g959-(12.0*g1829))+g1977*g1247*m23sq+3.0*g1942*g1209*m13sq
         +g908*m23sq*(48.0*g1190+16.0*g1140)+g1179*g3hzz*(64.0*g903+96.0*g872)+
         2.5*g1799*g1159*g2hzz+g1159*m13sq*(-(2.0*g1927)-(240.0*g935))+g1158*
         g3hzz*(16.0*g1871-(1056.0*g804)+320.0*g803-(32.0*g802))+g1140*m23sq*(-(
         24.0*g928)-(32.0*g909))+g1626*4.0*(g1851-g1913)+g1034*m12sq*(96.0*g867+
         32.0*g872*m12sq-(576.0*g869))+g1154*m23sq*(1152.0*g999-(288.0*g998))+
         g1634*(2.0*g1938-g1840)+g1635*(g1883-g1836+g1803-g1794+272.0*g1091-(
         96.0*g1106));
        t0=t0+g1636*(6.0*g1773+2.0*g1770+48.0*g959+96.0*(g1167-g1042)+8.0*(-
         g1829-g1088)-g1976)+g1643*(g2008+g1780-(2.0*g1775)+g1773+g1770+32.0*
         g1477-(272.0*g1042)-(4.0*g1129)-(g1981*g1317)-g2009)+g1647*(g1842+4.0*
         g1771+32.0*(g1349+g1481-(g1222*g941))+g2002*g1203-g2016)+g1649*(128.0*
         g1316-g1864)+g1650*(g1804+64.0*g1461-(256.0*g1001)+768.0*(g1000-g1079))
         +g1654*(16.0*(g1279-g1220)+8.0*(-g1011-g1494)+g1985*g1213-(4.0*g1838)-
         g1827)+g1655*(g1114*g1114+g1115*g1115)+g1661*g1636*(4.0*g1883-g1834-(
         128.0*g1106)+64.0*(g1091+g1183*mw-g1206))+g1659*(g1797+2.0*g1786+5.0*
         g1781+4.0*g1772+2496.0*g1322-(576.0*g1320)-(16.0*g1010)+64.0*g924-(
         208.0*g1351)-(3840.0*g1318)+6.0*(g1771+g1769)-g1801);
        t0=t0+g1661*(6.0*g1807+4.0*g1791-(2.0*g1784)-g1782-(8.0*g1516)+g1988*
         g918-g2012-(16.0*g1964))+g1662*(g1807+g1791-g1787+160.0*g1304+64.0*(
         g1219+g1217-g1137)+32.0*(-g1295-g1394)+8.0*(g1116+g1201)-g1844-g1817)+
         g1663*(g1787+60.0*g1160*g932-(64.0*g1661*g1349)-(544.0*g1647*g1638*
         g1124))+g1663*g1634*(384.0*g1100-g2024)+g1666*(16.0*g1004*g1004+g1985*
         g1002-(48.0*g867*g867)-(160.0*g869*g869))+g1668*(192.0*g1441+96.0*(-
         g1440-(g903*g903)))+g1670*(4.0*g1176*g1176+12.0*(g1177*g1177+g1178*
         g1178))+g1684*(g2028*g1195-(60.0*g1200*g1114)-(160.0*g1196))+g1686*(
         1.875*g1830-(2.83333*g1804)-(256.0*g1461)-g2019-(2.125*g1852))+g1688*(
         5.0*g1904-(7.0*g1855));
        t0=t0+g1691*(g2025-g1979-g1792+1536.0*g891+2.66667*(g1819+g1798)-(272.0*
         g1643*g1074))+g1693*(8.0*g1853+g1803+32.0*g1028*sw-g2023)+g941*m12sq*(
         64.0*g1625-(32.0*g1704))+g1696*(g1793+g1772+48.0*g1339-(24.0*g1338)+
         g1999*g1034)+g1700*(g1847+g1801+1.41667*g1797+g1781+96.0*g1339-(16.0*
         g1338)+80.0*g1065+272.0*(g1351+g1325)+8.0*g1317*g951-g2016)+g1701*(
         g1935+g1793-(24.0*g1213*g1004))+g1168*g1168*(4.0*g1670+8.0*g1702)+g1707
         *(128.0*(g1079-g1001)-g2019-g1848-g1779)+g1711*(g1849+g1843+48.0*g1352+
         192.0*g1152-(204.0*g1335)-g2020)+g872*g872*(-(120.0*g1668)-(24.0*g1181)
         )+g1713*(96.0*g843-(16.0*g842)-(272.0*g844))+g1714*(14.0*g1785+4.0*(
         g1841+g1806))+g1716*(g1873+g1798-g1978)+g1718*(g1911+g1806);
        t0=t0+1.5*g1864*g1720+g1296*g1296*(g1932+g1832)+g1297*g1297*(g1915-g2022
         )+g1733*(5.0*g1803+g1778+8.0*g928)+g1366*g1366*(128.0*g843+64.0*(-g844-
         g842)-(2.0*g1858))+g1321*g1321*(g1908-(120.0*g870))+g1305*g1305*(4.0*
         g1908-(5.0*g1886))+g1350*g1350*(-(24.0*g870)-(96.0*g944))+g1347*g1347*(
         12.5*g1886+320.0*g944)+g1329*g1329*(g1900-g2024)+g1330*g1330*(g1882-
         g2024)+g1334*g820*(192.0*g1334+32.0*g2hzz)+g1140*g1140*(4.0*g1882-(
         320.0*g949))+g1362*g1362*(g1785+g1777+4.0*g902)+g1361*g1361*(272.0*g904
         +68.0*g873)+g1317*g1317*32.0*(g1003-g820)+g1986*g1108-(256.0*g1694*
         g1352)-(96.0*g1268*g1012)+136.0*g1387*g948-(g1995*g1469)-(192.0*g1269*
         g1005)-(64.0*g1627*g1009);
        msq3=t0/(g1658*g1650*16.0*(g1108+g1634)-(32.0*g1658*g1635*g1154));
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

  double ee =  _par[4];
  double sw =  _par[5];

  double g1hzz = _par[7];
  double g2hzz = _par[8];
  double g3hzz = _par[9];

  double cw = sqrt(1-pow(sw,2));
  double mw = mz * cw;
  
  double m12sq = x[0] * pow( mh - mz, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), 0, 0, pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2) + pow(mz,2) - m12sq - m23sq;
 
  // Matrixelemente //
 double g2166,g2399,g2407,g2195,g2420,g2054,g2392,g2387,g2193,g2400,g2417,g2144,g2315,g2049,g2414,g2058,g2050,g2196,g2385,g2412,g2100,g2051,g2421,g2419,g2381,g2180,g2163,g2052,g2380,g2165,g2155,g2053,g2379,g2160,g2088,g2156,g2089,g2159,g2090,g2187,g2143,g2410,g2411,g2192,g2258,g2060,g2214,g2422,g2198,g2178,g2116,g2249,g2062,g2415,g2231,g2179,g2076,g2311,g2063,g2287,g2064,g2065,g2066,g2242,g2067,g2142,g2068,g2141,g2069,g2181,g2115,g2073,g2074,g2183,g2125,g2075,g2147,g2077,g2409,g2164,g2200,g2418,g2103,g2080,g2162,g2197,g2161,g2084,g2105,g2397,g2108,g2107,g2087,g2094,g2096,g2416,g2201,g2101,g2098,g2377,g2158,g2102,g2239,g2157,g2386,g2106,g2208,g2173,g2109,g2401,g2110,g2233,g2177,g2344,g2111,g2232,g2112,g2131,g2113,g2114,g2302,g2118,g2119,g2182,g2251,g2217,g2176,g2169,g2121,g2172,g2122,g2123,g2186,g2129,g2126,g2174,g2234,g2270,g2128,g2130,g2224,g2219,g2154,g2153,g2298,g2167,g2138,g2408,g2292,g2139,g2205,g2185,g2140,g2151,g2152,g2398,g2170,g2175,g2171,g2184,g2194,g2383,g2191,g2199,g2202,g2203,g2269,g2206,g2209,
g2229,g2391,g2228,g2301,g2213,g2222,g2300,g2220,g2221,g2299,g2235,g2237,g2402,g2403,g2318,g2317,g2265,g2248,g2252,g2253,g2254,g2255,g2256,g2257,g2259,g2260,g2261,g2262,g2266,g2271,g2274,g2275,g2276,g2291,g2289,g2290,g2284,g2285,g2288,g2294,g2312,g2320,g2321,g2455,g2441,g2445,g2457,g2442,g2456,g2443,g2449,g2489,g2500,g2528,g2444,g2459,g2446,g2448,g2458,g2513,g2450,g2451,g2487,g2453,g2478,g2468,g2454,g2467,g2532,g2460,g2482,g2466,g2522,g2463,g2483,g2464,g2465,g2469,g2529,g2471,g2480,g2507,g2473,g2479,g2474,g2510,g2511,g2475,g2533,g2477,g2525,g2526,g2485,g2486,g2488,g2490,g2502,g2514,g2518,g2501,g2503,g2504,g2505,g2506,g2508,g2509,g2512,g2515,g2516,g2517,g2519,g2520,g2521,g2523,g2524,g2527,g2530,g2531,g2534,g2535,g2536,g2547,g2388,msq;
{
    double t0 = 0;
    g2166=m23sq*ee;
    g2399=g1hzz*g1hzz;
    g2407=mh*mh;
    g2195=g2407*g2399;
    g2420=g2166*g2166;
    g2054=g2420*g2195;
    g2392=mz*mz;
    g2387=g2392*g2392;
    g2193=g2392*g1hzz;
    g2400=ee*ee;
    g2417=g2193*g2193;
    g2144=g2417*g2400;
    g2315=g2407*m23sq;
    g2049=g2315*g2144;
    g2414=m13sq*m13sq;
    g2058=g2414*g2144;
    g2050=g2058*m12sq;
    g2196=sw*ee;
    g2385=g3hzz*g3hzz;
    g2412=g2196*g2196;
    g2100=g2412*g2385;
    g2051=g2407*g2100;
    g2421=sw*sw;
    g2419=g2421*sw;
    g2381=g2419*sw;
    g2180=g2400*g2381;
    g2163=g2407*g2180;
    g2052=g2385*g2163;
    g2380=g2421*g2381;
    g2165=g2400*g2380;
    g2155=g2385*g2165;
    g2053=g2407*g2155;
    g2379=g2392*g2387;
    g2160=g2412*g2379;
    g2088=g2399*g2160;
    g2156=g2379*g2180;
    g2089=g2399*g2156;
    g2159=g2379*g2165;
    g2090=g2399*g2159;
    g2187=g2392*sw;
    g2143=g2187*ee;
    g2410=m23sq*m23sq;
    g2411=g2143*g2143;
    g2192=g2392*m12sq;
    g2258=g2421*m23sq;
    g2060=g2258*g2192;
    g2214=g2392*m23sq;
    g2422=g2214*g2214;
    g2198=g2400*m12sq;
    g2178=g2198*g3hzz;
    g2116=g2178*g1hzz;
    g2249=g2407*g2392;
    g2062=g2249*g2116;
    g2415=g2400*ee;
    g2231=g2415*mw;
    g2179=g2392*g2231;
    g2076=g2419*g2179;
    g2311=g2407*m12sq;
    g2063=g2311*g2076;
    g2287=m23sq*m13sq;
    g2064=g2412*g2287;
    g2065=g2287*g2180;
    g2066=g2287*g2165;
    g2242=g2407*g3hzz;
    g2067=g2411*g2242;
    g2142=g2387*g2180;
    g2068=g2242*g2142;
    g2141=g2165*g3hzz;
    g2069=g2392*g2249*g2141;
    g2181=g2193*g3hzz;
    g2115=g2141*g1hzz;
    g2073=g2142*m12sq;
    g2074=g2242*g2179;
    g2183=g2412*g2196*mw;
    g2125=g2407*g2183;
    g2075=g2387*g2125;
    g2147=g2385*g2198;
    g2077=g2392*g2147;
    g2409=g2hzz*g2hzz;
    g2164=g2412*g2409;
    g2200=g2387*g2hzz;
    g2418=g2200*g2200;
    g2103=g2418*g2400;
    g2080=g2380*g2103;
    g2162=g2420*g2379;
    g2197=g2hzz*m13sq;
    g2161=g2400*g2197*g2197;
    g2084=g2414*g2159;
    g2105=g2392*g2160;
    g2397=g2392*g2379;
    g2108=g2397*g2180;
    g2107=g2397*g2165;
    g2087=g2407*g2107;
    g2094=g2142*m13sq;
    g2096=g2142*m23sq;
    g2416=m12sq*m12sq;
    g2201=g2416*g2400;
    g2101=g2385*g2201;
    g2098=g2381*g2101;
    g2377=g2397*g2392;
    g2158=g2377*g2165;
    g2102=g2409*g2158;
    g2239=g2407*g1hzz;
    g2157=g2387*g2239;
    g2386=g2187*g2187;
    g2106=g2386*m23sq;
    g2208=g2231*sw;
    g2173=g2208*g1hzz;
    g2109=g2311*g2173;
    g2401=mw*mw;
    g2110=g2401*g2198*g2198;
    g2233=g2379*g3hzz;
    g2177=g2400*g2233;
    g2344=g2hzz*m12sq;
    g2111=g2344*g2177;
    g2232=g2392*m13sq;
    g2112=g2232*g2232*g2178;
    g2131=g2201*g2hzz;
    g2113=g2131*g3hzz;
    g2114=g2239*g2177;
    g2302=g2hzz*g1hzz;
    g2118=g2160*g1hzz;
    g2119=g2156*g1hzz;
    g2182=g2379*sw;
    g2251=g2419*g2182;
    g2217=g2421*g2251;
    g2176=g2231*m12sq;
    g2169=g2176*g3hzz;
    g2121=g2407*g2169;
    g2172=g2176*g2hzz;
    g2122=g2379*g2172;
    g2123=g2387*g2172;
    g2186=g2416*g2231;
    g2129=g2387*g2186;
    g2126=g2410*g2183;
    g2174=g2231*m23sq;
    g2234=g2387*g2174;
    g2270=g2387*g1hzz;
    g2128=g2270*g2176;
    g2130=g2416*g2173;
    g2224=g2410*m13sq;
    g2219=g2414*m23sq;
    g2154=g2412*g2377;
    g2153=g2377*g2180;
    g2298=g2379*m12sq;
    g2167=g2298*m12sq;
    g2138=g2231*g2167;
    g2408=g2411*g2143;
    g2292=g2408*mw;
    g2139=g2292*g1hzz;
    g2205=g2415*g2401*ee;
    g2185=g2205*m12sq;
    g2140=g2407*g2185;
    g2151=g2187*g2176;
    g2152=g2392*g2185;
    g2398=g2392*g2377;
    g2170=g2182*g2174;
    g2175=g2231*m13sq;
    g2171=g2175*sw;
    g2184=g2205*m13sq;
    g2194=g2409*g2379;
    g2383=g2407*g2407;
    g2191=g2379*m23sq;
    g2199=g2106*g1hzz;
    g2202=g2400*g2060*m13sq;
    g2203=g2060*g1hzz;
    g2269=g3hzz*m12sq;
    g2206=g2269*mw;
    g2209=g2239*g2hzz;
    g2229=g2414*g3hzz;
    g2391=g2392*g2182;
    g2228=g2421*g2391;
    g2301=g2171*g1hzz;
    g2213=g2379*g2301;
    g2222=g2387*m13sq;
    g2300=g2379*m13sq;
    g2220=g2387*m12sq;
    g2221=g2380*m23sq;
    g2299=g2416*g1hzz;
    g2235=g2397*g2173;
    g2237=sw*m13sq;
    g2402=g2410*m23sq;
    g2403=g2414*m13sq;
    g2318=g2414*sw;
    g2317=g2410*sw;
    g2265=g2407*sw;
    g2248=g2421*g2265;
    g2252=g2265*sw;
    g2253=g2381*g2111;
    g2254=g2380*g2111;
    g2255=g1hzz*m13sq;
    g2256=g1hzz*m23sq;
    g2257=sw*m23sq;
    g2259=g2419*m23sq;
    g2260=g2419*m13sq;
    g2261=m23sq*m12sq;
    g2262=m13sq*m12sq;
    g2266=g2421*m13sq;
    g2271=g1hzz*m12sq;
    g2274=g2381*g2050;
    g2275=g3hzz*m23sq;
    g2276=g3hzz*m13sq;
    g2291=g2414*g2hzz;
    g2289=g2416*g2hzz;
    g2290=g2410*g1hzz;
    g2284=g2410*g3hzz;
    g2285=g3hzz*g1hzz;
    g2288=g2397*g1hzz;
    g2294=g2269*g2076;
    g2312=g2169*sw;
    g2320=g2126*g3hzz;
    g2321=g2126*g1hzz;
    g2455=4.0*(g2416*g2058+g2400*g2157*g2157)-(8.0*g2262*g2049);
    g2441=g2455+12.0*(g2219*g2147+g2224*g2147)+4.0*(g2403*g2147+g2402*g2147);
    g2445=8.0*(g2407*g2090+g2407*g2088)-(16.0*g2407*g2089);
    g2457=32.0*(g2387*g2155+g2387*g2100);
    g2442=g2457+g2445-(192.0*g2080)+24.0*g2139;
    g2456=g2110-g2140-g2152+4.0*g2299*g2076;
    g2443=g2456+g2445;
    g2449=4.0*g2088-(8.0*g2089);
    g2489=g2185-g2449;
    g2500=g2271*g2076-(g2151*g1hzz)+g2100*m12sq;
    g2528=4.0*g2090;
    g2444=4.0*g2500+g2489-g2528;
    g2459=8.0*g2052+4.0*(-g2053-g2051);
    g2446=g2459-(2.0*g2449);
    g2448=8.0*(-(g2105*m13sq)-(g2105*m23sq))+16.0*(g2108*m13sq+g2108*m23sq);
    g2458=32.0*(g2302*g2162+g2409*g2162)-(4.0*g2387*g2054);
    g2513=16.0*g2114;
    g2450=g2513+2.0*g2458;
    g2451=32.0*g2298*g2065+16.0*(-(g2298*g2066)-(g2298*g2064));
    g2487=16.0*g2181*g2180-(8.0*g2392*g2115);
    g2453=g2487-(8.0*g2412*g2181);
    g2478=4.0*(g2380*g2144+g2411*g2399);
    g2468=4.0*(g2107+g2105);
    g2454=g2468-(8.0*g2108);
    g2467=32.0*g2421*g2161-(64.0*g2381*g2161);
    g2532=16.0*g2100;
    g2460=g2532-(2.0*g2467)+4.0*g2205;
    g2482=16.0*g2123+4.0*g2121;
    g2466=g2482-(4.0*g2186*g3hzz);
    g2522=8.0*g2075;
    g2463=64.0*g2407*g2164-(128.0*g2409*g2163);
    g2483=8.0*g2062-(4.0*g2077);
    g2464=g2483+8.0*g2058;
    g2465=8.0*g2049-g2483;
    g2469=4.0*(g2422*g2165+g2411*g2410);
    g2529=16.0*m13sq;
    g2471=-g2529-(16.0*m23sq);
    g2480=8.0*g2065-(4.0*g2066);
    g2507=32.0*g2111;
    g2473=g2513+g2507+12.0*g2050;
    g2479=16.0*g2118-(32.0*g2119);
    g2474=-g2479-(4.0*g2151);
    g2510=8.0*g2419*g2234;
    g2511=8.0*g2234*sw;
    g2475=g2511-g2510;
    g2533=32.0*g2108;
    g2477=16.0*g2105-g2533;
    g2525=8.0*g2173;
    g2526=16.0*g2115;
    g2485=-g2526-g2525;
    g2486=48.0*(g2300*g2116+g2191*g2116);
    g2488=128.0*g2398*g2180-(64.0*g2398*g2165);
    g2490=g2528+g2449;
    g2502=-g2237-g2257;
    g2514=32.0*g2hzz;
    g2518=8.0*g2261;
    g2501=16.0*g2302*g2153+8.0*(-(g2302*g2158)-(g2302*g2154));
    g2503=16.0*g2454;
    g2504=32.0*m12sq;
    g2505=4.0*g2050;
    g2506=32.0*g2122;
    g2508=8.0*g2125;
    g2509=16.0*g2183;
    g2512=8.0*g2222;
    g2515=8.0*g2087;
    g2516=24.0*m23sq;
    g2517=32.0*g2084;
    g2519=64.0*g2256;
    g2520=4.0*g2063;
    g2521=16.0*g2063;
    g2523=8.0*g2073;
    g2524=16.0*g2073;
    g2527=4.0*g2184;
    g2530=8.0*g2098;
    g2531=4.0*g2101;
    g2534=-(48.0*g2115);
    g2535=-(32.0*g2113);
    g2536=16.0*g2077;
    g2547=cw*cw*cw;
    g2388=g2547*g2547;
    {
        t0=16.0*(g2408*g2206-(g2170*g3hzz)-(g2233*g2171)-(g2182*g2169))+64.0*(
         g2197*g2087*g1hzz-(g2398*g2164))+32.0*(g2254*m13sq-(g2167*g2115))+4.0*(
         g2477*g2209*m12sq-(g2249*g2110))+2.0*(g2480*g2385*g2192+g2466*g2259*
         m13sq+g2465*g2266*g2266)+3.0*(g2489*g2219+g2453*g2224*m12sq+g2487*g2219
         *m12sq)+g2469*(g2271*g2271+3.0*g2399*g2262)+g2454*(g2255*g2255+16.0*(-(
         g2289*g1hzz)-(g2291*g1hzz)))+(4.0*g2064-g2480)*(g2417*g2383+16.0*(g2194
         *m12sq-(g2233*g1hzz)-(g2269*g2200)-(g2379*g2209)-(g2407*g2194))+4.0*(
         g2285*g2220-(g2416*g2181)+g2387*g2385-(g2157*g3hzz))+48.0*(-g2418-(
         g2288*g2hzz))+2.0*(g2270*g2270+g2269*g2269+g2399*g2192*g2192))+g2468*(
         g2256*g2256-(16.0*g2290*g2hzz));
        t0=t0+(g2453+4.0*g2100)*(g2262*g2262+g2261*g2261)+(g2464-(64.0*g2103))*(
         g2257*g2257-(2.0*g2258*g2258))+(8.0*g2383*g2128+16.0*g2416*g2074-(12.0*
         g2219*g2169)-(4.0*g2420*g2206*g2166)+32.0*(-(g2129*g3hzz)-(g2222*g2169)
         ))*(g2419-sw)+g2459*4.0*(g2192*m23sq+g2416*g2392)+4.0*(g2109-g2130)*(
         2.0*g2214*m13sq+g2414*g2392+g2410*g2392)+g2479*(4.0*g2219*g2hzz+2.0*(
         g2289*m23sq+g2291*m12sq))+(4.0*g2128-g2466)*(2.0*g2237*m23sq+g2318+
         g2317-(g2421*g2318))+(8.0*(-g2255-g2256)-(16.0*g2197))*(g2075*m12sq+4.0
         *g2068*m12sq+2.0*(-(g2069*m12sq)-(g2067*m12sq)))+16.0*g2502*(g2074*
         m12sq-(g2407*g2123))+(16.0*(g2069+g2067)-g2522-(32.0*g2068))*(2.0*g2261
         *g2hzz+g2299);
        t0=t0+(-g2518-(16.0*g2192))*(g2053*m13sq-(2.0*g2052*m13sq)+g2051*m13sq)+
         g2471*(4.0*(g2385*g2073+g2253)-(2.0*g2217*g2131*g1hzz))+g2463*(g2392*
         g2298+g2392*g2300+g2392*g2191)+g2490*(g2383*m12sq-(g2383*m13sq)-(g2383*
         m23sq))+(g2478+g2453)*(g2403*m12sq+g2402*m12sq)+g2478*(g2403*m23sq+
         g2402*m13sq)+g2500*12.0*(g2219+g2224)+(8.0*g1hzz-g2514)*(g2380*g2112+
         g2421*g2112)+g2458*(g2380*m12sq-(2.0*g2381*m12sq)+g2421*m12sq)+g2450*(
         g2380*m13sq-(2.0*g2381*m13sq))+32.0*(g3hzz-g2197)*(2.0*g2416*g2119-(
         g2416*g2118))+16.0*(g2129*g2hzz-g2122)*(g2502+g2260+g2259)+(-(8.0*g2054
         )-(64.0*g2113))*(2.0*g2251-(g2182*sw)-g2217)+g2448*(g2195-(8.0*g2209));
        t0=t0+(8.0*g2471-(192.0*m12sq))*(2.0*g2409*g2153-(g2409*g2154)-g2102)+(
         g2471-(16.0*m12sq))*(g2501+g2379*g2155-(2.0*g2385*g2156))+g2hzz*(32.0*
         g2138*sw+g2519*g2084)+g2080*64.0*(g2311+g2315)+g2140*4.0*(-g2232-g2214)
         +g2172*32.0*(g2391-g2228)+g2191*(g2534*m12sq-g2460-(g2508*g1hzz))+g2400
         *g2229*(16.0*g2199-(24.0*g2203))+g2400*g2302*(128.0*g2106*g2106-(64.0*
         g2182*g2182))+g2228*g1hzz*(24.0*(-g2175-g2174)-(32.0*g2176))+g2220*(4.0
         *g2459+8.0*g2184)+g2221*(g2473+g2529*g2062)+g2224*(12.0*g2312-(3.0*
         g2490))+g2229*(g2474+4.0*g2076*m12sq)+g2235*(g2516+g2504)+g2485*g2191*
         m23sq+g2239*(8.0*(g2170+g2129*sw)-(g2511*m13sq))+g2482*g2421*g2317+
         g2248*(g2506+g2536*g2248);
        t0=t0+g2252*(-g2505-(64.0*g2111)-(32.0*g2252*g2077))+g2255*(-(32.0*g2170
         )-(g2510*m12sq))+g2473*g2258+g2442*g2261+g2262*(g2442-(12.0*g2320))+
         g2403*g2399*(-g2523-(8.0*g2096))+g2402*g2399*(-g2523-(8.0*g2094))+g2265
         *(g2536*g2265-g2506)+g2266*(g2507+g2450)+g2269*(4.0*g2475+16.0*g2075)+
         g2271*(-(24.0*g2170)-(160.0*g2197*g2107))+g2275*(g2521-(8.0*g2151*m13sq
         ))+g2276*(g2521+2.0*g2475+g2518*g2076)+g2289*g3hzz*64.0*(g2094+g2096)+
         g2284*g1hzz*(-g2524-(32.0*g2094))+g2474*g2284+g2285*(64.0*g2153-(32.0*
         g2154)+16.0*(-g2087-g2084)-(6.0*g2448))+g2287*(2*g2443+32.0*g2139)+
         g2288*(g2508+24.0*g2171)+g2292*16.0*(g2276+g2275)+g2298*(g2467-g2532)+
         g2300*(-g2532-(g2525*m13sq))+g2302*(g2488-(4.0*g2451));
        t0=t0+g2397*g3hzz*(16.0*g2208-g2509)+g2387*m23sq*(g2527+8.0*(g2109+g2185
         ))+g2410*m12sq*(g2446+3.0*g2184-(8.0*g2090))+g2414*g1hzz*(g2475-g2520)+
         g2419*g2138*(16.0*g1hzz-g2514)+g2321*(-g2512-(4.0*g2220))+g2409*m12sq*(
         g2517+24.0*g2448)+g2446*g2414*m12sq+g2399*m23sq*(-g2515-(12.0*g2084))+
         g2256*g2107*(48.0*g3hzz-(160.0*g2344))+g2073*g2hzz*64.0*(g2229+g2284)+
         g2087*g2hzz*(g2519+64.0*g2271)+g2271*g2hzz*(g2517+20.0*g2448)+g2269*
         g2hzz*(g2503-(8.0*g2469))+g2269*g1hzz*(g2503+2.0*g2469)+g2255*g3hzz*(
         4.0*g2469+48.0*g2107)+g2255*m23sq*(g2522-(8.0*g2063))+g2239*g3hzz*(16.0
         *g2202-g2477)+g2229*g1hzz*(-g2524-(32.0*g2096))+g2377*(2.0*g2485-g2463+
         g2509*g1hzz);
        t0=t0+g2379*(8.0*g2321-(4.0*g2185)-(g2508*g2255)+g2534*g2262-g2527-(16.0
         *g2130))+g2380*(g2441+g2535*g2222)+g2381*(32.0*(-(g2287*g2062)-(g2114*
         m23sq))+2.0*(g2486-g2441))+g2383*(4.0*g2152+16.0*(g2151*g3hzz-g2294)-(
         g2526*g2220)+32.0*g2285*g2073)+g2385*(16.0*g2107-g2533-(8.0*g2202))+
         g2386*(g2535*m13sq-(16.0*g2383*g2116))+g2387*(8.0*g2110-(4.0*g2140)-(
         64.0*g2098)-(16.0*g2121*sw)+g2526*g2219+g2535*g2221)+g2460*g2397+g2399*
         (g2451-(8.0*g2084*m12sq)-(24.0*g2224*g2073)-(g2515*m13sq))+g2400*8.0*(-
         (g2199*g2199)-(g2203*g2203))+g2444*g2402+g2403*(g2444+4.0*g2312)+g2407*
         (128.0*g2253+64.0*(-g2102-g2254)+8.0*(g2501+g2213-g2235+g2274)-(g2505*
         g2380))+g2409*(g2488+64.0*g2084*m23sq);
        msq=(t0+g2410*(g2456+4.0*g2294-(64.0*g2080)-g2530)+g2080*m13sq*64.0*(
         g2407-m13sq)+g2414*(g2443+8.0*g2139-g2530)+g2416*(g2457-(4.0*g2320))+
         g2421*(g2455-g2486)+g2259*g2259*(g2531+g2464)+g2237*g2237*(-g2465-(4.0*
         g2237*g2169))+g2260*g2260*(g2531-g2465)+g2535*g2106-(g2516*g2274)+8.0*
         g2422*g2301-(g2520*g2290)-(24.0*g2213*m12sq)+g2512*g2109)/(g2388*g2381*
         16.0*(g2167+g2377)-(g2504*g2388*g2386*g2386));
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
