#include "gaugecpl.h"

/* triple gauge couplings */

double HDim6::d_kappa_y( sminputs * smpar, effinputs * effpar )
{
  double g = sqrt(4.*M_PI*smpar->alphae)/smpar->sw;
  return pow(g*smpar->vev,2)/8.*(effpar->fw + effpar->fb);
};

double HDim6::d_kappa_z( sminputs * smpar, effinputs * effpar )
{
  double g = sqrt(4.*M_PI*smpar->alphae)/smpar->sw;
  double cw = sqrt(1.-pow(smpar->sw,2));
  return pow(g*smpar->vev/cw,2)/8.*(pow(cw,2)*effpar->fw-pow(smpar->sw,2)*effpar->fb);
};

double HDim6::d_g1_y(    sminputs * smpar, effinputs * effpar )
{
  return 0;
};

double HDim6::d_g1_z(    sminputs * smpar, effinputs * effpar )
{
  double g = sqrt(4.*M_PI*smpar->alphae)/smpar->sw;
  double cw = sqrt(1.-pow(smpar->sw,2));
  return pow(g*smpar->vev/cw,2)/8.*effpar->fw;
};

/* quartic gauge couplings */

double HDim6::d_g1_ww(   sminputs * smpar, effinputs * effpar )
{
  return pow(smpar->mw,2)/2.*effpar->fw;
};

double HDim6::d_g2_ww(   sminputs * smpar, effinputs * effpar )
{
  return pow(smpar->mw,2)/4.*effpar->fw;
};

double HDim6::d_g1_yy(   sminputs * smpar, effinputs * effpar )
{
  return 0;
};

double HDim6::d_g2_yy(   sminputs * smpar, effinputs * effpar ) 
{
  return 0;
};

double HDim6::d_g1_zz(   sminputs * smpar, effinputs * effpar )
{
  return pow(smpar->mw,2)/(1.-pow(smpar->sw,2))*effpar->fw;
};

double HDim6::d_g2_zz(   sminputs * smpar, effinputs * effpar )
{
  return pow(smpar->mw,2)/(1.-pow(smpar->sw,2))/2.*effpar->fw;
};

double HDim6::d_g1_zy(   sminputs * smpar, effinputs * effpar )
{
  return d_g1_zz( smpar, effpar );
};

double HDim6::d_g2_zy(   sminputs * smpar, effinputs * effpar )
{
  return d_g2_zz( smpar, effpar );
};
