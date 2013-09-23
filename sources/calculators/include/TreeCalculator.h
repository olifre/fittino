/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        TreeCalculator.h                                                 *
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


#include "ModelCalculatorBase.h"

class TTree;
class TFile;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  /*!
   *  \ingroup calculators
   *  \brief Class for a Tree Calculator
   */
  class TreeCalculator : public ModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                          TreeCalculator( const PhysicsModelBase* model, std::string inputFileName = "Fittino.out.root", std::string inputTreeName = "Tree" );
      /*!
       *  Standard destructor.
       */
                          ~TreeCalculator();
      /*!
       *  Set All Branch Addresses in the tree
       */
      void                SetAllBranchAddresses();

    public:
      virtual void        CalculatePredictions();

    private:
      TFile*              _inputFile;
      TTree*              _inputTree;
      int                 _currentEntry;

  };

}

#endif // FITTINO_TREECALCULATOR_H
