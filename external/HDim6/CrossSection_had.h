#include <cstdlib>
#include <iostream>
#include <cmath>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* LHA PDF */
#include <LHAPDF/LHAPDF.h>

/* Typdefinitionen */
#include "sminputs.h"
#include "effinputs.h"

#define NCalls 10000
#define Nstep  30

using namespace std;

static double pp_zh_sm, pp_wh_sm;

void init_( sminputs * SMparam );

/* Ratios */
void ratio_tth_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_bb_h_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_ggh_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_pphw_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );
void ratio_pphz_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err, double * chisq );

/* Processes */

void HZRadiation_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err, double * chisq );
void HWRadiation_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err, double * chisq );

/* Interne Funktionen */

/*** qqp_WH Matrixelemente ***/
double m_qqp_WH( double * x, size_t dim, void * param );

/*** qQ_ZH Matrixelemente ***/
double m_dD_ZH( double * x, size_t dim, void * param );
double m_uU_ZH( double * x, size_t dim, void * param );

/*** Zweiteilchen-Phasenraum ***/
double _pi( double m1, double m2, double s );
double _beta( double m3, double m4, double s );
int  tbounds( double m1, double m2, double m3, double m4, double s, double * lbound, double * ubound );
