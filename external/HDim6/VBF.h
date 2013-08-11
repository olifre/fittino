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

/* Typdefinitionen */
#include "inputs.h"

typedef struct {
   sminputs sm;
   effinputs eff;
}VBFParam;

#define NCALLS 10000
#define NRUN   20

static double cs_2flavorSM, cs_4flavorSM, cs_5flavorSM, err_2flavorSM, err_4flavorSM, err_5flavorSM;
static double chi_2flavorSM, chi_4flavorSM, chi_5flavorSM;

/* Initialize VBF Standard Model Values */

void vbf_init_cs_( sminputs * smpar );

/* Return the Ratios */

void ratio_vbf_2flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );
void ratio_vbf_4flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );
void ratio_vbf_5flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );

/* Cross Sections in 2,4 and 5 flavor scheme */

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
