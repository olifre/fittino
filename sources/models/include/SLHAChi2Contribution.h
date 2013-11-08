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

#include <boost/property_tree/ptree.hpp>

#include "Chi2ContributionBase.h"

class TRandom3;

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
       *  Constructor taking name, blockName, id, column index and SLHACalculator as input.
       */
                               SLHAChi2Contribution( std::string              name,
                                                     SLHAModelCalculatorBase* slhaModelCalculator,
                                                     std::string              blockName,
                                                     std::string              id,
                                                     int                      columnIndex );
      /*!
       *  Standard constructor
       */
                              SLHAChi2Contribution( const boost::property_tree::ptree& ptree, SLHAModelCalculatorBase* slhaModelCalculator );
      /*!
       *  Standard destructor.
       */
                               ~SLHAChi2Contribution();
      virtual void             UpdateValue();
      virtual void             SmearObservation( TRandom3* );

    private:
      int                      _columnIndex;
      std::string              _id;
      std::string              _blockName;
      SLHAModelCalculatorBase* _slhaModelCalculator;

  };

}

#endif // FITTINO_SLHACHI2CONTRIBUTION_H
