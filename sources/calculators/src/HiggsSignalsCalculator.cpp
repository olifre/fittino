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

#include <boost/lexical_cast.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/thread.hpp>

#include "CHiggsSignals.h"
#include "HiggsSignalsCalculator.h"
#include "ModelParameter.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "Observable.h"

Fittino::HiggsSignalsCalculator::HiggsSignalsCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    :CalculatorBase       ( model, &ptree                                                                         ) {

    SetName( "HiggsSignalsCalculator" );
    SetTag( "" );

    _runHiggsBounds = GetConfiguration()->get<bool>( "RunHiggsBounds" );

    AddInputQuantities();
    ResizeInputArrays();
    InitializeAndSetup();
    Run();
    DetermineNumberOfObservables();
    ResizePeakArrays();
    UpdatePeakArrays();
    AddOutputQuantities();

    // SetupMeasuredValues();

}

void Fittino::HiggsSignalsCalculator::InitializeAndSetup() {

    int nHzero = _h0.size();
    int nHplus = _hp.size();

    std::string whichAnalyses = GetConfiguration()->get<std::string>( "WhichAnalyses", "LandH" );
    std::string expdata = GetConfiguration()->get<std::string>( "ExpData" );

    // todo: make this configurable
    _mode = 1;
    int output_level = 0;
    int pdf = 2;
    double range = 20.;

    if ( _runHiggsBounds ) {

        initialize_higgsbounds_chisqtables_();
        initialize_higgsbounds_(&nHzero, &nHplus, whichAnalyses.c_str(), whichAnalyses.length());

    }

    initialize_higgssignals_( &nHzero, &nHplus, expdata.c_str(), expdata.size() );
    setup_output_level_( &output_level );
    setup_pdf_( &pdf );
    setup_assignmentrange_( &range );

}

Fittino::HiggsSignalsCalculator::~HiggsSignalsCalculator() {

}


void Fittino::HiggsSignalsCalculator::SetNeutralInput() {

    if ( !_h0.size() ) return;

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

void Fittino::HiggsSignalsCalculator::CallHiggsBounds() {

    _globalHiggsBoundsChi2 = RunHiggsBounds();

}

double Fittino::HiggsSignalsCalculator::RunHiggsBounds() {

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

void Fittino::HiggsSignalsCalculator::CalculatePredictions() {

    Run();
    UpdatePeakArrays();

}


void Fittino::HiggsSignalsCalculator::SetupMeasuredValues() {

    // todo: do the smearing here. Also set mass shift

    for ( int i = 1; i <= _npeakmu; ++i ) {

        double measuredValue_mh = -1.e9;
        double measuredValue_mu = -1.e9;
        int obsID = 0;
        __io_MOD_get_id_of_peakobservable( &i, &obsID );
        std::ostringstream ss_index;
        ss_index << obsID;
        std::string s_index = ss_index.str();
        std::string fittinoName_mh = "HiggsSignalsObservable_" + s_index + "_mh";
        std::string fittinoName_mu = "HiggsSignalsObservable_" + s_index + "_mu";

        // get measured values from the model
        for ( int j = 0; j < _model->GetObservableVector()->size(); ++j ) {

            if ( _model->GetObservableVector()->at(j)->GetPrediction()->GetName() == fittinoName_mh ) {

                measuredValue_mh = _model->GetObservableVector()->at(j)->GetMeasuredValue();

            }

            if ( _model->GetObservableVector()->at(j)->GetPrediction()->GetName() == fittinoName_mu ) {

                measuredValue_mu = _model->GetObservableVector()->at(j)->GetMeasuredValue();

            }

        }

        // test if all observable were acutally defined
        if ( measuredValue_mh < -1.e8 || measuredValue_mu < -1.e8 ) {

            throw ConfigurationException( "Incomplete set of HiggsSignals Observables: Missing at least one (mu, mh) for HiggsSignalsObservable_" + s_index );

        }

        // assign the new values
        assign_toyvalues_to_peak_( &obsID, &measuredValue_mu, &measuredValue_mh );
    
    }

}

const double& Fittino::HiggsSignalsCalculator::GetHiggsInput( std::string name, std::string higgs ) {

    return GetInput( higgs + "_" + name );

}

const double &Fittino::HiggsSignalsCalculator::GetHiggsInput(std::string name, std::string higgs1, std::string higgs2) {

    return GetInput( higgs1 + "_" + higgs2 + "_" + name );

}

void Fittino::HiggsSignalsCalculator::SetChargedInput() {

    if ( ! _hp.size() ) return;

    higgsbounds_charged_input_( &_chargedInput_MHplus             [0],
                                &_chargedInput_GammaTot           [0],
                                &_chargedInput_CS_lep_HpjHmj_ratio[0],
                                &_chargedInput_BR_tWpb            [0],
                                &_chargedInput_BR_tHpjb           [0],
                                &_chargedInput_BR_Hpjcs           [0],
                                &_chargedInput_BR_Hpjcb           [0],
                                &_chargedInput_BR_Hptaunu         [0] );

}

void Fittino::HiggsSignalsCalculator::SetMassUncertainties() {

    higgsbounds_set_mass_uncertainties_( &_massUncertainty_HB_neutral[0],
                                         &_massUncertainty_HB_charged[0] );

    if ( !_h0.size() ) return;

    higgssignals_neutral_input_massuncertainty_( &_massUncertainty_HS_neutral[0] );

}

void Fittino::HiggsSignalsCalculator::UpdateInputArraysNeutral() {

    for( unsigned int j = 0; j < _h0.size(); ++j ) {

        _neutralInput_Mh                [j] = GetHiggsInput( "Mh"                , _h0[j] );
        _neutralInput_GammaTot          [j] = GetHiggsInput( "GammaTot"          , _h0[j] );
        _neutralInput_CP                [j] = GetHiggsInput( "CP"                , _h0[j] );
        _neutralInput_CS_lep_hjZ_ratio  [j] = GetHiggsInput( "CS_lep_hjZ_ratio"  , _h0[j] );
        _neutralInput_CS_lep_bbhj_ratio [j] = GetHiggsInput( "CS_lep_bbhj_ratio" , _h0[j] );
        _neutralInput_CS_lhc7_hj_ratio  [j] = GetHiggsInput( "CS_lhc7_hj_ratio"  , _h0[j] );
        _neutralInput_CS_lhc7_hjb_ratio [j] = GetHiggsInput( "CS_lhc7_hjb_ratio" , _h0[j] );
        _neutralInput_CS_lhc7_hjW_ratio [j] = GetHiggsInput( "CS_lhc7_hjW_ratio" , _h0[j] );
        _neutralInput_CS_lhc7_hjZ_ratio [j] = GetHiggsInput( "CS_lhc7_hjZ_ratio" , _h0[j] );
        _neutralInput_CS_lhc7_vbf_ratio [j] = GetHiggsInput( "CS_lhc7_vbf_ratio" , _h0[j] );
        _neutralInput_CS_lhc7_tthj_ratio[j] = GetHiggsInput( "CS_lhc7_tthj_ratio", _h0[j] );
        _neutralInput_CS_lhc8_hj_ratio  [j] = GetHiggsInput( "CS_lhc8_hj_ratio"  , _h0[j] );
        _neutralInput_CS_lhc8_hjb_ratio [j] = GetHiggsInput( "CS_lhc8_hjb_ratio" , _h0[j] );
        _neutralInput_CS_lhc8_hjW_ratio [j] = GetHiggsInput( "CS_lhc8_hjW_ratio" , _h0[j] );
        _neutralInput_CS_lhc8_hjZ_ratio [j] = GetHiggsInput( "CS_lhc8_hjZ_ratio" , _h0[j] );
        _neutralInput_CS_lhc8_vbf_ratio [j] = GetHiggsInput( "CS_lhc8_vbf_ratio" , _h0[j] );
        _neutralInput_CS_lhc8_tthj_ratio[j] = GetHiggsInput( "CS_lhc8_tthj_ratio", _h0[j] );
        _neutralInput_BR_hjss           [j] = GetHiggsInput( "BR_hjss"           , _h0[j] );
        _neutralInput_BR_hjcc           [j] = GetHiggsInput( "BR_hjcc"           , _h0[j] );
        _neutralInput_BR_hjbb           [j] = GetHiggsInput( "BR_hjbb"           , _h0[j] );
        _neutralInput_BR_hjmumu         [j] = GetHiggsInput( "BR_hjmumu"         , _h0[j] );
        _neutralInput_BR_hjtautau       [j] = GetHiggsInput( "BR_hjtautau"       , _h0[j] );
        _neutralInput_BR_hjWW           [j] = GetHiggsInput( "BR_hjWW"           , _h0[j] );
        _neutralInput_BR_hjZZ           [j] = GetHiggsInput( "BR_hjZZ"           , _h0[j] );
        _neutralInput_BR_hjZga          [j] = GetHiggsInput( "BR_hjZga"          , _h0[j] );
        _neutralInput_BR_hjgaga         [j] = GetHiggsInput( "BR_hjgaga"         , _h0[j] );
        _neutralInput_BR_hjgg           [j] = GetHiggsInput( "BR_hjgg"           , _h0[j] );
        _neutralInput_BR_hjinvisible    [j] = GetHiggsInput( "BR_hjinvisible"    , _h0[j] );

    }

    int index = 0;

    for( unsigned int i = 0; i < _h0.size(); ++i ) {

        for( unsigned int j = 0; j < _h0.size(); ++j ) {

            _neutralInput_CS_lep_hjhi_ratio[index] = GetHiggsInput( "CS_lep_hjhi_ratio", _h0[j], _h0[i] );
            _neutralInput_BR_hjhihi        [index] = GetHiggsInput( "BR_hjhihi"        , _h0[j], _h0[i] );

            ++index;

        }

    }

}

void Fittino::HiggsSignalsCalculator::UpdateInputArraysCharged() {

    for( int i = 0; i < _hp.size(); ++i ) {

        _chargedInput_MHplus             [i] = GetHiggsInput( "MHplus"             , _hp[i] );
        _chargedInput_GammaTot           [i] = GetHiggsInput( "GammaTot"           , _hp[i] );
        _chargedInput_CS_lep_HpjHmj_ratio[i] = GetHiggsInput( "CS_lep_HpjHmj_ratio", _hp[i] );
        _chargedInput_BR_tWpb            [i] = GetHiggsInput( "BR_tWpb"            , _hp[i] );
        _chargedInput_BR_tHpjb           [i] = GetHiggsInput( "BR_tHpjb"           , _hp[i] );
        _chargedInput_BR_Hpjcs           [i] = GetHiggsInput( "BR_Hpjcs"           , _hp[i] );
        _chargedInput_BR_Hpjcb           [i] = GetHiggsInput( "BR_Hpjcb"           , _hp[i] );
        _chargedInput_BR_Hptaunu         [i] = GetHiggsInput( "BR_Hptaunu"         , _hp[i] );

    }

}

void Fittino::HiggsSignalsCalculator::UpdateInputArraysMassUncertainties() {

    for( unsigned int i = 0; i < _h0.size(); ++i ) {

        _massUncertainty_HB_neutral[i] = GetHiggsInput( "dMh_HB", _h0[i] );
        _massUncertainty_HS_neutral[i] = GetHiggsInput( "dMh_HS", _h0[i] );

    }

    for( unsigned int i = 0; i < _hp.size(); ++i ) {

        _massUncertainty_HB_charged[i] = GetHiggsInput( "dMh", _hp[i] );

    }

}

void Fittino::HiggsSignalsCalculator::ShiftHiggsMass() {

    for( unsigned int j = 0; j < _h0.size(); ++j ) {

        _neutralInput_Mh[j] += _mass_h_neutral_shift[j];

    }

    for( unsigned int j = 0; j < _hp.size(); ++j ) {

        _chargedInput_MHplus[j] += _mass_h_charged_shift[j];

    }

}

void Fittino::HiggsSignalsCalculator::RestoreHiggsMass() {

    for( unsigned int j = 0; j < _h0.size(); ++j ) {

        _neutralInput_Mh[j] =  GetHiggsInput( "Mh", _h0[j] );

    }

    for( unsigned int j = 0; j < _hp.size(); ++j ) {

        _chargedInput_MHplus[j] = GetHiggsInput( "MHplus", _hp[j] );

    }

}

void Fittino::HiggsSignalsCalculator::ResizeInputArrays() {

    _chargedInput_MHplus             .resize( _hp.size() );
    _chargedInput_GammaTot           .resize( _hp.size() );
    _chargedInput_CS_lep_HpjHmj_ratio.resize( _hp.size() );
    _chargedInput_BR_tWpb            .resize( _hp.size() );
    _chargedInput_BR_tHpjb           .resize( _hp.size() );
    _chargedInput_BR_Hpjcs           .resize( _hp.size() );
    _chargedInput_BR_Hpjcb           .resize( _hp.size() );
    _chargedInput_BR_Hptaunu         .resize( _hp.size() );

    _neutralInput_Mh                   .resize( _h0.size()              ) ;
    _neutralInput_GammaTot             .resize( _h0.size()              );
    _neutralInput_CP                   .resize( _h0.size()              );
    _neutralInput_CS_lep_hjZ_ratio     .resize( _h0.size()              );
    _neutralInput_CS_lep_bbhj_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lep_tautauhj_ratio.resize( _h0.size()              );
    _neutralInput_CS_lep_hjhi_ratio    .resize( _h0.size() * _h0.size() );
    _neutralInput_CS_tev_hj_ratio      .resize( _h0.size()              );
    _neutralInput_CS_tev_hjb_ratio     .resize( _h0.size()              );
    _neutralInput_CS_tev_hjW_ratio     .resize( _h0.size()              );
    _neutralInput_CS_tev_hjZ_ratio     .resize( _h0.size()              );
    _neutralInput_CS_tev_vbf_ratio     .resize( _h0.size()              );
    _neutralInput_CS_tev_tthj_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc7_hj_ratio     .resize( _h0.size()              );
    _neutralInput_CS_lhc7_hjb_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc7_hjW_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc7_hjZ_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc7_vbf_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc7_tthj_ratio   .resize( _h0.size()              );
    _neutralInput_CS_lhc8_hj_ratio     .resize( _h0.size()              );
    _neutralInput_CS_lhc8_hjb_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc8_hjW_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc8_hjZ_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc8_vbf_ratio    .resize( _h0.size()              );
    _neutralInput_CS_lhc8_tthj_ratio   .resize( _h0.size()              );
    _neutralInput_BR_hjss              .resize( _h0.size()              );
    _neutralInput_BR_hjcc              .resize( _h0.size()              );
    _neutralInput_BR_hjbb              .resize( _h0.size()              );
    _neutralInput_BR_hjmumu            .resize( _h0.size()              );
    _neutralInput_BR_hjtautau          .resize( _h0.size()              );
    _neutralInput_BR_hjWW              .resize( _h0.size()              );
    _neutralInput_BR_hjZZ              .resize( _h0.size()              );
    _neutralInput_BR_hjZga             .resize( _h0.size()              );
    _neutralInput_BR_hjgaga            .resize( _h0.size()              );
    _neutralInput_BR_hjgg              .resize( _h0.size()              );
    _neutralInput_BR_hjinvisible       .resize( _h0.size()              );
    _neutralInput_BR_hjhihi            .resize( _h0.size() * _h0.size() );

    _massUncertainty_HB_neutral.resize( std::max( _h0.size(), 1UL ) );
    _massUncertainty_HB_charged.resize( std::max( _hp.size(), 1UL ) );

    _massUncertainty_HS_neutral.resize( _h0.size() );

    _mass_h_neutral_shift.resize( _h0.size() );
    _mass_h_charged_shift.resize( _hp.size() );

}

void Fittino::HiggsSignalsCalculator::Run() {

    UpdateInputArraysCharged();
    UpdateInputArraysMassUncertainties();
    UpdateInputArraysNeutral();
    SetMassUncertainties    ();

    if ( _runHiggsBounds ) {

        ShiftHiggsMass          ();
        SetChargedInput         ();
        SetNeutralInput         ();

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

        RestoreHiggsMass();

    }

    SetChargedInput();
    SetNeutralInput();

    run_higgssignals_( &_mode, &_chi2_mu, &_chi2_mass_h, &_chi2, &_nobs, &_pvalue );

    // todo: loop over i = higgsbosons and colliders
    int i = 1;
    int collider = 3;

    get_rvalues_( &i,
                  &collider,
                  &_R_H_WW,
                  &_R_H_ZZ,
                  &_R_H_gaga,
                  &_R_H_tautau,
                  &_R_H_bb,
                  &_R_VH_bb );

    for( int i = 1; i <= _h0.size(); ++i ) {

        __pc_chisq_MOD_print_cov_mh_to_file( &i );

    }
    __pc_chisq_MOD_print_cov_mu_to_file();

}

void Fittino::HiggsSignalsCalculator::DetermineNumberOfObservables() {

    int ntotal, npeakmh, nmpred, nanalyses;
    __io_MOD_get_number_of_observables( &ntotal, &_npeakmu, &npeakmh, &nmpred, &nanalyses );

}

void Fittino::HiggsSignalsCalculator::ResizePeakArrays() {

    _peakInfoFromHSresults_mupred.resize( _npeakmu );
    _peakInfoFromHSresults_domH  .resize( _npeakmu );
    _peakInfoFromHSresults_nHcomb.resize( _npeakmu );
    _peakChi2_mu                 .resize( _npeakmu );
    _peakChi2_mh                 .resize( _npeakmu ); // npeakmh?
    _peakChi2_max                .resize( _npeakmu ); // used for mu or mass or tot? npeakmh?
    _peakChi2_tot                .resize( _npeakmu ); // trivial sum?

    // consider dropping the _peakChi outputs if they can easily be recomputed with just 1 HS call of peak_info and the stored mupred and smeared mu meas etc. from the ntuple

}

void Fittino::HiggsSignalsCalculator::AddOutputQuantities() {

    // todo: review these HB and HS quantities
    AddQuantity( new SimplePrediction( "HB_result"              , "",  _HBresult_double         ) );
    AddQuantity( new SimplePrediction( "HB_obsratio"            , "",  _obsratio                ) );
    AddQuantity( new SimplePrediction( "HB_channel"             , "",  _channel_double          ) );
    AddQuantity( new SimplePrediction( "HB_chi2WithTheory"      , "", _chi2WithTheory           ) );
    AddQuantity( new SimplePrediction( "HB_chi2WithoutTheory"   , "", _chi2WithoutTheory        ) );
    AddQuantity( new SimplePrediction( "HB_bestChannelChi2"     , "",  _bestChannelChi2_double  ) );
    AddQuantity( new SimplePrediction( "HS_chi2"                , "", _chi2                     ) );
    AddQuantity( new SimplePrediction( "HS_chi2_mass_h"         , "", _chi2_mass_h              ) );
    AddQuantity( new SimplePrediction( "HS_chi2_mu"             , "", _chi2_mu                  ) );
    AddQuantity( new SimplePrediction( "HS_pvalue"              , "", _pvalue                   ) );
    AddQuantity( new SimplePrediction( "HS_R_H_bb"              , "", _R_H_bb                   ) );
    AddQuantity( new SimplePrediction( "HS_R_H_gaga"            , "", _R_H_gaga                 ) );
    AddQuantity( new SimplePrediction( "HS_R_H_tautau"          , "", _R_H_tautau               ) );
    AddQuantity( new SimplePrediction( "HS_R_H_WW"              , "", _R_H_WW                   ) );
    AddQuantity( new SimplePrediction( "HS_R_H_ZZ"              , "", _R_H_ZZ                   ) );
    AddQuantity( new SimplePrediction( "HS_R_VH_bb"             , "", _R_VH_bb                  ) );

    for ( int i = 1; i <= _npeakmu; ++i ) {

        int obsID, mhchisq;
        __io_MOD_get_id_of_peakobservable( &i, &obsID );
        __io_MOD_get_more_peakinfo( &obsID, &mhchisq ); // only needed if npeakmh is used above

        //std::string s_index = std::to_string( obsID );
        std::string s_index = boost::lexical_cast<std::string>( obsID );

        AddQuantity( new SimplePrediction( "HS_peakInfo_mupred_" + s_index, "", _peakInfoFromHSresults_mupred[i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakInfo_domH_"   + s_index, "", _peakInfoFromHSresults_domH  [i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakInfo_nHcomb_" + s_index, "", _peakInfoFromHSresults_nHcomb[i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakChi2_mu_"     + s_index, "", _peakChi2_mu                 [i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakChi2_mh_"     + s_index, "", _peakChi2_mh                 [i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakChi2_max_"    + s_index, "", _peakChi2_max                [i-1] ) );
        AddQuantity( new SimplePrediction( "HS_peakChi2_tot_"    + s_index, "", _peakChi2_tot                [i-1] ) );

    }

}

void Fittino::HiggsSignalsCalculator::UpdatePeakArrays() {

    int obsID, nHcomb, domH;

    for ( int i = 1; i <= _npeakmu; ++i ) {

        __io_MOD_get_id_of_peakobservable( &i, &obsID );

        __io_MOD_get_peakinfo_from_hsresults( &obsID, &_peakInfoFromHSresults_mupred[i-1], &domH, &nHcomb);

        __pc_chisq_MOD_get_peakchi2( &obsID,
                                     &_peakChi2_mu [i-1],
                                     &_peakChi2_mh [i-1],
                                     &_peakChi2_max[i-1],
                                     &_peakChi2_tot[i-1] );

        _peakInfoFromHSresults_domH[i-1] = domH;
        _peakInfoFromHSresults_nHcomb[i-1] = nHcomb;

    }

}

void Fittino::HiggsSignalsCalculator::AddInputQuantities() {

    // todo: loop over input higgs here. Add an AddHiggsInput() private function for that

}
