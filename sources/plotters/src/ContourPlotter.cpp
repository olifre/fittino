/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ContourPlotter.cpp                                               *
*                                                                              *
* Description Class for plotting 2D contour plots                              *
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
#include "TColor.h"
#include "TGraph.h"
#include "TH1.h"
#include "TLegend.h"
#include "TMarker.h"
#include "TMath.h"
#include "TObjArray.h"
#include "TROOT.h"
#include "TStyle.h"

#include "ContourPlotter.h"

Fittino::ContourPlotter::ContourPlotter( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : PlotterBase( histogramVector, ptree ),
      _style     ( ptree.get<std::string>( "Style", "Plain" ) ) {

    _name = "contour plotter";

    // Style settings.

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    //if ( _style == "Peach" ) {

    //    _pad->SetRightMargin( 0.16 );
    //    _pad->SetLeftMargin( 0.10 );

    //}
    //else {

    _pad->SetRightMargin( 0.08 );
    _pad->SetLeftMargin( 0.12 );

    //}

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::ContourPlotter::~ContourPlotter() {

}

void Fittino::ContourPlotter::Plot( unsigned int iHistogram ) {

    //if ( _style == "Peach" ) {

    //    // Set the color palette.

    //    const UInt_t Number = 3;
    //    Double_t Red[Number]   = { 0.00, 1.00, 1.00 };
    //    Double_t Green[Number] = { 1.00, 1.00, 0.00 };
    //    Double_t Blue[Number]  = { 1.00, 0.00, 1.00 };
    //    Double_t Length[4] = { 0.0, 0.1, 0.6, 1.0 };
    //    Int_t nb = 10;
    //    TColor::CreateGradientColorTable( Number, Length, Red, Green, Blue, nb );
    //    _histogramVector[iHistogram]->SetContour( nb );

    //    // Set all bins with entries greater 10 to zero.

    //    for ( Int_t iBinX = 0; iBinX <= _histogramVector[iHistogram]->GetNbinsX(); ++iBinX ) {

    //        for ( Int_t iBinY = 0; iBinY <= _histogramVector[iHistogram]->GetNbinsY(); ++iBinY ) {

    //            if ( _histogramVector[iHistogram]->GetBinContent( iBinX, iBinY ) >= 10. )
    //                _histogramVector[iHistogram]->SetBinContent( iBinX, iBinY, 0. );

    //        }

    //    }

    //}

    // Prepare histogram contours.

    TH1* contourHistogram = ( TH1* )_histogramVector[iHistogram]->Clone();

    Double_t levels[2] = { 1., 6. };
    contourHistogram->SetContour( 2, levels );
    contourHistogram->Draw( "CONT LIST" );

    _canvas->Update();

    // Draw the histogram.

    //if ( _style == "Peach" ) {

    //    _histogramVector[iHistogram]->Draw( "COLZ" );

    //}
    //else {

    _histogramVector[iHistogram]->Draw( "AXIS" );

    //}

    // Draw the contours.

    TObjArray *contours = ( TObjArray* )gROOT->GetListOfSpecials()->FindObject( "contours" );

    TList* listOfGraphsPerContour1 = 0;
    TList* listOfGraphsPerContour2 = 0;

    if ( contours ) listOfGraphsPerContour1 = ( TList* )contours->At( 1 );
    if ( contours ) listOfGraphsPerContour2 = ( TList* )contours->At( 0 );

    TGraph* contour1 = 0;
    TGraph* contour2 = 0;

    if ( listOfGraphsPerContour1 ) {

        int nGraphsPerContour = listOfGraphsPerContour1->GetSize();

        for ( int iGraph = 0; iGraph < nGraphsPerContour; iGraph++ ) {

            contour1 = ( TGraph* ) listOfGraphsPerContour1->At( iGraph );

            if ( _style == "Classic" ) {

                if ( contour1 ) contour1->SetLineStyle( 1 );
                if ( contour1 ) contour1->SetLineColor( kBlue - 2 );
                if ( contour1 ) contour1->SetFillColor( kBlue - 10 );
                if ( contour1 ) contour1->Draw( "F" );
                if ( contour1 ) contour1->Draw( "CSAME" );

            }
            else {

                if ( contour1 ) contour1->SetLineStyle( 2 );
                if ( contour1 ) contour1->SetLineColor( kBlack );
                if ( contour1 ) contour1->Draw( "C" );

            }

        }

    }

    if ( listOfGraphsPerContour2 ) {

        int nGraphsPerContour = listOfGraphsPerContour2->GetSize();

        for ( int iGraph = 0; iGraph < nGraphsPerContour; iGraph++ ) {

            contour2 = ( TGraph* ) listOfGraphsPerContour2->At( iGraph );

            if ( contour2 ) contour2->SetLineStyle( 1 );

            if ( _style == "Classic" ) {

                if ( contour2 ) contour2->SetLineColor( kBlue - 2 );
                if ( contour2 ) contour2->SetFillColor( kBlue - 9 );
                if ( contour2 ) contour2->Draw( "F" );
                if ( contour2 ) contour2->Draw( "CSAME" );

            }
            else {

                if ( contour2 ) contour2->SetLineColor( kBlack );
                if ( contour2 ) contour2->Draw( "C" );

            }

        }

    }

    // Draw the best fit value.

    Int_t minimumBinX = 0;
    Int_t minimumBinY = 0;

    for ( Int_t iBinX = 0; iBinX <= _histogramVector[iHistogram]->GetNbinsX(); ++iBinX ) {

        for ( Int_t iBinY = 0; iBinY <= _histogramVector[iHistogram]->GetNbinsY(); ++iBinY ) {

            if ( _histogramVector[iHistogram]->GetBinContent( iBinX, iBinY ) <= 0. ) {

                minimumBinX = iBinX;
                minimumBinY = iBinY;

            }

        }

    }

    Double_t bestFitValueX = _histogramVector[iHistogram]->GetXaxis()->GetBinCenter( minimumBinX );
    Double_t bestFitValueY = _histogramVector[iHistogram]->GetYaxis()->GetBinCenter( minimumBinY );

    TMarker* bestFitValue = new TMarker( bestFitValueX, bestFitValueY, 29 );
    bestFitValue->SetMarkerColor( kBlack );

    bestFitValue->Draw( "PSAME" );

    // Draw the legend.

    if ( _format == "Square" ) {

        _legend = new TLegend( 0.58, 0.17, 0.84, 0.35 );

    }
    else {

        _legend = new TLegend( 0.65, 0.17, 0.89, 0.35 );

    }

    _legend->SetShadowColor( 0 );
    _legend->SetBorderSize( 1 );
    _legend->SetLineColor( 0 );
    _legend->SetTextSize( _textSize );
    _legend->SetTextFont( _textFont );
    _legend->SetFillColor( 0 );
    _legend->AddEntry( bestFitValue, "Best Fit Point", "p" );

    if ( _style == "Classic" ) {

        _legend->AddEntry( contour2, "1D 68% CL", "f" );
        _legend->AddEntry( contour1, "2D 95% CL", "f" );

    }
    else {

        _legend->AddEntry( contour2, "1D 68% CL", "l" );
        _legend->AddEntry( contour1, "2D 95% CL", "l" );

    }

    _legend->Draw( "SAME" );

    _histogramVector[iHistogram]->Draw( "AXISSAME" );

}

void Fittino::ContourPlotter::PrintSteeringParameters() const {

}
