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

#include <vector>
#include <sstream>

#include "TRandom3.h"

#include "LHCChi2Contribution.h"
#include "LHCModelCalculator.h"
#include "SimpleDataStorage.h"

Fittino::LHCChi2Contribution::LHCChi2Contribution( std::string name,
        std::string fileName,
        std::string histogramName,
        std::vector<std::string> relevantParameters,
        double nObs,
        double nExpSM,
        double nExpBestFit,
        double systematicErrorBG,
        double systematicErrorSignal,
        LHCModelCalculator* lhcModelCalculator )
    : _fileName( fileName ),
      _histogramName( histogramName ),
      _nObs( nObs ),
      _nExpSM( nExpSM ),
      _nExpBestFit( nExpBestFit ),
      _systematicErrorBG( systematicErrorBG ),
      _systematicErrorSignal( systematicErrorSignal ),
      _lhcModelCalculator( lhcModelCalculator ),
      Chi2ContributionBase( name ) {

      relevantParameters = relevantParameters;
      std::stringstream nObs_ss;
      nObs_ss << nObs;
      std::string nObs_s;
      nObs_ss >> nObs_s;
      std::string actualHistogramName = _histogramName + "_nObs" + nObs_ss.str();
      _lhcModelCalculator->AddAnalysis( _name, _fileName, actualHistogramName, _relevantParameters );

}

Fittino::LHCChi2Contribution::~LHCChi2Contribution() {

}

void Fittino::LHCChi2Contribution::UpdateValue() {

    _chi2 = _lhcModelCalculator->GetSimpleOutputDataStorage()->GetMap()->at( _name );

}

void Fittino::LHCChi2Contribution::SmearNObs( TRandom3* randomGenerator ) {

    double nObsNew = randomGenerator->Poisson( _nExpSM*randomGenerator->Gaus(1., _systematicErrorBG) + _nExpBestFit*randomGenerator->Gaus(1., _systematicErrorSignal ) );
    std::stringstream nObsNew_ss;
    nObsNew_ss << nObsNew;
    
    std::string actualHistogramName = _histogramName + "_nObs" + nObsNew_ss.str(); 
    _lhcModelCalculator->UpdateAnalysisHistogram( _name, _fileName, actualHistogramName, _relevantParameters );

}
