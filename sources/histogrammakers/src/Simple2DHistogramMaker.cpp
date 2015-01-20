/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Simple2DHistogramMaker.cpp                                       *
*                                                                              *
* Description Class for simple 2D histogram maker                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TGraph.h"
#include "TH2D.h"
#include "TMath.h"

#include "ModelBase.h"
#include "ModelParameter.h"
#include "PlotterBase.h"
#include "Simple2DHistogramMaker.h"

Fittino::Simple2DHistogramMaker::Simple2DHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "simple 2D histogram maker";

    // Setup the histograms to be made using the information gathered by the base class.

    for ( unsigned int iQuantity1 = 0; iQuantity1 < _quantityName.size(); ++iQuantity1 ) {

        for ( unsigned int iQuantity2 = iQuantity1 + 1; iQuantity2 < _quantityName.size(); ++iQuantity2 ) {

            // Histogram name.

            std::string histogramName = _quantityName[iQuantity1] + "_" + _quantityName[iQuantity2];

            // Histogram bins of the x-axis.

            double xBins[_numberOfBins[iQuantity1] + 1];

            for ( unsigned int iBin = 0; iBin < _numberOfBins[iQuantity1] + 1; iBin++ ) {

                xBins[iBin] = _lowerBound[iQuantity1] + iBin * ( _upperBound[iQuantity1] - _lowerBound[iQuantity1] ) / double( _numberOfBins[iQuantity1] );

                if ( _logScale[iQuantity1] ) {

                        xBins[iBin] = TMath::Power( 10, xBins[iBin] );

                }

            }

            // Histogram bins of the y-axis.

            double yBins[_numberOfBins[iQuantity2] + 1];

            for ( unsigned int iBin = 0; iBin < _numberOfBins[iQuantity2] + 1; iBin++ ) {

                yBins[iBin] = _lowerBound[iQuantity2] + iBin * ( _upperBound[iQuantity2] - _lowerBound[iQuantity2] ) / double( _numberOfBins[iQuantity2] );

                if ( _logScale[iQuantity2] ) {

                        yBins[iBin] = TMath::Power( 10, yBins[iBin] );

                }

            }

            TH2D* histogram = new TH2D( histogramName.c_str(),
                                        histogramName.c_str(),
                                        _numberOfBins[iQuantity1], xBins,
                                        _numberOfBins[iQuantity2], yBins );

            // Histogram axes' titles.

            histogram->GetXaxis()->SetTitle( _plotName[iQuantity1].c_str() );
            histogram->GetYaxis()->SetTitle( _plotName[iQuantity2].c_str() );
            histogram->GetZaxis()->SetTitle( "Number of entries" );

            histogram->SetTitle( 0 );
            histogram->SetStats( 0 );

            _histogramVector.push_back( histogram );
            _plotter->AddHistogram( histogram );

            double bestFitX = _model->GetCollectionOfQuantities().At( _quantityName[iQuantity1] )->GetValue();
            double bestFitY = _model->GetCollectionOfQuantities().At( _quantityName[iQuantity2] )->GetValue();

            TGraph* graph = new TGraph( 1 );
            graph->SetPoint( 0, bestFitX, bestFitY );
            _plotter->AddGraph( graph );

        }

    }

}

Fittino::Simple2DHistogramMaker::~Simple2DHistogramMaker() {

}

void Fittino::Simple2DHistogramMaker::UpdateModel() {

    // Loop over all tree entries and fill simple 2D histograms.

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    _chi2 = _model->GetChi2();

    // Loop over all scheduled quantities.

    unsigned int iHistogram = 0;

    for ( unsigned int iQuantity1 = 0; iQuantity1 < _quantityName.size(); ++iQuantity1 ) {

        for ( unsigned int iQuantity2 = iQuantity1 + 1; iQuantity2 < _quantityName.size(); ++iQuantity2 ) {

            TH1* histogram = _histogramVector[iHistogram];

            histogram->Fill( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity1] )->GetValue(),
                                 _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity2] )->GetValue() );

            iHistogram++;

        }

    }

    // Update the tree entry.

    _iEntry++;

}
