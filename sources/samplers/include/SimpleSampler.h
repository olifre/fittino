/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleSampler.h                                                  *
*                                                                              *
* Description Class for simple parameter sampler                               *
*                                                                              *
* Authors     Pia Kullik  <kullik@physik.uni-bonn.de>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SIMPLESAMPLER_H
#define FITTINO_SIMPLESAMPLER_H

#include "SamplerBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for simple parameter sampler.
   */
  class SimpleSampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      SimpleSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SimpleSampler();

      /*! \cond UML */
    private:
      void         ResetValues( unsigned int iParameter );
      /*!
       *  Scans chi2 by iterating over a given parameter.
       */
      void         Scan( unsigned int iParameter );
      /*!
       *  Updates within an iteration of UpdateModel():
       *  - increase the current parameter by the desired increment
       *  - reset all following parameters to their original values
       *  - leave previous parameters unchanged
      */
      void         UpdateValues( unsigned int iParameter );

    private:
      virtual void Execute();
      virtual void PrintSteeringParameters() const;
      /*!
       *  Call Scan() for the last parameter to start the recursion.
       */
      virtual void UpdateModel();

      /*! \endcond UML */

  };

}

#endif // FITTINO_SIMPLESAMPLER_H
