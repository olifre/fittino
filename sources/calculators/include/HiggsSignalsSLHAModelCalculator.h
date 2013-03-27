/* $Id: HiggsSignalsSLHAModelCalculator.h 851 2011-01-10 18:01:22Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.h                                *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
#define FITTINO_HIGGSSIGNALSMODELCALCULATOR_H

#include "SLHAModelCalculatorBase.h"

extern "C" {

  void higgssignals_neutral_input_massuncertainty_( double* dm );
  void initialize_higgssignals_latestresults_( int* nHzero, int* nHplus );
  void setup_higgs_to_peaks_assignment_iterations_( int* iterations );
  void setup_output_level_( int* output_level );
  void setup_pdf_( int* pdf );

}

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for HiggsSignals.
   */
  class HiggsSignalsSLHAModelCalculator : public SLHAModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                   HiggsSignalsSLHAModelCalculator();
      /*!
       *  Standard destructor.
       */
                   ~HiggsSignalsSLHAModelCalculator();

    public:
      virtual void Initialize() const;

      /*! \cond UML */
    private:
      virtual void CallExecutable();
      virtual void CallFunction( PhysicsModelBase* model );
      virtual void ConfigureInput( PhysicsModelBase* model );

      /*! \endcond UML */

  };

}

#endif // FITTINO_HIGGSSIGNALSMODELCALCULATOR_H
