/* $Id: GCECalculator.cpp 2383 2014-12-29 13:52:26Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GCECalculator.cpp                                       *
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

#include "GCECalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "TimeoutExecutorException.h"

Fittino::GCECalculator::GCECalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./GCECalculator.py", "GCECalculator.py" ) {
     
    _tag  = "GCE";
    _name = "GCECalculator";

    AddQuantity( new SimplePrediction( "chi2",                                  "", _chi2                 ) );
    AddQuantity( new SimplePrediction( "jbar",                                  "", _jbar                 ) );

}

Fittino::GCECalculator::~GCECalculator() {

}

void Fittino::GCECalculator::CalculatePredictions() {
    
    std::string outputFileName = _name + ".out"; 
    Redirector redirector( outputFileName );
  
    redirector.Start();
    
    ofstream inputFile( "GCEInput.txt", std::ofstream::out );
    inputFile << _model->GetCollectionOfQuantities().At("MicrOMEGAs_Omega_h2"          )->GetValue() << std::endl;
    inputFile << 1.e10*_model->GetCollectionOfQuantities().At("MicrOMEGAs_DiffSM_a_mu"       )->GetValue() << std::endl;
    

    try {

        _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    redirector.Stop();
    
    inputFile.close();
    ifstream outputFile( "GCEOutput.txt", std::ifstream::in );
    std::string key, value;
    while( outputFile.good() ) {
        outputFile >> key >> std::ws >> value;
        if( outputFile.eof() ) break;
        if     ( key == "Chi2" ) _chi2 = atof( value.c_str() );
        else if( key == "jbar" ) _jbar = atof( value.c_str() );
    }


}
