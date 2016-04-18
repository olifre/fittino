/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MicromegasCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for Micromegas                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>
#include <boost/thread.hpp>
#include <boost/chrono.hpp>
#include <pthread.h>

#include "MicromegasCalculator.h"
#include "SimplePrediction.h"
#include "CalculatorException.h"

Fittino::MicromegasCalculator::MicromegasCalculator( const ModelBase* model, boost::property_tree::ptree &ptree )
    : MicromegasWrapper( ptree.get<std::string>( "Name", "MicrOMMEGAs" ) ), CalculatorBase( model, &ptree ) {

    _name = "MicrOMEGAs";
    _tag = "MicrOMEGAs";

    _inputFile = ptree.get<std::string>( "InputFile" );

    AddQuantity( new SimplePrediction( "Omega_h2", "", _omegah2 ) );
    AddQuantity( new SimplePrediction( "DiffSM_a_mu", "", _gmin2 ) );
    AddQuantity( new SimplePrediction( "vSigma", "", _vSigma ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_WpWm", "", _vSigma_Contribution_WpWm ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_ZZ", "", _vSigma_Contribution_ZZ ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_GG", "", _vSigma_Contribution_GG ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_AA", "", _vSigma_Contribution_AA ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_hh", "", _vSigma_Contribution_hh ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_Zh", "", _vSigma_Contribution_Zh ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_tT", "", _vSigma_Contribution_tT ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_bB", "", _vSigma_Contribution_bB ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_cC", "", _vSigma_Contribution_cC ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_sS", "", _vSigma_Contribution_sS ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_dD", "", _vSigma_Contribution_dD ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_uU", "", _vSigma_Contribution_uU ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_lL", "", _vSigma_Contribution_lL ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_eE", "", _vSigma_Contribution_eE ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_mM", "", _vSigma_Contribution_mM ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_nlNl", "", _vSigma_Contribution_nlNl ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_nmNm", "", _vSigma_Contribution_nmNm ) );
    AddQuantity( new SimplePrediction( "vSigma_Contribution_neNe", "", _vSigma_Contribution_neNe ) );

}

Fittino::MicromegasCalculator::~MicromegasCalculator() {

}

void Fittino::MicromegasCalculator::CalculatePredictions() {

    boost::thread threadMO( boost::bind( &Fittino::MicromegasWrapper::CalculatePredictions, this ) );
    if( ! (threadMO.try_join_for( boost::chrono::milliseconds(30000))) ) {
        
        pthread_t native_thread = threadMO.native_handle();
        pthread_cancel( native_thread );
        throw CalculatorException( _mcname, "timeout");

    }

    if( _errorCode != 0 ) {
        if( _errorCode == 1 ) {

            throw ConfigurationException( "Micromegas: Problem with input file." );
    
        }
        else if( _errorCode == 2 ) {

            throw CalculatorException( _mcname, "LSP" );

        }
        else if( _errorCode == 3 ) {
        
            throw CalculatorException( _mcname, "Negative omega." );
    
        }
    }
}
