/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckVacuumCalculator.h                                          *
*                                                                              *
* Description Wrapper class for CheckVacuum                                    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CHECKVACUUMCALCULATOR_H
#define FITTINO_CHECKVACUUMCALCULATOR_H

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

class CheckVacuum;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for CheckVacuum.
   */
  class CheckVacuumCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      CheckVacuumCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~CheckVacuumCalculator();
      void          CalculatePredictions();
      void          Initialize();

      /*! \cond UML */
    private:
      double        _vacuumLifetime;
      double        _vacuumStability;
      std::string   _gridfile;
      CheckVacuum*  _checkVacuum;

    private:
      const double& _m0;
      const double& _m12;
      const double& _a0;
      const double& _tanbeta;
      const double& _signmu;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CHECKVACUUMCALCULATOR_H
