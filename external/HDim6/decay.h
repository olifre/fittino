/* Berechnet die Zerfallsbreiten in der effektiven Feldtheorie          */
/* Parameter sind Standardmodellparameter (Massen und Kopplungen        */
/* Die Parameter der effektiven Theorie				        */
/* Rueckgabewert ist die Zerfallsbreite in GeV, wird in pWidth abgelegt */

/* Standardbibliotheke */
#include <iostream>
#include <cstdlib>
#include <cmath>

/* Bibliotheken der GSL zur numerischen Integration */
#include <gsl/gsl_math.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

/* Komplexe Zahlen */
#include <complex>

/* Typdefinitionen */
#include "inputs.h"

using namespace std;

#define DSteps 30
#define DCalls 10000

/* global values to be initialized with effective widths and errors in order to calculate Branching Ratios and total width */

static double T_hglgl_eff, T_hgaga_eff, T_hmumu_eff, T_htata_eff, T_hchch_eff, T_hstst_eff, T_hbobo_eff,
              T_hzz_eff, T_hww_eff, T_eff, T_hgaz_eff;

static double err_hglgl_eff, err_hgaga_eff, err_hmumu_eff, err_htata_eff, err_hchch_eff, err_hstst_eff, 
              err_hbobo_eff, err_hzz_eff, err_hww_eff, err_T_eff, err_hgaz_eff;

static double chi_hglgl_eff, chi_hgaga_eff, chi_hmumu_eff, chi_htata_eff, chi_hchch_eff, chi_hstst_eff,
              chi_hbobo_eff, chi_hzz_eff, chi_hww_eff, chi_hgaz_eff;

static double T_hglgl_sm, T_hgaga_sm, T_hmumu_sm, T_htata_sm, T_hchch_sm, T_hstst_sm, T_hbobo_sm,
              T_hzz_sm, T_hww_sm, T_sm, T_hgaz_sm;

static double err_hglgl_sm, err_hgaga_sm, err_hmumu_sm, err_htata_sm, err_hchch_sm, err_hstst_sm,
              err_hbobo_sm, err_hzz_sm, err_hww_sm, err_T_sm, err_hgaz_sm;

static double chi_hglgl_sm, chi_hgaga_sm, chi_hmumu_sm, chi_htata_sm, chi_hchch_sm, chi_hstst_sm,
              chi_hbobo_sm, chi_hzz_sm, chi_hww_sm, chi_hgaz_sm;


/* Initialization of Higgs partial widths in effective and standard model */

void initeffwidths_( sminputs * smpar, effinputs * effpar ); // initialize tree level effective widths
void initsmwidths_(  sminputs * smpar );                     //initialize tree level sm widths

/* Totale Breite */

void totalwidth_( sminputs * smpar, effinputs * effpar, double * tWidth, double * tError, double * tChi );

/* Branching Ratios */

void br_hbb_(     sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_hcc_(     sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_hss_(     sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_htautau_( sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );

void br_hww_(     sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_hzz_(     sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );

void br_hglgl_(   sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_hgaga_(   sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );
void br_hgaz_(    sminputs * smpar, effinputs * effpar, double * br, double * err, double * chi );

/* K-Faktor der Branching Rations BR(eff)/BR(SM)|Tree */

void k_hbb_(     sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_hcc_(     sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_hss_(     sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_htautau_( sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );

void k_hww_(     sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_hzz_(     sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );

void k_hglgl_(   sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_hgaga_(   sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );
void k_hgaz_(    sminputs * smpar, effinputs * effpar, double * k, double * err, double * chi );


/* Zerfaelle ueber Top- und W-Loops */

void hglgl_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hgaga_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hgaz_(  sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );

/* Zerfaelle in zwei Leptonen */

void htata_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hmumu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
// void helel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );

/* Zerfaelle in zwei Quarks */

// void hupup_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
// void hdodo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hchch_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hstst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );
void hbobo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError );

/* Zerfaelle in elektroschwache Eichbosonen mit der Naeherung das ein Boson On-Shell ist */

void hww_(     sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzz_(     sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );

/* Dreikoerperzerfaelle ueber schwache Eichbosonen */

void hztata_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzmumu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzelel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hznunu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );

void hzdodo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzupup_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzstst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzchch_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hzbobo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );

void hwtanta_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwmunmu_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwelnel_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );

void hwupdo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwupst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwupbo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwchdo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwchst_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );
void hwchbo_( sminputs * smpar, effinputs * effpar, double * pWidth, double * pError, double * chi );

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

/* Amplituden und Schleifenfunktionen fuer H->yy,H->gg und H->Zy */

complex< double > f_(  double tau );
complex< double > g_(  double tau );
complex< double > I1_( double a, double b );
complex< double > I2_( double a, double b );
