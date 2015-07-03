/* $Id: CheckMATE2Calculator.h 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************                            
 *                                                                              *                
 * Project     Fittino - A SUSY Parameter Fitting Package                       *                
 *                                                                              *                    
 * File        CheckMATE2Calculator.h                                           *                  
 * Description: Wrapper class for CheckMATE                                     *          
 * Authors:     Nanette Range                                                   *   
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *                       
 *             modify it under the terms of the GNU General Public License as   *                  
 *             published by the Free Software Foundation; either version 3 of   *                 
 *             the License, or (at your option) any later version.              *                  
 *                                                                              *           
 *******************************************************************************/

#ifndef FITTINO_CHECKMATE2CALCULATOR_H
#define FITTINO_CHECKMATE2CALCULATOR_H

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"

namespace Fittino{
  class CheckMATE2Calculator : public CalculatorBase {

  public:
    CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~CheckMATE2Calculator();
    
  public:
    virtual void CalculatePredictions();
    virtual void SetupMeasuredValues();
    virtual void Initialize();

  private:
    double _r;
    double _cl;
    double _r_cl;
    
  };

}
#endif //Fittino_CheckMATE2CALCULATOR_H
