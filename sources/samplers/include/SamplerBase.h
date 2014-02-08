/* $Id$ */

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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SAMPLERBASE_H
#define FITTINO_SAMPLERBASE_H

#include "AnalysisTool.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup samplers
   */
  /*!
   *  \ingroup samplers
   *  \brief Base class for Fittino parameter samplers.
   */
  class SamplerBase : public AnalysisTool {

    public:
      /*!
       *  Takes as input a pointer to the model to be analysed. Via this pointer an association\n
       *  between a model and the concrete sampler is established.
       */
      SamplerBase( ModelBase *model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      virtual      ~SamplerBase();

      /*! \cond UML */
    private:
      virtual void PrintResult() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_SAMPLERBASE_H
