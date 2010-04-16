/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SteeringParameterBase.h                                          *
*                                                                              *
* Description Base class for holding generic steering parameters               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_STEERINGPARAMETERBASE_H
#define FITTINO_STEERINGPARAMETERBASE_H

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Base class for holding generic steering parameters 
   */
  class SteeringParameterBase {

    public:
      /*!
       *  Constructor
       */
      SteeringParameterBase();
      /*!
       *  Destructor
       */
      ~SteeringParameterBase();

  };

}

#endif // FITTINO_STEERINGPARAMETERBASE_H
