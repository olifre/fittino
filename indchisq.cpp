/***************************************************************************
                                  indchisq.cpp
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
#include <stdlib.h>
#include <algorithm>
#include <stdio.h>
#include <leshouches.h>

#include <TRandom.h>
#include <TMath.h>
#include <TFitter.h>
#include <TMinuit.h>
#include <TGraph.h>

#include <TFile.h>
#include <TH1.h>

typedef struct {string name; double chisq; int alias; } ind_chisq_T;
void pairsort (ind_chisq_T* array, int length);


IndChisq::IndChisq(const Input* input)
{
    fInput = input;
}




IndChisq::~IndChisq()
{

}



void IndChisq::CalcIndChisq()
{
  Double_t x[100];
  Double_t chisquare;
  Double_t dummyfloat = 5.;
  Int_t dummyint = 1;
  double chisq0;
  double store_chisq[2];
  double ind_delta_chisq;
  double delta_chisq;
  double ind_delta_chisq_array[1024]; 
  int ind_delta_chisq_array_size;
  ind_chisq_T ind_chisq_array[1024];
  vector<parameter_t> individ_delta_chisq_plus;
  vector<parameter_t> individ_delta_chisq_minus;
  vector<parameter_t> individ_delta_chisq_start;

  // open output file
  FILE* file = fopen("fittino_individual_chisq_contr.out","w");

  // switch all temp_nofits on
  for (unsigned int i = 0; i < yyMeasuredVec.size(); i++ ) {
    yyMeasuredVec[i].temp_nofit = false;
  }  
  // make settings
  yyUseGivenStartValues = true;
  yyFitAllDirectly = true;
  yyUseOneLoopCorrections = true;
  yyUseSimAnnWhile        = false;
  yyUseSimAnnBefore       = false;

  //construct fittino
  Fittino* fittino = new Fittino(fInput);
  fittino->calculateTreeLevelValues(10000);
  //fill x
  for (unsigned int i = 0; i < yyFittedVec.size(); i++ ) {
    x[i] = yyFittedVec[i].value;
  }  
  //get chisq0
  fitterFCN(dummyint, &dummyfloat, chisq0, x, 10);
  individ_delta_chisq_start.clear();
  individ_delta_chisq_start = indchisq_vec;
  //  for (unsigned int i = 0; i < individ_delta_chisq_start.size(); i++) {
  //    cout << "2 Ind Delta Chisq = " << individ_delta_chisq_start[i].value << endl;
  //  }
  cout << "chisq0 = " << chisq0 << endl;
  indchisq_vec.clear();

  //loop over parameters
  for (unsigned int i = 0; i < yyFittedPar.size(); i++ ) {
    if (yyFittedPar[i].error > 0.) {
      // find corresponding entry in yyFittedVec
      for (unsigned int j = 0; j < yyFittedVec.size(); j++ ) {
	if (yyFittedPar[i].name == yyFittedVec[j].name) {

	  x[j] = yyFittedVec[j].value - yyFittedPar[i].error;
	  fitterFCN(dummyint, &dummyfloat, store_chisq[0], x, 10);
	  individ_delta_chisq_minus.clear();
	  individ_delta_chisq_minus = indchisq_vec;
//	  for (unsigned int l = 0; l < individ_delta_chisq_start.size(); l++) {
//	    cout << "3 Ind Delta Chisq = " << individ_delta_chisq_minus[l].value << endl;
//	  }
	  indchisq_vec.clear();

	  x[j] = yyFittedVec[j].value + yyFittedPar[i].error;
	  fitterFCN(dummyint, &dummyfloat, store_chisq[1], x, 10);
	  individ_delta_chisq_plus.clear();
	  individ_delta_chisq_plus = indchisq_vec;
//	  for (unsigned int l = 0; l < individ_delta_chisq_start.size(); l++) {
//	    cout << "4 Ind Delta Chisq = " << individ_delta_chisq_plus[l].value << endl;
//	  }

	  x[j] = yyFittedVec[j].value;

	  delta_chisq = 0.5*(store_chisq[0]+store_chisq[1])-chisq0;
	  fprintf (file, "\n\n\n\n");
	  fprintf (file, "Individual Delta Chisq contributions to Parameter %s (%12g +- %12g)\n",
		   yyFittedVec[j].name.c_str(), yyFittedVec[j].value, yyFittedPar[i].error);
	  fprintf (file, "================================================================\n\n");
	  for (unsigned int k = 0; k < individ_delta_chisq_start.size(); k++) {
	    ind_delta_chisq = 0.5*(individ_delta_chisq_minus[k].value+individ_delta_chisq_plus[k].value)
	      -individ_delta_chisq_start[k].value;
	    if (ind_delta_chisq < 0.) {
	      ind_delta_chisq = 0.;
	    }
	    ind_delta_chisq_array[k] = ind_delta_chisq;
	    ind_delta_chisq_array_size = k+1;
	    ind_chisq_array[k].chisq = ind_delta_chisq;
	    ind_chisq_array[k].name = individ_delta_chisq_start[k].name;
	    ind_chisq_array[k].alias = individ_delta_chisq_start[k].error;
	    fprintf (file, "%31s : %20g\n",individ_delta_chisq_start[k].name.c_str(),ind_delta_chisq);
	  }
	  pairsort(ind_chisq_array, ind_delta_chisq_array_size);
	  fprintf (file, "=========== percentage of strongest contributions: =============\n");
	  { 
	    unsigned int k = 0;
	    while ( ( ( k < individ_delta_chisq_start.size() ) && ( ind_chisq_array[k].chisq/delta_chisq > 0.01 ) ) || ( k < 5 ) ) {
	      //	  for (unsigned int k = 0; k < 5; k++ ) {
	      fprintf (file, "%31s (%i): %20g\n",ind_chisq_array[k].name.c_str(),ind_chisq_array[k].alias,ind_chisq_array[k].chisq/delta_chisq);
	      k++;
	    }
	  }
	  fprintf (file, "              total Delta Chisq :      %f\n",delta_chisq);
	  indchisq_vec.clear();
	  break;
	}
      }
    }
  }  

  //write results


  fclose(file);

}

void pairsort (ind_chisq_T* array, int length)
{

  ind_chisq_T intermediate_array_element;
  int sorted = 0;

  while (sorted==0) {
    sorted = 1;
    for (unsigned int i = 0; i < (length-1); i++) {
      if (array[i].chisq<array[i+1].chisq) {
	sorted = 0;
	intermediate_array_element.name = array[i].name;
	intermediate_array_element.chisq = array[i].chisq;
	intermediate_array_element.alias = array[i].alias;
	array[i].name = array[i+1].name;
	array[i].chisq = array[i+1].chisq;
	array[i].alias = array[i+1].alias;
	array[i+1].name = intermediate_array_element.name;
	array[i+1].chisq = intermediate_array_element.chisq;
	array[i+1].alias = intermediate_array_element.alias;
      }
    }
  }

}
