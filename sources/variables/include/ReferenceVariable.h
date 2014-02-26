/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ReferenceVariable.h                                              *
*                                                                              *
* Description Variable which value is a reference                              *
*                                                                              *
* Authors     Bjoern Sarrazin <sarrazin@physik.uni-bonn.de>                    *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_REFERENCEVARIABLE_H
#define FITTINO_REFERENCEVARIABLE_H

#include "VariableBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \defgroup variables
   */
  /*!
   *  \ingroup variables
   *  \brief Variable which value is a reference.
   */
  template< class T >
  class ReferenceVariable : public VariableBase< T > {

    public:
      /*!
       *  Standard constructor.
       */
      ReferenceVariable( const std::string& name, const T& value );
      /*!
       *  Standard destructor.
       */
      virtual ~ReferenceVariable();
      /*!
       *  Returns the value of the variable.
       */
      const T& GetValue() const;

    private:
      const T& _value;

  };

  template< class T>
  ReferenceVariable< T >::ReferenceVariable( const std::string& name, const T& value )
    : VariableBase< T >( name ),
      _value ( value ) {

  }

  template< class T >
  ReferenceVariable< T >::~ReferenceVariable() {

  }

  template< class T >
  const T& ReferenceVariable< T >::GetValue() const {

    return _value;

  }

}

#endif // FITTINO_REFERENCEVARIABLE_H
