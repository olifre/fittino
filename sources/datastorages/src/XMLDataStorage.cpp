/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        XMLDataStorage.cpp                                               *
*                                                                              *
* Description Class for XML data storage                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
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
#include "TXMLAttr.h"
#include "TXMLDocument.h"
#include "TXMLNode.h"

#include "Configuration.h"
#include "InputException.h"
#include "Messenger.h"

#include "XMLDataStorage.h"

Fittino::XMLDataStorage::XMLDataStorage() {

}

Fittino::XMLDataStorage::~XMLDataStorage() {

}

void Fittino::XMLDataStorage::ReadFile( const std::string& xmlInputFileName ) const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Reading configuration from file " << xmlInputFileName << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    // Construct XML DOM parser.

    TDOMParser* const xmlParser = new TDOMParser();

    // Switch on XML file validation.

    xmlParser->SetValidate();

    // Check if XML input file can be parsed.

    const Int_t parseCode = xmlParser->ParseFile( xmlInputFileName.c_str() );

    if ( parseCode != 0 ) {

        throw InputException( "Parsing of xml document failed" );

    }

    // Loop over the XML DOM tree and add the input data to appropriate lists.

    const TXMLDocument* const xmlDocument = xmlParser->GetXMLDocument();
    TXMLNode* const xmlRootNode = xmlDocument->GetRootNode();
    TXMLNode* xmlNode = xmlRootNode->GetChildren();

    while ( xmlNode != 0 ) {

        TXMLAttr* xmlAttribute( 0 );

        //if ( xmlNode->GetNodeType() == TXMLNode::kXMLElementNode )
        //std::cout << "node name = " << xmlNode->GetNodeName() << std::endl;

        TListIter attributeIterator( xmlNode->GetAttributes() );

        while ( ( xmlAttribute = ( TXMLAttr* )attributeIterator() ) != 0 ) {

            Configuration::GetInstance()->AddSteeringParameter( xmlAttribute->GetName(), xmlAttribute->GetValue() );

        }

        if      ( xmlNode->HasChildren() ) xmlNode = xmlNode->GetChildren();
        else if ( xmlNode->HasNextNode() ) xmlNode = xmlNode->GetNextNode();
        else if ( xmlNode->HasParent()   ) xmlNode = xmlNode->GetParent()->GetNextNode();
        else throw InputException( "Found inconsistency in XML input file" );

    }

    delete xmlParser;

    Configuration::GetInstance()->ReadFile( xmlInputFileName );

}
