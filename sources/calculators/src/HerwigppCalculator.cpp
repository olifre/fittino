/* $Id: HerwigppCalculator.cpp 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/******************************************************************************* 
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *  
 * File        HerwigppCalculator.cpp                                           *
 * Description: Wrapper around Herwig++                                         *
 * Authors:     Nanette Range                                                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include <map>	
#include <iostream>
#include <string>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/filesystem.hpp>

#include "TFile.h"
#include "TMath.h"
#include "TTree.h"
#include "HerwigppCalculator.h"
#include "Executor.h"
#include "LogicException.h"

Fittino::HerwigppCalculator::HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

    _executable = ptree.get<std::string>( "Executable" );
    _inFile = ptree.get<std::string>( "InputFile" );
    std::string run = ptree.get<std::string>( "Run" );
    _numberOfEvents = ptree.get<unsigned int>( "NumberOfEvents" ); 
    
    _runFile = run + ".run";
    _logFile = run + ".log";
    _outFile = run + ".out";

    AddOutput("xs_weighted", _xs_weighted );
    AddOutput("xs_unweighted", _xs_unweighted );
    AddOutput("Error_xs_weighted", _error_xs_weighted );
    AddOutput("Error_xs_unweighted", _error_xs_unweighted );

}

Fittino::HerwigppCalculator::~HerwigppCalculator() {

}

std::istream& Fittino::HerwigppCalculator::GetLine(std::istream& is){

    std::getline( is, _line );
    _words.clear();
    split( _words, _line, boost::is_any_of(" "), boost::token_compress_on );
    return is;

}

void Fittino::HerwigppCalculator::CalculatePredictions() {

    // todo move .out .run .hepmc if they exist

    Executor executorRead( _executable, "Herwig++" ); 
    executorRead.AddArgument( "read" );
    executorRead.AddArgument( _inFile );
    executorRead.Execute();

    Executor executorRun( _executable, "Herwig++" ); 
    executorRun.AddArgument( "run" );
    executorRun.AddArgument( _runFile );
    executorRun.AddArgument( "-N" + std::to_string( _numberOfEvents ) );
    executorRun.AddArgument( "-d1" );
    executorRun.Execute();

    ReadOutFile();
    ReadLogFile();

}

int Fittino::HerwigppCalculator::GetPDGID(std::istream& is, int expectedRunningID) {

    std::string strExpectedRunningID = std::to_string( expectedRunningID );  
    GetLine( is );

    if ( !boost::starts_with(_words[1], strExpectedRunningID ) ) throw LogicException( "Unexpected running ID." );

    // if the particle name is to long, the empty space between the running ID and and the particle name is missing
    if ( _words[1] != strExpectedRunningID ) {

        _words.insert( _words.begin() + 2, _words[1].substr(strExpectedRunningID.size(), _words[1].size() )  );
        _words[1] = strExpectedRunningID; 

    }

    int id = std::stoi( _words[3] );

    GetLine( is );

    return id;

}

void Fittino::HerwigppCalculator::ReadLogFile() {

    unsigned int eventNumber = 1;
    std::string matrixElement;
    int colliding1;
    int colliding2;
    int incoming1;
    int incoming2;
    int intermediate;
    int outgoing1;
    int outgoing2;

    TDirectory* pwd = gDirectory;
    TFile* rootFile = new TFile( "MatrixElements.root", "RECREATE" );
    TTree* tree = new TTree( "Tree", "Tree" );
    tree->Branch( "EventNumber", &eventNumber );
    tree->Branch( "MatrixElement", &matrixElement );
    tree->Branch( "Incoming1", &incoming1 );
    tree->Branch( "Incoming2", &incoming2 );
    tree->Branch( "Intermediate", &intermediate );
    tree->Branch( "Outgoing1", &outgoing1 );
    tree->Branch( "Outgoing2", &outgoing2 );

    std::ifstream logStream( _logFile );

    if ( !logStream.is_open() ) throw LogicException( "Can't open " + _logFile + "." );

    while( GetLine( logStream ) ) {

        if ( _line != "******************************************************************************" ) continue;

        GetLine( logStream );
        if( _words.size() != 8 || _words[0] != "Event" || _words[1]!="number" || _words[5] != "performed" || _words[6] != "by" ) throw LogicException( "Unexpected line, expected event number!" );
        unsigned int thisEventNumber = std::stoi( _words[2] );
        if( thisEventNumber == eventNumber + 1 ) tree->Fill(); 
        else if ( thisEventNumber != eventNumber ) throw LogicException( "Event missing!" );
        eventNumber = thisEventNumber;

        GetLine( logStream );
        if( _line != "==============================================================================") throw LogicException( "Unexpected line, expected seperating line!" );

        GetLine( logStream );
        if( _line != "" ) throw LogicException( "Unexpected line, expected empty line.!" );

        GetLine( logStream );
        if( _line != "--- Colliding particles:" ) throw LogicException( "Unexpected line, expected colliding particles.!" );
        colliding1 = GetPDGID( logStream, 1 );
        colliding2 = GetPDGID( logStream, 2 );

        GetLine( logStream );
        if( _line != "------------------------------------------------------------------------------" ) throw LogicException( "Unexpected line, expected seperating line." );

        GetLine( logStream );
        if ( _words.size() !=5 || _words[0] != "Primary" || _words[1] != "sub-process" || _words[2] != "performed" || _words[3] != "by" ) {

            throw LogicException( "Unexpected line, expected primary sub-process.!" );

        }
        matrixElement = _words[4];

        GetLine( logStream );
        if( _line != "--- incoming:" ) throw LogicException( "Unexpected line, expected incoming particles.!" );
        incoming1 = GetPDGID( logStream, 3 );
        incoming2 = GetPDGID( logStream, 4 );

        GetLine( logStream );
        if( _line != "--- intermediates:" ) throw LogicException( "Unexpected line, expected intermediate particles.!" );
        intermediate = GetPDGID( logStream, 5 );

        GetLine( logStream );
        if( _line != "--- outgoing:" ) throw LogicException( "Unexpected line, expected outgoing particles.!" );
        outgoing1 = GetPDGID( logStream, 6 );
        outgoing2 = GetPDGID( logStream, 7 );

        GetLine( logStream );
        if( _line != "------------------------------------------------------------------------------" ) throw LogicException( "Unexpected line, expected seperating line!" );

    }

    if ( eventNumber > 0 ) tree->Fill();

    tree->Write();
    rootFile->Close();
    delete rootFile;
    pwd->cd();

}

void Fittino::HerwigppCalculator::GetCrossSectionAndUncertainty( std::string input, double& xs, double& error ) {

   std::vector<std::string> significandErrorExponent;
   split( significandErrorExponent, input, boost::is_any_of("()"), boost::token_compress_on );
   
   std::vector<std::string> decimal;
   split( decimal, significandErrorExponent[0], boost::is_any_of("."), boost::token_compress_on );
   
   int numberOfDecimalPlaces;
   if ( decimal.size() == 1 ) numberOfDecimalPlaces = 0; 
   else if ( decimal.size() == 2 )  numberOfDecimalPlaces = decimal.at(1).length();
   else throw LogicException( "Determination of number of decimal places failed." );
   
   xs = std::stod( significandErrorExponent[0] + significandErrorExponent[2] );
   error = std::stod( significandErrorExponent[1] + significandErrorExponent[2] ) * TMath::Power( 10, -1 * numberOfDecimalPlaces );

}

void Fittino::HerwigppCalculator::ReadOutFile() {

    std::ifstream outStream( _outFile );
    if ( !outStream.is_open() ) throw LogicException( "Can't open " + _outFile + ".");
    
    for( unsigned int i = 0; i < 8; ++i ) GetLine( outStream );
    if ( _words.size() != 4 || _words[3] != "(nb)" ) throw LogicException( "Unexpected line, expected cross section to be in nb." );

    for( unsigned int i = 0; i < 2; ++i ) GetLine( outStream );
    std::string xsid = "Total (from   weighted events): including vetoed events";
    if ( !boost::starts_with( _line, xsid ) ) throw LogicException( "Unexpected line, expected cross section from weighted events." );
    GetCrossSectionAndUncertainty( _words[7], _xs_weighted, _error_xs_weighted );

    for( unsigned int i = 0; i < 2; ++i ) GetLine( outStream );
    xsid = "Total (from unweighted events):";
    if ( !boost::starts_with( _line, xsid ) ) throw LogicException( "Unexpected line, expected cross section from unweighted events." );
    GetCrossSectionAndUncertainty( _words[6], _xs_unweighted, _error_xs_unweighted );

}

