/***************************************************************************
                                     yy.h
                             -------------------    
    Declarations used for data transfer between yacc and Input class.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : September 14, 2003
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

#ifndef FITTINO_YY_H
#define FITTINO_YY_H

#include <stdio.h>
#include <misc.h>


extern FILE* yyin;

extern "C" {
int yylex(void);
void yyerror(char*);
int yyparse(void);
int yywrap(void);
}

extern vector<MeasuredValue> yyMeasuredVec;
extern vector<MeasuredValue> yyThrownVec;

extern vector<MeasuredValue> yyFittedVec;
extern vector<MeasuredValue> yyUniversalityVec;
extern vector<MeasuredValue> yyFixedVec;  // contains mu, M1, M2 ...

extern CorrelationMatrix     yyMeasuredCorrelationMatrix;
extern CorrelationMatrix     yyFittedCorrelationMatrix;
		        
extern bool             yyUseOneLoopCorrections;
extern bool             yyCalcPullDist;
extern bool             yyScanParameters;
extern bool             yyISR;
extern bool             yyGeneratorError;
extern bool             yyUseMinos;
extern bool             yyUseHesse;
extern bool             yyUseGivenStartValues;
extern bool             yyFitAllDirectly;
extern int              yyNumberOfMinimizations;
extern bool             yyCalcIndChisqContr;
extern bool             yyBoundsOnX;
extern bool             yySepFitTanbX;
extern bool             yyScanX;

typedef struct {
  string name;
  double value;
  double error;
} parameter_t;

extern vector <parameter_t> yyFixedPar;
extern vector <parameter_t> yyFittedPar;

extern string yyGeneratorPath;
extern int    yyParseError;
extern double        yyErrDef;
extern int           yyNumberPulls;
extern double        yyXscanlow;
extern double        yyXscanhigh;

#endif
