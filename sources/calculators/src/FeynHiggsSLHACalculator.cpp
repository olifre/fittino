/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHACalculator.cpp                                      *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "CFeynHiggs.h"

#include "Factory.h"
#include "FeynHiggsSLHACalculator.h"
#include "SLHADataStorageBase.h"

Fittino::FeynHiggsSLHACalculator::FeynHiggsSLHACalculator(  const PhysicsModel* model, const boost::property_tree::ptree& ptree )
    : FeynHiggsCalculatorBase( model, ptree ) {

    _name = "FeynHiggsCalculator";
    _fileName = "SPheno.spc";

    Factory factory;

    _slhadatastorage  = factory.CreateSLHAeaSLHADataStorage();

}

Fittino::FeynHiggsSLHACalculator::~FeynHiggsSLHACalculator() {

}

void Fittino::FeynHiggsSLHACalculator::ConfigureInput() {

    _slhadatastorage->ReadFile("SPheno.spc");

    SLHAClear( _slhadata );
    SLHARead( &_error, _slhadata, _fileName.c_str(), 1 );
    //if( error )
    //    exit(error);

    FHSetSLHA( &_error, _slhadata );
    //if( error )
    //    exit(error);

}

void Fittino::FeynHiggsSLHACalculator::WriteOutput() {

    // int key = 16;
    // int key = 255;
    // FHOutputSLHA( &_error, _slhadata, key );
    // SLHAWrite(&_error, _slhadata, "FH.slha");

     _slhadatastorage->SetEntry(666, "MASS", 1, "35", "", "", "");
     _slhadatastorage->SetEntry(777, "alpha", 0, "(any)", "# alpha", "", "");
     _slhadatastorage->WriteFile("NewSPheno.spc");

}

