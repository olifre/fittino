#ifndef HIGGSSIGNAL_H
#define HIGGSSIGNAL_H

#include "TVectorT.h"
#include "TMatrixT.h"
#include "TMatrixTSym.h"
#include "TMatrixDSymEigen.h"

using namespace std;

// == Define Fortran routines to be called from the HiggsSignal programm
//extern "C" { void initialize_higgsbounds_(int* nH, int* nHplus, char* whichexpt);}
extern "C" { void initialize_higgssignals_(int* nH, int* nHplus) ;}
extern "C" { void higgssignals_neutral_input_massuncertainty_(double dMh[]);}
extern "C" { void setup_rate_uncertainties_(double dCS_SM[], double dCS[], double dBR_SM[], double dBR[]);}
extern "C" { void __pc_chisq_MOD_set_significance(double* S0);}// module, not subroutine
extern "C" { void __pc_chisq_MOD_set_pdf(int* pdf_in);}// module, not subroutine
extern "C" { double smgamma_h_(double* Mh);}
extern "C" { void higgsbounds_neutral_input_effc_(double* Mh, double* GammaTotal, double* g2hjss_s, double* g2hjss_p, double* g2hjcc_s, double* g2hjcc_p, double* g2hjbb_s, double* g2hjbb_p, double* g2hjtt_s, double* g2hjtt_p, double* g2hjmumu_s, double* g2hjmumu_p, double* g2hjtautau_s, double* g2hjtautau_p, double* g2hjWW, double* g2hjZZ, double* g2hjZga, double* g2hjgaga, double* g2hjgg, double* g2hjggZ, double* g2hjhiZ, double* BR_hjinvisible, double* BR_hjhihi);}
extern "C" { void assign_toyvalues_to_mutable_(int* ii, int* peakindex, int* npeaks, double* Toys_muobs, double* Toys_mhobs);}
extern "C" { void run_higgssignals_(double* Pvalue, double* Chisq, int* ndf, char peak[]);}
extern "C" { void finish_higgssignals_();}

extern "C" { void __pc_chisq_MOD_print_cov_mh_to_file(int* nH);}
extern "C" { void __pc_chisq_MOD_print_cov_mu_to_file();}


// == Input for the calculation of the chi2 (to be taken from the toy and/or the input file later)

// == Number of Higgs
int nH = 1;
int nHplus = 0;

// == Theoretical uncertainties in GeV for the 3 MSSM neutral Higgs
double dMh[3] = { 2.0, 2.0, 2.0 };

// == Relative systematic uncertainties for 
//  dCS(1) - singleH                             dBR(1) - gamma gamma
//  dCS(2) - VBF                                 dBR(2) - W W
//  dCS(3) - HW                                  dBR(3) - Z Z
//  dCS(4) - HZ                                  dBR(4) - tau tau
//  dCS(5) - ttH                                 dBR(5) - b bbar
// from https://twiki.cern.ch/twiki/bin/view/LHCPhysics/CrossSections
double dCS_SM[5] = { 0.15, 0.027, 0.043, 0.051, 0.178 };//xx
double dBR_SM[5] = { 0.05, 0.043, 0.043, 0.057, 0.033 };//xx
// Rate uncertainties for the given model
double dCS[5] = { 0.2, 0.04, 0.05, 0.08, 0.2 };//xx
double dBR[5] = { 0.05, 0.043, 0.043, 0.057, 0.033 };//xx

 // == Minimal significance for a channel to be considered
double S0 = 3.0;

// == Set the Higgs mass pdf (1: box, 2: gaussian, 3: theory-box + exp-gaussian)
int pdf_in = 2;

// == HiggsBounds/Signals effective relative couplings input, set by hand to the SM values
// Values for the best fit point, to be taken from the ntuple
// 's' scalar, 'p' pseudoscalar
double g2hjss_s=1;
double g2hjss_p=0;
double g2hjcc_s=1;
double g2hjcc_p=0;
double g2hjbb_s=1;
double g2hjbb_p=0;
double g2hjtt_s=1;
double g2hjtt_p=0;
double g2hjmumu_s=1;
double g2hjmumu_p=0;
double g2hjtautau_s=1;
double g2hjtautau_p=0;
double g2hjWW=1;
double g2hjZZ=1;
double g2hjZga=1;
double g2hjgaga=1;
double g2hjgg=1;
double g2hjggZ=1;
double g2hjhiZ=0;
double BR_hjhihi=0;
double BR_hjinvisible=0;
double Mh=127.1;

// == Toy measurements for the peaks
const int Nanalyses=16;
double Toys_muobs[Nanalyses];
double Toys_mhobs[Nanalyses];
TVectorD vec_obs_mu(Nanalyses);
TVectorD vec_obs_mh(Nanalyses);
int peakindex = 1;
int npeaks = 1;

// == Covariance matrices
TMatrixDSym cov_mu;
TMatrixDSym cov_mh;

// == Statistical output
double Pvalue;
double Chisq;
int ndf;
char peak[10] = "peak";


// == Read the covariance matrices for mu and m(h0) from HiggsSignal
void readCovarianceMatrices( bool verb=0 ){

  cov_mu.ResizeTo( Nanalyses, Nanalyses );
  cov_mh.ResizeTo( Nanalyses, Nanalyses );
  
  // Print out the matrices in text files
  __pc_chisq_MOD_print_cov_mu_to_file();
  __pc_chisq_MOD_print_cov_mh_to_file( &nH );

 // Read the text files
 double col[Nanalyses];
 int line = 0;
 ifstream cov_mu_file( "/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/cov_mu.txt" );
 while( cov_mu_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] ){
   for( int icol=0; icol<Nanalyses; icol++ ) cov_mu( line, icol ) = col[icol];
    line++;
 } cov_mu_file.close();

 line=0;
 ifstream cov_mh_file( "/afs/naf.desy.de/user/p/prudent/fittino/postProcessing/cov_mh.txt" );
 while( cov_mh_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] ){
   for( int icol=0; icol<Nanalyses; icol++ ) cov_mh( line, icol ) = col[icol];
   line++;
 } cov_mh_file.close();
  
 if( verb ){
   cout << " >>> Printing out covariance matrices.." << endl;
   cout << " >>> Covariance matrix of mu:" << endl;
   cov_mu.Print();
   cout << " >>> Covariance matrix of mh:" << endl;
   cov_mh.Print();
 }
  return;
}

// == Set nominal values of mu and mh for the 16 channels
void set_mu_mh(){

  // Set toy measurements for the peaks, every analysis has only one peak (second and third argument to 1)
  Toys_muobs[0] = 0.8;
  Toys_muobs[1] = -1.7;
  Toys_muobs[2] = 0.9;
  Toys_muobs[3] = 1.0;
  Toys_muobs[4] = 0.2;
  Toys_muobs[5] = -1.0;
  Toys_muobs[6] = 2.0;
  Toys_muobs[7] = 0.1;
  Toys_muobs[8] = -0.2;
  Toys_muobs[9] = 1.0;
  Toys_muobs[10] = 3.0;
  Toys_muobs[11] = 1.0;
  Toys_muobs[12] = 0.1;
  Toys_muobs[13] = -1.2;
  Toys_muobs[14] = 2.0;
  Toys_muobs[15] = 1.0;
  //
  Toys_mhobs[0] = 124.8;
  Toys_mhobs[1] = 126.7;
  Toys_mhobs[2] = 122.9;
  Toys_mhobs[3] = 134.0;
  Toys_mhobs[4] = 121.2;
  Toys_mhobs[5] = 125.0;
  Toys_mhobs[6] = 126.0;
  Toys_mhobs[7] = 127.1;
  Toys_mhobs[8] = 122.2;
  Toys_mhobs[9] = 124.0;
  Toys_mhobs[10] = 132.0;
  Toys_mhobs[11] = 122.0;
  Toys_mhobs[12] = 117.1;
  Toys_mhobs[13] = 123.2;
  Toys_mhobs[14] = 125.0;
  Toys_mhobs[15] = 126.0;

  for( int i = 1; i <= Nanalyses; i++ ){
    vec_obs_mu[i-1] = Toys_muobs[i-1];
    vec_obs_mh[i-1] = Toys_mhobs[i-1];
    assign_toyvalues_to_mutable_( &i, &peakindex, &npeaks, &Toys_muobs[i-1], &Toys_mhobs[i-1]);
  }

  double s=1,p=0,m=125;
  double GammaTotal=smgamma_h_( &m );
  higgsbounds_neutral_input_effc_( &m, &GammaTotal, &s, &p, &s, &p, &s, &p, &s, &p, &s, &p, &s, &p, &s, &s, &s, &s, &s, &s, &p, &p, &p );

  return;
}

// == Initialize HiggsSignal
void initializeHiggs( bool verb=0 ){

  // == Restrict to SM Higgs (no charged H)
  initialize_higgssignals_( &nH, &nHplus );

  // == Theoretical uncertainties on mass
  higgssignals_neutral_input_massuncertainty_( dMh );

  // == Systematic uncertainties on cross section and branching fraction
  setup_rate_uncertainties_( dCS_SM, dCS, dBR_SM, dBR );

  // == Minimal significance for a channel to be considered
  __pc_chisq_MOD_set_significance( &S0 );

  // == Set the Higgs mass pdf (1: box, 2: gaussian, 3: theory-box + exp-gaussian)
  __pc_chisq_MOD_set_pdf( &pdf_in );

  // == Dummy run with nominal values of mu and mh to get the covariance matrix
  set_mu_mh();
  run_higgssignals_( &Pvalue, &Chisq, &ndf, peak);

  // == Read the covariance matrices for mu and m(h0) from HiggsSignal
  readCovarianceMatrices( verb );

  return;
}


// == Get correlated random numbers, given the correlation between the 16 channels
TVectorD getCorrelatedRandomNumbers(const TVectorD& mean, const TMatrixDSym& covarianceMatrix) {
  int n = mean.GetNoElements();

   const TMatrixDSymEigen matrix(covarianceMatrix);
   TMatrixD eigenVecMatrix = matrix.GetEigenVectors();
   TVectorD eigenValueVec = matrix.GetEigenValues();
   TVectorD y(n);
   for (int i=0; i<n; i++) {
      if (eigenValueVec(i) < 0) {
	cout << "getCorrelatedRandomNumbers: Covariance matrix is not non-negative definite" << endl;
	 exit(EXIT_FAILURE);
      }
      y(i) = gRandom->Gaus(0, TMath::Sqrt(eigenValueVec(i)));
   }
   TVectorD x(y);
   x *= eigenVecMatrix;
   x += mean;

   return x;
}

// == Smear the Higgs observables in a correlated way
// == the covariance matrices are created in 'readCovarianceMatrices'
void smearHiggs( bool verb ){

 if( verb ) cout << "   > Smear Higgs mu, mh.." << endl;

  TVectorD vec_toy_mu = getCorrelatedRandomNumbers( vec_obs_mu, cov_mu );
  TVectorD vec_toy_mh = getCorrelatedRandomNumbers( vec_obs_mh, cov_mh );
  
  if( verb ){
    cout << "     Correlated toy values for mu.." << endl;
    for( int i = 0; i < Nanalyses; i++ ) cout << "      mu["<<i<<"]="<<vec_toy_mu[i]<<" ("<<vec_obs_mu[i]<<")"<<endl;
    cout << "     Correlated toy values for mh.." << endl;
    for( int i = 0; i < Nanalyses; i++ ) cout << "      mh["<<i<<"]="<<vec_toy_mh[i]<<" ("<<vec_obs_mh[i]<<")"<<endl;
  }

  for( int i = 1; i <= Nanalyses; i++ ) 
  assign_toyvalues_to_mutable_( &i, &peakindex, &npeaks, &vec_toy_mu[i-1], &vec_toy_mh[i-1]);

  return;
}


// == For a given point, get the Higgs chi2
double getHiggsChi2( double _HiggsMassCouplings[] )
{
  // == Set the HiggsBounds/Signals effective relative couplings input
  double GammaTotal=smgamma_h_( &_HiggsMassCouplings[0] );
  higgsbounds_neutral_input_effc_( &_HiggsMassCouplings[0], &GammaTotal, &_HiggsMassCouplings[1], &_HiggsMassCouplings[2], &_HiggsMassCouplings[3], &_HiggsMassCouplings[4], &_HiggsMassCouplings[5], &_HiggsMassCouplings[6], &_HiggsMassCouplings[7], &_HiggsMassCouplings[8], &_HiggsMassCouplings[9], &_HiggsMassCouplings[10], &_HiggsMassCouplings[11], &_HiggsMassCouplings[12], &_HiggsMassCouplings[13], &_HiggsMassCouplings[14], &_HiggsMassCouplings[15], &_HiggsMassCouplings[16], &_HiggsMassCouplings[17], &_HiggsMassCouplings[18], &_HiggsMassCouplings[19], &_HiggsMassCouplings[20], &_HiggsMassCouplings[21] );
  //  higgsbounds_neutral_input_effc_( &HiggsMass, &GammaTotal, &g2hjss_s, &g2hjss_p, &g2hjcc_s, &g2hjcc_p, &g2hjbb_s, &g2hjbb_p, &g2hjtt_s, &g2hjtt_p, &g2hjmumu_s, &g2hjmumu_p, &g2hjtautau_s, &g2hjtautau_p, &g2hjWW, &g2hjZZ, &g2hjZga, &g2hjgaga, &g2hjgg, &g2hjggZ, &g2hjhiZ, &BR_hjinvisible, &BR_hjhihi);

  // == Statistical output
  run_higgssignals_( &Pvalue, &Chisq, &ndf, peak);
  
  return Chisq;
}

 




#endif
