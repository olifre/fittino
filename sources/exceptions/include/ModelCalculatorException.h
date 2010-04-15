/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelCalculatorException.h                                       *
*                                                                              *
* Description Fittino input file exception class. It is thrown in case of      *
*             problems with calculations performed by model calculators.       *
*                                                                              *
* Authors     Peter Wienemann  <wienemann@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELCALCULATOREXCEPTION_H
#define FITTINO_MODELCALCULATOREXCEPTION_H

#include "ExceptionBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Fittino model calculator exception class
   */
  class ModelCalculatorException : public ExceptionBase {

    public:
      /*!
       *  Constructor
       */
                  ModelCalculatorException( const std::string& message );
      /*!
       *  Method to print message
       */
      const char* what() const throw();

  };

}

#endif // FITTINO_MODELCALCULATOREXCEPTION_H
