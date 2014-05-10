/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        VariableBase.h                                                   *
*                                                                              *
* Description Base class for variables                                         *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_VARIABLEBASE_H
#define FITTINO_VARIABLEBASE_H

#include <iomanip>
#include <iostream>
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
  template<class T>
  class VariableBase {

    public:
      /*!
       *  Standard constructor
       */
      VariableBase( const std::string& name );
      /*!
      *  Returns the name of the variable.
      */
      void               PrintStatus() const;
      const std::string& GetName() const;

    public:
      /*!
       *  Standard destructor.
       */
      virtual            ~VariableBase();
      /*!
       *  Returns the value of the variable.
       */
      virtual const T&   GetValue() const = 0;

    private:
      std::string        _name;

  };

}

template<class T>
Fittino::VariableBase<T>::VariableBase( const std::string& name )
  : _name ( name ) {

}

template<class T>
void Fittino::VariableBase<T>::PrintStatus() const {

  Messenger& messenger = Messenger::GetInstance();

  messenger << Messenger::INFO
            << "    "
            << std::left
            << std::setw( 50 )
            << _name
            << std::right
            << std::setw( 9 )
            << std::setprecision( 2 )
            << std::scientific
            << GetValue()
            << Messenger::Endl;

}

template<class T>
const std::string& Fittino::VariableBase<T>::GetName() const {

  return _name;

}

template<class T>
Fittino::VariableBase<T>::~VariableBase() {

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup kernel
   *  \brief Class for string variables.
   */
  template<>
  class VariableBase<std::string> {

    public:
      /*!
       *  Standard constructor
       */
      VariableBase( const std::string& name ) : _name ( name ) {}
      /*!
      *  Returns the name of the variable.
      */
      void                       PrintStatus() const {

        Messenger& messenger = Messenger::GetInstance();

        messenger << Messenger::INFO
                  << "    "
                  << std::left
                  << std::setw( 44 )
                  << _name
                  << std::left
                  << GetValue()
                  << Messenger::Endl;

      }
      const std::string&         GetName() const {

        return _name;

      }

    public:
      /*!
       *  Standard destructor.
       */
      virtual                    ~VariableBase() {}
      /*!
       *  Returns the value of the variable.
       */
      virtual const std::string& GetValue() const = 0;

    private:
      std::string                _name;

  };

}

#endif // FITTINO_VARIABLEBASE_H
