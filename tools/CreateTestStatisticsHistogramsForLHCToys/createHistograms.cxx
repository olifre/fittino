#include <iostream>
#include <fstream>
#include "TMath.h"
#include "TH2D.h"
#include "fstream"
#include "iostream"
#include <map>

#include <string>
#include <sstream>
#include <iostream>
//#include <stream.h>
#include <vector>
#include <map>
#include <utility>
#include <TVectorD.h>
#include <TMatrixD.h>
#include <TMatrixDSym.h>
#include <TH1.h>
#include <TH2D.h>
#include <TGraph.h>
//##include<leshouches.h>
#include <math.h>
#include<sstream> 
#include<TFile.h> 
#include <TCanvas.h>
#include "TRandom3.h"
#include "TF1.h"
#include "TStyle.h"

using namespace std;

Double_t clsbpdf(Double_t *arg, Double_t *par) {
	// par[0] = t0_obs;
	// par[1] = t0;
	// par[2] = sigma_obs;
	// par[3] = sigma;
	// par[4] = normalisation;
	Double_t x = arg[0];
	Double_t s_t = par[3];
	Double_t s_tobs = par[2];
	Double_t t0 = par[1];
	Double_t tobs0 = par[0];
	Double_t ret = s_t/s_tobs;
	ret *= exp( TMath::ErfInverse(2*x-1)*TMath::ErfInverse(2*x-1) );
	ret *= exp( -0.5/s_tobs/s_tobs*(t0-tobs0-s_t*sqrt(2)*TMath::ErfInverse(2*x-1))*(t0-tobs0-s_t*sqrt(2)*TMath::ErfInverse(2*x-1))); 

	return ret*par[4];
}

double llratio( double _nS, double _nS_unc, double _nBkg, double _nBkg_unc, double _nData, TString option ){

  double n = 0;

  if( option != "data" ){
    static TRandom3 rndm;
    // Relative uncertainty
    double Bkg_scale = 1;
    double S_scale = 1;
    while (1) {
      Bkg_scale = rndm.Gaus( 1, _nBkg_unc );
      if (Bkg_scale>0.) break;
    } 
    while (1) {
      S_scale = rndm.Gaus( 1, _nS_unc );
      if (S_scale>0.) break;
    }
  
    // Hypothese background or background+signal
    if( option == "b" ) n = (double) rndm.Poisson( _nBkg * Bkg_scale );
    if( option == "sb" ) n = (double) rndm.Poisson( _nBkg * Bkg_scale + _nS * S_scale );
  }
  if( option == "data" ) n = _nData;


  double   numb  = TMath::Max(_nBkg, 1e-6);
  double   numsb = TMath::Max(_nS+_nBkg, 1e-6);    


  // Log likelihood ration (s+b)/b for Poisson
  double ll_sb = n * TMath::Log( numsb ) - ( numsb );
  double ll_b  = n * TMath::Log( numb ) - numb;

  return ( ll_sb - ll_b );
}


//void toys(  int nToys = 2000, int region=1, int binx=1, int biny=1 ){

int main ( int argc, char *argv[]){

  if ( argc != 2 ){
    cout<<"wrong number of arguments"<<endl;
    exit(-1);
  }
  

  stringstream sbinx(argv[1]);
  int binx;
  sbinx>>binx;

  //output

  TString outputName = Form(("scan_grid_"+sbinx.str()+".root").c_str());
  TFile* output = new TFile( outputName, "recreate");



  int nToys = 200000; 

  //  double nBkg_2j = 12.1;
  double nBkg_2j = 10.;

  //  double nBkg_3j = 10.1;
  double nBkg_3j = 6.;

  //  double nBkg_4j = 7.3;
  double nBkg_4j = 4.;

  double nBkg_2j_unc = 0.02;
  double nBkg_3j_unc = 0.10;
  double nBkg_4j_unc = 0.10;
  double nS_unc = 0.;

  //  double lumi = 15.0;
  double lumi = 20.0;

  TFile f("signalGrids.root");
  TH2D* signal=0;


  for (int region=1;region<=3; region++){

    stringstream sregion;
    sregion<<region;
    

    double nBkg, nBkg_unc;
    if( region == 1 ){
      nBkg = nBkg_2j;
      nBkg_unc = nBkg_2j_unc;
    }
    if( region == 2 ){
      nBkg = nBkg_3j;
      nBkg_unc = nBkg_3j_unc;
    }
    if( region == 3 ){
      nBkg = nBkg_4j;
      nBkg_unc = nBkg_4j_unc;
    }
    
    nBkg *= lumi/0.165;
    

    if (region==1)
      signal=(TH2D*) f.Get("signalA");
    else if (region==2)
      signal=(TH2D*) f.Get("signalB");
    else if (region==3)
      signal=(TH2D*) f.Get("signalC");


    TH2F *h_median_t_2D = new TH2F( ("h_median_t_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);
    TH2F *h_median_tobs_2D = new TH2F( ("h_median_tobs_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);
    TH2F *h_medianPlus1Sigma_t_2D = new TH2F( ("h_medianPlus1Sigma_t_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);
    TH2F *h_medianPlus1Sigma_tobs_2D = new TH2F( ("h_medianPlus1Sigma_tobs_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);
    TH2F *h_medianMinus1Sigma_t_2D = new TH2F( ("h_medianMinus1Sigma_t_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);
    TH2F *h_medianMinus1Sigma_tobs_2D = new TH2F( ("h_medianMinus1Sigma_tobs_2D_"+sregion.str()).c_str(), "",249 , 15, 2505, 221, 97.5, 1202.5);




    for (int biny=1;biny<=221;biny++){
		cout << "processing biny = " << biny << endl;
    double M0=signal->GetXaxis()->GetBinCenter(binx);
    double M12=signal->GetYaxis()->GetBinCenter(biny);
    double nS=signal->GetBinContent(binx,biny);
    nS *=lumi;

        if( M0 >= 1000 ) nS_unc = 0.15;
    if( M0 < 1000 ) nS_unc = 0.1;
    
		int ntrials = 200000;
		double lnQb_array[ntrials];
		double lnQsb_array[ntrials];
		for( int iToy2 = 0; iToy2 < ntrials; ++iToy2 ) {
			lnQb_array[iToy2] = -2*llratio( nS, nS_unc, nBkg, nBkg_unc, nBkg, "b" );
			lnQsb_array[iToy2] = -2*llratio( nS, nS_unc, nBkg, nBkg_unc, nBkg, "sb" );
		}
		
		int array_index[ntrials];
		TMath::Sort( ntrials, lnQb_array, array_index, kFALSE );
		int median_pos = (int)(ntrials*0.5 + 0.5);
		int median_plus1sigma_pos = (int)(ntrials*0.84135 + 0.5);
		int median_minus1sigma_pos = (int)(ntrials*0.15865 + 0.5);
		double llratio_data = lnQb_array[ array_index[median_pos] ];
		double llratio_plus1sigma_data = lnQb_array[ array_index[median_plus1sigma_pos] ];
		double llratio_minus1sigma_data = lnQb_array[ array_index[median_minus1sigma_pos] ];
 		
		
		int array_index_qsb[nToys];
		TMath::Sort( nToys, lnQsb_array, array_index_qsb, kFALSE );
		int median_pos_qsb = (int)(nToys*0.5+0.5);
		int median_pos_plus1sigma_qsb = (int)(nToys*0.84135 + 0.5);
		int median_pos_minus1sigma_qsb = (int)(nToys*0.15865 + 0.5);
		double llratio_qsb = lnQsb_array[ array_index_qsb[median_pos_qsb] ];
		double llratio_plus1sigma_qsb = lnQsb_array[ array_index_qsb[median_pos_plus1sigma_qsb] ];
		double llratio_minus1sigma_qsb = lnQsb_array[ array_index_qsb[median_pos_minus1sigma_qsb] ];
  	h_median_t_2D -> SetBinContent( binx, biny, llratio_qsb );
		h_median_tobs_2D -> SetBinContent( binx, biny, llratio_data );
		h_medianPlus1Sigma_t_2D -> SetBinContent( binx, biny, llratio_plus1sigma_qsb );
		h_medianPlus1Sigma_tobs_2D -> SetBinContent( binx, biny, llratio_plus1sigma_data);
		h_medianMinus1Sigma_t_2D -> SetBinContent( binx, biny, llratio_minus1sigma_qsb );
		h_medianMinus1Sigma_tobs_2D -> SetBinContent( binx, biny, llratio_minus1sigma_data );
	}
	
  output->cd();
	h_median_t_2D -> Write();
	h_median_tobs_2D -> Write();
	h_medianPlus1Sigma_t_2D -> Write();
	h_medianPlus1Sigma_tobs_2D -> Write();
	h_medianMinus1Sigma_t_2D -> Write();
	h_medianMinus1Sigma_tobs_2D -> Write();
  }
  output->Close();
	


}





