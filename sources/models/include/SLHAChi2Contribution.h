/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAChi2Contribution.h                                           *
*                                                                              *
* Description Class for SLHA chi2 contributions                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHACHI2CONTRIBUTION_H
#define FITTINO_SLHACHI2CONTRIBUTION_H

#include "Chi2ContributionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHAModelCalculatorBase;

  /*!
   *  \ingroup models
   *  \brief Class for SLHA chi2 contributions.
   */
  class SLHAChi2Contribution : public Chi2ContributionBase {

    public:
      /*!
       *  Standard constructor.
       */
                               SLHAChi2Contribution( std::string              name,
                                                     SLHAModelCalculatorBase* slhaModelCalculator,
                                                     std::string              blockName,
                                                     std::string              id,
                                                     int                      columnIndex );
      /*!
       *  Standard destructor.
       */
                               ~SLHAChi2Contribution();
      virtual void             UpdateValue();

    private:
      int                      _columnIndex;
      std::string              _id;
      std::string              _blockName;
      SLHAModelCalculatorBase* _slhaModelCalculator;

  };

}

#endif // FITTINO_SLHACHI2CONTRIBUTION_H
