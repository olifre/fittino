/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SummaryHistogramMaker.cpp                                        *
*                                                                              *
* Description Class for summary histogram maker                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "TGaxis.h"
#include "TH2D.h"
#include "TMath.h"

#include "ModelBase.h"
#include "ModelParameter.h"
#include "SummaryHistogramMaker.h"

Fittino::SummaryHistogramMaker::SummaryHistogramMaker( ModelBase* model, const boost::property_tree::ptree& ptree )
    : Tool         ( model, ptree ),
      _logScale    ( ptree.get<bool>( "LogScale", false ) ),
      _iEntry      ( 0 ),
      _numberOfBins( ptree.get<unsigned int>( "NumberOfBins", 35 ) ),
      _globalAxis  ( new TGaxis() ) {

    _globalAxis->SetMaxDigits( ptree.get<int>( "AxisMaxDigits", 3 ) );

    _name = "summary histogram maker";

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "Quantity" ) {

            _quantityName.push_back( node.second.get<std::string> ( "Name"     ) );
            _plotName.push_back    ( node.second.get<std::string> ( "PlotName" ) );


        }

    }

    // Depending on whether or not LogScale is set, the histogram upper and lower bounds
    // are recomputed.

    if ( _logScale ) {

        if ( ptree.get<double>( "LowerBound" ) <= 0. || ptree.get<double>( "UpperBound" ) <= 0. ) {

            throw ConfigurationException( "Histogram axis set to log scale but boundaries are not positive." );

        }
        else {

            _lowerBound = TMath::Log10( ptree.get<double>( "LowerBound" ) );
            _upperBound = TMath::Log10( ptree.get<double>( "UpperBound" ) );

        }

    }
    else {

        _lowerBound = ptree.get<double>( "LowerBound" );
        _upperBound = ptree.get<double>( "UpperBound" );

    }

    // Histogram name.

    std::string histogramName = "Summary1Sigma";

    // Histogram bins.

    double xBins[_numberOfBins + 1];

    for ( unsigned int iBin = 0; iBin < _numberOfBins + 1; iBin++ ) {

        xBins[iBin] = _lowerBound + iBin * ( _upperBound - _lowerBound ) / double( _numberOfBins );

        if ( _logScale ) {

            if ( _lowerBound > 0. ) {

                xBins[iBin] = TMath::Power( 10, xBins[iBin] );

            }

        }

    }

    _histogram1Sigma = new TH2D( histogramName.c_str(),
                                 histogramName.c_str(),
                                 _numberOfBins, xBins, 2 * _quantityName.size() + 1, 0., 2 * _quantityName.size() + 1 );

    histogramName = "Summary2Sigma";

    _histogram2Sigma = new TH2D( histogramName.c_str(),
                                 histogramName.c_str(),
                                 _numberOfBins, xBins, 2 * _quantityName.size() + 1, 0., 2 * _quantityName.size() + 1 );

    _histogram1Sigma->SetTitle( 0 );
    _histogram1Sigma->SetStats( 0 );

    _histogram2Sigma->SetTitle( 0 );
    _histogram2Sigma->SetStats( 0 );

    _histogramVector.push_back( _histogram1Sigma );
    _histogramVector.push_back( _histogram2Sigma );

    // Detemine the quantity index of each scheduled quantity in the list of model quantities. This
    // is done because lookup via index is usually faster than lookup via name.

    for ( unsigned int iScheduledQuantity = 0; iScheduledQuantity < _quantityName.size(); ++iScheduledQuantity ) {

        for ( unsigned int iQuantity = 0; iQuantity < _model->GetCollectionOfQuantities().GetNumberOfElements(); ++iQuantity ) {

            if ( _quantityName[iScheduledQuantity] == _model->GetCollectionOfQuantities().At( iQuantity )->GetName() ) {

                _quantityIndex.push_back( iQuantity );

            }

        }

    }

    // Determine the lowest chi2.

    _bestFitEntry = model->GetCollectionOfParameters().At( 0 )->GetValue();

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _bestFitEntry );
    _lowestChi2 = _model->GetChi2();
    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

}

Fittino::SummaryHistogramMaker::~SummaryHistogramMaker() {

    delete _globalAxis;
    _globalAxis = 0;

}

void Fittino::SummaryHistogramMaker::PrintSteeringParameters() const {

    PrintItem( "BestFitEntry", _bestFitEntry );

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        PrintItem( "Quantity", _quantityName[iQuantity] );

    }

}

void Fittino::SummaryHistogramMaker::Execute() {

    while ( _iterationCounter < _model->GetCollectionOfQuantities().At( "TreeIterations" )->GetValue() ) {

        _iterationCounter++;

        UpdateModel();

        Tool::PrintStatus();

    }

}

void Fittino::SummaryHistogramMaker::InitializeTool() {

}

void Fittino::SummaryHistogramMaker::PrintResult() const {

    Messenger& messenger = Messenger::GetInstance();
    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;

}

void Fittino::SummaryHistogramMaker::Terminate() {

}

void Fittino::SummaryHistogramMaker::WriteResultToFile() const {

    _histogram1Sigma->Write();
    _histogram2Sigma->Write();

}

void Fittino::SummaryHistogramMaker::UpdateModel() {

    // For each quantity fill the bins corresponding to the 1 and 2 sigma regions.

    _model->GetCollectionOfParameters().At( 0 )->SetValue( _iEntry );

    double chi2 = _model->GetChi2();

    double normalizedChi2 = chi2 - _lowestChi2;

    // Loop over all quantities.

    for ( unsigned int iQuantity = 0; iQuantity < _quantityName.size(); ++iQuantity ) {

        // Find the bin associated to the current tree entry.

        int bin;

        if ( _logScale ) {

            bin = _histogram1Sigma->ProjectionX()->FindBin( TMath::Log10( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() ) );

        }
        else {

            bin = _histogram1Sigma->ProjectionX()->FindBin( _model->GetCollectionOfQuantities().At( _quantityIndex[iQuantity] )->GetValue() );

        }


        if ( normalizedChi2 <= 1. ) {

            // If the bin corresponds to the 1 sigma region, fill with 0.5.

            _histogram1Sigma->SetBinContent( bin, 2 * ( _quantityName.size() - iQuantity ), 0.5 );

        }
        else if ( normalizedChi2 <= 4. &&  normalizedChi2 > 1. ) {

            // If the bin corresponds to the 2 sigma region, fill with 0.8.

            _histogram2Sigma->SetBinContent( bin, 2 * ( _quantityName.size() - iQuantity ), 0.8 );

        }

    }

    // Update the tree entry.

    _iEntry++;

}
