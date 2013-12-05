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

#include <boost/property_tree/ptree.hpp>

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
       *  Old standard constructor.
       */
                          TreeCalculator( const PhysicsModelBase* model );
      /*!
       *  Standard constructor.
       */
                          TreeCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~TreeCalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        CallFunction();
      virtual void        CallExecutable();
      virtual void        ConfigureInput();
      virtual void        Initialize() const;
      void                SetInputFileName( std::string inputFileName );
      void                SetInputTreeName( std::string inputTreeName );
      void                OpenInputTree();
    private:
      TFile*              _inputFile;
      TTree*              _inputTree;
      std::string         _inputFileName;
      std::string         _inputTreeName;

    private:
      /*!
       *  Set All Branch Addresses in the tree
       */
      void                SetAllBranchAddresses();
      void                FillSimpleDataStorage();
      void                CreateDefaultPredictions();

  };

}

#endif // FITTINO_TREECALCULATOR_H
