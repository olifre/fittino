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
#include <yy.h>
#include <fstream>
#include <stdio.h>
#include <leshouches.h>

#include <TRandom.h>
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
  double correction;
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
  yyUseOneLoopCorrections = true;
  yyUseMinos              = false;
  yyUseHesse              = false;

  // set the random number generator
  time (&systime);
  seed = systime;
  cout << "time " << seed << endl; 
  gRandom->SetSeed(seed);


  // get local copy of measured values
  savedMeasuredValues.clear();
  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++) {  
    savedMeasuredValues.push_back(yyMeasuredVec[i]);
  }

  // open output files
  TFile* hfile1 = 0;
  hfile1 = new TFile("PullDistributions.root","RECREATE","PullDistributions of the Fitted Parameters with respect to their true values");
  for (unsigned int i = 0; i < yyFittedPar.size(); i++) {
    sprintf(histogram_name,"%s Pull Distribution",yyFittedPar[i].name.c_str());
    TH1F* newhist = new TH1F(yyFittedPar[i].name.c_str(),histogram_name,40,-8.,8.);
    histomap.push_back(newhist);
  }
  ndof = yyMeasuredVec.size() - yyFittedPar.size();
  if ( ndof <= 0 ) {
    ndof = 1;
  }
  TH1F* chisq_hist = new TH1F("chisq_hist","chisq distribution",3*ndof,0.,(double)(3*ndof));

  // loop 
  for (unsigned int  i = 0; i < npulls; i++) {
    //   smear the observables
//    for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {  
//      yyMeasuredVec[j].value = gRandom->Gaus(savedMeasuredValues[j].value, 
//					     TMath::Sqrt(fInput->GetMeasuredCorrelationMatrix().GetCovariance(j, j)));
//    }
    for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
      yyMeasuredVec[j].value = savedMeasuredValues[j].value;
    }
    for (unsigned int j = 0; j < yyMeasuredVec.size(); j++) {
      for (unsigned int k = j; k < yyMeasuredVec.size(); k++) {  
	correction = gRandom->Gaus(0., 
				    TMath::Sqrt(TMath::Abs(fInput->GetMeasuredCorrelationMatrix().GetCovariance(j, k))));
	if (fInput->GetMeasuredCorrelationMatrix().GetCovariance(j, k)>0.) {
	  yyMeasuredVec[j].value += 0.5 * correction;
	  yyMeasuredVec[k].value += 0.5 * correction;
	} else {
	  yyMeasuredVec[j].value += 0.5 * correction;
	  yyMeasuredVec[k].value -= 0.5 * correction;	  
	}
      }
    }
    //   calculate new Fit result...
    Fittino* fittino = new Fittino(fInput);
    fittino->calculateTreeLevelValues(10000);
    fittino->calculateLoopLevelValues();
    cout << "returned from CalculateLoopLevelValues" << endl;
    // write results
    for (unsigned int j = 0; j < yyFittedVec.size(); j++) {
      for (unsigned int k = 0; k < yyFittedPar.size(); k++ ) {
	if (yyFittedPar[k].name == yyFittedVec[j].name) {
	  cout << "Parameter " << yyFittedVec[j].name << " is off by " << (yyFittedVec[j].value-yyFittedPar[k].value)/yyFittedPar[k].error << endl;
	  histomap[k]->Fill((yyFittedVec[j].value-yyFittedPar[k].value)/yyFittedPar[k].error);
	  cout << "filled..." << endl;
	  break;
	}
      }
    }
    cout << "filling chisq hist " << endl;
    chisq_hist->Fill(gchisq);
    cout << "deleting fittino" << endl;
    delete fittino;
    cout << "having deleted fittino" << endl;

    // deleting yyFittedVec
    yyFittedVec.clear();

  }

  // write Histos to file
  for (unsigned int i = 0; i < yyFittedPar.size(); i++) {
    histomap[i]->Write();
  }  
  chisq_hist->Write();

  hfile1->Write();
  hfile1->Close();

}
