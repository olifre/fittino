/* Standardbibliotheke */
#include <cstdlib>
#include <iostream>
#include <cmath>
#include <string>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* LHAPDF Header */
#include <LHAPDF/LHAPDF.h>

/* Typdefinitionen */
#include "sminputs.h"
#include "effinputs.h"

typedef struct {
   sminputs sm;
   effinputs eff;
}VBFParam;

#define NCALLS 10000
#define NRUN   20

static double CS_SM, ERR_SM;

void init_( sminputs * smpar );

/* Auf SM Normierter WQ */

void ratio_( sminputs * smpar, effinputs * effpar, double * ratio, double * err );

/* Teilweise Querschnitte */

void u_and_d_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );
void udcs_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );
void udcsb_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );

double ud_jjh(    double * x, size_t dim, void * params );
double udcs_jjh(  double * x, size_t dim, void * params );
double udcsb_jjh( double * x, size_t dim, void * params );

/* Voller Querschnitt pp->XX H */
void cs_pp_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err );
double pp_jjh_( double * x, size_t dim, void * params );

/* Diagramme */
double dd_ddh_massless(   double * x, size_t dim, void * params );
double uu_uuh_massless(   double * x, size_t dim, void * params );
double ud_duh_NoCKM_massless(   double * x, size_t dim, void * params ); // Diagramme ohne W
double ud_duh_CKMsQ_massless(   double * x, size_t dim, void * params ); // Diagramme mit einem W
double ud_dpuph_massless( double * x, size_t dim, void * params );
