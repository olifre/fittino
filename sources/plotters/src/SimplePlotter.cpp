/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimplePlotter.cpp                                                *
*                                                                              *
* Description Class for plotting simple quantity distributions                 *
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

#include "SimplePlotter.h"

Fittino::SimplePlotter::SimplePlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase( histogramVector, ptree ) {

    _name = "simple plotter";

    // Style settings.

    _fittinoStyle->SetHistLineColor( kBlack ); // Black
    _fittinoStyle->SetHistFillColor( kBlack ); // Black
    _fittinoStyle->SetHistFillStyle( 3004 );   // Hatched

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );
    _pad->SetRightMargin( 0.08 );
    _pad->SetLeftMargin( 0.12 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::SimplePlotter::~SimplePlotter() {

}

void Fittino::SimplePlotter::Plot( unsigned int iHistogram ) {

    _histogramVector[iHistogram]->Draw( "" );

}

void Fittino::SimplePlotter::PrintSteeringParameters() const {

}
