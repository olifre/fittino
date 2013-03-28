/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HECModel.h                                                       *
*                                                                              *
* Description Implementation of the HEC model                                  *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HECMODEL_H
#define FITTINO_HECMODEL_H

#include "PhysicsModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the HEC model.
   */
  class HECModel : public PhysicsModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                        HECModel();
      /*!
       *  Standard destructor.
       */
                        ~HECModel();
      /*!
       *  Virtual copy constructor.
       */
      virtual HECModel* Clone() const;

  };

}

#endif // FITTINO_HECMODEL_H
