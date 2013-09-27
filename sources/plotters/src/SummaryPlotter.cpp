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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>
#include <map>
#include <vector>

#include "TCanvas.h"
#include "TColor.h"
#include "TGraph.h"
#include "TH2F.h"
#include "TLatex.h"
#include "TLegend.h"
#include "TLine.h"
#include "TMarker.h"
#include "TROOT.h"
#include "TStyle.h"
#include "TTree.h"

#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"
#include "Quantity.h"
#include "SummaryPlotter.h"

Fittino::SummaryPlotter::SummaryPlotter( ModelBase* model, std::string& dataFileName, int randomSeed )
    : PlotterBase( model, dataFileName, randomSeed ) {

    _name = "summary plotter";

    _canvas = new TCanvas( "Canvas", "Canvas", 600, 800 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

    _pad = (TPad*)_canvas->cd();
    _pad->SetTicks( 1, 1 );
    //_pad->SetTopMargin( 0.03 );
    _pad->SetTopMargin( 0.14 );
    //_pad->SetRightMargin( 0.42 );
    _pad->SetRightMargin( 0.40 );
    _pad->SetLeftMargin( 0.05 );

    gStyle->SetNdivisions( 0, "Y" );

    _smValue = 0.;
    //_smValue = 1.;

}

Fittino::SummaryPlotter::~SummaryPlotter() {

}

void Fittino::SummaryPlotter::PrintResult() const {

}

void Fittino::SummaryPlotter::PrintSteeringParameters() const {

}

void Fittino::SummaryPlotter::UpdateModel() {

}

void Fittino::SummaryPlotter::Execute() {

    //_activeQuantityVector.push_back( "Mass_h" );
    //_activeQuantityVector.push_back( "Delta_quarks_s_hdd" );
    _activeQuantityVector.push_back( "Delta_s_hbb" );
    //_activeQuantityVector.push_back( "Delta_quarks_s_huu" );
    _activeQuantityVector.push_back( "Delta_s_hcc" );
    _activeQuantityVector.push_back( "Delta_s_htt" );
    //_activeQuantityVector.push_back( "Delta_leptons_s_hdd" );
    _activeQuantityVector.push_back( "Delta_s_htautau" );
    //_activeQuantityVector.push_back( "Delta_Bosons_hWZ" );
    _activeQuantityVector.push_back( "Delta_hWW" );
    _activeQuantityVector.push_back( "Delta_hZZ" );
    _activeQuantityVector.push_back( "Delta_hgammagamma" );
    _activeQuantityVector.push_back( "Delta_hgg" );
    //_activeQuantityVector.push_back( "Gamma_hInvisible" );

    //_activeQuantityVector.push_back( "Gamma_hTotal" );

    //_activeQuantityVector.push_back( "BR_s_hbb" );
    //_activeQuantityVector.push_back( "BR_s_htautau" );
    //_activeQuantityVector.push_back( "BR_hWW" );
    //_activeQuantityVector.push_back( "BR_hZZ" );
    //_activeQuantityVector.push_back( "BR_hgg" );
    //_activeQuantityVector.push_back( "BR_hgammagamma" );
    //_activeQuantityVector.push_back( "BR_hInvisible" );
    //_activeQuantityVector.push_back( "BR_SM_s_hbb" );
    //_activeQuantityVector.push_back( "BR_SM_s_htautau" );
    //_activeQuantityVector.push_back( "BR_SM_hWW" );
    //_activeQuantityVector.push_back( "BR_SM_hZZ" );
    //_activeQuantityVector.push_back( "BR_SM_hgg" );
    //_activeQuantityVector.push_back( "BR_SM_hgammagamma" );

    //_activeQuantityVector.push_back( "Mu_hWWlnulnu_ATL" );
    //_activeQuantityVector.push_back( "Mu_VBFWWlnulnu_ATL" );
    //_activeQuantityVector.push_back( "Mu_hZZ4l_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_1lep_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_ETmiss_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_conv_central_highPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_conv_central_lowPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_conv_rest_highPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_conv_rest_lowPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_conv_trans_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_highmass2jetloose_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_highmass2jettight_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_lowmass2jet_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_unconv_central_highPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_unconv_central_lowPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_unconv_rest_highPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_hgammgamma_unconv_rest_lowPTt_ATL" );
    //_activeQuantityVector.push_back( "Mu_htautau_ATL" );
    //_activeQuantityVector.push_back( "Mu_VhVbb_ATL" );
    //_activeQuantityVector.push_back( "Mu_hWW_CDF" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_CDF" );
    //_activeQuantityVector.push_back( "Mu_htautau_CDF" );
    //_activeQuantityVector.push_back( "Mu_VhVbb_CDF" );
    //_activeQuantityVector.push_back( "Mu_tthttbb_CDF" );
    //_activeQuantityVector.push_back( "Mu_hWW_01jet_CMS" );
    //_activeQuantityVector.push_back( "Mu_hZZ4l_01jet_CMS" );
    //_activeQuantityVector.push_back( "Mu_hZZ4l_2jet_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_2jetloose_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_2jettight_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_2jet_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_ETmiss_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_e_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_inclusive_CMS" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_mu_CMS" );
    //_activeQuantityVector.push_back( "Mu_htautau_01jet_CMS" );
    //_activeQuantityVector.push_back( "Mu_VBFWW_CMS" );
    //_activeQuantityVector.push_back( "Mu_VBFtautau_CMS" );
    //_activeQuantityVector.push_back( "Mu_VhVbb_CMS" );
    //_activeQuantityVector.push_back( "Mu_VhVtautau_CMS" );
    //_activeQuantityVector.push_back( "Mu_WhWWW_CMS" );
    //_activeQuantityVector.push_back( "Mu_tthttbb_CMS" );
    //_activeQuantityVector.push_back( "Mu_hbb_D0" );
    //_activeQuantityVector.push_back( "Mu_hgammagamma_D0" );
    //_activeQuantityVector.push_back( "Mu_htautau_D0" );
    //_activeQuantityVector.push_back( "Mu_hWW_D0" );

    //_activeQuantityVector.push_back( "R_htautau" );
    //_activeQuantityVector.push_back( "R_hbb" );
    //_activeQuantityVector.push_back( "R_Vhbb" );
    //_activeQuantityVector.push_back( "R_hWW" );
    //_activeQuantityVector.push_back( "R_hZZ" );
    //_activeQuantityVector.push_back( "R_hgammagamma" );

    float chi2, lowestChi2 = 1.e99;
    Int_t bestFitEntry;

    _tree->SetBranchAddress( "Chi2", &chi2 );

    for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

        _tree->GetEntry( iEntry );

        if ( chi2 < lowestChi2 ) {

            lowestChi2   = chi2;
            bestFitEntry = iEntry;

        }

    }

    // Set the histogram settings.

    TString histogramName  = "SummaryHistogram";
    TString histogramTitle = histogramName;
    Double_t xLowerBound =  _smValue - 1.;
    Double_t xUpperBound =  6.;
    //Double_t xUpperBound =  21.;
    //Double_t xUpperBound =  12.;
    Double_t yLowerBound =  0.;
    Double_t yUpperBound =  2 * _activeQuantityVector.size() + 1;

    TH2F histogram = TH2F( histogramName, histogramTitle, 35, xLowerBound, xUpperBound, yUpperBound, yLowerBound, yUpperBound );
    //histogram.GetXaxis()->SetTitle( "Best fit #hat{#mu}" );
    histogram.GetXaxis()->SetTitle( "Best fit value" );
    //histogram.GetXaxis()->SetTitle( "Best fit value / SM value" );
    histogram.GetZaxis()->SetRangeUser( 0., 1. );

    TH2F histogram2 = TH2F( "SummaryHistogram1Sigma", "SummaryHistogram1Sigma", 35, xLowerBound, xUpperBound, yUpperBound, yLowerBound, yUpperBound );

    // All bins to 50.

    for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX() + 1; ++iBinX ) {

        for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX() + 1; ++iBinY ) {

            ///histogram.SetBinContent( iBinX, iBinY, 50. );
            histogram.SetBinContent( iBinX, iBinY, 9. );

        }

    }

    const char* axisNames[_activeQuantityVector.size()];

    Double_t xBestFitValue[_activeQuantityVector.size()];
    Double_t yBestFitValue[_activeQuantityVector.size()];

    for ( Int_t iActiveQuantity = 0; iActiveQuantity < _activeQuantityVector.size(); ++iActiveQuantity ) {

        Int_t iQuantity = _leafMap.find( _activeQuantityVector.at( iActiveQuantity ) )->second;

        axisNames[_activeQuantityVector.size() - iActiveQuantity - 1] = ( _quantityVector.at( iQuantity )->GetPlotName() ).c_str();

        std::cout << _activeQuantityVector.size() - iActiveQuantity - 1 << " " << axisNames[_activeQuantityVector.size() - iActiveQuantity - 1] << std::endl;
        //std::cout << iActiveQuantity << std::endl;

        for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

            _tree->GetEntry( iEntry );

            if ( ( chi2 - lowestChi2 ) <= 4. &&  ( chi2 - lowestChi2 ) > 1.) {

                histogram.SetBinContent( histogram.ProjectionX()->FindBin( _leafVector[iQuantity] ), 2 * ( _activeQuantityVector.size() - iActiveQuantity ), 0.8 );

            }
            else if ( ( chi2 - lowestChi2 ) <= 1. ) {

                histogram2.SetBinContent( histogram.ProjectionX()->FindBin( _leafVector[iQuantity] ), 2 * ( _activeQuantityVector.size() - iActiveQuantity ), 0.5 );
            }

        }

        _tree->GetEntry( bestFitEntry );
        xBestFitValue[iActiveQuantity] = TMath::Abs( _leafVector[iQuantity] + 1 ) - 1;
        yBestFitValue[iActiveQuantity] = 2 * ( _activeQuantityVector.size() - iActiveQuantity ) - 0.5;
 
    }

    // Set all other bins to zero.

    for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX(); ++iBinX ) {

        for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX(); ++iBinY ) {

            if ( histogram.GetBinContent( iBinX, iBinY ) > 4. )
                histogram.SetBinContent( iBinX, iBinY, 0. );

        }

    }

    // Create set of markers for the best fit values.

    TGraph* BestFitValue = new TGraph( _activeQuantityVector.size(), xBestFitValue, yBestFitValue );
    BestFitValue->SetMarkerStyle( 21 );
    BestFitValue->SetMarkerSize( 2. );
    //BestFitValue->SetMarkerSize( 0.6 );
    BestFitValue->SetMarkerColor( 10 );

    TGraph* BestFitValue2 = (TGraph*)BestFitValue->Clone();
    BestFitValue2->SetMarkerStyle( 25 );
    BestFitValue2->SetMarkerSize( 2. );
    //BestFitValue2->SetMarkerSize( 0.6 );
    BestFitValue2->SetMarkerColor( kRed );

    // Create color palette.

    //const UInt_t Number = 2;
    //Double_t Red[Number]    = { 0.00, 1.00 };
    //Double_t Green[Number]  = { 0.00, 1.00 };
    //Double_t Blue[Number]   = { 1.00, 1.00 };
    //Double_t Length[3] = { 0.0, 0.5, 1.0 };
    //Int_t nb = 50;
    //TColor::CreateGradientColorTable( Number, Length, Red, Green, Blue, nb );

    histogram2.SetFillColor( TColor::GetColorPalette( 99 ) );
    histogram2.SetLineColor( TColor::GetColorPalette( 99 ) );

    histogram.SetFillColor( TColor::GetColorPalette( 92 ) );
    histogram.SetLineColor( TColor::GetColorPalette( 92 ) );

    // Draw the histogram.

    histogram.Draw( "AXIS" );

    // Draw labels along the y-axis.

    Float_t x, y;
    x = xUpperBound + xUpperBound / 100. * ( 10. / 3. );

    TLatex text;
    text.SetTextAlign( 12 );
    //text.SetTextSize( 0.02 );
    text.SetTextAngle( 0 );

    for ( int iLabel = 0; iLabel < _activeQuantityVector.size(); ++iLabel ) {
        
        std::cout << iLabel << " " << axisNames[iLabel] << std::endl;

        y = histogram.GetYaxis()->GetBinCenter( 2 * ( iLabel + 1 ) );
        text.DrawLatex( x, y, axisNames[iLabel] );

    }

    //TLatex text2;
    ////text2.DrawLatex( 0.01, gPad->GetUymax(), "Fittino 2.0" );
    //text2.SetTextFont( 82 );
    //text2.SetTextSize( 0.03 );
    //text2.DrawLatex( -1., 20., "Fittino 2.0" );

    //TLatex text3;
    ////text2.DrawLatex( 0.01, gPad->GetUymax(), "Fittino 2.0" );
    //text3.SetTextFont( 82 );
    //text3.SetTextSize( 0.03 );
    //text3.DrawLatex( -1., 19.5, "HiggsSignals 4.0.0" );

    // Draw a vertical line to indicate the SM expectation.

    TLine line;
    line.SetLineStyle( 2 ); // dashed line
    line.DrawLine( _smValue, 0., _smValue, yUpperBound );

    TMarker BestFitValueMarker;
    BestFitValueMarker.SetMarkerStyle( 25 );
    BestFitValueMarker.SetMarkerSize( 1.4 );
    BestFitValueMarker.SetMarkerColor( kRed );

    TLegend legend = TLegend( 0.05, 0.88, 0.32, 0.97 );
    legend.SetShadowColor(0);
    legend.SetBorderSize(1);
    legend.SetLineColor(0);
    Int_t font = 42; // Helvetica
    Double_t tsize = 0.04;
    legend.SetTextSize(tsize);
    legend.SetTextFont(font);
    legend.SetFillColor(0);
    legend.AddEntry( &BestFitValueMarker, "Best fit value", "p" );
    legend.AddEntry( &line, "SM expectation", "l" );

    TLegend legend2 = TLegend( 0.42, 0.88, 0.69, 0.97 );
    legend2.SetShadowColor(0);
    legend2.SetBorderSize(1);
    legend2.SetLineColor(0);
    legend2.SetTextSize(tsize);
    legend2.SetTextFont(font);
    legend2.SetFillColor(0);
    legend2.AddEntry( &histogram2, "68 % CL", "f" );
    legend2.AddEntry( &histogram, "95 % CL", "f" );

    histogram.Draw( "COLSAME" );
    histogram2.Draw( "COLSAME" );

    // Draw the best fit value.

    BestFitValue->Draw( "PSAME" );
    BestFitValue2->Draw( "PSAME" );

    legend.Draw();
    legend2.Draw();

    histogram.Draw( "AXISSAME" );

    _canvas->Update();

    TString plotname = "SummaryPlot";
    _canvas->SaveAs( plotname + ".eps", "RECREATE" );

}
