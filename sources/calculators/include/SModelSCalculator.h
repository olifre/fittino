/* $Id: SModelSCalculator.h 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/******************************************************************************* 
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *      
 *                                                                              *      
 * File        SModelSCalculator.h                                              * 
 * Description: Wrapper class for SModelS                                       *  
 * Authors:     Nanette Range                                                   *   
 *                                                                              *                      
 * Licence     This program is free software; you can redistribute it and/or    *              
 *             modify it under the terms of the GNU General Public License as   *     
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *            
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_SMODELSCALCULATOR_H
#define FITTINO_SMODELSCALCULATOR_H

#include "CalculatorBase.h"

namespace Fittino {
  class SModelSCalculator : public CalculatorBase {
    
  public:
    
    SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~SModelSCalculator();

  public:
    
    virtual void CalculatePredictions();
    virtual void Initialize();

  private:

    double _r;
    double _Chi2;

    double _theo;
    double _obs;
    double _exp;
    double _chi2;
    
    double _value1;
    double _value0;
    
    std::string R; 
    std::string string;
    
    std::string name1;
    std::string name2;
    std::string name3;
    std::string name4;
                                                                                                                  
    };


}
#endif // FITTINO_SMODELSCALCULATOR_H

