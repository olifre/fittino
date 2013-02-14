//
// @file    FileSettings.h
//
// @author  Mathias Uhlenbrock

#ifndef FILESETTINGS_H
#define FILESETTINGS_H

TFile* file;

// Specify the location of the input file.
TString inputFile = "/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/toys/4/CMSSM/toy.root";
//TString inputFile = "/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/toys/0/NUHM1/toy.root";
//TString inputFile = "/scratch/hh/dust/naf/atlas/user/prudent/postProcessing_2012/outputs/toys/0/NUHM2/toy.root";

// Specify the model.
TString model = "CMSSM";
//TString model = "NUHM1";
//TString model = "NUHM2";

// Specify the name of the ROOT tree in the input file.
TString treeName = "markovChain";

TTree* tree;

// Specify the number of observables.
const UInt_t numberOfObservables = 10;

// Specify the number of model parameters.
const UInt_t numberOfParameters = 5;
//const UInt_t numberOfParameters = 6;
//const UInt_t numberOfParameters = 7;

// Gauss' formula gives the number of pairs.
//const UInt_t numberOfHistograms = (numberOfObservables*(numberOfObservables-1))/2.;
//const UInt_t numberOfHistograms = numberOfObservables + numberOfParameters + 1;

// For 1D histograms.
const UInt_t numberOfHistograms = 15; // CMSSM
//const UInt_t numberOfHistograms = 16; // NUHM1
//const UInt_t numberOfHistograms = 17; // NUHM2

// For 2D histograms.
const UInt_t numberOfHistograms = 105; // CMSSM
//const UInt_t numberOfHistograms = 120; // NUHM1
//const UInt_t numberOfHistograms = 136; // NUHM2

Float_t leaf[numberOfHistograms] = 0;

#endif // FILESETTINGS_H
