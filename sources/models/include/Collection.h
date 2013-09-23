/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CollectionBase.h                                                 *
*                                                                              *
* Description Template for collection classes                                  *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef COLLECTION_H
#define COLLECTION_H

#include <map>
#include <string>
#include <vector>

namespace Fittino {

  template<class T>
    class Collection {

  public:
                                    Collection();
    virtual                         ~Collection();
    void                            AddElement( const std::string& name, const T& element );
    const T&                        At( int index ) const;
    const T&                        At( std::string name ) const;

  public:  
    const std::map<std::string, T>* GetMap() const;
    const std::vector<T>*           GetVector() const;

  private:  
    std::map<std::string, T>        _map;
    std::vector<T>                  _vector;

  };

}

template<class T>
Fittino::Collection<T>::Collection() {

}

template<class T>
Fittino::Collection<T>::~Collection() {

}

template<class T>
void Fittino::Collection<T>::AddElement( const std::string& name, const T& element ){

  _vector.push_back( element );

  std::pair<std::string,T> pair( name, element );
  _map.insert( pair );

}

template<class T>
const std::map<std::string,T>* Fittino::Collection<T>::GetMap() const {

  return &_map;

}

template<class T>
const std::vector<T>* Fittino::Collection<T>::GetVector() const {

  return &_vector;

}

template<class T>
const T& Fittino::Collection<T>::At( int index ) const {

  return _vector.at( index );

}

template<class T>
const T& Fittino::Collection<T>::At( std::string name ) const {

  return _map.at( name );

}

#endif

