/* $Id: Chi2ContributionBase.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Chi2ContributionBase.cpp                                         *
*                                                                              *
* Description Base class for chi2 contributions                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iomanip>

//#include "TString.h"

#include "Messenger.h"
#include "Chi2ContributionBase.h"

Fittino::Chi2ContributionBase::Chi2ContributionBase( std::string name )
                             : _chi2( 0. ),
                               _name( name ) {

}

Fittino::Chi2ContributionBase::~Chi2ContributionBase() {

}

void Fittino::Chi2ContributionBase::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 18 )
              << _name 
              << std::right
              << std::setw( 17 )
              << std::setprecision( 5 )
              << std::scientific
              << _chi2
              << Messenger::Endl;

}

double Fittino::Chi2ContributionBase::GetValue() const {

    return _chi2;

}
