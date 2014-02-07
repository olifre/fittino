/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroCalculator.h                                                 *
*                                                                              *
* Description Class for a simple tree calculator                               *
*                                                                              *
* Authors     Matthias Hamer  <mhamer@gwdg.de>                                 *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_TREECALCULATOR_H
#define FITTINO_TREECALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "ModelCalculatorBase.h"

class TTree;
class TFile;
class TGraph;
class TF1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Class for a Tree Calculator
   */
  class AstroCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Old standard constructor.
       */
                          AstroCalculator( const PhysicsModelBase* model );
      /*!
       *  Standard constructor.
       */
                          AstroCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~AstroCalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize() const;
      void                SetupMeasuredValues();

    private:
      std::vector<std::string>              _chi2ContributionNames;
      std::vector<std::string>              _xValueNames;
      std::vector<std::string>              _yValueNames;
      std::vector<std::string>              _dataPointFileNames;
      std::vector<TF1>                      _widthFormulas; 
      std::vector<TF1>                      _limitFormulas;
      std::vector<double>                   _theoryUncertainties;
      std::vector<TGraph>                   _exclusionGraphs;
      std::vector<double>                   _measuredValues;

  };

}

#endif // FITTINO_TREECALCULATOR_H
