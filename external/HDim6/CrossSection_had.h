#include <cstdlib>
#include <iostream>
#include <cmath>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* Typdefinitionen */
#pragma once
#include "inputs.h"

#define NCalls 10000
#define Nstep  50

using namespace std;

static double pp_zh_sm, pp_wh_sm, err_zh_sm, err_wh_sm, chi_zh_sm, chi_wh_sm;

void init_hadronic_cs_( sminputs * SMparam );

/* Ratios */
void ratio_tth_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_bb_h_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_ggh_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_pphw_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_pphz_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_bg_bh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );

/* Processes */

void HZRadiation_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err, double * chisq );
void HWRadiation_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err, double * chisq );

/* Internals */

double m_qqp_WH( double * x, size_t dim, void * param );

double m_dD_ZH( double * x, size_t dim, void * param );
double m_uU_ZH( double * x, size_t dim, void * param );

double _pi( double m1, double m2, double s );
double _beta( double m3, double m4, double s );
int  tbounds( double m1, double m2, double m3, double m4, double s, double * lbound, double * ubound );

/* Debug */
// double ZRadiationSM( void ) { return pp_zh_sm; };
// double WRadiationSM( void ) { return pp_wh_sm; };
