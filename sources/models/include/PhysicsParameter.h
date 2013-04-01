/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PhysicsParameter.h                                               *
*                                                                              *
* Description Class for model parameters that represent a physical quantity    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PHYSICSPARAMETER_H
#define FITTINO_PHYSICSPARAMETER_H

#include "ParameterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for model parameters that represent a physical quantity.
   *
   *  This class extends the ParameterBase class with a physical unit.
   */
  class PhysicsParameter : public ParameterBase {

    public:
      /*!
       *  Standard constructor.
       */
                  PhysicsParameter( std::string name,
                                    double      value,
                                    std::string unit,
                                    double      error,
                                    double      lowerBound,
                                    double      upperBound,
                                    bool        fixed = false );
      /*!
       *  Standard destructor.
       */
                  ~PhysicsParameter();
      /*!
       *  Returns the physical unit of the parameter.
       */
      virtual void        PrintStatus() const;
      std::string GetUnit() const;

    protected:
      /*!
       *  Physical unit of the parameter.
       */
      std::string _unit;

  };

}

#endif // FITTINO_PHYSICSPARAMETER_H
