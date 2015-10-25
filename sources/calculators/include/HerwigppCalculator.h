/******************************************************************************* 
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       * 
 *                                                                              * 
 * File        HerwigppCalculator.h                                             *
 * Description: Wrapper class for Herwig++                                      *
 * Authors:     Nanette Range                                                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_HERWIGPPCALCULATOR_H
#define FITTINO_HERWIGPPCALCULATOR_H

#include <map>
#include <string>

#include <boost/property_tree/ptree.hpp>

#include "Executor.h"
#include "CalculatorBase.h"

namespace Fittino {

  class HerwigppCalculator : public CalculatorBase {
    
  public:
    
    HerwigppCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
    ~HerwigppCalculator();

  public:

    virtual void CalculatePredictions();    
    virtual void Initialize();

  private:
    std::string _executable;
    std::string _inFile;
    std::string _outFile;
    std::string _logFile;
    std::string _runFile;
    
    std::string _line;
    std::vector<std::string> _words;
    std::istream& GetLine(std::istream& is);
    int GetPDGID(std::istream& is, int expectedRunningID);

    double _Total_Xsec;
    double _Total_Xsec_error;

 };


}

#endif
