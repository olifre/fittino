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

void Fittino::HerwigppCalculator::AddParticle( std::map<std::string, int>& map,std::string name, int id, bool addAntiParticle ) {

    if ( !map.insert( std::make_pair( name, id ) ).second ) {

        throw LogicException("Particle " + name + " has already been added." );

    }     

    if ( !addAntiParticle ) return;

    if ( name.back() == '-' ) {

        name.pop_back();
        name += "+";

    }
    else if ( name.back() == '+' ) {

        name.pop_back();
        name += "-";

    }
    else {
        name += "bar";
    }

    if ( !map.insert( std::make_pair( name, id ) ).second ) {

        throw LogicException( "Antiparticle " + name + "has already been added." );

    }     



}

void Fittino::HerwigppCalculator::InitializeParticleMaps(){

    AddParticle( _sm, "e-"   ,  11 );
    AddParticle( _sm, "nu_e" ,  12 );
    AddParticle( _sm, "mu-"  ,  13 );
    AddParticle( _sm, "nu_mu",  14 );
    AddParticle( _sm, "tau"  ,  15 );
    AddParticle( _sm, "nu_tau", 16 );

    AddParticle( _sm, "d", 1 );
    AddParticle( _sm, "u", 2 );
    AddParticle( _sm, "s", 3 );
    AddParticle( _sm, "c", 4 );
    AddParticle( _sm, "b", 5 );
    AddParticle( _sm, "t", 6 );

    AddParticle( _sm, "g", 21, false );
    AddParticle( _sm, "gamma", 22, false );
    AddParticle( _sm, "Z0", 23, false );
    AddParticle( _sm, "W+", 24, true );
    AddParticle( _sm, "h0", 25, false );

    _susy = _sm;

    AddParticle( _susy, "H0", 35, false );  
    AddParticle( _susy, "A0", 36, false );  
    AddParticle( _susy, "H+", 37, true );  

    AddParticle( _susy, "~d_L", 1000001 );
    AddParticle( _susy, "~u_L", 1000002 );
    AddParticle( _susy, "~s_L", 1000003 );
    AddParticle( _susy, "~c_L", 1000004 );
    AddParticle( _susy, "~b_L", 1000005 );
    AddParticle( _susy, "~t_L", 1000006 );

    AddParticle( _susy, "~e_L-", 1000011 );
    AddParticle( _susy, "~nu_eL", 1000012 );
    AddParticle( _susy, "~mu_L-", 1000013 );
    AddParticle( _susy, "~nu_muL", 1000014 );
    AddParticle( _susy, "~tau_1-", 1000015 );
    AddParticle( _susy, "~nu_tauL", 1000016 );

    AddParticle( _susy, "~g", 1000021, false );
    AddParticle( _susy, "~chi_10", 1000022, false );
    AddParticle( _susy, "~chi_20", 1000023, false );
    AddParticle( _susy, "~chi_1+", 1000024, true );
    AddParticle( _susy, "~chi_30", 1000025, false );
    AddParticle( _susy, "~chi_40", 1000035, false );
    AddParticle( _susy, "~chi_2+", 1000037, true );
    AddParticle( _susy, "~gravitino", 1000039, false );

    AddParticle( _susy, "~d_R", 2000001 );
    AddParticle( _susy, "~u_R", 2000002 );
    AddParticle( _susy, "~s_R", 2000003 );
    AddParticle( _susy, "~c_R", 2000004 );
    AddParticle( _susy, "~b_R", 2000005 );
    AddParticle( _susy, "~t_R", 2000006 );

    AddParticle( _susy, "~e_R-", 2000011 );
    AddParticle( _susy, "~mu_R-", 2000013 );
    AddParticle( _susy, "~tau_2-", 2000015 );


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
    std::cout<<"Read"<<std::endl;
    //  executorRead.Execute();

    Executor executorRun( _executable, "Herwig++" ); 
    executorRun.AddArgument( "run" );
    executorRun.AddArgument( _runFile );
    executorRun.AddArgument( "-N1000" );
    executorRun.AddArgument( "-d1" );
    std::cout<<"Run"<<std::endl;
    // executorRun.Execute();
    std::cout<<"Finished"<<std::endl;
    std::cout<<"Finished"<<std::endl;

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
    bool primarySubprocess( false );  
    int incoming1;
    int incoming2;
    TDirectory* pwd = gDirectory;

    TFile *MyFile = new TFile( "MatrixElements.root", "RECREATE" );

    TTree *tree = new TTree( "Tree", "Tree" );
    tree-> Branch ( "EventNumber", &eventNumber );
    tree-> Branch ( "MatrixElement", &matrixElement );
    tree->Branch("IncomingParticle1", &incoming1 );
    tree->Branch("IncomingParticle2", &incoming2 );


    fileLOG.open( _logFile );

    while( GetLine( fileLOG ) ) {

        if( _words.size() > 6 && _words[0] == "Event" && _words[1]=="number" && _words[5] == "performed" && _words[6] == "by" ) {

            unsigned int thisEventNumber = std::stoi( _words[2] );

            if( thisEventNumber == eventNumber + 1 ) tree->Fill(); 
            else if ( thisEventNumber != eventNumber ) throw LogicException( "Event missing!" );

            eventNumber = thisEventNumber;

            for ( unsigned int i = 0; i < 9; i++ ) GetLine( fileLOG );

            if ( _words.size() !=5 || _words[0] != "Primary" || _words[1] != "sub-process" || _words[2] != "performed" || _words[3] != "by" ) {

                throw LogicException( "Unexpected line!" );

            }

            matrixElement = _words[4];

            GetLine( fileLOG );

            if( _line != "--- incoming:" ) throw LogicException( "Unexpected line!" );
            
            incoming1 = GetPDGID( fileLOG, 3 );
            incoming2 = GetPDGID( fileLOG, 4 );

        }

    }

    if ( eventNumber > 0 ) tree->Fill();

    fileLOG.close();

    tree-> Write();

    MyFile-> Close();
    delete MyFile;
    pwd->cd();

}

int Fittino::HerwigppCalculator::GetPDGID(std::istream& is, int expectedRunningID) {

    GetLine( is );

    int runningID = std::stoi( _words[1] );
    if ( runningID != expectedRunningID ) throw LogicException( "Unexpected running ID." );

    int id = std::stoi( _words[3] );
    
    GetLine( is );

    return id;

}

void Fittino::HerwigppCalculator::Initialize(){

}
