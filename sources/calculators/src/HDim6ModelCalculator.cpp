/* $Id$ */ 

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6ModelCalculator.cpp                                         *
*                                                                              *
* Description Wrapper class for HDim6                                          * 
*                                                                              *
* Authors     Bastian Heller    <bastian.heller@rwth-aachen.de>                *
*             Bjoern  Sarrazin  <sarrazin@physik.uni-bonn.de>                  *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TMath.h"

#include <LHAPDF/LHAPDF.h>

#include "HDim6/CrossSection.h" 
#include "HDim6/CrossSection_had.h" 
#include "HDim6/decay.h" 
#include "HDim6/gaugecpl.h"
#include "HDim6/inputs.h" 
#include "HDim6/VBF.h"

#include "HDim6ModelCalculator.h"
#include "ModelParameterBase.h"
#include "PhysicsModelBase.h"
#include "SimpleDataStorage.h"

extern "C" {

    double smbr_hss_    ( double* massh );
    double smbr_hcc_    ( double* massh );
    double smbr_hbb_    ( double* massh );
    double smbr_htoptop_( double* massh );
    double smbr_hmumu_  ( double* massh );
    double smbr_htautau_( double* massh );
    double smbr_hgamgam_( double* massh );
    double smbr_hgg_    ( double* massh );
    double smbr_hww_    ( double* massh );
    double smbr_hzgam_  ( double* massh );
    double smbr_hzz_    ( double* massh );
    double smgamma_h_   ( double* massh );

    void initialize_higgsbounds_int_(int* nH, int* nHplus, int* whichanalysis);
  
}

Fittino::HDim6ModelCalculator::HDim6ModelCalculator( const PhysicsModelBase* model )
        :ModelCalculatorBase( model ){

    _name = "HDim6ModelCalculator";

    // lhapdf-getdata CT10.LHgrid
    _pdfSet = "CT10";

    _interpolateGamma      = false;
    _interpolateXS         = false;
    _smValuesChanged       = true;
    _gridParametersChanged = true;

    _decayChannels.push_back( "hbb"     );
    _decayChannels.push_back( "hcc"     );
    _decayChannels.push_back( "hss"     );
    _decayChannels.push_back( "htautau" );
    _decayChannels.push_back( "hmumu"   );
    _decayChannels.push_back( "hWW"     );
    _decayChannels.push_back( "hgg"     );
    _decayChannels.push_back( "hZZ"     );
    _decayChannels.push_back( "hgaga"   );
    _decayChannels.push_back( "hZga"    );


    InitializeSimpleOutputDataStorage();

    _effvalues         = new effinputs();
    _effsmvalues       = new effinputs();
    _smvalues          = new sminputs();

    _previousEffValues = 0;
    _previousSMValues  = 0;

}

Fittino::HDim6ModelCalculator::~HDim6ModelCalculator() {

    delete _effvalues;
    delete _effsmvalues;
    delete _smvalues;
    delete _previousEffValues;
    delete _previousSMValues;

}

void Fittino::HDim6ModelCalculator::CalculatePredictions() {

    ConfigureInput();
    ComparePreviousSMValues();
    ComparePreviousEffValues();
    
    if ( _smValuesChanged ) {
      
      CalculateLO( true ); 
      CalculateBRSM();
      
    }

    CalculateLO( false );
    CalculateNormSM();
    CalculateBR();
    CalculateTripleGaugeCouplings();
    CalculateQuarticGaugeCouplings();

}

void Fittino::HDim6ModelCalculator::Initialize() const {

    if ( _pdfDirectory !="" ){

        LHAPDF::setPDFPath( _pdfDirectory );

    }
    
    LHAPDF::initPDFSet( _pdfSet, LHAPDF::LHGRID, 0 );  

    int nHzero = 1;
    int nHplus = 0;
    int whichanalysis = 1;

    initialize_higgsbounds_int_( &nHzero, &nHplus, &whichanalysis );
  
}

void Fittino::HDim6ModelCalculator::CalculateBR(){

    _simpleOutputDataStorage->GetMap()->at( "Gamma_hTotal" ) = 0;

    for ( unsigned int i = 0; i < _decayChannels.size(); i++ ) {

        _simpleOutputDataStorage->GetMap()->at( "Gamma_"       + _decayChannels[i] )
	    =  _simpleOutputDataStorage->GetMap()->at( "Gamma_normSM_" + _decayChannels[i] )
	    *  _simpleOutputDataStorage->GetMap()->at( "Gamma_SM_"     + _decayChannels[i] );

	_simpleOutputDataStorage->GetMap()->at( "Gamma_hTotal"                     ) 
            += _simpleOutputDataStorage->GetMap()->at( "Gamma_"       + _decayChannels[i] );  	  

    }

    for ( unsigned int i = 0; i < _decayChannels.size(); i++ ) {

        _simpleOutputDataStorage      ->GetMap()->at( "BR_"    + _decayChannels[i] )
	    = _simpleOutputDataStorage->GetMap()->at( "Gamma_" + _decayChannels[i] )
            / _simpleOutputDataStorage->GetMap()->at( "Gamma_hTotal" );

    }

}

void Fittino::HDim6ModelCalculator::CalculateBRSM() {

    std::string tag;

    tag = "BR_SM_";

    _simpleOutputDataStorage->GetMap()->at( tag + "hss" ) = smbr_hss_( &_smvalues->mh );
    _simpleOutputDataStorage->GetMap()->at( tag + "hcc" ) = smbr_hcc_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hbb" ) = smbr_hbb_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hmumu" ) = smbr_hmumu_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "htautau" ) = smbr_htautau_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hgaga" ) = smbr_hgamgam_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hgg" ) = smbr_hgg_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hWW" ) = smbr_hww_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hZga" ) = smbr_hzgam_( &_smvalues->mh);
    _simpleOutputDataStorage->GetMap()->at( tag + "hZZ" ) = smbr_hzz_( &_smvalues->mh);

    tag  = "Gamma_SM_";

    _simpleOutputDataStorage->GetMap()->at( tag + "hTotal" ) = smgamma_h_( &_smvalues->mh);

    for ( unsigned int i = 0; i < _decayChannels.size(); i++ ) {
      
        _simpleOutputDataStorage      ->GetMap()->at( tag + _decayChannels[i]      )
   	    = _simpleOutputDataStorage->GetMap()->at( "BR_SM_" + _decayChannels[i] )
            * _simpleOutputDataStorage->GetMap()->at( "Gamma_SM_hTotal"            );

    }

}


void Fittino::HDim6ModelCalculator::CalculateLO( bool doSM ) {

    std::string gammatag;
    std::string xstag;
    effinputs* effvalues;

    if ( doSM ) {
      
        gammatag = "Gamma_SM_LO_";
	xstag = "XS_SM_LO_";
        effvalues = _effsmvalues;

    }
    else {

        gammatag = "Gamma_LO_";
	xstag = "XS_LO_";
        effvalues = _effvalues;

    }

    hglgl_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hgg"           ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hgg_error"     ) );

    hgaga_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hgaga"         ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hgaga_error"   ) );

    hgaz_ ( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hZga"          ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hZga_error"    ) );

    hmumu_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hmumu"         ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hmumu_error"   ) );

    htata_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "htautau"       ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "htautau_error" ) );

    hchch_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hcc"           ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hcc_error"     ) );

    hstst_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hss"           ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hss_error"     ) );

    hbobo_( _smvalues, effvalues,
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hbb"           ),
            &_simpleOutputDataStorage->GetMap()->at( gammatag + "hbb_error"     ) );

    if ( _smValuesChanged || _gridParametersChanged ) {

        if ( _interpolateGamma && !doSM ) {

	  // TODO: Do the interpolation here

	}  
	else {

	    hzz_  ( _smvalues, effvalues,
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hZZ"       ),
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hZZ_error" ),
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hZZ_chi2"  ) );

	    hww_  ( _smvalues, effvalues,
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hWW"       ),
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hWW_error" ),
		    &_simpleOutputDataStorage->GetMap()->at( gammatag + "hWW_chi2"  ) );

	}

	if ( _interpolateXS && !doSM ) {

	  // TODO: Do the interpolation here

	}
	else {

	    udcsb_jjh_( _smvalues, _effvalues,
			& _simpleOutputDataStorage->GetMap()->at( xstag + "qqh"),
			& _simpleOutputDataStorage->GetMap()->at( xstag + "qqh_error"), 
			& _simpleOutputDataStorage->GetMap()->at( xstag + "qqh_chi2") );

	    HWRadiation_( _smvalues, _effvalues,
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Wh"),
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Wh_error"),
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Wh_chi2") );

	    HZRadiation_( _smvalues, _effvalues,
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Zh"),
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Zh_error"),
			 & _simpleOutputDataStorage->GetMap()->at( xstag + "Zh_chi2") );

	}
 
    }

}

void Fittino::HDim6ModelCalculator::CalculateNormSM() {

    ratio_ggh_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_ggh_chi2") );

    ratio_bb_h_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bbh_chi2") );

    ratio_tth_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_tth_chi2") );

    ratio_bg_bh_( _smvalues, _effvalues,
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh_error"),
                & _simpleOutputDataStorage->GetMap()->at("XS_normSM_bh_chi2") );

    _simpleOutputDataStorage->GetMap()->at("XS_normSM_qqh") 
        = _simpleOutputDataStorage->GetMap()->at("XS_LO_qqh") 
        / _simpleOutputDataStorage->GetMap()->at("XS_SM_LO_qqh"); 

    _simpleOutputDataStorage->GetMap()->at("XS_normSM_Wh") 
        = _simpleOutputDataStorage->GetMap()->at("XS_LO_Wh") 
        / _simpleOutputDataStorage->GetMap()->at("XS_SM_LO_Wh"); 

    _simpleOutputDataStorage->GetMap()->at("XS_normSM_Zh") 
        = _simpleOutputDataStorage->GetMap()->at("XS_LO_Zh") 
        / _simpleOutputDataStorage->GetMap()->at("XS_SM_LO_Zh"); 

    for ( unsigned int i = 0; i < _decayChannels.size(); i++ ) {

        _simpleOutputDataStorage      ->GetMap()->at( "Gamma_normSM_" + _decayChannels[i] )
            = _simpleOutputDataStorage->GetMap()->at( "Gamma_LO_"     + _decayChannels[i] ) 
            / _simpleOutputDataStorage->GetMap()->at( "Gamma_SM_LO_"  + _decayChannels[i] ); 

    }

}

void Fittino::HDim6ModelCalculator::CalculateQuarticGaugeCouplings() {

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_WW"  )
        = HDim6::d_g1_ww ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_WW"  )
        = HDim6::d_g2_ww ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_gaga")
        = HDim6::d_g1_yy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_gaga") 
        = HDim6::d_g2_yy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_ZZ"  )
        = HDim6::d_g1_zz ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_ZZ"  )
        = HDim6::d_g2_zz ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_Zga" )
        = HDim6::d_g1_zy ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g2_Zga" )
        = HDim6::d_g2_zy ( _smvalues, _effvalues );

}

void Fittino::HDim6ModelCalculator::CalculateTripleGaugeCouplings() {

    _simpleOutputDataStorage->GetMap()->at("Delta_kappa_ga")
        = HDim6::d_kappa_y ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_kappa_Z" )
        = HDim6::d_kappa_z ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_ga"   )
        = HDim6::d_g1_y    ( _smvalues, _effvalues );

    _simpleOutputDataStorage->GetMap()->at("Delta_g1_Z"    )
        = HDim6::d_g1_z    ( _smvalues, _effvalues );

}

void Fittino::HDim6ModelCalculator::ComparePreviousEffValues() {

    if ( !_previousEffValues ) {
      
        _previousEffValues = new effinputs();
        _gridParametersChanged = true;

    }
    else {
    
        _gridParametersChanged
	  = (    _previousEffValues->fb  != _effvalues->fb
	      || _previousEffValues->fw  != _effvalues->fw
	      || _previousEffValues->fww != _effvalues->fww );

    }

    *_previousEffValues = *_effvalues;

}

void Fittino::HDim6ModelCalculator::ComparePreviousSMValues() {

   if ( !_previousSMValues ) {

        _previousSMValues = new sminputs();
	_smValuesChanged = true;
	
    }
    else {

        _smValuesChanged = ( *_previousSMValues != *_smvalues );

    }

    if ( _smValuesChanged ) {

        *_previousSMValues = *_smvalues;

    }

}

void Fittino::HDim6ModelCalculator::InitializeSimpleOutputDataStorage() {

    _simpleOutputDataStorage->AddEntry( "Gamma_hTotal" , 0 );
    _simpleOutputDataStorage->AddEntry( "Gamma_SM_hTotal" , 0 );
    _simpleOutputDataStorage->AddEntry( "Gamma_normSM_hTotal" , 0 );

    _simpleOutputDataStorage->AddEntry("Gamma_LO_hWW_chi2" , 0 );
    _simpleOutputDataStorage->AddEntry("Gamma_LO_hZZ_chi2" , 0 );
    _simpleOutputDataStorage->AddEntry("Gamma_SM_LO_hWW_chi2" , 0 );
    _simpleOutputDataStorage->AddEntry("Gamma_SM_LO_hZZ_chi2" , 0 );

    for ( unsigned int i = 0; i < _decayChannels.size(); i++ ) {

        _simpleOutputDataStorage->AddEntry("Gamma_LO_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("Gamma_SM_LO_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("Gamma_LO_" + _decayChannels[i] + "_error", 0 );
        _simpleOutputDataStorage->AddEntry("Gamma_SM_LO_" + _decayChannels[i] + "_error", 0 );

        _simpleOutputDataStorage->AddEntry("Gamma_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("Gamma_SM_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("Gamma_normSM_" + _decayChannels[i] , 0 );

        _simpleOutputDataStorage->AddEntry("BR_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("BR_SM_" + _decayChannels[i] , 0 );
        _simpleOutputDataStorage->AddEntry("BR_normSM_" + _decayChannels[i] , 0 );

    }

    std::string productionChannels1[4] = { "ggh", "bbh", "tth", "bh" };

    for ( unsigned int i = 0; i < 4; i++ ) {

        _simpleOutputDataStorage->AddEntry("XS_normSM_" + productionChannels1[i] , 0 );
	_simpleOutputDataStorage->AddEntry("XS_normSM_" + productionChannels1[i] + "_error" , 0 );
	_simpleOutputDataStorage->AddEntry("XS_normSM_" + productionChannels1[i] + "_chi2" , 0 );
	
    }

    std::string productionChannels2[3] = { "qqh", "Wh", "Zh" };

    for ( unsigned int i = 0; i < 3; i++ ) {

	_simpleOutputDataStorage->AddEntry("XS_LO_"        + productionChannels2[i]            , 0 );
	_simpleOutputDataStorage->AddEntry("XS_LO_"        + productionChannels2[i] + "_error" , 0 );
	_simpleOutputDataStorage->AddEntry("XS_LO_"        + productionChannels2[i] + "_chi2"  , 0 );
        _simpleOutputDataStorage->AddEntry("XS_SM_LO_"     + productionChannels2[i]            , 0 );
	_simpleOutputDataStorage->AddEntry("XS_SM_LO_"     + productionChannels2[i] + "_error" , 0 );
	_simpleOutputDataStorage->AddEntry("XS_SM_LO_"     + productionChannels2[i] + "_chi2"  , 0 );
	_simpleOutputDataStorage->AddEntry("XS_normSM_" + productionChannels2[i]             , 0); 

    }

    _simpleOutputDataStorage->AddEntry("Delta_kappa_ga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_kappa_Z", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_ga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_Z", -1);

    _simpleOutputDataStorage->AddEntry("Delta_g1_WW", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_WW", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_gaga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_gaga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_ZZ", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_ZZ", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g1_Zga", -1);
    _simpleOutputDataStorage->AddEntry("Delta_g2_Zga", -1);

}

void Fittino::HDim6ModelCalculator::CallExecutable() {

}

void Fittino::HDim6ModelCalculator::CallFunction() {


}


void Fittino::HDim6ModelCalculator::ConfigureInput() {

    _smvalues->mel    = 0.511e-3;
    _smvalues->mmu    = 0.10565;
    _smvalues->mta    = 1.777;
    _smvalues->mup    = 0.0023;
    _smvalues->mdo    = 0.0048;
    _smvalues->mch    = 1.275;
    _smvalues->mst    = 0.095;
    _smvalues->mto    = 173.5;
    _smvalues->mbo    = 4.18;

    _smvalues->mz     = 91.1876;
    _smvalues->mw     = 80.385;
    _smvalues->mh     = 125;

    _smvalues->alphae = 0.0078186;
    _smvalues->alphas = 0.11819;
    _smvalues->sw     = 0.48079;

    _smvalues->vud    = 0.97483;
    _smvalues->vus    = 0.2229;
    _smvalues->vub    = 0.0036;
    _smvalues->vcd    = 0.23;
    _smvalues->vcs    = 0.97389;
    _smvalues->vcb    = 40.9e-3;
    _smvalues->vtd    = 8.4e-3;
    _smvalues->vts    = 42.9e-3;
    _smvalues->vtb    = 0.89;

    _smvalues->s      = pow( 7000,2 );

    _smvalues->vev   = _smvalues->mw
                     * _smvalues->sw
                     * 2.0 
                     / sqrt(4.0*TMath::Pi()*_smvalues->alphae);

    _effvalues->fbb  = _model->GetParameterMap()->at( "F_BB"  )->GetValue();
    _effvalues->fww  = _model->GetParameterMap()->at( "F_WW"  )->GetValue();
    _effvalues->fgg  = _model->GetParameterMap()->at( "F_gg"  )->GetValue();
    _effvalues->fb   = _model->GetParameterMap()->at( "F_B"   )->GetValue();
    _effvalues->fw   = _model->GetParameterMap()->at( "F_W"   )->GetValue();
    _effvalues->fuph = _model->GetParameterMap()->at( "F_u"   )->GetValue();
    _effvalues->fdoh = _model->GetParameterMap()->at( "F_d"   )->GetValue();
    _effvalues->fchh = _model->GetParameterMap()->at( "F_c"   )->GetValue();
    _effvalues->fsth = _model->GetParameterMap()->at( "F_s"   )->GetValue();
    _effvalues->ftoh = _model->GetParameterMap()->at( "F_t"   )->GetValue();
    _effvalues->fboh = _model->GetParameterMap()->at( "F_b"   )->GetValue();
    _effvalues->felh = _model->GetParameterMap()->at( "F_e"   )->GetValue();
    _effvalues->fmuh = _model->GetParameterMap()->at( "F_mu"  )->GetValue();
    _effvalues->ftah = _model->GetParameterMap()->at( "F_tau" )->GetValue();


}
