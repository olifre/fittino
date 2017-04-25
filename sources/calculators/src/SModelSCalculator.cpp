/* $Id: SModelSCalculator.cpp 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/******************************************************************************* 
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *    
 *                                                                              * 
 * File        SModelSCalculator.cpp                                            *                  
 * Description: Wrapper around SModelS                                          *                                                    
 * Authors:     Nanette Range                                                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *    
 *             modify it under the terms of the GNU General Public License as   *        
 *             published by the Free Software Foundation; either version 3 of   *          
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include <Python.h>
#include <boost/lexical_cast.hpp>
#include <boost/python.hpp>
#include <boost/property_tree/ptree.hpp>
#include <fstream>
#include <iostream>
#include <string>
#include <boost/algorithm/string.hpp>
#include <math.h>

#include "SimplePrediction.h"
#include "SModelSCalculator.h"
#include "Executor.h"

Fittino::SModelSCalculator::SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree)
    : CalculatorBase( model, &ptree ) {

  AddQuantity( new SimplePrediction( "r", "", _r ));
  AddQuantity( new SimplePrediction( "chi2", "", _Chi2));

  std::string parameterFile = "parameters.ini";

    std::string exename = "SModelSToolsExecutable";

#ifdef SModelSTools_EXECUTABLE

    std::string executable = ptree.get<std::string>( exename, SModelSTools_EXECUTABLE );

#else

    if ( ptree.count( exename ) == 0 ) {

        throw ConfigurationException( "SModelSTools was not found. Please set " + exename + " in the input file." );

    }

    std::string executable = ptree.get<std::string>( exename );

#endif

   std::string inputrunTools = "SPheno.spc";

    _executor = new Executor( executable, "smodelsTools.py" );
    _executor->AddArgument( "xseccomputer" );
    _executor->AddArgument( "-f" );
    _executor->AddArgument( inputrunTools );
    _executor->AddArgument( "-p" );
    _executor->AddArgument( "-N" );

//  Py_Initialize();
//  PyRun_SimpleString( ( "parameterFile = '" + parameterFile + "'" ).c_str() );
//  PyRun_SimpleString("from smodels.tools import modelTester");
//  PyRun_SimpleString( "parser = modelTester.getParameters( parameterFile )" );
//  PyRun_SimpleString( "database, databaseVersion = modelTester.loadDatabase(parser, None )" );
//  PyRun_SimpleString( "listOfExpRes = modelTester.loadDatabaseResults(parser, database)" );
//  PyRun_SimpleString( "print '[smodels.cpp] %d experimental results found.' % len(listOfExpRes) " );
//
//  PyRun_SimpleString("from smodels.tools import smodelsLogging");
 
}
Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {

    _executor->Execute();

//    std::string parameterFile = "parameters.ini";
//    std::string inFile = "SPheno.spc";
//  PyRun_SimpleString( ( "inFile = '" + inFile  + "'" ).c_str() );
//  PyRun_SimpleString( "fileList = modelTester.getAllInputFiles( inFile )" );
//  PyRun_SimpleString( "modelTester.testPoints( fileList, inFile, 'results', parser, databaseVersion, listOfExpRes, 900, False, parameterFile )" );

}

void Fittino::SModelSCalculator::Initialize(){


}
