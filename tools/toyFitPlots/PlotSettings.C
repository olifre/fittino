//
// @file    PlotSettings.C
//
// @author  Mathias Uhlenbrock

#include "PlotSettings.h"

void PlotSettings()
{
    // Load and set Atlas style.
    gROOT->LoadMacro("style/AtlasLabels.C");
    gROOT->LoadMacro("style/AtlasStyle.C");
    gROOT->LoadMacro("style/AtlasUtils.C");
    SetAtlasStyle();

    // Set nice palette colors.
    gStyle->SetPalette(1);

    canvas = new TCanvas("Canvas", "Canvas", 800, 600);
}
