/* $Id: SlideModel.cpp 2227 2014-05-26 13:44:35Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SlideModel.cpp                                                   *
*                                                                              *
* Description Implementation of a n-dimensional SlideModel function            *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cmath>

#include "ModelParameter.h"
#include "SlideModel.h"

Fittino::SlideModel::SlideModel( boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ),
     _sigma1(ptree.get<double>("Sigma1", 1.)),
    _sigma2(ptree.get<double>("Sigma2", 1.)),
    _rho(ptree.get<double>("Rho", 0.)),
    _transformationMatrix(2, 2)
    {
     _name = "SlideModel";
    //fill trafo matrix
    _transformationMatrix[0][0] = _sigma1*_sigma1; _transformationMatrix[0][1] = -_rho*_sigma1*_sigma2;
    _transformationMatrix[1][0] = _rho*_sigma1*_sigma2; _transformationMatrix[1][1] = _sigma2*_sigma2;

    TestModelBase::Initialize();

}

Fittino::SlideModel::~SlideModel() {

}

Fittino::SlideModel* Fittino::SlideModel::Clone() const {

    return new SlideModel( *this );

}

double Fittino::SlideModel::TestModelFunction() {

    double parab;
    TMatrixD input(2, 1);
    for(int i = 0; i < 2; i++) input[i][0] = GetCollectionOfParameters().At(i)->GetValue();
    //transform to desired shape
    input = _transformationMatrix * input;
    //get value
    parab = input[0][0]*input[0][0] - input[1][0];
    //100x100 box
    //if(std::max(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) > 5 || std::min(GetCollectionOfParameters().At(0)->GetValue(), GetCollectionOfParameters().At(1)->GetValue()) < -5) return 1000000;
    //else return parab;
    return parab;

}

