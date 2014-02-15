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
                          bool        fixed = false );
      /*!
       *  Standard constructor.
       */
      ModelParameterBase( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ModelParameterBase();
      bool   IsFixed() const;
      /*!
       *  Returns true when the parameter value has been set.
       */
      bool   IsUpdated() const;
      /*!
       *  Returns the error of the parameter.
       */
      double GetError() const;
      /*!
       *  Sets the return value of IsUpdated().  
       */
      void   SetUpdated( bool updated );
     /*!
       *  Sets the value of the parameter.
       */
      void   SetValue( double value );

    protected:
      /*!
       *  If true, the parameter value is not updated by the analysis tool. Per default it is set\n
       *  to false.
       */
      bool   _fixed;
      /*!
       *  Error of the parameter. Analysis tools use this value as the parameter-dependent\n
       *  "stepwidth".
       */
      bool   _updated;
      double _error;

  };

}

#endif // FITTINO_MODELPARAMETERBASE_H
