/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AnalysisTool.h                                                   *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ANALYSISTOOL_H
#define FITTINO_ANALYSISTOOL_H

#include <string>
#include <vector>

#include "TFile.h"
#include "TRandom.h"

class TTree;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class ModelBase;
  class ParameterBase;

  /*!
   *  \ingroup kernel
   *  \brief Abstract class which provides basic functionality for analysis tools like optimizers or
   *  samplers.
   *
   *  This class contains auxiliary objects needed by every analysis tool such as the tool's name,\n
   *  a pointer to the model to be analysed, a counter for the number of iteration steps and a\n
   *  random number generator.
   */
  class AnalysisTool {

    public:
      /*!
       *  Takes as input a pointer to the model to be analysed. Via this pointer an association\n
       *  between a model and any class deriving from AnalysisTool (especially the concrete\n
       *  optimizer or sampler classes) is established.
       */
                                         AnalysisTool( ModelBase* model );
      /*!
       *  Standard destructor.
       */
                                         ~AnalysisTool();
      /*!
       *  Template method . It subdivides the tool's exectution into three
       *  It is usually called directly after the creation of a concrete analysis tool.
       */ 
      void                               PerformAnalysis();

    protected:
      /*!
       *  The chi2 of the model.
       */
      double                             _chi2;
      /*!
       *  Counts the number of calls to UpdateModel().
       */
      unsigned int                       _iterationCounter;
      /*!
       *  Name of the analysis tool.
       */
      std::string                        _name;
      /*!
       *  Random number generator.
       */
      TRandom                            _randomGenerator;
      /*!
       *  Pointer to the model to be analysed. Via this pointer an association between the model\n
       *  and any class deriving from AnalysisTool (especially the concrete optimizer or sampler\n
       *  classes) is established.
       */
      ModelBase*                         _model;
      /*!
       *  Stores the status parameters.
       */
      std::vector<ParameterBase*>        _statusParameterVector;

    protected:
      /*!
       *  Prints the result of the execution of a particuar analysis tool. It is declared virtual\n
       *  because the result output is different for optimizers and samplers.
       */
      virtual void                       PrintResult() const = 0;
      /*!
       *  Prints the steering parameters of a particuar analysis tool.
       *  \todo Short-term: Write a function that does always the correct formatting.
       */
      virtual void                       PrintSteeringParameters() const = 0;
      /*!
       *  Causes the tool to propose a new model. How this is done has to be specified by any\n
       *  concrete analysis tool.
       */
      virtual void                       UpdateModel() = 0;

    protected:
      /*!
       *  Returns the number of status parameters.
       */
      int                                GetNumberOfStatusParameters() const;
      /*!
       *  Saves the tool's current status (steering parameters, model parameters and observable\n
       *  predictions at a certain iteration step) which is eventually written to an output file.\n
       *  At which point of the analysis this is done has to be specified by any concrete analysis\n
       *  tool.
       */
      void                               FillTree();
      /*!
       *  Prints the tool's status to screen.
       */
      void                               PrintStatus() const;
      /*!
       *  Returns the status parameters as a vector.
       */
      const std::vector<ParameterBase*>* GetStatusParameterVector() const;

      /*! \cond UML */
    private:
      std::vector<float>                 _leafVector;
      /*!
       *  A ROOT file which stores the tool's output. The default name of the file is\n
       *  "Fittino.out.root".
       */
      TFile                              _outputFile;
      TTree*                             _tree;

    private:
      virtual void                       Execute() = 0;

    private:
      void                               ExecuteAnalysisTool();
      void                               InitializeAnalysisTool();
      void                               InitializeBranches();
      void                               PrintConfiguration() const;
      void                               TerminateAnalysisTool();
      void                               WriteResultToFile() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_ANALYSISTOOL_H