/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MSSM3Model.h                                                     *
*                                                                              *
* Description A constrained version of MSSM to test SM limit of calculators    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MSSM3MODEL_H
#define FITTINO_MSSM3MODEL_H

#include "PhysicsModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief A constrained version of MSSM to test SM limit of calculators
   */
  class MSSM3Model : public PhysicsModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                          MSSM3Model();
      /*!
       *  Standard destructor.
       */
                          ~MSSM3Model();
      /*!
       *  Virtual copy constructor.
       */
      virtual MSSM3Model* Clone() const;

  };

}

#endif // FITTINO_MSSM3MODEL_H
