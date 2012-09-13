/***************************************************************************
                                  fittino.h
                             -------------------    
    Main class which does Fittino's calculations.
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

#ifndef FITTINO_FITTINO_H
#define FITTINO_FITTINO_H

#include <misc.h>
#include <TMath.h>
#include <TMatrixD.h>
#include <TTree.h>
#include <TNtuple.h>
#include "TMatrixDSymEigen.h"

class Input;
class SmearedInput;

typedef struct {
  vector <double> value;
} vector_type;
extern int initialize_HiggsBoundsWithSLHA(int nH, int nHplus, char* whichexpt);
extern int close_HiggsBoundsWithSLHA();
extern void fitterFCN(Int_t &, Double_t *, Double_t &f, Double_t *x, Int_t iflag) ;
extern double gchisq;
extern int    gstat;
extern int n_printouts;
extern bool FindInFixed(string name);
extern void FillFixedParameters();
extern int callMicrOmegas (double *x);
extern double higgsLimit ();
extern double readAstroFit ();
extern double higgsBR(int id, vector<int> daughter_list);
extern double mSquarkGluinoMax;

class Fittino {
public:
    Fittino(const Input* input);
    virtual ~Fittino();

    void calculateTreeLevelValues(int nthrows = 100000);
    void calculateLoopLevelValues();
    void CalcFromRandPars(unsigned int nruns);

    void setStartWidths();
    void setStartValues();

    void writeResults(const char* filename);

    const MeasuredValue& getM0() const      { return fM0; }
    const MeasuredValue& getM1() const      { return fM1; }
    const MeasuredValue& getM2() const      { return fM2; }
    const MeasuredValue& getAbsM3() const   { return fAbsM3; }
    const MeasuredValue& getAM0H()  const   { return fM0H; }
    const MeasuredValue& getAM0Hu()  const   { return fM0Hu; }
    const MeasuredValue& getAM0Hd()  const   { return fM0Hd; }
    const MeasuredValue& getAM05()  const   { return fM05; }
    const MeasuredValue& getAM010() const   { return fM010; }
    const MeasuredValue& getA0() const      { return fA0; }
    const MeasuredValue& getTanBeta() const { return fTanBeta; }
    const MeasuredValue& getMu() const      { return fMu; }

private:
    const Input*  fInput;
    double*       fFittedCovarianceMatrix;
    double fchisq;

    MeasuredValue fM0;
    MeasuredValue fM12;

    MeasuredValue fLambda;
    MeasuredValue fMmess;
    MeasuredValue fN5;
    MeasuredValue fcGrav;

    MeasuredValue fM32;

    MeasuredValue fM1;
    MeasuredValue fM2;
    MeasuredValue fM3;
		MeasuredValue fAbsM3;
    MeasuredValue fM0H;
    MeasuredValue fM0Hu;
    MeasuredValue fM0Hd;
    MeasuredValue fM05;
    MeasuredValue fM010;
    MeasuredValue fA0;
    MeasuredValue fTanBeta;
    MeasuredValue fMu;
    MeasuredValue fAbsMu;
    MeasuredValue fSignMu;
    MeasuredValue fMSelL;
    MeasuredValue fMSelR;
    MeasuredValue fMSmuL;
    MeasuredValue fMSmuR;
    MeasuredValue fMStauL;
    MeasuredValue fMStauR;
    MeasuredValue fMSupL;
    MeasuredValue fMSupR;
    MeasuredValue fMScharmL;
    MeasuredValue fMScharmR;
    MeasuredValue fMStopL;
    MeasuredValue fMStopR;
    MeasuredValue fMSdownR;
    MeasuredValue fMSstrangeR;
    MeasuredValue fMSbottomR;
    MeasuredValue fXbottom;
    MeasuredValue fXtop;
    MeasuredValue fXtau;
    MeasuredValue fAbottom;
    MeasuredValue fAtop;
    MeasuredValue fAtau;
		MeasuredValue fmassA0;
		MeasuredValue fMSqx;
		MeasuredValue fMSq3;
		MeasuredValue fMSlx;

    MeasuredValue fQEWSB;

    MeasuredValue fNmssmLambda;
    MeasuredValue fKappa;
    MeasuredValue fALambda;
    MeasuredValue fAKappa;

    void          calculateM1(const SmearedInput* input);
    void          calculateM2(const SmearedInput* input);
    void          calculateAbsM3(const SmearedInput* input);
    void          calculateTanBeta(const SmearedInput* input);
    void          calculateAbsMu(const SmearedInput* input);
    void          calculateSignMu(const SmearedInput* input);
    void          calculateMu(const SmearedInput* input);
    void          calculateMSelL(const SmearedInput* input);
    void          calculateMSelR(const SmearedInput* input);
    void          calculateMSmuL(const SmearedInput* input);
    void          calculateMSmuR(const SmearedInput* input);
    void          calculateMStauL(const SmearedInput* input);
    void          calculateMStauR(const SmearedInput* input);
    void          calculateMSupL(const SmearedInput* input);
    void          calculateMScharmL(const SmearedInput* input);
    void          calculateMStopL(const SmearedInput* input);
    void          calculateMSupR(const SmearedInput* input);
    void          calculateMScharmR(const SmearedInput* input);
    void          calculateMStopR(const SmearedInput* input);
    void          calculateMSdownR(const SmearedInput* input);
    void          calculateMSstrangeR(const SmearedInput* input);
    void          calculateMSbottomR(const SmearedInput* input);
    void          calculateXtau(const SmearedInput* input);
    void          calculateXtop(const SmearedInput* input);
    void          calculateXbottom(const SmearedInput* input);

    TMatrixD* fSavedFittedCovarianceMatrix;
    TMatrixD* fSavedFittedCorrelationMatrix;

    void simulated_annealing (int iteration, TNtuple *ntuple);
    void simulated_annealing_uncertainties (TNtuple *ntuple);
    void simulated_annealing_uncertainties_run_down (TNtuple *ntuple);
    void markovChain ();

    // == For optimization of proposal width
    TMatrixD corM;
    TMatrixDSym covMsym; 
    TVectorD eigenValues;
    TMatrixD eigenVectors;
    TMatrixD correlationMatrix;
    TMatrixDSymEigen covarianceMatrix;
    vector<double> correlatedRandomNumbers( vector<double> mean );
    vector <double> widthOptimization(std::vector<double> x, std::vector<double> vm, std::vector<double> xp, std::vector<double> lb, std::vector <double> ub, std::vector<string> xNames );
    void estimateCorrelations(vector<double> x, vector<double> xp, vector<double> vm, vector<double> lb, vector <double> ub );
    void computeCovMatrix( vector<double> vm, vector< vector <Float_t> > varSampling );

    // ==
 
    
    double calculateQ(std::vector<double> x, std::vector<double> xk, std::vector<double> vm);
    void hybridMonteCarlo();

    void randomDirectionUncertainties();
};

#endif
