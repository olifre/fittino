/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModelParameterBase.h                                             *
*                                                                              *
* Description Base class for model parameters                                  *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MODELPARAMETERBASE_H
#define FITTINO_MODELPARAMETERBASE_H

#include "ParameterBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for model parameters.
   */
  class ModelParameterBase : public ParameterBase {

    public:
      /*!
       *  Takes as input the name and starting value of the parameter.
       */
                   ModelParameterBase( std::string name,
                                       std::string plotName,
                                       double      value,
                                       double      error,
                                       double      lowerBound,
                                       double      upperBound,
                                       double      plotLowerBound,
                                       double      plotUpperBound,
                                       bool        fixed = false );
      /*!
       *  Standard destructor.
       */
                   ~ModelParameterBase();
      bool         IsFixed() const;
      /*!
       *  Returns the error of the parameter.
       */
      double       GetError() const;
      /*!
       *  Returns the lower bound of the parameter.
       */
      double       GetLowerBound() const;
      /*!
       *  Returns the upper bound of the parameter.
       */
      double       GetUpperBound() const;
     /*!
       *  Sets the value of the parameter.
       */
      void         SetValue( double value );

    public:
      /*!
       *  Prints the parameter status on screen.
       */
      virtual void PrintStatus() const;

    protected:
      /*!
       *  If true, the parameter value is not updated by the analysis tool. Per default it is set\n
       *  to false.
       */
      bool         _fixed;
      /*!
       *  Error of the parameter. Analysis tools use this value as the parameter-dependent\n
       *  "stepwidth".
       */
      double       _error;
      /*!
       *  Lower bound of the parameter.
       */
      double       _lowerBound;
      /*!
       *  Upper bound of the parameter.
       */
      double       _upperBound;

  };

}

#endif // FITTINO_MODELPARAMETERBASE_H
