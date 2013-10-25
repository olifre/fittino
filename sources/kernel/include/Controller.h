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
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CONTROLLER_H
#define FITTINO_CONTROLLER_H

#include <string>

#include "Configuration.h"

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
      static Controller*              GetInstance();

    public:
      /*!
       *  Initializes Fittino. Takes as input the command line arguments specified by the user\n
       *  while invocing Fittino and stores them for future reference. Then a dedicated input file\n
       *  interpreter inheriting from InputFileInterpreterBase is created and advised to parse the\n
       *  mandatory input file. After that the steering parameters and flags are globally\n
       *  accessible via calls to the Configuration.
       */
      void                            InitializeFittino( int argc, char** argv );
      /*!
       *  Executes Fittino according to the configured execution mode. So far supported modes are\n
       *  parameter sampling or optimization. For that purpose a model inheriting from ModelBase\n
       *  and the required analysis tools inheriting from AnalysisTool are created and put into\n
       *  action.
       */
      void                            ExecuteFittino() const;
      /*!
       *  Provides the controlled termination of Fittino.
       */
      void                            TerminateFittino() const;

    private:
      /*!
       *  Pointer to the unique instance of this class.
       */
      static Controller*              _instance;

      /*! \cond UML */
    private:
      /*!
       *  External seed as passed as an argument to Fittino.
       */
      int                             _randomSeed;
      /*!
       *  The name of the input file.
       */
      std::string                     _inputFileName;
      /*!
       *  The name of the data file.
       */
      std::string                     _dataFileName;
      boost::property_tree::ptree*    _propertyTree;

    private:
      /*!
       *  Standard constructor.
       */
                                      Controller();
      /*!
       *  Standard destructor.
       */
                                      ~Controller();
      void                            HandleOptions( int argc, char** argv );
      /*!
       *  When Fittino is called without arguments or with the -h/--help option this method\n
       *  prints a help screen with further instructions on how to use Fittino.
       */
      void                            PrintHelp() const;
      /*!
       *  Prints a welcome logo.
       */
      void                            PrintLogo() const;
      /*!
       *  Determines the format of the input file. The supported input file format is XML.
       */
      const Configuration::FileFormat DetermineInputFileFormat() const;

      /*! \endcond UML */

  };

}

#endif // FITTINO_CONTROLLER_H
