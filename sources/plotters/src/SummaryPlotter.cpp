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

#include "TColor.h"
#include "TGraph.h"
#include "TH2F.h"
#include "TLatex.h"
#include "TLegend.h"
#include "TLine.h"
#include "TROOT.h"
#include "TTree.h"
#include "TStyle.h"

#include "SummaryPlotter.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"
#include "Quantity.h"

Fittino::SummaryPlotter::SummaryPlotter( ModelBase* model, std::string& dataFileName )
        : PlotterBase( model, dataFileName ) {

    _name = "summary plotter";

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

    _pad->SetTopMargin(0.03);
    _pad->SetRightMargin(0.42);
    _pad->SetLeftMargin(0.05);

    //gStyle->SetNdivisions(5000, "Y");
    gStyle->SetNdivisions(0, "Y");

    //_activeQuantityVector.push_back( "P_M0" );
    //_activeQuantityVector.push_back( "P_M12" );

    //_activeQuantityVector.push_back( "Mass_h" );
    ////_activeQuantityVector.push_back( "Delta_quarks_s_hdd" );
    //_activeQuantityVector.push_back( "Delta_s_hbb" );
    ////_activeQuantityVector.push_back( "Delta_quarks_s_huu" );
    //_activeQuantityVector.push_back( "Delta_s_hcc" );
    //_activeQuantityVector.push_back( "Delta_s_htt" );
    ////_activeQuantityVector.push_back( "Delta_leptons_s_hdd" );
    //_activeQuantityVector.push_back( "Delta_s_htautau" );
    //_activeQuantityVector.push_back( "Delta_hWW" );
    //_activeQuantityVector.push_back( "Delta_hZZ" );
    //_activeQuantityVector.push_back( "Delta_hgammagamma" );
    //_activeQuantityVector.push_back( "Delta_hgg" );
    //_activeQuantityVector.push_back( "Gamma_hInvisible" );

    ////_activeQuantityVector.push_back( "Gamma_hTotal" );

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

    _activeQuantityVector.push_back( "Mu_hWWlnulnu_ATL" );
    _activeQuantityVector.push_back( "Mu_VBFWWlnulnu_ATL" );
    _activeQuantityVector.push_back( "Mu_hZZ4l_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_1lep_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_ETmiss_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_conv_central_highPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_conv_central_lowPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_conv_rest_highPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_conv_rest_lowPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_conv_trans_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_highmass2jetloose_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_highmass2jettight_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_lowmass2jet_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_unconv_central_highPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_unconv_central_lowPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_unconv_rest_highPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_hgammgamma_unconv_rest_lowPTt_ATL" );
    _activeQuantityVector.push_back( "Mu_htautau_ATL" );
    _activeQuantityVector.push_back( "Mu_VhVbb_ATL" );
    _activeQuantityVector.push_back( "Mu_hWW_CDF" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_CDF" );
    _activeQuantityVector.push_back( "Mu_htautau_CDF" );
    _activeQuantityVector.push_back( "Mu_VhVbb_CDF" );
    _activeQuantityVector.push_back( "Mu_tthttbb_CDF" );
    _activeQuantityVector.push_back( "Mu_hWW_01jet_CMS" );
    _activeQuantityVector.push_back( "Mu_hZZ4l_01jet_CMS" );
    _activeQuantityVector.push_back( "Mu_hZZ4l_2jet_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_2jetloose_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_2jettight_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_2jet_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_ETmiss_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_e_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_inclusive_CMS" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_mu_CMS" );
    _activeQuantityVector.push_back( "Mu_htautau_01jet_CMS" );
    _activeQuantityVector.push_back( "Mu_VBFWW_CMS" );
    _activeQuantityVector.push_back( "Mu_VBFtautau_CMS" );
    _activeQuantityVector.push_back( "Mu_VhVbb_CMS" );
    _activeQuantityVector.push_back( "Mu_VhVtautau_CMS" );
    _activeQuantityVector.push_back( "Mu_WhWWW_CMS" );
    _activeQuantityVector.push_back( "Mu_tthttbb_CMS" );
    _activeQuantityVector.push_back( "Mu_hbb_D0" );
    _activeQuantityVector.push_back( "Mu_hgammagamma_D0" );
    _activeQuantityVector.push_back( "Mu_htautau_D0" );
    _activeQuantityVector.push_back( "Mu_hWW_D0" );

    //_activeQuantityVector.push_back( "R_htautau" );
    //_activeQuantityVector.push_back( "R_hbb" );
    //_activeQuantityVector.push_back( "R_Vhbb" );
    //_activeQuantityVector.push_back( "R_hWW" );
    //_activeQuantityVector.push_back( "R_hZZ" );
    //_activeQuantityVector.push_back( "R_hgammagamma" );

    const char* axisNames[_activeQuantityVector.size()];

    float chi2, lowestChi2 = 1.e99;
    Int_t bestFitEntry;

    _tree->SetBranchAddress( "Chi2", &chi2 );
    //_tree->SetBranchAddress( "chi2", &chi2 );

    for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

        _tree->GetEntry( iEntry );

        if ( chi2 < lowestChi2 ) {

            lowestChi2   = chi2;
            bestFitEntry = iEntry;

        }

    }

    Double_t xBestFitValue[_activeQuantityVector.size()];
    Double_t yBestFitValue[_activeQuantityVector.size()];

    TString histogramName  = "SummaryHistogram";
    TString histogramTitle = histogramName;
    Double_t lowerBound1 =  0.;
    Double_t upperBound1 =  6.;
    Double_t lowerBound2 =  0.;
    Double_t upperBound2 =  2 * _activeQuantityVector.size() + 1;

    // All bins to 50.

    TH2F histogram = TH2F( histogramName, histogramTitle, 40, lowerBound1, upperBound1, upperBound2, lowerBound2, upperBound2 );

    for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX() + 1; ++iBinX ) {

        for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX() + 1; ++iBinY ) {

            ///histogram.SetBinContent( iBinX, iBinY, 50. );
            histogram.SetBinContent( iBinX, iBinY, 9. );

        }

    }

    for ( Int_t iActiveQuantity = 0; iActiveQuantity < _activeQuantityVector.size(); ++iActiveQuantity ) {

        Int_t iQuantity = _leafMap.find( _activeQuantityVector.at( iActiveQuantity ) )->second;

        axisNames[_activeQuantityVector.size() - iActiveQuantity - 1] = ( _quantityVector.at( iQuantity )->GetPlotName() ).c_str();

        //std::cout << iActiveQuantity << std::endl;

        for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

            _tree->GetEntry( iEntry );

            if ( ( chi2 - lowestChi2 ) <  histogram.GetBinContent( histogram.ProjectionX()->FindBin( _leafVector[iQuantity] ), 2 * ( _activeQuantityVector.size() - iActiveQuantity ) ) ) {

                if ( ( chi2 - lowestChi2 ) <= 4. &&  ( chi2 - lowestChi2 ) > 1.) {

                    histogram.SetBinContent( histogram.ProjectionX()->FindBin( _leafVector[iQuantity] ), 2 * ( _activeQuantityVector.size() - iActiveQuantity ), 3.5 );
                
                }
                else if ( ( chi2 - lowestChi2 ) <= 1. ) {

                    histogram.SetBinContent( histogram.ProjectionX()->FindBin( _leafVector[iQuantity] ), 2 * ( _activeQuantityVector.size() - iActiveQuantity ), 0.5 );
                }


            }

        }

        _tree->GetEntry( bestFitEntry );
        xBestFitValue[iActiveQuantity] = _leafVector[iQuantity];
        yBestFitValue[iActiveQuantity] = 2 * ( _activeQuantityVector.size() - iActiveQuantity ) - 0.5;
   
        //Double_t xSMValue[1] = { 0. };
        //Double_t ySMValue[1] = { 0. };
        ////Double_t xSMValue[1] = { 1. };
        ////Double_t ySMValue[1] = { 1. };
        //TGraph* SMValue = new TGraph( 1, xSMValue, ySMValue );
        //SMValue->SetMarkerStyle(20);


        //TGraph* dummy = new TGraph();
        //dummy->SetMarkerStyle(20);

        //TGraph* dummy2 = new TGraph();
        //dummy2->SetLineStyle(2);

    }

    TGraph* BestFitValue = new TGraph( _activeQuantityVector.size(), xBestFitValue, yBestFitValue );
    BestFitValue->SetMarkerStyle(20);
    BestFitValue->SetMarkerSize(0.5);
    //BestFitValue->SetMarkerColor( 10 );
    BestFitValue->SetMarkerColor( kYellow );
    TGraph* BestFitValue2 = (TGraph*)BestFitValue->Clone();
    BestFitValue2->SetMarkerStyle(24);
    BestFitValue2->SetMarkerSize(0.5);
    //BestFitValue2->SetMarkerColor( kBlack );
    BestFitValue2->SetMarkerColor( kRed );

    const UInt_t Number = 2;
    Double_t Red[Number]    = { 0.00, 1.00 };
    Double_t Green[Number]  = { 0.00, 1.00 };
    Double_t Blue[Number]   = { 1.00, 1.00 };
    Double_t Length[3] = { 0.0, 0.5, 1.0 };
    Int_t nb = 10;
    TColor::CreateGradientColorTable(Number,Length,Red,Green,Blue,nb);

    //Double_t levels[2] = { 1., 6. };
 

    for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX(); ++iBinX ) {

        for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX(); ++iBinY ) {

            if ( histogram.GetBinContent( iBinX, iBinY ) > 4. )
                histogram.SetBinContent( iBinX, iBinY, 0. );

        }

    }

    histogram.GetXaxis()->SetTitle( "Best fit #hat{#mu}" );
    //histogram.GetXaxis()->SetTitle( "Best fit value" );
    //histogram.GetYaxis()->SetTitle( "Quantity ");
    //histogram.GetZaxis()->SetTitle( "#Delta#chi^{2}" );
    histogram.GetZaxis()->SetRangeUser( 0., 4. );

    histogram.Draw( "AXIS" );

    // draw labels along X
    Float_t x, y;
    TLatex t;
    //x = gPad->GetUxmax(); //+ 0.1 * histogram.GetXaxis()->GetBinWidth( 1 );
    x = 6.2; //+ 0.1 * histogram.GetXaxis()->GetBinWidth( 1 );
    t.SetTextAlign(12);
    t.SetTextSize(0.02);
    t.SetTextAngle(0);
    for (int i=0;i<_activeQuantityVector.size();i++) {
       y = histogram.GetYaxis()->GetBinCenter(2*(i+1));
       t.DrawLatex(x,y,axisNames[i]);
    }

    TLine line;
    line.DrawLine( 1., 0., 1., upperBound2 );

    histogram.Draw( "COLSAME" );

    //SMValue->Draw( "PSAME" );

    BestFitValue->Draw( "PSAME" );
    BestFitValue2->Draw( "PSAME" );

    histogram.Draw( "AXISSAME" );

    _canvas.Update();

    TString plotname = "SummaryPlot"; 
    _canvas.SaveAs( plotname + ".eps", "RECREATE" );

}
