/* $Id: LHCNeuralNetCalculator.cpp 2383 2014-12-29 13:52:26Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCNeuralNetCalculator.cpp                                       *
*                                                                              *
* Description Calculator for python scripts                                    *          
*                                                                              *
* Authors     Matthias Hamer <matthias.hamer@cern.ch>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#define BOOST_NO_CXX11_SCOPED_ENUMS

#include <fstream>

#include "boost/filesystem.hpp"

#include "LHCNeuralNetCalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "TimeoutExecutorException.h"
#include "ModelParameter.h"

Fittino::LHCNeuralNetCalculator::LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./chi2_LHCNN.py", "chi2_LHCNN.py" ) {
     
    _tag  = "LHCNN";
    _name = "LHCNeuralNetCalculator";
    
    AddQuantity( new SimplePrediction( "TotalChi2",                                   "", _lhcNNChi2                  ) );

    _arguments.push_back( "M_1" );
    _arguments.push_back( "M_2" );
    _arguments.push_back( "M_3" );
    _arguments.push_back( "M_Q1" );
    _arguments.push_back( "M_Q3" );
    _arguments.push_back( "M_L1" );
    _arguments.push_back( "M_L3" );
    _arguments.push_back( "M_A0" );
    _arguments.push_back( "A" );
    _arguments.push_back( "mu" );
    _arguments.push_back( "TanBeta" );
}

Fittino::LHCNeuralNetCalculator::~LHCNeuralNetCalculator() {

}

void Fittino::LHCNeuralNetCalculator::CalculatePredictions() {
   
    _executor.ResetArguments();
    std::ostringstream arg;
    for( unsigned int i = 0; i < _arguments.size(); ++i ) {
        arg << _model->GetCollectionOfQuantities().At(_arguments.at(i))->GetValue();
        _executor.AddArgument( arg.str() );
        arg.str(std::string());
    }

    std::string outputFileName = _name + ".out"; 
    Redirector redirector( outputFileName );
  
    redirector.Start();
    
    try {

        _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    redirector.Stop();
    
    std::ifstream outputFile( _name + ".out", std::ifstream::in );
    std::string key, value;
    while( outputFile.good() ) {
        outputFile >> key;
        if( outputFile.eof() ) break;
        else {
            _lhcNNChi2 = atof( key.c_str() );
        }
    }

}
