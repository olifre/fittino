/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeCalculator.h                                                 *
*                                                                              *
* Description Class for a tree calculator                                      *
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

#include "CalculatorBase.h"
#include "PtreeForwardDeclaration.h"

class TChain;
class TFile;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Class for a Tree Calculator.
   */
  class TreeCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      TreeCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~TreeCalculator();

    public:
      void                                CalculatePredictions();

      /*! \cond UML */
    private:
      bool                                _excludeAllLeaves;
      double                              _numberOfTreeIterations;
      std::string                         _inputFileName;
      std::vector<std::string>            _inputTreeName;
      std::map<std::string, double>       _predictionMap;
      std::map<std::string, std::string*> _strings;
      std::vector<std::string>            _includedLeaves;
      std::vector<std::string>            _excludedLeaves;
      TChain*                             _inputTree;
      TFile*                              _inputFile;

    private:
      void                                AddPredictions();
      void                                OpenInputFile();

      /*! \endcond UML */

  };

}

#endif // FITTINO_TREECALCULATOR_H
