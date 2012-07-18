/***************************************************************************
  fittino.cpp
  -------------------    

  -------------------
  $Id: fittino.cpp 199 2008-02-21 14:33:28Z bechtle $
  $Name$
  -------------------

begin                : September 10, 2003
authors              : Philip Bechtle, Peter Wienemann
email                : philip.bechtle@desy.de, peter.wienemann@desy.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <fittino.h>
#include <indchisq.h>
#include <input.h>
#include <smearedinput.h>
#include <units.h>
#include <iostream>
#include <fstream>
#include <time.h>
#include <yy.h>
#include <fstream>
#include <sstream>
#include <stdio.h>
#include <leshouches.h>
#include <sys/wait.h>
#include <sys/signal.h>
#include <unistd.h>
#include <stdlib.h>

#include <TRandom.h>
#include <TMath.h>
#include <TFitter.h>
#include <TMinuit.h>
#include <TGraph.h>
#include <TGraph2D.h>
#include <TRandom3.h>

#include <TFile.h>
#include <TH1.h>
#include <TH1D.h>
#include <TH2D.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <sys/unistd.h>

#include "sRates.h"
#include "slhaea.h"
#include "./LHC-FASER/LHC-FASER.hpp"
using namespace SLHAea;
// #include <sys/types.h>
extern char **environ;

extern double Endpoint(int N, double mass[]);

MeasuredValue fitterM1;
MeasuredValue fitterM2;
MeasuredValue fitterAbsM3;
MeasuredValue fitterMassA0;
MeasuredValue fitterTanBeta;
MeasuredValue fitterMu;
MeasuredValue fitterMassSelR;
MeasuredValue fitterMassSelL;
MeasuredValue fitterMassSupR;
MeasuredValue fitterMassSupL;
MeasuredValue fitterA;
MeasuredValue fitterMassTop;


sRates* rateValue = NULL;
LHC_FASER::LHC_FASER_UI* lhcFaserSignals = NULL;
LHC_FASER::signal_handler* lhcFaserAtlas4jMET0l7TeV = NULL;
LHC_FASER::signal_handler* lhcFaserAtlas3jMET1l7TeV = NULL;

// observables received from suspect:
double        sRecMassChargino1;
double        sRecMassChargino2;
double        sRecMassNeutralino1;
double        sRecMassNeutralino2;
double        sRecMassNeutralino3;
double        sRecMassNeutralino4;
double        sRecMassGluino;
double        sRecMassh0;
double        sRecMassH0;
double        sRecMassA0;
double        sRecMassHpm;
double        sRecMassSelR;
double        sRecMassSelL;
double        sRecMassSupR;
double        sRecMassSupL;
double        sRecCos2PhiL;
double        sRecCos2PhiR;
double        sRecMassTop;


std::map< std::pair<int,int>, TH1D*> signalXsec;
TH1D* hbkgd = 0;
TH1D* hdata = 0;
double dataDefaultLumi=0.165;

extern "C" { void susygen_call_test_(int *, double [],double *);}
extern "C" { void mssmsusygen_init_(int *, int *, float *, float *,float *,float *,float *,float *);}
extern "C" { void mssmsusygen_();}
extern "C" { void call_suspect_free_(int *,int *,double *,double *,double *,
      double [],double *,double *,double *,double *,double *,double *);}
#ifdef USELIBHB
//extern "C" { void initialize_higgsbounds_(int*, char*);}
extern "C" { double smgamma_h_(double* Mh);}
extern "C" { double smbr_hgg_(double* Mh);}
extern "C" { double smbr_hgamgam_(double* Mh);}
extern "C" { double smbr_hzz_(double* Mh);}
extern "C" { double smbr_hww_(double* Mh);}
extern "C" { double smbr_hbb_(double* Mh);}
extern "C" { double smbr_htautau_(double* Mh);}
extern "C" { void initialize_higgsbounds_chisqtables_();}
extern "C" { void initialize_higgsbounds_(int* nH, int* nHplus, char* whichexpt);}
extern "C" { void finish_higgsbounds_chisqtables_();}
extern "C" { void finish_higgsbounds_();}
extern "C" { void run_higgsbounds_effc_(int* nH, double Mh[], double GammaTotal[], double g2hjbb[], double g2hjtautau[], double g2hjWW[], double g2hjZZ[], double g2hjgaga[], double g2hjgg[], double g2hjhiZ[][3], double BR_hjhihi[][3], int*p, int* chan, double obsratio[], int* ncombined);}
extern "C" { void higgsbounds_input_slha_(char* filename, int* len); }
extern "C" { void run_higgsbounds_( int* HBresult,int* chan, double* obsratio,int* ncombined ); }
extern "C" { void hb_calc_stats_(double* theory_uncertainty_1s, double* chisq_withouttheory, double*chisq_withtheory, int* bestChanChi2); }

int excl = 0;
int nexcl = 0;
vector<float> HBmass[3], gammah[3], BR_hjbb[3], BR_hjtautau[3], O_g2hjZZ[3];
#endif

//extern "C" { void get_suspect_(double [],double [],double *,double [],double [2][2],double [2][2],double [4][4],double []);}
void callSuspect();
int callSPheno();
int callSoftSusy();
int callSUSYHIT();
int callFeynHiggs();
int callSuperIso();
int callHDecay();
int WriteSUSYHITInputFile(int);
int callNPFitter();
int checkcall(char programpath[1024], unsigned int runtime);
void WriteLesHouches(double* x);
void fitterFCN(int &npar, double *gin, double &f, double *x, int iflag); 
void chi2Function(int& npar, double* gin, double& f, double* x, int iflag);
double hamiltonian(int n, double* q, double* p);
MeasuredValue* ReturnMeasuredValue (string name);
MeasuredValue* ReturnFittedValue (string name);
MeasuredValue* ReturnFixedValue (string name);
int ReturnFittedPosition (string name);
int ReturnRandomPosition(string);
bool FindInFitted (string name);
//bool FindInFixed (string name);
bool FindInRandomPar(string);
bool FindInUniversality(string name);
MeasuredValue* ReturnUniversality (string name);
int   ReadLesHouches();
int   ParseLesHouches();
double give_xs (doubleVec_t initial, int channel, int element );
double give_br ( int id, int decay, int element );
int FindInFittedPar (string name);
double mSquarkGluinoMax;


double* GetRandomParameterVector(const vector<parameter_t>&);

double gchisq;
int    gstat;

double global_LHC_CLb = -1;
double global_LHC_CLsb = -1;
double global_LHC_chi2 = -1;
double global_LHC_Exp_CLb = -1;
double global_LHC_Exp_CLsb = -1;
double global_LHC_Exp_chi2 = -1;

double af_photon=-1;
double af_relic=-1;
double af_svind=-1;
double af_direct=-1;
double af_chi2_total=-1;
double af_chi2_photon=-1;
double af_chi2_relic=-1;
double af_chi2_svind=-1;
double af_chi2_direct=-1;

double globalHiggsChi2=-1;


int n_printouts;

#ifdef USELIBHB

int initialize_HiggsBoundsWithSLHA(int nH, int nHplus, char* whichexpt)
{

  initialize_higgsbounds_chisqtables_();
  initialize_higgsbounds_(&nH,&nHplus,whichexpt);

  return 0;
}


int close_HiggsBoundsWithSLHA()
{

  finish_higgsbounds_chisqtables_();
  finish_higgsbounds_();

  return 0;
}




double call_HiggsBoundsWithSLHA() 
{

  double theory_uncertainty_1s=1.5;
  double chisq_withtheory = 0;
  double chisq_withouttheory = 0;
  int HBresult = -1;
  int chan = 0;
  int bestChanChi2 = 0;
  double obsratio = 0.;
  int ncombined = 0;
  string filename;
  double mh = 0.;

  for ( unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
    if ( yyMeasuredVec[i].name == "Massh0_npf" ||
	 yyMeasuredVec[i].name == "massh0" ) {
      theory_uncertainty_1s = yyMeasuredVec[i].error;
      mh = yyMeasuredVec[i].theovalue;
      break;
    }
  }  

  if (yyCalculator == SPHENO) {
    filename="SPheno.spc.last";
  } else {
    cout << "HB blocks not implemented in other calculators than SPheno, exiting" << endl;
    exit (-1);
  }
  system ("ls -l SPheno.spc.last");
  char charfilename[256];
  sprintf(charfilename,"%s",filename.c_str());
  int charfilenamelen = strlen(charfilename);
  higgsbounds_input_slha_(charfilename, &charfilenamelen);
  
  globalHiggsChi2 = 0.;
  
  if (yyVerbose) {
    cout << "-----------------------------------------------" << endl;
    cout << "-----------------------------------------------" << endl;
  }

  run_higgsbounds_( &HBresult, &chan, &obsratio, &ncombined     );
  if (HBresult < 0 || HBresult > 1) {
    return -1.0;
  }

  if (yyVerbose) {
    cout << "HBresult  " << HBresult  << endl;
    cout << "chan      " << chan      << endl;
    cout << "obsratio  " << obsratio  << endl;
    cout << "ncombined " << ncombined << endl;
    cout << "---------------------------" << endl;
    cout << "use a theory uncertainty of " << theory_uncertainty_1s << endl;
  }

  hb_calc_stats_(&theory_uncertainty_1s, &chisq_withouttheory, &chisq_withtheory, &bestChanChi2);
  if (chisq_withouttheory < 0.) {
    return -1.0;
  }
  if (chisq_withtheory < 0. && theory_uncertainty_1s > 0.0) {
    return -1.0;
  }
  if (chan != bestChanChi2) {
    if (HBresult==0) {
      chisq_withouttheory = 1000.;
      chisq_withtheory = 1000.;
    }
  }

  if (yyVerbose) {
    cout << "chisq_withouttheory " << chisq_withouttheory << endl;
    cout << "chisq_withtheory    " << chisq_withtheory    << endl;
    cout << "-----------------------------------------------" << endl;
    cout << "-----------------------------------------------" << endl;
  }
  
  // DIRTY FIXME for h0 -> chi+ chi-: 
  //if (mh<106.5) {
  //  chisq_withtheory += 1000.;
  //}





  globalHiggsChi2 = chisq_withtheory;
  return chisq_withtheory;

}

int call_HiggsBounds(int nH, double* parameterVector) 
{
  int chan, ncombined, HBresult, checkflag;
  double Mh[3], GammaTotal[3], g2hjbb[3], g2hjtautau[3], g2hjWW[3], g2hjZZ[3], g2hjgaga[3], g2hjgg[3], g2hjhiZ[3][3], BR_hjhihi[3][3], BR_hjhihisorted[3][3], g2hjhiZsorted[3][3], obsratio[3];
  double thisTanB = 0.;
  int IDarray[3] = {ID_h,ID_H,ID_A};
  int checkarray[3] = {0,1,2};
  double temp;
  int temp2;
  
  if (FindInFixed("TanBeta")) {
    thisTanB = ReturnFixedValue("TanBeta")->value;
  }    
  else if (FindInFitted("TanBeta")) {
    thisTanB = parameterVector[ReturnFittedPosition("TanBeta")];
  } 
  
  
  // Higgs Masses
  Mh[0]=yyMass[ID_h];
  Mh[1]=yyMass[ID_H];
  Mh[2]=yyMass[ID_A];
  vector<int> daughter_list;
  double temp_BR[3];
  if (Mh[0] == 0 || Mh[1] == 0 || Mh[2] == 0)
    {
      cout<<"Error: Cannot get Higgs-Masses. HiggsBounds aborted"<<endl;
      HBresult = 2;
      for (int i=0; i<nH; i++){ 
	HBmass[i].push_back(Mh[i]);
	gammah[i].push_back(0.);
	BR_hjbb[i].push_back(0.);
	BR_hjtautau[i].push_back(0.);
	O_g2hjZZ[i].push_back(0.);
      }
      return HBresult;
    }
  else {
    //		  double SMGammaTotal = smgamma_h_(&yyMass[ID_h]);
    for (int i=0; i<nH; i++){ 
      if (yyVerbose){
	cout << "mh = " << Mh[i] << endl;
      }
      double SMGammaTotal = 1.;
      double thisMh = 500.;
      double fudgeSafety = 1.;
      if (Mh[i]<500.) {
	thisMh = Mh[i];
      }
      else {
	thisMh = 500.;
	fudgeSafety = 1000.;
      }
      SMGammaTotal = smgamma_h_(&thisMh);
      HBmass[i].push_back(Mh[i]);
      GammaTotal[i] = yyGamma[IDarray[i]];
      gammah[i].push_back(yyGamma[IDarray[i]]);
      for (int j = 0;j<nH;j++){
	if (i!=j){
	  daughter_list.push_back(IDarray[i]);
	  daughter_list.push_back(IDarray[i]);
	  BR_hjhihi[j][i] = higgsBR(IDarray[j], daughter_list);
	  daughter_list.clear();
	}
	else { 
	  BR_hjhihi[j][i] = 0;
	  g2hjhiZ[i][j] = 0;
	}
	BR_hjhihisorted[j][i] = 0;
	g2hjhiZsorted[j][i] = 0;
      }
      daughter_list.push_back(ID_g);
      daughter_list.push_back(ID_g);
      temp_BR[i] = higgsBR(IDarray[i], daughter_list);
      g2hjgg[i] = (temp_BR[i]*GammaTotal[i])/(fudgeSafety*smbr_hgg_(&thisMh)*SMGammaTotal);
      daughter_list.clear();
      daughter_list.push_back(ID_gamma);
      daughter_list.push_back(ID_gamma);
      temp_BR[i] = higgsBR(IDarray[i], daughter_list);
      g2hjgaga[i] = (temp_BR[i]*GammaTotal[i])/(fudgeSafety*smbr_hgamgam_(&thisMh)*SMGammaTotal);
      daughter_list.clear();
      daughter_list.push_back(ID_b);
      daughter_list.push_back(-ID_b);
      temp_BR[i] = higgsBR(IDarray[i], daughter_list);
      BR_hjbb[i].push_back(temp_BR[i]);
      g2hjbb[i] = (temp_BR[i]*GammaTotal[i])/(fudgeSafety*smbr_hbb_(&thisMh)*SMGammaTotal);
      daughter_list.clear();
      daughter_list.push_back(ID_tau);
      daughter_list.push_back(-ID_tau);
      temp_BR[i] = higgsBR(IDarray[i], daughter_list);
      BR_hjtautau[i].push_back(temp_BR[i]);
      g2hjtautau[i] = (temp_BR[i]*GammaTotal[i])/(fudgeSafety*smbr_htautau_(&thisMh)*SMGammaTotal);
      daughter_list.clear();
    }
    
    g2hjZZ[0] = pow(((TMath::Sin(TMath::ATan(thisTanB)-yyalpha))),2);
    g2hjZZ[1] = pow(((TMath::Cos(TMath::ATan(thisTanB)-yyalpha))),2);
    g2hjZZ[2] = 0.;                                                
    g2hjWW[0] = pow(((TMath::Sin(TMath::ATan(thisTanB)-yyalpha))),2);
    g2hjWW[1] = pow(((TMath::Cos(TMath::ATan(thisTanB)-yyalpha))),2);
    g2hjWW[2] = 0.;                                              
    
    
    
    g2hjhiZ[0][1] = g2hjhiZ[1][0] = 0.;
    g2hjhiZ[0][2] = g2hjhiZ[2][0] = pow(((TMath::Cos(TMath::ATan(thisTanB)-yyalpha))),2);
    g2hjhiZ[1][2] = g2hjhiZ[2][1] = pow(((TMath::Sin(TMath::ATan(thisTanB)-yyalpha))),2);                                                
    for (int i = 0; i<nH;i++){
      O_g2hjZZ[i].push_back(g2hjZZ[i]);
    }
    
    
    
    for (int i = 0; i<nH; i++){
      checkflag = 0;
      for (int j = 0; j<nH-1; j++) {
	if(Mh[j]>Mh[j+1]){
	  temp = Mh[j];
	  Mh[j] = Mh[j+1];
	  Mh[j+1] = temp;
	  temp2 = IDarray[j];
	  IDarray[j] = IDarray[j+1];
	  IDarray[j+1] = temp2;
	  temp2 = checkarray[j];
	  checkarray[j] = checkarray[j+1];
	  checkarray[j+1] = temp2;
	  temp = g2hjgg[j]; 
	  g2hjgg[j] = g2hjgg[j+1];
	  g2hjgg[j+1] = temp;
	  temp = g2hjbb[j]; 
	  g2hjbb[j] = g2hjbb[j+1];
	  g2hjbb[j+1] = temp;
	  temp = g2hjZZ[j]; 
	  g2hjZZ[j] = g2hjZZ[j+1];
	  g2hjZZ[j+1] = temp;
	  temp = g2hjWW[j]; 
	  g2hjWW[j] = g2hjWW[j+1];
	  g2hjWW[j+1] = temp;
	  temp = g2hjtautau[j]; 
	  g2hjtautau[j] = g2hjtautau[j+1];
	  g2hjtautau[j+1] = temp;
	  temp = g2hjgaga[j]; 
	  g2hjgaga[j] = g2hjgaga[j+1];
	  g2hjgaga[j+1] = temp;
	  
	  checkflag = 1;
	}
      }
      if (!checkflag){
	break; 
      }
    }
    
    if (checkarray[0] == 0 && checkarray[1] == 1){}
    else {
      for (int i = 0; i<nH; i++){
	for (int j = 0; j<nH; j++){
	  g2hjhiZsorted[i][j] = g2hjhiZ[checkarray[i]][checkarray[j]]; 
	  BR_hjhihisorted[i][j] = BR_hjhihi[checkarray[i]][checkarray[j]]; 
	}
      }
    }
    
    run_higgsbounds_effc_(&nH, Mh, GammaTotal, g2hjbb, g2hjtautau, g2hjWW, g2hjZZ, g2hjgaga, g2hjgg, g2hjhiZsorted, BR_hjhihisorted, &HBresult, &chan, obsratio, &ncombined);
    if (yyVerbose){ 
      cout<<"INFO: Higgs masses: "<<Mh[0]<<" , "<<Mh[1]<<" , "<<Mh[2]<<endl;
      cout<<"INFO: Widths: "<<GammaTotal[0]<<" , "<<GammaTotal[1]<<" , "<<GammaTotal[2]<<endl;
      cout<<"INFO: hj -> bb: "<<g2hjbb[0]<<", "<<g2hjbb[1]<<", "<<g2hjbb[2]<<endl;
      cout<<"INFO: hj -> tau tau: "<<g2hjtautau[0]<<", "<<g2hjtautau[1]<<", "<<g2hjtautau[2]<<endl;
      cout<<"INFO: hj -> W W: "<<g2hjWW[0]<<", "<<g2hjWW[1]<<", "<<g2hjWW[2]<<endl;
      cout<<"INFO: hj -> Z Z: "<<g2hjZZ[0]<<", "<<g2hjZZ[1]<<", "<<g2hjZZ[2]<<endl;
      cout<<"INFO: hj -> gamma gamma: "<<g2hjgaga[0]<<", "<<g2hjgaga[1]<<", "<<g2hjgaga[2]<<endl;
      cout<<"INFO: hj -> gg: "<<g2hjgg[0]<<", "<<g2hjgg[1]<<", "<<g2hjgg[2]<<endl;
      cout<<"INFO: Z  -> hi hj: " << g2hjhiZsorted[0][1] << ", "  << g2hjhiZsorted[0][2] << ", " << g2hjhiZsorted[1][2] << endl;
      cout<<"INFO: channel: "<<chan<<endl;
      for (int i = 0; i<nH;i++){
	for (int j = 0; j<nH;j++){
	  cout<<"INFO: BR_h"<<j<<"h"<<i<<": "<<checkarray[0]<<checkarray[1]<<checkarray[2]<<", "<<BR_hjhihi[j][i]<<", "<<BR_hjhihisorted[j][i]<<endl;
	}
      }
    }
    
    return HBresult;
  }
}

string GetParameter(string par){


  double d;
  stringstream ss;
  string s;

  if (FindInFixed(par)) 
    d=ReturnFixedValue(par)->value;
  else if (FindInFitted(par)) 
    d=ReturnFittedValue(par)->value;
  else if (FindInUniversality(par)) 
    d=ReturnFittedValue(ReturnUniversality(par)->universality)->value;
  else {
MeasuredValue* ReturnUniversality (string name);
    cerr<<"Using hdecay without "<<par<<" given as parameter is not possible!"<<endl; 
    exit(EXIT_FAILURE);
  }

  ss<<d;
  ss>>s;
  return s;

}


void hdecayINfile()	{
	
	vector<string>	Input;

	Input.push_back("SLHAIN"); 
	Input.push_back("SLHAOUT"); 
	Input.push_back("HIGGS");   
	Input.push_back("SM4");     
	Input.push_back("FERMPHOB");
	Input.push_back("MODEL");
	Input.push_back("TGBET");   
	Input.push_back("MABEG");    
	Input.push_back("MAEND");   
	Input.push_back("NMA");     
	Input.push_back("ALS(MZ)");  
	Input.push_back("MSBAR(2)"); 
	Input.push_back("MC");     
	Input.push_back("MB");    
	Input.push_back("MT");  
	Input.push_back("MTAU"); 
	Input.push_back("MMUON");
	Input.push_back("1/ALPHA");
	Input.push_back("GF");  
	Input.push_back("GAMW");
	Input.push_back("GAMZ");
	Input.push_back("MZ"); 
	Input.push_back("MW");
	Input.push_back("VUS");
	Input.push_back("VCB");
	Input.push_back("VUB/VCB");
	Input.push_back("***** 4TH GENERATION *****");
	Input.push_back("MTP");
	Input.push_back("MBP");
	Input.push_back("MNUP");
	Input.push_back("MEP");
	Input.push_back("**************************");
	Input.push_back("SUSYSCALE");
	Input.push_back("MU");
	Input.push_back("M2");
	Input.push_back("MGLUINO");
	Input.push_back("MSL1");
	Input.push_back("MER1");
	Input.push_back("MQL1");
	Input.push_back("MUR1");
	Input.push_back("MDR1");
	Input.push_back("MSL");
	Input.push_back("MER");
	Input.push_back("MSQ");
	Input.push_back("MUR");
	Input.push_back("MDR");
	Input.push_back("AL");
	Input.push_back("AU");
	Input.push_back("AD");
	Input.push_back("NNLO (M)");
	Input.push_back("ON-SHELL");
	Input.push_back("ON-SH-WZ");
	Input.push_back("IPOLE");
	Input.push_back("OFF-SUSY");
	Input.push_back("INDIDEC");
	Input.push_back("NF-GG");
	Input.push_back("IGOLD");
	Input.push_back("MPLANCK");
	Input.push_back("MGOLD"); 

	vector<string>	InputVal;
	
	InputVal.push_back("1");
	InputVal.push_back("1");
	InputVal.push_back("5");
	InputVal.push_back("0");
	InputVal.push_back("0");
	InputVal.push_back("1");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back(GetParameter("massStrange"));		
	InputVal.push_back("1.67");		//MC pole - PDG 2012
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back(GetParameter("massMuon"));
	InputVal.push_back(GetParameter("alphaem"));
	InputVal.push_back("-1e12");
	InputVal.push_back("2.085");		//gamW - PDG 2012
	InputVal.push_back("2.4952");		//gamZ - PDG 2012
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("0.22534");		//VUS - PDG 2012
	InputVal.push_back("0.0412");		//VCB - PDG 2012
	InputVal.push_back("0.085194175");	//VUB/VCB - PDG 2012
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("-1e12");
	InputVal.push_back("1");	
	InputVal.push_back("0");
	InputVal.push_back("0");
	InputVal.push_back("0");
	InputVal.push_back("0");
	InputVal.push_back("0");
	InputVal.push_back("5");
	InputVal.push_back("0");
	InputVal.push_back("2.4D18");
	InputVal.push_back("1.D-13");

	vector<bool>	SetVal;
	
	SetVal.push_back(true);		//SLHAIN
	SetVal.push_back(true);		//SLHAOUT
	SetVal.push_back(true);		//HIGGS
	SetVal.push_back(true);		//SM4
	SetVal.push_back(true);		//FERMPHOB
	SetVal.push_back(true);		//MODEL
	SetVal.push_back(false);	//TGBET
	SetVal.push_back(false);	//MABEG
	SetVal.push_back(false);	//MAEND
	SetVal.push_back(false);	//NMA
	SetVal.push_back(false);	//ALS(MZ)
	SetVal.push_back(true);		//MSBAR(2)
	SetVal.push_back(true);		//MC
	SetVal.push_back(false);	//MB
	SetVal.push_back(false);	//MT
	SetVal.push_back(false);	//MTAU
	SetVal.push_back(true);		//MMUON
	SetVal.push_back(true);		//1/ALPHA	
	SetVal.push_back(false);	//GF
	SetVal.push_back(true);		//GAMW
	SetVal.push_back(true);		//GAMZ
	SetVal.push_back(false);	//MZ
	SetVal.push_back(false);	//MW
	SetVal.push_back(true);		//VUS
	SetVal.push_back(true);		//VCB
	SetVal.push_back(true);		//VUB/VCB
	SetVal.push_back(false);	//********
	SetVal.push_back(false);	//MTP
	SetVal.push_back(false);	//MBP
	SetVal.push_back(false);	//MNUP
	SetVal.push_back(false);	//MEP
	SetVal.push_back(false);	//********
	SetVal.push_back(false);	//SUSYSCALE
	SetVal.push_back(false);	//MU
	SetVal.push_back(false);	//M2
	SetVal.push_back(false);	//MGLUINO
	SetVal.push_back(false);	//MSL1
	SetVal.push_back(false);	//MER1
	SetVal.push_back(false);	//MQL1
	SetVal.push_back(false);	//MUR1	
	SetVal.push_back(false);	//MDR1
	SetVal.push_back(false);	//MSL
	SetVal.push_back(false);	//MER
	SetVal.push_back(false);	//MSQ
	SetVal.push_back(false);	//MUR
	SetVal.push_back(false);	//MDR
	SetVal.push_back(false);	//AL
	SetVal.push_back(false);	//AU
	SetVal.push_back(false);	//AD
	SetVal.push_back(true);		//NNLO (M)
	SetVal.push_back(true);		//ON-SHELL
	SetVal.push_back(true);		//ON-SH-WZ
	SetVal.push_back(true);		//IPOLE
	SetVal.push_back(true);		//OFF-SUSY
	SetVal.push_back(true);		//INDIDEC
	SetVal.push_back(true);		//NF-GG
	SetVal.push_back(true);		//IGOLD
	SetVal.push_back(true);		//MPLANCK
	SetVal.push_back(true);		//MGOLD
	
	int l=0;
	fstream HdecayIN;
	
	HdecayIN.open("hdecay.in", ios::in | ios::out | ios::trunc);
	for(unsigned int i=0; i<Input.size(); i++)	
	{
		l=9-strlen(Input[i].c_str());
		HdecayIN << Input[i];
		if(l>=0)	
		{
			for(int j=0;j<l;j++)	
			{
				HdecayIN << " ";
			}
			HdecayIN << "= " ;
			if (SetVal[i]) HdecayIN << InputVal[i] << endl;
			else HdecayIN << endl;
		}
		else	HdecayIN << endl;
	}
	HdecayIN.close();
}

//ReplaceBlock replaces a slha block in the file given in fNameOUT with the block from the file given in fNameIN
void ReplaceBlock(string fNameIN, string fNameOUT, string blockName)	{
	
 	ifstream ifstr_in(fNameIN.c_str());
 	ifstream ifstr_out(fNameOUT.c_str());
	
        Coll coll_in(ifstr_in);
 	Coll coll_out(ifstr_out);
	
 	ifstr_in.close();
 	ifstr_out.close();
	
 	coll_in.at(blockName).swap(coll_out.at(blockName));
	
 	ofstream ofstr(fNameOUT.c_str());
 	ofstr << coll_out;
 	ofstr.close();	
}

void ReplaceMass(string fName)	{
	
	ifstream ifstr(fName.c_str());
        Coll coll_in(ifstr);
	ifstr.close();
	
	coll_in["MASS"]["25"].at(1)=coll_in["FeynHiggs"]["1"].at(1);
	coll_in["MASS"]["35"].at(1)=coll_in["FeynHiggs"]["2"].at(1);
	coll_in["MASS"]["36"].at(1)=coll_in["FeynHiggs"]["3"].at(1);
	coll_in["MASS"]["37"].at(1)=coll_in["FeynHiggs"]["4"].at(1);
	
	ofstream ofstr(fName.c_str());
	ofstr << coll_in;
	ofstr.close();	

}

double ScanForHiggsLimit( int nH, double* parameterVector ) {

   double predictedHiggsMass = yyMass[ID_h];
   double higgsMassLimitCandidate = yyMass[ID_h];
   double scanStepWidth = 5.;
   const int ntriesLimit = 1000; 

   double higgsMassError = 0.3;
   for ( unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
      if ( yyMeasuredVec[i].name == "Massh0_npf" ||
	   yyMeasuredVec[i].name == "massh0" ) {
         higgsMassError = yyMeasuredVec[i].error;
      }
   }
   double tolerance = higgsMassError/100.*10.;

   bool higgsMassNotAccepted = true;
   int ntries = 0;
   while ( higgsMassNotAccepted && ntries < ntriesLimit ) {
     ntries++;

      yyMass[ID_h] += scanStepWidth;
      higgsMassNotAccepted = !( call_HiggsBounds( nH, parameterVector ) );

   }

   double higgsMassAccepted = yyMass[ID_h];
   double higgsMassRejected = yyMass[ID_h]-scanStepWidth;
   if ( yyVerbose ) { cout << "Found accepted higgs mass at " << higgsMassAccepted << endl; }

   bool higgsMassLimitNotFound = true;
   bool higgsMassLimitCandidateNotAccepted;
   if ( yyVerbose ) { cout << "Starting search for higgs mass limit" << endl; }
   ntries = 0;
   while ( higgsMassLimitNotFound && ntries < ntriesLimit ) {
     ntries++;

      higgsMassLimitCandidate = ( higgsMassRejected + higgsMassAccepted )/2.;

      yyMass[ID_h] = higgsMassLimitCandidate;
      higgsMassLimitCandidateNotAccepted = !( call_HiggsBounds( nH, parameterVector ) );

      if ( higgsMassLimitCandidateNotAccepted ) {

         higgsMassRejected = yyMass[ID_h];
         if ( yyVerbose ) { cout << "Higgs mass of " << higgsMassRejected << " rejected" << endl; }

         if ( fabs( higgsMassLimitCandidate - higgsMassAccepted ) < tolerance ) {

            if ( yyVerbose ) { cout << "Abort criterium met: Terminate" << endl; }
            higgsMassLimitNotFound = false;

         }
         else { if ( yyVerbose ) { cout << "Abort criterium not met. Continue." << endl; } }

      }
      else {

         higgsMassAccepted = yyMass[ID_h];
         if ( yyVerbose ) { cout << "higgs mass of " << higgsMassAccepted << " accepted" << endl; }

         if ( fabs( higgsMassLimitCandidate - higgsMassRejected ) < tolerance ) {

            if ( yyVerbose ) { cout << "Abort criterium met: Terminate" << endl; }
            higgsMassLimitNotFound = false;

         }
         else { if ( yyVerbose ) { cout << "Abort criterium not met. Continue." << endl; } }

      }

   }

   double higgsMassLimit = higgsMassLimitCandidate;
   if ( yyVerbose ) { cout << "Higgs mass limit is " << higgsMassLimit << endl; }


   yyMass[ID_h] = predictedHiggsMass;
   return higgsMassLimit;

}

#endif

Fittino::Fittino(const Input* input)
{
  fInput = input;
  fFittedCovarianceMatrix = 0;
  mSquarkGluinoMax = 1000.;

 
  //Added by JL & BOL. Here we read in the grids. Thus we do not need to read them in at every single step.

  for (unsigned int i=0; i<yyMeasuredVec.size();i++){
    if (yyMeasuredVec[i].type==LHCRate){

      // if it's one of the old sRates signals...
      if( ( yyMeasuredVec[i].id == fully_inclusive )
          ||
          ( yyMeasuredVec[i].id == os_sf )
          ||
          ( yyMeasuredVec[i].id == four_b ) )
       {

         rateValue = new sRates("fb",yyUseNLO);
         rateValue->readGrids();
         rateValue->readLeptonGrids();
        //break;
        // we cannot exit this loop prematurely now, since there could be
        // LHC-FASER signals too, which also require initialization per signal.

        }
      else
        {

          if( NULL == lhcFaserSignals )
          // if the LHC-FASER_UI object has not yet been constructed...
          {

            lhcFaserSignals = new LHC_FASER::LHC_FASER_UI( "SPheno.spc.last",
                                                          "./LHC-FASER/grids/",
                                                           "fb",
                                                           yyUseNLO );
            // these are the defaults for what I (BOL) think is the standard
            // Fittino setup.

          }

        /* I (BOL) am sure that there's a more elegant way of doing this, but
         * I really do not want to mess with the lexical parser.
         * (if someone with more confidence wants to do so, I'd have a
         * std::vector of strings which are the signal names, & go through that
         * vector once, here, loading in all the signals, & then we could break
         * from this loop over the yyMeasuredVec entries. actually, we wouldn't
         * even have to go into this loop, we could just loop over the vector
         * of signal names.
         */
        if( yyMeasuredVec[i].id == Atlas4jMET0l7TeV )
          {

            lhcFaserAtlas4jMET0l7TeV
            = lhcFaserSignals->add_signal( "Atlas4jMET0l7TeV" );

          }
        else if( yyMeasuredVec[i].id == Atlas3jMET1l7TeV )
          {

            lhcFaserAtlas3jMET1l7TeV
            = lhcFaserSignals->add_signal( "Atlas3jMET1l7TeV" );

          }

      }
    }
  }

  if (yyUseXsecLimits) {
    std::ifstream infile(yyGridPath.c_str());
    if (!infile.is_open()) {
      std::cerr << "Cannot open cross-section file" << std::endl;
      exit(EXIT_FAILURE);
    }

    std::string line;
    for (int i=0; i<2; i++) { // skip first two lines containing legend
      getline(infile,line);
    }
  
    double norm;
    double m0, m12, msq, mgl, xsnlo;
    double meff1, meff2, meff3, meff4, meff5;
    double meff6, meff7, meff8, meff9, meff10;
    std::pair<int, int> p;

    int histno = 0;
    TH1D* histo;
    while (!infile.eof()) {
//      infile >> m0 >> m12 >> msq >> mgl >> xsnlo >> meff1 >> meff2 
//	     >> meff3 >> meff4 >> meff5 >> meff6 >> meff7 >> meff8
//	     >> meff9 >> meff10;
      // FIXME: Adapt to final sctructure
      infile >> m0 >> m12  >> msq >> mgl >> meff1 >> meff2 >> meff3 ;

      char no[256];
      sprintf(no,"%d",histno);
      histno++;
      string histname = "histname_";
      histname = histname +no;
      //      norm = xsnlo; // Michael's files are normalised to unity, i. e. scale with NLO xs
      norm = 1; // Björn's files are normalised to expected events numbers, i. e. scale with 1
      histo = new TH1D(histname.c_str(), "", 3, 0, 3);
      histo->SetBinContent( 1,  meff1 * norm);
      histo->SetBinContent( 2,  meff2 * norm);
      histo->SetBinContent( 3,  meff3 * norm);
//      histo->SetBinContent( 4,  meff4 * norm);
//      histo->SetBinContent( 5,  meff5 * norm);
//      histo->SetBinContent( 6,  meff6 * norm);
//      histo->SetBinContent( 7,  meff7 * norm);
//      histo->SetBinContent( 8,  meff8 * norm);
//      histo->SetBinContent( 9,  meff9 * norm);
//      histo->SetBinContent(10, meff10 * norm);
      
      p.first = (int)m0;
      p.second = (int)m12;
      signalXsec[p] = histo;
    }

    hbkgd = new TH1D("hbkgd", "", 3, 0, 3);
//    hbkgd->SetBinContent(1, 358.48);
//    hbkgd->SetBinContent(2, 1974.87);
//    hbkgd->SetBinContent(3, 75.07);
//    hbkgd->SetBinContent(4, 8.98);
//    hbkgd->SetBinContent(5, 0.52);
//    hbkgd->SetBinContent(6, 0.32);
//    hbkgd->SetBinContent(7, 0);
//    hbkgd->SetBinContent(8, 0);
//    hbkgd->SetBinContent(9, 0);
//    hbkgd->SetBinContent(10, 0);
    hbkgd->SetBinContent(1, 73.3);  // FIXME: CORRECT VALUE
    hbkgd->SetBinContent(2, 61.2);  // FIXME: CORRECT VALUE
    hbkgd->SetBinContent(3, 44.2); // FIXME: CORRECT VALUE
    hbkgd->Scale(yyLumi);

    hdata = new TH1D("hdata", "", 3, 0, 3);
    hdata->SetBinContent(1, 60.6); // FIXME: CORRECT VALUE
    hdata->SetBinContent(2, 48.5); // FIXME: CORRECT VALUE
    hdata->SetBinContent(3, 42.4); // FIXME: CORRECT VALUE
    hdata->Scale(yyLumi);          // this is rather unconventional,
				   // but could be interesting to see
				   // how excesses would scale

  }
}


Fittino::~Fittino()
{      
      
      ////Added by JL & BOL
    if( NULL !=  rateValue )
      {

        delete rateValue;

      }

    if( NULL !=  lhcFaserSignals )
      {

        delete lhcFaserSignals;

      }
      ////////
      

}

void Fittino::calculateM1(const SmearedInput* input)
{
   double ka[3],kb[3],kc[3],kd[3];
   double rad[8], mka[4],mkb[4],mkc[4];
   double mst[4][2];
   double mnt[4];

   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double cos2ThetaW = 1. - sin2ThetaW;
   double beta       = TMath::ATan(fTanBeta);

   mnt[0] = input->GetValue("massNeutralino1");
   mnt[1] = input->GetValue("massNeutralino2");
   //    mnt[2] = input->GetValue("massNeutralino3");
   //    mnt[3] = input->GetValue("massNeutralino4");

   for (int jsss=0;jsss<3;jsss++) {
      ka[jsss]=0.;
      kb[jsss]=0.;
      kc[jsss]=0.;
      kd[jsss]=0.;
   }

   double mz = input->GetValue("massZ");

   ka[2]=sqr(fM2)+2.*sqr(fAbsMu)+2.*sqr(mz);

   kb[0]=sqr(fM2)+2.*sqr(fAbsMu)+2.*sqr(mz)
      *cos2ThetaW;
   kb[1]=-2.*TMath::Sin(2.*beta)*fAbsMu*sqr(mz)
      *sin2ThetaW;
   kb[2]= 2.*sqr(fAbsMu)*sqr(fM2)+sqr(sqr(fAbsMu)+sqr(mz))
      -2.*sqr(mz)*TMath::Sin(2.*beta)*cos2ThetaW*fAbsMu*fM2
      +2.*sin2ThetaW*sqr(mz)*sqr(fM2);

   kd[0]= TMath::Power(fAbsMu,4)*sqr(fM2)+TMath::Power(mz,4)
      *sqr(fAbsMu)*sqr(TMath::Sin(2.*beta))*sqr(cos2ThetaW)
      -2.*sqr(mz)*TMath::Power(fAbsMu,3)*fM2
      *TMath::Sin(2.*beta)*cos2ThetaW;
   kd[1]= 2.*TMath::Power(mz,4)*sqr(fAbsMu)*fM2
      *sin2ThetaW
      *cos2ThetaW*sqr(TMath::Sin(2.*beta))
      -2.*sqr(mz)*TMath::Power(fAbsMu,3)*sqr(fM2)
      *TMath::Sin(2.*beta)*sin2ThetaW;
   kd[2]= TMath::Power(mz,4)*sqr(fAbsMu)
      *sqr(TMath::Sin(2.*beta))
      *sqr(fM2)*sqr(sin2ThetaW);

   // --------------------------------------------------
   //   kc in version vom 22.5.01 nach Vergleich mit math
   kc[0]=TMath::Power(fAbsMu,4)+2.*sqr(fAbsMu)*sqr(fM2)+2.
      *sqr(mz)*sqr(fAbsMu)*cos2ThetaW
      +TMath::Power(mz,4)*sqr(cos2ThetaW)
      -2.*sqr(mz)*fAbsMu*TMath::Sin(2.*beta)*fM2*cos2ThetaW;
   kc[1]= 2.*TMath::Power(mz,4)*fM2*sin2ThetaW
      *cos2ThetaW-2.*sqr(mz)*TMath::Sin(2.*beta)
      *TMath::Power(fAbsMu,3)*sin2ThetaW-2.
      *sqr(mz)*TMath::Sin(2.*beta)*fAbsMu
      *sqr(fM2)*sin2ThetaW;
   kc[2]= TMath::Power(fAbsMu,4)*sqr(fM2)+TMath::Power(mz,4)
      *sqr(fAbsMu)*sqr(TMath::Sin(2.*beta))
      +2.*sqr(mz)*sqr(fAbsMu)*sqr(fM2)
      *sin2ThetaW
      -2.*sqr(mz)*TMath::Sin(2.*beta)*fM2
      *TMath::Power(fAbsMu,3)*cos2ThetaW
      +TMath::Power(mz,4)*sqr(fM2)
      *sqr(sin2ThetaW);

   //   If all four neutralino masses useful:
   //   then loop over is = 1,4
   //   Otherwise:
   //   Only use LSP Mass:

   int is = 0;

   rad[is+4]=0.;
   mka[is]=0.;
   mkb[is]=0.;
   mkc[is]=0.;
   mka[is]=-TMath::Power(mnt[is],6)+kb[0]*TMath::Power(mnt[is],4)
      -kc[0]*sqr(mnt[is])+kd[0];
   mkb[is]=kb[1]*TMath::Power(mnt[is],4)-kc[1]*sqr(mnt[is])+kd[1];
   mkc[is]=TMath::Power(mnt[is],8)-ka[2]*TMath::Power(mnt[is],6)
      +kb[2]*TMath::Power(mnt[is],4)
      -kc[2]*sqr(mnt[is])+kd[2];

   rad[is+4]=sqr(mkb[is])-4.*mka[is]*mkc[is];
   if (rad[is+4]<0.) {
      //    write(*,'(a23)') '# rad(mst)<0';
   }

   mst[is][0]=(-mkb[is]+TMath::Sqrt(sqr(mkb[is])-4.*mka[is]*mkc[is]))
      /2./mka[is];
   mst[is][1]=(-mkb[is]-TMath::Sqrt(sqr(mkb[is])-4.*mka[is]*mkc[is]))
      /2./mka[is];

   fM1.value = mst[0][0];
}


void Fittino::calculateM2(const SmearedInput* input)
{
   double massChargino1 = input->GetValue("massChargino1");
   double massChargino2 = input->GetValue("massChargino2");
   double massW         = input->GetValue("massW");
   double cos2phil      = input ->GetValue("cos2PhiL");
   double cos2phir      = input ->GetValue("cos2PhiR");

   double sigma = ((sqr(massChargino2)
	    +sqr(massChargino1))
	 /(2.*sqr(massW)))-1.;
   double delta = (sqr(massChargino2)
	 -sqr(massChargino1))
      /(4.*sqr(massW));

   fM2.value = massW * TMath::Sqrt(sigma - delta
	 * (cos2phil+cos2phir));
}


void Fittino::calculateAbsM3(const SmearedInput* input)
{
   fAbsM3.value = input->GetValue("massGluino");
}  


void Fittino::calculateTanBeta(const SmearedInput* input)
{
   double massChargino1 = input->GetValue("massChargino1");
   double massChargino2 = input->GetValue("massChargino2");
   double massW         = input->GetValue("massW");
   double cos2phil      = input ->GetValue("cos2PhiL");
   double cos2phir      = input ->GetValue("cos2PhiR");

   double delta = (sqr(massChargino2)
	 -sqr(massChargino1))
      /(4.*sqr(massW));
   double tan2Beta = (1.+delta*(cos2phir
	    -cos2phil))/
      (1.-delta*(cos2phir
		 -cos2phil));

   (tan2Beta >= 0.) ? fTanBeta.value = TMath::Sqrt(tan2Beta)
      : fTanBeta.value = 0.;
}  


void Fittino::calculateAbsMu(const SmearedInput* input)
{
   double massChargino1 = input->GetValue("massChargino1");
   double massChargino2 = input->GetValue("massChargino2");
   double massW         = input->GetValue("massW");
   double cos2phil      = input ->GetValue("cos2PhiL");
   double cos2phir      = input ->GetValue("cos2PhiR");

   double sigma = (sqr(massChargino2)
	 +sqr(massChargino1))
      /(2.*sqr(massW))-1.;
   double delta = (sqr(massChargino2)
	 -sqr(massChargino1))
      /(4.*sqr(massW));

   fAbsMu.value = massW * TMath::Sqrt(sigma
	 + delta*(cos2phil+cos2phir));
}


void Fittino::calculateSignMu(const SmearedInput* input)
{
   double massChargino1 = input->GetValue("massChargino1");
   double massChargino2 = input->GetValue("massChargino2");
   double massW         = input->GetValue("massW");

   double beta  = TMath::ATan(fTanBeta);
   double delta = (sqr(massChargino2)
	 -sqr(massChargino1))
      /(4.*sqr(massW));

   fSignMu.value = -(sqr(delta)-sqr(sqr(fM2)-sqr(fAbsMu))-
	 4.*sqr(massW)*(sqr(fM2)+sqr(fAbsMu)) - 
	 4.*TMath::Power(massW,4)
	 *(sqr(TMath::Cos(2.*beta))))
      /(8.*sqr(massW)*fM2*
	    fAbsMu*TMath::Sin(2.*beta));
}

void Fittino::calculateMSelL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mElectron = 0.000511;
   double mSelectron1 = input->GetValue("massSelectronL");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-sin2ThetaW) - sqr(mElectron) + sqr(mSelectron1);
   fMSelL.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMSelR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mElectron = 0.000511;
   double mSelectron1 = input->GetValue("massSelectronR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-sin2ThetaW) - sqr(mElectron) + sqr(mSelectron1);
   fMSelR.value = TMath::Sqrt(Msq);

   return;
}

void Fittino::calculateMSmuL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mMuon = 0.105658;
   double mSmuon1 = input->GetValue("massSmuL");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-sin2ThetaW) - sqr(mMuon) + sqr(mSmuon1);
   fMSmuL.value = TMath::Sqrt(Msq);
   //  if (yyVerbose){
   //  cout << fMSmuL.value << endl;
   //  }
   return;
}
void Fittino::calculateMSmuR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mMuon = 0.105658;
   double mSmuon1 = input->GetValue("massSmuR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-sin2ThetaW) - sqr(mMuon) + sqr(mSmuon1);
   fMSmuR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMStauL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mTau = 1.77;
   double mStau1 = input->GetValue("massStau2");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-sin2ThetaW) - sqr(mTau) + sqr(mStau1);
   fMStauL.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMStauR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mTau = 1.77;
   double mStau1 = input->GetValue("massStau1");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-sin2ThetaW) - sqr(mTau) + sqr(mStau1);
   fMStauR.value = TMath::Sqrt(Msq);

   return;
}

void Fittino::calculateMSupL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mElectron = 0.000511;
   double mSup1 = input->GetValue("massSupL");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-(2./3.)*sin2ThetaW) + sqr(mSup1);
   fMSupL.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMScharmL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mElectron = 0.000511;
   double mScharm1 = input->GetValue("massScharmL");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-(2./3.)*sin2ThetaW) + sqr(mScharm1);
   fMScharmL.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMStopL(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mTop = 174.3;
   double mStop1 = input->GetValue("massStop2");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(0.5-(2./3.)*sin2ThetaW) -sqr(mTop) + sqr(mStop1);
   fMStopL.value = TMath::Sqrt(Msq);

   return;
}

void Fittino::calculateMSupR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mTop = 174.3;
   double mSup1 = input->GetValue("massSupR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(2./3.)*sin2ThetaW) + sqr(mSup1);
   fMSupR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMScharmR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mTop = 174.3;
   double mScharm1 = input->GetValue("massScharmR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(2./3.)*sin2ThetaW) + sqr(mScharm1);
   fMScharmR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMStopR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mTop = 174.3;
   double mStop1 = input->GetValue("massStop1");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(2./3.)*sin2ThetaW) -sqr(mTop) + sqr(mStop1);
   fMStopR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMSdownR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mTop = 174.3;
   double mSdown1 = input->GetValue("massSdownR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(1./3.)*sin2ThetaW) + sqr(mSdown1);
   fMSdownR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMSstrangeR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   //double mTop = 174.3;
   double mSstrange1 = input->GetValue("massSstrangeR");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(1./3.)*sin2ThetaW) + sqr(mSstrange1);
   fMSstrangeR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateMSbottomR(const SmearedInput* input)
{
   double massZ = input->GetValue("massZ");
   double beta  = TMath::ATan(fTanBeta);
   double sin2ThetaW = input->GetValue("sin2ThetaW");
   double mBottom = 4.2;
   double mSbottom1 = input->GetValue("massSbottom2");
   double Msq;

   Msq = sqr(massZ)*TMath::Cos(2.*beta)*(-(1./3.)*sin2ThetaW) -sqr(mBottom)+ sqr(mSbottom1);
   fMSbottomR.value = TMath::Sqrt(Msq);

   return;
}
void Fittino::calculateXtau(const SmearedInput* input)
{
   double mu = fMu.value;

   fXtau.value = mu * fTanBeta;

   return;
}
void Fittino::calculateXtop(const SmearedInput* input)
{
   double mu = fMu.value;

   fXtop.value = mu / fTanBeta;

   return;
}

void Fittino::calculateXbottom(const SmearedInput* input)
{
   double mu = fMu.value;

   fXbottom.value = mu * fTanBeta;

   return;
}

//==================================================================
//
//
//
//
//
//
//==================================================================

void Fittino::calculateTreeLevelValues(int nthrows)
{
   double sumM1  = 0, sumM2    = 0, sumM3       = 0;
   double sumMu  = 0, sumBeta  = 0, sumTanBeta  = 0.;
   double sum2M1 = 0, sum2M2   = 0, sum2M3      = 0;
   double sum2Mu = 0, sum2Beta = 0, sum2TanBeta = 0;
   double sumMSelL = 0, sum2MSelL = 0; 
   double sumMSmuL = 0, sum2MSmuL = 0; 
   double sumMStauL = 0, sum2MStauL = 0; 
   double sumMSelR = 0, sum2MSelR = 0; 
   double sumMSmuR = 0, sum2MSmuR = 0; 
   double sumMStauR = 0, sum2MStauR = 0; 
   double sumMSupL = 0, sum2MSupL = 0; 
   double sumMScharmL = 0, sum2MScharmL = 0; 
   double sumMStopL = 0, sum2MStopL = 0; 
   double sumMSupR = 0, sum2MSupR = 0; 
   double sumMScharmR = 0, sum2MScharmR = 0; 
   double sumMStopR = 0, sum2MStopR = 0; 
   double sumMSdownR = 0, sum2MSdownR = 0; 
   double sumMSstrangeR = 0, sum2MSstrangeR = 0; 
   double sumMSbottomR = 0, sum2MSbottomR = 0; 
   double sumXtau = 0, sum2Xtau = 0; 
   double sumXtop = 0, sum2Xtop = 0; 
   double sumXbottom = 0, sum2Xbottom = 0; 

   int    nvalid = 0;
   MeasuredValue tmpValue;
   MeasuredValue fnew;
   bool par_already_found;


   if (!yyUseGivenStartValues){


   SmearedInput* smearedinput = new SmearedInput(fInput);

   for (int i = 0; i < nthrows; i++) {
      smearedinput->throwDice();

      // NOTICE: order of calculation is important
      calculateTanBeta(smearedinput);
      calculateM2(smearedinput);
      calculateAbsMu(smearedinput);
      calculateSignMu(smearedinput);
      fMu.value = TMath::Sign(fAbsMu, fSignMu);
      calculateM1(smearedinput);
      calculateAbsM3(smearedinput);

      calculateMSelL(smearedinput);
      calculateMSmuL(smearedinput);
      calculateMStauL(smearedinput);
      calculateMSelR(smearedinput);
      calculateMSmuR(smearedinput);
      calculateMStauR(smearedinput);

      calculateMSupL(smearedinput);
      calculateMScharmL(smearedinput);
      calculateMStopL(smearedinput);
      calculateMSupR(smearedinput);
      calculateMScharmR(smearedinput);
      calculateMStopR(smearedinput);
      calculateMSdownR(smearedinput);
      calculateMSstrangeR(smearedinput);
      calculateMSbottomR(smearedinput);

      calculateXtau(smearedinput);
      calculateXtop(smearedinput);
      calculateXbottom(smearedinput);

      if (fTanBeta > 0) {
	 nvalid++;
	 sumM1 += fM1;
	 sumM2 += fM2;
	 sumM3 += fAbsM3;
	 sumBeta += TMath::ATan(fTanBeta);
	 sumTanBeta += fTanBeta;
	 sumMu += fMu;

	 sumMSelL += fMSelL;
	 sumMSmuL += fMSmuL;
	 sumMStauL += fMStauL;
	 sumMSelR += fMSelR;
	 sumMSmuR += fMSmuR;
	 sumMStauR += fMStauR;
	 sumMSupL += fMSupL;
	 sumMScharmL += fMScharmL;
	 sumMStopL += fMStopL;
	 sumMSupR += fMSupR;
	 sumMScharmR += fMScharmR;
	 sumMStopR += fMStopR;
	 sumMSdownR += fMSdownR;
	 sumMSstrangeR += fMSstrangeR;
	 sumMSbottomR += fMSbottomR;
	 sumXtau += fXtau;
	 sumXtop += fXtop;
	 sumXbottom += fXbottom;

	 sum2M1 += sqr(fM1);
	 sum2M2 += sqr(fM2);
	 sum2M3 += sqr(fAbsM3);
	 sum2Beta += sqr(TMath::ATan(fTanBeta));
	 sum2TanBeta += sqr(fTanBeta);
	 sum2Mu += sqr(fMu);

	 sum2MSelL += sqr(fMSelL);
	 sum2MSmuL += sqr(fMSmuL);
	 sum2MStauL += sqr(fMStauL);
	 sum2MSelR += sqr(fMSelR);
	 sum2MSmuR += sqr(fMSmuR);
	 sum2MStauR += sqr(fMStauR);
	 sum2MSupL      += sqr(fMSupL);
	 sum2MScharmL   += sqr(fMScharmL);
	 sum2MStopL     += sqr(fMStopL);
	 sum2MSupR      += sqr(fMSupR);
	 sum2MScharmR   += sqr(fMScharmR);
	 sum2MStopR     += sqr(fMStopR);
	 sum2MSdownR    += sqr(fMSdownR);
	 sum2MSstrangeR += sqr(fMSstrangeR);
	 sum2MSbottomR  += sqr(fMSbottomR);
	 sum2Xtau       += sqr(fXtau);
	 sum2Xtop       += sqr(fXtop);
	 sum2Xbottom    += sqr(fXbottom);
      }
   }

   delete smearedinput;


   }

   // look at given observables, decide which parameters can be fitted, ask 
   // user for list of parameters to be fitted


   fQEWSB.name  = "QEWSB";
   fQEWSB.value = 1000.;
   fQEWSB.error = 50.;
   if (yyUseGivenStartValues && (FindInFittedPar("QEWSB") >= 0)) {
      fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value ;
      if (yyFittedPar[FindInFittedPar("QEWSB")].error > 0.) {
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error ;
      }
   }
   fQEWSB.bound_low = 91.2;
   fQEWSB.bound_up = 10000.;

   fM1.name  = "M1";
   fM1.value = sumM1 / double(nvalid);
   fM1.error = TMath::Sqrt(sum2M1 / double(nvalid) - sqr(fM1.value));
   if (yyUseGivenStartValues && (FindInFittedPar("M1") >= 0)) {
      fM1.value = yyFittedPar[FindInFittedPar("M1")].value ;
      if (yyFittedPar[FindInFittedPar("M1")].error > 0.) {
	 fM1.error = yyFittedPar[FindInFittedPar("M1")].error ;
      }
   }
   fM1.bound_low = 0.;
   fM1.bound_up = 10000.;

   fM2.name  = "M2";
   fM2.value = sumM2 / double(nvalid);
   fM2.error = TMath::Sqrt(sum2M2 / double(nvalid) - sqr(fM2.value));
   if (yyUseGivenStartValues && (FindInFittedPar("M2") >= 0)) { 
      fM2.value = yyFittedPar[FindInFittedPar("M2")].value ;
      if (yyFittedPar[FindInFittedPar("M2")].error > 0.) {
	 fM2.error = yyFittedPar[FindInFittedPar("M2")].error ;
      }
   }
   fM2.bound_low = 0.;
   fM2.bound_up = 10000.;

   fAbsM3.name  = "M3";
   fAbsM3.value = sumM3 / double(nvalid);
   fAbsM3.error = TMath::Sqrt(sum2M3 / double(nvalid) - sqr(fAbsM3.value));
   if (yyUseGivenStartValues && (FindInFittedPar("M3") >= 0)) { 
      fAbsM3.value = yyFittedPar[FindInFittedPar("M3")].value ;
      if (yyFittedPar[FindInFittedPar("M3")].error > 0.) {
	 fAbsM3.error = yyFittedPar[FindInFittedPar("M3")].error ;
      }
   }
   fAbsM3.bound_low = 0.;
   fAbsM3.bound_up = 10000.;

   fTanBeta.name  = "TanBeta";
   fTanBeta.value = sumTanBeta / double(nvalid);
   fTanBeta.error = TMath::Sqrt(sum2TanBeta / double(nvalid)
	 - sqr(fTanBeta.value));
   if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) { 
      fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value ;
      if (yyFittedPar[FindInFittedPar("TanBeta")].error > 0.) {
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error ;
      }
   }
   fTanBeta.bound_low = 0.;
   fTanBeta.bound_up = 1000.;

   fMu.name = "Mu";
   fMu.value = sumMu / double(nvalid);
   fMu.error = TMath::Sqrt(sum2Mu / double(nvalid) - sqr(fMu.value));
   if (yyUseGivenStartValues && (FindInFittedPar("Mu") >= 0)) { 
      fMu.value = yyFittedPar[FindInFittedPar("Mu")].value ;
      if (yyFittedPar[FindInFittedPar("Mu")].error > 0.) {
	 fMu.error = yyFittedPar[FindInFittedPar("Mu")].error ;
      }
   }
   fMu.bound_low = 0.;
   fMu.bound_up = 10000.;

   fMSelL.name = "MSelectronL";
   fMSelL.value = sumMSelL/ double(nvalid);
   fMSelL.error = TMath::Sqrt(sum2MSelL / double(nvalid) - sqr(fMSelL.value));
   if ((TMath::Abs(fMSelL.error)>TMath::Abs(fMSelL.value/2.)) || 
	 (TMath::Abs(fMSelL.error)<TMath::Abs(fMSelL.value/10.))) {
      fMSelL.error = TMath::Abs(fMSelL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSelectronL") >= 0)) { 
      fMSelL.value = yyFittedPar[FindInFittedPar("MSelectronL")].value ;
      if (yyFittedPar[FindInFittedPar("MSelectronL")].error > 0.) {
	 fMSelL.error = yyFittedPar[FindInFittedPar("MSelectronL")].error ;
      }
   }
   fMSelL.bound_low = 0.;
   fMSelL.bound_up = 10000.;

   fMSmuL.name = "MSmuL";
   fMSmuL.value = sumMSmuL/ double(nvalid);
   fMSmuL.error = TMath::Sqrt(sum2MSmuL / double(nvalid) - sqr(fMSmuL.value));
   if ((TMath::Abs(fMSmuL.error)>TMath::Abs(fMSmuL.value/2.)) || 
	 (TMath::Abs(fMSmuL.error)<TMath::Abs(fMSmuL.value/10.))) {
      fMSmuL.error = TMath::Abs(fMSmuL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSmuL") >= 0)) { 
      fMSmuL.value = yyFittedPar[FindInFittedPar("MSmuL")].value ;
      fMSmuL.error = yyFittedPar[FindInFittedPar("MSmuL")].error;
   }
   fMSmuL.bound_low = 0.;
   fMSmuL.bound_up = 10000.;

   fMStauL.name = "MStauL";
   fMStauL.value = sumMStauL/ double(nvalid);
   fMStauL.error = TMath::Sqrt(sum2MStauL / double(nvalid) - sqr(fMStauL.value));
   if ((TMath::Abs(fMStauL.error)>TMath::Abs(fMStauL.value/2.)) || 
	 (TMath::Abs(fMStauL.error)<TMath::Abs(fMStauL.value/10.))) {
      fMStauL.error = TMath::Abs(fMStauL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MStauL") >= 0)) { 
      fMStauL.value = yyFittedPar[FindInFittedPar("MStauL")].value ;
      fMStauL.error = yyFittedPar[FindInFittedPar("MStauL")].error;
   }
   fMStauL.bound_low = 0.;
   fMStauL.bound_up = 10000.;

   fMSelR.name = "MSelectronR";
   fMSelR.value = sumMSelR/ double(nvalid);
   fMSelR.error = TMath::Sqrt(sum2MSelR / double(nvalid) - sqr(fMSelR.value));
   if ((TMath::Abs(fMSelR.error)>TMath::Abs(fMSelR.value/2.)) || 
	 (TMath::Abs(fMSelR.error)<TMath::Abs(fMSelR.value/10.))) {
      fMSelR.error = TMath::Abs(fMSelR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSelectronR") >= 0)) { 
      fMSelR.value = yyFittedPar[FindInFittedPar("MSelectronR")].value ;
      fMSelR.error = yyFittedPar[FindInFittedPar("MSelectronR")].error ;
   }
   fMSelR.bound_low = 0.;
   fMSelR.bound_up = 10000.;

   fMSmuR.name = "MSmuR";
   fMSmuR.value = sumMSmuR/ double(nvalid);
   fMSmuR.error = TMath::Sqrt(sum2MSmuR / double(nvalid) - sqr(fMSmuR.value));
   if ((TMath::Abs(fMSmuR.error)>TMath::Abs(fMSmuR.value/2.)) || 
	 (TMath::Abs(fMSmuR.error)<TMath::Abs(fMSmuR.value/10.))) {
      fMSmuR.error = TMath::Abs(fMSmuR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSmuR") >= 0)) { 
      fMSmuR.value = yyFittedPar[FindInFittedPar("MSmuR")].value ;
      fMSmuR.error = yyFittedPar[FindInFittedPar("MSmuR")].error;
   }
   fMSmuR.bound_low = 0.;
   fMSmuR.bound_up = 10000.;

   fMStauR.name = "MStauR";
   fMStauR.value = sumMStauR/ double(nvalid);
   fMStauR.error = TMath::Sqrt(sum2MStauR / double(nvalid) - sqr(fMStauR.value));
   if ((TMath::Abs(fMStauR.error)>TMath::Abs(fMStauR.value/2.)) || 
	 (TMath::Abs(fMStauR.error)<TMath::Abs(fMStauR.value/10.))) {
      fMStauR.error = TMath::Abs(fMStauR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MStauR") >= 0)) { 
      fMStauR.value = yyFittedPar[FindInFittedPar("MStauR")].value ;
      fMStauR.error = yyFittedPar[FindInFittedPar("MStauR")].error ;
   }
   fMStauR.bound_low = 0.;
   fMStauR.bound_up = 10000.;

   fMSupL.name = "MSupL";
   fMSupL.value = sumMSupL/ double(nvalid);
   fMSupL.error = TMath::Sqrt(sum2MSupL / double(nvalid) - sqr(fMSupL.value));
   if ((TMath::Abs(fMSupL.error)>TMath::Abs(fMSupL.value/2.)) || 
	 (TMath::Abs(fMSupL.error)<TMath::Abs(fMSupL.value/10.))) {
      fMSupL.error = TMath::Abs(fMSupL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSupL") >= 0)) { 
      fMSupL.value = yyFittedPar[FindInFittedPar("MSupL")].value ;
      fMSupL.error = yyFittedPar[FindInFittedPar("MSupL")].error ;
   }
   fMSupL.bound_low = 0.;
   fMSupL.bound_up = 10000.;

   fMScharmL.name = "MScharmL";
   fMScharmL.value = sumMScharmL/ double(nvalid);
   fMScharmL.error = TMath::Sqrt(sum2MScharmL / double(nvalid) - sqr(fMScharmL.value));
   if ((TMath::Abs(fMScharmL.error)>TMath::Abs(fMScharmL.value/2.)) || 
	 (TMath::Abs(fMScharmL.error)<TMath::Abs(fMScharmL.value/10.))) {
      fMScharmL.error = TMath::Abs(fMScharmL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MScharmL") >= 0)) { 
      fMScharmL.value = yyFittedPar[FindInFittedPar("MScharmL")].value ;
      fMScharmL.error = yyFittedPar[FindInFittedPar("MScharmL")].error ;
   }
   fMScharmL.bound_low = 0.;
   fMScharmL.bound_up = 10000.;

   fMStopL.name = "MStopL";
   fMStopL.value = sumMStopL/ double(nvalid);
   fMStopL.error = TMath::Sqrt(sum2MStopL / double(nvalid) - sqr(fMStopL.value));
   if ((TMath::Abs(fMStopL.error)>TMath::Abs(fMStopL.value/2.)) || 
	 (TMath::Abs(fMStopL.error)<TMath::Abs(fMStopL.value/10.))) {
      fMStopL.error = TMath::Abs(fMStopL.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MStopL") >= 0)) { 
      fMStopL.value = yyFittedPar[FindInFittedPar("MStopL")].value ;
      fMStopL.error = yyFittedPar[FindInFittedPar("MStopL")].error;
   }
   fMStopL.bound_low = 0.;
   fMStopL.bound_up = 10000.;

   fMSupR.name = "MSupR";
   fMSupR.value = sumMSupR/ double(nvalid);
   fMSupR.error = TMath::Sqrt(sum2MSupR / double(nvalid) - sqr(fMSupR.value));
   if ((TMath::Abs(fMSupR.error)>TMath::Abs(fMSupR.value/2.)) || 
	 (TMath::Abs(fMSupR.error)<TMath::Abs(fMSupR.value/10.))) {
      fMSupR.error = TMath::Abs(fMSupR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSupR") >= 0)) { 
      fMSupR.value = yyFittedPar[FindInFittedPar("MSupR")].value ;
      fMSupR.error = yyFittedPar[FindInFittedPar("MSupR")].error;
   }
   fMSupR.bound_low = 0.;
   fMSupR.bound_up = 10000.;

   fMScharmR.name = "MScharmR";
   fMScharmR.value = sumMScharmR/ double(nvalid);
   fMScharmR.error = TMath::Sqrt(sum2MScharmR / double(nvalid) - sqr(fMScharmR.value));
   if ((TMath::Abs(fMScharmR.error)>TMath::Abs(fMScharmR.value/2.)) || 
	 (TMath::Abs(fMScharmR.error)<TMath::Abs(fMScharmR.value/10.))) {
      fMScharmR.error = TMath::Abs(fMScharmR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MScharmR") >= 0)) { 
      fMScharmR.value = yyFittedPar[FindInFittedPar("MScharmR")].value ;
      fMScharmR.error = yyFittedPar[FindInFittedPar("MScharmR")].error;
   }
   fMScharmR.bound_low = 0.;
   fMScharmR.bound_up = 10000.;

   fMStopR.name = "MStopR";
   fMStopR.value = sumMStopR/ double(nvalid);
   fMStopR.error = TMath::Sqrt(sum2MStopR / double(nvalid) - sqr(fMStopR.value));
   if ((TMath::Abs(fMStopR.error)>TMath::Abs(fMStopR.value/2.)) || 
	 (TMath::Abs(fMStopR.error)<TMath::Abs(fMStopR.value/10.))) {
      fMStopR.error = TMath::Abs(fMStopR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MStopR") >= 0)) { 
      fMStopR.value = yyFittedPar[FindInFittedPar("MStopR")].value ;
      fMStopR.error = yyFittedPar[FindInFittedPar("MStopR")].error ;
   }
   fMStopR.bound_low = 0.;
   fMStopR.bound_up = 10000.;

   fMSdownR.name = "MSdownR";
   fMSdownR.value = sumMSdownR/ double(nvalid);
   fMSdownR.error = TMath::Sqrt(sum2MSdownR / double(nvalid) - sqr(fMSdownR.value));
   if ((TMath::Abs(fMSdownR.error)>TMath::Abs(fMSdownR.value/2.)) || 
	 (TMath::Abs(fMSdownR.error)<TMath::Abs(fMSdownR.value/10.))) {
      fMSdownR.error = TMath::Abs(fMSdownR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSdownR") >= 0)) { 
      fMSdownR.value = yyFittedPar[FindInFittedPar("MSdownR")].value ;
      fMSdownR.error= yyFittedPar[FindInFittedPar("MSdownR")].error;
   }
   fMSdownR.bound_low = 0.;
   fMSdownR.bound_up = 10000.;

   fMSstrangeR.name = "MSstrangeR";
   fMSstrangeR.value = sumMSstrangeR/ double(nvalid);
   fMSstrangeR.error = TMath::Sqrt(sum2MSstrangeR / double(nvalid) - sqr(fMSstrangeR.value));
   if ((TMath::Abs(fMSstrangeR.error)>TMath::Abs(fMSstrangeR.value/2.)) || 
	 (TMath::Abs(fMSstrangeR.error)<TMath::Abs(fMSstrangeR.value/10.))) {
      fMSstrangeR.error = TMath::Abs(fMSstrangeR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSstrangeR") >= 0)) { 
      fMSstrangeR.value = yyFittedPar[FindInFittedPar("MSstrangeR")].value ;
      fMSstrangeR.error = yyFittedPar[FindInFittedPar("MSstrangeR")].error;
   }
   fMSstrangeR.bound_low = 0.;
   fMSstrangeR.bound_up = 10000.;

   fMSbottomR.name = "MSbottomR";
   fMSbottomR.value = sumMSbottomR/ double(nvalid);
   fMSbottomR.error = TMath::Sqrt(sum2MSbottomR / double(nvalid) - sqr(fMSbottomR.value));
   if ((TMath::Abs(fMSbottomR.error)>TMath::Abs(fMSbottomR.value/2.)) || 
	 (TMath::Abs(fMSbottomR.error)<TMath::Abs(fMSbottomR.value/10.))) {
      fMSbottomR.error = TMath::Abs(fMSbottomR.value/10.);
   }
   if (yyUseGivenStartValues && (FindInFittedPar("MSbottomR") >= 0)) { 
      fMSbottomR.value = yyFittedPar[FindInFittedPar("MSbottomR")].value ;
      fMSbottomR.error= yyFittedPar[FindInFittedPar("MSbottomR")].error;
   }
   fMSbottomR.bound_low = 0.;
   fMSbottomR.bound_up = 10000.;

   fXtau.name = "Xtau";
   fXtau.value = sumXtau/ double(nvalid);
   fXtau.value = -fMu.value*fTanBeta.value;
   fXtau.error = TMath::Sqrt(sum2Xtau / double(nvalid) - sqr(fXtau.value));
   //    if ( fXtau.value > 1000. ) fXtau.value = 1000.;
   //    if ( fXtau.value < -1000. ) fXtau.value = -1000.;
   if ((TMath::Abs(fXtau.error)>TMath::Abs(fXtau.value/2.)) || 
	 (TMath::Abs(fXtau.error)<TMath::Abs(fXtau.value/10.))) {
      fXtau.error = TMath::Abs(fXtau.value/10.);
   }
   fXtau.error = 100.;
   if (yyUseGivenStartValues && (FindInFittedPar("Xtau") >= 0)) { 
      fXtau.value = yyFittedPar[FindInFittedPar("Xtau")].value ;
      fXtau.error = yyFittedPar[FindInFittedPar("Xtau")].error;
   }
   if (yyBoundsOnX) {
      fXtau.bound_low = yyXscanlow;
      fXtau.bound_up = yyXscanhigh;
   } else {
      fXtau.bound_low = -10000.;
      fXtau.bound_up = 10000.;
   }

   fXtop.name = "Xtop";
   fXtop.value = sumXtop/ double(nvalid);
   fXtop.value = 0.;
   fXtop.value = -fMu.value/fTanBeta.value;
   fXtop.error = TMath::Sqrt(sum2Xtop / double(nvalid) - sqr(fXtop.value));
   if ((TMath::Abs(fXtop.error)>TMath::Abs(fXtop.value/2.)) || 
	 (TMath::Abs(fXtop.error)<TMath::Abs(fXtop.value/10.))) {
      fXtop.error = TMath::Abs(fXtop.value/10.);
   }
   fXtop.error = 100.;
   if (yyUseGivenStartValues && (FindInFittedPar("Xtop") >= 0)) { 
      fXtop.value = yyFittedPar[FindInFittedPar("Xtop")].value ;
      fXtop.error = yyFittedPar[FindInFittedPar("Xtop")].error;
   }
   if (yyBoundsOnX) {
      fXtop.bound_low = yyXscanlow;
      fXtop.bound_up = yyXscanhigh;
   } else {
      fXtop.bound_low = -10000.;
      fXtop.bound_up = 10000.;
   }
   if (yyScanX && (fXtop.value > yyXscanhigh)) { 
      fXtop.value = yyXscanhigh;
   }
   if (yyScanX && (fXtop.value < yyXscanlow)) { 
      fXtop.value = yyXscanlow;
   }

   fXbottom.name = "Xbottom";
   fXbottom.value = sumXbottom/ double(nvalid);
   fXbottom.value = 0.;
   fXbottom.value = -fMu.value*fTanBeta.value;
   fXbottom.error = TMath::Sqrt(sum2Xbottom / double(nvalid) - sqr(fXbottom.value));
   if ((TMath::Abs(fXbottom.error)>TMath::Abs(fXbottom.value/2.)) || 
	 (TMath::Abs(fXbottom.error)<TMath::Abs(fXbottom.value/10.))) {
      fXbottom.error = TMath::Abs(fXbottom.value/10.);
   }
   fXbottom.error = 100.;
   if (yyUseGivenStartValues && (FindInFittedPar("Xbottom") >= 0)) { 
      fXbottom.value = yyFittedPar[FindInFittedPar("Xbottom")].value ;
      fXbottom.error = yyFittedPar[FindInFittedPar("Xbottom")].error ;
   }
   if (yyBoundsOnX) {
      fXbottom.bound_low = yyXscanlow;
      fXbottom.bound_up = yyXscanhigh;
   } else {
      fXbottom.bound_low = -10000.;
      fXbottom.bound_up = 10000.;
   }
   if (yyScanX && (fXbottom.value > yyXscanhigh)) { 
      fXbottom.value = yyXscanhigh;
   }
   if (yyScanX && (fXbottom.value < yyXscanlow)) { 
      fXbottom.value = yyXscanlow;
   }

   fAtau.name = "Atau";
   fAtau.value = 0;
   fAtau.error = 1000; // rough estimate
   if (yyUseGivenStartValues && (FindInFittedPar("Atau") >= 0)) { 
      fAtau.value = yyFittedPar[FindInFittedPar("Atau")].value ;
      fAtau.error = yyFittedPar[FindInFittedPar("Atau")].error;
   }
   fAtau.bound_low = -10000.;
   fAtau.bound_up = 10000.;

   fAtop.name = "Atop";
   fAtop.value = 0;
   fAtop.error = 1000; // rough estimate
   if (yyUseGivenStartValues && (FindInFittedPar("Atop") >= 0)) { 
      fAtop.value = yyFittedPar[FindInFittedPar("Atop")].value ;
      fAtop.error = yyFittedPar[FindInFittedPar("Atop")].error;
   }
   fAtop.bound_low = -10000.;
   fAtop.bound_up = 10000.;

   fAbottom.name = "Abottom";
   fAbottom.value = 0;
   fAbottom.error = 1000; // rough estimate
   if (yyUseGivenStartValues && (FindInFittedPar("Abottom") >= 0)) { 
      fAbottom.value = yyFittedPar[FindInFittedPar("Abottom")].value ;
      fAbottom.error = yyFittedPar[FindInFittedPar("Abottom")].error;
   }
   fAbottom.bound_low = -10000.;
   fAbottom.bound_up = 10000.;

   // FIXME: Find a more intelligent way to get start values and errors
   if (yyFitModel == NMSSM) {
      fNmssmLambda.name  = "lambda";
      fNmssmLambda.value = 0;
      fNmssmLambda.error = 0.1;
      if (yyUseGivenStartValues && (FindInFittedPar("lambda") >= 0)) { 
	 fNmssmLambda.value = yyFittedPar[FindInFittedPar("lambda")].value ;
      }
      fNmssmLambda.bound_low = -10000.;
      fNmssmLambda.bound_up = 10000.;

      fKappa.name  = "kappa";
      fKappa.value = 0;
      fKappa.error = 0.1;
      if (yyUseGivenStartValues && (FindInFittedPar("kappa") >= 0)) {
	 fKappa.value = yyFittedPar[FindInFittedPar("kappa")].value ;
      }
      fKappa.bound_low = -10000.;
      fKappa.bound_up = 10000.;

      fALambda.name  = "ALambda";
      fALambda.value = 0;
      fALambda.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("ALambda") >= 0)) { 
	 fALambda.value = yyFittedPar[FindInFittedPar("ALambda")].value ;
      }
      fALambda.bound_low = -10000.;
      fALambda.bound_up = 10000.;

      fAKappa.name  = "AKappa";
      fAKappa.value = 0;
      fAKappa.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("AKappa") >= 0)) { 
	 fAKappa.value = yyFittedPar[FindInFittedPar("AKappa")].value ;
      }
      fAKappa.bound_low = -10000.;
      fAKappa.bound_up = 10000.;
   }

   //    if (yyVerbose){
   //    cout << "MSelectronL = " << fMSelL.value << " +- " << fMSelL.error << endl;
   //    cout << "MSmuL = " << fMSmuL.value << " +- " << fMSmuL.error << endl;
   //    cout << "MStauL = " << fMStauL.value << " +- " << fMStauL.error << endl;
   //    cout << "MSelectronR = " << fMSelR.value << " +- " << fMSelR.error << endl;
   //    cout << "MSmuR = " << fMSmuR.value << " +- " << fMSmuR.error << endl;
   //    cout << "MStauR = " << fMStauR.value << " +- " << fMStauR.error << endl;
   //    }
   //-----------------------------------------------------------------
   // fill yyFittedVec
   // first fill in the measured parameters
   for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      par_already_found = false;
      // if (yyVerbose){
      // cout << "filling yyFittedVec" << endl;
      // }
      for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	// if (yyVerbose){
	// cout << "looping over measured value " << fInput->GetMeasuredVector()[j].name << endl;
	// }
 	 if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	   // if (yyVerbose){
	   // cout << "filling contents of " << fInput->GetMeasuredVector()[j].name << endl;
	   // }
	    yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	    if (yyUseGivenStartValues) {
	       if (yyVerbose){
	       cout << "use given start values for " << fInput->GetMeasuredVector()[j].name << endl;
	       }
	       unsigned int ilength;
	       ilength = yyFittedVec.size();
	       yyFittedVec[ilength-1].value = yyFittedPar[i].value;
	       if (yyFittedPar[i].error>0.) {
		 yyFittedVec[ilength-1].error = yyFittedPar[i].error;
	       }
	       if (yyVerbose){
	       cout << " parameter " <<  yyFittedPar[i].name << " " << yyFittedVec[ilength-1].value << " " 
	       	    << " to value " << yyFittedPar[i].value << " +- " << yyFittedVec[ilength-1].error << endl;	   
	       }
	       if (!yyFittedPar[i].name.compare("massA0")) {
		 yyFittedVec[ilength-1].bound_low = 0.;
	       }	    
	    }
	    par_already_found = true;
	    break;
	 }
      }
      if (!par_already_found) {
	 if (!yyFittedPar[i].name.compare("QEWSB")) {
	    yyFittedVec.push_back(fQEWSB);
	    par_already_found = true;
	 }
	 if (!yyFittedPar[i].name.compare("TanBeta")) {
	    yyFittedVec.push_back(fTanBeta);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Mu")){
	    yyFittedVec.push_back(fMu);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("M1")) {
	    yyFittedVec.push_back(fM1);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("M2")) {
	    yyFittedVec.push_back(fM2);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("M3")) {
	    yyFittedVec.push_back(fAbsM3);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSelectronL")) {
	    yyFittedVec.push_back(fMSelL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSelectronR")) {
	    yyFittedVec.push_back(fMSelR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSmuL")) {
	    yyFittedVec.push_back(fMSmuL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSmuR")) {
	    yyFittedVec.push_back(fMSmuR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MStauL")) {
	    yyFittedVec.push_back(fMStauL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MStauR")) {
	    yyFittedVec.push_back(fMStauR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSupL")) {
	    yyFittedVec.push_back(fMSupL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSupR")) {
	    yyFittedVec.push_back(fMSupR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MScharmL")) {
	    yyFittedVec.push_back(fMScharmL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MScharmR")) {
	    yyFittedVec.push_back(fMScharmR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MStopL")) {
	    yyFittedVec.push_back(fMStopL);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MStopR")) {
	    yyFittedVec.push_back(fMStopR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSdownR")) {
	    yyFittedVec.push_back(fMSdownR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSstrangeR")) {
	    yyFittedVec.push_back(fMSstrangeR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("MSbottomR")) {
	    yyFittedVec.push_back(fMSbottomR);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Xtau")) {
	    yyFittedVec.push_back(fXtau);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Xtop")) {
	    yyFittedVec.push_back(fXtop);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Abottom")) {
	    yyFittedVec.push_back(fAbottom);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Atau")) {
	    yyFittedVec.push_back(fAtau);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Atop")) {
	    yyFittedVec.push_back(fAtop);
	    par_already_found = true;
	 }
	 else if (!yyFittedPar[i].name.compare("Abottom")) {
	    yyFittedVec.push_back(fAbottom);
	    par_already_found = true;
	 }

      }
      if (!par_already_found) {
	if (yyVerbose){
	std::cout << "ParNotFound: " <<  yyFittedPar[i].name << std::endl;
	}
	fnew.name  = yyFittedPar[i].name;
	fnew.value = yyFittedPar[i].value;
	fnew.error = yyFittedPar[i].value*0.05;
	fnew.bound_low = -1.E+6;
	fnew.bound_up = 1.E+6;
	if (!yyFittedPar[i].name.compare("massA0")) {
	  fnew.bound_low = 0.;
	}
	yyFittedVec.push_back(fnew);
      }
   }

   //    for (unsigned int  i=0; i < fInput->GetMeasuredVector().size(); i++ ) {
   //	if ( !fInput->GetMeasuredVector()[i].name.compare("massTop") || //
   //	     !fInput->GetMeasuredVector()[i].name.compare("massA0")  || //
   //	     !fInput->GetMeasuredVector()[i].name.compare("massCharm")  || //
   //	     !fInput->GetMeasuredVector()[i].name.compare("massBottom") ) {
   //	  yyFittedVec.push_back((fInput->GetMeasuredVector())[i]);
   //	}
   //    }
   //    // then fill the estimated parameters
   //    yyFittedVec.push_back(fTanBeta);
   //    yyFittedVec.push_back(fMu);
   //    yyFittedVec.push_back(fM1);
   //    yyFittedVec.push_back(fM2);
   //    yyFittedVec.push_back(fAbsM3);

   if (yyVerbose){
   cout << "fill fixed parameters " << endl;
   }
   FillFixedParameters();
   
   if (yyVerbose){
   cout << "------------------------------------------------------------" << endl;
   cout << "nthrows " << nthrows << " nvalid " << nvalid << endl;
   cout << "Estimated Parameters:" << endl;
   }
   for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
      if (yyVerbose){
      cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	 << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
      }
   }
   if (yyVerbose){
   cout << "------------------------------------------------------------" << endl;
   }


}

// ====================================
// == Set start values of fitted parameters

void Fittino::setStartValues()
{
   if (yyFitModel == mSUGRA) {
     
     if (yyVerbose){
     cout << "setting start values for QEWSB" << endl;
     }
      fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 10;
      fTanBeta.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

      fM0.name  = "M0";
      fM0.value = 100;
      fM0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M0") >= 0)) {
	 fM0.value = yyFittedPar[FindInFittedPar("M0")].value;
	 fM0.error = yyFittedPar[FindInFittedPar("M0")].error;
      }
      fM0.bound_low = 0.;
      fM0.bound_up = 10000.;

      fM12.name  = "M12";
      fM12.value = 100;
      fM12.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M12") >= 0)) {
	 fM12.value = yyFittedPar[FindInFittedPar("M12")].value;
	 fM12.error = yyFittedPar[FindInFittedPar("M12")].error;
      }
      fM12.bound_low = 0.;
      fM12.bound_up = 10000.;

      fA0.name  = "A0";
      fA0.value = 100;
      fA0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("A0") >= 0)) {
	 fA0.value = yyFittedPar[FindInFittedPar("A0")].value;
	 fA0.error = yyFittedPar[FindInFittedPar("A0")].error;
      }
      fA0.bound_low = -10000.;
      fA0.bound_up = 10000.;

      bool par_already_found;

      //    if (yyVerbose){
      //    cout<<"TanBeta = "<<fTanBeta.value<<" +- "<<fTanBeta.error<<endl;
      //    cout<<"M0 = "<<fM0.value<<" +- "<<fM0.error<<endl;
      //    cout<<"M12 = "<<fM12.value<<" +- "<<fM12.error<<endl;
      //    cout<<"A0 = "<<fA0.value<<" +- "<<fA0.error<<endl;
      
      //    cout<<"Contents of yyFittedPar:"<<endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout<<yyFittedPar[i].name<<" "<<yyFittedPar[i].value<<" "<<yyFittedPar[i].error<<endl;
      //      }
      //    }
      //
      //    exit(1);

      
      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		    yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	    if (!yyFittedPar[i].name.compare("QEWSB")) {
	       yyFittedVec.push_back(fQEWSB);
	       par_already_found = true;
	    }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M0")){
	       yyFittedVec.push_back(fM0);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M12")){
	       yyFittedVec.push_back(fM12);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("A0")){
	       yyFittedVec.push_back(fA0);
	       par_already_found = true;
	    }
	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;
      
      if (yyVerbose){
      cout << yyDashedLine << endl;
      }
      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);
	 
	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << yyDashedLine << endl;
      cout << "Setting parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	}
      }

   }

   else if (yyFitModel == XMSUGRA) {

     fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 10;
      fTanBeta.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

      fM0.name  = "M0";
      fM0.value = 100;
      fM0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M0") >= 0)) {
	 fM0.value = yyFittedPar[FindInFittedPar("M0")].value;
	 fM0.error = yyFittedPar[FindInFittedPar("M0")].error;
      }
      fM0.bound_low = 0.;
      fM0.bound_up = 10000.;

      fM1.name  = "M1";
      fM1.value = 100;
      fM1.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M1") >= 0)) {
	 fM1.value = yyFittedPar[FindInFittedPar("M1")].value;
	 fM1.error = yyFittedPar[FindInFittedPar("M1")].error;
      }
      fM1.bound_low = 0.;
      fM1.bound_up = 10000.;

      fM2.name  = "M2";
      fM2.value = 200;
      fM2.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M2") >= 0)) {
	 fM2.value = yyFittedPar[FindInFittedPar("M2")].value;
	 fM2.error = yyFittedPar[FindInFittedPar("M2")].error;
      }
      fM2.bound_low = 0.;
      fM2.bound_up = 10000.;

      fAbsM3.name  = "M3";
      fAbsM3.value = 600;
      fAbsM3.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M3") >= 0)) {
	 fAbsM3.value = yyFittedPar[FindInFittedPar("M3")].value;
	 fAbsM3.error = yyFittedPar[FindInFittedPar("M3")].error;
      }
      fAbsM3.bound_low = 0.;
      fAbsM3.bound_up = 10000.;

//      fM12.name  = "M12";
//      fM12.value = 100;
//      fM12.error = 100;
//      if (yyUseGivenStartValues && (FindInFittedPar("M12") >= 0)) {
//	 fM12.value = yyFittedPar[FindInFittedPar("M12")].value;
//	 fM12.error = yyFittedPar[FindInFittedPar("M12")].error;
//      }
//      fM12.bound_low = 0.;
//      fM12.bound_up = 10000.;

      fA0.name  = "A0";
      fA0.value = 100;
      fA0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("A0") >= 0)) {
	 fA0.value = yyFittedPar[FindInFittedPar("A0")].value;
	 fA0.error = yyFittedPar[FindInFittedPar("A0")].error;
      }
      fA0.bound_low = -10000.;
      fA0.bound_up = 10000.;

      bool par_already_found;

      //    if (yyVerbose){
      //    cout << "TanBeta = " << fTanBeta.value << " +- " << fTanBeta.error << endl;
      //    cout << "M1      = " << fM0.value      << " +- " << fM0.error      << endl;
      //    cout << "M2      = " << fM2.value      << " +- " << fM2.error      << endl;
      //    cout << "M3      = " << fAbsM3.value   << " +- " << fAbsM3.error   << endl;
      //    cout << "M12     = " << fM12.value     << " +- " << fM12.error     << endl;
      //    cout << "A0      = " << fA0.value      << " +- " << fA0.error      << endl;

      //    cout << "Contents of yyFittedPar: " << endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout << yyFittedPar[i].name << " " << yyFittedPar[i].value << " " << yyFittedPar[i].error << endl;
      //      }
      //    }
      //
      //    exit(1);

      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		     yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	   if (!yyFittedPar[i].name.compare("QEWSB")) {
	     yyFittedVec.push_back(fQEWSB);
	     par_already_found = true;
	   }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M0")){
	       yyFittedVec.push_back(fM0);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M1")){
	       yyFittedVec.push_back(fM1);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M2")){
	       yyFittedVec.push_back(fM2);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M3")){
	       yyFittedVec.push_back(fAbsM3);
	       par_already_found = true;
	    }
//	    else if (!yyFittedPar[i].name.compare("M12")){
//	       yyFittedVec.push_back(fM12);
//	       par_already_found = true;
//	    }
	    else if (!yyFittedPar[i].name.compare("A0")){
	       yyFittedVec.push_back(fA0);
	       par_already_found = true;
	    }
	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;

      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);

	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << "=======================================================" << endl;
      cout << "Setting start parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	 if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	 }
      }
      if (yyVerbose){
      cout << "=======================================================" << endl;
      }

   }

else if (yyFitModel == NONUNIVSIMPLIFIED) {

     fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 10;
      fTanBeta.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

//      fM0.name  = "M0";
//      fM0.value = 100;
//      fM0.error = 100;
//      if (yyUseGivenStartValues && (FindInFittedPar("M0") >= 0)) {
//	 fM0.value = yyFittedPar[FindInFittedPar("M0")].value;
//	 fM0.error = yyFittedPar[FindInFittedPar("M0")].error;
//      }
//      fM0.bound_low = 0.;
//      fM0.bound_up = 10000.;

      fM1.name  = "M1";
      fM1.value = 100;
      fM1.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M1") >= 0)) {
	 fM1.value = yyFittedPar[FindInFittedPar("M1")].value;
	 fM1.error = yyFittedPar[FindInFittedPar("M1")].error;
      }
      fM1.bound_low = 0.;
      fM1.bound_up = 10000.;

      fM2.name  = "M2";
      fM2.value = 200;
      fM2.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M2") >= 0)) {
	 fM2.value = yyFittedPar[FindInFittedPar("M2")].value;
	 fM2.error = yyFittedPar[FindInFittedPar("M2")].error;
      }
      fM2.bound_low = 0.;
      fM2.bound_up = 10000.;

      fAbsM3.name  = "M3";
      fAbsM3.value = 600;
      fAbsM3.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M3") >= 0)) {
	 fAbsM3.value = yyFittedPar[FindInFittedPar("M3")].value;
	 fAbsM3.error = yyFittedPar[FindInFittedPar("M3")].error;
      }
      fAbsM3.bound_low = 0.;
      fAbsM3.bound_up = 10000.;

//      fM12.name  = "M12";
//      fM12.value = 100;
//      fM12.error = 100;
//      if (yyUseGivenStartValues && (FindInFittedPar("M12") >= 0)) {
//	 fM12.value = yyFittedPar[FindInFittedPar("M12")].value;
//	 fM12.error = yyFittedPar[FindInFittedPar("M12")].error;
//      }
//      fM12.bound_low = 0.;
//      fM12.bound_up = 10000.;

      fA0.name  = "A0";
      fA0.value = 100;
      fA0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("A0") >= 0)) {
	 fA0.value = yyFittedPar[FindInFittedPar("A0")].value;
	 fA0.error = yyFittedPar[FindInFittedPar("A0")].error;
      }
      fA0.bound_low = -10000.;
      fA0.bound_up = 10000.;

      fM0H.name  = "M0H";
      fM0H.value = 100;
      fM0H.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M0H") >= 0)) {
	 fM0H.value = yyFittedPar[FindInFittedPar("M0H")].value;
	 fM0H.error = yyFittedPar[FindInFittedPar("M0H")].error;
      }
      fM0H.bound_low = -10000000.;
      fM0H.bound_up = 10000000.;

      fM05.name  = "M05";
      fM05.value = 100;
      fM05.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M05") >= 0)) {
	 fM05.value = yyFittedPar[FindInFittedPar("M05")].value;
	 fM05.error = yyFittedPar[FindInFittedPar("M05")].error;
      }
      fM05.bound_low = 0.;
      fM05.bound_up = 10000.;

      fM010.name  = "M010";
      fM010.value = 100;
      fM010.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M010") >= 0)) {
	 fM010.value = yyFittedPar[FindInFittedPar("M010")].value;
	 fM010.error = yyFittedPar[FindInFittedPar("M010")].error;
      }
      fM010.bound_low = 0.;
      fM010.bound_up = 10000.;

      bool par_already_found;

      //    if (yyVerbose){
      //    cout << "TanBeta = " << fTanBeta.value << " +- " << fTanBeta.error << endl;
      //    cout << "M1      = " << fM0.value      << " +- " << fM0.error      << endl;
      //    cout << "M2      = " << fM2.value      << " +- " << fM2.error      << endl;
      //    cout << "M3      = " << fAbsM3.value   << " +- " << fAbsM3.error   << endl;
      //    cout << "M12     = " << fM12.value     << " +- " << fM12.error     << endl;
      //    cout << "A0      = " << fA0.value      << " +- " << fA0.error      << endl;

      //    cout << "Contents of yyFittedPar: " << endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout << yyFittedPar[i].name << " " << yyFittedPar[i].value << " " << yyFittedPar[i].error << endl;
      //      }
      //    }
      //
      //    exit(1);

      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		     yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	   if (!yyFittedPar[i].name.compare("QEWSB")) {
	     yyFittedVec.push_back(fQEWSB);
	     par_already_found = true;
	   }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
//	    else if (!yyFittedPar[i].name.compare("M0")){
//	       yyFittedVec.push_back(fM0);
//	       par_already_found = true;
//	    }
	    else if (!yyFittedPar[i].name.compare("M1")){
	       yyFittedVec.push_back(fM1);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M2")){
	       yyFittedVec.push_back(fM2);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M3")){
	       yyFittedVec.push_back(fAbsM3);
	       par_already_found = true;
	    }
//	    else if (!yyFittedPar[i].name.compare("M12")){
//	       yyFittedVec.push_back(fM12);
//	       par_already_found = true;
//	    }
	    else if (!yyFittedPar[i].name.compare("A0")){
	       yyFittedVec.push_back(fA0);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M0H")){
	       yyFittedVec.push_back(fM0H);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M05")){
	       yyFittedVec.push_back(fM05);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M010")){
	       yyFittedVec.push_back(fM010);
	       par_already_found = true;
	    }
	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;

      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);

	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << "=======================================================" << endl;
      cout << "Setting start parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	 if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	 }
      }
      if (yyVerbose){
      cout << "=======================================================" << endl;
      }

   }


else if (yyFitModel == NUHM1 || yyFitModel == NUHM2 ) {
     
     if (yyVerbose){
     cout << "setting start values for QEWSB" << endl;
     }
      fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 10;
      fTanBeta.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

      fM0.name  = "M0";
      fM0.value = 100;
      fM0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M0") >= 0)) {
	 fM0.value = yyFittedPar[FindInFittedPar("M0")].value;
	 fM0.error = yyFittedPar[FindInFittedPar("M0")].error;
      }
      fM0.bound_low = 0.;
      fM0.bound_up = 10000.;

      fM12.name  = "M12";
      fM12.value = 100;
      fM12.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("M12") >= 0)) {
	 fM12.value = yyFittedPar[FindInFittedPar("M12")].value;
	 fM12.error = yyFittedPar[FindInFittedPar("M12")].error;
      }
      fM12.bound_low = 0.;
      fM12.bound_up = 10000.;

      fA0.name  = "A0";
      fA0.value = 100;
      fA0.error = 100;
      if (yyUseGivenStartValues && (FindInFittedPar("A0") >= 0)) {
	 fA0.value = yyFittedPar[FindInFittedPar("A0")].value;
	 fA0.error = yyFittedPar[FindInFittedPar("A0")].error;
      }
      fA0.bound_low = -10000.;
      fA0.bound_up = 10000.;
    
			if( yyFitModel == NUHM1 ) {
      	fM0H.name = "M0H";
      	fM0H.value = 100;
      	fM0H.error = 100;
      	if( yyUseGivenStartValues && (FindInFittedPar("M0H") >= 0 )) {
        	fM0H.value = yyFittedPar[FindInFittedPar("M0H")].value;
        	fM0H.error = yyFittedPar[FindInFittedPar("M0H")].error;
     		}
      	fM0H.bound_low = -10000000.;
      	fM0H.bound_up = 10000000.;
			}
			else if( yyFitModel == NUHM2 ) {
				fM0Hu.name = "M0Hu";
        fM0Hu.value = 100;
        fM0Hu.error = 100;
        if( yyUseGivenStartValues && (FindInFittedPar("M0Hu") >= 0 )) {
          fM0Hu.value = yyFittedPar[FindInFittedPar("M0Hu")].value;
          fM0Hu.error = yyFittedPar[FindInFittedPar("M0Hu")].error;
        }
        fM0Hu.bound_low = -10000000.;
        fM0Hu.bound_up = 10000000.;
				
				fM0Hd.name = "M0Hd";
        fM0Hd.value = 100;
        fM0Hd.error = 100;
        if( yyUseGivenStartValues && (FindInFittedPar("M0Hd") >= 0 )) {
          fM0Hd.value = yyFittedPar[FindInFittedPar("M0Hd")].value;
          fM0Hd.error = yyFittedPar[FindInFittedPar("M0Hd")].error;
        }
        fM0Hd.bound_low = -10000000.;
        fM0Hd.bound_up = 10000000.;

			}
      bool par_already_found;

      //    if (yyVerbose){
      //    cout<<"TanBeta = "<<fTanBeta.value<<" +- "<<fTanBeta.error<<endl;
      //    cout<<"M0 = "<<fM0.value<<" +- "<<fM0.error<<endl;
      //    cout<<"M12 = "<<fM12.value<<" +- "<<fM12.error<<endl;
      //    cout<<"A0 = "<<fA0.value<<" +- "<<fA0.error<<endl;
      
      //    cout<<"Contents of yyFittedPar:"<<endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout<<yyFittedPar[i].name<<" "<<yyFittedPar[i].value<<" "<<yyFittedPar[i].error<<endl;
      //      }
      //    }
      //
      //    exit(1);

      
      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		    yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	    if (!yyFittedPar[i].name.compare("QEWSB")) {
	       yyFittedVec.push_back(fQEWSB);
	       par_already_found = true;
	    }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M0")){
	       yyFittedVec.push_back(fM0);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M12")){
	       yyFittedVec.push_back(fM12);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("A0")){
	       yyFittedVec.push_back(fA0);
	       par_already_found = true;
	    }
      else if (!yyFittedPar[i].name.compare("M0H")){
        yyFittedVec.push_back(fM0H);
        par_already_found = true;
      }
      else if (!yyFittedPar[i].name.compare("M0Hu")){
        yyFittedVec.push_back(fM0Hu);
        par_already_found = true;
      }
      else if (!yyFittedPar[i].name.compare("M0Hd")){
        yyFittedVec.push_back(fM0Hd);
        par_already_found = true;
      }

	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;
      
      if (yyVerbose){
      cout << yyDashedLine << endl;
      }
      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);
	 
	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << yyDashedLine << endl;
      cout << "Setting parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	}
      }

   }


   else if (yyFitModel == GMSB) {

      fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 15;
      fTanBeta.error = 10;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

      fLambda.name  = "Lambda";
      fLambda.value = 1e5;
      fLambda.error = 1e5;
      if (yyUseGivenStartValues && (FindInFittedPar("Lambda") >= 0)) {
	 fLambda.value = yyFittedPar[FindInFittedPar("Lambda")].value;
	 fLambda.error = yyFittedPar[FindInFittedPar("Lambda")].error;
      }
      fLambda.bound_low = 1e3;
      fLambda.bound_up = 1e9;

      fMmess.name  = "Mmess";
      fMmess.value = 2e5;
      fMmess.error = 1e5;
      if (yyUseGivenStartValues && (FindInFittedPar("Mmess") >= 0)) {
	 fMmess.value = yyFittedPar[FindInFittedPar("Mmess")].value;
	 fMmess.error = yyFittedPar[FindInFittedPar("Mmess")].error;
      }
      fMmess.bound_low = 1e3;
      fMmess.bound_up = 1e9;

      fcGrav.name  = "cGrav";
      fcGrav.value = 1;
      fcGrav.error = 1;
      if (yyUseGivenStartValues && (FindInFittedPar("cGrav") >= 0)) {
	 fcGrav.value = yyFittedPar[FindInFittedPar("cGrav")].value;
	 fcGrav.error = yyFittedPar[FindInFittedPar("cGrav")].error;
      }
      fcGrav.bound_low = 0;
      fcGrav.bound_up = 100000;

      //fN5.name  = "N5";
      //fN5.value = 1;
      //fN5.error = 1;
      //if (yyUseGivenStartValues && (FindInFittedPar("N5") >= 0)) {
      //   fN5.value = yyFittedPar[FindInFittedPar("N5")].value;
      //   fN5.error = yyFittedPar[FindInFittedPar("N5")].error;
      //}
      //fcGrav.bound_low = 0;
      //fcGrav.bound_up = 100;

      bool par_already_found;

      //    if (yyVerbose){
      //    cout<<"TanBeta = "<<fTanBeta.value<<" +- "<<fTanBeta.error<<endl;
      //    cout<<"Lambda = "<<fLambda.value<<" +- "<<fLambda.error<<endl;
      //    cout<<"Mmess = "<<fMmess.value<<" +- "<<fMmess.error<<endl;
      //    cout<<"cGrav = "<<fcGrav.value<<" +- "<<fcGrav.error<<endl;

      //    cout<<"Contents of yyFittedPar:"<<endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout<<yyFittedPar[i].name<<" "<<yyFittedPar[i].value<<" "<<yyFittedPar[i].error<<endl;
      //      }
      //    }
      //
      //    exit(1);

      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		     yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	   if (!yyFittedPar[i].name.compare("QEWSB")) {
	     yyFittedVec.push_back(fQEWSB);
	     par_already_found = true;
	   }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("Lambda")){
	       yyFittedVec.push_back(fLambda);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("Mmess")){
	       yyFittedVec.push_back(fMmess);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("cGrav")){
	       yyFittedVec.push_back(fcGrav);
	       par_already_found = true;
	    }
	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;

      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);

	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << "=======================================================" << endl;
      cout << "Setting start parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	}
      }
      if (yyVerbose){
      cout << "=======================================================" << endl;
      }

   }

   else if (yyFitModel == AMSB) {

      fQEWSB.name  = "QEWSB";
      fQEWSB.value = 1000.;
      fQEWSB.error = 50;
      if (FindInFittedPar("QEWSB") >= 0) {
	 fQEWSB.value = yyFittedPar[FindInFittedPar("QEWSB")].value;
	 fQEWSB.error = yyFittedPar[FindInFittedPar("QEWSB")].error;
      }
      fQEWSB.bound_low = 91.2;
      fQEWSB.bound_up = 10000.;

      fTanBeta.name  = "TanBeta";
      fTanBeta.value = 10;
      fTanBeta.error = 5;
      if (yyUseGivenStartValues && (FindInFittedPar("TanBeta") >= 0)) {
	 fTanBeta.value = yyFittedPar[FindInFittedPar("TanBeta")].value;
	 fTanBeta.error = yyFittedPar[FindInFittedPar("TanBeta")].error;
      }
      fTanBeta.bound_low = 0.;
      fTanBeta.bound_up = 100.;

      fM0.name  = "M0";
      fM0.value = 450;
      fM0.error = 50;
      if (yyUseGivenStartValues && (FindInFittedPar("M0") >= 0)) {
	 fM0.value = yyFittedPar[FindInFittedPar("M0")].value;
	 fM0.error = yyFittedPar[FindInFittedPar("M0")].error;
      }
      fM0.bound_low = 0;
      fM0.bound_up = 10000;

      fM32.name  = "M32";
      fM32.value = 60000;
      fM32.error = 10000;
      if (yyUseGivenStartValues && (FindInFittedPar("M32") >= 0)) {
	 fM32.value = yyFittedPar[FindInFittedPar("M32")].value;
	 fM32.error = yyFittedPar[FindInFittedPar("M32")].error;
      }
      fM32.bound_low = 0;
      fM32.bound_up = 1e7;

      bool par_already_found;

      //    if (yyVerbose){
      //    cout<<"TanBeta = "<<fTanBeta.value<<" +- "<<fTanBeta.error<<endl;
      //    cout<<"M0 = "<<fM0.value<<" +- "<<fM0.error<<endl;
      //    cout<<"M32 = "<<fM32.value<<" +- "<<fM32.error<<endl;

      //    cout<<"Contents of yyFittedPar:"<<endl;
      //    }
      //    for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
      //      if (yyVerbose){
      //      cout<<yyFittedPar[i].name<<" "<<yyFittedPar[i].value<<" "<<yyFittedPar[i].error<<endl;
      //      }
      //    }
      //
      //    exit(1);

      for (unsigned int  i=0; i < yyFittedPar.size(); i++ ) {
	 par_already_found = false;
	 for (unsigned int j = 0; j < fInput->GetMeasuredVector().size(); j++ ) {
	    if (!yyFittedPar[i].name.compare(fInput->GetMeasuredVector()[j].name)) {
	       yyFittedVec.push_back((fInput->GetMeasuredVector())[j]);
	       if (yyUseGivenStartValues) {
		  unsigned int ilength;
		  ilength = yyFittedVec.size();
		  yyFittedVec[ilength-1].value = yyFittedPar[i].value;
		  if (yyFittedPar[i].error>0.) {
		     yyFittedVec[ilength-1].error = yyFittedPar[i].error;
		  }
		  if (yyVerbose){
		  cout << " parameter " <<  yyFittedPar[i].name << " " 
		     << yyFittedVec[ilength-1].value << " " 
		     << " to value " << yyFittedPar[i].value << endl;	   
		  }
	       }
	       par_already_found = true;
	       break;
	    }
	 }
	 if (!par_already_found) {
	   if (!yyFittedPar[i].name.compare("QEWSB")) {
	     yyFittedVec.push_back(fQEWSB);
	     par_already_found = true;
	   }
	    if (!yyFittedPar[i].name.compare("TanBeta")) {
	       yyFittedVec.push_back(fTanBeta);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M0")){
	       yyFittedVec.push_back(fM0);
	       par_already_found = true;
	    }
	    else if (!yyFittedPar[i].name.compare("M32")){
	       yyFittedVec.push_back(fM32);
	       par_already_found = true;
	    }
	 }
      }

      // Fill fixed parameters();
      MeasuredValue tmpValue;

      for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
	 for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	    if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	    if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	       cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	       exit (EXIT_FAILURE);
	    }
	 }

	 tmpValue.name = yyFixedPar[i].name;
	 tmpValue.value = yyFixedPar[i].value;
	 tmpValue.error = -1;
	 tmpValue.bound_low = -1E+6;
	 tmpValue.bound_up = 1E+6;
	 yyFixedVec.push_back(tmpValue);

	 if (yyVerbose){
	 cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
	 }
      }

      if (yyVerbose){
      cout << "=======================================================" << endl;
      cout << "Setting start parameter start values to:" << endl;
      }
      for (unsigned int  i=0; i < yyFittedVec.size(); i++ ) {
	 if (yyVerbose){
	 cout << i << " " << yyFittedVec[i].name << " = " << yyFittedVec[i].value << " +- " << yyFittedVec[i].error 
	    << " bounds " << yyFittedVec[i].bound_low << " -- " <<  yyFittedVec[i].bound_up << endl;
	 }
      }
      if (yyVerbose){
      cout << "=======================================================" << endl;
      }

   }
   else if (yyFitModel == MSSM || yyFitModel == NMSSM) {
      cerr<<"Fittino::setStartValues: Use Fittino::calculateTreeLevelValues() for (N)MSSM fits to "
	 "set fit start values"<<endl;
      exit(EXIT_FAILURE);
   }
   else {
      cerr<<"Unknown value for yyFitModel in Fittino::setStartValues"<<endl;
      exit(EXIT_FAILURE);
   }
}


void Fittino::calculateLoopLevelValues() 
{
   Double_t amin, edm, errdef;
   Int_t    nvpar, nparx;
   double vlow, vhigh;
   double arguments[4];
   TString parname;
   double eminus, eplus, eparab, globcc;
   TGraph* TGraphDummy;
   string TGraphTitle;
   const int    npoints = 20;
   double xarray[npoints];
   double yarray[npoints];
   double closedxarray[npoints+1];
   double closedyarray[npoints+1];
   int ierr = 0;
   char GraphName[255];
   vector <double> saved_uncertainties;

   char ntuplename[256];
   char ntupletext[256];
   char ntuplevars[2048];

   //-------------------------------------------------------------------------
   // switch all temp_nofits on
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
      yyMeasuredVec[i].temp_nofit = false;
      yyMeasuredVec[i].first = true;
      yyMeasuredVec[i].hasbeenset = false;
   }  

   if (yyNoBoundsAtAll) {
      yyUseSimAnnBefore = false;
      yyUseSimAnnWhile = false;
      yySimAnnUncertainty = false;
      for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
	 yyFittedVec[j].bound_up = 0.;
	 yyFittedVec[j].bound_low = 0.;
      }    
   }

   //-------------------------------------------------------------------------
   // eventually call simulated annealing
   system ("rm SimAnnNtupFile.root");
   system ("rm MarkovChainNtupFile.root");

   if (yyUseMarkovChains) {
     markovChain();
     return;
   }
   // ===========================================

   if (yyUseSimAnnBefore) {
      unsigned int i = 0;
      // open the ntuple file
      TFile *SimAnnNtupFile = new TFile("SimAnnNtupFile.root","UPDATE");
      sprintf ( ntuplename, "ntuple%i", i );
      sprintf ( ntupletext, "path of the simulated annealing No. %i", i );
      sprintf ( ntuplevars, "n:t:f:acc:xopt" );
      for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
	 sprintf ( ntuplevars, "%s:%s", ntuplevars, yyFittedVec[j].name.c_str() );
      }
      TNtuple *simannntuple = new TNtuple(ntuplename,ntupletext,ntuplevars);

      simulated_annealing(0,simannntuple);
      SimAnnNtupFile->Write();
      SimAnnNtupFile->Close();
   }

   TMinuit* fitter = 0;

   if (yyPerformFit) {
      //-------------------------------------------------------------------------
      // Set Up TMinuit
      //  TFitter* fitter = new TFitter(yyFittedVec.size());
      fitter = new TMinuit (yyFittedVec.size());
      fitter->SetFCN(fitterFCN);

      arguments[0] = 0;
      fitter->mnexcm("SET PRI", arguments, 1,ierr);
      arguments[0] = 1.;
      fitter->mnexcm("SET ERR", arguments, 1,ierr);
      arguments[0] = yyMachinePrecision;
      fitter->mnexcm("SET EPS", arguments, 1,ierr);


      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 if (yyVerbose){
	 cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	 cout << "adding parameter " << yyFittedVec[i].name << endl;
	 cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	 }
	 if (!(yyFittedVec[i].name=="Mmess") && !(yyFittedVec[i].name=="Lambda")) {
	   if ( yyFittedVec[i].error <= 0. ) {
	     fitter->mnparm(i, yyFittedVec[i].name.c_str(),
			    yyFittedVec[i].value, TMath::Abs(yyFittedVec[i].value/10.), 
			    yyFittedVec[i].bound_low, yyFittedVec[i].bound_up,ierr);
	     saved_uncertainties.push_back(TMath::Abs(yyFittedVec[i].value/10.));
	   } else {
	     fitter->mnparm(i, yyFittedVec[i].name.c_str(),
			    yyFittedVec[i].value, yyFittedVec[i].error, 
			    yyFittedVec[i].bound_low, yyFittedVec[i].bound_up,ierr);
	     saved_uncertainties.push_back(yyFittedVec[i].error);
	   }
	 } else {
	   if ( yyFittedVec[i].error <= 0. ) {
	     fitter->mnparm(i, yyFittedVec[i].name.c_str(),
			    yyFittedVec[i].value, TMath::Abs(yyFittedVec[i].value/10.), 
			    0., 0., ierr);
	     saved_uncertainties.push_back(TMath::Abs(yyFittedVec[i].value/10.));
	   } else {
	     fitter->mnparm(i, yyFittedVec[i].name.c_str(),
			    yyFittedVec[i].value, yyFittedVec[i].error, 
			    0., 0., ierr);
	     saved_uncertainties.push_back(yyFittedVec[i].error);
	   }	   
	 }
      }


      //==================================================================================
      //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      //==================================================================================
      // fit everything directly or first do some subsample fits?
      if (!yyFitAllDirectly) {

	 //-------------------------------------------------------------------------
	 // first fit just mA to mA
	 if (yySepFitmA) {
	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       if ( !( !yyMeasuredVec[i].name.compare("massA0") || !yyMeasuredVec[i].name.compare("massh0") ) ) {
		  yyMeasuredVec[i].temp_nofit = true;
	       }
	    }        
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( yyFittedVec[i].name.compare("massA0") ) {
		  arguments[0] = i+1;
		  if (yyVerbose){
		  cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
		  }
		  fitter->mnexcm("FIX", arguments, 1,ierr);
	       }
	    }

	    arguments[0] = yyMinuitStrategy;
	    fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	    arguments[0] = yyMachinePrecision;
	    fitter->mnexcm("SET EPS", arguments, 1,ierr);
	    arguments[0] = 2000;
	    arguments[1] = 0.1;
	    fitter->mnexcm("MINIMIZE", arguments, 2,ierr);

	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       yyMeasuredVec[i].temp_nofit = false;
	    }  
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( yyFittedVec[i].name.compare("massA0") ) {
		  arguments[0] = i+1;
		  fitter->mnexcm("RELEASE", arguments, 1,ierr);
	       }
	    }
	 }
	 //-------------------------------------------------------------------------
	 // first fit just tanb and mu
	 if (yySepFitTanbMu) {
	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       if ( !( !yyMeasuredVec[i].name.compare("massChargino1") || !yyMeasuredVec[i].name.compare("massChargino2") ||
			!yyMeasuredVec[i].name.compare("massNeutralino1") || !yyMeasuredVec[i].name.compare("massNeutralino2") || 
			!yyMeasuredVec[i].name.compare("massNeutralino3") || !yyMeasuredVec[i].name.compare("massNeutralino4") || 
			((yyMeasuredVec[i].type == xsection) && ((TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Neutralino1"]) || 
			   (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Neutralino2"]) || 
			   (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Chargino1"]) || 
			   (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Chargino2"]) ) ) ) ) {
		  yyMeasuredVec[i].temp_nofit = true;
	       }
	    }        
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( !( !yyFittedVec[i].name.compare("TanBeta") || !yyFittedVec[i].name.compare("Mu") ) ) {
		  arguments[0] = i+1;
		  if (yyVerbose){
		  cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
		  }
		  fitter->mnexcm("FIX", arguments, 1,ierr);
	       }
	    }

	    arguments[0] = yyMinuitStrategy;
	    fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	    arguments[0] = yyMachinePrecision;
	    fitter->mnexcm("SET EPS", arguments, 1,ierr);
	    arguments[0] = 2000;
	    arguments[1] = 0.1;
	    fitter->mnexcm("MINIMIZE", arguments, 2,ierr);

	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       yyMeasuredVec[i].temp_nofit = false;
	    }  
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( !( !yyFittedVec[i].name.compare("TanBeta") || !yyFittedVec[i].name.compare("Mu") ) ) {
		  arguments[0] = i+1;
		  fitter->mnexcm("RELEASE", arguments, 1,ierr);
	       }
	    }

	 }


	 //  //-------------------------------------------------------------------------
	 //  // Perform the fit
	 //  // first fix everything but TanBeta, Mu, M1, M2, M3, massA0
	 //  for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 //    if ( !( !yyFittedVec[i].name.compare("TanBeta") || !yyFittedVec[i].name.compare("Mu") 
	 //	    || !yyFittedVec[i].name.compare("M1") || !yyFittedVec[i].name.compare("M2")
	 //	    || !yyFittedVec[i].name.compare("M3") || !yyFittedVec[i].name.compare("massA0") ) ) {
	 //      arguments[0] = i+1;
	 //      cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
	 //      fitter->mnexcm("FIX", arguments, 1,ierr);
	 //    }
	 //  }
	 //  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	 //    if ( !( !yyMeasuredVec[i].name.compare("massChargino1") || !yyMeasuredVec[i].name.compare("massChargino2") ||
	 //	    !yyMeasuredVec[i].name.compare("massNeutralino1") || !yyMeasuredVec[i].name.compare("massNeutralino2") || 
	 //	    !yyMeasuredVec[i].name.compare("massGluino") || !yyMeasuredVec[i].name.compare("massA0") ||  
	 //	    !yyMeasuredVec[i].name.compare("massh0") || 
	 //	    ((yyMeasuredVec[i].type == xsection) && ((TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Neutralino1"]) || 
	 //						     (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Neutralino2"]) || 
	 //						     (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Chargino1"]) || 
	 //						     (TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Chargino2"]) ) ) ) ) {
	 //      yyMeasuredVec[i].temp_nofit = true;
	 //    }
	 //  }  
	 //  
	 //  arguments[0] = 2000;
	 //  arguments[1] = 0.1;
	 //  fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	 //  for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 //    if ( !( !yyFittedVec[i].name.compare("TanBeta") || !yyFittedVec[i].name.compare("Mu") 
	 //	    || !yyFittedVec[i].name.compare("M1") || !yyFittedVec[i].name.compare("M2")
	 //	    || !yyFittedVec[i].name.compare("M3") || !yyFittedVec[i].name.compare("massA0") ) ) {
	 //      arguments[0] = i+1;
	 //      fitter->mnexcm("RELEASE", arguments, 1,ierr);
	 //    }
	 //  }
	 //
	 //  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	 //    yyMeasuredVec[i].temp_nofit = false;
	 //  }  

	 for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	    if ( !( !yyMeasuredVec[i].name.compare("massSelectronL") ||  !yyMeasuredVec[i].name.compare("massSelectronR") || 
		     !yyMeasuredVec[i].name.compare("massSmuL") ||  !yyMeasuredVec[i].name.compare("massSmuR") || 
		     !yyMeasuredVec[i].name.compare("massStau1") ||  !yyMeasuredVec[i].name.compare("massStau2") ||
		     !yyMeasuredVec[i].name.compare("massSnueL") || !yyMeasuredVec[i].name.compare("massSnumuL") || 
		     !yyMeasuredVec[i].name.compare("massSnutauL") || 
		     ((yyMeasuredVec[i].type == xsection) && ((TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SelectronL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SelectronR"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SmuL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SmuR"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Stau1"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Stau2"]) ) ) ) ) {
	       yyMeasuredVec[i].temp_nofit = true;
	    }
	 } 

	 //    //-------------------------------------------------------------------------
	 //    // scan Xtau
	 //    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 //	if (   !yyFittedVec[i].name.compare("Xtau") ) {
	 //	  arguments[0] = i+1;
	 //	  cout << "scanning parameter no " << i+1 << " " << yyFittedVec[i].name << endl;
	 //	  arguments[1] = 100;
	 //	  arguments[2] = yyFittedVec[i].bound_low;
	 //	  arguments[3] = yyFittedVec[i].bound_up;
	 //	  fitter->mnexcm("SCAN", arguments, 4,ierr);
	 //	  break;
	 //	}
	 //    }

	 //-------------------------------------------------------------------------
	 // Perform the fit
	 // Then fix everything but the SLepton Sector
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( !( !yyFittedVec[i].name.compare("Xtau") || !yyFittedVec[i].name.compare("MSelectronL") 
		     || !yyFittedVec[i].name.compare("MSmuL") || !yyFittedVec[i].name.compare("MStauL")
		     || !yyFittedVec[i].name.compare("MSelectronR") || !yyFittedVec[i].name.compare("MSmuR")
		     || !yyFittedVec[i].name.compare("MStauR") ) ) {
	       arguments[0] = i+1;
	       if (yyVerbose){
	       cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
	       }
	       fitter->mnexcm("FIX", arguments, 1,ierr);
	    }
	 }
	 arguments[0] = yyMinuitStrategy;
	 fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	 arguments[0] = yyMachinePrecision;
	 fitter->mnexcm("SET EPS", arguments, 1,ierr);
	 arguments[0] = 2000;
	 arguments[1] = 0.1;
	 fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( !( !yyFittedVec[i].name.compare("Xtau") || !yyFittedVec[i].name.compare("MSelectronL") 
		     || !yyFittedVec[i].name.compare("MSmuL") || !yyFittedVec[i].name.compare("MStauL")
		     || !yyFittedVec[i].name.compare("MSelectronR") || !yyFittedVec[i].name.compare("MSmuR")
		     || !yyFittedVec[i].name.compare("MStauR") ) ) {
	       arguments[0] = i+1;
	       fitter->mnexcm("RELEASE", arguments, 1,ierr);
	    }
	 }

	 for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	    yyMeasuredVec[i].temp_nofit = false;
	 }  



	 for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	    if ( !( !yyMeasuredVec[i].name.compare("massSupL") ||  !yyMeasuredVec[i].name.compare("massSupR") || 
		     !yyMeasuredVec[i].name.compare("massScharmL") ||  !yyMeasuredVec[i].name.compare("massScharmR") || 
		     !yyMeasuredVec[i].name.compare("massStop1") ||  !yyMeasuredVec[i].name.compare("massStop2") ||
		     !yyMeasuredVec[i].name.compare("massSdownL") || !yyMeasuredVec[i].name.compare("massSdownR") || 
		     !yyMeasuredVec[i].name.compare("massSstrangeL") || !yyMeasuredVec[i].name.compare("massSstrangeR") || 
		     !yyMeasuredVec[i].name.compare("massSbottom1") || !yyMeasuredVec[i].name.compare("massSbottom2") || 
		     ((yyMeasuredVec[i].type == xsection) && ((TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SupL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SupR"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SdownL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SdownR"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["ScharmL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["ScharmR"]) || 
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SstrangeL"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["SstrangeR"]) || 
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Stop1"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Stop2"]) || 
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Sbottom1"]) ||
			(TMath::Abs(yyMeasuredVec[i].products[0])==yyParticleIDs["Sbottom2"]) ) ) ) ) {
	       yyMeasuredVec[i].temp_nofit = true;
	    }
	 } 


	 if (yyScanX) {
	    //-------------------------------------------------------------------------
	    // scan Xtop
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if (  !yyFittedVec[i].name.compare("Xtop") ) {
		  arguments[0] = i+1;
		  if (yyVerbose){
		  cout << "scanning parameter no " << i+1 << " " << yyFittedVec[i].name << endl;
		  }
		  arguments[1] = 100;
		  if (yyBoundsOnX) {
		     arguments[2] = yyFittedVec[i].bound_low;
		     arguments[3] = yyFittedVec[i].bound_up;
		  } else {
		     arguments[2] = yyXscanlow;
		     arguments[3] = yyXscanhigh;	    
		  }
		  fitter->mnexcm("SCAN", arguments, 4,ierr);
		  break;
	       }
	    }

	    //-------------------------------------------------------------------------
	    // scan Xbottom
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if (  !yyFittedVec[i].name.compare("Xbottom") ) {
		  arguments[0] = i+1;
		  if (yyVerbose){
		  cout << "scanning parameter no " << i+1 << " " << yyFittedVec[i].name << endl;
		  }
		  arguments[1] = 100;
		  if (yyBoundsOnX) {
		     arguments[2] = yyFittedVec[i].bound_low;
		     arguments[3] = yyFittedVec[i].bound_up;
		  } else {
		     arguments[2] = yyXscanlow;
		     arguments[3] = yyXscanhigh;	    
		  }
		  fitter->mnexcm("SCAN", arguments, 4,ierr);
		  break;
	       }
	    }
	 }

	 //-------------------------------------------------------------------------
	 // Perform the fit
	 // Then fix everything but the SQuark Sector
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( !( !yyFittedVec[i].name.compare("Xtop") || !yyFittedVec[i].name.compare("Xbottom")   
		     || !yyFittedVec[i].name.compare("MSupL") || !yyFittedVec[i].name.compare("MScharmL")
		     || !yyFittedVec[i].name.compare("MStopL") || !yyFittedVec[i].name.compare("MSupR")
		     || !yyFittedVec[i].name.compare("MScharmR") || !yyFittedVec[i].name.compare("MStopR") 
		     || !yyFittedVec[i].name.compare("MSdownR")
		     || !yyFittedVec[i].name.compare("MSstrangeR") || !yyFittedVec[i].name.compare("MSbottomR") ) ) {
	       arguments[0] = i+1;
	       if (yyVerbose){
	       cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
	       }
	       fitter->mnexcm("FIX", arguments, 1,ierr);
	    }
	 }
	 arguments[0] = yyMinuitStrategy;
	 fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	 arguments[0] = yyMachinePrecision;
	 fitter->mnexcm("SET EPS", arguments, 1,ierr);
	 arguments[0] = 2000;
	 arguments[1] = 0.1;
	 fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( !( !yyFittedVec[i].name.compare("Xtop") || !yyFittedVec[i].name.compare("Xbottom")  
		     || !yyFittedVec[i].name.compare("MSupL") || !yyFittedVec[i].name.compare("MScharmL")
		     || !yyFittedVec[i].name.compare("MStopL") || !yyFittedVec[i].name.compare("MSupR")
		     || !yyFittedVec[i].name.compare("MScharmR") || !yyFittedVec[i].name.compare("MStopR") 
		     || !yyFittedVec[i].name.compare("MSdownR")
		     || !yyFittedVec[i].name.compare("MSstrangeR") || !yyFittedVec[i].name.compare("MSbottomR") ) ) {
	       arguments[0] = i+1;
	       fitter->mnexcm("RELEASE", arguments, 1,ierr);
	    }
	 }

	 //==================================================================================================
	 //==================================================================================================
	 // now release all
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    arguments[0] = i+1;
	    fitter->mnexcm("RELEASE", arguments, 1,ierr);
	 }
	 for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	    yyMeasuredVec[i].temp_nofit = false;  
	 }  

	 if (yySepFitTanbX) {
	    //-------------------------------------------------------------------------
	    // Perform the fit
	    // Then fix everything but the A's and MStop and TanBeta
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( !( !yyFittedVec[i].name.compare("Xtop") || !yyFittedVec[i].name.compare("Xbottom") || !yyFittedVec[i].name.compare("TanBeta") 
			|| !yyFittedVec[i].name.compare("MStopL") || !yyFittedVec[i].name.compare("MStopR") ) ) { 
		  arguments[0] = i+1;
	          if (yyVerbose){
		  cout << "fixing parameter "<< yyFittedVec[i].name << endl;
		  }
		  fitter->mnexcm("FIX", arguments, 1,ierr);
	       }
	    }
	    arguments[0] = yyMinuitStrategy;
	    fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	    arguments[0] = yyMachinePrecision;
	    fitter->mnexcm("SET EPS", arguments, 1,ierr);
	    arguments[0] = 20000;
	    arguments[1] = 0.1;
	    fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	    for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	       if ( !( !yyFittedVec[i].name.compare("Xtop") || !yyFittedVec[i].name.compare("Xbottom") || !yyFittedVec[i].name.compare("TanBeta") 
			|| !yyFittedVec[i].name.compare("MStopL") || !yyFittedVec[i].name.compare("MStopR") ) ) {
		  arguments[0] = i+1;
		  fitter->mnexcm("RELEASE", arguments, 1,ierr);
	       }
	    }
	 }

      } // end of if(!yyFitAllDirectly)


      //==================================================================================================
      //==================================================================================================
      //--------------------------------------------------------------------------
      // then release all the fixed parameters
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 arguments[0] = i+1;
	 fitter->mnexcm("RELEASE", arguments, 1,ierr);
      }
      for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	 yyMeasuredVec[i].temp_nofit = false;
      }  


      //--------------------------------------------------------------------------
      // perform the final fit with all parameters free
      arguments[0] = yyMinuitStrategy;
      fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
      arguments[0] = yyMachinePrecision;
      fitter->mnexcm("SET EPS", arguments, 1,ierr);
      arguments[0] = 200000;
      arguments[1] = 0.1;
      for (unsigned int i=0; i<yyNumberOfMinimizations; i++) {
	 if (i>0) {
	    // read the central values and uncertainties
	    for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	       fitter->mnpout(j,parname,yyFittedVec[j].value,yyFittedVec[j].error,vlow,vhigh,ierr);
	    }      
	    //-------------------------------------------------------------------------
	    // eventually call simulated annealing
	    if (yyUseSimAnnWhile) {
	       // open the ntuple file
	       TFile *SimAnnNtupFile = new TFile("SimAnnNtupFile.root","UPDATE");
	       sprintf ( ntuplename, "ntuple%i", i );
	       sprintf ( ntupletext, "path of the simulated annealing No. %i", i );
	       sprintf ( ntuplevars, "n:t:f:acc:xopt" );
	       for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
		  sprintf ( ntuplevars, "%s:%s", ntuplevars, yyFittedVec[j].name.c_str() );
	       }
	       TNtuple *simannntuple = new TNtuple(ntuplename,ntupletext,ntuplevars);
	       // check the status of the minimization
	       fitter->mnstat(amin, edm, errdef, nvpar, nparx, ierr);	
	       if (ierr == 3) {
		  for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
		     yyFittedVec[j].error = 2.*yyFittedVec[j].error;
		  }
	       } else {
		  // error matrix is not accurate
		  for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
		     yyFittedVec[j].error = saved_uncertainties[j];
		  }
	       }
	       simulated_annealing(i,simannntuple);
	       // close the ntuple
	       SimAnnNtupFile->Write();
	       SimAnnNtupFile->Close();
	    }
	    // reset the uncertainties
	    for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	       if (yyVerbose){
	       cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	       cout << "resetting parameter errors " << yyFittedVec[j].name << endl;
	       cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	       }
	       fitter->mnparm(j, yyFittedVec[j].name.c_str(),
		     yyFittedVec[j].value, saved_uncertainties[j], 
		     yyFittedVec[j].bound_low, yyFittedVec[j].bound_up,ierr);
	    }
	 }
	 if (yyUseSimplexMinOnly || yyUseSimplexMin) {
	   if (yyVerbose){
	   cout << "perform simplex optimization" << endl;
	   }
	   arguments[0]  = 1000.;  
	   fitter->mnexcm("SIMPLEX",arguments, 1, ierr);
	 }
	 if (!yyUseSimplexMinOnly) {
	   if (yyVerbose){
	   cout << "perform MINIMIZE optimization" << endl;
	   }
	   arguments[0] = 200000;
	   arguments[1] = 0.1;
	   fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	 }
      }
      if (yyVerbose){
      cout << "returning from MINIMIZE, return value "<< ierr << endl;
      }
      if (yyUseHesse && !yyUseMinos) {
	 fitter->mnexcm("HESSE", arguments, 1,ierr);
	 if (yyVerbose){
	 cout << "returning from HESSE, return value "<< ierr << endl;
	 }
      }
      if (yyUseMinos) {
	 fitter->mnexcm("HESSE", arguments, 1,ierr);
	 arguments[0] = yyErrDef;
	 fitter->mnexcm("SET ERR", arguments, 1,ierr);
	 arguments[0] = 200000;
	 fitter->mnexcm("MINOS", arguments, 1,ierr);
      }  
   }

   if (yyPerformSingleFits) {
      fstream singleFitsFile;
      if (yyVerbose){
      cout << "Starting single Fits" << endl;
      }

      if (!yyPerformFit) {
	 fitter = new TMinuit (yyFittedVec.size());
	 fitter->SetFCN(fitterFCN);

	 arguments[0] = 0;
	 fitter->mnexcm("SET PRI", arguments, 1,ierr);
	 arguments[0] = 1.;
	 fitter->mnexcm("SET ERR", arguments, 1,ierr);

	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if (yyVerbose){
	    cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	    cout << "adding parameter " << yyFittedVec[i].name << endl;
	    cout << "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" << endl;
	    }
	    if ( yyFittedVec[i].error <= 0. ) {
	       fitter->mnparm(i, yyFittedVec[i].name.c_str(),
		     yyFittedVec[i].value, TMath::Abs(yyFittedVec[i].value/10.), 
		     yyFittedVec[i].bound_low, yyFittedVec[i].bound_up,ierr);
	       saved_uncertainties.push_back(TMath::Abs(yyFittedVec[i].value/10.));
	    } else {
	       fitter->mnparm(i, yyFittedVec[i].name.c_str(),
		     yyFittedVec[i].value, yyFittedVec[i].error, 
		     yyFittedVec[i].bound_low, yyFittedVec[i].bound_up,ierr);
	       saved_uncertainties.push_back(yyFittedVec[i].error);
	    }
	 }
      }

      singleFitsFile.open ("singleFitsResults.txt",ofstream::out);

      Double_t fittedPar[30];
      Double_t fittedParErr[30][300];
      for (unsigned int ipar = 0; ipar < yyFittedVec.size(); ipar++) {
	 singleFitsFile << endl << "======================================="<< endl;
	 singleFitsFile << "Testing Parameter " << yyFittedVec[ipar].name << endl << endl;
	 // fix all other parameters
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( i != ipar ) { 
	       arguments[0] = i+1;
	       if (yyVerbose){
	       cout << "fixing parameter "<< yyFittedVec[i].name << endl; 
	       }
	       fitter->mnexcm("FIX", arguments, 1,ierr);
	       if (yyVerbose){
	       cout << "fixing done" << endl;
	       }
	    }
	 }
	 Double_t fivelargest[5];
	 Int_t fivelargestint[5];
	 for (unsigned int j = 0; j < 5; j++) {
	    fivelargest[j] = 10000000000.;
	    fivelargestint[j] = 1000000000;
	 }
	 // loop over obersvables
	 for (unsigned int iobs = 0; iobs < yyMeasuredVec.size(); iobs++) {
	    // fix unneeded observables
	    if ( !yyMeasuredVec[iobs].name.compare("alphas")
		  || !yyMeasuredVec[iobs].name.compare("alphaem")
		  || !yyMeasuredVec[iobs].name.compare("sin2ThetaW") 
		  || !yyMeasuredVec[iobs].name.compare("massZ")
		  || !yyMeasuredVec[iobs].name.compare("massTau")
		  || !yyMeasuredVec[iobs].name.compare("massCharm") 
		  || !yyMeasuredVec[iobs].name.compare("massBottom") ) {
	       continue;
	    } 
	    if (yyMeasuredVec[iobs].nofit) {
	       continue;
	    }
	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       if ( i != iobs ) {
		  yyMeasuredVec[i].temp_nofit = true;
	       }
	    }
	    // fit
	    arguments[0] = yyMinuitStrategy;
	    fitter->mnexcm("SET STRATEGY", arguments, 1, ierr);
	    arguments[0] = yyMachinePrecision;
	    fitter->mnexcm("SET EPS", arguments, 1,ierr);
	    arguments[0] = 20000;
	    arguments[1] = 0.1;
	    fitter->mnexcm("MINIMIZE", arguments, 2,ierr);
	    // get result
	    fitter->mnstat(amin, edm, errdef, nvpar, nparx, ierr);
	    if (ierr == 3) {
	       fitter->mnpout(ipar,parname,fittedPar[ipar],fittedParErr[ipar][iobs],vlow,vhigh,ierr);
	    } else {
	       fittedParErr[ipar][iobs] = 10000000.;
	       fittedPar[ipar] = yyFittedVec[ipar].value;
	    }
	    // reset value
	    fitter->mnparm(ipar, yyFittedVec[ipar].name.c_str(),
		  yyFittedVec[ipar].value, yyFittedVec[ipar].error, 
		  yyFittedVec[ipar].bound_low, yyFittedVec[ipar].bound_up,ierr);
	    singleFitsFile << yyMeasuredVec[iobs].name << " " << yyMeasuredVec[iobs].alias << " :   " << fittedParErr[ipar][iobs] << endl; 
	    for (int k = 4; k > -1; k--) {
	       if (fabs(fittedParErr[ipar][iobs])<fivelargest[k]) {
		  // fprintf (stderr, "correlation from %s is stronger than previous on pos %d\n",obsnames[j],k);
		  for (int l = 0; l < k; l++) {
		     fivelargest[l]=fivelargest[l+1];
		     fivelargestint[l]=fivelargestint[l+1];
		  }
		  fivelargest[k]=fabs(fittedParErr[ipar][iobs]);
		  fivelargestint[k]=iobs;
		  break;
	       }
	    }
	    // unfix observables
	    for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
	       yyMeasuredVec[i].temp_nofit = false;
	    }  
	 }
	 // release all other parameters
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    if ( i != ipar ) {
	       arguments[0] = i+1;
	       fitter->mnexcm("RELEASE", arguments, 1,ierr);
	    }
	 }
	 // evaluate results
	 singleFitsFile << "======================================="<< endl;
	 for (int k = 4; k > -1; k--) {
	    singleFitsFile << yyMeasuredVec[fivelargestint[k]].name << " " << yyMeasuredVec[fivelargestint[k]].alias << " :   " << fittedParErr[ipar][fivelargestint[k]] << endl; ;
	 }
      }
      singleFitsFile.close();
   }

   if (yyScanParameters) {

      int npar, iflag;
      double chi2;
      double *gin;
      double* par = new double[yyFittedVec.size()];

      int par1pos,par2pos;

      double* x = 0;
      double* y = 0;
      double* z = 0;

      if (yyVerbose){
      cout<<"Starting parameter scan with:"<<endl;
      }

      if (yyPerformFit) {
	 for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	    fitter->mnpout(i,parname,yyFittedVec[i].value,yyFittedVec[i].error,vlow,vhigh,ierr);
	 }
      }

      for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	 par[j] = yyFittedVec[j].value;
	 if (yyVerbose){
	 cout<<yyFittedVec[j].name<<" = "<<yyFittedVec[j].value<<endl;
	 }
      }



      if (yyScanPar.size() == 1) {

	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    if (!yyFittedVec[j].name.compare(yyScanPar[0].name)) {
	       par1pos = j;
	       break;
	    }
	 }

	 x = new double[yyScanPar[0].numberOfSteps];
	 z = new double[yyScanPar[0].numberOfSteps];

	 for (unsigned int j=0; j<yyScanPar[0].numberOfSteps; j++) {
	    double value = yyScanPar[0].min + (yyScanPar[0].max - yyScanPar[0].min)
	       * double(j) / (yyScanPar[0].numberOfSteps - 1);

	    par[par1pos] = value;

	    fitterFCN(npar, gin, chi2, par, iflag);

	    x[j] = value;
	    z[j] = chi2;

	 }
      }
      else if (yyScanPar.size() == 2) {

	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    if (!yyFittedVec[j].name.compare(yyScanPar[0].name)) {
	       par1pos = j;
	    }
	    if (!yyFittedVec[j].name.compare(yyScanPar[1].name)) {
	       par2pos = j;
	    }	
	 }

	 x = new double[yyScanPar[0].numberOfSteps*yyScanPar[1].numberOfSteps];
	 y = new double[yyScanPar[0].numberOfSteps*yyScanPar[1].numberOfSteps];
	 z = new double[yyScanPar[0].numberOfSteps*yyScanPar[1].numberOfSteps];

	 for (unsigned int i=0; i<yyScanPar[0].numberOfSteps; i++) {
	    double value1 = yyScanPar[0].min + (yyScanPar[0].max - yyScanPar[0].min)
	       * double(i) / (yyScanPar[0].numberOfSteps - 1);

	    for (unsigned int j=0; j<yyScanPar[1].numberOfSteps; j++) {
	       double value2 = yyScanPar[1].min + (yyScanPar[1].max - yyScanPar[1].min)
		  * double(j) / (yyScanPar[1].numberOfSteps - 1);

	       par[par1pos] = value1;
	       par[par2pos] = value2;

	       fitterFCN(npar, gin, chi2, par, iflag);

	       x[i*yyScanPar[1].numberOfSteps+j] = value1;
	       y[i*yyScanPar[1].numberOfSteps+j] = value2;
	       z[i*yyScanPar[1].numberOfSteps+j] = chi2;
	       
	       if (yyVerbose){
	       cout << "parScan " << value2 << " " << value1 << " " << chi2 << endl;
	       }

	    }
	 }

      	}
	TFile* file = new TFile("ParameterScan.root","recreate");
	TTree* tree = new TTree("observables","Tree holding the parameters + chi2");
	Float_t par1, par2, chi;
	tree->Branch(yyScanPar[0].name.c_str(),&par1,yyScanPar[0].name.c_str());
	tree->Branch(yyScanPar[1].name.c_str(),&par2,yyScanPar[1].name.c_str());
	tree->Branch("chi2",&chi,"chi2");
	#ifdef USELIBHB
	Float_t massh0, massH0, massA0, gammah0, gammaH0, gammaA0, BR_hjbbh0, BR_hjbbH0, BR_hjbbA0, BR_hjtautauh0, BR_hjtautauH0, BR_hjtautauA0, g2hjZZh0, g2hjZZH0, g2hjZZA0;
	if (yyUseHiggsBounds){
		tree->Branch("O_massh0",&massh0,"O_massh0");
		tree->Branch("O_massH0",&massH0,"O_massH0");
		tree->Branch("O_massA0",&massA0,"O_massA0");
		tree->Branch("O_gammah0",&gammah0,"O_gammah0");
		tree->Branch("O_gammaH0",&gammaH0,"O_gammaH0");
		tree->Branch("O_gammaA0",&gammaA0,"O_gammaA0");
		tree->Branch("BR_hjbbh0",&BR_hjbbh0,"BR_hjbbh0");
		tree->Branch("BR_hjbbH0",&BR_hjbbH0,"BR_hjbbH0");
		tree->Branch("BR_hjbbA0",&BR_hjbbA0,"BR_hjbbA0");
		tree->Branch("BR_hjtautauh0",&BR_hjtautauh0,"BR_hjtautauh0");
		tree->Branch("BR_hjtautauH0",&BR_hjtautauH0,"BR_hjtautauH0");
		tree->Branch("BR_hjtautauA0",&BR_hjtautauA0,"BR_hjtautauA0");
		tree->Branch("O_g2hjZZh0",&g2hjZZh0,"O_g2hjZZh0");
		tree->Branch("O_g2hjZZH0",&g2hjZZH0,"O_g2hjZZH0");
		tree->Branch("O_g2hjZZA0",&g2hjZZA0,"O_g2hjZZA0");
		}
	#endif
      	if (par) delete[] par;


	for (unsigned int j=0; j<(yyScanPar[0].numberOfSteps*yyScanPar[0].numberOfSteps); j++) {
		par1 = x[j];
		par2 = y[j];
		chi = z[j];
		#ifdef USELIBHB
		if (yyUseHiggsBounds) {
			massh0 = HBmass[0][j];
			massH0 = HBmass[1][j];
			massA0 = HBmass[2][j];
			
			gammah0 = gammah[0][j];
			gammaH0 = gammah[1][j];
			gammaA0 = gammah[2][j];

			BR_hjbbh0 = BR_hjbb[0][j];
			BR_hjbbH0 = BR_hjbb[1][j];
			BR_hjbbA0 = BR_hjbb[2][j];

			BR_hjtautauh0 = BR_hjtautau[0][j];
			BR_hjtautauH0 = BR_hjtautau[1][j];
			BR_hjtautauA0 = BR_hjtautau[2][j];

			g2hjZZh0 = O_g2hjZZ[0][j];
			g2hjZZH0 = O_g2hjZZ[1][j];
			g2hjZZA0 = O_g2hjZZ[2][j];
			}
		#endif
	   tree->Fill();
	}
	tree->Write();

      TGraph* graph1d = 0;
      TGraph2D* graph2d = 0;

      if (yyScanPar.size() == 1) {
	 graph1d = new TGraph(yyScanPar[0].numberOfSteps, x, z);
	 graph1d->GetHistogram()->SetXTitle(yyScanPar[0].name.c_str());
	 graph1d->GetHistogram()->SetYTitle("#chi^{2}");
	 graph1d->Write();
      }
      else if (yyScanPar.size() == 2) {
	 graph2d = new TGraph2D(yyScanPar[0].numberOfSteps*yyScanPar[1].numberOfSteps, x, y, z);
	 graph2d->GetHistogram()->SetXTitle(yyScanPar[0].name.c_str());
	 graph2d->GetHistogram()->SetYTitle(yyScanPar[1].name.c_str());
	 graph2d->GetHistogram()->SetZTitle("#chi^{2}");
	 graph2d->Write();
      }

      file->Close();

      if (x) delete[] x;
      if (y) delete[] y;
      if (z) delete[] z;

      //      fitterFCN(dummyint, &dummyfloat, store_chisq[0], x, 10);

   }

   if (yyPerformFit) {
      //-------------------------------------------------------------------------
      // Get Results
      fitter->mnstat(amin, edm, errdef, nvpar, nparx, ierr);
      fchisq = amin;
      gchisq = amin;
      gstat  = ierr;
      fFittedCovarianceMatrix = new double[yyFittedVec.size()*yyFittedVec.size()];
      fitter->mnemat(fFittedCovarianceMatrix,yyFittedVec.size());
      //fitter->PrintResults(3, amin);

      fSavedFittedCovarianceMatrix = new TMatrixD(yyFittedVec.size(),yyFittedVec.size());
      fSavedFittedCorrelationMatrix = new TMatrixD(yyFittedVec.size(),yyFittedVec.size());

      
      if (yyVerbose){
      cout << "calculating the covariance and correlation matrix "<<endl;
      }
      //-------------------------------------------------------------------------
      // Calculate Covariance Matrix
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    (*fSavedFittedCovarianceMatrix)(i,j) = fFittedCovarianceMatrix[i*yyFittedVec.size()+j];
	 }
      }
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    (*fSavedFittedCorrelationMatrix)(i,j) = (*fSavedFittedCovarianceMatrix)(i,j)/
	       (TMath::Sqrt((*fSavedFittedCovarianceMatrix)(i,i)*(*fSavedFittedCovarianceMatrix)(j,j)));
	 }
      }

      if (yyVerbose){
      cout << "get the errors" << endl;
      }
      //-------------------------------------------------------------------------
      // Get Errors
      // return values
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 fitter->mnpout(i,parname,yyFittedVec[i].value,yyFittedVec[i].error,vlow,vhigh,ierr);
	 if (yyUseMinos) {
	    fitter->mnerrs(i, eplus, eminus, eparab, globcc);
	    //      yyFittedVec[i].error = TMath::Max(TMath::Abs(eplus), TMath::Abs(eminus));
	    yyFittedVec[i].positive_error = eplus;
	    yyFittedVec[i].negative_error = eminus;
	    // recalculate Error because of yyErrDef
	    yyFittedVec[i].error = yyFittedVec[i].error / sqrt(yyErrDef);
	    yyFittedVec[i].positive_error = yyFittedVec[i].positive_error / sqrt(yyErrDef);
	    yyFittedVec[i].negative_error = yyFittedVec[i].negative_error / sqrt(yyErrDef);
	 }
      }
   }

   if (yyPerformFit && yyUseMinos) {
      // recalculate Covariance Matrix because of yyErrDef
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    (*fSavedFittedCovarianceMatrix)(i,j) = (*fSavedFittedCovarianceMatrix)(i,j)/yyErrDef;
	 }
      }    
   }

   // eventually call simulated annealing
   if (yySimAnnUncertainty) {
      time_t systime;
      int seed;
      struct sysinfo sinfo; 
      // set the random number generator
      time (&systime);
      sysinfo(&sinfo);
      if (yyRandomGeneratorSeed < 0) {
	 seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
	 if (yyVerbose){
	 cout<<"uptime = "<<sinfo.uptime<<endl;
	 cout<<"freeswap = "<<sinfo.freeswap<<endl;
	 cout<<"pid = "<<getpid()<<endl;
	 cout << "systime " << systime << endl;
	 }
      }
      else {
	 if (yyVerbose){
	 cout<<"using seed from input file"<<endl;
	 }
	 seed = yyRandomGeneratorSeed;
      }
      if (yyVerbose){
      cout << "seed = " << seed << endl;
      }
      gRandom->SetSeed(seed);
      TFile *SimAnnNtupFile = new TFile("SimAnnNtupFile.root","UPDATE");
      sprintf ( ntuplename, "uncertainty_ntuple" );
      sprintf ( ntupletext, "Simulated Annealing uncertainty ellipse" );
      sprintf ( ntuplevars, "n:t:f:acc:xopt:delta1" );
      for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
	 sprintf ( ntuplevars, "%s:%s", ntuplevars, yyFittedVec[j].name.c_str() );
      }
      TNtuple *simannntuple = new TNtuple(ntuplename,ntupletext,ntuplevars);
      simulated_annealing_uncertainties(simannntuple);
      SimAnnNtupFile->Write();
      SimAnnNtupFile->Close();
   }
   if (yySimAnnUncertaintyRunDown) {
      time_t systime;
      int seed;
      struct sysinfo sinfo; 
      // set the random number generator
      time (&systime);
      sysinfo(&sinfo);
      if (yyRandomGeneratorSeed < 0) {
	 seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
	 if (yyVerbose){
	 cout<<"uptime = "<<sinfo.uptime<<endl;
	 cout<<"freeswap = "<<sinfo.freeswap<<endl;
	 cout<<"pid = "<<getpid()<<endl;
	 cout << "systime " << systime << endl; 
	 }
      }
      else {
	 if (yyVerbose){
	 cout<<"using seed from input file"<<endl;
	 }
	 seed = yyRandomGeneratorSeed;
      }
      if (yyVerbose){
      cout << "seed = " << seed << endl;
      }
      gRandom->SetSeed(seed);
      TFile *SimAnnNtupFile = new TFile("SimAnnNtupFile.root","UPDATE");
      sprintf ( ntuplename, "uncertainty_ntuple" );
      sprintf ( ntupletext, "Simulated Annealing uncertainty ellipse" );
      sprintf ( ntuplevars, "n:t:f:acc:xopt:delta1" );
      for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
	 sprintf ( ntuplevars, "%s:%s", ntuplevars, yyFittedVec[j].name.c_str() );
      }
      TNtuple *simannntuple = new TNtuple(ntuplename,ntupletext,ntuplevars);
      simulated_annealing_uncertainties_run_down(simannntuple);
      SimAnnNtupFile->Write();
      SimAnnNtupFile->Close();
   }

   if (yyRandomDirUncertainties) {
      randomDirectionUncertainties();
   }

   if (yyPerformFit) {
      if (yyVerbose){
      cout << "write the preliminay output file" << endl;
      }
      writeResults("fittino.out.intermediate");
   }
   if (yyVerbose){
   cout << "eventually get the contours " << endl;
   }
   //-------------------------------------------------------------------------
   // Get the contours with only two parameters free
   if (yyPerformFit && yyGetContours) {
      TFile* hfile1 = 0;
      hfile1 = new TFile("FitContours_2params_free.root","RECREATE","Fit Contours of the SUSY Paramater Fit with only two params free");

      arguments[0] = 1.0;
      fitter->mnexcm("SET ERR", arguments, 1,ierr);
      //    fitter->mnexcm("MINOS", arguments, 1,ierr);
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    if (i < j) {
	       // fix all parameters but i and j 
	       for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		  if ( !( (k==i) || (k==j) ) ) {
		     arguments[0] = k+1;
		     if (yyVerbose){
		     cout << "fixing parameter "<< yyFittedVec[k].name << endl; 
		     }
		     fitter->mnexcm("FIX", arguments, 1,ierr);
		  }
	       }
	       // now get the contour
	       UInt_t ncontpoints = 0;
	       fitter->mncont(i,j,npoints,xarray,yarray,ierr);
	       if (ierr < 4) {
		  cerr<<"ierr returned from mncont = "<<ierr<<endl;
		  for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		     arguments[0] = k+1;
		     fitter->mnexcm("RELEASE", arguments, 1,ierr);
		  }
		  continue;
	       }
	       ncontpoints = ierr;
	       for (unsigned int k = 0; k<ncontpoints; k++) {
		  closedxarray[k] = xarray[k];
		  closedyarray[k] = yarray[k];
		  if (yyVerbose){
		  cout<<"x["<<k<<"] = "<<xarray[k]<<"   y["<<k<<"] = "<<yarray[k]<<endl;
		  }
	       }
	       closedxarray[ncontpoints] = xarray[0];
	       closedyarray[ncontpoints] = yarray[0];
	       //-------------------------------------------------------------------------
	       // book graphs
	       // create one TGraph object for each pair of variables
	       TGraphTitle = "2Param Fit Contour of ";
	       TGraphTitle.append(yyFittedVec[j].name);
	       TGraphTitle.append(" vs ");
	       TGraphTitle.append(yyFittedVec[i].name);
	       TGraphDummy = new TGraph(ncontpoints+1,closedxarray,closedyarray);
	       TGraphDummy->SetTitle(TGraphTitle.c_str());
	       sprintf(GraphName,"Graph%i",int(i*yyFittedVec.size()+j));
	       TGraphDummy->SetName(GraphName);
	       TGraphDummy->Write();
	       // free all other parameters
	       for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		  arguments[0] = k+1;
		  fitter->mnexcm("RELEASE", arguments, 1,ierr);
	       }
	    }
	 }
      }
      if (yyVerbose){
      cout << "close the output root files " << endl;
      }
      //-------------------------------------------------------------------------
      // Close the Output file
      // close histograms
      hfile1->Write();
      hfile1->Close();
   }

   //-------------------------------------------------------------------------
   // Get Contours
   if (yyPerformFit && yyGetContours) {
      TFile* hfile = 0;
      hfile = new TFile("FitContours.root","RECREATE","Fit Contours of the SUSY Paramater Fit");

      arguments[0] = 1.0;
      fitter->mnexcm("SET ERR", arguments, 1,ierr);
      //    fitter->mnexcm("MINOS", arguments, 1,ierr);
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	    if (i < j) {
	       UInt_t ncontpoints = 0;
	       fitter->mncont(i,j,npoints,xarray,yarray,ierr);
	       if (ierr < 4) {
		  cerr<<"ierr returned from mncont = "<<ierr<<endl;
		  continue;
	       }
	       ncontpoints = ierr;
	       for (unsigned int k = 0; k<ncontpoints; k++) {
		  closedxarray[k] = xarray[k];
		  closedyarray[k] = yarray[k];
		  if (yyVerbose){
		  cout<<"x["<<k<<"] = "<<xarray[k]<<"   y["<<k<<"] = "<<yarray[k]<<endl;
		  }
	       }
	       closedxarray[ncontpoints] = xarray[0];
	       closedyarray[ncontpoints] = yarray[0];
	       //-------------------------------------------------------------------------
	       // book graphs
	       // create one TGraph object for each pair of variables
	       TGraphTitle = "Fit Contour of ";
	       TGraphTitle.append(yyFittedVec[j].name);
	       TGraphTitle.append(" vs ");
	       TGraphTitle.append(yyFittedVec[i].name);
	       TGraphDummy = new TGraph(ncontpoints+1,closedxarray,closedyarray);
	       TGraphDummy->SetTitle(TGraphTitle.c_str());
	       sprintf(GraphName,"Graph%i",int(i*yyFittedVec.size()+j));
	       TGraphDummy->SetName(GraphName);
	       TGraphDummy->Write();
	    }
	 }
      }
      if (yyVerbose){
      cout << "close the output root files " << endl;
      }
      //-------------------------------------------------------------------------
      // Close the Output file
      // close histograms
      hfile->Write();
      hfile->Close();
   }

   //  arguments[0] = 0;
   //  fitter->mnexcm("RETURN", arguments, 0,ierr);

   if (yyVerbose){
   cout << "do not delete fitter" << endl;
   }

   // if (fitter) delete fitter;
   // cout << "fitter deleted" << endl;
}


void Fittino::writeResults(const char* filename)
{
   FILE* file = fopen(filename,"w");

   time_t now;
   time(&now);

   tm* tm_now = localtime(&now);
   int sec  = tm_now->tm_sec;
   int min  = tm_now->tm_min;
   int hour = tm_now->tm_hour;
   int mday = tm_now->tm_mday;
   int mon  = tm_now->tm_mon;
   int year = tm_now->tm_year + 1900;
   int wday = tm_now->tm_wday;

   if (yyVerbose){
   cout << " entering writeResults" << endl;
   }

   string weekday;
   switch (wday) {
      case 0:
	 weekday = "Sunday";
	 break;
      case 1:
	 weekday = "Monday";
	 break;
      case 2:
	 weekday = "Tuesday";
	 break;
      case 3:
	 weekday = "Wednesday";
	 break;
      case 4:
	 weekday = "Thursday";
	 break;
      case 5:
	 weekday = "Friday";
	 break;
      case 6:
	 weekday = "Saturday";
	 break;
      default:
	 cerr<<"Unknown weekday"<<endl;
	 exit(EXIT_FAILURE);
   }

   string month;
   switch (mon) {
      case 0:
	 month = "January";
	 break;
      case 1:
	 month = "February";
	 break;
      case 2:
	 month = "March";
	 break;
      case 3:
	 month = "April";
	 break;
      case 4:
	 month = "May";
	 break;
      case 5:
	 month = "June";
	 break;
      case 6:
	 month = "July";
	 break;
      case 7:
	 month = "August";
	 break;
      case 8:
	 month = "September";
	 break;
      case 9:
	 month = "October";
	 break;
      case 10:
	 month = "November";
	 break;
      case 11:
	 month = "December";
	 break;
      default:
	 cerr<<"Unknown month"<<endl;
	 exit(EXIT_FAILURE);
   }


   fprintf(file,"#################### Fittino Fit Summary ####################\n");
   fprintf(file,"created by Fittino revision $Rev$\n");
   fprintf(file,"on %s, %s %02d, %d at %02d:%02d:%02d\n", weekday.c_str(), month.c_str(),
	 mday, year, hour, min, sec);
   fprintf(file,"\n");
   fprintf(file,"Input values:\n");
   fprintf(file,"=============\n");
   for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
      if (yyMeasuredVec[i].nofit) continue;
      if (yyMeasuredVec[i].name.length() < 20)
	 fprintf(file,"%20s   %12g +- %12g\n", yyMeasuredVec[i].name.c_str(), yyMeasuredVec[i].value,
	       yyMeasuredVec[i].error);
      else
	 fprintf(file,"%s      %f +- %f\n",yyMeasuredVec[i].name.c_str(),
	       yyMeasuredVec[i].value,yyMeasuredVec[i].error);
   }
   fprintf(file,"\n");
   fprintf(file,"Covariance matrix for input value:\n");
   fprintf(file,"==================================\n");
   fprintf(file,"                     ");
   for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
      if (!yyMeasuredVec[i].nofit) {
	 fprintf(file,"%12s", yyMeasuredVec[i].name.c_str());
      }
   }
   fprintf(file,"\n");
   for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
      if (!yyMeasuredVec[i].nofit) {
	 fprintf(file,"%20s ", yyMeasuredVec[i].name.c_str());
	 for (unsigned int j=0; j<yyMeasuredVec.size(); j++) {
	    if (!yyMeasuredVec[j].nofit) {
	       fprintf(file,"%12f", fInput->GetMeasuredCorrelationMatrix().GetCovariance(i, j));
	    }
	 }
	 fprintf(file,"\n");
      }
   }
   fprintf(file,"\n");
   fprintf(file,"Fixed values: \n");
   fprintf(file,"=============\n");
   for (unsigned int i=0; i<yyFixedPar.size(); i++) {
      if (yyFixedPar[i].name.length() < 20)
	 fprintf(file,"%20s   %12g\n", yyFixedPar[i].name.c_str(), yyFixedPar[i].value);
      else
	 fprintf(file,"%s      %f\n",yyFixedPar[i].name.c_str(),yyFixedPar[i].value);
   }
   fprintf(file,"\n");
   fprintf(file,"Fitted values:\n");
   fprintf(file,"==============\n");
   for (unsigned int i=0; i<yyFittedVec.size(); i++) {
      if (yyFittedVec[i].name.length() < 20) {
	 fprintf(file,"%20s   %12g +- %12g", yyFittedVec[i].name.c_str(), yyFittedVec[i].value,
	       yyFittedVec[i].error);
	 if (yyUseMinos) {
	    fprintf(file," (%12g,%12g)\n",yyFittedVec[i].negative_error,yyFittedVec[i].positive_error);
	 } else {
	    fprintf(file,"\n");
	 }
      }
      else {
	 fprintf(file,"%s      %f +- %f",yyFittedVec[i].name.c_str(),yyFittedVec[i].value,yyFittedVec[i].error);
	 if (yyUseMinos) {
	    fprintf(file," (%f,%f)\n",yyFittedVec[i].negative_error,yyFittedVec[i].positive_error);
	 } else {
	    fprintf(file,"\n");
	 }
      }
   }
   fprintf(file,"\n");
   if (fSavedFittedCovarianceMatrix) {
      fprintf(file,"Covariance matrix for fitted parameters:\n");
      fprintf(file,"========================================\n");
      fprintf(file,"\n");
      fprintf(file,"                   ");
      for (unsigned int i=0; i<yyFittedVec.size(); i++) {
	 fprintf(file, "%12s", yyFittedVec[i].name.c_str());
      }
      fprintf(file,"\n");
      for (unsigned int i=0; i<yyFittedVec.size(); i++) {
	 fprintf(file,"%20s ", yyFittedVec[i].name.c_str());
	 for (unsigned int j=0; j<yyFittedVec.size(); j++) {
	    fprintf(file, "%12g", (*fSavedFittedCovarianceMatrix)(i,j) );
	 }
	 fprintf(file, " \n");
      }
      fprintf(file, " \n");
   }
   fprintf(file,"\n");
   if (fSavedFittedCorrelationMatrix) {
      fprintf(file,"Correlation matrix for fitted parameters:\n");
      fprintf(file,"=========================================\n");
      fprintf(file,"\n");
      fprintf(file,"                   ");
      for (unsigned int i=0; i<yyFittedVec.size(); i++) {
	 fprintf(file, "%12s", yyFittedVec[i].name.c_str());
      }
      fprintf(file,"\n");
      for (unsigned int i=0; i<yyFittedVec.size(); i++) {
	 fprintf(file,"%20s ", yyFittedVec[i].name.c_str());
	 for (unsigned int j=0; j<yyFittedVec.size(); j++) {
	    fprintf(file, "%12g", (*fSavedFittedCorrelationMatrix)(i,j) );
	 }
	 fprintf(file, " \n");
      }
      fprintf(file, " \n");
   }

   cout << "printing chisq result" << endl;

   fprintf(file,"\n");
   fprintf(file,"Chisq of the fit:\n");
   fprintf(file,"=================\n");
   fprintf(file,"\n");
   fprintf(file,"                   chisq = %f\n\n",fchisq);
   fprintf(file,"\n");
   fprintf(file,"Status of the minimization:\n");
   fprintf(file,"===========================\n");
   fprintf(file,"\n");
   if (gstat==0) {
      fprintf(file,"                   Error Matrix not calculated at all\n\n");
   } else if (gstat==1) {
      fprintf(file,"                   Error Matrix available in diagonal approximation only\n\n");
   } else if (gstat==2) {
      fprintf(file,"                   Error Matrix available but forced positive-definite\n\n");
   } else if (gstat==3) {
      fprintf(file,"                   Error Matrix accurate\n\n");
   } else {
      fprintf(file,"                   No information on error matrix accuracy available\n\n");
   }
   fprintf(file, "##################### End of Fit Summary ####################\n");

   if (yyVerbose){
   cout << "closing output file" << endl;
   }
   fclose(file);
}

void Fittino::CalcFromRandPars(unsigned int nruns) {
   if (yyVerbose){
   cout << yyDashedLine << endl;
   cout << "Calcualting Observables from random parameter distribution" << endl;
   }

   TFile *file = new TFile("Observables.root","RECREATE");
   TTree *tree = new TTree("Observables","Observable scatter plots");

   for (unsigned int j=0; j<yyMeasuredVec.size(); j++) {
      tree->Branch(yyMeasuredVec[j].name.c_str(), &(yyMeasuredVec[j].theovalue), (yyMeasuredVec[j].name + "/D").c_str());
   }

   for (unsigned int i=0; i<nruns; i++) {
      //Calculating random parameter vector
      double* RandomParameterVector = GetRandomParameterVector(yyRandomPar);

      //Writing the Les Houches input file
      WriteLesHouches(RandomParameterVector);

      if ( yyCalculatorPath.compare("") ) {
	 if ( access( yyCalculatorPath.c_str(), X_OK ) ) {
	    cerr << "Cannot find calculator " << yyCalculatorPath << endl;
	    cerr << "Check path in input file." << endl;
	    exit(EXIT_FAILURE);
	 }
	 }
	 if( yyDecayCalculatorPath.compare("") ) {
		if( access( yyDecayCalculatorPath.c_str(), X_OK) ) {
			cerr<< "Cannot find DecayCalculator " << yyDecayCalculatorPath << endl;
			cerr<< "Check path in input file." << endl;
			exit(EXIT_FAILURE);
		}
	}
	 //Calling SPheno to calculate observables
	 int rc = 0;
	 Double_t f = 0.;
	 if( yyCalculator == SPHENO ) {
	   rc = callSPheno();
	   if (rc == 2) {
	     if (yyVerbose){
	     cout << "SIGINT received in SPheno, exiting" << endl;
	     }
	     exit (2);
	   }
	   if (rc > 0) {
	     cerr << "Exiting fitterFCN because of problem in SPheno run" << endl;
	     f = 111111111111.;
	     if (yyVerbose){
	     cout << " f = " << f << endl;
	     }
	   }
		 else if( yyCalculator == SUSPECT ) {
	if (yyVerbose){
        cout << "Calling SuSpect and SDecay/HDecay via SUSYHIT" << endl;
	}
        rc = callSUSYHIT();
        if( rc > 0 ) {
          cerr << "Exiting fitterFCN because of problem in SUSYHIT run" << endl;
          f = 111111111111.;
	  if (yyVerbose){
          cout << " f = " << f << endl;
	  }
          return;
        }
      }
	   else if( yyCalculator == SOFTSUSY ) {
	     if( yyFitModel != AMSB && yyFitModel != GMSB && yyFitModel != mSUGRA ) {
	       if (yyVerbose){
	       cout << "SoftSUSY currently works only with AMSB, GMSB and mSUGRA. sorry. " << endl;
	       }
	     }
	     if( yyDecayCalculator != SUSYHIT ) {
	       if (yyVerbose){
	       cout << "SoftSUSY currently works only with SUSYHIT. sorry. " <<endl;
	       }
	       exit(1);
	     }
	     rc = callSoftSusy();
	     if( rc > 0 ) {
	       cerr << "Exiting fitter FCN because of problem in SoftSusy run" << endl;
	       f = 111111111111.;
	       if (yyVerbose){
	       cout << "f = " << f << endl;
	       }
	     }
	     if (yyVerbose){
	     cout << "     SoftSusy finished (Maybe With Problems?). Calling SUSYHIT" << endl;
	     }
			 if( yyDecayCalculator != NONE ) {
	 	  	 rc = callSUSYHIT();
	  	   if( rc > 0 ) {
	      	 cerr << "Exiting fitterFCN because of problem in SUSYHIT run" << endl;
	         f = 111111111111.;
	      	 if (yyVerbose){
	      		 cout << " f = " << f << endl;
	      	 }
	      	 return;
	     	}
			}
			else {
				system( "cp slhaspectrum.in susyhit_slha.out" );
			}
	   }
	   return;        
	 }

      //Reading the Les Houches outputfile
      rc = ReadLesHouches();
      if (yyCalculatorError) {
	 cerr << "Exiting fitterFCN because LesHouches outfile did not exist" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;    
      }
      if (yyParseError) {
	 cerr << "Exiting fitterFCN because of a parse error in yacc" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;
      }
      if (yyNaN) {
	 cerr << "Exiting fitterFCN because of NaN in Les Houches ouput file" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;
      }
      if (yyInfinity) {
	 cerr << "Exiting fitterFCN because of infinity in Les Houches ouput file" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;
      }
      if (rc > 0) {
	 cerr << "Exiting fitterFCN because of return value "<< rc << " from the Calculator" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;
      }
      tree->Fill();
   }
   tree->Print();
   tree->Write();
   delete tree;
   delete file;
}

double* GetRandomParameterVector(const vector<parameter_t>& mean) {
   unsigned int n = mean.size();

   double* fParameterVector = new double [n];
   for (unsigned int i=0; i<n; i++) {
      gRandom->SetSeed(0);
      fParameterVector[i] = gRandom->Gaus(mean[i].value, mean[i].error);
   }
   return fParameterVector;
}

// hamiltonian
//
// calculates hamiltonian for hybrid MC method
//
// P. Wienemann, March 30, 2007
double hamiltonian(int n, double* q, double* p)
{
   int dummyint = 1;
   double dummyfloat = 5;
   double chi2;
   fitterFCN(dummyint, &dummyfloat, chi2, q, 0);

   double p2 = 0;
   for (int i = 0; i < n; i++) {
      p2 += p[i] * p[i];
   }

   return 0.5 * p2 + TMath::Exp(- 0.5 * chi2);
}



// ************************************************************
// fitterFCN
//
// calculates: The chi^2 from the measured values and the predictions
// needs:      all
//
// P. Bechtle, P. Wienemann, 18.09.03
//
// ************************************************************

void fitterFCN(Int_t &, Double_t *, Double_t &f, Double_t *x, Int_t iflag) 
{

  global_LHC_CLb = -1;
  global_LHC_CLsb = -1;
  global_LHC_chi2 = -1;
  global_LHC_Exp_CLb = -1;
  global_LHC_Exp_CLsb = -1;
  global_LHC_Exp_chi2 = -1;

  af_photon=-1;
  af_relic=-1;
  af_svind=-1;
  af_direct=-1;
  af_chi2_total=-1;
  af_chi2_photon=-1;
  af_chi2_relic=-1;
  af_chi2_svind=-1;
  af_chi2_direct=-1;

  globalHiggsChi2=-1;

  //cout<<"fitterFCN called"<<endl;
   //  niterations++;
   int rc = 0;
   int nobs = 0;
   int ncorr = 0;
   int nbound = 0;

   f = 0.;

   // set values
   yySetErrorFlag    = false;
   yyCalculatorError = false;
   yyParseError      = 0;
   yyNaN             = 0;
   yyInfinity        = 0;

   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
      yyMeasuredVec[i].theoset = false;
   }
   // start loop over cross sections and polarisations
   // cout << "having to call Calculator " <<  CrossSectionProduction.size() << " times" << endl; 
   // for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
   // HERE: WRITE THE LES HOUCHES FILE
   //  WriteLesHouches(x);


   //  fitterMassA0.value =  436.2;
   //  fitterMassTop.value = x[6];
   //  fitterMassSelL.value = 262.5;// x[6];
   //  fitterMassSelR.value = 218.6; // x[7];
   //  fitterMassSupL.value = 519.1; // x[8];
   //  fitterMassSupR.value = 429.6; // x[9];
   //  fitterA.value        = -500.0;// x[10];

   WriteLesHouches(x);

   yySPhenoLastCallValid = false;
   //  exit(0);

   if ( yyCalculatorPath.compare("") ) {
     if ( access( yyCalculatorPath.c_str(), X_OK ) ) {
       cerr << "Cannot find calculator " << yyCalculatorPath << endl;
       cerr << "Check path in input file." << endl;
       exit(EXIT_FAILURE);
     }
   }
   if( yyDecayCalculatorPath.compare("") ) {
     if( access( yyDecayCalculatorPath.c_str(), X_OK) ) {
       cerr<< "Cannot find DecayCalculator " << yyDecayCalculatorPath << endl;
       cerr<< "Check path in input file." << endl;
       exit(EXIT_FAILURE);
     }
   }
   
   if (yyCalculator == SUSPECT) {
        if (yyVerbose){
  	cout << "Calling SuSpect and SDecay/HDecay via SUSYHIT" << endl;
	}
      rc = callSUSYHIT();
      if( rc > 0 ) {
        cerr << "Exiting fitterFCN because of problem in SUSYHIT run" << endl;
        f = 111111111111.;
	if (yyVerbose){
        cout << " f = " << f << endl;
	}
        return;
      }	 
   }
   else if (yyCalculator == SPHENO) {
     if (yyVerbose){
     cout << yyDashedLine << endl;
     cout << "Calling SPheno" << endl;
     }
     rc = callSPheno();
     
     if (rc == 2) {
       if (yyVerbose){
       cout << "SIGINT received in SPheno, exiting" << endl;
       }
       exit (2);
     }
     if (rc > 0) {
       cerr << "Exiting fitterFCN because of problem in SPheno run" << endl;
       f = 111111111111.;
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;        
     }

     if (yyFitModel==MSSM){
       ofstream file;
       file.open("SPheno.spc",ios::app);
       file<<"Block MODSEL  # Model selection"<<endl;
       file<<"1    0    # MSSM"<<endl;
       file<<"3    0    # MSSM particle content"<<endl;	
       file.close();
     }
     
     // Some calculators cannot digest non-standard SLHA blocks.
     // If needed, create a spectrum file without SPheno specific blocks.
     // The output file is called SPheno.spc.stdslha
     if (yyHiggsCalculator == FEYNHIGGS) {
       string command = yyAfterBurnerDirectory + "/removeSPhenoBlocks.sh SPheno.spc";
       system(command.c_str());
     }

     if (yyLEOCalculator==NPFITTER){
       string command = yyAfterBurnerDirectory + "/removeSPhenoBlocks.sh SPheno.spc";
       system(command.c_str());
       system ("cp SPheno.spc.stdslha SPheno.spc.stdslha.mastercode");
     }
   }
   else if (yyCalculator == SOFTSUSY) {
     if( yyFitModel != AMSB && yyFitModel != GMSB && yyFitModel != mSUGRA ) {
       if (yyVerbose){
       cout << "FATAL: SOFTSUSY SUPOPRT AT THE MOMENT ONLY FOR  GMSB, AMSB and mSUGRA. " << yyFitModel << " MAY BE AVAILABLE LATER . . . (sorry :( )"<< endl;
       }
       exit(1);
     }
     if (yyDecayCalculator != SUSYHIT && yyDecayCalculator != NONE ) {
       if (yyVerbose){
       cout << "SoftSUSY currently runs only with SUSYHIT. Sorry. " << endl;
       }
       exit(1);
     }
     if (yyVerbose){
     cout << yyDashedLine << endl;
     cout << "Calling SoftSusy" << endl;
     }
     rc = callSoftSusy();
     if( rc > 0 ) {
       cerr << "Exiting fitterFCN because of problem in SoftSusy run" << endl;
       f = 111111111111.;
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;	
     }
     if (yyVerbose){
     cout << "     SoftSusy finished (Maybe With Problems?)." << endl; 
     }
     if( yyDecayCalculator != NONE ) {
			 rc = callSUSYHIT();
 	     if( rc > 0 ) {
    	   cerr << "Exiting fitterFCN because of problem in SUSYHIT run" << endl;
     	  f = 111111111111.;
     	  if (yyVerbose){
      	 cout << " f = " << f << endl;
       	}
       	return;		
     	}
		}
		else {
			system( "cp slhaspectrum.in susyhit_slha.out" );
		}
   }    
   
   if (yyHiggsCalculator == FEYNHIGGS ) {
     if (yyVerbose){
     cout << yyDashedLine << endl;
     cout << "Calling FeynHiggs" << endl;
     }
     rc = callFeynHiggs();
     
     if (rc == 2) {
       if (yyVerbose){
       cout << "SIGINT received in FeynHiggs, exiting" << endl;
       }
       exit (2);
     }
     if (rc > 0) {
       cerr << "Exiting fitterFCN because of problem in FeynHiggs run" << endl;
       f = 111111111111.;
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;        
     }

     // append FeynHiggs block to SPheno.spc file
     string command = yyAfterBurnerDirectory + "/parseFeynHiggs.sh";
     system(command.c_str());


     //TODO: add corresponding lines for softsusy
     //TODO: We loose spheno's mass information here -- do we need to keep it?
     ReplaceMass("SPheno.spc");
     ReplaceBlock("SPheno.spc.stdslha.fh-001.last", "SPheno.spc", "ALPHA");
     ReplaceBlock("SPheno.spc.stdslha.fh-001.last", "SPheno.spc", "HMIX");


     //TODO: This should not depend on the use of hisssignals but on the use of the higgscalculator 
     if (yyUseHiggsSignals){
       ReplaceBlock("SPheno.spc.stdslha.fh-001.last", "SPheno.spc", "HiggsBoundsInputHiggsCouplingsBosons");
       ReplaceBlock("SPheno.spc.stdslha.fh-001.last", "SPheno.spc", "HiggsBoundsInputHiggsCouplingsFermions");
     }

   }



   if (yyUseHDecay){
     
     if (yyVerbose){
       cout<<"Calling HDECAY"<<endl;
     }
     

     hdecayINfile();

     rc=callHDecay();

     if (rc == 2) {
       if (yyVerbose){
       cout << "SIGINT received in HDecay, exiting" << endl;
       }
       exit (2);
     }
     if (rc > 0) {
       cerr << "Exiting fitterFCN because of problem in HDecay" << endl;
       f = 111111111111.;
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;        
     }
	 ReplaceBlock("slha.out", "SPheno.spc", "25");
	 ReplaceBlock("slha.out", "SPheno.spc", "35");
	 ReplaceBlock("slha.out", "SPheno.spc", "36");
	 ReplaceBlock("slha.out", "SPheno.spc", "37");

   }



   if (yyFlavourCalculator == SUPERISO) {
     if (yyVerbose){
     cout << yyDashedLine << endl;
     cout << "Calling SuperIso" << endl;
     }
     rc = callSuperIso();
     
     if (rc == 2) {
       if (yyVerbose){
       cout << "SIGINT received in SuperIso, exiting" << endl;
       }
       exit (2);
     }
     if (rc > 0) {
       cerr << "Exiting fitterFCN because of problem in SuperIso run" << endl;
       f = 111111111111.;
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;        
     }

     // append SuperIso block to SPheno.spc file
     string command = yyAfterBurnerDirectory + "/parseSuperIso.sh";
     system(command.c_str());
   }


   if (yyLEOCalculator == NPFITTER) {
      if (yyVerbose){
      cout << yyDashedLine << endl;
      cout << "Calling NPFitter" << endl;
      }
      rc = callNPFitter();
      if( rc > 0 ) {
	cerr << "Exiting fitterFCN because of problem in NPFITTER run" << endl;
	f = 111111111111.;
	if (yyVerbose){
	cout << " f = " << f << endl;
	}
	return;
      }

     // append PREDICT block to SPheno.spc file
     string command = yyAfterBurnerDirectory + "/parseMastercode.sh";
     system(command.c_str());
   }

   if (yyRelicDensityCalculator == MICROMEGAS) {
      rc = callMicrOmegas(x);
      // disable this, since MicOmegas has the annoying feature of returning 2 if 
      // neutralino1 is not LSP
      // if (rc == 2) {
      //  cout << "SIGINT received in MicrOmegas, exiting" << endl;
      //  exit (2);
      // }    
      if (rc > 0) {
	 cerr << "Exiting fitterFCN because of problem in MicrOmegas run" << endl;
	 f = 111111111111.;
	 if (yyVerbose){
	 cout << " f = " << f << endl;
	 }
	 return;
      }
   }
  
   // HERE: READ THE LES HOUCHES FILE
   rc = ReadLesHouches();
   if (yyCalculatorError) {
      cerr << "Exiting fitterFCN because LesHouches outfile did not exist" << endl;
      f = 111111111111.;
      if (yyVerbose){
      cout << " f = " << f << endl;
      }
      return;    
   }
   if (yyParseError) {
      cerr << "Exiting fitterFCN because of a parse error in yacc" << endl;
      f = 111111111111.;
      if (yyVerbose){
      cout << " f = " << f << endl;
      }
      return;
   }
   if (yyNaN) {
      cerr << "Exiting fitterFCN because of NaN in Les Houches ouput file" << endl;
      f = 111111111111.;
      if (yyVerbose){
      cout << " f = " << f << endl;
      }
      return;
   }
   if (yyInfinity) {
      cerr << "Exiting fitterFCN because of infinity in Les Houches ouput file" << endl;
      f = 111111111111.;
      if (yyVerbose){
      cout << " f = " << f << endl;
      }
      return;
   }
   if (rc > 0) {
      cerr << "Exiting fitterFCN because of return value "<< rc << " from the Calculator" << endl;
      f = 111111111111.;
      if (yyVerbose){
      cout << " f = " << f << endl;
      }
      return;
   }

   if (yySetErrorFlag) {
     cerr << "Exiting fitterFCN because of Syntax Error in the LesHouches File" << endl;
     f = 111111111111.;  
     if (yyVerbose){
     cout << " f = " << f << endl;
     }
     return;  
   }
   yySetErrorFlag = false;

   // find maximum squark or gluino mass
   mSquarkGluinoMax = -1.;
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
     if (yyMeasuredVec[i].name == "massGluino" ||
	 yyMeasuredVec[i].name == "massStop1"  ||
	 yyMeasuredVec[i].name == "massStop2"  ||
	 yyMeasuredVec[i].name == "massSbottom1"  ||
	 yyMeasuredVec[i].name == "massSbottom2"  ||
	 yyMeasuredVec[i].name == "massSupL"  ||
	 yyMeasuredVec[i].name == "massSupR"  ||
	 yyMeasuredVec[i].name == "massSdownL"  ||
	 yyMeasuredVec[i].name == "massSdownR" 	 ) {
       if (yyMeasuredVec[i].theovalue>mSquarkGluinoMax) {
	 mSquarkGluinoMax = yyMeasuredVec[i].theovalue;
       }
     }
   }   
   // find stop quark masses
   double thisMStop1 = -1.;
   double thisMStop2 = -1.;
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
     if ( yyMeasuredVec[i].name == "massStop1" ) {
       thisMStop1 = yyMeasuredVec[i].theovalue;
       break;
     }
   }   
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
     if ( yyMeasuredVec[i].name == "massStop2" ) {
       thisMStop2 = yyMeasuredVec[i].theovalue;
       break;
     }
   }   
   if (thisMStop1 < 0. || thisMStop2 < 0.) {
     cout << "mStop1 or mStop2 not found" << endl;
     f = 111111111111.;
     return;
   }
   double thisMmean = TMath::Sqrt(thisMStop1*thisMStop2);

   // Check whether QEWSB is within bounds
   if (mSquarkGluinoMax>0.) {
     if (FindInFitted("QEWSB")) {
       if (yyVerbose){
       cout << "QEWSB found fitted = " << x[ReturnFittedPosition("QEWSB")] << endl;
       }
       if ( x[ReturnFittedPosition("QEWSB")] < 0.5*thisMmean || 
	    x[ReturnFittedPosition("QEWSB")] > 2.0*thisMmean ) {
	 if (yyVerbose){
	   cout << "QEWSB out of dynamic bounds " << endl;
	 }
	 f = 111111111111.;
	 if (yyVerbose){
	   cout << " f = " << f << endl;
	 }
	 return;
       }
     } 
     else if (FindInUniversality("QEWSB")) {
       if (yyVerbose){
       cout << "QEWSB found in universality = " << ReturnUniversality("QEWSB")->universality << endl;
       }
       if ( x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)] < 0.5*thisMmean ||
	    x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)] > 2.0*thisMmean ) {
	 if (yyVerbose){
	   cout << "QEWSB universality out of dynamic bounds " << endl;
	 }
	 f = 111111111111.; 
	 if (yyVerbose){
	   cout << " f = " << f << endl;
	 }
	 return;
       }
     }    
   }  

   if (yyRequireNeut1LSP) {
     // search for particle masses
     double massNeut1 = -1.;
     double massChar1 = -1.;
     double massSlepL = -1.;
     double massSlepR = -1.;
     double massStau1 = -1.;
     for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
       if (yyMeasuredVec[i].name == "massNeutralino1") {
	 massNeut1 = yyMeasuredVec[i].theovalue;
       }
       if (yyMeasuredVec[i].name == "massChargino1") {
	 massChar1 = yyMeasuredVec[i].theovalue;
       }
       if (yyMeasuredVec[i].name == "massSelectronL") {
	 massSlepL = yyMeasuredVec[i].theovalue;
       }
       if (yyMeasuredVec[i].name == "massSelectronR") {
	 massSlepR = yyMeasuredVec[i].theovalue;
       }
       if (yyMeasuredVec[i].name == "massStau1") {
	 massStau1 = yyMeasuredVec[i].theovalue;
       }
     }
     // check the masses
     //cout << "masses of lightest sparticles " << massNeut1 << " " << massChar1 << " " << massSlepL << " " << massSlepR << " " << massStau1 << endl;
     if (massNeut1<0.) {
       if (yyVerbose){
       cout << "WARNING: RequireNeut1LSP set but no neutralino1 mass among the observables" << endl;
       }
     } else if (massChar1<0. && massSlepL<0. && massSlepR<0. && massStau1<0.) {
       if (yyVerbose){
       cout << "WARNING: RequireNeut1LSP set but no selectron, chargino and stau masses among the observables" << endl;
       }
     } else if ( (massNeut1>massChar1 && massChar1>0.) || 
		 (massNeut1>massSlepL && massSlepL>0.) || 
		 (massNeut1>massSlepR && massSlepR>0.) || 
		 (massNeut1>massStau1 && massStau1>0.) ) {
       if (yyVerbose){
       cout << "Neut1 is not the LSP" << endl;
       }
       f = 111111111111.;  
       if (yyVerbose){
       cout << " f = " << f << endl;
       }
       return;  
     }
   }

   yySPhenoLastCallValid = true;
   // end loop over crosssections and polarisations:
   //  }

   // Higgsbounds
   double higgsChisqContribution = 0.;
   #ifdef USELIBHB

   if ( yyUseHiggsBounds == 1 ) {

     higgsChisqContribution = call_HiggsBoundsWithSLHA();
     if (higgsChisqContribution<0) {
       f += 111111111111.;  
     }
     f+= higgsChisqContribution;
     if (yyVerbose) {
       cout << "adding " << higgsChisqContribution << " to the chi2 due to the Higgs limits"<< endl;
     }

   }


//      if (yyVerbose){
//      cout << yyDashedLine << endl;
//      cout << "Starting HiggsBounds" << endl;
//      }
//
//      int nH = 3;
//      int HBresult = 0;
//      HBresult = call_HiggsBounds( nH, x );
//
//      yySetErrorFlag = false;
//
//      if ( HBresult == 0 ) {
//
//         cerr << "Scenario excluded by HiggsBounds" << endl;
//         excl++;
//
//	 if (yyVerbose){
//         cout << "Starting scan for limit of lightest higgs mass" << endl;
//	 }
//   
//         double higgsMassLimit = ScanForHiggsLimit( nH, x );
//
//         for ( unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
//
//            if ( yyMeasuredVec[i].name == "Massh0_npf" ||
//		 yyMeasuredVec[i].name == "massh0" ) {
//
//               yyMeasuredVec[i].bound_low = higgsMassLimit;
//
//            }
//
//         }
//         if (yyVerbose){
//         cout << "Scan terminated" << endl;
//         cout << "Changed higgs mass limit to > " << higgsMassLimit << " GeV in list of observables" << endl;
//	 }
//
//      }
//      if ( HBresult == 1 ) {
//
//         cerr << "Scenario accepted by HiggsBounds" << endl;
//	 nexcl++;
//
//      }
//      if ( HBresult == 2 ) {
//
//	 f = 111111111111.;
//
//      }
//      if ( yyVerbose ) {
//
//	 if (yyVerbose){
//         cout << "Already excluded: " << excl << endl;
//         cout << "Not excluded: " << nexcl << endl;
//	 }
//
//      }
//      if (yyVerbose){
//      cout << "Ending HiggsBounds" << endl;
//      }
//   }

   #endif


   if (yyUseHiggsSignals){
     system("cp SPheno.spc.last SPheno.spc.last.1");
     system((yyHiggsSignalsPath+" 1 SPheno.spc.last").c_str());
     //TODO: read in chi2, add it, save it in ntuple


   }



   // HERE: FIND OBSERVABLES BELONGING TO THE MEASUREMENTS IN yyMeasuredVec
   // CALCULATE CHISQ
   n_printouts++;
   if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) {
      cout << yyDashedLine << endl;
      cout << "Calculating chisq" << endl;
   }
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {

      for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {

         //    cout << "looking at "<< yyMeasuredVec[i].name << endl;
         if ((yyMeasuredVec[i].theoset && yyMeasuredVec[j].theoset) && (!yyMeasuredVec[i].nofit && !yyMeasuredVec[j].nofit )
              && (!yyMeasuredVec[i].temp_nofit && !yyMeasuredVec[j].temp_nofit ) ) {

            // cout << "theo ist set" << endl;
            if ((yyMeasuredVec[i].error > 0.) && (yyMeasuredVec[j].error > 0.) && !yyMeasuredVec[j].bound ) {

               // find corresponding measurement for prediction... 
               f += (yyMeasuredVec[i].theovalue-yyMeasuredVec[i].value)
       	         * yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j)
       	         * (yyMeasuredVec[j].theovalue-yyMeasuredVec[j].value);

               if ( (i==j) && (yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j) > 1.E-12) ) {

       	          nobs++;

               }
               else if (yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j) > 1.E-12) {

       	          ncorr++;
               }
               if ( i == j && ( (yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j)>1.E-12) ||
       			(yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j)<-1.E-12) ) ) {

       	          // cout << (float)n_printouts/100. << " " << n_printouts/101 << endl;
       	          if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) {

       	             cout << i << " " << j << " using obs " << yyMeasuredVec[i].name << " = " << yyMeasuredVec[i].value
       		          << "+-" << sqrt(yyMeasuredCorrelationMatrix.GetCovariance(i,j))
       		          << " (" << (TMath::Abs(yyMeasuredVec[i].value-yyMeasuredVec[i].theovalue))*sqrt(yyMeasuredCorrelationMatrix.GetInverseCovariance(i,j)) << ") "
                          << "\t at theovalue = "
       		          << yyMeasuredVec[i].theovalue<< endl;
       	          }
               }
            }
            else if ( yyMeasuredVec[j].bound ) {

               if ( i == j ) {

		 if ( (yyUseHiggsBounds == 1) && 
		      (yyMeasuredVec[i].name == "Massh0_npf" ||
		       yyMeasuredVec[i].name == "massh0") ) {
		   cout << i << " using lower bound on " << yyMeasuredVec[i].name << " at " << yyMeasuredVec[i].bound_low << " > " << yyMeasuredVec[i].theovalue << " Sqrt (chi2 contribution) " << TMath::Sqrt(higgsChisqContribution) <<  endl;
		 }
		 else {
		   
		   
		   if ( yyMeasuredVec[i].theovalue<yyMeasuredVec[i].bound_low ) {
		     
       	             f += sqr( ( yyMeasuredVec[i].theovalue-yyMeasuredVec[i].value )/yyMeasuredVec[i].error );
       	             cout << i << " using lower bound on " << yyMeasuredVec[i].name << " at " << yyMeasuredVec[i].bound_low << " > " << yyMeasuredVec[i].theovalue << endl;
		     
		   }

		   else if ( yyMeasuredVec[i].theovalue>yyMeasuredVec[i].bound_up ) {
		     f += sqr((yyMeasuredVec[i].theovalue-yyMeasuredVec[i].value)/(yyMeasuredVec[i].error));
       	             cout << i << " using upper bound on " << yyMeasuredVec[i].name << " at " << yyMeasuredVec[i].bound_up << " < " <<  yyMeasuredVec[i].theovalue << endl;
		   }

		   else if (yyVerbose ) {
		     cout<< i << " NOT using lower bound on " << yyMeasuredVec[i].name << " at " << yyMeasuredVec[i].bound_low << " < " << yyMeasuredVec[i].theovalue << endl;
		     cout << i << " NOT using upper bound on " << yyMeasuredVec[i].name << " at " << yyMeasuredVec[i].bound_up << " > " <<  yyMeasuredVec[i].theovalue << endl;
		   }

		 
		 }
		 
		 nbound++;

               }

            }

         }

      }

   }


   //ASTROFIT

   if (yyUseAstroFit) {
     if (yyVerbose){
     cout << "chi2 without AstroFit = " << f << endl;
     }
     f += readAstroFit();
     if (yyVerbose){
     cout << "chi2 with AstroFit = " << f << endl;
     }
   }


   if (yyUseXsecLimits) {
     double M0;
     if (yyFitModel == NONUNIVSIMPLIFIED) {
       if (FindInFixed("M05")) {
	 M0 = ReturnFixedValue("M05")->value;
       }
       else if (FindInFitted("M05")) {
	 M0 = x[ReturnFittedPosition("M05")];
       }
       else if (FindInRandomPar("M05")) {
	 M0 = x[ReturnRandomPosition("M05")];
       }
     } else {
       if (FindInFixed("M0")) {
	 M0 = ReturnFixedValue("M0")->value;
       }
       else if (FindInFitted("M0")) {
	 M0 = x[ReturnFittedPosition("M0")];
       }
       else if (FindInRandomPar("M0")) {
	 M0 = x[ReturnRandomPosition("M0")];
       }
     }
     double M12;
     if (yyFitModel == NONUNIVSIMPLIFIED) {
       if (FindInFixed("M1")) {
	 M12 = ReturnFixedValue("M1")->value;
       }
       else if (FindInFitted("M1")) {
	 M12 = x[ReturnFittedPosition("M1")];
       }
       else if (FindInRandomPar("M1")) {
	 M12 = x[ReturnRandomPosition("M1")];
       }
     } else {
       if (FindInFixed("M12")) {
	 M12 = ReturnFixedValue("M12")->value;
       }
       else if (FindInFitted("M12")) {
	 M12 = x[ReturnFittedPosition("M12")];
       }
       else if (FindInRandomPar("M12")) {
	 M12 = x[ReturnRandomPosition("M12")];
       }
     }
     const int binmax = 3;
     TH1D* hsig = new TH1D("hsig", "", binmax, 0, 3);
     bool interpolationOK = true;
     bool noGridPoint = false;
     for (int bin=1; bin<=binmax; bin++) {
       const double binContent = BilinearInterpolator(M0, M12, bin, signalXsec);
       if (binContent<0.) {
	 interpolationOK = false;
	 if (binContent<-999.) {
	   noGridPoint = false;
	 }
	 else if (binContent<-0.5) {
	   noGridPoint = true;
	 }
       } else {
	 hsig->SetBinContent(bin, binContent*yyLumi);
       }       
     }
     
     double xsintegral;
     
     double CLsb;
     double CLb;
     double ObsCLsb;
     double ObsCLb;
     
     double xschi2;
     double xschi2Exp;
     
     cout << " >>> THE INTERPOLATION IS " << interpolationOK << endl;

     if (interpolationOK) {
       const int ntrials = 20000;
       int bestSignalRegion = -1;
       double bestExpCLsb      = 1000.;
       double bestExpCLb       = 1000.;
       // loop over the three bins
       for (int signalRegionNumber = 0; signalRegionNumber<binmax; ++signalRegionNumber) {
	 // create new histograms
	 TH1D* thisSig = new TH1D("thisSig","thisSig",1,0,1);
	 TH1D* thisBkg = new TH1D("thisBkg","thisBkg",1,0,1);
	 // copy the Bin contents
	 thisSig->SetBinContent(1,hsig->GetBinContent(signalRegionNumber+1));
	 thisBkg->SetBinContent(1,hbkgd->GetBinContent(signalRegionNumber+1));
	 double array_lnQb[ntrials];
	 double array_lnQsb[ntrials];
	 for (int itrial=0; itrial<ntrials; itrial++) {
	   double lnQsb = LogLikelihoodRatio(thisSig, thisBkg, thisBkg,
					     yyRelativeSignalCrossSectionSysUncertainty,
					     yyRelativeBackgroundCrossSectionSysUncertainty, "sb");
	   double lnQb = LogLikelihoodRatio(thisSig, thisBkg, thisBkg, 
					    yyRelativeSignalCrossSectionSysUncertainty,
					    yyRelativeBackgroundCrossSectionSysUncertainty, "b");
	   
	   array_lnQb[itrial] = lnQb;
	   array_lnQsb[itrial] = lnQsb;
	   
	 }

	 int array_index[ntrials];
	 
//	 for (int itrial=0; itrial<ntrials; itrial++) {
//	   cout << "before trial No. " <<  itrial << " " << array_lnQb[itrial] << endl;
//	 }

	 TMath::Sort(ntrials, array_lnQb, array_index, kFALSE);

//	 for (int itrial=0; itrial<ntrials; itrial++) {
//	   cout << "after  trial No. " <<  itrial << " " << array_lnQb[array_index[itrial]] << endl;
//	 }

	 int median_pos = int(ntrials * 0.5 + 0.5);
	 
	 double median_lnQb = array_lnQb[ array_index[ median_pos ] ];
	 
	 //	 cout << "median pos = " << median_pos << " median = " << median_lnQb << endl;

	 // Asimov data set (data = bkgd only)
	 //       double lnQdata = LogLikelihoodRatio(hsig, hbkgd, hbkgd, 
	 //					   yyRelativeSignalCrossSectionSysUncertainty,
	 //					   yyRelativeBackgroundCrossSectionSysUncertainty, 
	 //					   "expected_b");
	 
	 double lnQdata = median_lnQb;
	 //     std::cout << "lnQdata = " << lnQdata << std::endl;
	 
	 int nCLsb = 0;
	 int nCLb = 0;
	 for (int itrial=0; itrial<ntrials; itrial++) {
	   double lnQb = array_lnQb[itrial];
	   double lnQsb = array_lnQsb[itrial];
	   
	   if (lnQsb < lnQdata) {
	     nCLsb++;
	   }
	   if (lnQb < lnQdata) {
	     nCLb++;
	   }
	 }

	 //	 xsintegral = hsig->Integral();
	 
	 CLsb = double(nCLsb) / (double)ntrials;
	 CLb = double(nCLb) / (double)ntrials;
	 
	 if (CLsb<bestExpCLsb) {
	   bestExpCLsb = CLsb;
	   bestExpCLb  = CLb;
	   bestSignalRegion = signalRegionNumber;
	 }

	 thisSig->Delete();
	 thisBkg->Delete();

       }
       // now calculate observed limit 
       TH1D* thisSig = new TH1D("thisSig","thisSig",1,0,1);
       TH1D* thisBkg = new TH1D("thisBkg","thisBkg",1,0,1);
       TH1D* thisDat = new TH1D("thisDat","thisBkg",1,0,1);
       // copy the Bin contents
       thisSig->SetBinContent(1,hsig->GetBinContent(bestSignalRegion+1));
       thisBkg->SetBinContent(1,hbkgd->GetBinContent(bestSignalRegion+1));
       thisDat->SetBinContent(1,hdata->GetBinContent(bestSignalRegion+1));
       double array_lnQb[ntrials];
       double array_lnQsb[ntrials];
       double lnQdata = LogLikelihoodRatio(thisSig, thisBkg, thisDat,
					   yyRelativeSignalCrossSectionSysUncertainty,
					   yyRelativeBackgroundCrossSectionSysUncertainty, "data");
       for (int itrial=0; itrial<ntrials; itrial++) {
	 double lnQsb = LogLikelihoodRatio(thisSig, thisBkg, thisDat,
					   yyRelativeSignalCrossSectionSysUncertainty,
					   yyRelativeBackgroundCrossSectionSysUncertainty, "sb");
	 double lnQb = LogLikelihoodRatio(thisSig, thisBkg, thisDat,
					  yyRelativeSignalCrossSectionSysUncertainty,
					  yyRelativeBackgroundCrossSectionSysUncertainty, "b");
	 
	 array_lnQb[itrial] = lnQb;
	 array_lnQsb[itrial] = lnQsb;
	 
       }

       //int array_index[ntrials];
       
       //TMath::Sort(ntrials, array_lnQb, array_index, kFALSE);
       
       //int median_pos = int(ntrials * 0.5 + 0.5);
       
       //double median_lnQb = array_lnQb[ array_index[ median_pos ] ];
       
       //	 double lnQdata = median_lnQb;
       //     std::cout << "lnQdata = " << lnQdata << std::endl;
       
       int nCLsb = 0;
       int nCLb = 0;
       for (int itrial=0; itrial<ntrials; itrial++) {
	 double lnQb = array_lnQb[itrial];
	 double lnQsb = array_lnQsb[itrial];
	 
	 if (lnQsb < lnQdata) {
	   nCLsb++;
	 }
	 if (lnQb < lnQdata) {
	   nCLb++;
	 }
       }
       
       xsintegral = hsig->Integral();
       
       ObsCLsb = double(nCLsb) / (double)ntrials;
       ObsCLb = double(nCLb) / (double)ntrials;
       
       thisSig->Delete();
       thisBkg->Delete();
       thisDat->Delete();
       
       if (ObsCLsb>0.) {
	 xschi2 = 2. * TMath::ErfInverse(1. - 2.*ObsCLsb) * TMath::ErfInverse(1. - 2.*ObsCLsb);
       } else {
	 xschi2 = 100.;
       }
       if (bestExpCLsb>0.) {
	 xschi2Exp = 2. * TMath::ErfInverse(1. - 2.*bestExpCLsb) * TMath::ErfInverse(1. - 2.*bestExpCLsb);
       } else {
	 xschi2Exp = 100.;
       }

       global_LHC_CLb  = ObsCLb;
       global_LHC_CLsb = ObsCLsb;
       global_LHC_Exp_CLsb = bestExpCLsb;
       global_LHC_Exp_CLb  = bestExpCLb;
       if (xschi2<0.) global_LHC_chi2 = 1000.;
       else global_LHC_chi2 = xschi2;
       if (xschi2Exp<0.) global_LHC_Exp_chi2 = 1000.;
       else global_LHC_Exp_chi2 = xschi2Exp ;
       // Be careful: The following will not work if we have real data!!!!!
       //       if (global_LHC_CLsb>0.5) global_LHC_chi2 = 0.;

       
       
     } else {
       if (noGridPoint) {
	 xsintegral = 0.;
	 global_LHC_CLb = 0.5;
	 global_LHC_CLsb = 0.5;
	 global_LHC_chi2 = 0.;	 
	 global_LHC_Exp_CLb = 0.5;
	 global_LHC_Exp_CLsb = 0.5;
	 global_LHC_Exp_chi2 = 0.;	 
       } else {
	 xsintegral = 10000.;
	 global_LHC_CLb = 0.5;
	 global_LHC_CLsb = 0.0;
	 global_LHC_chi2 = 1000.;	 	 
	 global_LHC_Exp_CLb = 0.5;
	 global_LHC_Exp_CLsb = 0.0;
	 global_LHC_Exp_chi2 = 1000.;	 
       }
     }

     hsig->Delete();


     // check whether parameter point is out-of-bounds
     // WARNING: TMath::ErfInverse(1) returns 0, not infinity
//     if (xs < 0 && xs > -10) {
//       xschi2 = 0;
//     }
//     else if (xs < -10) {
//       xschi2 = 8e88;
//     }

     if (yyVerbose) {
       std::cout << "**********************************************************" << endl;
       std::cout << "**********************************************************" << endl;
       std::cout << "LHC cross-section at M0 = " 
		 << M0 << " GeV, M12 = " << M12 << " GeV is " 
		 << xsintegral/yyLumi << " fb " << std::endl;

       std::cout << "    CLsb = " << global_LHC_CLsb     << "     CLb = " << global_LHC_CLb     << "     chi2 = " << global_LHC_chi2<<  std::endl;
       std::cout << "Exp CLsb = " << global_LHC_Exp_CLsb << " Exp CLb = " << global_LHC_Exp_CLb << " Exp chi2 = " << global_LHC_Exp_chi2<<  std::endl;
       
       std::cout << "Parameter point";
       if (global_LHC_CLsb > 0.05) std::cout << " not";
       std::cout << " excluded at 95 % CL" << std::endl;
       
       std::cout << "chi2 contribution from LHC cross-section = " << global_LHC_chi2 << std::endl;
       std::cout << "Sqrt(chi2) contribution from LHC cross-section = " << TMath::Sqrt(global_LHC_chi2) << std::endl;
       std::cout << "**********************************************************" << endl;
       std::cout << "**********************************************************" << endl;
     }
     
     if (yyLumi==dataDefaultLumi) {
       //cout << "using obs chi2" << endl;
       f += global_LHC_chi2;
     } else {
       //cout << "using exp chi2" << endl;
       f += global_LHC_Exp_chi2;
     }


   }


   if (yyVerbose){
   cout << " chisq = " << f << " with " << nobs << " observables (" << ncorr/2 << " correlated), "
        << yyFittedVec.size() << " parameters and " << nbound << " bounds" << endl;
   }

   //  f = ( sqr(sRecMassChargino1-fMassChargino1)/sqr(fMassChargino1.error)
   //	+ sqr(sRecMassChargino2-fMassChargino2)/sqr(fMassChargino2.error)
   //	+ sqr(sRecMassNeutralino1-fMassNeutralino1)/sqr(fMassNeutralino1.error)
   //	+ sqr(sRecMassNeutralino2-fMassNeutralino2)/sqr(fMassNeutralino2.error)
   //	+ sqr(sRecMassGluino-fMassGluino)/sqr(fMassGluino.error)
   //	+ sqr(sRecCos2PhiR-fCos2PhiR)/sqr(fCos2PhiR.error)
   //	+ sqr(sRecCos2PhiL-fCos2PhiL)/sqr(fCos2PhiL.error)
   //	+ sqr(sRecMassh0-fMassh0)/sqr(fMassh0.error)
   //	+ sqr(sRecMassA0-fMassA0)/sqr(fMassA0.error)
   //	+ sqr(sRecMassTop-fMassTop)/sqr(fMassTop.error)
   //	); 

  if ((!(f<0.))&&(!(f>=0.))) {
    f = 111111111111.;
    if (yyVerbose){
    cout << "detected nan!" << endl;
    }
  }

   if (iflag == 10) {
      parameter_t tmpchisq;
      // write individual chisq contributions of each observable to global variable
      for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
	 if ((yyMeasuredVec[i].theoset ) && (!yyMeasuredVec[i].nofit )
	       && (!yyMeasuredVec[i].temp_nofit ) ) {
	    if ((yyMeasuredVec[i].error > 0.) ) {
	       tmpchisq.name = yyMeasuredVec[i].name;
	       tmpchisq.value = sqr(yyMeasuredVec[i].theovalue-yyMeasuredVec[i].value)
		  * yyMeasuredCorrelationMatrix.GetInverseCovariance(i,i);
	       tmpchisq.error = yyMeasuredVec[i].alias;
	       indchisq_vec.push_back(tmpchisq);
	       //	  cout << "Ind Delta Chisq = " << tmpchisq.value << endl;
	    }
	 }
      }
   }

   if (iflag == 20) {
      // do not use the fitted observables, just test for NANs
      f = sRecMassChargino1 + sRecMassChargino2 + sRecMassNeutralino1 + sRecMassNeutralino2 +
	 sRecMassA0 + sRecMassh0 + sRecMassGluino + sRecCos2PhiL + sRecCos2PhiR;
      if ((!(f<0.))&&(!(f>=0.))) {
	 f = 1.E99;
	 if (yyVerbose){
	 cout << "detected nan in return!" << endl;
	 }
      }
   }

   //cout << "f = " << f << endl;

   return;
} 

int callMicrOmegas (double* x)
{

   int rc;

   if (yyVerbose){
   cout << "Using relic density calculator MicrOmegas" << endl;
   }

   char cwd[1024];
   if (getcwd(cwd, sizeof(cwd)) == NULL) {
     perror("getcwd() error");
   }

   int pid = -2;
   int status = 0;
   int child_pid = 0;
   // printf("Process %d about to fork a child.\n", parent_pid  );

   /*
    * Get a child process.
    */
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);
      /* NOTE: perror() produces a short  error  message  on  the  standard
	 error describing the last error encountered during a call to
	 a system or library function.
	 */
   }

   if (pid == 0) {
      /*
       * The child executes the code inside this if.
       */
      child_pid = getpid();
      char* argv[4];

      argv[0] = new char[1024];
      strcpy(argv[0], yyRelicDensityCalculatorPath.c_str());

      argv[1] = new char[1024];
      strcpy(argv[1], cwd);
      if( yyCalculator == SOFTSUSY ) {
				strcat(argv[1], "/susyhit_slha.out.stdslha" );
			}
			else {
				strcat(argv[1], "/SPheno.spc.stdslha");
			}

      argv[2] = new char[1024];
      strcpy(argv[2], cwd);
      if( yyCalculator == SOFTSUSY ) {
				strcat(argv[2], "/susyhit_slha.out");
			}
			else {
				strcat(argv[2], "/SPheno.spc");
			}

      argv[3] = 0;

      if (yyVerbose){
	cout << "calling " << argv[0] << " " << argv[1] << " " << argv[2] << std::endl; 
      }
      rc = execve(argv[0], argv, environ);
      if (yyVerbose){
      cout << "returning from execve "<< rc<< endl;
      }
      exit (rc);
   }
   else {
      /*
       * The parent executes this
       */
      int spheno_counter = 0;
      while (1) {
	 spheno_counter++;
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)spheno_counter/10. ) {
	    printf("killing child process %d due to too much time\n",pid);
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
      // while (waitpid (-1, &status, 0) != pid) {
      //   sleep (2);
      //   printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
      // }
   }

   rc = WEXITSTATUS(status);
   if (yyVerbose){
   cout << "MicrOmegas returned with return value " << rc << endl;
   }

   if (rc == 0) {
     //      system ("mv SPheno.spc.saved_fittino SPheno.spc");
     // system ("cp SPheno.spc.saved_fittino SPheno.spc");
   }
   return rc;
}

// ************************************************************
// callNPFitter
//
// calculates: The low energy observables as predicted by NPFitter
// needs:      all
//
// P. Bechtle, M. Uhlenbrock, P. Wienemann, 14.03.08
//
// ************************************************************

int callNPFitter() {

   int return_value;

   int pid = -2;
   int status = 0;
   int child_pid = 0;
   //cout << "Process " << parent_pid << " about to fork a child" << endl;

   // Get a child process.
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);

      // NOTE: perror() produces a short  error  message  on  the  standard
      // error describing the last error encountered during a call to
      // a system or library function.
   }

   if (pid == 0) {

      // The child executes the code inside this if.
      child_pid = getpid();
      char *argv[3];
      argv[0] = "NPFitter";
      if( yyCalculator == SPHENO ) {
				argv[1] = "SPheno.spc.stdslha.mastercode";
      }
			else if( yyCalculator == SOFTSUSY ) {
				argv[1] = "susyhit_slha.out";
				std::cout << "not tested: using softsusy with mastercode!" << std::endl;
			}
			else if( yyCalculator == SUSPECT ) {
				argv[1] = "susyhit_slha.out";
				std::cout << "not tested: using suspect with mastercode!" << std::endl;
			}
			argv[2] = 0;
      if (fopen("SPheno.spc.stdslha.mastercode", "r") == NULL) {
	 cout << "File SPheno.spc.stdslha.mastercode cannot be found" << endl;
      }
      // cout << "Process " << parent_pid << " has forked a child process with pid " << child_pid << endl;
      if (!yyLEOCalculatorPath.compare("")) {
	 return_value = execve("./NPFitter", argv, environ );
      }
      else {
	 return_value = execve(yyLEOCalculatorPath.c_str(), argv, environ );
      }
      exit (return_value);

   }
   else {
      // The parent executes this
      int npfitter_counter = 0;
      while (1) {
	 npfitter_counter++;
	 // cout << "Waiting for NPFitter with status = " << status << " and pid = " << pid << endl;
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    // cout << "child process finished, status = " << WEXITSTATUS(status) << endl;
	    // sleep (1);
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)npfitter_counter/10. ) {
	    cout << "Killing child process " << pid << " due to too much time" << endl;
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
   }

   return_value = WEXITSTATUS(status);
   if (yyVerbose){
   cout << "NPFitter returned with return value " << return_value << endl;
   }

   if (return_value > 0) {
      return(return_value);
   }

   return 0;

}


double readAstroFit()
{

  int return_value;
  char* argv[3];
  argv[0] = new char[1024];
  strcpy(argv[0], yyAstroCalculatorPath.c_str());
  return_value = system(argv[0]);
  ifstream file_to_read;
  file_to_read.open("afout.txt");

  if (!file_to_read.is_open()) {
    cerr << "error opening afout.txt" << endl;
    exit(EXIT_FAILURE);
  }


  string line;
  
  while (  getline(file_to_read, line)){
    vector<string> words= split(line, ' ');

    if (words[0]=="chi2_relic") af_chi2_relic=atof(words[1].c_str());
    if (words[0]=="chi2_photon")af_chi2_photon=atof(words[1].c_str());
    if (words[0]=="chi2_svind") af_chi2_svind=atof(words[1].c_str());
    if (words[0]=="chi2_direct") af_chi2_direct=atof(words[1].c_str());
    if (words[0]=="relic") af_relic=atof(words[1].c_str());
    if (words[0]=="photon") af_photon=atof(words[1].c_str());
    if (words[0]=="svind") af_svind=atof(words[1].c_str());
    if (words[0]=="direct") af_direct=atof(words[1].c_str());

  }
    
  af_chi2_total=0;

  if (yyUseAFrelic){
    if (af_chi2_relic<0 || af_relic<0){
      cout<<"FATAL ERROR IN AF/DARKSUSY. EXIT!"<<endl;
      exit(2);
    }
    if (yyVerbose) cout<<"using obs af_relic ("<<TMath::Sqrt(af_chi2_relic)<<") at theovalue="<<af_relic<<endl;
    af_chi2_total+=af_chi2_relic;
  }

  if (yyUseAFphoton){
    if (af_chi2_photon<0 || af_photon<0){
      cout<<"FATAL ERROR IN AF/DARKSUSY. EXIT!"<<endl;
      exit(2);
    }
    if (yyVerbose) cout<<"using obs af_photon ("<<TMath::Sqrt(af_chi2_photon)<<") at theovalue="<<af_photon<<endl;
    af_chi2_total+=af_chi2_photon;    
  }

  if (yyUseAFsvind){
    if (af_chi2_svind<0 || af_svind<0){
      cout<<"FATAL ERROR IN AF/DARKSUSY. EXIT!"<<endl;
      exit(2);
    }
    if (yyVerbose) cout<<"using obs af_svind ("<<TMath::Sqrt(af_chi2_svind)<<") at theovalue="<<af_svind<<endl;
    af_chi2_total+=af_chi2_svind;    
  }

  if (yyUseAFdirect){
    if (af_chi2_direct<0 || af_direct<0){
      cout<<"FATAL ERROR IN AF/DARKSUSY. EXIT!"<<endl;
      exit(2);
    }
    if (yyVerbose) cout<<"using obs af_direct ("<<TMath::Sqrt(af_chi2_direct)<<") at theovalue="<<af_direct<<endl;
    af_chi2_total+=af_chi2_direct; 
  }

  system("mv afout.last.txt  afout.last2.txt");
  system("mv afout.txt  afout.last.txt");
  return af_chi2_total;

}



double higgsLimit ()
{
   double higgsLimit = 0.;

   // get masses
   //double mh = yyMass[ID_h];
   //double mA = yyMass[ID_A];

   // get BR
   vector<int> daughter_list;
   daughter_list.push_back(ID_b);
   daughter_list.push_back(-ID_b);
   double higgsToBB = higgsBR(ID_h,daughter_list);
   daughter_list.clear();
   daughter_list.push_back(ID_tau);
   daughter_list.push_back(-ID_tau);
   //double higgsToTauTau = higgsBR(ID_h,daughter_list);  

   daughter_list.clear();
   daughter_list.push_back(ID_A);
   daughter_list.push_back(-ID_A);
   //double higgsToAA = higgsBR(ID_h,daughter_list);

   daughter_list.clear();
   daughter_list.push_back(ID_b);
   daughter_list.push_back(-ID_b);
   double AToBB = higgsBR(ID_A,daughter_list);
   daughter_list.clear();
   daughter_list.push_back(ID_tau);
   daughter_list.push_back(-ID_tau);
   //double AToTauTau = higgsBR(ID_A,daughter_list);  

   // calculate scaling factors  
   vector<double> sf(higgsLimitProcessesLast);
   sf[Zh_Zbb] = yygSquaredZh * higgsToBB;
   sf[Ah_bbbb] = yygSquaredAh * higgsToBB * AToBB;

   return higgsLimit;
}

//int higgsFindBestExpectedLimit(vector<double> sf, double mh, double mA) {
//  int best = 0;
//
//
//  return best;
//}
//
//double higgsLimitRatio(int process, double sf, double mh, double mA, int exp) {
//
//  double ration = 0.;
//
//  
//
//  //  higgsS95[process][exp][mh][mA]
//
//  
//
//  
//  return ratio;
//}


double higgsBR(int id, vector<int> daughter_list) {
   double br = 0.;
   vector<int> used_products;
   bool already_used = false;
   unsigned int found_prod = 0;
   for (unsigned int i = 0; 1; i++ ) { // loop over all Higgs BR
      if (give_br(id, i, 1) == 0) break;
      for (unsigned int j = 0; j < (2+give_br(id, i, 1)); j++ ) { // loop over all entries in one BR line
	 for (unsigned int k = 0; k < daughter_list.size(); k++ ) {
	    for (unsigned int n=0;n< used_products.size();n++) {
	       if ((int)k==used_products[n]) {
		  already_used = true;
		  break;
	       }
	    }
	    if (already_used) {
	       already_used = false;
	       continue;
	    }
	    if (TMath::Abs(daughter_list[k])==TMath::Abs(give_br(id, i, j))) {
	       used_products.push_back(k);
	       found_prod++;
	       break;
	    }
	 }
      }
      if (found_prod == daughter_list.size()) {
	 br = give_br(id, i, 0);
	 break;
      }
   }
   return br;
}
// This Function writes the SUSYHIT InputFile

int WriteSUSYHITInputFile(int SpecCalc) {
	system("rm susyhit.in");
  ofstream susyhit_in("susyhit.in", ios::out);
  if( !susyhit_in ) {
    return 1006;
  }
  susyhit_in << "* SUspect-SdecaY-Hdecay-InTerface options:" << endl;
  susyhit_in << "------------------------------------------" << endl;
  susyhit_in << "  (1) link SuSpect-Sdecay-Hdecay and take the input parameters from SuSpect" << endl;
  susyhit_in << "  (2) link Sdecay-Hdecay, not SuSpect, take the input parameters from any SLHA" << endl;
  susyhit_in << "      input, called slhaspectrum.in " << endl;
  susyhit_in << SpecCalc << endl;
  susyhit_in << "* Choice of the output, SLHA format (1) or simple (0):" << endl;
  susyhit_in << "------------------------------------------------------" << endl;
  susyhit_in << "1" << endl;
  susyhit_in << "* HDECAY input parameters:" << endl;
  susyhit_in << "--------------------------" << endl;
  susyhit_in << "MSBAR(1) = 0.190D0" << endl;
  susyhit_in << "MC       = 1.40D0" << endl;
  susyhit_in << "MMUON    = 0.105658389D0" << endl;
  susyhit_in << "1/ALPHA  = 137.0359895D0" << endl;
  susyhit_in << "GAMW     = 2.080D0" << endl;
  susyhit_in << "GAMZ     = 2.490D0" << endl;
  susyhit_in << "VUS      = 0.2205D0" << endl;
  susyhit_in << "VCB      = 0.04D0" << endl;
  susyhit_in << "VUB/VCB  = 0.08D0" << endl;

  susyhit_in.close();

  if( SpecCalc == 1 ) {
    system("cp LesHouches.in suspect2_lha.in");
    fstream suspect_in("suspect2_lha.in", ios::out | ios::app );
      suspect_in << "Block SU_ALGO  # !Optional SUSPECT v>=2.3* block: algorithm control parameters" << endl;
      suspect_in << "# !IF block absent (or if any parameter undefined), defaut values are taken" << endl;
      suspect_in << "     2    21  # 2-loop RGE (defaut, 1-loop RGE is: 11 instead)" << endl;
      suspect_in << "     3    1   # 1: g_1(gut) = g_2(gut) consistently calculated from input" << endl;
      suspect_in << "#   (other possibility is 0: High scale input =HIGH in block EXTPAR below)" << endl;
      suspect_in << "     4    2   # RGE accuracy: 1: moderate, 2: accurate (but slower)  " <<endl;
      suspect_in << "     6    1   #  1: M_Hu, M_Hd input (default in constrained models)" << endl;
      suspect_in << "#        (other possibility 0: MA_pole, MU(EWSB) input instead) "<< endl;
      suspect_in << "     7    2   #  choice for sparticles masses rad. corr. (=/= h): "<< endl;
      suspect_in << "#               2 ->all (recommended, defaut); 1->no R.C. in squarks & gauginos." << endl;
      suspect_in << "     8    0   # 1 (defaut): EWSB scale=(mt_L*mt_R)^(1/2) "<< endl;
      suspect_in << "#         (Or = 0: arbitrary EWSB scale: give EWSB in Block EXTPAR below) " <<endl;
      suspect_in << "     9    2   # Final spectrum accuracy: 1 -> 1% acc.; 2 -> 0.01 % acc.(defaut) "<< endl;
      suspect_in << "     10   2   # Higgs boson masses rad. corr. calculation options:  " <<endl;
      suspect_in << "#             A simple (but very good) approximation (advantage=fast)  : 0 " << endl;
      suspect_in << "#             Full one-loop calculation                                : 1 " <<endl;
      suspect_in << "#             One-loop  + dominant DSVZ 2-loop (defaut,recommended)    : 2 " << endl;
      suspect_in << "     11   0   # Higher order Higgs 'scheme' choice in rad. corr. at mZ: " << endl;
      suspect_in << "#          RUNNING DRbar Higgs masses at loop-level at mZ (defaut)    : 0 " << endl;
      suspect_in << "#          POLE          Higgs masses at loop-level at mZ             : 1 " << endl;
      suspect_in << "Block EXTPAR" << endl;
      suspect_in << "     0 1000.0" << endl;
    suspect_in.close();
  }
  return 0;

}

// This Function calls SUSYHIT - only used when yyCalculator == SOFTSUSY


int callSUSYHIT() {
	if( yyCalculator == SOFTSUSY ) {
    if( WriteSUSYHITInputFile(2) > 0 ) {
      return 1005;
    }
  }
  else if ( yyCalculator == SUSPECT ) {
    if( WriteSUSYHITInputFile(1) > 0 ) {
      return 1005;
    }
  }
	int return_value;
	int pid = -2;
	int status = 0;
	int child_pid = 0;

	if( (pid = fork()) < 0 ) {
		perror("fork");
		exit(1);
	}
	if( pid == 0 ) {
		child_pid = getpid();
		char *argv[2];
		argv[0] = "SUSYHIT";
		argv[1] = 0;
		if ( !yyDecayCalculatorPath.compare("")) {	
			return_value = execve("./SUSYHIT", argv, environ);
		}
		else {
			return_value = execve(yyDecayCalculatorPath.c_str(), argv, environ );
		}
		exit(return_value);
	}
	else {
		int SUSYHIT_counter = 0;
		while(1) {
			SUSYHIT_counter++;
			if(waitpid( pid, &status, WNOHANG) == pid ) {
				break;
			}
			if( yyMaxCalculatorTime < (float)SUSYHIT_counter/10. ) {
				printf("killing childprocess %d due to too much time\n", pid);
				kill(pid, 9);
				waitpid( -1, &status, 0);
				return(1);
			}
			usleep(100000);
		}
	}
	return_value= WEXITSTATUS(status);
  if (yyVerbose){
  cout << "SUSYHIT returned with return value " << return_value << endl;
  }
  if( return_value > 0 ) {
    return(return_value);
  }
  return 0;
}
//Call SoftSusy here
int callSoftSusy() {
	int return_value;
	int pid = -2;
	int status = 0;
	int child_pid = 0;
	
	if( (pid = fork()) < 0 ) {
		perror("fork");
		exit(1);
	}

	if( pid == 0 ) {
		child_pid = getpid();
		char *argv[3];
		argv[0] = "softpoint.x";
		argv[1] = "leshouches";
		argv[2] = 0;
		
		freopen("LesHouches.in","r", stdin);
		freopen("slhaspectrum.in", "w+", stdout);
		if( !yyCalculatorPath.compare("")) {
			return_value = execve("./softpoint.x", argv, environ );
		}
		else {
			return_value = execve(yyCalculatorPath.c_str(), argv, environ );
		}
		exit(return_value);
	}
	else {
		int softsusy_counter = 0;
		while(1) { 
			softsusy_counter++;
			if(waitpid( pid, &status, WNOHANG) == pid ) {
				break;
			}
			if( yyMaxCalculatorTime < (float)softsusy_counter/10. ) {
				printf("killing childprocess %d due to too much time\n",pid);
				kill( pid, 9);
				waitpid(-1, &status, 0);
				return(1);
			}
			usleep(100000);
		}
	}
	return_value= WEXITSTATUS(status);
	if (yyVerbose){
	cout << "softsusy returned with return value " << return_value << endl;
	}
	if( return_value > 0 ) {
		return(return_value);
	}
	return 0;
}
// ************************************************************
// callSPheno
//
// calculates: The spectrum as predicted by SPheno
// needs:      all
//
// P. Bechtle, P. Wienemann, 18.09.03
//
// ************************************************************
int callSPheno() 
{
   int return_value;
   // char programname[1024];

   //  FILE * SPheno;
   //  SPheno = popen("./SPheno", "r"); 
   //  pclose (SPheno);


   int pid = -2;
   int status = 0;
   int child_pid = 0;
   // printf("Process %d about to fork a child.\n", parent_pid  );

   /*
    * Get a child process.
    */
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);
      /* NOTE: perror() produces a short  error  message  on  the  standard
	 error describing the last error encountered during a call to
	 a system or library function.
	 */
   }

   if (pid == 0) {
      /*
       * The child executes the code inside this if.
       */
      child_pid = getpid();
      char *argv[2];
      argv[0] = "SPheno";
      argv[1] = 0;
      // printf("Process %d has forked a child process with pid %d\n", parent_pid, child_pid  );
      if (!yyCalculatorPath.compare("")) {
	 // return_value = system("./SPheno");
	 return_value = execve("./SPheno", argv, environ );
      }
      else {
	 return_value = execve(yyCalculatorPath.c_str(), argv, environ );
	 // return_value = system(yyCalculatorPath.c_str());
      }
      //    for ( unsigned int i = 0; i < 5; i++ ) {
      //      sleep (1);
      //      cout << "child is doing nothing but making noise..." << endl;
      //    }
      //    return_value = 250;
      //    sleep (15);
      exit (return_value);
   }
   else {
      /*
       * The parent executes this
       */
      int spheno_counter = 0;
      while (1) {
	 spheno_counter++;
	 //      printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    // printf("child process finished, status = %d\n", WEXITSTATUS(status));
	    // sleep (1);
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)spheno_counter/10. ) {
	    printf("killing child process %d due to too much time\n",pid);
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
      // while (waitpid (-1, &status, 0) != pid) {
      //   sleep (2);
      //   printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
      // }
   }

   return_value = WEXITSTATUS(status);
   if (yyVerbose){
   cout << "SPheno returned with return value " << return_value << endl;
   }


   //  if (!yyCalculatorPath.compare(""))
   //    return_value = system("./SPheno");
   //  //    strcpy(programname,"./SPheno");
   //  // return_value = checkcall(programname,20);
   //  else
   //    return_value = system(yyCalculatorPath.c_str());
   if (return_value > 0) {
      return(return_value);
   }

   return 0;

}

// ************************************************************
// callFeynHiggs
// ************************************************************
int callFeynHiggs() 
{
   int return_value;

   int pid = -2;
   int status = 0;
   int child_pid = 0;
   // printf("Process %d about to fork a child.\n", parent_pid  );

   /*
    * Get a child process.
    */
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);
      /* NOTE: perror() produces a short  error  message  on  the  standard
	 error describing the last error encountered during a call to
	 a system or library function.
	 */
   }

   if (pid == 0) {
      /*
       * The child executes the code inside this if.
       */
     
      child_pid = getpid();
      char *argv[3];
      argv[0] = "FeynHiggs";
      if( yyCalculator == SOFTSUSY ) {
				system( "cp susyhit_slha.out susyhit_slha.out.stdslha");
				argv[1] = "susyhit_slha.out.stdslha";
			}
			else {
				argv[1] = "SPheno.spc.stdslha";
      }
      argv[2] = 0;

      // prevent FeynHiggs from calling pager
      char *locenviron[2];

      if (yyVerbose) locenviron[0]="PAGER=cat";
      else locenviron[0]="PAGER=''";
      locenviron[1]=(char *)0;
      
      // printf("Process %d has forked a child process with pid %d\n", parent_pid, child_pid  );
      if (!yyHiggsCalculatorPath.compare("")) {
	cout << "calling FeynHiggs 1" << endl;
	return_value = execve("./FeynHiggs", argv, locenviron );
	cout << "returning from FeynHiggs 1" << endl;
      }
      else {
	cout << "calling FeynHiggs 2" << endl;
	return_value = execve(yyHiggsCalculatorPath.c_str(), argv, locenviron );
	cout << "returning from FeynHiggs 2" << endl;
      }
      //    for ( unsigned int i = 0; i < 5; i++ ) {
      //      sleep (1);
      //      cout << "child is doing nothing but making noise..." << endl;
      //    }
      //    return_value = 250;
      //    sleep (15);
      //system("ls -lrt");
      exit (return_value);
   }
   else {
      /*
       * The parent executes this
       */
      int spheno_counter = 0;
      while (1) {
	 spheno_counter++;
	 //      printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    // printf("child process finished, status = %d\n", WEXITSTATUS(status));
	    // sleep (1);
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)spheno_counter/10. ) {
	    printf("killing child process %d due to too much time\n",pid);
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
      // while (waitpid (-1, &status, 0) != pid) {
      //   sleep (2);
      //   printf("waiting for FeynHiggs with status = %d and pid = %d\n",status, pid);
      // }
   }

   return_value = WEXITSTATUS(status);
   if (yyVerbose){
     cout << "FeynHiggs returned with return value " << return_value << endl;
   }


   if (return_value > 0) {
      return(return_value);
   }

//check file

   if( yyCalculator == SOFTSUSY ) {
	fstream filestr;
        filestr.open("./susyhit_slha.out.stdslha.fh-001");
        if(filestr.is_open())
        {
                filestr.close();
                return 0;
        }
        else    return 3;
   }

        fstream filestrr;
        filestrr.open("./SPheno.spc.stdslha.fh-001");
        if(filestrr.is_open())   
        {       
                filestrr.close();
                return 0;
        }
        else    return 3;


   return 0;

}



// ************************************************************
// callSuperIso
// ************************************************************
int callSuperIso() 
{
   int return_value;

   int pid = -2;
   int status = 0;
   int child_pid = 0;
   // printf("Process %d about to fork a child.\n", parent_pid  );

   /*
    * Get a child process.
    */
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);
      /* NOTE: perror() produces a short  error  message  on  the  standard
	 error describing the last error encountered during a call to
	 a system or library function.
	 */
   }

   if (pid == 0) {
      /*
       * The child executes the code inside this if.
       */
     
      child_pid = getpid();
      char *argv[3];
      argv[0] = "slha.x";
      if( yyCalculator == SOFTSUSY ) {
				argv[1] = "susyhit_slha.out";
			}
			else {
				argv[1] = "SPheno.spc";
      }
			argv[2] = 0;

      // printf("Process %d has forked a child process with pid %d\n", parent_pid, child_pid  );
      if (!yyFlavourCalculatorPath.compare("")) {
	 return_value = execve("./slha.x", argv, environ );
      }
      else {
	 return_value = execve(yyFlavourCalculatorPath.c_str(), argv, environ );
      }
      //    for ( unsigned int i = 0; i < 5; i++ ) {
      //      sleep (1);
      //      cout << "child is doing nothing but making noise..." << endl;
      //    }
      //    return_value = 250;
      //    sleep (15);
      exit (return_value);
   }
   else {
      /*
       * The parent executes this
       */
      int spheno_counter = 0;
      while (1) {
	 spheno_counter++;
	 //      printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    // printf("child process finished, status = %d\n", WEXITSTATUS(status));
	    // sleep (1);
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)spheno_counter/10. ) {
	    printf("killing child process %d due to too much time\n",pid);
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
      // while (waitpid (-1, &status, 0) != pid) {
      //   sleep (2);
      //   printf("waiting for FeynHiggs with status = %d and pid = %d\n",status, pid);
      // }
   }

   return_value = WEXITSTATUS(status);
   if (yyVerbose){
     cout << "SuperIso returned with return value " << return_value << endl;
   }


   if (return_value > 0) {
      return(return_value);
   }

   return 0;

}


int callHDecay() 
{
   int return_value;

   int pid = -2;
   int status = 0;
   int child_pid = 0;
   // printf("Process %d about to fork a child.\n", parent_pid  );

   /*
    * Get a child process.
    */
   if ((pid = fork()) < 0) {
      perror("fork");
      exit(1);
      /* NOTE: perror() produces a short  error  message  on  the  standard
	 error describing the last error encountered during a call to
	 a system or library function.
	 */
   }

   if (pid == 0) {
      /*
       * The child executes the code inside this if.
       */
     
      child_pid = getpid();
      char *argv[3];
      argv[0] = "hdecay";
      if( yyCalculator == SOFTSUSY ) {
	system("cp susyhit_slha.out slha.in");
      }
      else {
	system("cp SPheno.spc slha.in");
      }
      argv[1] = 0;
      argv[2] = 0;

      // printf("Process %d has forked a child process with pid %d\n", parent_pid, child_pid  );
      if (!yyHiggsBRCalculatorPath.compare("")) {
	 return_value = execve("./hdecay", argv, environ );
      }
      else {
	 return_value = execve(yyHiggsBRCalculatorPath.c_str(), argv, environ );
      }
      //    for ( unsigned int i = 0; i < 5; i++ ) {
      //      sleep (1);
      //      cout << "child is doing nothing but making noise..." << endl;
      //    }
      //    return_value = 250;
      //    sleep (15);
      exit (return_value);
   }
   else {
      /*
       * The parent executes this
       */
      int spheno_counter = 0;
      while (1) {
	 spheno_counter++;
	 //      printf("waiting for SPheno with status = %d and pid = %d\n",status, pid);
	 if (waitpid (pid, &status, WNOHANG) == pid) {
	    // printf("child process finished, status = %d\n", WEXITSTATUS(status));
	    // sleep (1);
	    break;
	 } 
	 if ( yyMaxCalculatorTime < (float)spheno_counter/10. ) {
	    printf("killing child process %d due to too much time\n",pid);
	    kill (pid, 9);
	    waitpid (-1, &status, 0);
	    return(1);
	 }
	 usleep (100000);
      }
      // while (waitpid (-1, &status, 0) != pid) {
      //   sleep (2);
      //   printf("waiting for FeynHiggs with status = %d and pid = %d\n",status, pid);
      // }
   }

   return_value = WEXITSTATUS(status);
   if (yyVerbose){
     cout << "HDecay returned with return value " << return_value << endl;
   }


   if (return_value > 0) {
      return(return_value);
   }

   return 0;

}



// ************************************************************
// checkcall
//
// performs:   fork of SPheno, check of runtime of SPheno
// needs:      all
//
// P. Bechtle, P. Wienemann, 21.10.04
//
// ************************************************************
int checkcall(char* programpath, unsigned int runtime) 
{
   int rc;

   // preliminary: do nothing
   rc = system (programpath);
   return rc;

}

// ************************************************************
// callSuspect
//
// calculates: The spectrum as predicted by SUSPECT
// needs:      all
//
// P. Bechtle, P. Wienemann, 18.09.03
//
// ************************************************************

void callSuspect() 
{

   // ==================================================
   // This is for Tests with SUSPECT:
   //  int imodel = 0; // 0: arbitrary soft terms at low scale
   //  int iinput = 0; // 0: ma,mu as input; 1: v_1^2, v_2^2 as input
   //  double vintb = fitterTanBeta;
   //  double vinmu = fitterMu;
   //  double vinma = fitterMassA0;
   //  double vinm[3];
   //  double vinmsl = fitterMassSelL;
   //  double vinmstaur = fitterMassSelR;
   //  double vinmsq = fitterMassSupL;
   //  double vinmtr = fitterMassSupR;
   //  double vina = fitterA;
   //  double suspect_mchip[2];
   //  double suspect_mchi0[4];
   //  double suspect_u[2][2];
   //  double suspect_vv[2][2];
   //  double suspect_z[4][4];
   //  double suspect_xmn[4];
   //  double suspect_mgl;
   //  double suspect_mh[4];
   //  double vinmt = fitterMassTop;
   //
   //  double PhiR,PhiL;
   //
   //  vinm[0] = fitterM1;
   //  vinm[1] = fitterM2;
   //  vinm[2] = fitterAbsM3;
   //
   //  //cout << "fitterMassA0 " << fitterMassA0 << endl;
   //
   //  // cout << "calling suspect" << endl;
   //  call_suspect_free_(&imodel,&iinput,&vintb,&vinmu,&vinma,
   //		    vinm,&vinmsl,&vinmstaur,&vinmsq,&vinmtr,&vina,&vinmt);
   //
   //  // cout << "getting parameters from suspect" << endl;
   //  get_suspect_(suspect_mchip,suspect_mchi0,&suspect_mgl,suspect_mh,suspect_u,suspect_vv,suspect_z,suspect_xmn);
   //
   //  sRecMassChargino1 = suspect_mchip[0];
   //  sRecMassChargino2 = suspect_mchip[1];
   //  sRecMassNeutralino1 = suspect_mchi0[0];
   //  sRecMassNeutralino2 = suspect_mchi0[1];
   //  sRecMassNeutralino3 = suspect_mchi0[2];
   //  sRecMassNeutralino4 = suspect_mchi0[3];
   //  sRecMassGluino = suspect_mgl;
   //  sRecMassh0 = suspect_mh[0];
   //  sRecMassH0 = suspect_mh[1];
   //  sRecMassA0 = suspect_mh[2];
   //  sRecMassHpm = suspect_mh[3];
   //  PhiL = TMath::ACos(suspect_u[1][1]);
   //  PhiR = TMath::ACos(suspect_vv[1][1]);
   //  sRecCos2PhiL = TMath::Cos(2.*PhiL);
   //  sRecCos2PhiR = TMath::Cos(2.*PhiR);
   //  sRecMassTop = fitterMassTop;
   // cout << "PhiL,PhiR: " << PhiL << " " << PhiR << endl;

   //  cout <<  "suspect_mchip[0]" << suspect_mchip[0] << endl;
   // cout << sRecMassChargino1 << endl;
   //  cout << sRecMassChargino2 << endl;
   //  cout << sRecMassNeutralino1 << endl;
   //  cout << sRecMassNeutralino2 << endl;
   //  cout << sRecMassNeutralino3 << endl;
   //  cout << sRecMassNeutralino4 << endl;
   //  cout << sRecMassGluino << endl;
   //  cout << sRecMassh0 << endl;
   //  cout << sRecMassH0 << endl;
   //  cout << sRecMassA0 << endl;
   //  cout << sRecMassHpm << endl;
   //    cout << sRecCos2PhiL << endl;
   //    cout << sRecCos2PhiR << endl;



   // ==================================================

}

// ************************************************************
// WriteLesHouches
//
// calculates: nothing
// needs:      x, yyFittedVec
//
// P. Bechtle, P. Wienemann, 06.02.04
//
// ************************************************************
void WriteLesHouches(double* x) 
{
   double local_mu, local_tanb;
   //cout <<"Openning file LesHouches.in"<< endl;
   // open file LesHouches.in
   fstream LesHouchesOutfile;
   LesHouchesOutfile.open ("LesHouches.in",ofstream::out);
   LesHouchesOutfile.setf(ios::scientific, ios::floatfield);

   if (!LesHouchesOutfile.is_open()) {
      cerr << "error opening LesHouches.in" << endl;
      exit(EXIT_FAILURE);
   }

   if (yyFitModel == MSSM || yyFitModel == NMSSM) {

      if (FindInFixed("Mu")) {
	 local_mu = ReturnFixedValue("Mu")->value;
      }    
      else if (FindInFitted("Mu")) {
	 local_mu = x[ReturnFittedPosition("Mu")];
      } 
      else if (FindInUniversality("Mu")) {
	 local_mu = x[ReturnFittedPosition(ReturnUniversality("Mu")->universality)];
      }
      if (FindInFixed("TanBeta")) {
	 local_tanb = ReturnFixedValue("TanBeta")->value;
      }    
      else if (FindInFitted("TanBeta")) {
	 local_tanb = x[ReturnFittedPosition("TanBeta")];
      } 
      else if (FindInUniversality("TanBeta")) {
	 local_tanb = x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)];
      }
      //  cout << "writeLesHouches: local_tanb = "<< local_tanb << endl;
      //  cout << "writeLesHouches: local_mu = "<< local_mu << endl;

      LesHouchesOutfile << "BLOCK MODSEL" << endl;
      if (yyFitModel == MSSM) {
	 LesHouchesOutfile << "    1  0 # General MSSM " << endl;
	 LesHouchesOutfile << "    3  0 # MSSM particle content" << endl;}
      else if (yyFitModel == NMSSM) 
	 LesHouchesOutfile << "    3  1 # NMSSM particle content" << endl;

      if (FindInFixed("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
      }
      else if (FindInFitted("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    
	    cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	    
	 }
      } 
      else if (FindInUniversality("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	 }
      }      
      /*
			else {
	LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
      }
      */
      LesHouchesOutfile << "BLOCK SMINPUTS" << endl;
      if (FindInFixed("alphaem")) {
	 LesHouchesOutfile << "    1 "<<ReturnFixedValue("alphaem")->value<<" # 1/alpha_em (fixed)"<<endl;
      }
      else if (FindInFitted("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition("alphaem")]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	 }
      } 
      else if (FindInUniversality("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fiting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    1  "<<ReturnMeasuredValue("alphaem")->value<<" # 1/alpha_em(M_Z) (fixed)"<<endl;
      }

      if (FindInFixed("G_F")) {
         LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
      }
      else if (FindInFitted("G_F")) {
         LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
         if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
            cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
         }
      } 
      else if (FindInUniversality("G_F")) {
         LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
         if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
            cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
         }
      }
      else {
         LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value <<" # G_F"<<endl;
      }

      if (FindInFixed("alphas")) {
	 LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }
      else if (FindInFitted("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	 }
      } 
      else if (FindInUniversality("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }


      if (FindInFixed("massZ")) {
	 LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }
      else if (FindInFitted("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	 }
      } 
      else if (FindInUniversality("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }

      if (FindInFixed("massBottom")) {
	 LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }
      else if (FindInFitted("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	 }
      } 
      else if (FindInUniversality("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }


      if (FindInFixed("massTop")) {
	 LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }
      else if (FindInFitted("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mTop " << x[ReturnFittedPosition("massTop")] << endl;
	 }
      } 
      else if (FindInUniversality("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }

      if (FindInFixed("massTau")) {
	 LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }
      else if (FindInFitted("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
      } 
      else if (FindInUniversality("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }


      if (FindInFixed("massCharm")) {
	LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }
      else if (FindInFitted("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	}
      } 
      else if (FindInUniversality("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	}
      }
      else {
	LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }


      // MINPAR
      LesHouchesOutfile << "BLOCK MINPAR" << endl;
      if (FindInFixed("TanBeta")) {
	 LesHouchesOutfile << "    3  " << ReturnFixedValue("TanBeta")->value << " # TanBeta (fixed)" << endl;
      }
      else if (FindInFitted("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting TanBeta " << x[ReturnFittedPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition("TanBeta")] << " # TanBeta" << endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random TanBeta " << x[ReturnRandomPosition("TanBeta")] << "(deviation from mean value " << yyFittedPar[2].value <<" within " << TMath::Ceil(TMath::Abs(x[ReturnRandomPosition("TanBeta")]-yyFittedPar[2].value)/yyFittedPar[2].error) << " sigma)"<<endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("TanBeta")] << " # TanBeta (random)" << endl;
      }
      else if (FindInUniversality("TanBeta")) {
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)] << " # TanBeta" << endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	 }
      }
      else {
	 cerr << "e-Parameter TanBeta not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // EXTPAR
      LesHouchesOutfile << "BLOCK EXTPAR" << endl;
      //    LesHouchesOutfile << "BLOCK MSOFT" << endl;
      LesHouchesOutfile << "    0  1000. # Input scale for mSUGRA" << endl;
      if (FindInFixed("M1")) {
	 LesHouchesOutfile << "    1  "<< ReturnFixedValue("M1")->value <<" # M1 (fixed)"<< endl;
      }    
      else if (FindInFitted("M1")) {
	 LesHouchesOutfile << "    1  "<< x[ReturnFittedPosition("M1")]<<" # M1"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M1 " << x[ReturnFittedPosition("M1")] << endl;
	 }
      } 
      else if (FindInRandomPar("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M1 " << x[ReturnRandomPosition("M1")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnRandomPosition("M1")] << " # M1 (random)" << endl;
      }
      else if (FindInUniversality("M1")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("M1")->universality)]<<" # M1"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting " << ReturnUniversality("M1")->universality << " instead of M1" << endl;
	 }
      }
      else {
	 cerr << "Parameter M1 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("M2")) {
	 LesHouchesOutfile << "    2  "<< ReturnFixedValue("M2")->value <<" # M2 (fixed)"<< endl;
      }    
      else if (FindInFitted("M2")) {
	 LesHouchesOutfile << "    2  "<< x[ReturnFittedPosition("M2")]<<" # M2"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M2 " << x[ReturnFittedPosition("M2")] << endl;
	 }
      }
      else if (FindInRandomPar("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M2 " << x[ReturnRandomPosition("M2")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnRandomPosition("M2")] << " # M2 (random)" << endl;
      }
      else if (FindInUniversality("M2")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("M2")->universality)]<<" # M2"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M2")->universality << " instead of M2" << endl;
	 }
      }
      else {
	 cerr << "Parameter M2 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("M3")) {
	 LesHouchesOutfile << "    3  "<< ReturnFixedValue("M3")->value <<" # M3 (fixed)"<< endl;
      }    
      else if (FindInFitted("M3")) {
	 LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("M3")]<<" # M3"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M3 " << x[ReturnFittedPosition("M3")] << endl;
	 }
      }
      else if (FindInRandomPar("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M3 " << x[ReturnRandomPosition("M3")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("M3")] << " # M3 (random)" << endl;
      }
      else if (FindInUniversality("M3")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("M3")->universality)]<<" # M3"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M3")->universality << " instead of M3" << endl;
	 }
      }
      else {
	 cerr << "Parameter M3 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      //Writing Atop in LesHouches... First the program will try to find Xtop in "yyFittedPar", "yyFixedPar", etc... and if it finds Xtop
      //then it will calculate Atop out of it. If Atop is declared instead of Xtop, then Atop will be directly given
      if (FindInFixed("Xtop")) {
	 LesHouchesOutfile << "   11  "<< ReturnFixedValue("Xtop")->value+local_mu/local_tanb <<" # Atop (fixed)"<< endl;
      }    
      else if (FindInFitted("Xtop")) {
	 LesHouchesOutfile << "   11  "<< x[ReturnFittedPosition("Xtop")]+local_mu/local_tanb<<" # Atop"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Xtop " << x[ReturnFittedPosition("Xtop")] << endl;
	 }
      } 
      else if (FindInRandomPar("Xtop")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Xtop " << x[ReturnRandomPosition("Xtop")] << endl;
	 }
	 LesHouchesOutfile << "   11  " << x[ReturnRandomPosition("Xtop")] << " # Xtop (random)" << endl;
      }
      else if (FindInUniversality("Xtop")) {
	 LesHouchesOutfile << "   11  "<<x[ReturnFittedPosition(ReturnUniversality("Xtop")->universality)]+local_mu/local_tanb<<" # Atop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Xtop")->universality << " instead of Xtop" << endl;
	 }
      }
      else if (FindInFixed("Atop")) {
	 LesHouchesOutfile << "   11  "<< ReturnFixedValue("Atop")->value <<" # Atop (fixed)"<< endl;
      }    
      else if (FindInFitted("Atop")) {
	 LesHouchesOutfile << "   11  "<< x[ReturnFittedPosition("Atop")] <<" # Atop"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Atop " << x[ReturnFittedPosition("Atop")] << endl;
	 }
      }   
      else if (FindInRandomPar("Atop")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Atop " << x[ReturnRandomPosition("Atop")] << endl;
	 }
	 LesHouchesOutfile << "   11  " << x[ReturnRandomPosition("Atop")] << " # Atop (random)" << endl;
      }
      else if (FindInUniversality("Atop")) {
	 LesHouchesOutfile << "   11  "<<x[ReturnFittedPosition(ReturnUniversality("Atop")->universality)] <<" # Atop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Atop")->universality << " instead of Atop" << endl;
	 }
      }
      else {
	 cerr << "Neither parameter Xtop nor Atop declared" << endl;
	 exit (EXIT_FAILURE);
      }
      
      //Same for X/A bottom
      if (FindInFixed("Xbottom")) {
	 LesHouchesOutfile << "   12  "<< ReturnFixedValue("Xbottom")->value+local_mu/local_tanb <<" # Abottom (fixed)"<< endl;
      }    
      else if (FindInFitted("Xbottom")) {
	 LesHouchesOutfile << "   12  "<< x[ReturnFittedPosition("Xbottom")]+local_mu/local_tanb<<" # Abottom"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Xbottom " << x[ReturnFittedPosition("Xbottom")] << endl;
	 }
      } 
      else if (FindInRandomPar("Xbottom")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Xbottom " << x[ReturnRandomPosition("Xbottom")] << endl;
	 }
	 LesHouchesOutfile << "   12  " << x[ReturnRandomPosition("Xbottom")] << " # Xbottom (random)" << endl;
      }
      else if (FindInUniversality("Xbottom")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("Xbottom")->universality)]+local_mu/local_tanb<<" # Abottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Xbottom")->universality << " instead of Xbottom" << endl;
	 }
      }
      else if (FindInFixed("Abottom")) {
	 LesHouchesOutfile << "   12  "<< ReturnFixedValue("Abottom")->value <<" # Abottom (fixed)"<< endl;
      }    
      else if (FindInFitted("Abottom")) {
	 LesHouchesOutfile << "   12  "<< x[ReturnFittedPosition("Abottom")] <<" # Abottom"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Abottom " << x[ReturnFittedPosition("Abottom")] << endl;
	 }
      }   
      else if (FindInRandomPar("Abottom")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Abottom " << x[ReturnRandomPosition("Abottom")] << endl;
	 }
	 LesHouchesOutfile << "   12  " << x[ReturnRandomPosition("Abottom")] << " # Abottom (random)" << endl;
      }
      else if (FindInUniversality("Abottom")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("Abottom")->universality)] <<" # Abottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Abottom")->universality << " instead of Abottom" << endl;
	 }
      }
      else {
	 cerr << "Neither parameter Xbottom nor Abottom declared" << endl;
	 exit (EXIT_FAILURE);
      }
      
      //Same for X/A tau
      if (FindInFixed("Xtau")) {
	 LesHouchesOutfile << "   13  "<< ReturnFixedValue("Xtau")->value+local_mu*local_tanb <<" # Atau (fixed)"<< endl;
      }    
      else if (FindInFitted("Xtau")) {
	 LesHouchesOutfile << "   13  "<< x[ReturnFittedPosition("Xtau")]+local_mu*local_tanb<<" # Atau"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Xtau " << x[ReturnFittedPosition("Xtau")] << endl;
	 }
      }  
      else if (FindInRandomPar("Xtau")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Xtau " << x[ReturnRandomPosition("Xtau")] << endl;
	 }
	 LesHouchesOutfile << "   13  " << x[ReturnRandomPosition("Xtau")] << " # Xtau (random)" << endl;
      }
      else if (FindInUniversality("Xtau")) {
	 LesHouchesOutfile << "   13  "<<x[ReturnFittedPosition(ReturnUniversality("Xtau")->universality)]+local_mu*local_tanb<<" # Atau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Xtau")->universality << " instead of Xtau" << endl;
	 }
      }
      else if (FindInFixed("Atau")) {
	 LesHouchesOutfile << "   13  "<< ReturnFixedValue("Atau")->value <<" # Atau (fixed)"<< endl;
      }    
      else if (FindInFitted("Atau")) {
	 LesHouchesOutfile << "   13  "<< x[ReturnFittedPosition("Atau")] <<" # Atau"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Atau " << x[ReturnFittedPosition("Atau")] << endl;
	 }
      }  
      else if (FindInRandomPar("Atau")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Atau " << x[ReturnRandomPosition("Atau")] << endl;
	 }
	 LesHouchesOutfile << "   13  " << x[ReturnRandomPosition("Atau")] << " # Atau (random)" << endl;
      }
      else if (FindInUniversality("Atau")) {
	 LesHouchesOutfile << "   13  "<<x[ReturnFittedPosition(ReturnUniversality("Atau")->universality)] <<" # Atau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Atau")->universality << " instead of Atau" << endl;
	 }
      }
      else {
	 cerr << "Neither parameter Xtau nor Atau declared" << endl;
	 exit (EXIT_FAILURE);
      }


      if (FindInFixed("Mu")) {
	 LesHouchesOutfile << "   23  "<< ReturnFixedValue("Mu")->value <<" # mu (fixed)"<< endl;
      }    
      else if (FindInFitted("Mu")) {
	 LesHouchesOutfile << "   23  "<< x[ReturnFittedPosition("Mu")]<<" # mu"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Mu " << x[ReturnFittedPosition("Mu")] << endl;
	 }
      } 
      else if (FindInRandomPar("Mu")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Mu " << x[ReturnRandomPosition("Mu")] << endl;
	 }
	 LesHouchesOutfile << "   23  " << x[ReturnRandomPosition("Mu")] << " # Mu (random)" << endl;
      }
      else if (FindInUniversality("Mu")) {
	 LesHouchesOutfile << "   23  "<<x[ReturnFittedPosition(ReturnUniversality("Mu")->universality)]<<" # Mu"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Mu")->universality << " instead of Mu" << endl;
	 }
      }
      else {
	 cerr << "Parameter Mu not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if ( yyFitModel != NMSSM ) {
	 if (FindInFixed("massA0")) {
	    if( yyCalculator == SOFTSUSY ) {
				LesHouchesOutfile << "   24  " << ReturnFixedValue("massA0")->value << " # mA (fixed)" << endl;
			}
			else 
				LesHouchesOutfile << "   24  "<< sqr(ReturnFixedValue("massA0")->value) <<" # mA (fixed)"<< endl;
	 }    
	 else if (FindInFitted("massA0")) {
	 		if( yyCalculator == SOFTSUSY ) {
				LesHouchesOutfile << "   24  " << x[ReturnFittedPosition("massA0")] <<" # mA" << endl;
			}
			else
	   	 LesHouchesOutfile << "   24  "<< sqr(x[ReturnFittedPosition("massA0")])<<" # mA"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting mA " << x[ReturnFittedPosition("massA0")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("massA0")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random mA " << x[ReturnRandomPosition("massA0")] << endl;
	    }
	    LesHouchesOutfile << "   24  " << x[ReturnRandomPosition("massA0")] << " # massA0 (random)" << endl;
	 }
	 else if (FindInUniversality("massA0")) {
	    LesHouchesOutfile << "   24  "<<sqr(x[ReturnFittedPosition(ReturnUniversality("massA0")->universality)])<<" # massA0"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("massA0")->universality << " instead of massA0" << endl;
	    }
	 }
	 else {
	    cerr << "Parameter massA0 not declared" << endl;
	    exit (EXIT_FAILURE);
	 }
      }

      if (FindInFixed("MSelectronL")) {
	 LesHouchesOutfile << "   31  "<< ReturnFixedValue("MSelectronL")->value <<" # MSelectronL (fixed)"<< endl;
      }    
      else if (FindInFitted("MSelectronL")) {
	 LesHouchesOutfile << "   31  "<< x[ReturnFittedPosition("MSelectronL")]<<" # MSelectronL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSelectronL " << x[ReturnFittedPosition("MSelectronL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSelectronL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSelectronL " << x[ReturnRandomPosition("MSelectronL")] << endl;
	 }
	 LesHouchesOutfile << "   31  " << x[ReturnRandomPosition("MSelectronL")] << " # MSelectronL (random)" << endl;
      }
      else if (FindInUniversality("MSelectronL")) {
	 LesHouchesOutfile << "   31  "<<x[ReturnFittedPosition(ReturnUniversality("MSelectronL")->universality)]<<" # MSelectronL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSelectronL")->universality << " instead of MSelectronL" << endl;
	 }
      }
      else {
	 cerr << "Parameter MSelectronL not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MSmuL")) {
	 LesHouchesOutfile << "   32  "<< ReturnFixedValue("MSmuL")->value <<" # MSmuL (fixed)"<< endl;
      }    
      else if (FindInFitted("MSmuL")) {
	 LesHouchesOutfile << "   32 "<< x[ReturnFittedPosition("MSmuL")]<<" # MSmuL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSmuL " << x[ReturnFittedPosition("MSmuL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSmuL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSmuL " << x[ReturnRandomPosition("MSmuL")] << endl;
	 }
	 LesHouchesOutfile << "   32  " << x[ReturnRandomPosition("MSmuL")] << " # MSmuL (random)" << endl;
      }
      else if (FindInUniversality("MSmuL")) {
	 LesHouchesOutfile << "   32  "<<x[ReturnFittedPosition(ReturnUniversality("MSmuL")->universality)]<<" # MSmuL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSmuL")->universality << " instead of MSmuL" << endl;
	 }
      }
      else {
	 cerr << "Parameter MSmuL not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MStauL")) {
	 LesHouchesOutfile << "   33  "<< ReturnFixedValue("MStauL")->value <<" # MStauL (fixed)"<< endl;
      }    
      else if (FindInFitted("MStauL")) {
	 LesHouchesOutfile << "   33  "<< x[ReturnFittedPosition("MStauL")]<<" # MStauL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MStauL " << x[ReturnFittedPosition("MStauL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MStauL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MStauL " << x[ReturnRandomPosition("MStauL")] << endl;
	 }
	 LesHouchesOutfile << "   33  " << x[ReturnRandomPosition("MStauL")] << " # MStauL (random)" << endl;
      }
      else if (FindInUniversality("MStauL")) {
	 LesHouchesOutfile << "   33  "<<x[ReturnFittedPosition(ReturnUniversality("MStauL")->universality)]<<" # MStauL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MStauL")->universality << " instead of MStauL" << endl;
	 }
      }
      else {
	 cerr << "Parameter MStauL not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MSelectronR")) {
	 LesHouchesOutfile << "   34  "<< ReturnFixedValue("MSelectronR")->value <<" # MSelectronR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSelectronR")) {
	 LesHouchesOutfile << "   34  "<< x[ReturnFittedPosition("MSelectronR")]<<" # MSelectronR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSelectronR " << x[ReturnFittedPosition("MSelectronR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSelectronR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSelectronR " << x[ReturnRandomPosition("MSelectronR")] << endl;
	 }
	 LesHouchesOutfile << "   34  " << x[ReturnRandomPosition("MSelectronR")] << " # MSelectronR (random)" << endl;
      }
      else if (FindInUniversality("MSelectronR")) {
	 LesHouchesOutfile << "   34  "<<x[ReturnFittedPosition(ReturnUniversality("MSelectronR")->universality)]<<" # MSelectronR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSelectronR")->universality << " instead of MSelectronR" << endl;
	 }
      }
      else {
	 cerr << "Parameter MSelectronR not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MSmuR")) {
	 LesHouchesOutfile << "   35  "<< ReturnFixedValue("MSmuR")->value <<" # MSmuR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSmuR")) {
	 LesHouchesOutfile << "   35  "<< x[ReturnFittedPosition("MSmuR")]<<" # MSmuR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSmuR " << x[ReturnFittedPosition("MSmuR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSmuR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSmuR " << x[ReturnRandomPosition("MSmuR")] << endl;
	 }
	 LesHouchesOutfile << "   35  " << x[ReturnRandomPosition("MSmuR")] << " # MSmuR (random)" << endl;
      }
      else if (FindInUniversality("MSmuR")) {
	 LesHouchesOutfile << "   35  "<<x[ReturnFittedPosition(ReturnUniversality("MSmuR")->universality)]<<" # MSmuR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSmuR")->universality << " instead of MSmuR" << endl;
	 }
      }
      else {
	 cerr << "Parameter MSmuR not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MStauR")) {
	 LesHouchesOutfile << "   36  "<< ReturnFixedValue("MStauR")->value <<" # MStauR (fixed)"<< endl;
      }    
      else if (FindInFitted("MStauR")) {
	 LesHouchesOutfile << "   36  "<< x[ReturnFittedPosition("MStauR")]<<" # MStauR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MStauR " << x[ReturnFittedPosition("MStauR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MStauR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MStauR " << x[ReturnRandomPosition("MStauR")] << endl;
	 }
	 LesHouchesOutfile << "   36  " << x[ReturnRandomPosition("MStauR")] << " # MStauR (random)" << endl;
      }
      else if (FindInUniversality("MStauR")) {
	 LesHouchesOutfile << "   36  "<<x[ReturnFittedPosition(ReturnUniversality("MStauR")->universality)]<<" # MStauR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MStauR")->universality << " instead of MStauR" << endl;
	 }
      }
      else {
	 cerr << "Parameter MStauR not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("MSupL")) {
	 LesHouchesOutfile << "   41  "<< ReturnFixedValue("MSupL")->value <<" # MSupL (fixed)"<< endl;
      }    
      else if (FindInFitted("MSupL")) {
	 LesHouchesOutfile << "   41  "<< x[ReturnFittedPosition("MSupL")]<<" # MSupL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSupL " << x[ReturnFittedPosition("MSupL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSupL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSupL " << x[ReturnRandomPosition("MSupL")] << endl;
	 }
	 LesHouchesOutfile << "   41  " << x[ReturnRandomPosition("MSupL")] << " # MSupL (random)" << endl;
      }
      else if (FindInUniversality("MSupL")) {
	 LesHouchesOutfile << "   41  "<<x[ReturnFittedPosition(ReturnUniversality("MSupL")->universality)]<<" # MSupL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSupL")->universality << " instead of MSupL" << endl;
	 }
      }

      if (FindInFixed("MScharmL")) {
	 LesHouchesOutfile << "   42  "<< ReturnFixedValue("MScharmL")->value <<" # MScharmL (fixed)"<< endl;
      }    
      else if (FindInFitted("MScharmL")) {
	 LesHouchesOutfile << "   42  "<< x[ReturnFittedPosition("MScharmL")]<<" # MScharmL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MScharmL " << x[ReturnFittedPosition("MScharmL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MScharmL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MScharmL " << x[ReturnRandomPosition("MScharmL")] << endl;
	 }
	 LesHouchesOutfile << "   42  " << x[ReturnRandomPosition("MScharmL")] << " # MScharmL (random)" << endl;
      }
      else if (FindInUniversality("MScharmL")) {
	 LesHouchesOutfile << "   42  "<<x[ReturnFittedPosition(ReturnUniversality("MScharmL")->universality)]<<" # MScharmL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MScharmL")->universality << " instead of MScharmL" << endl;
	 }
      }

      if (FindInFixed("MStopL")) {
	 LesHouchesOutfile << "   43  "<< ReturnFixedValue("MStopL")->value <<" # MStopL (fixed)"<< endl;
      }    
      else if (FindInFitted("MStopL")) {
	 LesHouchesOutfile << "   43  "<< x[ReturnFittedPosition("MStopL")]<<" # MStopL"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MStopL " << x[ReturnFittedPosition("MStopL")] << endl;
	 }
      } 
      else if (FindInRandomPar("MStopL")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MStopL " << x[ReturnRandomPosition("MStopL")] << endl;
	 }
	 LesHouchesOutfile << "   43  " << x[ReturnRandomPosition("MStopL")] << " # MStopL (random)" << endl;
      }
      else if (FindInUniversality("MStopL")) {
	 LesHouchesOutfile << "   43  "<<x[ReturnFittedPosition(ReturnUniversality("MStopL")->universality)]<<" # MStopL"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MStopL")->universality << " instead of MStopL" << endl;
	 }
      }

      if (FindInFixed("MSupR")) {
	 LesHouchesOutfile << "   44  "<< ReturnFixedValue("MSupR")->value <<" # MSupR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSupR")) {
	 LesHouchesOutfile << "   44  "<< x[ReturnFittedPosition("MSupR")]<<" # MSupR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSupR " << x[ReturnFittedPosition("MSupR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSupR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSupR " << x[ReturnRandomPosition("MSupR")] << endl;
	 }
	 LesHouchesOutfile << "   44  " << x[ReturnRandomPosition("MSupR")] << " # MSupR (random)" << endl;
      }
      else if (FindInUniversality("MSupR")) {
	 LesHouchesOutfile << "   44  "<<x[ReturnFittedPosition(ReturnUniversality("MSupR")->universality)]<<" # MSupR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSupR")->universality << " instead of MSupR" << endl;
	 }
      }

      if (FindInFixed("MScharmR")) {
	 LesHouchesOutfile << "   45  "<< ReturnFixedValue("MScharmR")->value <<" # MScharmR (fixed)"<< endl;
      }    
      else if (FindInFitted("MScharmR")) {
	 LesHouchesOutfile << "   45  "<< x[ReturnFittedPosition("MScharmR")]<<" # MScharmR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MScharmR " << x[ReturnFittedPosition("MScharmR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MScharnR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MScharmR " << x[ReturnRandomPosition("MScharmR")] << endl;
	 }
	 LesHouchesOutfile << "   45  " << x[ReturnRandomPosition("MScharmR")] << " # MScharmR (random)" << endl;
      }
      else if (FindInUniversality("MScharmR")) {
	 LesHouchesOutfile << "   45  "<<x[ReturnFittedPosition(ReturnUniversality("MScharmR")->universality)]<<" # MScharmR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MScharmR")->universality << " instead of MScharmR" << endl;
	 }
      }

      if (FindInFixed("MStopR")) {
	 LesHouchesOutfile << "   46  "<< ReturnFixedValue("MStopR")->value <<" # MStopR (fixed)"<< endl;
      }    
      else if (FindInFitted("MStopR")) {
	 LesHouchesOutfile << "   46  "<< x[ReturnFittedPosition("MStopR")]<<" # MStopR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MStopR " << x[ReturnFittedPosition("MStopR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MStopR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MStopR " << x[ReturnRandomPosition("MStopR")] << endl;
	 }
	 LesHouchesOutfile << "   46  " << x[ReturnRandomPosition("MStopR")] << " # MStopR (random)" << endl;
      }
      else if (FindInUniversality("MStopR")) {
	 LesHouchesOutfile << "   46  "<<x[ReturnFittedPosition(ReturnUniversality("MStopR")->universality)]<<" # MStopR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MStopR")->universality << " instead of MStopR" << endl;
	 }
      }

      if (FindInFixed("MSdownR")) {
	 LesHouchesOutfile << "   47  "<< ReturnFixedValue("MSdownR")->value <<" # MSdownR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSdownR")) {
	 LesHouchesOutfile << "   47  "<< x[ReturnFittedPosition("MSdownR")]<<" # MSdownR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSdownR " << x[ReturnFittedPosition("MSdownR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSdownR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSdownR " << x[ReturnRandomPosition("MSdownR")] << endl;
	 }
	 LesHouchesOutfile << "   47  " << x[ReturnRandomPosition("MSdownR")] << " # MSdownR (random)" << endl;
      }
      else if (FindInUniversality("MSdownR")) {
	 LesHouchesOutfile << "   47  "<<x[ReturnFittedPosition(ReturnUniversality("MSdownR")->universality)]<<" # MSdownR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSdownR")->universality << " instead of MSdownR" << endl;
	 }
      }

      if (FindInFixed("MSstrangeR")) {
	 LesHouchesOutfile << "   48  "<< ReturnFixedValue("MSstrangeR")->value <<" # MSstrangeR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSstrangeR")) {
	 LesHouchesOutfile << "   48  "<< x[ReturnFittedPosition("MSstrangeR")]<<" # MSstrangeR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSstrangeR " << x[ReturnFittedPosition("MSstrangeR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSstrangeR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSstrangeR " << x[ReturnRandomPosition("MSstrangeR")] << endl;
	 }
	 LesHouchesOutfile << "   48  " << x[ReturnRandomPosition("MSstrangeR")] << " # MSstrangeR (random)" << endl;
      }
      else if (FindInUniversality("MSstrangeR")) {
	 LesHouchesOutfile << "   48  "<<x[ReturnFittedPosition(ReturnUniversality("MSstrangeR")->universality)]<<" # MSstrangeR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSstrangeR")->universality << " instead of MSstrangeR" << endl;
	 }
      }

      if (FindInFixed("MSbottomR")) {
	 LesHouchesOutfile << "   49  "<< ReturnFixedValue("MSbottomR")->value <<" # MSbottomR (fixed)"<< endl;
      }    
      else if (FindInFitted("MSbottomR")) {
	 LesHouchesOutfile << "   49  "<< x[ReturnFittedPosition("MSbottomR")]<<" # MSbottomR"<< endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting MSbottomR " << x[ReturnFittedPosition("MSbottomR")] << endl;
	 }
      } 
      else if (FindInRandomPar("MSbottomR")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random MSbottomR " << x[ReturnRandomPosition("MSbottomR")] << endl;
	 }
	 LesHouchesOutfile << "   49  " << x[ReturnRandomPosition("MSbottomR")] << " # MSbottomR (random)" << endl;
      }
      else if (FindInUniversality("MSbottomR")) {
	 LesHouchesOutfile << "   49  "<<x[ReturnFittedPosition(ReturnUniversality("MSbottomR")->universality)]<<" # MSbottomR"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("MSbottomR")->universality << " instead of MSbottomR" << endl;
	 }
      }

      if (yyFitModel == NMSSM) {

	 if (FindInFixed("lambda")) {
	    LesHouchesOutfile << "   61  "<< ReturnFixedValue("lambda")->value <<" # lambda (fixed)"<< endl;
	 }    
	 else if (FindInFitted("lambda")) {
	    LesHouchesOutfile << "   61  "<< x[ReturnFittedPosition("lambda")]<<" # lambda"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting lambda " << x[ReturnFittedPosition("lambda")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("lambda")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random lambda " << x[ReturnRandomPosition("lambda")] << endl;
	    }
	    LesHouchesOutfile << "   61  " << x[ReturnRandomPosition("lambda")] << " # lambda (random)" << endl;
	 }
	 else if (FindInUniversality("lambda")) {
	    LesHouchesOutfile << "   61  "<<x[ReturnFittedPosition(ReturnUniversality("lambda")->universality)]<<" # lambda"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("lambda")->universality << " instead of lambda" << endl;
	    }
	 }

	 if (FindInFixed("kappa")) {
	    LesHouchesOutfile << "   62  "<< ReturnFixedValue("kappa")->value <<" # kappa (fixed)"<< endl;
	 }    
	 else if (FindInFitted("kappa")) {
	    LesHouchesOutfile << "   62  "<< x[ReturnFittedPosition("kappa")]<<" # kappa"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting kappa " << x[ReturnFittedPosition("kappa")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("kappa")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random kappa " << x[ReturnRandomPosition("kappa")] << endl;
	    }
	    LesHouchesOutfile << "   62  " << x[ReturnRandomPosition("kappa")] << " # kappa (random)" << endl;
	 }
	 else if (FindInUniversality("kappa")) {
	    LesHouchesOutfile << "   62  "<<x[ReturnFittedPosition(ReturnUniversality("kappa")->universality)]<<" # kappa"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("kappa")->universality << " instead of kappa" << endl;
	    }
	 }

	 if (FindInFixed("ALambda")) {
	    LesHouchesOutfile << "   63  "<< ReturnFixedValue("ALambda")->value <<" # ALambda (fixed)"<< endl;
	 }    
	 else if (FindInFitted("ALambda")) {
	    LesHouchesOutfile << "   63  "<< x[ReturnFittedPosition("ALambda")]<<" # ALambda"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting ALambda " << x[ReturnFittedPosition("ALambda")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("Alambda")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random Alambda " << x[ReturnRandomPosition("Alambda")] << endl;
	    }
	    LesHouchesOutfile << "   63  " << x[ReturnRandomPosition("Alambda")] << " # Alambda (random)" << endl;
	 }
	 else if (FindInUniversality("ALambda")) {
	    LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("ALambda")->universality)]<<" # ALambda"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("ALambda")->universality << " instead of ALambda" << endl;
	    }
	 }

	 if (FindInFixed("AKappa")) {
	    LesHouchesOutfile << "   64  "<< ReturnFixedValue("AKappa")->value <<" # AKappa (fixed)"<< endl;
	 }    
	 else if (FindInFitted("AKappa")) {
	    LesHouchesOutfile << "   64  "<< x[ReturnFittedPosition("AKappa")]<<" # AKappa"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting AKappa " << x[ReturnFittedPosition("AKappa")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("Akappa")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random Akappa " << x[ReturnRandomPosition("Akappa")] << endl;
	    }
	    LesHouchesOutfile << "   64  " << x[ReturnRandomPosition("Akappa")] << " # Akappa (random)" << endl;
	 }
	 else if (FindInUniversality("AKappa")) {
	    LesHouchesOutfile << "   64  "<<x[ReturnFittedPosition(ReturnUniversality("AKappa")->universality)]<<" # AKappa"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("AKappa")->universality << " instead of AKappa" << endl;
	    }
	 }

	 if (FindInFixed("MuEff")) {
	    LesHouchesOutfile << "   65  "<< ReturnFixedValue("MuEff")->value <<" # MuEff (fixed)"<< endl;
	 }    
	 else if (FindInFitted("MuEff")) {
	    LesHouchesOutfile << "   65  "<< x[ReturnFittedPosition("MuEff")]<<" # MuEff"<< endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Fitting MuEff " << x[ReturnFittedPosition("MuEff")] << endl;
	    }
	 } 
	 else if (FindInRandomPar("MuEff")) {
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "Calculating random MuEff " << x[ReturnRandomPosition("MuEff")] << endl;
	    }
	    LesHouchesOutfile << "   65  " << x[ReturnRandomPosition("MuEff")] << " # MuEff (random)" << endl;
	 }
	 else if (FindInUniversality("MuEff")) {
	    LesHouchesOutfile << "   65  "<<x[ReturnFittedPosition(ReturnUniversality("MuEff")->universality)]<<" # MuEff"<<endl;
	    if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("MuEff")->universality << " instead of MuEff" << endl;
	    }
	 }
      }
      // cout << "looking for SPheno " << yyCalculator << endl;
      if( yyCalculator == SPHENO ) {  //ADDED SOMETHING HERE
	//cout << "writing LesHouches for SPheno " << yySPhenoStartDataString << endl;
	//if (yySPhenoStartDataString!="") {
	//  LesHouchesOutfile << "BLOCK StartDataFile" << endl;
	//  LesHouchesOutfile << " " << yySPhenoStartDataString << endl;
	//}
	// BLOCK SPhenoInput
      LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
      LesHouchesOutfile << "    1  0                  # error level" << endl;
      LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
      LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
      LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
      if (yyCalculateSPhenoCrossSections) {
	LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
      } else {
	LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
      }
      for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
				 LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
				 LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
				 LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	 			if (!yyISR) {
	  			LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
				} 
				else {
			    LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	 			}
      }
      LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
      LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
      LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
      // LesHouchesOutfile << "   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

//       if (FindInFixed("massCharm")) {
// 				LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }
//       else if (FindInFitted("massCharm")) {
// 				LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 			 	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		
// 	    	cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
		
// 				 }
//       } 
//       else if (FindInUniversality("massCharm")) {
// 				 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 				 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	   			 cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
				   
// 				 }
//       }
//       else {
// 	LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }

      LesHouchesOutfile << "   80  1     # SPheno Exit wit hnon-zero-value for sure!!" << endl;
      if ( yySPhenoOldInputFile != "") {
	LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	LesHouchesOutfile << yySPhenoOldInputFile << endl;
      }
      }
      //ADDED SOMETHING HERE
      else if( yyCalculator == SOFTSUSY ) {
	//ADD BLOCK SOFTSUSY
	LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
	LesHouchesOutfile << "    1 	0.1     			# desired fractional accuracy in output " << endl;
	LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
	LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caclualtion " << endl;
	//LesHouchesOutfile << "    4   1000.0		    # change electroweak symmetry breaking scale " << endl;
	LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
      }
   }
   else if (yyFitModel == mSUGRA || yyFitModel == NUHM1 || yyFitModel == NUHM2 ) {

      LesHouchesOutfile << "BLOCK MODSEL                 # Select model" << endl;
      LesHouchesOutfile << "    1 1                      # mSugra" << endl;
      if ( yyUseFullCKMMatrix ) {
	 LesHouchesOutfile << "    5 1                      # CP violation (0,1,2)=(none, CKM, general SUSY)" << endl;
	 LesHouchesOutfile << "    6 1                      # Flavour violation in quark sector" << endl;
      }
      if (FindInFixed("QEWSB")) {
	 			std::cout << "found QEWSB in fixex" << std::endl;
	 LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
      }
      else if (FindInFitted("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	 }
      } 
      else if (FindInUniversality("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	 }
      }      
      /*
			else {
	LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
      }
			*/

      LesHouchesOutfile << "BLOCK SMINPUTS               # Standard Model inputs" << endl;

      if (FindInFixed("alphaem")) {
	 LesHouchesOutfile << "    1 " << ReturnFixedValue("alphaem")->value << " # 1/alpha_em (fixed)" << endl;
      }
      else if (FindInFitted("alphaem")) {
	 LesHouchesOutfile << "    1  " << x[ReturnFittedPosition("alphaem")] << " # 1/alpha_em(M_Z)" << endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	 }
      } 
      else if (FindInUniversality("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    1  " << ReturnMeasuredValue("alphaem")->value << " # 1/alpha_em(M_Z) (fixed)" << endl;
      }

      // TODO: Fix problem with small errors in a smarter way
      if (FindInFixed("G_F")) {
	 LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
      }
      else if (FindInFitted("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
	 }
      } 
      else if (FindInUniversality("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value<<" # G_F (fixed)"<<endl;
      }

      if (FindInFixed("alphas")) {
	 LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }
      else if (FindInFitted("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	 }
      } 
      else if (FindInUniversality("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }

      if (FindInFixed("massZ")) {
	 LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }
      else if (FindInFitted("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	 }
      } 
      else if (FindInUniversality("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }

      if (FindInFixed("massBottom")) {
	 LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }
      else if (FindInFitted("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	 }
      } 
      else if (FindInUniversality("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }


      if (FindInFixed("massTop")) {
	 LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }
      else if (FindInFitted("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massTop " << x[ReturnFittedPosition("massTop")] << endl;
	 }
      } 
      else if (FindInUniversality("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }

      if (FindInFixed("massTau")) {
	 LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }
      else if (FindInFitted("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
	    cout << "Fitting massTau " << x[ReturnFittedPosition("massTau")] << endl;
	 }
      } 
      else if (FindInUniversality("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
	    cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }

      if (FindInFixed("massCharm")) {
	LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }
      else if (FindInFitted("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	}
      } 
      else if (FindInUniversality("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	}
      }
      else {
	LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }
      if(yyUseHDecay) {
      if (FindInFixed("massStrange")) {
         LesHouchesOutfile << "   23  "<<ReturnFixedValue("massStrange")->value<<" # m_s(2 GeV), MSbar"<<endl;
      }
      else if (FindInFitted("massStrange")) {
         LesHouchesOutfile << "   23  "<<x[ReturnFittedPosition("massStrange")]<<" # m_s(2 GeV), MSbar"<<endl;
         if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "Fitting mStrange " << x[ReturnFittedPosition("massStrange")] << endl;
         }
      }
      else if (FindInUniversality("massStrange")) {
         LesHouchesOutfile << "    23  "<<x[ReturnFittedPosition(ReturnUniversality("massStrange")->universality)]<<" # m_s(2 GeV), MSbar"<<endl;
         if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "fitting " << ReturnUniversality("massStrange")->universality << " instead of massStrange" << endl;
         }
      }
      else {
         LesHouchesOutfile << "    23  "<<ReturnMeasuredValue("massStrange")->value<<" # m_s(2 GeV), MSbar"<<endl;
      }

            if (FindInFixed("massMuon")) {
        LesHouchesOutfile << "    13  "<<ReturnFixedValue("massMuon")->value<<" # mmuon"<<endl;
      }
      else if (FindInFitted("massMuon")) {
        LesHouchesOutfile << "    13  "<<x[ReturnFittedPosition("massMuon")]<<" # mmuon"<<endl;
        if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
          cout << "Fitting mMuon " << x[ReturnFittedPosition("massMuon")] << endl;
        }
      }
      else if (FindInUniversality("massMuon")) {
        LesHouchesOutfile << "    13  "<<x[ReturnFittedPosition(ReturnUniversality("massMuon")->universality)]<<" # massMuon"<<endl;
        if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
          cout << "fitting " << ReturnUniversality("massMuon")->universality << " instead of massMuon" << endl;
        }
      }
      else {
        LesHouchesOutfile << "    13  "<<ReturnMeasuredValue("massMuon")->value<<" # mmuon"<<endl;
      }
      }


      if ( yyUseFullCKMMatrix ) {
	 // VCKM
	/*
	// Obsolete Les Houches CKM matrix parametrisation
	 LesHouchesOutfile << "BLOCK VCKMIN"               << endl;
	 LesHouchesOutfile << "    1  0.2292    # theta12" << endl;
	 LesHouchesOutfile << "    2  0.04224   # theta23" << endl;
	 LesHouchesOutfile << "    3  0.0038903 # theta13" << endl;
	 LesHouchesOutfile << "    4  0.9944    # delta"   << endl; // set CKM p
hase (rad), SPheno default value = 0
	 //    LesHouchesOutfile << "    4  0.0 # delta" << endl; // set CKM phase (rad), SPheno default value = 0
	 */
	// Wolfenstein parametrisation
	 LesHouchesOutfile << "BLOCK VCKMIN"               << endl;
	 LesHouchesOutfile << "    1  0.226500E+00       # lambda" << endl;
	 LesHouchesOutfile << "    2  0.807000E+00       # A" << endl;
	 LesHouchesOutfile << "    3  0.141000E+00       # rho bar" << endl;
	 LesHouchesOutfile << "    4  0.343000E+00       # eta bar" << endl; // set CKM p
      }

      LesHouchesOutfile << "BLOCK MINPAR                 # Input parameters" << endl;
      /*
      // moved TanBeta to EXTPAR
      if (FindInFixed("TanBeta")) {
	 LesHouchesOutfile << "    3  "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
      }
      else if (FindInFitted("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random tanb " << x[ReturnRandomPosition("TanBeta")] << endl;
	 }

	 LesHouchesOutfile << "    3  "<< x[ReturnRandomPosition("TanBeta")]<<" # tanb (random)"<< endl;
      }
      else if (FindInUniversality("TanBeta")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	 }
      }
      else {
	 cerr << "a-Parameter TanBeta not declared" << endl;
	 exit (EXIT_FAILURE);
      } AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      */
      if (FindInFixed("M0")) {
	 LesHouchesOutfile << "    1  "<< ReturnFixedValue("M0")->value <<" # M0 (fixed)"<< endl;
      }
      else if (FindInFitted("M0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M0 " << x[ReturnFittedPosition("M0")] << endl;
	 }
	 LesHouchesOutfile << "    1  "<< x[ReturnFittedPosition("M0")]<<" # M0"<< endl;
      } 
      else if (FindInRandomPar("M0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M0 " << x[ReturnRandomPosition("M0")] << endl;
	 }
	 LesHouchesOutfile << "    1  "<< x[ReturnRandomPosition("M0")]<<" # M0 (random)"<< endl;
      }

      else if (FindInUniversality("M0")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("M0")->universality)]<<" # M0"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M0")->universality << " instead of M0" << endl;
	 }
      }
      else {
	 cerr << "Parameter M0 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("M12")) {
	 LesHouchesOutfile << "    2  "<< ReturnFixedValue("M12")->value <<" # M12 (fixed)"<< endl;
      }
      else if (FindInFitted("M12")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M12 " << x[ReturnFittedPosition("M12")] << endl;
	 }
	 LesHouchesOutfile << "    2  "<< x[ReturnFittedPosition("M12")]<<" # M12"<< endl;
      } 
      else if (FindInRandomPar("M12")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M12 " << x[ReturnRandomPosition("M12")] << endl;
	 }
	 LesHouchesOutfile << "    2  "<< x[ReturnRandomPosition("M12")]<<" # M12 (random)"<< endl;
      }

      else if (FindInUniversality("M12")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("M12")->universality)]<<" # M12"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M12")->universality << " instead of M12" << endl;
	 }
      }
      else {
	 cerr << "Parameter M12 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("A0")) {
	 LesHouchesOutfile << "    5  "<< ReturnFixedValue("A0")->value <<" # A0 (fixed)"<< endl;
      }
      else if (FindInFitted("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting A0 " << x[ReturnFittedPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnFittedPosition("A0")]<<" # A0"<< endl;
      } 
      else if (FindInRandomPar("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random A0 " << x[ReturnRandomPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnRandomPosition("A0")]<<" # A0 (random)"<< endl;
      }

      else if (FindInUniversality("A0")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("A0")->universality)]<<" # A0"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("A0")->universality << " instead of A0" << endl;
	 }
      }
      else {
	 cerr << "Parameter A0 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      if (FindInFixed("SignMu") && TMath::Abs(ReturnFixedValue("SignMu")->value) == 1 ) {
	 LesHouchesOutfile << "    4  "<< ReturnFixedValue("SignMu")->value <<" # sign(mu) (fixed)"<< endl;
      }
      else {
	 cerr<<"SignMu must be fixed to either 1 or -1"<<endl;
	 exit(EXIT_FAILURE);
      }
      
      // moved TanBeta to this block
      LesHouchesOutfile << "BLOCK EXTPAR                 # Input parameters" << endl;
      if (FindInFixed("TanBeta")) {
   LesHouchesOutfile << "    25 "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
      }
      else if (FindInFitted("TanBeta")) {
   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
      cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
   }
   LesHouchesOutfile << "    25 "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
      cout << "Calculating random tanb " << x[ReturnRandomPosition("TanBeta")] << endl;
   }

   LesHouchesOutfile << "    25 "<< x[ReturnRandomPosition("TanBeta")]<<" # tanb (random)"<< endl;
      }
      else if (FindInUniversality("TanBeta")) {
   LesHouchesOutfile << "    25 "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
      cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
   }
      }
      else {
   cerr << "Parameter TanBeta not declared" << endl;
   exit (EXIT_FAILURE);
      } 
      
      if( yyFitModel == NUHM1 ) {
        if (FindInFixed("M0H")) {
          LesHouchesOutfile << "   21 " << ReturnFixedValue("M0H")->value << " # non-universal m_(H_d)^2" << endl;
          LesHouchesOutfile << "   22 " << ReturnFixedValue("M0H")->value << " # non-universal m_(H_u)^2" << endl;
        } 
        else if (FindInFitted("M0H")) {
          if( yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100) < 0.01 ) ) {
              cout << "Fitting M0H " << x[ReturnFittedPosition("M0H")] << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnFittedPosition("M0H")] << " # non-universal m_(H_d)^2" << endl;
          LesHouchesOutfile << "    22 " << x[ReturnFittedPosition("M0H")] << " # non-universal m_(H_u)^2" << endl;
        }
        else if (FindInRandomPar("M0H")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "Calculating random M0H " << x[ReturnRandomPosition("M0H")] << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnRandomPosition("M0H")] << " # non-universal m_(H_d)^2" << endl;
          LesHouchesOutfile << "    22 " << x[ReturnRandomPosition("M0H")] << " # non-universal m_(H_u)^2" << endl;
        }
        else if (FindInUniversality("M0H")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "fitting " << ReturnUniversality("M0H")->universality << " instead of M0H" << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnFittedPosition(ReturnUniversality("M0H")->universality)] << " # non-universal m_(H_d)^2" << endl;
          LesHouchesOutfile << "    22 " << x[ReturnFittedPosition(ReturnUniversality("M0H")->universality)] << " # non-universal m_(H_u)^2" << endl;
        }
        else {
          cerr << "Parameter M0H not declared" << endl;
          exit (EXIT_FAILURE);
        }
      }
			if( yyFitModel == NUHM2 ) {
				if (FindInFixed("M0Hu")) {
          LesHouchesOutfile << "   22 " << ReturnFixedValue("M0Hu")->value << " # non-universal m_(H_u)^2" << endl;
        }
        else if (FindInFitted("M0Hu")) {
          if( yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100) < 0.01 ) ) {
              cout << "Fitting M0Hu " << x[ReturnFittedPosition("M0Hu")] << endl;
          }
          LesHouchesOutfile << "    22 " << x[ReturnFittedPosition("M0Hu")] << " # non-universal m_(H_u)^2" << endl;
        }
        else if (FindInRandomPar("M0Hu")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "Calculating random M0Hu " << x[ReturnRandomPosition("M0Hu")] << endl;
          }
          LesHouchesOutfile << "    22 " << x[ReturnRandomPosition("M0Hu")] << " # non-universal m_(H_u)^2" << endl;
        }
        else if (FindInUniversality("M0Hu")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "fitting " << ReturnUniversality("M0Hu")->universality << " instead of M0Hu" << endl;
          }
          LesHouchesOutfile << "    22 " << x[ReturnFittedPosition(ReturnUniversality("M0Hu")->universality)] << " # non-universal m_(H_u)^2" << endl;
        }
        else {
          cerr << "Parameter M0Hu not declared" << endl;
          exit (EXIT_FAILURE);
        }
				
				if (FindInFixed("M0Hd")) {
          LesHouchesOutfile << "   21 " << ReturnFixedValue("M0Hd")->value << " # non-universal m_(H_d)^2" << endl;
        }
        else if (FindInFitted("M0Hd")) {
          if( yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100) < 0.01 ) ) {
              cout << "Fitting M0Hd " << x[ReturnFittedPosition("M0Hd")] << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnFittedPosition("M0Hd")] << " # non-universal m_(H_d)^2" << endl;
        }
        else if (FindInRandomPar("M0Hd")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "Calculating random M0Hd " << x[ReturnRandomPosition("M0Hd")] << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnRandomPosition("M0Hd")] << " # non-universal m_(H_d)^2" << endl;
        }
        else if (FindInUniversality("M0Hd")) {
          if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) {
            cout << "fitting " << ReturnUniversality("M0Hd")->universality << " instead of M0Hd" << endl;
          }
          LesHouchesOutfile << "    21 " << x[ReturnFittedPosition(ReturnUniversality("M0Hd")->universality)] << " # non-universal m_(H_d)^2" << endl;
        }
        else {
          cerr << "Parameter M0Hd not declared" << endl;
          exit (EXIT_FAILURE);
        }
		
			}

      if( yyCalculator == SPHENO ) {
	if (yySPhenoStartDataString!="" && yySPhenoLastCallValid) {
	  LesHouchesOutfile << "BLOCK StartDataFile" << endl;
	  LesHouchesOutfile << "    " << yySPhenoStartDataString << endl;
	}
      LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
      LesHouchesOutfile << "    1  0                  # error level" << endl;
      LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
      LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
      LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
      if (yyCalculateSPhenoCrossSections) {
	LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
      } else {
	LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
      }
      for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
	 LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
	 LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
	 LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	 if (!yyISR) {
	    LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
	 } else {
	    LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	 }
      }
      LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
      LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
      LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
      // LesHouchesOutfile << "   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

//       if (FindInFixed("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }
//       else if (FindInFitted("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
// 	 }
//       } 
//       else if (FindInUniversality("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
// 	 }
//       }
//       else {
// 	 LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }

      LesHouchesOutfile << "   80  1     # SPheno Exit with non-zero-value for sure!!" << endl;
      if ( yySPhenoOldInputFile != "") {
	LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	LesHouchesOutfile << yySPhenoOldInputFile << endl;
      }
   }
	
	else if( yyCalculator == SOFTSUSY ) {
	    //ADD BLOCK SOFTSUSY
		LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
		LesHouchesOutfile << "    1   0.1           # desired fractional accuracy in output " << endl;
		LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
		LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caclualtion " << endl;
		//LesHouchesOutfile << "    4   1000.0        # change electroweak symmetry breaking scale " << endl;
		LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
	}
	}															

   else if (yyFitModel == XMSUGRA) {

      LesHouchesOutfile << "BLOCK MODSEL                 # Select model"     << endl;
      LesHouchesOutfile << "    1  1                     # mSugra (XMSUGRA)" << endl;
      if ( yyUseFullCKMMatrix ) {
	 LesHouchesOutfile << "    5  1                 # CP violation (0,1,2)=(none, CKM, general SUSY)" << endl;
	 LesHouchesOutfile << "    6  1                 # Flavour violation in quark sector" << endl;
      }
      if (FindInFixed("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
      }
      else if (FindInFitted("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	 }
      } 
      else if (FindInUniversality("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	 }
      }      
      /*
			else {
	LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
      }
			*/

      LesHouchesOutfile << "BLOCK SMINPUTS               # Standard Model inputs" << endl;
      if (FindInFixed("alphaem")) {
	 LesHouchesOutfile << "    1 " <<ReturnFixedValue("alphaem")->value << " # 1/alpha_em (fixed)" << endl;
      }
      else if (FindInFitted("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition("alphaem")]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	 }
      } 
      else if (FindInUniversality("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    1  "<<ReturnMeasuredValue("alphaem")->value<<" # 1/alpha_em(M_Z) (fixed)"<<endl;
      }

      /*
	 if (FindInFixed("G_F")) {
	 LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
	 }
	 else if (FindInFitted("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	 cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
	 }
	 } 
	 else if (FindInUniversality("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	 cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
	 }
	 }
	 else {
	 LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value<<" # G_F (fixed)"<<endl;
	 }
	 */
      if (FindInFixed("alphas")) {
	 LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }
      else if (FindInFitted("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	 }
      } 
      else if (FindInUniversality("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }


      if (FindInFixed("massZ")) {
	 LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }
      else if (FindInFitted("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	 }
      } 
      else if (FindInUniversality("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }

      if (FindInFixed("massBottom")) {
	 LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }
      else if (FindInFitted("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	 }
      } 
      else if (FindInUniversality("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }


      if (FindInFixed("massTop")) {
	 LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }
      else if (FindInFitted("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mTop " << x[ReturnFittedPosition("massTop")] << endl;
	 }
      } 
      else if (FindInUniversality("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }

      if (FindInFixed("massTau")) {
	 LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }
      else if (FindInFitted("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
      } 
      else if (FindInUniversality("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }


      if (FindInFixed("massCharm")) {
	LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }
      else if (FindInFitted("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	}
      } 
      else if (FindInUniversality("massCharm")) {
	LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	}
      }
      else {
	LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
      }

      if ( yyUseFullCKMMatrix ) {
	 // VCKM
	 LesHouchesOutfile << "BLOCK VCKMIN"               << endl;
	 LesHouchesOutfile << "    1  0.2292    # theta12" << endl;
	 LesHouchesOutfile << "    2  0.04224   # theta23" << endl;
	 LesHouchesOutfile << "    3  0.0038903 # theta13" << endl;
	 LesHouchesOutfile << "    4  0.9944    # delta"   << endl; // set CKM phase (rad), SPheno default value = 0
	 //    LesHouchesOutfile << "    4  0.0 # delta" << endl; // set CKM phase (rad), SPheno default value = 0
      }

      LesHouchesOutfile<<"BLOCK MINPAR                 # Input parameters"<<endl;

      if (FindInFixed("M0")) {
	 LesHouchesOutfile << "    1  "<< ReturnFixedValue("M0")->value <<" # M0 (fixed)"<< endl;
      }
      else if (FindInFitted("M0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M0 " << x[ReturnFittedPosition("M0")] << endl;
	 }
	 LesHouchesOutfile << "    1  "<< x[ReturnFittedPosition("M0")]<<" # M0"<< endl;
      } 
      else if (FindInRandomPar("M0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M0 " << x[ReturnRandomPosition("M0")] << endl;
	 }
	 LesHouchesOutfile << "    1  "<< x[ReturnRandomPosition("M0")]<<" # M0 (random)"<< endl;
      }

      else if (FindInUniversality("M0")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("M0")->universality)]<<" # M0"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M0")->universality << " instead of M0" << endl;
	 }
      }
      else {
	 cerr << "Parameter M0 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

//      if (FindInFixed("M12")) {
//	 LesHouchesOutfile << "    2  "<< ReturnFixedValue("M12")->value <<" # M12 (fixed)"<< endl;
//      }
//      else if (FindInFitted("M12")) {
//	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
//	    cout << "Fitting M12 " << x[ReturnFittedPosition("M12")] << endl;
//	 }
//	 LesHouchesOutfile << "    2  "<< x[ReturnFittedPosition("M12")]<<" # M12"<< endl;
//      } 
//      else if (FindInRandomPar("M12")) {
//	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
//	    cout << "Calculating random M12 " << x[ReturnRandomPosition("M12")] << endl;
//	 }
//	 LesHouchesOutfile << "    2  "<< x[ReturnRandomPosition("M12")]<<" # M12 (random)"<< endl;
//      }
//
//      else if (FindInUniversality("M12")) {
//	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("M12")->universality)]<<" # M12"<<endl;
//	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
//	    cout << "fitting " << ReturnUniversality("M12")->universality << " instead of M12" << endl;
//	 }
//      }
//      else {
//	 cerr << "Parameter M12 not declared" << endl;
//	 exit (EXIT_FAILURE);
//      }

      if (FindInFixed("TanBeta")) {
	 LesHouchesOutfile << "    3  "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
      }
      else if (FindInFitted("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random tanb " << x[ReturnRandomPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnRandomPosition("TanBeta")]<<" # tanb (random)"<< endl;
      }
      else if (FindInUniversality("TanBeta")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	 }
      }
      else {
	 cerr << "b-Parameter TanBeta not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("SignMu") && TMath::Abs(ReturnFixedValue("SignMu")->value) == 1 ) {
	 LesHouchesOutfile << "    4  "<< ReturnFixedValue("SignMu")->value <<" # sign(mu) (fixed)"<< endl;
      }
      else {
	 cerr<<"SignMu must be fixed to either 1 or -1"<<endl;
	 exit(EXIT_FAILURE);
      }

      if (FindInFixed("A0")) {
	 LesHouchesOutfile << "    5  "<< ReturnFixedValue("A0")->value <<" # A0 (fixed)"<< endl;
      }
      else if (FindInFitted("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting A0 " << x[ReturnFittedPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnFittedPosition("A0")]<<" # A0"<< endl;
      } 
      else if (FindInRandomPar("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random A0 " << x[ReturnRandomPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnRandomPosition("A0")]<<" # A0 (random)"<< endl;
      }

      else if (FindInUniversality("A0")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("A0")->universality)]<<" # A0"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("A0")->universality << " instead of A0" << endl;
	 }
      }
      else {
	 cerr << "Parameter A0 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // BLOCK EXTPAR
      LesHouchesOutfile << "BLOCK EXTPAR" << endl;
      //      LesHouchesOutfile << "    0  1000. # Input scale for mSUGRA" << endl;
      // M1
      if (FindInFixed("M1")) {
	 LesHouchesOutfile << "    1  " << ReturnFixedValue("M1")->value << " # M1(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M1 " << x[ReturnFittedPosition("M1")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnFittedPosition("M1")] << " # M1(M_GUT)" << endl;
      } 
      else if (FindInRandomPar("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M1 " << x[ReturnRandomPosition("M1")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnRandomPosition("M1")] << " # M1(M_GUT) (random)" << endl;
      } 
      else if (FindInUniversality("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M1")->universality << " instead of M1" << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnFittedPosition(ReturnUniversality("M1")->universality)] << " # M1(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M1 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      // M2
      if (FindInFixed("M2")) {
	 LesHouchesOutfile << "    2  " << ReturnFixedValue("M2")->value << " # M2(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M2 " << x[ReturnFittedPosition("M2")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnFittedPosition("M2")] << " # M2(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M2 " << x[ReturnRandomPosition("M2")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnRandomPosition("M2")] << " # M2(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M2")->universality << " instead of M2" << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnFittedPosition(ReturnUniversality("M2")->universality)] << " # M2(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M2 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      // M3
      if (FindInFixed("M3")) {
	 LesHouchesOutfile << "    3  " << ReturnFixedValue("M3")->value << " # M3(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M3 " << x[ReturnFittedPosition("M3")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition("M3")] << " # M3(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M3 " << x[ReturnRandomPosition("M3")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("M3")] << " # M3(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M3")->universality << " instead of M3" << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition(ReturnUniversality("M3")->universality)] << " # M3(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M3 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      // BLOCK SPhenoInput
      if( yyCalculator == SPHENO ) {
	if (yySPhenoStartDataString!="" && yySPhenoLastCallValid) {
	  LesHouchesOutfile << "BLOCK StartDataFile" << endl;
	  LesHouchesOutfile << "    " << yySPhenoStartDataString << endl;
	}
      LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
      LesHouchesOutfile << "    1  0                  # error level" << endl;
      LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
      LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
      LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
      if (yyCalculateSPhenoCrossSections) {
	LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
      } else {
	LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
      }
      for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
	 LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
	 LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
	 LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	 if (!yyISR) {
	    LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
	 } else {
	    LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	 }
      }
      LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
      LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
      LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
      // LesHouchesOutfile << "#   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

//       if (FindInFixed("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }
//       else if (FindInFitted("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
// 	 }
//       } 
//       else if (FindInUniversality("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
// 	 }
//       }
//       else {
// 	 LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }

      LesHouchesOutfile << "   80  1     # SPheno Exit wit hnon-zero-value for sure!!" << endl;
      if ( yySPhenoOldInputFile != "") {
	LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	LesHouchesOutfile << yySPhenoOldInputFile << endl;
      }
   }
		else if( yyCalculator == SOFTSUSY ) {
			//ADD BLOCK SOFTSUSY
			LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
			LesHouchesOutfile << "    1   0.1           # desired fractional accuracy in output " << endl;
			LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
			LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caculaltion " << endl;
			//LesHouchesOutfile << "    4   1000.0	      # change electroweak symmetry breaking scale " << endl;
			LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
		}	
	}


   else if (yyFitModel == NONUNIVSIMPLIFIED) {

      LesHouchesOutfile << "BLOCK MODSEL                 # Select model"     << endl;
      LesHouchesOutfile << "    1  1                     # mSugra (NONUNIVSIMPLIFIED)" << endl;
      if ( yyUseFullCKMMatrix ) {
	 LesHouchesOutfile << "    5  1                 # CP violation (0,1,2)=(none, CKM, general SUSY)" << endl;
	 LesHouchesOutfile << "    6  1                 # Flavour violation in quark sector" << endl;
      }
      if (FindInFixed("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
      }
      else if (FindInFitted("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	 }
      } 
      else if (FindInUniversality("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	 }
      }      
      /*
			else {
	LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
      }
			*/

      LesHouchesOutfile << "BLOCK SMINPUTS               # Standard Model inputs" << endl;
      if (FindInFixed("alphaem")) {
	 LesHouchesOutfile << "    1 " <<ReturnFixedValue("alphaem")->value << " # 1/alpha_em (fixed)" << endl;
      }
      else if (FindInFitted("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition("alphaem")]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	 }
      } 
      else if (FindInUniversality("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    1  "<<ReturnMeasuredValue("alphaem")->value<<" # 1/alpha_em(M_Z) (fixed)"<<endl;
      }

      /*
	 if (FindInFixed("G_F")) {
	 LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
	 }
	 else if (FindInFitted("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	 cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
	 }
	 } 
	 else if (FindInUniversality("G_F")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	 cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
	 }
	 }
	 else {
	 LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value<<" # G_F (fixed)"<<endl;
	 }
	 */
      if (FindInFixed("alphas")) {
	 LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }
      else if (FindInFitted("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	 }
      } 
      else if (FindInUniversality("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }


      if (FindInFixed("massZ")) {
	 LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }
      else if (FindInFitted("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	 }
      } 
      else if (FindInUniversality("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }

      if (FindInFixed("massBottom")) {
	 LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }
      else if (FindInFitted("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	 }
      } 
      else if (FindInUniversality("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }


      if (FindInFixed("massTop")) {
	 LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }
      else if (FindInFitted("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mTop " << x[ReturnFittedPosition("massTop")] << endl;
	 }
      } 
      else if (FindInUniversality("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }

      if (FindInFixed("massTau")) {
	 LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }
      else if (FindInFitted("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
      } 
      else if (FindInUniversality("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }


         if (FindInFixed("massCharm")) {
           LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
         }
         else if (FindInFitted("massCharm")) {
           LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	     cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	   }
         } 
         else if (FindInUniversality("massCharm")) {
           LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	     cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	   }
         }
         else {
           LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
         }

      if ( yyUseFullCKMMatrix ) {
	 // VCKM
	 LesHouchesOutfile << "BLOCK VCKMIN"               << endl;
	 LesHouchesOutfile << "    1  0.2292    # theta12" << endl;
	 LesHouchesOutfile << "    2  0.04224   # theta23" << endl;
	 LesHouchesOutfile << "    3  0.0038903 # theta13" << endl;
	 LesHouchesOutfile << "    4  0.9944    # delta"   << endl; // set CKM phase (rad), SPheno default value = 0
	 //    LesHouchesOutfile << "    4  0.0 # delta" << endl; // set CKM phase (rad), SPheno default value = 0
      }

      LesHouchesOutfile<<"BLOCK MINPAR                 # Input parameters"<<endl;


      if (FindInFixed("TanBeta")) {
	 LesHouchesOutfile << "    3  "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
      }
      else if (FindInFitted("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random tanb " << x[ReturnRandomPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnRandomPosition("TanBeta")]<<" # tanb (random)"<< endl;
      }
      else if (FindInUniversality("TanBeta")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	 }
      }
      else {
	 cerr << "b-Parameter TanBeta not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("SignMu") && TMath::Abs(ReturnFixedValue("SignMu")->value) == 1 ) {
	 LesHouchesOutfile << "    4  "<< ReturnFixedValue("SignMu")->value <<" # sign(mu) (fixed)"<< endl;
      }
      else {
	 cerr<<"SignMu must be fixed to either 1 or -1"<<endl;
	 exit(EXIT_FAILURE);
      }

      if (FindInFixed("A0")) {
	 LesHouchesOutfile << "    5  "<< ReturnFixedValue("A0")->value <<" # A0 (fixed)"<< endl;
      }
      else if (FindInFitted("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting A0 " << x[ReturnFittedPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnFittedPosition("A0")]<<" # A0"<< endl;
      } 
      else if (FindInRandomPar("A0")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random A0 " << x[ReturnRandomPosition("A0")] << endl;
	 }
	 LesHouchesOutfile << "    5  "<< x[ReturnRandomPosition("A0")]<<" # A0 (random)"<< endl;
      }

      else if (FindInUniversality("A0")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("A0")->universality)]<<" # A0"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("A0")->universality << " instead of A0" << endl;
	 }
      }
      else {
	 cerr << "Parameter A0 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // BLOCK EXTPAR
      LesHouchesOutfile << "BLOCK EXTPAR" << endl;
      //      LesHouchesOutfile << "    0  1000. # Input scale for mSUGRA" << endl;
      // M1
      if (FindInFixed("M1")) {
	 LesHouchesOutfile << "    1  " << ReturnFixedValue("M1")->value << " # M1(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M1 " << x[ReturnFittedPosition("M1")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnFittedPosition("M1")] << " # M1(M_GUT)" << endl;
      } 
      else if (FindInRandomPar("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M1 " << x[ReturnRandomPosition("M1")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnRandomPosition("M1")] << " # M1(M_GUT) (random)" << endl;
      } 
      else if (FindInUniversality("M1")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M1")->universality << " instead of M1" << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnFittedPosition(ReturnUniversality("M1")->universality)] << " # M1(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M1 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      // M2
      if (FindInFixed("M2")) {
	 LesHouchesOutfile << "    2  " << ReturnFixedValue("M2")->value << " # M2(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M2 " << x[ReturnFittedPosition("M2")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnFittedPosition("M2")] << " # M2(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M2 " << x[ReturnRandomPosition("M2")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnRandomPosition("M2")] << " # M2(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M2")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M2")->universality << " instead of M2" << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnFittedPosition(ReturnUniversality("M2")->universality)] << " # M2(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M2 not declared" << endl;
	 exit (EXIT_FAILURE);
      }
      // M3
      if (FindInFixed("M3")) {
	 LesHouchesOutfile << "    3  " << ReturnFixedValue("M3")->value << " # M3(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M3 " << x[ReturnFittedPosition("M3")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition("M3")] << " # M3(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M3 " << x[ReturnRandomPosition("M3")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("M3")] << " # M3(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M3")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M3")->universality << " instead of M3" << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnFittedPosition(ReturnUniversality("M3")->universality)] << " # M3(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M3 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // M0H
      if (FindInFixed("M0H")) {
	 LesHouchesOutfile << "   21  " << ReturnFixedValue("M0H")->value << " # M^2_Hd(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   22  " << ReturnFixedValue("M0H")->value << " # M^2_Hu(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M0H")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M0H " << x[ReturnFittedPosition("M0H")] << endl;
	 }
	 LesHouchesOutfile << "   21  " << x[ReturnFittedPosition("M0H")] << " # M^2_Hd(M_GUT)" << endl;
	 LesHouchesOutfile << "   22  " << x[ReturnFittedPosition("M0H")] << " # M^2_Hu(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M0H")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M0H " << x[ReturnRandomPosition("M0H")] << endl;
	 }
	 LesHouchesOutfile << "   21  " << x[ReturnRandomPosition("M0H")] << " # M^2_Hd(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   22  " << x[ReturnRandomPosition("M0H")] << " # M^2_Hu(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M0H")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M0H")->universality << " instead of M0H" << endl;
	 }
	 LesHouchesOutfile << "   21  " << x[ReturnFittedPosition(ReturnUniversality("M0H")->universality)] << " # M^2_Hd(M_GUT)" << endl;
	 LesHouchesOutfile << "   22  " << x[ReturnFittedPosition(ReturnUniversality("M0H")->universality)] << " # M^2_Hu(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M0H not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // M05
      if (FindInFixed("M05")) {
	 LesHouchesOutfile << "   31  " << ReturnFixedValue("M05")->value << " # M_L_11(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   32  " << ReturnFixedValue("M05")->value << " # M_L_22(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   33  " << ReturnFixedValue("M05")->value << " # M_L_33(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   47  " << ReturnFixedValue("M05")->value << " # M_D_11(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   48  " << ReturnFixedValue("M05")->value << " # M_D_22(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   49  " << ReturnFixedValue("M05")->value << " # M_D_33(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M05")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M05 " << x[ReturnFittedPosition("M05")] << endl;
	 }
	 LesHouchesOutfile << "   31  " << x[ReturnFittedPosition("M05")] << " # M_L_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   32  " << x[ReturnFittedPosition("M05")] << " # M_L_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   33  " << x[ReturnFittedPosition("M05")] << " # M_L_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   47  " << x[ReturnFittedPosition("M05")] << " # M_D_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   48  " << x[ReturnFittedPosition("M05")] << " # M_D_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   49  " << x[ReturnFittedPosition("M05")] << " # M_D_33(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M05")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M05 " << x[ReturnRandomPosition("M05")] << endl;
	 }
	 LesHouchesOutfile << "   31  " << x[ReturnRandomPosition("M05")] << " # M_L_11(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   32  " << x[ReturnRandomPosition("M05")] << " # M_L_22(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   33  " << x[ReturnRandomPosition("M05")] << " # M_L_33(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   47  " << x[ReturnRandomPosition("M05")] << " # M_D_11(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   48  " << x[ReturnRandomPosition("M05")] << " # M_D_22(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   49  " << x[ReturnRandomPosition("M05")] << " # M_D_33(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M05")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M05")->universality << " instead of M05" << endl;
	 }
	 LesHouchesOutfile << "   31  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_L_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   32  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_L_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   33  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_L_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   47  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_D_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   48  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_D_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   49  " << x[ReturnFittedPosition(ReturnUniversality("M05")->universality)] << " # M_D_33(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M05 not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      // M010
      if (FindInFixed("M010")) {
	 LesHouchesOutfile << "   34  " << ReturnFixedValue("M010")->value << " # M_E_11(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   35  " << ReturnFixedValue("M010")->value << " # M_E_22(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   36  " << ReturnFixedValue("M010")->value << " # M_E_33(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   41  " << ReturnFixedValue("M010")->value << " # M_Q_11(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   42  " << ReturnFixedValue("M010")->value << " # M_Q_22(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   43  " << ReturnFixedValue("M010")->value << " # M_Q_33(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   44  " << ReturnFixedValue("M010")->value << " # M_U_11(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   45  " << ReturnFixedValue("M010")->value << " # M_U_22(M_GUT) (fixed)" << endl;
	 LesHouchesOutfile << "   46  " << ReturnFixedValue("M010")->value << " # M_U_33(M_GUT) (fixed)" << endl;
      }    
      else if (FindInFitted("M010")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting M010 " << x[ReturnFittedPosition("M010")] << endl;
	 }
	 LesHouchesOutfile << "   34  " << x[ReturnFittedPosition("M010")] << " # M_E_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   35  " << x[ReturnFittedPosition("M010")] << " # M_E_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   36  " << x[ReturnFittedPosition("M010")] << " # M_E_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   41  " << x[ReturnFittedPosition("M010")] << " # M_Q_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   42  " << x[ReturnFittedPosition("M010")] << " # M_Q_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   43  " << x[ReturnFittedPosition("M010")] << " # M_Q_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   44  " << x[ReturnFittedPosition("M010")] << " # M_U_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   45  " << x[ReturnFittedPosition("M010")] << " # M_U_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   46  " << x[ReturnFittedPosition("M010")] << " # M_U_33(M_GUT)" << endl;
      }
      else if (FindInRandomPar("M010")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random M010 " << x[ReturnRandomPosition("M010")] << endl;
	 }
	 LesHouchesOutfile << "   34  " << x[ReturnRandomPosition("M010")] << " # M_E_11(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   35  " << x[ReturnRandomPosition("M010")] << " # M_E_22(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   36  " << x[ReturnRandomPosition("M010")] << " # M_E_33(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   41  " << x[ReturnRandomPosition("M010")] << " # M_Q_11(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   42  " << x[ReturnRandomPosition("M010")] << " # M_Q_22(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   43  " << x[ReturnRandomPosition("M010")] << " # M_Q_33(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   44  " << x[ReturnRandomPosition("M010")] << " # M_U_11(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   45  " << x[ReturnRandomPosition("M010")] << " # M_U_22(M_GUT) (random)" << endl;
	 LesHouchesOutfile << "   46  " << x[ReturnRandomPosition("M010")] << " # M_U_33(M_GUT) (random)" << endl;
      }
      else if (FindInUniversality("M010")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("M010")->universality << " instead of M010" << endl;
	 }
	 LesHouchesOutfile << "   34  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_E_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   35  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_E_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   36  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_E_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   41  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_Q_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   42  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_Q_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   43  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_Q_33(M_GUT)" << endl;
	 LesHouchesOutfile << "   44  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_U_11(M_GUT)" << endl;
	 LesHouchesOutfile << "   45  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_U_22(M_GUT)" << endl;
	 LesHouchesOutfile << "   46  " << x[ReturnFittedPosition(ReturnUniversality("M010")->universality)] << " # M_U_33(M_GUT)" << endl;
      }
      else {
	 cerr << "Parameter M010 not declared" << endl;
	 exit (EXIT_FAILURE);
      }



      // BLOCK SPhenoInput
      if( yyCalculator == SPHENO ) {
	if (yySPhenoStartDataString!="" && yySPhenoLastCallValid) {
	  LesHouchesOutfile << "BLOCK StartDataFile" << endl;
	  LesHouchesOutfile << "    " << yySPhenoStartDataString << endl;
	}
      LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
      LesHouchesOutfile << "    1  0                  # error level" << endl;
      LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
      LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
      LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
      if (yyCalculateSPhenoCrossSections) {
	LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
      } else {
	LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
      }
      for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
	 LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
	 LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
	 LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	 if (!yyISR) {
	    LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
	 } else {
	    LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	 }
      }
      LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
      LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
      LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
      // LesHouchesOutfile << "#   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

//       if (FindInFixed("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }
//       else if (FindInFitted("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
// 	 }
//       } 
//       else if (FindInUniversality("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
// 	 }
//       }
//       else {
// 	 LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }

      LesHouchesOutfile << "   80  1     # SPheno Exit wit hnon-zero-value for sure!!" << endl;
      if ( yySPhenoOldInputFile != "") {
	LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	LesHouchesOutfile << yySPhenoOldInputFile << endl;
      }
   }
		else if( yyCalculator == SOFTSUSY ) {
			//ADD BLOCK SOFTSUSY
			LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
			LesHouchesOutfile << "    1   0.1           # desired fractional accuracy in output " << endl;
			LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
			LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caculaltion " << endl;
			//LesHouchesOutfile << "    4   1000.0	      # change electroweak symmetry breaking scale " << endl;
			LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
		}	
	}





   else if (yyFitModel == GMSB) {

      LesHouchesOutfile<<"BLOCK MODSEL                 # Select model"<<endl;
      LesHouchesOutfile<<" 1    2                      # GMSB"<<endl;
      if (FindInFixed("QEWSB")) {
	 LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
      }
      else if (FindInFitted("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	 }
      } 
      else if (FindInUniversality("QEWSB")) {
	 LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	 }
      }     
			/*
      else {
	LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
      }
			*/

      LesHouchesOutfile<<"BLOCK SMINPUTS               # Standard Model inputs"<<endl;
      if (FindInFixed("alphaem")) {
	 LesHouchesOutfile << "    1 "<<ReturnFixedValue("alphaem")->value<<" # 1/alpha_em (fixed)"<<endl;
      }
      else if (FindInFitted("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition("alphaem")]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	 }
      } 
      else if (FindInUniversality("alphaem")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fiting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    1  "<<ReturnMeasuredValue("alphaem")->value<<" # 1/alpha_em(M_Z) (fixed)"<<endl;
      }

      /* Philip: put that in again */
      if (FindInFixed("G_F")) {
	LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
      }
      else if (FindInFitted("G_F")) {
	LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
	}
      } 
      else if (FindInUniversality("G_F")) {
	LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
	if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	  cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
	}
      }
      else {
	LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value<<" # G_F (fixed)"<<endl;
      }
      /* end */

      if (FindInFixed("alphas")) {
	 LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }
      else if (FindInFitted("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	 }
      } 
      else if (FindInUniversality("alphas")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
      }


      if (FindInFixed("massZ")) {
	 LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }
      else if (FindInFitted("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	 }
      } 
      else if (FindInUniversality("massZ")) {
	 LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
      }

      if (FindInFixed("massBottom")) {
	 LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }
      else if (FindInFitted("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	 }
      } 
      else if (FindInUniversality("massBottom")) {
	 LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
      }


      if (FindInFixed("massTop")) {
	 LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }
      else if (FindInFitted("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting mTop " << x[ReturnFittedPosition("massTop")] << endl;
	 }
      } 
      else if (FindInUniversality("massTop")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
      }

      if (FindInFixed("massTau")) {
	 LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }
      else if (FindInFitted("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
      } 
      else if (FindInUniversality("massTau")) {
	 LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	 }
      }
      else {
	 LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
      }


         if (FindInFixed("massCharm")) {
           LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
         }
         else if (FindInFitted("massCharm")) {
           LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	     cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	   }
         } 
         else if (FindInUniversality("massCharm")) {
           LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	   if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	     cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	   }
	 }
         else {
           LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
         }

      LesHouchesOutfile<<"BLOCK MINPAR                 # Input parameters"<<endl;

      if (FindInFixed("TanBeta")) {
	 LesHouchesOutfile << "    3  "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
      }
      else if (FindInFitted("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
      } 
      else if (FindInRandomPar("TanBeta")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random TanBeta " << x[ReturnRandomPosition("TanBeta")] << endl;
	 }
	 LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("TanBeta")] << " # TanBeta (random)" << endl;
      }
      else if (FindInUniversality("TanBeta")) {
	 LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	 }
      }
      else {
	 cerr << "c-Parameter TanBeta not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("Lambda")) {
	 LesHouchesOutfile << "    1  "<< ReturnFixedValue("Lambda")->value <<" # Lambda (fixed)"<< endl;
      }
      else if (FindInFitted("Lambda")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Lambda " << x[ReturnFittedPosition("Lambda")] << endl;
	 }
	 LesHouchesOutfile << "    1  "<< x[ReturnFittedPosition("Lambda")]<<" # Lambda"<< endl;
      } 
      else if (FindInRandomPar("Lambda")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Lambda " << x[ReturnRandomPosition("Lambda")] << endl;
	 }
	 LesHouchesOutfile << "    1  " << x[ReturnRandomPosition("Lambda")] << " # Lambda (random)" << endl;
      }
      else if (FindInUniversality("Lambda")) {
	 LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("Lambda")->universality)]<<" # Lambda"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Lambda")->universality << " instead of Lambda" << endl;
	 }
      }
      else {
	 cerr << "Parameter Lambda not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("Mmess")) {
	 LesHouchesOutfile << "    2  "<< ReturnFixedValue("Mmess")->value <<" # Mmess (fixed)"<< endl;
      }
      else if (FindInFitted("Mmess")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting Mmess " << x[ReturnFittedPosition("Mmess")] << endl;
	 }
	 LesHouchesOutfile << "    2  "<< x[ReturnFittedPosition("Mmess")]<<" # Mmess"<< endl;
      } 
      else if (FindInRandomPar("Mmess")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random Mmess " << x[ReturnRandomPosition("Mmess")] << endl;
	 }
	 LesHouchesOutfile << "    2  " << x[ReturnRandomPosition("Mmess")] << " # Mmess (random)" << endl;
      }
      else if (FindInUniversality("Mmess")) {
	 LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("Mmess")->universality)]<<" # Mmess"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("Mmess")->universality << " instead of Mmess" << endl;
	 }
      }
      else {
	 cerr << "Parameter Mmess not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("cGrav")) {
	 LesHouchesOutfile << "    6  "<< ReturnFixedValue("cGrav")->value <<" # cGrav (fixed)"<< endl;
      }
      else if (FindInFitted("cGrav")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Fitting cGrav " << x[ReturnFittedPosition("cGrav")] << endl;
	 }
	 LesHouchesOutfile << "    6  "<< x[ReturnFittedPosition("cGrav")]<<" # cGrav"<< endl;
      } 
      else if (FindInRandomPar("cGrav")) {
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "Calculating random cGrav" << x[ReturnRandomPosition("cGrav")] << endl;
	 }
	 LesHouchesOutfile << "    6  " << x[ReturnRandomPosition("cGrav")] << " # cGrav (random)" << endl;
      }
      else if (FindInUniversality("cGrav")) {
	 LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("cGrav")->universality)]<<" # cGrav"<<endl;
	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
	    cout << "fitting " << ReturnUniversality("cGrav")->universality << " instead of cGrav" << endl;
	 }
      }
      else {
	 cerr << "Parameter cGrav not declared" << endl;
	 exit (EXIT_FAILURE);
      }

      if (FindInFixed("SignMu") && TMath::Abs(ReturnFixedValue("SignMu")->value) == 1 ) {
	 LesHouchesOutfile << "    4  "<< ReturnFixedValue("SignMu")->value <<" # sign(mu) (fixed)"<< endl;
      }
      else {
	 cerr<<"SignMu must be fixed to either 1 or -1"<<endl;
	 exit(EXIT_FAILURE);
      }

      if (FindInFixed("N5")) {
	 LesHouchesOutfile << "    5  "<< ReturnFixedValue("N5")->value <<" # N5 (fixed)"<< endl;
      }
      else {
	 cerr<<"N5 must be fixed to an integer number"<<endl;
	 exit(EXIT_FAILURE);
      }
      if( yyCalculator == SPHENO ) {
	if (yySPhenoStartDataString!="" && yySPhenoLastCallValid) {
	  LesHouchesOutfile << "BLOCK StartDataFile" << endl;
	  LesHouchesOutfile << "    " << yySPhenoStartDataString << endl;
	}
      LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
      LesHouchesOutfile << "    1  0                  # error level" << endl;
      LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
      LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
      LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
      if (yyCalculateSPhenoCrossSections) {
	LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
      } else {
	LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
      }
      for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
	 LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
	 LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
	 LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	 if (!yyISR) {
	    LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
	 } else {
	    LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	 }
      }
      LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
      LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
      LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
      // LesHouchesOutfile << "   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

//       if (FindInFixed("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }
//       else if (FindInFitted("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
// 	 }
//       } 
//       else if (FindInUniversality("massCharm")) {
// 	 LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 	 if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 	    cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
// 	 }
//       }
//       else {
// 	 LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
//       }

      LesHouchesOutfile << "   80  1     # SPheno Exit wit hnon-zero-value for sure!!" << endl;
      if ( yySPhenoOldInputFile != "") {
	LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	LesHouchesOutfile << yySPhenoOldInputFile << endl;
      }
   }
	else if( yyCalculator == SOFTSUSY ) {
  	//ADD BLOCK SOFTSUSY
		LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
		LesHouchesOutfile << "    1   0.1           # desired fractional accuracy in output " << endl;
		LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
		LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caclualtion " << endl;
		//LesHouchesOutfile << "    4  	1.0		    # change electroweak symmetry breaking scale " << endl;
		LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
	}
}
	 else if (yyFitModel == AMSB) {

	    LesHouchesOutfile<<"BLOCK MODSEL                 # Select model"<<endl;
	    LesHouchesOutfile<<" 1    3                      # AMSB"<<endl;
	    if (FindInFixed("QEWSB")) {
	      LesHouchesOutfile << "    12  "<<ReturnFixedValue("QEWSB")->value<<" # Q_EWSB (fixed)"<<endl;
	    }
	    else if (FindInFitted("QEWSB")) {
	      LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition("QEWSB")]<<" # Q_EWSB"<<endl;
	      if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		cout << "Fitting Q_EWSB " << x[ReturnFittedPosition("QEWSB")] << endl;
	      }
	    } 
	    else if (FindInUniversality("QEWSB")) {
	      LesHouchesOutfile << "   12  "<<x[ReturnFittedPosition(ReturnUniversality("QEWSB")->universality)]<<" # Q_EWSB"<<endl;
	      if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		cout << "fitting " << ReturnUniversality("QEWSB")->universality << " instead of QEWSB" << endl;
	      }
	    }     
			/*
	    else {
	      LesHouchesOutfile << "    12   1000.    # Q_EWSB (fixed)"<<endl;
	    }
			*/

	    LesHouchesOutfile<<"BLOCK SMINPUTS               # Standard Model inputs"<<endl;
	    if (FindInFixed("alphaem")) {
	       LesHouchesOutfile << "    1 "<<ReturnFixedValue("alphaem")->value<<" # 1/alpha_em (fixed)"<<endl;
	    }
	    else if (FindInFitted("alphaem")) {
	       LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition("alphaem")]<<" # 1/alpha_em(M_Z)"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting alphaem " << x[ReturnFittedPosition("alphaem")] << endl;
	       }
	    } 
	    else if (FindInUniversality("alphaem")) {
	       LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("alphaem")->universality)]<<" # 1/alpha_em(M_Z)"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fiting " << ReturnUniversality("alphaem")->universality << " instead of alphaem" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    1  "<<ReturnMeasuredValue("alphaem")->value<<" # 1/alpha_em(M_Z) (fixed)"<<endl;
	    }

	    /*
	       if (FindInFixed("G_F")) {
	       LesHouchesOutfile << "    2  "<<ReturnFixedValue("G_F")->value<<" # G_F (fixed)"<<endl;
	       }
	       else if (FindInFitted("G_F")) {
	       LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition("G_F")]<<" # G_F"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	       cout << "Fitting G_F " << x[ReturnFittedPosition("G_F")] << endl;
	       }
	       } 
	       else if (FindInUniversality("G_F")) {
	       LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("G_F")->universality)]<<" # G_F"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/10. ) - (n_printouts+1)/10 ) < 0.01 ) ) { 
	       cout << "fitting " << ReturnUniversality("G_F")->universality << " instead of G_F" << endl;
	       }
	       }
	       else {
	       LesHouchesOutfile << "    2  "<<ReturnMeasuredValue("G_F")->value<<" # G_F (fixed)"<<endl;
	       }
	       */
	    if (FindInFixed("alphas")) {
	       LesHouchesOutfile << "    3  "<<ReturnFixedValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
	    }
	    else if (FindInFitted("alphas")) {
	       LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition("alphas")]<<" # alpha_s"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting alphas " << x[ReturnFittedPosition("alphas")] << endl;
	       }
	    } 
	    else if (FindInUniversality("alphas")) {
	       LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("alphas")->universality)]<<" # alpha_ss"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("alphas")->universality << " instead of alphas" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    3  "<<ReturnMeasuredValue("alphas")->value<<" # alpha_s (fixed)"<<endl;
	    }


	    if (FindInFixed("massZ")) {
	       LesHouchesOutfile << "    4  "<<ReturnFixedValue("massZ")->value<<" # mZ (fixed)"<<endl;
	    }
	    else if (FindInFitted("massZ")) {
	       LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition("massZ")]<<" # mZ"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting massZ " << x[ReturnFittedPosition("massZ")] << endl;
	       }
	    } 
	    else if (FindInUniversality("massZ")) {
	       LesHouchesOutfile << "    4  "<<x[ReturnFittedPosition(ReturnUniversality("massZ")->universality)]<<" # massZ"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("massZ")->universality << " instead of massZ" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    4  "<<ReturnMeasuredValue("massZ")->value<<" # mZ (fixed)"<<endl;
	    }

	    if (FindInFixed("massBottom")) {
	       LesHouchesOutfile << "    5  "<<ReturnFixedValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
	    }
	    else if (FindInFitted("massBottom")) {
	       LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition("massBottom")]<<" # mb(mb)"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting mBottom " << x[ReturnFittedPosition("massBottom")] << endl;
	       }
	    } 
	    else if (FindInUniversality("massBottom")) {
	       LesHouchesOutfile << "    5  "<<x[ReturnFittedPosition(ReturnUniversality("massBottom")->universality)]<<" # massBottom"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("massBottom")->universality << " instead of massBottom" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    5  "<<ReturnMeasuredValue("massBottom")->value<<" # mb(mb) (fixed)"<<endl;
	    }


	    if (FindInFixed("massTop")) {
	       LesHouchesOutfile << "    6  "<<ReturnFixedValue("massTop")->value<<" # mtop (fixed)"<<endl;
	    }
	    else if (FindInFitted("massTop")) {
	       LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition("massTop")]<<" # mtop"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting mTop " << x[ReturnFittedPosition("massTop")] << endl;
	       }
	    } 
	    else if (FindInUniversality("massTop")) {
	       LesHouchesOutfile << "    6  "<<x[ReturnFittedPosition(ReturnUniversality("massTop")->universality)]<<" # massTop"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("massTop")->universality << " instead of massTop" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    6  "<<ReturnMeasuredValue("massTop")->value<<" # mtop (fixed)"<<endl;
	    }

	    if (FindInFixed("massTau")) {
	       LesHouchesOutfile << "    7  "<<ReturnFixedValue("massTau")->value<<" # mtau (fixed)"<<endl;
	    }
	    else if (FindInFitted("massTau")) {
	       LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition("massTau")]<<" # mtau"<<endl;
	    } 
	    else if (FindInUniversality("massTau")) {
	       LesHouchesOutfile << "    7  "<<x[ReturnFittedPosition(ReturnUniversality("massTau")->universality)]<<" # massTau"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("massTau")->universality << " instead of massTau" << endl;
	       }
	    }
	    else {
	       LesHouchesOutfile << "    7  "<<ReturnMeasuredValue("massTau")->value<<" # mtau (fixed)"<<endl;
	    }


	    if (FindInFixed("massCharm")) {
	      LesHouchesOutfile << "    24  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
	    }
	    else if (FindInFitted("massCharm")) {
	      LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
	      if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
	      } 
	    }
	    else if (FindInUniversality("massCharm")) {
	      LesHouchesOutfile << "    24  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
	      if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
	      }
	    }
	    else {
	      LesHouchesOutfile << "    24  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
	    }


	    LesHouchesOutfile<<"BLOCK MINPAR                 # Input parameters"<<endl;

	    if (FindInFixed("TanBeta")) {
	       LesHouchesOutfile << "    3  "<< ReturnFixedValue("TanBeta")->value <<" # tanb (fixed)"<< endl;
	    }
	    else if (FindInFitted("TanBeta")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting tanb " << x[ReturnFittedPosition("TanBeta")] << endl;
	       }
	       LesHouchesOutfile << "    3  "<< x[ReturnFittedPosition("TanBeta")]<<" # tanb"<< endl;
	    } 
	    else if (FindInRandomPar("TanBeta")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Calculating random TanBeta " << x[ReturnRandomPosition("TanBeta")] << endl;
	       }
	       LesHouchesOutfile << "    3  " << x[ReturnRandomPosition("TanBeta")] << " # TanBeta (random)" << endl;
	    }
	    else if (FindInUniversality("TanBeta")) {
	       LesHouchesOutfile << "    3  "<<x[ReturnFittedPosition(ReturnUniversality("TanBeta")->universality)]<<" # TanBeta"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("TanBeta")->universality << " instead of TanBeta" << endl;
	       }
	    }
	    else {
	       cerr << "d-Parameter TanBeta not declared" << endl;
	       exit (EXIT_FAILURE);
	    }

	    if (FindInFixed("M0")) {
	       LesHouchesOutfile << "    1  "<< ReturnFixedValue("M0")->value <<" # M0 (fixed)"<< endl;
	    }
	    else if (FindInFitted("M0")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting M0 " << x[ReturnFittedPosition("M0")] << endl;
	       }
	       LesHouchesOutfile << "    1  "<< x[ReturnFittedPosition("M0")]<<" # M0"<< endl;
	    } 
	    else if (FindInRandomPar("M0")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Calculating random M0 " << x[ReturnRandomPosition("M0")] << endl;
	       }
	       LesHouchesOutfile << "    1  " << x[ReturnRandomPosition("M0")] << " # M0 (random)" << endl;
	    }
	    else if (FindInUniversality("M0")) {
	       LesHouchesOutfile << "    1  "<<x[ReturnFittedPosition(ReturnUniversality("M0")->universality)]<<" # M0"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("M0")->universality << " instead of M0" << endl;
	       }
	    }
	    else {
	       cerr << "Parameter M0 not declared" << endl;
	       exit (EXIT_FAILURE);
	    }

	    if (FindInFixed("M32")) {
	       LesHouchesOutfile << "    2  "<< ReturnFixedValue("M32")->value <<" # M32 (fixed)"<< endl;
	    }
	    else if (FindInFitted("M32")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Fitting M32 " << x[ReturnFittedPosition("M32")] << endl;
	       }
	       LesHouchesOutfile << "    2  "<< x[ReturnFittedPosition("M32")]<<" # M32"<< endl;
	    } 
	    else if (FindInRandomPar("M32")) {
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "Calculating random M32 " << x[ReturnRandomPosition("M32")] << endl;
	       }
	       LesHouchesOutfile << "    2  " << x[ReturnRandomPosition("M32")] << " # M32 (random)" << endl;
	    }
	    else if (FindInUniversality("M32")) {
	       LesHouchesOutfile << "    2  "<<x[ReturnFittedPosition(ReturnUniversality("M32")->universality)]<<" # M32"<<endl;
	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
		  cout << "fitting " << ReturnUniversality("M32")->universality << " instead of M32" << endl;
	       }
	    }
	    else {
	       cerr << "Parameter M32 not declared" << endl;
	       exit (EXIT_FAILURE);
	    }

	    if (FindInFixed("SignMu") && TMath::Abs(ReturnFixedValue("SignMu")->value) == 1 ) {
	       LesHouchesOutfile << "    4  "<< ReturnFixedValue("SignMu")->value <<" # sign(mu) (fixed)"<< endl;
	    }
	    else {
	       cerr<<"SignMu must be fixed to either 1 or -1"<<endl;
	       exit(EXIT_FAILURE);
	    }
	    if( yyCalculator == SPHENO ) {
	      if (yySPhenoStartDataString!="" && yySPhenoLastCallValid) {
		LesHouchesOutfile << "BLOCK StartDataFile" << endl;
		LesHouchesOutfile << "    " << yySPhenoStartDataString << endl;
	      }
	    LesHouchesOutfile << "BLOCK SPHENOINPUT" << endl;
	    LesHouchesOutfile << "    1  0                  # error level" << endl;
	    LesHouchesOutfile << "    2  0                  # if 1, then SPA conventions are used" << endl;
	    LesHouchesOutfile << "   11  1                  # calculate branching ratios" << endl;
	    LesHouchesOutfile << "   12  1.00000000E-04     # write only branching ratios larger than this value" << endl;
	    if (yyCalculateSPhenoCrossSections) {
	      LesHouchesOutfile << "   21  1                  # calculate cross section" << endl;
	    } else {
	      LesHouchesOutfile << "   21  0                  # calculate cross section" << endl;
	    }
	    for (unsigned int j = 0; j < CrossSectionProduction.size(); j++) {
	       LesHouchesOutfile << "   22  " << CrossSectionProduction[j][0] << "     # cms energy in GeV" << endl;
	       LesHouchesOutfile << "   23  " << CrossSectionProduction[j][1] << "     # polarisation of incoming e- beam" << endl;
	       LesHouchesOutfile << "   24  " << CrossSectionProduction[j][2] << "     # polarisation of incoming e+ beam" << endl;
	       if (!yyISR) {
		  LesHouchesOutfile << "   25  0                  # no ISR is calculated" << endl;
	       } else {
		  LesHouchesOutfile << "   25  1                  # ISR is calculated" << endl;
	       }
	    }
	    LesHouchesOutfile << "   26  1.00000000E-05     # write only cross sections larger than this value [fb]" << endl;
	    LesHouchesOutfile << "   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2" << endl;
	    LesHouchesOutfile << "   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set " << endl;
	    // LesHouchesOutfile << "   33  1000.              #  Q_EWSB, if < 0 than  Q_EWSB=sqrt(m_~t1 m_~t2) " << endl;

// 	    if (FindInFixed("massCharm")) {
// 	       LesHouchesOutfile << "   63  "<<ReturnFixedValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
// 	    }
// 	    else if (FindInFitted("massCharm")) {
// 	       LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition("massCharm")]<<" # mcharm"<<endl;
// 	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 		  cout << "Fitting mCharm " << x[ReturnFittedPosition("massCharm")] << endl;
// 	       }
// 	    } 
// 	    else if (FindInUniversality("massCharm")) {
// 	       LesHouchesOutfile << "   63  "<<x[ReturnFittedPosition(ReturnUniversality("massCharm")->universality)]<<" # massCharm"<<endl;
// 	       if (yyVerbose || ( TMath::Abs( ( (float)(n_printouts+1)/100. ) - (n_printouts+1)/100 ) < 0.01 ) ) { 
// 		  cout << "fitting " << ReturnUniversality("massCharm")->universality << " instead of massCharm" << endl;
// 	       }
// 	    }
// 	    else {
// 	       LesHouchesOutfile << "   63  "<<ReturnMeasuredValue("massCharm")->value<<" # mcharm (fixed)"<<endl;
// 	    }

	    LesHouchesOutfile << "   80  1     # SPheno Exit wit hnon-zero-value for sure!!" << endl;
	    if ( yySPhenoOldInputFile != "") {
	      LesHouchesOutfile << "BLOCK STARTDATAFILE" << endl;
	      LesHouchesOutfile << yySPhenoOldInputFile << endl;
	    }
	 }
		else if( yyCalculator == SOFTSUSY ) {
		    //ADD BLOCK SOFTSUSY
		    LesHouchesOutfile << "BLOCK SOFTSUSY        #SOFTSUSY specific inputs" << endl;
		    LesHouchesOutfile << "    1   0.1           # desired fractional accuracy in output " << endl;
		    LesHouchesOutfile << "    2   -1.0           # quark mixing option " << endl;
		    LesHouchesOutfile << "    3   0.0           # gives additional verbose output during caclualtion " << endl;
		    //LesHouchesOutfile << "    4   1.0        # change electroweak symmetry breaking scale " << endl;
		    LesHouchesOutfile << "    5   1.0           # Full 2-loop running in RGEs " << endl;
		}
		}
	       else {
		  cerr << "Unknown fit model in WriteLesHouches" << endl;
		  exit(EXIT_FAILURE);
	       }

	       //close file
	       LesHouchesOutfile.close();

	       return;

}

MeasuredValue* ReturnMeasuredValue (string name)
{
   for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
      if (!yyMeasuredVec[i].name.compare(name)) {
	 return &(yyMeasuredVec[i]);
      }
   }

   cerr<<"No measured value with name "<<name<<" found"<<endl;
   exit(EXIT_FAILURE);

}

MeasuredValue* ReturnFittedValue (string name)
{
   for (unsigned int i = 0; i < yyFittedVec.size(); i++) {
      if (!yyFittedVec[i].name.compare(name)) {
	 return &(yyFittedVec[i]);
      }
   }

   cerr<<"No fitted value with name "<<name<<" found"<<endl;  
   exit(EXIT_FAILURE);

}

MeasuredValue* ReturnUniversality (string name)
{
   for (unsigned int i = 0; i < yyUniversalityVec.size(); i++) {
      if (!yyUniversalityVec[i].name.compare(name)) {
	 return &(yyUniversalityVec[i]);
      }
   }

   cerr<<"No UniversalityVec with name "<<name<<" found"<<endl;  
   exit(EXIT_FAILURE);

}

MeasuredValue* ReturnFixedValue (string name)
{
   for (unsigned int i = 0; i < yyFixedVec.size(); i++) {
      if (!yyFixedVec[i].name.compare(name)) {
	 return &(yyFixedVec[i]);
      }
   }

   cerr<<"No fixed value with name "<<name<<" found"<<endl;  
   exit(EXIT_FAILURE);

}
int ReturnFittedPosition (string name)
{
   for (unsigned int i = 0; i < yyFittedVec.size(); i++) {
      if (!yyFittedVec[i].name.compare(name)) {
	 return i;
      }
   }

   cerr<<"No fitted position with name "<<name<<" found"<<endl;
   exit(EXIT_FAILURE);

}

int ReturnRandomPosition(string name) {
   for (unsigned int i = 0; i < yyRandomPar.size(); i++) {
      if (!yyRandomPar[i].name.compare(name)) {
	 return i;
      }
   }

   cerr<<"No random position with name "<<name<<" found"<<endl;
   exit(EXIT_FAILURE);

}

bool FindInFitted (string name)
{
   for (unsigned int i = 0; i < yyFittedVec.size(); i++) {
      if (!yyFittedVec[i].name.compare(name)) {
	 //      cout << name << " found in fitted on pos " << i << endl;
	 return true;
      }
   }
   //  cout << name << " not found in fitted"<<endl;
   return false;

}
bool FindInRandomPar(string name) {
   for (unsigned int i = 0; i < yyRandomPar.size(); i++) {
      if (!yyRandomPar[i].name.compare(name)) {
	 //      cout << name << " found in random on pos " << i << endl;
	 return true;
      }
   }
   //  cout << name << " not found in random"<<endl;
   return false;

}

int FindInFittedPar (string name)
{
   for (unsigned int i = 0; i < yyFittedPar.size(); i++) {
      if (!yyFittedPar[i].name.compare(name)) {
	 //      cout << name << " found in fitted on pos " << i << endl;
	 return i;
      }
   }
   //  cout << name << " not found in fitted"<<endl;
   return -1;

}
bool FindInFixed (string name)
{
   for (unsigned int i = 0; i < yyFixedVec.size(); i++) {
      if (!yyFixedVec[i].name.compare(name)) {
	 //      cout << name << " found in fitted on pos " << i << endl;
	 return true;
      }
   }
   //  cout << name << " not found in fitted"<<endl;
   return false;

}
bool FindInUniversality (string name)
{
   for (unsigned int i = 0; i < yyUniversalityVec.size(); i++) {
      if (!yyUniversalityVec[i].name.compare(name)) {
	 //      cout << name << " found in fitted on pos " << i << endl;
	 return true;
      }
   }
   //  cout << name << " not found in fitted"<<endl;
   return false;

}

void FillFixedParameters()
{
   MeasuredValue tmpValue;

   for (unsigned int i = 0; i < yyFixedPar.size(); i++) {
      for (unsigned int j = 0; j < yyFittedPar.size(); j++) {
	 if (!yyFittedPar[j].name.compare(yyFixedPar[i].name)) {
	    cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in Fitted Par" << endl;
	    exit (EXIT_FAILURE);
	 }
      }

      for (unsigned int j = 0; j < yyUniversalityVec.size(); j++) {
	 if (!yyUniversalityVec[j].name.compare(yyFixedPar[i].name)) {
	    cerr << "Fixed Parameter " <<  yyFixedPar[i].name << " is also in universality vec" << endl;
	    exit (EXIT_FAILURE);
	 }
      }

      tmpValue.name = yyFixedPar[i].name;
      tmpValue.value = yyFixedPar[i].value;
      tmpValue.error = -1;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      yyFixedVec.push_back(tmpValue);

      if (yyVerbose){
      cout << "fixed: " << yyFixedPar[i].name << " at " << yyFixedPar[i].value << endl;
      }
   }
   
   
   //Checking out if we have Xtop and Atop both given in the input file (which will give troubles in the WriteLesHouches() function
   bool AtopUsed = ( FindInFitted("Atop") || FindInFixed("Atop") || FindInUniversality("Atop") || FindInRandomPar("Atop") ); 
   bool XtopUsed = ( FindInFitted("Xtop") || FindInFixed("Xtop") || FindInUniversality("Xtop") || FindInRandomPar("Xtop") );       
   if (AtopUsed && XtopUsed){
     cerr << "Atop and Xtop both given in the input file" << endl;     
     exit (EXIT_FAILURE);    
   }
   
   bool AbottomUsed = ( FindInFitted("Abottom") || FindInFixed("Abottom") || FindInUniversality("Abottom") || FindInRandomPar("Abottom") ); 
   bool XbottomUsed = ( FindInFitted("Xbottom") || FindInFixed("Xbottom") || FindInUniversality("Xbottom") || FindInRandomPar("Xbottom") );       
   if (AbottomUsed && XbottomUsed){
     cerr << "Abottom and Xbottom both given in the input file" << endl;     
     exit (EXIT_FAILURE);    
   }
   
   bool AtauUsed = ( FindInFitted("Atau") || FindInFixed("Atau") || FindInUniversality("Atau") || FindInRandomPar("Atau") ); 
   bool XtauUsed = ( FindInFitted("Xtau") || FindInFixed("Xtau") || FindInUniversality("Xtau") || FindInRandomPar("Xtau") );       
   if (AtauUsed && XtauUsed){
     cerr << "Atau and Xtau both given in the input file" << endl;     
     exit (EXIT_FAILURE);    
   }
   
   //If neither Atop nor Xtop are given in the input file, then we provide a "default" value for Xtop
   if ( (!AtopUsed && !XtopUsed) ) {
      tmpValue.name = "Xtop";
      tmpValue.value = 500.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }  
   if ( (!AbottomUsed && !XbottomUsed) ) {  
      tmpValue.name = "Xbottom";
      tmpValue.value = 400.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if ( (!AtauUsed && !XtauUsed) ) {  
      tmpValue.name = "Xtau";
      tmpValue.value = 300.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   
   if (!FindInFitted("massA0") && !FindInFixed("massA0") && !FindInUniversality("massA0") && !FindInRandomPar("massA0")) {  
      tmpValue.name = "massA0";
      tmpValue.value = 436.2;
      tmpValue.error = -1.;
      tmpValue.bound_low = 0.0;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = ID_A;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("Mu") && !FindInFixed("Mu") && !FindInUniversality("Mu") && !FindInRandomPar("Mu")) {  
      tmpValue.name = "Mu";
      tmpValue.value = 250.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSelectronL") && !FindInFixed("MSelectronL") && !FindInUniversality("MSelectronL") && !FindInRandomPar("MSelectronL")) {  
      tmpValue.name = "MSelectronL";
      tmpValue.value = 550.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSmuL") && !FindInFixed("MSmuL") && !FindInUniversality("MSmuL") && !FindInRandomPar("MSmuL")) {  
      tmpValue.name = "MSmuL";
      tmpValue.value = 450.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MStauL") && !FindInFixed("MStauL") && !FindInUniversality("MStauL") && !FindInRandomPar("MStauL")) {  
      tmpValue.name = "MStauL";
      tmpValue.value = 400.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSelectronR") && !FindInFixed("MSelectronR") && !FindInUniversality("MSelectronR") && !FindInRandomPar("MSelectronR")) {  
      tmpValue.name = "MSelectronR";
      tmpValue.value = 560.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSmuR") && !FindInFixed("MSmuR") && !FindInUniversality("MSmuR") && !FindInRandomPar("MSmuR")) {  
      tmpValue.name = "MSmuR";
      tmpValue.value = 460.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MStauR") && !FindInFixed("MStauR") && !FindInUniversality("MStauR") && !FindInRandomPar("MStauR")) {  
      tmpValue.name = "MStauR";
      tmpValue.value = 410.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }

   if (!FindInFitted("MSupL") && !FindInFixed("MSupL") && !FindInUniversality("MSupL") && !FindInRandomPar("MSupL")) {  
      tmpValue.name = "MSupL";
      tmpValue.value = 650.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MScharmL") && !FindInFixed("MScharmL") && !FindInUniversality("MScharmL") && !FindInRandomPar("MScharmL")) {  
      tmpValue.name = "MScharmL";
      tmpValue.value = 550.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MStopL") && !FindInFixed("MStopL") && !FindInUniversality("MStopL") && !FindInRandomPar("MStopL")) {  
      tmpValue.name = "MStopL";
      tmpValue.value = 450.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }

   if (!FindInFitted("MSupR") && !FindInFixed("MSupR") && !FindInUniversality("MSupR") && !FindInRandomPar("MSupR")) {  
      tmpValue.name = "MSupR";
      tmpValue.value = 660.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MScharmR") && !FindInFixed("MScharmR") && !FindInUniversality("MScharmR") && !FindInRandomPar("MScharmR")) {  
      tmpValue.name = "MScharmR";
      tmpValue.value = 560.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MStopR") && !FindInFixed("MStopR") && !FindInUniversality("MStopR") && !FindInRandomPar("MStopR")) {  
      tmpValue.name = "MStopR";
      tmpValue.value = 460.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }

   if (!FindInFitted("MSdownR") && !FindInFixed("MSdownR") && !FindInUniversality("MSdownR") && !FindInRandomPar("MSdownR")) {  
      tmpValue.name = "MSdownR";
      tmpValue.value = 670.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSstrangeR") && !FindInFixed("MSstrangeR") && !FindInUniversality("MSstrangeR") && !FindInRandomPar("MSstrangeR")) {  
      tmpValue.name = "MSstrangeR";
      tmpValue.value = 570.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }
   if (!FindInFitted("MSbottomR") && !FindInFixed("MSbottomR") && !FindInUniversality("MSbottomR") && !FindInRandomPar("MSbottomR")) {  
      tmpValue.name = "MSbottomR";
      tmpValue.value = 470.;
      tmpValue.error = -1.;
      tmpValue.bound_low = -1E+6;
      tmpValue.bound_up = 1E+6;
      tmpValue.id = 0;
      if (yyVerbose){
      cout<<"Setting "<<tmpValue.name<<" to default value "<<tmpValue.value<<endl;
      }
      yyFixedVec.push_back(tmpValue);
   }



   return;

}

int   ReadLesHouches()
{
   unsigned int found_prod;
   // first parse the LesHouches outfile and load predictions to maps
   if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
      cout << yyDashedLine << endl;
      cout << "Parsing the les houches file " << endl;
   }
   int rc = ParseLesHouches();
   if (yyCalculatorError) {
      cerr << "Error in ParseLesHouches, exiting ReadLesHouches" << endl;
      return 1;
   }
   if (rc > 0) {
      return rc;
   }
   vector <unsigned int> used_products;
   bool already_used = false;
   bool dependencies_theoset = false;

   if ( yyLEOCalculator == NPFITTER && yyHiggsCalculator == FEYNHIGGS ) {
     cerr << "Switched on both NPFitter and FeynHiggs" << endl;
     cerr << "This is not supported (mis-use of variables) ;-)" << endl;
     exit(1);
   }

   // test reading of low energy measurements
   //========================================
   //if (yyLEOCalculator == NOLEOCALCULATOR) {
	 if( yyCalculator == SPHENO ) {
   if (yyVerbose){
   cout << "  --->  yybsg            from SPheno:     " << yybsg    << endl;   //  1  BR(b -> s gamma) 
   cout << "  --->  yybsmm           from SPheno:     " << yybsmm   << endl;   //  2  BR(b -> s mu+ mu-)
   cout << "  --->  yyB_smm          from SPheno:     " << yyB_smm  << endl;   //  3  BR(Bs -> mu+ mu-)
   cout << "  --->  yyB_utn          from SPheno:     " << yyB_utn  << endl;   //  4  BR(B_u -> tau nu)
   cout << "  --->  yydMB_d          from SPheno:     " << yydMB_d  << endl;   //  5  |Delta(M_Bd)| [ps^-1]
   cout << "  --->  yydMB_s          from SPheno:     " << yydMB_s  << endl;   //  6  |Delta(M_Bs)| [ps^-1]
   cout << "  --->  yygmin2e         from SPheno:     " << yygmin2e << endl;   // 10  Delta(g-2)_electron
   cout << "  --->  yygmin2m         from SPheno:     " << yygmin2m << endl;   // 11  Delta(g-2)_muon
   cout << "  --->  yygmin2t         from SPheno:     " << yygmin2t << endl;   // 12  Delta(g-2)_tau
   cout << "  --->  yydrho           from SPheno:     " << yydrho   << endl;   // 30  Delta(rho_parameter)
   cout << "  --->  yyMassZ          from SPheno:     " << yyMassZ   << endl;   //
   cout << "  --->  yyG_F            from SPheno:     " << yyG_F   << endl;   //
   }
   }
	 else if( yyCalculator == SOFTSUSY ) {
		        if (yyVerbose){
	 		cout << "  --->  yyMassZ          from SoftSusy:   " << yyMassZ   << endl;   //
			cout << "  --->  yyG_F            from SoftSusy:   " << yyG_F   << endl;   //
			}
	}
	 //}
   //------------------------------------------------------------------------------------------
   if (yyRelicDensityCalculator == MICROMEGAS) {
     if (yyVerbose){
      cout << "  --->  yyOmega          from MicrOmegas: " << yyOmega  << endl;   //     relic density
     }
   }

   if ( yyHiggsCalculator == FEYNHIGGS ) {
     if (yyVerbose){
       cout << "  --->  yyMassh0_npf     from FeynHiggs:   " << yyMassh0_npf        << endl; // R(B->s gamma)  
       cout << "  --->  yyMassH0_npf     from FeynHiggs:   " << yyMassH0_npf        << endl; // R(B->s gamma)  
       cout << "  --->  yyMassA0_npf     from FeynHiggs:   " << yyMassA0_npf        << endl; // R(B->s gamma)  
       cout << "  --->  yyMassHpm_npf    from FeynHiggs:   " << yyMassHpm_npf       << endl; // R(B->s gamma)  
       cout << "  --->  yygmin2m_npf     from FeynHiggs:   " << yygmin2m_npf     << endl; // D(g-2)
       cout << "  --->  yyMassW_npf      from FeynHiggs:   " << yyMassW_npf      << endl; // m(W)
       cout << "  --->  yyBsg_npf        from FeynHiggs:   " << yyBsg_npf        << endl; // R(B->s gamma)  
       cout << "  --->  yysin_th_eff_npf from FeynHiggs:   " << yysin_th_eff_npf << endl; // sin^2ThetaEff
       cout << "  --->  yydm_s_npf       from FeynHiggs:   " << yydm_s_npf       << endl; // Delta_m (B_s,B_d)/ps-1  
     }
   }

   

   //------------------------------------------------------------------------------------------
   if (yyLEOCalculator == NPFITTER) {
      if (yyVerbose){
      cout << "  --->  yyBsg_npf        from NPFitter:   " << yyBsg_npf        << endl; // R(B->s gamma)
      cout << "  --->  yydm_s_npf       from NPFitter:   " << yydm_s_npf       << endl; // R(Delta m_s)
      cout << "  --->  yyB_smm_npf      from NPFitter:   " << yyB_smm_npf      << endl; // B(Bs->mumu)
      cout << "  --->  yyBtn_npf        from NPFitter:   " << yyBtn_npf        << endl; // R(B->tau nu)
      cout << "  --->  yyB_sXsll_npf    from NPFitter:   " << yyB_sXsll_npf    << endl; // R(Bs->Xsll)
      cout << "  --->  yyKlnu_npf       from NPFitter:   " << yyKlnu_npf       << endl; // R(K->tau nu)
      cout << "  --->  yygmin2m_npf     from NPFitter:   " << yygmin2m_npf     << endl; // D(g-2)
      cout << "  --->  yyMassW_npf      from NPFitter:   " << yyMassW_npf      << endl; // m(W)
      cout << "  --->  yysin_th_eff_npf from NPFitter:   " << yysin_th_eff_npf << endl; // sin(th_eff(Qfb))
      cout << "  --->  yyGammaZ_npf     from NPFitter:   " << yyGammaZ_npf     << endl; // Gamma(Z)
      cout << "  --->  yyR_l_npf        from NPFitter:   " << yyR_l_npf        << endl; // R_l (l=e,mu)
      cout << "  --->  yyR_b_npf        from NPFitter:   " << yyR_b_npf        << endl; // R_b
      cout << "  --->  yyR_c_npf        from NPFitter:   " << yyR_c_npf        << endl; // R_c
      cout << "  --->  yyA_fbb_npf      from NPFitter:   " << yyA_fbb_npf      << endl; // A_fb(b)
      cout << "  --->  yyA_fbc_npf      from NPFitter:   " << yyA_fbc_npf      << endl; // A_fb(c)
      cout << "  --->  yyA_b_npf        from NPFitter:   " << yyA_b_npf        << endl; // A_b
      cout << "  --->  yyA_c_npf        from NPFitter:   " << yyA_c_npf        << endl; // A_c
      cout << "  --->  yyA_l_npf        from NPFitter:   " << yyA_l_npf        << endl; // A_l(SLD)
      cout << "  --->  yyMassh0_npf     from NPFitter:   " << yyMassh0_npf     << endl; // m(h0)
      cout << "  --->  yyOmega_npf      from NPFitter:   " << yyOmega_npf      << endl; // Omega_h
      cout << "  --->  yyA_tau_npf      from NPFitter:   " << yyA_tau_npf      << endl; // A_l(P_tau)
      cout << "  --->  yyA_fbl_npf      from NPFitter:   " << yyA_fbl_npf      << endl; // A_fb(l)
      cout << "  --->  yysigma_had0_npf from NPFitter:   " << yysigma_had0_npf << endl; // sigma_had^0
      cout << "  --->  yydm_d_npf       from NPFitter:   " << yydm_d_npf       << endl; // R(Delta m_d)
      cout << "  --->  yydm_k_npf       from NPFitter:   " << yydm_k_npf       << endl; // R(Delta m_k)
      cout << "  --->  yyKppinn_npf     from NPFitter:   " << yyKppinn_npf     << endl; // R(Kp->pinn)
      cout << "  --->  yyB_dll_npf      from NPFitter:   " << yyB_dll_npf      << endl; // B(Bd->ll)
      cout << "  --->  yyDmsDmd_npf     from NPFitter:   " << yyDmsDmd_npf     << endl; // R(Dms)/R(Dmd)
      cout << "  --->  yyD_0_npf        from NPFitter:   " << yyD_0_npf        << endl; // D_0(K*gamma)
      cout << "  --->  yybsg_npf        from NPFitter:   " << yybsg_npf        << endl; // B(b->sg)
      }
   }
   //------------------------------------------------------------------------------------------

   used_products.clear();
   // loop over yyMeasuredVec and fill theovalue
   if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
      cout << yyDashedLine << endl;
      cout << "Interpreting the les houches output " << endl;
   }

   //Added by JL and BOL
   // old sRates spectrum read-in code:
   //    read in LHE-File in EW_spectrum
   int spectrum_loaded = 0;
   for (unsigned int i=0; i<yyMeasuredVec.size();i++){
     if (yyMeasuredVec[i].type==LHCRate){

       if( NULL != rateValue )
         {

           if( rateValue->readSLHA( "./SPheno.spc.last" ) )
             {

               spectrum_loaded = 1;

             }
           else
             {
	
	       spectrum_loaded = 0;

             }
       
       }
       break;
     }
   }
  // new LHC-FASER read-in code:
  if( NULL != lhcFaserSignals )
    {

      lhcFaserSignals->update_for_new_point();

    }
  /* unfortunately it's more effort to make LHC-FASER share input with sRates
   * than it is to just get LHC-FASER to take over the functionality of sRates.
   * unfortunately *that* is going to take some time, as new acceptance grids
   * need to be generated & analyzed...
   */







  
   for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
      if (yyMeasuredVec[i].type == mass) {
	 //      cout << "found mass of particle " << yyMeasuredVec[i].id << endl;
	 //      if ( yyMeasuredVec[i].id == 25 || yyMeasuredVec[i].id == 35 ||
	 //	   yyMeasuredVec[i].id == 45 ) {
	 //	cout << "################ H1 or H2 or H3 found" << endl;
	 //      }
	 yyMeasuredVec[i].theovalue = yyMass[yyMeasuredVec[i].id];
	 yyMeasuredVec[i].theoset = true;
      }
			else if ( yyMeasuredVec[i].type == FineTuningParameter ) {
				yyMeasuredVec[i].theovalue = yyFineTuningParameters[yyMeasuredVec[i].id];
				yyMeasuredVec[i].theoset = true;
			}
      //################################################
      else if (yyMeasuredVec[i].type == LEObs) {
	 if (yyMeasuredVec[i].id == bsg) {
	    yyMeasuredVec[i].theovalue = yybsg;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == bsmm) {
	    yyMeasuredVec[i].theovalue = yybsmm; 
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == B_smm) {
	    yyMeasuredVec[i].theovalue = yyB_smm; 
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == B_utn) {
	    yyMeasuredVec[i].theovalue = yyB_utn; 
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == dMB_d) {
	    yyMeasuredVec[i].theovalue = yydMB_d;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == dMB_s) {
	    yyMeasuredVec[i].theovalue = yydMB_s;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == gmin2e) {
	    yyMeasuredVec[i].theovalue = yygmin2e;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == gmin2m) {
	    yyMeasuredVec[i].theovalue = yygmin2m;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == gmin2t) {
	    yyMeasuredVec[i].theovalue = yygmin2t;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == drho) {
	    yyMeasuredVec[i].theovalue = yydrho;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == omega) {
	    yyMeasuredVec[i].theovalue = yyOmega;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == Bsg_npf) {
	    yyMeasuredVec[i].theovalue = yyBsg_npf;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == dm_s_npf) {
	    yyMeasuredVec[i].theovalue = yydm_s_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == B_smm_npf) {
	    yyMeasuredVec[i].theovalue = yyB_smm_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == Btn_npf) {
	    yyMeasuredVec[i].theovalue = yyBtn_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == B_sXsll_npf) {
	    yyMeasuredVec[i].theovalue = yyB_sXsll_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == Klnu_npf) {
	    yyMeasuredVec[i].theovalue = yyKlnu_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == gmin2m_npf) {
	    yyMeasuredVec[i].theovalue = yygmin2m_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == MassW_npf) {
	    yyMeasuredVec[i].theovalue = yyMassW_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == sin_th_eff_npf) {
	    yyMeasuredVec[i].theovalue = yysin_th_eff_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == GammaZ_npf) {
	    yyMeasuredVec[i].theovalue = yyGammaZ_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == R_l_npf) {
	    yyMeasuredVec[i].theovalue = yyR_l_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == R_b_npf) {
	    yyMeasuredVec[i].theovalue = yyR_b_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == R_c_npf) {
	    yyMeasuredVec[i].theovalue = yyR_c_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_fbb_npf) {
	    yyMeasuredVec[i].theovalue = yyA_fbb_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_fbc_npf) {
	    yyMeasuredVec[i].theovalue = yyA_fbc_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_b_npf) {
	    yyMeasuredVec[i].theovalue = yyA_b_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_c_npf) {
	    yyMeasuredVec[i].theovalue = yyA_c_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_l_npf) {
	    yyMeasuredVec[i].theovalue = yyA_l_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == Massh0_npf) {
	    yyMeasuredVec[i].theovalue = yyMassh0_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == MassH0_npf) {
	    yyMeasuredVec[i].theovalue = yyMassH0_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == MassA0_npf) {
	    yyMeasuredVec[i].theovalue = yyMassA0_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == MassHpm_npf) {
	    yyMeasuredVec[i].theovalue = yyMassHpm_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == Omega_npf) {
	    yyMeasuredVec[i].theovalue = yyOmega_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_tau_npf) {
	    yyMeasuredVec[i].theovalue = yyA_tau_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == A_fbl_npf) {
	    yyMeasuredVec[i].theovalue = yyA_fbl_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == sigma_had0_npf) {
	    yyMeasuredVec[i].theovalue = yysigma_had0_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == dm_d_npf) {
	    yyMeasuredVec[i].theovalue = yydm_d_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == dm_k_npf) {
	    yyMeasuredVec[i].theovalue = yydm_k_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == Kppinn_npf) {
	    yyMeasuredVec[i].theovalue = yyKppinn_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == B_dll_npf) {
	    yyMeasuredVec[i].theovalue = yyB_dll_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == DmsDmd_npf) {
	    yyMeasuredVec[i].theovalue = yyDmsDmd_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == D_0_npf) {
	    yyMeasuredVec[i].theovalue = yyD_0_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
	 else if (yyMeasuredVec[i].id == bsg_npf) {
	    yyMeasuredVec[i].theovalue = yybsg_npf;
	    yyMeasuredVec[i].theoset = true;
	 }         
      }
      //################################################
      else if (yyMeasuredVec[i].type == SMPrecision) {
	 if (yyMeasuredVec[i].id == gf) {
	    yyMeasuredVec[i].theovalue = yyG_F;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == alphas) {
	    yyMeasuredVec[i].theovalue = yyalpha_s_mz;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].id == alphaem) {
	    yyMeasuredVec[i].theovalue = yyoneoveralpha_em_mz;
	    yyMeasuredVec[i].theoset = true;
	 }
      }
     else if ( yyMeasuredVec[i].type == LHCRate )
                        // if the observable to be compared is a cross-section times branching ratio at the LHC...
      {
		
	if (yyMeasuredVec[i].id == fully_inclusive){

	      if ( spectrum_loaded == 1 ){ //check that spectrum has been loaded successfully

	      yyMeasuredVec[i].theovalue = rateValue->fully_inclusive_with_cuts();  // actually work out the theoretical value.


	      } else {

		      yyMeasuredVec[i].theovalue = -1.;
	      }
	      
	      if (yyMeasuredVec[i].theovalue < 0 ) {
	
		      yyMeasuredVec[i].theoset = false; // note that the theoretical value has NOT been recorded.

	      } else {	

	      yyMeasuredVec[i].theoset = true;  // note that the theoretical value has been recorded.
	      
	      }

	} 
	
	//OS-SF light leptons from two-body neutralino2 decays with lepton+jet+missingET cuts (veto on b+t)
	else if (yyMeasuredVec[i].id == os_sf){

		if ( spectrum_loaded == 1 ){ //check that spectrum has been loaded successfully

			yyMeasuredVec[i].theovalue = rateValue->Two_OSSF_leptons_cuts();  // actually work out the theoretical value.


		} else {

			yyMeasuredVec[i].theovalue = -1.;
		}
	      
		if (yyMeasuredVec[i].theovalue < 0 ) {
	
			yyMeasuredVec[i].theoset = false; // note that the theoretical value has NOT been recorded.

		} else {	

			yyMeasuredVec[i].theoset = true;  // note that the theoretical value has been recorded.
	      
		}

	}	
	
	//four b signature (not to be used at the moment. might not work correctly)
	else if (yyMeasuredVec[i].id == four_b) {

	      if ( spectrum_loaded == 1 ){ //check that spectrum has been loaded successfully

              yyMeasuredVec[i].theovalue = rateValue->fully_inclusive_four_sbottons_with_cuts();  // actually work out the theoretical value.


              } else {

                      yyMeasuredVec[i].theovalue = -1.;
              }
              
              if (yyMeasuredVec[i].theovalue < 0 ) {
        
                      yyMeasuredVec[i].theoset = false; // note that the theoretical value has NOT been recorded.

              } else {  

              yyMeasuredVec[i].theoset = true;  // note that the theoretical value has been recorded.
              
              }


	}
	else if( yyMeasuredVec[i].id == Atlas4jMET0l7TeV )
	// Atlas 4-jet + MET + 0-lepton signal
          {

            yyMeasuredVec[i].theovalue = lhcFaserAtlas4jMET0l7TeV->get_value();
            yyMeasuredVec[i].theoset = true;
            // note that the theory value has been recorded.

          }
	else if( yyMeasuredVec[i].id == Atlas3jMET1l7TeV )
	// Atlas 3-jet + MET + 1-lepton signal
          {

            yyMeasuredVec[i].theovalue = lhcFaserAtlas3jMET1l7TeV->get_value();
            yyMeasuredVec[i].theoset = true;
            // note that the theory value has been recorded.

          }

      }
      else if (yyMeasuredVec[i].type == Pwidth) {
	//cout << "width of particle " << yyMeasuredVec[i].id << " is measured at " <<  yyMeasuredVec[i].value << " and predicted at " << branching_ratios[yyMeasuredVec[i].id].TWidth << endl;
	 yyMeasuredVec[i].theovalue = branching_ratios[yyMeasuredVec[i].id].TWidth;
	 yyMeasuredVec[i].theoset = true;
	 if (yyMeasuredVec[i].setScaling == true) {
	   yyMeasuredVec[i].theovalue = yyMeasuredVec[i].theovalue*yyMeasuredVec[i].scaling;
	 }
      }
      else if (yyMeasuredVec[i].type == xsection) {
	 //      cout << " looking for xs " << yyMeasuredVec[i].name << endl; 
	 doubleVec_t tmp;
	 tmp.clear();
	 tmp.push_back(yyMeasuredVec[i].id);
	 tmp.push_back(yyMeasuredVec[i].sqrts);
	 tmp.push_back(yyMeasuredVec[i].polarisation1);
	 tmp.push_back(yyMeasuredVec[i].polarisation2);
	 if( cross_sections.find(tmp) != cross_sections.end() ) {
	    //	cout << " map element found " << yyMeasuredVec[i].id << " " 
	    //	     << yyMeasuredVec[i].polarisation1 << " " << yyMeasuredVec[i].polarisation2 << endl; 
	    for (unsigned int j=0; 1; j++) {
	       found_prod = 0;
	       used_products.clear();
	       //          cout << " j = " << j << " products " << (int)give_xs(tmp, j, 2) << " " <<  (int)give_xs(tmp, j, 3) << endl;
	       if (give_xs(tmp, j, 1) == 0) break;
	       //          cout << "looping over cross_sections from 2 to " << give_xs(tmp, j, 1)+1 << endl;
	       for (unsigned int k=2; k<(2+give_xs(tmp, j, 1)); k++) {
		  for (unsigned int m=0;m<yyMeasuredVec[i].products.size();m++) {
		     for (unsigned int n=0;n< used_products.size();n++) {
			if (m==used_products[n]) {
			   already_used = true;
			   break;
			}
		     }
		     if (already_used) {
			already_used = false;
			continue;
		     }
		     //	      cout << " comparing " << yyMeasuredVec[i].products[m] << " with " << (int)give_xs(tmp, j, k) << endl;
		     //	      if (TMath::Abs(yyMeasuredVec[i].products[m]) == TMath::Abs((int)give_xs(tmp, j, k)) ) {
		     if (yyMeasuredVec[i].products[m] == (int)give_xs(tmp, j, k) ) {
			found_prod++;
			used_products.push_back(m);
			break;
		     }
		  }  
		  }
		  //          cout << "found_prod = " << found_prod << endl;
		  if ((found_prod == yyMeasuredVec[i].products.size()) && (found_prod == give_xs(tmp, j, 1))) {
		     //     	    cout << "cross section " << yyMeasuredVec[i].name << " with Ecm " << cross_sections[tmp].ecm << " "  << yyMeasuredVec[i].sqrts << endl;
		     if ((cross_sections[tmp].ecm == yyMeasuredVec[i].sqrts) && 
			   (cross_sections[tmp].polarisation[0] == yyMeasuredVec[i].polarisation1) && 
			   (cross_sections[tmp].polarisation[1] == yyMeasuredVec[i].polarisation2) ) {
			yyMeasuredVec[i].theovalue = give_xs(tmp, j, 0);
			yyMeasuredVec[i].theoset = true;
			break;
		     }
		  } 
	       }
	    }
	 }
	 else if (yyMeasuredVec[i].type == br) {
	    for (unsigned int j = 0; 1; j++ ) {
	       used_products.clear();
	       found_prod = 0;
	       if (give_br(yyMeasuredVec[i].id, j, 1) == 0) break;
	       for (unsigned int k=2; k<(2+give_br(yyMeasuredVec[i].id, j, 1)); k++) {
		  for (unsigned int m=0;m<yyMeasuredVec[i].daughters.size();m++) {
		     for (unsigned int n=0;n< used_products.size();n++) {
			if (m==used_products[n]) {
			   already_used = true;
			   break;
			}
		     }
		     if (already_used) {
			already_used = false;
			continue;
		     }
		     if (TMath::Abs(yyMeasuredVec[i].daughters[m]) == TMath::Abs((int)give_br(yyMeasuredVec[i].id, j, k)) ) {
			used_products.push_back(m);
			found_prod++;
			break;
		     }	    
		  }
	       }
	       if ((found_prod == yyMeasuredVec[i].daughters.size()) && (found_prod == give_br(yyMeasuredVec[i].id, j, 1))) {
		  yyMeasuredVec[i].theovalue = give_br(yyMeasuredVec[i].id, j, 0);
		  yyMeasuredVec[i].theoset = true;
		  break;
	       } 
	    }
	    if (yyMeasuredVec[i].theoset == false) {
	       yyMeasuredVec[i].theovalue = 0.0;
	       yyMeasuredVec[i].theoset = true;
	    }
	 }
	 else if (yyMeasuredVec[i].type == tauFromStau1Polarisation) {
	    double a11R = - 2 * yyg / TMath::Sqrt(2) * yyN11 * yygprime / yyg * TMath::Sin(yyThetaStau) - yyYtau * yyN13 * TMath::Cos(yyThetaStau);
	    double a11L = yyg / TMath::Sqrt(2) * ( yyN12 + yyN11 * yygprime / yyg ) * TMath::Cos(yyThetaStau) - yyYtau * yyN13 * TMath::Sin(yyThetaStau);
	    yyMeasuredVec[i].theovalue = ( a11R * a11R - a11L * a11L ) / ( a11R * a11R + a11L * a11L );
//	    cout << "g = " << yyg <<endl;
//	    cout << "g' = " << yygprime <<endl;
//	    cout << "N11 = " << yyN11 <<endl;
//	    cout << "N12 = " << yyN12 <<endl;
//	    cout << "N13 = " << yyN13 <<endl;
//	    cout << "thetaStau = " << yyThetaStau <<endl;
//	    cout << "Ytau = " << yyYtau <<endl;
//          cout << "far pol = " << yyMeasuredVec[i].theovalue <<endl;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].type == tauFromNeutralino2Polarisation) {
	    double a21R = - 2 * yyg / TMath::Sqrt(2) * yyN21 * yygprime / yyg * TMath::Sin(yyThetaStau) - yyYtau * yyN23 * TMath::Cos(yyThetaStau);
	    double a21L = yyg / TMath::Sqrt(2) * ( yyN22 + yyN21 * yygprime / yyg ) * TMath::Cos(yyThetaStau) - yyYtau * yyN23 * TMath::Sin(yyThetaStau);
	    yyMeasuredVec[i].theovalue = ( a21R * a21R - a21L * a21L ) / ( a21R * a21R + a21L * a21L );
//	    cout << "g = " << yyg <<endl;
//	    cout << "g' = " << yygprime <<endl;
//	    cout << "N21 = " << yyN21 <<endl;
//	    cout << "N22 = " << yyN22 <<endl;
//	    cout << "N23 = " << yyN23 <<endl;
//	    cout << "thetaStau = " << yyThetaStau <<endl;
//	    cout << "Ytau = " << yyYtau <<endl;
//	    cout << "near pol = " << yyMeasuredVec[i].theovalue <<endl;
	    yyMeasuredVec[i].theoset = true;
	 }
	 else if (yyMeasuredVec[i].type == Pedge) {
	    // implement edge types here
	    //      cout << "in theory fitting edge " << yyMeasuredVec[i].name << endl;
	    // dummy edge 1
	    if (yyMeasuredVec[i].id == 1) {
	       yyMeasuredVec[i].theovalue = yyMass[yyMeasuredVec[i].daughters[0]] + yyMass[yyMeasuredVec[i].daughters[1]];
	       yyMeasuredVec[i].theoset = true;
	    }
	    // dummy edge 2
	    else if (yyMeasuredVec[i].id == 2) {
	       yyMeasuredVec[i].theovalue = TMath::Abs(yyMass[yyMeasuredVec[i].daughters[0]] - yyMass[yyMeasuredVec[i].daughters[1]]);
	       yyMeasuredVec[i].theoset = true;
	    }
	    // real edge 1: m_ll, m_qll, mqledgemin; m_chi01 m_chi02 m_lR (see LHCILC, page 214) (5.9, 5.10, 5.11)
	    else if (yyMeasuredVec[i].id == 3) {
	       // cout << "edge: " << yyMeasuredVec[i].name << " " 
	       //      << yyMeasuredVec[i].type << " " 
	       //      << yyMeasuredVec[i].id << " " 
	       //      << yyMeasuredVec[i].value  << " " 
	       //      << yyMeasuredVec[i].error << " " 
	       //      << yyMeasuredVec[i].alias << " " << endl;
	       // cout << "evaluating edge 3:" << yyMass[yyMeasuredVec[i].daughters[0]] << " "
	       //      << yyMass[yyMeasuredVec[i].daughters[1]] << " " 
	       //      << yyMass[yyMeasuredVec[i].daughters[2]] << " "<< endl;
	       double tmpvalue = ((sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			- sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
		     *(sqr(yyMass[yyMeasuredVec[i].daughters[2]])
			- sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
		     /(sqr(yyMass[yyMeasuredVec[i].daughters[2]])));
	       if (tmpvalue > 0) {
		  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
	       } else {
		  yyMeasuredVec[i].theovalue = 1.1E11;
	       }
	       // cout << "edge = " << yyMeasuredVec[i].theovalue << endl;
	       yyMeasuredVec[i].theoset = true;
	    } 
	    // real edge 3: mqledgemax; m_chi01 m_chi02 m_lR m_qL (see LHCILC, page 214) (5.13)
	    else if (yyMeasuredVec[i].id == 4) {
	       // cout << "edge: " << yyMeasuredVec[i].name << " " 
	       //     << yyMeasuredVec[i].type << " " 
	       //      << yyMeasuredVec[i].id << " " 
	       //     << yyMeasuredVec[i].value  << " " 
	       //     << yyMeasuredVec[i].error << " " 
	       //      << yyMeasuredVec[i].alias << " " << endl;
	       // cout << "evaluating edge 4:" << yyMass[yyMeasuredVec[i].daughters[0]] << " "
	       //      << yyMass[yyMeasuredVec[i].daughters[1]] << " " 
	       //      << yyMass[yyMeasuredVec[i].daughters[2]] << " "
	       //      << yyMass[yyMeasuredVec[i].daughters[3]] << " " << endl;
	       double tmpvalue = ((sqr(yyMass[yyMeasuredVec[i].daughters[3]])
			- sqr(yyMass[yyMeasuredVec[i].daughters[1]]))
		     *(sqr(yyMass[yyMeasuredVec[i].daughters[2]])
			- sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
		     /(sqr(yyMass[yyMeasuredVec[i].daughters[2]])));
	       if (tmpvalue > 0) {
		  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
	       } else {
		  yyMeasuredVec[i].theovalue = 1.1E11;
	       }
	       // cout << "edge = " << yyMeasuredVec[i].theovalue << endl;
	       yyMeasuredVec[i].theoset = true;
	    }      
	    else if (yyMeasuredVec[i].id == 5) {
	       //	cout << "edge: " << yyMeasuredVec[i].name << " " 
	       //     << yyMeasuredVec[i].type << " " 
	       //     << yyMeasuredVec[i].id << " " 
	       //     << yyMeasuredVec[i].value  << " " 
	       //     << yyMeasuredVec[i].error << " " 
	       //     << yyMeasuredVec[i].alias << " " << endl;
	       // cout << "evaluating edge 5:" << yyMass[yyMeasuredVec[i].daughters[0]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[1]] << " " 
	       //     << yyMass[yyMeasuredVec[i].daughters[2]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[3]] << " " << endl;
	       double tmpvalue = (
		     (
		      (sqr(yyMass[yyMeasuredVec[i].daughters[3]])
		       + sqr(yyMass[yyMeasuredVec[i].daughters[1]]))
		      *(sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			 - sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
		      *(sqr(yyMass[yyMeasuredVec[i].daughters[2]])
			 - sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
		      - (sqr(yyMass[yyMeasuredVec[i].daughters[3]])
			 - sqr(yyMass[yyMeasuredVec[i].daughters[1]]))
		      *TMath::Sqrt(
			 sqr((sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			       + sqr(yyMass[yyMeasuredVec[i].daughters[2]])))
			 *sqr((sqr(yyMass[yyMeasuredVec[i].daughters[2]])
			       + sqr(yyMass[yyMeasuredVec[i].daughters[0]])))
			 -16.*sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			 *sqr(sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
			 *sqr(yyMass[yyMeasuredVec[i].daughters[0]])
			 )
		      + 2.*sqr(yyMass[yyMeasuredVec[i].daughters[2]])
		      *(sqr(yyMass[yyMeasuredVec[i].daughters[3]])
			 - sqr(yyMass[yyMeasuredVec[i].daughters[1]]))
		      *(sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			    - sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
		      )
		      /(4.*sqr(yyMass[yyMeasuredVec[i].daughters[2]]
			       *yyMass[yyMeasuredVec[i].daughters[1]]))
		      );
	       if (tmpvalue > 0) {
		  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
	       } else {
		  yyMeasuredVec[i].theovalue = 1.1E11;
	       }
	       // cout << "edge = " << yyMeasuredVec[i].theovalue << endl;
	       yyMeasuredVec[i].theoset = true;
	    }

	    /* implementation of "edge 6" M^2_tb(III)j written by Mathias Uhlenbrock (ll 5809-5844) */
	    else if (yyMeasuredVec[i].id == 6) {
	       //	cout << "edge: " << yyMeasuredVec[i].name << " " 
	       //     << yyMeasuredVec[i].type << " " 
	       //     << yyMeasuredVec[i].id << " " 
	       //     << yyMeasuredVec[i].value  << " " 
	       //     << yyMeasuredVec[i].error << " " 
	       //     << yyMeasuredVec[i].alias << " " << endl;
	       // cout << "evaluating edge 6:" << yyMass[yyMeasuredVec[i].daughters[0]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[1]] << " " 
	       //     << yyMass[yyMeasuredVec[i].daughters[2]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[3]] << " " << endl;

	       double tmpvalue;
	       if ((sqr(yyMass[yyMeasuredVec[i].daughters[3]])-sqr((yyMass[yyMeasuredVec[i].daughters[1]]+yyMass[yyMeasuredVec[i].daughters[0]]))) < 0.) {
		  tmpvalue = 0.;
	       }

	       else {
		  tmpvalue = (
			sqr(yyMass[yyMeasuredVec[i].daughters[0]])
			+(sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			   -sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
			/(2*sqr(yyMass[yyMeasuredVec[i].daughters[1]]))
			*((sqr(yyMass[yyMeasuredVec[i].daughters[3]])
			      -sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			      -sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
			   +TMath::Sqrt((sqr(yyMass[yyMeasuredVec[i].daughters[3]])
				 -sqr((yyMass[yyMeasuredVec[i].daughters[1]]
				       -yyMass[yyMeasuredVec[i].daughters[0]])))
			      *(sqr(yyMass[yyMeasuredVec[i].daughters[3]])
				 -sqr((yyMass[yyMeasuredVec[i].daughters[1]]
				       +yyMass[yyMeasuredVec[i].daughters[0]])))))

			);
	       }
	       if (tmpvalue > 0.) {
		  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
	       } else {
		  yyMeasuredVec[i].theovalue = 1.1E11;
	       }
	       // cout << "edge = " << yyMeasuredVec[i].theovalue << endl;
	       yyMeasuredVec[i].theoset = true;
	    }
	    /* implementation of "edge 7" M^2_tb(IV)ij written by Mathias Uhlenbrock (ll 5846-5880) */
	    else if (yyMeasuredVec[i].id == 7) {
	       //	cout << "edge: " << yyMeasuredVec[i].name << " " 
	       //     << yyMeasuredVec[i].type << " " 
	       //     << yyMeasuredVec[i].id << " " 
	       //     << yyMeasuredVec[i].value  << " " 
	       //     << yyMeasuredVec[i].error << " " 
	       //     << yyMeasuredVec[i].alias << " " << endl;
	       // cout << "evaluating edge 7:" << yyMass[yyMeasuredVec[i].daughters[0]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[1]] << " " 
	       //     << yyMass[yyMeasuredVec[i].daughters[2]] << " "
	       //     << yyMass[yyMeasuredVec[i].daughters[3]] << " " << endl;

	       double tmpvalue;
	       if ((sqr(yyMass[yyMeasuredVec[i].daughters[2]])-sqr((yyMass[yyMeasuredVec[i].daughters[3]]+yyMass[yyMeasuredVec[i].daughters[0]]))) < 0.) {
		  tmpvalue = 0.;
	       }
	       else {
		  tmpvalue = (
			sqr(yyMass[yyMeasuredVec[i].daughters[0]])
			+(sqr(yyMass[yyMeasuredVec[i].daughters[1]])
			   -sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
			/(2*sqr(yyMass[yyMeasuredVec[i].daughters[2]]))
			*((sqr(yyMass[yyMeasuredVec[i].daughters[2]])
			      -sqr(yyMass[yyMeasuredVec[i].daughters[3]])
			      +sqr(yyMass[yyMeasuredVec[i].daughters[0]]))
			   +TMath::Sqrt((sqr(yyMass[yyMeasuredVec[i].daughters[2]])
				 -sqr((yyMass[yyMeasuredVec[i].daughters[3]]
				       -yyMass[yyMeasuredVec[i].daughters[0]])))
			      *(sqr(yyMass[yyMeasuredVec[i].daughters[2]])
				 -sqr((yyMass[yyMeasuredVec[i].daughters[3]]
				       +yyMass[yyMeasuredVec[i].daughters[0]])))))
			);
	       }
	       if (tmpvalue > 0.) {
		  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
	       } else {
		  yyMeasuredVec[i].theovalue = 1.1E11;
	       }
	       // cout << "edge = " << yyMeasuredVec[i].theovalue << endl;
	       yyMeasuredVec[i].theoset = true;
	    }
	    else if (yyMeasuredVec[i].id == 8) {
	       double tmpvalue = sqr(yyMass[yyMeasuredVec[i].daughters[0]]) - 2*sqr(yyMass[yyMeasuredVec[i].daughters[1]]);
	       yyMeasuredVec[i].theovalue = (tmpvalue > 0 ) ? TMath::Sqrt(tmpvalue) : 1.1E11;
	       yyMeasuredVec[i].theoset = true;
	    }
            else if (yyMeasuredVec[i].id == 9) {
               double tmpvalue1 = 1 - sqr(yyMass[yyMeasuredVec[i].daughters[1]] / yyMass[yyMeasuredVec[i].daughters[2]]);
               double tmpvalue2 = 1 - sqr(yyMass[yyMeasuredVec[i].daughters[0]] / yyMass[yyMeasuredVec[i].daughters[1]]);
               double tmpvalue  = yyMass[yyMeasuredVec[i].daughters[2]] * TMath::Sqrt(tmpvalue1) * TMath::Sqrt(tmpvalue2);
               if (tmpvalue > 0) {
                  yyMeasuredVec[i].theovalue = tmpvalue;
               } else {
                  yyMeasuredVec[i].theovalue = 1.1E11;
               }
               yyMeasuredVec[i].theoset = true;
            }
            else if (yyMeasuredVec[i].id == 10) {
               double tmpvalue = sqr(yyMass[yyMeasuredVec[i].daughters[0]]) - sqr(yyMass[yyMeasuredVec[i].daughters[1]]);
               if (tmpvalue > 0) {
                  yyMeasuredVec[i].theovalue = TMath::Sqrt(tmpvalue);
               } else {
                  yyMeasuredVec[i].theovalue = 1.1E11;
               }
               yyMeasuredVec[i].theoset = true;
            }
	    else if (yyMeasuredVec[i].id >= 100 && yyMeasuredVec[i].id <= 121) {
	       double epmasses[5];
	       epmasses[0] = yyMass[ID_chi01];
	       epmasses[1] = yyMass[ID_seR];
	       epmasses[2] = yyMass[ID_chi02];
	       epmasses[3] = yyMass[ID_suL];
	       epmasses[4] = yyMass[ID_gluino];
	       if (yyMeasuredVec[i].id == 100) {
		 // for m(ll) use the masses defined in the input file
		 epmasses[0] = yyMass[yyMeasuredVec[i].daughters[0]];
		 epmasses[1] = yyMass[yyMeasuredVec[i].daughters[2]];
		 epmasses[2] = yyMass[yyMeasuredVec[i].daughters[1]];
	       } else if (yyMeasuredVec[i].id == 102) {
		 epmasses[0] = yyMass[yyMeasuredVec[i].daughters[0]];
		 epmasses[1] = yyMass[yyMeasuredVec[i].daughters[2]];
		 epmasses[2] = yyMass[yyMeasuredVec[i].daughters[1]];
		 epmasses[3] = yyMass[yyMeasuredVec[i].daughters[3]];
	       }
	       if (yyVerbose){
	       std::cout << " endpoint number " << yyMeasuredVec[i].id - 100 << std::endl;
	       std::cout << " neutralino1 mass " << epmasses[0] << std::endl;
	       std::cout << " selectronR mass " << epmasses[1] << std::endl;
	       std::cout << " neutralino2 mass " << epmasses[2] << std::endl;
	       std::cout << " supL mass " << epmasses[3] << std::endl;
	       std::cout << " gluino mass " << epmasses[4] << std::endl;
	       }
	       yyMeasuredVec[i].theovalue = Endpoint(yyMeasuredVec[i].id - 100, epmasses);


/////////////////////////////////////////////////////	       
// 	       // hacked by BOL to ensure the right edge is chosen for this point's hierarchy.
// 		if( ( yyMeasuredVec[i].id == 103 ) || ( yyMeasuredVec[i].id == 105 ) )  // if the edge is m_ql(low)...
// 	       {
// 
// 		       if( ( 2.0 * epmasses[1] * epmasses[1] ) > ( ( epmasses[2] * epmasses[2] ) + ( epmasses[0] * epmasses[0] ) ) )  // if m_ql(low) should be m_ql(near)...
// 		       {
// 
// 			       yyMeasuredVec[i].theovalue = Endpoint( 3, epmasses );  // use m_ql(near).
// 
// 		       }
// 		       else  // otherwise
// 		       {
// 
// 			       yyMeasuredVec[i].theovalue = Endpoint( 5, epmasses );  // use m_ql(eq).
// 
// 		       }
// 
// 	       }
// 	       else
// 	       {
// 
// 		       yyMeasuredVec[i].theovalue = Endpoint(yyMeasuredVec[i].id - 100, epmasses);
// 
// 	       }
////////////////////////////////////////////////////////	       


	       yyMeasuredVec[i].theoset = true;
	    }
	 }
      }
      // check for brprod
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if (yyMeasuredVec[i].type == brprod) {
	    yyMeasuredVec[i].theovalue = 1.;
	    dependencies_theoset = true;
	    for (unsigned int j=0; j<yyMeasuredVec[i].daughters.size(); j++) {
	       // cout << "multiplying br " << yyMeasuredVec[yyMeasuredVec[i].daughters[j]].name << " = " << 
	       //   yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue << endl;
	       yyMeasuredVec[i].theovalue *= yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue;
	       if (yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theoset == false) {
		  dependencies_theoset = false;
	       }
	    } 
	    if (dependencies_theoset) {
	       yyMeasuredVec[i].theoset = true;
	    }
	    else { 
	       yyMeasuredVec[i].theoset = false;
	    }
	 }
      }  
      // check for brsum
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if (yyMeasuredVec[i].type == brsum) {
	    yyMeasuredVec[i].theovalue = 0.;
	    dependencies_theoset = true;
	    for (unsigned int j=0; j<yyMeasuredVec[i].daughters.size(); j++) {
	       // cout << "multiplying br " << yyMeasuredVec[yyMeasuredVec[i].daughters[j]].name << " = " << 
	       //   yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue << endl;
	       yyMeasuredVec[i].theovalue += yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue;
	       if (yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theoset == false) {
		  dependencies_theoset = false;
	       }
	    } 
	    if (dependencies_theoset) {
	       yyMeasuredVec[i].theoset = true;
	    }
	    else { 
	       yyMeasuredVec[i].theoset = false;
	    }
	 }
      }  
      // check for xsbr
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if (yyMeasuredVec[i].type == xsbr) {
	    yyMeasuredVec[i].theovalue = 1.;
	    dependencies_theoset = true;
	    for (unsigned int j=0; j<yyMeasuredVec[i].daughters.size(); j++) {
	       // cout << "multiplying br " << yyMeasuredVec[yyMeasuredVec[i].daughters[j]].name << " = " << 
	       //   yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue << endl;
	       yyMeasuredVec[i].theovalue *= yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theovalue;
	       if (yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theoset == false) {
		  dependencies_theoset = false;
	       }
	    } 
	    for (unsigned int j=0; j<yyMeasuredVec[i].products.size(); j++) {
	       // cout << "multiplying xs " << yyMeasuredVec[yyMeasuredVec[i].products[j]].name << " = " << 
	       //   yyMeasuredVec[yyMeasuredVec[i].products[j]].theovalue << endl;
	       yyMeasuredVec[i].theovalue *= yyMeasuredVec[yyMeasuredVec[i].products[j]].theovalue;
	       if (yyMeasuredVec[yyMeasuredVec[i].products[j]].theoset == false) {
		  dependencies_theoset = false;
	       }
	    }        
	    if (dependencies_theoset) {
	       yyMeasuredVec[i].theoset = true;
	    }
	    else { 
	       yyMeasuredVec[i].theoset = false;
	    }
	 }
      }  
      // check for brratio
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if (yyMeasuredVec[i].type == brratio) {
	    yyMeasuredVec[i].theovalue = yyMeasuredVec[yyMeasuredVec[i].daughters[0]].theovalue / 
	       yyMeasuredVec[yyMeasuredVec[i].daughters[1]].theovalue;
	    if (yyMeasuredVec[yyMeasuredVec[i].daughters[1]].theoset && yyMeasuredVec[yyMeasuredVec[i].daughters[0]].theoset) {
	       yyMeasuredVec[i].theoset = true;
	    }
	    else {
	       yyMeasuredVec[i].theoset = false;
	    }
	 }
      }  
      // check for weighted
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if (yyMeasuredVec[i].type == weighted) {
	    yyMeasuredVec[i].theovalue = 0.;
	    dependencies_theoset = true;

	    if (yyMeasuredVec[i].daughters.size() == 4) {
	      yyMeasuredVec[i].theovalue = (yyMeasuredVec[yyMeasuredVec[i].daughters[0]].theovalue*yyMeasuredVec[yyMeasuredVec[i].daughters[1]].theovalue+yyMeasuredVec[yyMeasuredVec[i].daughters[2]].theovalue*yyMeasuredVec[yyMeasuredVec[i].daughters[3]].theovalue)/(yyMeasuredVec[yyMeasuredVec[i].daughters[0]].theovalue+yyMeasuredVec[yyMeasuredVec[i].daughters[2]].theovalue);
	    }
	    if (yyMeasuredVec[i].daughters.size() == 5) {
	      yyMeasuredVec[i].theovalue = yyMeasuredVec[yyMeasuredVec[i].daughters[0]].theovalue - (yyMeasuredVec[yyMeasuredVec[i].daughters[1]].theovalue*yyMeasuredVec[yyMeasuredVec[i].daughters[2]].theovalue+yyMeasuredVec[yyMeasuredVec[i].daughters[3]].theovalue*yyMeasuredVec[yyMeasuredVec[i].daughters[4]].theovalue)/(yyMeasuredVec[yyMeasuredVec[i].daughters[1]].theovalue+yyMeasuredVec[yyMeasuredVec[i].daughters[3]].theovalue);
	    }

	    if (!(yyMeasuredVec[i].theovalue<0.) && !(yyMeasuredVec[i].theovalue>=0.)) {
	      if (yyVerbose){
	      cout << "detected nan" << endl;
	      }
	      yyMeasuredVec[i].theovalue = -10000.;
	    }
	    for (unsigned int j=0; j<4; j++) {
	       if (yyMeasuredVec[yyMeasuredVec[i].daughters[j]].theoset == false) {
		  dependencies_theoset = false;
	       }
	    } 
	    if (dependencies_theoset) {
	       yyMeasuredVec[i].theoset = true;
	    }
	    else {
	       yyMeasuredVec[i].theoset = false;
	    }

	 }
      }
      // check whether all has been found
      for (unsigned int i=0; i<yyMeasuredVec.size(); i++) {
	 if ((yyMeasuredVec[i].theoset == false) && (yyMeasuredVec[i].nofit == false)) {
	    if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) {       
	       cout << "WARNING: observable " << yyMeasuredVec[i].name << " not found!" << endl;
	    }
	 }
	 if (yyMeasuredVec[i].first == true) {
	    yyMeasuredVec[i].first = false;
	    if (yyMeasuredVec[i].theoset == true) {
	       yyMeasuredVec[i].hasbeenset = true;
	    }
	 }
	 if ((yyMeasuredVec[i].theoset == true) && (yyMeasuredVec[i].hasbeenset == false)) {
	    yyMeasuredVec[i].hasbeenset = true;
	 }
	 if ((yyMeasuredVec[i].hasbeenset == true) && (yyMeasuredVec[i].theoset == false)) {
	    yyMeasuredVec[i].theovalue = 11111111111.;
	    yyMeasuredVec[i].theoset = true;
	 }
      }

      return 0;

   }

   int   ParseLesHouches()
   {
      static int counter = 0;

      counter++;

      int rc = 0;

      if (yyCalculator == SPHENO) {
	 //      system("cp SPheno.spc.test SPheno.spc");
	 yyin = fopen("SPheno.spc", "r");
	 //	yyin = fopen("leshouches.in", "r");
	 if (!yyin) {
	    cerr<<"SPheno.spc does not exist"<<endl;
	    yyCalculatorError = true;
	    return 1;
	 }
	 yyInputFileLineNo = 1;
	 rc = yyparse();
	 fclose(yyin);
	 system ("mv SPheno.spc SPheno.spc.last");
	 system ("mv Messages.out Messages.out.last");
	 system ("mv LesHouches.in LesHouches.in.last");
	 system ("mv SPheno.out SPheno.out.last");

	 // exit (0);
      }
			else if ( yyCalculator == SOFTSUSY || yyCalculator == SUSPECT) {
				
				yyin = fopen("susyhit_slha.out", "r");
		    if( !yyin ) {
			    cerr << "Couldnt open susyhit_slha.out" << endl;
		  		yyCalculatorError = true;
					return 1;
				}
				yyInputFileLineNo = 1;
				rc = yyparse();
				fclose(yyin);
				system("mv susyhit_slha.out.last susyhit_slha.out.last2");
        system("mv susyhit_slha.out susyhit_slha.out.last");
        system("mv slhaspectrum.in.last slhaspectrum.in.last2");
        system("mv slhaspectrum.in slhaspectrum.in.last");
        system("mv LesHouches.in.last LesHouches.in.last2");
        system("mv LesHouches.in LesHouches.in.last");
			}
																									 
      else {
	 cerr<<"Only SPHENO is implemented"<<endl;
	 exit(EXIT_FAILURE);
      }

      yyInputFileLineNo = 1;

      if (yyVerbose){
      cout<<counter<<" ###########################################################"<<endl;
      }


      return rc;

   }


   double give_br ( int id, int decay, int element )
   {

      if( branching_ratios.find( id ) != branching_ratios.end() ) {
	 if (branching_ratios[id].decays.size() > (unsigned int)decay ) {
	    if (branching_ratios[id].decays[decay].size() > (unsigned int)element) {
	       return branching_ratios[id].decays[decay][element];
	    } else {
	       return 0.;
	    }
	 } else {
	    return 0.;
	 }
      } else {
	 return 0.;
      }

   }

   double give_xs (doubleVec_t initial, int channel, int element )
   {

      if( cross_sections.find( initial ) != cross_sections.end() ) {
	 if (cross_sections[initial].xs.size() > (unsigned int)channel ) {
	    if (cross_sections[initial].xs[channel].size() > (unsigned int)element) {
	       return cross_sections[initial].xs[channel][element];
	    } else {
	       return 0.;
	    }
	 } else {
	    return 0.;
	 }
      } else {
	 return 0.;
      }

   }


   // Fittino::hybridMonteCarlo
   //
   // Scan parameter space using hybrid monte carlo
   //
   // P. Wienemann, March 30, 2007
   void Fittino::hybridMonteCarlo()
   {
      const int ncycles = 10000;

      double* q0 = new double[yyFittedVec.size()];
      double* p0 = new double[yyFittedVec.size()];
      double* q1 = new double[yyFittedVec.size()];
      double* p1 = new double[yyFittedVec.size()];
      // fill vector of parameters
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
	 q0[i] = yyFittedVec[i].value;
      }

      for (int cycle = 0; cycle < ncycles; cycle++) {
	 for (unsigned int i=0; i < yyFittedVec.size(); i++ ) {
	    p0[i] = gRandom->Gaus(0, 1);
	 }
	 //double H0 = hamiltonian(yyFittedVec.size(), q0, p0);

	 // integrate Hamilton equations here using leapfrog algorithm

	 //double H1 = hamiltonian(yyFittedVec.size(), q1, p1);

	 //double acceptprob = TMath::Min( 1., TMath::Exp( H0 - H1 ) );
      }

      delete[] q0;
      delete[] p0;
      delete[] q1;
      delete[] p1;
   }


   // test simulated annealing

   void Fittino::simulated_annealing (int iteration, TNtuple *ntuple)
   {

      Double_t xdummy[100];
      int n;
      vector <double> x; 
      vector <double> xvar; 
      //  bool max = false; 
      double rt; 
      double eps = 0.0001; 
      int ns = 20; 
      int nt; 
      int neps = 4;
      int maxevl; 
      vector <double> lb; 
      vector <double> ub;
      vector <double> c; 
      //  int iprint = 0;
      //  int iseed1 = 31327; 
      //  int iseed2 = 30080; 
      double t = 5.0; // initial temperature
      vector <double> vm;
      vector <double> xopt;
      double fopt = 11111111111.0;
      int nacc = 0; 
      int nfcnev = 0; 
      int nobds = 0;
      int ier = 0; 
      vector <double> fstar; 
      vector <double> xp;
      vector <int> nacp;

      /* System generated locals */
      //  int i1, i2, i3, i4;
      double d1;
      Double_t dummyfloat = 5.;
      Int_t dummyint = 1;

      /* Local variables */
      static int nrej;
      static int nnew;
      static bool quit = false;
      bool quit_while_loop = false;
      static double f;
      static int h, i, j, m;
      static double p, ratio;
      static int ndown;
      static int nup;
      static double fp, pp;
      static int lnobds;
      //  double fvar = 0.;
      double fcubed = 0.;
      double fsum = 0.;
      int nvalid = 0;
      bool firstfalse;
      int accpoint = 0;
      int xoptflag = 0;
      int niter = 0;
      int accbetter = 0;
      int lower_opt;
      int upper_opt;
      int lower_opt_before;
      int upper_opt_before;


      Float_t ntupvars[50];

      time_t systime;
      int seed;
      struct sysinfo sinfo; 
      // set the random number generator
      time (&systime);
      sysinfo(&sinfo);
      if (yyRandomGeneratorSeed < 0) {
	 seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
	 if (yyVerbose){
	 cout<<"uptime = "<<sinfo.uptime<<endl;
	 cout<<"freeswap = "<<sinfo.freeswap<<endl;
	 cout<<"pid = "<<getpid()<<endl;
	 cout << "systime " << systime << endl; 
	 }
      }
      else {
	if (yyVerbose){
	 cout<<"using seed from input file"<<endl;
	}
	 seed = yyRandomGeneratorSeed;
      }
      if (yyVerbose){
      cout << "seed = " << seed << endl;
      }
      gRandom->SetSeed(seed);


      // set values
      maxevl = yyMaxCallsSimAnn;
      rt = yyTempRedSimAnn;
      nup = 0;
      nrej = 0;
      nnew = 0;
      ndown = 0;
      lnobds = 0;
      lower_opt = 0;
      upper_opt = 0;
      lower_opt_before = 0;
      upper_opt_before = 0;
      n = yyFittedVec.size();
      if (n<20) {
	 nt = 60;
      } else {
	 nt = 3*n;
      }
      // override this
      nt=yySimAnnEpochLength;
      for (i = 0; i < neps; ++i) {
	 fstar.push_back(1e20);
      }

      // fill vector of parameters
      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 x.push_back(yyFittedVec[k].value);
	 xp.push_back(yyFittedVec[k].value);
	 xvar.push_back(yyFittedVec[k].value);
	 xopt.push_back(yyFittedVec[k].value);
	 vm.push_back(yyFittedVec[k].error);
	 lb.push_back(yyFittedVec[k].bound_low);
	 ub.push_back(yyFittedVec[k].bound_up);
	 c.push_back(2.0);
	 nacp.push_back(0);
      }

      /*  Evaluate function to be minimized at the starting point */
      for (unsigned int ii = 0; ii < xp.size(); ii++) {
	 xdummy[ii] = x[ii];
      }
      fitterFCN(dummyint, &dummyfloat, f, xdummy, 0);
      f = -f;
      ++nfcnev;
      fopt = f;
      fstar[1] = f;

      // ------------------------------------------------------------------
      // if initial temperature is given:
      if (yyInitTempSimAnn>0.) {
	 t = yyInitTempSimAnn;
      }
      else {
	 // ------------------------------------------------------------------
	 // if already very close to the minimum:
	 if (TMath::Abs(f)<0.1) {
	    t = 0.1;
	    if (rt<0.6) {
	       rt = 0.6;
	    }
	 } else if (TMath::Abs(f)<1.) {
	    t = 1.;
	    if (rt<0.6) {
	       rt = 0.6;
	    }
	 } else if (TMath::Abs(f)<5.) {
	    t = 5.;
	    if (rt<0.6) {
	       rt = 0.6;
	    }    
	 } else if (TMath::Abs(f)<10.) {
	    t = 10.;
	    if (rt<0.6) {
	       rt = 0.6;
	    }    
	 } else if (TMath::Abs(f)<100.) {
	    t = 100.;
	    if (rt<0.6) {
	       rt = 0.6;
	    }    
	 } else if (TMath::Abs(f)<200.) {
	    t = 200.;
	    if (rt<0.5) {
	       rt = 0.5;
	    }    
	 } else {
	    //-------------------------------------------
	    // if not very close to the minimum:
	    // first adjust the temperature to the variance for variations within vm?
	    nvalid = 0;
	    fsum = 0.;
	    fcubed = 0.;
	    for (m = 0; m < 10; m++) {
	       for (i = 0; i < n; i++) {
		  xp[i] = xvar[i] + gRandom->Uniform(-1.,1.) * vm[i];
		  //  If variation has led xp out of bounds:
		  while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
		     xp[i] = gRandom->Uniform(-1.,1.) * vm[i] + yyFittedVec[i].value;
		  }
		  // Then call the function to be minimized at the starting point
		  for (unsigned int ii = 0; ii < xp.size(); ii++) {
		     xdummy[ii] = xp[ii];
		  }
		  fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
		  fp = -fp;
		  if (yyVerbose){
		  cout << "fp = " << fp << endl;
		  }
		  if (fp > -1e10) {
		     //	fopt = 0.;
		     //      fp = 5.;
		     fsum = fsum + TMath::Abs(fopt - fp);
		     fcubed = fcubed + sqr((fopt - fp));
		     nvalid++;
		  }
		  xp[i] = xvar[i];
	       }
	       for (i = 0; i < n; i++) {
		  xvar[i] = xp[i];
	       }
	    }
	    // set t to half of the variance
	    t = TMath::Sqrt(fcubed/double(nvalid) - sqr(fsum/double(nvalid)))/2.;
	 }
      }

      // simple temperature adaption
      if (yyGetTempFromFirstChiSqr) {

	if (yyVerbose){
	 cout << "determining initial temperature from first chi2 " << fopt << endl;
	}
	 double firstChi2 = TMath::Abs(fopt);
	 if (firstChi2<yyInitTempSimAnn*10.) {
	    t = yyInitTempSimAnn;
	 } else {
	    t = (double)TMath::Nint(firstChi2/10.);
	 } 

      }



      if (yyVerbose){
      cout << "temperature chosen " << t << endl;
      }

      //-------------------------------------------
      // perform the optimization
      niter = 0;

      // begin new temperature era
      while (!quit_while_loop) {
	 nup = 0;
	 nrej = 0;
	 nnew = 0;
	 ndown = 0;
	 lnobds = 0;
	 if (yyAdaptiveSimAnn) {
	    if (niter>0 && ( TMath::Abs( ( (float)niter/2. ) - niter/2 ) < 0.01 ) ) {
	       if (lower_opt>0 && upper_opt==0 && lower_opt_before>0 && upper_opt_before==0) {
		  if (nt>20) {
		    if (yyVerbose){
		     cout << "resetting the temperature reduction factor from " << rt;
		    }
		     rt = TMath::Sqrt(rt);
		     if (yyVerbose){
		     cout  << " to " << rt << endl;
		     cout << "resetting the temperature step width from " << nt;
		     }
		     nt = nt/2;
		     if (yyVerbose){
		     cout  << " to " << nt << endl;
		     }
		  }
	       }
	    }
	 }
	 niter++;
	 // loop over the iterations before temperature reduction:
	 for (m = 0; m < nt; m++) {
	    lower_opt_before = lower_opt;
	    upper_opt_before = upper_opt;
	    lower_opt=0;
	    upper_opt=0;
	    // loop over the accepted function evaluations:
	    for (j = 0; j < ns; j++) {
	       // loop over the variables:
	       for (h = 0; h < n; h++) {
		  for (i = 0; i < n; i++) {
		     if (i == h) {
			xp[i] = x[i] + gRandom->Uniform(-1.,1.) * vm[i];
		     } else {
			xp[i] = x[i];
		     }
		     //  If variation has led xp out of bounds:
		     firstfalse = true;
		     while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
			xp[i] = gRandom->Uniform(-2.,2.) * vm[i] + yyFittedVec[i].value;
			if (firstfalse) {
			   ++lnobds;
			   ++(nobds);
			}
			firstfalse = false;
		     }
		  }
		  // Then call the function to be minimized at the starting point
		  for (unsigned int ii = 0; ii < xp.size(); ii++) {
		     xdummy[ii] = xp[ii];
		  }
		  if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
		     cout << "running simulated annealing at t = " << t << " m(<"<<nt<<") = " << m << " j(<"<<ns<<") = " << j << 
			" h(<"<<n<<") = " << h << " " << yyFittedVec[h].name << " in niter = " << niter <<  endl;
		  }
                  if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
		    // system("top -b -n 1 -u uhlenbro");
		  }
		  if (yyVerbose) {
		     cout << "previous: accpoint = " << accpoint << " was better: " << accbetter <<  endl;
		     if (accpoint==1 && accbetter== 0) {
			cout << "d1 = " << d1 << " p = " << p << " pp = " << pp << endl;
		     }
		  }
		  fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
		  fp = -fp;
		  ++nfcnev;
		  xoptflag = 0;
		  // For too many function evaluations, terminate:
		  if (nfcnev >= maxevl) {
		     cout << "terminating simulated annealing prematurely due to number of calls" << endl;
		     fopt = -fopt;
		     ier = 1;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			yyFittedVec[k].value = xopt[k];
		     }
		     quit_while_loop = true;
		     return;
		  }
		  //  Accept new point if better chisq
		  if (fp < -111111111110.) {
		    ++nrej;
		    accpoint = 0;
		  }
		  else if (fp >= f) {
		     for (i = 0; i < n; ++i) {
			x[i] = xp[i];
		     }
		     f = fp;
		     ++nacc;
		     ++nacp[h];
		     ++nup;
		     accbetter = 1;
		     accpoint = 1;
		     //  If best chisq so far, record as new best parameter set:
		     if (fp > fopt) {
			for (i = 0; i < n; ++i) {
			   xopt[i] = xp[i];
			}
			if (m <= nt/2) {
			   lower_opt++;
			} else {
			   upper_opt++;
			}
			fopt = fp;
			++nnew;
			xoptflag = 1;
			if (yyVerbose){
			cout << "found new optimum at chisq = " << fopt << endl;
			}
		     }
		     //  Metropolis criteria to decide whether point is accepted if chisq is worse than before 
		  } else {
		     accbetter = 0;
		     d1 = (fp - f) / t;
		     p = TMath::Exp(d1);
		     pp = gRandom->Uniform(1.);
		     if (pp < p) {
			for (i = 1; i < n; ++i) {
			   x[i] = xp[i];
			}
			f = fp;
			++nacc;
			++nacp[h];
			++ndown;
			accpoint = 1;
		     } else {
			++nrej;
			accpoint = 0;
		     }
		  }
		  // write point to ntuple
		  ntupvars[0] = (Float_t)nfcnev;
		  ntupvars[1] = (Float_t)t;
		  ntupvars[2] = -(Float_t)fp;
		  ntupvars[3] = (Float_t)accpoint;
		  ntupvars[4] = (Float_t)xoptflag;
		  for (unsigned int ii = 5; ii < 5+yyFittedVec.size(); ii++) {
		     ntupvars[ii] = xp[ii-5];
		  }
		  ntuple->Fill(ntupvars);
	       } // close the outer variable loop
	    } // close the loop over the accepted function evaluations
	    // go on to adjust vm and t
	    // adjust vm to accept between 0.4 and 0.6 of the trial points at the given temperature
	    for (i = 0; i < n; ++i) {
	       ratio = (double) nacp[i] / (double) (ns);
	       if (ratio > 0.6) {
		  vm[i] *= c[i] * (ratio - 0.6) / 0.4 + 1.;
	       } else if (ratio < 0.4) {
		  vm[i] /= c[i] * (0.4 - ratio) / 0.4 + 1.;
	       }
	       if (vm[i] > ub[i] - lb[i]) {
		  vm[i] = ub[i] - lb[i];
	       }	
	    }
	    for (i = 0; i < n; ++i) {
	       nacp[i] = 0;
	    }
	 } // close the loop over the iterations before temperature reduction
	 // check whether to terminate
	 quit = false;
	 fstar[1] = f;
	 if (TMath::Abs(fopt - fstar[1]) <= eps) {
	    quit = true;
	 }
	 for (i = 0; i < neps; ++i) {
	    if (TMath::Abs(f - fstar[i]) > eps) {
	       quit = false;
	    }
	 }
	 //  Terminate simulated annealing if appropriate 
	 if (quit) {
	    for (i = 0; i < n; ++i) {
	       x[i] = xopt[i];
	    }
	    ier = 0;
	    fopt = -fopt;
	    quit_while_loop = true;
	 } else {
	    // If not terminating, prepare t
	    if (yyVerbose){
	    cout << "starting new temperature loop at t = " << rt * t <<  endl;
	    }
	    t = rt * t;
	    for (i = neps-1; i >= 1; --i) {
	       fstar[i] = fstar[i - 1];
	    }
	    f = fopt;
	    for (i = 0; i < n; ++i) {
	       x[i] = xopt[i];
	    }
	 }
      } // close the while loop 

      //--------------------------------------------
      // write output

      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 yyFittedVec[k].value = xopt[k];
      }
      if (yyVerbose){
      cout << "optimal function value " << fopt << " after " << nacc << " evaluations" << endl;
      }

   }

   void Fittino::simulated_annealing_uncertainties (TNtuple *ntuple)
   {

      Double_t xdummy[100];
      int n;
      vector <double> x; 
      vector <double> xvar; 
      //  bool max = false; 
      double rt; 
      double eps = 0.0001; 
      int ns = 20; 
      int nt; 
      int neps = 4;
      int maxevl; 
      vector <double> lb; 
      vector <double> ub;
      vector <double> c; 
      //  int iprint = 0;
      //  int iseed1 = 31327; 
      //  int iseed2 = 30080; 
      double t = 5.0; // initial temperature
      vector <double> vm;
      vector <double> xopt;
      double fopt = 11111111111.0;
      double fadd = 0.;	
      int nacc = 0; 
      int nfcnev = 0; 
      int nobds = 0;
      int ier = 0; 
      vector <double> fstar; 
      vector <double> xp;
      vector <int> nacp;

      /* System generated locals */
      //  int i1, i2, i3, i4;
      double d1;
      Double_t dummyfloat = 5.;
      Int_t dummyint = 1;

      /* Local variables */
      static int nrej;
      static int nnew;
      static bool quit = false;
      bool quit_while_loop = false;
      static double f;
      static double fminimum;
      static double fgoal;
      static double delta1;
      static double steepness;
      static int h, i, j, m;
      static double p, ratio;
      static int ndown;
      static int nup;
      static double fp, pp;
      static int lnobds;
      vector_type fill_vector;
      vector <vector_type> saved_x;
      vector <double> p_mean;
      vector <double> x_min;
      vector <double> x_dist;
      //  double fvar = 0.;
      bool firstfalse;
      int accpoint = 0;
      int xoptflag = 0;
      int niter = 0;
      int accbetter = 0;
      int lower_opt;
      int upper_opt;
      int lower_opt_before;
      int upper_opt_before;
      int number_stored = 30;
      bool start_pushaway = false;
      bool start_pushaway_now = false;
      int soon_start_pushaway = 0;

      Float_t ntupvars[50];

      // set values
      maxevl = yyMaxCallsSimAnn;
      rt = yyTempRedSimAnn;
      steepness = 100.;
      nup = 0;
      nrej = 0;
      nnew = 0;
      ndown = 0;
      lnobds = 0;
      lower_opt = 0;
      upper_opt = 0;
      lower_opt_before = 0;
      upper_opt_before = 0;
      n = yyFittedVec.size();
      if (n<20) {
	 nt = 60;
      } else {
	 nt = 3*n;
      }
      for (i = 0; i < neps; ++i) {
	 fstar.push_back(1e20);
      }

      // fill vector of parameters
      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 x.push_back(yyFittedVec[k].value);
	 x_min.push_back(yyFittedVec[k].value);
	 p_mean.push_back(yyFittedVec[k].value);
	 fill_vector.value.push_back(yyFittedVec[k].value);
	 xp.push_back(yyFittedVec[k].value);
	 xvar.push_back(yyFittedVec[k].value);
	 xopt.push_back(yyFittedVec[k].value);
	 vm.push_back(yyFittedVec[k].error);
	 lb.push_back(yyFittedVec[k].bound_low);
	 ub.push_back(yyFittedVec[k].bound_up);
	 c.push_back(2.0);
	 nacp.push_back(0);
      }
      for (unsigned int k = 0; k < (unsigned int)number_stored; k++ ) {
	 saved_x.push_back(fill_vector);
      }  

      /*  Evaluate function to be minimized at the starting point */
      for (unsigned int ii = 0; ii < xp.size(); ii++) {
	 xdummy[ii] = x[ii];
      }
      fitterFCN(dummyint, &dummyfloat, f, xdummy, 0);
      fminimum = f;
      fgoal = f+1.;
      f = -steepness*sqr(f-fgoal);
      ++nfcnev;
      fopt = f;
      fstar[1] = fopt;

      // // ------------------------------------------------------------------
      // // if initial temperature is given:
      // if (yyInitTempSimAnn>0.) {
      //   t = yyInitTempSimAnn;
      // }
      // else {
      //   // ------------------------------------------------------------------
      //   // if already very close to the minimum:
      //   if (TMath::Abs(f)<0.1) {
      //     t = 0.1;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }
      //   } else if (TMath::Abs(f)<1.) {
      //     t = 1.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }
      //   } else if (TMath::Abs(f)<5.) {
      //     t = 5.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<10.) {
      //     t = 10.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<100.) {
      //     t = 100.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<200.) {
      //     t = 200.;
      //     if (rt<0.5) {
      //       rt = 0.5;
      //     }    
      //   } else {
      //     //-------------------------------------------
      //     // if not very close to the minimum:
      //     // first adjust the temperature to the variance for variations within vm?
      //     nvalid = 0;
      //     fsum = 0.;
      //     fcubed = 0.;
      //     for (m = 0; m < 10; m++) {
      //       for (i = 0; i < n; i++) {
      //         xp[i] = xvar[i] + gRandom->Uniform(-1.,1.) * vm[i];
      //         //  If variation has led xp out of bounds:
      //         while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
      //           xp[i] = gRandom->Uniform(-1.,1.) * vm[i] + yyFittedVec[i].value;
      //         }
      //         // Then call the function to be minimized at the starting point
      //         for (unsigned int ii = 0; ii < xp.size(); ii++) {
      //           xdummy[ii] = xp[ii];
      //         }
      //         fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
      //         fp = -fp;
      //         cout << "fp = " << fp << endl;
      //         if (fp > -1e10) {
      //           //	fopt = 0.;
      //           //      fp = 5.;
      //           fsum = fsum + TMath::Abs(fopt - fp);
      //           fcubed = fcubed + sqr((fopt - fp));
      //           nvalid++;
      //         }
      //         xp[i] = xvar[i];
      //       }
      //       for (i = 0; i < n; i++) {
      //         xvar[i] = xp[i];
      //       }
      //     }
      //     // set t to half of the variance
      //     t = TMath::Sqrt(fcubed/double(nvalid) - sqr(fsum/double(nvalid)))/2.;
      //   }
      // }
      t = 0.05;
      if (yyVerbose){
      cout << "temperature chosen " << t << endl;
      }

      //-------------------------------------------
      // perform the optimization
      niter = 0;

      // begin new temperature era
      while (!quit_while_loop) {
	 nup = 0;
	 nrej = 0;
	 nnew = 0;
	 ndown = 0;
	 lnobds = 0;
	 niter++;
	 // loop over the iterations before temperature reduction:
	 for (m = 0; m < nt; m++) {
	    lower_opt_before = lower_opt;
	    upper_opt_before = upper_opt;
	    lower_opt=0;
	    upper_opt=0;
	    // loop over the accepted function evaluations:
	    for (j = 0; j < ns; j++) {
	       // loop over the variables:
	       for (h = 0; h < n; h++) {
		  for (i = 0; i < n; i++) {
		     if (i == h) {
			xp[i] = x[i] + gRandom->Uniform(-1.,1.) * vm[i];
		     } else {
			xp[i] = x[i];
		     }
		     //  If variation has led xp out of bounds:
		     firstfalse = true;
		     while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
			xp[i] = gRandom->Uniform(-2.,2.) * vm[i] + yyFittedVec[i].value;
			if (firstfalse) {
			   ++lnobds;
			   ++(nobds);
			}
			firstfalse = false;
		     }
		  }
		  // Then call the function to be minimized at the starting point
		  for (unsigned int ii = 0; ii < xp.size(); ii++) {
		     xdummy[ii] = xp[ii];
		  }
		  if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
		     cout << "running simulated annealing at t = " << t << " m(<"<<nt<<") = " << m << " j(<"<<ns<<") = " << j << 
			" h(<"<<n<<") = " << h << " " << yyFittedVec[h].name << " in niter = " << niter <<  endl;
		  }
		  if (yyVerbose) {
		     cout << "previous: accpoint = " << accpoint << " was better: " << accbetter <<  endl;
		     if (accpoint==1 && accbetter== 0) {
			cout << "d1 = " << d1 << " p = " << p << " pp = " << pp << endl;
		     }
		  }
		  fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
		  if (yyVerbose){
		  cout << "fminimum = " << fminimum << " fgoal = " << fgoal << " fp = " << fp << " with up to now " << nacc << " accepted points" << endl;
		  }
		  delta1 = TMath::Abs(fp-fgoal);
		  fp = steepness*sqr(fp-fgoal);
		  if (start_pushaway) {
		     // calculate mean
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			p_mean[k] = 0.;
			for (unsigned int kk = 0; kk < (unsigned int)number_stored; kk++ ) {
			   p_mean[k] = p_mean[k] + saved_x[kk].value[k];
			}
			p_mean[k] = p_mean[k] / (double) number_stored;
		     }	    
		     if (yyVerbose){
		     cout << "p_mean[0] = " << p_mean[0] << " xp[0] = " << xp[0]  << endl;
		     }
		     // add something to fp
		     fadd = 0.;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			//	      fadd = fadd + sqr((xp[k]-p_mean[k])/((double)steepness*0.003*(xp[k]-x_min[k])));
			fadd = fadd + sqr((xp[k]-p_mean[k])/((double)steepness*0.003*(x_dist[k])));
		     }	    
		     if (fadd > 0.) {
			fadd = 1./fadd;
		     } else {
			fadd = 0.;
			cerr << "WARNING: fadd == 0" << endl;
		     }
		     if (start_pushaway_now == false) {
			f = f - 2.*fadd - 1.; // make sure it is accepted on the first time
			start_pushaway_now = true;
		     }
		     if (yyVerbose){
		     cout << "adding " << fadd << " to the potential, with f = " << f << endl;
		     }
		     fp = fp + fadd;
		  }
		  if (yyVerbose){
		  cout << "hyperbolical chisq = " << fp << endl;
		  }
		  fp = -fp;
		  ++nfcnev;
		  xoptflag = 0;
		  // For too many function evaluations, terminate:
		  if (nfcnev >= maxevl) {
		     cout << "terminating simulated annealing uncertainty estimation due to number of calls" << endl;
		     fopt = -fopt;
		     ier = 1;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			yyFittedVec[k].value = xopt[k];
		     }
		     quit_while_loop = true;
		     return;
		  }
		  //  Accept new point if better chisq
		  if (yyVerbose){
		  cout << " f = " << f << " fp = " << fp << endl; 
		  }
		  if (fp >= f) {
		    if (yyVerbose){
		     cout << "accept point because better" << endl;
		    }
		     for (i = 0; i < n; ++i) {
			x[i] = xp[i];
		     }
		     f = fp;
		     ++nacc;
		     ++nacp[h];
		     ++nup;
		     accbetter = 1;
		     accpoint = 1;
		     //  If best chisq so far, record as new best parameter set:
		     if (fp > fopt) {
			for (i = 0; i < n; ++i) {
			   xopt[i] = xp[i];
			}
			if (m <= nt/2) {
			   lower_opt++;
			} else {
			   upper_opt++;
			}
			fopt = fp;
			++nnew;
			xoptflag = 1;
			if (yyVerbose){
			cout << "found new optimum at chisq = " << fopt << endl;
			}
		     }
		     //  Metropolis criteria to decide whether point is accepted if chisq is worse than before 
		  } else {
		    if (yyVerbose){
		     cout << "point is worse, contemplate acceptance..." << endl;
		    }
		     accbetter = 0;
		     d1 = (fp - f) / t;
		     p = TMath::Exp(d1);
		     pp = gRandom->Uniform(1.);
		     if (pp < p) {
			for (i = 1; i < n; ++i) {
			   x[i] = xp[i];
			}
			f = fp;
			++nacc;
			++nacp[h];
			++ndown;
			accpoint = 1;
			if (yyVerbose){
			cout << "accept anyway" << endl;
			}
		     } else {
		       if (yyVerbose){
			cout << "reject" << endl;
		       }
			++nrej;
			accpoint = 0;
		     }
		  }
		  // store info for pushaway
		  if ( soon_start_pushaway == 0 && nacc > number_stored && TMath::Abs(fopt) < 0.1 ) {
		     soon_start_pushaway = nacc;
		  }
		  if ( ( soon_start_pushaway > 0 ) && ( nacc > 2 * soon_start_pushaway ) ) {
		     start_pushaway = true;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			x_dist.push_back(xopt[k]-x_min[k]);
		     }
		  }
		  if (accpoint > 0.5) {
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			fill_vector.value[k] = xp[k];
		     }
		     for (unsigned int k = number_stored-1; k > 0; k-- ) {
			saved_x[k].value = saved_x[k-1].value;
		     }	    
		     saved_x[0] = fill_vector;
		     if (yyVerbose){
		     cout << " 0: " << saved_x[0].value[0] <<  
			" 1: " << saved_x[1].value[0] <<  
			" 2: " << saved_x[2].value[0] <<  
			" 3: " << saved_x[3].value[0] <<
			" 4: " << saved_x[4].value[0] << endl;
		     }
		  }
		  // write point to ntuple
		  ntupvars[0] = (Float_t)nfcnev;
		  ntupvars[1] = (Float_t)t;
		  ntupvars[2] = -(Float_t)fp;
		  ntupvars[3] = (Float_t)accpoint;
		  ntupvars[4] = (Float_t)xoptflag;
		  ntupvars[5] = (Float_t)delta1;
		  for (unsigned int ii = 6; ii < 6+yyFittedVec.size(); ii++) {
		     ntupvars[ii] = xp[ii-6];
		  }
		  ntuple->Fill(ntupvars);
	       } // close the outer variable loop
	    } // close the loop over the accepted function evaluations
	    // go on to adjust vm and t
	    // adjust vm to accept between 0.4 and 0.6 of the trial points at the given temperature
	    if (!start_pushaway) {
	       for (i = 0; i < n; ++i) {
		  ratio = (double) nacp[i] / (double) (ns);
		  if (ratio > 0.6) {
		     vm[i] *= c[i] * (ratio - 0.6) / 0.4 + 1.;
		  } else if (ratio < 0.4) {
		     vm[i] /= c[i] * (0.4 - ratio) / 0.4 + 1.;
		  }
		  if (vm[i] > ub[i] - lb[i]) {
		     vm[i] = ub[i] - lb[i];
		  }	
	       }
	       for (i = 0; i < n; ++i) {
		  nacp[i] = 0;
	       }
	    }
	 } // close the loop over the iterations before temperature reduction
	 // check whether to terminate
	 quit = false;
	 fstar[1] = f;
	 if (TMath::Abs(fopt - fstar[1]) <= eps) {
	    quit = true;
	 }
	 for (i = 0; i < neps; ++i) {
	    if (TMath::Abs(f - fstar[i]) > eps) {
	       quit = false;
	    }
	 }
	 //  Terminate simulated annealing if appropriate 
	 if (quit) {
	    for (i = 0; i < n; ++i) {
	       x[i] = xopt[i];
	    }
	    ier = 0;
	    fopt = -fopt;
	    // quit_while_loop = true;
	 } else {
	    // If not terminating, prepare t
	    if (yyVerbose){
	    cout << "starting new temperature loop at t = " << rt * t <<  endl;
	    }
	    // t = rt * t;
	    for (i = neps-1; i >= 1; --i) {
	       fstar[i] = fstar[i - 1];
	    }
	    // f = fopt;
	    // for (i = 0; i < n; ++i) {
	    //	x[i] = xopt[i];
	    // }
	 }
      } // close the while loop 

      //--------------------------------------------
      // write output

      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 yyFittedVec[k].value = xopt[k];
      }
      if (yyVerbose){
      cout << "optimal function value " << fopt << " after " << nacc << " evaluations" << endl;
      }

   }


   void Fittino::simulated_annealing_uncertainties_run_down (TNtuple *ntuple)
   {

      Double_t xdummy[100];
      int n;
      vector <double> x; 
      vector <double> xvar; 
      //  bool max = false; 
      double rt; 
      double eps = 0.0001; 
      int ns = 20; 
      int nt; 
      int neps = 4;
      int maxevl; 
      vector <double> lb; 
      vector <double> ub;
      vector <double> c; 
      //  int iprint = 0;
      //  int iseed1 = 31327; 
      //  int iseed2 = 30080; 
      double t = 5.0; // initial temperature
      vector <double> vm;
      vector <double> vm_orig;
      vector <double> xopt;
      double fopt = 11111111111.0;
      //double fadd = 0.;	
      int nacc = 0; 
      int nfcnev = 0; 
      int nobds = 0;
      int ier = 0; 
      vector <double> fstar; 
      vector <double> xp;
      vector <int> nacp;

      /* System generated locals */
      //  int i1, i2, i3, i4;
      double d1;
      Double_t dummyfloat = 5.;
      Int_t dummyint = 1;

      /* Local variables */
      static int nrej;
      static int nnew;
      static bool quit = false;
      bool quit_while_loop = false;
      static double f;
      static double fminimum;
      static double fgoal;
      static double delta1;
      static double steepness;
      static int h, i, j, m;
      static double p, ratio;
      static int ndown;
      static int nup;
      static double fp, pp;
      static int lnobds;
      vector_type fill_vector;
      vector <vector_type> saved_x;
      vector <double> p_mean;
      vector <double> x_min;
      vector <double> x_dist;
      //  double fvar = 0.;
      bool firstfalse;
      int accpoint = 0;
      int xoptflag = 0;
      int niter = 0;
      int accbetter = 0;
      int lower_opt;
      int upper_opt;
      int lower_opt_before;
      int upper_opt_before;
      int number_stored = 30;
      //bool start_pushaway = false;
      //bool start_pushaway_now = false;
      int n_found = 0;
      //int soon_start_pushaway = 0;

      Float_t ntupvars[50];

      // set values
      maxevl = yyMaxCallsSimAnn;
      rt = yyTempRedSimAnn;
      steepness = 100.;
      nup = 0;
      nrej = 0;
      nnew = 0;
      ndown = 0;
      lnobds = 0;
      lower_opt = 0;
      upper_opt = 0;
      lower_opt_before = 0;
      upper_opt_before = 0;
      n = yyFittedVec.size();
      if (n<20) {
	 nt = 60;
      } else {
	 nt = 3*n;
      }
      for (i = 0; i < neps; ++i) {
	 fstar.push_back(1e20);
      }

      // fill vector of parameters
      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 x.push_back(yyFittedVec[k].value);
	 x_min.push_back(yyFittedVec[k].value);
	 p_mean.push_back(yyFittedVec[k].value);
	 fill_vector.value.push_back(yyFittedVec[k].value);
	 xp.push_back(yyFittedVec[k].value);
	 xvar.push_back(yyFittedVec[k].value);
	 xopt.push_back(yyFittedVec[k].value);
	 vm.push_back(yyFittedVec[k].error);
	 vm_orig.push_back(yyFittedVec[k].error);
	 lb.push_back(yyFittedVec[k].bound_low);
	 ub.push_back(yyFittedVec[k].bound_up);
	 c.push_back(2.0);
	 nacp.push_back(0);
      }
      for (unsigned int k = 0; k < (unsigned int)number_stored; k++ ) {
	 saved_x.push_back(fill_vector);
      }  

      /*  Evaluate function to be minimized at the starting point */
      for (unsigned int ii = 0; ii < xp.size(); ii++) {
	 xdummy[ii] = x[ii];
      }
      fitterFCN(dummyint, &dummyfloat, f, xdummy, 0);
      fminimum = f;
      fgoal = f+1.;
      f = -steepness*sqr(f-fgoal);
      ++nfcnev;
      fopt = f;
      fstar[1] = fopt;

      // // ------------------------------------------------------------------
      // // if initial temperature is given:
      // if (yyInitTempSimAnn>0.) {
      //   t = yyInitTempSimAnn;
      // }
      // else {
      //   // ------------------------------------------------------------------
      //   // if already very close to the minimum:
      //   if (TMath::Abs(f)<0.1) {
      //     t = 0.1;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }
      //   } else if (TMath::Abs(f)<1.) {
      //     t = 1.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }
      //   } else if (TMath::Abs(f)<5.) {
      //     t = 5.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<10.) {
      //     t = 10.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<100.) {
      //     t = 100.;
      //     if (rt<0.6) {
      //       rt = 0.6;
      //     }    
      //   } else if (TMath::Abs(f)<200.) {
      //     t = 200.;
      //     if (rt<0.5) {
      //       rt = 0.5;
      //     }    
      //   } else {
      //     //-------------------------------------------
      //     // if not very close to the minimum:
      //     // first adjust the temperature to the variance for variations within vm?
      //     nvalid = 0;
      //     fsum = 0.;
      //     fcubed = 0.;
      //     for (m = 0; m < 10; m++) {
      //       for (i = 0; i < n; i++) {
      //         xp[i] = xvar[i] + gRandom->Uniform(-1.,1.) * vm[i];
      //         //  If variation has led xp out of bounds:
      //         while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
      //           xp[i] = gRandom->Uniform(-1.,1.) * vm[i] + yyFittedVec[i].value;
      //         }
      //         // Then call the function to be minimized at the starting point
      //         for (unsigned int ii = 0; ii < xp.size(); ii++) {
      //           xdummy[ii] = xp[ii];
      //         }
      //         fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
      //         fp = -fp;
      //         cout << "fp = " << fp << endl;
      //         if (fp > -1e10) {
      //           //	fopt = 0.;
      //           //      fp = 5.;
      //           fsum = fsum + TMath::Abs(fopt - fp);
      //           fcubed = fcubed + sqr((fopt - fp));
      //           nvalid++;
      //         }
      //         xp[i] = xvar[i];
      //       }
      //       for (i = 0; i < n; i++) {
      //         xvar[i] = xp[i];
      //       }
      //     }
      //     // set t to half of the variance
      //     t = TMath::Sqrt(fcubed/double(nvalid) - sqr(fsum/double(nvalid)))/2.;
      //   }
      // }
      t = 0.05;
      if (yyVerbose){
      cout << "temperature chosen " << t << endl;
      }

      //-------------------------------------------
      // perform the optimization
      niter = 0;

      // begin new temperature era
      while (!quit_while_loop) {
	 nup = 0;
	 nrej = 0;
	 nnew = 0;
	 ndown = 0;
	 lnobds = 0;
	 niter++;
	 // loop over the iterations before temperature reduction:
	 for (m = 0; m < nt; m++) {
	    lower_opt_before = lower_opt;
	    upper_opt_before = upper_opt;
	    lower_opt=0;
	    upper_opt=0;
	    // loop over the accepted function evaluations:
	    for (j = 0; j < ns; j++) {
	       // loop over the variables:
	       for (h = 0; h < n; h++) {
		  for (i = 0; i < n; i++) {
		     if (i == h) {
			xp[i] = x[i] + gRandom->Uniform(-1.,1.) * vm[i];
		     } else {
			xp[i] = x[i];
		     }
		     //  If variation has led xp out of bounds:
		     firstfalse = true;
		     while ( (xp[i] < lb[i]) || (xp[i] > ub[i]) ) {
			xp[i] = gRandom->Uniform(-2.,2.) * vm[i] + yyFittedVec[i].value;
			if (firstfalse) {
			   ++lnobds;
			   ++(nobds);
			}
			firstfalse = false;
		     }
		  }
		  // Then call the function to be minimized at the starting point
		  for (unsigned int ii = 0; ii < xp.size(); ii++) {
		     xdummy[ii] = xp[ii];
		  }
		  if (yyVerbose || ( TMath::Abs( ( (float)n_printouts/100. ) - n_printouts/100 ) < 0.01 ) ) { 
		     cout << "running simulated annealing at t = " << t << " m(<"<<nt<<") = " << m << " j(<"<<ns<<") = " << j << 
			" h(<"<<n<<") = " << h << " " << yyFittedVec[h].name << " in niter = " << niter <<  endl;
		  }
		  if (yyVerbose) {
		     cout << "previous: accpoint = " << accpoint << " was better: " << accbetter <<  endl;
		     if (accpoint==1 && accbetter== 0) {
			cout << "d1 = " << d1 << " p = " << p << " pp = " << pp << endl;
		     }
		  }
		  fitterFCN(dummyint, &dummyfloat, fp, xdummy, 0);
		  if (yyVerbose){
		  cout << "fminimum = " << fminimum << " fgoal = " << fgoal << " fp = " << fp << " with up to now " << nacc << 
		     " accepted points, n_found = " << n_found << endl;
		  }
		  delta1 = TMath::Abs(fp-fgoal);
		  fp = steepness*sqr(fp-fgoal);
		  if (yyVerbose){
		  cout << "hyperbolical chisq = " << fp << endl;
		  }
		  fp = -fp;
		  ++nfcnev;
		  xoptflag = 0;
		  // For too many function evaluations, terminate:
		  if (nfcnev >= maxevl) {
		     cout << "terminating simulated annealing uncertainty estimation due to number of calls" << endl;
		     fopt = -fopt;
		     ier = 1;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
			yyFittedVec[k].value = xopt[k];
		     }
		     quit_while_loop = true;
		     return;
		  }
		  //  Accept new point if better chisq
		  if (yyVerbose){
		  cout << " f = " << f << " fp = " << fp << endl; 
		  }
		  if (fp >= f) {
		    if (yyVerbose){
		     cout << "accept point because better" << endl;
		    }
		     for (i = 0; i < n; ++i) {
			x[i] = xp[i];
		     }
		     f = fp;
		     ++nacc;
		     ++nacp[h];
		     ++nup;
		     accbetter = 1;
		     accpoint = 1;
		     //  If best chisq so far, record as new best parameter set:
		     if (fp > fopt) {
			for (i = 0; i < n; ++i) {
			   xopt[i] = xp[i];
			}
			if (m <= nt/2) {
			   lower_opt++;
			} else {
			   upper_opt++;
			}
			fopt = fp;
			++nnew;
			xoptflag = 1;
			if (yyVerbose){
			cout << "found new optimum at chisq = " << fopt << endl;
			}
		     }
		     //  Metropolis criteria to decide whether point is accepted if chisq is worse than before 
		  } else {
		    if (yyVerbose){
		     cout << "point is worse, contemplate acceptance..." << endl;
		    }
		     accbetter = 0;
		     d1 = (fp - f) / t;
		     p = TMath::Exp(d1);
		     pp = gRandom->Uniform(1.);
		     if (pp < p) {
			for (i = 1; i < n; ++i) {
			   x[i] = xp[i];
			}
			f = fp;
			++nacc;
			++nacp[h];
			++ndown;
			accpoint = 1;
			if (yyVerbose){
			cout << "accept anyway" << endl;
			}
		     } else {
		       if (yyVerbose){
			cout << "reject" << endl;
		       }
			++nrej;
			accpoint = 0;
		     }
		  }
		  // 
		  // 	     // store info for pushaway
		  // 	     if ( soon_start_pushaway == 0 && nacc > number_stored && TMath::Abs(fopt) < 0.1 ) {
		  // 	       soon_start_pushaway = nacc;
		  // 	     }
		  // 	     if ( ( soon_start_pushaway > 0 ) && ( nacc > 2 * soon_start_pushaway ) ) {
		  // 	       start_pushaway = true;
		  // 	       for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		  // 		 x_dist.push_back(xopt[k]-x_min[k]);
		  // 	       }
		  // 	     }
		  // 	     if (accpoint > 0.5) {
		  // 	       for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		  // 		 fill_vector.value[k] = xp[k];
		  // 	       }
		  // 	       for (unsigned int k = number_stored-1; k > 0; k-- ) {
		  // 		 saved_x[k].value = saved_x[k-1].value;
		  // 	       }	    
		  // 	       saved_x[0] = fill_vector;
		  // 	       cout << " 0: " << saved_x[0].value[0] <<  
		  // 		 " 1: " << saved_x[1].value[0] <<  
		  // 		 " 2: " << saved_x[2].value[0] <<  
		  // 		 " 3: " << saved_x[3].value[0] <<
		  // 		 " 4: " << saved_x[4].value[0] << endl;
		  // 	     }
		  // write point to ntuple
		  ntupvars[0] = (Float_t)nfcnev;
		  ntupvars[1] = (Float_t)t;
		  ntupvars[2] = -(Float_t)fp;
		  ntupvars[3] = (Float_t)accpoint;
		  ntupvars[4] = (Float_t)xoptflag;
		  ntupvars[5] = (Float_t)delta1;
		  for (unsigned int ii = 6; ii < 6+yyFittedVec.size(); ii++) {
		     ntupvars[ii] = xp[ii-6];
		  }
		  ntuple->Fill(ntupvars);
		  if (n_found > 2.5 && delta1<0.05) {
		    if (yyVerbose){
		     cout << endl << endl << endl << "restarting simann" << endl;
		    }
		     // restart
		     n_found = 0;
		     for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
		       if (yyVerbose){
			cout << yyFittedVec[k].name << " = " << x_min[k] << endl; 
		       }
			vm[k] = TMath::Abs(xopt[k]-x_min[k]);
			x[k] = x_min[k];
			xopt[k] = x_min[k];
			xp[k] = x_min[k];
			//	      vm[k] = vm_orig[k];
		     }	
		     if (yyVerbose){
		     cout << endl << endl << endl ;
		     }
		     f = -111111111.;
		     fopt = f;
		     fp = f;
		  }
		  if (delta1<0.05) {
		     n_found++;
		  }
	       } // close the outer variable loop
	    } // close the loop over the accepted function evaluations
	    // go on to adjust vm and t
	    // adjust vm to accept between 0.4 and 0.6 of the trial points at the given temperature
	    for (i = 0; i < n; ++i) {
	       ratio = (double) nacp[i] / (double) (ns);
	       if (ratio > 0.6) {
		  vm[i] *= c[i] * (ratio - 0.6) / 0.4 + 1.;
	       } else if (ratio < 0.4) {
		  vm[i] /= c[i] * (0.4 - ratio) / 0.4 + 1.;
	       }
	       if (vm[i] > ub[i] - lb[i]) {
		  vm[i] = ub[i] - lb[i];
	       }	
	    }
	    for (i = 0; i < n; ++i) {
	       nacp[i] = 0;
	    }
	 } // close the loop over the iterations before temperature reduction
	 // check whether to terminate
	 quit = false;
	 fstar[1] = f;
	 if (TMath::Abs(fopt - fstar[1]) <= eps) {
	    quit = true;
	 }
	 for (i = 0; i < neps; ++i) {
	    if (TMath::Abs(f - fstar[i]) > eps) {
	       quit = false;
	    }
	 }
	 //  Terminate simulated annealing if appropriate 
	 if (quit) {
	    for (i = 0; i < n; ++i) {
	       x[i] = xopt[i];
	    }
	    ier = 0;
	    fopt = -fopt;
	    // quit_while_loop = true;
	 } else {
	    // If not terminating, prepare t
	    if (yyVerbose){
	    cout << "starting new temperature loop at t = " << rt * t <<  endl;
	    }
	    // t = rt * t;
	    for (i = neps-1; i >= 1; --i) {
	       fstar[i] = fstar[i - 1];
	    }
	    // f = fopt;
	    // for (i = 0; i < n; ++i) {
	    //	x[i] = xopt[i];
	    // }
	 }
      } // close the while loop 

      //--------------------------------------------
      // write output

      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 yyFittedVec[k].value = xopt[k];
      }
      if (yyVerbose){
      cout << "optimal function value " << fopt << " after " << nacc << " evaluations" << endl;
      }

   }


   void Fittino::randomDirectionUncertainties()
   {
     if (yyVerbose){
      cout<<"Using randomDirectionUncertainties"<<endl;
     }

      const double eps = 0.005;
      double* optpar = new double[yyFittedVec.size()];

      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 optpar[k] = yyFittedVec[k].value;
      }

      int npar, iflag;
      double* gin;
      double minChi2;
      fitterFCN(npar, gin, minChi2, optpar, iflag);

      time_t systime;
      int seed;
      struct sysinfo sinfo; 
      // set the random number generator
      time (&systime);
      sysinfo(&sinfo);
      if (yyRandomGeneratorSeed < 0) {
	 seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
	 if (yyVerbose){
	 cout<<"uptime = "<<sinfo.uptime<<endl;
	 cout<<"freeswap = "<<sinfo.freeswap<<endl;
	 cout<<"pid = "<<getpid()<<endl;
	 cout << "systime " << systime << endl; 
	 }
      }
      else {
	if (yyVerbose){
	 cout<<"using seed from input file"<<endl;
	}
	 seed = yyRandomGeneratorSeed;
      }
      if (yyVerbose){
      cout << "seed = " << seed << endl;
      }
      gRandom->SetSeed(seed);

      double* par = new double[yyFittedVec.size()];
      double* unitvec = new double[yyFittedVec.size()];
      double chi2;
      double deltaChi2;

      TFile* file = new TFile("RandomDirUncertainties.root", "recreate");
      TTree* tree = new TTree("tree", "Tree containing fitted parameters");
      vector<MeasuredValue> leafVec(yyFittedPar.size());
      if (yyVerbose){
      cout<<"Creating RandomDirectionUncertainties tree"<<endl;
      }
      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	 leafVec[k].name = yyFittedVec[k].name;
	 leafVec[k].value = -1;
	 string str = yyFittedVec[k].name;
	 str.append("/D");
	 if (yyVerbose){
	 cout << "Adding branch " << yyFittedVec[k].name.c_str() << " to tree" << endl;
	 }
	 tree->Branch(yyFittedVec[k].name.c_str(), &(leafVec[k].value), str.c_str());
	 str.erase();
      }
      if (yyVerbose){
      cout << "Adding branch DeltaChi2 to tree" << endl;
      }
      tree->Branch("DeltaChi2", &deltaChi2, "DeltaChi2/D");

      for (int idir=0; idir<yyNumberOfDirections; idir++) {

	 double d = 0;
	 for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	    par[k] = gRandom->Uniform(0.99, 1.01) * optpar[k];
	    unitvec[k] = par[k] - optpar[k];
	    d += (par[k] - optpar[k]) * (par[k] - optpar[k]);
	 }
	 d = TMath::Sqrt(d);

	 for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	    unitvec[k] /= d;
	 }

	 unsigned int ncalls = 0;
	 double prevd = 0;
	 /*
	    double dinit[3];
	    double finit[3];
	    */
	 while (1) {
	    fitterFCN(npar, gin, chi2, par, iflag);
	    ncalls++;
	    deltaChi2 = chi2 - minChi2;
	    if (yyVerbose){
	    cout<<"f = "<<deltaChi2<<endl;
	    cout<<"d = "<<d<<endl;
	    }
	    if (deltaChi2 < 0) cerr<<"WARNING: Minimization did not yield global minimum"<<endl;
	    if (TMath::Abs(deltaChi2 - yyErrDef) < eps || ncalls > 50) break;
	    /*
	       if (ncalls < 4) {
	       dinit[ncalls-1] = d;
	       finit[ncalls-1] = deltaChi2;
	       }
	       if (ncalls == 3) {
	       double x1 = dinit[0];
	       double x2 = dinit[1];
	       double x3 = dinit[2];
	       double y1 = finit[0];
	       double y2 = finit[1];
	       double y3 = finit[2];
	       double denominator = ( -x3 * sqr(x1) + x3 * sqr(x2) + x2 * sqr(x1) + x1 * sqr(x3)
	       - x1 * sqr(x2) - x2 * sqr(x3) );
	       double a2 = ( -x3 * y1 + x3 * y2 + x2 * y1 + x1 * y3 - x1 * y2 - x2 * y3 ) / denominator;
	       double a1 = - ( sqr(x2) * y1 - sqr(x2) * y3 + y2 * sqr(x3) + y3 * sqr(x1)
	       - sqr(x3) * y1 - y2 * sqr(x1) ) / denominator;
	       double a0 = ( -y2 * x3 * sqr(x1) + sqr(x3) * x1 * y2 + sqr(x2) * x3 * y1
	       - sqr(x2) * x1 * y3 + y3 * x2 * sqr(x1) - sqr(x3) * x2 * y1 ) / denominator;
	       double sol1 = 0.5 * ( -a1 + TMath::Sqrt( sqr(a1) + 4 * a2 - 4 * a2 * a0 ) ) / a2;
	       double sol2 = 0.5 * ( -a1 - TMath::Sqrt( sqr(a1) + 4 * a2 - 4 * a2 * a0 ) ) / a2;
	       cout<<"sol1 = "<<sol1<<"     sol2 = "<<sol2<<endl;
	       d = (sol1 > 0) ? sol1 : sol2; 
	       }
	       else {
	       if (ncalls == 4) {
	       prevd = deltaChi2;
	       }
	       */
	    if (deltaChi2 > 1) {
	       double tmp = d;
	       d = d - TMath::Abs(d - prevd) * 0.5;
	       prevd = tmp;
	    }
	    else {
	       double tmp = d;
	       d = d + TMath::Abs(d - prevd) * 0.5;
	       prevd = tmp;
	    }
	    /*
	       }
	       */
	    for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	       par[k] = optpar[k] + d * unitvec[k];
	    }
	 }

if (yyVerbose){
	 cout<<"Found interception with uncertainty countour (ErrDef = "
	    <<yyErrDef<<", f = "<<deltaChi2<<") at"<<endl;
}
	 for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	   if (yyVerbose){
	    cout<<yyFittedVec[k].name<<" = "<<par[k]<<endl;
	   }
	    leafVec[k].name = yyFittedVec[k].name;
	    leafVec[k].value = par[k];
	 }

	 tree->Fill();
      }

      tree->Write();
      file->Close();

      if (optpar) delete[] optpar;
      if (par) delete[] par;
   }




void Fittino::markovChain ()
{
  vector <double> x; 
  vector <double> vm;
  vector <double> xp;
  vector <double> lb; 
  vector <double> ub;
  vector <string> xNames;
  vector <double> obsTheoValue(yyMeasuredVec.size());
  vector <double> previousObsTheoValue(yyMeasuredVec.size());
  Float_t ntupvars[5000];
  Double_t dummyfloat = 5.;
  Int_t dummyint = 1;
  Double_t xdummy[100];
  vector <int> nacp;
  vector <int> ntest;
  vector <double> c; 
  int successes = 0;
  int globalIter = 0;

      char ntuplename[256];
      char ntupletext[256];
      char ntuplevars[65536];

      TFile *MarkovNtupFile = new TFile("MarkovChainNtupFile.root","RECREATE");
      sprintf ( ntuplename, "markovChain" );
      sprintf ( ntupletext, "path of the Markov Chain" );
      ////      sprintf ( ntuplevars, "likelihood:rho:chi2:accpoint:n:haveAcceptedAtLeastOne:globalIter" );
      //      sprintf ( ntuplevars, "likelihood:rho:chi2:accpoint:n:globalIter:haveAcceptedAtLeastOne" );
      sprintf ( ntuplevars, "likelihood:rho:chi2:accpoint:n:globalIter:haveAcceptedAtLeastOne:LHC_CLb:LHC_CLsb:LHC_chi2:LHC_Exp_CLb:LHC_Exp_CLsb:LHC_Exp_chi2:af_photon:af_relic:af_svind:af_direct:af_chi2_total:af_chi2_photon:af_chi2_relic:af_chi2_svind:af_chi2_direct:globalHiggsChi2" );
//	    ntupvars[0] = (Float_t)likelihood;
//	    ntupvars[1] = (Float_t)rho;
//	    ntupvars[2] = (Float_t)chi2;
//	    ntupvars[3] = (Float_t)accpoint;
//	    ntupvars[4] = (Float_t)niter;
//	    ntupvars[5] = (Float_t)globalIter;
//	    ntupvars[6] = (haveAcceptedAtLeastOne) ? 1 : 0;
//	    ntupvars[7] = (Float_t)global_LHC_CLb;
//	    ntupvars[8] = (Float_t)global_LHC_CLsb;
//	    ntupvars[9] = (Float_t)global_LHC_chi2;
//	    ntupvars[10] = (Float_t)global_LHC_Exp_CLb;
//	    ntupvars[11] = (Float_t)global_LHC_Exp_CLsb;
//	    ntupvars[12] = (Float_t)global_LHC_Exp_chi2;
//	    ntupvars[13] = (Float_t) af_photon;
//	    ntupvars[14] = (Float_t) af_relic;
//	    ntupvars[15] = (Float_t) af_svind;
//	    ntupvars[16] = (Float_t) af_direct;
//	    ntupvars[17] = (Float_t) af_chi2_total;
//	    ntupvars[18] = (Float_t) af_chi2_photon;
//	    ntupvars[19] = (Float_t) af_chi2_relic;
//	    ntupvars[20] = (Float_t) af_chi2_svind;
//	    ntupvars[21] = (Float_t) af_chi2_direct;
//	    ntupvars[22] = (Float_t) globalHiggsChi2;
      for (unsigned int j=0; j < yyFittedVec.size(); j++ ) {
	string parName = "P_"+yyFittedVec[j].name;
	sprintf ( ntuplevars, "%s:%s", ntuplevars, parName.c_str() );
      }
      for (unsigned int k = 0; k < yyMeasuredVec.size(); k++ ) {
	if (yyMeasuredVec[k].nofit == false) {
	  string obsName = "";
	  if (strchr(yyMeasuredVec[k].name.c_str(),'>') || strchr(yyMeasuredVec[k].name.c_str(),' ') ) {

	    if (yyVerbose){
	    cout << "found unlucky string: " <<  yyMeasuredVec[k].name << endl;
	    }
	    string correctedName = "";
	    char varName[1024];
	    strcpy(varName,"");
	    char* movedVarName = varName;
	    strcpy(varName,yyMeasuredVec[k].name.c_str());
	    char* firstPos;
	    while (strchr(movedVarName,'>')) {
	      firstPos = strchr(movedVarName,'>');
	      if (firstPos) {
		int length = strlen(movedVarName)-strlen(firstPos);
		if (yyVerbose){
		cout << "found initial string of length " << length << " before the first >" << endl;
		}
		char section[1024];
		strcpy(section,"");
		strncpy(section,movedVarName,length-1);
		section[length-1]='\0';
		if (yyVerbose){
		cout << "assembling string: |" << correctedName << "| + |" <<  section << "|" << endl;
		}
		correctedName = correctedName + section + "To";
		movedVarName = firstPos+1;
	      }
	    }
	    correctedName = correctedName + (firstPos+1);
	    if (yyVerbose){
	    cout << "first part corrected string: " << correctedName << endl;
	    }
	    string saveCorrectedName = correctedName;
	    strcpy(varName,"");
	    movedVarName = varName;
	    strcpy(varName,correctedName.c_str());
	    correctedName = "";
	    while (strchr(movedVarName,' ')) {
	      firstPos = strchr(movedVarName,' ');
	      if (firstPos) {
		int length = strlen(movedVarName)-strlen(firstPos);
		if (yyVerbose){
		cout << "found initial string of length " << length << " before the first >" << endl;
		}
		char section[1024];
		strcpy(section,"");
		strncpy(section,movedVarName,length);
		section[length]='\0';
		if (yyVerbose){
		cout << "assembling string: |" << correctedName << "| + |" <<  section << "|" << endl;
		}
		correctedName = correctedName + section + "_";
		movedVarName = firstPos+1;
	      }
	    }	    
	    correctedName = correctedName + (firstPos+1);
	    obsName = "O_"+correctedName;
	    if (yyVerbose){
	    cout << "fully corrected string: " << obsName << endl;
	    }
	    //delete varName;

	  } else {
	    if (yyVerbose){
	    cout << "found useable string: " <<  yyMeasuredVec[k].name << endl;
	    }
	    obsName = "O_"+yyMeasuredVec[k].name;
	  }
	  sprintf ( ntuplevars, "%s:%s", ntuplevars, obsName.c_str() );
	} else {
	  string obsName = "";
	  if (strchr(yyMeasuredVec[k].name.c_str(),'>') || strchr(yyMeasuredVec[k].name.c_str(),' ') ) {
	    if (yyVerbose){
	    cout << "found unlucky string: " <<  yyMeasuredVec[k].name << endl;
	    }
	    string correctedName = "";
	    char varName[1024];
	    strcpy(varName,"");
	    char* movedVarName = varName;
	    strcpy(varName,yyMeasuredVec[k].name.c_str());
	    char* firstPos;
	    while (strchr(movedVarName,'>')) {
	      firstPos = strchr(movedVarName,'>');
	      if (firstPos) {
		int length = strlen(movedVarName)-strlen(firstPos);
		if (yyVerbose){
		cout << "found initial string of length " << length << " before the first >" << endl;
		}
		char section[1024];
		strcpy(section,"");
		strncpy(section,movedVarName,length-1);
		section[length-1]='\0';
		if (yyVerbose){
		cout << "assembling string: |" << correctedName << "| + |" <<  section << "|" << endl;
		}
		correctedName = correctedName + section + "To";
		movedVarName = firstPos+1;
	      }
	    }
	    correctedName = correctedName + (firstPos+1);
	    if (yyVerbose){
	    cout << "first part corrected string: " << correctedName << endl;
	    }
	    string saveCorrectedName = correctedName;
	    strcpy(varName,"");
	    movedVarName = varName;
	    strcpy(varName,correctedName.c_str());
	    correctedName = "";
	    while (strchr(movedVarName,' ')) {
	      firstPos = strchr(movedVarName,' ');
	      if (firstPos) {
		int length = strlen(movedVarName)-strlen(firstPos);
		if (yyVerbose){
		cout << "found initial string of length " << length << " before the first >" << endl;
		}
		char section[1024];
		strcpy(section,"");
		strncpy(section,movedVarName,length);
		section[length]='\0';
		if (yyVerbose){
		cout << "assembling string: |" << correctedName << "| + |" <<  section << "|" << endl;
		}
		correctedName = correctedName + section + "_";
		movedVarName = firstPos+1;
	      }
	    }	    
	    correctedName = correctedName + (firstPos+1);
	    obsName = "O_"+correctedName+"_nofit";
	    if (yyVerbose){
	    cout << "fully corrected string: " << obsName << endl;
	    }
	    //delete varName;
	  } else {
	    if (yyVerbose){
	    cout << "found useable string: " <<  yyMeasuredVec[k].name << endl;
	    }
	    obsName = "O_"+yyMeasuredVec[k].name+"_nofit";
	  }
	  sprintf ( ntuplevars, "%s:%s", ntuplevars, obsName.c_str() );
	}
      }
      TNtuple *markovTuple = new TNtuple(ntuplename,ntupletext,ntuplevars);

      // fill vector of parameters
      for (unsigned int k = 0; k < yyFittedVec.size(); k++ ) {
	x.push_back(yyFittedVec[k].value);
	xp.push_back(yyFittedVec[k].value);
	vm.push_back(yyFittedVec[k].error);
	lb.push_back(yyFittedVec[k].bound_low);
	ub.push_back(yyFittedVec[k].bound_up);
	xNames.push_back(yyFittedVec[k].name);
	c.push_back(2.0);
	nacp.push_back(0);
	 ntest.push_back(0);
      }

      // check for additional input file
      int searchWidth = 0;
      unsigned int nFilePars = 0; 
      const unsigned int nVars = xp.size();
      double varsFromFile[200];
      double widthsFromFile[200];
      for( int i=0; i<200; i++ ) widthsFromFile[i] = -1;
      string thisString[200];
      bool fileReadError = false;
      string separator;
      if (yyMarkovInterfaceFilePath == "") {
	if (yyVerbose){
	cout << "NOTE: no interface file found" << endl;
	}
      }

      if (yyMarkovInterfaceFilePath != "") {
	if (yyVerbose){
	cout << "read previous ending from file " << yyMarkovInterfaceFilePath << endl;
	}
	string syscall = "cp "+yyMarkovInterfaceFilePath+" ./markovInterfaceFile.txt";
	int rc = system (syscall.c_str());
	if (yyVerbose){
	cout << "NOTE: search for proposal widths in interface file..."<< endl;
	}
	syscall = "grep '+-' " + yyMarkovInterfaceFilePath;
	searchWidth = system ( syscall.c_str() );
	if( searchWidth != 0 ) cout << "NOTE: no proposal width in interface file" << endl;
	if( searchWidth == 0 ) cout << "NOTE: proposal width found in interface file" << endl;

	if (rc!=0){
	  if (yyVerbose){
	  cout << "return value " << rc << " from copy of markovInterfaceFile " << yyMarkovInterfaceFilePath << endl;
	  }
	} else {
	  ifstream markovInterfaceFilePath("./markovInterfaceFile.txt");
	  if (markovInterfaceFilePath.is_open()) {
	    while (!markovInterfaceFilePath.eof()) {
	      markovInterfaceFilePath >> globalIter;
	      break;
	    }
	    while (!markovInterfaceFilePath.eof()) {
	      if ( nFilePars > nVars ) {
		if (yyVerbose){
		cout << "too many parameters" << endl;
		cout << "nFilePars = " << nFilePars << ", nVars = " << nVars << endl;
		}
		fileReadError = true;
		break;
	      }
	      if( searchWidth != 0 ) markovInterfaceFilePath >> thisString[nFilePars] >> varsFromFile[nFilePars];
	      if( searchWidth == 0 ) markovInterfaceFilePath >> thisString[nFilePars] >> varsFromFile[nFilePars] >> separator >> widthsFromFile[nFilePars];
	      nFilePars++;
	    }

	    if (!(nFilePars==xp.size()+1)) {
	      cout << "wrong number of parameters" << endl;
	      globalIter = 0;
	    } else if (!fileReadError) {
	      if (yyVerbose){
	      cout << "correct number of parameters" << endl;
	      }
	      for (unsigned int i = 0; i < nVars; i++) {
		for (unsigned int j = 0; j < nVars; j++) {
		  if ( xNames[i] == thisString[j] ) {
		    if (yyVerbose){
		    cout << "setting variable " << xNames[i] << " = " << varsFromFile[j];
		    }
		    x[i]  = varsFromFile[j];
		    xp[i] = varsFromFile[j];
		    if( searchWidth != 0 )  cout << endl;
		    if( searchWidth == 0 ){
		      vm[i] = widthsFromFile[j];
		      if (yyVerbose){
		      cout << " +- " << widthsFromFile[j] << endl;
		      }
		    }
		  }
		}
	      }

	      
	    } else {
	      cout << "unspecified syntax error for yyMarkovInterfaceFilePath, reverting to standard start values" << endl;
	    }
	  } else {
	    cout << "file " << yyMarkovInterfaceFilePath << "could not be opened, reverting to standard start values" << endl;
	  }
	  if (yyVerbose){
	  cout << yyDashedLine << endl;
	  cout << "using the following start settings" << endl;
	  cout << "globalIter = " << globalIter << endl;
	  }
	  for (unsigned int i = 0; i < xNames.size(); i++) {
	    if (yyVerbose){
	    cout << xNames[i] << " = " << xp[i] << " +- " << vm[i] << endl;
	    }
	  }	  cout << yyDashedLine << endl;
	  markovInterfaceFilePath.close();
	}
	system ("rm ./markovInterfaceFile.txt");
      }

      TRandom3* random = new TRandom3();
      time_t systime;
      int seed;
      struct sysinfo sinfo; 
      // set the random number generator
      time (&systime);
      sysinfo(&sinfo);
      if (yyRandomGeneratorSeed < 0) {
	 seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
	 if (yyVerbose){
	 cout<<"uptime = "<<sinfo.uptime<<endl;
	 cout<<"freeswap = "<<sinfo.freeswap<<endl;
	 cout<<"pid = "<<getpid()<<endl;
	 cout << "systime " << systime << endl;
	 }
      }
      else {
	if (yyVerbose){
	 cout<<"using seed from input file"<<endl;
	}
	 seed = yyRandomGeneratorSeed;
      }
      if (yyVerbose){
      cout << "seed = " << seed << endl;
      }
      random->SetSeed(seed);

      // ====================================================================
      // ====================================================================
      double previousChi2 = 1.E10;

      double previous_LHC_CLb  = -1;
      double previous_LHC_CLsb = -1;
      double previous_LHC_chi2 = -1;
      double previous_LHC_Exp_CLb  = -1;
      double previous_LHC_Exp_CLsb = -1;
      double previous_LHC_Exp_chi2 = -1;

      double previous_af_photon=-1;
      double previous_af_relic=-1;
      double previous_af_svind=-1;
      double previous_af_direct=-1;
      double previous_af_chi2_total=-1;
      double previous_af_chi2_photon=-1;
      double previous_af_chi2_relic=-1;
      double previous_af_chi2_svind=-1;
      double previous_af_chi2_direct=-1;

      double previous_globalHiggsChi2=-1;


 
      //-------------------------------------------
      // perform the optimization
      int niter = 0;
      int chainCount = 0;
      double previousLikelihood = 1.E-99;
      double previousRho = 1.;
      previousChi2 = 1.E10;
      bool firstChi2 = true;
      bool haveAcceptedAtLeastOne = false;
      successes = 0;

     //-------------------------------------------
      // Adapt the variance
      vector < float > sum;
      vector < float > sum2;
      vector < float > variance;
      vector < vector < float > > data; 
      vector < float > point;      
      int nVar  = x.size();
      int nData = 0;
      bool firstData = 1;

      // Adapt the correlation
      string parName = "globalIter";
      string parName2 = "globalIter";
      for (unsigned int i = 0; i < yyFittedVec.size(); i++ ){
	parName2 += ":" + yyFittedVec[i].name;
	for (unsigned int j = i; j < yyFittedVec.size(); j++ ) parName += ":" + yyFittedVec[i].name + "_" + yyFittedVec[j].name;
      }
      //      TNtuple *correlationNtuple = new TNtuple( "correlationNtuple", "Correlations", parName.c_str() );
      //      TNtuple *widthNtuple = new TNtuple( "widthNtuple", "Proposal_widths", parName2.c_str() );
      //      float _correlationNtuple[17] = {0.};
      //      float _widthNtuple[6] = {0.};

     //-------------------------------------------
 
    if (yyVerbose){
      std::cout << "Starting Markov Chain algorithm" << std::endl;
      std::cout << "Starting with the following variables and bounds" << std::endl;
      }
      for (unsigned int iVariable = 0; iVariable < x.size(); iVariable++) 
      {
	if (yyVerbose){
	 std::cout << iVariable << " " << x[iVariable] << " [" << lb[iVariable] << "," << ub[iVariable] << "]" << std::endl;
	}
      }

      // Fill the width ntuples with the starting values
      //      _widthNtuple[0] = globalIter;
      //      for( int iVar = 0; iVar < nVar; iVar++ ) _widthNtuple[iVar+1] = vm[iVar];
      //      widthNtuple->Fill( _widthNtuple );




      while (1)
      {
	cout << " >>>> Starting point #" << globalIter << " <<<< " << endl;
	cout << " >>>> Nb. points for widths and correlations = " << nData << endl;

	 //-------------------------------------------

	 if( nData == 1000 )
	   {

	     // Adapt the variance
	     if( yyUpdateWidths )
	       {
		 cout << " >>>> Updating the widths" << endl;
		 sum.resize( nVar, 0 );
		 sum2.resize( nVar, 0 );
		 variance.resize( nVar, 0 );

		 for( int ipt = 0; ipt < nData; ipt++ ){
		   for( int iVar = 0; iVar < nVar; iVar++ ){
		     float val = data[ipt][iVar];
		     sum[iVar]  += val / nData;
		     sum2[iVar] += val * val / nData;
		   }
		 }

		 //		 _widthNtuple[0] = globalIter;
		 for( int iVar = 0; iVar < nVar; iVar++ )
		   {
		     variance[iVar] = fabs( sum2[iVar] - sum[iVar]*sum[iVar] );
		     
		     // Adapt the width to the variance, rescaled by an arbitrary factor
		     vm[iVar] = sqrt( variance[iVar] ) / yyUpdateWidthsScale;
//		     if( !firstData  ) vm[iVar] = sqrt( variance[iVar] ) / yyUpdateWidthsScale;
//		     
//		     // For the first chain, as the widths are small, don't reduce the variance
//		     if( firstData )  vm[iVar] = sqrt( variance[iVar] );
//		     _widthNtuple[iVar+1] = vm[iVar];
		   }
		 //		 widthNtuple->Fill( _widthNtuple );
	       }
	     
	     // Adapt the correlation
	     if( yyCorrelationInMarkovChain )
	       {
		 // Calculate the correlation
		 computeCovMatrix( vm, data );
		 // Fill the ntuple with info on correlation
		 int index = 1;
		 //		 _correlationNtuple[0] = globalIter;
		 for ( unsigned int iVarx = 0; iVarx < x.size(); iVarx++){
		   for ( unsigned int iVary = iVarx; iVary < x.size(); iVary++){
		     //		     _correlationNtuple[index] = corM[iVarx][iVary];
		     index++;
		   }
		 }
		 //		 correlationNtuple->Fill( _correlationNtuple );
	       }
	     firstData = 0;
	     nData = 0;
	     sum.clear();
	     sum2.clear();
	     variance.clear();
	     data.clear();
	 }
	 //-------------------------------------------


	niter++;
	globalIter++;

	// Choice of correlated new point
	if( yyCorrelationInMarkovChain && !firstData ){
	  bool outOfBounds = false;
	  bool first = true;
	  while ( outOfBounds == true || first == true ){
	    first = false;
	    outOfBounds = false;
	    xp = correlatedRandomNumbers( x );
	    for (unsigned int iVar = 0; iVar < x.size(); iVar++)
	      if ( ( xp[iVar] < lb[iVar] ) || ( xp[iVar] > ub[iVar] ) ) outOfBounds = true;
	  }
	}
	// Choice of new point uncorrelated
	if( !yyCorrelationInMarkovChain || firstData ){
	 for (unsigned int iiVariable = 0; iiVariable < x.size(); iiVariable++) 
	 {
	    bool outOfBounds = false;
	    bool first = true;
	    while (outOfBounds==true || first==true)
	    {
	       first = false; 
	       outOfBounds = false;
	       xp[iiVariable] = x[iiVariable] + random->Gaus(0.,vm[iiVariable]);
	       if ( ( xp[iiVariable] < lb[iiVariable] ) || ( xp[iiVariable] > ub[iiVariable] ) ) outOfBounds = true;
	    }
	 }
	}

	 if (yyVerbose){
	   std::cout << "looking at Markov Chain in step " << niter << " success/fail = " << (double)successes/(double)(niter-successes) << std::endl;
	 }
	 for (unsigned int iiiVariable = 0; iiiVariable < x.size(); iiiVariable++) 
	   {
	     if (yyVerbose){
	       std::cout 
		 << iiiVariable << " " 
		 << xp[iiiVariable] << " +- " 
		 << vm[iiiVariable] << " [" 
		 << lb[iiiVariable] << "," 
		 << ub[iiiVariable] << "]" 
		 << std::endl;
	   }
	 }

	 // calclate chi^2
	 double chi2 = 1.E10;
	 for (unsigned int i = 0; i < xp.size(); i++) {
	    xdummy[i] = xp[i];
	 }
	 fitterFCN(dummyint, &dummyfloat, chi2, xdummy, 0);
	 // chi2 = -chi2;
	 std::cout << "chi^2 = " << chi2 << std::endl;

	 yyMarkovChainChi2Scale = 1.;
	 if (yyVerbose){
	 std::cout << "Using yyMarkovChainChi2Scale = " << yyMarkovChainChi2Scale << std::endl;
	 }

	 // calculate likelihood
	 double likelihood = TMath::Exp(-chi2/(2.*yyMarkovChainChi2Scale));
	 if (yyVerbose){
	 std::cout << "L = " << likelihood << std::endl;
	 }


	 if (firstChi2) {
	   firstChi2 = false;
	   if (likelihood>0.) {
	     previousLikelihood = likelihood*2;
	   }
	   previousChi2 = chi2+1.;
	   for (unsigned int i = 0; i < previousObsTheoValue.size(); ++i) {
	     previousObsTheoValue[i] = yyMeasuredVec[i].theovalue;
	   }
	   previous_LHC_CLb = global_LHC_CLb;
	   previous_LHC_CLsb = global_LHC_CLsb;
	   previous_LHC_chi2 = global_LHC_chi2;
	   previous_LHC_Exp_CLb = global_LHC_Exp_CLb;
	   previous_LHC_Exp_CLsb = global_LHC_Exp_CLsb;
	   previous_LHC_Exp_chi2 = global_LHC_Exp_chi2;

	   previous_af_photon=af_photon;
	   previous_af_relic=af_relic;
	   previous_af_svind=af_svind;
	   previous_af_direct=af_direct;
	   previous_af_chi2_total=af_chi2_total;
	   previous_af_chi2_photon=af_chi2_photon;
	   previous_af_chi2_relic=af_chi2_relic;
	   previous_af_chi2_svind=af_chi2_svind;
	   previous_af_chi2_direct=af_chi2_direct;

	   previous_globalHiggsChi2=globalHiggsChi2;


	 }

	 // calculate Q
	 double Qupper = calculateQ(x,xp,vm);
	 double Qlower = calculateQ(xp,x,vm);
	 if (yyVerbose){
	   std::cout << "Qlower = " << Qlower << std::endl;
	   std::cout << "Qupper = " << Qupper << std::endl;
	 }

	 //	  if (haveAcceptedAtLeastOne==false) {
	 //	    if (previousLikelihood==0) {
	 //	      previousLikelihood = 1E-10;
	 //	    }
	 //	    if (Qlower==0.) {
	 //	      Qlower = 1E-10;
	 //	      Qupper = 1E-10;
	 //	    }
	 //	  } 

	 if (yyVerbose){
	   std::cout << "calculating rho = " << likelihood << "*" << Qupper << "/" << previousLikelihood << "*" << Qlower<< std::endl;
	 }

	 // calculate rho
	 double rho = 0.;
	 rho =  TMath::Exp( -chi2/2. + previousChi2/2. );
	 if (yyVerbose){
	   cout << "compare " << chi2 << " " << previousChi2 << " " << rho << " " << TMath::Exp( -chi2/2. + previousChi2/2. ) << endl;
	 }
	 if (yyVerbose){
	   std::cout << "rho = " << rho << std::endl;
	 }

	 // decide whether point shall be accepted
	 float accpoint = 0;
	 if (rho > 1.) {
	   accpoint = 1;
	 } else {
	   double p = random->Uniform(0.,1.);
	   if (p < rho) {
	     accpoint = 1;
	   }
	 } 
	 if (yyVerbose){
	   std::cout << "accpoint = " << accpoint << std::endl;
	   cout << "Chi2 = " << chi2 << endl;
	   cout << "Previous chi2 = " << previousChi2 << endl;
	 }

	 if (accpoint == 1) { 
	   haveAcceptedAtLeastOne = true;
	   successes++;
	   point.clear();
	   for (unsigned int iVar = 0; iVar < x.size(); iVar++) point.push_back( xp[iVar] );
	   data.push_back( point );
	   nData++;
	 }

	 // write into ntuple
	 if (accpoint == 1) {
	    // ++nacp[iVariable];
	    ntupvars[0] = (Float_t)likelihood;
	    ntupvars[1] = (Float_t)rho;
	    ntupvars[2] = (Float_t)chi2;
	    ntupvars[3] = (Float_t)accpoint;
	    ntupvars[4] = (Float_t)niter;
	    ntupvars[5] = (Float_t)globalIter;
	    ntupvars[6] = (haveAcceptedAtLeastOne) ? 1 : 0;
	    ntupvars[7] = (Float_t)global_LHC_CLb;
	    ntupvars[8] = (Float_t)global_LHC_CLsb;
	    ntupvars[9] = (Float_t)global_LHC_chi2;
	    ntupvars[10] = (Float_t)global_LHC_Exp_CLb;
	    ntupvars[11] = (Float_t)global_LHC_Exp_CLsb;
	    ntupvars[12] = (Float_t)global_LHC_Exp_chi2;
	    ntupvars[13] = (Float_t) af_photon;
	    ntupvars[14] = (Float_t) af_relic;
	    ntupvars[15] = (Float_t) af_svind;
	    ntupvars[16] = (Float_t) af_direct;
	    ntupvars[17] = (Float_t) af_chi2_total;
	    ntupvars[18] = (Float_t) af_chi2_photon;
	    ntupvars[19] = (Float_t) af_chi2_relic;
	    ntupvars[20] = (Float_t) af_chi2_svind;
	    ntupvars[21] = (Float_t) af_chi2_direct;
	    ntupvars[22] = (Float_t) globalHiggsChi2;
	    int counter = 0;
	    //	    for (unsigned int ii = 7; ii < 7+yyFittedVec.size(); ii++) {
	    //	       ntupvars[ii] = xp[ii-7];
	    for (unsigned int ii = 23; ii < 23+yyFittedVec.size(); ii++) {
	       ntupvars[ii] = xp[ii-23];
	       counter = ii;
	    }
	    for (unsigned int iii = counter+1; iii < counter+1+yyMeasuredVec.size(); iii++) {
	      ntupvars[iii] = yyMeasuredVec[iii-(counter+1)].theovalue;
	    }
	    markovTuple->Fill(ntupvars);
	 } else {
	    ntupvars[0] = (Float_t)likelihood;
	    ntupvars[1] = (Float_t)rho;
	    ntupvars[2] = (Float_t)chi2;
	    ntupvars[3] = 0.;
	    ntupvars[4] = (Float_t)niter;
	    ntupvars[5] = (Float_t)globalIter;
	    ntupvars[6] = (haveAcceptedAtLeastOne) ? 1 : 0;
	    ntupvars[7] = (Float_t)global_LHC_CLb;
	    ntupvars[8] = (Float_t)global_LHC_CLsb;
	    ntupvars[9] = (Float_t)global_LHC_chi2;
	    ntupvars[10] = (Float_t)global_LHC_Exp_CLb;
	    ntupvars[11] = (Float_t)global_LHC_Exp_CLsb;
	    ntupvars[12] = (Float_t)global_LHC_Exp_chi2;
	    ntupvars[13] = (Float_t) af_photon;
	    ntupvars[14] = (Float_t) af_relic;
	    ntupvars[15] = (Float_t) af_svind;
	    ntupvars[16] = (Float_t) af_direct;
	    ntupvars[17] = (Float_t) af_chi2_total;
	    ntupvars[18] = (Float_t) af_chi2_photon;
	    ntupvars[19] = (Float_t) af_chi2_relic;
	    ntupvars[20] = (Float_t) af_chi2_svind;
	    ntupvars[21] = (Float_t) af_chi2_direct;
	    ntupvars[22] = (Float_t) globalHiggsChi2;

	    int counter = 0;
	    //	    for (unsigned int ii = 7; ii < 7+yyFittedVec.size(); ii++) {
	    //	       ntupvars[ii] = xp[ii-7];
	    for (unsigned int ii = 23; ii < 23+yyFittedVec.size(); ii++) {
	       ntupvars[ii] = xp[ii-23];
	       counter = ii;
	    }
	    for (unsigned int iii = counter+1; iii < counter+1+yyMeasuredVec.size(); iii++) {
	      ntupvars[iii] = yyMeasuredVec[iii-(counter+1)].theovalue;
	    }
	    markovTuple->Fill(ntupvars);
	    ntupvars[0] = (Float_t)previousLikelihood;
	    ntupvars[1] = (Float_t)previousRho;
	    ntupvars[2] = (Float_t)previousChi2;
	    ntupvars[3] = 1.;
	    ntupvars[4] = (Float_t)niter;
	    ntupvars[5] = (Float_t)globalIter;
	    ntupvars[6] = (haveAcceptedAtLeastOne) ? 1 : 0;
	    ntupvars[7] = (Float_t)previous_LHC_CLb;
	    ntupvars[8] = (Float_t)previous_LHC_CLsb;
	    ntupvars[9] = (Float_t)previous_LHC_chi2;
	    ntupvars[10] = (Float_t)previous_LHC_Exp_CLb;
	    ntupvars[11] = (Float_t)previous_LHC_Exp_CLsb;
	    ntupvars[12] = (Float_t)previous_LHC_Exp_chi2;
	    ntupvars[13] = (Float_t)previous_af_photon;
	    ntupvars[14] = (Float_t) previous_af_relic;
	    ntupvars[15] = (Float_t) previous_af_svind;
	    ntupvars[16] = (Float_t) previous_af_direct;
	    ntupvars[17] = (Float_t) previous_af_chi2_total;
	    ntupvars[18] = (Float_t) previous_af_chi2_photon;
	    ntupvars[19] = (Float_t) previous_af_chi2_relic;
	    ntupvars[20] = (Float_t) previous_af_chi2_svind;
	    ntupvars[21] = (Float_t) previous_af_chi2_direct;
	    ntupvars[22] = (Float_t) previous_globalHiggsChi2;

	    counter = 0;
	    //	    for (unsigned int ii = 7; ii < 7+yyFittedVec.size(); ii++) {
	    //	       ntupvars[ii] = x[ii-7];
	    for (unsigned int ii = 23; ii < 23+yyFittedVec.size(); ii++) {
	       ntupvars[ii] = x[ii-23];
	       counter = ii;
	    }
	    for (unsigned int iii = counter+1; iii < counter+1+yyMeasuredVec.size(); iii++) {
	      ntupvars[iii] = previousObsTheoValue[iii-(counter+1)];
	    }
	    markovTuple->Fill(ntupvars);

	 }

	 // save variables 
	 if (accpoint == 1)
	 {
	    for (unsigned int i = 0; i < x.size(); ++i) {
	       x[i] = xp[i];
	    }
	    for (unsigned int i = 0; i < previousObsTheoValue.size(); ++i) {
	       previousObsTheoValue[i] = yyMeasuredVec[i].theovalue;
	    }
	    previousRho        = rho;
	    previousChi2       = chi2;
	    previousLikelihood = likelihood;
	    previous_LHC_CLb   = global_LHC_CLb;
	    previous_LHC_CLsb  = global_LHC_CLsb;
	    previous_LHC_chi2  = global_LHC_chi2;
	    previous_LHC_Exp_CLb   = global_LHC_Exp_CLb;
	    previous_LHC_Exp_CLsb  = global_LHC_Exp_CLsb;
	    previous_LHC_Exp_chi2  = global_LHC_Exp_chi2;

	    previous_af_photon=af_photon;
	    previous_af_relic=af_relic;
	    previous_af_svind=af_svind;
	    previous_af_direct=af_direct;
	    previous_af_chi2_total=af_chi2_total;
	    previous_af_chi2_photon=af_chi2_photon;
	    previous_af_chi2_relic=af_chi2_relic;
	    previous_af_chi2_svind=af_chi2_svind;
	    previous_af_chi2_direct=af_chi2_direct;

	    previous_globalHiggsChi2=globalHiggsChi2;

	 }


	 chainCount++;
	 if (chainCount > yyMaxMarkovChain) break;
      }

      MarkovNtupFile->Write();
      MarkovNtupFile->Close();

      // eventually write final point to output text file
      if (yyMarkovInterfaceFilePath != "") {
	bool allOK = true;
	ofstream markovInterfaceFilePath("./markovInterfaceFile.txt");
	if (markovInterfaceFilePath.is_open()) {
	  markovInterfaceFilePath << globalIter << endl;
	  for (unsigned int i = 0; i < xp.size(); i++) {
	      markovInterfaceFilePath << xNames[i] << " " << xp[i] << " +- " << vm[i] << endl;
	  }
	} else {
	  allOK = false;
	}
	markovInterfaceFilePath.close();
	if (allOK) {
	  cout << yyDashedLine << endl;
	  system("cat ./markovInterfaceFile.txt");
	  cout << yyDashedLine << endl;
	  cout << "write ending to file " << yyMarkovInterfaceFilePath << endl;
	  string syscall = "cp ./markovInterfaceFile.txt "+yyMarkovInterfaceFilePath;
	  int rc = system (syscall.c_str());
	  if (rc!=0) {
	    cout << "return value " << rc << " from copy to markovInterfaceFile " << yyMarkovInterfaceFilePath << endl; 
	  } else {
	    cout << "successfully copied interface file to " << yyMarkovInterfaceFilePath << endl;
	  }
	}
	system("rm ./markovInterfaceFile.txt");
      }     
      
      return;
      
   }

double Fittino::calculateQ(vector<double> x, vector<double> xk, vector<double> vm)
{
  double Q = 1.;
  for (unsigned int iVariable = 0; iVariable < x.size(); iVariable++) 
    {
      Q = Q * 1/(TMath::Sqrt(2.*TMath::Pi())*vm[iVariable])*
	TMath::Exp(-sqr(x[iVariable]-xk[iVariable])/(2.*sqr(vm[iVariable])));
    }
  return Q;
}


// == Compute pseudo-covariance matrix
// This is NOT the real covariance matrix: the considered widths here
// are not the standard deviations "sigma" but the width of the proposal distribution 
//              0   1    2   3
//             M0  M12  A0  TanBeta
// 0 -> M0      1   0    0   0
// 1 -> M12     x   1    0   0
// 2 -> A0      x   x    1   0
// 3 -> Tanbeta x   x    x   1

void Fittino::computeCovMatrix( vector<double> vm, vector< vector <Float_t> > varSampling ){

  if( yyVerbose ) cout << " >>>> Computing the pseudo-covariance matrix... " << endl;

  const int nVar = varSampling[0].size();
  const int totStep = varSampling.size();

  // Build correlation matrix
  
  // Mean
  vector<Float_t> avg(nVar,0);
  vector<Float_t> avg2(nVar,0);
  for ( int iVar = 0; iVar < nVar; ++iVar){
    for( int step = 0; step < totStep; ++step ){
      avg[iVar]  += varSampling[step][iVar]/varSampling.size();
      avg2[iVar] += varSampling[step][iVar]*varSampling[step][iVar]/varSampling.size();
    }
  }

  // Variance
  vector<Float_t> sig(nVar,0);
  for ( int iVar = 0; iVar < nVar; ++iVar){
    sig[iVar] = sqrt( fabs( avg2[iVar] - avg[iVar]*avg[iVar] ) );
  }
  

  // Correlation
  corM.ResizeTo( nVar, nVar );
  for( int iVarx = 0; iVarx < nVar; ++iVarx ){
    for( int iVary = iVarx+1; iVary < nVar; ++iVary ){
      float sigxy = 0;
      for( int step = 0; step < totStep; ++step ) sigxy += ( varSampling[step][iVarx] - avg[iVarx] )*( varSampling[step][iVary] - avg[iVary] )/varSampling.size();
      if( sig[iVarx] * sig[iVary] != 0 )
	corM[iVarx][iVary] = sigxy / ( sig[iVarx] * sig[iVary] );
      else corM[iVarx][iVary] = 0.1;
    }
  }
  for( int iVarx = 0; iVarx < nVar; ++iVarx ){
    for( int iVary = 0; iVary < nVar; ++iVary ){
      if( iVarx == iVary ) corM[iVarx][iVary] = 1;
      else if( iVary < iVarx ) corM[iVarx][iVary] = corM[iVary][iVarx];
    }
  }

  if( yyVerbose ){
    cout <<" >>>> Variables properties..." << endl;
    for( int iVarx = 0; iVarx < nVar; ++iVarx ) cout << "#" << iVarx << " mean = " << avg[iVarx] << " width = " << sig[iVarx] << endl; 

    cout <<" >>>> Estimated correlation matrix..."<< endl;
    corM.Print();
    float determinant = corM.Determinant();
    cout <<"Determinant = " << determinant << endl;
    if( determinant < 0 ){
      cout <<" >>>> WARNING, correlation matrix non positive-definite, use unit matrix instead.." << endl;
      corM.UnitMatrix();
      corM.Print();
    }
  }
  
  // Build pseudo-covariance matrix
  TMatrixD covM( nVar, nVar );
  for( int iVarx = 0; iVarx < nVar; ++iVarx ){
    for( int iVary = 0; iVary < nVar; ++iVary ){
      covM( iVarx, iVary ) = corM[iVarx][iVary] * vm[iVarx] * vm[iVary];
    }
  }
  // Check that is positive definite
  if( covM.Determinant() < 0 ){
    cout << " >>>> WARNING, pseudo-covariance matrix non positive-definite, use unit matrix for correlation matrix instead.." << endl;
    corM.UnitMatrix();
    for( int iVarx = 0; iVarx < nVar; ++iVarx ){
      for( int iVary = 0; iVary < nVar; ++iVary ){
	covM( iVarx, iVary ) = corM[iVarx][iVary] * vm[iVarx] * vm[iVary];
      }
    }
  }
  

  // Symmetrize the matrix
  covMsym.Use( covM.GetNrows(), covM.GetMatrixArray() );
  if( yyVerbose ){
    cout <<" >>>> Estimated pseudo-covariance matrix..."<< endl;
    covMsym.Print();
  }

  // Compute eigenvalues/vectors
  TMatrixDSymEigen covMsymEig ( covMsym );
  eigenVectors.ResizeTo(nVar,nVar);
  eigenValues.ResizeTo(nVar);
  eigenVectors = covMsymEig.GetEigenVectors();
  eigenValues = covMsymEig.GetEigenValues();

  if( yyVerbose ){
    cout <<" >>>> Estimated eigenvalues and eigenvectors..."<< endl;
    eigenValues.Print();
    eigenVectors.Print();
  }

  for( int iVarx = 0; iVarx < nVar; ++iVarx ){
    if( eigenValues[iVarx] < 0 ){
      cerr << "WARNING: negative eigenvalues for pseudo-covariance matrix, forced to be null" << endl;
      eigenValues[iVarx] = 0;
    }
  }



  return;
}

// == This function is a copy of misc.cpp::getCorrelatedRandomNumbers
// where the calcul of eigenvalues/vectors is placed outside the loop to speed up the chain

vector<double> Fittino::correlatedRandomNumbers( vector<double> mean ){
  cout << " >>> Genenerating correlated numbers..." << endl;
  unsigned int n = mean.size();
  TVectorD Vmean( n );
  for( unsigned int i=0; i<n; i++ ) Vmean(i) = mean[i];
  TVectorD y(n);
  for ( unsigned int i=0; i<n; i++) {
    y(i) = gRandom->Gaus( 0, TMath::Sqrt( eigenValues[i] ) );
  }
   TVectorD x(y);
   x *= eigenVectors;
   x += Vmean;
   for( unsigned int i=0; i<n; i++) mean[i] = x[i];
   return mean;
}
