/* $Id: Shubert3Model.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Shubert3Model.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional Shubert3Model function                        *
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

#ifndef FITTINO_Shubert3Model_H
#define FITTINO_Shubert3Model_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class Shubert3Model : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      Shubert3Model( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Shubert3Model();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual Shubert3Model* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);
      virtual double           Summand(double x, int j);

      /*! \endcond UML */

  };

}

#endif // FITTINO_Shubert3Model_H
