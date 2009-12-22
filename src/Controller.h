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

#include "InputFileInterpreterBase.h"

/*! 
 *  \brief Fittino namespace 
 */
namespace Fittino {

  /*! 
   *  \brief Singleton class for controlling the execution flow of Fittino
   */
  class Controller {

    public:
      static Controller*                        GetInstance();

    public:
      /*!
       *  This function initializes Fittino. It takes as input the number and the
       *  vector of command line arguments specified while invocing Fittino.
       */
      void                                      InitializeFittino( int argc, char** argv );
      /*!  
       *  In this function Fittino sets up the configured execution mode.
       *  It is called directly after Controller::InitializeFittino.
       *  Supported modes are sampling, scan or optimization.
       */
      void                                      ExecuteFittino();
      /*!
       *  This function provides the controlled termination of Fittino
       */
      void                                      TerminateFittino();

    protected:
      Controller();
      ~Controller();

    private:
      static Controller*                        _instance;

    private:
      InputFileInterpreterBase::InputFileFormat _inputFileFormat;

  };

}

#endif // FITTINO_CONTROLLER_H
