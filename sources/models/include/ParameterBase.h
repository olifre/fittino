/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParameterBase.h                                                  *
*                                                                              *
* Description Base class for parameters                                        *
*                                                                              *
* Authors     Sebastian Heer        <s6seheer@uni-bonn.de>                     *
*             Mathias   Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PARAMETERBASE_H
#define FITTINO_PARAMETERBASE_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for parameters.
   */
  class ParameterBase {

    public:
      /*!
       *  Takes as input the name and value of the parameter.
       */
                   ParameterBase( std::string name,
                                  double      value );
      /*!
       *  Standard destructor.
       */
                   ~ParameterBase();
      /*!
       *  Returns the value of the parameter.
       */
      double       GetValue() const;
      /*!
       *  Sets the value of the parameter.
       */
      void         SetValue( double value );
      /*!
       *  Returns the name of the parameter.
       */
      std::string  GetName() const;

    public:
      /*!
       *  Prints the parameter status on screen.
       */
      virtual void PrintStatus() const;

    protected:
      /*!
       *  Value of the parameter.
       */
       double      _value;
      /*!
       *  Name of the parameter.
       */
      std::string  _name;

    //private:
    //  void         CheckConsistency() const;

  };

}

#endif // FITTINO_PARAMETERBASE_H
