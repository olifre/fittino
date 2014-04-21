/* $Id: ProfileHistogramMaker.cpp 2033 2014-03-30 16:41:36Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

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

#include "ModelBase.h"
#include "ModelParameter.h"
#include "ProfileHistogramMaker.h"

Fittino::ProfileHistogramMaker::ProfileHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "profile histogram maker";

    // Prepare the list of histograms.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        std::string histogramName = _quantityName[iQuantity];

        TH1D* histogram = new TH1D( histogramName.c_str(),
                                    histogramName.c_str(),
                                    _numberOfBins[iQuantity], _lowerBound[iQuantity], _upperBound[iQuantity] );

        histogram->GetXaxis()->SetTitle( _plotName[iQuantity].c_str() );
        histogram->GetYaxis()->SetTitle( "#Delta#chi^{2}" );
        histogram->GetYaxis()->SetRangeUser( 0., 10. );

        histogram->SetTitle( 0 );
        histogram->SetStats( 0 );

        for ( Int_t iBin = 0; iBin <= histogram->GetNbinsX() + 1; ++iBin ) {

            histogram->SetBinContent( iBin, 10. );

        }

        _histogramVector.push_back( histogram );

    }

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

    // For each histogram fill the bin associated to the current tree entry with the lowest
    // normalized chi2.

    double normalizedChi2;

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        TH1* histogram = _histogramVector[iHistogram];

        normalizedChi2 = chi2 - _lowestChi2;

        // Find the bin associated to the current tree entry.

        int bin = histogram->FindBin( _model->GetCollectionOfQuantities().At( histogram->GetName() )->GetValue() );

        // Check if the current normalized chi2 is smaller than the previous bin content so far.

        if ( normalizedChi2 < histogram->GetBinContent( bin ) )
            histogram->SetBinContent( bin, normalizedChi2 );

    }

    // Update the tree entry.

    _iEntry++;

}
