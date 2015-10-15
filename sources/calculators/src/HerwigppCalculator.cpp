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

void Fittino::HerwigppCalculator::CalculatePredictions() {

  Executor executorRead( _executable, "Herwig++" ); 
  executorRead.AddArgument( "read" );
  executorRead.AddArgument( _inFile );
  std::cout<<"Read"<<std::endl;
  executorRead.Execute();

  Executor executorRun( _executable, "Herwig++" ); 
  executorRun.AddArgument( "run" );
  executorRun.AddArgument( _runFile );
  executorRun.AddArgument( "-N1000" );
  executorRun.AddArgument( "-d1" );
  std::cout<<"Run"<<std::endl;
  executorRun.Execute();
  std::cout<<"Finished"<<std::endl;

  std::fstream fileOUT;
  std::string line;

  fileOUT.open( _outFile ); 
  while( getline( fileOUT, line ) ){

    typedef std::vector< std::string > split_vector_type;
      
      split_vector_type SplitVec;
      split( SplitVec, line, boost::is_any_of(" "), boost::token_compress_on);

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
  
  std::string Event_Number = "1";
  int event_number = 1;
  int last_event_number = 1;

  std::string Matrix_Element;
  std::string Last_Matrix_Element;
  
  TDirectory* pwd = gDirectory;

  TFile *MyFile = new TFile( "MatrixElements.root", "RECREATE" );
  if( MyFile-> IsOpen() ) {
    
    TTree *tree = new TTree( "event_number", "Matrix_Element" );
    tree-> Branch ( "event_number", &last_event_number );
    tree-> Branch ( "Matrix_Element", &Last_Matrix_Element );


    fileLOG.open( _logFile );
  
    while( getline( fileLOG, line )) {
 
      typedef std::vector<std::string> split_vector_type;
      split_vector_type SplitVector;
      split( SplitVector, line, boost::is_any_of(" "), boost::token_compress_on );
    
      if( SplitVector.size() > 1 ) {
		
	if( SplitVector[0] == "Event" ) {
	  if( SplitVector[1] == "number" ) {
	    if( SplitVector[5] == "performed" ) {
	    
	      Event_Number = SplitVector[2]; 
	      event_number = boost::lexical_cast<double>(Event_Number);
	    
	    }
	  }
	}

	if( SplitVector[0] == "Primary" ) {
	  if( SplitVector[1] == "sub-process" ) {
	    if( SplitVector[2] == "performed" ) {
	    
	      Matrix_Element = SplitVector[4];
	       
	      if( event_number != last_event_number ) {
	      
		split_vector_type SplitMatrixElement;
		split( SplitMatrixElement, Matrix_Element, boost::is_any_of("~"), boost::token_compress_on );
		
		std::string sparticle1 = SplitMatrixElement[1];
		std::string sparticle2 = SplitMatrixElement[2];

		std::cout << "sparticle1: " << sparticle1 << ", sparticle2: " << sparticle2 << std::endl; 
		
		tree->Fill();
	  
	      }

	      last_event_number = event_number;
	      Last_Matrix_Element = Matrix_Element;
	    
	    }
  	  }
  	}  
      } 
    }
    
    tree->Fill();

    fileLOG.close();

    tree-> Write();

  }

  MyFile-> Close();
  delete MyFile;
  pwd->cd();


 }

void Fittino::HerwigppCalculator::Initialize(){

}
