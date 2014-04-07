/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsBoundsCalculator.cpp                                   *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
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

Fittino::HiggsBoundsCalculator::HiggsBoundsCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree ) 
    : CalculatorBase( model ) {

    // Initialize steering parameters common to all SLHA calculators.

    _name               = ptree.get<std::string>( "Name",               "HiggsBoundsCalculator" );
    _nH                 = ptree.get<int>        ( "NH",                 5                       );
    _nHzero             = ptree.get<int>        ( "NHzero",             4                       );
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


}

Fittino::HiggsBoundsCalculator::~HiggsBoundsCalculator() {

}

void Fittino::HiggsBoundsCalculator::Initialize() {

    initialize_higgsbounds_chisqtables_();
    initialize_higgsbounds_( &_nH, &_nHplus, _whichAnalyses.c_str() );

}

void Fittino::HiggsBoundsCalculator::CalculatePredictions() {

    _globalHiggsBoundsChi2 = -1.;
    boost::thread threadHB( boost::bind( &Fittino::HiggsBoundsCalculator::CallHiggsBounds, this ) );
    threadHB.join();
    if( _globalHiggsBoundsChi2 < 0 ) {

    }

}

void Fittino::HiggsBoundsCalculator::CallHiggsBounds() {

    _globalHiggsBoundsChi2 = call_HiggsBoundsWithSLHA();

}

double Fittino::HiggsBoundsCalculator::call_HiggsBoundsWithSLHA() {

    std::string filename = "SPheno.spc";
    int length = filename.length();
    char charfilename[256];
    sprintf( charfilename, "%s", filename.c_str() );
    higgsbounds_input_slha_(charfilename, &length );
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
