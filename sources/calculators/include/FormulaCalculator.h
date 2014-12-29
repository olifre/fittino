/* $Id$ */

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

#ifndef FITTINO_FORMULACALCULATOR_H
#define FITTINO_FORMULACALCULATOR_H

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

class TFormula;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class PhysicsModel;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for TFormula.
   *  \todo Add support for parameters.
   */
  class FormulaCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FormulaCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~FormulaCalculator();
      void                               CalculatePredictions();
      void                               Initialize();

      /*! \cond UML */
    private:
      double                             _defaultValue;
      double                             _result;
      const double*                      _t;
      const double*                      _x;
      const double*                      _y;
      const double*                      _z;
      std::string                        _unit;
      const boost::property_tree::ptree& _ptree;
      TFormula*                          _formula;

    private:
      void                               InitializeVariable( std::string name, const double*& variable );

      /*! \endcond UML */

  };

}

#endif // FITTINO_FORMULACALCULATOR_H
