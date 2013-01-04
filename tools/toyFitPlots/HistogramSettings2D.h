//
// @file    HistogramSettings2D.h
//
// @author  Mathias Uhlenbrock

#include "HistogramSetup.h"

#ifndef HISTOGRAMSETTINGS2D_H
#define HISTOGRAMSETTINGS2D_H

HistogramSetup* histogramSetup[numberOfHistograms];

TH2F* histogram[numberOfHistograms];
TH2F* histogram1s[numberOfHistograms];
TH2F* histogram2s[numberOfHistograms];

#endif // HISTOGRAMSETTINGS2D_H
