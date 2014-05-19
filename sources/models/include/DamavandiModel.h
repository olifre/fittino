/* $Id: DamavandiModel.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        DamavandiModel.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional DamavandiModel function                        *
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

#ifndef FITTINO_DamavandiModel_H
#define FITTINO_DamavandiModel_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class DamavandiModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      DamavandiModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~DamavandiModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual DamavandiModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);

      /*! \endcond UML */

  };

}

#endif // FITTINO_DamavandiModel_H
