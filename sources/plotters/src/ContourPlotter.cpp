/* $Id: ContourPlotter.cpp 1309 2013-04-11 17:26:34Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

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
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "TColor.h"
#include "TGraph.h"
#include "TH2F.h"
#include "TLegend.h"
#include "TROOT.h"
#include "TTree.h"

#include "ContourPlotter.h"
#include "ModelBase.h"
#include "ModelParameterBase.h"
#include "PredictionBase.h"
#include "Quantity.h"

Fittino::ContourPlotter::ContourPlotter( ModelBase* model, std::string& dataFileName )
        : PlotterBase( model, dataFileName ) {

    _name = "contour plotter";

}

Fittino::ContourPlotter::~ContourPlotter() {

}

void Fittino::ContourPlotter::PrintResult() const {

}

void Fittino::ContourPlotter::PrintSteeringParameters() const {

}

void Fittino::ContourPlotter::UpdateModel() {

}

void Fittino::ContourPlotter::Execute() {

    _pad->SetRightMargin(0.15);

    _activeQuantityVector.push_back( "P_M0" );
    _activeQuantityVector.push_back( "P_M12" );

    float chi2, lowestChi2 = 1.e99;
    Int_t bestFitEntry;

    //_tree->SetBranchAddress( "Chi2", &chi2 );
    _tree->SetBranchAddress( "chi2", &chi2 );

    for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

        _tree->GetEntry( iEntry );

        if ( chi2 < lowestChi2 ) {

            lowestChi2   = chi2;
            bestFitEntry = iEntry;

        }

    }

    for ( Int_t iActiveQuantity1 = 0; iActiveQuantity1 < _activeQuantityVector.size(); ++iActiveQuantity1 ) {

        for ( Int_t iActiveQuantity2 = iActiveQuantity1 + 1; iActiveQuantity2 < _activeQuantityVector.size(); ++iActiveQuantity2 ) {

            Int_t iQuantity1 = _leafMap.find( _activeQuantityVector.at( iActiveQuantity1 ) )->second;
            Int_t iQuantity2 = _leafMap.find( _activeQuantityVector.at( iActiveQuantity2 ) )->second;

            // Create a histogram.

            TString histogramName  = _quantityVector.at( iQuantity1 )->GetName() + _quantityVector.at( iQuantity2 )->GetName();
            TString histogramTitle = histogramName;
            Double_t lowerBound1 = _quantityVector.at( iQuantity1 )->GetPlotLowerBound();
            Double_t upperBound1 = _quantityVector.at( iQuantity1 )->GetPlotUpperBound();
            Double_t lowerBound2 = _quantityVector.at( iQuantity2 )->GetPlotLowerBound();
            Double_t upperBound2 = _quantityVector.at( iQuantity2 )->GetPlotUpperBound();

            TH2F histogram = TH2F( histogramName, histogramTitle, 100, lowerBound1, upperBound1, 100, lowerBound2, upperBound2 );

            // Set all bins to 50.

            for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX() + 1; ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX() + 1; ++iBinY ) {

                    histogram.SetBinContent( iBinX, iBinY, 50. );

                }

            }

            for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

                _tree->GetEntry( iEntry );

                if ( ( chi2 - lowestChi2 ) < histogram.GetBinContent( histogram.FindBin( _leafVector[iQuantity1], _leafVector[iQuantity2] ) ) )
                    histogram.SetBinContent( histogram.FindBin( _leafVector[iQuantity1], _leafVector[iQuantity2] ), chi2 - lowestChi2 );

            }

            TH2F* tmpHist = (TH2F*)histogram.Clone();

            for ( Int_t iBinX = 0; iBinX <= tmpHist->ProjectionX()->GetNbinsX(); ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= tmpHist->ProjectionY()->GetNbinsX(); ++iBinY ) {

                    if ( tmpHist->GetBinContent( iBinX, iBinY ) > 10. )
                        tmpHist->SetBinContent( iBinX, iBinY, 0. );

                }

            }

            // Set the best fit value;

            Double_t xBestFitValue[1] = { 0. };
            Double_t yBestFitValue[1] = { 0. };

            _tree->GetEntry( bestFitEntry );
            xBestFitValue[0] = TMath::Abs( _leafVector[iQuantity1] + 1 ) - 1;
            yBestFitValue[0] = TMath::Abs( _leafVector[iQuantity2] + 1 ) - 1;

            TGraph* BestFitValue = new TGraph( 1, xBestFitValue, yBestFitValue );
            BestFitValue->SetMarkerStyle(25);
            BestFitValue->SetMarkerColor( kRed );

            // Set the SM value.

            Double_t xSMValue[1] = { 0. };
            Double_t ySMValue[1] = { 0. };
            TGraph* SMValue = new TGraph( 1, xSMValue, ySMValue );
            SMValue->SetMarkerStyle(20);

            TGraph* dummy = new TGraph();
            dummy->SetMarkerStyle(20);

            TGraph* dummy2 = new TGraph();
            dummy2->SetLineStyle(2);

            TLegend legend = TLegend( 0.52, 0.63, 0.78, 0.86 );
            legend.SetShadowColor(0);
            legend.SetBorderSize(1);
            legend.SetLineColor(0);
            Int_t font = 42; // Helvetica
            Double_t tsize = 0.04;
            legend.SetTextSize(tsize);
            legend.SetTextFont(font);
            legend.SetFillColor(0);
            legend.AddEntry( SMValue, "SM", "p" );
            legend.AddEntry( BestFitValue, "Best Fit Point", "p" );
            legend.AddEntry( dummy, "68 % CL", "l" );
            legend.AddEntry( dummy2, "95 % CL", "l" );

            // Define the color palette.

            const UInt_t Number = 3;
            Double_t Red[Number]    = { 0.00, 1.00, 1.00 };
            Double_t Green[Number]  = { 1.00, 1.00, 0.00 };
            Double_t Blue[Number]   = { 1.00, 0.00, 1.00 };
            Double_t Length[4] = { 0.0, 0.1, 0.6, 1.0 };
            Int_t nb = 10;
            TColor::CreateGradientColorTable(Number,Length,Red,Green,Blue,nb);
            tmpHist->SetContour(nb);

            Double_t levels[2] = { 1., 6. };
       
            tmpHist->GetXaxis()->SetTitle( _quantityVector.at( iQuantity1 )->GetPlotName().c_str() );
            tmpHist->GetYaxis()->SetTitle( _quantityVector.at( iQuantity2 )->GetPlotName().c_str() );
            tmpHist->GetZaxis()->SetTitle( "#Delta#chi^{2}" );
            tmpHist->GetZaxis()->SetRangeUser( 0., 10. );

            histogram.SetContour(2, levels);

            histogram.Draw( "CONT LIST" );
            _canvas.Update();

            TObjArray *contours = (TObjArray*)gROOT->GetListOfSpecials()->FindObject("contours");
            if ( contours ) Int_t ncontours = contours->GetSize();

            TList* list = 0;
            TList* list2 = 0;
            if ( contours ) list = (TList*)contours->At(1);
            if ( contours ) list2 = (TList*)contours->At(0);
            TGraph* gr1 = 0;
            TGraph* gr2 = 0;
            if ( list ) gr1 = (TGraph*)list->First();
            if ( list2 ) gr2 = (TGraph*)list2->First();

            if ( gr1 ) gr1->SetMarkerStyle(20);
            if ( gr1 ) gr1->SetLineStyle(2);
            if ( gr2 ) gr2->SetLineStyle(1);
            if ( gr1 ) gr1->SetMarkerColor(kBlack);
            if ( gr1 ) gr1->SetLineColor(kBlack);
            if ( gr2 ) gr2->SetLineColor(kBlack);
            if ( gr1 ) gr1->Draw("PSAME");

            tmpHist->Draw( "COLZ" );

            TGraph* gc = 0;
            if ( gr1 ) gc = (TGraph*)gr1->Clone();
            if ( gc ) gc->Draw("C");

            TGraph* gc2 = 0;
            if ( gr2 ) gc2 = (TGraph*)gr2->Clone();
            if ( gc2 ) gc2->Draw("C");
            
            SMValue->Draw( "PSAME" );

            BestFitValue->Draw( "PSAME" );

            legend.Draw( "SAME" );

            _canvas.Update();

            TString plotname = _quantityVector.at( iQuantity1 )->GetName() + "Vs" + _quantityVector.at( iQuantity2 )->GetName();
            _canvas.SaveAs( plotname + ".eps", "RECREATE" );

        }

    }

}
