#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <iostream>
#include <stdlib.h>
#include <cmath>
#include "ModelBase.h"
#include "RPVCalculator.h"

Fittino::RPVCalculator::RPVCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
: CalculatorBase(model, &ptree),
 _mbR ( _model->GetCollectionOfQuantities().At( ( "mbR" ) )->GetValue() ),
 _lambda_333 (  _model->GetCollectionOfQuantities().At("lambda'_333")->GetValue() ),
 _lambda_323 ( _model->GetCollectionOfQuantities().At("lambda'_323")->GetValue() ),
 _lambda_313 ( _model->GetCollectionOfQuantities().At("lambda'_313")->GetValue() )

{
    AddOutput("NormSM_RD",R_D_Relation);
    AddOutput("NormSM_RDstar",R_Dstar_Relation);
    AddOutput("NormSM_BR_B_tau_nu",B_tau_nu_relation);
    AddOutput("NormSM_BR_B_K_nu_nu",B_K_relation);
    AddOutput("NormSM_BR_B_pi_nu_nu",B_pi_relation);
    AddOutput("Ratio_gZtautau_gZll",Z_coupling_relation);
    AddOutput("Ratio_gWtaunu_gWlnu",W_coupling_relation);
    v = 246.0;
    X_t = 1.469;
    Vud = 0.97434;
    Vus = 0.22506;
    Vub = 0.00357;
    Vcd = 0.22492;
    Vcs = 0.97351;
    Vcb = 0.0411;
    Vtd = 0.00875;
    Vts = 0.0403;
    Vtb = 0.99915;
    //at W_Z & m_t direct measurement
    s_Wsq = 0.22336;
    alpha_em = 1./128.;
    m_t = 173.21;
    
    //s_Wsq = 0.23129;
    //alpha_em = 0.0078155529503712;
    //m_t = 160;
    
    
}

Fittino::RPVCalculator::~RPVCalculator() {
    
}

void Fittino::RPVCalculator::CalculatePredictions() {

    R_D_Relation = 1. + 0.5*pow(v/_mbR,2)*(pow(_lambda_333,2) + _lambda_333*_lambda_323*Vcs/Vcb + _lambda_333*_lambda_313*Vcd/Vcb);
    R_D_Relation = pow(R_D_Relation,2);
    R_Dstar_Relation = R_D_Relation;
    
    B_tau_nu_relation = 1. + 0.5*pow(v/_mbR,2)*(pow(_lambda_333,2) + _lambda_333*_lambda_323*Vus/Vub + _lambda_333*_lambda_313*Vud/Vub);
    B_tau_nu_relation = pow(B_tau_nu_relation,2);
    
    B_K_relation = 1. + pow(v/_mbR,2)*M_PI*s_Wsq*_lambda_333*_lambda_323/(alpha_em*Vtb*Vts*X_t);
    B_K_relation = 2./3 + 1./3.*pow(B_K_relation,2);
    
    B_pi_relation = 1. + pow(v/_mbR,2)*M_PI*s_Wsq*_lambda_333*_lambda_313/(alpha_em*Vtb*Vts*X_t);
    B_pi_relation = 2./3. + 1./3.*pow(B_pi_relation,2);
    
    f_Z = 1./(pow(m_t/_mbR,2)-1.) - log10(pow(m_t/_mbR,2))/pow((pow(m_t/_mbR,2)-1.),2);
    Z_coupling_relation = 1. - 3.*pow(_lambda_333/M_PI,2)*pow(m_t/_mbR,2)*f_Z/(16.*(1.-2.*s_Wsq));
    
    f_W = 1./(pow(m_t/_mbR,2)-1.) - (2.-pow(m_t/_mbR,2))*log10(pow(m_t/_mbR,2))/pow((pow(m_t/_mbR,2)-1.),2);
    W_coupling_relation = 1. - 3.*pow(_lambda_333/M_PI,2)*pow(m_t/_mbR,2)*f_W/(16.*4.);

}

void Fittino::RPVCalculator::Initialize() {
    
    
}



