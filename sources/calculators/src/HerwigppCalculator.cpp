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
#include "TTree.h"
#include "HerwigppCalculator.h"
#include "Executor.h"
#include "LogicException.h"

Fittino::HerwigppCalculator::HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

    _executable = ptree.get<std::string>( "Executable" );
    _inFile = ptree.get<std::string>( "InputFile" );
    boost::filesystem::path p( _inFile );
    _runFile = p.stem().string() + ".run";
    _logFile = p.stem().string() + ".log";
    _outFile = p.stem().string() + ".out";

    AddOutput("Total_Xsec", _Total_Xsec);
    AddOutput("Total_Xsec_error", _Total_Xsec_error);

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

    Executor executorRead( _executable, "Herwig++" ); 
    executorRead.AddArgument( "read" );
    executorRead.AddArgument( _inFile );
    executorRead.Execute();

    Executor executorRun( _executable, "Herwig++" ); 
    executorRun.AddArgument( "run" );
    executorRun.AddArgument( _runFile );
    executorRun.AddArgument( "-N1000" );
    executorRun.AddArgument( "-d1" );
    executorRun.Execute();

    std::fstream fileOUT;

    fileOUT.open( _outFile ); 
    while( getline( fileOUT, _line ) ){

        typedef std::vector< std::string > split_vector_type;

        split_vector_type SplitVec;
        split( SplitVec, _line, boost::is_any_of(" "), boost::token_compress_on);

        if( SplitVec.size() > 5 ){
            if ( SplitVec[0] == "Total" ){
                if( SplitVec[2] == "unweighted" ){

                    std::string Total_Xsec = SplitVec[6]; 
                    split_vector_type SplitVecNumber;
                    split( SplitVecNumber, Total_Xsec, boost::is_any_of("()"), boost::token_compress_on);
                    std::string number1 = SplitVecNumber[0];
                    std::string number3 = SplitVecNumber[2];
                    std::string total_xsec = number1 + number3;  
                    _Total_Xsec = boost::lexical_cast<double>(total_xsec);

                    std::string number2 = SplitVecNumber[1];
                    std::string total_xsec_error = number2 + number3;
                    _Total_Xsec_error = boost::lexical_cast<double>(total_xsec_error);

                }
            }
        }
    }

    fileOUT.close();

    std::fstream fileLOG;

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
    TFile *MyFile = new TFile( "MatrixElements.root", "RECREATE" );
    TTree *tree = new TTree( "Tree", "Tree" );
    tree->Branch ( "EventNumber", &eventNumber );
    tree->Branch ( "MatrixElement", &matrixElement );
    tree->Branch( "Incoming1", &incoming1 );
    tree->Branch( "Incoming2", &incoming2 );
    tree->Branch( "Intermediate", &intermediate );
    tree->Branch( "Outgoing1", &outgoing1 );
    tree->Branch( "Outgoing2", &outgoing2 );

    fileLOG.open( _logFile );

    while( GetLine( fileLOG ) ) {

        if ( _line != "******************************************************************************" ) continue;

        GetLine( fileLOG );
        if( _words.size() != 8 || _words[0] != "Event" || _words[1]!="number" || _words[5] != "performed" || _words[6] != "by" ) throw LogicException( "Unexpected line, expected event number!" );
        unsigned int thisEventNumber = std::stoi( _words[2] );
        if( thisEventNumber == eventNumber + 1 ) tree->Fill(); 
        else if ( thisEventNumber != eventNumber ) throw LogicException( "Event missing!" );
        eventNumber = thisEventNumber;

        GetLine( fileLOG );
        if( _line != "==============================================================================") throw LogicException( "Unexpected line, expected seperating line!" );

        GetLine( fileLOG );
        if( _line != "" ) throw LogicException( "Unexpected line, expected empty line.!" );

        GetLine( fileLOG );
        if( _line != "--- Colliding particles:" ) throw LogicException( "Unexpected line, expected colliding particles.!" );
        colliding1 = GetPDGID( fileLOG, 1 );
        colliding2 = GetPDGID( fileLOG, 2 );

        GetLine( fileLOG );
        if( _line != "------------------------------------------------------------------------------" ) throw LogicException( "Unexpected line, expected seperating line." );

        GetLine( fileLOG );
        if ( _words.size() !=5 || _words[0] != "Primary" || _words[1] != "sub-process" || _words[2] != "performed" || _words[3] != "by" ) {

            throw LogicException( "Unexpected line, expected primary sub-process.!" );

        }
        matrixElement = _words[4];

        GetLine( fileLOG );
        if( _line != "--- incoming:" ) throw LogicException( "Unexpected line, expected incoming particles.!" );
        incoming1 = GetPDGID( fileLOG, 3 );
        incoming2 = GetPDGID( fileLOG, 4 );

        GetLine( fileLOG );
        if( _line != "--- intermediates:" ) throw LogicException( "Unexpected line, expected intermediate particles.!" );
        intermediate = GetPDGID( fileLOG, 5 );

        GetLine( fileLOG );
        if( _line != "--- outgoing:" ) throw LogicException( "Unexpected line, expected outgoing particles.!" );
        outgoing1 = GetPDGID( fileLOG, 6 );
        outgoing2 = GetPDGID( fileLOG, 7 );

        GetLine( fileLOG );
        if( _line != "------------------------------------------------------------------------------" ) throw LogicException( "Unexpected line, expected seperating line!" );

    }

    if ( eventNumber > 0 ) tree->Fill();

    fileLOG.close();

    tree-> Write();

    MyFile-> Close();
    delete MyFile;
    pwd->cd();

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

void Fittino::HerwigppCalculator::Initialize(){

}
