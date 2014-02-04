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
#include <stdexcept>  
#include <string>
#include <vector>

#include "ConfigurationException.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {
    /*!
   *  \ingroup models
   *  \brief Template for collection classes. Only specification for pointers is implemented. 
   */
  template<class T> class Collection;
    /*!
   *  \ingroup models
   *  \brief template for collection of pointers.
   */
  template<class T> class Collection<T*> {

  public:
    Collection();

  public:
    void                            AddElement( T* element );
    void                            AddElement( const std::string& name, T* element );
    void                            Delete();

  public:  
     T*                             At( int index )        const;
     T*                             At( std::string name ) const;
    unsigned int                    GetNumberOfElements()  const;

  public:  
    virtual                         ~Collection();

  private:  
    std::map<std::string, T*>        _map;
    std::vector<T*>                  _vector;

  };

}

template<class T>
Fittino::Collection<T*>::Collection() {

}

template<class T>
Fittino::Collection<T*>::~Collection() {

}

template<class T>
void Fittino::Collection<T*>::AddElement( T* element ) {

  _vector.push_back( element );
  std::string name = element->GetName();

  std::pair<std::string,T*> pair( name, element );

  if ( ! _map.insert( pair ).second ) {

    std::string message = "Element with name " + name + " has already been added.";

    throw ConfigurationException( message ); //TODO: Dedicated exception class ?

  }

}

template<class T>
void Fittino::Collection<T*>::AddElement( const std::string& name, T* element ){

  _vector.push_back( element );

  std::pair<std::string,T*> pair( name, element );

  if ( ! _map.insert( pair ).second ) {

    std::string message = "Element with name " + name + " has already been added.";

    throw ConfigurationException( message ); //TODO: Dedicated exception class ?

  }

}

template<class T>
T* Fittino::Collection<T*>::At( int index ) const {

  return _vector.at( index );

}

template<class T>
T* Fittino::Collection<T*>::At( std::string name ) const {

  try {

    return _map.at( name );

  }
  catch (const std::out_of_range& ) {

    throw ConfigurationException( "Element with name " + name + " not contained in Collection." ); //TODO: Dedicated exception class ?
    
  }

}


template<class T>
unsigned int Fittino::Collection<T*>::GetNumberOfElements() const {

  return _vector.size();

}


template<class T>
void Fittino::Collection<T*>::Delete()  {

  for  (int i=0; i<_vector.size(); i++ ){

    delete _vector[i];

  }

  _vector.clear();
  _map.clear();

}


#endif

