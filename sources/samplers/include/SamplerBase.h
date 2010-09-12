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

#include <TRandom.h>

#include "ModelBase.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \brief Base class for Fittino parameter samplers 
   */
  class SamplerBase {

    public:
      enum         SamplerType { MARKOVCHAIN };

    public:
                   SamplerBase( ModelBase* model );
      virtual      ~SamplerBase();
      void         PerformSampling();

    protected:
      std::string  _name;
      TRandom      _randomGenerator;
      ModelBase*   _model;

    protected:
      virtual void PrintSteeringParameters() const = 0;
      virtual void UpdateModel() = 0;

      /*! \cond UML */
    private:
      double       _abortCriterium;
      double       _chi2;
      unsigned int _iterationCounter;
      unsigned int _numberOfIterations;

    private:
      void         ExecuteSampler();
      void         InitializeSampler();
      void         PrintConfiguration() const;
      void         PrintResult() const;
      void         PrintStatus() const;
      void         TerminateSampler() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_SAMPLERBASE_H
