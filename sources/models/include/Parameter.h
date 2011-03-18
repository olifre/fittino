/* $Id: Parameter.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Parameter.h                                                      *
*                                                                              *
* Description Class for model parameters                                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PARAMETER_H
#define FITTINO_PARAMETER_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Class for model parameters.
   */
  class Parameter {

    public:
      /*!
       *  Takes as input the name and starting value of the parameter.
       */
                  Parameter( std::string name, double value, int id );
      /*!
       *  Standard destructor.
       */
                  ~Parameter();
      /*!
       *  Returns the value of the parameter.
       */
      double      GetValue() const;
      /*!
       *  Returns the ID of the parameter. The parameter ID can (and should) be used whenever it\n
       *  is necessary to identify a parameter by a numerical (integer) value. The parameter ID\n
       *  has to be unique within a certain model and is specified in the definition of the model\n
       *  class.  For example, in the definition of the SLHA standard tan(beta) has the\n
       *  parameter ID 3 (for all models satisfying the standard).
       */
      int         GetID() const;
      /*!
       *  Sets the value of the parameter.
       */
      void        SetValue( double value );
      /*!
       *  Returns the name of the parameter.
       */
      std::string GetName() const;

    private:
      //double      _error;
      //double      _lowerBound;
      /*!
       *  Value of the parameter.
       */
      double      _value;
      //double      _upperBound;
      /*!
       *  ID of the parameter.
       */
      int         _id;
      /*!
       *  Name of the parameter.
       */
      std::string _name;

  };

}

#endif // FITTINO_PARAMETER_H
