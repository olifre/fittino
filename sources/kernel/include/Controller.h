/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Controller.h                                                     *
*                                                                              *
* Description Singleton class for controlling the execution flow of Fittino    *
*                                                                              *
* Authors     Philip  Bechtle     <philip.bechtle@desy.de>                     *
*             Klaus   Desch       <desch@physik.uni-bonn.de>                   *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

/*!
 *  \todo Long-term: Document the code.
 *  \todo Long-term: Write a comprehensive developer's guide.
 *  \todo Long-term: Write a comprehensive user's guide.
 *  \todo Long-term: Redefine kernel and keep it clean (Mathias).
 *  \todo Long-term: Discuss Calculator interface (Mathias).
 *  \todo Long-term: Discuss Plotters and their relation to other analysis tools.
 *  \todo Check if all branch names are unique (probably in AnalysisTool::InitializeBranches).
 *  \todo TreeSampler configuration: Set name of parameter to be used as looping parameter.
 *  \todo MeasuredErrors: Allow arbitrary number. Give names.
 *  \todo Remove SimpleDataStorage from ModelCalculatorBase.
 *  \todo Update Observable - Prediction relation.
 *  \todo Complete removal of obsolete Configuration.
 *  \todo Remove again the Chi2Contribution.
 *  \todo Rename all ModelCalculators in Calculators (Mathias).
 *  \todo Update the xml definition file.
 *  \todo Make chi2 a model quantitiy?
 *  \todo Make name of chi2 branch configurable.
 *  \todo More general: Make all quantity names/branch names configurable?
 *  \todo Make configurable if quantities are added to the model/are written to ntuple (especially TreeCalculator but also in general)?
 *  \todo Common base class for MarkovChainSampler and CorrelatedSampler.
 *  \todo Add RandomSampler, a sampler with fixed sampling density (usefull for random grid production).
 *  \todo When RandomSampler is implemented, use parameter limits as hard limits in markovchain. Discuss what to do when limit is reached (new random point? mirror point?).
 */

#ifndef FITTINO_CONTROLLER_H
#define FITTINO_CONTROLLER_H

#include <string>

#include "PtreeForwardDeclaration.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup kernel
   */
  /*!
   *  \ingroup kernel
   *  \brief Singleton class for controlling the execution flow of Fittino.
   *
   *  The instance of the Controller class is the first object that is created at the beginning of\n
   *  the execution of Fittino. Depending on the user configuration the controller creates\n
   *  instances of further objects (either directly or with the help of a factory) and advises\n
   *  them to perform the specified tasks, hereby controlling the program's overall execution\n
   *  flow.
   *
   *  The controller adresses its purpose in three distinct phases: At first, the controller\n
   *  initializes Fittino by letting an input file interpreter read in user specified options.\n
   *  After that further objects are created and put into action according to the user's\n
   *  configuration. At the end, the controller provides the controlled termination of Fittino.
   */
  class Controller {

    public:
      /*!
       *  Returns a static pointer to the unique instance of this class.
       */
      static Controller*           GetInstance();

    public:
      /*!
       *  Executes Fittino. For that purpose a model inheriting from ModelBase and the required\n
       *  analysis tools inheriting from AnalysisTool are created and put into action.
       */
      void                         ExecuteFittino() const;
      /*!
       *  Initializes Fittino. Takes as input the command line arguments specified by the user\n
       *  while invocing Fittino and stores them for future reference.
       */
      void                         InitializeFittino( int argc, char** argv );
      /*!
       *  Provides the controlled termination of Fittino.
       */
      void                         TerminateFittino() const;

    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static Controller*           _instance;

      /*! \cond UML */
    private:
      /*!
       *  The name of the input file.
       */
      std::string                  _inputFileName;
      /*!
       *  Property tree which stores the configuration items of Fittino.
       */
      boost::property_tree::ptree* _inputPtree;
      /*!
       *  Property tree which stores the status of Fittino after Execute().
       */
      boost::property_tree::ptree* _outputPtree;

    private:
      /*!
       *  Standard constructor.
       */
      Controller();
      /*!
       *  Standard destructor.
       */
      ~Controller();
      /*!
       *  Check the format of the input file. The supported input file format is XML.
       */
      void                         CheckInputFileFormat() const;
      /*!
       *  Handles the Fittino options given at the command line.
       */
      void                         HandleOptions( int argc, char** argv );
      /*!
       *  When Fittino is called without arguments or with the -h/--help option this method\n
       *  prints a help screen with further instructions on how to use Fittino.
       */
      void                         PrintHelp() const;
      /*!
       *  Prints a welcome logo.
       */
      void                         PrintLogo() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CONTROLLER_H
