/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SteeringParameterTemplate.h                                      *
*                                                                              *
* Description Class template for holding generic steering parameters           *
*                                                                              *
* Authors     Mathias Uhlenrbrock  <uhlenbrock@physik.uni-bonn.de>             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_STEERINGPARAMETERTEMPLATE_H
#define FITTINO_STEERINGPARAMETERTEMPLATE_H

#include <string> 

#include "SteeringParameterBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  template<class SteeringParameterType>

  /*!
   *  \brief Class template for holding generic steering parameters
   */
  class SteeringParameterTemplate : public SteeringParameterBase {

    public:
      /*!
       *  Constructor
       */
      SteeringParameterTemplate( std::string name, SteeringParameterType value ) {

        _name = name;
        _value = value;

      }
      /*!
       *  Destructor
       */
      ~SteeringParameterTemplate();

    protected:
      std::string           _name;
      SteeringParameterType _value;

  };

}

#endif // FITTINO_STEERINGPARAMETERTEMPLATE_H
