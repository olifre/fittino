/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        AstroCalculator.h                                                *
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

#ifndef FITTINO_ASTROCALCULATOR_H
#define FITTINO_ASTROCALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"

class TTree;
class TFile;
class TGraph;
class TF1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimpleDataStorage;

  /*!
   *  \defgroup calculators
   */
  /*!
   *  \ingroup calculators
   *  \brief Class for a Tree Calculator
   */
  class AstroCalculator : public CalculatorBase {

    public:
      /*!
       *  Old standard constructor.
       */
                          AstroCalculator( const ModelBase* model );
      /*!
       *  Standard constructor.
       */
                          AstroCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~AstroCalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();

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
      SimpleDataStorage*                    _simpleOutputDataStorage;

  };

}

#endif // FITTINO_ASTROCALCULATOR_H
