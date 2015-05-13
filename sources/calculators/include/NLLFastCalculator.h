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
