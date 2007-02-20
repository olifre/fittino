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
extern bool          yyPerformSingleFits;
extern bool          yyUseMicrOmegas;
extern bool          yyUseHiggsLimits;

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
extern int    yyNaN;
extern int    yyInfinity;
extern double        yyErrDef;
extern int           yyNumberPulls;
extern int           yyMaxCallsSimAnn;
extern int           yyRandomGeneratorSeed;
extern int           yyNumberOfDirections;
extern double        yyTempRedSimAnn;
extern double        yyInitTempSimAnn;
extern double        yyXscanlow;
extern double        yyXscanhigh;
extern double        yyMaxCalculatorTime;
extern double        yyLimitSlope;

extern unsigned int  yyFitModel;

//==========================================================
// Low Energy Observables: (SPhenoLowEnergy)
extern double        yybsg;     //  1  BR(b -> s gamma) 
extern double        yybsmm;    //  2  BR(b -> s mu+ mu-)
extern double        yyB_smm;   //  3  BR(Bs -> mu+ mu-)
extern double        yyB_utn;   //  4  BR(B_u -> tau nu)
extern double        yydMB_d;   //  5  |Delta(M_Bd)| [ps^-1]
extern double        yydMB_s;   //  6  |Delta(M_Bs)| [ps^-1]
extern double        yygmin2e;  // 10  Delta(g-2)_electron
extern double        yygmin2m;  // 11  Delta(g-2)_muon
extern double        yygmin2t;  // 12  Delta(g-2)_tau
extern double        yydrho;    // 30  Delta(rho_parameter)
//---------------------------------------------------------
extern double        yyOmega;   //     relic density
extern double        yygSquaredAh;  // hAZ coupling correction
extern double        yygSquaredZh;  // hZZ coupling correction
//==========================================================

extern std::vector<InputFileLine> yyInputFile;
extern int yyInputFileLineNo;

#endif
