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
printf("\n ------------------------------------ HZZ Decay -----------------------------------\n");
//ALEX
printf("effpar:\n fbb: %f \n fww: %f \n fgg: %f \n fb: %f \n fw: %f \n ", effpar->fbb, effpar->fww, effpar->fgg, effpar->fb, effpar->fw);

  double width = 0, error = 0, chi = 1;
  double buffer1 = 0, buffer2 = 0, buffer3 = 0;
  hztata_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n tata: %f",buffer1);
  hzmumu_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n mumu: %f",buffer1);
  hzelel_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n elel: %f",buffer1);
  hzupup_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n upup: %f",buffer1);
  hzdodo_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n dodo: %f",buffer1);
  hzchch_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n chch: %f",buffer1);
  hzstst_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n stst: %f",buffer1);
  hzbobo_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n bobo: %f", buffer1);
  hznunu_( smpar, effpar, &buffer1, &buffer2, &buffer3 ); width += buffer1; error += buffer2; chi = (fabs(chi - 1 ) < fabs(buffer3 - 1) ? buffer3 : chi );
printf("\n nunu: %f",buffer1);
  *pWidth = width;
  *pError = error;
  *pChi   = chi;
printf("\n ----------------------------------------------------------------------------------\n");
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
  
  *pWidth = 3.0*result;
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
 
//printf("\n mHZlL-g1hzz: %f", g1hzz); 
//printf("\n mHZlL-g2hzz: %f", g2hzz); 
//printf("\n mHZlL-g3hzz: %f", g3hzz); 
//printf("\n mHZlL-g1hzy: %f", g1hzy); 
//printf("\n mHZlL-g2hzy: %f", g2hzy); 

 
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
    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2) && (k < DSteps)); //ALEX
//    while ((fabs (gsl_monte_vegas_chisq (s)) > 1.2) && (k < DSteps));
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
 
//printf("\n mHZdd-g1hzz: %f", g1hzz); 
//printf("\n mHZdd-g2hzz: %f", g2hzz); 
//printf("\n mHZdd-g3hzz: %f", g3hzz); 
//printf("\n mHZdd-g1hzy: %f", g1hzy); 
//printf("\n mHZdd-g2hzy: %f", g2hzy); 

 
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
 
#include "matrixelements/decay_mHWl.cc"
 

  msq = msq * (pow(mh - mw,2) - pow(ml,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq;
  if( width < 0 ) return 0;
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


#include "matrixelements/decay_mHWqqp.cc"
  
  msq = msq * (pow(mh - mw,2) - pow(m3 + m4,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq;
  if( width < 0 ) return 0;
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

#include "matrixelements/decay_mHZdD.cc"

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


#include "matrixelements/decay_mHZuU.cc"


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

//printf("\n mHZlL-g1hzz: %f", g1hzz); 
//printf("\n mHZlL-g2hzz: %f", g2hzz); 
//printf("\n mHZlL-g3hzz: %f", g3hzz); 
//printf("\n mHZlL-g1hzy: %f", g1hzy); 
//printf("\n mHZlL-g2hzy: %f", g2hzy); 

  double m12sq = x[0] * (pow( mh - mz, 2 ) - pow( mt + mt, 2 )) + pow( mt + mt, 2 );
  double m23min, m23max;
  _m23lim( pow(mh,2), pow(mt,2), pow(mt,2), pow(mz,2), sqrt(m12sq), &m23max, &m23min );
  double m23sq = x[1]*(m23max - m23min) + m23min;
  double m13sq = pow(mh,2)+pow(mt,2) + pow(mt, 2) + pow(mz,2) - m12sq - m23sq;
  
  double m = mt;

#include "matrixelements/decay_mHZlL.cc"

  double msq_tot = ( msq1 + msq2 + msq3 ) * (pow(mh - mz,2) - pow(mt + mt,2)) * (m23max - m23min);
  double width = 1/pow(2.*M_PI,3)/32./pow(mh,3)*msq_tot;
  if( width < 0 ) return 0;
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

#include "matrixelements/decay_mHZnN.cc"
 
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
