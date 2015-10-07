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
#include <iostream>

#include "GM2CalcCalculator.h"

Fittino::GM2CalcCalculator::GM2CalcCalculator(const Fittino::ModelBase *model,
                                              const boost::property_tree::ptree &ptree)
:CalculatorBase(model, &ptree ){

}

Fittino::GM2CalcCalculator::~GM2CalcCalculator() {

}

void Fittino::GM2CalcCalculator::CalculatePredictions() {

    gm2calc::MSSMNoFV_onshell model;

    const Eigen::Matrix<double,3,3> UnitMatrix
            = Eigen::Matrix<double,3,3>::Identity();

    // fill pole masses
    model.get_physical().MSvmL   = 3.52693688E+02;
    model.get_physical().MSm(0)  = 2.29789268E+02;
    model.get_physical().MSm(1)  = 3.61617754E+02;
    model.get_physical().MChi(0) = 2.04267616E+02;
    model.get_physical().MChi(1) = 3.85975573E+02;
    model.get_physical().MChi(2) = 6.36794092E+02;
    model.get_physical().MChi(3) = 6.50380139E+02;
    model.get_physical().MCha(0) = 3.85988934E+02;
    model.get_physical().MCha(1) = 6.50709035E+02;
    model.get_physical().MAh(1)  = 7.19480165E+02;

    // fill DR-bar parameters
    model.set_TB(10);
    model.set_mq2(500 * 500 * UnitMatrix);
    model.set_ml2(500 * 500 * UnitMatrix);
    model.set_md2(500 * 500 * UnitMatrix);
    model.set_mu2(500 * 500 * UnitMatrix);
    model.set_me2(500 * 500 * UnitMatrix);
    model.set_Mu(350);
    model.set_MassB(150);
    model.set_MassWB(300);
    model.set_MassG(1000);
    model.set_scale(454.7);

    // convert DR-bar parameters to on-shell
    model.convert_to_onshell();

    const double amu =
            + gm2calc::calculate_amu_1loop(model)
            + gm2calc::calculate_amu_2loop(model);

    std::cout << "amu = " << std::scientific<< amu << std::endl;


}
