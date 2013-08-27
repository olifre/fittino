/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CollectionBase.h                                                 *
*                                                                              *
* Description Template for abstract collection base classes                    *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef COLLECTIONBASE_H
#define COLLECTIONBASE_H

#include <map>
#include <string>
#include <vector>

namespace Fittino {

  template<class T>
    class CollectionBase {

  public:
                                    CollectionBase();
    virtual                         ~CollectionBase();
    void                            AddElement( T element );

  public:  
    const std::map<std::string, T>* GetMap() const;
    const std::vector<T>*           GetVector() const;

  private:  
    std::map<std::string, T>        _map;
    std::vector<T>                  _vector;

  private:  
    virtual std::string             GetName( T element ) = 0;  

  };

}

template<class T>
Fittino::CollectionBase<T>::CollectionBase() {

}

template<class T>
Fittino::CollectionBase<T>::~CollectionBase() {

}

template<class T>
void Fittino::CollectionBase<T>::AddElement( T element ){

  _vector.push_back( element );

  std::string name = GetName( element );
  std::pair<std::string,T> pair( name, element );
  _map.insert( pair );

}

template<class T>
const std::map<std::string,T>* Fittino::CollectionBase<T>::GetMap() const {

  return &_map;

}

template<class T>
const std::vector<T>* Fittino::CollectionBase<T>::GetVector() const {

  return &_vector;

}

#endif
