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

#define VBFCALLS 50000
#define VBFRUN   10

// Cuts
#define pt3min 5
#define pt4min 5
#define CUTS

static double cs_5flavorSM, err_5flavorSM, chi_5flavorSM;
static double cs_2flavorSM, err_2flavorSM, chi_2flavorSM;

/* Initialize VBF Standard Model Values */

void vbf_init_cs_( sminputs * smpar );
void vbf_init_2flav_sm_( sminputs * smpar );

/* Return normalized Value of CS */

void ratio_vbf_5flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );
void ratio_vbf_2flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );

/* Calculates the Cross Section */

void udcsb_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );
double udcsb_jjh( double * x, size_t dim, void * params );

void ud_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );
double ud_jjh( double * x, size_t dim, void * params );

/* Diagramme */
double dd_ddh_massless(   double * x, size_t dim, void * params );
double uu_uuh_massless(   double * x, size_t dim, void * params );
double ud_duh_NoCKM_massless(   double * x, size_t dim, void * params ); // Diagramme ohne W
double ud_duh_CKMsQ_massless(   double * x, size_t dim, void * params ); // Diagramme mit einem W
double ud_dpuph_massless( double * x, size_t dim, void * params );
