/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CMSSMModel.cpp                                                   *
*                                                                              *
* Description Implementation of the CMSSM model                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

#include "Configuration.h"
#include "CMSSMModel.h"
#include "Observable.h"
#include "SLHAParameter.h"
#include "SLHAPrediction.h"
#include "SimplePrediction.h"
#include "SPhenoSLHAModelCalculator.h"
#include "TreeCalculator.h"

Fittino::CMSSMModel::CMSSMModel() {

    Configuration* configuration = Configuration::GetInstance();

    _name = "CMSSM model";

    const boost::property_tree::ptree* propertyTree = configuration->GetPropertyTree();
    if( propertyTree->get<std::string>( "InputFile.Sampler.<xmlattr>.SamplerType" ) == "Tree" ) {

        TreeCalculator *treeCalculator = new TreeCalculator( this, propertyTree->get<std::string>( "InputFile.Sampler.<xmlattr>.InputFileName" ), propertyTree->get<std::string>( "InputFile.Sampler.<xmlattr>.InputTreeName" ) );
        _modelCalculatorVector.push_back( treeCalculator );


        AddParameter( new SLHAParameter( "P_A0", "A_{0}",
                                         propertyTree->get<double>( "InputFile.Model.<xmlattr>.A0" ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5, -1.e5, 1.e5, "5" ) );

        AddParameter( new SLHAParameter( "P_M0", "M_{0}",
                                         propertyTree->get<double>( "InputFile.Model.<xmlattr>.M0" ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5, 0., 2300., "1" ) );

        AddParameter( new SLHAParameter( "P_M12", "M_{1/2}",
                                         propertyTree->get<double>( "InputFile.Model.<xmlattr>.M12" ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5,  500., 3500., "2" ) );

        AddParameter( new SLHAParameter( "P_TanBeta", "tan#beta",
                                         propertyTree->get<double>( "InputFile.Model.<xmlattr>.TanBeta" ),
                                         "", "",
                                         1., 0., 1.e3, 0., 1.e3, "3" ) );

        BOOST_FOREACH( const boost::property_tree::ptree::value_type & v, propertyTree->get_child( "InputFile" ) ) {
            if( v.first == "Observable" ) {

                AddObservable( new Observable( new SimplePrediction( v.second.get<std::string>( "<xmlattr>.Name" ), v.second.get<std::string>( "<xmlattr>.Name" ), "", "", v.second.get<double>( "<xmlattr>.MeasuredValue" ) - 10 * v.second.get<double>( "<xmlattr>.Error1" ), v.second.get<double>( "<xmlattr>.MeasuredValue" ) + 10 * v.second.get<double>( "<xmlattr>.Error1" ), treeCalculator ), v.second.get<double>( "<xmlattr>.MeasuredValue" ), v.second.get<double>( "<xmlattr>.Error1" ) ) );

                /*
                std::cout << "read observable from config: " << std::endl;
                std::cout << "\t name is  " << v.second.get<std::string>("<xmlattr>.Name") << std::endl;
                std::cout << "\t value is " << v.second.get<double>("<xmlattr>.MeasuredValue") << std::endl;
                std::cout << "\t error is " << v.second.get<double>("<xmlattr>.Error1") << std::endl;
                */
            }
        }

        PhysicsModelBase::Initialize();

    }
    else {

        AddParameter( new SLHAParameter( "P_A0", "A_{0}",
                                         configuration->GetSteeringParameter( "A0", 0. ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5, -1.e5, 1.e5, "5" ) );

        AddParameter( new SLHAParameter( "P_M0", "M_{0}",
                                         configuration->GetSteeringParameter( "M0", 0. ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5, 0., 2300., "1" ) );

        AddParameter( new SLHAParameter( "P_M12", "M_{1/2}",
                                         configuration->GetSteeringParameter( "M12", 0. ),
                                         "GeV", "GeV",
                                         1., -1.e5, 1.e5,  500., 3500., "2" ) );

        AddParameter( new SLHAParameter( "P_TanBeta", "tan#beta",
                                         configuration->GetSteeringParameter( "TanBeta", 0. ),
                                         "", "",
                                         1., 0., 1.e3, 0., 1.e3, "3" ) );

        SPhenoSLHAModelCalculator* slhaModelCalculator = new SPhenoSLHAModelCalculator( this );
        _modelCalculatorVector.push_back( slhaModelCalculator );

        AddObservable( new Observable( new SLHAPrediction( "O_Bsg_npf", "BR(b#rightarrows#gamma)",
                                        "", "",
                                        0., 1.e6,
                                        slhaModelCalculator,
                                        "SPhenoLowEnergy",
                                        " 1", 1 ),
                                        3.55e-04, 0.53e-04 ) );

        _predictionVector.push_back( new SLHAPrediction( "O_massNeutralino1", "m_{#chi_{1}^{0}}",
                                     "GeV", "GeV",
                                     5., 1500.,
                                     slhaModelCalculator,
                                     "mass",
                                     "dummy", 0 ) );

        _predictionVector.push_back( new SLHAPrediction( "af_direct", "#sigma^{SI}",
                                     "pb", "pb",
                                     1.e-12, 1.e-2 ,
                                     slhaModelCalculator,
                                     "dummy",
                                     "dummy", 0 ) );

        PhysicsModelBase::Initialize();
    }
}

Fittino::CMSSMModel::~CMSSMModel() {

}

Fittino::CMSSMModel* Fittino::CMSSMModel::Clone() const {

    return new CMSSMModel( *this );

}
