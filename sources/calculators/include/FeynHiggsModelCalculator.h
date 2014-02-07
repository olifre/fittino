/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculator.h                                       *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#ifndef FITTINO_FEYNHIGGSMODELCALCULATOR_H
#define FITTINO_FEYNHIGGSMODELCALCULATOR_H

#include "Collection.h"
#include "FeynHiggsModelCalculatorBase.h"

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

  class SimplePrediction;

  /*!
   *  \ingroup calculators
   *  \brief Wrapper class for FeynHiggs.
   */
  class FeynHiggsModelCalculator : public FeynHiggsModelCalculatorBase {

    public:
      /*!
       *  Standard constructor.
       */
      FeynHiggsModelCalculator( const PhysicsModel* model, const boost::property_tree::ptree& ptree );
      /*!
       *  Standard destructor.
       */
      ~FeynHiggsModelCalculator();
                   
      /*! \cond UML */
    private:
      void CalculatePredictions();

    private:  
      double _m_h;
      int    _error;

      Collection<SimplePrediction*> _input;
      
      /*! \endcond UML */

  };

}

#endif 
