/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHAParameter.h                                                  *
*                                                                              *
* Description Class for SLHA model parameters                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SLHAPARAMETER_H
#define FITTINO_SLHAPARAMETER_H

#include "PhysicsParameter.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for SLHA model parameters.
   *
   *  This class extends the PhysicsParameter class with a SLHA parameter ID. This ID is unique\n
   *  within a certain SLHA model and is specified in the definition of the corresponding model\n
   *  class. For example, tan(beta) has the parameter ID 3 (for all models satisfying the SLHA\n
   *  standard).
   */
  class SLHAParameter : public PhysicsParameter {

    public:
      /*!
       *  Standard constructor.
       */
          SLHAParameter( std::string name,
                         double      value,
                         std::string unit,
                         double      error,
                         double      lowerBound,
                         double      upperBound,
                         int         id,
                         bool        fixed = false );
      /*!
       *  Standard destructor.
       */
          ~SLHAParameter();
      /*!
       *  Returns the ID of the parameter.
       */
      int GetID() const;

    private:
      /*!
       *  ID of the parameter.
       */
      int _id;

  };

}

#endif // FITTINO_SLHAPARAMETER_H
