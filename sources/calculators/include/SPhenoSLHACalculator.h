/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SPhenoSLHACalculator.h                                           *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SPHENOSLHACALCULATOR_H
#define FITTINO_SPHENOSLHACALCULATOR_H

#include "Executor.h"
#include "SLHACalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SLHALine;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for SPheno.
   */
  class SPhenoSLHACalculator : public SLHACalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      SPhenoSLHACalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SPhenoSLHACalculator();
      void                   CalculatePredictions();

      /*! \cond UML */
    private:
      int                    _returnValue;
      Executor*              _executor;
      InputFile*             _inputFile;

    private:
      void                   AddBR( std::string mother, std::string daughter1, std::string daughter2 );
      void                   AddMass( std::string particle );
      void                   AddParticle( std::string particle );
      void                   AddTotalWidth(std::string particle);

      /*! \endcond UML */

  };

}

#endif // FITTINO_SPHENOSLHACALCULATOR_H
