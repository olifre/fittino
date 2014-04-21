/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HistogramMakerBase.cpp                                           *
*                                                                              *
* Description Base class for histogram makers                                  *
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

#include "TH1.h"

#include "HistogramMakerBase.h"
#include "ModelBase.h"
#include "ModelParameter.h"

Fittino::HistogramMakerBase::HistogramMakerBase( ModelBase* model, const boost::property_tree::ptree& ptree )
    : Tool( model, ptree ),
      _iEntry( 0 ) {

    // Loop over the scheduled quantities.

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) {

        if ( node.first == "Histogram" ) {

            _quantityName.push_back( node.second.get<std::string> ( "Name"         ) );
            _plotName.push_back    ( node.second.get<std::string> ( "PlotName"     ) );
            _numberOfBins.push_back( node.second.get<unsigned int>( "NumberOfBins" ) );
            _lowerBound.push_back  ( node.second.get<double>      ( "LowerBound"   ) );
            _upperBound.push_back  ( node.second.get<double>      ( "UpperBound"   ) );

        }

    }

}

Fittino::HistogramMakerBase::~HistogramMakerBase() {

}

void Fittino::HistogramMakerBase::PrintSteeringParameters() const {

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        PrintItem( "Histogram", _histogramVector[iHistogram]->GetName() );

    }

}

void Fittino::HistogramMakerBase::Execute() {

    while ( _iterationCounter < _model->GetCollectionOfQuantities().At( "TreeIterations" )->GetValue() ) {

        _iterationCounter++;

        UpdateModel();

        Tool::PrintStatus();

    }

}

void Fittino::HistogramMakerBase::InitializeTool() {

}

void Fittino::HistogramMakerBase::PrintResult() const {

    Messenger& messenger = Messenger::GetInstance();
    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;

}

void Fittino::HistogramMakerBase::Terminate() {

}

void Fittino::HistogramMakerBase::WriteResultToFile() const {

    for ( Int_t i = 0; i < _histogramVector.size(); ++i ) {

        _histogramVector[i]->Write();

    }

}
