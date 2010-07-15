/* $Id: MSUGRAModel.h 613 2010-05-26 09:42:00Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MSUGRAModel.h                                                    *
*                                                                              *
* Description Implementation of the MSUGRA model                               *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MSUGRAMODEL_H
#define FITTINO_MSUGRAMODEL_H

#include <vector>

#include "Minuit2/FCNBase.h"

#include "ModelBase.h"

/*!
 *  \brief Fittino namespace
 */
namespace Fittino {

  /*!
   *  \brief Implementation of the MSUGRA model 
   */
  class MSUGRAModel : public ModelBase {

    public:
      /*!
       *  Constructor
       */
                           MSUGRAModel();
      /*!
       *  Destructor
       */
                           ~MSUGRAModel();
      virtual double       Evaluate();
      /*!
       *  Virtual copy constructor
       */
      virtual MSUGRAModel* Clone() const;

  };

  /*!
   *  \brief Implementation of the MSUGRA model as required by Minuit
   */
  class MSUGRAFCN : public ROOT::Minuit2::FCNBase {

    public:
                          MSUGRAFCN( const std::vector<double>& meas, const std::vector<double>& pos, const std::vector<double>& mvar );
                          ~MSUGRAFCN();
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

#endif // FITTINO_MSUGRAMODEL_H
