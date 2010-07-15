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
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Class for model parameters 
   */
  class Parameter {

    public:
      /*!
       *  Constructor
       */
                  Parameter( std::string name, double value );
      /*!
       *  Destructor
       */
                  ~Parameter();
      double      GetValue() const;
      void        SetValue( double value );
      std::string GetName() const;

    private:
      //double      _error;
      //double      _lowerBound;
      double      _value;
      //double      _upperBound;
      std::string _name;

  };

}

#endif // FITTINO_PARAMETER_H
