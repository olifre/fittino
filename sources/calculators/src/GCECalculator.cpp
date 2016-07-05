/* $Id: GCECalculator.cpp 2383 2014-12-29 13:52:26Z sarrazin $ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        GCECalculator.cpp                                       *
*                                                                              *
* Description Calculator for python scripts                                    *          
*                                                                              *
* Authors     Matthias Hamer <matthias.hamer@cern.ch>                          *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#define BOOST_NO_CXX11_SCOPED_ENUMS

#include <fstream>

#include "boost/filesystem.hpp"

#include "GCECalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "Redirector.h"
#include "SimplePrediction.h"
#include "TimeoutExecutorException.h"

Fittino::GCECalculator::GCECalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model ),
      _executor( "./GCE_master.py", "GCE_master.py" ) {
     
    _tag  = "GCE";
    _name = "GCECalculator";

    AddQuantity( new SimplePrediction( "ll_gce",    "", _ll_gce   ) );
    AddQuantity( new SimplePrediction( "chi2_gce",  "", _chi2_gce ) );
    AddQuantity( new SimplePrediction( "ll_j",      "", _ll_j     ) );
    AddQuantity( new SimplePrediction( "chi2_j",    "", _chi2_j   ) );
    AddQuantity( new SimplePrediction( "ll_R3",    "", _ll_R3   ) );
    AddQuantity( new SimplePrediction( "chi2_R3",  "", _chi2_R3 ) );
    AddQuantity( new SimplePrediction( "ll_R16",    "", _ll_R16   ) );
    AddQuantity( new SimplePrediction( "chi2_R16",  "", _chi2_R16 ) );
    AddQuantity( new SimplePrediction( "ll_dSph",     "", _ll_dSph    ) );
    AddQuantity( new SimplePrediction( "chi2_dSph",   "", _chi2_dSph  ) );
    AddQuantity( new SimplePrediction( "jfactor",   "", _jfactor  ) );
    AddQuantity( new SimplePrediction( "jres",   "", _jres  ) );
    AddQuantity( new SimplePrediction( "GCEERROR", "", _GCEERROR ) );
}

Fittino::GCECalculator::~GCECalculator() {

}

void Fittino::GCECalculator::CalculatePredictions() {
    
    std::string outputFileName = _name + ".out"; 
    Redirector redirector( outputFileName );
  
    redirector.Start();
    
    std::ofstream inputFile( "GCEInput.txt", std::ofstream::out );
    inputFile << "sigmav  " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma")->GetValue() << std::endl;
    inputFile << "mDM "    << _model->GetCollectionOfQuantities().At("SPheno_Mass_~chi10")->GetValue() << std::endl;
    inputFile << "con_gg " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_GG")->GetValue() << std::endl;
    inputFile << "con_aa " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_AA")->GetValue() << std::endl;
    inputFile << "con_ww " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_WpWm")->GetValue() << std::endl;
    inputFile << "con_zz " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_ZZ")->GetValue() << std::endl;
    inputFile << "con_zh " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_Zh")->GetValue() << std::endl;
    inputFile << "con_hh " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_hh")->GetValue() << std::endl;
    inputFile << "con_tt " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_tT")->GetValue() << std::endl;
    inputFile << "con_bb " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_bB")->GetValue() << std::endl;
    inputFile << "con_cc " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_cC")->GetValue() << std::endl;
    inputFile << "con_ss " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_sS")->GetValue() << std::endl;
    inputFile << "con_dd " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_dD")->GetValue() << std::endl;
    inputFile << "con_uu " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_uU")->GetValue() << std::endl;
    inputFile << "con_ee " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_eE")->GetValue() << std::endl;
    inputFile << "con_mm " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_mM")->GetValue() << std::endl;
    inputFile << "con_tatau " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_lL")->GetValue() << std::endl;
    inputFile << "con_nene " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_neNe")->GetValue() << std::endl;
    inputFile << "con_nmnm " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_nmNm")->GetValue() << std::endl;
    inputFile << "con_ntnt " << _model->GetCollectionOfQuantities().At("MicrOMEGAs_vSigma_Contribution_nlNl")->GetValue() << std::endl;
    

    try {

        _executor.Execute();

    }
    catch ( const TimeoutExecutorException& e ) {

        throw CalculatorException( _name, "Timeout" );

    }

    redirector.Stop();
    
    inputFile.close();
    std::ifstream outputFile( "GCEOutput.txt", std::ifstream::in );
    std::string key, value;
    while( outputFile.good() ) {
        outputFile >> key >> std::ws >> value;
        if( outputFile.eof() ) break;
        if     ( key == "ll_gce"   ) _ll_gce    = atof( value.c_str() );
        else if( key == "chi2_gce" ) _chi2_gce  = atof( value.c_str() );
        else if( key == "ll_R3"    ) _ll_R3     = atof( value.c_str() );
        else if( key == "chi2_R3"  ) _chi2_R3   = atof( value.c_str() );
        else if( key == "ll_R16"   ) _ll_R16    = atof( value.c_str() );
        else if( key == "chi2_R16" ) _chi2_R16  = atof( value.c_str() );
        else if( key == "ll_j"     ) _ll_j      = atof( value.c_str() );
        else if( key == "chi2_j"   ) _chi2_j    = atof( value.c_str() );
        else if( key == "ll_dSph"  ) _ll_dSph   = atof( value.c_str() );
        else if( key == "chi2_dSph") _chi2_dSph = atof( value.c_str() );
        else if( key == "jfactor"  ) _jfactor   = atof( value.c_str() );
        else if( key == "jres"     ) _jres      = atof( value.c_str() );
        else if( key == "error"    ) _GCEERROR  = atof( value.c_str() );
    }


}
