/*******************************************************************************  
 *                                                                              *                      
 * Project     Fittino - A SUSY Parameter Fitting Package                       *             
 *                                                                              *         
 * File        CheckMATE2Calculator.cpp                                         *          
 * Description: Wrapper around CheckMATE                                        * 
 * Authors:     Nanette Range                                                   *           
 *                                                                              *               
 * Licence     This program is free software; you can redistribute it and/or    *            
 *             modify it under the terms of the GNU General Public License as   *  
 *             published by the Free Software Foundation; either version 3 of   *                             
 *             the License, or (at your option) any later version.              *
 *                                                                              *           
 *******************************************************************************/

#include <iostream>
#include <boost/property_tree/ptree.hpp>
#include <fstream>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>
#include "boost/filesystem.hpp"

#include "ModelBase.h"
#include "Executor.h"
#include "LogicException.h"
#include "SimplePrediction.h"
#include "CheckMATE2Calculator.h"

    Fittino::CheckMATE2Calculator::CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model, &ptree )
    ,_inputFile( ptree.get_child("InputFile"), model ) {

        _executable = ptree.get<std::string>( "Executable" );
        _directory = ptree.get<std::string>( "Directory" ); 
        _first = true;

        AddQuantity(new SimplePrediction( "r", "", _r));
        AddOutput( "ErrorIsDominatedByMonteCarloStatistics", _errorIsDominatedByMonteCarloStatistics );
        AddOutput( "TheModelCouldBeExcludedIfYouProvidedMoreInputEvents", _theModelCouldBeExcludedIfYouProvidedMoreInputEvents );
        AddOutput( "Excluded", _excluded ); 

        //todo: only add if CLs is turned on
        AddQuantity(new SimplePrediction( "CLs", "", _cls ) );

    }

Fittino::CheckMATE2Calculator::~CheckMATE2Calculator() {

} 

void Fittino::CheckMATE2Calculator::ReadResult() {

    std::string line;
    std::ifstream file( _directory + "/result.txt" );
    if( !file.is_open() ) throw LogicException( "Cannot open result.txt." );

    getline( file, line );
    if ( ! line.empty() ) throw LogicException( "CheckMATECalculator: Expected empty line. " );

    getline( file, line );
    std::string clsid = "Test: Calculation of CLs from determined signal";
    std::string rid = "Test: Calculation of CLs from determined signal";

    if( _first && line == clsid ) _fullCLs = true;
    else if( _first && line==rid ) _fullCLs = false; 
    else if( _first ) throw LogicException( "CheckMATECalculator: Expected Test line." );

    if( _fullCLs && line != clsid ) throw LogicException( "CheckMATECalculator: Expected CLs test." );
    else if ( !_fullCLs && line !=rid ) throw LogicException( "Expected r test." ); 

    getline( file, line );
    _errorIsDominatedByMonteCarloStatistics = 0;
    _theModelCouldBeExcludedIfYouProvidedMoreInputEvents = 0;

    while( boost::starts_with( line, "Warning:" ) ) {

        if ( line == "Warning: Error is dominated by Monte Carlo statistics!" ) _errorIsDominatedByMonteCarloStatistics = 1; 
        else if ( line == "Warning: The model could be excluded if you provided more input events!" ) _theModelCouldBeExcludedIfYouProvidedMoreInputEvents = 1; 
        else throw LogicException( "CheckMATE2Calculator: Unknown warning: " + line );
        getline( file, line );

    }

    if ( line == "Result: Excluded" ) _excluded = 1;
    else if ( line == "Result: Allowed" ) _excluded = 0;  
    else throw LogicException( "Expected result." );

    getline( file, line );
    clsid = "Result for CLs: cls_min = "; 
    rid = "Result for r: r_max = ";

    if ( _fullCLs ) {

        if ( !boost::starts_with( line, clsid ) ) throw LogicException( "CheckMATECalculator: Expected CLs in result.txt." );
        boost::algorithm::erase_first( line, clsid );
        _cls = std::stod( line );

        getline( file, line );

    }

    if ( !boost::starts_with( line, rid ) ) throw LogicException( "CheckMATECalculator: Expected r in result.txt, got " + line );
    boost::algorithm::erase_first( line, rid );
    _r = std::stod( line );

    getline( file, line );
    if ( !boost::starts_with( line, "SR: " ) ) throw LogicException( "Expected SR." );
    boost::algorithm::erase_first( line, "SR: " );
    _sr = line;

    if ( getline( file, line ) ) throw LogicException( "Expected end of result.txt." );

    file.close();  

}

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

    if ( boost::filesystem::exists( _inputFile.GetName() ) ) boost::filesystem::remove( _inputFile.GetName() );
    if ( boost::filesystem::exists( _directory ) ) boost::filesystem::remove_all( _directory );

    _inputFile.Write();

    Executor executor( _executable, "CheckMATE" );
    executor.AddArgument( _inputFile.GetName() );
    executor.Execute();

    ReadResult();

    _first = false;

}
