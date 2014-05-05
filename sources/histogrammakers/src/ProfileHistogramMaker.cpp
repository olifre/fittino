/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ProfileHistogramMaker.cpp                                        *
*                                                                              *
* Description Class for profile histogram maker                                *
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

#include "ModelBase.h"
#include "ModelParameter.h"
#include "ProfileHistogramMaker.h"

Fittino::ProfileHistogramMaker::ProfileHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : Simple1DHistogramMaker( model, ptree ) {

    _name = "profile histogram maker";

    // Add some settings specific to profile histograms.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        _histogramVector[iQuantity]->GetYaxis()->SetTitle( "#Delta#chi^{2}" ); // Overwrite the y-axis title.
        _histogramVector[iQuantity]->GetYaxis()->SetRangeUser( 0., 10. );

        for ( Int_t iBin = 0; iBin <= _histogramVector[iQuantity]->GetNbinsX() + 1; ++iBin ) {

            _histogramVector[iQuantity]->SetBinContent( iBin, 10. );

        }

    }

    // Determine the lowest chi2.

    _bestFitEntry = model->GetCollectionOfParameters().At( 0 )->GetValue();

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _bestFitEntry );
    _lowestChi2 = _model->GetChi2();
    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

}

Fittino::ProfileHistogramMaker::~ProfileHistogramMaker() {

}

void Fittino::ProfileHistogramMaker::PrintSteeringParameters() const {

    PrintItem( "BestFitEntry", _bestFitEntry );

    HistogramMakerBase::PrintSteeringParameters();

}

void Fittino::ProfileHistogramMaker::UpdateModel() {

    // For each quantity fill the bin associated to the current tree entry with the lowest
    // normalized chi2.

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    double normalizedChi2 = chi2 - _lowestChi2;

    // Loop over all quantities.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        TH1* histogram = _histogramVector[iQuantity];

        // Find the bin associated to the current tree entry.

        int bin;

        if ( _logScale[iQuantity] ) {

            bin = histogram->FindBin( TMath::Log10( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() ) );

        }
        else {

            bin = histogram->FindBin( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() );

        }

        // Check if the current normalized chi2 is smaller than the previous bin content so far.

        if ( normalizedChi2 < histogram->GetBinContent( bin ) )
            histogram->SetBinContent( bin, normalizedChi2 );

    }

    // Update the tree entry.

    _iEntry++;

}
