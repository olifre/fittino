/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ModifiedRosenbrockModel.h                                        *
*                                                                              *
* Description Implementation of an n-dimensional ModifiedRosenbrockModel       *
*             function                                                         *
*                                                                              *
* Authors     Pia Kullik  <pkullik@uni-bonn.de>                                *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ModifiedRosenbrockModel_H
#define FITTINO_ModifiedRosenbrockModel_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class ModifiedRosenbrockModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      ModifiedRosenbrockModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ModifiedRosenbrockModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual ModifiedRosenbrockModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);

      /*! \endcond UML */

  };

}

#endif // FITTINO_ModifiedRosenbrockModel_H
