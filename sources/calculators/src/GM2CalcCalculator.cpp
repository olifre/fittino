/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GM2CalcCalculator.cpp                                            *
*                                                                              *
* Description Wrapper class for GM2Calc                                        *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "gm2_1loop.hpp"
#include "gm2_2loop.hpp"
#include "MSSMNoFV_onshell.hpp"
#include "gm2_slha_io.hpp"
#include <iostream>

#include "GM2CalcCalculator.h"

Fittino::GM2CalcCalculator::GM2CalcCalculator(const Fittino::ModelBase *model,
                                              const boost::property_tree::ptree &ptree)
:CalculatorBase(model, &ptree ){

}

Fittino::GM2CalcCalculator::~GM2CalcCalculator() {

}

void Fittino::GM2CalcCalculator::CalculatePredictions() {

    gm2calc::GM2_slha_io slha_io;
    slha_io.read_from_source( "SPheno.spc" );

    gm2calc::MSSMNoFV_onshell model;

    gm2calc::fill_slha (slha_io, model );

    model.convert_to_onshell();

    double amu = gm2calc::calculate_amu_1loop( model ) + gm2calc::calculate_amu_2loop( model ) ;

    std::cout << "amu = " << std::scientific<< amu << std::endl;

}
