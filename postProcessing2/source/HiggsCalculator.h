#ifndef HIGGS_CALCULATOR_H
#define HIGGS_CALCULATOR_H

#include "FloatStorage.h"
#include "TMatrixDSym.h"
#include "TVectorD.h"
#include "TVectorT.h"
#include "TMatrixT.h"
#include "TMatrixTSym.h"
#include "TMatrixDSymEigen.h"
#include "TRandom3.h"
#include "TMath.h"


extern "C" { void initialize_higgssignals_latestresults_(int* nHiggsneut, int* nHiggsplus) ;}
extern "C" { void initialize_higgssignals_for_fittino_(int* nHiggsneut, int* nHiggsplus) ;}
extern "C" { void setup_output_level_(int* outputLevel);}
extern "C" { void setup_pdf_(int* pdf_in);}// module, not subroutine
extern "C" { void setup_rate_uncertainties_(double dCS[], double dBR[]);}
extern "C" { void setup_higgs_to_peaks_assignment_iterations_(int* iteration);}
extern "C" { void higgssignals_neutral_input_massuncertainty_(double dMh[]);}
extern "C" { void higgsbounds_neutral_input_effc_(double* Mh, double* GammaTotal, double* g2hjss_s, double* g2hjss_p, double* g2hjcc_s, double* g2hjcc_p, double* g2hjbb_s, double* g2hjbb_p, double* g2hjtt_s, double* g2hjtt_p, double* g2hjmumu_s, double* g2hjmumu_p, double* g2hjtautau_s, double* g2hjtautau_p, double* g2hjWW, double* g2hjZZ, double* g2hjZga, double* g2hjgaga, double* g2hjgg, double* g2hjggZ, double* g2hjhiZ, double* BR_hjinvisible, double* BR_hjhihi);}
extern "C" { void assign_toyvalues_to_peak_(int* ID, double* mu_obs, double* mh_obs);}
extern "C" { void assign_rate_uncertainty_scalefactor_to_peak_( int* ID, double* scale_mu ); }

extern "C" { void run_higgssignals_(int* hsmode, double* Chisq_mu, double* Chisq_mh, double* Chisq, int* ndf, double* Pvalue);}

extern "C" { void __io_MOD_get_peakinfo_from_hsresults( int* ID, double* mupred, int* domH, int* nHcomb ); }
extern "C" { void __io_MOD_get_number_of_observables( int* ntotal, int* npeakmu, int* npeakmh, int* nmpred, int* nanalyses );}
extern "C" { void __io_MOD_get_id_of_peakobservable( int* ii, int* ID );}
extern "C" { void __pc_chisq_MOD_print_cov_mh_to_file(int* nH);}
extern "C" { void __pc_chisq_MOD_print_cov_mu_to_file();}
extern "C" { void __pc_chisq_MOD_get_peakchi2(int* obsID, double* csqmu, double* csqmh, double* csqmax, double* csqtot); }
extern "C" { void get_rvalues_( int* nH, int* collider, double* R_H_WW, double* R_H_ZZ, double* R_H_gaga, double* R_H_tautau, double* R_H_bb, double* R_VH_bb ); }

extern "C" { void finish_higgssignals_();}

extern "C" { double smbr_hss_( double *Mh );}
extern "C" { double smbr_hcc_( double *Mh );}
extern "C" { double smbr_hbb_( double *Mh );}
extern "C" { double smbr_htoptop_( double *Mh );}
extern "C" { double smbr_hmumu_( double *Mh );}
extern "C" { double smbr_htautau_( double *Mh );}
extern "C" { double smbr_hww_( double *Mh );}
extern "C" { double smbr_hzz_( double *Mh );}
extern "C" { double smbr_hzgam_( double *Mh );}
extern "C" { double smbr_hgamgam_( double *Mh );}
extern "C" { double smbr_hgg_( double *Mh );}
extern "C" { double smgamma_h_( double *Mh );}

extern "C" { double __theory_collidersfunctions_MOD_lhc8_rh_bb( double* massh ); }
extern "C" { double __theory_collidersfunctions_MOD_lhc8_rh_gg( double* massh ); }
extern "C" { void setup_assignmentrange_( double* range ); }


class HiggsCalculator{

 public:

  HiggsCalculator(FloatStorage* in, FloatStorage* out, std::string obSet, double theoMassUnc);
  ~HiggsCalculator();

  void          Calculate(); 
  double        GetChi2();
  FloatStorage* GetOutput();
  void          SetInput( FloatStorage* in );
  void          SetOutput( FloatStorage* out );

 private:

  void ConfigureInput();
  void CallFunction();
  void ConfigureOutput(); 
  double CalculateSinglehUncertainty(double dhbb, double dhgg, double g2hbb, double g2hgg, double massh);

  TVectorD GetCorrelatedRandomNumbers( const TVectorD& mean,
				       const TMatrixDSym& covarianceMatrix,
				       int randomSeed ); 

  void ReadCovarianceMatrices( bool verb=0, int useObs=0 );
  
  // HS configuration

  std::string _obsSet;
  int    _nHiggsneut;
  int    _nHiggsplus;
  int    _outputLevel; // 0: silent, 1: screen output, 2: even more output,...
  double _dMh[3];   // Theoretical uncertainties in GeV for the 3 MSSM neutral Higgs
  int    _iteration;     // == Number of iterations to find the (best) Higgs-to-peaks assignment
  int    _pdf_in; // == Set the Higgs mass pdf (1: box, 2: gaussian, 3: theory-box + exp-gaussian)
  int    _hsmode;
  int    _collider;
  double  _range;
  
  // == Relative systematic uncertainties for 
  //  dCS(1) - singleH                             dBR(1) - gamma gamma
  //  dCS(2) - VBF                                 dBR(2) - W W
  //  dCS(3) - HW                                  dBR(3) - Z Z
  //  dCS(4) - HZ                                  dBR(4) - tau tau
  //  dCS(5) - ttH                                 dBR(5) - b bbar
  // Rate uncertainties for the given model
  double _dCS[5];
  double _dBR[5];

  FloatStorage* _in; 
  FloatStorage* _out; 

  double _mh;
  double _gammaTotal;
  double _g2hjss_s;
  double _g2hjss_p;
  double _g2hjcc_s;
  double _g2hjcc_p;
  double _g2hjbb_s;
  double _g2hjbb_p;
  double _g2hjtt_s;
  double _g2hjtt_p;
  double _g2hjmumu_s;
  double _g2hjmumu_p;
  double _g2hjtautau_s;
  double _g2hjtautau_p;
  double _g2hjWW;
  double _g2hjZZ;
  double _g2hjZga;
  double _g2hjgaga;
  double _g2hjgg;
  double _g2hjggZ;
  double _g2hjhiZ;
  double _BR_hjinvisible;
  double _BR_hjhihi;

  TMatrixDSym _cov_mh;
  TMatrixDSym _cov_mu;

  int _ntotal;
  int _npeakmu;
  int _npeakmh;
  int _nmpred;
  int _nanalyses;

  double _Chisq;
  double _Chisq_mh;
  double _Chisq_mu;
  double _Pvalue;
  int    _ndf;

  double _R_H_WW;
  double _R_H_ZZ;
  double _R_H_gaga;
  double _R_H_tautau;
  double _R_H_bb;
  double _R_VH_bb; 

  std::map< int, std::string > _ID;


};

#endif
