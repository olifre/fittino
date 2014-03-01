/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SLHALine.h                                                       *
*                                                                              *
* Description Stores information of one line of an SLHA file                   *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "boost/format.hpp"

#include "ModelBase.h"
#include "SLHALine.h"

Fittino::SLHALine::SLHALine( const boost::property_tree::ptree& ptree, const ModelBase* model )
    : _value  ( model->GetCollectionOfQuantities().At( ptree.get<std::string>( "Value" ) )->GetValue() ),
      _block  ( ptree.get<std::string>( "Block" ) ),
      _comment( ptree.get<std::string>( "Comment", "# " + ptree.get<std::string>( "Value" ) ) ),
      _index  ( ptree.get<std::string>( "Index" ) ) {

}

Fittino::SLHALine::~SLHALine() {

}

std::string Fittino::SLHALine::GetBlock() const {

    return _block;

}

std::string Fittino::SLHALine::GetIndex() const {

    return _index;

}

std::string Fittino::SLHALine::GetComment() const {

    return _comment;

}

std::string Fittino::SLHALine::GetValue() const {

    return ( boost::format( "%.8e" ) % _value ).str();

}
