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

#include "TCanvas.h"
#include "TColor.h"
#include "TGraph.h"
#include "TH2F.h"
#include "TLegend.h"
#include "TMath.h"
#include "TROOT.h"
#include "TStyle.h"
#include "TTree.h"

#include "ContourPlotter.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::ContourPlotter::ContourPlotter( ModelBase* model, const boost::property_tree::ptree& ptree )
    : PlotterBase( model, ptree ) {

    _name = "contour plotter";
    _logX = false;
    _logY = true;

    _canvas = new TCanvas( "Canvas", "Canvas", 600, 600 );

    gROOT->SetStyle( "FITTINO" );
    gROOT->ForceStyle();

    _pad = ( TPad* )_canvas->cd();
    _pad->SetTicks( 1, 1 );
    _pad->SetRightMargin( 0.15 );

}

Fittino::ContourPlotter::~ContourPlotter() {

}

void Fittino::ContourPlotter::Execute() {

    Int_t font = 42; // Helvetica
    Double_t tsize = 0.04;
    _pad->SetLeftMargin( 0.15 );
    _pad->SetBottomMargin( 0.15 );

    ////_activeQuantityVector.push_back( "Mass_h" );
    ////_activeQuantityVector.push_back( "Delta_quarks_s_hdd" );
    _activeQuantityVector.push_back( "Delta_s_hbb" );
    ////_activeQuantityVector.push_back( "Delta_quarks_s_huu" );
    //_activeQuantityVector.push_back( "Delta_s_hcc" );
    _activeQuantityVector.push_back( "Delta_s_htt" );
    ////_activeQuantityVector.push_back( "Delta_leptons_s_hdd" );
    _activeQuantityVector.push_back( "Delta_s_htautau" );
    _activeQuantityVector.push_back( "Delta_hWW" );
    _activeQuantityVector.push_back( "Delta_hZZ" );
    ////_activeQuantityVector.push_back( "Delta_Bosons_hWZ" );
    _activeQuantityVector.push_back( "Delta_hgammagamma" );
    _activeQuantityVector.push_back( "Delta_hgg" );
    _activeQuantityVector.push_back( "Gamma_hInvisible" );

    // _activeQuantityVector.push_back( "O_massNeutralino1" );
    // _activeQuantityVector.push_back( "af_direct" );

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

    for ( Int_t iActiveQuantity1 = 0; iActiveQuantity1 < _activeQuantityVector.size(); ++iActiveQuantity1 ) {

        for ( Int_t iActiveQuantity2 = iActiveQuantity1 + 1; iActiveQuantity2 < _activeQuantityVector.size(); ++iActiveQuantity2 ) {

            Int_t iQuantity1 = _leafMap.find( _activeQuantityVector.at( iActiveQuantity1 ) )->second;
            Int_t iQuantity2 = _leafMap.find( _activeQuantityVector.at( iActiveQuantity2 ) )->second;

            // x axis

            Double_t lowerBound1 = _quantityVector.at( iQuantity1 )->GetLowerBound();
            Double_t upperBound1 = _quantityVector.at( iQuantity1 )->GetUpperBound();

            if ( _logX ) {

                if ( _quantityVector.at( iQuantity1 )->GetLowerBound() > 0. ) {

                    lowerBound1 = TMath::Log10( lowerBound1 );
                    upperBound1 = TMath::Log10( upperBound1 );

                }

            }

            int nxBins = 100;

            double xbins[nxBins + 1];

            for ( unsigned int iBin = 0; iBin < nxBins + 1; iBin++ ) {

                xbins[iBin] = lowerBound1 + iBin * ( upperBound1 - lowerBound1 ) / double( nxBins );

                if ( _logX ) {

                    if ( _quantityVector.at( iQuantity1 )->GetLowerBound() > 0. ) {

                        xbins[iBin] = TMath::Power( 10, xbins[iBin] );

                    }

                }

            }

            // y axis

            Double_t lowerBound2 = _quantityVector.at( iQuantity2 )->GetLowerBound();
            Double_t upperBound2 = _quantityVector.at( iQuantity2 )->GetUpperBound();

            if ( _logY ) {

                if ( _quantityVector.at( iQuantity2 )->GetLowerBound() > 0. ) {

                    lowerBound2 = TMath::Log10( lowerBound2 );
                    upperBound2 = TMath::Log10( upperBound2 );

                }

            }

            int nyBins = 100;

            double ybins[nyBins + 1];

            for ( unsigned int iBin = 0; iBin < nyBins + 1; iBin++ ) {

                ybins[iBin] = lowerBound2 + iBin * ( upperBound2 - lowerBound2 ) / double( nyBins );

                if ( _logY ) {

                    if ( _quantityVector.at( iQuantity2 )->GetLowerBound() > 0. ) {

                        ybins[iBin] = TMath::Power( 10, ybins[iBin] );

                    }

                }

            }

            // Create a histogram.

            TString histogramName = _quantityVector.at( iQuantity1 )->GetName() + _quantityVector.at( iQuantity2 )->GetName();
            TString histogramTitle = histogramName;
            TH2F histogram = TH2F( histogramName, histogramTitle, nxBins, xbins, nyBins , ybins );

            // Set all bins to 50.

            for ( Int_t iBinX = 0; iBinX <= histogram.ProjectionX()->GetNbinsX() + 1; ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= histogram.ProjectionY()->GetNbinsX() + 1; ++iBinY ) {

                    histogram.SetBinContent( iBinX, iBinY, 50. );

                }

            }

            for ( Int_t iEntry = 0; iEntry < _tree->GetEntries(); ++iEntry ) {

                _tree->GetEntry( iEntry );

                if ( ( chi2 - lowestChi2 ) < histogram.GetBinContent( histogram.FindBin( TMath::Abs( _leafVector[iQuantity1] + 1 ) - 1, TMath::Abs( _leafVector[iQuantity2] + 1 ) - 1 ) ) )
                    histogram.SetBinContent( histogram.FindBin( TMath::Abs( _leafVector[iQuantity1] + 1 ) - 1, TMath::Abs( _leafVector[iQuantity2] + 1 ) - 1 ), chi2 - lowestChi2 );

            }

            TH2F* tmpHist = ( TH2F* )histogram.Clone();

            tmpHist->GetXaxis()->SetTitleOffset( 1.40 );
            tmpHist->GetYaxis()->SetTitleOffset( 1.35 );

            for ( Int_t iBinX = 0; iBinX <= tmpHist->ProjectionX()->GetNbinsX(); ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= tmpHist->ProjectionY()->GetNbinsX(); ++iBinY ) {

                    if ( tmpHist->GetBinContent( iBinX, iBinY ) > 10. )
                        tmpHist->SetBinContent( iBinX, iBinY, 0. );

                }

            }

            Double_t xBestFitValue[1] = { 0. };
            Double_t yBestFitValue[1] = { 0. };

            _tree->GetEntry( bestFitEntry );
            xBestFitValue[0] = TMath::Abs( _leafVector[iQuantity1] + 1 ) - 1;
            yBestFitValue[0] = TMath::Abs( _leafVector[iQuantity2] + 1 ) - 1;

            TGraph* BestFitValue = new TGraph( 1, xBestFitValue, yBestFitValue );
            BestFitValue->SetMarkerStyle( 29 ); // star: 25
            BestFitValue->SetMarkerColor( kRed ); // kBlack

            // Set the SM value.

            Double_t xSMValue[1] = { 0. };
            Double_t ySMValue[1] = { 0. };
            TGraph* SMValue = new TGraph( 1, xSMValue, ySMValue );
            SMValue->SetMarkerStyle( 20 );

            //TGraph* BestFitValue = new TGraph( 1, xBestFitValue, yBestFitValue );
            //BestFitValue->SetMarkerStyle(25);
            //BestFitValue->SetMarkerColor( kRed );

            TGraph* dummy = new TGraph();
            dummy->SetMarkerStyle( 20 );

            TGraph* dummy2 = new TGraph();
            dummy2->SetLineStyle( 2 );

            TLegend legend = TLegend( 0.52, 0.63, 0.78, 0.86 );
            // astro:  TLegend legend = TLegend( 0.52, 0.63, 0.78, 0.86 );

            legend.SetShadowColor( 0 );
            legend.SetBorderSize( 1 );
            legend.SetLineColor( 0 );
            legend.SetTextSize( tsize );
            legend.SetTextFont( font );
            legend.SetFillColor( 0 );
            legend.AddEntry( SMValue, "SM", "p" );
            legend.AddEntry( BestFitValue, "Best Fit Point", "p" );
            legend.AddEntry( dummy, "1D 68 % CL", "l" );
            legend.AddEntry( dummy2, "2D 95 % CL", "l" );

            const UInt_t Number = 3;
            Double_t Red[Number]    = { 0.00, 1.00, 1.00 };
            Double_t Green[Number]  = { 1.00, 1.00, 0.00 };
            Double_t Blue[Number]   = { 1.00, 0.00, 1.00 };
            Double_t Length[4] = { 0.0, 0.1, 0.6, 1.0 };
            Int_t nb = 10;
            TColor::CreateGradientColorTable( Number, Length, Red, Green, Blue, nb );
            tmpHist->SetContour( nb );

            // different color palette for z axis range from 0 to 6
            // const UInt_t Number = 2;
            // Double_t Red[Number]    = { 0.00, 1.00 };
            // Double_t Green[Number]  = { 1.00, 1.00};
            // Double_t Blue[Number]   = { 1.00, 0.00 };
            // Double_t Length[3] = { 0.0, 1./6., 1. };
            // Int_t nb = 36;
            // TColor::CreateGradientColorTable(Number,Length,Red,Green,Blue,nb);
            // tmpHist->SetContour(nb);

            Double_t levels[2] = { 1., 6. };

            tmpHist->GetXaxis()->SetTitle( _quantityVector.at( iQuantity1 )->GetPlotName().c_str() );
            tmpHist->GetYaxis()->SetTitle( _quantityVector.at( iQuantity2 )->GetPlotName().c_str() );
            tmpHist->GetZaxis()->SetTitle( "#Delta#chi^{2}" );
            tmpHist->GetZaxis()->SetRangeUser( 0., 10. );
            // tmpHist->GetZaxis()->SetRangeUser( 0., 6. );

            histogram.SetContour( 2, levels );

            histogram.Draw( "CONT LIST" );
            _canvas->Update();

            TObjArray *contours = ( TObjArray* )gROOT->GetListOfSpecials()->FindObject( "contours" );
            if ( contours ) Int_t ncontours = contours->GetSize();

            TList* list = 0;
            TList* list2 = 0;

            if ( contours ) list = ( TList* )contours->At( 1 );
            if ( contours ) list2 = ( TList* )contours->At( 0 );

            tmpHist->Draw( "COLZ" );

            TGraph* gr1 = 0;
            TGraph* gr2 = 0;

            if ( list ) {

                int nGraphsPerContour = list->GetSize();

                for ( int iGraph = 0; iGraph < nGraphsPerContour; iGraph++ ) {

                    TGraph* gr1 = ( TGraph* ) list->At( iGraph );

                    if ( gr1 ) gr1->SetMarkerStyle( 20 );
                    if ( gr1 ) gr1->SetLineStyle( 2 );
                    if ( gr1 ) gr1->SetMarkerColor( kBlack );
                    if ( gr1 ) gr1->SetLineColor( kBlack );
                    if ( gr1 ) gr1->Draw( "C" );

                }

            }

            if ( list2 ) {

                int nGraphsPerContour = list2->GetSize();

                for ( int iGraph = 0; iGraph < nGraphsPerContour; iGraph++ ) {

                    TGraph* gr2 = ( TGraph* ) list2->At( iGraph );

                    if ( gr2 ) gr2->SetLineColor( kBlack );
                    if ( gr2 ) gr2->SetLineStyle( 1 );
                    if ( gr2 ) gr2->Draw( "C" );

                }

            }

            SMValue->Draw( "PSAME" );

            BestFitValue->Draw( "PSAME" );

            // 	    TGraph graph("dd_xenon100_2012.dat");
            // 	    graph.Draw("C");
            // 	    graph.SetLineColor(kBlue);
            //      TGraph graph2("xenon1t.txt");
            // 	    graph2.SetLineColor(kRed);
            // 	    double x,y;
            //      for(unsigned int ip=0; ip<graph2.GetN(); ip++){
            //      graph2.GetPoint(ip, x, y);
            //      graph2.SetPoint(ip, x,1.e36*y);
            // 	    }
            //      graph2.Draw("C");
            //      legend.AddEntry( &graph, "Xenon100 (2012)", "l" );
            //      legend.AddEntry( &graph2, "Xenon1T  (2017)", "l" );

            legend.Draw( "SAME" );

            if ( _logX ) {

                if ( _quantityVector.at( iQuantity1 )->GetLowerBound() > 0. ) _canvas->SetLogx();
                else _canvas->SetLogx( 0 );

            }

            if ( _logY ) {

                if ( _quantityVector.at( iQuantity2 )->GetLowerBound() > 0. ) {

                    std::cout << "set logscale" << std::endl;
                    _canvas->SetLogy();

                }

                else _canvas->SetLogy( 0 );

            }

            _canvas->Update();

            TString plotname = _quantityVector.at( iQuantity1 )->GetName() + "Vs" + _quantityVector.at( iQuantity2 )->GetName();
            _canvas->SaveAs( plotname + ".eps", "RECREATE" );

        }

    }

}

void Fittino::ContourPlotter::PrintResult() const {

}

void Fittino::ContourPlotter::PrintSteeringParameters() const {

}

void Fittino::ContourPlotter::UpdateModel() {

}
