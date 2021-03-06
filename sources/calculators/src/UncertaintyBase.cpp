/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        UncertaintyBase.cpp                                              *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "UncertaintyBase.h"
#include <boost/property_tree/ptree.hpp>


Fittino::UncertaintyBase::UncertaintyBase(ModelBase const *model, const Measurement *observable, const boost::property_tree::ptree &ptree)
: Quantity( ptree.get<std::string>( "Name", "" ) ) {

    _observable = observable;

}

Fittino::UncertaintyBase::~UncertaintyBase() {

}
