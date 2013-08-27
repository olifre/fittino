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

#define NCALLS 15000
#define NRUN   30

// Cuts
#define pt3min 5
#define pt4min 5
#define CUTS

static double cs_5flavorSM, err_5flavorSM, chi_5flavorSM;

/* Initialize VBF Standard Model Values */

void vbf_init_cs_( sminputs * smpar );

/* Return normalized Value of CS */

void ratio_vbf_5flav_( sminputs * smpar, effinputs * effpar, double * ratio, double * error, double * chisq );

/* Calculates the Cross Section */

void udcsb_jjh_( sminputs * smpar, effinputs * effpar, double * cs, double * err, double * chisq );
double udcsb_jjh( double * x, size_t dim, void * params );

/* Diagramme */
double dd_ddh_massless(   double * x, size_t dim, void * params );
double uu_uuh_massless(   double * x, size_t dim, void * params );
double ud_duh_NoCKM_massless(   double * x, size_t dim, void * params ); // Diagramme ohne W
double ud_duh_CKMsQ_massless(   double * x, size_t dim, void * params ); // Diagramme mit einem W
double ud_dpuph_massless( double * x, size_t dim, void * params );
