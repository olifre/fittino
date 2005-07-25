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
		        
extern bool             yyUseLoopCorrections;
extern bool             yyCalcPullDist;
extern bool             yyScanParameters;
extern bool             yyPerformFit;
extern bool             yyISR;
extern bool             yyCalculatorError;
extern bool             yyUseMinos;
extern bool             yyGetContours;
extern bool             yyUseHesse;
extern bool             yyUseSimAnnBefore;
extern bool             yyUseSimAnnWhile;
extern bool             yyUseGivenStartValues;
extern bool             yyFitAllDirectly;
extern unsigned int     yyNumberOfMinimizations;
extern bool             yyCalcIndChisqContr;
extern bool             yyBoundsOnX;
extern bool             yySepFitTanbX;
extern bool             yySepFitTanbMu;
extern bool             yySepFitmA;
extern bool             yyScanX;
extern bool             yyVerbose;
extern bool             yyAdaptiveSimAnn;
extern bool             yyNoBoundsAtAll;
extern bool          yySimAnnUncertainty;
extern bool          yySimAnnUncertaintyRunDown;
extern bool          yyRandomDirUncertainties;


typedef struct {
  string name;
  double value;
  double error;
} parameter_t;

extern vector <parameter_t> yyFixedPar;
extern vector <parameter_t> yyFittedPar;
extern vector<ScanParameter> yyScanPar;

extern string yyCalculatorPath;
extern int    yyParseError;
extern double        yyErrDef;
extern int           yyNumberPulls;
extern int           yyMaxCallsSimAnn;
extern int           yyRandomGeneratorSeed;
extern int           yyNumberOfDirections;
extern double        yyTempRedSimAnn;
extern double        yyInitTempSimAnn;
extern double        yyXscanlow;
extern double        yyXscanhigh;

extern unsigned int  yyFitModel;

extern double        yybsg;
extern double        yygmin2;
extern double        yydrho;

#endif
