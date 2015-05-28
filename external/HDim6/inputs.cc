#include "inputs.h"

sminputs::sminputs() {

	this->alphae = 1./128.952;
	this->alphas = 0.1185;
	this->Gf     = 1.1663787e-5;
	this->mz     = 91.1876;
	this->mh     = 125.09;

  	this->mel    = 0.510998928e-3;
	this->mmu    = 105.6583715e-3;
	this->mta    = 1776.82e-3;
	this->mup    = 0.0023;
	this->mdo    = 0.0048;
	this->mch    = 1.275;
	this->mst    = 0.095;
	this->mto    = 173.34;
	this->mbo    = 4.18;

	this->vud    = 0.97427;
    this->vus    = 0.22536;
	this->vub    = 0.00355;
	this->vcd    = 0.22522;
	this->vcs    = 0.97343;
	this->vcb    = 0.0414;
	this->vtd    = 0.00886;
	this->vts    = 0.0405;
	this->vtb    = 0.99914;

	this->s      = pow( 8000,2 );

    double vev2 = 1. / ( sqrt( 2 ) * this->Gf );
    this->vev = sqrt( vev2 );

    double sin2theta2 = 2. * sqrt( 2. ) * M_PI * this->alphae / ( this->Gf * pow( this->mz, 2 )  );
    double costheta2 = sqrt( 1 - sin2theta2 );
    this->sw = sqrt( ( 1 - costheta2 ) / 2. );

    this->mw = this->mz * sqrt( 1 - pow( this->sw, 2 ) );

}

sminputs::~sminputs() {


}

bool sminputs::operator==( const sminputs& rhs ) const {

    if ( alphae != rhs.alphae ) return false;
    if ( alphas != rhs.alphas ) return false;

    if ( sw != rhs.sw ) return false;

    if ( mel != rhs.mel ) return false;
    if ( mmu != rhs.mmu ) return false;
    if ( mta != rhs.mta ) return false;

    if ( mup != rhs.mup ) return false;
    if ( mdo != rhs.mdo ) return false;
    if ( mch != rhs.mch ) return false;
    if ( mst != rhs.mst ) return false;
    if ( mto != rhs.mto ) return false;
    if ( mbo != rhs.mbo ) return false;

    if ( mw != rhs.mw ) return false;
    if ( mz != rhs.mz ) return false;
    if ( mh != rhs.mh ) return false;

    if ( vev != rhs.vev ) return false;

    if ( vud != rhs.vud ) return false;
    if ( vus != rhs.vus ) return false;
    if ( vub != rhs.vub ) return false;
    if ( vcd != rhs.vcd ) return false;
    if ( vcs != rhs.vcs ) return false;
    if ( vcb != rhs.vcb ) return false;
    if ( vtd != rhs.vtd ) return false;
    if ( vts != rhs.vts ) return false;
    if ( vtb != rhs.vtb ) return false;

    if ( s != rhs.s ) return false;

    return true;

}

bool sminputs::operator!=(const sminputs& rhs) const {

    return !operator==(rhs);

}

effinputs::effinputs() {

    this->fbb  = 0;
    this->fww  = 0;
    this->fgg  = 0;
    this->fb   = 0;
    this->fw   = 0;
    this->fp1  = 0;
    this->fp2  = 0;
    this->fp4  = 0;
    this->fuph = 0;
    this->fdoh = 0;
    this->fchh = 0;
    this->fsth = 0;
    this->ftoh = 0;
    this->fboh = 0;
    this->felh = 0;
    this->fmuh = 0;
    this->ftah = 0;

    // Effekte der folgenden Variablen AUS
    this->override_unitarity = 1;

    this->nbb  = 0; //Alex: Hier stand ueberall 1, ich hab zur Sicherheit mal 0 hin getan
    this->nww  = 0;
    this->ngg  = 0;
    this->nb   = 0;
    this->nw   = 0;
    this->np1  = 0;
    this->np2  = 0;
    this->np4  = 0;

    this->rbb  = 1;
    this->rww  = 1;
    this->rgg  = 1;
    this->rb   = 1;
    this->rw   = 1;
    this->rp1  = 1;
    this->rp2  = 1;
    this->rp4  = 1;

}

effinputs::~effinputs() {

}

pominput::pominput() {

  this->kgg  = 0;  
  this->kbb  = 0;  
  this->ch   = 0;   
  this->khvp = 0; 
  this->khvm = 0; 
  this->cvm  = 0;  

};

pominput::~pominput() {

}

// Calculate the *loop* contributions to the oblique Peskin-Takeuchi parameters
// while we assume the tree level contributions to be absent
// Taken from arXiv:1211.4580
double s_parameter(effinputs * effdata, sminputs * smdata, double cutoff)
{
// Calculates S without alpha
double log_lam_higgs=2*log(cutoff/smdata->mh);
double log_lam_z=2*log(cutoff/smdata->mz);

double mhlam=pow(smdata->mh/cutoff,2);
double mzlam=pow(smdata->mz/cutoff,2);
double vevlam=pow(smdata->vev/cutoff,2);
double cw=sqrt(1-pow(smdata->sw,2));
double sw=smdata->sw;

double prefactor=1.0/(6.0*4.0*(3.1415));

double part1=3*(effdata->fw + effdata->fb)*mhlam*log_lam_higgs;
double part2=2*((5*cw*cw-2)*effdata->fw - (5*cw*cw-3)*effdata->fb)*mzlam*log_lam_higgs;
double part3=-((22*cw*cw -1)*effdata->fw - (30*cw*cw +1)*effdata->fb)*mzlam*log_lam_z;
double part4=-24*(cw*cw*effdata->fww+ sw*sw*effdata->fbb)*mzlam*log_lam_higgs;
double part5=2*effdata->fp2*vevlam*log_lam_higgs;

return prefactor*(part1+part2+part3+part4+part5);
}

double t_parameter(effinputs * effdata, sminputs * smdata, double cutoff)
{
// Calculates T without alpha
double log_lam_higgs=2*log(cutoff/smdata->mh);
double log_lam_z=2*log(cutoff/smdata->mz);

double mhlam=pow(smdata->mh/cutoff,2);
double mzlam=pow(smdata->mz/cutoff,2);
double vevlam=pow(smdata->vev/cutoff,2);
double cw=sqrt(1-pow(smdata->sw,2));
double sw=smdata->sw;

double prefactor=3.0/(4.0*cw*cw*4.0*(3.1415));

double part1=effdata->fb*mhlam*log_lam_higgs;
double part2=(cw*cw*effdata->fw + effdata->fb)*mzlam*log_lam_higgs;
double part3=(2*cw*cw*effdata->fw+(3*cw*cw-1)*effdata->fb)*mzlam*log_lam_z;
double part4=-effdata->fp2*vevlam*log_lam_higgs;

return prefactor*(part1+part2+part3+part4);
}

double u_parameter(effinputs * effdata, sminputs * smdata, double cutoff)
{
// Calculates T without alpha
double log_lam_higgs=2*log(cutoff/smdata->mh);
double log_lam_z=2*log(cutoff/smdata->mz);

double mhlam=pow(smdata->mh/cutoff,2);
double mzlam=pow(smdata->mz/cutoff,2);
double vevlam=pow(smdata->vev/cutoff,2);
double cw=sqrt(1-pow(smdata->sw,2));
double sw=smdata->sw;

double prefactor=-1.0*sw*sw/(3.0*4.0*(3.1415));

double part1=(-4*effdata->fw+5*effdata->fb)*mzlam*log_lam_higgs;
double part2=(2*effdata->fw-5*effdata->fb)*mzlam*log_lam_z;

return prefactor*(part1+part2);
}


// Calculate the vertex factors for effective interactions


void pom_to_eboli( pominput * pomdata, effinputs * effdata, sminputs * smdata )
{
  effdata->fw  =  2.0 * pomdata->khvp/pow(smdata->mw,2) + 4.0 * (pomdata->cvm + pomdata->khvm)/pow(smdata->mw,2);
  effdata->fb  =  2.0 * pomdata->khvp/pow(smdata->mw,2) - 4.0 * (pomdata->cvm + pomdata->khvm)/pow(smdata->mw,2);
  effdata->fww = -2.0 * pomdata->cvm/pow(smdata->mw,2);
  effdata->fbb =  2.0 * pomdata->cvm/pow(smdata->mw,2) -  4.0 * pomdata->kbb/pow(smdata->mw,2);
  effdata->fp2 =  pomdata->ch/pow( smdata->vev, 2 );
  effdata->fgg =  pomdata->kgg/pow( smdata->mw, 2 ) * 4.0 * M_PI * smdata->alphas;

  double kFermion = sqrt(2) / pow( smdata->vev, 3 );
  
  effdata->fuph = pomdata->c_y_uph * smdata->mup * kFermion;   
  effdata->fdoh = pomdata->c_y_doh * smdata->mdo * kFermion;
  effdata->fchh = pomdata->c_y_chh * smdata->mch * kFermion;
  effdata->fsth = pomdata->c_y_sth * smdata->mst * kFermion;
  effdata->ftoh = pomdata->c_y_toh * smdata->mto * kFermion;
  effdata->fboh = pomdata->c_y_boh * smdata->mbo * kFermion;
  effdata->felh = pomdata->c_y_elh * smdata->mel * kFermion;
  effdata->fmuh = pomdata->c_y_muh * smdata->mmu * kFermion; 
  effdata->ftah = pomdata->c_y_tah * smdata->mta * kFermion;

};

double ghyy_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  double pref= g*g*smpar->vev/2.0;
  return - pref*pow(sw,2)*(fbb+fww)/2.0;
};

double ghgg_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);
  return fgg*smpar->vev;
};

double g1hzy_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return pref*sw*(fw-fb)/2.0/cw;
};

double g2hzy_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return pref*sw*(2.0*sw*sw*fbb-2.0*cw*cw*fww)/2.0/cw;
};

double g1hzz_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return pref*(cw*cw*fw+sw*sw*fb)/2.0/cw/cw;
};

double g2hzz_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return -pref*(pow(sw,4)*fbb+pow(cw,4)*fww)/2.0/cw/cw;
};

double g3hzz_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;

  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return pow(smpar->mz*smpar->vev/2.0,2)*sqrt(sqrt(2)*smpar->Gf)*(fp1+2*fp4-2*fp2);
};

double g1hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double pref= g*g*smpar->vev/2.0;
  return pref*fw/2.0;
};

double g2hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double pref= g*g*smpar->vev/2.0;
  return -pref*fww;
};

double g3hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;

  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1.0/2.0*pow(smpar->mw*smpar->vev,2)*sqrt(sqrt(2)*smpar->Gf)*(2*fp4-fp1-2*fp2);
};

double fuph_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mup*effpar->fuph;
};

double fdoh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mdo*effpar->fdoh; 
};

double fchh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mch*effpar->fchh;
};

double fsth_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mst*effpar->fsth;
};

double ftoh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mto*effpar->ftoh;
};

double fboh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mbo*effpar->fboh;
};

double ftah_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mta*effpar->ftah;
};

double fmuh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mmu*effpar->fmuh;
};

double felh_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fp1 = effpar->fp1/pow(1+s/effpar->rp1,effpar->np1);
  double fp2 = effpar->fp2/pow(1+s/effpar->rp2,effpar->np2);
  double fp4 = effpar->fp4/pow(1+s/effpar->rp4,effpar->np4);
  return 1-pow(smpar->vev/2.0,2)*(fp1+2*fp2+fp4)-pow(smpar->vev,3)/sqrt(2)/smpar->mel*effpar->felh;
};

double higgsrenorm2(sminputs * smpar, effinputs * effpar)
{
 // The square of the Higgs field renormalization as it will to our
 // approximation be inherited by all cross sections and decay widths
 // involving one Higgs.
 return 1.0/(1.0 + (effpar->fp2)*pow(smpar->vev,2) );
}
