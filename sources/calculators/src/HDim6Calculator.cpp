/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HDim6Calculator.cpp                                              *
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

#include <boost/foreach.hpp>

#include "TMath.h"

#include <LHAPDF/LHAPDF.h>

#include "HDim6/CrossSection_had.h"
#include "HDim6/decay.h"
#include "HDim6/gaugecpl.h"
#include "HDim6/VBF.h"

#include "HDim6Calculator.h"
#include "Quantity.h"
#include "ModelBase.h"
#include "SimplePrediction.h"

Fittino::HDim6Calculator::HDim6Calculator(const ModelBase *model, boost::property_tree::ptree &ptree)
    : CalculatorBase( model, &ptree ),
      _calculate_Gamma_hWW     ( ptree.get<bool>( "calculate_Gamma_hWW"      ) ),
      _calculate_Gamma_hZZ     ( ptree.get<bool>( "calculate_Gamma_hZZ"      ) ),
      _calculate_xs_qqh_2flavor( ptree.get<bool>( "calculate_xs_qqh_2flavor" ) ),
      _calculate_xs_qqh_5flavor( ptree.get<bool>( "calculate_xs_qqh_5flavor" ) ),
      _calculate_xs_Wh         ( ptree.get<bool>( "calculate_xs_Wh"          ) ),
      _calculate_xs_Zh         ( ptree.get<bool>( "calculate_xs_Zh"          ) ),
      _effsmvalues ( new effinputs() ),
      _effvalues   ( new effinputs() ),
      _first       ( true ),
      _pdfSet      ( "CT10" ),  // lhapdf-getdata CT10.LHgrid
      _pdfDirectory( "" ),
      _smvalues ( new sminputs() ) {

    SetName( "HDim6Calculator" );
    SetTag( "HDim6" );

    _effvalues->override_unitarity = ! ptree.get<bool>( "UseDampingCoefficients" );

    Messenger::GetInstance()<<Messenger::ALWAYS<<"Building calculator "<<_name<<Messenger::Endl;
    Messenger::GetInstance()<<Messenger::ALWAYS<<Messenger::Endl;
    Messenger::GetInstance()<<Messenger::ALWAYS<<"  Using the following settings: "<<Messenger::Endl;
    Messenger::GetInstance()<<Messenger::ALWAYS<<Messenger::Endl;
    Messenger::GetInstance()<<Messenger::ALWAYS<<"    UseDampingCoefficients: "<<!_effvalues->override_unitarity<<Messenger::Endl;

    AddInput( "Cutoff" );

    AddInput("Mass_h");

    AddInput("f_GG");
    AddInput("f_BB");
    AddInput("f_WW");
    AddInput("f_B");
    AddInput("f_W");
    AddInput("f_t");
    AddInput("f_b");
    AddInput("f_tau");
    AddInput("f_Phi_1");
    AddInput("f_Phi_2");
    AddInput("f_Phi_4");

    AddInput("r_GG");
    AddInput("r_BB");
    AddInput("r_WW");
    AddInput("r_B");
    AddInput("r_W");
    AddInput("r_Phi_1");
    AddInput("r_Phi_2");
    AddInput("r_Phi_4");

    AddInput("n_GG");
    AddInput("n_BB");
    AddInput("n_WW");
    AddInput("n_B");
    AddInput("n_W");
    AddInput("n_Phi_1");
    AddInput("n_Phi_2");
    AddInput("n_Phi_4");

    AddOutput( "vev"       );
    AddOutput( "sin2theta" );
    AddOutput( "Mass_W"    );

    AddOutput( "S_Parameter", _s_paramater );
    AddOutput( "T_Parameter", _t_paramater );
    AddOutput( "U_Parameter", _u_parameter );

    _Delta_kappa_Gamma = HDim6::d_kappa_y( _smvalues, _effvalues );
    _Delta_kappa_Z     = HDim6::d_kappa_z( _smvalues, _effvalues );
    _Delta_g1_gamma = HDim6::d_g1_y   ( _smvalues, _effvalues );
    _Delta_g1_Z        = HDim6::d_g1_z   ( _smvalues, _effvalues );

    AddOutput( "Delta_kappa_gamma", _Delta_kappa_Gamma );
    AddOutput( "Delta_kappa_Z", _Delta_kappa_Z ); 
    AddOutput( "Delta_g1_gamma", _Delta_g1_gamma);
    AddOutput( "Delta_g1_Z", _Delta_g1_Z ); 

    SetOutput( "vev"      , _smvalues->vev                   );
    SetOutput( "sin2theta", TMath::Power( _smvalues->sw, 2 ) );
    SetOutput( "Mass_W"   , _smvalues->mw                    );

    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_g_g",         "",      _normSM_Gamma_hgg     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_tau_tau",     "",      _normSM_Gamma_htautau ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_mu_mu",       "",      _normSM_Gamma_hmumu   ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_gamma_gamma", "",      _normSM_Gamma_hgaga   ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_Z_gamma",     "",      _normSM_Gamma_hZga    ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_b_b",         "",      _normSM_Gamma_hbb     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_c_c",         "",      _normSM_Gamma_hcc     ) );
    AddQuantity( new SimplePrediction( "NormSM_Gamma_h_s_s",         "",      _normSM_Gamma_hss     ) );

    if ( _calculate_Gamma_hZZ      ) {

        AddQuantity( new SimplePrediction( "NormSM_Gamma_h_Z_Z",    "", _normSM_Gamma_hZZ      ) );
        AddQuantity( new SimplePrediction( "Error_Gamma_h_Z_Z",    "", _error_Gamma_hZZ      ) );
        AddQuantity( new SimplePrediction( "Chi2_Gamma_h_Z_Z",    "", _chi2_Gamma_hZZ      ) );
        AddOutput( "Gamma_h_Z_Z", _Gamma_hZZ );

    }

    if ( _calculate_Gamma_hWW      )  {

        AddQuantity( new SimplePrediction( "NormSM_Gamma_h_W_W",    "", _normSM_Gamma_hWW      ) );
        AddQuantity( new SimplePrediction( "Error_Gamma_h_W_W",    "", _error_Gamma_hWW      ) );
        AddQuantity( new SimplePrediction( "Chi2_Gamma_h_W_W",    "", _chi2_Gamma_hWW      ) );
        AddOutput( "Gamma_h_W_W", _Gamma_hWW );

    }

    unsigned int nEnergies = ptree.count( "CenterOfMassEnergy" );

    _energies.resize( nEnergies );
    _normSM_xs_ggh.resize( nEnergies );
    _normSM_xs_bbh.resize( nEnergies );
    _normSM_xs_tth.resize( nEnergies );
    _normSM_xs_bh.resize( nEnergies );
    _normSM_xs_qqh_2flavor.resize( nEnergies );
    _normSM_xs_qqh_5flavor.resize( nEnergies );
    _normSM_xs_Wh.resize( nEnergies );
    _normSM_xs_Zh.resize( nEnergies );
    _SM_xs_qqh_2flavor.resize( nEnergies );
    _SM_xs_qqh_5flavor.resize( nEnergies );
    _SM_xs_Wh.resize( nEnergies );
    _SM_xs_Zh.resize( nEnergies );
    _xs_qqh_2flavor.resize( nEnergies );
    _xs_qqh_5flavor.resize( nEnergies );
    _xs_Wh.resize( nEnergies );
    _xs_Zh.resize( nEnergies );

    _error_xs_qqh_2flavor.resize( nEnergies );
    _error_xs_qqh_5flavor.resize( nEnergies );
    _error_xs_Wh.resize( nEnergies );
    _error_xs_Zh.resize( nEnergies );

    _chi2_xs_qqh_2flavor.resize( nEnergies );
    _chi2_xs_qqh_5flavor.resize( nEnergies );
    _chi2_xs_Wh.resize( nEnergies );
    _chi2_xs_Zh.resize( nEnergies );

    unsigned int iEnergy = 0;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

                    if ( node.first == "CenterOfMassEnergy" ) {

                        double energy = node.second.get<double>( "Value" );

                        std::string energyname = node.second.get<std::string>( "Name" );

                        std::string normtag( "NormSM_xs_LHC_" + energyname + "_" );
                        std::string xstag( "xs_LHC_" + energyname + "_" );
                        std::string errortag( "Error_xs_"  + energyname + "_" );
                        std::string chi2tag ( "Chi2_xs_"   + energyname + "_" );

                        _energies.at( iEnergy ) = energy;
                        Messenger::GetInstance()<<Messenger::ALWAYS<<"    CenterOfMassEnergy: "<<energy<<" GeV"<<Messenger::Endl;

                        AddQuantity( new SimplePrediction( normtag + "ggh", "", _normSM_xs_ggh.at( iEnergy ) ) );
                        AddQuantity( new SimplePrediction( normtag + "bbh", "", _normSM_xs_bbh.at( iEnergy ) ) );
                        AddQuantity( new SimplePrediction( normtag + "tth", "", _normSM_xs_tth.at( iEnergy ) ) );
                        AddQuantity( new SimplePrediction( normtag + "bh", "", _normSM_xs_bh.at( iEnergy ) ) );

                        if ( _calculate_xs_qqh_2flavor ) {

                            AddQuantity( new SimplePrediction( normtag + "qqh_2flavor", "", _normSM_xs_qqh_2flavor.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( errortag + "qqh_2flavor", "", _error_xs_qqh_2flavor.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( chi2tag + "qqh_2flavor", "", _chi2_xs_qqh_2flavor.at( iEnergy ) ) );
                            AddOutput( xstag + "qqh_2flavor", _xs_qqh_2flavor.at( iEnergy ) );

                        }
                        if ( _calculate_xs_qqh_5flavor ) {

                                AddQuantity( new SimplePrediction( normtag + "qqh_5flavor", "", _normSM_xs_qqh_5flavor.at( iEnergy ) ) );
                                AddQuantity( new SimplePrediction( errortag + "qqh_5flavor", "", _error_xs_qqh_5flavor.at( iEnergy ) ) );
                                AddQuantity( new SimplePrediction( chi2tag + "qqh_5flavor", "", _chi2_xs_qqh_5flavor.at( iEnergy ) ) );
                                AddOutput( xstag + "qqh_5flavor", _xs_qqh_5flavor.at( iEnergy ) );

                        }
                        if ( _calculate_xs_Wh ) {

                            AddQuantity( new SimplePrediction( normtag + "Wh", "", _normSM_xs_Wh.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( errortag + "Wh", "", _error_xs_Wh.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( chi2tag + "Wh", "", _chi2_xs_Wh.at( iEnergy ) ) );
                            AddOutput( xstag + "Wh", _xs_Wh.at( iEnergy ) );

                        }
                        if ( _calculate_xs_Zh ) {

                            AddQuantity( new SimplePrediction( normtag + "Zh", "", _normSM_xs_Zh.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( errortag + "Zh", "", _error_xs_Zh.at( iEnergy ) ) );
                            AddQuantity( new SimplePrediction( chi2tag + "Zh", "", _chi2_xs_Zh.at( iEnergy ) ) );
                            AddOutput( xstag + "Zh", _xs_Zh.at( iEnergy ) );

                        }

                        ++iEnergy;

                    }

                }

    if ( _pdfDirectory != "" ) {

        LHAPDF::setPDFPath( _pdfDirectory );

    }

    LHAPDF::initPDFSet( _pdfSet, LHAPDF::LHGRID, 0 );

}

Fittino::HDim6Calculator::~HDim6Calculator() {

    delete _effvalues;
    delete _effsmvalues;
    delete _smvalues;

}

void Fittino::HDim6Calculator::CalculatePredictions() {

    Messenger& messenger = Messenger::GetInstance();

    messenger<<Messenger::INFO<<"Updating calculator "<<_name<<Messenger::Endl;
    messenger << Messenger::Endl;

    ConfigureInput();

    messenger << Messenger::INFO << "  Using the following input:"<< Messenger::Endl;
    messenger << Messenger::Endl;
    PrintInput();


    CallFunction();

}

void Fittino::HDim6Calculator::CallFunction() {

    bool new_mh = ( _first || _previous_mass_h != _smvalues ->mh );

    bool new_gridParameters = (
                                  _first
                                  || new_mh
                                  || _previous_f_B     != _effvalues->fb
                                  || _previous_f_BB    != _effvalues->fbb
                                  || _previous_f_WW    != _effvalues->fww
                                  || _previous_f_W     != _effvalues->fw
                                  || _previous_f_Phi_2 != _effvalues->fp2
                              );

    if ( _first )  _first = false;

    if ( new_mh )  _previous_mass_h = _smvalues ->mh;

    if ( new_gridParameters ) {

        _previous_f_B     = _effvalues->fb;
        _previous_f_W     = _effvalues->fw;
        _previous_f_BB    = _effvalues->fbb;
        _previous_f_WW    = _effvalues->fww;
        _previous_f_Phi_2 = _effvalues->fp2;

    }

    _Delta_g1_WW       = HDim6::d_g1_ww  ( _smvalues, _effvalues );
    _Delta_g2_WW       = HDim6::d_g2_ww  ( _smvalues, _effvalues );
    _Delta_g1_gaga     = HDim6::d_g1_yy  ( _smvalues, _effvalues );
    _Delta_g2_gaga     = HDim6::d_g2_yy  ( _smvalues, _effvalues );
    _Delta_g1_ZZ       = HDim6::d_g1_zz  ( _smvalues, _effvalues );
    _Delta_g2_ZZ       = HDim6::d_g2_zz  ( _smvalues, _effvalues );
    _Delta_g1_Zga      = HDim6::d_g1_zy  ( _smvalues, _effvalues );
    _Delta_g2_Zga      = HDim6::d_g2_zy  ( _smvalues, _effvalues );
    _Delta_kappa_Gamma = HDim6::d_kappa_y( _smvalues, _effvalues );
    _Delta_kappa_Z     = HDim6::d_kappa_z( _smvalues, _effvalues );
    _Delta_g1_gamma = HDim6::d_g1_y   ( _smvalues, _effvalues );
    _Delta_g1_Z        = HDim6::d_g1_z   ( _smvalues, _effvalues );

    _s_paramater = s_parameter( _effvalues, _smvalues, GetInput( "Cutoff" ) );
    _t_paramater = t_parameter( _effvalues, _smvalues, GetInput( "Cutoff" ) );
    _u_parameter = u_parameter( _effvalues, _smvalues, GetInput( "Cutoff" ) );

    double error, chi2;

    if ( new_mh ) {

        hglgl_( _smvalues, _effsmvalues, &_SM_Gamma_hgg,     &error );
        hgaga_( _smvalues, _effsmvalues, &_SM_Gamma_hgaga,   &error );
        hgaz_ ( _smvalues, _effsmvalues, &_SM_Gamma_hZga,    &error );
        hmumu_( _smvalues, _effsmvalues, &_SM_Gamma_hmumu,   &error );
        htata_( _smvalues, _effsmvalues, &_SM_Gamma_htautau, &error );
        hchch_( _smvalues, _effsmvalues, &_SM_Gamma_hcc,     &error );
        hstst_( _smvalues, _effsmvalues, &_SM_Gamma_hss,     &error );
        hbobo_( _smvalues, _effsmvalues, &_SM_Gamma_hbb,     &error );

    }

    hglgl_( _smvalues, _effvalues, &_Gamma_hgg,     &error );
    hgaga_( _smvalues, _effvalues, &_Gamma_hgaga,   &error );
    hgaz_ ( _smvalues, _effvalues, &_Gamma_hZga,    &error );
    hmumu_( _smvalues, _effvalues, &_Gamma_hmumu,   &error );
    htata_( _smvalues, _effvalues, &_Gamma_htautau, &error );
    hchch_( _smvalues, _effvalues, &_Gamma_hcc,     &error );
    hstst_( _smvalues, _effvalues, &_Gamma_hss,     &error );
    hbobo_( _smvalues, _effvalues, &_Gamma_hbb,     &error );

    _normSM_Gamma_hgg     = _Gamma_hgg     / _SM_Gamma_hgg;
    _normSM_Gamma_hgaga   = _Gamma_hgaga   / _SM_Gamma_hgaga;
    _normSM_Gamma_hZga    = _Gamma_hZga    / _SM_Gamma_hZga;
    _normSM_Gamma_hmumu   = _Gamma_hmumu   / _SM_Gamma_hmumu;
    _normSM_Gamma_htautau = _Gamma_htautau / _SM_Gamma_htautau;
    _normSM_Gamma_hcc     = _Gamma_hcc     / _SM_Gamma_hcc;
    _normSM_Gamma_hss     = _Gamma_hss     / _SM_Gamma_hss;
    _normSM_Gamma_hbb     = _Gamma_hbb     / _SM_Gamma_hbb;

    if ( new_gridParameters )  {

        if ( new_mh ) {

            if ( _calculate_Gamma_hZZ ) hzz_( _smvalues, _effsmvalues, &_SM_Gamma_hZZ, &error, &chi2 );
            if ( _calculate_Gamma_hWW ) hww_( _smvalues, _effsmvalues, &_SM_Gamma_hWW, &error, &chi2 );

        }

        if ( _calculate_Gamma_hZZ ) hzz_( _smvalues, _effvalues, &_Gamma_hZZ, &_error_Gamma_hZZ, &_chi2_Gamma_hZZ );
        if ( _calculate_Gamma_hWW ) hww_( _smvalues, _effvalues, &_Gamma_hWW, &_error_Gamma_hWW, &_chi2_Gamma_hWW );

        if ( _calculate_Gamma_hZZ ) _normSM_Gamma_hZZ = _Gamma_hZZ / _SM_Gamma_hZZ;
        if ( _calculate_Gamma_hWW ) _normSM_Gamma_hWW = _Gamma_hWW / _SM_Gamma_hWW;

    }

    for (unsigned int iEnergy = 0; iEnergy < _energies.size(); ++iEnergy) {

        _smvalues->s = TMath::Power(_energies.at( iEnergy ), 2);

        k_ggh_(_smvalues, _effvalues, &_normSM_xs_ggh.at( iEnergy ), &error, &chi2);
        ratio_bb_h_(_smvalues, _effvalues, &_normSM_xs_bbh.at( iEnergy ), &error, &chi2);
        ratio_tth_(_smvalues, _effvalues, &_normSM_xs_tth.at( iEnergy ), &error, &chi2);
        ratio_bg_bh_(_smvalues, _effvalues, &_normSM_xs_bh.at( iEnergy ), &error, &chi2);

        if (new_gridParameters) {

            if (new_mh) {

                if (_calculate_xs_Wh) HWRadiation_(_smvalues, _effsmvalues, &_SM_xs_Wh.at( iEnergy), &error, &chi2);
                if (_calculate_xs_Zh) HZRadiation_(_smvalues, _effsmvalues, &_SM_xs_Zh.at( iEnergy ), &error, &chi2);
                if (_calculate_xs_qqh_2flavor) ud_jjh_(_smvalues, _effsmvalues, &_SM_xs_qqh_2flavor.at( iEnergy ), &error, &chi2);
                if (_calculate_xs_qqh_5flavor) udcsb_jjh_(_smvalues, _effsmvalues, &_SM_xs_qqh_5flavor.at( iEnergy ), &error, &chi2);

            }

            if (_calculate_xs_Wh) HWRadiation_(_smvalues, _effvalues, &_xs_Wh.at( iEnergy ), &_error_xs_Wh.at( iEnergy ), &_chi2_xs_Wh.at( iEnergy ) );
            if (_calculate_xs_Zh) HZRadiation_(_smvalues, _effvalues, &_xs_Zh.at( iEnergy ), &_error_xs_Zh.at( iEnergy ), &_chi2_xs_Zh.at( iEnergy ) );
            if (_calculate_xs_qqh_2flavor) ud_jjh_(_smvalues, _effvalues, &_xs_qqh_2flavor.at( iEnergy ), &_error_xs_qqh_2flavor.at( iEnergy ), &_chi2_xs_qqh_2flavor.at( iEnergy ) );
            if (_calculate_xs_qqh_5flavor) udcsb_jjh_(_smvalues, _effvalues, &_xs_qqh_5flavor.at( iEnergy ), &_error_xs_qqh_5flavor.at( iEnergy ), &_chi2_xs_qqh_5flavor.at( iEnergy ) );

            if (_calculate_xs_Wh) _normSM_xs_Wh.at( iEnergy ) = _xs_Wh.at( iEnergy ) / _SM_xs_Wh.at( iEnergy );
            if (_calculate_xs_Zh) _normSM_xs_Zh.at( iEnergy ) = _xs_Zh.at( iEnergy ) / _SM_xs_Zh.at( iEnergy );
            if (_calculate_xs_qqh_2flavor) _normSM_xs_qqh_2flavor.at( iEnergy ) = _xs_qqh_2flavor.at( iEnergy ) / _SM_xs_qqh_2flavor.at( iEnergy );
            if (_calculate_xs_qqh_5flavor) _normSM_xs_qqh_5flavor.at( iEnergy ) = _xs_qqh_5flavor.at( iEnergy ) / _SM_xs_qqh_5flavor.at( iEnergy );

        }

    }

}

void Fittino::HDim6Calculator::ConfigureInput() {

    UpdateInput();

    _smvalues ->mh   = GetInput( "Mass_h" );

    _effvalues->fgg  = GetInput( "f_GG" );
    _effvalues->fbb  = GetInput( "f_BB" );
    _effvalues->fww  = GetInput( "f_WW" );
    _effvalues->fb   = GetInput( "f_B" );
    _effvalues->fw   = GetInput( "f_W" );
    _effvalues->ftoh = GetInput( "f_t" );
    _effvalues->fboh = GetInput( "f_b" );
    _effvalues->ftah = GetInput( "f_tau" );
    _effvalues->fp1  = GetInput( "f_Phi_1" );
    _effvalues->fp2  = GetInput( "f_Phi_2" );
    _effvalues->fp4  = GetInput( "f_Phi_4" );

    _effvalues->rgg  = TMath::Power( GetInput( "r_GG"    ), 2 );
    _effvalues->rbb  = TMath::Power( GetInput( "r_BB"    ), 2 );
    _effvalues->rww  = TMath::Power( GetInput( "r_WW"    ), 2 );
    _effvalues->rb   = TMath::Power( GetInput( "r_B"     ), 2 );
    _effvalues->rw   = TMath::Power( GetInput( "r_W"     ), 2 );
    _effvalues->rp1  = TMath::Power( GetInput( "r_Phi_1" ), 2 );
    _effvalues->rp2  = TMath::Power( GetInput( "r_Phi_2" ), 2 );
    _effvalues->rp4  = TMath::Power( GetInput( "r_Phi_4" ), 2 );

    _effvalues->ngg  = GetInput( "n_GG" );
    _effvalues->nbb  = GetInput( "n_BB" );
    _effvalues->nww  = GetInput( "n_WW" );
    _effvalues->nb   = GetInput( "n_B" );
    _effvalues->nw   = GetInput( "n_W" );
    _effvalues->np1  = GetInput( "n_Phi_1" );
    _effvalues->np2  = GetInput( "n_Phi_2" );
    _effvalues->np4  = GetInput( "n_Phi_4" );

};
