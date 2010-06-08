/* $Id: XMLInputFileInterpreter.cpp 542 2009-12-23 14:59:43Z wiene $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        XMLInputFileInterpreter.cpp                                      *
*                                                                              *
* Description Class for reading and interpreting XML input files               *
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

#include <cstdlib>
#include <iostream>

#include "TDOMParser.h"
#include "TList.h"
#include "TString.h"
#include "TXMLAttr.h"
#include "TXMLDocument.h"
#include "TXMLNode.h"

#include "Configuration.h"
#include "InputException.h"
#include "XMLInputFileInterpreter.h"

Fittino::XMLInputFileInterpreter::XMLInputFileInterpreter() {

}

Fittino::XMLInputFileInterpreter::~XMLInputFileInterpreter() {

}

void Fittino::XMLInputFileInterpreter::Parse( const TString& xmlInputFileName ) {

    std::cout << "\n  Reading input from file " << xmlInputFileName << "\n" << std::endl;

    // Construct XML DOM parser

    TDOMParser* xmlParser = new TDOMParser();

    // Check if XML input file can be parsed

    Int_t parseCode = xmlParser->ParseFile( xmlInputFileName );

    if ( parseCode != 0 ) {

        throw InputException( "Parsing of xml document failed" );
        exit( EXIT_FAILURE );

    }

    // Loop over the XML DOM tree and add the input data to appropriate lists

    TXMLDocument* xmlDocument = xmlParser->GetXMLDocument();
    TXMLNode* xmlRootNode = xmlDocument->GetRootNode();
    TXMLNode* xmlNode = xmlRootNode->GetChildren();

    while ( xmlNode != 0 ) {

        TXMLAttr* xmlAttribute( 0 );
        TListIter attributeIterator( xmlNode->GetAttributes() );

        while ( ( xmlAttribute = ( TXMLAttr* )attributeIterator() )  != 0 ) {

            Configuration::GetInstance()->AddSteeringParameter( xmlAttribute->GetName(), xmlAttribute->GetValue() );

        }

        xmlNode = xmlNode->GetNextNode();

    }

    delete xmlParser;

}
