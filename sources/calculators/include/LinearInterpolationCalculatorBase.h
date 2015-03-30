/* $Id: LHCChi2Calculator.h 2462 2015-02-06 11:59:42Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LinearInterpolationCalculatorBase.h                              *
*                                                                              *
* Description                                                                  *
*                                                                              *
* Authors                                                                      *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	          published by the Free Software Foundation; either version 3 of   *
*    	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LINEARINTERPOLATIONCALCULATORBASE_H
#define FITTINO_LINEARINTERPOLATIONCALCULATORBASE_H

#include <vector>

#include "THnSparse.h"

#include "CalculatorBase.h"

class TH1D;
/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Quantity;

    /*!
   *  \ingroup calculators
   *  \brief
   */
  class LinearInterpolationCalculatorBase : public CalculatorBase {

    public:

                           LinearInterpolationCalculatorBase( const ModelBase* model, const boost::property_tree::ptree& ptree );
                           ~LinearInterpolationCalculatorBase();
    
    public:
      virtual void        CalculatePredictions();

  protected:
      double                   _chi2;
      TH1D*                    _chi2Histogram;
      THnSparseD*              _chi2HistogramnD;
      std::vector<const Quantity*>   _variables;

  protected:
      void                GetHistogram( std::string name );


  private:
      double              InterpolateND( THnSparse* histogram, std::vector<double> interpolationPoint);


      };

}

#endif
