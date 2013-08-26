#include "inputs.h"

bool sminputs::operator==( const sminputs& rhs ) {

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

void update_effinputs_( sminputs * smvalues, effinputs * effvalues )
{
  double ee = sqrt( 4.*M_PI*smvalues->alphae );
  double sw = smvalues->sw;
  double g  = ee/sw;
  double cw = sqrt( 1.0 - sw*sw );
  double pref = pow(g,2.)*smvalues->vev/2;

  // Calculating the Vertex Factors

  effvalues->ghyy  =-pref*(effvalues->fbb + effvalues->fww)/2.0;
  effvalues->g1hzy = pref*sw*(effvalues->fw - effvalues->fb)/2.0/cw;
  effvalues->g2hzy = pref*sw*(2.0*pow(sw,2.)*effvalues->fbb-2*pow(cw, 2.)*effvalues->fww)/2.0/cw;
  effvalues->g1hzz = pref*(pow(cw,2)*effvalues->fw+pow(sw,2)*effvalues->fb)/2./cw/cw;
  effvalues->g2hzz =-pref*(pow(sw,4)*effvalues->fbb+pow(cw,4)*effvalues->fww)/2./cw/cw;
  effvalues->g3hzz = 0;
  effvalues->g1hww = pref*effvalues->fw/2.;
  effvalues->g2hww =-pref*effvalues->fww;
  effvalues->g3hww = 0;
};
