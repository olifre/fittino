/* $Id: MadGraphCalculator.h 2528 2015-04-07 10:54:29Z thakur@PHYSIK.UNI-BONN.DE $ */

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

#ifndef FITTINO_MADGRAPH2CALCULATOR_H
#define FITTINO_MADGRAPH2CALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"
#include <map>

class TTree;
class TFile;
class TGraph;
class TF1;

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class Quantity;

  /*!
   *  \defgroup calculators
   */
  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for MadGraph
   */
  class MadGraph2Calculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                          MadGraph2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~MadGraph2Calculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();
      
    private:
      double     _crossSection;
      double     _SMxs;
      double     _normxs;
      double     _nevents;
      double     _f_BB;
      double     _f_WW;
      double     _f_B;
      double     _f_W;
      
      
  };

}

#endif // FITTINO_MADGRAPH2CALCULATOR_H
