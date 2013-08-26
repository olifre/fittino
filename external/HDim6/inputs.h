#pragma once
#include <cmath>

struct sminputs {
  /* Coupling Constants */
  double alphae;		// Electromagnetic Coupling Constants
  double alphas;		// Strong Coupling Constant
  
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
  
  /* Widths */
  double wz;			// Z-decay Width (SM)
  double ww;			// W-decay Width (SM)
  
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
  double fbb;			// Coefficient of PhiFS(B)FS(B)Phi                 -- currently not in operator base, = 0, might change though
  double fww;			// Coefficient of PhiFS(W)FS(W)Phi
  double fgg;			// Coefficient of PhiFS(G)FS(G)Phi
  double fb;			// Coefficient of (DPhi)FS(B)(DPhi)
  double fw;			// Coefficient of (DPhi)FS(W)(DPhi)
   
   /* Additional Yukawa Coefficients */
  double fuph;                 // Modification of Yukawa-Coupling to up-Quarks     -- not relevant for fit, = 0
  double fdoh;                 // Modification of Yukawa-Coupling to down-Quarks   -- not relevant for fit, = 0
  double fchh;                 // Modification of Yukawa-Coupling to charm-Quarks  -- not relevant for fit, = 0
  double fsth;                 // Modification of Yukawa-Coupling to strange-Quarks-- not relevant for fit, = 0
  double ftoh;                 // Modification of Yukawa-Coupling to top-Quarks    -- not relevant for fit, = 0, in my opinion it should however be considered
  double fboh;                 // Modification of Yukawa-Coupling to bottom-Quarks
   
  double felh;                 // Modification of Yukawa-Coupling to Electrons     -- not relevant for fit, = 0
  double fmuh;                 // Modification of Yukawa-Coupling to Muons         -- not relevant for fit, = 0
  double ftah;                 // Modification of Yukawa-Coupling to Taus          
   
   /* Calculated Couplings to tensor structure */
   /* This coefficients have to be calculated from above given parameters */

  double ghyy;                 // coefficient of H FS(A)FS(A)-Vertex
  double g1hzy;                // coefficient of del(nu,H) FS(A)*del(mu,Z)-Vertex
  double g2hzy;                // coefficient of H FS(A)FS(Z)-Vertex
  double g1hzz;                // coefficient of FS(Z)*Z(mu)*del(nu,H)-Vertex
  double g2hzz;                // coefficient of H FS(Z)FS(Z)-Vertex
  double g3hzz;                // coefficient of H Z(mu)Z(mu)-Vertex
  double g1hww;                // coefficient of FS(W+)W-(mu)del(nu,H) + h.c. Vertex
  double g2hww;                // coefficient of FS(W+) FS(W-) H Vertex
  double g3hww;                // coefficient of H W+(mu)W-(mu)-Vertex
  
  /* damping coefficients (unitarity, Alex), descriptions to follow */

  double nbb;
  double nww;
  double nb;
  double nw;
  double ngg;
  double ntop;
  double nbot;
  double ntau;

  double rbb;
  double rww;
  double rb;
  double rw;
  double rgg;
  double rtop;
  double rbot;
  double rtau;
};

void update_effinputs_( sminputs * smvalues, effinputs * effvalues );
