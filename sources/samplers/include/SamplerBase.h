/* $Id: SamplerBase.h,v 1.0 2007/10/08 09:37:15 uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SamplerBase.h                                                    *
*                                                                              *
* Description Base class for Fittino parameter samplers                        *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SAMPLERBASE_H
#define FITTINO_SAMPLERBASE_H

#include <string>

#include "AnalysisTool.h"
#include "ModelBase.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \brief Base class for Fittino parameter samplers 
   */
  class SamplerBase : public AnalysisTool {

    public:
      enum         SamplerType { MARKOVCHAIN };

    public:
                   SamplerBase( ModelBase* model );
      virtual      ~SamplerBase();

      /*! \cond UML */
    private:
      virtual void PrintResult() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_SAMPLERBASE_H
