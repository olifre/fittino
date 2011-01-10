/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        RosenbrockModel.h                                                *
*                                                                              *
* Description Implementation of the Rosenbrock model                           *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_ROSENBROCKMODEL_H
#define FITTINO_ROSENBROCKMODEL_H

#include <vector>

#include "Minuit2/FCNBase.h"

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup models
   *  \brief Implementation of the Rosenbrock model.
   */
  class RosenbrockModel : public ModelBase {

    public:
      /*!
       *  Standard constructor.
       */
                               RosenbrockModel();
      /*!
       *  Standard destructor.
       */
                               ~RosenbrockModel();
      virtual double           Evaluate();
      /*!
       *  Virtual copy constructor.
       */
      virtual RosenbrockModel* Clone() const;

  };

  /*!
   *  \brief Implementation of the Rosenbrock model as required by Minuit.
   */
  class RosenbrockFCN : public ROOT::Minuit2::FCNBase {

    public:
                          RosenbrockFCN( const std::vector<double>& meas, const std::vector<double>& pos, const std::vector<double>& mvar );
                          ~RosenbrockFCN();
      virtual double      Up() const;

    public:
      virtual double      operator()( const std::vector<double>& parameterVector ) const;

    private:
      double              theErrorDef;
      std::vector<double> theMeasurements;
      std::vector<double> thePositions;
      std::vector<double> theMVariances;

  };

}

#endif // FITTINO_ROSENBROCKMODEL_H
