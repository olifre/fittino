/* $Id: Univariate2Model.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Univariate2Model.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional Univariate2Model function                        *
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

#ifndef FITTINO_Univariate2Model_H
#define FITTINO_Univariate2Model_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class Univariate2Model : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      Univariate2Model( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~Univariate2Model();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual Univariate2Model* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);

      /*! \endcond UML */

  };

}

#endif // FITTINO_Univariate2Model_H
