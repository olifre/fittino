/* $Id: NLLFastCalculator.h 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************                             
 *                                                                              *                                          
 * Project     Fittino - A SUSY Parameter Fitting Package                       *                                            
 *                                                                              *                                                      
 * File        NLLFastCalculator.h                                              *                                                 
 * Description: Wrapper class for NLL-Fast                                      *                                           
 * Authors:     Nanette Range                                                   *                               
 *                                                                              *                              
 * Licence     This program is free software; you can redistribute it and/or    *                                   
 *             modify it under the terms of the GNU General Public License as   *                            
 *             published by the Free Software Foundation; either version 3 of   *               
 *             the License, or (at your option) any later version.              *             
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_NLLFASTCALCULATOR_H
#define FITTINO_NLLFASTCALCULATOR_H

#include <vector>
#include "CalculatorBase.h"

namespace Fittino {
  class NLLFastCalculator : public CalculatorBase {
    
  public:
    
    NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
    ~NLLFastCalculator();

  public:

    virtual void CalculatePredictions();
    void SetToZero( std::string process );
    void Call( std::string process, std::string outputProcess, std::string pdf, std::vector<double> masses );
    void ReadFile( std::string file, std::string process, std::string pdf, unsigned int offset );
    
  private:

    std::string _griddir;
    std::string _executable;
    std::vector<std::string> _pdfs;
    std::map<std::string, std::vector<double> > _lowerBounds;
    std::map<std::string, std::vector<double> > _upperBounds;

  };

}

#endif 
