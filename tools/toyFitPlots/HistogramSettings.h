//
// @file    HistogramSettings.h
//
// @author  Mathias Uhlenbrock

#include "HistogramSetup.h"

#ifndef HISTOGRAMSETTINGS_H
#define HISTOGRAMSETTINGS_H

//Float_t observable1sLeft[numberOfHistograms];
//Float_t observable1sRight[numberOfHistograms];
//Float_t observable2sLeft[numberOfHistograms];
//Float_t observable2sRight[numberOfHistograms];

Double_t mostProbableValue[numberOfHistograms];
Double_t observableLeftLimit[numberOfHistograms];
Double_t observableRightLimit[numberOfHistograms];
Double_t sigma1RightLimit[numberOfHistograms];
Double_t sigma1LeftLimit[numberOfHistograms];
Double_t sigma2RightLimit[numberOfHistograms];
Double_t sigma2LeftLimit[numberOfHistograms];

Int_t numberOfEntries[numberOfHistograms];
Int_t sigma1numberOfRightEntries[numberOfHistograms];
Int_t sigma1numberOfLeftEntries[numberOfHistograms];
Int_t sigma2numberOfRightEntries[numberOfHistograms];
Int_t sigma2numberOfLeftEntries[numberOfHistograms];

TString observableTitle[numberOfHistograms];

UInt_t eventCounter[numberOfHistograms];
UInt_t leftEventCounter[numberOfHistograms];
UInt_t mostProbableValueBin[numberOfHistograms];
UInt_t rightEventCounter[numberOfHistograms];

HistogramSetup* histogramSetup[numberOfHistograms];

TH1F* histChi2;
TH1F* histChi22;

TH1F* histogram[numberOfHistograms];
TH1F* histogram1s[numberOfHistograms];
TH1F* histogram2s[numberOfHistograms];

#endif // HISTOGRAMSETTINGS_H
