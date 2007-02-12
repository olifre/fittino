/***************************************************************************
                                  main.cpp
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


#include <input.h>
#include <fittino.h>
#include <units.h>
#include <iostream>
#include <yy.h>
#include <indchisq.h>
#include <makepulldist.h>

using namespace std;



int main(int argc, char** argv) 
{
  //===============================================
  n_printouts = 0;

  char* inputfilename = 0;

  if (argc == 1) {
      inputfilename = new char[strlen("fittino.in")+1];
      strcpy(inputfilename, "fittino.in");
  }
  else if (argc == 2) {
      if (!strcmp(argv[1], "--help")) {
   	  cout<<endl;
	  cout<<"Usage: fittino [<parameters>]"<<endl;
	  cout<<endl;
	  cout<<"If Fittino is started without parameters, \"fittino.in\" is "
	        "used as input file name."<<endl;
	  cout<<"Possible optional program parameters are:"<<endl;
	  cout<<endl;
	  cout<<"  --help"<<endl;
	  cout<<"      Fittino prints this message."<<endl;
	  cout<<endl;
	  cout<<"  <inputfile>"<<endl;
	  cout<<"      If only a single parameter is given (different from \"--help\"), Fittino reads in "<<endl;
	  cout<<"      input file <inputfile> instead of \"fittino.in\"."<<endl;
	  cout<<endl;
	  cout<<"  -i <inputfile>"<<endl;
	  cout<<"      Fittino uses input file <inputfile>."<<endl;
	  cout<<endl;
	  cout<<"  -g <inputfile>"<<endl;
	  cout<<"      Fittino generates an input file <inputfile> for the scenario provided with the -l option."<<endl;
	  cout<<"      A template input file must be provided with the -i option."<<endl;
	  cout<<endl;
	  cout<<"  -l <leshouchesfile>"<<endl;
	  cout<<"      Fittino generates the input file (see -g option) using the scenario described"<<endl;
	  cout<<"      in SUSY Les Houches Accord file <leshouchesfile>."<<endl;
	  cout<<endl;
	  return 0;
      }
      else {
	  inputfilename = new char[strlen(argv[1])+1];
	  strcpy(inputfilename, argv[1]);
      }
  }
  else {
      for (int i=1; i<argc; i++) {
  	  if (!strcmp(argv[i], "-i")) {
	      i++;
	      inputfilename = new char[strlen(argv[i])+1];
	      strcpy(inputfilename, argv[i]);
	      continue;
	  }
  	  if (!strcmp(argv[i], "-g")) {
	      i++;
	      cerr<<"Option -g not yet implemented"<<endl;
	      exit(EXIT_FAILURE);
	      continue;
	  }
  	  if (!strcmp(argv[i], "-l")) {
	      i++;
	      cerr<<"Option -l not yet implemented"<<endl;
	      exit(EXIT_FAILURE);
	      continue;
	  }
      }
  }

  cout << "reading input from file " << inputfilename << endl;
  Input* input = new Input(inputfilename);

  delete[] inputfilename;

  //  input->DumpMeasuredVector();


  // Dumping input file
  for (unsigned int i=0; i<yyInputFile.size(); i++) {
    cout<<yyInputFile[i].prevalue;
    //    if (yyInputFile[i].error >= 0) {
    if (yyInputFile[i].error.size()) {
      cout<<"size = "<<yyInputFile[i].error.size()<<endl;
      cout<<"\t"<<yyInputFile[i].value;
      for (int q=0; q < yyInputFile[i].error.size(); q++) {
	cout<<" +- "<<yyInputFile[i].error[q];
      }
    }
    cout<<yyInputFile[i].postvalue;
  }


  if (yyCalcIndChisqContr) {

    IndChisq* indchisq = new IndChisq(input);
    indchisq->CalcIndChisq();
  } 
  else if (yyCalcPullDist) {
    MakePullDist* makepulldist = new MakePullDist(input);
    makepulldist->CalcPullDist();
  }
  else {

    cout << "constructing fittino" << endl;
    Fittino* fittino = new Fittino(input);
    
    if ( yyFitModel == MSSM || yyFitModel == NMSSM ) {
      cout << "calculating tree level values" << endl;
      fittino->calculateTreeLevelValues(10000);
    }
    else if (yyFitModel == mSUGRA || yyFitModel == GMSB || yyFitModel == AMSB) {
      cout << "setting fit start values" << endl;
      fittino->setStartValues();
    }
    
    if (yyUseLoopCorrections) {
      cout << "calculating loop level values" << endl;
      fittino->calculateLoopLevelValues();
    }
    
    if (yyPerformFit) {
      fittino->writeResults("fittino.out");
    }
  }

  return 0;
}
