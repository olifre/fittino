/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6Model.cpp                                                   *
*                                                                              *
* Description Implementation of the HDim6 model                                *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "Factory.h"
#include "Configuration.h"
#include "HDim6Model.h"
#include "HDim6ModelCalculator.h"
#include "PhysicsParameter.h"
#include "SimpleDataStorage.h"
#include "SimplePrediction.h"

Fittino::HDim6Model::HDim6Model() {

    _name = "HDim6 model";

    double      value          = 0;
    std::string unit           = "GeV-2";
    std::string plotUnit       = "GeV^{-2}";
    double      error          = 10;
    double      lowerBound     = 0;
    double      upperBound     = 1;
    double      plotLowerBound = 0;
    double      plotUpperBound = 1e-4;
    
    // these will parametrize our grid
    AddParameter( new PhysicsParameter( "F_B", "F_{B}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_W", "F_{W}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_WW", "F_{WW}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );

    // these will be free in the fit as well
    AddParameter( new PhysicsParameter( "F_gg", "F_{gg}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, false ) );
    AddParameter( new PhysicsParameter( "F_b", "F_{b}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_t", "F_{t}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_tau", "F_{#tau}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    
    // these we keep fixed
    AddParameter( new PhysicsParameter( "F_BB", "F_{BB}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_u", "F_{u}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_d", "F_{d}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_c", "F_{c}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_s", "F_{s}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_e", "F_{e}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );
    AddParameter( new PhysicsParameter( "F_mu", "F_{#mu}", value, unit, plotUnit, error, lowerBound, upperBound, plotLowerBound, plotUpperBound, true ) );

    const Factory factory;
    
    ModelCalculatorBase* hdim6ModelCalculator = factory.CreateCalculator(Configuration::HDIM6CALCULATOR, this);

    _modelCalculatorVector.push_back( hdim6ModelCalculator );


    std::map<std::string, double>::const_iterator it;

    const std::map<std::string, double>* map = hdim6ModelCalculator->GetSimpleOutputDataStorage()->GetMap();
    
    for(it = map->begin(); it != map->end(); it++) {

      AddPrediction( new SimplePrediction( it->first, it->first, "", "", 0,0, hdim6ModelCalculator  ) );

    }


    //     _predictionVector.push_back( new SimplePrediction( "Gamma_normSM_hTotal", "#Gamma_{h}/#Gamma_{h}^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hss", "BR(h#rightarrowss)/BR^{SM}(h#rightarrowss)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hcc", "BR(h#rightarrowcc)/BR^{SM}(h#rightarrowcc)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hbb", "BR(h#rightarrowbb)/BR^{SM}(h#rightarrowbb)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_htautau", "BR(h#rightarrow#tau#tau)/BR^{SM}(h#rightarrow#tau#tau)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hWW", "BR(h#rightarrowWW)/BR^{SM}(h#rightarrowWW)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hZZ", "BR(h#rightarrowZZ)/BR^{SM}(h#rightarrowZZ)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hgg", "BR(h#rightarrowgg)/BR^{SM}(h#rightarrowgg)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hgaga", "BR(h#rightarrow#gamma#gamma)/BR^{SM}(h#rightarrow#gamma#gamma)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "BR_normSM_hZga", "BR(h#rightarrowZ#gamma)/BR^{SM}(h#rightarrowZ#gamma)", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_ggh", "ggh/ggh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_bbh", "bbh/bbh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_tth", "tth/tth^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_bh", "bh/bh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_qqh", "qqh/qqh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_Wh", "Wh/Wh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "XS_normSM_Zh", "Zh/Zh^{SM}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_kappa_ga", "#Delta #kappa^{#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_kappa_Z", "#Delta #kappa^{Z}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_ga", "#Delta g_{1}^{#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_Z", "#Delta g_{1}^{Z}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_WW", "#Delta g_{1}^{WW}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g2_WW", "#Delta g_{2}^{WW}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_gaga", "#Delta g_{1}^{#gamma#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g2_gaga", "#Delta g_{2}^{#gamma#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_ZZ", "#Delta g_{1}^{ZZ}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g2_ZZ", "#Delta g_{2}^{ZZ}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g1_Zga", "#Delta g_{1}^{Z#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );
    //     _predictionVector.push_back( new SimplePrediction( "Delta_g2_Zga", "#Delta g_{2}^{Z#gamma}", "", "", 0.01, 100, hdim6ModelCalculator ) );

    PhysicsModelBase::Initialize();

}

Fittino::HDim6Model::~HDim6Model() {

}

Fittino::HDim6Model* Fittino::HDim6Model::Clone() const {

    return new HDim6Model( *this );

}
