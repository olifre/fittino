/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.h                                                *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
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

#ifndef FITTINO_ROSENBROCKMODEL_H
#define FITTINO_ROSENBROCKMODEL_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class RosenbrockModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      RosenbrockModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~RosenbrockModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual RosenbrockModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();

      /*! \endcond UML */

  };

}

#endif // FITTINO_ROSENBROCKMODEL_H
