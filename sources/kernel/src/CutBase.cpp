/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CutBase.cpp                                                      *
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

#include <sstream>

#include <boost/property_tree/ptree.hpp>

#include "CutBase.h"

unsigned int Fittino::CutBase::_cutCounter = 0;

Fittino::CutBase::CutBase( const boost::property_tree::ptree& ptree ) {

    _cutNumber = _cutCounter;
    ++_cutCounter;
    std::stringstream namess;
    namess << "CutNumber_ " << _cutNumber;

    _name = ptree.get<std::string>( "Name", namess.str() );

}

unsigned int Fittino::CutBase::GetCutNumber() {

    return _cutNumber;

}

std::string Fittino::CutBase::GetName() {

    return _name;

}

Fittino::CutBase::~CutBase() {

}
