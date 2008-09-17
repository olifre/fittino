/***************************************************************************
                                  makepulldist.cpp
                             -------------------
    Main program.
                             -------------------
    $Id$
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


#include <makepulldist.h>
#include <indchisq.h>
#include <fittino.h>
#include <input.h>
#include <smearedinput.h>
#include <units.h>
#include <iostream>
#include <fstream>
#include <time.h>
#include <unistd.h>
#include <yy.h>
#include <fstream>
#include <stdio.h>
#include <leshouches.h>
#include <sys/sysinfo.h>

#include <TRandom.h>
#include <TRandom3.h>
#include <TMath.h>
#include <TFitter.h>
#include <TMinuit.h>
#include <TGraph.h>

#include <TFile.h>
#include <TH1.h>
#include <sys/time.h>


MakePullDist::MakePullDist(const Input* input)
{
    fInput = input;
}




MakePullDist::~MakePullDist()
{

}



void MakePullDist::CalcPullDist()
{
  //double correction;
  vector<MeasuredValue>  savedMeasuredValues;
  unsigned int npulls = 100;
  vector<TH1F*> histomap;
  char histogram_name[256];
  time_t systime;
  int ndof;
  int seed;

  // switch all temp_nofits on
  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
    yyMeasuredVec[i].temp_nofit = false;
  }  
  if (yyNumberPulls > 0) {
    npulls = yyNumberPulls;
  }
  // make settings
  yyUseGivenStartValues   = true;
  yyFitAllDirectly        = true;
  yyUseLoopCorrections    = true;
  //  yyUseSimAnnWhile        = false;
  //  yyUseSimAnnBefore       = false;
  yyUseMinos              = false;
  yyUseHesse              = false;

  // set the random number generator
  time (&systime);
  struct sysinfo sinfo; 
  sysinfo(&sinfo);
  if (yyRandomGeneratorSeed < 0) {
    seed = systime + sinfo.uptime + sinfo.freeswap + getpid();
    
    // Test printouts
    //cout<<"uptime = "<<sinfo.uptime<<endl;
    //cout<<"freeswap = "<<sinfo.freeswap<<endl;
    //cout<<"pid = "<<getpid()<<endl;
    //cout << "systime " << systime << endl; 
  }
  else {
    cout<<"Using seed from input file"<<endl;
    seed = yyRandomGeneratorSeed;
  }
  //cout << "Using seed = " << seed << endl;
  gRandom->SetSeed(seed);


  // get local copy of measured values
  savedMeasuredValues.clear();
  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {  
    savedMeasuredValues.push_back(yyMeasuredVec[i]);
  }

  // open output files
  TFile* hfile1 = 0;
  hfile1 = new TFile("PullDistributions.root","RECREATE","PullDistributions of the Fitted Parameters with respect to their true values");
  // creating parameter histograms
  for (unsigned int i = 0; i < yyFittedPar.size(); i++) {
    sprintf(histogram_name,"%s Pull Distribution",yyFittedPar[i].name.c_str());
    TH1F* newhist = new TH1F(yyFittedPar[i].name.c_str(),histogram_name,40,-8.,8.);
    histomap.push_back(newhist);
  }
  // creating observable histograms
  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {
     sprintf(histogram_name,"%s Pull Distribution",yyMeasuredVec[i].name.c_str());
     TH1F* newhist = new TH1F(yyMeasuredVec[i].name.c_str(),histogram_name,40,-8.,8.);
     histomap.push_back(newhist);
  }
  ndof = yyMeasuredVec.size() - yyFittedPar.size();
  if ( ndof <= 0 ) {
     ndof = 1;
  }
  TH1F* chisq_hist = new TH1F("chisq_hist","chisq distribution",3*ndof,0.,(double)(3*ndof));

  // create a vector of trees if MultiplePulls is set

  TTree* tree = new TTree("tree", "Tree containing fitted parameters");
  vector<MeasuredValue> parLeafVec(yyFittedPar.size());

  //cout << "Adding branch for each parameter to tree" << endl;
  for (unsigned int k = 0; k < yyFittedPar.size(); k++ ) {
     parLeafVec[k].name = yyFittedPar[k].name;
     parLeafVec[k].value = -1;
     string str = yyFittedPar[k].name;
     str.append("/D");
     //cout << "Adding branch " << yyFittedPar[k].name.c_str() << " to tree" << endl;
     tree->Branch(yyFittedPar[k].name.c_str(), &(parLeafVec[k].value), str.c_str());
     str.erase();
  }

  //cout << "Adding branch for each observable to tree" << endl;
  vector<MeasuredValue> obsLeafVec(yyMeasuredVec.size());
  for (unsigned int k = 0; k < yyMeasuredVec.size(); k++ ) {
     if (yyMeasuredVec[k].nofit == false) {
	obsLeafVec[k].name = yyMeasuredVec[k].name;
	obsLeafVec[k].value = -1;
	string str = yyMeasuredVec[k].name;
	str.append("/D");
	cout << "Adding branch for fitted observable " << yyMeasuredVec[k].name.c_str() << " to tree" << endl;
	tree->Branch(yyMeasuredVec[k].name.c_str(), &(obsLeafVec[k].value), str.c_str());
	str.erase();
     } else {
	obsLeafVec[k].name = yyMeasuredVec[k].name;
	obsLeafVec[k].value = -1;
	string str = yyMeasuredVec[k].name;
	str.append("_nofit/D");
	cout << "Adding branch for nofit observable " << yyMeasuredVec[k].name.c_str() << " to tree" << endl;
	tree->Branch(yyMeasuredVec[k].name.c_str(), &(obsLeafVec[k].value), str.c_str());
	str.erase();       
     }
  }

  double randSeed = yyRandomGeneratorSeed;
  int nToy = 0;
  //cout << "Adding branch Chi2 to tree" << endl;
  tree->Branch("Chi2", &gchisq, "Chi2/D");
  tree->Branch("randSeed", &randSeed, "randSeed/D");
  tree->Branch("nToy", &nToy, "nToy/I");

  //for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
  //   yyMeasuredVec[j].value = pseudoMeasuredObservableVector(j);
  //}

  // loop 
  for (unsigned int  i = 0; i < npulls; i++) {
     //   smear the observables
     //    for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {  
     //      yyMeasuredVec[j].value = gRandom->Gaus(savedMeasuredValues[j].value, 
     //					     TMath::Sqrt(fInput->GetMeasuredCorrelationMatrix().GetCovariance(j, j)));
     //    }

     TVectorD mean(yyMeasuredVec.size());

     for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
	yyMeasuredVec[j].value = savedMeasuredValues[j].value;
	mean(j) = yyMeasuredVec[j].value;
     }

     TVectorD thrown(yyMeasuredVec.size());

     // TODO Second scattering

     thrown = getCorrelatedRandomNumbers( mean, fInput->GetMeasuredCorrelationMatrix().GetCovarianceMatrix() );

     for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
       if (yyMeasuredVec[j].nofit == false) {
	 yyMeasuredVec[j].value = thrown(j);
       }
     }

     // test printouts for observable value scattering
     cout << yyDashedLine << endl;
     cout<<"Thrown set of observables for pull fit no "<<i<<":"<<endl;
     for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
	if (yyMeasuredVec[j].nofit == false) {
	   cout << yyMeasuredVec[j].name << ": " << yyMeasuredVec[j].value << " (deviation from mean value " << savedMeasuredValues[j].value << " within " << TMath::Ceil((TMath::Abs(yyMeasuredVec[j].value-savedMeasuredValues[j].value)/yyMeasuredVec[j].error)) <<" sigma)" <<endl;
	}
     }


     // loop here over varied 'digital' parameters
     // (eg signmu=+1,-1)

     //   calculate new Fit result...
     Fittino* fittino = new Fittino(fInput);
     if ( yyFitModel == MSSM || yyFitModel == NMSSM ) {
	fittino->calculateTreeLevelValues(10000);
     }
     else {
	fittino->setStartValues();
     }
     fittino->calculateLoopLevelValues();
     cout << "returned from CalculateLoopLevelValues" << endl;
     // write results
     for (unsigned int j = 0; j < yyFittedVec.size(); j++) {
	for (unsigned int k = 0; k < yyFittedPar.size(); k++ ) {
	   if (yyFittedPar[k].name == yyFittedVec[j].name) {
	      cout << "Parameter " << yyFittedVec[j].name << " is off by " << (yyFittedVec[j].value-yyFittedPar[k].value)/yyFittedPar[k].error << endl;
	      histomap[k]->Fill((yyFittedVec[j].value-yyFittedPar[k].value)/yyFittedPar[k].error);
	      cout << "filled..." << endl;
	      cout << "Copying fitted values into parLeafVec..." << endl;
	      if (parLeafVec[k].name == yyFittedVec[j].name) {
		 parLeafVec[k].value = yyFittedVec[j].value;
	      }
	      else {
		 cout<<"Messy parLeafVec"<<endl;
	      }
	      break;
	   }
	}
     }
     cout << "Copying observables into obsLeafVec..." << endl;
     for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
       if (yyMeasuredVec[j].nofit == false) {
	 obsLeafVec[j].value = yyMeasuredVec[j].value;
       } else {
	 cout << "looking for fitted value of the unfitted observable " << yyMeasuredVec[j].name << " = " << yyMeasuredVec[j].theovalue << endl;
	 obsLeafVec[j].value = yyMeasuredVec[j].theovalue;
       }
     }
     cout << "filling chisq hist " << endl;
     chisq_hist->Fill(gchisq);
     cout << "filling tree " << endl;
     // make sure the different model results are saved separately...
     tree->Fill();
     cout << "deleting fittino" << endl;
     delete fittino;
     cout << "having deleted fittino" << endl;

     // stop loop over digital fixed parameters here


    nToy++;


     // deleting yyFittedVec
     yyFittedVec.clear();
     parLeafVec.clear();
     obsLeafVec.clear();
  }

  // write Histos to file
  for (unsigned int i = 0; i < yyFittedPar.size(); i++) {
     histomap[i]->Write();
  }  
  chisq_hist->Write();
  tree->Write();

  hfile1->Write();
  hfile1->Close();

}
