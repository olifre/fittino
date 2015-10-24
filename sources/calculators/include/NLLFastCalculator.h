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

#include "CalculatorBase.h"

namespace Fittino {
  class NLLFastCalculator : public CalculatorBase {
    
  public:
    
    NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree );
    ~NLLFastCalculator();

  public:

    virtual void CalculatePredictions();
    virtual void Initialize();
    
  private:

    std::string _griddir;
    std::string _executable;

    double _ms_gg;
    double _mg_gg;
    double _lo_gg;
    double _nlo_gg;
    double _nll_nlo_gg;
    double _d_mu_plus_gg;
    double _d_mu_minus_gg;
    double _d_pdf_plus_gg;
    double _d_pdf_minus_gg;
    double _d_as_plus_gg;
    double _d_as_minus_gg;
    double _k_nlo_gg;
    double _k_nll_gg;

    double _ms_sb;
    double _mg_sb;
    double _lo_sb;
    double _nlo_sb;
    double _nll_nlo_sb;
    double _d_mu_plus_sb;
    double _d_mu_minus_sb;
    double _d_pdf_plus_sb;
    double _d_pdf_minus_sb;
    double _d_as_plus_sb;
    double _d_as_minus_sb;
    double _k_nlo_sb;
    double _k_nll_sb;

    double _ms_st1;
    double _lo_st1;
    double _nlo_st1;
    double _nll_nlo_st1;
    double _d_mu_plus_st1;
    double _d_mu_minus_st1;
    double _d_pdf_plus_st1;
    double _d_pdf_minus_st1;
    double _d_as_plus_st1;
    double _d_as_minus_st1;
    double _k_nlo_st1;
    double _k_nll_st1;

    double _ms_st2;
    double _lo_st2;
    double _nlo_st2;
    double _nll_nlo_st2;
    double _d_mu_plus_st2;
    double _d_mu_minus_st2;
    double _d_pdf_plus_st2;
    double _d_pdf_minus_st2;
    double _d_as_plus_st2;
    double _d_as_minus_st2;
    double _k_nlo_st2;
    double _k_nll_st2;

    double _ms_sb1;
    double _lo_sb1;
    double _nlo_sb1;
    double _nll_nlo_sb1;
    double _d_mu_plus_sb1;
    double _d_mu_minus_sb1;
    double _d_pdf_plus_sb1;
    double _d_pdf_minus_sb1;
    double _d_as_plus_sb1;
    double _d_as_minus_sb1;
    double _k_nlo_sb1;
    double _k_nll_sb1;

    double _ms_sb2;
    double _lo_sb2;
    double _nlo_sb2;
    double _nll_nlo_sb2;
    double _d_mu_plus_sb2;
    double _d_mu_minus_sb2;
    double _d_pdf_plus_sb2;
    double _d_pdf_minus_sb2;
    double _d_as_plus_sb2;
    double _d_as_minus_sb2;
    double _k_nlo_sb2;
    double _k_nll_sb2;

    double _ms_ss;
    double _mg_ss;
    double _lo_ss;
    double _nlo_ss;
    double _nll_nlo_ss;
    double _d_mu_plus_ss;
    double _d_mu_minus_ss;
    double _d_pdf_plus_ss;
    double _d_pdf_minus_ss;
    double _d_as_plus_ss;
    double _d_as_minus_ss;
    double _k_nlo_ss;
    double _k_nll_ss;
    
    double _ms_sg;
    double _mg_sg;
    double _lo_sg;
    double _nlo_sg;
    double _nll_nlo_sg;
    double _d_mu_plus_sg;
    double _d_mu_minus_sg;
    double _d_pdf_plus_sg;
    double _d_pdf_minus_sg;
    double _d_as_plus_sg;
    double _d_as_minus_sg;
    double _k_nlo_sg;
    double _k_nll_sg;
  };

}


#endif //FITTINO_NLLFASTCALCULATOR_H
