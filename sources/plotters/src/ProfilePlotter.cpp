/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ProfilePlotter.cpp                                               *
*                                                                              *
* Description Class for plotting chi2 profile plots                            *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TCanvas.h"
#include "TH1.h"
#include "TROOT.h"
#include "TStyle.h"

#include "ProfilePlotter.h"

Fittino::ProfilePlotter::ProfilePlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase( histogramVector, ptree ) {

    _name = "profile plotter";

    // Style settings.

    _fittinoStyle->SetFrameFillColor( kBlack ); // Black
    _fittinoStyle->SetFrameFillStyle( 3004 );   // Hatched
    _fittinoStyle->SetHistFillColor( 10 );      // White
    _fittinoStyle->SetHistLineColor( kBlack );  // Black

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );
    _pad->SetRightMargin( 0.08 );
    _pad->SetLeftMargin( 0.12 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::ProfilePlotter::~ProfilePlotter() {

}

void Fittino::ProfilePlotter::Plot( unsigned int iHistogram ) {

    _histogramVector[iHistogram]->Draw();

}

void Fittino::ProfilePlotter::PrintSteeringParameters() const {

}
