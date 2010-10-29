/* $Id: AnalysisTool.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AnalysisTool.h                                                   *
*                                                                              *
* Description Abstract class which provides basic functionality for analysis   *
*             tools like optimizers or samplers                                *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
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

#include "TRandom.h"

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  class ModelBase;

  /*!
   *  \brief Abstract class which provides basic functionality for analysis tools like optimizers\n
   *  or samplers.
   *
   *  This class contains auxiliary objects needed by every analysis tool such as the tool's name,\n
   *  a pointer to the model to be anlysed, a counter for the number of iteration steps and a\n
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
      void         PerformAnalysis();

    protected:
      /*!
       *  Counts the number of calls to UpdateModel().
       */
      unsigned int _iterationCounter;
      /*!
       *  Name of the analysis tool.
       */
      std::string  _name;
      /*!
       *  Random number generator.
       */
      TRandom      _randomGenerator;
      /*!
       *  Pointer to the model to be analysed. Via this pointer an association between the model\n
       *  and any class deriving from AnalysisTool (especially the concrete optimizer or sampler\n
       *  classes) is established.
       */
      ModelBase*   _model;

    protected:
      /*!
       *  Prints the result of the execution of a particuar analysis tool. It is declared virtual\n
       *  because the result output is different for optimizers and samplers.
       */
      virtual void PrintResult() const = 0;
      /*!
       *  Prints the steering parameters of a particuar analysis tool.
       */
      virtual void PrintSteeringParameters() const = 0;
      /*!
       *  Causes the tool to propose a new model. How this is done has to be specified by any\n
       *  concrete analysis tool.
       */
      virtual void UpdateModel() = 0;

      /*! \cond UML */
    private:
      /*!
       *  Stores the configured criterium of a measure of the goodness of fit is compared to\n
       *  (usually the chi2 of the model).
       */
      double       _abortCriterium;
      /*!
       *  The chi2 of the model.
       */
      double       _chi2;
      /*!
       *  Stores the configured maximal number of iteration steps.
       */
      unsigned int _numberOfIterations;

    private:
      void         ExecuteAnalysisTool();
      void         InitializeAnalysisTool() const;
      void         PrintConfiguration() const;
      void         PrintStatus() const;
      void         TerminateAnalysisTool() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_ANALYSISTOOL_H
