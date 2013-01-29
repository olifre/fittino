#ifndef HIGGSSIGNAL_H
#define HIGGSSIGNAL_H

#include "TVectorT.h"
#include "TMatrixT.h"
#include "TMatrixTSym.h"
#include "TMatrixDSymEigen.h"

using namespace std;

// == Define Fortran routines to be called from the HiggsSignal programm
extern "C" { void initialize_higgssignals_latestresults_(int* nH, int* nHplus) ;}
extern "C" { void higgssignals_neutral_input_massuncertainty_(double dMh[]);}
extern "C" { void setup_rate_uncertainties_(double dCS[], double dBR[]);}
extern "C" { void __io_MOD_get_number_of_observables( int* ntotal, int* npeakmu, int* npeakmh, int* nmpred );}
extern "C" { void set_pdf_(int* pdf_in);}// module, not subroutine
extern "C" { double smgamma_h_(double* Mh);}
extern "C" { void higgsbounds_neutral_input_effc_(double* Mh, double* GammaTotal, double* g2hjss_s, double* g2hjss_p, double* g2hjcc_s, double* g2hjcc_p, double* g2hjbb_s, double* g2hjbb_p, double* g2hjtt_s, double* g2hjtt_p, double* g2hjmumu_s, double* g2hjmumu_p, double* g2hjtautau_s, double* g2hjtautau_p, double* g2hjWW, double* g2hjZZ, double* g2hjZga, double* g2hjgaga, double* g2hjgg, double* g2hjggZ, double* g2hjhiZ, double* BR_hjinvisible, double* BR_hjhihi);}
extern "C" { void assign_toyvalues_to_observables_(int* ii, int* peakindex, int* npeaks, double* Toys_muobs, double* Toys_mhobs);}
extern "C" { void run_higgssignals_(double* Pvalue, double* Chisq, double* Chisq_mu, double* Chisq_mh, int* ndf, char peak[]);}
extern "C" { void get_rvalues_lhc8_( int* nH, double* R_H_WW, double* R_H_ZZ, double* R_H_gaga, double* R_H_tautau, double* R_H_bb, double* R_VH_bb ); }
extern "C" { void finish_higgssignals_();}
extern "C" { void __pc_chisq_MOD_print_cov_mh_to_file(int* nH);}
extern "C" { void __pc_chisq_MOD_print_cov_mu_to_file();}
extern "C" { void setup_output_level_(int* outputLevel);}
extern "C" { void set_higgs_to_peaks_assignment_iterations_(int* iteration);}
extern "C" { void __io_MOD_get_peakinfo_from_hsresults( int* i, double* mupred, int* domH, int* nHcomb ); }
extern "C" { void assign_uncertainty_scalefactors_to_observables_( int* ii, int* peakindex, int* npeaks, double* scale_mu, double* scale_mh ); }


// == Input for the calculation of the chi2 (to be taken from the toy and/or the input file later)
int outputLevel = 0;
int iteration = 0;

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
double dCS_SM[5] = { 0.147, 0.028, 0.037, 0.051, 0.12 };
double dBR_SM[5] = { 0.054, 0.048, 0.048, 0.061, 0.028 };
// Rate uncertainties for the given model
double dCS[5] = { 0.20, 0.028, 0.037, 0.051, 0.12 };
double dBR[5] = { 0.054, 0.048, 0.048, 0.061, 0.028 };

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
const int Nanalyses=26;
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
double Chisq_mh;
double Chisq_mu;
int ndf;
char peak[10] = "peak";

// ===================================================================
// == Read the covariance matrices for mu and m(h0) from HiggsSignal
void readCovarianceMatrices( bool verb=0, int useObs=0 ){

  cov_mu.ResizeTo( Nanalyses, Nanalyses );
  cov_mh.ResizeTo( Nanalyses, Nanalyses );

  // Print out the matrices in text files
  __pc_chisq_MOD_print_cov_mu_to_file();
  __pc_chisq_MOD_print_cov_mh_to_file( &nH );

  // Read the text files
  double col[Nanalyses];
  int line = 0;
  ifstream cov_mu_file( "cov_mu.txt" );
  while( cov_mu_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] >> col[16] >> col[17] >> col[18] >> col[19] >> col[20] >> col[21] >> col[22] >> col[23]>> col[24] >> col[25]){
    for( int icol=0; icol<Nanalyses; icol++ ) cov_mu( line, icol ) = col[icol];
    line++;
  } cov_mu_file.close();
  
 line=0;
 ifstream cov_mh_file( "cov_mh.txt" );
  while( cov_mh_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] >> col[16] >> col[17] >> col[18] >> col[19] >> col[20] >> col[21] >> col[22] >> col[23]>> col[24] >> col[25]){
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

// ===================================================================
// == Set nominal values of mu and mh for the 26 channels
void set_mu_mh(){

  // Set toy measurements for the peaks, every analysis has only one peak (second and third argument to 1)
  Toys_muobs[0] = 2.7200;
  Toys_muobs[1] = 2.6200;
  Toys_muobs[2] = 2.1800;
  Toys_muobs[3] = 1.7200;
  Toys_muobs[4] = 0.7050;
  Toys_muobs[5] = 1.3460;
  Toys_muobs[6] = 1.0490;
  Toys_muobs[7] = 1.0800;
  Toys_muobs[8] = -2.7000;
  Toys_muobs[9] = 1.0000;
  Toys_muobs[10] = 4.2085;
  Toys_muobs[11] = 1.2889;
  Toys_muobs[12] = 1.6870;
  Toys_muobs[13] = 1.4460;
  Toys_muobs[14] = 0.8950;
  Toys_muobs[15] = 0.7680;
  Toys_muobs[16] = 0.8000;
  Toys_muobs[17] = -0.7710;
  Toys_muobs[18] = 0.7000;
  Toys_muobs[19] = -0.0550;
  Toys_muobs[20] = 1.2880;
  Toys_muobs[21] = 0.9570;
  Toys_muobs[22] = -0.3120;
  Toys_muobs[23] = 3.6200;
  Toys_muobs[24] = 0.3200;
  Toys_muobs[25] = 1.9700;


  //
   Toys_mhobs[0] = 126.50;
   Toys_mhobs[1] = 126.50;
   Toys_mhobs[2] = 126.50;
   Toys_mhobs[3] = 126.50;
   Toys_mhobs[4] = 126.00;
   Toys_mhobs[5] = 126.00;
   Toys_mhobs[6] = 126.50;
   Toys_mhobs[7] = 126.50;
   Toys_mhobs[8] = 125.00;
   Toys_mhobs[9] = 125.00;
   Toys_mhobs[10] = 125.00;
   Toys_mhobs[11] = 125.00;
   Toys_mhobs[12] = 125.00;
   Toys_mhobs[13] = 125.00;
   Toys_mhobs[14] = 125.00;
   Toys_mhobs[15] = 125.80;
   Toys_mhobs[16] = 126.20;
   Toys_mhobs[17] = 125.00;
   Toys_mhobs[18] = 125.00;
   Toys_mhobs[19] = 125.80;
   Toys_mhobs[20] = 125.00;
   Toys_mhobs[21] = 125.00;
   Toys_mhobs[22] = 125.80;
   Toys_mhobs[23] = 125.00;
   Toys_mhobs[24] = 125.00;
   Toys_mhobs[25] = 125.00;
   
   
  for( int i = 1; i <= Nanalyses; i++ ){
    vec_obs_mu[i-1] = Toys_muobs[i-1];
    vec_obs_mh[i-1] = Toys_mhobs[i-1];
    assign_toyvalues_to_observables_( &i, &peakindex, &npeaks, &Toys_muobs[i-1], &Toys_mhobs[i-1]);
  }

  double s=1,p=0,m=125;
  double GammaTotal=smgamma_h_( &m );
  higgsbounds_neutral_input_effc_( &m, &GammaTotal, &s, &p, &s, &p, &s, &p, &s, &p, &s, &p, &s, &p, &s, &s, &s, &s, &s, &s, &p, &p, &p );

  return;
}

// ===================================================================
// == Initialize HiggsSignal
void initializeHiggs( bool verb=0, int useObs=0 ){

  // == Restrict to SM Higgs (no charged H)
  initialize_higgssignals_latestresults_( &nH, &nHplus );

  // == Output level (0: silent, 1: screen output, 2: even more output,...)
  setup_output_level_( &outputLevel );

  // == Theoretical uncertainties on mass
  higgssignals_neutral_input_massuncertainty_( dMh );

  // == Set number of iterations to find the (best) Higgs-to-peaks assignment
  // We set the mass very close to the peak, thus we don't need iterations.
  set_higgs_to_peaks_assignment_iterations_( &iteration );
    
 // == Set the Higgs mass pdf (1: box, 2: gaussian, 3: theory-box + exp-gaussian)
  set_pdf_( &pdf_in );

  // == Calculate theoretical uncertainties of singleH production from ggh and bbh effective couplings. 
  //dCS[0] = get_singleh_uncertainty_(dggh, dbbh, g2hjgg, g2hjbb_s+g2hjbb_p, mh)	
  setup_rate_uncertainties_( dCS, dBR );
 
  // == Dummy run with nominal values of mu and mh to get the covariance matrix
  set_mu_mh();
  run_higgssignals_( &Pvalue, &Chisq, &Chisq_mu, &Chisq_mh, &ndf, peak);
  int npeakmu, ntotal, npeakmh, nmpred;
  __io_MOD_get_number_of_observables( &ntotal, &npeakmu, &npeakmh, &nmpred );

  // == Scale down the uncertainty on mh and mu
  // For study, lower the uncertainties
  float redUncMu = 1.;
  float redUncMh = 1.;
  if( useObs == 13 ) redUncMu = 0.20;
  if( useObs == 14 ) redUncMu = 0.05;
  if( useObs == 15 ){ 
    redUncMu = 0.05;
    redUncMh = 0.25;
  }
  double scale_mu[26] = {redUncMu};
  double scale_mh[26] = {redUncMh};
  cout << " >>> Uncertainty scales for the "<< npeakmu <<" peaks: scale(mu) = " << redUncMu << " scale(mh) = " << redUncMh << endl;


  for( int ii = 1; ii <= npeakmu; ii++ ) 
    assign_uncertainty_scalefactors_to_observables_( &ii, &peakindex, &npeaks, scale_mu, scale_mh ); 

  // == Read the covariance matrices for mu and m(h0) from HiggsSignal
  readCovarianceMatrices( verb, useObs );

  return;
}


// == Get correlated random numbers, given the correlation between the 16 channels
TVectorD getCorrelatedRandomNumbers(const TVectorD& mean, const TMatrixDSym& covarianceMatrix, int randomSeed ) {
  int n = mean.GetNoElements();

   const TMatrixDSymEigen matrix(covarianceMatrix);
   TMatrixD eigenVecMatrix = matrix.GetEigenVectors();
   TVectorD eigenValueVec = matrix.GetEigenValues();
   TVectorD y(n);
   TRandom3 r( randomSeed );
   for (int i=0; i<n; i++) {
      if (eigenValueVec(i) < 0) {
	cout << "getCorrelatedRandomNumbers: Covariance matrix is not non-negative definite" << endl;
	 exit(EXIT_FAILURE);
      }
      y(i) = r.Gaus(0, TMath::Sqrt(eigenValueVec(i)));
   }
   TVectorD x(y);
   x *= eigenVecMatrix;
   x += mean;

   return x;
}

// ===================================================================
// == Smear the Higgs observables in a correlated way
// == the covariance matrices are created in 'readCovarianceMatrices'
void smearHiggs( bool verb, int randomSeed, TString inputDir, TString fit ){

 if( verb ) cout << "   > Smear Higgs mu, mh.." << endl;

 // -----------------------------------------------------------------
 // Open the files with the values of mu and mh at the best fit point
 TString bestMuFile = inputDir + "/mu_" + fit + ".txt";
 TString bestMhFile = inputDir + "/mh_" + fit + ".txt";
 ifstream bestMuStreamIn( bestMuFile );
 ifstream bestMhStreamIn( bestMhFile );
 
 // Warning if the file does not exist
 if( !bestMuStreamIn.good() ) cout << " >>>>>> WARNING <<<<<< the file of the best fit mu is missing: " << endl << bestMuFile << endl;
 if( !bestMhStreamIn.good() ) cout << " >>>>>> WARNING <<<<<< the file of the best fit mh is missing: " << endl << bestMhFile << endl;

 cout << "   > Values of mu, m(h0) at the best fit point.." << endl;
 cout << bestMuFile << endl;
 cout << bestMhFile << endl;

 // Read read the best fit point files for mu
 float bestMu;
 int analysis=0;
 while( bestMuStreamIn >> bestMu ){
   vec_obs_mu[analysis] = bestMu;
   analysis++;
   if( analysis >= Nanalyses ) break;
 }
 bestMuStreamIn.close();
 
 // Read read the best fit point files for mh
 float bestMh;
 analysis=0;
 while( bestMhStreamIn >> bestMh ){
   vec_obs_mh[analysis] = bestMh;
   analysis++;
   if( analysis >= Nanalyses ) break;
 }
 bestMhStreamIn.close();


 // -----------------------------------------------------------------
 // Smear these best fit point values
 TVectorD vec_toy_mu = getCorrelatedRandomNumbers( vec_obs_mu, cov_mu, randomSeed );
 TVectorD vec_toy_mh = getCorrelatedRandomNumbers( vec_obs_mh, cov_mh, randomSeed );
 //TVectorD vec_toy_mu = vec_obs_mu;// test the toys
 //TVectorD vec_toy_mh = vec_obs_mh;


if( verb ){
  cout << "     Correlated toy values for mu.." << endl;
  for( int i = 0; i < Nanalyses; i++ ) cout << "      mu["<<i<<"]="<<vec_toy_mu[i]<<" ("<<vec_obs_mu[i]<<")"<<endl;
  cout << "     Correlated toy values for mh.." << endl;
  for( int i = 0; i < Nanalyses; i++ ) cout << "      mh["<<i<<"]="<<vec_toy_mh[i]<<" ("<<vec_obs_mh[i]<<")"<<endl;
 }

for( int i = 1; i <= Nanalyses; i++ ) assign_toyvalues_to_observables_( &i, &peakindex, &npeaks, &vec_toy_mu[i-1], &vec_toy_mh[i-1]);

return;
}

// ===================================================================
// == For a given point, get the Higgs chi2
void getHiggsChi2( double _HiggsMassCouplings[], double& Chisq, double& Chisq_mu, double& Chisq_mh )
{
  // == Set the HiggsBounds/Signals effective relative couplings input
  double GammaTotal=smgamma_h_( &_HiggsMassCouplings[0] );
  higgsbounds_neutral_input_effc_( &_HiggsMassCouplings[0], &GammaTotal, &_HiggsMassCouplings[1], &_HiggsMassCouplings[2], &_HiggsMassCouplings[3], &_HiggsMassCouplings[4], &_HiggsMassCouplings[5], &_HiggsMassCouplings[6], &_HiggsMassCouplings[7], &_HiggsMassCouplings[8], &_HiggsMassCouplings[9], &_HiggsMassCouplings[10], &_HiggsMassCouplings[11], &_HiggsMassCouplings[12], &_HiggsMassCouplings[13], &_HiggsMassCouplings[14], &_HiggsMassCouplings[15], &_HiggsMassCouplings[16], &_HiggsMassCouplings[17], &_HiggsMassCouplings[18], &_HiggsMassCouplings[19], &_HiggsMassCouplings[20], &_HiggsMassCouplings[21] );

  // == Statistical output
  run_higgssignals_( &Pvalue, &Chisq, &Chisq_mu, &Chisq_mh, &ndf, peak);

  return;
}

 // ===================================================================
// == Get signal-rate ratios (without efficiencies) for lightest Higgs boson from HS.
// This function has to be called AFTER run_HiggsSignals.
void getHiggsRatios( double& R_H_WW, double& R_H_ZZ, double& R_H_gaga, double& R_H_tautau, double& R_H_bb, double& R_VH_bb )
{
  get_rvalues_lhc8_( &nH, &R_H_WW, &R_H_ZZ, &R_H_gaga, &R_H_tautau, &R_H_bb, &R_VH_bb );
  return;
}

// == predicted Higgs mu for each analysis
double getHiggsMu( int i )
{
  double predmu;
  int domH, nHcomb;
  __io_MOD_get_peakinfo_from_hsresults( &i, &predmu, &domH, &nHcomb );

return predmu;
}

#endif
