/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCChi2Contribution.h                                           *
*                                                                              *
* Description Class for LHC chi2 contributions                                *
*                                                                              *
* Authors     Matthias Hamer <mhamer@gwdg.de>                                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*    	      published by the Free Software Foundation; either version 3 of   *
*	          the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LHCCHI2CONTRIBUTION_H
#define FITTINO_LHCCHI2CONTRIBUTION_H

#include <vector>

#include "Chi2ContributionBase.h"

class TRandom3;
/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class LHCModelCalculator;

  /*!
   *  \ingroup models
   *  \brief Class for LHC chi2 contributions.
   */
  class LHCChi2Contribution : public Chi2ContributionBase {

    public:
      /*!
       *  Old standard constructor. Takes several variables as input
       */
                               LHCChi2Contribution( std::string              name,
                                                    std::string              fileName,
                                                    std::string              histogramName,
                                                    std::vector<std::string> relevantParameters,
                                                    int                      nObs,
                                                    double                   nExpSM,
                                                    double                   nExpBestFit,
                                                    double                   systematicErrorBG,
                                                    double                   systematicErrorSignal,
                                                    LHCModelCalculator* lhcModelCalculator );
      /*!
       *  Standard constuctor.
       */
                                LHCChi2Contribution( const boost::property_tree::ptree& ptree, LHCModelCalculator* lhcModelCalculator );
      /*!
       *  Standard destructor.
       */
                               ~LHCChi2Contribution();
      virtual void             UpdateValue();
      void                     SmearNObs( TRandom3* );

    private:
      LHCModelCalculator*      _lhcModelCalculator;
      std::string              _fileName;
      std::string              _histogramName;
      std::vector<std::string> _relevantParameters;
      int                      _nObs;
      double                   _nExpSM;
      double                   _nExpBestFit;
      double                   _systematicErrorBG;
      double                   _systematicErrorSignal;

  };

}

#endif // FITTINO_LHCCHI2CONTRIBUTION_H
