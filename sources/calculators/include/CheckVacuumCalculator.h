/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckVacuumCalculator.h                                          *
*                                                                              *
* Description Wrapper class for CheckVacuum                                    *
*                                                                              *
* Authors     Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CHECKVACUUMCALCULATOR_H
#define FITTINO_CHECKVACUUMCALCULATOR_H

#include "PtreeForwardDeclaration.h"

#include "CalculatorBase.h"

class CheckVacuum;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for CheckVacuum
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

    public:  
      void             CalculatePredictions();
      void             Initialize();

    private:  
      const double&            _m0;
      const double&            _m12;
      const double&            _a0;
      const double&            _tanbeta;
      const double&            _signmu;

      double            _vacuumStability;
      double            _vacuumLifetime;
      std::string              _gridfile;
      CheckVacuum*             _checkVacuum;

  };

}

#endif
