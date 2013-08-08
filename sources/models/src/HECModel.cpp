/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HECModel.cpp                                                     *
*                                                                              *
* Description Implementation of the HEC model                                  *
*                                                                              *
* Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "HECModel.h"
#include "InputException.h"
#include "HiggsSignalsSLHAModelCalculator.h"
#include "PhysicsParameter.h"
#include "SLHAChi2Contribution.h"
#include "SLHAPrediction.h"

#include <iostream>
#include <stdlib.h>
#include <time.h>

Fittino::HECModel::HECModel() {

    double a, b; // Parameters used for rand()-function; a is the minimum value, b is the maximum.

    a = -1.;
    b =  1.;

    srand( ( unsigned )time( NULL ) );

    double rc     = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rb     = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rt     = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rtau   = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rW     = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rZ     = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rgamma = a +  rand() / ( RAND_MAX / ( b - a ) );
    double rg     = a +  rand() / ( RAND_MAX / ( b - a ) );

    double rMassh = 125.5 +  rand() / ( RAND_MAX / ( 126.5 - 125.5 ) );

    double rGammahInvisible = 0. +  rand() / ( RAND_MAX / ( 0.1 - 0. ) );

    _name = "HEC model";

    //AddParameter( new PhysicsParameter( "Alpha_EM",          "#alpha_{em}",       128.952, "GeV", "GeV", 0.1,  50., 150., true  ) );
    //AddParameter( new PhysicsParameter( "Alpha_S",           "#alpha_{S}",         0.1184, "GeV", "GeV", 0.1, -50.,  50., true  ) );
    //AddParameter( new PhysicsParameter( "G_F",               "G_{F}",        1.1663787e-5,    "",    "", 0.1,  -5.,   5., true  ) );

    //AddParameter( new PhysicsParameter( "Mass_h",              "m_{h}",                                    rMassh, "GeV", "GeV", 0.02,  123., 129.,   123., 129., false ) );
    //AddParameter( new PhysicsParameter( "Delta_quarks_s_hdd",  "#Delta^{quarks}_{s}(hdd)",                     rb,    "",    "",  0.1, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hss",         "#Delta_{p}(hss)",                             -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_quarks_s_huu",  "#Delta^{quarks}_{s}(huu)",                     rc,    "",    "",  0.2, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hcc",         "#Delta_{p}(hcc)",                             -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hbb",         "#Delta_{p}(hbb)",                             -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htt",         "#Delta_{p}(htt)",                             -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_leptons_s_hdd", "#Delta^{leptons}_{s}(hdd)",                  rtau,    "",    "",  0.1, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hmumu",       "#Delta_{p}(h#mu#mu)",                         -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htautau",     "#Delta_{p}(h#tau#tau)",                       -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_Bosons_hWZ",    "#Delta^{Bosons}(hWZ)",                         rW,    "",    "",  0.2, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hZgamma",       "#Delta(hZ#gamma)",                             0.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hgammagamma",   "#Delta(h#gamma#gamma)",                    rgamma,    "",    "",  0.1, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hgg",           "#Delta(hgg)",                                  rg,    "",    "",  0.2, -101.,  99.,    -1.,   2., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hggZ",          "#Delta(hggZ)",                                 0.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hihjZ",         "#Delta(h_{i}h_{j}Z)",                         -1.,    "",    "",  0.1, -101.,  99.,    -1.,   2., true  ) );
    //AddParameter( new PhysicsParameter( "BR_hjhihi",           "BR(h_{j}#rightarrowh_{i}h_{i}}",               0.,    "",    "",  0.1,    0.,   1.,     0.,   1., true  ) );
    //AddParameter( new PhysicsParameter( "Gamma_hInvisible",    "#Gamma(h#rightarrowInvisible)",                0., "GeV", "GeV", 0.01,    0.,   1.,     0.,   1., true  ) );

    AddParameter( new PhysicsParameter( "Mass_h",              "m_{h}",                                    rMassh, "GeV", "GeV", 0.02,  123., 129.,  123., 129., false ) );
    AddParameter( new PhysicsParameter( "Delta_quarks_s_hdd",  "#Delta^{quarks}_{s}(hdd)",                     rb,    "",    "", 0.05,    3.,  20., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_p_hss",         "#Delta_{p}(hss)",                             -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_quarks_s_huu",  "#Delta^{quarks}_{s}(huu)",                     rt,    "",    "",  0.1,  -32.,  30., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_p_hcc",         "#Delta_{p}(hcc)",                             -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_p_hbb",         "#Delta_{p}(hbb)",                             -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_p_htt",         "#Delta_{p}(htt)",                             -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_leptons_s_hdd", "#Delta^{leptons}_{s}(hdd)",                  rtau,    "",    "", 0.02,  -3.5,  1.5, -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_p_hmumu",       "#Delta_{p}(h#mu#mu)",                         -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_p_htautau",     "#Delta_{p}(h#tau#tau)",                       -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_hWW",           "#Delta(hWW)",                                  rW,    "",    "", 0.02,   -3.,   1., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_hZZ",           "#Delta(hZZ)",                                  rZ,    "",    "", 0.02,   -3.,   1., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_hZgamma",       "#Delta(hZ#gamma)",                             0.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_hgammagamma",   "#Delta(h#gamma#gamma)",                    rgamma,    "",    "", 0.02,   -4.,   2., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_hgg",           "#Delta(hgg)",                                  rg,    "",    "", 0.05,    5.,  40., -101.,  99., false ) );
    AddParameter( new PhysicsParameter( "Delta_hggZ",          "#Delta(hggZ)",                                 0.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "Delta_hihjZ",         "#Delta(h_{i}h_{j}Z)",                         -1.,    "",    "",  0.1, -101.,  99., -101.,  99., true  ) );
    AddParameter( new PhysicsParameter( "BR_hjhihi",           "BR(h_{j}#rightarrowh_{i}h_{i}}",               0.,    "",    "",  0.1,    0.,   1.,    0.,   1., true  ) );
    AddParameter( new PhysicsParameter( "Gamma_hInvisible",    "#Gamma(h#rightarrowInvisible)",  rGammahInvisible, "GeV", "GeV", 0.01,    0.,   1.,    0.,   1., false ) );

    //AddParameter( new PhysicsParameter( "Mass_h",            "m_{h}",                                    rMassh, "GeV", "GeV", 0.02,  123., 129.,  124., 130., false ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hss",       "#Delta_{s}(hss)",                              0.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hss",       "#Delta_{p}(hss)",                             -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hcc",       "#Delta_{s}(hcc)",                              rc,    "",    "", 0.02,  -12.,  10.,   -1., 200., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hcc",       "#Delta_{p}(hcc)",                             -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hbb",       "#Delta_{s}(hbb)",                              rb,    "",    "", .001,   -1.,   3.,   -1.,  21., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hbb",       "#Delta_{p}(hbb)",                             -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_htt",       "#Delta_{s}(htt)",                              rt,    "",    "", 0.02,  -17.,  15.,   -1.,  17., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htt",       "#Delta_{p}(htt)",                             -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hmumu",     "#Delta_{s}(h#mu#mu)",                          0.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hmumu",     "#Delta_{p}(h#mu#mu)",                         -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_htautau",   "#Delta_{s}(h#tau#tau)",                      rtau,    "",    "", 0.01,   -8.,   6.,   -1.,   9., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htautau",   "#Delta_{p}(h#tau#tau)",                       -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hWW",         "#Delta(hWW)",                                  rW,    "",    "", 0.02,   -6.,   4.,   -1.,   9., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hZZ",         "#Delta(hZZ)",                                  rZ,    "",    "", 0.02,   -6.,   4.,   -1.,   9., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hZgamma",     "#Delta(hZ#gamma)",                             0.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hgammagamma", "#Delta(h#gamma#gamma)",                    rgamma,    "",    "", 0.01,   -7.,   5.,   -1.,   9., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hgg",         "#Delta(hgg)",                                  rg,    "",    "", .001,   -4.,   2.,   -1.,  40., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hggZ",        "#Delta(hggZ)",                                 0.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hihjZ",       "#Delta(h_{i}h_{j}Z)",                         -1.,    "",    "", 0.01, -101.,  99.,   -1.,   7., true  ) );
    //AddParameter( new PhysicsParameter( "BR_hjhihi",         "BR(h_{j}#rightarrowh_{i}h_{i}}",               0.,    "",    "", 0.01,    0.,   1.,    0.,   1., true  ) );
    //AddParameter( new PhysicsParameter( "Gamma_hInvisible",  "#Gamma(h#rightarrowInvisible)",  rGammahInvisible, "GeV", "GeV", 0.01,    0.,   1.,    0.,   1., false ) );

    //AddParameter( new PhysicsParameter( "Mass_h",            "m_{h}",                          126., "GeV", "GeV", 0.02,  123., 129.,  123., 129., false ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hss",       "#Delta_{s}(hss)",                  0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hss",       "#Delta_{p}(hss)",                 -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hcc",       "#Delta_{s}(hcc)",                  0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hcc",       "#Delta_{p}(hcc)",                 -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hbb",       "#Delta_{s}(hbb)",                  0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hbb",       "#Delta_{p}(hbb)",                 -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_htt",       "#Delta_{s}(htt)",                  0.,    "",    "",  0.2,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htt",       "#Delta_{p}(htt)",                 -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_hmumu",     "#Delta_{s}(h#mu#mu)",              0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_p_hmumu",     "#Delta_{p}(h#mu#mu)",             -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_s_htautau",   "#Delta_{s}(h#tau#tau)",            0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_p_htautau",   "#Delta_{p}(h#tau#tau)",           -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hWW",         "#Delta(hWW)",                      0.,    "",    "",  0.2,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hZZ",         "#Delta(hZZ)",                      0.,    "",    "",  0.2,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hZgamma",     "#Delta(hZ#gamma)",                 0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hgammagamma", "#Delta(h#gamma#gamma)",            0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hgg",         "#Delta(hgg)",                      0.,    "",    "",  0.2,  -12.,  10.,  -12.,  10., false ) );
    //AddParameter( new PhysicsParameter( "Delta_hggZ",        "#Delta(hggZ)",                     0.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "Delta_hihjZ",       "#Delta(h_{i}h_{j}Z)",             -1.,    "",    "",  0.1,  -12.,  10.,  -12.,  10., true  ) );
    //AddParameter( new PhysicsParameter( "BR_hjhihi",         "BR(h_{j}#rightarrowh_{i}h_{i}}",   0.,    "",    "",  0.1,    0.,   1.,    0.,   1., true  ) );
    //AddParameter( new PhysicsParameter( "Gamma_hInvisible",  "#Gamma(h#rightarrowInvisible)",    0., "GeV", "GeV", 0.01,    0.,   1.,    0.,   1., false ) );

    //SLHAModelCalculatorBase* slhaModelCalculator = new HiggsSignalsSLHAModelCalculator( this );
    //_modelCalculatorVector.push_back( slhaModelCalculator );

    //_predictionVector.push_back( new SLHAPrediction( "Gamma_hTotal", "#Gamma_{h}^{Total}",
    //                                                 "GeV", "GeV",
    //                                                 0., 1.,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "7", 1  ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_s_hss", "BR(h#rightarrowss)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "8", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_s_hcc", "BR(h#rightarrowcc)",                           
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "9", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_s_hbb", "BR(h#rightarrowbb)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "10", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_s_htt", "BR(h#rightarrowtt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "11", 1 ) );
 
    //_predictionVector.push_back( new SLHAPrediction( "BR_s_hmumu", "BR(h#rightarrow#mu#mu)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "12", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_s_htautau", "BR(h#rightarrow#tau#tau)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "13", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_hWW", "BR(h#rightarrowWW)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "14", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_hZZ", "BR(h#rightarrowZZ)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "15", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_hZgamma", "BR(h#rightarrowZ#gamma)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "16", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_hgammagamma", "BR(h#rightarrow#gamma#gamma)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "17", 1 ) ); 

    //_predictionVector.push_back( new SLHAPrediction( "BR_hgg", "BR(h#rightarrowgg)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "18", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_hss", "BR(h#rightarrowss)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "19", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_hcc", "BR(h#rightarrowcc)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "20", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_hbb", "BR(h#rightarrowbb)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "21", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_htt", "BR(h#rightarrowtt)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "22", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_hmumu", "BR(h#rightarrow#mu#mu)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "23", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_s_htautau", "BR(h#rightarrow#tau#tau)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "24", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_hWW", "BR(h#rightarrowWW)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "25", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_hZZ", "BR(h#rightarrowZZ)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "26", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_hZgamma", "BR(h#rightarrowZ#gamma)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "27", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_hgammagamma", "BR(h#rightarrow#gamma#gamma)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "28", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_SM_hgg", "BR(h#rightarrowgg)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "29", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "BR_hInvisible", "BR(h#rightarrowInvisible)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "30", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "g2_SM_hgammagamma", "g^{2}(h#gamma#gamma)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "31", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "g2_SM_hgg", "g^{2}(hgg)^{SM}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "32", 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_inclusive_ATL", "#mu_{h#gamma#gamma}inclusive-ATL",
    ////                                                 "", "",
    ////                                                 0., 1.e6,
    ////                                                 slhaModelCalculator,
    ////                                                 "HiggsSignalsPeakObservables",
    ////                                                 "1", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_1lep_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (1lep)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "1", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv_central_highPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-central-highPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "2", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv_central_lowPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-central-lowPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "3", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv_rest_highPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-rest-highPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "4", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv_rest_lowPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.-rest-lowPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "5", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_conv_trans_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (conv.trans.)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "6", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_ETmiss_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (ETmiss)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "7", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_highmass2jetloose_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (highmass2jet,loose)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "8", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_highmass2jettight_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (highmass2jet,tight)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "9", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_lowmass2jet_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (lowmass2jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "10", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv_central_highPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-central-highPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6, 
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "11", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv_central_lowPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-central-lowPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "12", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv_rest_highPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-rest-highPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "13", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammgamma_unconv_rest_lowPTt_ATL", "ATL (pp)#rightarrowh#rightarrow#gamma#gamma (unconv.-rest-lowPTt)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "14", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_ATL", "ATL (pp)#rightarrowh#rightarrow#tau#tau",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "15", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWWlnulnu_ATL", "ATL (pp)#rightarrowh#rightarrowWW#rightarrowl#nul#nu",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "16", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VBFWWlnulnu_ATL", "ATL (pp)#rightarrowVBF#rightarrowWW#rightarrowl#nul#nu",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "17", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_ATL", "ATL (pp)#rightarrowh#rightarrowZZ#rightarrow4l",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "18", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_ATL", "ATL (pp)#rightarrowVh#rightarrowVb#bar{b}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "19", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_CDF", "CDF (pp)#rightarrowh#rightarrow#gamma#gamma",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "20", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_CDF", "CDF (pp)#rightarrowh#rightarrow#tau#tau",
    //                                                 "", "",
    //                                                 0., 1.e6, slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "21", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_CDF", "CDF (pp)#rightarrowh#rightarrowWW",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "22", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_tthttbb_CDF", "CDF (pp)#rightarrowt#bar{t}h#rightarrowttbb",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "23", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_CDF", "CDF (pp)#rightarrowVh#rightarrowVb#bar{b}",
    //                                                 "", "", 0., 1.e6, slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "24", "17", 2 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_inclusive_CMS","#mu_{h#gamma#gamma}inclusive-CMS",
    ////                                                 "", "",
    ////                                                 0., 1.e6,
    ////                                                 slhaModelCalculator,
    ////                                                 "HiggsSignalsPeakObservables",
    ////                                                 "12", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jet_CMS", "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "25", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jetloose_CMS",  "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet-loose)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "26", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_2jettight_CMS",  "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (2jet-tight)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "27", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_e_CMS","CMS (pp)#rightarrowh#rightarrow#gamma#gamma (e)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "28", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_inclusive_CMS", "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (inclusive)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "29", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_ETmiss_CMS", "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (ETmiss)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "30", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_mu_CMS", "CMS (pp)#rightarrowh#rightarrow#gamma#gamma (#mu)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "31", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_01jet_CMS", "CMS (pp)#rightarrowh#rightarrow#tau#tau (0/1 jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "32", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_01jet_CMS", "CMS (pp)#rightarrowh#rightarrowWW (0/1 jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "33", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_01jet_CMS", "CMS (pp)#rightarrowh#rightarrowZZ#rightarrow4l (0/1 jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "34", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hZZ4l_2jet_CMS", "CMS (pp)#rightarrowh#rightarrowZZ#rightarrow4l (2jet)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "35", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_tthttbb_CMS", "CMS (pp)#rightarrowt#bar{t}h#rightarrowttb#bar{b}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "36", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VBFtautau_CMS", "CMS (pp)#rightarrowVBF#rightarrow#tau#tau",
    //                                                 "", "",
    //                                                 0., 1.e6, 
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "37", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VBFWW_CMS", "CMS (pp)#rightarrowVBF#rightarrowWW",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "38", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVbb_CMS", "CMS (pp)#rightarrowVh#rightarrowVb#bar{b}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "39", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_VhVtautau_CMS", "CMS (pp)#rightarrowVh#rightarrowV#tau#tau",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "40", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_WhWWW_CMS", "CMS (pp)#rightarrowWh#rightarrowWWW",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "41", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hbb_D0", "D#slash{0} (pp)#rightarrowh#rightarrowb#bar{b}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "42", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hgammagamma_D0", "D#slash{0} (pp)#rightarrowh#rightarrow#gamma#gamma",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "43", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_htautau_D0", "D#slash{0} (pp)#rightarrowh#rightarrow#tau#tau",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "44", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "Mu_hWW_D0", "D#slash{0} (pp)#rightarrowh#rightarrowWW",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsPeakObservables",
    //                                                 "45", "17", 2 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_htautau", "R(h#rightarrow#tau#tau)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "4", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_hbb", "R(h#rightarrowb#bar{b})",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "5", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_Vhbb", "R(Vh#rightarrowVb#bar{b}}",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "6", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_hWW", "R(h#rightarrowWW)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "1", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_hZZ", "R(h#rightarrowZZ)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "2", 1 ) );

    //_predictionVector.push_back( new SLHAPrediction( "R_hgammagamma", "R(h#rightarrow#gamma#gamma)",
    //                                                 "", "",
    //                                                 0., 1.e6,
    //                                                 slhaModelCalculator,
    //                                                 "HiggsSignalsAdditionalPredictions",
    //                                                 "3", 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Masss",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 0 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Massc",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Massb",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Masst",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Massmu",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 1 ) );

    ////_predictionVector.push_back( new SLHAPrediction( "Masstau",
    ////                                                 "GeV",
    ////                                                 slhaModelCalculator,
    ////                                                 "", "",
    ////                                                 1 ) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "HiggsSignals",
    //                                                             slhaModelCalculator,
    //                                                             "HiggsSignalsResults",
    //                                                             "12", 1 ) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "Gamma_hTotal_Penalty",
    //                                                             slhaModelCalculator,
    //                                                             "HiggsSignalsAdditionalPredictions",
    //                                                             "33", 1 ) );

    //_chi2ContributionVector.push_back( new SLHAChi2Contribution( "BR_hInvisible_Limit",
    //                                                             slhaModelCalculator,
    //                                                             "HiggsSignalsAdditionalPredictions",
    //                                                             "34", 1 ) );

    PhysicsModelBase::Initialize();

}

Fittino::HECModel::~HECModel() {

}

Fittino::HECModel* Fittino::HECModel::Clone() const {

    return new HECModel( *this );

}
