/* $Id: ParaboloidModel.cpp 2227 2014-05-26 13:44:35Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParaboloidModel.cpp                                                   *
*                                                                              *
* Description Implementation of a n-dimensional ParaboloidModel function            *
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
#include "ParaboloidModel.h"
#include "TMatrixD.h"

Fittino::ParaboloidModel::ParaboloidModel( boost::property_tree::ptree& ptree )
    : TestModelBase( ptree ),
    _sigma1(ptree.get<double>("Sigma1", 1.)),
    _sigma2(ptree.get<double>("Sigma2", 1.)),
    _rho(ptree.get<double>("Rho", 0.)),
    _transformationMatrix(2, 2)
    {

    _name = "ParaboloidModel";
    //fill trafo matrix
    _transformationMatrix[0][0] = _sigma1*_sigma1; _transformationMatrix[0][1] = -_rho*_sigma1*_sigma2;
    _transformationMatrix[1][0] = _rho*_sigma1*_sigma2; _transformationMatrix[1][1] = _sigma2*_sigma2;

    TestModelBase::Initialize();

}

Fittino::ParaboloidModel::~ParaboloidModel() {

}

Fittino::ParaboloidModel* Fittino::ParaboloidModel::Clone() const {

    return new ParaboloidModel( *this );

}


double Fittino::ParaboloidModel::TestModelFunction() {

    double parab;
    TMatrixD input(2, 1);
    for(int i = 0; i < 2; i++) input[i][0] = GetCollectionOfParameters().At(i)->GetValue();
    //transform to desired shape
    _transformationMatrix.Invert();
    input = _transformationMatrix * input;
    //get value
    parab = input[0][0]*input[0][0] + input[1][0]*input[1][0];
    //100x100 box
    if(GetCollectionOfParameters().At(0)->GetValue()>=GetCollectionOfParameters().At(0)->GetLowerBound() && GetCollectionOfParameters().At(0)->GetValue()<=GetCollectionOfParameters().At(0)->GetUpperBound() && GetCollectionOfParameters().At(1)->GetValue()>=GetCollectionOfParameters().At(1)->GetLowerBound() && GetCollectionOfParameters().At(1)->GetValue()<=GetCollectionOfParameters().At(1)->GetUpperBound()){
        return parab;
    } else return 100000;

}
