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
