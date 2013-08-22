#pragma once
#include <cstdlib>
#include <cmath>

#include "inputs.h"

namespace HDim6 {

  using namespace std;

  /* triple gauge couplings */

  double d_kappa_y( sminputs * smpar, effinputs * effpar );
  double d_kappa_z( sminputs * smpar, effinputs * effpar );
  double d_g1_y(    sminputs * smpar, effinputs * effpar );
  double d_g1_z(    sminputs * smpar, effinputs * effpar );

  /* quartic gauge couplings */
  
  double d_g1_ww(   sminputs * smpar, effinputs * effpar );
  double d_g2_ww(   sminputs * smpar, effinputs * effpar );
  double d_g1_yy(   sminputs * smpar, effinputs * effpar );
  double d_g2_yy(   sminputs * smpar, effinputs * effpar );
  double d_g1_zz(   sminputs * smpar, effinputs * effpar );
  double d_g2_zz(   sminputs * smpar, effinputs * effpar );
  double d_g1_zy(   sminputs * smpar, effinputs * effpar );
  double d_g2_zy(   sminputs * smpar, effinputs * effpar );

}
