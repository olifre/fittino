/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroCalculator.cpp                                              *
*                                                                              *
* Description Base class for SLHA compatible model calculators                 *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <stdlib.h>

#include <iostream>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TTree.h"
#include "TFile.h"
#include "TObjArray.h"
#include "TLeaf.h"
#include "TGraph.h"
#include "TF1.h"
#include "TMath.h"

#include "AstroCalculator.h"
#include "SimpleDataStorage.h"
#include "ConfigurationException.h"
#include "PhysicsModel.h"
#include "ModelParameterBase.h"
#include "Factory.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::AstroCalculator::AstroCalculator( const PhysicsModel* model )
    : CalculatorBase( model ) {

    _name = "AstroCalculator";

}

Fittino::AstroCalculator::AstroCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    _name = "AstroCalculator";
    if( ptree.count("Chi2Contribution" ) != 0 ) {
        BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, ptree ) { //.get_child("Chi2Contribution") ) {
            if( node.first != "Chi2Contribution" ) continue;
            std::string name = node.second.get<std::string>("Name");
            _chi2ContributionNames.push_back( name );
            _simpleOutputDataStorage -> AddEntry( name, 0. );
            _xValueNames.push_back( node.second.get<std::string>( "XValue" ) );
            _yValueNames.push_back( node.second.get<std::string>( "YValue" ) );
            _dataPointFileNames.push_back( node.second.get<std::string>( "FileName" ) ); 
            _exclusionGraphs.push_back( TGraph(_dataPointFileNames.at(_dataPointFileNames.size()-1).c_str()) );
            _theoryUncertainties.push_back( node.second.get<double>( "TheoryUncertainty" ) );
            _widthFormulas.push_back( TF1("", (node.second.get<std::string>( "WidthFormula" ) ).c_str() ) );
            _limitFormulas.push_back( TF1("", (node.second.get<std::string>( "LimitFormula" ) ).c_str() ) );
            _measuredValues.push_back( 0. );
            AddQuantity( new SimplePrediction( name, "", _simpleOutputDataStorage -> GetMap() -> at(name) ) ); 

        }
    }

}

Fittino::AstroCalculator::~AstroCalculator() {

}


void Fittino::AstroCalculator::CalculatePredictions() {

    for( unsigned int i = 0; i < GetCollectionOfQuantities().GetNumberOfElements(); ++i ) {
        
        std::string name = GetCollectionOfQuantities().At(i) -> GetName();
        double xValue = _model -> GetCollectionOfQuantities().At( _xValueNames.at(i) ) -> GetValue();
        double yValue = _model -> GetCollectionOfQuantities().At( _yValueNames.at(i) ) -> GetValue();
        _widthFormulas.at(i).SetParameter( 0, _exclusionGraphs.at(i).Eval( xValue ) );
        _widthFormulas.at(i).SetParameter( 1, _theoryUncertainties.at(i) );
        _widthFormulas.at(i).SetParameter( 2, yValue );
        _limitFormulas.at(i).SetParameter( 0, _measuredValues.at(i) );
        _limitFormulas.at(i).SetParameter( 1, _widthFormulas.at(i).Eval(0) );
        double width = _widthFormulas.at(i).Eval(0);
        double csLimit = width*TMath::Sqrt(_limitFormulas.at(i).Eval(0));
        if( yValue > csLimit ) {
            _simpleOutputDataStorage -> GetMap() -> at( name ) = ( yValue - csLimit )*(yValue - csLimit)/width/width;
        }
        else {
            _simpleOutputDataStorage -> GetMap() -> at( name ) = 0.;
        }
    }
    
}

void Fittino::AstroCalculator::SetupMeasuredValues() {
    for( unsigned int i = 0; i < _chi2ContributionNames.size(); ++i ) {
        std::string name = _yValueNames.at(i);
        for( unsigned int j = 0; j < _model->GetObservableVector()->size(); ++j ) {

            if( _model -> GetObservableVector() -> at(j) -> GetPrediction() -> GetName() == name ) {
                _measuredValues.at(i) = _model->GetObservableVector()->at(j)->GetMeasuredValue();
                
                break;
            }
        }
    }
}

void Fittino::AstroCalculator::Initialize() const {

}
