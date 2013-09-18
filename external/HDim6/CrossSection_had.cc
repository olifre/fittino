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
  *ratio = pow(ftoh_( smpar, effpar, s), 2);
  *err   = 0;
  *chisq = 1;
};

void ratio_bg_bh_(sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq )
{
  double s = smpar->mh + smpar->mbo;
  *ratio = pow( fboh_( smpar, effpar, s ),2);
  *err   = 0;
  *chisq = 1;
};

void ratio_bb_h_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  *ratio = pow( fboh_( smpar, effpar, smpar->mh), 2);
  *err   = 0;
  *chisq = 1;
};

void ratio_ggh_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
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
   
   *cSec = result;
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
    } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.5 && k < CSstep );  
    double chi = gsl_monte_vegas_chisq( s );
    *chisq = (fabs(*chisq-1) > fabs(chi-1) ? *chisq : chi );
    gsl_monte_vegas_free( s );
    cs     += result;
    toterr += error;
      
  };
  *cSec = cs;
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
      gsl_monte_function G = { &m_qqp_WH, dim, &par };
      gsl_monte_vegas_state * s = gsl_monte_vegas_alloc( dim );
      int k = 0;
      do {
	k++;
	gsl_monte_vegas_integrate( &G, xl, xu, dim, calls, r, s, &result, &error );
      } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.5 && k < CSstep );
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
      } while (fabs (gsl_monte_vegas_chisq (s) - 1.0) > 0.5 && k < CSstep );
      chi = gsl_monte_vegas_chisq(s);
      *chisq = (fabs(*chisq-1) > fabs(chi-1) ? *chisq : chi );
      gsl_monte_vegas_free( s );
      cs     += result;
      toterr += error;
     
      j += 2;
    }while( j <= 5 );
    i += 2;
  }while( i <= 4 );
  *cSec = cs;
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
  
 double g364,g374,g144,g397,g101,g401,g82,g379,g40,g388,g9,g387,g4,g373,g20,g5,g32,g8,g6,g73,g393,g186,g17,g7,g383,g47,g46,g10,g137,g407,g11,g375,g366,g64,g38,g19,g12,
       g13,g72,g18,g14,g356,g16,g15,g21,g22,g362,g381,g65,g48,g23,g341,g24,g386,g34,g39,g26,g41,g27,g157,g28,g350,g29,g30,g31,g355,g253,g33,g83,g141,g119,g35,g395,g36,
       g361,g358,g79,g37,g42,g312,g43,g54,g44,g398,g185,g115,g92,g45,g81,g49,g124,g80,g50,g354,g380,g52,g249,g122,g143,g53,g291,g56,g63,g261,g57,g61,g59,g60,g62,g66,g367,
       g363,g118,g339,g68,g96,g189,g194,g351,g162,g378,g100,g78,g76,g84,g85,g120,g172,g112,g91,g88,g110,g89,g111,g90,g93,g400,g142,g117,g94,g95,g145,g116,g97,g98,g99,g102,
       g104,g105,g106,g109,g125,g114,g121,g123,g181,g140,g209,g180,g129,g179,g406,g130,g178,g405,g131,g177,g404,g132,g171,g402,g133,g173,g176,g174,g403,g138,g146,g147,g243,
       g170,g155,g169,g154,g156,g275,g158,g160,g161,g272,g164,g271,g165,g166,g270,g168,g377,g182,g365,g183,g184,g195,g200,g201,g202,g203,g204,g349,g207,g208,g210,g211,g212,
       g213,g214,g215,g216,g219,g394,g221,g222,g223,g384,g399,g226,g227,g228,g229,g230,g232,g233,g239,g241,g244,g245,g254,g260,g252,g255,g258,g259,g266,g276,g278,g282,g285,
       g286,g296,g300,g304,g307,g309,g311,g314,g391,g550,g437,g549,g424,g452,g552,g431,g425,g426,g427,g554,g555,g428,g548,g429,g430,g432,g556,g433,g532,g533,g444,g534,g535,
       g453,g434,g435,g436,g438,g439,g440,g482,g441,g442,g443,g445,g446,g497,g447,g448,g519,g449,g450,g451,g510,g455,g485,g454,g515,g456,g491,g457,g558,g458,g538,g539,g459,
       g460,g559,g461,g462,g463,g500,g464,g525,g544,g466,g520,g502,g472,g523,g469,g501,g471,g474,g476,g560,g477,g565,g483,g486,g487,g488,g489,g490,g492,g493,g494,g495,g496,
       g498,g499,g503,g504,g505,g506,g507,g508,g509,g511,g512,g513,g514,g516,g517,g518,g521,g522,g524,g526,g527,g528,g529,g530,g531,g536,g537,g540,g541,g542,g543,g545,g546,
       g547,g551,g553,g557,g561,g562,g563,g564,g566,g567,g568,g569,g570,g571,g572,g348,msq,t0;
    {
    g364=ckm*ckm;
    g374=ee*ee;
    g144=g374*g364;
    g397=sw*sw;
    g101=g397*g144;
    g401=mw*mw;
    g82=g401*g101;
    g379=g1hww*g1hww;
    g40=g379*g82;
    g388=u*u;
    g9=g388*g40;
    g387=mc*mc;
    g4=g387*g9;
    g373=t*t;
    g20=g373*g40;
    g5=g387*g20;
    g32=g82*t;
    g8=g387*g32;
    g6=g8*u;
    g73=g101*u;
    g393=mh*mh;
    g186=g393*g379;
    g17=g186*g73;
    g7=g17*s;
    g383=mb*mb;
    g47=g383*g101;
    g46=g47*s;
    g10=g373*g46;
    g137=g1hww*s;
    g407=g137*g137;
    g11=g407*g73;
    g375=g401*mw;
    g366=g375*mw;
    g64=g366*g101;
    g38=g379*g64;
    g19=g387*g38;
    g12=g19*u;
    g13=g19*t;
    g72=g101*s;
    g18=g186*g72;
    g14=g366*g18;
    g356=g387*g387;
    g16=g356*g40;
    g15=g16*u;
    g21=g366*g47;
    g22=g387*g40;
    g362=g366*mw;
    g381=g362*mw;
    g65=g381*g101;
    g48=g379*g65;
    g23=g393*g48;
    g341=g3hww*g1hww;
    g24=g341*g82;
    g386=g3hww*g3hww;
    g34=g386*g82;
    g39=g387*g65;
    g26=g39*u;
    g41=g381*g47;
    g27=g41*t;
    g157=g356*t;
    g28=g157*g64;
    g350=g387*g356;
    g29=g350*g40;
    g30=g401*g72;
    g31=g39*s;
    g355=g383*g383;
    g253=g355*t;
    g33=g253*g64;
    g83=g387*g364;
    g141=g3hww*sw;
    g119=g374*g141*g141;
    g35=g119*g83;
    g395=g2hww*g2hww;
    g36=g395*g65;
    g361=g381*mw;
    g358=g361*mw;
    g79=g358*g101;
    g37=g387*g79;
    g42=g379*g79;
    g312=g3hww*g2hww;
    g43=g312*g64;
    g54=g341*g64;
    g44=g387*g54;
    g398=g374*ee;
    g185=g398*sw;
    g115=g185*g1hww;
    g92=g375*g115;
    g45=g92*g83;
    g81=g387*g141;
    g49=g144*g81*g81;
    g124=g383*g364;
    g80=g383*g124;
    g50=g119*g80;
    g354=g358*mw;
    g380=g354*mw;
    g52=g380*g101;
    g249=g398*mw;
    g122=mw*ee;
    g143=g249*g122;
    g53=g143*g83;
    g291=g65*s;
    g56=g65*g1hww;
    g63=g185*g124;
    g261=g3hww*mw;
    g57=g261*g63;
    g61=g362*g63;
    g59=g61*u;
    g60=g61*t;
    g62=g63*s;
    g66=g79*g2hww;
    g367=g122*g122*g122;
    g363=g367*g364;
    g118=g398*g362;
    g339=g118*sw;
    g68=g339*g80;
    g96=g362*g115;
    g189=g387*g83;
    g194=g387*g189;
    g351=g383*g355;
    g162=g351*t;
    g378=g398*ee;
    g100=g378*g124;
    g78=g401*g100;
    g76=g78*s;
    g84=g356*g141;
    g85=g355*g3hww;
    g120=g378*g373;
    g172=g398*g364;
    g112=g172*u;
    g91=g112*sw;
    g88=g362*g91;
    g110=g172*t;
    g89=g110*sw;
    g111=g172*s;
    g90=g111*sw;
    g93=g367*g141;
    g400=g118*mw;
    g142=g400*mw;
    g117=g364*g142;
    g94=g117*sw;
    g95=g339*g2hww;
    g145=g378*g364;
    g116=g145*t;
    g97=g356*g116;
    g98=g145*s;
    g99=g145*u;
    g102=g400*ee;
    g104=g364*g143;
    g105=g111*g81;
    g106=g249*g141;
    g109=g112*g84;
    g125=g383*s;
    g114=g354*g185;
    g121=g401*s;
    g123=g387*mw;
    g181=g379*g32;
    g140=g383*g379;
    g209=g387*u;
    g180=g209*u;
    g129=g383*g373;
    g179=g1hww*u;
    g406=g179*g179;
    g130=g406*g21;
    g178=g1hww*t;
    g405=g178*g178;
    g131=g405*g21;
    g177=g387*g1hww;
    g404=g177*g177;
    g132=g404*g21;
    g171=g383*mw;
    g402=g171*g171;
    g133=g402*g18;
    g173=g171*mw;
    g176=g401*g10;
    g174=g383*g1hww;
    g403=g174*g174;
    g138=g403*g8;
    g146=g375*g179;
    g147=g178*g63;
    g243=u*t;
    g170=g356*g2hww;
    g155=g356*g1hww;
    g169=g361*g63;
    g154=g373*g1hww;
    g156=g386*u;
    g275=g358*g47;
    g158=g275*u;
    g160=g386*t;
    g161=g351*u;
    g272=g356*u;
    g164=g209*g24;
    g271=g355*s;
    g165=g271*g24;
    g166=g366*t;
    g270=g393*t;
    g168=g379*s;
    g377=g398*g80;
    g182=g377*ee;
    g365=g367*g122;
    g183=g365*g80;
    g184=g378*g83;
    g195=g383*g80;
    g200=g3hww*u;
    g201=g387*g3hww;
    g202=g355*g43;
    g203=g383*g42;
    g204=g387*g29;
    g349=g383*g351;
    g207=u*s;
    g208=t*s;
    g210=g387*t;
    g211=g387*s;
    g212=g350*g38;
    g213=g383*u;
    g214=g383*t;
    g215=g387*g383;
    g216=g351*g38;
    g219=g355*g36;
    g394=s*s;
    g221=g383*g3hww;
    g222=g355*g1hww;
    g223=g387*g27;
    g384=g388*u;
    g399=g373*t;
    g226=g387*g21;
    g227=g379*g21;
    g228=g355*g20;
    g229=g388*g19;
    g230=g373*g19;
    g232=g381*g18;
    g233=g381*g17;
    g239=u*mw;
    g241=s*mw;
    g244=g361*u;
    g245=g83*t;
    g254=g358*g3hww;
    g260=g394*g56;
    g252=g355*u;
    g255=g47*g2hww;
    g258=g388*g1hww;
    g259=g394*g1hww;
    g266=g207*g38;
    g276=g157*g24;
    g278=g21*t;
    g282=g90*g1hww;
    g285=g106*g80;
    g286=g102*g83;
    g296=g56*g3hww;
    g300=g48*t;
    g304=g350*g24;
    g307=g16*t;
    g309=g2hww*u;
    g311=g142*sw;
    g314=g2hww*s;
    g391=g123*g123;
    g550=4.0*g42;
    g437=-g550-g49;
    g549=4.0*g189*g92;
    g424=g549+g437;
    g452=-(4.0*g366*g100)-(8.0*g375*g63*g3hww);
    g552=8.0*g363*g81;
    g431=g452-g552;
    g425=g431-(2.0*g50);
    g426=g424-(3.0*g15);
    g427=g5+g4;
    g554=12.0*g23;
    g555=16.0*g395*g79;
    g428=g554-(5.0*g14)-g555;
    g548=4.0*g92*g80;
    g429=g548-(11.0*g12);
    g430=-g427-g29;
    g432=g425+5.0*g29-g555;
    g556=4.0*g387*g34;
    g433=-g556-g552;
    g532=3.0*g9;
    g533=8.0*g36;
    g444=g533-g532;
    g534=8.0*g43;
    g535=4.0*g34;
    g453=8.0*g54-g535-g534;
    g434=g453-g444-(4.0*g363*g122)+9.0*g48+3.0*g20;
    g435=2.0*g270*g16+8.0*g272*g24;
    g436=4.0*(g96*g83+g44);
    g438=-(13.0*g48)-(12.0*g54);
    g439=4.0*(-g27-g26);
    g440=g399*g22+g384*g22-(4.0*g180*g24);
    g482=-(g349*g40)-g204;
    g441=g482+2.0*g351*g181+g379*g176;
    g442=g436+2.0*g300;
    g443=2.0*(g173*g11-(g173*g7));
    g445=8.0*(-g12-g13);
    g446=g76-(2.0*g285)-g14-g50;
    g497=4.0*g57;
    g447=-g497-(2.0*g78);
    g448=g373*g16+g356*g9;
    g519=4.0*g52;
    g449=4.0*g37-g519-(10.0*g28);
    g450=g53+g35;
    g451=g548+g424;
    g510=4.0*g45;
    g455=g450-g510;
    g485=2*g455;
    g454=g485+20*g19;
    g515=8.0*g33;
    g456=g515+8.0*g28;
    g491=16.0*g291*g2hww;
    g457=g491+16.0*g66;
    g558=2.0*g16;
    g458=g9-g558;
    g538=4.0*g99;
    g539=6.0*g17;
    g459=g538-g539;
    g460=2.0*(g99-g17);
    g559=3.0*g16;
    g461=-g559-g9;
    g462=g533+2.0*g57+3.0*g48;
    g463=g98-g18;
    g500=16.0*g59;
    g464=-g500-(16.0*g60);
    g525=8.0*u;
    g544=8.0*s;
    g466=g544+g525;
    g520=4.0*t;
    g502=4.0*g207;
    g472=-g502-(4.0*g208);
    g523=2.0*u;
    g469=-g523-(2.0*t);
    g501=4.0*g125;
    g471=g140*g30-g16+g38*s-(g355*g40);
    g474=2.0*(-(g373*mw)-(g388*mw));
    g476=4.0*g92-(2.0*g106);
    g560=2.0*g7;
    g477=g560-(2.0*g11);
    g565=4.0*g24;
    g483=-(g401*g120)-(g388*g143);
    g486=4.0*g439;
    g487=3.0*g436;
    g488=4.0*g65;
    g489=8.0*g88;
    g490=4.0*t*mw;
    g492=8.0*g355*g243;
    g493=4.0*g156;
    g494=16.0*g110;
    g495=8.0*g63;
    g496=8.0*g89;
    g498=8.0*g21;
    g499=8.0*g60;
    g503=16.0*g201;
    g504=20.0*g177;
    g505=8.0*g179;
    g506=8.0*g68;
    g507=16.0*g169;
    g508=8.0*g137;
    g509=8.0*g3hww;
    g511=8.0*g1hww;
    g512=16.0*g1hww;
    g513=16.0*g2hww;
    g514=32.0*g2hww;
    g516=4.0*g125*g8;
    g517=16.0*g37;
    g518=16.0*g31;
    g521=8.0*t;
    g522=16.0*t;
    g524=4.0*u;
    g526=16.0*u;
    g527=8.0*g61;
    g528=16.0*g61;
    g529=16.0*g361*s;
    g530=10.0*g48;
    g531=26.0*g48;
    g536=4.0*g164;
    g537=4.0*g125*g24;
    g540=2.0*g97;
    g541=4.0*g35*u;
    g542=2.0*g15;
    g543=4.0*s;
    g545=12.0*s;
    g546=8.0*g35;
    g547=2.0*g402*g17;
    g551=8.0*g91*g1hww;
    g553=2.0*g29;
    g557=16.0*g275*t;
    g561=16.0*g41;
    g562=16.0*g39;
    g563=4.0*g383*g8;
    g564=4.0*g6;
    g566=8.0*g24;
    g567=2.0*g30;
    g568=8.0*g30;
    g569=4.0*g38;
    g570=5.0*g38;
    g571=16.0*g83;
    g572=-(2.0*g47);
    g348=g397*g397*g381;
    {
        t0=16.0*(-(g255*g254)-(g117*g81))+(g565+12.0*g38)*(g213*g213+g210*g210)+
         g477*(g402+3.0*g387*g366)+(g520+g466)*(2.0*g93*g80+g183)+g469*(g182*
         g121+8.0*(g137*g66-(g260*g2hww)))+8.0*(g208-g207)*(g95*g83+g387*g43)+(
         4.0*g213+2.0*g207-g501)*(g53*t+g35*t)+(g472-(4.0*g243))*(g365*g83+g285)
         +(4.0*g91+2.0*g90)*(g351*g261+g350*g261-(2.0*g402*g171*g1hww))+(g72+2.0
         *g73)*(g386*g351+g386*g350)+8.0*(g96-g95-g93)*(g195+g194)+(g463+g460)*(
         g401*g351+g401*g350)+g476*(g383*g195+g387*g194)+2.0*(g364*g162+g194*t)*
         (g143+g119-g476)+s*(g440+g435-(17.0*g230)-(5.0*g229)+7.0*(g138-g216)-(4
         *g448))+t*(g547+g443+2.0*g133+4.0*(g232-g233-(g146*g62)))+u*(3.0*g441-(
         8.0*g203)-(7.0*g131));
        t0=t0+g2hww*(-(g529*g89)-(16.0*g244*g90))+g3hww*(g500+g499-(8.0*g260)-(
         32.0*g68)-(g491*t)-g507)+g483*g80+g84*(4.0*g249*g80-(g144*g84))+g85*(
         20.0*g56+g511*g8-(g514*g65)-(g101*g85))+g102*(8.0*g245-(16.0*g80))+g105
         *(24.0*g362-g474)+g121*(-g540-(4.0*g184*g121))+g125*(g536-(5.25*g445)+4
         *g430+7.0*(g15+g307)+g532*t-g541)+g129*(g454-g559-g533)+g130*(-(11.0*t)
         -(17.0*s))+g132*(-(31.0*t)-(27.0*u)-(29.0*s))+g137*(4.0*g60+20.0*g59-(
         12.0*g68))+g140*(g517-(30.0*g31)-(40.0*g26))+g474*g172*g84+g362*g170*(
         g496+8.0*g90)+g362*g155*(-(12.0*g90)-(20.0*g89))+g387*g169*(g514+g512)+
         g154*(g491-(g513*g41))+g155*(g528-g489+g457+20.0*g94)+g156*(g498-g488)+
         g157*(g447-g532-g531);
        t0=t0+g160*(4.0*g21-g488)+g161*(-g566-(9.0*g38))+g162*(-g570-g566)+g165*
         (g524+g521)+g166*(g546+6.0*g11-g560)+g168*(11.0*g33+23.0*g28+18.0*g41*u
         -(1.5*g439))+g170*(g527+g489+32.0*(-g94-(g65*g3hww))+g526*g56)+g177*(
         1.25*g464+16.0*g68+g513*g52)+g178*(12.0*g59-g506)+g179*(28.0*(-g169-(
         g41*g3hww))-(20.0*g68))+g180*(g497-g533)+g186*(g516+g449-(6.0*g33))+
         g189*(g483-(16.0*g102))+g366*g356*(g459+8.0*g98)+g383*g381*(12*g463+2.0
         *g459)+g387*g373*(g533+g497)+g388*g383*(g533+g454-g535)+g200*(g200*g46-
         g491-(g513*g226))+g466*g202+g207*(g548+g442+g432+2.0*g424+g266+3.0*g5-(
         g521*g54)-g556)+g208*(g549+5.0*g436+g432+3.0*g4+8.0*(-g296-g15)+2.0*(
         g437+g429));
        t0=t0+g209*(g536-g452+g569*g209)+g210*(-g554-g452)+g211*(g570*g211-(g513
         *g61))+g212*(-(9.0*t)-(5.0*u)-(7.0*s))+g213*(g556+6.0*g5)+g214*(40.0*
         g12-(8.0*g23)+6.0*(g14+g4-g15))+g215*(20.0*g23-(10.0*g14))+g395*g383*(
         32.0*g37-(16.0*g26))+g383*g356*(g444-g535)+g219*(g544+g522)+g394*g383*(
         g20+14.0*g19-g535-g461)+g222*(g457-(g567*g222))+g228*(-g543-(3.0*u))+
         g393*g355*(g458+7.0*g19)+g393*g383*(g542+g445-(2*g427))+g383*g366*(6.0*
         g7-(10.0*g11))+g239*(g520*g105-(g540*mw))+g241*4.0*(-g109-(g110*g84))+
         g377*g81*(6.0*g241-(4.0*g239)-g490)+g243*(g487+g425+6.0*g29+2.0*(g451+
         g76-(g143*g80))-(22.0*g168*g21)-g537)+g254*g1hww*(16.0*g72+8.0*(g47+g73
         ));
        t0=t0+g252*(8.0*g34-g531-g485-(20.0*g54))+g253*(-g530-g485-(3*g458))+
         g258*g2hww*(g561-g562)+g259*g2hww*(-g562-g561)+g258*(g491+12.0*g61)+
         g259*(g527-(8.0*g94))+g361*g115*(20.0*g80-(28.0*g245))+2.0*g472*g387*
         g57+g361*g89*(-g509-g508-g505)+g361*g90*(g509-g505)+g393*g6*(-(4.0*g140
         )-(2.0*g168))+g270*(g550+g542+6.0*g12-g553)+g271*(3*g450+g438-(29.0*g19
         )+4.0*(-g9-g16)-g510)+g272*(g447+16.0*g36-g530-g453)+g379*g30*(5.0*(
         g162+g161)-g492)+g383*g30*(-g493-(4.0*g160))+g276*(g543+g525)+g375*g62*
         4.0*(-g155-g154)+g278*(-(g504*g3hww)-(g503*g2hww))+g461*g393*g125+g362*
         g81*(g494+8.0*g112)+g375*g84*(g494+16.0*g111)+g286*(g545+g524)+g381*t*(
         g538+4.0*g100);
        t0=t0+g354*g2hww*(32.0*g90-(16.0*g63))+g354*g1hww*(g496+g495)+g387*g2hww
         *(g506+g464)+g361*g62*(g513-g512)+g388*s*(g462+g455)+g373*s*(g462+g450)
         +g356*s*(g534+g533+g438+6.0*g57)+g395*s*(g486+16.0*g52)+g379*u*(g519+
         2.0*g456+14.0*g27)+g379*t*(g519-(8.0*g37)+18.0*g31+14.0*g26)+g395*g37*(
         g526-g522)+g304*(4.0*g469-g543)+g351*s*(g40*s-g565-(4.0*g22))+g386*s*(
         12.0*g21-(4.0*g8))+g393*s*(6.0*g13-g427)+g309*(g506+g571*g311)+g311*
         g2hww*(g571*s-(32.0*g80))+g312*(g518-g517-g486+g456+g561*s-(g498*g208))
         +g314*g21*(8.0*g200-g503)+g314*(g506-g499+8.0*g59)+g137*g41*16.0*(-g309
         -g3hww)+g137*g3hww*(4.0*g278-g564)+g21*g3hww*(16.0*g155+12.0*g258+8.0*(
         g259+g170));
        t0=t0+g56*g2hww*16.0*(g253-g252-g157)+g45*t*(g501-(16.0*g213)-g502)+g57*
         t*(g502+8.0*g209)+g137*g21*(20.0*g200-g503)+g200*g56*(-g544-g521)+g200*
         g21*(12.0*g178-g504)+g37*g2hww*(16.0*g179-(32.0*g178))+g178*g3hww*(8.0*
         g79-(28.0*g39))+g31*g2hww*(32.0*g174-(16.0*g178))+g174*g3hww*(g562-(
         16.0*g6))+g2hww*t*(g507+g506)+g156*t*(4.0*g64+2.0*g46)+g39*g2hww*(16.0*
         g154+32.0*g221)+8.0*g439*g137*g2hww+g88*t*(g509-g508)+g125*u*(g510-(4.0
         *g53))+g114*g83*(g511-g513)+g341*(g516-g515+2.0*g449-g439-(4.0*g176)-
         g518)+g3hww*s*(24.0*g61+32.0*g66)+g115*g83*(4.0*g244-g529)+g2hww*g1hww*
         (g557-(32.0*g158))+g349*(g565-g104+g22+2.0*g38-(3.0*g181))+g350*(g434+
         12.0*g227)+g351*(g434+12.0*g19-g558);
        t0=t0+g354*(g551+16.0*g282)+g355*(g433+g428-(3*g427)-(2.0*g426)+8.0*g164
         -(31.0*g12)+23.0*g266-(27.0*g13)+16.0*g44+7.0*g207*g22-g553)+g356*(g452
         +g428+20.0*g296+11.0*g266+3.0*g76+8.0*g42+g495*g146+g572*g156-g537)+
         g358*(4.0*(g98-g116)+8.0*(-g100-g184)-(2.0*g460))+g361*(4.0*g147-(g509*
         g91))+g364*(g509*g114-(32.0*g118*g84))+g366*(g541+8.0*g97+16.0*(-g50-
         g49)-(4.0*g120*g83)+g545*g35)+g373*(g487+g446+g433+g429+g426+3.0*g266+
         g524*g48)+g375*8.0*(g109+g356*g147)+g379*(-(40.0*g223)-(8.0*g125*g6)-(
         5.0*g366*g10))+g380*(4.0*g145-(8.0*g364*g115*mw)+g512*g255)+g381*(4.0*(
         g7+g11)-g546)+g383*(2.0*g440+g435+4.0*g286+8.0*g276+g539*g166-(g493*g32
         )-g482)+g384*(g471-(5.0*g227)-g19);
        t0=t0+g386*(g563+g10-(8.0*g41)+4.0*(g226+g79+g291)+g572*g157-g564)+g387*
         (g547-(3.0*g133)-(12.0*g232)+g204+8.0*(g219+g202-g233)+4.0*(g304-g183-
         g165)+2.0*(g212-g443)-(g350*g104)-(g528*g137)-(g566*g129))+g388*(g452+
         g451+g446-(7.0*g13)+4.0*g300)+g391*g123*(-g551-(4.0*g282))+g391*(g477+
         2.0*g182-(g523*g98))+g208*g38*(g208+3.0*g388)+g393*(g448-g441+2.0*g138+
         g228+7.0*g132+4.0*g203+g131+g229+5.0*(g216+g130+g212+g230))+g394*(g555+
         g431-g430-(10.0*g13)+4.0*g23+2.0*(g442-g307)-g556)+g395*(g557+16.0*(-
         g223-g158))+g399*(g471-g227-(5.0*g19))+g403*(31.0*g39-(6.0*g6))+g405*(
         g41+17.0*g39)+g406*(17.0*g41+g39)+g407*(2.0*g6-g563-(6.0*g278))+g201*
         g201*(g568+3.0*g46+8.0*g32);
        msq=(t0+g221*g221*(g568+4.0*g32)+g214*g214*(g569+g565)+g215*g215*(20.0*
         g38-g566)+g155*g155*(-g567-(3.0*g32))+g125*g125*(g570+3.0*g22-(2.0*g181
         ))+g492*g24+31.0*g404*g41-(10.0*g173*g173*g17)-(g490*g109)+g527*g201)/(
         g401*g348*(96.0*g401-(192.0*s))+96.0*g394*g348);
      };
  };
 
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
  
  double g63,g64,g24,g66,g6,g4,g57,g74,g5,g67,g29,g15,g71,g7,g13,g8,g25,g9,g27,g54,g10,g11,g28,g14,g12,g69,g16,g58,g65,g35,g18,g36,g19,g21,g20,g31,g22,g23,g56,g32,g37,g72,g70,
       g62,g61,g50,g79,g82,g80,g92,g81,g83,g86,g84,g85,g87,g91,msq1;
{
    double t0 = 0;
    g63=mq*mq;
    g64=mz*mz;
    g24=g64*g63;
    g66=ee*ee;
    g6=g66*g24;
    g4=g6*s;
    g57=g66*g64;
    g74=g2hzy*g2hzy;
    g5=g74*g57;
    g67=g1hzy*g1hzy;
    g29=g67*g66;
    g15=g64*g29;
    g71=s*s;
    g7=g71*g15;
    g13=g29*u;
    g8=g13*s;
    g25=g29*s;
    g9=g25*t;
    g27=g64*g57;
    g54=g27*g2hzy;
    g10=g54*g2hzy;
    g11=g15*s;
    g28=g66*g63;
    g14=g67*g28;
    g12=g14*s;
    g69=mh*mh;
    g16=g69*g25;
    g58=g64*g64;
    g65=g64*g58;
    g35=u*g1hzy;
    g18=g35*s;
    g36=t*g1hzy;
    g19=g36*s;
    g21=g63*g1hzy;
    g20=g21*s;
    g31=g2hzy*g1hzy;
    g22=g57*g31;
    g23=g71*g31;
    g56=g64*s;
    g32=g63*g13;
    g37=g67*g6;
    g72=u*u;
    g70=t*s;
    g62=g63*g63;
    g61=g63*s;
    g50=g8*t;
    g79=g9-g16;
    g82=16.0*(g31*g6+g63*g5);
    g80=g82-(6.0*g12)-(3.0*g11);
    g92=4.0*g8;
    g81=g92+4.0*g9;
    g83=64.0*g65*g28+16.0*g56*g27;
    g86=8.0*(-g22-g5);
    g84=16.0*g15-(8.0*g86);
    g85=16.0*(-(g4*t)-(g4*u));
    g87=16.0*(-(g10*t)-(g10*u));
    g91=8.0*g67*g4;
    {
        t0=4.0*(-t-u)*(16.0*g54*g21-(4.0*g71*g22)+g7-g91)+g86*(8.0*g62*u-(g70*t)
         -(g72*s))+g81*(g69*g63+g69*g64)+g87*s+g6*(4.0*(g35*g35+g36*g36)-(32.0*
         g23))+g27*(32.0*g21*g21-(16.0*g23))+g31*(g83+128.0*g24*g6-g85)-(g84*g62
         *t)+g63*g61*(16.0*g5-(48.0*g22))+g70*s*(6.0*g13-(8.0*g14))+g54*(16.0*(-
         g19-g18)-(32.0*g20))+u*t*(2.0*g82+8.0*g37)+g58*(g92+4.0*g79-(40.0*g12)+
         16.0*(-g32-(g14*t)))+g63*g62*(g84-(8.0*g25))+g62*(3.0*g81+128.0*g10-(
         4.0*g16)-(48.0*g11))+g63*(4.0*g87-(12.0*g50)-(16.0*g24*g13))+g66*(g18*
         g18+g19*g19+8.0*g20*g20)+g69*(4.0*g7-(2.0*g50)-g91)+g71*(24.0*g37-(8.0*
         g32)+16.0*g10)+g72*(g80-g16+3.0*g9+g25*u)+g74*(g85+g83)+t*t*(g80+g79+
         3.0*g8);
        msq1=(t0+32.0*g61*g10-(10.0*g64*g50)+16.0*g65*g14)/(216.0*g56*s);
    };
};
double g357,g348,g355,g208,g161,g346,g209,g125,g347,g281,g176,g345,g217,g126,g214,g186,g274,g356,g354,g267,g270,g273,g210,g268,g213,g187,g261,g113,g114,g115,g116,g349,g189,g330,
       g178,g272,g271,g259,g201,g185,g174,g218,g207,g197,g263,g134,g342,g198,g135,g243,g136,g215,g184,g139,g137,g275,g138,g287,g190,g183,g266,g194,g142,g160,g143,g144,g162,g145,
       g193,g316,g147,g343,g157,g148,g158,g149,g166,g150,g353,g282,g151,g211,g182,g276,g152,g196,g180,g153,g203,g154,g339,g155,g156,g269,g159,g175,g163,g181,g165,g188,g173,g167,
       g192,g264,g171,g172,g177,g195,g191,g340,g202,g222,g216,g219,g224,g225,g226,g227,g231,g238,g256,g245,g254,g258,g257,g255,g280,g288,g293,g320,g429,g381,g382,g364,g365,g401,
       g366,g367,g368,g389,g369,g388,g416,g378,g385,g417,g370,g379,g371,g372,g376,g373,g374,g375,g377,g380,g383,g384,g386,g391,g393,g395,g396,g397,g399,g400,g403,g404,g407,g423,
       g424,g414,g415,g418,g419,g420,g421,g422,g425,g426,g427,g428,g430,g431,g432,msq2;
{
    double t0 = 0;
    g357=sw*sw;
    g348=g357*sw;
    g355=ee*ee;
    g208=g355*g348;
    g161=g208*g1hzy;
    g346=mz*mz;
    g209=g346*s;
    g125=g209*g161;
    g347=mq*mq;
    g281=g355*g1hzy;
    g176=g281*s;
    g345=g357*g348;
    g217=g346*g345;
    g126=g217*g176;
    g214=g346*g2hzy;
    g186=g355*g214;
    g274=g186*g2hzz;
    g356=u*u;
    g354=t*t;
    g267=g356*g1hzz;
    g270=g354*g1hzz;
    g273=g348*g186;
    g210=g345*g1hzz;
    g268=g346*g2hzz;
    g213=g355*g345;
    g187=g213*g1hzy;
    g261=g161*g1hzz;
    g113=g356*g261;
    g114=g354*g261;
    g115=g267*g187;
    g116=g270*g187;
    g349=s*s;
    g189=g355*g349;
    g330=g1hzz*g1hzy;
    g178=g330*g189;
    g272=g345*u;
    g271=g186*t;
    g259=u*t;
    g201=g347*g1hzz;
    g185=g201*s;
    g174=g176*sw;
    g218=g347*g346;
    g207=g208*g2hzy;
    g197=g345*g3hzz;
    g263=g355*g2hzy;
    g134=g207*g2hzz;
    g342=g346*g346;
    g198=g345*g2hzz;
    g135=g263*g198;
    g243=g1hzz*sw;
    g136=g243*g186;
    g215=g342*g2hzy;
    g184=g355*g215;
    g139=g347*g184;
    g137=g139*u;
    g275=g348*g1hzz;
    g138=g275*g184;
    g287=g347*g3hzz;
    g190=g355*g347;
    g183=g190*g1hzy;
    g266=sw*g1hzy;
    g194=g355*g266;
    g142=g268*g194;
    g160=g183*g2hzz;
    g143=g342*g160;
    g144=g267*g194;
    g162=g183*g1hzz;
    g145=g162*sw;
    g193=g347*g190;
    g316=g1hzz*u;
    g147=g316*g193*g1hzy;
    g343=g347*g347;
    g157=g343*g161;
    g148=g157*g1hzz;
    g158=g343*g187;
    g149=g158*g1hzz;
    g166=g349*g346;
    g150=g281*g166;
    g353=mh*mh;
    g282=g353*g1hzz;
    g151=g282*g176;
    g211=g355*mw*ee;
    g182=g346*g211;
    g276=g182*g2hzy;
    g152=g357*g276;
    g196=g347*g211;
    g180=g196*g1hzy;
    g153=g180*u;
    g203=g211*g1hzy;
    g154=g357*g203;
    g339=g346*g342;
    g155=g339*g190*g2hzy;
    g156=g343*g184;
    g269=g342*g2hzz;
    g159=g269*g189;
    g175=g343*g190;
    g163=g330*g175;
    g181=g190*sw;
    g165=g214*g181;
    g188=g193*sw;
    g173=g346*g188;
    g167=g173*g2hzy;
    g192=g263*s;
    g264=g342*g176;
    g171=g264*g2hzz;
    g172=g174*g1hzz;
    g177=g188*g1hzy;
    g195=g211*s;
    g191=g342*s;
    g340=g347*g343;
    g202=g340*g261;
    g222=g347*g154;
    g216=g346*sw;
    g219=g354*g172;
    g224=g342*g151;
    g225=g348*g147;
    g226=g354*g145;
    g227=g347*g142;
    g231=g346*g218;
    g238=g2hzz*sw;
    g256=g1hzz*s;
    g245=g145*s;
    g254=g347*t;
    g258=g353*u;
    g257=g353*t;
    g255=g2hzz*s;
    g280=g177*g1hzz;
    g288=g159*g1hzy;
    g293=g151*sw;
    g320=g1hzz*t;
    g429=48.0*g196*g2hzy;
    g381=g429+24.0*g195*g2hzy;
    g382=32.0*g197*g183-(56.0*g287*g161)+24.0*g181*g3hzz*g1hzy;
    g364=2.0*g382+g381;
    g365=224.0*g342*g134-(128.0*g342*g135);
    g401=112.0*g273*u-(64.0*g272*g186);
    g366=64.0*g345*g271-(112.0*g348*g271)-g401;
    g367=28.0*g148*s+12.0*g245*u-(4.0*g115*s)+7.0*g113*s-(3.0*g144*s)-(16.0*g149
     *s);
    g368=3.0*g144+7.0*(-g114-g113)+4.0*(g116+g115);
    g389=-(4.0*g365)-(64.0*g152);
    g369=g389-(336.0*g138);
    g388=32.0*g210*g186-(56.0*g273*g1hzz);
    g416=2.0*g388;
    g378=-g416-(48.0*g136);
    g385=56.0*g268*g161-(32.0*g268*g187);
    g417=4.0*g385;
    g370=g417+2.0*g378;
    g379=48.0*(-(g354*g274)-(g356*g274))+24.0*(-(g270*g186)-(g267*g186));
    g371=-g379-(96.0*g143);
    g372=2.0*g385-(48.0*g142);
    g376=g365+32.0*g152;
    g373=-g382-g376-(56.0*g138);
    g374=g364+24.0*g180;
    g375=12.0*g153+16.0*(-(g222*t)-(g357*g153));
    g377=128.0*g149-(224.0*g148);
    g380=16.0*g345*g178-(28.0*g349*g261);
    g383=8.0*g259*g187-(14.0*g259*g161);
    g384=224.0*g207*g3hzz-(128.0*g263*g197);
    g386=56.0*g347*g125-(24.0*g218*g174)-(32.0*g347*g126);
    g391=2.0*g370-(192.0*g142);
    g393=96.0*g155-(144.0*g137);
    g395=-(96.0*g342*g162)-(256.0*g143);
    g396=12.0*g224+24.0*g150*g3hzz;
    g397=7.0*g256*g161-(4.0*g210*g176);
    g399=56.0*g157-(32.0*g158);
    g400=7.0*g114*s-(4.0*g116*s);
    g403=12.0*(g191-g166);
    g404=224.0*g134-(128.0*g135);
    g407=12.0*(-t-u);
    g423=96.0*g255;
    g424=96.0*g3hzz;
    g414=g2hzz*t+g2hzz*u;
    g415=1.33333*g210+g243;
    g418=2.0*g384;
    g419=2.0*g380;
    g420=12.0*g195;
    g421=16.0*g154;
    g422=64.0*g154;
    g425=3.0*t;
    g426=48.0*g145;
    g427=24.0*g174*g3hzz;
    g428=96.0*g227;
    g430=112.0*g161;
    g431=-(96.0*sw);
    g432=-(192.0*sw);
    {
        t0=2.33333*(g393*g275+g371*g348*s)+4.0*(g401*g254*g2hzz+g399*g346*g3hzz)
         +(-(48.0*g227)-(24.0*g142*s))*(g356+g354)+g391*(g340-(g343*u))+(24.0*
         g163-(36.0*g147)-g371)*(s*sw+1.33333*g345*s)+(48.0*g171+192.0*g143)*(t*
         sw+u*sw)+g383*(3.0*g209*g1hzz-(8.0*g346*g201)+g353*g256+6.0*g185)+g407*
         (g216*g151-(6.0*g342*g145))+24.0*(g192*t+g192*u)*(2.0*g216*g3hzz+4.0*
         g342*g238+g342*g243+1.33333*g342*g210)+(g424+g423)*(g165*t+g165*u)+g386
         *(4.0*(g316+g320)-g282)+g414*(2.0*g386+384.0*g167)+g379*(2.0*g347*sw+
         2.66667*g347*g345-(4.66667*g348*g347))+g385*(g354*s+g356*s+2.0*(g354*
         g347+g356*g347))+g366*(8.0*g343*g2hzz+2.0*(g287+g347*g255));
        t0=t0+(16.0*g126-(28.0*g125))*(14.0*g343*g1hzz-(g257*g1hzz)-(g258*g1hzz)
         )+(16.0*g213*g185-(28.0*g208*g185))*(8.0*g342*g1hzy-(g257*g1hzy)-(g258*
         g1hzy)+4.0*g215)+(g372+24.0*g145-g388)*(g349*t+g349*u)+g395*1.75*(g348*
         t+g348*u)+(64.0*g171-g395)*(g345*t+g272)+g415*(-g393-(288.0*g156))+g404
         *(g343*g209+4.0*(g343*g218+g346*g231))+96.0*(g147-g163)*(1.33333*g217+
         g216)+g396*sw+s*(84.0*g225+18.0*g226-g375-(56.0*g202))+g425*g367+3.0*
         g400*u+g3hzz*(g432*g139-(4.0*g386))+g159*(48.0*g266+g431*g2hzy)+g166*(-
         g426-g421)+g167*(-g423-(192.0*g3hzz))+g191*(g421+g384+96.0*g145)+g197*
         32.0*(g150-g264)-(g403*g203)+g347*g209*(g384-g422)+g209*(g368+48.0*g180
         -g429);
        t0=t0+g218*(-(4.0*g380)-(8.0*g368))+g219*(-g425-(9.0*u))+g347*g218*(g422
         +g418+168.0*g172)+g342*g217*(-(64.0*g162)-(256.0*g160))+g349*g136*(2.0*
         g407+48.0*g347)+g418*g231-(g380*g353*g346)+g349*g347*(g416-g417)+g238*(
         384.0*(g137-(g214*g175)-g155)-(768.0*g156))+g346*g259*(18.0*g172-g426)+
         g339*s*(g404+g430*g2hzz)+g370*g254*u+g254*(g419+g369)+g259*(g427-(1.5*
         g380)+6.0*g293-(g421*s)+g420*g1hzy-(18.0*g178*sw)-(192.0*g165*g2hzz)-
         g428)+g343*g1hzy*(g420-(48.0*g182))+g269*(16.0*g399-(384.0*g177))+g346*
         t*(g377+g374)+g364*g346*u+g354*sw*3.0*(g151-g178)+g343*t*(-g391-(36.0*
         g172))+g343*s*(-g421-g378-(3.0*g372))+g347*u*(g419+g389)+g347*s*(2.0*
         g376+6.0*g368);
        t0=t0+g3hzz*s*(4.0*g383+g366-(96.0*g165)+g431*g184-g399)+g173*g1hzy*(
         96.0*g320-g424)+g191*g161*(56.0*g3hzz-(112.0*g414))+g139*t*(144.0*g415+
         384.0*g238)+g139*s*(48.0*g243-(192.0*g238))+t*s*(g373-(12.0*g180))+g373
         *u*s+g339*(g430*g201+g432*g160-(64.0*g198*g176)-(48.0*g174*g2hzz)-(96.0
         *g238*g192)-g426)+g343*(g427-g419-(2.0*g369)-(96.0*g276)+12.0*g293)+
         g342*(64.0*g222-(144.0*g280)-g427-(1.5*g377)-(2.0*g374))+g345*(16.0*
         g224+64.0*g288)+g346*(2.0*g375-(24.0*g226)+3.0*g219+224.0*(g202-g225))+
         g348*(-(2.33333*g396)-(112.0*g288))+g349*(g428-g368+g365-(24.0*g280))+
         g356*u*(g397-(3.0*g172))+g397*g354*t+g353*(-g400-g367-(12.0*g243*g150))
         +g216*g216*(2.66667*g381+448.0*g216*g160);
        msq2=(t0-(12.0*g257*g245))/(36.0*g403*g357*cw*cw*cw);
    };
};
double g970,g991,g630,g754,g1019,g448,g439,g1000,g629,g692,g1002,g449,g440,g1004,g987,g972,g611,g996,g850,g441,g849,g442,g966,g963,g610,g443,g444,g992,g551,g985,g691,g540,g494,
       g686,g541,g495,g957,g609,g450,g451,g708,g823,g522,g745,g452,g694,g661,g487,g453,g986,g628,g560,g982,g482,g454,g949,g852,g651,g943,g969,g526,g456,g965,g851,g748,g527,g458,
       g462,g459,g641,g654,g994,g533,g989,g461,g460,g510,g505,g467,g717,g490,g468,g511,g958,g469,g749,g755,g1018,g501,g470,g649,g1017,g502,g471,g946,g539,g777,g472,g523,g506,
       g474,g475,g507,g476,g477,g687,g619,g508,g478,g688,g618,g509,g480,g627,g513,g483,g514,g484,g683,g515,g751,g488,g489,g746,g491,g953,g848,g1015,g554,g496,g555,g497,g500,
       g681,g737,g503,g719,g504,g512,g960,g553,g516,g624,g544,g517,g545,g518,g546,g520,g990,g734,g640,g521,g693,g642,g698,g524,g525,g1009,g652,g528,g689,g1003,g614,g529,g531,
       g747,g1016,g534,g535,g536,g626,g625,g542,g973,g685,g548,g650,g549,g621,g550,g623,g552,g945,g690,g556,g622,g557,g558,g559,g561,g562,g620,g898,g564,g648,g569,g565,g570,
       g566,g571,g572,g706,g646,g595,g573,g574,g632,g575,g726,g589,g576,g608,g580,g577,g797,g639,g578,g827,g579,g599,g581,g645,g606,g582,g583,g584,g732,g585,g635,g601,g586,g942,
       g587,g588,g597,g725,g643,g591,g592,g944,g647,g815,g594,g596,g705,g600,g602,g603,g604,g605,g607,g756,g615,g616,g617,g631,g798,g633,g653,g634,g636,g637,g967,g644,g743,g742,
       g767,g741,g657,g684,g659,g740,g736,g662,g738,g739,g667,g1014,g998,g735,g682,g1028,g695,g696,g697,g699,g700,g702,g789,g703,g716,g707,g709,g710,g711,g712,g841,g840,g715,
       g733,g947,g825,g824,g838,g723,g724,g1013,g728,g814,g744,g750,g956,g761,g768,g769,g770,g774,g778,g811,g855,g817,g867,g801,g791,g792,g793,g794,g795,g891,g885,g808,g809,
       g810,g828,g826,g837,g839,g1012,g899,g1029,g1001,g1037,g1038,g1109,g1039,g1040,g1041,g1056,g1060,g1066,g1074,g1097,g1073,g1099,g1166,g1043,g1044,g1045,g1046,g1047,g1048,
       g1049,g1096,g1050,g1086,g1052,g1051,g1053,g1080,g1057,g1100,g1058,g1054,g1076,g1082,g1093,g1055,g1059,g1167,g1061,g1069,g1072,g1062,g1063,g1064,g1065,g1162,g1067,g1083,
       g1165,g1068,g1105,g1070,g1071,g1075,g1121,g1077,g1078,g1079,g1081,g1084,g1085,g1098,g1087,g1088,g1089,g1178,g1090,g1091,g1185,g1187,g1092,g1094,g1095,g1108,g1101,g1128,
       g1102,g1104,g1106,g1107,g1146,g1110,g1111,g1112,g1182,g1113,g1192,g1117,g1164,g1119,g1174,g1120,g1170,g1127,g1171,g1130,g1131,g1158,g1172,g1147,g1153,g1154,g1155,g1156,
       g1157,g1160,g1161,g1163,g1168,g1169,g1173,g1175,g1176,g1177,g1179,g1180,g1181,g1183,g1184,g1186,g1188,g1189,g1190,g1191,g1193,g1194,g1195,g1196,g1197,g1198,g1199,g1206,
       g971,msq3;
  {
    double t0 = 0;
    g970=mq*mq;
    g991=ee*ee;
    g630=g991*g970;
    g754=u*sw;
    g1019=g754*g754;
    g448=g1019*g630;
    g439=g448*s;
    g1000=t*t;
    g629=g1000*g970;
    g692=sw*ee;
    g1002=g692*g692;
    g449=g1002*g629;
    g440=g449*s;
    g1004=sw*sw;
    g987=g1004*sw;
    g972=g987*sw;
    g611=g972*g630;
    g996=u*u;
    g850=g996*s;
    g441=g850*g611;
    g849=g1000*s;
    g442=g849*g611;
    g966=g972*sw;
    g963=g966*sw;
    g610=g963*g630;
    g443=g850*g610;
    g444=g849*g610;
    g992=mz*mz;
    g551=g1002*g992;
    g985=s*s;
    g691=g991*g972;
    g540=g992*g691;
    g494=g970*g540;
    g686=g991*g963;
    g541=g992*g686;
    g495=g970*g541;
    g957=g992*g992;
    g609=g957*g630;
    g450=g972*g609;
    g451=g963*g609;
    g708=g992*g970;
    g823=u*t;
    g522=g823*g708;
    g745=g991*g522;
    g452=g745*s;
    g694=g991*g957;
    g661=g694*u;
    g487=g1004*g661;
    g453=g487*t;
    g986=g991*g1hzz;
    g628=g986*g1hzz;
    g560=g1004*g628;
    g982=mh*mh;
    g482=g982*g560*s;
    g454=g957*g482;
    g949=g972*g972;
    g852=g949*u;
    g651=g991*t;
    g943=g972*g957;
    g969=g972*g943;
    g526=g969*g651;
    g456=g526*s;
    g965=g1004*g949;
    g851=g965*u;
    g748=g1004*g969;
    g527=g748*g651;
    g458=g527*s;
    g462=g551*s;
    g459=g462*u;
    g641=g970*ee;
    g654=g992*s;
    g994=g641*g641;
    g533=g994*g654;
    g989=g1hzz*g1hzz;
    g461=g989*g533;
    g460=g461*t;
    g510=g949*g628;
    g505=g748*g628;
    g467=g1004*g609;
    g717=g957*t;
    g490=g717*g628;
    g468=g985*g490;
    g511=g654*g628*s;
    g958=g970*g970;
    g469=g958*g511;
    g749=g992*sw;
    g755=g749*sw;
    g1018=g755*g755;
    g501=g1018*g628;
    g470=g501*s;
    g649=g755*sw;
    g1017=g649*g649;
    g502=g1017*g628;
    g471=g502*s;
    g946=g992*g957;
    g539=g1002*g946;
    g777=g970*g539;
    g472=g777*u;
    g523=g539*t;
    g506=g946*g611;
    g474=g506*u;
    g475=g506*t;
    g507=g946*g610;
    g476=g507*u;
    g477=g507*t;
    g687=g991*g949;
    g619=g946*g687;
    g508=g970*g619;
    g478=g508*u;
    g688=g1004*g687;
    g618=g946*g688;
    g509=g970*g618;
    g480=g509*u;
    g627=g946*g628;
    g513=g972*g627;
    g483=g513*s;
    g514=g963*g627;
    g484=g514*s;
    g683=g946*s;
    g515=g989*g618;
    g751=g1004*t;
    g488=g994*g751;
    g489=g972*g661;
    g746=g991*u;
    g491=g1017*g746;
    g953=g970*g958;
    g848=g953*s;
    g1015=g2hzz*g2hzz;
    g554=g1015*g691;
    g496=g946*g554;
    g555=g1015*g686;
    g497=g946*g555;
    g500=g957*g560;
    g681=g972*s;
    g737=g1hzz*u;
    g503=g737*g681;
    g719=g1hzz*t;
    g504=g719*g654;
    g512=g985*g539;
    g960=g992*g946;
    g553=g1002*g960;
    g516=g970*g553;
    g624=g960*g628;
    g544=g972*g624;
    g517=g970*g544;
    g545=g963*g624;
    g518=g970*g545;
    g546=g965*g624;
    g520=g958*g539;
    g990=g991*ee;
    g734=g990*mw;
    g640=g734*s;
    g521=g708*g640;
    g693=g970*mw;
    g642=g990*g693;
    g698=g992*g3hzz;
    g524=g698*g642;
    g525=g957*g642*g1hzz;
    g1009=g3hzz*g3hzz;
    g652=g1009*g746;
    g528=g1004*g652;
    g689=g1004*g3hzz;
    g1003=g689*g689;
    g614=g1003*g991;
    g529=g614*u;
    g531=g963*g652;
    g747=g987*g3hzz;
    g1016=g747*g747;
    g534=g539*s;
    g535=g960*g554;
    g536=g960*g555;
    g626=g960*g687;
    g625=g960*g688;
    g542=g553*u;
    g973=mw*mw;
    g685=g990*g973*ee;
    g548=g1004*g685;
    g650=g685*u;
    g549=g957*g650;
    g621=g970*g685;
    g550=g957*g621;
    g623=g994*g957;
    g552=g1009*g623;
    g945=g992*g960;
    g690=g991*g945;
    g556=g1015*g690;
    g622=g945*g628;
    g557=g972*g622;
    g558=g963*g622;
    g559=g965*g622;
    g561=g737*g640;
    g562=g992*g621;
    g620=g972*g685;
    g898=g3hzz*g1hzz;
    g564=g898*g623;
    g648=g986*g946;
    g569=g972*g648;
    g565=g569*s;
    g570=g963*g648;
    g566=g570*s;
    g571=g619*g1hzz;
    g572=g618*g1hzz;
    g706=g960*g1hzz;
    g646=g991*g706;
    g595=g972*g646;
    g573=g970*g595;
    g574=g646*u;
    g632=g960*g686;
    g575=g632*g1hzz;
    g726=g960*g2hzz;
    g589=g726*g630;
    g576=g589*g1hzz;
    g608=g1002*g692*mw;
    g580=g608*g3hzz;
    g577=g580*s;
    g797=g3hzz*u;
    g639=g797*g734;
    g578=g970*g639;
    g827=g957*g3hzz;
    g579=g827*g642;
    g599=g946*g642;
    g581=g599*g2hzz;
    g645=g734*g1hzz;
    g606=g946*g645;
    g582=g606*u;
    g583=g606*t;
    g584=g608*s;
    g732=g1hzz*s;
    g585=g732*g599;
    g635=g958*g734;
    g601=g957*g635;
    g586=g601*g1hzz;
    g942=g3hzz*g2hzz;
    g587=g942*g691;
    g588=g942*g686;
    g597=g994*g2hzz;
    g725=g991*g3hzz;
    g643=g725*g1hzz;
    g591=g960*g643;
    g592=g689*g1hzz;
    g944=g970*g957;
    g647=g958*g944;
    g815=g2hzz*g1hzz;
    g594=g945*g815*g630;
    g596=g626*g2hzz;
    g705=g966*g734;
    g600=g705*g3hzz;
    g602=g726*g642;
    g603=g946*g608;
    g604=g705*g2hzz;
    g605=g946*g635;
    g607=g960*g645;
    g756=g1009*s;
    g615=g991*g756;
    g616=g621*s;
    g617=g973*g630*g630;
    g631=g1004*s;
    g798=g3hzz*t;
    g633=g798*g734;
    g653=g3hzz*sw;
    g634=g653*g640;
    g636=g946*g640*g2hzz;
    g637=g645*sw;
    g967=g987*g972;
    g644=g967*g734;
    g743=g946*g510;
    g742=g957*g944;
    g767=g992*g944;
    g741=g970*g767;
    g657=g741*g510;
    g684=g989*g982;
    g659=g1004*g970;
    g740=g659*sw;
    g736=g989*g957;
    g662=g736*g488;
    g738=g989*g970;
    g739=g989*g953;
    g667=g738*g453;
    g1014=g737*g737;
    g998=g719*g719;
    g735=g992*g989;
    g682=g946*t;
    g1028=g992*g943;
    g695=g1028*g957;
    g696=g734*g653;
    g697=g992*g653;
    g699=g972*g3hzz;
    g700=g963*g3hzz;
    g702=g967*g2hzz;
    g789=g957*u;
    g703=g789*g633;
    g716=g958*sw;
    g707=g970*g1hzz;
    g709=g953*g1hzz;
    g710=g958*u;
    g711=g958*t;
    g712=g963*g574*g2hzz;
    g841=g949*g574;
    g840=g965*g574;
    g715=g717*g561;
    g733=g989*s;
    g947=g970*g953;
    g825=g996*g1hzz;
    g824=g1000*g1hzz;
    g838=g960*g510;
    g723=g838*u;
    g724=g838*t;
    g1013=g732*g732;
    g728=g1009*t;
    g814=g982*u;
    g744=g958*g510;
    g750=g945*g643;
    g956=g740*sw;
    g761=g972*g956;
    g768=g992*g580;
    g769=g957*g578;
    g770=g970*g577;
    g774=g2hzz*s;
    g778=g2hzz*u;
    g811=g1004*u;
    g855=g811*sw;
    g817=g751*sw;
    g867=g631*sw;
    g801=g982*g970;
    g791=u*s;
    g792=g970*s;
    g793=t*s;
    g794=g970*u;
    g795=g970*t;
    g891=g989*u;
    g885=g989*t;
    g808=g970*g3hzz;
    g809=g958*g1hzz;
    g810=t*sw;
    g828=g2hzz*t;
    g826=g985*g3hzz;
    g837=g774*g575;
    g839=g487*s;
    g1012=g707*g707;
    g899=g3hzz*s;
    g1029=g749*g749;
    g1001=g659*g659;
    g1037=72.0*g739*g462+108.0*g1014*g450-(36.0*g735*g441)+41.0*g996*g471-(30.0*
     g996*g470)+18.0*(g735*g443+g735*g439)+54.0*(-(g1014*g451)-(g736*g448));
    g1038=64.0*g509-(224.0*g508);
    g1109=32.0*g851*g609-(112.0*g852*g609);
    g1039=4.0*g1109-(144.0*g453);
    g1040=52.0*(-g476-g477);
    g1041=36.0*g549+64.0*g967*g582-(160.0*g966*g582);
    g1056=312.0*(g474+g475);
    g1060=32.0*g480-(112.0*g478);
    g1066=180.0*(g970*g523+g472);
    g1074=32.0*g509*t-(112.0*g508*t);
    g1097=g1074+g1060;
    g1073=36.0*(-(g553*t)-g542);
    g1099=144.0*g848*g540-(72.0*g848*g541);
    g1166=72.0*g516;
    g1043=g1166+g1099-g1073;
    g1044=128.0*g625+144.0*g553;
    g1045=64.0*g967*g583-(160.0*g966*g583)-(72.0*g583*sw);
    g1046=18.0*(g985*g495+g985*g970*g551)-(36.0*g985*g494);
    g1047=216.0*g740*g740*g490+108.0*g998*g450-(36.0*g735*g442)+18.0*(g735*g444+
     g735*g440)+54.0*(-(g998*g451)-(g736*g449));
    g1048=56.0*g684*g456-(16.0*g684*g458);
    g1049=8.0*g505*s-(28.0*g957*g510*s);
    g1096=1792.0*g1015*g626-(512.0*g1015*g625);
    g1050=2.0*g1096-(4096.0*g536)+1536.0*g535;
    g1086=256.0*g1015*g618-(896.0*g1015*g619);
    g1052=72.0*g577-(2048.0*g497)+768.0*g496-(2.0*g1086);
    g1051=4.0*g1052-(416.0*g515)-(2348.0*g514)+1992.0*g513+1068.0*g471-(1512.0*
     g470);
    g1053=896.0*g841*g2hzz-(256.0*g840*g2hzz);
    g1080=32.0*g546+164.0*g545-(120.0*g544);
    g1057=-g1080-(36.0*g562);
    g1100=56.0*g683*g510-(16.0*g515*s);
    g1058=82.0*g484-(60.0*g483)-g1100;
    g1054=1.5*g1058+g1057+18.0*g616-(9.0*g454)-(108.0*g963*g461);
    g1076=72.0*(-g444-g443);
    g1082=144.0*(g442+g441);
    g1093=72.0*(-g440-g439);
    g1055=g1093+g1082+g1076;
    g1059=64.0*(g985*g606+g715)-(448.0*g605*g1hzz);
    g1167=36.0*g512;
    g1061=g1167-g1166-(3.0*g1099);
    g1069=288.0*(g1016*g651+g531);
    g1072=480.0*(-(g614*t)-g529);
    g1062=1.2*g1072+g1069+288.0*g528;
    g1063=g1046+1.5*g1038+546.0*g507-(468.0*g506)-(36.0*g553)+27.0*g534;
    g1064=-(1.125*g1059)-(72.0*g946*g561);
    g1065=72.0*g634-g1052;
    g1162=2.0*g1050;
    g1067=g1162+72.0*g608*g504;
    g1083=18.0*g495*s-(36.0*g494*s);
    g1165=432.0*g467;
    g1068=g1165-(16.0*g1083)-(80.0*g451)-(672.0*g450);
    g1105=36.0*g684*g452-(72.0*g982*g460);
    g1070=g1105-(72.0*g814*g461)-(864.0*g647*g643);
    g1071=36.0*(g824*g521+g825*g521);
    g1075=2624.0*g536-(1920.0*g535)-g1096;
    g1121=41.0*g471-(30.0*g470);
    g1077=g1121+g1049;
    g1078=72.0*g607-(432.0*g586)+288.0*(g581-g636);
    g1079=128.0*g572*s-(448.0*g571*s);
    g1081=g1038+256.0*g507-(96.0*g506);
    g1084=1024.0*g602+128.0*(-g585-(g579*t)-g769);
    g1085=288.0*g716*g633-(72.0*g953*g685);
    g1098=-(2.30769*g1056-(6.0*g1097)-(1.2*g1066))-(18.9231*g1040);
    g1087=g1098-(504.0*g520);
    g1088=432.0*g586+480.0*g581-(168.0*g607);
    g1089=656.0*g491-(480.0*g489);
    g1178=32.0*g515;
    g1090=g1178+164.0*g514-(120.0*g513);
    g1091=1024.0*g594+2048.0*(g946*g597*g3hzz+g589*g3hzz)+128.0*(g552-g750);
    g1185=48.0*g548;
    g1187=336.0*g580;
    g1092=g1187+g1185;
    g1094=24.0*g458-(84.0*g456);
    g1095=1920.0*g506-(8.0*g1038)-(2624.0*g507);
    g1108=-(432.0*g489)-(72.0*g459);
    g1101=216.0*(-g491-g487)-g1108;
    g1128=54.0*g451-(108.0*g450);
    g1102=g1128+54.0*g467;
    g1104=128.0*g572-(448.0*g571);
    g1106=41.0*g502-(30.0*g501)+9.0*g500;
    g1107=g1086+1312.0*g497-(960.0*g496);
    g1146=-g1079-(656.0*g566);
    g1110=-g1146-(480.0*g565);
    g1111=32.0*(u+t);
    g1112=7040.0*g588-(768.0*g587);
    g1182=72.0*g511;
    g1113=648.0*g490-g1182;
    g1192=216.0*g500;
    g1117=144.0*(g449+g448);
    g1164=72.0*g469;
    g1119=-g1164-(216.0*g460);
    g1174=288.0*g737;
    g1120=g1174+288.0*g719;
    g1170=128.0*s;
    g1127=128.0*g527-(448.0*g526);
    g1171=216.0*s;
    g1130=128.0*(-g633-g639);
    g1131=288.0*g540-(144.0*g541);
    g1158=g793+g791;
    g1172=512.0*s;
    g1147=g1080+2.0*g1058;
    g1153=g559-(3.5*g945*g510)+5.125*g558-(3.75*g557)+1.125*g945*g560;
    g1154=g946*g620+10.0*g946*g600;
    g1155=g967*g607-(2.5*g966*g607);
    g1156=3.5*g742*g510-(g970*g546);
    g1157=g985*g515-(3.5*g985*g743)+5.125*g985*g514-(3.75*g985*g513);
    g1160=5.33333*g1094;
    g1161=8.0*g1081;
    g1163=36.0*g482;
    g1168=1312.0*g575;
    g1169=216.0*g525;
    g1173=576.0*g707;
    g1175=1152.0*g520;
    g1176=48.0*g548*u;
    g1177=144.0*g528;
    g1179=480.0*g614;
    g1180=32.0*g972*g549;
    g1181=144.0*g607*sw;
    g1183=288.0*g615;
    g1184=112.0*g682*g510;
    g1186=320.0*g600;
    g1188=108.0*g454;
    g1189=288.0*g553;
    g1190=288.0*g534;
    g1191=144.0*g523;
    g1193=576.0*g553;
    g1194=112.0*g510;
    g1195=-(288.0*g462);
    g1196=-(108.0*g461);
    g1197=216.0*g461;
    g1198=-(128.0*g3hzz);
    g1199=g693*g551;
    g1206=cw*cw*cw;
    g971=g1206*g1206;
    {
        t0=32.0*g1199*g1199+480.0*(g695*g643-(g699*g574))+3.0*(g1108*g1012*t-(
         g1109*g733*t))+2.0*(g1113*g958*g956+g1046*g989*g823)+(g1192+216.0*g502-
         (432.0*g501))*(2.0*g947+g958*g801+1.5*(g795*g795+g794*g794))+(288.0*
         g494-(144.0*g495))*(g798*g798+g797*g797+2.0*g728*u)+(g1077+18.0*g738*
         g462+9.0*g500*s)*(g1000*t+g996*u)+(1920.0*g587-(640.0*g604)-(2624.0*
         g588))*(g682*s+g683*u-(2.0*g960*s))+(288.0*g699-(144.0*g700))*(g452*
         g1hzz-(2.0*g994*g504))+576.0*(-g711-g710)*(3.55556*g572*g2hzz-(12.4444*
         g571*g2hzz)+14.2222*g570*g2hzz-(5.33333*g569*g2hzz)+g768)+1024.0*(g719-
         g3hzz)*(g480*g2hzz-(3.5*g478*g2hzz))+288.0*(g747-g653)*(g521*t+g521*u)+
         (g1171+216.0*t)*(g754*g525+1.03704*g723);
        t0=t0+64.0*g1158*(3.6875*g684*g451-(4.125*g684*g450)-(g967*g525)+2.5*
         g966*g525-(4.875*g987*g525))+(480.0*g569-g1104-(656.0*g570))*(g797*t-(
         7.0*g958*g3hzz)+g826+2.0*(-(g985*g778)-(g985*g828)))+512.0*(-g798-g797)
         *(g774*g618-(3.5*g774*g619))+g1101*(4.0*g809*g3hzz+g958*g684)+g1128*(
         2.0*g823*g684+4.0*(g824*g3hzz+g825*g3hzz))+(144.0*g525-(288.0*g524))*(
         g985*sw-(g867*s))+(108.0*g525-(144.0*g524))*(g1000*sw+g996*sw-(g817*t)-
         (g855*u))+(512.0*g556-(128.0*g564))*(g965*s-(3.5*g949*s))+g1110*2.0*(
         g1000*g2hzz+g996*g2hzz)+(-g1172-(1536.0*t))*(g965*g576-(3.5*g949*g576))
         +g1111*(g1157+g1153+16.0*g967*g581-(40.0*g966*g581)+8.0*g967*g636+45.5*
         g657+4.5*(g992*g617-(g1013*g467)));
        t0=t0+(64.0*g586-(512.0*g581))*(g967*s-(2.5*g966*s))+(g1171+108.0*t)*(
         1.18519*g965*g591-(4.14815*g949*g591)+g550)+g1107*(g850+g849)+(g1117-(
         576.0*g488))*(1.5*g827*g1hzz-(g698*g3hzz))+(g1083-g1102)*(g1000*g885+
         g996*g891)+g1158*(2.0*g1057-(72.0*g617)-g1075)+(256.0*g591+2048.0*g556-
         (64.0*g468))*(g1004*g761-(3.5*g761))+g1155*(-g1170-(2.0*g1111))+(g1065-
         (6.0*g1049))*(g996*g970+g629)+(384.0*g450-(400.0*g451))*(g1013*t+g1013*
         u)+g1156*(g1170+4.0*g1111)+(32.0*s-g1111)*(g1154+4.0*g1009*g618-(14.0*
         g1009*g619))+s*(g1181-g1085+g1053+g1045-(1312.0*g712)+684.0*g662-(396.0
         *g667)+224.0*g724+896.0*g719*g596)+sw*(g1064-(288.0*g585)+144.0*g703-(
         576.0*g602)+432.0*g769-g1071);
        t0=t0+t*(g1180+g1041+3.0*g1037-(1312.0*g837))+u*(g1048+3.0*g1047)+g3hzz*
         (128.0*g840-(448.0*g841)+g1195*g709)+g468*(48.0*g851-(168.0*g852))+g517
         *(10.5*g1111+192.0*s)+g518*(-g1172-(18.25*g1111))+g522*288.0*(g580-g696
         )+g533*(576.0*g1016-(1152.0*g1003))+g573*(2880.0*g828-(960.0*g3hzz))+
         g592*144.0*(-g452-g690)+g605*(-(1024.0*g702)-(576.0*g2hzz*sw))+g631*(
         576.0*g556-(720.0*g564))+g635*(144.0*g504*sw+576.0*g697*u)+g647*432.0*(
         g637-(g608*g1hzz))+g653*(-(1008.0*g601)-(576.0*g599)-(288.0*g745*g653))
         +g654*(144.0*g617-(224.0*g744*g654))+g681*(1632.0*g564-(960.0*g591))+
         g682*(g1163+g1092+672.0*g584*g2hzz)+g683*(-g1185-g1179)+g684*(g1167+
         g1097-g1066+g1056+g1043+g1040+396.0*g520);
        t0=t0+g685*(36.0*(g683-g682)-(72.0*g522))+g700*(656.0*g574+g1174*g533)+
         g1028*g987*(64.0*g561+g1198*g640-g1130)+g710*(g1051+12.0*g1049-(288.0*
         g634))+g1051*g711+g717*(g1194*g717-g1176)+g1131*g947*g733+g1000*u*(
         g1090+3.0*g1077-(112.0*g743))+g726*(576.0*g640*sw-(1344.0*g584))+g728*(
         g1089+g1068)+g733*(g1087+2.0*g1073)+g736*(2.75*g1093+3.25*g1082+5.41667
         *g1076)+g739*(3.0*g1101+720.0*g539)+g740*(504.0*(g582+g583)-(336.0*g607
         ))+g741*(g1112+2560.0*g604)+g1112*g742+g751*(g1197*g751-g1164)+g992*
         g958*(2.0*g1062+576.0*(g634-g577))+g754*(g1078-(72.0*g642*g504))+g756*(
         16.0*g1102-(288.0*g488))+g1004*g953*(g1183-g1113)+g767*(-(216.0*g482)-(
         288.0*g548)-(576.0*g580));
        t0=t0+g992*g742*(8192.0*g555-(3072.0*g554)-(224.0*g510))+g774*(768.0*
         g573-(256.0*g719*g625)+960.0*g595*t+g1193*g774)+g1009*g953*(4.0*g1131-(
         576.0*g551))+g778*(2880.0*g573+g1190*g778)+g1000*g534*288.0*(g815+g1015
         )+g1009*g970*(-g1127-(288.0*g459))+g970*g801*(268.0*g514-(744.0*g513)-(
         308.0*g471)+408.0*g470-g1178-(4.0*g1049))-(g1050*g792)+g794*(g1188+
         g1067)+g795*(g1188+g1162-(6432.0*g575*g2hzz))+g797*(g1146+g1165*g732)+
         g798*(656.0*g575-g1110)+g989*g946*(1.125*g1117-(684.0*g488))+g801*(4.0*
         g1100-(472.0*g484)+528.0*g483)-(g1077*g1000*g982)-(g1049*g996*g982)+
         g808*(g1168+1152.0*g534*g2hzz+576.0*g808*g462)+g809*(g1193*g2hzz-(
         1176.0*g603)-(10752.0*g596)-(144.0*g809*g462));
        t0=t0+g810*(g1078-(72.0*g582)+432.0*g579+g1196*g810)+g811*(g1197*g811-
         g1164)+g814*(g1184+g1147)+g817*(g1088+168.0*g582-(240.0*g579)-(g1169*u)
         )+5.33333*g1102*g826*g1hzz+g823*(g1058-(144.0*g770)+36.0*g616-(2.0*
         g1080))+g996*g815*(g1190+g1161)+g1161*g1000*g815+g1095*g985*g815+g946*
         g584*(672.0*g778+480.0*g707)+1.125*g1130*g946*sw+g848*(-(576.0*g614)-(
         648.0*g500))+g945*g1hzz*(64.0*g644+168.0*g608)+g1088*g855+g958*g2hzz*(
         12864.0*g575-(4.0*g1079)-(960.0*g603)-(5760.0*g595)-(896.0*g566)-(
         1536.0*g565))+g967*g3hzz*(-(128.0*g601)-(768.0*g599))+g972*t*(1728.0*
         g564+144.0*g469-(32.0*g550)-(480.0*g591))+g867*(168.0*g583-(1344.0*g581
         ))+g946*u*(g1187+g1163);
        t0=t0+g953*g2hzz*(16.0*g1104+8192.0*g570-(3072.0*g569))+g963*g564*(-(
         1232.0*s)-(864.0*t))+g945*s*(2624.0*g555-(1920.0*g554))+g1147*g982*t+
         g774*g2hzz*(16.0*g1073+576.0*g520-(2.66667*g1098))+g885*(g1061+4.0*
         g1060+764.0*g476-(696.0*g474)-(72.0*g542)+252.0*g472)+g958*s*(2.0*g1107
         -g1062)+g1009*u*(g1127+g1068)+g891*(g1061-(684.0*g520))+g1090*g996*t+
         g828*g2hzz*(32.0*g1060+4096.0*g476-(1536.0*g474))+g972*u*(-(2.0*g1119)-
         (180.0*g468))+g963*u*(g1119+246.0*g468)+g899*g719*(g1165-g1089+944.0*
         g451-(1056.0*g450))+g898*(4.0*g1043-(144.0*g512)+288.0*g711*g462-(2.0*
         g1087))+g899*(g1168-(3584.0*g596))+g823*g733*(936.0*g450-(780.0*g451))+
         g814*t*(-(2.0*g1121)-g1090);
        t0=t0+g797*g450*(-(1056.0*g732)-(864.0*g719))+g797*g451*(944.0*g732+
         432.0*g719)+g793*sw*(g1169+144.0*g578)+g792*t*(g1177+144.0*g531-(288.0*
         g529))+g534*g3hzz*(-g1173-(576.0*g778)-(144.0*g737))+g774*g3hzz*(8.0*
         g1044-(576.0*g523)-(2.0*g1095))+g737*g3hzz*(-g1191-g1160)+g512*g2hzz*(
         g1120-g1173)+g516*g2hzz*(-g1120-(1152.0*g3hzz))+g523*u*(18.0*g733-(36.0
         *g684))+g732*g3hzz*(g1189+g1039-(4.0*g1038)-(1600.0*g507)+1536.0*g506-
         g1191)+g732*g2hzz*(g1175+8.0*g1073-(4.8*g1066)+5.53846*g1056+16.6154*
         g1040)+g474*g2hzz*(384.0*g3hzz-(1536.0*g719))+g476*g2hzz*(4096.0*g719-(
         3520.0*g3hzz))+g717*u*(g1186-g1187)+g707*g3hzz*(g1160+432.0*g453)+g1055
         *g698*g1hzz+g684*s*(g1109-(18.0*g453));
        t0=t0+sw*s*(576.0*g581+864.0*g579-(360.0*g586))+g942*(3.2*g1066-(3520.0*
         g477)+384.0*g475-g1175-(32.0*g1074))+g946*(g1176-g1072-(2.27778*g1069)-
         (36.0*g650)-(336.0*g577)+144.0*(g634-g621)+480.0*g725*g503-g1177)-(3.5*
         g1091*g949)+g953*(4.0*g1065-(8.0*g1049)+576.0*g768+448.0*g515+2512.0*
         g514-(2112.0*g513)-(904.0*g471)+1392.0*g470-(144.0*g654*g637))+g958*(
         384.0*g546+1824.0*g545-(1152.0*g544)-(144.0*g649*g561)-(2.0*g1067)-(
         28.0*g1058)-(180.0*g454))+g957*(-(252.0*g617)-(864.0*g770))+g960*(g1186
         -g1179-g1092+32.0*g620+36.0*g685+144.0*g696-(1344.0*g744)-(512.0*g702*
         g640)+g1198*g644)+g963*(4672.0*g594-(496.0*g552)-(g1164*t)-g1070-(656.0
         *g750))+g965*(g1091+3072.0*g706*g597);
        t0=t0+g966*(2.5*g1084+2.22222*g1064)+g967*(g1059-(128.0*g703)-g1084)+
         g970*(g1181-g1180-(128.0*g1155)+192.0*g1154+6.0*g1053-(2.0*g1048)-(
         2048.0*g837)-(6432.0*g712)+64.0*g559+256.0*g558-(96.0*g557)+3.0*(g1045+
         g1041)+g1185*g717-(216.0*g582*sw)+g1195*g728)+g972*(2.0*g1070-(2688.0*
         g594)+1824.0*g552)+g1029*g749*(168.0*g561-(160.0*g1029*g645))+g982*(
         64.0*g1156-g1047-g1037-(216.0*g662)-(184.0*g518)-(48.0*g517)+108.0*g667
         +112.0*(g657-g724-g723)+32.0*(g1157-g1153))+g1001*g490*(432.0*g982-(
         648.0*g659))+g985*(g1075-(72.0*g562)+168.0*g603*g1hzz)+g987*(g1071+
         168.0*g715-(960.0*g602)-(240.0*g769))+g991*(960.0*g726*g503+864.0*g647*
         g592)+g992*(2.0*g1085+144.0*(g709*g584+g716*g561));
        t0=t0+g1001*g659*(g1183+g1182)+g994*576.0*(-(g697*g641*mw)-(g698*g503))+
         g996*(g1054+27.0*g631*g490-g1184)+g998*(g1063+27.0*g839+36.0*g539*u)+
         g708*g708*(g1186-g1185+816.0*g580+456.0*g584*g1hzz-(1568.0*g708*g510))+
         g1054*g1000+g1004*(576.0*g594-(1008.0*g552)-g1105)+g1009*(g1044-g1039+
         12.0*g1038-(576.0*g777)-(448.0*g626)+656.0*g632+2496.0*g507+144.0*g534-
         g1191-g1055-(16.0*g1046))+g1012*(g1189+4.0*g1094+684.0*g839+648.0*g453)
         +g1013*(g1081+54.0*g453-(2.0*g1109))+g1014*(g1094+g1063+36.0*g523)+g791
         *g791*(g1106+8.0*g505)+g1106*g793*g793+g504*g504*(8.0*g688-(28.0*g687))
         +g792*g792*(g1192+64.0*g505+472.0*g502-(528.0*g501))+656.0*g1018*g755*
         g615-(28.0*g694*g503*g503)+g1194*g789*g789+g1196*g1019;
        msq3=(t0-(336.0*g706*g584)-(72.0*g945*g637)+g1176*g944)/(g971*g946*(
         1728.0*g631*g631-(3456.0*g992*g681))+1728.0*g971*g695);
    };
  };
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
  
  /* Matrixelement */
  double g1271,g1272,g1232,g1274,g1214,g1212,g1265,g1282,g1213,g1275,g1237,g1223,g1279,g1215,g1221,g1216,g1233,g1217,g1235,g1262,g1218,g1219,g1236,g1222,g1220,g1277,g1224,g1266,g1273,g1243,g1226,g1244,g1227,g1229,g1228,g1239,g1230,g1231,g1264,g1240,g1245,g1280,g1278,g1270,g1269,g1258,g1287,g1290,g1288,g1300,g1289,g1291,g1294,g1292,g1293,g1295,g1299,msq1;
{
    double t0 = 0;
    g1271=mq*mq;
    g1272=mz*mz;
    g1232=g1272*g1271;
    g1274=ee*ee;
    g1214=g1274*g1232;
    g1212=g1214*s;
    g1265=g1274*g1272;
    g1282=g2hzy*g2hzy;
    g1213=g1282*g1265;
    g1275=g1hzy*g1hzy;
    g1237=g1275*g1274;
    g1223=g1272*g1237;
    g1279=s*s;
    g1215=g1279*g1223;
    g1221=g1237*u;
    g1216=g1221*s;
    g1233=g1237*s;
    g1217=g1233*t;
    g1235=g1272*g1265;
    g1262=g1235*g2hzy;
    g1218=g1262*g2hzy;
    g1219=g1223*s;
    g1236=g1274*g1271;
    g1222=g1275*g1236;
    g1220=g1222*s;
    g1277=mh*mh;
    g1224=g1277*g1233;
    g1266=g1272*g1272;
    g1273=g1272*g1266;
    g1243=u*g1hzy;
    g1226=g1243*s;
    g1244=t*g1hzy;
    g1227=g1244*s;
    g1229=g1271*g1hzy;
    g1228=g1229*s;
    g1239=g2hzy*g1hzy;
    g1230=g1265*g1239;
    g1231=g1279*g1239;
    g1264=g1272*s;
    g1240=g1271*g1221;
    g1245=g1275*g1214;
    g1280=u*u;
    g1278=t*s;
    g1270=g1271*g1271;
    g1269=g1271*s;
    g1258=g1216*t;
    g1287=g1217-g1224;
    g1290=16.0*(g1239*g1214+g1271*g1213);
    g1288=g1290-(6.0*g1220)-(3.0*g1219);
    g1300=4.0*g1216;
    g1289=g1300+4.0*g1217;
    g1291=64.0*g1273*g1236+16.0*g1264*g1235;
    g1294=8.0*(-g1230-g1213);
    g1292=16.0*g1223-(8.0*g1294);
    g1293=16.0*(-(g1212*t)-(g1212*u));
    g1295=16.0*(-(g1218*t)-(g1218*u));
    g1299=8.0*g1275*g1212;
    {
        t0=4.0*(-t-u)*(16.0*g1262*g1229-(4.0*g1279*g1230)+g1215-g1299)+g1294*(
         8.0*g1270*u-(g1278*t)-(g1280*s))+g1289*(g1277*g1271+g1277*g1272)+g1295*
         s+g1214*(4.0*(g1243*g1243+g1244*g1244)-(32.0*g1231))+g1235*(32.0*g1229*
         g1229-(16.0*g1231))+g1239*(g1291+128.0*g1232*g1214-g1293)-(g1292*g1270*
         t)+g1271*g1269*(16.0*g1213-(48.0*g1230))+g1278*s*(6.0*g1221-(8.0*g1222)
         )+g1262*(16.0*(-g1227-g1226)-(32.0*g1228))+u*t*(2.0*g1290+8.0*g1245)+
         g1266*(g1300+4.0*g1287-(40.0*g1220)+16.0*(-g1240-(g1222*t)))+g1271*
         g1270*(g1292-(8.0*g1233))+g1270*(3.0*g1289+128.0*g1218-(4.0*g1224)-(
         48.0*g1219))+g1271*(4.0*g1295-(12.0*g1258)-(16.0*g1232*g1221))+g1274*(
         g1226*g1226+g1227*g1227+8.0*g1228*g1228);
        msq1=(t0+g1277*(4.0*g1215-(2.0*g1258)-g1299)+g1279*(24.0*g1245-(8.0*
         g1240)+16.0*g1218)+g1280*(g1288-g1224+3.0*g1217+g1233*u)+g1282*(g1293+
         g1291)+t*t*(g1288+g1287+3.0*g1216)+32.0*g1269*g1218-(10.0*g1272*g1258)+
         16.0*g1273*g1222)/(54.0*g1264*s);
    }
}
double g1565,g1556,g1563,g1416,g1369,g1554,g1417,g1333,g1555,g1489,g1384,g1553,g1425,g1334,g1422,g1394,g1482,g1564,g1562,g1475,g1478,g1481,g1418,g1476,g1421,g1395,g1469,g1321,g1322,g1323,g1324,g1557,g1397,g1538,g1386,g1480,g1479,g1467,g1409,g1393,g1382,g1426,g1415,g1405,g1471,g1342,g1550,g1406,g1343,g1451,g1344,g1423,g1392,g1347,g1345,g1483,g1346,g1495,g1398,g1391,g1474,g1402,g1350,g1368,g1351,g1352,g1370,g1353,g1401,g1524,g1355,g1551,g1365,g1356,g1366,g1357,g1374,g1358,g1561,g1490,g1359,g1419,g1390,g1484,g1360,g1404,g1388,g1361,g1411,g1362,g1547,g1363,g1364,g1477,g1367,g1383,g1371,g1389,g1373,g1396,g1381,g1375,g1400,g1472,g1379,g1380,g1385,g1403,g1399,g1548,g1410,g1430,g1424,g1427,g1432,g1433,g1434,g1435,g1439,g1446,g1464,g1453,g1462,g1466,g1465,g1463,g1488,g1496,g1501,g1528,g1637,g1589,g1590,g1572,g1573,g1609,g1574,g1575,g1576,g1597,g1577,g1596,g1624,g1586,g1593,g1625,g1578,g1587,g1579,g1580,g1584,g1581,g1582,g1583,g1585,g1588,g1591,g1592,g1594,g1599,g1601,g1603,g1604,g1605,g1607,g1608,g1611,g1612,g1615,g1631,g1632,g1622,g1623,g1626,g1627,g1628,g1629,g1630,g1633,g1634,g1635,g1636,g1638,g1639,g1640,msq2;
{
    double t0 = 0;
    g1565=sw*sw;
    g1556=g1565*sw;
    g1563=ee*ee;
    g1416=g1563*g1556;
    g1369=g1416*g1hzy;
    g1554=mz*mz;
    g1417=g1554*s;
    g1333=g1417*g1369;
    g1555=mq*mq;
    g1489=g1563*g1hzy;
    g1384=g1489*s;
    g1553=g1565*g1556;
    g1425=g1554*g1553;
    g1334=g1425*g1384;
    g1422=g1554*g2hzy;
    g1394=g1563*g1422;
    g1482=g1394*g2hzz;
    g1564=u*u;
    g1562=t*t;
    g1475=g1564*g1hzz;
    g1478=g1562*g1hzz;
    g1481=g1556*g1394;
    g1418=g1553*g1hzz;
    g1476=g1554*g2hzz;
    g1421=g1563*g1553;
    g1395=g1421*g1hzy;
    g1469=g1369*g1hzz;
    g1321=g1564*g1469;
    g1322=g1562*g1469;
    g1323=g1475*g1395;
    g1324=g1478*g1395;
    g1557=s*s;
    g1397=g1563*g1557;
    g1538=g1hzz*g1hzy;
    g1386=g1538*g1397;
    g1480=g1553*u;
    g1479=g1394*t;
    g1467=u*t;
    g1409=g1555*g1hzz;
    g1393=g1409*s;
    g1382=g1384*sw;
    g1426=g1555*g1554;
    g1415=g1416*g2hzy;
    g1405=g1553*g3hzz;
    g1471=g1563*g2hzy;
    g1342=g1415*g2hzz;
    g1550=g1554*g1554;
    g1406=g1553*g2hzz;
    g1343=g1471*g1406;
    g1451=g1hzz*sw;
    g1344=g1451*g1394;
    g1423=g1550*g2hzy;
    g1392=g1563*g1423;
    g1347=g1555*g1392;
    g1345=g1347*u;
    g1483=g1556*g1hzz;
    g1346=g1483*g1392;
    g1495=g1555*g3hzz;
    g1398=g1563*g1555;
    g1391=g1398*g1hzy;
    g1474=sw*g1hzy;
    g1402=g1563*g1474;
    g1350=g1476*g1402;
    g1368=g1391*g2hzz;
    g1351=g1550*g1368;
    g1352=g1475*g1402;
    g1370=g1391*g1hzz;
    g1353=g1370*sw;
    g1401=g1555*g1398;
    g1524=g1hzz*u;
    g1355=g1524*g1401*g1hzy;
    g1551=g1555*g1555;
    g1365=g1551*g1369;
    g1356=g1365*g1hzz;
    g1366=g1551*g1395;
    g1357=g1366*g1hzz;
    g1374=g1557*g1554;
    g1358=g1489*g1374;
    g1561=mh*mh;
    g1490=g1561*g1hzz;
    g1359=g1490*g1384;
    g1419=g1563*mw*ee;
    g1390=g1554*g1419;
    g1484=g1390*g2hzy;
    g1360=g1565*g1484;
    g1404=g1555*g1419;
    g1388=g1404*g1hzy;
    g1361=g1388*u;
    g1411=g1419*g1hzy;
    g1362=g1565*g1411;
    g1547=g1554*g1550;
    g1363=g1547*g1398*g2hzy;
    g1364=g1551*g1392;
    g1477=g1550*g2hzz;
    g1367=g1477*g1397;
    g1383=g1551*g1398;
    g1371=g1538*g1383;
    g1389=g1398*sw;
    g1373=g1422*g1389;
    g1396=g1401*sw;
    g1381=g1554*g1396;
    g1375=g1381*g2hzy;
    g1400=g1471*s;
    g1472=g1550*g1384;
    g1379=g1472*g2hzz;
    g1380=g1382*g1hzz;
    g1385=g1396*g1hzy;
    g1403=g1419*s;
    g1399=g1550*s;
    g1548=g1555*g1551;
    g1410=g1548*g1469;
    g1430=g1555*g1362;
    g1424=g1554*sw;
    g1427=g1562*g1380;
    g1432=g1550*g1359;
    g1433=g1556*g1355;
    g1434=g1562*g1353;
    g1435=g1555*g1350;
    g1439=g1554*g1426;
    g1446=g2hzz*sw;
    g1464=g1hzz*s;
    g1453=g1353*s;
    g1462=g1555*t;
    g1466=g1561*u;
    g1465=g1561*t;
    g1463=g2hzz*s;
    g1488=g1385*g1hzz;
    g1496=g1367*g1hzy;
    g1501=g1359*sw;
    g1528=g1hzz*t;
    g1637=48.0*g1404*g2hzy;
    g1589=g1637+24.0*g1403*g2hzy;
    g1590=64.0*g1405*g1391-(88.0*g1495*g1369)+24.0*g1389*g3hzz*g1hzy;
    g1572=2.0*g1590+g1589;
    g1573=352.0*g1550*g1342-(256.0*g1550*g1343);
    g1609=176.0*g1481*u-(128.0*g1480*g1394);
    g1574=128.0*g1553*g1479-(176.0*g1556*g1479)-g1609;
    g1575=44.0*g1356*s+12.0*g1453*u-(8.0*g1323*s)+11.0*g1321*s-(3.0*g1352*s)-(
     32.0*g1357*s);
    g1576=3.0*g1352+11.0*(-g1322-g1321)+8.0*(g1324+g1323);
    g1597=-(4.0*g1573)-(128.0*g1360);
    g1577=g1597-(528.0*g1346);
    g1596=64.0*g1418*g1394-(88.0*g1481*g1hzz);
    g1624=2.0*g1596;
    g1586=-g1624-(48.0*g1344);
    g1593=88.0*g1476*g1369-(64.0*g1476*g1395);
    g1625=4.0*g1593;
    g1578=g1625+2.0*g1586;
    g1587=48.0*(-(g1562*g1482)-(g1564*g1482))+24.0*(-(g1478*g1394)-(g1475*g1394)
     );
    g1579=-g1587-(96.0*g1351);
    g1580=2.0*g1593-(48.0*g1350);
    g1584=g1573+64.0*g1360;
    g1581=-g1590-g1584-(88.0*g1346);
    g1582=g1572+24.0*g1388;
    g1583=12.0*g1361+32.0*(-(g1430*t)-(g1565*g1361));
    g1585=256.0*g1357-(352.0*g1356);
    g1588=32.0*g1553*g1386-(44.0*g1557*g1469);
    g1591=16.0*g1467*g1395-(22.0*g1467*g1369);
    g1592=352.0*g1415*g3hzz-(256.0*g1471*g1405);
    g1594=88.0*g1555*g1333-(24.0*g1426*g1382)-(64.0*g1555*g1334);
    g1599=2.0*g1578-(192.0*g1350);
    g1601=96.0*g1363-(144.0*g1345);
    g1603=-(192.0*g1550*g1370)-(512.0*g1351);
    g1604=12.0*g1432+24.0*g1358*g3hzz;
    g1605=11.0*g1464*g1369-(8.0*g1418*g1384);
    g1607=88.0*g1365-(64.0*g1366);
    g1608=11.0*g1322*s-(8.0*g1324*s);
    g1611=12.0*(g1399-g1374);
    g1612=352.0*g1342-(256.0*g1343);
    g1615=12.0*(-t-u);
    g1631=96.0*g1463;
    g1632=96.0*g3hzz;
    g1622=g2hzz*t+g2hzz*u;
    g1623=2.66667*g1418+g1451;
    g1626=2.0*g1592;
    g1627=2.0*g1588;
    g1628=12.0*g1403;
    g1629=32.0*g1362;
    g1630=128.0*g1362;
    g1633=3.0*t;
    g1634=48.0*g1353;
    g1635=24.0*g1382*g3hzz;
    g1636=96.0*g1435;
    g1638=176.0*g1369;
    g1639=-(96.0*sw);
    g1640=-(192.0*sw);
    {
        t0=3.66667*(g1601*g1483+g1579*g1556*s)+4.0*(g1609*g1462*g2hzz+g1607*
         g1554*g3hzz)+(-(48.0*g1435)-(24.0*g1350*s))*(g1564+g1562)+g1599*(g1548-
         (g1551*u))+(24.0*g1371-(36.0*g1355)-g1579)*(s*sw+2.66667*g1553*s)+(48.0
         *g1379+192.0*g1351)*(t*sw+u*sw)+g1591*(3.0*g1417*g1hzz-(8.0*g1554*g1409
         )+g1561*g1464+6.0*g1393)+g1615*(g1424*g1359-(6.0*g1550*g1353))+24.0*(
         g1400*t+g1400*u)*(2.0*g1424*g3hzz+4.0*g1550*g1446+g1550*g1451+2.66667*
         g1550*g1418)+(g1632+g1631)*(g1373*t+g1373*u)+g1594*(4.0*(g1524+g1528)-
         g1490)+g1622*(2.0*g1594+384.0*g1375)+g1587*(2.0*g1555*sw+5.33333*g1555*
         g1553-(7.33333*g1556*g1555))+g1593*(g1562*s+g1564*s+2.0*(g1562*g1555+
         g1564*g1555));
        t0=t0+g1574*(8.0*g1551*g2hzz+2.0*(g1495+g1555*g1463))+(32.0*g1334-(44.0*
         g1333))*(14.0*g1551*g1hzz-(g1465*g1hzz)-(g1466*g1hzz))+(32.0*g1421*
         g1393-(44.0*g1416*g1393))*(8.0*g1550*g1hzy-(g1465*g1hzy)-(g1466*g1hzy)+
         4.0*g1423)+(g1580+24.0*g1353-g1596)*(g1557*t+g1557*u)+g1603*1.375*(
         g1556*t+g1556*u)+(128.0*g1379-g1603)*(g1553*t+g1480)+g1623*(-g1601-(
         288.0*g1364))+g1612*(g1551*g1417+4.0*(g1551*g1426+g1554*g1439))+96.0*(
         g1355-g1371)*(2.66667*g1425+g1424)+g1604*sw+s*(132.0*g1433+18.0*g1434-
         g1583-(88.0*g1410))+g1633*g1575+3.0*g1608*u+g3hzz*(g1640*g1347-(4.0*
         g1594))+g1367*(48.0*g1474+g1639*g2hzy)+g1374*(-g1634-g1629)+g1375*(-
         g1631-(192.0*g3hzz))+g1399*(g1629+g1592+96.0*g1353);
        t0=t0+g1405*64.0*(g1358-g1472)-(g1611*g1411)+g1555*g1417*(g1592-g1630)+
         g1417*(g1576+48.0*g1388-g1637)+g1426*(-(4.0*g1588)-(8.0*g1576))+g1427*(
         -g1633-(9.0*u))+g1555*g1426*(g1630+g1626+168.0*g1380)+g1550*g1425*(-(
         128.0*g1370)-(512.0*g1368))+g1557*g1344*(2.0*g1615+48.0*g1555)+g1626*
         g1439-(g1588*g1561*g1554)+g1557*g1555*(g1624-g1625)+g1446*(384.0*(g1345
         -(g1422*g1383)-g1363)-(768.0*g1364))+g1554*g1467*(18.0*g1380-g1634)+
         g1547*s*(g1612+g1638*g2hzz)+g1578*g1462*u+g1462*(g1627+g1577)+g1467*(
         g1635-(1.5*g1588)+6.0*g1501-(g1629*s)+g1628*g1hzy-(18.0*g1386*sw)-(
         192.0*g1373*g2hzz)-g1636)+g1551*g1hzy*(g1628-(48.0*g1390))+g1477*(16.0*
         g1607-(384.0*g1385))+g1554*t*(g1585+g1582)+g1572*g1554*u;
        t0=t0+g1562*sw*3.0*(g1359-g1386)+g1551*t*(-g1599-(36.0*g1380))+g1551*s*(
         -g1629-g1586-(3.0*g1580))+g1555*u*(g1627+g1597)+g1555*s*(2.0*g1584+6.0*
         g1576)+g3hzz*s*(4.0*g1591+g1574-(96.0*g1373)+g1639*g1392-g1607)+g1381*
         g1hzy*(96.0*g1528-g1632)+g1399*g1369*(88.0*g3hzz-(176.0*g1622))+g1347*t
         *(144.0*g1623+384.0*g1446)+g1347*s*(48.0*g1451-(192.0*g1446))+t*s*(
         g1581-(12.0*g1388))+g1581*u*s+g1547*(g1638*g1409+g1640*g1368-(128.0*
         g1406*g1384)-(48.0*g1382*g2hzz)-(96.0*g1446*g1400)-g1634)+g1551*(g1635-
         g1627-(2.0*g1577)-(96.0*g1484)+12.0*g1501)+g1550*(128.0*g1430-(144.0*
         g1488)-g1635-(1.5*g1585)-(2.0*g1582))+g1553*(32.0*g1432+128.0*g1496);
        msq2=(t0+g1554*(2.0*g1583-(24.0*g1434)+3.0*g1427+352.0*(g1410-g1433))+
         g1556*(-(3.66667*g1604)-(176.0*g1496))+g1557*(g1636-g1576+g1573-(24.0*
         g1488))+g1564*u*(g1605-(3.0*g1380))+g1605*g1562*t+g1561*(-g1608-g1575-(
         12.0*g1451*g1358))+g1424*g1424*(5.33333*g1589+704.0*g1424*g1368)-(12.0*
         g1465*g1453))/(18.0*g1611*g1565*cw*cw*cw);
    }
}
double g2178,g2199,g1838,g1962,g2227,g1656,g1647,g2208,g1837,g1900 ,g2210,g1657,g1648,g2212,g2195,g2180,g1819,g2204,g2058,g1649,g2057,g1650,g2174,g2171,g1818,g1651,g1652,g2200,g1759,g2193,g1899,g1748,g1702,g1894,g1749,g1703,g2165,g1817,g1658,g1659,g1916,g2031,g1730,g1953,g1660,g1902,g1869,g1695,g1661,g2194,g1836,g1768,g2190,g1690,g1662,g2157,g2060,g1859,g2151,g2177,g1734,g1664,g2173,g2059,g1956,g1735,g1666,g1670,g1667,g1849,g1862,g2202,g1741,g2197,g1669,g1668,g1718,g1713,g1675,g1925,g1698,g1676,g1719,g2166,g1677,g1957,g1963,g2226,g1709,g1678,g1857,g2225,g1710,g1679,g2154,g1747,g1985,g1680,g1731,g1714,g1682,g1683,g1715,g1684,g1685,g1895,g1827,g1716,g1686,g1896,g1826,g1717,g1688,g1835,g1721,g1691,g1722,g1692,g1891,g1723,g1959,g1696,g1697,g1954,g1699,g2161,g2056,g2223,g1762,g1704,g1763,g1705,g1708,g1889,g1945,g1711,g1927,g1712,g1720,g2168,g1761,g1724,g1832,g1752,g1725,g1753,g1726,g1754,g1727,g1728,g2198,g1942,g1848,g1729,g1901,g1850,g1906,g1732,g1733,g2217,g1860,g1736,g1897,g2211,g1822,g1737,g1739,g1955,g2224,g1742,g1743,g1744,g1834,g1833,g1750,g2181,g1893,g1756,g1858,g1757,g1829,g1758,g1831,g1760,g2153,g1898,g1764,g1830,g1765,g1766,g1767,g1769,g1770,g1828,g1771,g2106,g1772,g1856,g1777,g1773,g1778,g1774,g1779,g1780,g1914,g1854,g1803,g1781,g1782,g1840,g1783,g1934,g1797,g1784,g1816,g1788,g1785,g2005,g1847,g1786,g2035,g1787,g1807,g1789,g1853,g1814,g1790,g1791,g1792,g1940,g1793,g1843,g1809,g1794,g2150,g1795,g1796,g1805,g1933,g1851,g1799,g1800,g2152,g1855,g2023,g1802,g1804,g1913,g1808,g1806,g1810,g1811,g1812,g1813,g1815,g1964,g1823,g1824,g1825,g1839,g2006,g1841,g1861,g1842,g1844,g1845,g2175,g1852,g1951,g1950,g1864,g1975,g1949,g1865,g1892,g1867,g1948,g1944,g1870,g1946,g1947,g1875,g2222,g2206,g1943,g1890,g2236,g1903,g1904,g1905,g1907,g1908,g1910,g1997,g1911,g1924,g1915,g1917,g1918,g1919,g1920,g2049,g2048,g1923,g1941,g2155,g2033,g2032,g2046,g1931,g1932,g2221,g1936,g2022,g1952,g1958,g1966,g1967,g2164,g1969,g1976,g1977,g1978,g1982,g1986,g2019,g2063,g2025,g2075,g2009,g1999,g2000,g2001,g2002,g2003,g2099,g2093,g2016,g2017,g2018,g2036,g2034,g2045,g2047,g2220,g2107,g2237,g2209,g2245,g2246,g2317,g2247,g2248,g2249,g2250,g2264,g2268,g2274,g2282,g2304,g2281,g2307,g2373,g2252,g2253,g2254,g2255,g2256,g2257,g2303,g2258,g2284,g2290,g2302,g2259,g2294,g2261,g2260,g2262,g2288,g2265,g2308,g2266,g2263,g2267,g2374,g2269,g2277,g2280,g2270,g2271,g2272,g2273,g2368,g2275,g2291,g2372,g2376,g2276,g2313,g2278,g2279,g2283,g2329,g2285,g2384,g2286,g2287,g2289,g2292,g2293,g2305,g2295,g2296,g2297,g2388,g2298,g2299,g2395,g2397,g2300,g2301,g2306,g2316,g2309,g2334,g2310,g2312,g2314,g2315,g2352,g2318,g2369,g2319,g2320,g2392,g2321,g2402,g2325,g2371,g2327,g2383,g2328,g2333,g2378,g2336,g2337,g2363,g2353,g2360,g2362,g2365,g2366,g2367,g2370,g2375,g2377,g2379,g2380,g2381,g2382,g2385,g2386,g2387,g2389,g2390,g2391,g2393,g2394,g2396,g2398,g2399,g2400,g2401,g2403,g2404,g2405,g2406,g2407,g2408,g2409,g2416,g2179,msq3;
{	
    double t0 = 0;
    g2178=mq*mq;
    g2199=ee*ee;
    g1838=g2199*g2178;
    g1962=u*sw;
    g2227=g1962*g1962;
    g1656=g2227*g1838;
    g1647=g1656*s;
    g2208=t*t;
    g1837=g2208*g2178;
    g1900=sw*ee;
    g2210=g1900*g1900;
    g1657=g2210*g1837;
    g1648=g1657*s;
    g2212=sw*sw;
    g2195=g2212*sw;
    g2180=g2195*sw;
    g1819=g2180*g1838;
    g2204=u*u;
    g2058=g2204*s;
    g1649=g2058*g1819;
    g2057=g2208*s;
    g1650=g2057*g1819;
    g2174=g2180*sw;
    g2171=g2174*sw;
    g1818=g2171*g1838;
    g1651=g2058*g1818;
    g1652=g2057*g1818;
    g2200=mz*mz;
    g1759=g2210*g2200;
    g2193=s*s;
    g1899=g2199*g2180;
    g1748=g2200*g1899;
    g1702=g2178*g1748;
    g1894=g2199*g2171;
    g1749=g2200*g1894;
    g1703=g2178*g1749;
    g2165=g2200*g2200;
    g1817=g2165*g1838;
    g1658=g2180*g1817;
    g1659=g2171*g1817;
    g1916=g2200*g2178;
    g2031=u*t;
    g1730=g2031*g1916;
    g1953=g2199*g1730;
    g1660=g1953*s;
    g1902=g2199*g2165;
    g1869=g1902*u;
    g1695=g2212*g1869;
    g1661=g1695*t;
    g2194=g2199*g1hzz;
    g1836=g2194*g1hzz;
    g1768=g2212*g1836;
    g2190=mh*mh;
    g1690=g2190*g1768*s;
    g1662=g2165*g1690;
    g2157=g2180*g2180;
    g2060=g2157*u;
    g1859=g2199*t;
    g2151=g2180*g2165;
    g2177=g2180*g2151;
    g1734=g2177*g1859;
    g1664=g1734*s;
    g2173=g2212*g2157;
    g2059=g2173*u;
    g1956=g2212*g2177;
    g1735=g1956*g1859;
    g1666=g1735*s;
    g1670=g1759*s;
    g1667=g1670*u;
    g1849=g2178*ee;
    g1862=g2200*s;
    g2202=g1849*g1849;
    g1741=g2202*g1862;
    g2197=g1hzz*g1hzz;
    g1669=g2197*g1741;
    g1668=g1669*t;
    g1718=g2157*g1836;
    g1713=g1956*g1836;
    g1675=g2212*g1817;
    g1925=g2165*t;
    g1698=g1925*g1836;
    g1676=g2193*g1698;
    g1719=g1862*g1836*s;
    g2166=g2178*g2178;
    g1677=g2166*g1719;
    g1957=g2200*sw;
    g1963=g1957*sw;
    g2226=g1963*g1963;
    g1709=g2226*g1836;
    g1678=g1709*s;
    g1857=g1963*sw;
    g2225=g1857*g1857;
    g1710=g2225*g1836;
    g1679=g1710*s;
    g2154=g2200*g2165;
    g1747=g2210*g2154;
    g1985=g2178*g1747;
    g1680=g1985*u;
    g1731=g1747*t;
    g1714=g2154*g1819;
    g1682=g1714*u;
    g1683=g1714*t;
    g1715=g2154*g1818;
    g1684=g1715*u;
    g1685=g1715*t;
    g1895=g2199*g2157;
    g1827=g2154*g1895;
    g1716=g2178*g1827;
    g1686=g1716*u;
    g1896=g2212*g1895;
    g1826=g2154*g1896;
    g1717=g2178*g1826;
    g1688=g1717*u;
    g1835=g2154*g1836;
    g1721=g2180*g1835;
    g1691=g1721*s;
    g1722=g2171*g1835;
    g1692=g1722*s;
    g1891=g2154*s;
    g1723=g2197*g1826;
    g1959=g2212*t;
    g1696=g2202*g1959;
    g1697=g2180*g1869;
    g1954=g2199*u;
    g1699=g2225*g1954;
    g2161=g2178*g2166;
    g2056=g2161*s;
    g2223=g2hzz*g2hzz;
    g1762=g2223*g1899;
    g1704=g2154*g1762;
    g1763=g2223*g1894;
    g1705=g2154*g1763;
    g1708=g2165*g1768;
    g1889=g2180*s;
    g1945=g1hzz*u;
    g1711=g1945*g1889;
    g1927=g1hzz*t;
    g1712=g1927*g1862;
    g1720=g2193*g1747;
    g2168=g2200*g2154;
    g1761=g2210*g2168;
    g1724=g2178*g1761;
    g1832=g2168*g1836;
    g1752=g2180*g1832;
    g1725=g2178*g1752;
    g1753=g2171*g1832;
    g1726=g2178*g1753;
    g1754=g2173*g1832;
    g1727=g2178*g1754;
    g1728=g2166*g1747;
    g2198=g2199*ee;
    g1942=g2198*mw;
    g1848=g1942*s;
    g1729=g1916*g1848;
    g1901=g2178*mw;
    g1850=g2198*g1901;
    g1906=g2200*g3hzz;
    g1732=g1906*g1850;
    g1733=g2165*g1850*g1hzz;
    g2217=g3hzz*g3hzz;
    g1860=g2217*g1954;
    g1736=g2212*g1860;
    g1897=g2212*g3hzz;
    g2211=g1897*g1897;
    g1822=g2211*g2199;
    g1737=g1822*u;
    g1739=g2171*g1860;
    g1955=g2195*g3hzz;
    g2224=g1955*g1955;
    g1742=g1747*s;
    g1743=g2168*g1762;
    g1744=g2168*g1763;
    g1834=g2168*g1895;
    g1833=g2168*g1896;
    g1750=g1761*u;
    g2181=mw*mw;
    g1893=g2198*g2181*ee;
    g1756=g2212*g1893;
    g1858=g1893*u;
    g1757=g2165*g1858;
    g1829=g2178*g1893;
    g1758=g2165*g1829;
    g1831=g2202*g2165;
    g1760=g2217*g1831;
    g2153=g2200*g2168;
    g1898=g2199*g2153;
    g1764=g2223*g1898;
    g1830=g2153*g1836;
    g1765=g2180*g1830;
    g1766=g2171*g1830;
    g1767=g2173*g1830;
    g1769=g1945*g1848;
    g1770=g2200*g1829;
    g1828=g2180*g1893;
    g1771=g2154*g1828;
    g2106=g3hzz*g1hzz;
    g1772=g2106*g1831;
    g1856=g2194*g2154;
    g1777=g2180*g1856;
    g1773=g1777*s;
    g1778=g2171*g1856;
    g1774=g1778*s;
    g1779=g1827*g1hzz;
    g1780=g1826*g1hzz;
    g1914=g2168*g1hzz;
    g1854=g2199*g1914;
    g1803=g2180*g1854;
    g1781=g2178*g1803;
    g1782=g1854*u;
    g1840=g2168*g1894;
    g1783=g1840*g1hzz;
    g1934=g2168*g2hzz;
    g1797=g1934*g1838;
    g1784=g1797*g1hzz;
    g1816=g2210*g1900*mw;
    g1788=g1816*g3hzz;
    g1785=g1788*s;
    g2005=g3hzz*u;
    g1847=g2005*g1942;
    g1786=g2178*g1847;
    g2035=g2165*g3hzz;
    g1787=g2035*g1850;
    g1807=g2154*g1850;
    g1789=g1807*g2hzz;
    g1853=g1942*g1hzz;
    g1814=g2154*g1853;
    g1790=g1814*u;
    g1791=g1814*t;
    g1792=g1816*s;
    g1940=g1hzz*s;
    g1793=g1940*g1807;
    g1843=g2166*g1942;
    g1809=g2165*g1843;
    g1794=g1809*g1hzz;
    g2150=g3hzz*g2hzz;
    g1795=g2150*g1899;
    g1796=g2150*g1894;
    g1805=g2202*g2hzz;
    g1933=g2199*g3hzz;
    g1851=g1933*g1hzz;
    g1799=g2168*g1851;
    g1800=g1897*g1hzz;
    g2152=g2178*g2165;
    g1855=g2166*g2152;
    g2023=g2hzz*g1hzz;
    g1802=g2153*g2023*g1838;
    g1804=g1834*g2hzz;
    g1913=g2174*g1942;
    g1808=g1913*g3hzz;
    g1806=g2154*g1808;
    g1810=g1934*g1850;
    g1811=g2154*g1816;
    g1812=g1913*g2hzz;
    g1813=g2154*g1843;
    g1815=g2168*g1853;
    g1964=g2217*s;
    g1823=g2199*g1964;
    g1824=g1829*s;
    g1825=g2181*g1838*g1838;
    g1839=g2212*s;
    g2006=g3hzz*t;
    g1841=g2006*g1942;
    g1861=g3hzz*sw;
    g1842=g1861*g1848;
    g1844=g2154*g1848*g2hzz;
    g1845=g1853*sw;
    g2175=g2195*g2180;
    g1852=g2175*g1942;
    g1951=g2154*g1718;
    g1950=g2165*g2152;
    g1864=g1950*g1718;
    g1975=g2200*g2152;
    g1949=g2178*g1975;
    g1865=g1949*g1718;
    g1892=g2197*g2190;
    g1867=g2212*g2178;
    g1948=g1867*sw;
    g1944=g2197*g2165;
    g1870=g1944*g1696;
    g1946=g2197*g2178;
    g1947=g2197*g2161;
    g1875=g1946*g1661;
    g2222=g1945*g1945;
    g2206=g1927*g1927;
    g1943=g2200*g2197;
    g1890=g2154*t;
    g2236=g2200*g2151;
    g1903=g2236*g2165;
    g1904=g1942*g1861;
    g1905=g2200*g1861;
    g1907=g2180*g3hzz;
    g1908=g2171*g3hzz;
    g1910=g2175*g2hzz;
    g1997=g2165*u;
    g1911=g1997*g1841;
    g1924=g2166*sw;
    g1915=g2178*g1hzz;
    g1917=g2161*g1hzz;
    g1918=g2166*u;
    g1919=g2166*t;
    g1920=g2171*g1782*g2hzz;
    g2049=g2157*g1782;
    g2048=g2173*g1782;
    g1923=g1925*g1769;
    g1941=g2197*s;
    g2155=g2178*g2161;
    g2033=g2204*g1hzz;
    g2032=g2208*g1hzz;
    g2046=g2168*g1718;
    g1931=g2046*u;
    g1932=g2046*t;
    g2221=g1940*g1940;
    g1936=g2217*t;
    g2022=g2190*u;
    g1952=g2166*g1718;
    g1958=g2153*g1851;
    g1966=g2174*g1815;
    g1967=g2175*g1815;
    g2164=g1948*sw;
    g1969=g2180*g2164;
    g1976=g2200*g1788;
    g1977=g2165*g1786;
    g1978=g2178*g1785;
    g1982=g2hzz*s;
    g1986=g2hzz*u;
    g2019=g2212*u;
    g2063=g2019*sw;
    g2025=g1959*sw;
    g2075=g1839*sw;
    g2009=g2190*g2178;
    g1999=u*s;
    g2000=g2178*s;
    g2001=t*s;
    g2002=g2178*u;
    g2003=g2178*t;
    g2099=g2197*u;
    g2093=g2197*t;
    g2016=g2178*g3hzz;
    g2017=g2166*g1hzz;
    g2018=t*sw;
    g2036=g2hzz*t;
    g2034=g2193*g3hzz;
    g2045=g1982*g1783;
    g2047=g1695*s;
    g2220=g1915*g1915;
    g2107=g3hzz*s;
    g2237=g1957*g1957;
    g2209=g1867*g1867;
    g2245=72.0*g1947*g1670+108.0*g2222*g1658-(36.0*g1943*g1649)+89.0*g2204*g1679
     -(42.0*g2204*g1678)+18.0*(g1943*g1651+g1943*g1647)+54.0*(-(g2222*g1659)-(
     g1944*g1656));
    g2246=256.0*g1717-(704.0*g1716);
    g2317=128.0*g2059*g1817-(352.0*g2060*g1817);
    g2247=4.0*g2317-(144.0*g1661);
    g2248=140.0*(-g1684-g1685);
    g2249=36.0*g1757+256.0*g2175*g1790-(448.0*g2174*g1790);
    g2250=512.0*g1833+144.0*g1761;
    g2264=264.0*(g1682+g1683);
    g2268=128.0*g1688-(352.0*g1686);
    g2274=180.0*(g2178*g1731+g1680);
    g2282=128.0*g1717*t-(352.0*g1716*t);
    g2304=g2282+g2268;
    g2281=36.0*(-(g1761*t)-g1750);
    g2307=144.0*g2056*g1748-(72.0*g2056*g1749);
    g2373=72.0*g1724;
    g2252=g2373+g2307-g2281;
    g2253=256.0*g2175*g1791-(448.0*g2174*g1791)-(72.0*g1791*sw);
    g2254=18.0*(g2193*g1703+g2193*g2178*g1759)-(36.0*g2193*g1702);
    g2255=216.0*g1948*g1948*g1698+108.0*g2206*g1658-(36.0*g1943*g1650)+18.0*(
     g1943*g1652+g1943*g1648)+54.0*(-(g2206*g1659)-(g1944*g1657));
    g2256=176.0*g1892*g1664-(64.0*g1892*g1666);
    g2257=32.0*g1713*s-(88.0*g2165*g1718*s);
    g2303=5632.0*g2223*g1834-(2048.0*g2223*g1833);
    g2258=2.0*g2303-(10240.0*g1744)+3072.0*g1743;
    g2284=72.0*(-g1652-g1651);
    g2290=144.0*(g1650+g1649);
    g2302=72.0*(-g1648-g1647);
    g2259=g2302+g2290+g2284;
    g2294=1024.0*g2223*g1826-(2816.0*g2223*g1827);
    g2261=72.0*g1785-(5120.0*g1705)+1536.0*g1704-(2.0*g2294);
    g2260=4.0*g2261-(1664.0*g1723)-(4844.0*g1722)+2616.0*g1721+1644.0*g1679-(
     1656.0*g1678);
    g2262=2816.0*g2049*g2hzz-(1024.0*g2048*g2hzz);
    g2288=128.0*g1754+356.0*g1753-(168.0*g1752);
    g2265=-g2288-(36.0*g1770);
    g2308=176.0*g1891*g1718-(64.0*g1723*s);
    g2266=178.0*g1692-(84.0*g1691)-g2308;
    g2263=1.5*g2266+g2265+18.0*g1824-(9.0*g1662)-(108.0*g2171*g1669);
    g2267=72.0*(g2193*g1814+g1923)-(504.0*g1813*g1hzz);
    g2374=36.0*g1720;
    g2269=g2374-g2373-(3.0*g2307);
    g2277=288.0*(g2224*g1859+g1739);
    g2280=576.0*(-(g1822*t)-g1737);
    g2270=g2280+g2277+288.0*g1736;
    g2271=g2254+1.5*g2246+1122.0*g1715-(612.0*g1714)-(36.0*g1761)+27.0*g1742;
    g2272=72.0*g1842-g2261;
    g2273=-g2267-(72.0*g2154*g1769);
    g2368=2.0*g2258;
    g2275=g2368+72.0*g1816*g1712;
    g2291=18.0*g1703*s-(36.0*g1702*s);
    g2372=432.0*g1675;
    g2376=480.0*g1658;
    g2276=g2372-(16.0*g2291)-(848.0*g1659)-g2376;
    g2313=36.0*g1892*g1660-(72.0*g2190*g1668);
    g2278=g2313-(72.0*g2022*g1669)-(864.0*g1855*g1851);
    g2279=36.0*(g2032*g1729+g2033*g1729);
    g2283=5696.0*g1744-(2688.0*g1743)-g2303;
    g2329=89.0*g1679-(42.0*g1678);
    g2285=g2329+g2257;
    g2384=432.0*g1794;
    g2286=72.0*g1815+288.0*(g1789-g1844)-g2384;
    g2287=512.0*g1780*s-(1408.0*g1779*s);
    g2289=g2246+640.0*g1715-(192.0*g1714);
    g2292=4096.0*g1810+512.0*(-g1793-(g1787*t)-g1977);
    g2293=288.0*g1924*g1841-(72.0*g2161*g1893);
    g2305=-(3.81818*g2264-(6.0*g2304)-(1.2*g2274))-(15.2571*g2248);
    g2295=g2305-(504.0*g1728);
    g2296=g2384-(264.0*g1815)+1248.0*g1789;
    g2297=1424.0*g1699-(672.0*g1697);
    g2388=128.0*g1723;
    g2298=g2388+356.0*g1722-(168.0*g1721);
    g2299=4096.0*g1802+8192.0*(g2154*g1805*g3hzz+g1797*g3hzz)+512.0*(g1760-g1958
     );
    g2395=96.0*g1756;
    g2397=528.0*g1788;
    g2300=g2397+g2395;
    g2301=96.0*g1666-(264.0*g1664);
    g2306=2688.0*g1714-(8.0*g2246)-(5696.0*g1715);
    g2316=-(432.0*g1697)-(72.0*g1667);
    g2309=216.0*(-g1699-g1695)-g2316;
    g2334=54.0*g1659-(108.0*g1658);
    g2310=g2334+54.0*g1675;
    g2312=512.0*g1780-(1408.0*g1779);
    g2314=89.0*g1710-(42.0*g1709)+9.0*g1708;
    g2315=g2294+2848.0*g1705-(1344.0*g1704);
    g2352=-g2287-(1424.0*g1774);
    g2318=-g2352-(672.0*g1773);
    g2369=36.0*u;
    g2319=g2369+36.0*t;
    g2320=19328.0*g1796-(3840.0*g1795);
    g2392=72.0*g1719;
    g2321=648.0*g1698-g2392;
    g2402=216.0*g1708;
    g2325=144.0*(g1657+g1656);
    g2371=72.0*g1677;
    g2327=-g2371-(216.0*g1668);
    g2383=288.0*g1945;
    g2328=g2383+288.0*g1927;
    g2333=512.0*g1735-(1408.0*g1734);
    g2378=216.0*s;
    g2336=144.0*(-g1841-g1847);
    g2337=288.0*g1748-(144.0*g1749);
    g2363=g2001+g1999;
    g2353=g2288+2.0*g2266;
    g2360=3.55556*g1767+g2153*g1768-(9.77778*g2153*g1718)+9.88889*g1766-(4.66667
     *g1765);
    g2362=9.88889*g2193*g1722-(4.66667*g2193*g1721)-(9.77778*g2193*g1951)+
     3.55556*g2193*g1723;
    g2365=39.1111*g2319;
    g2366=5.33333*g2301;
    g2367=8.0*g2289;
    g2370=36.0*g1690;
    g2375=2848.0*g1783;
    g2377=216.0*g1733;
    g2379=512.0*s;
    g2380=896.0*s;
    g2381=1408.0*s;
    g2382=576.0*g1915;
    g2385=1152.0*g1728;
    g2386=96.0*g1756*u;
    g2387=144.0*g1736;
    g2389=672.0*g1822;
    g2390=128.0*g2180*g1757;
    g2391=144.0*g1815*sw;
    g2393=288.0*g1823;
    g2394=352.0*g1890*g1718;
    g2396=896.0*g1808;
    g2398=108.0*g1662;
    g2399=288.0*g1761;
    g2400=288.0*g1742;
    g2401=144.0*g1731;
    g2403=576.0*g1761;
    g2404=352.0*g1718;
    g2405=-(288.0*g1670);
    g2406=-(108.0*g1669);
    g2407=216.0*g1669;
    g2408=-(512.0*g3hzz);
    g2409=g1901*g1759;
    g2416=cw*cw*cw;
    g2179=g2416*g2416;
    {
        t0=128.0*g2409*g2409+672.0*(g1903*g1851-(g1907*g1782))+3.0*(g2316*g2220*
         t-(g2317*g1941*t))+2.0*(g2321*g2166*g2164+g2254*g2197*g2031)+(g2402+
         216.0*g1710-(432.0*g1709))*(2.0*g2155+g2166*g2009+1.5*(g2003*g2003+
         g2002*g2002))+(288.0*g1702-(144.0*g1703))*(g2006*g2006+g2005*g2005+2.0*
         g1936*u)+(g2285+18.0*g1946*g1670+9.0*g1708*s)*(g2208*t+g2204*u)+(2688.0
         *g1795-(1792.0*g1812)-(5696.0*g1796))*(g1890*s+g1891*u-(2.0*g2168*s))+(
         288.0*g1907-(144.0*g1908))*(g1660*g1hzz-(2.0*g2202*g1712))+576.0*(-
         g1919-g1918)*(14.2222*g1780*g2hzz-(39.1111*g1779*g2hzz)+35.5556*g1778*
         g2hzz-(10.6667*g1777*g2hzz)+g1976)+4096.0*(g1927-g3hzz)*(g1688*g2hzz-(
         2.75*g1686*g2hzz))+288.0*(g1955-g1861)*(g1729*t+g1729*u);
        t0=t0+(g2378+216.0*t)*(g1962*g1733+3.25926*g1931)+256.0*g2363*(1.67188*
         g1892*g1659-(1.21875*g1892*g1658)-(g2175*g1733)+1.75*g2174*g1733-(
         1.59375*g2195*g1733))+(672.0*g1777-g2312-(1424.0*g1778))*(g2005*t-(7.0*
         g2166*g3hzz)+g2034+2.0*(-(g2193*g1986)-(g2193*g2036)))+2048.0*(-g2006-
         g2005)*(g1982*g1826-(2.75*g1982*g1827))+g2309*(4.0*g2017*g3hzz+g2166*
         g1892)+g2334*(2.0*g2031*g1892+4.0*(g2032*g3hzz+g2033*g3hzz))+(144.0*
         g1733-(288.0*g1732))*(g2193*sw-(g2075*s))+(108.0*g1733-(144.0*g1732))*(
         g2208*sw+g2204*sw-(g2025*t)-(g2063*u))+(2048.0*g1764-(512.0*g1772))*(
         g2173*s-(2.75*g2157*s))+g2318*2.0*(g2208*g2hzz+g2204*g2hzz)+(-(2048.0*s
         )-(6144.0*t))*(g2173*g1784-(2.75*g2157*g1784));
        t0=t0+g2319*(g2362+g2360+56.8889*g2175*g1789-(99.5556*g2174*g1789)+
         28.4444*g2175*g1844+127.111*g1865+4.0*(g2200*g1825-(g2221*g1675)))+(
         256.0*g1794-(2048.0*g1789))*(g2175*s-(1.75*g2174*s))+(g2378+108.0*t)*(
         4.74074*g2173*g1799-(13.037*g2157*g1799)+g1758)+g2315*(g2058+g2057)+(
         g2325-(576.0*g1696))*(1.5*g2035*g1hzz-(g1906*g3hzz))+(g2291-g2310)*(
         g2208*g2093+g2204*g2099)+g2363*(2.0*g2265-(72.0*g1825)-g2283)+(1024.0*
         g1799+8192.0*g1764-(256.0*g1676))*(g2212*g1969-(2.75*g1969))+(g2272-(
         6.0*g2257))*(g2204*g2178+g1837)+(g2376-(784.0*g1659))*(g2221*t+g2221*u)
         +(128.0*s-(3.55556*g2319))*(4.0*g2217*g1826+g1771);
        t0=t0+s*(g2391-g2293+g2262+g2253-(2848.0*g1920)+684.0*g1870-(396.0*g1875
         )+704.0*g1932+2816.0*g1927*g1804)+sw*(g2273-(288.0*g1793)+144.0*g1911-(
         576.0*g1810)+432.0*g1977-g2279)+t*(g2390+g2249+3.0*g2245-(2848.0*g2045)
         )+u*(g2256+3.0*g2255)+g3hzz*(512.0*g2048-(1408.0*g2049)+g2405*g1917)+
         g1676*(192.0*g2059-(528.0*g2060))+g1725*(14.6667*g2319+384.0*s)+g1726*(
         -(37.5556*g2319)-(1280.0*s))+g1727*(-g2379-(14.2222*g2319))+g1730*288.0
         *(g1788-g1904)+g1741*(576.0*g2224-(1152.0*g2211))+g1781*(5184.0*g2036-(
         1344.0*g3hzz))+g1800*144.0*(-g1660-g1898)+g1806*(g2380-(24.8889*g2319))
         +g1813*(-(4096.0*g1910)-(576.0*g2hzz*sw))+g2217*g1827*(g2365-g2381)+
         g1839*(576.0*g1764-(720.0*g1772));
        t0=t0+g1843*(144.0*g1712*sw+576.0*g1905*u)+g1855*432.0*(g1845-(g1816*
         g1hzz))+g1861*(-(1008.0*g1809)-(576.0*g1807)-(288.0*g1953*g1861))+g1862
         *(144.0*g1825-(704.0*g1952*g1862))+g1864*(g2381+g2365)+g1889*(1824.0*
         g1772-(1344.0*g1799))+g1890*(g2370+g2300+1056.0*g1792*g2hzz)+g1891*(-
         g2395-g2389)+g1892*(g2374+g2304-g2274+g2264+g2252-g2248+396.0*g1728)+
         g1893*(36.0*(g1891-g1890)-(72.0*g1730))+g1908*(1424.0*g1782+g2383*g1741
         )+g2236*g2195*(256.0*g1769+g2408*g1848-(3.55556*g2336))+g1918*(g2260+
         12.0*g2257-(288.0*g1842))+g2260*g1919+g1925*(g2404*g1925-g2386)+g2337*
         g2155*g1941+g2208*u*(g2298+3.0*g2285-(352.0*g1951))+g1934*(576.0*g1848*
         sw-(2112.0*g1792))+g1936*(g2297+g2276)+g1941*(g2295+2.0*g2281);
        t0=t0+g1944*(2.75*g2302+3.75*g2290+9.41667*g2284)+g1947*(3.0*g2309+720.0
         *g1747)+g1948*(792.0*(g1790+g1791)-(528.0*g1815))+g1949*(g2320+7168.0*
         g1812)+g2320*g1950+g1959*(g2407*g1959-g2371)+g2200*g2166*(2.0*g2270+
         576.0*(g1842-g1785))+g1962*(g2286-(72.0*g1850*g1712))+g1964*(16.0*g2310
         -(288.0*g1696))+g2212*g2161*(g2393-g2321)+g1966*(g2380+12.4444*g2319)+
         g1967*(-g2379-(7.11111*g2319))+g1975*(-(216.0*g1690)-(576.0*g1756)-(
         1728.0*g1788))+g2200*g1950*(20480.0*g1763-(6144.0*g1762)-(704.0*g1718))
         +g1982*(1536.0*g1781-(1024.0*g1927*g1833)+1344.0*g1803*t+g2403*g1982)+
         g2217*g2161*(4.0*g2337-(576.0*g1759))+g1986*(5184.0*g1781+g2400*g1986)+
         g2208*g1742*288.0*(g2023+g2223);
        t0=t0+g2217*g2178*(-g2333-(288.0*g1667))+g2178*g2009*(76.0*g1722-(696.0*
         g1721)-(500.0*g1679)+456.0*g1678-g2388-(4.0*g2257))-(g2258*g2000)+g2002
         *(g2398+g2275)+g2003*(g2398+g2368-(15648.0*g1783*g2hzz))+g2005*(g2352+
         g2372*g1940)+g2006*(1424.0*g1783-g2318)+g2197*g2154*(1.125*g2325-(684.0
         *g1696))+g2009*(4.0*g2308-(856.0*g1692)+624.0*g1691)-(g2285*g2208*g2190
         )-(g2257*g2204*g2190)+g2016*(g2375+1152.0*g1742*g2hzz+576.0*g2016*g1670
         )+g2017*(g2403*g2hzz-(1848.0*g1811)-(33792.0*g1804)-(144.0*g2017*g1670)
         )+g2018*(g2286-(72.0*g1790)+432.0*g1787+g2406*g2018)+g2019*(g2407*g2019
         -g2371)+g2022*(g2394+g2353)+g2025*(g2296+264.0*g1790-(48.0*g1787)-(
         g2377*u))+5.33333*g2310*g2034*g1hzz;
        t0=t0+g2031*(g2266-(144.0*g1978)+36.0*g1824-(2.0*g2288))+g2204*g2023*(
         g2400+g2367)+g2367*g2208*g2023+g2306*g2193*g2023+g2154*g1792*(1056.0*
         g1986+672.0*g1915)+g2336*g2154*sw+g2056*(-(576.0*g1822)-(648.0*g1708))+
         g2153*g1hzz*(256.0*g1852+264.0*g1816)+g2296*g2063+g2166*g2hzz*(31296.0*
         g1783-(4.0*g2287)-(2496.0*g1811)-(10368.0*g1803)-(3968.0*g1774)-(768.0*
         g1773))+g2175*g3hzz*(-(512.0*g1809)-(3072.0*g1807))+g2180*t*(1728.0*
         g1772+144.0*g1677-(128.0*g1758)-(672.0*g1799))+g2075*(264.0*g1791-(
         2112.0*g1789))+g2154*u*(g2397+g2370)+g2161*g2hzz*(16.0*g2312+20480.0*
         g1778-(6144.0*g1777))+g2171*g1772*(-(2000.0*s)-(864.0*t))+g2153*s*(
         5696.0*g1763-(2688.0*g1762))+g2353*g2190*t;
        t0=t0+g1982*g2hzz*(16.0*g2281+576.0*g1728-(2.66667*g2305))+g2093*(g2269+
         4.0*g2268+1532.0*g1684-(888.0*g1682)-(72.0*g1750)+252.0*g1680)+g2166*s*
         (2.0*g2315-g2270)+g2217*u*(g2333+g2276)+g2099*(g2269-(684.0*g1728))+
         g2298*g2204*t+g2036*g2hzz*(32.0*g2268+10240.0*g1684-(3072.0*g1682))+
         g2180*u*(-(2.0*g2327)-(252.0*g1676))+g2171*u*(g2327+534.0*g1676)+g2107*
         g1927*(g2372-g2297+1712.0*g1659-(1248.0*g1658))+g2106*(4.0*g2252-(144.0
         *g1720)+288.0*g1919*g1670-(2.0*g2295))+g2107*(g2375-(11264.0*g1804))+
         g2031*g1941*(1080.0*g1658-(1356.0*g1659))+g2022*t*(-(2.0*g2329)-g2298)+
         g2005*g1658*(-(1248.0*g1940)-(864.0*g1927))+g2005*g1659*(1712.0*g1940+
         432.0*g1927)+g2001*sw*(g2377+144.0*g1786);
        t0=t0+g2000*t*(g2387+144.0*g1739-(288.0*g1737))+g1742*g3hzz*(-g2382-(
         576.0*g1986)-(144.0*g1945))+g1982*g3hzz*(8.0*g2250-(576.0*g1731)-(2.0*
         g2306))+g1945*g3hzz*(-g2401-g2366)+g1720*g2hzz*(g2328-g2382)+g1724*
         g2hzz*(-g2328-(1152.0*g3hzz))+g1731*u*(18.0*g1941-(36.0*g1892))+g1940*
         g3hzz*(g2399+g2247-(4.0*g2246)-(3136.0*g1715)+1920.0*g1714-g2401)+g1940
         *g2hzz*(g2385+8.0*g2281-(4.8*g2274)+6.54545*g2264+6.17143*g2248)+g1682*
         g2hzz*(1920.0*g3hzz-(3072.0*g1927))+g1684*g2hzz*(10240.0*g1927-(9664.0*
         g3hzz))+g1925*u*(g2396-g2397)+g1915*g3hzz*(g2366+432.0*g1661)+g2259*
         g1906*g1hzz+g1892*s*(g2317-(18.0*g1661))+sw*s*(576.0*g1789+864.0*g1787-
         (360.0*g1794));
        t0=t0+g2150*(3.2*g2274-(9664.0*g1685)+1920.0*g1683-g2385-(32.0*g2282))+
         g2154*(g2386-(1.16667*g2280)-(4.94444*g2277)-(36.0*g1858)-(528.0*g1785)
         +144.0*(g1842-g1829)+672.0*g1933*g1711-g2387)-(2.75*g2299*g2157)+g2161*
         (4.0*g2272-(8.0*g2257)+576.0*g1976+1792.0*g1723+5200.0*g1722-(2784.0*
         g1721)-(1288.0*g1679)+1488.0*g1678-(144.0*g1862*g1845))+g2166*(1536.0*
         g1754+4128.0*g1753-(1728.0*g1752)-(144.0*g1857*g1769)-(2.0*g2275)-(28.0
         *g2266)-(180.0*g1662))+g2165*(-(252.0*g1825)-(864.0*g1978))+g2168*(
         g2396-g2389-g2300+128.0*g1828+36.0*g1893+144.0*g1904-(4224.0*g1952)-(
         2048.0*g1910*g1848)+g2408*g1852)+g2171*(10816.0*g1802+272.0*g1760-(
         g2371*t)-g2278-(1424.0*g1958))+g2173*(g2299+12288.0*g1914*g1805);
        t0=t0+g2174*(1.75*g2292+6.22222*g2273)+g2175*(3.55556*g2267-(512.0*g1911
         )-g2292)+g2178*(g2391-g2390+6.0*g2262-(2.0*g2256)+768.0*g1771-(512.0*
         g1967)+896.0*g1966+5376.0*g1806-(5120.0*g2045)-(15648.0*g1920)+256.0*
         g1767+640.0*g1766-(192.0*g1765)+3.0*(g2253+g2249)+g2395*g1925-(216.0*
         g1790*sw)+g2405*g1936)+g2180*(2.0*g2278-(4224.0*g1802)+1632.0*g1760)+
         g2237*g1957*(264.0*g1769-(448.0*g2237*g1853))+g2190*(704.0*g1864-(568.0
         *g1726)+48.0*g1725+108.0*g1875+352.0*(g1865-g1932-g1931)+36.0*(g2362-
         g2360)-g2255-g2245-(216.0*g1870)-(256.0*g1727))+g2209*g1698*(432.0*
         g2190-(648.0*g1867))+g2193*(g2283-(72.0*g1770)+264.0*g1811*g1hzz)+g2195
         *(g2279+264.0*g1923-(2496.0*g1810)-(48.0*g1977));
        t0=t0+g2199*(1344.0*g1934*g1711+864.0*g1855*g1800)+g2200*(2.0*g2293+
         144.0*(g1917*g1792+g1924*g1769))+g2209*g1867*(g2393+g2392)+g2202*576.0*
         (-(g1905*g1849*mw)-(g1906*g1711))+g2204*(g2263+27.0*g1839*g1698-g2394)+
         g2206*(g2271+27.0*g2047+g2369*g1747)+g1916*g1916*(g2396-g2395+624.0*
         g1788+552.0*g1792*g1hzz-(4928.0*g1916*g1718))+g2263*g2208+g2212*(576.0*
         g1802-(1008.0*g1760)-g2313)+g2217*(g2250-g2247+12.0*g2246-(576.0*g1985)
         -(1408.0*g1834)+1424.0*g1840+7104.0*g1715-(1152.0*g1714)+144.0*g1742-
         g2401-g2259-(16.0*g2254))+g2220*(g2399+4.0*g2301+684.0*g2047+648.0*
         g1661)+g2221*(g2289+54.0*g1661-(2.0*g2317))+g2222*(g2301+g2271+36.0*
         g1731)+g1999*g1999*(g2314+32.0*g1713)+g2314*g2001*g2001;
        msq3=(t0+g1712*g1712*(32.0*g1896-(88.0*g1895))+g2000*g2000*(g2402+256.0*
         g1713+856.0*g1710-(624.0*g1709))+1424.0*g2226*g1963*g1823-(88.0*g1902*
         g1711*g1711)+g2404*g1997*g1997+g2406*g2227-(528.0*g1914*g1792)-(72.0*
         g2153*g1845)+g2386*g2152)/(g2179*g2154*(1728.0*g1839*g1839-(3456.0*
         g2200*g1889))+1728.0*g2179*g1903);
    }
}

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
   return 1.0/x1/x2*LHAPDF::xfx(x1,smpar.mh,0)*LHAPDF::xfx(x2,smpar.mh,0)/x1/smpar.s*pow(M_PI,2)/8.0/smpar.mh*Gamma*(1-pow(smpar.mh,2)/smpar.s)/2.57e3*1e12;
};
