/* $Id: FormulaPropCalculator.h 3063 2018-05-20 11:49:41Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FormulaCalculator.h                                              *
*                                                                              *
* Description Wrapper class for TFormula                                       *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FORMULAPROPCALCULATOR_H
#define FITTINO_FORMULAPROPCALCULATOR_H

#include "CalculatorBase.h"
#include <vector>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class FormulaQuantity;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FormulaQuantity
   */
  class FormulaPropCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FormulaPropCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~FormulaPropCalculator();
      void                               CalculatePredictions();

      /*! \cond UML */
    private:
      std::vector<FormulaQuantity*>     _formulas;
      void AddFormula( boost::property_tree::ptree ptree );
      bool _nonZerosRequired;

      /*! \endcond UML */

  };

}

#endif // FITTINO_FORMULAPROPCALCULATOR_H
