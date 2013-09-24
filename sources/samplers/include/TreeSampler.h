/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeSampler.h                                                    *
*                                                                              *
* Description Class for Tree sampler - to be used in PP                        *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of       *
*	      the License, or (at your option) any later version.                  *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TREESAMPLER_H
#define FITTINO_TREESAMPLER_H

#include "SamplerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for Tree sampler.
   */
  class TreeSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
                             TreeSampler( ModelBase* model );
      /*!
       *  Standard destructor.
       */
                             ~TreeSampler();

      /*! \cond UML */
    private:
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int           _numberOfIterations;

      /*!
       *  Used to count how often a point is accepted.
       */

    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_TREESAMPLER_H
