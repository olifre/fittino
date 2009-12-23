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
*	      Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*	      Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

/*! 
 *  \mainpage Fittino Class Reference
 *
 *  This document aims to give an overview on the underlying software
 *  architecture of Fittino. In addition to providing a detailed description
 *  for each of the component classes, the inheritance and collaboration
 *  structure and the individual roles within a certain design pattern are
 *  depicted.
 */

#include "Controller.h"

int main( int argc, char** argv ) {
 
    try {

        Controller* controller = Controller::GetInstance();

	controller->InitializeFittino( argc, argv );
	controller->ExecuteFittino();
	controller->TerminateFittino();

    }
    catch (...) {
        std::cout << "Exception caught by default handler" std::endl;
    }

    return 0;

}
