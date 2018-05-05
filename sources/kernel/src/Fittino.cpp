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

#ifdef PYTHON2

#include <boost/python.hpp>

#endif

#ifdef PYTHON

#include "Python.h"

#endif

#include "Controller.h"

int main( int argc, char** argv ) {

#ifdef PYTHON2

    Py_SetProgramName( (char*) PYTHON_EXECUTABLE );
    Py_Initialize();

    char * args[] = { (char*) "", nullptr };

  //  wchar_t *args2[] = { L"", nullptr };

    PySys_SetArgvEx(0, args, 0);




#endif

#ifdef PYTHON3

    Py_SetProgramName( Py_DecodeLocale( PYTHON_EXECUTABLE, NULL ) );
    Py_Initialize();

#endif

    Fittino::Controller& controller = Fittino::Controller::GetInstance();

#ifdef PYTHON2

try {

#endif

    controller.InitializeFittino( argc, argv );
    controller.ExecuteFittino();
    controller.TerminateFittino();


#ifdef PYTHON2
}
catch (boost::python::error_already_set&) {
     PyErr_Print();
     throw;
 }

#endif

    return 0;

}
