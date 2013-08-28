#include "inputs.h"

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

    if ( wz != rhs.wz ) return false;
    if ( ww != rhs.ww ) return false;

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

// Calculate the vertex factors for effective interactions

double ghyy_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  //double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);
  
  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  double sw  = smpar->sw;
  //double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return - pref*pow(sw,2)*(fbb+fww)/2.0;
};

double ghgg_(  sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  //double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  //double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  //double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

  //double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  //double sw  = smpar->sw;
  //double cw  = sqrt(1-sw*sw);
  //double pref= g*g*smpar->vev/2.0;
  return fgg*smpar->vev;
};

double g1hzy_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  //double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  //double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

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
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  //double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

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
 
  //double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  //double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

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
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  //double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

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
  /*
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);
  */
  return 0;
};

double g1hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  
  //double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  //double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  //double sw  = smpar->sw;
  //double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return pref*fw/2.0;
};

double g2hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
 
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  //double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  //double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  //double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  //double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);

  double g   = sqrt( 4.0*M_PI*smpar->alphae )/smpar->sw;
  //double sw  = smpar->sw;
  //double cw  = sqrt(1-sw*sw);
  double pref= g*g*smpar->vev/2.0;
  return -pref*fww;
};

double g3hww_( sminputs * smpar, effinputs * effpar, double s )
{
  if( effpar->override_unitarity )
    s = 0;
  /*
  double fww = effpar->fww/pow(1+s/effpar->rww,effpar->nww);
  double fbb = effpar->fbb/pow(1+s/effpar->rbb,effpar->nbb);
  double fb  = effpar->fb/pow( 1+s/effpar->rb, effpar->nb );
  double fw  = effpar->fw/pow( 1+s/effpar->rw, effpar->nw );
  double fgg = effpar->fgg/pow(1+s/effpar->rgg,effpar->ngg);
  */
  return 0;
};
