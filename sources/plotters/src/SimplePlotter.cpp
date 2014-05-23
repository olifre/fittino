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

#include <boost/property_tree/ptree.hpp>

#include "TCanvas.h"
#include "TH1.h"
#include "TROOT.h"
#include "TStyle.h"

#include "SimplePlotter.h"

Fittino::SimplePlotter::SimplePlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase( histogramVector, ptree ),
      _fillColor ( ptree.get<int>        ( "FillColor", 1    ) ), // Black
      _fillStyle ( ptree.get<int>        ( "FillStyle", 3004 ) ), // Hatched
      _lineColor ( ptree.get<int>        ( "LineColor", 1    ) ), // Black
      _option    ( ptree.get<std::string>( "Option",    ""   ) ) {

    _name = "simple plotter";

    // Style settings.

    _fittinoStyle->SetHistFillColor( _fillColor );
    _fittinoStyle->SetHistFillStyle( _fillStyle );
    _fittinoStyle->SetHistLineColor( _lineColor );

    _option.ToLower();

    if ( _option == "colz" ) {

        _pad->SetRightMargin( 0.15 );
        _pad->SetLeftMargin( 0.11 );
        _pad->SetBottomMargin( 0.12 );
        _pad->SetTopMargin( 0.08 );

    }
    else {

        _pad->SetRightMargin( 0.10 );
        _pad->SetLeftMargin( 0.11 );
        _pad->SetBottomMargin( 0.12 );
        _pad->SetTopMargin( 0.08 );

    }

    _pad->SetTicks( 1, 1 );

    gStyle->SetPalette( 1 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::SimplePlotter::~SimplePlotter() {

}

void Fittino::SimplePlotter::Plot( unsigned int iHistogram ) {

    _histogramVector[iHistogram]->Draw( _option.Data() );

}

void Fittino::SimplePlotter::PrintSteeringParameters() const {

}
