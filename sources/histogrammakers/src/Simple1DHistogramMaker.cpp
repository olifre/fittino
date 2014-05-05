/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Simple1DHistogramMaker.cpp                                       *
*                                                                              *
* Description Class for simple 1D histogram maker                              *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TH1D.h"
#include "TMath.h"

#include "Simple1DHistogramMaker.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::Simple1DHistogramMaker::Simple1DHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "simple 1D histogram maker";

    // Setup the histograms to be made using the information gathered by the base class.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        // Histogram name.

        std::string histogramName = _quantityName[iQuantity];

        // Histogram bins.

        double xBins[_numberOfBins[iQuantity] + 1];

        for ( unsigned int iBin = 0; iBin < _numberOfBins[iQuantity] + 1; iBin++ ) {

            xBins[iBin] = _lowerBound[iQuantity] + iBin * ( _upperBound[iQuantity] - _lowerBound[iQuantity] ) / double( _numberOfBins[iQuantity] );

            if ( _logScale[iQuantity] ) {

                if ( _lowerBound[iQuantity] > 0. ) {

                    xBins[iBin] = TMath::Power( 10, xBins[iBin] );

                }

            }

        }

        TH1D* histogram = new TH1D( histogramName.c_str(),
                                    histogramName.c_str(),
                                    _numberOfBins[iQuantity], xBins );

        // Histogram axes' titles.

        if ( _logScale[iQuantity] ) {

            histogram->GetXaxis()->SetTitle( ( "Log_{10}(" + _plotName[iQuantity] + ")" ).c_str() );

        }
        else {

            histogram->GetXaxis()->SetTitle( _plotName[iQuantity].c_str() );

        }

        histogram->GetYaxis()->SetTitle( "Fractions" );

        histogram->SetTitle( 0 );
        histogram->SetStats( 0 );

        _histogramVector.push_back( histogram );

    }

}

Fittino::Simple1DHistogramMaker::~Simple1DHistogramMaker() {

}

void Fittino::Simple1DHistogramMaker::UpdateModel() {

    // Loop over all tree entries and fill simple 1D histograms.

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    _chi2 = _model->GetChi2();

    // Loop over all quantities.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        TH1* histogram = _histogramVector[iQuantity];

        // Fill the histogram.

        if ( _logScale[iQuantity] ) {

            histogram->Fill( TMath::Log10( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() ) );

        }
        else {

            histogram->Fill( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() );

        }

    }

    // Update the tree entry.

    _iEntry++;

}
