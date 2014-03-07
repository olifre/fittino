/* $Id$ */

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

#include <boost/property_tree/ptree.hpp>
#include "TTree.h"
#include "TFile.h"

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
      TreeSampler( ModelBase* model, const boost::property_tree::ptree& ptree );
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
       *  Switch to enable Toy runs.
       */
      bool                   _isToyRun;
      /*!
       *  Switch to enable determination of best fit values from input file.
       */
      bool                   _determineBestFitValues;
      /*!
       * used to store the content of the output ntuple for a ToyRun:
       */
      double                 _lowestChi2;
      int                    _bestFitIndex;
      double                 _inputLowestChi2;
      int                    _inputBestFitIndex;
      TFile                  *_outputFile;
      TTree                  *_outputTree;
      double                 _currentChi2;
      std::vector<double>    _currentPhysicsParameters;
      int                    _firstIteration;

    private:
      void                   DetermineBestFitValues();

    private:
      virtual void           Execute();
      virtual void           PrintSteeringParameters() const;
      virtual void           UpdateModel();
    
      /*! \endcond UML */

  };

}

#endif // FITTINO_TREESAMPLER_H
