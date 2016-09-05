/* $Id: LHCNeuralNetCalculator.h 2462 2015-02-06 11:59:42Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        LHCNeuralNetCalculator.h                                         *
*                                                                              *
* Description Calculator for MSSM11 LHC NEURAL NET                             *
*                                                                              *
* Authors     Matthias Hamer <matthias.hamer@cern.ch>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_LHCNEURALNETCALCULATOR_H
#define FITTINO_LHCNEURALNETCALCULATOR_H

#include "CalculatorBase.h"
#include "Executor.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Calculator for MSSM11 LHC Neural Net 
   */
  class LHCNeuralNetCalculator : public CalculatorBase {

    public:
      LHCNeuralNetCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree  );
      ~LHCNeuralNetCalculator();

    private:
      Executor _executor;

    private:
      void     CalculatePredictions();
    
    private:
      double _lhcNNChi2;
      std::vector<std::string> _arguments;
  };

}

#endif // FITTINO_LHCNEURALNETCALCULATOR_H
