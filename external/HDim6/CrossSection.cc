#include "CrossSection.h"

/* Initialisierung zur Berechnung der Standardmodell-Wirkungsquerschnitte */

void init_(         sminputs * smpar )
{
  double err;
  effinputs temp;
  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
 
  uu_zh_( smpar, &temp, &uu_zh_sm, &err );
  dd_zh_( smpar, &temp, &dd_zh_sm, &err ); 
  cc_zh_( smpar, &temp, &cc_zh_sm, &err );
  ss_zh_( smpar, &temp, &ss_zh_sm, &err );
  bb_zh_( smpar, &temp, &bb_zh_sm, &err );
  
  ud_wh_( smpar, &temp, &ud_wh_sm, &err );
  us_wh_( smpar, &temp, &us_wh_sm, &err );
  ub_wh_( smpar, &temp, &ub_wh_sm, &err );
  cd_wh_( smpar, &temp, &cd_wh_sm, &err );
  cs_wh_( smpar, &temp, &cs_wh_sm, &err );
  cb_wh_( smpar, &temp, &cb_wh_sm, &err );
};

/* Berechnung der Ratios */

void ratio_tth_(   sminputs * smpar, effinputs * effpar, double * ratio, double * err ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  double s = 2.*smpar->mto + smpar->mh;
  *ratio = pow(ftoh_( smpar, effpar, s), 2);
  *err   = 0;
};

void ratio_bb_h_(   sminputs * smpar, effinputs * effpar, double * ratio, double * err ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  double s = smpar->mh;
  *ratio = pow(fboh_( smpar, effpar, s ),2);
  *err   = 0;
};

void ratio_ggh_(   sminputs * smpar, effinputs * effpar, double * ratio, double * err ) 
{
  double mh = smpar->mh;
  double mt = smpar->mto;
  double z = pow( mt/mh, 2. );
  double I = (2.*z - 2*z*(4.*z - 1)*pow(asin(1/2./sqrt(z)), 2.));
  double fgg = effpar->fgg/pow(1+mh/effpar->rgg,effpar->ngg);
  double factor = pow(1+fgg*M_PI*pow(smpar->vev,2)*sqrt(2)/smpar->alphas/I, 2);
  *ratio         = factor;  
  *err           = 0;
};

void ratio_uu_zh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  uu_zh_( smpar, effpar, &cs, &_err );
  *ratio = cs/uu_zh_sm;
  *err   = _err/cs;
};

void ratio_dd_zh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  dd_zh_( smpar, effpar, &cs, &_err );
  *ratio = cs/dd_zh_sm;
  *err   = _err/cs;
};

void ratio_cc_zh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  cc_zh_( smpar, effpar, &cs, &_err );
  *ratio = cs/cc_zh_sm;
  *err   = _err/cs;
};

void ratio_ss_zh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  ss_zh_( smpar, effpar, &cs, &_err );
  *ratio = cs/ss_zh_sm;
  *err   = _err/cs;
};

void ratio_bb_zh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  bb_zh_( smpar, effpar, &cs, &_err );
  *ratio = cs/bb_zh_sm;
  *err   = _err/cs;
};

void ratio_ud_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  ud_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/ud_wh_sm;
  *err   = _err/cs;
};

void ratio_us_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  us_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/us_wh_sm;
  *err   = _err/cs;
};

void ratio_ub_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  ub_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/ub_wh_sm;
  *err   = _err/cs;
};

void ratio_cd_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  cd_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/cd_wh_sm;
  *err   = _err/cs;
};

void ratio_cs_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  cs_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/cs_wh_sm;
  *err   = _err/cs;
};

void ratio_cb_wh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err )
{
  double cs, _err;
  cb_wh_( smpar, effpar, &cs, &_err );
  *ratio = cs/cb_wh_sm;
  *err   = _err/cs;
};

// H-Radiation from Z-Boson
void uu_zh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mup, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, 
		   g1hww, g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_uU_ZH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void cc_zh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA


  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mch, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_uU_ZH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void dd_zh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA


  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mdo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_dD_ZH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void ss_zh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mst, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_dD_ZH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void bb_zh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mbo, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_dD_ZH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};

// H-Radiation from W-Boson
void ud_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA


  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mdo, smpar->mup, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vud, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void us_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

   // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );

  double par[] = { smpar->mh, smpar->mz, smpar->mst, smpar->mup, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vus, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void ub_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

   // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );

  double par[] = { smpar->mh, smpar->mz, smpar->mbo, smpar->mup, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vub, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void cd_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA


  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
 
  double par[] = { smpar->mh, smpar->mz, smpar->mdo, smpar->mch, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vcd, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void cs_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA


  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mst, smpar->mch, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vcs, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};
void cb_wh_( sminputs * smpar, effinputs * effpar, double * cSec, double * err ) {
  size_t dim = 1;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar;
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  double g1hww = g1hww_( smpar, &myeffpar, smpar->s );
  double g2hww = g2hww_( smpar, &myeffpar, smpar->s );
  double g3hww = g3hww_( smpar, &myeffpar, smpar->s );
  double g1hzz = g1hzz_( smpar, &myeffpar, smpar->s );
  double g2hzz = g2hzz_( smpar, &myeffpar, smpar->s );
  double g3hzz = g3hzz_( smpar, &myeffpar, smpar->s );
  double g1hzy = g1hzy_( smpar, &myeffpar, smpar->s );
  double g2hzy = g2hzy_( smpar, &myeffpar, smpar->s );
  double ghyy  = ghyy_(  smpar, &myeffpar, smpar->s );
  //double ghgg  = ghgg_(  smpar, effpar, smpar->s );
  
  double par[] = { smpar->mh, smpar->mz, smpar->mbo, smpar->mch, sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, smpar->vcb, g1hww, 
                   g2hww, g3hww, g1hzz, g2hzz, g3hzz, g1hzy, g2hzy, ghyy };
  double result, error;
  
  double xl[] = { 0 };
  double xu[] = { 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = 10000;
  gsl_monte_function G = { m_qqp_WH, dim, par };
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  {
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    gsl_monte_vegas_free( s );
  };
  
  *cSec = result*higgsrenorm2(smpar,effpar);
  *err  = error;
};

double m_qqp_WH( double * x, size_t dim, void * param )
{
  /* Parameter */
  double mh = ((double*)param)[0];
  double mz = ((double*)param)[1];
  double mb = ((double*)param)[2];
  double mc = ((double*)param)[3];
  double ee = ((double*)param)[4];
  double sw = ((double*)param)[5];
  double s  = ((double*)param)[6];
  double ckm= ((double*)param)[7];
  double g1hww = ((double*)param)[8];
  double g2hww = ((double*)param)[9];
  double g3hww = ((double*)param)[10];
  //double g1hzz = ((double*)param)[11];
  //double g2hzz = ((double*)param)[12];
  //double g3hzz = ((double*)param)[13];
  //double g1hzy = ((double*)param)[14];
  //double g2hzy = ((double*)param)[15];
  //double ghyy  = ((double*)param)[16];
  
  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  double tmin, tmax;
  tbounds( mb, mc, mw, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = pow(mb,2) + pow(mc,2) + pow(mh,2) + pow(mw,2) - s - t;
 
#include "matrixelements/production_m_qqp_WH2.cc"
 
 
  double pi = _pi(mb, mc, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msq / 2.57e3*1e12 * (tmax - tmin);
  return dsigdt;
};

double m_dD_ZH( double * x, size_t dim, void * param )
{
  /* Parameter */
  double mh = ((double*)param)[0];
  double mz = ((double*)param)[1];
  double mq = ((double*)param)[2];
  double ee = ((double*)param)[3];
  double sw = ((double*)param)[4];
  double s  = ((double*)param)[5];
  //double ckm= ((double*)param)[7];
  //double g1hww = ((double*)param)[8];
  //double g2hww = ((double*)param)[9];
  //double g3hww = ((double*)param)[10];
  double g1hzz = ((double*)param)[11];
  double g2hzz = ((double*)param)[12];
  double g3hzz = ((double*)param)[13];
  double g1hzy = ((double*)param)[14];
  double g2hzy = ((double*)param)[15];
  //double ghyy  = ((double*)param)[16];
  
  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;

#include "matrixelements/production_m_dD_ZH2.cc"
  
  double msqtotal = (msq1+msq2+msq3)*(tmax-tmin);
  double pi = _pi(mq, mq, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msqtotal / 2.57e3*1e12;
  return dsigdt;
};

double m_uU_ZH( double * x, size_t dim, void * param )
{
  /* Parameter */
  double mh = ((double*)param)[0];
  double mz = ((double*)param)[1];
  double mq = ((double*)param)[2];
  double ee = ((double*)param)[3];
  double sw = ((double*)param)[4];
  double s  = ((double*)param)[5];
  //double ckm= ((double*)param)[7];
  //double g1hww = ((double*)param)[8];
  //double g2hww = ((double*)param)[9];
  //double g3hww = ((double*)param)[10];
  double g1hzz = ((double*)param)[11];
  double g2hzz = ((double*)param)[12];
  double g3hzz = ((double*)param)[13];
  double g1hzy = ((double*)param)[14];
  double g2hzy = ((double*)param)[15];
  //double ghyy  = ((double*)param)[16];

  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;
 
#include "matrixelements/production_m_uU_ZH2.cc"
 
  double msqtotal = (msq1 + msq2 + msq3)*(tmax - tmin);
  double pi = _pi(mq, mq, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msqtotal / 2.57e3*1e12;
  return dsigdt;
};

/* Funktionen fuer Zweiteilchen-Phasenraum */

int  tbounds( double m1, double m2, double m3, double m4, double s, double * lbound, double * ubound )
{
  if( !lbound ) return -1;
  if( !ubound ) return -1;
  
  double beta = _beta( m3, m4, s );
  double pi   = _pi( m1, m2, s );
  double tmin = m3*m3 + m4*m4 - 2*(sqrt(m3*m3+beta*beta)*sqrt(m1*m1+pi*pi) + beta*pi);
  double tmax = m3*m3 + m4*m4 - 2*(sqrt(m3*m3+beta*beta)*sqrt(m1*m1+pi*pi) - beta*pi);
  *lbound = tmin;
  *ubound = tmax;
  return 0;
};

double _beta( double m3, double m4, double s )
{
  return 1./2./sqrt(s)*sqrt(pow(s+m3*m3-m4*m4,2)-4*s*m3*m3);
};

double _pi( double m1, double m2, double s )
{
  return sqrt(1./4./s*pow(s+m2*m2-m1*m1, 2)-m2*m2);
};
