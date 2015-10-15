/* $Id: HerwigppCalculator.h 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

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

    double _Total_Xsec;
    double _Total_Xsec_error;

    std::string g;
    std::string u_R;
    std::string u_L;
    std::string d_R;
    std::string d_L;
    std::string s_R;
    std::string s_L;
    std::string c_R;
    std::string c_L;
    std::string b_1;
    std::string b_2;
    std::string t_1;
    std::string t_2;

    std::string u_Rbar;
    std::string u_Lbar;
    std::string d_Rbar;
    std::string d_Lbar;
    std::string s_Rbar;
    std::string s_Lbar;
    std::string c_Rbar;
    std::string c_Lbar;
    std::string b_1bar;
    std::string b_2bar;
    std::string t_1bar;
    std::string t_2bar;

    std::string gluino_1;
    std::string squark_1;
    std::string antisquark_1;
    std::string sbottom1_1;
    std::string sbottom2_1;
    std::string stop1_1;
    std::string stop2_1;

    std::string gluino_2;
    std::string squark_2;
    std::string antisquark_2;
    std::string sbottom1_2;
    std::string sbottom2_2;
    std::string stop1_2;
    std::string stop2_2;
    std::string process;
    std::string gg;
    std::string sb;
    std::string ss;
    std::string sg;
    std::string sb1;
    std::string sb2;
    std::string st1;
    std::string st2;

    
  };


}

#endif // FITTINO_HERWIGPPCALCULATOR_H
