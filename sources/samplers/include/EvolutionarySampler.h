/* $Id: EvolutionarySampler.h 1692 2013-11-06 11:26:02Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EvolutionarySampler.h                                             *
*                                                                              *
* Description Class for Evolutionary parameter sampler                         *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_EvolutionarySampler_H
#define FITTINO_EvolutionarySampler_H

#include "SamplerBase.h"
#include "Hypothesis.h"

class TBranch;


/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup samplers
   *  \brief Class for Evolutionary parameter sampler.
   */
  class EvolutionarySampler : public SamplerBase {

    public:
      /*!
       *  Standard constructor.
       */
      EvolutionarySampler( ModelBase* model, int randomSeed );
      EvolutionarySampler( ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                             ~EvolutionarySampler();

      /*! \cond UML */
    private:

      unsigned int           _numberOfIterations;
      unsigned int           _numberOfHypotheses;
      std::vector<Hypothesis>  _hypotheses;
      unsigned int           _iterationCounter;
      double                  _chi2;

    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();
      virtual void           SelectParents();
      virtual void           Reproduce();
      virtual void           Mutate(int i);
      virtual void           InitialiseHypotheses();
      virtual double         FitnessFunction(double chi2);

      /*! \endcond UML */

  };

}

#endif // FITTINO_EvolutionarySampler_H
