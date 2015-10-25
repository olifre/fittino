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

#include <string>
#include <vector>
#include <map>

#include <boost/property_tree/ptree.hpp>

#include "CalculatorBase.h"

namespace Fittino{

  class CheckMATE2Calculator : public CalculatorBase {

  public:
    CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree);
    ~CheckMATE2Calculator();
    
  public:
    virtual void CalculatePredictions();

  private:

    double _r;
    double _cl;
    double _r_cl;

   std::string _inputFileName;
   std::vector<std::string> _analyses;
   std::string _run;
   std::vector<std::string> _processes;
   std::map<std::string, std::vector<std::string> > _events;
   std::map<std::string, std::string> _unitOfCrossSection;
   std::map<std::string, std::string> _unitOfCrossSectionError;

  private:
    void AddProcess( const boost::property_tree::ptree& ptree );
    void WriteInputFile();
    
  };

}
#endif 
