/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CMSSMModel.h                                                     *
*                                                                              *
* Description Implementation of the CMSSM model                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CMSSMMODEL_H
#define FITTINO_CMSSMMODEL_H

#include "PhysicsModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the CMSSM model.
   */
  class CMSSMModel : public PhysicsModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                          CMSSMModel();
      /*!
       *  Standard destructor.
       */
                          ~CMSSMModel();
      /*!
       *  Virtual copy constructor.
       */
      virtual CMSSMModel* Clone() const;

  };

}

#endif // FITTINO_CMSSMMODEL_H
