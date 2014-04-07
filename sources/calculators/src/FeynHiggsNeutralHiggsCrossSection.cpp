/* $Id$ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        FeynHiggsNeutralHiggsCrossSection.cpp                            *
 *                                                                              *
 * Description Wrapper class for FeynHiggs                                      *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include "CFeynHiggs.h"

#include "ConfigurationException.h"
#include "FeynHiggsNeutralHiggsCrossSection.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsNeutralHiggsCrossSection::FeynHiggsNeutralHiggsCrossSection( FHRealType* prodxs, int higgs, std::string sqrts )
:CalculatorBase ( 0 ),
prodxs ( prodxs ),
_higgs( higgs ) {

    std::string higgsname;

    switch ( _higgs ) {

        case 1:
            higgsname = "h0";
            break;

        case 2:
            higgsname = "H0";
            break;

        case 3:
            higgsname = "A0";
            break;

        default:
            throw ConfigurationException("Unknown higgs");
            break;

    }

    _quantityname = "CrossSection_" + sqrts + "TeV" + "_" + higgsname + "_";

    AddQuantity( new SimplePrediction( _quantityname + "StSth" , "", _StSth ) );

    AddQuantity( new SimplePrediction( _quantityname + "ggh2" ,  "", _ggh2  ) );
    AddQuantity( new SimplePrediction( "NormSM_" + _quantityname + "ggh2" , "", _ggh2 ) );

    AddChannel( "bbh"   , _bbh,    _bbhSM,    _bbhNormSM    );
    AddChannel( "btagbh", _btagbh, _btagbhSM, _btagbhNormSM );
    AddChannel( "ggh"   , _ggh,    _gghSM,    _gghNormSM    );
    AddChannel( "qqh"   , _qqh,    _qqhSM,    _qqhNormSM    );
    AddChannel( "tth"   , _tth,    _tthSM,    _tthNormSM    );
    AddChannel( "Wh"    , _Wh,     _WhSM,     _WhNormSM     );
    AddChannel( "Zh"    , _Zh,     _ZhSM,     _ZhNormSM     );

}

Fittino::FeynHiggsNeutralHiggsCrossSection::~FeynHiggsNeutralHiggsCrossSection() {

}

void Fittino::FeynHiggsNeutralHiggsCrossSection::AddChannel( std::string name, const double& value, const double& valueSM, const double& valueNormSM ) {

    std::string tag = _quantityname + name;

    AddQuantity( new SimplePrediction( tag , "", value ) );
    AddQuantity( new SimplePrediction( "SM_" + tag, "", valueSM ) );
    AddQuantity( new SimplePrediction( "NormSM_" + tag, "", valueNormSM ) );

}

void Fittino::FeynHiggsNeutralHiggsCrossSection::CalculatePredictions() {

    _bbh    = bbh   ( _higgs );
    _btagbh = btagbh( _higgs );
    _ggh    = ggh   ( _higgs );
    _ggh2   = ggh2  ( _higgs );
    _qqh    = qqh   ( _higgs );
    _tth    = tth   ( _higgs );
    _Wh     = Wh    ( _higgs );
    _Zh     = Zh    ( _higgs );
    _StSth  = StSth ( _higgs );

    _bbhSM    = bbhSM   ( _higgs );
    _btagbhSM = btagbhSM( _higgs );
    _gghSM    = gghSM   ( _higgs );
    _qqhSM    = qqhSM   ( _higgs );
    _tthSM    = tthSM   ( _higgs );
    _WhSM     = WhSM    ( _higgs );
    _ZhSM     = ZhSM    ( _higgs );

    _bbhNormSM    = _bbh    / _bbhSM;
    _btagbhNormSM = _btagbh / _btagbhSM;
    _gghNormSM    = _ggh    / _gghSM;
    _ggh2NormSM   = _ggh2   / _gghSM;
    _qqhNormSM    = _qqh    / _qqhSM;
    _tthNormSM    = _tth    / _tthSM;
    _WhNormSM     = _Wh     / _WhSM;
    _ZhNormSM     = _Zh     / _ZhSM;

}