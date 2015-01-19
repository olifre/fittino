/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ContourHistogramMaker.cpp                                        *
*                                                                              *
* Description Class for contour histogram maker                                *
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
#include "TMath.h"

#include "ContourHistogramMaker.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::ContourHistogramMaker::ContourHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : Simple2DHistogramMaker( model, ptree ) {

    _name = "contour histogram maker";

    // Add some settings specific to contour histograms.

    unsigned int iHistogram = 0;

    for ( unsigned int iQuantity1 = 0; iQuantity1 < _quantityName.size(); ++iQuantity1 ) {

        for ( unsigned int iQuantity2 = iQuantity1 + 1; iQuantity2 < _quantityName.size(); ++iQuantity2 ) {

            _histogramVector[iHistogram]->GetZaxis()->SetTitle( "#Delta#chi^{2}" ); // Overwrite the z-axis title.
            _histogramVector[iHistogram]->GetZaxis()->SetRangeUser( 0., 10. );

            for ( Int_t iBinX = 0; iBinX <= _histogramVector[iHistogram]->GetNbinsX() + 1; ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= _histogramVector[iHistogram]->GetNbinsY() + 1; ++iBinY ) {

                    _histogramVector[iHistogram]->SetBinContent( iBinX, iBinY, 10. );

                }

            }

            iHistogram++;

        }

    }

    // Determine the lowest chi2.

    _bestFitEntry = model->GetCollectionOfParameters().At( 0 )->GetValue();

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _bestFitEntry );
    _lowestChi2 = _model->GetChi2();
    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

}

Fittino::ContourHistogramMaker::~ContourHistogramMaker() {

}

void Fittino::ContourHistogramMaker::PrintSteeringParameters() const {

    PrintItem( "BestFitEntry", _bestFitEntry );

    HistogramMakerBase::PrintSteeringParameters();

}

void Fittino::ContourHistogramMaker::UpdateModel() {

    // For each histogram fill the bin associated to the current tree entry with the lowest
    // normalized chi2.

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    double normalizedChi2 = chi2 - _lowestChi2;

    // Loop over all quantities.

    unsigned int iHistogram = 0;

    for ( unsigned int iQuantity1 = 0; iQuantity1 < _quantityName.size(); ++iQuantity1 ) {

        for ( unsigned int iQuantity2 = iQuantity1 + 1; iQuantity2 < _quantityName.size(); ++iQuantity2 ) {

            TH1* histogram = _histogramVector[iHistogram];

            // Find the bin associated to the current tree entry.

            int bin = histogram->FindBin( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity1] )->GetValue(),
                                          _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity2] )->GetValue() );

            // Check if the current normalized chi2 is smaller than the previous bin content so far.

            if ( normalizedChi2 < histogram->GetBinContent( bin ) )
                histogram->SetBinContent( bin, normalizedChi2 );

            iHistogram++;

        }

    }

    // Update the tree entry.

    _iEntry++;

}
