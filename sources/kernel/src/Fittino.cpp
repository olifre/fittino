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
//#include "InputFileException.h"
//#include "LesHouchesFileException.h"
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
    //catch ( Fittino::LesHouchesFileException& lesHouchesFileException ) {

    //    std::cout << lesHouchesFileException.what() << std::endl;

    //}
    //catch ( Fittino::ModelCalculatorException& modelCalculatorException ) {

    //    std::cout << modelCalculatorException.what() << std::endl;

    //}
    //catch ( Fittino::OptimizerException& optimizerException ) {

    //    std::cout << optimizerException.what() << std::endl;

    //}
    //catch (...) {

    //    std::cout << "Exception caught by default handler" std::endl;

    //}

    return 0;

}
