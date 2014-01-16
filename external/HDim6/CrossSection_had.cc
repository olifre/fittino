#include <LHAPDF/LHAPDF.h>

#include "CrossSection_had.h"

/* Initialisierung zur Berechnung der Standardmodell-Wirkungsquerschnitte */

void init_hadronic_cs_( sminputs * smpar )
{
  effinputs temp;

  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
 
  HWRadiation_( smpar, &temp, &pp_wh_sm, &err_wh_sm,  &chi_wh_sm );
  HZRadiation_( smpar, &temp, &pp_zh_sm, &err_zh_sm,  &chi_zh_sm );
  Gluonfusion_( smpar, &temp, &ggh_sm,   &err_ggh_sm, &chi_ggh_sm );
  std::cout<<"pp->wh = "<<pp_wh_sm<<" pp->zh = "<<pp_zh_sm<<" gg->h = "<<ggh_sm<<std::endl;
};

/* Berechnung der Ratios */

void ratio_tth_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  double s = smpar->mh + 2.*smpar->mto;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar; 
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  *ratio = pow(ftoh_( smpar, &myeffpar, s), 2)*higgsrenorm2(smpar,effpar);
  *err   = 0;
  *chisq = 1;
};

void ratio_bg_bh_(sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq )
{
  double s = smpar->mh + smpar->mbo;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar; 
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  *ratio = pow( fboh_( smpar, &myeffpar, s ),2)*higgsrenorm2(smpar,effpar);
  *err   = 0;
  *chisq = 1;
};

void ratio_bb_h_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  effinputs myeffpar=*effpar; 
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  myeffpar.fp1=0;
  myeffpar.fp2=0;
  myeffpar.fp4=0;
  // xelA

  /* Ratio given through modified Yukawa-Coupling! */
  *ratio = pow( fboh_( smpar, &myeffpar, smpar->mh), 2)*higgsrenorm2(smpar,effpar);
  *err   = 0;
  *chisq = 1;
};

void ratio_ggh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
printf("\n ratio_ggh_ was called\n");
  double cs = 0, error = 0, chi = 0;
  Gluonfusion_( smpar, effpar, &cs, &error, &chi );
  *ratio = cs/ggh_sm;
  *err   = error/ggh_sm + cs/pow(ggh_sm,2)*err_ggh_sm;
  *chisq         = chi;
};

void ratio_pphw_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) {
  double result, error, chi;
  HWRadiation_( smpar, effpar, &result, &error, &chi );
  *ratio = result / pp_wh_sm;
  *err   = error / pp_wh_sm + result / pow( pp_wh_sm, 2 ) * err_wh_sm;
  *chisq = chi;
};

void ratio_pphz_(  sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) {
  double result, error, chi;
  HZRadiation_( smpar, effpar, &result, &error, &chi );
  *ratio = result / pp_zh_sm;
  *err   = error / pp_zh_sm + result / pow( pp_zh_sm, 2 ) * err_zh_sm;
  *chisq = chi;
};

void Gluonfusion_( sminputs * smpar, effinputs * effpar, double * cSec, double * err, double * chisq )
{
   double xl    = 0;
   double xu    = 1;
   size_t calls = CSCalls;
   size_t dim   = 1;
   
   const gsl_rng_type * T; 
   gsl_rng * r;

   T = gsl_rng_default;
   r = gsl_rng_alloc( T );
   
   gsl_monte_function G;
   *chisq = 1;
   double result=0, error=0;
   radparam par;
   par.smpar  = *smpar;
   par.effpar = *effpar;
   

   {
     G = (gsl_monte_function){ggH, dim, &par};
     gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
     int k = 0;
     do{
      gsl_monte_vegas_integrate( &G,&xl,&xu,dim,calls,r,s,&result,&error); }
     while( fabs( gsl_monte_vegas_chisq( s ) - 1 ) > 0.2 && k < CSstep );
     *chisq = gsl_monte_vegas_chisq( s );
     gsl_monte_vegas_free( s );
   };
   
   *cSec = result; // *higgsrenorm2(smpar,effpar);
   *err  = error;
};

void HZRadiation_( sminputs * smpar, effinputs * effpar, double * cSec, double * err, double * chisq ) 
{  
  double mq[]  = { 0, smpar->mdo, smpar->mup, smpar->mst, smpar->mch, smpar->mbo };
  double result = 0, error = 0, cs = 0, toterr = 0;
  
  size_t dim = 3;
  double xl[] = { 0, 0, 0 };
  double xu[] = { 1, 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = CSCalls;
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  
  *chisq = 1;
  gsl_monte_function G;
  /* Loop over Initial Quarks */
  for( int i = 1; i <= 5; i++ )
  {
    radparam par;
    par.mq1    = mq[i];
    par.mq2    = mq[i];
    par.ckm    = 0;
    par.PDG1   = i;
    par.PDG2   = -i;
    par.smpar  = *smpar;
    par.effpar = *effpar;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  par.effpar.fp1=0;
  par.effpar.fp2=0;
  par.effpar.fp4=0;
  // xelA


    /*
    double par[] = { smpar->mh, smpar->mz, mq[i], sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, 0, 0, effpar->g1hww, 
		     effpar->g2hww, effpar->g3hww, effpar->g1hzz, effpar->g2hzz, effpar->g3hzz, effpar->g1hzy, effpar->g2hzy, effpar->ghyy, (double)i, -(double)i };
    */
    if(!(i%2)) 
    {
        G = (gsl_monte_function){ m_uU_ZH, dim, &par };
    }
    else
    {
        G = (gsl_monte_function){ m_dD_ZH, dim, &par };
    };      
    gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
    int k = 0;
    do {
      k++;
      gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
    } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2 && k < CSstep );  
    double chi = gsl_monte_vegas_chisq( s );
    *chisq = (fabs(*chisq-1) > fabs(chi-1) ? *chisq : chi );
    gsl_monte_vegas_free( s );
    cs     += result;
    toterr += error;
      
  };
  *cSec = cs*higgsrenorm2(smpar,effpar);
  *err  = toterr;  
};

void HWRadiation_( sminputs * smpar, effinputs * effpar, double * cSec, double * err, double * chisq ) 
{  
  double mq[]  = { 0, smpar->mdo, smpar->mup, smpar->mst, smpar->mch, smpar->mbo };
  double result = 0, error = 0, cs = 0, toterr = 0;
  
  size_t dim = 3;
  double xl[] = { 0, 0, 0 };
  double xu[] = { 1, 1, 1 };
  
  const gsl_rng_type * T; 
  gsl_rng * r;
  size_t calls = CSCalls;
  
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc( T );
  *chisq = 1;
  /* Loop over Initial Quarks */
  int i = 2, j = 1;
  do
  {
    j = 1;
    do
    {
      
      double vckm;
      if( (i == 2 ) )
      {
	if( j == 1 )
	  vckm = smpar->vud;
	if( j == 3 )
	  vckm = smpar->vus;
	if( j == 5 )
	  vckm = smpar->vub;
      };
      if( (i==4) )
      {
	if( j == 1 )
	  vckm = smpar->vcd;
	if( j == 3 )
	  vckm = smpar->vcs;
	if( j == 5 )
	  vckm = smpar->vcb;
      };
      radparam par;
      par.mq1    = mq[j];
      par.mq2    = mq[i];
      par.PDG1   = i;
      par.PDG2   = -j;
      par.ckm    = vckm;
      par.smpar  = *smpar;
      par.effpar = *effpar;

  // Alex : set anomalous yukawas to zero in ggh interaction. For this reason reroute effpars to a local variable
  // Also kill off the Higgs rescaling effect, add 
  // Higgs renormalization effect globally
  par.effpar.fp1=0;
  par.effpar.fp2=0;
  par.effpar.fp4=0;
  // xelA


      gsl_monte_function G = { &m_qqp_WH, dim, &par };
      gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
      int k = 0;
      do {
	k++;
	gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
      } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2 && k < CSstep );
      double chi = gsl_monte_vegas_chisq(s);
      *chisq = (fabs(*chisq-1) > fabs(chi-1) ? *chisq : chi );
      gsl_monte_vegas_free( s );
      cs     += result;
      toterr += error;

      par.PDG1   = -i;
      par.PDG2   = j;
      G = (gsl_monte_function){ &m_qqp_WH, dim, &par };
      s = gsl_monte_vegas_alloc( dim );
      k = 0;
      do {
	k++;
	gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
      } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.2 && k < CSstep );
      chi = gsl_monte_vegas_chisq(s);
      *chisq = (fabs(*chisq-1) > fabs(chi-1) ? *chisq : chi );
      gsl_monte_vegas_free( s );
      cs     += result;
      toterr += error;
     
      j += 2;
    }while( j <= 5 );
    i += 2;
  }while( i <= 4 );
  *cSec = cs*higgsrenorm2(smpar,effpar);
  *err  = toterr;  
};

double m_qqp_WH( double * x, size_t dim, void * param )
{
  /* Parameter */
  radparam * par = (radparam*)param;
  double mb = par->mq1;
  double mc = par->mq2;
  double ckm= par->ckm;
  int pdg1 = par->PDG1;
  int pdg2 = par->PDG2;

  effinputs effpar = par->effpar;
  sminputs  smpar  = par->smpar;
  double mh = smpar.mh;
  double mz = smpar.mz;
  double ee = sqrt(4*M_PI*smpar.alphae);
  double sw = smpar.sw;
  double S  = smpar.s;
  
  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  /* Fuer PDF-Faltung */
  double x1 = x[1]*(1-pow(mw+mh,2)/S) + pow(mw+mh,2)/S;
  double x2 = x[2]*(1-pow(mw+mh,2)/S/x1) + pow(mw+mh,2)/S/x1;
  double s = S*x1*x2;

  double g1hww = g1hww_( &smpar, &effpar, s );
  double g2hww = g2hww_( &smpar, &effpar, s );
  double g3hww = g3hww_( &smpar, &effpar, s );
  
  double tmin, tmax;
  tbounds( mb, mc, mw, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = pow(mb,2) + pow(mc,2) + pow(mh,2) + pow(mw,2) - s - t;
 
#include "matrixelements/production_m_qqp_WH.cc" 
  
  double pi = _pi(mb, mc, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msq / 2.57e3*1e12 * (tmax - tmin)*(1-pow(mh+mw,2)/S)*(1-pow(mw+mh,2)/S/x1)*1./x1/x2*(LHAPDF::xfx(x1,mh,pdg1)*LHAPDF::xfx(x2,mh,pdg2)+LHAPDF::xfx(x2,mh,pdg1)*LHAPDF::xfx(x1,mh,pdg2));
  return dsigdt;
};

double m_dD_ZH( double * x, size_t dim, void * param )
{
  radparam * par = (radparam*)param;
  double mq = par->mq1;
  //double ckm= par->ckm;
  int pdg1 = par->PDG1;
  int pdg2 = par->PDG2;

  effinputs effpar = par->effpar;
  sminputs  smpar  = par->smpar;
  double mh = smpar.mh;
  double mz = smpar.mz;
  double ee = sqrt(4*M_PI*smpar.alphae);
  double sw = smpar.sw;
  double S  = smpar.s;
  
  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  /* Fuer PDF's */
  double x1 = x[1]*(1-pow(mz+mh,2)/S)+pow(mz+mh,2)/S;
  double x2 = x[2]*(1-pow(mz+mh,2)/S/x1) + pow(mz+mh,2)/S/x1;
  double s = S*x1*x2;

  double g1hzz = g1hzz_( &smpar, &effpar, s );
  double g2hzz = g2hzz_( &smpar, &effpar, s );
  double g1hzy = g1hzy_( &smpar, &effpar, s );
  double g2hzy = g2hzy_( &smpar, &effpar, s );
  double g3hzz = g2hzz_( &smpar, &effpar, s );
  
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;

#include "matrixelements/production_m_dD_ZH.cc"  

  double msqtotal = (msq1+msq2+msq3)*(tmax-tmin);
  double pi = _pi(mq, mq, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msqtotal / 2.57e3*1e12 * (1-pow(mz+mh,2)/S)*(1-pow(mh+mz,2)/S/x1)*1./x1/x2*(LHAPDF::xfx(x1,mh,pdg1)*LHAPDF::xfx(x2,mh,pdg2)+LHAPDF::xfx(x2,mh,pdg1)*LHAPDF::xfx(x1,mh,pdg2));
  return dsigdt;
};

double m_uU_ZH( double * x, size_t dim, void * param )
{
  /* Parameter */
  radparam * par = (radparam*)param;
  double mq = par->mq1;
  //double ckm= par->ckm;
  int pdg1 = par->PDG1;
  int pdg2 = par->PDG2;

  effinputs effpar = par->effpar;
  sminputs  smpar  = par->smpar;
  double mz = smpar.mz;
  double mh = smpar.mh;
  double sw = smpar.sw;
  double ee = sqrt(4*M_PI*smpar.alphae);
  double S  = smpar.s;
  
  /* Berechnete Groessen */
  double cw = sqrt(1-sw*sw);
  double mw = mz*cw;
  
  /* Fuer LHAPDF */
  
  double x1 = x[1]*(1-pow(mz+mh,2)/S) + pow(mh+mz,2)/S;
  double x2 = x[2]*(1-pow(mz+mh,2)/S/x1) + pow(mh+mz,2)/S/x1;
  double s  = x1*x2*S;

  double g1hzz = g1hzz_( &smpar, &effpar, s );
  double g2hzz = g2hzz_( &smpar, &effpar, s );
  double g3hzz = g3hzz_( &smpar, &effpar, s );
  double g1hzy = g1hzy_( &smpar, &effpar, s );
  double g2hzy = g2hzy_( &smpar, &effpar, s );
    
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;

#include "matrixelements/production_m_uU_ZH.cc"
  
  double msqtotal = (msq1 + msq2 + msq3)*(tmax - tmin);
  double pi = _pi(mq, mq, s);
  double dsigdt = 1./64./s/pow(pi,2.)/M_PI*msqtotal / 2.57e3*1e12 * (1-pow(mz+mh,2)/S)*(1-pow(mz+mh,2)/S/x1)*1./x1/x2*(LHAPDF::xfx(x1,mh,pdg1)*LHAPDF::xfx(x2,mh,pdg2)+LHAPDF::xfx(x2,mh,pdg1)*LHAPDF::xfx(x1,mh,pdg2));
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

double ggH( double * x, size_t dim, void * param )
{
   radparam * par = (radparam*)param;
   sminputs  smpar = par->smpar;
   effinputs effpar = par->effpar;
 
   double mf[] = { smpar.mup, smpar.mdo, smpar.mch, smpar.mst, smpar.mto, smpar.mbo };

  // Alex : set anomalous yukawas to zero in ggh interaction
  effpar.ftoh=0;
  effpar.fboh=0;
  effpar.fsth=0;
  effpar.fchh=0;
  effpar.fdoh=0;
  effpar.fuph=0;
   // Alex
        effpar.fp1=0; // We kill off the effect of the Higgs rescaling
        effpar.fp2=0; // We kill off the effect of the Higgs rescaling
        effpar.fp4=0; // We kill off the effect of the Higgs rescaling
   // xelA

  // xelA

   double ff[] = { fuph_( &smpar, &effpar, smpar.mh ), 
		   fdoh_( &smpar, &effpar, smpar.mh ),
		   fchh_( &smpar, &effpar, smpar.mh ), 
		   fsth_( &smpar, &effpar, smpar.mh ), 
		   ftoh_( &smpar, &effpar, smpar.mh ), 
		   fboh_( &smpar, &effpar, smpar.mh ) };   
   complex<double> Af( 0, 0 );
   for( int i = 0; i < 6; i++ )
   {
      double tau = 4.*pow(mf[i]/smpar.mh,2);
      complex< double > ftau( 0, 0 );
      if( tau >= 1.0 )
      {
	ftau =complex< double >( pow(asin(1/sqrt(tau)),2) , 0 );
      }
      else
      {
	double np = 1+sqrt(1-tau);
	double nm = 1-sqrt(1-tau);
	double re = log(np/nm);
	double im = -M_PI;
	ftau = -1.0/4.0*pow(complex< double >( re, im ),2);
      }
      Af += -tau*(complex<double>(1,0)+(1-tau)*ftau)*sqrt(2)*smpar.alphas/M_PI/smpar.vev*ff[i];
   };
   complex<double> Aano(-4*ghgg_( &smpar, &effpar, smpar.mh ), 0);
   complex<double> A = Af + Aano;
   double Gamma = pow(smpar.mh,3)/64.0/M_PI*abs(A*A);
   double x1 = *x*(1-pow(smpar.mh,2)/smpar.s)+pow(smpar.mh,2)/smpar.s;
   double x2 = pow(smpar.mh,2)/x1/smpar.s;
   double returnvalue=1.0/x1/x2*LHAPDF::xfx(x1,smpar.mh,0)*LHAPDF::xfx(x2,smpar.mh,0)/x1/smpar.s*pow(M_PI,2)/8.0/smpar.mh*Gamma*(1-pow(smpar.mh,2)/smpar.s)/2.57e3*1e12;
   return returnvalue*higgsrenorm2(&(par->smpar),&(par->effpar));
};

void k_ggh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq )
{
  *chisq = 1;
  *err   = 0;
  sminputs  smpar  = *SMparam;
  effinputs effpar = *ESMparam;
  double mf[] = { smpar.mup, smpar.mdo, smpar.mch, smpar.mst, smpar.mto, smpar.mbo };
  // Alex : set anomalous yukawas to zero in ggh interaction
  effpar.ftoh=0;
  effpar.fboh=0;
  effpar.fsth=0;
  effpar.fchh=0;
  effpar.fdoh=0;
  effpar.fuph=0;

   // Alex
        effpar.fp1=0; // We kill off the effect of the Higgs rescaling
        effpar.fp2=0; // We kill off the effect of the Higgs rescaling
        effpar.fp4=0; // We kill off the effect of the Higgs rescaling
   // xelA

  // xelA
  double ff[] = { fuph_( &smpar, &effpar, smpar.mh ), 
	          fdoh_( &smpar, &effpar, smpar.mh ),
	          fchh_( &smpar, &effpar, smpar.mh ), 
	          fsth_( &smpar, &effpar, smpar.mh ), 
	          ftoh_( &smpar, &effpar, smpar.mh ), 
	          fboh_( &smpar, &effpar, smpar.mh ) };   
   complex<double> Af( 0, 0 );
   complex<double> Af0( 0, 0 );
   complex<double> A(-4*ghgg_( &smpar, &effpar, smpar.mh ), 0);
   for( int i = 0; i < 6; i++ )
   {
      double tau = 4.*pow(mf[i]/smpar.mh,2);
      complex< double > ftau( 0, 0 );
      if( tau >= 1.0 )
      {
	ftau =complex< double >( pow(asin(1/sqrt(tau)),2) , 0 );
      }
      else
      {
	double np = 1+sqrt(1-tau);
	double nm = 1-sqrt(1-tau);
	double re = log(np/nm);
	double im = -M_PI;
	ftau = -1.0/4.0*pow(complex< double >( re, im ),2);
      }
      Af += -tau*(complex<double>(1,0)+(1-tau)*ftau)*sqrt(2)*smpar.alphas/M_PI/smpar.vev*ff[i];
      Af0+= -tau*(complex<double>(1,0)+(1-tau)*ftau)*sqrt(2)*smpar.alphas/M_PI/smpar.vev;
   };
   complex<double> kappa = (Af + A)/Af0;
   *ratio = pow(abs(kappa),2)*higgsrenorm2(SMparam,ESMparam);
};
