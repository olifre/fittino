/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCChi2Calculator.h                                            *
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

#ifndef FITTINO_LHCCHI2CALCULATOR_H
#define FITTINO_LHCCHI2CALCULATOR_H

#include <vector>

#include "THnSparse.h"

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

class TH1D;
/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    class Quantity;

    /*!
   *  \ingroup calculators
   *  \brief Base class for LHC model calculators.
   */
  class LHCChi2Calculator : public CalculatorBase {

    public:

                           LHCChi2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
                           ~LHCChi2Calculator();
    
    public:
      virtual void        CalculatePredictions();

  private:
      double                   _chi2;
      TH1D*                    _chi2Histogram;
      THnSparseD*              _chi2HistogramnD;
      std::vector<const Quantity*>   _variables;

  private:
      double              InterpolateND( THnSparse* histogram, std::vector<double> interpolationPoint);

  };

}

#endif
