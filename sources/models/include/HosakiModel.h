/* $Id: HosakiModel.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HosakiModel.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional HosakiModel function                        *
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

#ifndef FITTINO_HosakiModel_H
#define FITTINO_HosakiModel_H

#include "TestModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class HosakiModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      HosakiModel( const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~HosakiModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual HosakiModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();
      virtual double           ToRadians(double x);

      /*! \endcond UML */

  };

}

#endif // FITTINO_HosakiModel_H
