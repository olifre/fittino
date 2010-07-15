/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelBase.h                                                      *
*                                                                              *
* Description Base class for Fittino models                                    *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELBASE_H
#define FITTINO_MODELBASE_H

#include <string>
#include <vector>

#include "Parameter.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Base class for Fittino models 
   */
  class ModelBase {

    public:
      enum                     ModelType { MSUGRA, ROSENBROCK };

    public:
      /*!
       *  Constructor
       */
                               ModelBase();
      /*!
       *  Destructor
       */
                               ~ModelBase();
      int                      GetNumberOfParameters() const;
      std::string              GetName() const;
      std::vector<Parameter>*  GetParameterVector();
      virtual double           Evaluate() = 0;
      virtual ModelBase*       Clone() const = 0;

    protected:
      int                      _numberOfParameters;
      std::string              _name;
      std::vector<Parameter>   _parameterVector;

  };

}

#endif // FITTINO_MODELBASE_H
