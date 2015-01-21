#include <LHAPDF/LHAPDF.h>

#include "VBF.h"

void vbf_init_cs_( sminputs * smpar )
{
  effinputs temp;
  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
 //printf("ALEX vbf init call");
  udcsb_jjh_(   smpar, &temp, &cs_5flavorSM, &err_5flavorSM, &chi_5flavorSM );
};

void vbf_init_2flav_sm_( sminputs * smpar )
{
  effinputs temp;
  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
 //printf("ALEX vbf 2flav sm call");
  ud_jjh_(   smpar, &temp, &cs_2flavorSM, &err_2flavorSM, &chi_2flavorSM );
};

void ratio_vbf_5flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq )
{
  double result, err, chi;
  //printf("ALEX 2flav params:\n fbb: %10.10f\n fww: %10.10f\n fgg: %10.10f\n fb: %10.10f\n fw: %10.10f\n",effpar->fbb,effpar->fww, effpar->fgg, effpar->fb, effpar->fw);
  udcsb_jjh_( smpar, effpar, &result, &err, &chi );
  *ratio = result / cs_5flavorSM;
  *error = err / cs_5flavorSM + result / pow( cs_5flavorSM, 2 ) * err_5flavorSM;
  *chisq = chi;
};

void ratio_vbf_2flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq )
{
  double result, err, chi;
  //printf("ALEX 2flav params:\n fbb: %10.10f\n fww: %10.10f\n fgg: %10.10f\n fb: %10.10f\n fw: %10.10f\n",effpar->fbb,effpar->fww, effpar->fgg, effpar->fb, effpar->fw);
  ud_jjh_( smpar, effpar, &result, &err, &chi );
  *ratio = result / cs_5flavorSM;
  *error = err / cs_2flavorSM + result / pow( cs_2flavorSM, 2 ) * err_2flavorSM;
  *chisq = chi;
};

void udcsb_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq )
{
  VBFParam par;
  par.sm = *smpar;
  par.eff = *effpar;

  double xl[] = {0,0,0,0,0,0};
  double xu[] = {1,1,1,1,1,1};
  double result, error;
  
  size_t dim = 6;
  const gsl_rng_type * T;
  gsl_rng * r;
  size_t calls = VBFCALLS;
   //printf("ALEX 5flav params:\n fbb: %10.10f\n fww: %10.10f\n fgg: %10.10f\n fb: %10.10f\n fw: %10.10f\n",effpar->fbb,effpar->fww, effpar->fgg, effpar->fb, effpar->fw);
 
  gsl_monte_function G = {udcsb_jjh, dim, &par};
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
	//printf("\n ALEX, chisquare of VBF udscb:run %i, chi2 %f \n",k,(double)gsl_monte_vegas_chisq(s));
      k++;
    }
//    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.4) && ( k < VBFRUN ));
    while (((gsl_monte_vegas_chisq (s) - 1.0) > 0.4) && ( k < VBFRUN ));
    *chisq = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  *cs = result;
  *err = error; 
};

double udcsb_jjh( double * x, size_t dim, void * params )
{
  VBFParam * par = (VBFParam*)params;
  sminputs smpar = par->sm;
  double ckm[] = { smpar.vud, smpar.vus, smpar.vub, smpar.vcd, smpar.vcs, smpar.vcb };
  int    pdg[] = { 1, 2, 3, 4, 5 };
  double mh = smpar.mh;
  //printf("ALEX x[0...3]: %f,%f,%f,%f \n", x[0],x[1],x[2],x[3]);// -------------------------------------------
  double x1 = x[4]*(1-pow(smpar.mh,2)/smpar.s) + pow(smpar.mh,2)/smpar.s;
  double x2 = x[5]*(1-pow(smpar.mh,2)/smpar.s/x1) + pow(smpar.mh,2)/smpar.s/x1;
  
  double uu_uuh       = uu_uuh_massless(   x, dim, par );
  double dd_ddh       = dd_ddh_massless(   x, dim, par );
  double ud_dpuph     = ud_dpuph_massless( x, dim, par );
  double ud_duh_NoCKM = ud_duh_NoCKM_massless( x, dim, par );
  double ud_duh_CKMsQ = ud_duh_CKMsQ_massless( x, dim, par );
  
  double dsig = 0;
  /* Loop over initial states */
  for( int i = 0; i < 5; i++ )
  {
    for( int j = 0; j < 5; j++ )
    {
      double xfx_i_x1  = LHAPDF::xfx(x1,mh,pdg[i]);  // Quark 1 mit x1
      double xfx_j_x1  = LHAPDF::xfx(x1,mh,pdg[j]);  // Quark 2 mit x1
      double xfx_i_x2  = LHAPDF::xfx(x2,mh,pdg[i]);  // Quark 1 mit x2
      double xfx_j_x2  = LHAPDF::xfx(x2,mh,pdg[j]);  // Quark 2 mit x2
      double xfx_mi_x1 = LHAPDF::xfx(x1,mh,-pdg[i]); // Antiquark 1 mit x1
      double xfx_mj_x1 = LHAPDF::xfx(x1,mh,-pdg[j]); // Antiquark 2 mit x1
      double xfx_mi_x2 = LHAPDF::xfx(x2,mh,-pdg[i]); // Antiquark 1 mit x2
      double xfx_mj_x2 = LHAPDF::xfx(x2,mh,-pdg[j]); // Antiquark 2 mit x2

      if( (pdg[i] == pdg[j]) && !(pdg[i]%2) )
      {
	dsig += 1./x1/x2*xfx_i_x1*xfx_j_x2*uu_uuh;                                                               // Nur up-quarks beteiligt
	dsig += 1./x1/x2*xfx_mi_x1*xfx_mj_x2*uu_uuh;                                                             // Nur anti-up-quarks beteiligt
	dsig += 2./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1 + xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*uu_uuh; // Ein Quark, ein Antiquark
	// Der Faktor 2 tritt auf um den von Comphep eingetragenen Symmetriefaktor aufzuheben der sich im Falle gleicher Quarks im Endzustand ergaebe
      };
      if( (pdg[i] == pdg[j]) && (pdg[i]%2) )
      {
	dsig += 1./x1/x2*xfx_i_x1*xfx_j_x2*dd_ddh;                                                               // Nur d-quarks beteiligt
	dsig += 1./x1/x2*xfx_mi_x1*xfx_mj_x2*dd_ddh;                                                             // Nur anti-d-quarks beteiligt
	dsig += 2./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x2 + xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*dd_ddh; // Ein Quark, ein Antiquark 
	// Der Faktor 2 tritt auf um den von Comphep eingetragenen Symmetriefaktor aufzuheben...
      };
      if( !(pdg[i]%2) && !(pdg[j]%2)) // Beide sind up-Quarks, aber nicht notwendigerweise gleich
	{
	  for( int k = 0; k < 3; k++ ) // Summiert über das erste mögliche d-quark im Endzustand
	    {
	      for( int l = 0; l < 3; l++) // Summiert über das zweite mögliche d-Quark im Endzustand
		{
		  double ckm1 = ckm[(pdg[i]==4)*3+k];
		  double ckm2 = ckm[(pdg[j]==4)*3+k];
		  dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1)*ud_dpuph*pow(ckm1*ckm2,2);
		};
	    };
	};
      if( (pdg[i]%2) && (pdg[j]%2)) // Beide sind d-Quarks, aber nicht notwendigerweise gleich
	{
	  for( int k = 0; k < 2; k++ )
	    {
	      for( int l = 0; l < 2; l++ )
		{
		  // Zaehle die beiden moeglichen u-typ quarks im Endzustand
		  double ckm1 = ckm[3*k+i/2];
		  double ckm2 = ckm[3*l+j/2];
		  dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1)*ud_dpuph*pow(ckm1*ckm2,2);
		};
	    };
	};
      if( (pdg[i] != pdg[j]) && ( pdg[j]%2 && !(pdg[i]%2) ) )
      {
	/* Quark i ist up-Quark, Quark j ist d-Quark */
	for( int k = 0; k < 5; k++ )
	{
	  for( int l = 0; l < 5; l++ )
	  {
	    if((pdg[k] == pdg[j]) && (pdg[l] == pdg[i]) )  {
	      int zeile   = (pdg[i]==4);
	      int spalte  = pdg[j]/2;
	      int element = spalte+zeile*3;
	      
	      dsig += 1./x1/x2*(xfx_i_x1*xfx_j_x2+xfx_j_x1*xfx_i_x2)*(ud_duh_CKMsQ*pow(ckm[element],2) + ud_duh_NoCKM + ud_dpuph*pow(ckm[element],4));     // Nur quarks
	      dsig += 1./x1/x2*(xfx_mi_x1*xfx_mj_x2+xfx_mj_x1*xfx_mi_x2)*(ud_duh_CKMsQ*pow(ckm[element],2) + ud_duh_NoCKM + ud_dpuph*pow(ckm[element],4)); // Nur antiquarks
	      dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1+xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*ud_duh_NoCKM; // Ein Quark und ein Antiquark, W tritt nicht auf
	    };
	    if( ( pdg[k]%2 && !(pdg[l]%2)) && ((pdg[l] != pdg[i]) && (pdg[k] != pdg[j])))
	    {
	      int zeile1  = (pdg[i]==4);
	      int spalte1 = pdg[k]/2;
	      int zeile2  = (pdg[j]==4);
	      int spalte2 = pdg[l]/2;
	      int elem1   = spalte1+zeile1*3;
	      int elem2   = spalte2+zeile2*3;
	      dsig += 2./x1/x2*(xfx_i_x1*xfx_j_x2+xfx_j_x1*xfx_i_x2)*ud_dpuph*pow(ckm[elem1]*ckm[elem2],2);       // Die Quarks an jedem Strang sind verschieden
	      dsig += 2./x1/x2*(xfx_mi_x1*xfx_mj_x2 + xfx_mj_x1*xfx_mi_x2)*ud_dpuph*pow(ckm[elem1]*ckm[elem2],2); // Die Antiquarks an jedem Strang sind verschieden
	    };
	  };
	};
      };
    };
  };
  
  return dsig;
};

// ------- TWO FLAVOR -------------------------

void ud_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq )
{
  VBFParam par;
  par.sm = *smpar;
  par.eff = *effpar;
  //printf("ALEX 2flav params:\n fbb: %10.10f\n fww: %10.10f\n fgg: %10.10f\n fb: %10.10f\n fw: %10.10f\n",effpar->fbb,effpar->fww, effpar->fgg, effpar->fb, effpar->fw);

  double xl[] = {0,0,0,0,0,0};
  double xu[] = {1,1,1,1,1,1};
  double result, error;
  
  size_t dim = 6;
  const gsl_rng_type * T;
  gsl_rng * r;
  size_t calls = VBFCALLS;
  
  gsl_monte_function G = {ud_jjh, dim, &par};
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    int k = 0;
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    do
    {    
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
	//printf("\n ALEX, chisquare of VBF ud:run %i, chi2 %f \n",k,(double)gsl_monte_vegas_chisq(s));
      k++;
    }
while (((gsl_monte_vegas_chisq (s) - 1.0) > 0.4) && ( k < VBFRUN ));
//    while ((fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.4) && ( k < VBFRUN ));
    *chisq = gsl_monte_vegas_chisq( s );
    gsl_monte_vegas_free( s );
  };
  *cs = result;
  *err = error; 
};

double ud_jjh( double * x, size_t dim, void * params )
{
  VBFParam * par = (VBFParam*)params;
  sminputs smpar = par->sm;
  double ckm[] = { smpar.vud, smpar.vus, smpar.vub, smpar.vcd, smpar.vcs, smpar.vcb };
  int    pdg[] = { 1, 2, 3, 4, 5 };
  double mh = smpar.mh;
  
  double x1 = x[4]*(1-pow(smpar.mh,2)/smpar.s) + pow(smpar.mh,2)/smpar.s;
  double x2 = x[5]*(1-pow(smpar.mh,2)/smpar.s/x1) + pow(smpar.mh,2)/smpar.s/x1;
  
  double uu_uuh       = uu_uuh_massless(   x, dim, par );
  double dd_ddh       = dd_ddh_massless(   x, dim, par );
  double ud_dpuph     = ud_dpuph_massless( x, dim, par );
  double ud_duh_NoCKM = ud_duh_NoCKM_massless( x, dim, par );
  double ud_duh_CKMsQ = ud_duh_CKMsQ_massless( x, dim, par );
  
  double dsig = 0;
  /* Loop over initial states */
  for( int i = 0; i < 2; i++ )
  {
    for( int j = 0; j < 2; j++ )
    {
      double xfx_i_x1  = LHAPDF::xfx(x1,mh,pdg[i]);  // Quark 1 mit x1
      double xfx_j_x1  = LHAPDF::xfx(x1,mh,pdg[j]);  // Quark 2 mit x1
      double xfx_i_x2  = LHAPDF::xfx(x2,mh,pdg[i]);  // Quark 1 mit x2
      double xfx_j_x2  = LHAPDF::xfx(x2,mh,pdg[j]);  // Quark 2 mit x2
      double xfx_mi_x1 = LHAPDF::xfx(x1,mh,-pdg[i]); // Antiquark 1 mit x1
      double xfx_mj_x1 = LHAPDF::xfx(x1,mh,-pdg[j]); // Antiquark 2 mit x1
      double xfx_mi_x2 = LHAPDF::xfx(x2,mh,-pdg[i]); // Antiquark 1 mit x2
      double xfx_mj_x2 = LHAPDF::xfx(x2,mh,-pdg[j]); // Antiquark 2 mit x2

      if( (pdg[i] == pdg[j]) && !(pdg[i]%2) )
      {
	dsig += 1./x1/x2*xfx_i_x1*xfx_j_x2*uu_uuh;                                                               // Nur up-quarks beteiligt
	dsig += 1./x1/x2*xfx_mi_x1*xfx_mj_x2*uu_uuh;                                                             // Nur anti-up-quarks beteiligt
	dsig += 2./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1 + xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*uu_uuh; // Ein Quark, ein Antiquark
	// Der Faktor 2 tritt auf um den von Comphep eingetragenen Symmetriefaktor aufzuheben der sich im Falle gleicher Quarks im Endzustand ergaebe
      };
      if( (pdg[i] == pdg[j]) && (pdg[i]%2) )
      {
	dsig += 1./x1/x2*xfx_i_x1*xfx_j_x2*dd_ddh;                                                               // Nur d-quarks beteiligt
	dsig += 1./x1/x2*xfx_mi_x1*xfx_mj_x2*dd_ddh;                                                             // Nur anti-d-quarks beteiligt
	dsig += 2./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x2 + xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*dd_ddh; // Ein Quark, ein Antiquark 
	// Der Faktor 2 tritt auf um den von Comphep eingetragenen Symmetriefaktor aufzuheben...
      };
      if( !(pdg[i]%2) && !(pdg[j]%2)) // Beide sind up-Quarks, aber nicht notwendigerweise gleich
	{
	  for( int k = 0; k < 3; k++ ) // Summiert über das erste mögliche d-quark im Endzustand
	    {
	      for( int l = 0; l < 3; l++) // Summiert über das zweite mögliche d-Quark im Endzustand
		{
		  double ckm1 = ckm[(pdg[i]==4)*3+k];
		  double ckm2 = ckm[(pdg[j]==4)*3+k];
		  dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1)*ud_dpuph*pow(ckm1*ckm2,2);
		};
	    };
	};
      if( (pdg[i]%2) && (pdg[j]%2)) // Beide sind d-Quarks, aber nicht notwendigerweise gleich
	{
	  for( int k = 0; k < 2; k++ )
	    {
	      for( int l = 0; l < 2; l++ )
		{
		  // Zaehle die beiden moeglichen u-typ quarks im Endzustand
		  double ckm1 = ckm[3*k+i/2];
		  double ckm2 = ckm[3*l+j/2];
		  dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1)*ud_dpuph*pow(ckm1*ckm2,2);
		};
	    };
	};
      if( (pdg[i] != pdg[j]) && ( pdg[j]%2 && !(pdg[i]%2) ) )
      {
	/* Quark i ist up-Quark, Quark j ist d-Quark */
	for( int k = 0; k < 5; k++ )
	{
	  for( int l = 0; l < 5; l++ )
	  {
	    if((pdg[k] == pdg[j]) && (pdg[l] == pdg[i]) )  {
	      int zeile   = (pdg[i]==4);
	      int spalte  = pdg[j]/2;
	      int element = spalte+zeile*3;
	      
	      dsig += 1./x1/x2*(xfx_i_x1*xfx_j_x2+xfx_j_x1*xfx_i_x2)*(ud_duh_CKMsQ*pow(ckm[element],2) + ud_duh_NoCKM + ud_dpuph*pow(ckm[element],4));     // Nur quarks
	      dsig += 1./x1/x2*(xfx_mi_x1*xfx_mj_x2+xfx_mj_x1*xfx_mi_x2)*(ud_duh_CKMsQ*pow(ckm[element],2) + ud_duh_NoCKM + ud_dpuph*pow(ckm[element],4)); // Nur antiquarks
	      dsig += 1./x1/x2*(xfx_mi_x1*xfx_j_x2+xfx_mi_x2*xfx_j_x1+xfx_i_x1*xfx_mj_x2+xfx_i_x2*xfx_mj_x1)*ud_duh_NoCKM; // Ein Quark und ein Antiquark, W tritt nicht auf
	    };
	    if( ( pdg[k]%2 && !(pdg[l]%2)) && ((pdg[l] != pdg[i]) && (pdg[k] != pdg[j])))
	    {
	      int zeile1  = (pdg[i]==4);
	      int spalte1 = pdg[k]/2;
	      int zeile2  = (pdg[j]==4);
	      int spalte2 = pdg[l]/2;
	      int elem1   = spalte1+zeile1*3;
	      int elem2   = spalte2+zeile2*3;
	      dsig += 2./x1/x2*(xfx_i_x1*xfx_j_x2+xfx_j_x1*xfx_i_x2)*ud_dpuph*pow(ckm[elem1]*ckm[elem2],2);       // Die Quarks an jedem Strang sind verschieden
	      dsig += 2./x1/x2*(xfx_mi_x1*xfx_mj_x2 + xfx_mj_x1*xfx_mi_x2)*ud_dpuph*pow(ckm[elem1]*ckm[elem2],2); // Die Antiquarks an jedem Strang sind verschieden
	    };
	  };
	};
      };
    };
  };
  
  return dsig;
};


// --------------- MATRIX ELEMENTS ----------------------


double dd_ddh_massless( double * x, size_t dim, void * params )
{
  VBFParam par = *(VBFParam*)params;
  
  double x1   = x[4]*(1-pow(par.sm.mh,2)/par.sm.s)+ pow(par.sm.mh,2)/par.sm.s;
  double x2   = x[5]*(1-pow(par.sm.mh,2)/par.sm.s/x1) + pow(par.sm.mh,2)/par.sm.s/x1;
  double mh = par.sm.mh;
  double m1 = 0, m2 = 0, m3 = 0, m4 = 0;
  double mz = par.sm.mz;
  double sw = par.sm.sw;
  double ee = sqrt(4.*M_PI*par.sm.alphae);
  double s    = x1*x2*par.sm.s;
  
// Alex

par.eff.fp1=0;
par.eff.fp2=0;
par.eff.fp4=0;

// xelA


  /* Daraus berechnet */
  double cw   = sqrt(1-pow(sw,2));
  double mw   = mz*cw;
  
  /* Berechne den einlaufenden Impuls im CMS */
  double pi   = sqrt(pow(s+m2*m2-m1*m1,2)/4./s-m2*m2);
  double E1   = sqrt(m1*m1 + pi*pi);
  double E2   = sqrt(m2*m2 + pi*pi);
  
  /* Berechne physikalische Region fuer Phasenraum */
  double eta    = x[3]*2.*M_PI; // Polarwinkel von 0 bis 2*pi
  double ctheta = x[2]*2.-1;	// Kosinus des Azimutalwinkels zw. -1 und 1
  double stheta = sqrt(1-pow(ctheta,2));
  
  double k40max = sqrt(s)/2. - (pow(m3+mh,2)-pow(m4,2))/2./sqrt(s);
  double k40min = m4;
  double k40    = x[0]*(k40max-k40min) + k40min;
  double k4v    = sqrt(k40*k40-m4*m4);	// Impuls von k4 im CMS
  
  double sigma  = sqrt(s)-k40;
  double tau    = pow(sigma,2)-pow(k4v,2);
  double mp	= m3 + mh;
  double mm	= m3 - mh;
  
  double k30min = 1./2./tau*(sigma*(tau+mm*mp)-k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30max = 1./2./tau*(sigma*(tau+mm*mp)+k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30    = x[1]*(k30max-k30min)+k30min;
  double k3v    = sqrt(k30*k30-m3*m3);
  
  double cXi    = (pow(sqrt(s)-k30-k40,2)-pow(mh,2)-pow(k3v,2)-pow(k4v,2))/2./k3v/k4v;
  double sXi    = sqrt(1-pow(cXi,2));

#ifdef CUTS
  double pt4 = k4v*stheta;
  if( fabs(pt4) < pt4min ) return 0;
  double pt3 = k3v*sqrt(ctheta*ctheta*cos(eta)*cos(eta)*sXi*sXi + stheta*stheta*cXi*cXi+2*stheta*ctheta*sXi*cXi*cos(eta)+sin(eta)*sin(eta)*sXi*sXi);
  if( fabs(pt3) < pt3min ) return 0;
#endif

  /* Berechnung der kinematischen Invarianten */
//ALEX1
  double x14	= k30*E1 - k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x24	= k30*E2 + k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x13	= k40*E1 - k4v*pi*ctheta;
  double x23	= k40*E2 + k4v*pi*ctheta;
  double x34	= k40*k30- k3v*k4v*cXi;

//printf("ALEX x14 x24 x13 x23 x34: %f| %f| %f| %f| %f \n",x14, x24, x13, x23, x34);
//printf("->SQ x14 x24 x13 x23 x34: %f| %f| %f| %f| %f \n",sqrt(x14), sqrt(x24), sqrt(x13), sqrt(x23), sqrt(x34));

  double vbfdampingscale=fmax(2*abs(x13),2*abs(x24));

  double g1hzz = g1hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzz = g2hzz_( &par.sm, &par.eff, vbfdampingscale ); 
  double g3hzz = g3hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g1hzy = g1hzy_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzy = g2hzy_( &par.sm, &par.eff, vbfdampingscale );
  double ghyy  = ghyy_(  &par.sm, &par.eff, vbfdampingscale );
 
#include "matrixelements/production_vbf_dd_ddh_massless.cc"
 
  double dP3  = (k30max-k30min)*(k40max-k40min)*4.*M_PI/8./pow(2*M_PI,4);
  double dsig = (msq1+msq2+msq3+msq4+msq5+msq6+msq5+msq7+msq8+msq9+msq10+msq11+msq12+msq13+msq14+msq15+msq16+msq17+msq18+msq19+msq20)/4./pi/sqrt(s)*dP3/2.57e3*1e12*(1-pow(mh,2)/par.sm.s)*(1-pow(mh,2)/par.sm.s/x1);
  return dsig*higgsrenorm2(&par.sm,&((*(VBFParam*)params).eff) ); // Alex  

};

double uu_uuh_massless( double * x, size_t dim, void * params )
{
  VBFParam par = *(VBFParam*)params;
  double x1   = x[4]*(1-pow(par.sm.mh,2)/par.sm.s)+ pow(par.sm.mh,2)/par.sm.s;
  double x2   = x[5]*(1-pow(par.sm.mh,2)/par.sm.s/x1) + pow(par.sm.mh,2)/par.sm.s/x1;

  double m1 = 0, m2 = 0, m3 = 0, m4 = 0;
  double m5 = par.sm.mh;
  double mz = par.sm.mz;
  double sw = par.sm.sw;
  double ee = sqrt(4.*M_PI*par.sm.alphae);
  double s    = x1*x2*par.sm.s;

// Alex

par.eff.fp1=0;
par.eff.fp2=0;
par.eff.fp4=0;

// xelA



  double mh   = m5;
  /* Daraus berechnet */
  double cw   = sqrt(1-pow(sw,2));
  double mw   = mz*cw;

  /* Berechne den einlaufenden Impuls im CMS */
  double pi   = sqrt(pow(s+m2*m2-m1*m1,2)/4./s-m2*m2);
  double E1   = sqrt(m1*m1 + pi*pi);
  double E2   = sqrt(m2*m2 + pi*pi);
  
  /* Berechne physikalische Region fuer Phasenraum */
  double eta    = x[3]*2.*M_PI; // Polarwinkel von 0 bis 2*pi
  double ctheta = x[2]*2.-1;	// Kosinus des Azimutalwinkels zw. -1 und 1
  double stheta = sqrt(1-pow(ctheta,2));
  
  double k40max = sqrt(s)/2. - (pow(m3+m5,2)-pow(m4,2))/2./sqrt(s);
  double k40min = m4;
  double k40    = x[0]*(k40max-k40min) + k40min;
  double k4v    = sqrt(k40*k40-m4*m4);	// Impuls von k4 im CMS
  
  double sigma  = sqrt(s)-k40;
  double tau    = pow(sigma,2)-pow(k4v,2);
  double mp	= m3 + m5;
  double mm	= m3 - m5;
  
  double k30min = 1./2./tau*(sigma*(tau+mm*mp)-k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30max = 1./2./tau*(sigma*(tau+mm*mp)+k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30    = x[1]*(k30max-k30min)+k30min;
  double k3v    = sqrt(k30*k30-m3*m3);
  
  double cXi    = (pow(sqrt(s)-k30-k40,2)-pow(m5,2)-pow(k3v,2)-pow(k4v,2))/2./k3v/k4v;
  double sXi    = sqrt(1-pow(cXi,2));

#ifdef CUTS
  double pt4 = k4v*stheta;
  if( fabs(pt4) < pt4min ) return 0;
  double pt3 = k3v*sqrt(ctheta*ctheta*cos(eta)*cos(eta)*sXi*sXi + stheta*stheta*cXi*cXi+2*stheta*ctheta*sXi*cXi*cos(eta)+sin(eta)*sin(eta)*sXi*sXi);
  if( fabs(pt3) < pt3min ) return 0;
#endif

  /* Berechnung der kinematischen Invarianten */
//ALEX2
  double x14	= k30*E1 - k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x24	= k30*E2 + k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x13	= k40*E1 - k4v*pi*ctheta;
  double x23	= k40*E2 + k4v*pi*ctheta;
  double x34	= k40*k30- k3v*k4v*cXi;

  double vbfdampingscale=fmax(2*abs(x13),2*abs(x24));

  double g1hzz = g1hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzz = g2hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g3hzz = g3hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g1hzy = g1hzy_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzy = g2hzy_( &par.sm, &par.eff, vbfdampingscale );
  double ghyy  = ghyy_(  &par.sm, &par.eff, vbfdampingscale );

#include "matrixelements/production_vbf_uu_uuh_massless.cc"

  double dP3	= (k30max-k30min)*(k40max-k40min)*4.*M_PI/8./pow(2*M_PI,4);
  double dsig =  (msq1+msq2+msq3+msq4+msq5+msq5+msq6+msq7+msq8+msq9+msq10+msq11+msq12+msq13+msq14+msq15+msq16+msq17+msq18+msq19+msq20)/4./pi/sqrt(s)*dP3/2.57e3*1e12*(1-pow(mh,2)/par.sm.s)*(1-pow(mh,2)/par.sm.s/x1);
  return dsig*higgsrenorm2(&par.sm,&((*(VBFParam*)params).eff) ); // Alex  

};

double ud_duh_NoCKM_massless( double * x, size_t dim, void * params )
{
  VBFParam par = *(VBFParam*)params;
  double x1   = x[4]*(1-pow(par.sm.mh,2)/par.sm.s)+ pow(par.sm.mh,2)/par.sm.s;
  double x2   = x[5]*(1-pow(par.sm.mh,2)/par.sm.s/x1) + pow(par.sm.mh,2)/par.sm.s/x1;
  double m1 = 0, m2 = 0, m3 = 0, m4 = 0;
  double m5 = par.sm.mh;
  double mz = par.sm.mz;
  double sw = par.sm.sw;
  double ee = sqrt(4.*M_PI*par.sm.alphae);
  double s  = x1*x2*par.sm.s;


// Alex

par.eff.fp1=0;
par.eff.fp2=0;
par.eff.fp4=0;

// xelA



  double mh   = m5;
  /* Daraus berechnet */
  double cw   = sqrt(1-pow(sw,2));
  double mw   = mz*cw;
  /* Berechne den einlaufenden Impuls im CMS */
  double pi   = sqrt(pow(s+m2*m2-m1*m1,2)/4./s-m2*m2);
  double E1   = sqrt(m1*m1 + pi*pi);
  double E2   = sqrt(m2*m2 + pi*pi);
  
  /* Berechne physikalische Region fuer Phasenraum */
  double eta    = x[3]*2.*M_PI; // Polarwinkel von 0 bis 2*pi
  double ctheta = x[2]*2.-1;	// Kosinus des Azimutalwinkels zw. -1 und 1
  double stheta = sqrt(1-pow(ctheta,2));
  
  double k40max = sqrt(s)/2. - (pow(m3+m5,2)-pow(m4,2))/2./sqrt(s);
  double k40min = m4;
  double k40    = x[0]*(k40max-k40min) + k40min;
  double k4v    = sqrt(k40*k40-m4*m4);	// Impuls von k4 im CMS
  
  double sigma  = sqrt(s)-k40;
  double tau    = pow(sigma,2)-pow(k4v,2);
  double mp	= m3 + m5;
  double mm	= m3 - m5;
  
  double k30min = 1./2./tau*(sigma*(tau+mm*mp)-k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30max = 1./2./tau*(sigma*(tau+mm*mp)+k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30    = x[1]*(k30max-k30min)+k30min;
  double k3v    = sqrt(k30*k30-m3*m3);
  
  double cXi    = (pow(sqrt(s)-k30-k40,2)-pow(m5,2)-pow(k3v,2)-pow(k4v,2))/2./k3v/k4v;
  double sXi    = sqrt(1-pow(cXi,2));
#ifdef CUTS
  double pt4 = k4v*stheta;
  if( fabs(pt4) < pt4min ) return 0;
  double pt3 = k3v*sqrt(ctheta*ctheta*cos(eta)*cos(eta)*sXi*sXi + stheta*stheta*cXi*cXi+2*stheta*ctheta*sXi*cXi*cos(eta)+sin(eta)*sin(eta)*sXi*sXi);
  if( fabs(pt3) < pt3min ) return 0;
#endif

  /* Berechnung der kinematischen Invarianten */
//ALEX3
  double x14	= k30*E1 - k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x24	= k30*E2 + k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x13	= k40*E1 - k4v*pi*ctheta;
  double x23	= k40*E2 + k4v*pi*ctheta;
  double x34	= k40*k30- k3v*k4v*cXi;

  double vbfdampingscale=fmax(2*abs(x13),2*abs(x24));

  double g1hzz = g1hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzz = g2hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g3hzz = g3hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g1hzy = g1hzy_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzy = g2hzy_( &par.sm, &par.eff, vbfdampingscale );
  double ghyy  = ghyy_(  &par.sm, &par.eff, vbfdampingscale );

#include "matrixelements/production_ud_duh_NoCKM_massless.cc"

  double dP3	= (k30max-k30min)*(k40max-k40min)*4.*M_PI/8./pow(2*M_PI,4);
  double dsig =  (msq6+msq7+msq8+msq9+msq10+msq11+msq12+msq13+msq14+msq15)/4./pi/sqrt(s)*dP3/2.57e3*1e12*(1-pow(mh,2)/par.sm.s)*(1-pow(mh,2)/par.sm.s/x1);
  return dsig*higgsrenorm2(&par.sm,&((*(VBFParam*)params).eff) ); // Alex  

};
double ud_duh_CKMsQ_massless( double * x, size_t dim, void * params )
{
  VBFParam par = *(VBFParam*)params;
  double x1   = x[4]*(1-pow(par.sm.mh,2)/par.sm.s)+ pow(par.sm.mh,2)/par.sm.s;
  double x2   = x[5]*(1-pow(par.sm.mh,2)/par.sm.s/x1) + pow(par.sm.mh,2)/par.sm.s/x1;
  double m1 = 0, m2 = 0, m3 = 0, m4 = 0;
  double m5 = par.sm.mh;
  double mz = par.sm.mz;
  double sw = par.sm.sw;
  double ee = sqrt(4.*M_PI*par.sm.alphae);
  double s= x1*x2*par.sm.s;

// Alex

par.eff.fp1=0;
par.eff.fp2=0;
par.eff.fp4=0;

// xelA



  double mh   = m5;
  double vud  = 1;
  /* Daraus berechnet */
  double cw   = sqrt(1-pow(sw,2));
  double mw   = mz*cw;
  double pi   = sqrt(pow(s+m2*m2-m1*m1,2)/4./s-m2*m2);
  double E1   = sqrt(m1*m1 + pi*pi);
  double E2   = sqrt(m2*m2 + pi*pi);
  
  /* Berechne physikalische Region fuer Phasenraum */
  double eta    = x[3]*2.*M_PI; // Polarwinkel von 0 bis 2*pi
  double ctheta = x[2]*2.-1;	// Kosinus des Azimutalwinkels zw. -1 und 1
  double stheta = sqrt(1-pow(ctheta,2));
  
  double k40max = sqrt(s)/2. - (pow(m3+m5,2)-pow(m4,2))/2./sqrt(s);
  double k40min = m4;
  double k40    = x[0]*(k40max-k40min) + k40min;
  double k4v    = sqrt(k40*k40-m4*m4);	// Impuls von k4 im CMS
  
  double sigma  = sqrt(s)-k40;
  double tau    = pow(sigma,2)-pow(k4v,2);
  double mp	= m3 + m5;
  double mm	= m3 - m5;
  
  double k30min = 1./2./tau*(sigma*(tau+mm*mp)-k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30max = 1./2./tau*(sigma*(tau+mm*mp)+k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30    = x[1]*(k30max-k30min)+k30min;
  double k3v    = sqrt(k30*k30-m3*m3);
  
  double cXi    = (pow(sqrt(s)-k30-k40,2)-pow(m5,2)-pow(k3v,2)-pow(k4v,2))/2./k3v/k4v;
  double sXi    = sqrt(1-pow(cXi,2));
#ifdef CUTS
  /* Phasenraum-Cuts */
  double pt4 = k4v*stheta;
  if( fabs(pt4) < pt4min ) return 0;
  double pt3 = k3v*sqrt(ctheta*ctheta*cos(eta)*cos(eta)*sXi*sXi + stheta*stheta*cXi*cXi+2*stheta*ctheta*sXi*cXi*cos(eta)+sin(eta)*sin(eta)*sXi*sXi);
  if( fabs(pt3) < pt3min ) return 0;
#endif

  /* Berechnung der kinematischen Invarianten */
//ALEX4
  double x14	= k30*E1 - k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x24	= k30*E2 + k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x13	= k40*E1 - k4v*pi*ctheta;
  double x23	= k40*E2 + k4v*pi*ctheta;
  double x34	= k40*k30- k3v*k4v*cXi;

  double vbfdampingscale=fmax(2*abs(x13),2*abs(x24));

  double g1hww = g1hww_( &par.sm, &par.eff, vbfdampingscale );
  double g2hww = g2hww_( &par.sm, &par.eff, vbfdampingscale );
  double g3hww = g3hww_( &par.sm, &par.eff, vbfdampingscale );
  double g1hzz = g1hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzz = g2hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g3hzz = g3hzz_( &par.sm, &par.eff, vbfdampingscale );
  double g1hzy = g1hzy_( &par.sm, &par.eff, vbfdampingscale );
  double g2hzy = g2hzy_( &par.sm, &par.eff, vbfdampingscale );
  double ghyy  = ghyy_(  &par.sm, &par.eff, vbfdampingscale );

#include "matrixelements/production_ud_duh_CKMsq_massless.cc"


  double dP3	= (k30max-k30min)*(k40max-k40min)*4.*M_PI/8./pow(2*M_PI,4);
  double dsig =  (msq2+msq3+msq4+msq5)/4./pi/sqrt(s)*dP3/2.57e3*1e12*(1-pow(mh,2)/par.sm.s)*(1-pow(mh,2)/par.sm.s/x1);

  return dsig*higgsrenorm2(&par.sm,&((*(VBFParam*)params).eff) ); // Alex  

};

double ud_dpuph_massless( double * x, size_t dim, void * params )
{
  VBFParam par = *(VBFParam*)params;
  double x1   = x[4]*(1-pow(par.sm.mh,2)/par.sm.s)+ pow(par.sm.mh,2)/par.sm.s;
  double x2   = x[5]*(1-pow(par.sm.mh,2)/par.sm.s/x1) + pow(par.sm.mh,2)/par.sm.s/x1;
  double m1 = 0, m2 = 0, m3 = 0, m4 = 0;
  double m5 = par.sm.mh;
  double mz = par.sm.mz;
  double sw = par.sm.sw;
  double ee = sqrt(4.*M_PI*par.sm.alphae);
  double s    = x1*x2*par.sm.s;

// Alex

par.eff.fp1=0;
par.eff.fp2=0;
par.eff.fp4=0;

// xelA



  double mh   = m5;
  /* Daraus berechnet */
  double cw   = sqrt(1-pow(sw,2));
  double mw   = mz*cw;
  double vud  = 1;
  
  /* Berechne den einlaufenden Impuls im CMS */
  double pi   = sqrt(pow(s+m2*m2-m1*m1,2)/4./s-m2*m2);
  double E1   = sqrt(m1*m1 + pi*pi);
  double E2   = sqrt(m2*m2 + pi*pi);
  
  /* Berechne physikalische Region fuer Phasenraum */
  double eta    = x[3]*2.*M_PI; // Polarwinkel von 0 bis 2*pi
  double ctheta = x[2]*2.-1;	// Kosinus des Azimutalwinkels zw. -1 und 1
  double stheta = sqrt(1-pow(ctheta,2));
  
  double k40max = sqrt(s)/2. - (pow(m3+m5,2)-pow(m4,2))/2./sqrt(s);
  double k40min = m4;
  double k40    = x[0]*(k40max-k40min) + k40min;
  double k4v    = sqrt(k40*k40-m4*m4);	// Impuls von k4 im CMS
  
  double sigma  = sqrt(s)-k40;
  double tau    = pow(sigma,2)-pow(k4v,2);
  double mp	= m3 + m5;
  double mm	= m3 - m5;
  
  double k30min = 1./2./tau*(sigma*(tau+mm*mp)-k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30max = 1./2./tau*(sigma*(tau+mm*mp)+k4v*sqrt((tau-pow(mp,2))*(tau-pow(mm,2))));
  double k30    = x[1]*(k30max-k30min)+k30min;
  double k3v    = sqrt(k30*k30-m3*m3);
  
  double cXi    = (pow(sqrt(s)-k30-k40,2)-pow(m5,2)-pow(k3v,2)-pow(k4v,2))/2./k3v/k4v;
  double sXi    = sqrt(1-pow(cXi,2));
#ifdef CUTS
  /* Phasenraum-Cuts */
  double pt4 = k4v*stheta;
  if( fabs(pt4) < pt4min ) return 0;
  double pt3 = k3v*sqrt(ctheta*ctheta*cos(eta)*cos(eta)*sXi*sXi + stheta*stheta*cXi*cXi+2*stheta*ctheta*sXi*cXi*cos(eta)+sin(eta)*sin(eta)*sXi*sXi);
  if( fabs(pt3) < pt3min ) return 0;
#endif

  /* Berechnung der kinematischen Invarianten */
//ALEX5
  double x14	= k30*E1 - k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x24	= k30*E2 + k3v*pi*(ctheta*cXi-stheta*cos(eta)*sXi);
  double x13	= k40*E1 - k4v*pi*ctheta;
  double x23	= k40*E2 + k4v*pi*ctheta;
  double x34	= k40*k30- k3v*k4v*cXi;

  double vbfdampingscale=fmax(2*abs(x13),2*abs(x24));

  double g1hww = g1hww_( &par.sm, &par.eff, vbfdampingscale );
  double g2hww = g2hww_( &par.sm, &par.eff, vbfdampingscale );
  double g3hww = g3hww_( &par.sm, &par.eff, vbfdampingscale );

#include "matrixelements/production_ud_dpuph_massless.cc"


  double dP3	= (k30max-k30min)*(k40max-k40min)*4.*M_PI/8./pow(2*M_PI,4);
  double dsigT =  msq1/4./pi/sqrt(s)*dP3/2.57e3*1e12*(1-pow(mh,2)/par.sm.s)*(1-pow(mh,2)/par.sm.s/x1);

  return dsigT*higgsrenorm2(&par.sm,&((*(VBFParam*)params).eff) ); // Alex  

};
