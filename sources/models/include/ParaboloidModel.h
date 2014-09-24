/* $Id: ParaboloidModel.h 1882 2014-02-08 11:44:18Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        ParaboloidModel.h                                                *
*                                                                              *
* Description Implementation of an n-dimensional ParaboloidModel function                        *
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

#ifndef FITTINO_ParaboloidModel_H
#define FITTINO_ParaboloidModel_H

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
  class ParaboloidModel : public TestModelBase {

    public:
      /*!
       *  Standard constructor.
       */
      ParaboloidModel( boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~ParaboloidModel();

    public:
      /*!
       *  Virtual copy constructor.
       */
      virtual ParaboloidModel* Clone() const;

      /*! \cond UML */
    private:
      virtual double           TestModelFunction();

      double                    _sigma1;
      double                    _sigma2;
      double                    _rho;
      TMatrixD                   _transformationMatrix;

      /*! \endcond UML */

  };

}

#endif // FITTINO_ParaboloidModel_H
