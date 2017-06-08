/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Main.cpp                                                         *
*                                                                              *
* Description Main function                                                    *
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
 *  \mainpage Fittino Class Reference
 *
 *  This document aims to give an overview on the underlying software architecture of Fittino. In\n
 *  addition to providing a detailed description for each of the component classes, the\n
 *  inheritance and collaboration structure and the individual roles within a certain design\n
 *  pattern are depicted.
 *
 *  The central object is the Fittino::Controller.
 */

#include "Controller.h"

#ifdef PYTHON

#include "Python.h"

#endif

int main( int argc, char** argv ) {

#ifdef PYTHON2

    Py_SetProgramName( (char*) PYTHON_EXECUTABLE );
    Py_Initialize();

#endif

#ifdef PYTHON3

    Py_SetProgramName( Py_DecodeLocale( PYTHON_EXECUTABLE, NULL ) );
    Py_Initialize();

#endif

    Fittino::Controller& controller = Fittino::Controller::GetInstance();

    controller.InitializeFittino( argc, argv );
    controller.ExecuteFittino();
    controller.TerminateFittino();

    return 0;

}
