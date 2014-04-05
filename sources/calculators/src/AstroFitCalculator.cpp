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

#include <fstream>

#include <boost/property_tree/ptree.hpp>

#include "AstroFitCalculator.h"
#include "SimplePrediction.h"

Fittino::AstroFitCalculator::AstroFitCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model ),
_executor( "./AstroFit" , "AstroFit" ){

    _name = "AstroFit";
    _tag = "AF";

    AddQuantity( new SimplePrediction("Chi2_relic",  "", _chi2_relic  ) );
    AddQuantity( new SimplePrediction("Chi2_svind",  "", _chi2_svind  ) );
    AddQuantity( new SimplePrediction("Chi2_photon", "", _chi2_photon ) );
    AddQuantity( new SimplePrediction("Chi2_direct", "", _chi2_direct ) );

    AddQuantity( new SimplePrediction("relic",  "", _relic  ) );
    AddQuantity( new SimplePrediction("svind",  "", _svind  ) );
    AddQuantity( new SimplePrediction("photon", "", _photon ) );
    AddQuantity( new SimplePrediction("direct", "", _direct ) );

}

Fittino::AstroFitCalculator::~AstroFitCalculator() {

}

void Fittino::AstroFitCalculator::CalculatePredictions() {

    _executor.Execute();

    std::ifstream file("afout.txt");

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
