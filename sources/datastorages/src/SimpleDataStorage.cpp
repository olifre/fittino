/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SimpleDataStorage.cpp                                            *
*                                                                              *
* Description Class for storage of doubles                                     *
*                                                                              *
* Authors     Bjoern Sarrazin  <uhlenbrock@physik.uni-bonn.de>                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <map>
#include <string>

#include "SimpleDataStorage.h"

Fittino::SimpleDataStorage::SimpleDataStorage() {

  _map = new std::map<std::string, double>;

}

Fittino::SimpleDataStorage::~SimpleDataStorage() {

  delete _map;

}

std::map<std::string, double>* Fittino::SimpleDataStorage::GetMap() {

  return _map;

}

const std::map<std::string, double>* Fittino::SimpleDataStorage::GetMap() const {

  return _map;

}

void Fittino::SimpleDataStorage::ReadFile( const std::string& inputFileName ) const {


}
