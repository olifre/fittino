/* $Id: SlideModel.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SlideModel.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional SlideModel function                        *
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

#ifndef FITTINO_SlideModel_H
#define FITTINO_SlideModel_H

#include "TestModelBase.h"
#include "TMatrixD.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class SlideModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      SlideModel( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SlideModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual SlideModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();

      double           _sigma1;
      double           _sigma2;
      double           _rho;
      TMatrixD          _transformationMatrix;

      /*! \endcond UML */

  };

}

#endif // FITTINO_SlideModel_H
