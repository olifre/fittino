#include "inputs.h"

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
