/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RegressionCalculator.h                                           *
*                                                                              *
* Description Wrapper class for TMVA::Reader::EvaluateRegression()             *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_REGRESSIONCALCULATOR_H
#define FITTINO_REGRESSIONCALCULATOR_H

#include "TMVA/Reader.h"

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PhysicsModel;
  class RegressionMVA;
  class RegressionVariable;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for TMVA::Reader::EvaluateRegression().
   */
  class RegressionCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      RegressionCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~RegressionCalculator();

    public:
      virtual void               CalculatePredictions();
      virtual void               Initialize();

      /*! \cond UML */
    private:
      std::vector<float*>        _vectorOfFloatVariables;
      std::vector<const double*> _vectorOfDoubleVariables;
      TMVA::Reader               _reader;
      Collection<RegressionMVA*> _collectionOfMVAs;

      /*! \endcond UML */

  };

}

#endif // FITTINO_REGRESSIONCALCULATOR_H
