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

#include <iostream>
#include <sstream>

#include "TDOMParser.h"
#include "TString.h"
#include "TXMLAttr.h"
#include "TXMLDocument.h"
#include "TXMLNode.h"

#include "Configuration.h"
#include "InputFileException.h"
#include "SteeringParameterTemplate.h"
#include "XMLInputFileInterpreter.h"

Fittino::XMLInputFileInterpreter::XMLInputFileInterpreter() {

}

Fittino::XMLInputFileInterpreter::~XMLInputFileInterpreter() {

}

void Fittino::XMLInputFileInterpreter::Parse( const TString& xmlInputFileName ) {

    Configuration* configuration = Configuration::GetInstance();

    TDOMParser* xmlParser = new TDOMParser();
    Int_t parseCode = xmlParser->ParseFile( xmlInputFileName );

    if ( parseCode != 0 ) {

        throw InputFileException( "Parsing of xml document failed" );
        exit( EXIT_FAILURE );

    }
    else {

        std::cout << "\nReading input from file " << xmlInputFileName << "\n" << std::endl;

        TXMLDocument* xmlDocument = xmlParser->GetXMLDocument();
        TXMLNode* xmlRootNode = xmlDocument->GetRootNode();
        TXMLNode* xmlNode = xmlRootNode->GetChildren();

        while ( xmlNode != 0 ) {

            TXMLAttr* xmlAttribute( 0 );
            TListIter attributeIterator( xmlNode->GetAttributes() );

            while ( ( xmlAttribute = ( TXMLAttr* )attributeIterator() )  != 0 ) {

                std::string key = xmlAttribute->GetName();
                std::string name = xmlAttribute->GetName();

                std::stringstream sstr;
                sstr << xmlAttribute->GetValue();

                if ( sstr.eof() ) {

                    int value = 0; sstr >> value;
                    ( *configuration->GetSteeringParameterMap() )[key] = new SteeringParameterTemplate<int>( name, value );

                }
                else {

                    std::string value = ""; sstr >> value;
                    ( *configuration->GetSteeringParameterMap() )[key] = new SteeringParameterTemplate<std::string>( name, value );

                }

            }

            xmlNode = xmlNode->GetNextNode();

        }

    }

}
