#include <cstdlib>
#include <cmath>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* Typdefinitionen */
#include "sminputs.h"
#include "effinputs.h"

/* Globale Variablen zum Speichern der Standardmodell-Wirkungsquerschnitte */
static double uu_zh_sm = 0, cc_zh_sm = 0, dd_zh_sm = 0, ss_zh_sm = 0, bb_zh_sm = 0;
static double ud_wh_sm = 0, us_wh_sm = 0, ub_wh_sm = 0, cd_wh_sm = 0, cs_wh_sm = 0, cb_wh_sm = 0;

/* Zum Initialisieren der Standardmodellwerte */
void init_(         sminputs * SMparam );

/* Ratios */
void ratio_tth_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_bb_h_(  sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err ) ;
void ratio_ggh_(   sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );

void ratio_uu_zh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_dd_zh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_cc_zh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_ss_zh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_bb_zh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );

void ratio_ud_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_us_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_ub_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_cd_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_cs_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );
void ratio_cb_wh_( sminputs * SMparam, effinputs * ESMparam, double * ratio, double * err );

// H-Radiation from Z-Boson
void uu_zh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void cc_zh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void dd_zh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void ss_zh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void bb_zh_(  sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );

// H-Radiation from W-Boson
void ud_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void us_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void ub_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void cd_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void cs_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );
void cb_wh_( sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );

// H-Production in Gluon Fusion
void gg_h_(  sminputs * SMparam, effinputs * ESMparam, double * cSec, double * err );

// H-Production in VBF

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
