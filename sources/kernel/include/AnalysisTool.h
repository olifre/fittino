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
   *  \brief Abstract class which provides basic functionality for analysis tools like optimizers or
   *  samplers
   */
  class AnalysisTool {

    public:
      /*!
       *  Standard constructor.
       */
                   AnalysisTool( ModelBase* model );

      /*!
       *  Standard destructor.
       */
                   ~AnalysisTool();
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
       *  Random generator.
       */
      TRandom      _randomGenerator;
      /*!
       *  Pointer to the model to be analysed.
       */
      ModelBase*   _model;

    protected:
      virtual void PrintResult() const = 0;
      virtual void PrintSteeringParameters() const = 0;
      /*!
       *  This method is described here.
       */
      virtual void UpdateModel() = 0;

      /*! \cond UML */
    private:
      double       _abortCriterium;
      double       _chi2;
      unsigned int _numberOfIterations;

    private:
      void         ExecuteAnalysisTool();
      void         InitializeAnalysisTool();
      void         PrintConfiguration() const;
      void         PrintStatus() const;
      void         TerminateAnalysisTool() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_ANALYSISTOOL_H
