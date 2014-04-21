/* $Id: Simple2DHistogramMaker.cpp 2033 2014-03-30 16:41:36Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

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

#include "TH2D.h"

#include "Simple2DHistogramMaker.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::Simple2DHistogramMaker::Simple2DHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "simple 2D histogram maker";

    // Prepare the list of histograms.

    for ( unsigned int iQuantity1 = 0; iQuantity1 < _quantityName.size(); ++iQuantity1 ) {

        for ( unsigned int iQuantity2 = iQuantity1 + 1; iQuantity2 < _quantityName.size(); ++iQuantity2 ) {

            std::string histogramName = _quantityName[iQuantity1] + ":" + _quantityName[iQuantity2];

            TH2D* histogram = new TH2D( histogramName.c_str(),
                                        histogramName.c_str(),
                                        _numberOfBins[iQuantity1], _lowerBound[iQuantity1], _upperBound[iQuantity1],
                                        _numberOfBins[iQuantity2], _lowerBound[iQuantity2], _upperBound[iQuantity2] );

            histogram->GetXaxis()->SetTitle( _plotName[iQuantity1].c_str() );
            histogram->GetYaxis()->SetTitle( _plotName[iQuantity2].c_str() );
            histogram->GetZaxis()->SetTitle( "Fractions" );

            histogram->SetTitle( 0 );
            histogram->SetStats( 0 );

            _histogramVector.push_back( histogram );

        }

    }

}

Fittino::Simple2DHistogramMaker::~Simple2DHistogramMaker() {

}

void Fittino::Simple2DHistogramMaker::UpdateModel() {

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    _chi2 = _model->GetChi2();

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        TH1* histogram = _histogramVector[iHistogram];

        std::string histogramName = std::string( histogram->GetName() );

        std::string quantityName1 = histogramName.substr( 0, histogramName.find( ":" ) );
        std::string quantityName2 = histogramName.substr( quantityName1.length() + 1, histogramName.length() );

        // Fill the histogram.

        histogram->Fill( _model->GetCollectionOfQuantities().At( quantityName1 )->GetValue(),
                         _model->GetCollectionOfQuantities().At( quantityName2 )->GetValue() );

    }

    // Update the tree entry.

    _iEntry++;

}
