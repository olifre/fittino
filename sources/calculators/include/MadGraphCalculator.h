/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        MadGraphCalculator.h                                             *
*                                                                              *
* Description Wrapper class for MadGraph                                       *
*                                                                              *
* Authors       <@>                                                            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_MADGRAPHCALCULATOR_H
#define FITTINO_MADGRAPHCALCULATOR_H

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
   *  \brief Wrapper class for MadGraph
   */
  class MadGraphCalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                          MadGraphCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~MadGraphCalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();

    private:
 
      const double&         _fH;
      /*!
       *
       */
      const double&           _cHW;
      /*!
       *
       */
      const double&           _cHB;
      /*!
       * 
       */
      const double&        _cBB;
      

  };

}

#endif // FITTINO_MADGRAPHCALCULATOR_H
