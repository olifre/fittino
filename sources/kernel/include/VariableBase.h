/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        VariableBase.h                                                   *
*                                                                              *
* Description Base class for variables                                         *
*                                                                              *
* Authors     Bjoern Sarrazin         <sarrazin@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_VARIABLEBASE_H
#define FITTINO_VARIABLEBASE_H

#include <iostream>
#include <iomanip>
#include <string>

#include "Messenger.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Base class for variables.
   */
  template< class T >
  class VariableBase {

    public:
      /*!
       *  Standard constructor
       */
      VariableBase( const std::string& name );
      /*!
       *  Standard destructor.
       */
      virtual ~VariableBase();
      /*!
      *  Returns the name of the variable.
      */
      const std::string&  GetName() const;
      /*!
       *  Returns the value of the variable.
       */
      virtual const T&     GetValue() const = 0;

      void PrintStatus() const;

    private:
      std::string           _name;

  };

  template< class T >
  VariableBase< T >::VariableBase( const std::string& name )
    : _name ( name ){

  }

  template< class T >
    VariableBase< T >::~VariableBase(){

  }  

  template< class T >
  const std::string& VariableBase< T >::GetName() const {

    return _name;

  }

  template< class T >
  void VariableBase< T >::PrintStatus() const {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::INFO
              << "    "
              << std::left
              << std::setw( 43 )
              << _name
              << std::right
              << std::setw( 9 )
              << std::setprecision( 2 )
              << std::scientific
              << GetValue()
              << Messenger::Endl;
  }

}

#endif
