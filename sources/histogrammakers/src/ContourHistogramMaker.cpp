/* $Id: ContourHistogramMaker.cpp 2033 2014-03-30 16:41:36Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

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

#include "ContourHistogramMaker.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::ContourHistogramMaker::ContourHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : HistogramMakerBase( model, ptree ) {

    _name = "contour histogram maker";

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
            histogram->GetZaxis()->SetTitle( "#Delta#chi^{2}" );
            histogram->GetZaxis()->SetRangeUser( 0., 10. );

            histogram->SetTitle( 0 );
            histogram->SetStats( 0 );

            for ( Int_t iBinX = 0; iBinX <= histogram->GetNbinsX() + 1; ++iBinX ) {

                for ( Int_t iBinY = 0; iBinY <= histogram->GetNbinsY() + 1; ++iBinY ) {

                    histogram->SetBinContent( iBinX, iBinY, 10. );

                }

            }

            _histogramVector.push_back( histogram );

        }

    }

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

    double normalizedChi2;

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        TH1* histogram = _histogramVector[iHistogram];

        normalizedChi2 = chi2 - _lowestChi2;

        // Find the bin associated to the current tree entry.

        std::string histogramName = std::string( histogram->GetName() );

        std::string quantityName1 = histogramName.substr( 0, histogramName.find( ":" ) );
        std::string quantityName2 = histogramName.substr( quantityName1.length() + 1, histogramName.length() );

        int bin = histogram->FindBin( _model->GetCollectionOfQuantities().At( quantityName1 )->GetValue(),
                                      _model->GetCollectionOfQuantities().At( quantityName2 )->GetValue() );

        // Check if the current normalized chi2 is smaller than the previous bin content so far.

        if ( normalizedChi2 < histogram->GetBinContent( bin ) )
            histogram->SetBinContent( bin, normalizedChi2 );

    }

    // Update the tree entry.

    _iEntry++;

}
