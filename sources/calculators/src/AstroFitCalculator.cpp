/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroFitCalculator.cpp                                           *
*                                                                              *
* Description Wrapper class for AstroFit                                       *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
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

#include "AstroFitCalculator.h"
#include "CalculatorException.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "TimeoutExecutorException.h"

Fittino::AstroFitCalculator::AstroFitCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./AstroFit" , "AstroFit" ) {

    _name = "AstroFit";
    _tag = "AstroFit";

    _executor.SetCompletionTimeout( 20 );

    AddQuantity( new SimplePrediction( "Chi2_Omega_h2",  "", _chi2_relic  ) );
    AddQuantity( new SimplePrediction( "Chi2_svind",     "", _chi2_svind  ) );
    AddQuantity( new SimplePrediction( "Chi2_photon",    "", _chi2_photon ) );
    AddQuantity( new SimplePrediction( "Chi2_direct",    "", _chi2_direct ) );

    AddQuantity( new SimplePrediction( "Omega_h2",  "", _relic  ) );
    AddQuantity( new SimplePrediction( "svind",     "", _svind  ) );
    AddQuantity( new SimplePrediction( "photon",    "", _photon ) );
    AddQuantity( new SimplePrediction( "direct",    "", _direct ) );

}

Fittino::AstroFitCalculator::~AstroFitCalculator() {

}

void Fittino::AstroFitCalculator::CalculatePredictions() {

    if ( boost::filesystem::exists( "AstroFit.spc" ) ) {

        boost::filesystem::rename( "AstroFit.spc" , "AstroFit.spc.last" );

    }

    if ( boost::filesystem::exists( "afout.txt" ) ) {

        boost::filesystem::rename( "afout.txt" , "afout.txt.last" );

    }

    if ( boost::filesystem::exists( "AstroFit.out" ) ) {

        boost::filesystem::rename( "AstroFit.out" , "AstroFit.out.last" );

    }

    //boost::filesystem::copy_file( "SPheno_FeynHiggs.spc", "AstroFit.spc" );
    std::ifstream infile( "SPheno_FeynHiggs.spc", std::ios::binary );
    std::ofstream outfile( "AstroFit.spc",        std::ios::binary );
    outfile << infile.rdbuf();
    infile.close();
    outfile.close();

    Redirector redirector( "AstroFit.out" );

    redirector.Start();

    try {

        _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    redirector.Stop();

    std::ifstream file( "afout.txt" );

    std::string line;
    std::getline( file, line );

    std::map<std::string, double > afout;

    while ( file ) {

        std::string name;
        double value;
        file >> name >> value;
        afout[name] = value;

    }

    file.close();

    _relic  = afout["relic"];
    _photon = afout["photon"];
    _svind  = afout["svind"];
    _direct = afout["direct"];

    _chi2_relic  = afout["chi2_relic"];
    _chi2_photon = afout["chi2_photon"];
    _chi2_svind  = afout["chi2_svind"];
    _chi2_direct = afout["chi2_direct"];

}
