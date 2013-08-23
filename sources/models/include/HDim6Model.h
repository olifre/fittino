/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6Model.h                                                     *
*                                                                              *
* Description Implementation of the HDim6 model                                *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HDIM6MODEL_H
#define FITTINO_HDIM6MODEL_H

#include "PhysicsModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the HDim6 model.
   */
  class HDim6Model : public PhysicsModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                        HDim6Model();
      /*!
       *  Standard destructor.
       */
                        ~HDim6Model();
      /*!
       *  Virtual copy constructor.
       */
      virtual HDim6Model* Clone() const;

  };

}

#endif // FITTINO_HDIM6MODEL_H
