#include <LHAPDF/LHAPDF.h>

#include "CrossSection_had.h"

/* Initialisierung zur Berechnung der Standardmodell-Wirkungsquerschnitte */

void init_hadronic_cs_( sminputs * smpar )
{
  effinputs temp;

  temp.fbb = 0; temp.fww = 0; temp.fgg = 0; temp.fb = 0; temp.fw = 0; 
  temp.fuph = 0; temp.fdoh = 0; temp.fchh = 0; temp.fsth = 0; temp.fboh = 0; temp.ftoh = 0; temp.felh = 0; temp.fmuh = 0; temp.ftah = 0;
 
  HWRadiation_( smpar, &temp, &pp_wh_sm, &err_wh_sm, &chi_wh_sm );
  HZRadiation_( smpar, &temp, &pp_zh_sm, &err_zh_sm, &chi_zh_sm );
  Gluonfusion_( smpar, &temp, &ggh_sm, &err_ggh_sm, &chi_ggh_sm );
  std::cout<<"pp->wh = "<<pp_wh_sm<<" pp->zh = "<<pp_zh_sm<<" gg->h = "<<ggh_sm<<std::endl;
};

/* Berechnung der Ratios */

void ratio_tth_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  *ratio = pow(1.0 - pow(smpar->vev,3)/sqrt(2)/smpar->mto*effpar->ftoh, 2);
  *err   = 0;
  *chisq = 1;
};

void ratio_bg_bh_(sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq )
{
  *ratio = pow(1-pow(smpar->vev,3)/sqrt(2)/smpar->mbo*effpar->fboh,2);
  *err   = 0;
  *chisq = 1;
};

void ratio_bb_h_( sminputs * smpar, effinputs * effpar, double * ratio, double * err, double * chisq ) 
{
  /* Ratio given through modified Yukawa-Coupling! */
  *ratio = pow(1.0 - pow(smpar->vev,3)/sqrt(2)/smpar->mbo*effpar->fboh, 2);
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
     while( fabs( gsl_monte_vegas_chisq( s )) > 0.5 && k < CSstep );
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
      /*
      double par[] = { smpar->mh, smpar->mz, mq[j], mq[i], sqrt( smpar->alphae*4*M_PI ), smpar->sw, smpar->s, vckm, effpar->g1hww, 
		       effpar->g2hww, effpar->g3hww, effpar->g1hzz, effpar->g2hzz, effpar->g3hzz, effpar->g1hzy, effpar->g2hzy, effpar->ghyy, (double)i, -(double)j };
      */
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
  
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;
  
  double g2360,g2361,g2321,g2363,g2303,g2301,g2354,g2371,g2302,g2364,g2326,g2312,g2368,g2304,g2310,g2305,g2322,g2306,g2324,g2351,g2307,g2308,g2325,g2311,g2309,g2366,
       g2313,g2355,g2362,g2332,g2315,g2333,g2316,g2318,g2317,g2328,g2319,g2320,g2353,g2329,g2334,g2369,g2367,g2359,g2358,g2347,g2376,g2379,g2377,g2389,g2378,g2380,g2383,
       g2381,g2382,g2384,g2388,msq1;
 {
    double t0 = 0;
    g2360=mq*mq;
    g2361=mz*mz;
    g2321=g2361*g2360;
    g2363=ee*ee;
    g2303=g2363*g2321;
    g2301=g2303*s;
    g2354=g2363*g2361;
    g2371=g2hzy*g2hzy;
    g2302=g2371*g2354;
    g2364=g1hzy*g1hzy;
    g2326=g2364*g2363;
    g2312=g2361*g2326;
    g2368=s*s;
    g2304=g2368*g2312;
    g2310=g2326*u;
    g2305=g2310*s;
    g2322=g2326*s;
    g2306=g2322*t;
    g2324=g2361*g2354;
    g2351=g2324*g2hzy;
    g2307=g2351*g2hzy;
    g2308=g2312*s;
    g2325=g2363*g2360;
    g2311=g2364*g2325;
    g2309=g2311*s;
    g2366=mh*mh;
    g2313=g2366*g2322;
    g2355=g2361*g2361;
    g2362=g2361*g2355;
    g2332=u*g1hzy;
    g2315=g2332*s;
    g2333=t*g1hzy;
    g2316=g2333*s;
    g2318=g2360*g1hzy;
    g2317=g2318*s;
    g2328=g2hzy*g1hzy;
    g2319=g2354*g2328;
    g2320=g2368*g2328;
    g2353=g2361*s;
    g2329=g2360*g2310;
    g2334=g2364*g2303;
    g2369=u*u;
    g2367=t*s;
    g2359=g2360*g2360;
    g2358=g2360*s;
    g2347=g2305*t;
    g2376=g2306-g2313;
    g2379=16.0*(g2328*g2303+g2360*g2302);
    g2377=g2379-(6.0*g2309)-(3.0*g2308);
    g2389=4.0*g2305;
    g2378=g2389+4.0*g2306;
    g2380=64.0*g2362*g2325+16.0*g2353*g2324;
    g2383=8.0*(-g2319-g2302);
    g2381=16.0*g2312-(8.0*g2383);
    g2382=16.0*(-(g2301*t)-(g2301*u));
    g2384=16.0*(-(g2307*t)-(g2307*u));
    g2388=8.0*g2364*g2301;
    {
        t0=4.0*(-t-u)*(16.0*g2351*g2318-(4.0*g2368*g2319)+g2304-g2388)+g2383*(
         8.0*g2359*u-(g2367*t)-(g2369*s))+g2378*(g2366*g2360+g2366*g2361)+g2384*
         s+g2303*(4.0*(g2332*g2332+g2333*g2333)-(32.0*g2320))+g2324*(32.0*g2318*
         g2318-(16.0*g2320))+g2328*(g2380+128.0*g2321*g2303-g2382)-(g2381*g2359*
         t)+g2360*g2358*(16.0*g2302-(48.0*g2319))+g2367*s*(6.0*g2310-(8.0*g2311)
         )+g2351*(16.0*(-g2316-g2315)-(32.0*g2317))+u*t*(2.0*g2379+8.0*g2334)+
         g2355*(g2389+4.0*g2376-(40.0*g2309)+16.0*(-g2329-(g2311*t)))+g2360*
         g2359*(g2381-(8.0*g2322))+g2359*(3.0*g2378+128.0*g2307-(4.0*g2313)-(
         48.0*g2308))+g2360*(4.0*g2384-(12.0*g2347)-(16.0*g2321*g2310))+g2363*(
         g2315*g2315+g2316*g2316+8.0*g2317*g2317);
        msq1=(t0+g2366*(4.0*g2304-(2.0*g2347)-g2388)+g2368*(24.0*g2334-(8.0*
         g2329)+16.0*g2307)+g2369*(g2377-g2313+3.0*g2306+g2322*u)+g2371*(g2382+
         g2380)+t*t*(g2377+g2376+3.0*g2305)+32.0*g2358*g2307-(10.0*g2361*g2347)+
         16.0*g2362*g2311)/(216.0*g2353*s);
    };
};

double g2537,g2635,g2478,g2625,g2435,g2638,g2623,g2628,g2512,g2511,g2499,g2480,g2470,g2636,g2637,g2469,g2479,g2443,g2486,g2474,g2468,g2465,g2447,g2432,g2449,g2631,
       g2414,g2458,g2445,g2627,g2532,g2415,g2483,g2476,g2467,g2482,g2418,g2419,g2536,g2597,g2606,g2466,g2503,g2428,g2618,g2472,g2460,g2425,g2624,g2551,g2473,g2431,
       g2429,g2553,g2430,g2433,g2507,g2471,g2552,g2434,g2436,g2634,g2550,g2437,g2498,g2481,g2450,g2438,g2453,g2439,g2440,g2484,g2441,g2477,g2462,g2442,g2615,g2444,
       g2446,g2448,g2451,g2455,g2454,g2608,g2456,g2517,g2457,g2519,g2527,g2459,g2461,g2475,g2463,g2464,g2496,g2549,g2488,g2578,g2489,g2497,g2546,g2545,g2502,g2513,
       g2514,g2587,g2518,g2521,g2613,g2544,g2543,g2542,g2526,g2540,g2529,g2539,g2531,g2538,g2556,g2580,g2581,g2562,g2564,g2567,g2569,g2585,g2591,g2590,g2633,g2645,
       g2661,g2646,g2647,g2648,g2664,g2649,g2656,g2671,g2650,g2651,g2652,g2653,g2654,g2655,g2658,g2659,g2660,g2662,g2685,g2672,g2666,g2668,g2690,g2670,g2674,g2679,
       g2687,g2688,g2684,g2686,g2689,g2691,g2692,g2693,g2694,g2695,msq2;
    {
    double t0 = 0;
    g2537=s*g1hzy;
    g2635=ee*ee;
    g2478=g2635*g2537;
    g2625=mz*mz;
    g2435=g2625*g2478;
    g2638=sw*sw;
    g2623=g2638*sw;
    g2628=mq*mq;
    g2512=g2628*g2623;
    g2511=g2638*g2512;
    g2499=g2625*g2hzy;
    g2480=g2635*g2499;
    g2470=g2480*g2hzz;
    g2636=u*u;
    g2637=t*t;
    g2469=g2480*g1hzz;
    g2479=g2635*g2623;
    g2443=g2479*g2hzy;
    g2486=g2625*g1hzz;
    g2474=g2638*g2479;
    g2468=g2474*g1hzz;
    g2465=g2479*g1hzy;
    g2447=g2474*g2hzz*g1hzy;
    g2432=g2465*g1hzz;
    g2449=g2468*g1hzy;
    g2631=s*s;
    g2414=g2631*g2432;
    g2458=g2635*g2631;
    g2445=g2458*g1hzy;
    g2627=g2638*g2623;
    g2532=g2627*g1hzz;
    g2415=g2532*g2445;
    g2483=g2628*g2443;
    g2476=g2635*g2628;
    g2467=g2476*g2hzy;
    g2482=g2627*g2hzz;
    g2418=g2432*u;
    g2419=g2449*u;
    g2536=g1hzz*s;
    g2597=g2536*t;
    g2606=t*s;
    g2466=g2476*g1hzy;
    g2503=g2625*sw;
    g2428=g2503*g2466;
    g2618=g2628*g2628;
    g2472=g2635*g2618;
    g2460=g2472*g2hzz*g2hzy;
    g2425=g2469*sw;
    g2624=g2625*g2625;
    g2551=g2624*g2hzy;
    g2473=g2624*g2476;
    g2431=g2473*g2hzz;
    g2429=g2431*u;
    g2553=g2624*g2hzz;
    g2430=g2553*g2465;
    g2433=g2473*g1hzz;
    g2507=g2628*g2625;
    g2471=g2628*g2507;
    g2552=g2471*t;
    g2434=g2635*g2552;
    g2436=g2445*sw;
    g2634=mh*mh;
    g2550=g2634*g1hzz;
    g2437=g2550*g2478;
    g2498=g2635*mw*ee;
    g2481=g2628*g2498;
    g2450=g2481*g2hzy;
    g2438=g2625*g2450;
    g2453=g2481*g1hzy;
    g2439=g2453*u;
    g2440=g2453*t;
    g2484=g2498*s;
    g2441=g2625*g2484;
    g2477=g2628*g2471;
    g2462=g2635*g2477;
    g2442=g2462*g2hzz;
    g2615=g2625*g2624;
    g2444=g2615*g2467;
    g2446=g2615*g2466;
    g2448=g2624*g2472*g1hzz;
    g2451=g2498*g2471;
    g2455=g2631*g2625;
    g2454=g2470*sw;
    g2608=sw*g1hzy;
    g2456=g2608*g2472;
    g2517=g1hzz*sw;
    g2457=g2517*g2478;
    g2519=g2635*g2hzy;
    g2527=g2hzz*s;
    g2459=g2527*g2519;
    g2461=g2478*g2hzz;
    g2475=g2624*s;
    g2463=g2498*g2475;
    g2464=g2484*g1hzy;
    g2496=g2628*g1hzy;
    g2549=g2618*g1hzz;
    g2488=g2628*t;
    g2578=g2628*s;
    g2489=g2628*g2578;
    g2497=g2634*g2625;
    g2546=g2419*s;
    g2545=g2418*s;
    g2502=g2628*sw;
    g2513=g2628*g2432;
    g2514=g2631*g2425;
    g2587=g2hzz*sw;
    g2518=g2587*g2hzy;
    g2521=g2517*g2435;
    g2613=u*t;
    g2544=g2624*u;
    g2543=t*sw;
    g2542=g2625*u;
    g2526=u*s;
    g2540=g2638*g2hzy;
    g2529=g2625*t;
    g2539=g1hzz*u;
    g2531=g2587*g2435;
    g2538=g2627*g1hzy;
    g2556=g2457*u;
    g2580=g2636*s;
    g2581=g2637*s;
    g2562=g2442*g2hzy;
    g2564=g2437*sw;
    g2567=g2430*s;
    g2569=g2428*g2hzz;
    g2585=g2623*s;
    g2591=g2433*sw;
    g2590=s*sw;
    g2633=g2521*t;
    g2645=14.0*g2634*g2545-(8.0*g2634*g2546);
    g2661=28.0*g2414-(16.0*g2415);
    g2646=-(2.0*g2661)-(12.0*g2564);
    g2647=24.0*g2415*u-(42.0*g2414*u);
    g2648=56.0*g2625*g2465*g2hzz-(32.0*g2625*g2447);
    g2664=56.0*g2486*g2443-(32.0*g2499*g2468);
    g2649=2.0*g2664-(48.0*g2425);
    g2656=7.0*g2637*g2432-(4.0*g2637*g2449);
    g2671=7.0*g2636*g2432-(4.0*g2636*g2449);
    g2650=g2671+g2656;
    g2651=28.0*g2625*g2545-(12.0*g2521*u)-(16.0*g2625*g2546);
    g2652=-(96.0*g2425*u)-(192.0*g2454*u)-(448.0*g2430);
    g2653=384.0*g2562+192.0*(g2446*g2hzz-(g2429*g1hzy));
    g2654=224.0*g2618*g2443*g2hzz-(128.0*g2627*g2460);
    g2655=48.0*g2453+96.0*g2450;
    g2658=48.0*(-(g2637*g2470)-(g2636*g2470))+24.0*(-(g2637*g2469)-(g2636*g2469)
     );
    g2659=3.0*g2564-(48.0*g2569)-(24.0*g2531);
    g2660=84.0*g2418-(48.0*g2419);
    g2662=-(4.0*g2649)-(8.0*g2648);
    g2685=2.0*g2648;
    g2672=24.0*(t+u);
    g2666=224.0*g2483*g2hzz-(128.0*g2482*g2467);
    g2668=32.0*g2551*g2474-(56.0*g2624*g2443);
    g2690=24.0*g2436;
    g2670=48.0*g2496*g2441+12.0*(g2613*g2464+g2498*g2455*g1hzy);
    g2674=168.0*g2549*g2435-(96.0*g2615*g2459);
    g2679=-(48.0*g2446)-(96.0*g2444);
    g2687=48.0*g2461;
    g2688=192.0*g2431;
    g2684=4.0*g2654;
    g2686=96.0*g2454;
    g2689=48.0*g2428;
    g2691=48.0*g2436;
    g2692=16.0*g2627*g2437;
    g2693=112.0*g2430;
    g2694=9.0*g2556;
    g2695=96.0*g2569;
    {
        t0=g2670+384.0*(g2518*g2434-(g2587*g2444))+1.33333*(g2679*g2532-(g2670*
         g2638))+(12.0*(g2440+g2439)+16.0*(-(g2638*g2440)-(g2638*g2439)))*(2.0*
         g2625-s)+(56.0*g2512*g2435-(24.0*g2428*s)-(32.0*g2511*g2435))*(2.0*(
         g2hzz*t+g2hzz*u)+4.0*(g1hzz*t+g2539)-g2550)+g2672*(g2441*g2hzy+2.66667*
         g2475*g2447-(1.33333*g2540*g2441)+g2519*g2517*g2475-g2514)+(256.0*g2429
         -(192.0*g2448))*(1.5*g2hzy*sw+g2538)+(g2690+6.0*g2668)*(g2488*g1hzz+
         g2628*g2539)+4.0*(g2664+g2648)*(g2488*u-(2.0*g2618*u))+g2668*(2.0*g2628
         *g2536+4.0*(g2526*g2hzz+g2527*t-(g2631*g2hzz)))+g2666*(2.0*g2529*u-(
         g2625*g2526)+4.0*(-(g2624*t)-g2544)-(g2529*s))+(g2688+72.0*g2433)*(
         g2543*g1hzy+2.0*g2543*g2hzy+1.33333*g2538*t);
        t0=t0+g2658*(g2590+1.33333*g2638*g2585-(2.33333*g2585)-(4.66667*g2512)+
         2.66667*g2511)+(48.0*g1hzy+96.0*g2hzy)*(1.5*g2591*u-g2451)+(g2685+g2664
         )*(g2631*t+g2631*u-(2.0*g2578*s))+g2648*(g2581+g2580)+g2650*(-(g2634*s)
         -(6.0*g2578))+(28.0*g2597*g2479-(16.0*g2606*g2468))*(3.0*g2618*g1hzy-(
         2.0*g2551)+g2634*g2496+g2497*g1hzy)+(-(24.0*g2428)-(3.0*g2436))*(g2637*
         g1hzz+g2636*g1hzz)+(48.0*s-(2.0*g2672))*(1.33333*g2638*g2438-g2438)+(
         4.0*g2449-(7.0*g2432))*(8.0*g2628*g2489-(g2581*t)-(g2580*u)-(32.0*g2477
         ))+g2660*(1.33333*g2625*g2488-(2.0*g2625*g2507))+(g2687+96.0*g2459)*(
         g2624*g2543+g2544*sw)+(g2685+18.0*g2457)*(g2637*g2628+g2636*g2628)+sw*(
         g2674-g2653);
        t0=t0+t*(3.0*g2633-(1.5*g2651)-g2647-g2645-(112.0*g2567))+g2456*(96.0*
         g2486*u-(36.0*g2597))+g2463*(-(12.0*g1hzy)-(48.0*g2hzy))+g2471*(-(
         2.66667*g2660)-(392.0*g2432*s))+g2475*(2.0*g2666-(224.0*g2513))+g2488*(
         g2652+g2646+48.0*g2546-(84.0*g2545)+36.0*g2556+g2686*s)+g2489*(g2660-
         g2649-(6.0*g2648)-g2686)+g2661*g2497+g2502*(2.0*g2658-(16.0*g2502*g2464
         ))+g2507*(4.0*g2661+8.0*g2650)+g2517*(g2679-(96.0*g2462*g1hzy))+g2542*
         g2hzz*(192.0*g2456-g2691)+g2526*(3.0*g2656-g2693)+g2529*(-g2684-(g2691*
         g2hzz))+g2627*g2537*128.0*(g2433+g2431)+g2537*96.0*(g2591+g2431*sw)+
         g2540*(128.0*g2451+64.0*g2463)-(g2684*g2542)+g2634*g2432*28.0*(-g2489-
         g2475)+g2549*(-g2690-(12.0*g2668));
        t0=t0+g2553*(g2691-(384.0*g2456))+g2638*g1hzy*(64.0*g2451+16.0*g2463)+
         g2624*sw*(12.0*g2437-(768.0*g2460))+g2662*g2618*t+g2625*s*(g2654-g2650)
         +g2590*g2hzy*(48.0*g2433-g2688)+g2434*g1hzy*(128.0*g2532+96.0*g2517+
         192.0*g2587)+g2437*u*(6.0*g2543-(12.0*g2502))+g2539*t*(-g2689-(18.0*
         g2436))+g2526*g1hzz*(g2668-(36.0*g2456))+3.0*g2671*g2606+g2608*(-(144.0
         *g2448)-(192.0*g2442))+g2613*(-g2695-g2694)+g2615*(4.0*g2666+112.0*
         g2513+224.0*(g2483*g1hzz+g2527*g2443)-(64.0*g2447*s)-(g2687*sw))+g2628*
         g2618*(24.0*g2457-g2662)+g2618*(g2692-(2.0*g2652)-g2646+12.0*g2464+
         144.0*g2531)+2.33333*g2653*g2623+g2624*(g2692-g2655+8.0*g2654-(168.0*
         g2488*g2432)+64.0*g2482*g2445-(96.0*g2518*g2458));
        msq2=(t0+g2627*(1.33333*g2674-(512.0*g2562))+g2628*(1.33333*g2647+2.0*
         g2645-(224.0*g2567)+48.0*g2514+g2686*g2526)+g2631*(g2695-g2693+g2650-(
         g2689*g1hzz))+g2634*(g2651+12.0*(-g2633-(g2486*g2436)))+g2636*(g2659+
         3.0*(g2521-g2556))+g2637*(g2659-(3.0*g2457*t)-g2694)+g2503*g2503*(
         1.33333*g2655+112.0*g2503*g2461)+g2507*g2507*(336.0*g2432-(512.0*g2447)
         )-(256.0*g2482*g2446)-(224.0*g2552*g2432))/(g2638*cw*cw*cw*432.0*(g2475
         -g2455));
    };
};
double g2863,g3091,g3111,g2787,g3084,g2761,g3083,g2705,g2702,g3086,g2885,g2795,g3112,g3090,g3085,g2937,g2706,g2703,g2938,g2930,g3078,g2707,g2704,g3074,g2768,g3109,
       g2708,g3108,g2709,g2879,g2852,g2769,g2710,g2711,g3082,g3076,g2880,g2851,g2770,g2712,g2713,g2742,g2714,g2744,g2715,g2745,g2716,g2871,g2878,g2839,g3107,g2746,
       g2717,g3073,g2728,g2962,g3041,g3042,g3075,g3069,g2721,g3080,g2722,g2723,g2724,g2725,g2881,g2850,g3119,g2759,g2882,g2849,g2760,g2810,g3068,g2874,g2729,g2730,
       g2864,g2799,g2753,g2731,g2732,g2800,g2754,g2733,g2734,g2859,g2736,g2735,g2738,g2737,g2752,g2739,g2757,g2740,g2758,g2741,g2858,g3114,g2756,g2743,g2884,g2916,
       g2865,g3072,g2924,g3120,g3110,g2857,g2750,g2856,g2751,g2809,g2965,g2755,g3065,g2789,g2762,g2790,g2763,g2791,g2792,g2853,g2783,g2784,g2892,g3089,g2911,g2842,
       g2917,g2771,g2995,g2829,g2772,g2872,g2838,g2775,g2877,g3087,g3014,g2827,g2776,g2914,g2777,g2870,g2778,g2779,g2780,g2855,g2854,g2913,g2785,g2786,g3067,g2899,
       g3077,g3118,g2883,g2846,g2793,g2808,g2794,g3062,g2796,g3063,g2801,g2797,g3115,g2798,g2828,g2806,g2826,g2807,g2811,g2860,g2812,g2815,g2941,g3008,g2898,g2868,
       g3019,g2818,g2821,g2825,g2822,g2867,g2823,g2869,g2824,g2830,g2835,g2873,g2837,g2836,g2834,g2889,g2841,g2847,g2848,g2861,g2862,g2875,g2866,g2912,g2888,g2891,
       g2893,g2894,g3010,g2897,g2939,g2900,g2901,g2910,g3009,g2909,g2919,g3081,g2918,g2921,g2929,g2932,g2934,g2936,g2947,g2948,g2949,g2952,g2953,g2954,g2959,g2961,
       g2963,g2964,g2967,g2968,g2972,g3034,g2976,g2977,g2978,g2979,g2980,g2981,g2986,g2987,g3007,g3001,g2997,g3000,g3020,g3028,g3029,g3035,g3036,g3045,g3134,g3135,
       g3154,g3188,g3162,g3161,g3136,g3140,g3242,g3146,g3150,g3179,g3137,g3155,g3167,g3138,g3139,g3141,g3142,g3143,g3201,g3144,g3145,g3182,g3147,g3148,g3149,g3184,
       g3173,g3151,g3152,g3153,g3156,g3170,g3157,g3241,g3158,g3159,g3160,g3163,g3164,g3165,g3202,g3166,g3168,g3169,g3186,g3171,g3172,g3174,g3180,g3177,g3178,g3181,
       g3183,g3185,g3187,g3189,g3190,g3191,g3192,g3238,g3193,g3203,g3204,g3205,g3233,g3207,g3230,g3234,g3235,g3215,g3218,g3219,g3220,g3221,g3222,g3223,g3224,g3225,
       g3226,g3227,g3228,g3229,g3231,g3232,g3236,g3237,g3239,g3240,g3247,msq3;
    {
    double t0 = 0;
    g2863=sw*ee;
    g3091=g1hzz*g1hzz;
    g3111=g2863*g2863;
    g2787=g3111*g3091;
    g3084=mq*mq;
    g2761=g3084*g2787;
    g3083=mz*mz;
    g2705=g3083*g2761;
    g2702=g2705*s;
    g3086=ee*ee;
    g2885=g3091*g3086;
    g2795=g3083*g2885;
    g3112=sw*sw;
    g3090=g3112*sw;
    g3085=g3090*sw;
    g2937=g3085*g2795;
    g2706=g3084*g2937;
    g2703=g2706*s;
    g2938=g3085*g3084;
    g2930=g2938*sw;
    g3078=g2930*sw;
    g2707=g3078*g2795;
    g2704=g2707*s;
    g3074=g3083*g3083;
    g2768=g3074*g2787;
    g3109=u*u;
    g2708=g3109*g2768;
    g3108=t*t;
    g2709=g3108*g2768;
    g2879=g3086*g3085;
    g2852=g3091*g2879;
    g2769=g3074*g2852;
    g2710=g3109*g2769;
    g2711=g3108*g2769;
    g3082=g3085*sw;
    g3076=g3082*sw;
    g2880=g3086*g3076;
    g2851=g3091*g2880;
    g2770=g3074*g2851;
    g2712=g3109*g2770;
    g2713=g3108*g2770;
    g2742=g2768*u;
    g2714=g2742*t;
    g2744=g2769*u;
    g2715=g2744*t;
    g2745=g2770*u;
    g2716=g2745*t;
    g2871=g3086*s;
    g2878=g3091*g3074;
    g2839=g2878*g2871;
    g3107=mh*mh;
    g2746=g3107*g2839;
    g2717=g3084*g2746;
    g3073=g3084*g3084;
    g2728=g3073*g2795;
    g2962=g3112*s;
    g3041=g3085*s;
    g3042=g3076*s;
    g3075=g3076*sw;
    g3069=g3075*sw;
    g2721=g3069*g2839;
    g3080=g3112*g3069;
    g2722=g3080*g2839;
    g2723=g3074*g2761;
    g2724=g3084*g2769;
    g2725=g3084*g2770;
    g2881=g3086*g3069;
    g2850=g3091*g2881;
    g3119=s*s;
    g2759=g3119*g2850;
    g2882=g3112*g2881;
    g2849=g3091*g2882;
    g2760=g3119*g2849;
    g2810=g3111*g3084;
    g3068=g3083*g3074;
    g2874=g3068*u;
    g2729=g2874*g2810;
    g2730=g3068*g2810*t;
    g2864=g3086*g3084;
    g2799=g3085*g2864;
    g2753=g3068*g2799;
    g2731=g2753*u;
    g2732=g2753*t;
    g2800=g3076*g2864;
    g2754=g3068*g2800;
    g2733=g2754*u;
    g2734=g2754*t;
    g2859=g3068*g2864;
    g2736=g3069*g2859;
    g2735=g2736*u;
    g2738=g3080*g2859;
    g2737=g2738*u;
    g2752=g3068*g2787;
    g2739=g2752*s;
    g2757=g3068*g2852;
    g2740=g2757*s;
    g2758=g3068*g2851;
    g2741=g2758*s;
    g2858=g3084*ee;
    g3114=g2858*g2858;
    g2756=g3114*g2878;
    g2743=g2756*t;
    g2884=g3084*g3083;
    g2916=g3084*g2884;
    g2865=g3084*g2916;
    g3072=g3084*g3073;
    g2924=g3112*g3084;
    g3120=g2924*g2924;
    g3110=g2hzz*g2hzz;
    g2857=g3110*g2879;
    g2750=g3068*g2857;
    g2856=g3110*g2880;
    g2751=g3068*g2856;
    g2809=g2884*sw;
    g2965=g1hzz*s;
    g2755=g2965*g2809;
    g3065=g3083*g3068;
    g2789=g3065*g2852;
    g2762=g3084*g2789;
    g2790=g3065*g2851;
    g2763=g3084*g2790;
    g2791=g3065*g2850;
    g2792=g3065*g2849;
    g2853=g3114*g3068;
    g2783=g3069*g2853;
    g2784=g3080*g2853;
    g2892=g1hzz*mw;
    g3089=g3086*ee;
    g2911=g3089*g2892;
    g2842=g2911*s;
    g2917=g3083*g2842;
    g2771=g3090*g2917;
    g2995=g2hzz*g1hzz;
    g2829=g3112*g2995;
    g2772=g3086*g3068*g2829;
    g2872=g3086*t;
    g2838=g3091*g3068*g2872;
    g2775=g2885*g2874;
    g2877=g3074*mw;
    g3087=g3111*g2863;
    g3014=g3087*g1hzz;
    g2827=g3014*g2877;
    g2776=g3084*g2827;
    g2914=g3110*s;
    g2777=g3111*g2914;
    g2870=g3110*g2871;
    g2778=g3068*g2870;
    g2779=g3065*g2857;
    g2780=g3065*g2856;
    g2855=g3065*g2881;
    g2854=g3065*g2882;
    g2913=g3068*g2871;
    g2785=g3069*g2913;
    g2786=g3080*g2913;
    g3067=g3084*g3072;
    g2899=g3067*s;
    g3077=g3089*ee;
    g3118=mw*mw;
    g2883=g3118*g3077;
    g2846=g2883*u;
    g2793=g3074*g2846;
    g2808=g3084*g2883;
    g2794=g3074*g2808;
    g3062=g2hzz*sw;
    g2796=g3062*s;
    g3063=g3083*g3065;
    g2801=g3063*g2864;
    g2797=g3110*g2801;
    g3115=g2884*g2884;
    g2798=g3115*g3086*g2884;
    g2828=g3074*g2842;
    g2806=g2828*u;
    g2826=g3084*g2842;
    g2807=g3074*g2826*t;
    g2811=g2995*g2913;
    g2860=g3119*g3068;
    g2812=g3086*g2995*g2860;
    g2815=g2995*g2879;
    g2941=g1hzz*u;
    g3008=g2941*g2hzz;
    g2898=g3089*mw;
    g2868=g3084*g2898;
    g3019=g3068*g2868;
    g2818=g3019*g2hzz;
    g2821=g3119*g2911;
    g2825=g2898*g2874;
    g2822=g3090*g2825;
    g2867=g2898*t;
    g2823=g3068*g2867;
    g2869=g3082*g2898;
    g2824=g3068*g2869;
    g2830=g3114*g3065;
    g2835=g3065*g2868;
    g2873=g3074*g2916;
    g2837=g2898*g2873;
    g2836=g3075*g2898;
    g2834=g3087*g3065*g2892;
    g2889=g1hzz*sw;
    g2841=g2889*g2867;
    g2847=g2883*t;
    g2848=g2883*s;
    g2861=g2911*u;
    g2862=g2877*sw;
    g2875=g3065*s;
    g2866=g2875*g2hzz;
    g2912=g3083*g2884;
    g2888=g2912*sw;
    g2891=g3082*g1hzz;
    g2893=g3084*u;
    g2894=g3073*s;
    g3010=g3075*g1hzz;
    g2897=g3010*g2823;
    g2939=g3065*g2787;
    g2900=g2939*u;
    g2901=g3065*t;
    g2910=g3107*s;
    g3009=g3091*t;
    g2909=g3119*g2728;
    g2919=g3090*g3068;
    g3081=g3112*g2919;
    g2918=g3073*g2828;
    g2921=g3068*g2821;
    g2929=g3068*g2808;
    g2932=g3069*g2801;
    g2934=g3085*g2hzz;
    g2936=g3069*g2798;
    g2947=g3085*t;
    g2948=g3082*t;
    g2949=g3119*g2772;
    g2952=g3072*g2770;
    g2953=g3072*g2769;
    g2954=g3072*g2768;
    g2959=g3073*g2758;
    g2961=g3073*g2757;
    g2963=g3090*s;
    g2964=g1hzz*t;
    g2967=g3073*g2752;
    g2968=g3084*sw;
    g2972=g2hzz*u;
    g3034=g3110*t;
    g2976=g3091*g2734;
    g2977=g3091*g2733;
    g2978=g3091*g2732;
    g2979=g3091*g2731;
    g2980=g3091*g2730;
    g2981=g3091*g2729;
    g2986=u*s;
    g2987=t*s;
    g3007=g3065*g2941;
    g3001=g3075*s;
    g2997=g3082*s;
    g3000=u*t;
    g3020=g2842*sw;
    g3028=g2812*t;
    g3029=g2806*t;
    g3035=g3109*s;
    g3036=g3108*s;
    g3045=g2717*u;
    g3134=112.0*g2791-(32.0*g2792);
    g3135=82.0*g2741-(60.0*g2740)+18.0*g2739;
    g3154=896.0*g2995*g2855-(256.0*g2995*g2854);
    g3188=512.0*g3110*g2854-(1792.0*g3110*g2855);
    g3162=1536.0*g2779-(2.0*g3188)-(4096.0*g2780);
    g3161=2.0*g3162+6.0*g3154;
    g3136=g3161+324.0*g2711+162.0*(-g2713-g2709);
    g3140=g3134-(164.0*g2790)+120.0*g2789;
    g3242=72.0*g3083*g2808;
    g3146=2.0*g3140-g3242;
    g3150=g3188+2624.0*g2780-(1920.0*g2779);
    g3179=144.0*g3072*g2937+72.0*(-(g3120*g2924*g2795)-(g2865*g2787));
    g3137=g3154-g3150+g3146-(312.0*g2776)-(3.0*g3179);
    g3155=41.0*g2713-(30.0*g2711)+9.0*g2709;
    g3167=41.0*g2712-(30.0*g2710)+9.0*g2708;
    g3138=g3179-g3167-g3155;
    g3139=108.0*g2716+54.0*(g2713+g2712);
    g3141=108.0*(-g2711-g2710)-(216.0*g2715);
    g3142=8.0*g3074*g2760-(28.0*g3074*g2759);
    g3143=56.0*g2721-(16.0*g2722);
    g3201=768.0*g2750-(2048.0*g2751);
    g3144=4.0*g3201+432.0*g2827-(144.0*g2771);
    g3145=324.0*g2710+162.0*(-g2712-g2708);
    g3182=256.0*g2812*u+512.0*g3063*g2870;
    g3147=3.75*g3182+960.0*(g3108*g2811+g3109*g2811);
    g3148=108.0*g2714+54.0*(g2709+g2708);
    g3149=32.0*g3009*g2738-(112.0*g3009*g2736);
    g3184=144.0*g3041*g2728+72.0*(-(g3042*g2728)-(g2962*g2728));
    g3173=1.5*g3184-(108.0*g2776);
    g3151=g3173+g3142+g3140+1.5*g3135-(36.0*g2939)+288.0*g3068*g2777;
    g3152=32.0*g3068*g2760-(112.0*g3068*g2759);
    g3153=18.0*(-(g3108*g2808)-(g3109*g2808));
    g3156=1312.0*g2751-(960.0*g2750);
    g3170=32.0*(g2717*t+g3045);
    g3157=g3182+g3170+32.0*g2910*g2775+2048.0*g2797+256.0*(g3028+g3108*g2778+
     g3109*g2778);
    g3241=216.0*g3107*g2743;
    g3158=-g3241-(144.0*g2899*g2795);
    g3159=432.0*g2744+216.0*(-g2745-g2742);
    g3160=72.0*(g2847+g2846);
    g3163=864.0*(-g2734-g2733);
    g3164=32.0*(g3068*g2848-(g3068*g2846)-(g3068*g2847));
    g3165=1728.0*(g2732+g2731);
    g3202=288.0*g2818*u-(576.0*g2835*g2hzz);
    g3166=g3202+288.0*g2818*t;
    g3168=2.0*g3135-g3184-g3140;
    g3169=512.0*g2737-(1792.0*g2735);
    g3186=64.0*g2738-(224.0*g2736);
    g3171=g3186+256.0*g2754-(96.0*g2753);
    g3172=1.5*g3186+546.0*g2754-(468.0*g2753);
    g3174=60.0*g2715-(18.0*g2714)-(82.0*g2716);
    g3180=1792.0*g2783-(512.0*g2784);
    g3177=3.0*g3143+36.0*g2771;
    g3178=64.0*(g2918-g2807);
    g3181=-g3164-(192.0*g2929);
    g3183=576.0*(-g2730-g2729);
    g3185=g3144-(6.0*g3143);
    g3187=64.0*g3010*g2825+168.0*g3112*g2889*g2823-(72.0*g2889*g2825);
    g3189=24.0*g3108*g2786-(84.0*g3108*g2785);
    g3190=16.0*g3080*g2838-(56.0*g3069*g2838);
    g3191=164.0*g2758-(120.0*g2757)+36.0*g2752;
    g3192=32.0*(-t-u);
    g3238=32.0*g2793;
    g3193=32.0*g2794-g3238;
    g3203=24.0*g2786-(84.0*g2785);
    g3204=36.0*(g3108*g2898+g3109*g2898);
    g3205=256.0*(g2823+g2825);
    g3233=64.0*g2836;
    g3207=g3233-(160.0*g2869);
    g3230=192.0*s;
    g3234=160.0*g2891;
    g3235=72.0*g2889;
    g3215=72.0*(-g2841-(g2861*sw));
    g3218=g3091*g2784-(3.5*g3091*g2783);
    g3219=g3084*g2792-(3.5*g3084*g2791);
    g3220=3.5*g3091*g2735-(g3091*g2737);
    g3221=g3108*g2722-(3.5*g3108*g2721)+2.25*(g3108*g2704+g3108*g2702)-(4.5*
     g3108*g2703);
    g3222=g3109*g2722-(3.5*g3109*g2721)+2.25*(g3109*g2704+g3109*g2702)-(4.5*
     g3109*g2703);
    g3223=3.5*g3063*g2850-(5.125*g3063*g2851)+3.75*g3063*g2852-(1.125*g3063*
     g2787)-(g3063*g2849);
    g3224=3.75*g3119*g2757-(1.125*g3119*g2752)-(5.125*g3119*g2758);
    g3225=2.0*g3190;
    g3226=8.0*g3142;
    g3227=144.0*g2865;
    g3228=576.0*g2777;
    g3229=160.0*g2806;
    g3231=216.0*s;
    g3232=2048.0*g3080*g2798;
    g3236=36.0*t;
    g3237=648.0*t;
    g3239=64.0*g3075*g2806;
    g3240=72.0*g3065*g2761;
    g3247=cw*cw*cw;
    {
        t0=1.125*g3164+144.0*(g2888*g2821-g2929)+g3171*(g2965*g2965+8.0*g3108*
         g2995)+(18.0*(g2707+g2705)-(36.0*g2706))*(g2987*g2987+g2986*g2986+2.0*
         g3119*g3000)+g3186*(8.0*(g2972*g2972-(g2914*t)+g3034*t)-(g3091*g2910))+
         (108.0*g2724+54.0*(-g2725-g2723))*(g3108*t+g3109*u)+(96.0*g2799-(256.0*
         g2800))*(8.0*g2866*g1hzz-(g3091*g3063))+g3192*(g3224+g3223-(4.5*g3085*
         g2909)-(9.0*g2949)+2.25*(g2875*g2787+g3076*g2909+g3112*g2909))+(3072.0*
         g2873+960.0*g2875)*(g2815*t+g2815*u)+(-g3235-g3234)*(g2823*s+g2823*u+
         3.0*g3084*g2823)+(4.0*g3180+2.0*g3169+4096.0*g2733-(1536.0*g2731))*(
         g2964*g2hzz+g3034)+(2880.0*g2799-(288.0*g2810)-(6432.0*g2800))*(g2995*
         g2901+g3007*g2hzz);
        t0=t0+(384.0*g2724-(144.0*g2723)-(400.0*g2725))*(g3119*t+g3119*u)+g3191*
         (g3108*u+g3109*t)+(41.0*g2770-(30.0*g2769)+9.0*g2768)*(g3036*t+g3035*u)
         +(g3156+288.0*g2772)*(g3036+g3035)+g3180*4.0*(g3110*u+g3008)+(1024.0*
         g2hzz+448.0*g1hzz)*(2.5*g3073*g2824-(g2873*g2836))+288.0*(-(g2995*g2872
         )-(g3086*g3008))*(28.4444*g3076*g2873+4.55556*g3076*g2875+g3112*g2875)+
         g3221*(8.0*t+24.0*u)+g3222*(24.0*t+8.0*u)+g3220*(-g3230-(128.0*t))+(
         g3177+162.0*g2752-g3201)*(g3108*g3084+g3109*g3084)+g3218*(13.0*g3192-(
         448.0*s))+g3219*(4.0*g3192-(128.0*s))+s*(g3187-g3153+6.0*g3149+984.0*
         g2976-(720.0*g2978)+216.0*g2980)+sw*(g3166-(360.0*g2918)+216.0*g2807+
         72.0*(-g2921-g3029)-(288.0*g3068*g2826));
        t0=t0+t*(g3239+g3152-(2348.0*g2959)+1992.0*g2961-(684.0*g2967)-(72.0*
         g2900))+g2743*(1068.0*g3042-(1512.0*g3041))+g2755*(216.0*g3086*g2755-
         g3204-(72.0*g2867*u))+g2762*(g3230-(10.5*g3192))+g2763*(18.25*g3192-(
         512.0*s))+g2777*576.0*(g3063+g2873)+g2793*(g3236+48.0*g2924)+g2794*(
         g3231+108.0*t)+g2796*(576.0*g3019-(1.125*g3205))+g2818*(1280.0*g2997-(
         512.0*g3001))+g2822*(168.0*(g2965+g2964)+672.0*g2hzz*s)+g2829*576.0*(
         g2830+g2801)+g3090*g2837*(-(960.0*g2hzz)-(1176.0*g1hzz))+g2834*(5.25*
         g3192-(336.0*s))+g2835*(320.0*g2891-(128.0*g3010))+g2862*(432.0*g3114*
         g2858*g1hzz-(48.0*g3077*g2862))+g2866*(-(8.0*g3207)-(1344.0*g3087*mw))+
         g2874*(32.0*g2760-(112.0*g2759));
        t0=t0+g3118*g3074*(32.0*g2810*g2810-(252.0*g2864*g2864))+g2883*(-g3227-(
         48.0*g2809*g2809))+g3073*u*(g3185-(2348.0*g2758)+1992.0*g2757-(684.0*
         g2752)+144.0*g2917*sw)+g2889*(504.0*g2837+144.0*g2835)+g3063*mw*(168.0*
         g3014-(g3235*g3089))+g2893*(g3136-(480.0*g2824*g1hzz)+216.0*g3074*g2841
         -g3226)+g2894*(2.0*g3156+1152.0*g2772+456.0*g2827+1068.0*g2745-(1512.0*
         g2744)+684.0*g2742-g3160)+g2897*64.0*(s+u)+g2901*(-g3228-(72.0*g2761))+
         g2910*(g3225+g3174+g3138)+g2914*(g3183-g3169+1.11111*g3165+3.03704*
         g3163)+g3083*g3081*(320.0*g2842+160.0*g2861)+g2916*(2.0*g3160+144.0*
         g2848)+g2919*(480.0*g2826+168.0*g2821)+g3112*g3081*(128.0*g2826+64.0*
         g2821)+g3084*g3078*(-(308.0*g2746)-(896.0*g2811));
        t0=t0+g2930*(g3229+512.0*g2930*g2778)+g2938*(-g3238-(1792.0*g2938*g2778)
         )+g2947*(-g3193-(960.0*g2812)-(264.0*g2717)-(112.0*g2947*g2775))+g2948*
         (32.0*g2948*g2775-g3229-(1280.0*g2818))+g2952*(-g3237-(904.0*s))+g2953*
         (1392.0*s+1296.0*t)+g2954*(-g3237-(648.0*s))+g2962*(684.0*g2743-(528.0*
         g2962*g2756))+g2963*(472.0*g2963*g2756-(1344.0*g2818))+g2968*(216.0*
         g2806-(180.0*g2968*g2746))+g3107*g3073*(g3159+2.0*g3143)+g3107*g3084*(
         g3148+g3141+g3139-(472.0*g2741)+528.0*g2740-(216.0*g2739))+g2977*(984.0
         *s+764.0*t)+g2979*(-(720.0*s)-(696.0*t))+g2981*(g3231+252.0*t)+g2986*(
         g3190+3.0*g3155+g3137+g3236*g2808)+g2987*(3.0*g3167+g3137)+g2995*(g3232
         +10.6667*g3189-(7168.0*g2936)-(3584.0*g2932));
        t0=t0+g3205*g3001*g2hzz+g3107*g3000*(g3143+72.0*g2703+36.0*(-g2704-g2702
         )-g3191)+g3000*(2.0*g3173+g3146+6.0*g3142+g3135)+g3109*g2995*(10.6667*
         g3203+8.0*g3171)+g3119*g2995*(1920.0*g2753-(8.0*g3186)-(2624.0*g2754))+
         g3063*g2995*(4672.0*g2800-(2688.0*g2799))+g3076*g2995*(12864.0*g2830+
         8192.0*g2798)+g3207*g3063*g1hzz+g3185*g3073*t+g3084*t*(g3161+g3145-
         g3226)+g3084*s*(2.0*g3154-(3.66667*g3148)-(4.33333*g3141)-(7.22222*
         g3139)-g3162)+g3112*t*(1.5*g3193+108.0*g2717)+g3107*u*(g3168-g3225)+
         g3168*g3107*t+g2823*g2hzz*(672.0*g2963-(640.0*g2997))+g2965*g2hzz*(1.5*
         g3183+g3180+g3165+g3163)+g2824*s*(-(160.0*g2941)-(640.0*g2972))+g2836*
         g1hzz*(-(64.0*g2901)-(128.0*g2875))+2.0*g3177*g2893*t+3.0*g3204*g2888*
         g1hzz;
        t0=t0+g3065*(144.0*g3020+g3234*g2867-(g3228*u)-g3215)+g3067*(432.0*(
         g2770+g2768)-(864.0*g2769))-(3.5*g3157*g3069)+g3072*(3.0*g3159-g3144+
         4.0*g3143+72.0*g2848+2512.0*g2758-(2112.0*g2757)+720.0*g2752)+g3073*(
         g3226-(28.0*g3135)-(12.0*g3134)+1824.0*g2790-(1152.0*g2789)-(1296.0*
         g2715)+648.0*(g2716+g2714)+2.0*(-g3145-g3136))+g3075*(g3178+1.77778*
         g3166)+g3076*(7.375*g3170+g3158+1.36667*g3147+1312.0*g3028+8192.0*g2797
         )+g3080*(g3157+1024.0*g2995*g2801)+g3082*(-(4.44444*g3202)-(2.5*g3178)-
         (160.0*g2921))+g3083*(2.0*g3153+144.0*(g2894*g2841-(g2899*g2787)))+
         g3084*(3.0*g3187+108.0*g2793-(336.0*g2834)+192.0*g2897-(576.0*g2949)-(
         320.0*g2965*g2824)+504.0*g2822*g1hzz-g3239);
        t0=t0+g3085*(-g3181-(2.0*g3158)-g3147-(3072.0*g2797)-(264.0*g3045))+
         g3090*(1.66667*g3166+168.0*g3029)+g3091*(g3189-(1568.0*g2936)-(224.0*
         g2932))+g3107*(g3240-(64.0*g3219)+g3152+g3149-(432.0*g2953)+268.0*g2959
         -(744.0*g2961)+396.0*g2967-(184.0*g2763)-(48.0*g2762)+36.0*(g2900+g2901
         *g2787)+180.0*(-g2980-g2981)+312.0*(g2978+g2979)+52.0*(-g2976-g2977)+
         216.0*(g2952+g2954)+8.0*(-g3222-g3221)+32.0*(g3223-g3220-g3218-g3224))+
         g3151*g3108+g3109*(g3225+g3151)+g3112*(1.5*g3181+108.0*g3045-g3241)+
         g2877*g2877*(36.0*g3077+32.0*g3087*g2863)+6.0*g3215*g3115+g3065*g2796*
         576.0*(g2898+g3086*g2796)+g3119*(g3150-g3138-(144.0*g2776)-g3242-(3.0*
         g3174))+g3120*(408.0*g2746-(1536.0*g2811));
        msq3=(t0+g2912*g2912*(288.0*g2787-(5760.0*g2815))+g2934*g2798*(-(3072.0*
         g1hzz)-(7168.0*g2934))+g2941*g2941*(g3203+g3172)+g3172*g2964*g2964+
         g2891*g2891*(448.0*g2798+64.0*g2801)+g3232*g3110-(g3240*u)-(576.0*g3062
         *g2837)-(g3233*g3007)-(g3227*g3020))/(g3085*g3247*g3247*(1728.0*(g3063+
         g2860)-(3456.0*g2875)));
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
  double g1hzy = g1hzy_( &smpar, &effpar, s );
  double g2hzy = g2hzy_( &smpar, &effpar, s );
  
  double tmin, tmax;
  tbounds( mq, mq, mz, mh, s, &tmin, &tmax );
  double t = x[0]*( tmax - tmin ) + tmin;
  double u = 2*pow(mq,2) + pow(mh,2) + pow(mz,2) - s - t;
  
  /* Matrixelement */
  
  double g1413,g1414,g1374,g1416,g1356,g1354,g1407,g1424,g1355,g1417,g1379,g1365,g1421,g1357,g1363,g1358,g1375,g1359,g1377,g1404,
       g1360,g1361,g1378,g1364,g1362,g1419,g1366,g1408,g1415,g1385,g1368,g1386,g1369,g1371,g1370,g1381,g1372,g1373,g1406,g1382,
       g1387,g1422,g1420,g1412,g1411,g1400,g1429,g1432,g1430,g1442,g1431,g1433,g1436,g1434,g1435,g1437,g1441,msq1;
    {
    double t0 = 0;
    g1413=mq*mq;
    g1414=mz*mz;
    g1374=g1414*g1413;
    g1416=ee*ee;
    g1356=g1416*g1374;
    g1354=g1356*s;
    g1407=g1416*g1414;
    g1424=g2hzy*g2hzy;
    g1355=g1424*g1407;
    g1417=g1hzy*g1hzy;
    g1379=g1417*g1416;
    g1365=g1414*g1379;
    g1421=s*s;
    g1357=g1421*g1365;
    g1363=g1379*u;
    g1358=g1363*s;
    g1375=g1379*s;
    g1359=g1375*t;
    g1377=g1414*g1407;
    g1404=g1377*g2hzy;
    g1360=g1404*g2hzy;
    g1361=g1365*s;
    g1378=g1416*g1413;
    g1364=g1417*g1378;
    g1362=g1364*s;
    g1419=mh*mh;
    g1366=g1419*g1375;
    g1408=g1414*g1414;
    g1415=g1414*g1408;
    g1385=u*g1hzy;
    g1368=g1385*s;
    g1386=t*g1hzy;
    g1369=g1386*s;
    g1371=g1413*g1hzy;
    g1370=g1371*s;
    g1381=g2hzy*g1hzy;
    g1372=g1407*g1381;
    g1373=g1421*g1381;
    g1406=g1414*s;
    g1382=g1413*g1363;
    g1387=g1417*g1356;
    g1422=u*u;
    g1420=t*s;
    g1412=g1413*g1413;
    g1411=g1413*s;
    g1400=g1358*t;
    g1429=g1359-g1366;
    g1432=16.0*(g1381*g1356+g1413*g1355);
    g1430=g1432-(6.0*g1362)-(3.0*g1361);
    g1442=4.0*g1358;
    g1431=g1442+4.0*g1359;
    g1433=64.0*g1415*g1378+16.0*g1406*g1377;
    g1436=8.0*(-g1372-g1355);
    g1434=16.0*g1365-(8.0*g1436);
    g1435=16.0*(-(g1354*t)-(g1354*u));
    g1437=16.0*(-(g1360*t)-(g1360*u));
    g1441=8.0*g1417*g1354;
    {
        t0=4.0*(-t-u)*(16.0*g1404*g1371-(4.0*g1421*g1372)+g1357-g1441)+g1436*(
         8.0*g1412*u-(g1420*t)-(g1422*s))+g1431*(g1419*g1413+g1419*g1414)+g1437*
         s+g1356*(4.0*(g1385*g1385+g1386*g1386)-(32.0*g1373))+g1377*(32.0*g1371*
         g1371-(16.0*g1373))+g1381*(g1433+128.0*g1374*g1356-g1435)-(g1434*g1412*
         t)+g1413*g1411*(16.0*g1355-(48.0*g1372))+g1420*s*(6.0*g1363-(8.0*g1364)
         )+g1404*(16.0*(-g1369-g1368)-(32.0*g1370))+u*t*(2.0*g1432+8.0*g1387)+
         g1408*(g1442+4.0*g1429-(40.0*g1362)+16.0*(-g1382-(g1364*t)))+g1413*
         g1412*(g1434-(8.0*g1375))+g1412*(3.0*g1431+128.0*g1360-(4.0*g1366)-(
         48.0*g1361))+g1413*(4.0*g1437-(12.0*g1400)-(16.0*g1374*g1363))+g1416*(
         g1368*g1368+g1369*g1369+8.0*g1370*g1370);
        msq1=(t0+g1419*(4.0*g1357-(2.0*g1400)-g1441)+g1421*(24.0*g1387-(8.0*
         g1382)+16.0*g1360)+g1422*(g1430-g1366+3.0*g1359+g1375*u)+g1424*(g1435+
         g1433)+t*t*(g1430+g1429+3.0*g1358)+32.0*g1411*g1360-(10.0*g1414*g1400)+
         16.0*g1415*g1364)/(54.0*g1406*s);
    };
};
double g1590,g1688,g1531,g1678,g1488,g1691,g1676,g1681,g1565,g1564,g1552,g1533,g1523,g1689,g1690,g1522,g1532,g1496,g1539,g1527,g1521,g1518,g1500,g1485,
       g1502,g1684,g1467,g1511,g1498,g1680,g1585,g1468,g1536,g1529,g1520,g1535,g1471,g1472,g1589,g1650,g1659,g1519,g1556,g1481,g1671,g1525,g1513,g1478,
       g1677,g1604,g1526,g1484,g1482,g1606,g1483,g1486,g1560,g1524,g1605,g1487,g1489,g1687,g1603,g1490,g1551,g1534,g1503,g1491,g1506,g1492,g1493,g1537,
       g1494,g1530,g1515,g1495,g1668,g1497,g1499,g1501,g1504,g1508,g1507,g1661,g1509,g1570,g1510,g1572,g1580,g1512,g1514,g1528,g1516,g1517,g1549,g1602,
       g1541,g1631,g1542,g1550,g1599,g1598,g1555,g1566,g1567,g1640,g1571,g1574,g1666,g1597,g1596,g1595,g1579,g1593,g1582,g1592,g1584,g1591,g1609,g1633,
       g1634,g1615,g1617,g1620,g1622,g1638,g1644,g1643,g1686,g1698,g1714,g1699,g1700,g1701,g1717,g1702,g1709,g1724,g1703,g1704,g1705,g1706,g1707,g1708,
       g1711,g1712,g1713,g1715,g1738,g1725,g1719,g1721,g1743,g1723,g1727,g1732,g1740,g1741,g1737,g1739,g1742,g1744,g1745,g1746,g1747,g1748,msq2;
    {
    double t0 = 0;
    g1590=s*g1hzy;
    g1688=ee*ee;
    g1531=g1688*g1590;
    g1678=mz*mz;
    g1488=g1678*g1531;
    g1691=sw*sw;
    g1676=g1691*sw;
    g1681=mq*mq;
    g1565=g1681*g1676;
    g1564=g1691*g1565;
    g1552=g1678*g2hzy;
    g1533=g1688*g1552;
    g1523=g1533*g2hzz;
    g1689=u*u;
    g1690=t*t;
    g1522=g1533*g1hzz;
    g1532=g1688*g1676;
    g1496=g1532*g2hzy;
    g1539=g1678*g1hzz;
    g1527=g1691*g1532;
    g1521=g1527*g1hzz;
    g1518=g1532*g1hzy;
    g1500=g1527*g2hzz*g1hzy;
    g1485=g1518*g1hzz;
    g1502=g1521*g1hzy;
    g1684=s*s;
    g1467=g1684*g1485;
    g1511=g1688*g1684;
    g1498=g1511*g1hzy;
    g1680=g1691*g1676;
    g1585=g1680*g1hzz;
    g1468=g1585*g1498;
    g1536=g1681*g1496;
    g1529=g1688*g1681;
    g1520=g1529*g2hzy;
    g1535=g1680*g2hzz;
    g1471=g1485*u;
    g1472=g1502*u;
    g1589=g1hzz*s;
    g1650=g1589*t;
    g1659=t*s;
    g1519=g1529*g1hzy;
    g1556=g1678*sw;
    g1481=g1556*g1519;
    g1671=g1681*g1681;
    g1525=g1688*g1671;
    g1513=g1525*g2hzz*g2hzy;
    g1478=g1522*sw;
    g1677=g1678*g1678;
    g1604=g1677*g2hzy;
    g1526=g1677*g1529;
    g1484=g1526*g2hzz;
    g1482=g1484*u;
    g1606=g1677*g2hzz;
    g1483=g1606*g1518;
    g1486=g1526*g1hzz;
    g1560=g1681*g1678;
    g1524=g1681*g1560;
    g1605=g1524*t;
    g1487=g1688*g1605;
    g1489=g1498*sw;
    g1687=mh*mh;
    g1603=g1687*g1hzz;
    g1490=g1603*g1531;
    g1551=g1688*mw*ee;
    g1534=g1681*g1551;
    g1503=g1534*g2hzy;
    g1491=g1678*g1503;
    g1506=g1534*g1hzy;
    g1492=g1506*u;
    g1493=g1506*t;
    g1537=g1551*s;
    g1494=g1678*g1537;
    g1530=g1681*g1524;
    g1515=g1688*g1530;
    g1495=g1515*g2hzz;
    g1668=g1678*g1677;
    g1497=g1668*g1520;
    g1499=g1668*g1519;
    g1501=g1677*g1525*g1hzz;
    g1504=g1551*g1524;
    g1508=g1684*g1678;
    g1507=g1523*sw;
    g1661=sw*g1hzy;
    g1509=g1661*g1525;
    g1570=g1hzz*sw;
    g1510=g1570*g1531;
    g1572=g1688*g2hzy;
    g1580=g2hzz*s;
    g1512=g1580*g1572;
    g1514=g1531*g2hzz;
    g1528=g1677*s;
    g1516=g1551*g1528;
    g1517=g1537*g1hzy;
    g1549=g1681*g1hzy;
    g1602=g1671*g1hzz;
    g1541=g1681*t;
    g1631=g1681*s;
    g1542=g1681*g1631;
    g1550=g1687*g1678;
    g1599=g1472*s;
    g1598=g1471*s;
    g1555=g1681*sw;
    g1566=g1681*g1485;
    g1567=g1684*g1478;
    g1640=g2hzz*sw;
    g1571=g1640*g2hzy;
    g1574=g1570*g1488;
    g1666=u*t;
    g1597=g1677*u;
    g1596=t*sw;
    g1595=g1678*u;
    g1579=u*s;
    g1593=g1691*g2hzy;
    g1582=g1678*t;
    g1592=g1hzz*u;
    g1584=g1640*g1488;
    g1591=g1680*g1hzy;
    g1609=g1510*u;
    g1633=g1689*s;
    g1634=g1690*s;
    g1615=g1495*g2hzy;
    g1617=g1490*sw;
    g1620=g1483*s;
    g1622=g1481*g2hzz;
    g1638=g1676*s;
    g1644=g1486*sw;
    g1643=s*sw;
    g1686=g1574*t;
    g1698=22.0*g1687*g1598-(16.0*g1687*g1599);
    g1714=44.0*g1467-(32.0*g1468);
    g1699=-(2.0*g1714)-(12.0*g1617);
    g1700=48.0*g1468*u-(66.0*g1467*u);
    g1701=88.0*g1678*g1518*g2hzz-(64.0*g1678*g1500);
    g1717=88.0*g1539*g1496-(64.0*g1552*g1521);
    g1702=2.0*g1717-(48.0*g1478);
    g1709=11.0*g1690*g1485-(8.0*g1690*g1502);
    g1724=11.0*g1689*g1485-(8.0*g1689*g1502);
    g1703=g1724+g1709;
    g1704=44.0*g1678*g1598-(12.0*g1574*u)-(32.0*g1678*g1599);
    g1705=-(96.0*g1478*u)-(192.0*g1507*u)-(704.0*g1483);
    g1706=384.0*g1615+192.0*(g1499*g2hzz-(g1482*g1hzy));
    g1707=352.0*g1671*g1496*g2hzz-(256.0*g1680*g1513);
    g1708=48.0*g1506+96.0*g1503;
    g1711=48.0*(-(g1690*g1523)-(g1689*g1523))+24.0*(-(g1690*g1522)-(g1689*g1522)
     );
    g1712=3.0*g1617-(48.0*g1622)-(24.0*g1584);
    g1713=132.0*g1471-(96.0*g1472);
    g1715=-(4.0*g1702)-(8.0*g1701);
    g1738=2.0*g1701;
    g1725=24.0*(t+u);
    g1719=352.0*g1536*g2hzz-(256.0*g1535*g1520);
    g1721=64.0*g1604*g1527-(88.0*g1677*g1496);
    g1743=24.0*g1489;
    g1723=48.0*g1549*g1494+12.0*(g1666*g1517+g1551*g1508*g1hzy);
    g1727=168.0*g1602*g1488-(96.0*g1668*g1512);
    g1732=-(48.0*g1499)-(96.0*g1497);
    g1740=48.0*g1514;
    g1741=192.0*g1484;
    g1737=4.0*g1707;
    g1739=96.0*g1507;
    g1742=48.0*g1481;
    g1744=48.0*g1489;
    g1745=32.0*g1680*g1490;
    g1746=176.0*g1483;
    g1747=9.0*g1609;
    g1748=96.0*g1622;
    {
        t0=g1723+384.0*(g1571*g1487-(g1640*g1497))+2.66667*(g1732*g1585-(g1723*
         g1691))+(12.0*(g1493+g1492)+32.0*(-(g1691*g1493)-(g1691*g1492)))*(2.0*
         g1678-s)+(88.0*g1565*g1488-(24.0*g1481*s)-(64.0*g1564*g1488))*(2.0*(
         g2hzz*t+g2hzz*u)+4.0*(g1hzz*t+g1592)-g1603)+g1725*(g1494*g2hzy+5.33333*
         g1528*g1500-(2.66667*g1593*g1494)+g1572*g1570*g1528-g1567)+(384.0*g1482
         -(288.0*g1501))*(g2hzy*sw+1.33333*g1591)+(g1743+6.0*g1721)*(g1541*g1hzz
         +g1681*g1592)+4.0*(g1717+g1701)*(g1541*u-(2.0*g1671*u))+g1721*(2.0*
         g1681*g1589+4.0*(g1579*g2hzz+g1580*t-(g1684*g2hzz)))+g1719*(2.0*g1582*u
         -(g1678*g1579)+4.0*(-(g1677*t)-g1597)-(g1582*s))+(g1741+72.0*g1486)*(
         g1596*g1hzy+2.0*g1596*g2hzy+2.66667*g1591*t);
        t0=t0+g1711*(g1643+2.66667*g1691*g1638-(3.66667*g1638)-(7.33333*g1565)+
         5.33333*g1564)+(48.0*g1hzy+96.0*g2hzy)*(1.5*g1644*u-g1504)+(g1738+g1717
         )*(g1684*t+g1684*u-(2.0*g1631*s))+g1701*(g1634+g1633)+g1703*(-(g1687*s)
         -(6.0*g1631))+(44.0*g1650*g1532-(32.0*g1659*g1521))*(3.0*g1671*g1hzy-(
         2.0*g1604)+g1687*g1549+g1550*g1hzy)+(-(24.0*g1481)-(3.0*g1489))*(g1690*
         g1hzz+g1689*g1hzz)+(48.0*s-(2.0*g1725))*(2.66667*g1691*g1491-g1491)+(
         8.0*g1502-(11.0*g1485))*(8.0*g1681*g1542-(g1634*t)-(g1633*u)-(32.0*
         g1530))+g1713*(1.33333*g1678*g1541-(2.0*g1678*g1560))+(g1740+96.0*g1512
         )*(g1677*g1596+g1597*sw)+(g1738+18.0*g1510)*(g1690*g1681+g1689*g1681)+
         sw*(g1727-g1706);
        t0=t0+t*(3.0*g1686-(1.5*g1704)-g1700-g1698-(176.0*g1620))+g1509*(96.0*
         g1539*u-(36.0*g1650))+g1516*(-(12.0*g1hzy)-(48.0*g2hzy))+g1524*(-(
         2.66667*g1713)-(616.0*g1485*s))+g1528*(2.0*g1719-(352.0*g1566))+g1541*(
         g1705+g1699+96.0*g1599-(132.0*g1598)+36.0*g1609+g1739*s)+g1542*(g1713-
         g1702-(6.0*g1701)-g1739)+g1714*g1550+g1555*(2.0*g1711-(32.0*g1555*g1517
         ))+g1560*(4.0*g1714+8.0*g1703)+g1570*(g1732-(96.0*g1515*g1hzy))+g1595*
         g2hzz*(192.0*g1509-g1744)+g1579*(3.0*g1709-g1746)+g1582*(-g1737-(g1744*
         g2hzz))+g1680*g1590*256.0*(g1486+g1484)+g1590*96.0*(g1644+g1484*sw)+
         g1593*(256.0*g1504+128.0*g1516)-(g1737*g1595)+g1687*g1485*44.0*(-g1542-
         g1528)+g1602*(-g1743-(12.0*g1721));
        t0=t0+g1606*(g1744-(384.0*g1509))+g1691*g1hzy*(128.0*g1504+32.0*g1516)+
         g1677*sw*(12.0*g1490-(768.0*g1513))+g1715*g1671*t+g1678*s*(g1707-g1703)
         +g1643*g2hzy*(48.0*g1486-g1741)+g1487*g1hzy*(256.0*g1585+96.0*g1570+
         192.0*g1640)+g1490*u*(6.0*g1596-(12.0*g1555))+g1592*t*(-g1742-(18.0*
         g1489))+g1579*g1hzz*(g1721-(36.0*g1509))+3.0*g1724*g1659+g1661*(-(144.0
         *g1501)-(192.0*g1495))+g1666*(-g1748-g1747)+g1668*(4.0*g1719+176.0*
         g1566+352.0*(g1536*g1hzz+g1580*g1496)-(128.0*g1500*s)-(g1740*sw))+g1681
         *g1671*(24.0*g1510-g1715)+g1671*(g1745-(2.0*g1705)-g1699+12.0*g1517+
         144.0*g1584)+3.66667*g1706*g1676+g1677*(g1745-g1708+8.0*g1707-(264.0*
         g1541*g1485)+128.0*g1535*g1498-(96.0*g1571*g1511));
        msq2=(t0+g1680*(2.66667*g1727-(1024.0*g1615))+g1681*(1.33333*g1700+2.0*
         g1698-(352.0*g1620)+48.0*g1567+g1739*g1579)+g1684*(g1748-g1746+g1703-(
         g1742*g1hzz))+g1687*(g1704+12.0*(-g1686-(g1539*g1489)))+g1689*(g1712+
         3.0*(g1574-g1609))+g1690*(g1712-(3.0*g1510*t)-g1747)+g1556*g1556*(
         2.66667*g1708+176.0*g1556*g1514)+g1560*g1560*(528.0*g1485-(1024.0*g1500
         ))-(512.0*g1535*g1499)-(352.0*g1605*g1485))/(g1691*cw*cw*cw*216.0*(
         g1528-g1508));
    };
};
double g1916,g2144,g2164,g1840,g2137,g1814,g2136,g1758,g1755,g2139,g1938,g1848,g2165,g2143,g2138,g1990,g1759,g1756,g1991,g1983,g2131,g1760,g1757,g2127,g1821,g2162,g1761,
       g2161,g1762,g1932,g1905,g1822,g1763,g1764,g2135,g2129,g1933,g1904,g1823,g1765,g1766,g1795,g1767,g1797,g1768,g1798,g1769,g1924,g1931,g1892,g2160,g1799,g1770,g2126,
       g1781,g2015,g2094,g2095,g2128,g2122,g1774,g2133,g1775,g1776,g1777,g1778,g1934,g1903,g2172,g1812,g1935,g1902,g1813,g1863,g2121,g1927,g1782,g1783,g1917,g1852,g1806,
       g1784,g1785,g1853,g1807,g1786,g1787,g1912,g1789,g1788,g1791,g1790,g1805,g1792,g1810,g1793,g1811,g1794,g1911,g2167,g1809,g1796,g1937,g1969,g1918,g2125,g1977,g2173,
       g2163,g1910,g1803,g1909,g1804,g1862,g2018,g1808,g2118,g1842,g1815,g1843,g1816,g1844,g1817,g1845,g1818,g1906,g1836,g1819,g1837,g1820,g1945,g2142,g1964,g1895,g1970,
       g1824,g2048,g1882,g1825,g1925,g1891,g1828,g1930,g2140,g2067,g1880,g1829,g1967,g1830,g1923,g1831,g1832,g1833,g1908,g1907,g1966,g1838,g1839,g2120,g1952,g2130,g2171,
       g1936,g1899,g1846,g1861,g1847,g2115,g1849,g2116,g1854,g1850,g2168,g1851,g1881,g1859,g1879,g1860,g1864,g1913,g1865,g1868,g1994,g2061,g1951,g1921,g2072,g1871,g1874,
       g1878,g1875,g1920,g1876,g1922,g1877,g1883,g1888,g1926,g1890,g1889,g1887,g1942,g1894,g1900,g1901,g1914,g1915,g1928,g1919,g1965,g1941,g1944,g1946,g1947,g2063,g1950,
       g1992,g1953,g1954,g1963,g2062,g1962,g1972,g2134,g1971,g1974,g1982,g1985,g1987,g1989,g2000,g2001,g2002,g2005,g2006,g2007,g2012,g2014,g2016,g2017,g2020,g2021,g2025,
       g2087,g2029,g2030,g2031,g2032,g2033,g2034,g2039,g2040,g2060,g2054,g2050,g2053,g2073,g2081,g2082,g2088,g2089,g2098,g2187,g2188,g2207,g2241,g2215,g2214,g2189,g2193,
       g2290,g2199,g2203,g2233,g2190,g2208,g2220,g2191,g2192,g2194,g2195,g2196,g2252,g2197,g2198,g2235,g2200,g2201,g2202,g2237,g2226,g2204,g2205,g2206,g2209,g2223,g2210,
       g2289,g2211,g2212,g2213,g2216,g2217,g2218,g2253,g2219,g2221,g2222,g2239,g2224,g2225,g2227,g2228,g2234,g2231,g2232,g2236,g2238,g2240,g2242,g2243,g2244,g2285,g2245,
       g2246,g2254,g2255,g2256,g2282,g2258,g2283,g2284,g2266,g2269,g2270,g2271,g2273,g2274,g2275,g2276,g2277,g2278,g2279,g2280,g2281,g2286,g2287,g2288,g2295,msq3;
    {
    double t0 = 0;
    g1916=sw*ee;
    g2144=g1hzz*g1hzz;
    g2164=g1916*g1916;
    g1840=g2164*g2144;
    g2137=mq*mq;
    g1814=g2137*g1840;
    g2136=mz*mz;
    g1758=g2136*g1814;
    g1755=g1758*s;
    g2139=ee*ee;
    g1938=g2144*g2139;
    g1848=g2136*g1938;
    g2165=sw*sw;
    g2143=g2165*sw;
    g2138=g2143*sw;
    g1990=g2138*g1848;
    g1759=g2137*g1990;
    g1756=g1759*s;
    g1991=g2138*g2137;
    g1983=g1991*sw;
    g2131=g1983*sw;
    g1760=g2131*g1848;
    g1757=g1760*s;
    g2127=g2136*g2136;
    g1821=g2127*g1840;
    g2162=u*u;
    g1761=g2162*g1821;
    g2161=t*t;
    g1762=g2161*g1821;
    g1932=g2139*g2138;
    g1905=g2144*g1932;
    g1822=g2127*g1905;
    g1763=g2162*g1822;
    g1764=g2161*g1822;
    g2135=g2138*sw;
    g2129=g2135*sw;
    g1933=g2139*g2129;
    g1904=g2144*g1933;
    g1823=g2127*g1904;
    g1765=g2162*g1823;
    g1766=g2161*g1823;
    g1795=g1821*u;
    g1767=g1795*t;
    g1797=g1822*u;
    g1768=g1797*t;
    g1798=g1823*u;
    g1769=g1798*t;
    g1924=g2139*s;
    g1931=g2144*g2127;
    g1892=g1931*g1924;
    g2160=mh*mh;
    g1799=g2160*g1892;
    g1770=g2137*g1799;
    g2126=g2137*g2137;
    g1781=g2126*g1848;
    g2015=g2165*s;
    g2094=g2138*s;
    g2095=g2129*s;
    g2128=g2129*sw;
    g2122=g2128*sw;
    g1774=g2122*g1892;
    g2133=g2165*g2122;
    g1775=g2133*g1892;
    g1776=g2127*g1814;
    g1777=g2137*g1822;
    g1778=g2137*g1823;
    g1934=g2139*g2122;
    g1903=g2144*g1934;
    g2172=s*s;
    g1812=g2172*g1903;
    g1935=g2165*g1934;
    g1902=g2144*g1935;
    g1813=g2172*g1902;
    g1863=g2164*g2137;
    g2121=g2136*g2127;
    g1927=g2121*u;
    g1782=g1927*g1863;
    g1783=g2121*g1863*t;
    g1917=g2139*g2137;
    g1852=g2138*g1917;
    g1806=g2121*g1852;
    g1784=g1806*u;
    g1785=g1806*t;
    g1853=g2129*g1917;
    g1807=g2121*g1853;
    g1786=g1807*u;
    g1787=g1807*t;
    g1912=g2121*g1917;
    g1789=g2122*g1912;
    g1788=g1789*u;
    g1791=g2133*g1912;
    g1790=g1791*u;
    g1805=g2121*g1840;
    g1792=g1805*s;
    g1810=g2121*g1905;
    g1793=g1810*s;
    g1811=g2121*g1904;
    g1794=g1811*s;
    g1911=g2137*ee;
    g2167=g1911*g1911;
    g1809=g2167*g1931;
    g1796=g1809*t;
    g1937=g2137*g2136;
    g1969=g2137*g1937;
    g1918=g2137*g1969;
    g2125=g2137*g2126;
    g1977=g2165*g2137;
    g2173=g1977*g1977;
    g2163=g2hzz*g2hzz;
    g1910=g2163*g1932;
    g1803=g2121*g1910;
    g1909=g2163*g1933;
    g1804=g2121*g1909;
    g1862=g1937*sw;
    g2018=g1hzz*s;
    g1808=g2018*g1862;
    g2118=g2136*g2121;
    g1842=g2118*g1905;
    g1815=g2137*g1842;
    g1843=g2118*g1904;
    g1816=g2137*g1843;
    g1844=g2118*g1903;
    g1817=g2137*g1844;
    g1845=g2118*g1902;
    g1818=g2137*g1845;
    g1906=g2167*g2121;
    g1836=g2122*g1906;
    g1819=g2144*g1836;
    g1837=g2133*g1906;
    g1820=g2144*g1837;
    g1945=g1hzz*mw;
    g2142=g2139*ee;
    g1964=g2142*g1945;
    g1895=g1964*s;
    g1970=g2136*g1895;
    g1824=g2143*g1970;
    g2048=g2hzz*g1hzz;
    g1882=g2165*g2048;
    g1825=g2139*g2121*g1882;
    g1925=g2139*t;
    g1891=g2144*g2121*g1925;
    g1828=g1938*g1927;
    g1930=g2127*mw;
    g2140=g2164*g1916;
    g2067=g2140*g1hzz;
    g1880=g2067*g1930;
    g1829=g2137*g1880;
    g1967=g2163*s;
    g1830=g2164*g1967;
    g1923=g2163*g1924;
    g1831=g2121*g1923;
    g1832=g2118*g1910;
    g1833=g2118*g1909;
    g1908=g2118*g1934;
    g1907=g2118*g1935;
    g1966=g2121*g1924;
    g1838=g2122*g1966;
    g1839=g2133*g1966;
    g2120=g2137*g2125;
    g1952=g2120*s;
    g2130=g2142*ee;
    g2171=mw*mw;
    g1936=g2171*g2130;
    g1899=g1936*u;
    g1846=g2127*g1899;
    g1861=g2137*g1936;
    g1847=g2127*g1861;
    g2115=g2hzz*sw;
    g1849=g2115*s;
    g2116=g2136*g2118;
    g1854=g2116*g1917;
    g1850=g2163*g1854;
    g2168=g1937*g1937;
    g1851=g2168*g2139*g1937;
    g1881=g2127*g1895;
    g1859=g1881*u;
    g1879=g2137*g1895;
    g1860=g2127*g1879*t;
    g1864=g2048*g1966;
    g1913=g2172*g2121;
    g1865=g2139*g2048*g1913;
    g1868=g2048*g1932;
    g1994=g1hzz*u;
    g2061=g1994*g2hzz;
    g1951=g2142*mw;
    g1921=g2137*g1951;
    g2072=g2121*g1921;
    g1871=g2072*g2hzz;
    g1874=g2172*g1964;
    g1878=g1951*g1927;
    g1875=g2143*g1878;
    g1920=g1951*t;
    g1876=g2121*g1920;
    g1922=g2135*g1951;
    g1877=g2121*g1922;
    g1883=g2167*g2118;
    g1888=g2118*g1921;
    g1926=g2127*g1969;
    g1890=g1951*g1926;
    g1889=g2128*g1951;
    g1887=g2140*g2118*g1945;
    g1942=g1hzz*sw;
    g1894=g1942*g1920;
    g1900=g1936*t;
    g1901=g1936*s;
    g1914=g1964*u;
    g1915=g1930*sw;
    g1928=g2118*s;
    g1919=g1928*g2hzz;
    g1965=g2136*g1937;
    g1941=g1965*sw;
    g1944=g2135*g1hzz;
    g1946=g2137*u;
    g1947=g2126*s;
    g2063=g2128*g1hzz;
    g1950=g2063*g1876;
    g1992=g2118*g1840;
    g1953=g1992*u;
    g1954=g2118*t;
    g1963=g2160*s;
    g2062=g2144*t;
    g1962=g2172*g1781;
    g1972=g2143*g2121;
    g2134=g2165*g1972;
    g1971=g2126*g1881;
    g1974=g2121*g1874;
    g1982=g2121*g1861;
    g1985=g2122*g1854;
    g1987=g2138*g2hzz;
    g1989=g2122*g1851;
    g2000=g2138*t;
    g2001=g2135*t;
    g2002=g2172*g1825;
    g2005=g2125*g1823;
    g2006=g2125*g1822;
    g2007=g2125*g1821;
    g2012=g2126*g1811;
    g2014=g2126*g1810;
    g2016=g2143*s;
    g2017=g1hzz*t;
    g2020=g2126*g1805;
    g2021=g2137*sw;
    g2025=g2hzz*u;
    g2087=g2163*t;
    g2029=g2144*g1787;
    g2030=g2144*g1786;
    g2031=g2144*g1785;
    g2032=g2144*g1784;
    g2033=g2144*g1783;
    g2034=g2144*g1782;
    g2039=u*s;
    g2040=t*s;
    g2060=g2118*g1994;
    g2054=g2128*s;
    g2050=g2135*s;
    g2053=u*t;
    g2073=g1895*sw;
    g2081=g1865*t;
    g2082=g1859*t;
    g2088=g2162*s;
    g2089=g2161*s;
    g2098=g1770*u;
    g2187=352.0*g1844-(128.0*g1845);
    g2188=178.0*g1794-(84.0*g1793)+18.0*g1792;
    g2207=2816.0*g2048*g1908-(1024.0*g2048*g1907);
    g2241=2048.0*g2163*g1907-(5632.0*g2163*g1908);
    g2215=3072.0*g1832-(2.0*g2241)-(10240.0*g1833);
    g2214=2.0*g2215+6.0*g2207;
    g2189=g2214+324.0*g1764+162.0*(-g1766-g1762);
    g2193=g2187-(356.0*g1843)+168.0*g1842;
    g2290=72.0*g2136*g1861;
    g2199=2.0*g2193-g2290;
    g2203=g2241+5696.0*g1833-(2688.0*g1832);
    g2233=144.0*g2125*g1990+72.0*(-(g2173*g1977*g1848)-(g1918*g1840));
    g2190=g2207-g2203+g2199-(408.0*g1829)-(3.0*g2233);
    g2208=89.0*g1766-(42.0*g1764)+9.0*g1762;
    g2220=89.0*g1765-(42.0*g1763)+9.0*g1761;
    g2191=g2233-g2220-g2208;
    g2192=108.0*g1769+54.0*(g1766+g1765);
    g2194=108.0*(-g1764-g1763)-(216.0*g1768);
    g2195=32.0*g2127*g1813-(88.0*g2127*g1812);
    g2196=176.0*g1774-(64.0*g1775);
    g2252=1536.0*g1803-(5120.0*g1804);
    g2197=4.0*g2252+432.0*g1880-(144.0*g1824);
    g2198=324.0*g1763+162.0*(-g1765-g1761);
    g2235=1024.0*g1865*u+2048.0*g2116*g1923;
    g2200=1.3125*g2235+1344.0*(g2161*g1864+g2162*g1864);
    g2201=108.0*g1767+54.0*(g1762+g1761);
    g2202=128.0*g2062*g1791-(352.0*g2062*g1789);
    g2237=144.0*g2094*g1781+72.0*(-(g2095*g1781)-(g2015*g1781));
    g2226=1.5*g2237-(108.0*g1829);
    g2204=g2226+g2195+g2193+1.5*g2188-(36.0*g1992)+288.0*g2121*g1830;
    g2205=128.0*g2121*g1813-(352.0*g2121*g1812);
    g2206=18.0*(-(g2161*g1861)-(g2162*g1861));
    g2209=2848.0*g1804-(1344.0*g1803);
    g2223=128.0*(g1770*t+g2098);
    g2210=g2235+g2223+128.0*g1963*g1828+8192.0*g1850+1024.0*(g2081+g2161*g1831+
     g2162*g1831);
    g2289=216.0*g2160*g1796;
    g2211=-g2289-(144.0*g1952*g1848);
    g2212=432.0*g1797+216.0*(-g1798-g1795);
    g2213=72.0*(g1900+g1899);
    g2216=864.0*(-g1787-g1786);
    g2217=36.0*(g2121*g1901-(g2121*g1899)-(g2121*g1900));
    g2218=1728.0*(g1785+g1784);
    g2253=288.0*g1871*u-(576.0*g1888*g2hzz);
    g2219=g2253+288.0*g1871*t;
    g2221=2.0*g2188-g2237-g2193;
    g2222=2048.0*g1790-(5632.0*g1788);
    g2239=256.0*g1791-(704.0*g1789);
    g2224=g2239+640.0*g1807-(192.0*g1806);
    g2225=1.5*g2239+1122.0*g1807-(612.0*g1806);
    g2227=84.0*g1768-(18.0*g1767)-(178.0*g1769);
    g2228=-(2.66667*g2217)-(576.0*g1982);
    g2234=5632.0*g1836-(2048.0*g1837);
    g2231=3.0*g2196+36.0*g1824;
    g2232=256.0*(g1971-g1860);
    g2236=576.0*(-g1783-g1782);
    g2238=g2197-(6.0*g2196);
    g2240=256.0*g2063*g1878+264.0*g2165*g1942*g1876-(72.0*g1942*g1878);
    g2242=96.0*g2161*g1839-(264.0*g2161*g1838);
    g2243=64.0*g2133*g1891-(176.0*g2122*g1891);
    g2244=356.0*g1811-(168.0*g1810)+36.0*g1805;
    g2285=36.0*t;
    g2245=-g2285-(36.0*u);
    g2246=96.0*(g1847-g1846);
    g2254=96.0*g1839-(264.0*g1838);
    g2255=36.0*(g2161*g1951+g2162*g1951);
    g2256=288.0*(g1876+g1878);
    g2282=256.0*g1889;
    g2258=g2282-(448.0*g1922);
    g2283=448.0*g1944;
    g2284=72.0*g1942;
    g2266=72.0*(-g1894-(g1914*sw));
    g2269=2.75*g2144*g1788-(g2144*g1790);
    g2270=g2161*g1757-(2.0*g2161*g1756)+g2161*g1755+1.77778*g2161*g1775-(4.88889
     *g2161*g1774);
    g2271=g2162*g1757-(2.0*g2162*g1756)+g2162*g1755+1.77778*g2162*g1775-(4.88889
     *g2162*g1774);
    g2273=-(3.55556*g2116*g1902)-(g2116*g1840)+9.77778*g2116*g1903-(9.88889*
     g2116*g1904)+4.66667*g2116*g1905;
    g2274=4.66667*g2172*g1810-(g2172*g1805)-(9.88889*g2172*g1811);
    g2275=2.0*g2243;
    g2276=8.0*g2195;
    g2277=144.0*g1918;
    g2278=576.0*g1830;
    g2279=448.0*g1859;
    g2280=216.0*s;
    g2281=8192.0*g2133*g1851;
    g2286=648.0*t;
    g2287=256.0*g2128*g1859;
    g2288=72.0*g2118*g1814;
    g2295=cw*cw*cw;
    {
        t0=g2217+144.0*(g1941*g1874-g1982)+g2224*(g2018*g2018+8.0*g2161*g2048)+(
         18.0*(g1760+g1758)-(36.0*g1759))*(g2040*g2040+g2039*g2039+2.0*g2172*
         g2053)+g2239*(8.0*(g2025*g2025-(g1967*t)+g2087*t)-(g2144*g1963))+(108.0
         *g1777+54.0*(-g1778-g1776))*(g2161*t+g2162*u)+(192.0*g1852-(640.0*g1853
         ))*(8.0*g1919*g1hzz-(g2144*g2116))+g2245*(g2274+g2273-(4.0*g2138*g1962)
         -(8.0*g2002)+2.0*(g1928*g1840+g2129*g1962+g2165*g1962))+(6144.0*g1926+
         1344.0*g1928)*(g1868*t+g1868*u)+(-g2284-g2283)*(g1876*s+g1876*u+3.0*
         g2137*g1876)+(4.0*g2234+2.0*g2222+10240.0*g1786-(3072.0*g1784))*(g2017*
         g2hzz+g2087)+(5184.0*g1852-(288.0*g1863)-(15648.0*g1853))*(g2048*g1954+
         g2060*g2hzz);
        t0=t0+(480.0*g1777-(144.0*g1776)-(784.0*g1778))*(g2172*t+g2172*u)+g2244*
         (g2161*u+g2162*t)+(89.0*g1823-(42.0*g1822)+9.0*g1821)*(g2089*t+g2088*u)
         +(g2209+288.0*g1825)*(g2089+g2088)+g2234*4.0*(g2163*u+g2061)+(4096.0*
         g2hzz+1792.0*g1hzz)*(1.75*g2126*g1877-(g1926*g1889))+288.0*(-(g2048*
         g1925)-(g2139*g2061))*(71.1111*g2129*g1926+9.88889*g2129*g1928+g2165*
         g1928)+g2270*(18.0*t+54.0*u)+g2271*(54.0*t+18.0*u)+g2269*(-(768.0*s)-(
         512.0*t))+(g2231+162.0*g1805-g2252)*(g2161*g2137+g2162*g2137)+s*(g2240-
         g2206+6.0*g2202+2136.0*g2029-(1008.0*g2031)+216.0*g2033)+sw*(g2219-(
         360.0*g1971)+216.0*g1860+72.0*(-g1974-g2082)-(288.0*g2121*g1879));
        t0=t0+t*(g2287+g2205-(4844.0*g2012)+2616.0*g2014-(684.0*g2020)-(72.0*
         g1953))+g1796*(1644.0*g2095-(1656.0*g2094))+g1808*(216.0*g2139*g1808-
         g2255-(72.0*g1920*u))+g1815*(384.0*s-(14.6667*g2245))+g1816*(37.5556*
         g2245-(1280.0*s))+g1817*(1408.0*s-(39.1111*g2245))+g1818*(14.2222*g2245
         -(512.0*s))+g1819*(4928.0*s-(127.111*g2245))+g1820*(46.2222*g2245-(
         1792.0*s))+g1830*576.0*(g2116+g1926)+g1846*(g2285+96.0*g1977)+g1847*(
         g2280+108.0*t)+g1849*(576.0*g2072-g2256)+g1871*(3584.0*g2050-(2048.0*
         g2054))+g1875*(264.0*(g2018+g2017)+1056.0*g2hzz*s)+g1882*576.0*(g1883+
         g1854)+g2143*g1890*(-(2496.0*g2hzz)-(1848.0*g1hzz))+g1887*(7.33333*
         g2245-(528.0*s))+g1888*(896.0*g1944-(512.0*g2063));
        t0=t0+g1915*(432.0*g2167*g1911*g1hzz-(96.0*g2130*g1915))+g1919*(-(8.0*
         g2258)-(2112.0*g2140*mw))+g1927*(128.0*g1813-(352.0*g1812))+g2171*g2127
         *(128.0*g1863*g1863-(252.0*g1917*g1917))+g1936*(-g2277-(96.0*g1862*
         g1862))+g2126*u*(g2238-(4844.0*g1811)+2616.0*g1810-(684.0*g1805)+144.0*
         g1970*sw)+g1942*(504.0*g1890+144.0*g1888)+g2116*mw*(264.0*g2067-(g2284*
         g2142))+g1946*(g2189-(1344.0*g1877*g1hzz)+216.0*g2127*g1894-g2276)+
         g1947*(2.0*g2209+1152.0*g1825+552.0*g1880+1644.0*g1798-(1656.0*g1797)+
         684.0*g1795-g2213)+g1950*256.0*(s+u)+g1954*(-g2278-(72.0*g1814))+g1963*
         (g2275+g2227+g2191)+g1967*(g2236-g2222+1.55556*g2218+6.59259*g2216)+
         g2136*g2134*(896.0*g1895+448.0*g1914)+g1969*(2.0*g2213+144.0*g1901);
        t0=t0+g1972*(672.0*g1879+264.0*g1874)+g2165*g2134*(512.0*g1879+256.0*
         g1874)+g2137*g2131*(-(500.0*g1799)-(3968.0*g1864))+g1983*(g2279+2048.0*
         g1983*g1831)+g1991*(-(128.0*g1846)-(5632.0*g1991*g1831))+g2000*(-(
         1.33333*g2246)-(1344.0*g1865)-(312.0*g1770)-(352.0*g2000*g1828))+g2001*
         (128.0*g2001*g1828-g2279-(3584.0*g1871))+g2005*(-g2286-(1288.0*s))+
         g2006*(1488.0*s+1296.0*t)+g2007*(-g2286-(648.0*s))+g2015*(684.0*g1796-(
         624.0*g2015*g1809))+g2016*(856.0*g2016*g1809-(2112.0*g1871))+g2021*(
         216.0*g1859-(180.0*g2021*g1799))+g2160*g2126*(g2212+2.0*g2196)+g2160*
         g2137*(g2201+g2194+g2192-(856.0*g1794)+624.0*g1793-(216.0*g1792))+g2030
         *(2136.0*s+1532.0*t)+g2032*(-(1008.0*s)-(888.0*t))+g2034*(g2280+252.0*t
         );
        t0=t0+g2039*(g2243+3.0*g2208+g2190+g2285*g1861)+g2040*(3.0*g2220+g2190)+
         g2048*(g2281+10.6667*g2242-(22528.0*g1989)-(11264.0*g1985))+3.55556*
         g2256*g2054*g2hzz+g2160*g2053*(g2196+72.0*g1756+36.0*(-g1757-g1755)-
         g2244)+g2053*(2.0*g2226+g2199+6.0*g2195+g2188)+g2162*g2048*(10.6667*
         g2254+8.0*g2224)+g2172*g2048*(2688.0*g1806-(8.0*g2239)-(5696.0*g1807))+
         g2116*g2048*(10816.0*g1853-(4224.0*g1852))+g2129*g2048*(31296.0*g1883+
         20480.0*g1851)+g2258*g2116*g1hzz+g2238*g2126*t+g2137*t*(g2214+g2198-
         g2276)+g2137*s*(2.0*g2207-(3.66667*g2201)-(5.0*g2194)-(12.5556*g2192)-
         g2215)+g2165*t*(g2246+108.0*g1770)+g2160*u*(g2221-g2275)+g2221*g2160*t+
         g1876*g2hzz*(1056.0*g2016-(1792.0*g2050));
        t0=t0+g2018*g2hzz*(1.5*g2236+g2234+g2218+g2216)+g1877*s*(-(448.0*g1994)-
         (1792.0*g2025))+g1889*g1hzz*(-(256.0*g1954)-(512.0*g1928))+2.0*g2231*
         g1946*t+3.0*g2255*g1941*g1hzz+g2118*(144.0*g2073+g2283*g1920-(g2278*u)-
         g2266)+g2120*(432.0*(g1823+g1821)-(864.0*g1822))-(2.75*g2210*g2122)+
         g2125*(3.0*g2212-g2197+4.0*g2196+72.0*g1901+5200.0*g1811-(2784.0*g1810)
         +720.0*g1805)+g2126*(g2276-(28.0*g2188)-(12.0*g2187)+4128.0*g1843-(
         1728.0*g1842)-(1296.0*g1768)+648.0*(g1769+g1767)+2.0*(-g2198-g2189))+
         g2128*(g2232+7.11111*g2219)+g2129*(3.34375*g2223+g2211+2.11905*g2200+
         2848.0*g2081+20480.0*g1850)+g2133*(g2210+4096.0*g2048*g1854)+g2135*(-(
         12.4444*g2253)-(1.75*g2232)-(448.0*g1974));
        t0=t0+g2136*(2.0*g2206+144.0*(g1947*g1894-(g1952*g1840)))+g2137*(3.0*
         g2240+108.0*g1846-(528.0*g1887)+768.0*g1950-(576.0*g2002)-(896.0*g2018*
         g1877)+792.0*g1875*g1hzz-g2287)+g2138*(-(1.33333*g2228)-(2.0*g2211)-
         g2200-(6144.0*g1850)-(312.0*g2098))+g2143*(4.33333*g2219+264.0*g2082)+
         g2144*(g2242-(4928.0*g1989)-(704.0*g1985))+g2160*(g2288+g2205+g2202-(
         432.0*g2006)+352.0*g1819+76.0*g2012-(696.0*g2014)+396.0*g2020-(256.0*
         g1818)+704.0*g1817-(568.0*g1816)+48.0*g1815+180.0*(-g2033-g2034)+264.0*
         (g2031+g2032)+140.0*(g2029+g2030)+216.0*(g2005+g2007)+128.0*(-g2269-
         g1820)+18.0*(-g2271-g2270)+36.0*(g2273+g1953+g1954*g1840-g2274))+g2204*
         g2161+g2162*(g2275+g2204)+g2165*(g2228+108.0*g2098-g2289);
        msq3=(t0+g1930*g1930*(36.0*g2130+128.0*g2140*g1916)+6.0*g2266*g2168+
         g2118*g1849*576.0*(g1951+g2139*g1849)+g2172*(g2203-g2191-(144.0*g1829)-
         g2290-(3.0*g2227))+g2173*(456.0*g1799-(768.0*g1864))+g1965*g1965*(288.0
         *g1840-(10368.0*g1868))+g1987*g1851*(-(6144.0*g1hzz)-(22528.0*g1987))+
         g1994*g1994*(g2254+g2225)+g2225*g2017*g2017+g1944*g1944*(1792.0*g1851+
         256.0*g1854)+g2281*g2163-(g2288*u)-(576.0*g2115*g1890)-(g2282*g2060)-(
         g2277*g2073))/(g2138*g2295*g2295*(1728.0*(g2116+g1913)-(3456.0*g1928)));
      };
  };
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
   double ff[] = {effpar.fuph, effpar.fdoh, effpar.fchh, effpar.fsth, effpar.ftoh, effpar.fboh };   
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
      Af += -tau*(complex<double>(1,0)+(1-tau)*ftau)*sqrt(2)*smpar.alphas/M_PI/smpar.vev*(1-pow(smpar.vev,3)/sqrt(2.0)/mf[i]*ff[i]);
   };
   complex<double> Aano(-4*ghgg_( &smpar, &effpar, smpar.mh ), 0);
   complex<double> A = Af + Aano;
   double Gamma = pow(smpar.mh,3)/64.0/M_PI*abs(A)*abs(A);
   
   double x1 = *x*(1-pow(smpar.mh,2)/smpar.s)+pow(smpar.mh,2)/smpar.s;
   double x2 = pow(smpar.mh,2)/x1/smpar.s;
   return 1.0/x1/x2*LHAPDF::xfx(x1,smpar.mh,0)*LHAPDF::xfx(x2,smpar.mh,0)/x1/smpar.s*pow(M_PI,2)/8.0/smpar.mh*Gamma*(1-pow(smpar.mh,2)/smpar.s)/2.57e3*1e12;
};
