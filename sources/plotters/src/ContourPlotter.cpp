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
    : PlotterBase    ( histogramVector, ptree ),
      _legendFrame   ( ptree.get<bool>       ( "LegendFrame",    false         ) ),
      _legendPosition( ptree.get<std::string>( "LegendPosition", "BottomRight" ) ),
      _style         ( ptree.get<std::string>( "Style",          "Plain"       ) ) {

    _name = "contour plotter";

    // Style settings.

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );

    if      ( _style == "Classic" ) SetClassicStyle();
    else if ( _style == "Peach"   ) SetPeachStyle();
    else if ( _style == "Plain"   ) SetPlainStyle();

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

}

Fittino::ContourPlotter::~ContourPlotter() {

}

void Fittino::ContourPlotter::Plot( unsigned int iHistogram ) {

    // Prepare histogram contours.

    TH1* contourHistogram = ( TH1* )_histogramVector[iHistogram]->Clone();

    Double_t levels[2] = { 1., 6. };
    contourHistogram->SetContour( 2, levels );
    contourHistogram->Draw( "CONT LIST" );

    _canvas->Update();

    // Draw the histogram.

    if ( _style == "Peach" ) {

        _histogramVector[iHistogram]->SetContour( _totalNumberOfContourLevels );

        // Set all bins with entries greater 10 to zero.

        for ( Int_t iBinX = 0; iBinX <= _histogramVector[iHistogram]->GetNbinsX(); ++iBinX ) {

            for ( Int_t iBinY = 0; iBinY <= _histogramVector[iHistogram]->GetNbinsY(); ++iBinY ) {

                if ( _histogramVector[iHistogram]->GetBinContent( iBinX, iBinY ) >= 10. )
                    _histogramVector[iHistogram]->SetBinContent( iBinX, iBinY, 0. );

            }

        }

        _histogramVector[iHistogram]->Draw( "COLZ" );

    }
    else {

        _histogramVector[iHistogram]->Draw( "AXIS" );

    }

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

            if ( contour1 ) contour1->SetLineStyle( _contour2SigmaLineStyle );
            if ( contour1 ) contour1->SetLineColor( _contour2SigmaLineColor );
            if ( contour1 ) contour1->SetFillColor( _contour2SigmaFillColor );

            if ( contour1->GetN() < 6 ) continue;

            if ( _style == "Classic" ) {

                if ( contour1 ) contour1->Draw( "F" );
                if ( contour1 ) contour1->Draw( "CSAME" );

            }
            else {

                if ( contour1 ) contour1->Draw( "C" );

            }

        }

    }

    if ( listOfGraphsPerContour2 ) {

        int nGraphsPerContour = listOfGraphsPerContour2->GetSize();

        for ( int iGraph = 0; iGraph < nGraphsPerContour; iGraph++ ) {

            contour2 = ( TGraph* ) listOfGraphsPerContour2->At( iGraph );

            if ( contour2 ) contour2->SetLineStyle( 1 );
            if ( contour2 ) contour2->SetLineColor( _contour1SigmaLineColor );
            if ( contour2 ) contour2->SetFillColor( _contour1SigmaFillColor );

            if ( contour2->GetN() < 6 ) continue;

            if ( _style == "Classic" ) {

                if ( contour2 ) contour2->Draw( "F" );
                if ( contour2 ) contour2->Draw( "CSAME" );

            }
            else {

                if ( contour2 ) contour2->Draw( "C" );

            }

        }

    }

    // Draw the legend.

    _legend = new TLegend( _legendX1, _legendY1, _legendX2, _legendY2 );

    _legend->SetShadowColor( 0 );
    _legend->SetBorderSize( 1 );
    _legend->SetLineColor( 0 );
    _legend->SetTextSize( _textSize );
    _legend->SetTextFont( _textFont );
    _legend->SetFillColor( 0 );

    if ( _legendFrame ) _legend->SetLineColor( kBlack );
    else _legend->SetLineColor( 0 );

    _legend->AddEntry( _graphVector.at( iHistogram ), "Best Fit Point", "p" );
    _legend->AddEntry( contour2, "1D 68% CL", _legendOption );
    _legend->AddEntry( contour1, "2D 95% CL", _legendOption );

    _legend->Draw( "SAME" );

    // Draw axis again.

    _histogramVector[iHistogram]->Draw( "AXISSAME" );

    _graphVector.at( iHistogram )->SetMarkerStyle( 29 );
    _graphVector.at( iHistogram )->Draw( "PSAME" );

}

void Fittino::ContourPlotter::PrintSteeringParameters() const {

}

void Fittino::ContourPlotter::SetClassicStyle() {

    // Pad settings.

    _pad->SetRightMargin( 0.10 );
    _pad->SetLeftMargin( 0.11 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    // Contour settings.

    _contour1SigmaLineStyle = 1;
    //_contour1SigmaLineColor = kBlue - 2;
    //_contour1SigmaFillColor = kBlue - 9;
    _contour1SigmaLineColor = kRed - 2;
    _contour1SigmaFillColor = kRed - 8;

    _contour2SigmaLineStyle = 1;
    _contour2SigmaLineColor = kBlue - 2;
    _contour2SigmaFillColor = kBlue - 10;

    // Legend settings.

    _legendOption = "f";

    if ( _pageFormat == "Square" ) {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.565;
            _legendX2 = 0.855;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.565;
            _legendX2 = 0.855;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }
    else {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.645;
            _legendX2 = 0.865;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.645;
            _legendX2 = 0.865;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }

}

void Fittino::ContourPlotter::SetPeachStyle() {

    // Pad settings.

    _pad->SetRightMargin( 0.15 );
    _pad->SetLeftMargin( 0.11 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    // Palette settings.

    const UInt_t Number = 3;
    Double_t Red[Number]   = { 0.00, 1.00, 1.00 };
    Double_t Green[Number] = { 1.00, 1.00, 0.00 };
    Double_t Blue[Number]  = { 1.00, 0.00, 1.00 };
    Double_t Length[4] = { 0.0, 0.1, 0.6, 1.0 };
    _totalNumberOfContourLevels = 10;
    TColor::CreateGradientColorTable( Number, Length, Red, Green, Blue, _totalNumberOfContourLevels );

    // Contour settings.

    _contour1SigmaLineStyle = 1;
    _contour1SigmaLineColor = kBlack;

    _contour2SigmaLineStyle = 2;
    _contour2SigmaLineColor = kBlack;

    // Legend settings.

    if ( _pageFormat == "Square" ) {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.520;
            _legendX2 = 0.810;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.520;
            _legendX2 = 0.810;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }
    else {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.590;
            _legendX2 = 0.815;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.590;
            _legendX2 = 0.815;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }

    _legendOption = "l";

}

void Fittino::ContourPlotter::SetPlainStyle() {

    // Pad settings.

    _pad->SetRightMargin( 0.10 );
    _pad->SetLeftMargin( 0.11 );
    _pad->SetBottomMargin( 0.12 );
    _pad->SetTopMargin( 0.08 );

    // Contour settings.

    _contour1SigmaLineStyle = 1;
    _contour1SigmaLineColor = kBlack;

    _contour2SigmaLineStyle = 2;
    _contour2SigmaLineColor = kBlack;

    // Legend settings.

    _legendOption = "l";

    if ( _pageFormat == "Square" ) {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.565;
            _legendX2 = 0.855;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.565;
            _legendX2 = 0.855;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.440;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }
    else {

        if ( _legendPosition == "BottomRight" ) {

            _legendX1 = 0.645;
            _legendX2 = 0.865;
            _legendY1 = 0.170;
            _legendY2 = 0.350;

        }
        else if ( _legendPosition == "TopRight" ) {

            _legendX1 = 0.645;
            _legendX2 = 0.865;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }
        else if ( _legendPosition == "BottomLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.170;
            _legendY2 = 0.350;
        }
        else if ( _legendPosition == "TopLeft" ) {

            _legendX1 = 0.150;
            _legendX2 = 0.370;
            _legendY1 = 0.700;
            _legendY2 = 0.880;

        }

    }

}
