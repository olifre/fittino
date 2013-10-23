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
 *  This document aims to give an overview on the underlying software architecture of Fittino. In\n
 *  addition to providing a detailed description for each of the component classes, the\n
 *  inheritance and collaboration structure and the individual roles within a certain design\n
 *  pattern are depicted.
 *
 *  The central object is the Fittino::Controller.
 */

/*!
 *  \todo Long-term: Document the code.
 *  \todo Long-term: Write a comprehensive developer's guide.
 *  \todo Long-term: Write a comprehensive user's guide.
 *  \todo Short-term: Overhaul FindROOT.cmake making use of FindPackageHandleStandardArgs.
 *  \todo Short-term: Write FindGSL.cmake module making use of gsl-config to get the version, the needed libraries etc. Remove explcit linking of -lm -lgslcblas.
 *  \todo Short-term: In xml input files use subtags instead of attributes
 */

//#include <iostream>

#include "Controller.h"
//#include "InputFileException.h"
//#include "SLHAFileException.h"
//#include "ModelCalculatorException.h"
//#include "OptimizerException.h"

using namespace Fittino;

int main( int argc, char** argv ) {

    /*!  
     *  \todo Short-term: Discuss usage of exceptions here.
     */

    //try {

    Controller* controller = Controller::GetInstance();

    controller->InitializeFittino( argc, argv );
    controller->ExecuteFittino();
    controller->TerminateFittino();

    //}
    //catch ( Fittino::InputFileException& inputFileException ) {

    //    std::cout << inputFileException.what() << std::endl;

    //}
    //catch ( Fittino::SLHAFileException& slhaFileException ) {

    //    std::cout << lesHouchesFileException.what() << std::endl;

    //}
    //catch ( Fittino::ModelCalculatorException& modelCalculatorException ) {

    //    std::cout << modelCalculatorException.what() << std::endl;

    //}
    //catch ( Fittino::OptimizerException& optimizerException ) {

    //    std::cout << optimizerException.what() << std::endl;

    //}
    //catch (...) {

    //    std::cout << "Exception caught by default handler" << std::endl;

    //}

    return 0;

}
