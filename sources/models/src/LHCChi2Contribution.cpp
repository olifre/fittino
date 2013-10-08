/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCChi2Contribution.cpp                                          *
*                                                                              *
* Description Class for LHC chi2 contributions                                 *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*	          the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "LHCChi2Contribution.h"
#include "LHCModelCalculator.h"
#include "SimpleDataStorage.h"

Fittino::LHCChi2Contribution::LHCChi2Contribution( std::string name,
        LHCModelCalculator* lhcModelCalculator )
    : _lhcModelCalculator( lhcModelCalculator ),
      Chi2ContributionBase( name ) {

}

Fittino::LHCChi2Contribution::~LHCChi2Contribution() {

}

void Fittino::LHCChi2Contribution::UpdateValue() {

    _chi2 = _lhcModelCalculator->GetSimpleOutputDataStorage()->GetMap()->at( _name );

}
