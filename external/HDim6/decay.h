/* Berechnet die Zerfallsbreiten in der effektiven Feldtheorie          */
/* Parameter sind Standardmodellparameter (Massen und Kopplungen        */
/* Die Parameter der effektiven Theorie				        */
/* Rueckgabewert ist die Zerfallsbreite in GeV, wird in pWidth abgelegt */

/* Standardbibliotheke */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* Typdefinitionen */
#include "inputs.h"

#define NSteps 30
#define NCalls 10000

/* global values to be initialized with effective widths and errors in order to calculate Branching Ratios and total width */

static double T_hglgl_eff, T_hgaga_eff, T_helel_eff, T_hmumu_eff, T_htata_eff, T_hupup_eff, T_hdodo_eff, T_hchch_eff, T_hstst_eff, T_hbobo_eff,
              T_hzz_eff, T_hww_eff, T_eff;

static double err_hglgl_eff, err_hgaga_eff, err_helel_eff, err_hmumu_eff, err_htata_eff, err_hupup_eff, err_hdodo_eff, err_hchch_eff, err_hstst_eff, 
              err_hbobo_eff, err_hzz_eff, err_hww_eff, err_T_eff;

static double chi_hglgl_eff, chi_hgaga_eff, chi_helel_eff, chi_hmumu_eff, chi_htata_eff, chi_hupup_eff, chi_hdodo_eff, chi_hchch_eff, chi_hstst_eff,
              chi_hbobo_eff, chi_hzz_eff, chi_hww_eff;

/* Initialization of Higgs partial widths in effective model */

void initeffwidths_( sminputs * smpar, effinputs * effpar );

/* Returns the total width */

void totalwidth_( double * tWidth, double * tError, double * tChi );

/* Branching Ratios */

void br_hbb_(     double * br, double * err, double * chi );
void br_hcc_(     double * br, double * err, double * chi );
void br_hss_(     double * br, double * err, double * chi );
void br_htautau_( double * br, double * err, double * chi );

void br_hww_(     double * br, double * err, double * chi );
void br_hzz_(     double * br, double * err, double * chi );

void br_hglgl_(   double * br, double * err, double * chi );
void br_hgaga_(   double * br, double * err, double * chi );

/* only Top-Loops- and W-Loops in Photon decay included */

void hglgl_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hgaga_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

/* Leptonische Zweikoerperzerfaelle */

void htata_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hmumu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void helel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

/* Hadronische Zweikoerperzerfaelle */

void hupup_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hdodo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hchch_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hstst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hbobo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

/* Dreikoerperzerfaelle ueber schwache Eichbosonen */
/* Um Vierkoerperzerfaelle zu erhalten, muss mit den */
/* entsprechenden Branching Rations multipliziert werden */

void hztata_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzmumu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzelel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hznunu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );

void hzdodo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzupup_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzstst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzchch_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hzbobo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );

void hwtanta_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwmunmu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwelnel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );

void hwupdo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwupst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwupbo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwchdo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwchst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );
void hwchbo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError, double * chi );

/* Interne Integration der differentiellen Zerfallsbreiten */

double mHWl(   double * x, size_t dim, void * par );	// H to W and dileptonstate
double mHWqqp( double * x, size_t dim, void * par );	// H to W and two quarks

double mHZdD(  double * x, size_t dim, void * par );	// H to ZZ* to Z and two down-type quarks
double mHZuU(  double * x, size_t dim, void * par );	// H to ZZ* to Z and two up-type quarks
double mHZlL(  double * x, size_t dim, void * par );	// H to ZZ* to two Leptons
double mHZnN(  double * x, size_t dim, void * par );	// H to ZZ* to two Neutrinos */

/* Definitionen fuer Dalitz-Variablen, 3-Partikel-Phasenraum-Integration */
double _E2S(double m12, double m1sq, double m2sq);
double _E3S(double Msq, double m12, double m3sq);
void _m23lim(double Msq, double m1sq, double m2sq, double m3sq, double m12, double * m23max, double * m23min );
