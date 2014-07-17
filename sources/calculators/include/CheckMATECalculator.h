/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        CheckMATECalculator.h                                            *
*                                                                              *
* Description Wrapper class for CheckMATE                                      *
*                                                                              *
* Authors       <@>                                                            *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_CHECKMATECALCULATOR_H
#define FITTINO_CHECKMATECALCULATOR_H

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
   *  \brief Wrapper class for CheckMATE
   */
  class CheckMATECalculator : public CalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
                       CheckMATECalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
                          ~CheckMATECalculator();

    public:
      virtual void        CalculatePredictions();
      virtual void        Initialize();
      virtual void        SetupMeasuredValues();

    private:
      int           _a;
      /*! 
       */
      int           _b;
      /*!                                                                                                                                                                                
       *                                                                                                                                                                                 
       */
      int           _c;
      /*!                                                                                                                                                                                
       *                                                                                                                                                                                 
       */
      double        _d;


  };

}

#endif // FITTINO_CHECKMATECALCULATOR_H

