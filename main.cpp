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

// To Do:
// 1.) Clean Up                                             OK
// 2.) Constraints                                          OK
// 3.) Les Houches as Input?                                No
// 4.) Check input parameters: Enough for a certain sector? To Do
// 5.) Output file                                          To Do
// 6.) XS, BR, SPheno, etc instead of pseudo observables    Being Done
// 7.) Covariance Matrix in Output?                         OK
// 8.) Covariance Matrix in Input?                          OK
// 9.) CP phases?                                           No (As long as SPHENO can't do it)
//10.) Cosmological Constraints: MicrOMEGAs ?               To Do
//

// To Do NEU:
// 1.) Error Handling: What to do if SPHeno crashes?               Prel. OK
// 2.) Flexible input of parameters which should be fitted         
// 2a.) Repair Tree level estimations
// 3.) Output File
// 4.) Pull distributions and ind chisq.
// 5.) Precision observables: g-2, b->sg, ...
//

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
  cout << "reading input" << endl;
  Input* input = new Input("fittino.in");
  
  input->DumpMeasuredVector();

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
    
    cout << "calculating tree level values" << endl;
    fittino->calculateTreeLevelValues(10000);
    
    if (yyUseLoopCorrections) {
      cout << "calculating loop level values" << endl;
      fittino->calculateLoopLevelValues();
    }
    
    fittino->writeResults("fittino.out");

  }

  return 0;
}
