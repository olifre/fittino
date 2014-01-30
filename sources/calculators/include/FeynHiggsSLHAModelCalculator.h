/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHAModelCalculator.h                                   *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSSLHAMODELCALCULATOR_H
#define FITTINO_FEYNHIGGSSLHAMODELCALCULATOR_H

#include "FeynHiggsModelCalculatorBase.h"

namespace boost {

  namespace property_tree {

    template < class Key, class Data, class KeyCompare >
      class basic_ptree;

    typedef basic_ptree< std::string, std::string, std::less<std::string> > ptree;

  }

}


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsSLHAModelCalculator : public FeynHiggsModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
    FeynHiggsSLHAModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                   ~FeynHiggsSLHAModelCalculator();

      virtual void Initialize() const;

      /*! \cond UML */
    private:
      void         ConfigureInput();

      /*! \endcond UML */

  };

}

#endif // FITTINO_FEYNHIGGSSLHAMODELCALCULATOR_H
