#pragma once
#include <cmath>

struct sminputs {

  sminputs();
  ~sminputs();

  /* Coupling Constants */
  double alphae;		// Electromagnetic Coupling Constants
  double alphas;		// Strong Coupling Constant
  double Gf;                    // Fermi Constant
  
  /* Weinberg Angle */
  double sw;			// Sine of the Weinberg Angle
  
  /* fermion masses */
  double mel;			// Electron Mass
  double mmu;			// Muon Mass
  double mta;			// Tau Mass
  
  double mup;			// U-Quark Mass
  double mdo;			// D-Quark Mass
  double mch;			// C-Quark Mass
  double mst;			// S-Quark Mass
  double mto;			// T-Quark Mass
  double mbo;			// B-Quark Mass
  
  /* Gauge-Boson Masses */
  double mw;			// W-Boson Mass
  double mz;			// Z-Boson Mass
  double mh;			// Higgs-Mass
  
  /* In future models v might need to be calculated */
  
  double vev;
  
  /* CKM Matrix Elements */
  
  double vud;
  double vus;
  double vub;
  double vcd;
  double vcs;
  double vcb;
  double vtd;
  double vts;
  double vtb;
  double s;

  // State of the art SM Branching Ratios for a 126 GeV Higgs particle   //
  // from twiki.cern.ch/twiki/bin/view/LHCPhysics/CERNYelloReportPageBR2 //
  // Required to take higher order corrections inot account              //

  double br_h_bb, err_h_bb;
  double br_h_cc, err_h_cc;
  double br_h_ss, err_h_ss;
  double br_h_tautau, err_h_tautau;
  double br_h_mm, err_h_mm;
  double br_h_ww, err_h_ww;
  double br_h_zz, err_h_zz;
  double br_h_gg, err_h_gg;
  double br_h_yy, err_h_yy;  
  double br_h_yz, err_h_yz;
  double sm_width, sm_width_err;

  bool operator==( const sminputs& rhs ) const;
  bool operator!=( const sminputs& rhs ) const;

};

struct effinputs {

  effinputs();
  ~effinputs();

  double fbb;			// Coefficient of PhiFS(B)FS(B)Phi          (Tyler Corbett: = 0, Pomerol: neq 0 )
  double fww;			// Coefficient of PhiFS(W)FS(W)Phi
  double fgg;			// Coefficient of PhiFS(G)FS(G)Phi
  double fb;			// Coefficient of (DPhi)FS(B)(DPhi)
  double fw;			// Coefficient of (DPhi)FS(W)(DPhi)

  double fp1;                   // Coefficient of (DPhi*Phi)(Phi*DPhi)     = 0 (Tyler Corbett, Pomarol)
  double fp2;                   // Coefficient of .5*d(Phi*Phi)*d(Phi*Phi)  (Tyler Corbett: =0, Pomarol: neq 0)
  double fp4;                   // Coefficient of DPhi*DPhi*(Phi*Phi)      = 0 (Tyler Corbett, Pomarol)
   
   /* Additional Yukawa Coefficients */
  double fuph;                 // Modification of Yukawa-Coupling to up-Quarks     -- not relevant for fit, = 0
  double fdoh;                 // Modification of Yukawa-Coupling to down-Quarks   -- not relevant for fit, = 0
  double fchh;                 // Modification of Yukawa-Coupling to charm-Quarks  -- not relevant for fit, = 0
  double fsth;                 // Modification of Yukawa-Coupling to strange-Quarks-- not relevant for fit, = 0
  double ftoh;                 // Modification of Yukawa-Coupling to top-Quarks    (Tyler Corbett: =0, Pomerol: neq 0)
  double fboh;                 // Modification of Yukawa-Coupling to bottom-Quarks
   
  double felh;                 // Modification of Yukawa-Coupling to Electrons     -- not relevant for fit, = 0
  double fmuh;                 // Modification of Yukawa-Coupling to Muons         -- not relevant for fit, = 0
  double ftah;                 // Modification of Yukawa-Coupling to Taus          
   
  /* damping coefficients (unitarity, Alex), descriptions to follow */

  double nbb;
  double nww;
  double ngg;
  double nb;
  double nw;
  double nbw;

  double np1;
  double np2;
  double np4;

  double ntop;
  double nbot;
  double ntau;

  double rbb;
  double rww;
  double rgg;
  double rb;
  double rw;
  double rbw;

  double rp1;
  double rp2;
  double rp4;

  double rtop;
  double rbot;
  double rtau;

  // set to one to neglect effects of unitarity_coefficients
  int override_unitarity;

};

// Minimale Struktur die die Pomarol-Koeffizienten zusammenfasst

struct pominput{

  pominput();
  ~pominput();

  double kgg;  // Coefficient of gs^2H^2FS(G)FS(G)
  double kbb;  // Coefficient of g'^2H^2FS(B)FS(B)
  double ch;   // Coefficient of 1/2*(d_mu H^2)^2
  double khvp; // kappa_hv_+ Coefficient of (O_HW+O_HB)/2
  double khvm; // kappa_hv_- Coefficient of (O_HW-O_HB)/2
  double cvm;  // c_v-       Coefficient of (O_W-O_B)/2

  double c_y_uph; 
  double c_y_doh;
  double c_y_chh;
  double c_y_sth;
  double c_y_toh;
  double c_y_boh;
  double c_y_elh;
  double c_y_muh;
  double c_y_tah;

};

// Funktion rechnet die Pomarol-Koeffizienten in Eboli-Koeffizienten um //
// Da die W-Masse und v in den Umrechnungen benoetigt werden, muessen die SM-Inputs gesetzt werden!

void pom_to_eboli( pominput * pomdata, effinputs * effdata, sminputs * smdata );

// Calculate the vertex factors for effective interactions

double ghyy_(  sminputs * smpar, effinputs * effpar, double s );
double ghgg_(  sminputs * smpar, effinputs * effpar, double s );
double g1hzy_( sminputs * smpar, effinputs * effpar, double s );
double g2hzy_( sminputs * smpar, effinputs * effpar, double s );
double g1hzz_( sminputs * smpar, effinputs * effpar, double s );
double g2hzz_( sminputs * smpar, effinputs * effpar, double s );
double g3hzz_( sminputs * smpar, effinputs * effpar, double s );
double g1hww_( sminputs * smpar, effinputs * effpar, double s );
double g2hww_( sminputs * smpar, effinputs * effpar, double s );
double g3hww_( sminputs * smpar, effinputs * effpar, double s );

double fuph_(  sminputs * smpar, effinputs * effpar, double s );
double fdoh_(  sminputs * smpar, effinputs * effpar, double s );
double fchh_(  sminputs * smpar, effinputs * effpar, double s );
double fsth_(  sminputs * smpar, effinputs * effpar, double s );
double ftoh_(  sminputs * smpar, effinputs * effpar, double s );
double fboh_(  sminputs * smpar, effinputs * effpar, double s );
double ftah_(  sminputs * smpar, effinputs * effpar, double s );
double fmuh_(  sminputs * smpar, effinputs * effpar, double s );
double felh_(  sminputs * smpar, effinputs * effpar, double s );

double higgsrenorm2(sminputs * smpar, effinputs * effpar); // For a global treatment of the scaling of couplings with f_p2 O_H

