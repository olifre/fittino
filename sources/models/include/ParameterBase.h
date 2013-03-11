/* $Id: ParameterBase.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParameterBase.h                                                  *
*                                                                              *
* Description Base class for model parameters                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
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
   *  \brief Base class for model parameters.
   */
  class ParameterBase {

    public:
      /*!
       *  Takes as input the name and starting values of the parameter.
       */
                  ParameterBase( std::string name,
                                 double      value,
                                 double      error,
                                 double      lowerBound,
                                 double      upperBound,
                                 bool        fixed = false );
      /*!
       *  Standard destructor.
       */
                  ~ParameterBase();
      /*!
       *  Returns the error of the parameter.
       */
      double      GetError() const;
      /*!
       *  Returns the lower bound of the parameter.
       */
      double      GetLowerBound() const;
      /*!
       *  Returns the upper bound of the parameter.
       */
      double      GetUpperBound() const;
      /*!
       *  Returns the value of the parameter.
       */
      double      GetValue() const;
      /*!
       *  Prints the parameter status on screen.
       */
      void        PrintStatus() const;
      /*!
       *  Sets the value of the parameter.
       */
      void        SetValue( double value );
      /*!
       *  Returns the name of the parameter.
       */
      std::string GetName() const;

    private:
      /*!
       *  If true, the parameter value is not updated by the analysis tool. Per default it is set\n
       *  to false.
       */
      bool        _fixed;
      /*!
       *  Error of the parameter. Analysis tools use this value as the parameter-dependent\n
       *  "stepwidth".
       */
      double      _error;
      /*!
       *  Lower bound of the parameter.
       */
      double      _lowerBound;
      /*!
       *  Upper bound of the parameter.
       */
      double      _value;
      /*!
       *  Value of the parameter.
       */
      double      _upperBound;
      /*!
       *  Name of the parameter.
       */
      std::string _name;

  };

}

#endif // FITTINO_PARAMETERBASE_H
