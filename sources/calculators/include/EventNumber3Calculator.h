/* $Id: EventNumber2Calculator.h 2775 2016-11-15 12:41:43Z sarrazin $ */

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

#ifndef FITTINO_EVENTNUMBER3CALCULATOR_H
#define FITTINO_EVENTNUMBER3CALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "Executor.h"
#include "InputFile.h"
#include "SLHACalculatorBase.h"
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
  class EventNumber3Calculator : public CalculatorBase{

    public:
      /*!
       *  Standard constructor.
       */
                          EventNumber3Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~EventNumber3Calculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();
    
     private:

     //InputFile _inputFile;
     Executor  _executor;
      int  _N;

  };

}

#endif // FITTINO_EVENTNUMBER3CALCULATOR_H
