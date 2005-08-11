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
  if (argc > 1) {
      inputfilename = new char[strlen(argv[1])+1];
      strcpy(inputfilename, argv[1]);
  }
  else {
      inputfilename = new char[strlen("fittino.in")+1];
      strcpy(inputfilename, "fittino.in");
  }

  cout << "reading input from file " << inputfilename << endl;
  Input* input = new Input(inputfilename);

  delete[] inputfilename;

  //  input->DumpMeasuredVector();

  /*
  // Dumping input file
  for (unsigned int i=0; i<yyInputFile.size(); i++) {
    cout<<yyInputFile[i].prevalue;
    if (yyInputFile[i].error >= 0) {
      cout<<"\t"<<yyInputFile[i].value<<" +- "<<yyInputFile[i].error;
    }
    cout<<yyInputFile[i].postvalue;
  }
  */

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
    
    if (yyFitModel == MSSM) {
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
