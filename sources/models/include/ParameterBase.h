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
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_PARAMETERBASE_H
#define FITTINO_PARAMETERBASE_H

#include "Quantity.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Base class for parameters.
   */
  class ParameterBase : public Quantity {

    public:
      /*!
       *  Takes as input the name and value of the parameter.
       */
      ParameterBase( std::string name,
                     std::string plotName,
                     double      value,
                     double      lowerBound,
                     double      upperBound );
      /*!
       *  Standard constructor.
       */
      ParameterBase( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ParameterBase();

    //private:
    //  void CheckConsistency() const;

  };

}

#endif // FITTINO_PARAMETERBASE_H
