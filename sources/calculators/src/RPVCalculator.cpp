#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <iostream>
#include <stdlib.h>
#include <cmath>
#include "ModelBase.h"
#include "RPVCalculator.h"

Fittino::RPVCalculator::RPVCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
: CalculatorBase(model, &ptree)

{

    AddInput( "Mass_sbottomR" );
    AddInput( "lambdaPrime_313" );
    AddInput( "lambdaPrime_323" );
    AddInput( "lambdaPrime_333" );
    AddInput( "Vev" );

    AddOutput("NormSM_RD",R_D_Relation);
    AddOutput("NormSM_RDstar",R_Dstar_Relation);
    AddOutput("NormSM_BR_B_tau_nu",B_tau_nu_relation);
    AddOutput("NormSM_BR_B_K_nu_nu",B_K_relation);
    AddOutput("NormSM_BR_B_pi_nu_nu",B_pi_relation);
    AddOutput("Ratio_gZtautau_gZll",Z_coupling_relation);
    AddOutput("Ratio_gWtaunu_gWlnu",W_coupling_relation);
    
    X_t = 1.469;
    s_Wsq = 0.22336;
    alpha_em = 1./128.;
    m_t = 173.21;
    
    InitializeCKMMatrix();
    
}

Fittino::RPVCalculator::~RPVCalculator() {
    
}

void Fittino::RPVCalculator::CalculatePredictions() {

    UpdateInput();

    const double&   mbR = GetInput( "Mass_sbottomR" );
    const double& lambda_313 = GetInput( "lambdaPrime_313" );
    const double& lambda_323 = GetInput( "lambdaPrime_323" );
    const double& lambda_333 = GetInput( "lambdaPrime_333" );
    const double& vev = GetInput( "Vev" );

    // 0.25 instead of 0.5 in literature
    R_D_Relation = std::norm( 1. + 0.25 * pow( vev / mbR, 2 ) * ( pow( lambda_333, 2 ) + lambda_333 * lambda_323 * Vcs / Vcb + lambda_333 * lambda_313 * Vcd / Vcb ) );
    R_Dstar_Relation = R_D_Relation;
    
    // 0.25 instead of 0.5 in literature
    B_tau_nu_relation = std::norm( 1. + 0.25 * pow( vev / mbR, 2 ) * ( pow( lambda_333, 2 ) + lambda_333 * lambda_323 * Vus / Vub + lambda_333 * lambda_313 * Vud / Vub ) );
    
    B_K_relation  = 2./3. + 1./3. * std::norm( 1. + pow( vev / mbR, 2 ) * M_PI * s_Wsq * lambda_333 * lambda_323 / ( alpha_em * Vtb * std::conj( Vts ) * X_t ) );
    
    B_pi_relation = 2./3. + 1./3. * std::norm( 1. + pow( vev / mbR, 2 ) * M_PI * s_Wsq * lambda_333 * lambda_313 / ( alpha_em * Vtb * std::conj( Vtd ) * X_t ) );
    
    double x = pow( m_t / mbR, 2 );
    double D =  16. * pow( M_PI, 2 );
    
    f_Z = 1. / ( x - 1. ) - log( x ) / pow( x - 1., 2 );
    Z_coupling_relation = 1. - 3. * pow( lambda_333, 2) / D / ( 1. - 2. * s_Wsq ) * x * f_Z ;
    
    f_W = 1. / ( x - 1. ) - ( 2. - x ) * log( x ) / pow( x - 1., 2 );
    W_coupling_relation = 1. - 3. * pow( lambda_333, 2) / D / 4.  * x * f_W;
    
}

void Fittino::RPVCalculator::Initialize() {
    
    
}

void Fittino::RPVCalculator::InitializeCKMMatrix() {
    
    // CKM Matrix according to http://pdg.lbl.gov/2016/reviews/rpp2016-rev-ckm-matrix.pdf
    
    // Start Equation 12.26
    
    double lambda = 0.22506;
    double A = 0.811;
    double rhobar = 0.124;
    double etabar = 0.356;
    
    // End Equation 12.26
    
    // Start Equation 12.4
    
    double s12 = lambda;
    double s23 = A * std::pow( lambda, 2 );
    
    const std::complex<double> i(0, 1);
    std::complex<double> rhoeta = rhobar + i * etabar;
    
    double A2lambda4 = std::pow( A, 2 ) * std::pow( lambda, 4 );
    
    std::complex<double> s13eidelta =  A * std::pow( lambda, 3 ) * rhoeta * std::sqrt( 1. - A2lambda4  );
    s13eidelta /= std::sqrt( 1. - std::pow( lambda, 2 ) ) * ( 1. - A2lambda4 * rhoeta );
    
    // End Equation 12.4
    
    double c12 = std::sqrt( 1. - std::norm( s12        ) );
    double c13 = std::sqrt( 1. - std::norm( s13eidelta ) );
    double c23 = std::sqrt( 1. - std::norm( s23        ) );
    
    // Start Equation 12.3
    
    Vud = c12 * c13;
    Vus = s12 * c13;
    Vub = std::conj( s13eidelta );
    
    Vcd = -s12 * c23 - c12 * s23 * s13eidelta;
    Vcs =  c12 * c23 - s12 * s23 * s13eidelta;
    Vcb =  s23 * c13;
    
    Vtd =  s12 * s23 - c12 * c23 * s13eidelta;
    Vts = -c12 * s23 - s12 * c23 * s13eidelta;
    Vtb =  c23 * c13;
    
    // End Equation 12.3
    
    auto& messenger = Messenger::GetInstance();
    messenger << Messenger::DEBUG << "CKM Matrix initialized to:" << Messenger::Endl;
    messenger << Messenger::DEBUG << Vud << "  " << Vus << "  " << Vub <<  Messenger::Endl;
    messenger << Messenger::DEBUG << Vcd << "  " << Vcs << "  " << Vcb <<  Messenger::Endl;
    messenger << Messenger::DEBUG << Vtd << "  " << Vts << "  " << Vtb <<  Messenger::Endl;
    messenger << Messenger::DEBUG << Messenger::Endl;
    
    messenger << Messenger::DEBUG << "Absolute Values are:" << Messenger::Endl;
    messenger << Messenger::DEBUG << std::abs( Vud ) << "  " << std::abs( Vus ) << "  " << std::abs( Vub ) <<  Messenger::Endl;
    messenger << Messenger::DEBUG << std::abs( Vcd ) << "  " << std::abs( Vcs ) << "  " << std::abs( Vcb ) <<  Messenger::Endl;
    messenger << Messenger::DEBUG << std::abs( Vtd ) << "  " << std::abs( Vts ) << "  " << std::abs( Vtb ) <<  Messenger::Endl;
    messenger << Messenger::DEBUG << Messenger::Endl;
    
}


