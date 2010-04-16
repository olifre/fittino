/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.h                                                *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenrbrock@physik.uni-bonn.de>             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ROSENBROCKMODEL_H
#define FITTINO_ROSENBROCKMODEL_H

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Implementation of the Rosenbrock model 
   */
  class RosenbrockModel : public ModelBase {

    public:
      /*!
       *  Constructor
       */
      RosenbrockModel();
      /*!
       *  Destructor
       */
      ~RosenbrockModel();

  };

}

#endif // FITTINO_ROSENBROCKMODEL_H
