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

#include <boost/foreach.hpp>

#include "TCanvas.h"
#include "TH2D.h"
#include "TLegend.h"
#include "TLine.h"
#include "TMarker.h"
#include "TROOT.h"
#include "TStyle.h"
#include "TGraph.h"
#include "TGraphAsymmErrors.h"

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SummaryPlotter.h"

Fittino::SummaryPlotter::SummaryPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase  ( histogramVector, ptree ),
      _data        ( new TGraphAsymmErrors() ),
      _labelOffset ( 0.02 ),
      _labelSize   ( 0.05 ),
      _labelsLeft  ( ptree.get<bool>( "LabelsLeft", true ) ),
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
    _pad->SetBottomMargin( 0.12 );

    if ( _labelsLeft ) {
              
        _pad->SetRightMargin( 0.06 );
        _pad->SetLeftMargin( 0.40 );
        
    }
    else {
        
        _pad->SetRightMargin( 0.40 );
        _pad->SetLeftMargin( 0.06 );
   
    }

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();
          
    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {
        
        if ( node.first != "DataPoint" ) continue;
        
        std::string name = node.second.get<std::string>("Name");
        double value = node.second.get<double>("Value");
        double elow = node.second.get<double>("ErrorLow");
        double ehigh = node.second.get<double>("ErrorHigh");
        
        int bin = _histogramVector.at( 0 )->GetYaxis()->FindBin( name.c_str() );
          
        if ( bin < 0 ) {
              
            throw ConfigurationException("Label does not exist.");
              
        }
          
        double yvalue =_histogramVector.at( 0 )->GetYaxis()->GetBinCenter(bin);
        
        int iDataPoint = _data->GetN();
        
        _data->SetPoint( iDataPoint, value, yvalue);
        _data->SetPointEXlow( iDataPoint, elow);
        _data->SetPointEXhigh(iDataPoint, ehigh);
        
    }
    
    double default_xlow = _histogramVector.at( 0 )->GetXaxis()->GetXmin();
    double default_xup = _histogramVector.at( 0 )->GetXaxis()->GetXmax();
          
    double xlow = ptree.get<double>( "LowerBound", default_xlow );
    double xup = ptree.get<double>( "UpperBound", default_xup );
          
    int nbinsy = _histogramVector.at( 0 )->GetYaxis()->GetNbins();
    double ylow = _histogramVector.at( 0 )->GetYaxis()->GetXmin();
    double yup = _histogramVector.at( 0 )->GetYaxis()->GetXmax();
          
    _emptyHistogram = new TH2D( "h", "", 2, xlow, xup, nbinsy, ylow, yup );
    
    for ( unsigned int i = 1; i <= nbinsy; i++ ) {
              
        _emptyHistogram->GetYaxis()->SetBinLabel(i, _histogramVector.at( 0 )->GetYaxis()->GetBinLabel(i) );
              
    }
          
    _emptyHistogram->GetXaxis()->SetTitle( _title.c_str() );
    _emptyHistogram->GetXaxis()->SetNdivisions( _ndivisions );
    _emptyHistogram->GetYaxis()->SetNdivisions( 0, kFALSE );
          
    _emptyHistogram->GetYaxis()->SetLabelSize( _labelSize );
    _emptyHistogram->GetYaxis()->SetLabelOffset( _labelOffset );
          
    _emptyHistogram->GetYaxis()->SetTickSize(0);
          
    std::string option = "COL";
          
    if ( !_labelsLeft ) option += "Y+";
 
    _emptyHistogram->Draw( option.c_str() );
          
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
    
    _histogramVector.at( iHistogram )->Draw( "COLSAME");

    // Draw a vertical dashed line to indicate the expectation.

    _histogramVector.at( iHistogram )->Draw( "COLSAME" );
    _histogramVector.at( iHistogram )->Draw( "COLSAME" );
    
    for ( unsigned int i = 0; i < _graphVector.size(); i++ ) {
        
        _graphVector[i]->SetLineWidth( 4 );
        _graphVector[i]->SetLineColor( kRed );
        _graphVector[i]->Draw( "LSAME" );
        
    }
    
    _line->DrawLine( 1., 0., 1., _histogramVector.at( iHistogram )->GetYaxis()->GetXmax() );

    _data->SetMarkerStyle( kFullDotLarge );
    _data->Draw( "PZEsame" );
    
    
    // Draw the legends.

    TH2D* dummyHistogram1 = ( TH2D* )_histogramVector.at( iHistogram )->Clone();
    TH2D* dummyHistogram2 = ( TH2D* )_histogramVector.at( iHistogram )->Clone();
    dummyHistogram1->SetFillColor( _color1 );
    dummyHistogram1->SetLineColor( _color1 );
    dummyHistogram2->SetFillColor( _color2 );
    dummyHistogram2->SetLineColor( _color2 );

    if ( _labelsLeft ) {
    
        _legend = new TLegend( 0.70, 0.88, 0.93, 0.97 );
        
    }
    else {
        
        _legend = new TLegend( 0.33, 0.88, 0.55, 0.97 );
        
    }
    _legend->SetShadowColor( 0 );
    _legend->SetBorderSize( 1 );
    _legend->SetLineColor( 0 );
    _legend->SetTextSize( _textSize );
    _legend->SetTextFont( _textFont );
    _legend->SetFillColor( 0 );
    _legend->AddEntry( _graphVector[0], "Best fit value", "l" );
    
    if ( _data->GetN() ) {
        
        _legend->AddEntry( _data, "Data", "lp" );
        
    }

    if ( _labelsLeft ) {
        
        _legend2 = new TLegend( 0.42, 0.88, 0.69, 0.97 );
        
    }
    else {
        
        _legend2 = new TLegend( 0.05, 0.88, 0.32, 0.97 );
        
    }
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
    
    gPad->RedrawAxis();

}

void Fittino::SummaryPlotter::PrintSteeringParameters() const {

}
