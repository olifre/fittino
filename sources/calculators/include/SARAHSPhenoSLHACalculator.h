/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SARAHSPhenoSLHACalculator.h                                      *
*                                                                              *
* Description Wrapper class for SPheno                                         *
*                                                                              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_SARAHSPHENOSLHACALCULATOR_H
#define FITTINO_SARAHSPHENOSLHACALCULATOR_H

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
  class SARAHSPhenoSLHACalculator : public SLHACalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      SARAHSPhenoSLHACalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~SARAHSPhenoSLHACalculator();
      void                   CalculatePredictions();

      /*! \cond UML */
    private:
      int                    _returnValue;
      Executor*              _executor;
      InputFile*             _inputFile;
      std::vector<int>       _dsquarkPIDs;
      std::vector<std::string> _dsquarkNames;

    private:
      void                   AddBR( std::string mother, std::string daughter1, std::string daughter2 );
      void                   AddMass( std::string particle );
      void                   AddParticle( std::string particle );
      void                   AddWidth( std::string particle );
      void TestUnitarity();
      /*! \endcond UML */


      void DetermineMass(std::string block, const std::vector<int> pids, const std::vector<std::string> names, int j) ;
  };

}

#endif // FITTINO_SPHENOSLHACALCULATOR_H
