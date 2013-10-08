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

#include "Chi2ContributionBase.h"

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
       *  Standard constructor.
       */
                               LHCChi2Contribution( std::string              name,
                                                    LHCModelCalculator* lhcModelCalculator );
      /*!
       *  Standard destructor.
       */
                               ~LHCChi2Contribution();
      virtual void             UpdateValue();

    private:
      LHCModelCalculator*      _lhcModelCalculator;

  };

}

#endif // FITTINO_LHCCHI2CONTRIBUTION_H
