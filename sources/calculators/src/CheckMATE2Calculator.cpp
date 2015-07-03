/* $Id: CheckMATE2Calculator.cpp 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************  
 *                                                                              *                      
 * Project     Fittino - A SUSY Parameter Fitting Package                       *             
 *                                                                              *         
 * File        CheckMATE2Calculator.cpp                                         *          
 * Description: Wrapper around CheckMATE                                        * 
 * Authors:     Nanette Range                                                   *           
 *                                                                              *               
 * Licence     This program is free software; you can redistribute it and/or    *            
 *             modify it under the terms of the GNU General Public License as   *  
 *             published by the Free Software Foundation; either version 3 of   *                             
 *             the License, or (at your option) any later version.              *
 *                                                                              *           
 *******************************************************************************/

#include <iostream>
#include <boost/property_tree/ptree.hpp>
#include <fstream>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#include "ModelBase.h"
#include "Executor.h"
#include "SimplePrediction.h"
#include "CheckMATE2Calculator.h"

Fittino::CheckMATE2Calculator::CheckMATE2Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
  :CalculatorBase( model, &ptree ) {

  SetName( "CheckMATE2Calculator" );
  SetTag( "CheckMATE2" );


  AddQuantity(new SimplePrediction( "r", "", _r));
  AddQuantity(new SimplePrediction("cl", "", _cl));
  AddQuantity(new SimplePrediction( "r_cl", "", _r_cl));

  
}

Fittino::CheckMATE2Calculator::~CheckMATE2Calculator() {

} 

void Fittino::CheckMATE2Calculator::CalculatePredictions() {

  //double Xsec_gg = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_gg")->GetValue();
  //std::string xsec_gg = boost::lexical_cast<std::string>(Xsec_gg) + "*FB";
  //std::string xsec_error_gg  = "0*PB";
  //std::string gg = "/lustre/user/range/fittino/bin/gg.hepmc";

  //double Xsec_sb = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_sb")->GetValue();
  //std::string xsec_sb = boost::lexical_cast<std::string>(Xsec_sb) + "*FB";
  //std::string xsec_error_sb = "0*PB";
  //std::string sb = "/lustre/user/range/fittino/bin/sb.hepmc";

  //double Xsec_ss = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_ss")->GetValue();
  //std::string xsec_ss = boost::lexical_cast<std::string>(Xsec_ss) + "*FB";
  //std::string xsec_error_ss = "0*PB";
  //std::string ss = "/lustre/user/range/fittino/bin/ss.hepmc";

  //double Xsec_sg = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_sg")->GetValue();
  //std::string xsec_sg = boost::lexical_cast<std::string>(Xsec_sg) + "*FB";
  //std::string xsec_error_sg = "0*PB";
  //std::string sg = "/lustre/user/range/fittino/bin/sg.hepmc";

  //double Xsec_sb1 = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_sb1")->GetValue();
  //std::string xsec_sb1 = boost::lexical_cast<std::string>(Xsec_sb1) + "*FB";
  //std::string xsec_error_sb1 = "0*PB";
  //std::string sb1 = "/lustre/user/range/fittino/bin/sb1.hepmc";

  //double Xsec_sb2 = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_sb2")->GetValue();
  //std::string xsec_sb2 = boost::lexical_cast<std::string>(Xsec_sb2) + "*FB";
  //std::string xsec_error_sb2 = "0*PB";
  //std::string sb2 = "/lustre/user/range/fittino/bin/sb2.hepmc";

  //double Xsec_st1 = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_st1")->GetValue();
  //std::string xsec_st1 = boost::lexical_cast<std::string>(Xsec_st1) + "*FB";
  //std::string xsec_error_st1 = "0*PB";
  //std::string st1 = "/lustre/user/range/fittino/bin/st1.hepmc";

  //double Xsec_st2 = _model->GetCollectionOfQuantities().At("NLLFast_nll_nlo_st2")->GetValue();
  //std::string xsec_st2 = boost::lexical_cast<std::string>(Xsec_st2) + "*FB";
  //std::string xsec_error_st2 = "0*PB";
  //std::string st2 = "/lustre/user/range/fittino/bin/st2.hepmc";

  double xsec = _model->GetCollectionOfQuantities().At("Herwigpp_Total_Xsec")->GetValue();
  std::string Xsec = boost::lexical_cast<std::string>(xsec);
  std::string Xsec_unit = Xsec + "*NB";
  
  //double xsec_error = _model->GetCollectionOfQuantities().At("Herwigpp_Total_Xsec_error")->GetValue();
  //std::string Xsec_error = boost::lexical_cast<std::string>(xsec_error);
  //std::string Xsec_error_unit = Xsec_error + "*NB";

  std::string inputfile = "/lustre/user/range/fittino/bin/LHC-MSSM.hepmc";
   
  Executor executor( "/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.2.0/bin/CheckMATE","CheckMATE");
  executor.AddArgument( "-n" );
  executor.AddArgument( "/lustre/user/range/fittino/bin/Last_Run" );
  executor.AddArgument( "-a" );
  executor.AddArgument( "atlas" );
  executor.AddArgument( "-cl" );
  executor.AddArgument( "-q" );
  executor.AddArgument( "-t" );
  executor.AddArgument( "-oe" );
  executor.AddArgument( "overwrite" );
  executor.AddArgument( "-p" );
  executor.AddArgument( "gluinogluino" );
  executor.AddArgument( "-xs" );
  executor.AddArgument( Xsec_unit );
  executor.AddArgument( "-xse" );
  executor.AddArgument( "0*NB" );
  executor.AddArgument( inputfile );

  //executor.AddArgument( "-p" );
  //executor.AddArgument( "gg" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_gg );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_gg );
  //executor.AddArgument( gg );

  //executor.AddArgument( "-p" );
  //executor.AddArgument("sb" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_sb );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_sb );
  //executor.AddArgument( sb ); 

  //executor.AddArgument( "-p" );
  //executor.AddArgument("ss" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_ss );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_ss );
  //executor.AddArgument( ss ); 

  //executor.AddArgument( "-p" );
  //executor.AddArgument("sg" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_sg );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_sg );
  //executor.AddArgument( sg ); 
  
  //executor.AddArgument( "-p" );
  //executor.AddArgument("sb1" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_sb1 );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_sb1 );
  //executor.AddArgument( sb1 ); 

  //executor.AddArgument( "-p" );
  //executor.AddArgument("sb2" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_sb2 );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_sb2 );
  //executor.AddArgument( sb2 ); 

  //executor.AddArgument( "-p" );
  //executor.AddArgument("st1" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_st1 );
  //executor.AddArgument( "-xse" );
  //executor.AddArgument( xsec_error_st1 );
  //executor.AddArgument( st1 ); 

  //executor.AddArgument( "-p" );
  //executor.AddArgument("st2" );
  //executor.AddArgument( "-xs" );
  //executor.AddArgument( xsec_st2 );
  //executor.AddArgument( "-xse" );
  // executor.AddArgument( xsec_error_st2 );
  //executor.AddArgument( st2 ); 

  executor.Execute();

  std::ifstream file1;
  std::string line1;

  file1.open("/lustre/user/range/fittino/bin/Last_Run/result.txt");
  
  while(getline(file1, line1)) {

    typedef std::vector< std::string> split_vector_type;
   
    split_vector_type SplitVec;
    split( SplitVec, line1, boost::is_any_of(" "), boost::token_compress_on);
  
    if(SplitVec.size() > 4) {
      
      if (SplitVec[3] == "cls_min") {

	std::string CL = SplitVec[5];
	_cl = boost::lexical_cast <double>(CL);
      }
    }

    if(SplitVec.size() > 4) {
      if(SplitVec[3] == "r_max") {

	std::string R = SplitVec[5];
	_r_cl = boost::lexical_cast <double>(R);

      }
    }  

  }
      
  file1.close();  

  Executor executorR( "/lustre/fittino/group/external/SL6/CheckMATE/CheckMATE-1.2.0/bin/CheckMATE","CheckMATE");
  executorR.AddArgument( "-n" );
  executorR.AddArgument( "/lustre/user/range/fittino/bin/Last_Run" );
  executorR.AddArgument( "-a" );
  executorR.AddArgument( "atlas" ); 
  executorR.AddArgument( "-cl" );
  executorR.AddArgument( "-q" );
  executorR.AddArgument( "-t" );
  executorR.AddArgument( "-oe" );
  executorR.AddArgument( "overwrite" );
  executorR.AddArgument( "-p" );
  executorR.AddArgument( "total" );
  executorR.AddArgument( "-xs" );
  executorR.AddArgument( Xsec_unit );
  executorR.AddArgument( "-xse" );
  executorR.AddArgument( "0*NB" );
  executorR.AddArgument( inputfile );
  executorR.Execute();


  std::ifstream file2;
  std::string line2;
 
  file2.open("/lustre/user/range/fittino/bin/Last_Run/result.txt");

  while(getline(file2, line2)) {

    typedef std::vector< std::string> split_vector_type;

    split_vector_type SplitVec;
    split( SplitVec, line2, boost::is_any_of(" "), boost::token_compress_on);

    if(SplitVec.size() > 4) {
      if(SplitVec[3] == "r_max") {
	
	std::string R = SplitVec[5]; 
	_r = boost::lexical_cast <double>(R);
	
       }

      else continue;
      
     }
  }
 
  file2.close();


}

void Fittino::CheckMATE2Calculator::SetupMeasuredValues() {

}

void Fittino::CheckMATE2Calculator::Initialize() {

}
