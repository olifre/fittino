/***************************************************************************
                                pulldist.cpp
                             -------------------
    Everything need to make pull distributions.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : December 07, 2003
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


// map<int,THF1> histomap
// for (unsigned int i = 0; i < yyFittedVec.size(); i++) {
//   THF1* newhist = new THF1(yyFittedVec.name,...);
//   histomap[i] = newhist;
// }
// for (unsigned int j = 0; j < nfits;j++) {
//   calculate new Fit result...
//   for (unsigned int i = 0; i < yyFittedVec.size(); i++) {
//     histomap[i].Fill(yyFittedVec[i].value-storedFitted[i].value);
//   }
// }
