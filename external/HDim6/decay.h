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
#include "sminputs.h"
#include "effinputs.h"

#define NSteps 30
#define NCalls 10000

/* Globale Variablen fuer Standardmodell-Breiten */

static double T_hglgl_sm, T_hgaga_sm, T_helel_sm, T_hmumu_sm, T_htata_sm, T_hupup_sm, T_hdodo_sm, T_hchch_sm, T_hstst_sm, T_hbobo_sm,
              T_hzz_sm, T_hww_sm, T_sm;
static double T_hglgl_eff, T_hgaga_eff, T_helel_eff, T_hmumu_eff, T_htata_eff, T_hupup_eff, T_hdodo_eff, T_hchch_eff, T_hstst_eff, T_hbobo_eff,
              T_hzz_eff, T_hww_eff, T_eff;

/* Initialisiernung der Standardmodellbreiten und Effektiven Breiten */

void initsmwidths_(  sminputs * smpar );
void initeffwidths_( sminputs * smpar, effinputs * effpar );

/* Branching Ratios as requested by Higgs Bounds */

void br_hbb_(     double * br );
void br_htautau_( double * br );
void br_hww_(     double * br );
void br_hgaga_(   double * br );
void br_hzz_(     double * br );

/* Zefaelle ueber SM-Loops in der Naeherung dass nur schwere Teilchen umlaufen */

void hglgl_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );	// Higgs nach Gluon Gluon
void hgaga_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );	// Higgs nach Gamma Gamma

/* Leptonische Zweikoerperzerfaelle */

void htata_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hmumu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void helel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

/* Hadronische Zweikoerperzerfaelle */

void hupup_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hdodo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hchch_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hstst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void htoto_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hbobo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

/* Dreikoerperzerfaelle ueber schwache Eichbosonen */
/* Um Vierkoerperzerfaelle zu erhalten, muss mit den */
/* entsprechenden Branching Rations multipliziert werden */

void hztata_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzmumu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzelel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

void hznunu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

void hzdodo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzupup_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzstst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzchch_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hzbobo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

void hwtanta_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwmunmu_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwelnel_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

void hwupdo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwupst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwupbo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwchdo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwchst_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwchbo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwtodo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwtost_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );
void hwtobo_( sminputs * SMpar, effinputs * Effpar, double * pWidth, double * pError );

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