/* $Id: Paraboloid.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Paraboloid.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional paraboloid function                        *
*                                                                              *
* Authors     Pia     Kullik      <pkullik@uni-bonn.de>                        *
*             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_Paraboloid_H
#define FITTINO_Paraboloid_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class Paraboloid : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      Paraboloid( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Paraboloid();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual Paraboloid* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();

      /*! \endcond UML */

  };

}

#endif // FITTINO_Paraboloid_H
