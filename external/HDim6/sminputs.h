typedef struct {
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
  
  /* Tree Level Cross Sections, to be filled in by the program */
  double pp_wh_sm;	// W-Radiation
  double pp_zh_sm;	// Z-Radiation
  double pp_jjh_sm;	// VBF
} sminputs;
