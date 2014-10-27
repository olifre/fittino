/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SummaryPlotter.cpp                                               *
*                                                                              *
* Description Class for plotting a summary of the fitted quantities            *
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
#include "TH2D.h"
#include "TLegend.h"
#include "TLine.h"
#include "TMarker.h"
#include "TROOT.h"
#include "TStyle.h"
#include "TGraph.h"

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SummaryPlotter.h"

Fittino::SummaryPlotter::SummaryPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase  ( histogramVector, ptree ),
      _labelOffset ( 0.02 ),
      _labelSize   ( 0.05 ),
      _color1      ( kBlue -  8 ), // Dark blue
      _color2      ( kBlue - 10 ), // Light blue
      _line        ( new TLine() ),
      _ndivisions  ( ptree.get<int>( "NDivisions", 510 ) ),
      _title( ptree.get<std::string>( "Title", "" ) ),
      _bestFitValue( new TMarker( 0., 0.9, 29 ) ) {

    _name = "summary plotter";

    // Palette settings.

    Int_t palette[2] = { _color2, _color1 };

    // Line settings

    _line->SetLineStyle( 2 );      // Dashed
    _line->SetLineColor( kBlack ); // Black

    // Best fit point settings.

    _bestFitValue->SetMarkerColor( kBlack ); // Black

    // Style settings.

    _fittinoStyle->SetPalette( 2, palette );

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );
    _pad->SetTopMargin( 0.14 );
    _pad->SetRightMargin( 0.05 );
    _pad->SetLeftMargin( 0.40 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::SummaryPlotter::~SummaryPlotter() {

    delete _legend;
    delete _legend2;
    delete _line;
    delete _bestFitValue;

    _legend = 0;
    _legend2 = 0;
    _line = 0;
    _bestFitValue = 0;

}

void Fittino::SummaryPlotter::Plot( unsigned int iHistogram ) {

    // Draw the histogram.
    
    _histogramVector.at( iHistogram )->GetXaxis()->SetTitle( _title.c_str() );
    _histogramVector.at( iHistogram )->GetXaxis()->SetNdivisions( _ndivisions );
    _histogramVector.at( iHistogram )->GetYaxis()->SetNdivisions( 0, kFALSE );

    _histogramVector.at( iHistogram )->GetYaxis()->SetLabelSize( _labelSize );
    _histogramVector.at( iHistogram )->GetYaxis()->SetLabelOffset( _labelOffset );
    
    _histogramVector.at( iHistogram )->GetYaxis()->SetTickSize(0);
    
    _histogramVector.at( iHistogram )->Draw( "COL" );

    // Draw a vertical dashed line to indicate the expectation.

    _line->DrawLine( 1., 0., 1., _histogramVector.at( iHistogram )->GetYaxis()->GetXmax() );

    _histogramVector.at( iHistogram )->Draw( "COLSAME" );
    _histogramVector.at( iHistogram )->Draw( "COLSAME" );

    // Draw the legends.

    TH2D* dummyHistogram1 = ( TH2D* )_histogramVector.at( iHistogram )->Clone();
    TH2D* dummyHistogram2 = ( TH2D* )_histogramVector.at( iHistogram )->Clone();
    dummyHistogram1->SetFillColor( _color1 );
    dummyHistogram1->SetLineColor( _color1 );
    dummyHistogram2->SetFillColor( _color2 );
    dummyHistogram2->SetLineColor( _color2 );

    _legend = new TLegend( 0.70, 0.88, 0.93, 0.97 );
    _legend->SetShadowColor( 0 );
    _legend->SetBorderSize( 1 );
    _legend->SetLineColor( 0 );
    _legend->SetTextSize( _textSize );
    _legend->SetTextFont( _textFont );
    _legend->SetFillColor( 0 );
    _legend->AddEntry( _graphVector[0], "Best fit value", "l" );
    _legend->AddEntry( _bestFitValue, "Data", "p" );

    _legend2 = new TLegend( 0.42, 0.88, 0.69, 0.97 );
    _legend2->SetShadowColor( 0 );
    _legend2->SetBorderSize( 1 );
    _legend2->SetLineColor( 0 );
    _legend2->SetTextSize( _textSize );
    _legend2->SetTextFont( _textFont );
    _legend2->SetFillColor( 0 );
    _legend2->AddEntry( dummyHistogram1, "68 % CL", "f" );
    _legend2->AddEntry( dummyHistogram2, "95 % CL", "f" );

    _legend->Draw( "SAME" );
    _legend2->Draw( "SAME" );

    for ( unsigned int i = 0; i < _graphVector.size(); i++ ) {
        
        _graphVector[i]->SetLineWidth( 4 );
        _graphVector[i]->SetLineColor( kRed );
        _graphVector[i]->Draw("LSAME");
    
    }
    
    gPad->RedrawAxis();

}

void Fittino::SummaryPlotter::PrintSteeringParameters() const {

}
