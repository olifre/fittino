/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsSLHACalculator.h                                        *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSSLHACALCULATOR_H
#define FITTINO_FEYNHIGGSSLHACALCULATOR_H

#include "CSLHA.h"

#include "FeynHiggsCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class SLHADataStorageBase;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsSLHACalculator : public FeynHiggsCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsSLHACalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~FeynHiggsSLHACalculator();

      /*! \cond UML */
    private:
      COMPLEX _slhadata[nslhadata];
      SLHADataStorageBase* _slhadatastorage;


    private:
      void ConfigureInput();
      void WriteOutput();

      /*! \endcond UML */

  };

}

#endif // FITTINO_FEYNHIGGSSLHACALCULATOR_H
