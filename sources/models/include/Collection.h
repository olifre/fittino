/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Collection.h                                                     *
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

#include "CollectionBase.h"

namespace Fittino {

  template<class T>
    class Collection : public CollectionBase<T> {

  private:  
    virtual std::string             GetName( T element ) ;  

  };

  template<class T>
    class Collection<T*> : public CollectionBase<T*> {

  private:  
    virtual std::string             GetName( T* element ) ;  

  };

}

template<class T>
std::string Fittino::Collection<T>::GetName( T element ) {
  
  return element.GetName();

}

template<class T>
std::string Fittino::Collection<T*>::GetName( T* element ) {
  
  return element->GetName();

}

#endif
