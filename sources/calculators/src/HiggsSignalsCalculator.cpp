/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsCalculator.cpp                                       *
*                                                                              *
* Description Wrapper class for HiggsSignals using whichinput=hadr             *
                                                                               *
* Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <algorithm>

#include <boost/foreach.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "HiggsSignalsCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

bool         Fittino::HiggsSignalsCalculator::_HBisInitialized           = false;
bool         Fittino::HiggsSignalsCalculator::_HSisInitialized           = false;
unsigned int Fittino::HiggsSignalsCalculator::_initialized_nHzero        = 0    ;
unsigned int Fittino::HiggsSignalsCalculator::_initialized_nHplus        = 0    ;
std::string  Fittino::HiggsSignalsCalculator::_initialized_whichAnalyses = ""   ;
std::string  Fittino::HiggsSignalsCalculator::_initialized_expData       = ""   ;

Fittino::HiggsSignalsCalculator::HiggsSignalsCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    :CalculatorBase       ( model, &ptree                                                                         ),
    _redirector("/dev/null")
{

    _runHiggsBounds  = GetConfiguration()->get<bool>( "RunHiggsBounds"  );
    _runHiggsSignals = GetConfiguration()->get<bool>( "RunHiggsSignals" );
    _useInitialPredictionsAsMeasurements = GetConfiguration()->get<bool>( "UseInitialPredictionsAsMeasurements" );

    //  to make sure that the measurements HS provides are the real measurements, shut HS and HB down in any case
    if ( _HBisInitialized )  {

        finish_higgsbounds_();
        _HBisInitialized = false;

    }

    if ( _HSisInitialized ) {

        finish_higgssignals_();
        _HSisInitialized = false;

    }

    AddInputs();
    CheckMatrices();
    ResizeInputArrays();
    InitializeHBandHS( true );
    Setup( true );
    Run();
    DetermineNumberOfPeaks();
    ResizePeakArrays();
    DetermineObsIDs();
    UpdateOutput();
    InitializeMeasurements();
    AddOutputs();
    CalculatePredictions(); // recalculate with maybe changed measurements

}

void Fittino::HiggsSignalsCalculator::InitializeHBandHS(bool print) {


    std::string expData = GetConfiguration()->get<std::string>( "ExpData" );
    std::string whichAnalyses = GetConfiguration()->get<std::string>( "WhichAnalyses" );

    int nHzero = _names_h0.size();
    int nHplus = _names_hp.size();

    bool changed_nHiggs = ( nHzero != _initialized_nHzero || nHplus != _initialized_nHplus );
    bool changed_ExpData = ( expData != _initialized_expData );
    bool changed_whichAnalyses = ( whichAnalyses != _initialized_whichAnalyses );

    bool finishHB_becauseOfRunningHB = _HBisInitialized && _runHiggsBounds && ( changed_nHiggs || changed_whichAnalyses );
    bool finishHB_becauseOfRunningHS = _HBisInitialized && _runHiggsSignals && ( changed_nHiggs || ( _HSisInitialized && changed_ExpData ) );

    bool finishHS_becauseOfRunningHS = _HSisInitialized && _runHiggsSignals && ( changed_nHiggs || changed_ExpData );
    bool finishHS_becauseOfRunningHB = _HSisInitialized && _runHiggsBounds && changed_nHiggs;

    if ( finishHB_becauseOfRunningHB || finishHB_becauseOfRunningHS )  {

        finish_higgsbounds_();
        _HBisInitialized = false;

    }

    if ( finishHS_becauseOfRunningHS || finishHS_becauseOfRunningHB ) {

        finish_higgssignals_();
        _HSisInitialized = false;

    }

    if ( _runHiggsBounds && !_HBisInitialized ) {

        if ( !print ) _redirector.Start();
        initialize_higgsbounds_chisqtables_();
        initialize_higgsbounds_( &nHzero, &nHplus, whichAnalyses.c_str(), whichAnalyses.length() );
        if ( !print ) _redirector.Stop();

        _HBisInitialized = true;
        _initialized_nHzero = nHzero;
        _initialized_nHplus = nHplus;
        _initialized_whichAnalyses = whichAnalyses;

    }

    if ( _runHiggsSignals && !_HSisInitialized ) {

        if ( !print ) _redirector.Start();

        initialize_higgssignals_( &nHzero, &nHplus, expData.c_str(), expData.size() );

        if ( !print ) _redirector.Stop();

        _HSisInitialized = true;
        _initialized_nHzero = nHzero;
        _initialized_nHplus = nHplus;
        _initialized_expData = expData;

    }

}

Fittino::HiggsSignalsCalculator::~HiggsSignalsCalculator() {

}

void Fittino::HiggsSignalsCalculator::CalculatePredictions() {

    InitializeHBandHS( false );
    Setup( false );
    AssignMeasurements();
    Run();
    UpdateOutput();

}

void Fittino::HiggsSignalsCalculator::UpdateNeutralInput( bool shiftHiggsMass ) {

    if ( !_names_h0.size() ) return;

    for( unsigned int j = 0; j < _names_h0.size(); ++j ) {

        _neutralInput_Mh                [j] = GetInput( _names_h0[j] + ".Mass_h"                 );
        _neutralInput_GammaTot          [j] = GetInput( _names_h0[j] + ".Gamma_h_Total"          );
        _neutralInput_CP                [j] = GetInput( _names_h0[j] + ".CP"                     );
        _neutralInput_CS_lep_hjZ_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_LEP_Zh"       );
        _neutralInput_CS_lep_bbhj_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LEP_bbh"      );
        _neutralInput_CS_tev_hj_ratio   [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_h"        );
        _neutralInput_CS_tev_hjb_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_bh"       );
        _neutralInput_CS_tev_hjW_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_Wh"       );
        _neutralInput_CS_tev_hjZ_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_Zh"       );
        _neutralInput_CS_tev_vbf_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_qqh"      );
        _neutralInput_CS_tev_tthj_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_TEV_tth"      );
        _neutralInput_CS_lhc7_hj_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_h"   );
        _neutralInput_CS_lhc7_hjb_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_bh"  );
        _neutralInput_CS_lhc7_hjW_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_Wh"  );
        _neutralInput_CS_lhc7_hjZ_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_Zh"  );
        _neutralInput_CS_lhc7_vbf_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_qqh" );
        _neutralInput_CS_lhc7_tthj_ratio[j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_7TeV_tth" );
        _neutralInput_CS_lhc8_hj_ratio  [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_h"   );
        _neutralInput_CS_lhc8_hjb_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_bh"  );
        _neutralInput_CS_lhc8_hjW_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_Wh"  );
        _neutralInput_CS_lhc8_hjZ_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_Zh"  );
        _neutralInput_CS_lhc8_vbf_ratio [j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_qqh" );
        _neutralInput_CS_lhc8_tthj_ratio[j] = GetInput( _names_h0[j] + ".NormSM_xs_LHC_8TeV_tth" );
        _neutralInput_BR_hjss           [j] = GetInput( _names_h0[j] + ".BR_h_s_s"               );
        _neutralInput_BR_hjcc           [j] = GetInput( _names_h0[j] + ".BR_h_c_c"               );
        _neutralInput_BR_hjbb           [j] = GetInput( _names_h0[j] + ".BR_h_b_b"               );
        _neutralInput_BR_hjmumu         [j] = GetInput( _names_h0[j] + ".BR_h_mu_mu"             );
        _neutralInput_BR_hjtautau       [j] = GetInput( _names_h0[j] + ".BR_h_tau_tau"           );
        _neutralInput_BR_hjWW           [j] = GetInput( _names_h0[j] + ".BR_h_W_W"               );
        _neutralInput_BR_hjZZ           [j] = GetInput( _names_h0[j] + ".BR_h_Z_Z"               );
        _neutralInput_BR_hjZga          [j] = GetInput( _names_h0[j] + ".BR_h_Z_gamma"           );
        _neutralInput_BR_hjgaga         [j] = GetInput( _names_h0[j] + ".BR_h_gamma_gamma"       );
        _neutralInput_BR_hjgg           [j] = GetInput( _names_h0[j] + ".BR_h_g_g"               );
        _neutralInput_BR_hjinvisible    [j] = GetInput( _names_h0[j] + ".BR_h_Invisible"         );

        if ( shiftHiggsMass ) {

            _neutralInput_Mh[j] += _mass_h_neutral_shift[j];

        }

        int index = 0;

        for( unsigned int i = 0; i < _names_h0.size(); ++i ) {

            for( unsigned int j = 0; j < _names_h0.size(); ++j ) {

                // To get the order of the matrix elements right, one needs to take into account:
                // 1. The elements of BR hjhihi are ordered such that BR hjhihi(j,i)= BR(hj -> hihi)
                //    ( arXiv:1311.0055v1, p47, caption of Table B3 )
                // 2. Fortran uses column-major order
                //    ( http://en.wikipedia.org/wiki/Row-major_order )

                _neutralInput_CS_lep_hjhi_ratio[index] = GetInput( _names_h0[j] + "." + _names_h0[i] + ".NormSM_xs_LEP_hH" );
                _neutralInput_BR_hjhihi        [index] = GetInput( _names_h0[j] + "." + _names_h0[i] + ".BR_h_H_H"         );

                ++index;

            }

        }

        higgsbounds_neutral_input_hadr_( &_neutralInput_Mh                   [0],
                                         &_neutralInput_GammaTot             [0],
                                         &_neutralInput_CP                   [0],
                                         &_neutralInput_CS_lep_hjZ_ratio     [0],
                                         &_neutralInput_CS_lep_bbhj_ratio    [0],
                                         &_neutralInput_CS_lep_tautauhj_ratio[0],
                                         &_neutralInput_CS_lep_hjhi_ratio    [0],
                                         &_neutralInput_CS_tev_hj_ratio      [0],
                                         &_neutralInput_CS_tev_hjb_ratio     [0],
                                         &_neutralInput_CS_tev_hjW_ratio     [0],
                                         &_neutralInput_CS_tev_hjZ_ratio     [0],
                                         &_neutralInput_CS_tev_vbf_ratio     [0],
                                         &_neutralInput_CS_tev_tthj_ratio    [0],
                                         &_neutralInput_CS_lhc7_hj_ratio     [0],
                                         &_neutralInput_CS_lhc7_hjb_ratio    [0],
                                         &_neutralInput_CS_lhc7_hjW_ratio    [0],
                                         &_neutralInput_CS_lhc7_hjZ_ratio    [0],
                                         &_neutralInput_CS_lhc7_vbf_ratio    [0],
                                         &_neutralInput_CS_lhc7_tthj_ratio   [0],
                                         &_neutralInput_CS_lhc8_hj_ratio     [0],
                                         &_neutralInput_CS_lhc8_hjb_ratio    [0],
                                         &_neutralInput_CS_lhc8_hjW_ratio    [0],
                                         &_neutralInput_CS_lhc8_hjZ_ratio    [0],
                                         &_neutralInput_CS_lhc8_vbf_ratio    [0],
                                         &_neutralInput_CS_lhc8_tthj_ratio   [0],
                                         &_neutralInput_BR_hjss              [0],
                                         &_neutralInput_BR_hjcc              [0],
                                         &_neutralInput_BR_hjbb              [0],
                                         &_neutralInput_BR_hjmumu            [0],
                                         &_neutralInput_BR_hjtautau          [0],
                                         &_neutralInput_BR_hjWW              [0],
                                         &_neutralInput_BR_hjZZ              [0],
                                         &_neutralInput_BR_hjZga             [0],
                                         &_neutralInput_BR_hjgaga            [0],
                                         &_neutralInput_BR_hjgg              [0],
                                         &_neutralInput_BR_hjinvisible       [0],
                                         &_neutralInput_BR_hjhihi            [0] );

    }

}

void Fittino::HiggsSignalsCalculator::UpdateChargedInput( bool shiftHiggsMass ) {

    if ( ! _names_hp.size() ) return;

    _chargedInput_BR_tWpb = GetInput( "BR_t_W_b" );

    for( int i = 0; i < _names_hp.size(); ++i ) {

        _chargedInput_MHplus             [i] = GetInput( _names_hp[i] + ".Mass_h"         );
        _chargedInput_GammaTot           [i] = GetInput( _names_hp[i] + ".Gamma_h_Total"  );
        _chargedInput_CS_lep_HpjHmj_ratio[i] = GetInput( _names_hp[i] + ".Norm_xs_LEP_hh" );
        _chargedInput_BR_tHpjb           [i] = GetInput( _names_hp[i] + ".BR_t_h_b"       );
        _chargedInput_BR_Hpjcs           [i] = GetInput( _names_hp[i] + ".BR_h_c_s"       );
        _chargedInput_BR_Hpjcb           [i] = GetInput( _names_hp[i] + ".BR_h_c_b"       );
        _chargedInput_BR_Hptaunu         [i] = GetInput( _names_hp[i] + ".BR_h_tau_nu"    );

        if ( shiftHiggsMass ) {

            _chargedInput_MHplus[i] += _mass_h_charged_shift[i];

        }

    }

    higgsbounds_charged_input_( &_chargedInput_MHplus             [0],
                                &_chargedInput_GammaTot           [0],
                                &_chargedInput_CS_lep_HpjHmj_ratio[0],
                                &_chargedInput_BR_tWpb               ,
                                &_chargedInput_BR_tHpjb           [0],
                                &_chargedInput_BR_Hpjcs           [0],
                                &_chargedInput_BR_Hpjcb           [0],
                                &_chargedInput_BR_Hptaunu         [0] );


}

void Fittino::HiggsSignalsCalculator::UpdateMassUncertainties() {

    for( unsigned int i = 0; i < _names_h0.size(); ++i ) {

        _massUncertainty_HB_neutral[i] = GetInput( _names_h0[i] + ".Error_Mass_h_HB" );
        _massUncertainty_HS_neutral[i] = GetInput( _names_h0[i] + ".Error_Mass_h_HS" );

    }

    for( unsigned int i = 0; i < _names_hp.size(); ++i ) {

        _massUncertainty_HB_charged[i] = GetInput( _names_hp[i] + ".Error_Mass_h" );

    }

    if ( _runHiggsBounds ) {

        higgsbounds_set_mass_uncertainties_( &_massUncertainty_HB_neutral[0],
                                             &_massUncertainty_HB_charged[0] );

    }

    if ( _runHiggsSignals && _names_h0.size() ) {

        higgssignals_neutral_input_massuncertainty_( &_massUncertainty_HS_neutral[0] );

    }

}

void Fittino::HiggsSignalsCalculator::ResizeInputArrays() {

    _chargedInput_MHplus             .resize( _names_hp.size() );
    _chargedInput_GammaTot           .resize( _names_hp.size() );
    _chargedInput_CS_lep_HpjHmj_ratio.resize( _names_hp.size() );
    _chargedInput_BR_tHpjb           .resize( _names_hp.size() );
    _chargedInput_BR_Hpjcs           .resize( _names_hp.size() );
    _chargedInput_BR_Hpjcb           .resize( _names_hp.size() );
    _chargedInput_BR_Hptaunu         .resize( _names_hp.size() );

    _neutralInput_Mh                   .resize( _names_h0.size()              );
    _neutralInput_GammaTot             .resize( _names_h0.size()              );
    _neutralInput_CP                   .resize( _names_h0.size()              );
    _neutralInput_CS_lep_hjZ_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_lep_bbhj_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lep_tautauhj_ratio.resize( _names_h0.size()              );
    _neutralInput_CS_lep_hjhi_ratio    .resize( _names_h0.size() * _names_h0.size() );
    _neutralInput_CS_tev_hj_ratio      .resize( _names_h0.size()              );
    _neutralInput_CS_tev_hjb_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_tev_hjW_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_tev_hjZ_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_tev_vbf_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_tev_tthj_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_hj_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_hjb_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_hjW_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_hjZ_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_vbf_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc7_tthj_ratio   .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_hj_ratio     .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_hjb_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_hjW_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_hjZ_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_vbf_ratio    .resize( _names_h0.size()              );
    _neutralInput_CS_lhc8_tthj_ratio   .resize( _names_h0.size()              );
    _neutralInput_BR_hjss              .resize( _names_h0.size()              );
    _neutralInput_BR_hjcc              .resize( _names_h0.size()              );
    _neutralInput_BR_hjbb              .resize( _names_h0.size()              );
    _neutralInput_BR_hjmumu            .resize( _names_h0.size()              );
    _neutralInput_BR_hjtautau          .resize( _names_h0.size()              );
    _neutralInput_BR_hjWW              .resize( _names_h0.size()              );
    _neutralInput_BR_hjZZ              .resize( _names_h0.size()              );
    _neutralInput_BR_hjZga             .resize( _names_h0.size()              );
    _neutralInput_BR_hjgaga            .resize( _names_h0.size()              );
    _neutralInput_BR_hjgg              .resize( _names_h0.size()              );
    _neutralInput_BR_hjinvisible       .resize( _names_h0.size()              );
    _neutralInput_BR_hjhihi            .resize( _names_h0.size() * _names_h0.size() );

    _massUncertainty_HB_neutral.resize( std::max( _names_h0.size(), 1UL ) );
    _massUncertainty_HB_charged.resize( std::max( _names_hp.size(), 1UL ) );
    _massUncertainty_HS_neutral.resize( _names_h0.size()                  );

    _mass_h_neutral_shift.resize( _names_h0.size() );
    _mass_h_charged_shift.resize( _names_hp.size() );

}

void Fittino::HiggsSignalsCalculator::Run() {

    UpdateInput();
    UpdateMassUncertainties();

    if ( _runHiggsBounds ) {

        UpdateChargedInput( true );
        UpdateNeutralInput( true );

        _globalHiggsBoundsChi2 = -1.;
        _HBresult              = -1;

        boost::thread threadHB( boost::bind( &Fittino::HiggsSignalsCalculator::CallHiggsBounds, this ) );
        threadHB.join();

        if( _globalHiggsBoundsChi2 < 0 ) {

            // todo: looks like we should throw a calculator exception in this case
            _chi2WithTheory = 10000.;
            _chi2WithoutTheory = 10000.;
            _globalHiggsBoundsChi2 = 10000.;

        }

    }

    UpdateChargedInput( false );
    UpdateNeutralInput( false );

    if ( _runHiggsSignals ) {

        int mode = GetConfiguration()->get<int>("Mode");
        run_higgssignals_( &mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

    }

}

void Fittino::HiggsSignalsCalculator::AddOutputs() {

    if ( _runHiggsBounds ) {

        AddQuantity(new SimplePrediction("HB_result", "", _HBresult_double));
        AddQuantity(new SimplePrediction("HB_obsratio", "", _obsratio));
        AddQuantity(new SimplePrediction("HB_channel", "", _channel_double));
        AddQuantity(new SimplePrediction("HB_chi2WithTheory", "", _chi2WithTheory));
        AddQuantity(new SimplePrediction("HB_chi2WithoutTheory", "", _chi2WithoutTheory));
        AddQuantity(new SimplePrediction("HB_bestChannelChi2", "", _bestChannelChi2_double));

    }

    if (!_runHiggsSignals ) return;

    AddQuantity( new SimplePrediction( "Chi2"                , "", _chi2                     ) );
    AddQuantity( new SimplePrediction( "Chi2_mass"           , "", _chi2_mass_h              ) );
    AddQuantity( new SimplePrediction( "Chi2_mu"             , "", _chi2_mu                  ) );
    AddQuantity( new SimplePrediction( "Pvalue"              , "", _pvalue                   ) );
    AddQuantity( new SimplePrediction( "R_h_b_b"             , "", _R_H_bb                   ) );
    AddQuantity( new SimplePrediction( "R_h_gamma_gamma"     , "", _R_H_gaga                 ) );
    AddQuantity( new SimplePrediction( "R_h_tau_tau"         , "", _R_H_tautau               ) );
    AddQuantity( new SimplePrediction( "R_h_W_W"             , "", _R_H_WW                   ) );
    AddQuantity( new SimplePrediction( "R_h_Z_Z"             , "", _R_H_ZZ                   ) );
    AddQuantity( new SimplePrediction( "R_Vh_b_b"            , "", _R_VH_bb                  ) );

    for ( int i = 1; i <= _npeakmu; ++i ) {

        std::string s_index = std::to_string( _obsID[i-1] );

        AddQuantity( new SimplePrediction( "Prediction_mu_"         + s_index, "", _peakInfoFromHSresults_mupred[i-1] ) );
        AddQuantity( new SimplePrediction( "DominantHiggs_"         + s_index, "", _peakInfoFromHSresults_domH  [i-1] ) );
        AddQuantity( new SimplePrediction( "NumberOfCombinedHiggs_" + s_index, "", _peakInfoFromHSresults_nHcomb[i-1] ) );

    }

}

void Fittino::HiggsSignalsCalculator::AddChargedHiggs(const boost::property_tree::ptree &ptree) {

    std::string name = ptree.get<std::string>( "Name" );

    _names_hp.push_back( name );

    AddInput( name + ".Mass_h"        , ptree.get<std::string>( "Mass_h"         ) );
    AddInput( name + ".Error_Mass_h"  , ptree.get<std::string>( "Error_Mass_h"   ) );
    AddInput( name + ".Gamma_h_Total" , ptree.get<std::string>( "Gamma_h_Total"  ) );
    AddInput( name + ".Norm_xs_LEP_hh", ptree.get<std::string>( "Norm_xs_LEP_hh" ) );
    AddInput( name + ".BR_t_h_b"      , ptree.get<std::string>( "BR_t_h_b"       ) );
    AddInput( name + ".BR_h_c_s"      , ptree.get<std::string>( "BR_h_c_s"       ) );
    AddInput( name + ".BR_h_c_b"      , ptree.get<std::string>( "BR_h_c_b"       ) );
    AddInput( name + ".BR_h_tau_nu"   , ptree.get<std::string>( "BR_h_tau_nu"    ) );

}

void Fittino::HiggsSignalsCalculator::AddNeutralHiggs( const boost::property_tree::ptree &ptree ) {

    std::string name = ptree.get<std::string>( "Name" );

    _names_h0.push_back( name );

    AddInput( name + ".Mass_h"                , ptree.get<std::string>( "Mass_h"                 ) );
    AddInput( name + ".Error_Mass_h_HB"       , ptree.get<std::string>( "Error_Mass_h_HB"        ) );
    AddInput( name + ".Error_Mass_h_HS"       , ptree.get<std::string>( "Error_Mass_h_HS"        ) );
    AddInput( name + ".Gamma_h_Total"         , ptree.get<std::string>( "Gamma_h_Total"          ) );
    AddInput( name + ".CP"                    , ptree.get<std::string>( "CP"                     ) );
    AddInput( name + ".NormSM_xs_LEP_Zh"      , ptree.get<std::string>( "NormSM_xs_LEP_Zh"       ) );
    AddInput( name + ".NormSM_xs_LEP_bbh"     , ptree.get<std::string>( "NormSM_xs_LEP_bbh"      ) );
    AddInput( name + ".NormSM_xs_LEP_tautauh" , ptree.get<std::string>( "NormSM_xs_LEP_tautauh"  ) );
    AddInput( name + ".NormSM_xs_TEV_h"       , ptree.get<std::string>( "NormSM_xs_TEV_h"        ) );
    AddInput( name + ".NormSM_xs_TEV_bh"      , ptree.get<std::string>( "NormSM_xs_TEV_bh"       ) );
    AddInput( name + ".NormSM_xs_TEV_Wh"      , ptree.get<std::string>( "NormSM_xs_TEV_Wh"       ) );
    AddInput( name + ".NormSM_xs_TEV_Zh"      , ptree.get<std::string>( "NormSM_xs_TEV_Zh"       ) );
    AddInput( name + ".NormSM_xs_TEV_qqh"     , ptree.get<std::string>( "NormSM_xs_TEV_qqh"      ) );
    AddInput( name + ".NormSM_xs_TEV_tth"     , ptree.get<std::string>( "NormSM_xs_TEV_tth"      ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_h"  , ptree.get<std::string>( "NormSM_xs_LHC_7TeV_h"   ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_bh" , ptree.get<std::string>( "NormSM_xs_LHC_7TeV_bh"  ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_Wh" , ptree.get<std::string>( "NormSM_xs_LHC_7TeV_Wh"  ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_Zh" , ptree.get<std::string>( "NormSM_xs_LHC_7TeV_Zh"  ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_qqh", ptree.get<std::string>( "NormSM_xs_LHC_7TeV_qqh" ) );
    AddInput( name + ".NormSM_xs_LHC_7TeV_tth", ptree.get<std::string>( "NormSM_xs_LHC_7TeV_tth" ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_h"  , ptree.get<std::string>( "NormSM_xs_LHC_8TeV_h"   ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_bh" , ptree.get<std::string>( "NormSM_xs_LHC_8TeV_bh"  ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_Wh" , ptree.get<std::string>( "NormSM_xs_LHC_8TeV_Wh"  ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_Zh" , ptree.get<std::string>( "NormSM_xs_LHC_8TeV_Zh"  ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_qqh", ptree.get<std::string>( "NormSM_xs_LHC_8TeV_qqh" ) );
    AddInput( name + ".NormSM_xs_LHC_8TeV_tth", ptree.get<std::string>( "NormSM_xs_LHC_8TeV_tth" ) );
    AddInput( name + ".BR_h_s_s"              , ptree.get<std::string>( "BR_h_s_s"               ) );
    AddInput( name + ".BR_h_c_c"              , ptree.get<std::string>( "BR_h_c_c"               ) );
    AddInput( name + ".BR_h_b_b"              , ptree.get<std::string>( "BR_h_b_b"               ) );
    AddInput( name + ".BR_h_mu_mu"            , ptree.get<std::string>( "BR_h_mu_mu"             ) );
    AddInput( name + ".BR_h_tau_tau"          , ptree.get<std::string>( "BR_h_tau_tau"           ) );
    AddInput( name + ".BR_h_W_W"              , ptree.get<std::string>( "BR_h_W_W"               ) );
    AddInput( name + ".BR_h_Z_Z"              , ptree.get<std::string>( "BR_h_Z_Z"               ) );
    AddInput( name + ".BR_h_Z_gamma"          , ptree.get<std::string>( "BR_h_Z_gamma"           ) );
    AddInput( name + ".BR_h_gamma_gamma"      , ptree.get<std::string>( "BR_h_gamma_gamma"       ) );
    AddInput( name + ".BR_h_g_g"              , ptree.get<std::string>( "BR_h_g_g"               ) );
    AddInput( name + ".BR_h_Invisible"        , ptree.get<std::string>( "BR_h_Invisible"         ) );

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

                    if ( node.first != "BR_h_H_H" ) continue;

                    std::string child = node.second.get<std::string>( "Child" );
                    std::string value = node.second.get<std::string>( "Value" );

                    AddInput( name + "." + child + ".BR_h_H_H", value );

                }

}

void Fittino::HiggsSignalsCalculator::DetermineNumberOfPeaks() {

    int ntotal, npeakmh, nmpred, nanalyses;
    __io_MOD_get_number_of_observables( &ntotal, &_npeakmu, &npeakmh, &nmpred, &nanalyses );

}

void Fittino::HiggsSignalsCalculator::UpdateOutput() {

    // todo: loop over i = higgsbosons and colliders
    int i = 1;
    int collider = 3;

    get_rvalues_(&i,
                 &collider,
                 &_R_H_WW,
                 &_R_H_ZZ,
                 &_R_H_gaga,
                 &_R_H_tautau,
                 &_R_H_bb,
                 &_R_VH_bb);

    int nHcomb, domH;

    for ( int i = 1; i <= _npeakmu; ++i ) {

        __io_MOD_get_peakinfo_from_hsresults( &_obsID[i-1], &_peakInfoFromHSresults_mupred[i - 1], &domH, &nHcomb );

        _peakInfoFromHSresults_domH  [i - 1] = domH;
        _peakInfoFromHSresults_nHcomb[i - 1] = nHcomb;

    }

    int dummy = 1;
    __pc_chisq_MOD_print_cov_mh_to_file( &dummy );
    __pc_chisq_MOD_print_cov_mu_to_file(        );

}

void Fittino::HiggsSignalsCalculator::AddInputs() {

    BOOST_FOREACH( const boost::property_tree::ptree::value_type & node, *GetConfiguration() ) {

                    if ( node.first == "NeutralHiggsBoson" ) {

                        AddNeutralHiggs( node.second );

                    }
                    else if ( node.first == "ChargedHiggsBoson" ) {

                        AddChargedHiggs( node.second );

                    }
                    else if ( node.first == "NormSM_xs_LEP_hH" ) {

                        AddHiggsPairProductionLEP( node.second );

                    }

                }

    AddInput( "BR_t_W_b" );

}

void Fittino::HiggsSignalsCalculator::CheckMatrices() {

    for ( unsigned int i = 0; i < _names_h0.size(); ++i ) {

        for ( unsigned int j = 0; j < _names_h0.size(); ++j ) {

            try {

                GetInput( _names_h0[i] + "." + _names_h0[j] + ".NormSM_xs_LEP_hH");

            }
            catch( const std::out_of_range& exception ) {

                throw ConfigurationException( _name + ": NormSM_xs_LEP_hH missing for h=" + _names_h0[i] + ", H=" + _names_h0[j] );

            }

            try {

                GetInput( _names_h0[i] + "." + _names_h0[j] + ".BR_h_H_H" );

            }
            catch( const std::out_of_range& exception ) {

                throw ConfigurationException( _name + ": BR_h_H_H missing for h=" + _names_h0[i] + ", H=" + _names_h0[j] );

            }

        }

    }

}

void Fittino::HiggsSignalsCalculator::AddHiggsPairProductionLEP( const boost::property_tree::ptree &ptree ) {

    std::vector<std::string> neutralHiggsBosons;

    BOOST_FOREACH( const boost::property_tree::ptree::value_type &node, ptree ) {

                    if ( node.first != "NeutralHiggsBoson" ) continue;

                    neutralHiggsBosons.push_back( node.second.get_value<std::string>() );

                }

    std::string value = ptree.get<std::string>( "Value" );

    AddInput( neutralHiggsBosons.at( 0 ) + "." + neutralHiggsBosons.at( 1 ) + "." + "NormSM_xs_LEP_hH", value );

    if ( neutralHiggsBosons.at( 0 ) == neutralHiggsBosons.at( 1 ) ) return;

    AddInput( neutralHiggsBosons.at( 1 ) + "." + neutralHiggsBosons.at( 0 ) + "." + "NormSM_xs_LEP_hH", value );

}

// todo: review the following 3 functions

void Fittino::HiggsSignalsCalculator::CallHiggsBounds() {

    _globalHiggsBoundsChi2 = RunHiggsBounds();

}

double Fittino::HiggsSignalsCalculator::RunHiggsBounds() {

    // todo: consider using run_higgsbounds_full
    run_higgsbounds_( &_HBresult, &_channel, &_obsratio, &_ncombined );
    _HBresult_double = _HBresult;
    _channel_double  = _channel;

    if( _HBresult < 0 || _HBresult > 1 ) {

        return -1.0;

    }

    _theoryUncertainty1s = 3.;
    hb_calc_stats_( &_theoryUncertainty1s, &_chi2WithoutTheory, &_chi2WithTheory, &_bestChannelChi2 );
    _bestChannelChi2_double = (double)_bestChannelChi2;

    if( _chi2WithoutTheory < 0. ) {

        return -1.0;

    }

    if( _chi2WithTheory < 0. && _chi2WithoutTheory > 0. ) {

        return -1.0;

    }

    if( _channel != _bestChannelChi2 ) {

        if( _HBresult == 0 ) {

            _chi2WithoutTheory += 10000.;
            _chi2WithTheory += 10000.;

        }

    }

    return _chi2WithTheory;

}

void Fittino::HiggsSignalsCalculator::Setup(bool print) {

    if ( _runHiggsSignals ) {

        int         outputLevel                    = GetConfiguration()->get<int>        ( "OutputLevel"                    );
        int         pdf                            = GetConfiguration()->get<int>        ( "PDF"                            );
        double      assignmentRange                = GetConfiguration()->get<double>     ( "AssignmentRange"                );
        double      assignmentRangeMassObservables = GetConfiguration()->get<double>     ( "AssignmentRangeMassObservables" );

        if ( !print ) _redirector.Start();

        setup_output_level_(&outputLevel);
        setup_pdf_(&pdf);
        setup_assignmentrange_(&assignmentRange);
        setup_assignmentrange_massobservables_(&assignmentRangeMassObservables);

        if ( !print ) _redirector.Stop();

    }

}

void Fittino::HiggsSignalsCalculator::AssignMeasurements() {

    if (!_runHiggsSignals ) return;

    for ( int i = 1; i <= _npeakmu; ++i ) {

        assign_toyvalues_to_peak_(&_obsID[i-1], &_measurement_mu[i-1], &_measurement_mass[i-1] );

    }

}

void Fittino::HiggsSignalsCalculator::InitializeMeasurements() {

    if ( !_runHiggsSignals ) return;

    for ( int i = 1; i <= _npeakmu; ++i ) {

        __io_MOD_get_peakinfo( &_obsID[i-1], &_measurement_mu[i-1], &_error_up_mu[i-1], &_error_down_mu[i-1], &_measurement_mass[i-1], &_error_mass[i-1] );

        int mhchisq;
        __io_MOD_get_more_peakinfo( &_obsID[i-1], &mhchisq ); // currently not needed

        if ( _useInitialPredictionsAsMeasurements ) {

            _measurement_mu[i-1] = _peakInfoFromHSresults_mupred[i-1];

            int domH = _peakInfoFromHSresults_domH[i-1];
            _measurement_mass[i-1] = _neutralInput_Mh[domH-1];  //todo: use the weighted mass average? Make sure mass chi2 is zero!

        }

    }

}

void Fittino::HiggsSignalsCalculator::ResizePeakArrays() {

    if ( !_runHiggsSignals ) return;

    _peakInfoFromHSresults_mupred.resize( _npeakmu );
    _peakInfoFromHSresults_domH  .resize( _npeakmu );
    _peakInfoFromHSresults_nHcomb.resize( _npeakmu );
    _obsID.resize( _npeakmu);
    _measurement_mass.resize( _npeakmu );
    _measurement_mu.resize  ( _npeakmu );
    _error_down_mu.resize( _npeakmu );
    _error_up_mu.resize( _npeakmu );
    _error_mass.resize( _npeakmu );

}

void Fittino::HiggsSignalsCalculator::DetermineObsIDs() {

    if ( !_runHiggsSignals ) return;

    for (int i = 1; i <= _npeakmu; ++i) {

        int obsID;
        __io_MOD_get_id_of_peakobservable(&i, &obsID);

        _obsID[i - 1] = obsID;

    }

}


