/* $Id: MarkovChainSampler.cpp 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleSampler.cpp                                           *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors     Pia Kullik     email                                                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	           published by the Free Software Foundation; either version 3 of   *
*	           the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include "TMath.h"
#include "SimpleSampler.h"
#include "ModelBase.h"
#include "ModelCalculatorException.h"
#include <vector>
#include <cmath>


Fittino::SimpleSampler::SimpleSampler( Fittino::ModelBase* model )
        : SamplerBase(model),
        _incrementValues(std::vector<double>(model->GetNumberOfParameters(), 0.)), //decide increments for each parameter separately
        _upperBoundValues(std::vector<double>(model->GetNumberOfParameters(), 0.)),
        _lowerBoundValues(std::vector<double>(model->GetNumberOfParameters(), 0.)){

    _name = "Scanner";

    for (unsigned int k = 0; k < _model->GetNumberOfParameters(); k++){
        _incrementValues.at(k) = 1;
        //_incrementValues.at(k) = _model->GetParameterVector()->at(k)->GetError();
        _upperBoundValues.at(k) = 10;
        //_upperBoundValues.at(k) = _model->GetParameterVector()->at(k)->GetUpperBound();
        _lowerBoundValues.at(k) = 0;
        //_lowerBoundValues.at(k) = _model->GetParameterVector()->at(k)->GetValue();
        //_lowerBoundValues.at(k) = _model->GetParameterVector()->at(k)->GetLowerBound();
    }
        }






Fittino::SimpleSampler::~SimpleSampler() {


}



void Fittino::SimpleSampler::PrintSteeringParameters() const {

}



/* updates within an iteration of UpdateModel:
- increase the current parameter by the desired increment
- reset all following parameters to their original values
- leave previous parameters unchanged.
*/
void Fittino::SimpleSampler::UpdateValues(int i){

        _model->SetParameterVector()->at(i)->SetValue(_model->GetParameterVector()->at(i)->GetValue() + _incrementValues.at(i));

}

void Fittino::SimpleSampler::ResetValues(int index){
    for (unsigned int i = 0; i < index; i++){
        _model->SetParameterVector()->at(i)->SetValue(_lowerBoundValues.at(i));
    }
}


/* scans chi2 by iterating over a given parameter.
*/
void Fittino::SimpleSampler::Scan(int index){


    //for(unsigned int steps = 0; steps < _stepNumber.at(index); steps++){
        if (index > 0) {

                while (_model->GetParameterVector()->at(index)->GetValue() <= _upperBoundValues.at(index)){
                    Scan(index - 1);
                    ResetValues(index);
                    UpdateValues(index);

                }


            }


        else {
                while (_model->GetParameterVector()->at(index)->GetValue() <= _upperBoundValues.at(index)){
                    _model-> GetChi2();
                    this->FillStatus();
                    UpdateValues(0);
                    }
        }
    }


/* call Scan for the last parameter to start the recursion.
*/
void Fittino::SimpleSampler::UpdateModel(){

    Scan( _model->GetNumberOfParameters()-1);

}








