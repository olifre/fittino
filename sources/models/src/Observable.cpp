/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Observable.cpp                                                   *
*                                                                              *
* Description Class for observables                                            *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*        published by the Free Software Foundation; either version 3 of   *
*        the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>
#include <math.h>

#include <boost/property_tree/ptree.hpp>

#include "Messenger.h"
#include "Observable.h"
#include "PredictionBase.h"
#include "RandomGenerator.h"

Fittino::Observable::Observable( PredictionBase* prediction,
                                 double          measuredValue,
                                 double          measuredError,
                                 double          bestFitPrediction,
                                 bool            noFit,
                                 bool            noSmear,
                                 bool            noUpdate )
        : _deviation( 0. ),
          _measuredError( measuredError ),
          _measuredValue( measuredValue ),
          _bestFitPrediction( bestFitPrediction ),
          _noFit( noFit ),
          _noSmear( noSmear ),
          _noUpdate( noUpdate ),
          _prediction( prediction ) {
}

Fittino::Observable::Observable( const boost::property_tree::ptree& ptree, PredictionBase* prediction ) 
                   : _deviation( 0. ),
                     _measuredValue( ptree.get<double>( "MeasuredValue" ) ),
                     _bestFitPrediction( ptree.get<double>( "BestFitPrediction" ) ),
                     _noFit( ptree.get<bool>( "NoFit", false ) ),
                     _noSmear( ptree.get<bool>( "NoSmear", false ) ),
                     _noUpdate( ptree.get<bool>( "NoUpdate", false ) ),
                     _smearingType( ptree.get<std::string>( "SmearingType", "Gaus" ) ),
                     _prediction( prediction ) {

    _error1 = ptree.get<double>( "MeasuredError1" );
    _error2 = ptree.get<double>( "MeasuredError2", 0. );
    _error3 = ptree.get<double>( "MeasuredError3", 0. );
    _measuredError = sqrt( _error1*_error1 + _error2*_error2 + _error3*_error3 );

}

Fittino::Observable::~Observable() {

}

void Fittino::Observable::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 18 )
              << _prediction->GetName()
              << std::right
              << std::setw( 17 )
              << std::setprecision( 5 )
              << std::scientific
              << _prediction->GetValue()
              << std::right
              << std::setw( 15 )
              << _measuredValue
              << std::setw( 5 )
              << " +/- "
              << std::right
              << std::setw( 10 )
              << _measuredError
              << std::right
              << std::setw( 7 )
              << std::setprecision( 1 )
              << std::fixed
              << _deviation
              << std::right
              << std::setw( 6 )
              << " sigma"
              << Messenger::Endl;

}

const double& Fittino::Observable::GetMeasuredError() const {

    return _measuredError;
}

const double& Fittino::Observable::GetMeasuredValue() const {

    return _measuredValue;
}

void Fittino::Observable::SetMeasuredValue( double value ) {

    _measuredValue = value;

}

double Fittino::Observable::CalculateDeviation() {

    _deviation = ( _prediction->GetValue() - _measuredValue ) / _measuredError;

}

Fittino::PredictionBase* Fittino::Observable::GetPrediction() {

   return _prediction;

}

double Fittino::Observable::GetBestFitPrediction() const {

  return _bestFitPrediction;

}

void Fittino::Observable::SetBestFitPrediction( double value ) {
    
    _bestFitPrediction = value;

}

void Fittino::Observable::UpdatePrediction() {

    _prediction->Update();

    this->CalculateDeviation();

}

void Fittino::Observable::SmearMeasuredValue( unsigned int randomSeed ) {

    RandomGenerator* randomGenerator = Fittino::RandomGenerator::GetInstance();
    if( randomGenerator->GetSeed() == 0 ) {
    
        randomGenerator->SetSeed( randomSeed );

    }

    if( _smearingType == "Gaus" ) {
    
        _measuredValue = randomGenerator->Gaus( _bestFitPrediction, _measuredError );
    
    }
    else if( _smearingType == "Poisson" ) {
      
        // we will have to think of a better way to do this. For now, this is for the ATLAS 0 Lepton Analysis.
        // Smearing works in the following way:
        // In the input file, set     1) NObs = Number of expected background events
        //                            2) NExpBestFit = Number of expected events at best fit point == > Number of expected signal events = NExpBestFit - NObs
        //                            3) MeasuredError1 = systematic uncertainty on the number of background events
        //                            4) MeausredError2 = systematic uncertainty on the number of signal events
        _measuredValue = randomGenerator->Poisson( _measuredValue*randomGenerator->Gaus( 1., _error1) + (_bestFitPrediction - _measuredValue)*randomGenerator->Gaus(1., _error2 ));
   
    }
    else {

        std::cout << "Unkonwn SmearingType " << _smearingType << " for observable " << GetPrediction()->GetName() << ". Measured Value will not be smeared. " << std::endl;

    }

}

bool Fittino::Observable::IsNoFitObservable() {

    return _noFit;

}

bool Fittino::Observable::IsNoSmearObservable() {

    return _noSmear;

}

bool Fittino::Observable::IsNoUpdateObservable() {

    return _noUpdate;

}

std::string Fittino::Observable::GetSmearingType() {

    return _smearingType;

}
