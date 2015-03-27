/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CalculatorException.h                                            *
*                                                                              *
* Description Thrown in case of problems with calculations performed by one of *
*             the calculators                                                  *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*             Peter   Wienemann   <wienemann@physik.uni-bonn.de>               *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CALCULATOREXCEPTION_H
#define FITTINO_CALCULATOREXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup exceptions
   *  \brief Thrown in case of problems with calculations performed by one of the calculators.
   */
  class CalculatorException : public ExceptionBase {

    public:
      /*!
       *  Constructor.
       */
      CalculatorException( const std::string& calculator, const std::string& error );
      /*!
       *  Returns the name of the calculator in which the exception was thrown.
       */
      const std::string& GetCalculator() const;
      /*!
       *  Returns the error which triggered the exception to be thrown.
       */
      const std::string& GetError() const;

    public:
      /*!
       *  Destructor.
       */
      virtual            ~CalculatorException() throw();

    private:
      std::string        _calculator;
      std::string        _error;

  };

}

#endif // FITTINO_CALCULATOREXCEPTION_H
