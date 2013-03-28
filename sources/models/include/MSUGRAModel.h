/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MSUGRAModel.h                                                    *
*                                                                              *
* Description Implementation of the MSUGRA model                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MSUGRAMODEL_H
#define FITTINO_MSUGRAMODEL_H

#include "PhysicsModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the MSUGRA model.
   */
  class MSUGRAModel : public PhysicsModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                           MSUGRAModel();
      /*!
       *  Standard destructor.
       */
                           ~MSUGRAModel();
      /*!
       *  Virtual copy constructor.
       */
      virtual MSUGRAModel* Clone() const;

  };

}

#endif // FITTINO_MSUGRAMODEL_H
