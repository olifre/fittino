/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleStringCut.cpp                                              *
*                                                                              *
* Description Base class for cuts                                              *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@cbpf.br>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TFile.h"
#include "TSpline.h"
#include "TDirectory.h"

#include "boost/foreach.hpp"

#include "SimpleStringCut.h"

Fittino::SimpleStringCut::SimpleStringCut( ModelBase* model, const boost::property_tree::ptree& ptree ) 
    : CutBase( ptree ),
      _testValue    ( model->GetCollectionOfStringVariables().At( ptree.get<std::string>( "Quantity" ) )->GetValue() ) {
      
    _mustMatch  =   ptree.get<bool>( "MustMatch", false );
        
    BOOST_FOREACH( const boost::property_tree::ptree::value_type &subnode, ptree ) {
        
        if( subnode.first == "CutValue" ) {
            
            _cutValues.push_back( subnode.second.data() );
        
        }
    
    }
    
}

Fittino::SimpleStringCut::~SimpleStringCut() {

}

bool Fittino::SimpleStringCut::IsPassed() {
    
    bool isMatch = false; 
    for( unsigned int i = 0; i < _cutValues.size(); ++i ) {
        
        if( _testValue == _cutValues.at(i) ) {
        
            isMatch = true;
            break;
        
        }
    
    }
    
    if( isMatch && !_mustMatch ) return false;
    if( !isMatch && _mustMatch ) return false;
    
    return true;

}
