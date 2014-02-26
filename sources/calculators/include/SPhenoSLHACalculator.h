/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHACalculator.h                                           *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SPHENOSLHACALCULATOR_H
#define FITTINO_SPHENOSLHACALCULATOR_H

#include <vector>

#include "SLHACalculatorBase.h"
#include "Executor.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare > class basic_ptree;
    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHALine;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for SPheno.
   */
  class SPhenoSLHACalculator : public SLHACalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      SPhenoSLHACalculator( const boost::property_tree::ptree& ptree, const PhysicsModel* model );
      /*!
       *  Standard destructor.
       */
      ~SPhenoSLHACalculator();

    public:
      virtual void           CalculatePredictions();

      /*! \cond UML */
    private:
      std::vector<SLHALine*> _lines;
      std::string            _executableName;
      int                    _returnValue;
      Executor               _executor;

    private:
      virtual void           ConfigureInput();

      /*! \endcond UML */

  };

}

#endif // FITTINO_SPHENOSLHACALCULATOR_H
