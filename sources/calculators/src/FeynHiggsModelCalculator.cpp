/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        FeynHiggsModelCalculator.cpp                                     *
*                                                                              *
* Description Wrapper class for FeynHiggs                                      *
*                                                                              *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <iostream>

#include <boost/property_tree/ptree.hpp>
#include <boost/foreach.hpp>

#include "TMath.h"

#include "CFeynHiggs.h"

#include "FeynHiggsModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimplePrediction.h"

Fittino::FeynHiggsModelCalculator::FeynHiggsModelCalculator( const PhysicsModelBase* model, const boost::property_tree::ptree& ptree )
        : ModelCalculatorBase(model) {

    _name = "FeynHiggs";

    std::string flags = "400242110";

    FHSetFlagsString(&_error,flags.c_str() );
    if ( _error ) exit(_error); 


    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {
    
      if( node.first == "Input" ) {

        std::string name     = node.second.get<std::string>( "Name" );
        std::string quantity = node.second.get<std::string>( "Value" );

        const double& value = _model->GetCollectionOfQuantities().At( quantity )->GetValue();
        // std::string   unit  = _model->GetCollectionOfQuantities().At( quantity )->GetUnit(); Quantity does not yet have a unit

        _input.AddElement( new SimplePrediction( name, "" , value ) ) ;

      }

    }

}

Fittino::FeynHiggsModelCalculator::~FeynHiggsModelCalculator() {

}

void Fittino::FeynHiggsModelCalculator::CalculatePredictions() {

    std::cout<<"Calculate Predictions"<<std::endl;

    _derror = 0;

    SetSMParameters();

    if ( _derror ) {

      return;

    }

    SetParameters();

    if ( _derror ) {

      return;

    }

    HiggsCorr();

    if ( _derror ) {

        return;

    }

    Couplings();

    if ( _derror ) {

        return;

    }

    Production();

    if ( _derror ) {

        std::cout<<"ABORT"<<std::endl;
        return;

    }

}

void Fittino::FeynHiggsModelCalculator::Initialize() const {

}

void Fittino::FeynHiggsModelCalculator::CallExecutable() {

}

void Fittino::FeynHiggsModelCalculator::CallFunction() {

}

void Fittino::FeynHiggsModelCalculator::ConfigureInput() {

}

void Fittino::FeynHiggsModelCalculator::Couplings(){
  
    int fast=0;
    ComplexType couplings[ncouplings];
    ComplexType couplingsms[ncouplingsms];
    RealType gammas[ngammas];
    RealType gammasms[ngammasms];

    int one=1;

    //FHSelectUZ(&_error, one,one,one); // U

    FHSelectUZ(&_error, one,2,one); // Z

    FHCouplings(&_error, couplings, couplingsms, gammas, gammasms, fast);
    _derror = _error;
    if( _error ) return;

    //  Gamma(H0FF(1,4,3,3))=666;

    _gamma_h_tautau = Gamma(H0FF(1,2,3,3));
    _gamma_h_tautau_sm = GammaSM(H0FF(1,2,3,3));
    _gamma_h_tautau_smratio = _gamma_h_tautau / _gamma_h_tautau_sm;
  
    _gamma_h_cc = Gamma(H0FF(1,3,2,2));
    _gamma_h_cc_sm = GammaSM(H0FF(1,3,2,2));
    _gamma_h_cc_smratio = _gamma_h_cc / _gamma_h_cc_sm;
  
    _gamma_h_ss = Gamma(H0FF(1,4,2,2));
    _gamma_h_ss_sm = GammaSM(H0FF(1,4,2,2));
    _gamma_h_ss_smratio = _gamma_h_ss / _gamma_h_ss_sm;
  
    _gamma_h_bb = Gamma(H0FF(1,4,3,3));
    _gamma_h_bb_sm = GammaSM(H0FF(1,4,3,3));
    _gamma_h_bb_smratio = _gamma_h_bb / _gamma_h_bb_sm;

    _gamma_h_gaga = Gamma(H0VV(1,1));
    _gamma_h_gaga_sm = GammaSM(H0VV(1,1));
    _gamma_h_gaga_smratio = _gamma_h_gaga / _gamma_h_gaga_sm;

    _gamma_h_Zga_smratio = Gamma(H0VV(1,2))/GammaSM(H0VV(1,2));

    _gamma_h_ZZ_smratio = Gamma(H0VV(1,3))/GammaSM(H0VV(1,3));
  
    _gamma_h_WW_smratio = Gamma(H0VV(1,4))/GammaSM(H0VV(1,4));

    _gamma_h_gg_smratio = Gamma(H0VV(1,5))/GammaSM(H0VV(1,5));

    _gamma_h_tot_smratio = GammaTot(1)/GammaSMTot(1);

}

void Fittino::FeynHiggsModelCalculator::HiggsCorr(){

    RealType MHiggs[4];
    ComplexType SAeff, UHiggs[3][3], ZHiggs[3][3];

    FHHiggsCorr(&_error, MHiggs, &SAeff, UHiggs, ZHiggs);
    _derror = _error;
    if( _error ) return;

        _m_h = MHiggs[0];

    if ( _m_h < 1. ) {

        std::cout<<"Problem in mh calculation"<<std::endl;
        _error=1;
        _derror=1;

  }

}

void Fittino::FeynHiggsModelCalculator::Production(){
  
    RealType prodxs[nprodxs];
    double sqrts=8;
  
    FHHiggsProd(&_error, sqrts, prodxs);
    _derror = _error;

    if( _error ) return;

    _sigma_ggh_smratio = ggh(1) / gghSM(1); 

    _sigma_ggh2_smratio = ggh2(1) / gghSM(1); ;
    _sigma_bbh_smratio =  bbh(1) / bbhSM(1); ;
    _sigma_qqh_smratio = qqh(1) / qqhSM(1); ;
    _sigma_tth_smratio = tth(1) / tthSM(1); ;
    _sigma_Wh_smratio = Wh(1) / WhSM(1); ;
    _sigma_Zh_smratio = Zh(1) / ZhSM(1); ;
  
}

void Fittino::FeynHiggsModelCalculator::SetParameters(){

    _mass_t        = 173;

    _m_susy        = _model->GetCollectionOfParameters().At("MSusy")->GetValue();

    _m_1           = _m_susy;
    _m_2           = _m_susy;
    _m_3           = _m_susy;

    _m_sl_1        = _m_susy;
    _m_sl_2        = _m_susy;
    _m_sl_3        = _m_susy;

    _m_se_1        = _m_susy;
    _m_se_2        = _m_susy;
    _m_se_3        = _m_susy;
    
    _m_sq_1        = _m_susy;
    _m_sq_2        = _m_susy;
    _m_sq_3        = _m_susy;

    _m_su_1        = _m_susy;
    _m_su_2        = _m_susy;
    _m_su_3        = _m_susy;

    _m_sd_1        = _m_susy;
    _m_sd_2        = _m_susy;
    _m_sd_3        = _m_susy;

    _mass_A0       = _m_susy;
    _mass_Hp       = _m_susy;

    _Re_mu         = _m_susy*_model->GetCollectionOfParameters().At("signMu")->GetValue();
    _Im_mu         = 0;
    _mu            = std::complex<double>(_Re_mu, _Im_mu);

    _tanBeta       = _model->GetCollectionOfParameters().At("TanBeta")->GetValue();

    double Xt =  _model->GetCollectionOfParameters().At("relXt")->GetValue()*_m_susy;

    _Re_A_t        = Xt+_Re_mu/_tanBeta;
    _Im_A_t        = 0;
    _A_t           = std::complex<double>(_Re_A_t, _Im_A_t);   

    _Re_A_b        = _Re_A_t;
    _Im_A_b        = 0;
    _A_b           = std::complex<double>(_Re_A_b, _Im_A_b);   

    _Re_A_c        = _Re_A_t;           
    _Im_A_c        = 0;
    _A_c           = std::complex<double>(_Re_A_c, _Im_A_c);   

    _Re_A_s        = _Re_A_t;
    _Im_A_s        = 0;
    _A_s           = std::complex<double>(_Re_A_s, _Im_A_s);   

    _Re_A_d        = _Re_A_t;
    _Im_A_d        = 0;
    _A_d           = std::complex<double>(_Re_A_d, _Im_A_d);   

    _Re_A_u        = _Re_A_t;
    _Im_A_u        = 0;
    _A_u           = std::complex<double>(_Re_A_u, _Im_A_u);   

    _Re_A_tau      = _Re_A_t;
    _Im_A_tau      = 0;
    _A_tau         = std::complex<double>(_Re_A_tau, _Im_A_tau);   

    _Re_A_mu       = _Re_A_t;
    _Im_A_mu       = 0;
    _A_mu          = std::complex<double>(_Re_A_mu, _Im_A_mu);   

    _Re_A_e        = _Re_A_t;
    _Im_A_e        = 0;
    _A_e           = std::complex<double>(_Re_A_e, _Im_A_e);   

    _Q_tau         = 0;
    _Q_t           = 0;
    _Q_b           = 0;

    //    _scalefactor   = 1;
    //     double mstop1 = TMath::Sqrt( TMath::Power(_m_susy, 2) + TMath::Power(_mass_t, 2) - TMath::Abs( Xt * _mass_t ) );
    //     double mstop2 = TMath::Sqrt( TMath::Power(_m_susy, 2) + TMath::Power(_mass_t, 2) + TMath::Abs( Xt * _mass_t ) );
    //    _scalefactor  = TMath::Sqrt( mstop1 * mstop2 ) / _mass_t;

    _scalefactor = _m_susy / _mass_t;
    
    FHSetPara( &_error, _scalefactor,
	       _mass_t,
	       _tanBeta,
	       _mass_A0, _mass_Hp,
	       _m_sl_3, _m_se_3, _m_sq_3, _m_su_3, _m_sd_3,
	       _m_sl_2, _m_se_2, _m_sq_2, _m_su_2, _m_sd_2,
	       _m_sl_1, _m_se_1, _m_sq_1, _m_su_1, _m_sd_1,
	       _mu,
	       _A_tau, _A_t, _A_b, _A_mu, _A_c, _A_s, _A_e, _A_u, _A_d,
	       _m_1, _m_2, _m_3,
	       _Q_tau, _Q_t, _Q_b );

    _derror = _error;

}

void Fittino::FeynHiggsModelCalculator::SetSMParameters(){

    _alphaem_inv   = -1;
    _alphas_mass_Z = -1;
    _GF            = -1;
    
    _mass_e        = -1;
    _mass_mu       = -1;
    _mass_tau      = -1;

    _mass_u_2GeV   = -1;
    _mass_d_2GeV   = -1;
    _mass_s_2GeV   = -1;
    _mass_c_mass_c = -1;
    _mass_b_mass_b = -1;

    _mass_W         = -1;
    _mass_Z         = -1;

    _CKM_lambda    = -1;
    _CKM_A         = -1;
    _CKM_rhobar    = -1; 
    _CKM_etabar    = -1; 

    FHSetSMPara( &_error,
		 _alphaem_inv,
		 _alphas_mass_Z,
		 _GF,
		 _mass_e,
		 _mass_u_2GeV,
		 _mass_d_2GeV,
		 _mass_mu,
		 _mass_c_mass_c,
		 _mass_s_2GeV,
		 _mass_tau,
		 _mass_b_mass_b,
		 _mass_W,
		 _mass_Z,
		 _CKM_lambda,
		 _CKM_A,
		 _CKM_rhobar,  
		 _CKM_etabar ); 

    _derror = _error;
    
}
