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
 *  \todo <B> Documentation: </B>\n
 *  Long-term: Document the code.\n
 *  Long-term: Write a comprehensive developer's guide.\n
 *  Long-term: Write a comprehensive user's guide.\n
 *
 *  \todo <B> Infrastructure: </B> \n
 *  Long-term: Use an issue tracker like Redmine instead of this list. (Peter?)\n
 *  Long-term: Add tests\n
 *  Long-term: Add all theorycodes to SuperBuild.\n
 *
 *  \todo <B> xml: </B> \n
 *  Update the xml definition file. \n
 *  Integrate xml input file validation to fittino.\n
 *  Find a way to use xml style files online. (Peter?)\n
 *
 *  \todo <B> Calculators: </B> \n
 *  Long-term: Discuss Calculator interface (Mathias).\n
 *  Long-term: Decide if and how to handle default quantities of the calculators.\n
 *  Long-term: Make HiggsBounds/HiggsSignals usable with ifort (Bjoern is working on a proposal)\n
 *  Add HiggsBoundsCalculator (needs threading, look at fittino1 for that).\n
 *  Add HiggsSignalsPartonicInputCalculator.\n
 *  Common base class for different HS calculators.\n
 *  Implement toys in the common base class (or temporarily in HiggsSignalsHECCalculator).\n
 *  Implement the corrrection of the FH decoupling limit (use FormulaCalculator?).\n
 *  Make sure AstroCalculator works with AstroFit database. (Matthias?)\n
 *  Long-term: Add LSPCalculator (a calculator which determines the LSP).\n
 *  Long-term: Add DarkSUSYCalculator.\n
 *  Make all quantity names/branch names configurable?\n
 *  Make configurable if quantities are added to the model/are written to ntuple (especially TreeCalculator but also in general)?\n
 *  Add MadGraphCalculator ( Uddhipan, Alex, Bjoern )\n
 *  Long-term: Add HerwigppCalculator\n
 *
 *  \todo <B> Tools and Plotters: </B>\n
 *  Long-term: Further develop plotters (Mathias).\n
 *  Add toy plots. (Matthias?)\n
 *  Add buggy point removal. (Matthias)\n
 *
 *  \todo <B> Samplers: </B>\n
 *  TreeSampler configuration: Set name of parameter to be used as looping parameter.\n
 *  Common base class for MarkovChainSampler and CorrelatedSampler (Matthias?).\n
 *  Add RandomSampler, a sampler with fixed sampling density (usefull for random grid production).\n
 *  When RandomSampler is implemented, use parameter limits as hard limits in markovchain. Discuss what to do when limit is reached (new random point? mirror point?).\n
 *
 *  \todo <B> Models: </B>\n
 *  Update Observable - Prediction relation.\n
 *  MeasuredErrors: Allow arbitrary number. Give names.\n
 *  Introduce parameter point dependent errors, correlations, covariances.\n
 *  Allow asymmetric errors.\n
 *  Make chi2 a model quantitiy?\n
 */

#ifndef FITTINO_CONTROLLER_H
#define FITTINO_CONTROLLER_H

#include <string>

#include "boost/interprocess/interprocess_fwd.hpp"
#include "PtreeForwardDeclaration.h"

namespace boost {

  namespace interprocess {

    class file_lock;

  }

}

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
      static Controller&           GetInstance();

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

      /*! \cond UML */
    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static Controller*           _instance;

    private:
      /*!
       *  The name of the input file.
       */
      std::string                       _inputFileName;
      std::string                       _lockFileName;
      boost::interprocess::file_lock*   _fileLock;
      boost::interprocess::scoped_lock<boost::interprocess::file_lock>* _scopedLock;
      
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
