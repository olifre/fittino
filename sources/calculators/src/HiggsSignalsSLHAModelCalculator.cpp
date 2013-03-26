/* $Id: HiggsSignalsSLHAModelCalculator.cpp 844 2011-01-10 13:52:15Z uhlenbrock $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        HiggsSignalsSLHAModelCalculator.cpp                              *
*                                                                              *
* Description Wrapper class for HiggsSignals                                   *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <cstring>

#include "HiggsSignalsSLHAModelCalculator.h"


Fittino::HiggsSignalsSLHAModelCalculator::HiggsSignalsSLHAModelCalculator() {

}

Fittino::HiggsSignalsSLHAModelCalculator::~HiggsSignalsSLHAModelCalculator() {

}

void Fittino::HiggsSignalsSLHAModelCalculator::Initialize(){

    int nHzero = 1;
    int nHplus = 0;

    initialize_higgssignals_latestresults_( &nHzero, &nHplus );

    int output_level = 1;

    setup_output_level_( &output_level );

    int pdf = 2;

    setup_pdf_( &pdf);

     double dm = 0.0;

    higgssignals_neutral_input_massuncertainty_( &dm );

    int iterations = 0;

    setup_higgs_to_peaks_assignment_iterations_( &iterations );

}

void Fittino::HiggsSignalsSLHAModelCalculator::ConfigureInput( PhysicsModelBase* model ) {

    
    //set i=1,31 j=1,51:

    int i = 21;
    int j = 6;
    double scale_ggh = (i-1)*0.05;
    double scale_bbh = (j-1)*0.20;
    

    double SMBR_Htoptop,SMBR_Hss, SMBR_Hcc, SMBR_Hbb, SMBR_Hmumu, SMBR_Htautau; 
    double SMBR_HWW, SMBR_HZZ, SMBR_HZgam, SMBR_Hgamgam, SMBR_Hgg,SMGamma_h;
    double Mh = 126.0, GammaTotal;
    double SMGammaTotal = SMGamma_h/*(Mh)*/;

    //GammaTotal = SMGammaTotal*(1 = DeltahWW);

    /*
    //Calculate the new total decay width:
    GammaTotal = SMGammaTotal*(1 + (DeltaHWW - 1)*SMBR_HWW(Mh) + (DeltahZZ - 1)*SMBR_HZZ(Mh) + (Deltahgg - 1)*SMBR_Hgg(Mh) + 
    (g2hjtt_s - 1)*SMBR_Htoptop(Mh)+ (Deltahbb_s - 1)*SMBR_Hbb(Mh) + (Deltahtautau_s - 1)*SMBR_Htautau(Mh) +
    (Deltahgammagamma - 1)*SMBR_Hgamgam(Mh));
    */
}

//double Fittino::HiggsSignalsSLHAModelCalculator::get_g2hgaga(){
//    //Evaluates g2hgaga from other effective couplings.....
//
//    double ghbb,ghtt,ghtautau,ghWW,ghZZ;
//    double get_g2hgaga;
//  
//    get_g2hgaga = ghtt*ghtt*0.070904 + ghbb*ghbb*0.18760e-04 + ghWW*ghWW*1.5863 +
//    ghtt*ghbb*(-0.17319e-02) + ghtt*ghWW*(-0.67074) + ghbb*ghWW*0.82093e-02 +
//    ghtautau*ghtautau*0.22663e-04 + ghtt*ghtautau*(-0.18696e-02) + ghbb*ghtautau*0.41239e-04 +
//    ghtautau*ghWW*0.88634e-02;
// 
//    return get_g2hgaga;
//
//}   

/*double Fittino::HiggsSignalsSLHAModelCalculator::get_singleH_uncertainty(){

    double dggh = 0.147;
    double dbbh = 0.2;
    double  g2hgg, g2hbb, mh;
    double get_singleH_uncertainty;

    if (g2hgg <= vsmall && g2hbb <= vsmall) {
    
    	get_singleH_uncertainty = 0.0;

    }
    else {

    	get_singleH_uncertainty = ( g2hgg*LHC8_rH_gg(mh)*dggh + g2hbb*LHC8_rH_bb(mh)*dbbh )
   	 /( g2hgg*LHC8_rH_gg(mh) + g2hbb*LHC8_rH_bb(mh));

    }
    
    return get_singleH_uncertainty;

}   */


/*void Fittino::SLHAModelCalculatorBase::CallFunction() {
}    */
