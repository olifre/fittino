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

#include "Simple1DHistogramMaker.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::Simple1DHistogramMaker::Simple1DHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "simple 1D histogram maker";

    // Prepare the list of histograms.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        std::string histogramName = _quantityName[iQuantity];

        TH1D* histogram = new TH1D( histogramName.c_str(),
                                    histogramName.c_str(),
                                    _numberOfBins[iQuantity], _lowerBound[iQuantity], _upperBound[iQuantity] );

        histogram->GetXaxis()->SetTitle( _plotName[iQuantity].c_str() );
        histogram->GetYaxis()->SetTitle( "Fractions" );

        histogram->SetTitle( 0 );
        histogram->SetStats( 0 );

        _histogramVector.push_back( histogram );

    }

}

Fittino::Simple1DHistogramMaker::~Simple1DHistogramMaker() {

}

void Fittino::Simple1DHistogramMaker::UpdateModel() {

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    _chi2 = _model->GetChi2();

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        TH1* histogram = _histogramVector[iHistogram];

        std::string quantityName = std::string( histogram->GetName() );

        // Fill the histogram.

        histogram->Fill(  _model->GetCollectionOfQuantities().At( quantityName )->GetValue() );

    }

    // Update the tree entry.

    _iEntry++;

}
