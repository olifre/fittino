/* $Id: Controller.h 572 2010-02-24 22:43:57Z uhlenbrock $ */

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

#include "InputFileInterpreterBase.h"

/*! 
 *  \todo Mid-term: Make objects configurable via steering parameters
 *
 *  \todo Mid-term: Create classes to handle output
 *
 *  \todo Short-term: Create class to handle messages 
 */

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  /*! 
   *  \brief Singleton class for controlling the execution flow of Fittino
   */
  class Controller {

    public:
      static Controller*                              GetInstance();

    public:
      /*!
       *  This function initializes Fittino. It takes as input the number and the vector of\n
       *  command line arguments specified while invocing Fittino.
       */
      void                                            InitializeFittino( int argc, char** argv );
      /*!  
       *  In this function Fittino sets up the configured execution mode. It is called directly\n
       *  after Controller::InitializeFittino. Supported modes are sampling, scan or optimization.
       */
      void                                            ExecuteFittino() const;
      /*!
       *  This function provides the controlled termination of Fittino
       */
      void                                            TerminateFittino() const;

    private:
      static Controller*                              _instance;

      /*! \cond UML */
    private:
      /*!
       *  External seed as passed as an argument to Fittino.
       */
      int                                             _randomSeed;
      /*!
       *  The name of the input file. 
       */
      std::string                                     _inputFileName;

    private:
      /*!
       *  Constructor.
       */
                                                      Controller();
      /*!
       *  Destructor.
       */
                                                      ~Controller();
      /*!
       *  When Fittino is called without arguments or with the -h/--help option this method\n
       *  prints a help screen with further instructions on how to use Fittino. 
       */
      void                                            PrintHelp() const;
      /*!
       *  Prints a welcome screen. 
       */
      void                                            PrintLogo() const;
      /*!
       *  Determines the format of the input file. Supported input file formats are .xml or .ftn\n
       *  (a special Fittino file format)
       */
      const InputFileInterpreterBase::InputFileFormat DetermineInputFileFormat() const;
      /*! \endcond UML */

  };

}

#endif // FITTINO_CONTROLLER_H
