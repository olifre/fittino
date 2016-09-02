/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsCalculator.cpp                                        *
*                                                                              *
* Description Wrapper class for HiggsBounds                                    *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "ConfigurationException.h"
#include "HiggsBoundsCalculator.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsBoundsCalculator::HiggsBoundsCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ) {

    // Initialize steering parameters common to all SLHA calculators.

    _name               = ptree.get<std::string>( "Name",               "HiggsBoundsCalculator" );
    _nH                 = ptree.get<int>        ( "NH",                 4                       );
    _nHzero             = ptree.get<int>        ( "NHzero",             3                       );
    _nHplus             = ptree.get<int>        ( "NHPlus",             1                       );
    _whichAnalyses      = ptree.get<std::string>( "WhichAnalyses",      "onlyL"                 );
    _HBresult           = -1;
    _channel            = 0;
    _obsratio           = 0.;
    _ncombined          = 0;
    _theoryUncertainty1s = ptree.get<double>    ( "TheoryUncertainty",  1.5 );
    _chi2WithTheory     = 0.;
    _chi2WithoutTheory  = 0.;
    _bestChannelChi2    = 0;

    AddQuantity( new SimplePrediction( "HB_result",             "HB_result",             "",    "",    -1.e4,    1.e4, _HBresult  ) ); 
    AddQuantity( new SimplePrediction( "HB_obsratio",           "HB_obsratio",           "",    "",    -1.e4,    1.e4, _obsratio  ) ); 
    AddQuantity( new SimplePrediction( "HB_channel",            "HB_channel",            "",    "",    -1.e4,    1.e4, _channel  ) ); 
    AddQuantity( new SimplePrediction( "HB_chi2WithTheory",     "HB_chi2WithTheory",     "",    "",    -1.e4,    1.e4, _chi2WithTheory  ) ); 
    AddQuantity( new SimplePrediction( "HB_chi2WithoutTheory",  "HB_chi2WithoutTheory",  "",    "",    -1.e4,    1.e4, _chi2WithoutTheory  ) ); 
    AddQuantity( new SimplePrediction( "HB_bestChannelChi2",    "HB_bestChannelChi2",    "",    "",    -1.e4,    1.e4, _bestChannelChi2  ) ); 

}

Fittino::HiggsBoundsCalculator::~HiggsBoundsCalculator() {

}

void Fittino::HiggsBoundsCalculator::Initialize() {

    std::cout << "initing hb chi2 tables" << std::endl;
    initialize_higgsbounds_chisqtables_();
    std::cout << "initing hb" << std::endl;
    initialize_higgsbounds_( &_nH, &_nHplus, _whichAnalyses.c_str(), _whichAnalyses.length() );

}

void Fittino::HiggsBoundsCalculator::CalculatePredictions() {

    _globalHiggsBoundsChi2 = -1.;
    boost::thread threadHB( boost::bind( &Fittino::HiggsBoundsCalculator::CallHiggsBounds, this ) );
    threadHB.join();
    if( _globalHiggsBoundsChi2 < 0 ) {

    }

}

void Fittino::HiggsBoundsCalculator::CallHiggsBounds() {

    setupHiggsBounds();
    _globalHiggsBoundsChi2 = RunHiggsBounds();

}

double Fittino::HiggsBoundsCalculator::RunHiggsBounds() {

    run_higgsbounds_( &_HBresult, &_channel, &_obsratio, &_ncombined );
     
    if( _HBresult < 0 || _HBresult > 1 ) {
        
        return -1.0;
    
    }
    
    for( int i = 0; i < _model->GetObservableVector()->size(); ++i ) {
        std::string name = _model->GetObservableVector()->at(i)->GetPrediction()->GetName();
        if( name == "FH_massh0" || name == "massh0" || name == "Massh0_npf" ) {
            _theoryUncertainty1s = _model->GetObservableVector()->at(i)->GetMeasuredError();
            break;
        }
    }

    hb_calc_stats_( &_theoryUncertainty1s, &_chi2WithoutTheory, &_chi2WithTheory, &_bestChannelChi2 );
    if( _chi2WithoutTheory < 0. ) {
    
        return -1.0;

    }

    if( _chi2WithTheory < 0. && _chi2WithoutTheory > 0. ) {

        return -1.0;

    }

    if( _channel != _bestChannelChi2 ) {

        if( _HBresult == 0 ) {

            _chi2WithoutTheory = 1000.;
            _chi2WithTheory    = 1000.;

        }
    
    }
    return _chi2WithTheory;
}
