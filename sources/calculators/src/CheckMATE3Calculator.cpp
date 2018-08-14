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
#include "boost/filesystem.hpp"
#include "CalculatorException.h"
#include "ModelBase.h"
#include "Executor.h"
#include "LogicException.h"
#include "SimplePrediction.h"
#include "CheckMATE3Calculator.h"

    Fittino::CheckMATE3Calculator::CheckMATE3Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model, &ptree ) 
    ,_inputFile( ptree.get_child("InputFile"), model ){
     
	_name = "CheckMate";
        _executable = ptree.get<std::string>( "Executable" );
        _first = true;
	_inputfile_test = ptree.get<std::string> ( "InputFileTest" );
	_CM_tot_result = ptree.get<std::string>( "results" );
	_CM_r_result = ptree.get<std::string>( "r_results" );
	_old_result = ptree.get<std::string>( "old_result" );
    	Executor executor2( _executable, "CheckMATE" );
    	executor2.AddArgument( _inputfile_test ); 
        executor2.Execute();


        std::string dummy, temp1, temp2;
        std::string line;
        double temp3 = 0, temp4=0, temp5=0, temp6=0, temp7=0, temp8=0, temp9=0, temp10=0;
        std::vector<std::string> analysis;
        std::vector<std::string> sr;
        std::ifstream infile(_old_result);
        int n = 0;
              while(std::getline(infile, line)){
                  if(n>=1){
                    if(line.empty())  break ;
        
         std::istringstream ss(line);
         ss>>temp1>>temp2>>temp3>>temp4>>dummy>>dummy>>dummy>>dummy>>temp5>>temp9>>dummy;
         analysis.push_back(temp1);
         sr.push_back(temp2);
            }
          n+=1;
         }                                                                                                                                                                                                                                                                                             infile.close();
       
std::string output;
int u=0;
for(const auto& elem : analysis ) {
    output = elem+"_"+sr[u];
    AddOutput( output + "_tot_norm_ev" );
    AddOutput( output + "_si_norm_ev" );
    AddOutput( output + "_si_er_stat" );
    AddOutput( output + "_si_er_syst" );
    AddOutput( output + "_si_er_tot" );
    AddOutput( output + "_tot_mc_ev"   );
    AddOutput( output + "_likelihood"   );
    AddOutput( output + "_r_value"   ); 
    AddOutput( output + "_cls_obs"   );
    AddOutput( output + "_cls_obs_err"   );
    AddOutput( output + "_cls_exp"   );
    AddOutput( output + "_cls_exp_err"   );
    AddOutput( output + "_bkg"   );
    AddOutput( output + "_bkg_err"   );
    AddOutput( output + "_obs"   );
    AddOutput( output + "_s95exp"   );

    SetOutput( output + "_tot_mc_ev"  , 0  );
    SetOutput( output + "_tot_norm_ev"  , 0 );
    SetOutput( output + "_si_norm_ev"  , 0  );
    SetOutput( output + "_si_er_stat"  , 0  );
    SetOutput( output + "_si_er_syst"  , 0  );
    SetOutput( output + "_si_er_tot"  , 0  );
    SetOutput( output + "_likelihood"  , 0  );
    SetOutput( output + "_r_value"  , 0  );
    SetOutput( output + "_cls_obs" , 0 );
    SetOutput( output + "_cls_obs_err" , 0  );
    SetOutput( output + "_cls_exp" , 0  );
    SetOutput( output + "_cls_exp_err", 0   );
    SetOutput( output + "_bkg" , 0   );
    SetOutput( output + "_bkg_err", 0   );
    SetOutput( output + "_obs", 0   );
    SetOutput( output + "_s95exp", 0   );




u +=1;

    

}

    AddOutput("r_value_exclusion");
  


    }

Fittino::CheckMATE3Calculator::~CheckMATE3Calculator() {

} 

void Fittino::CheckMATE3Calculator::ReadResult() {
	
 if (!boost::filesystem::exists (_CM_tot_result)){
 	throw CalculatorException(_name, "CheckMateError");    
    }
	
 else{

	std::string dummy, temp1, temp2;
        std::string line;
        double temp3 = 0, temp4=0, temp5=0, temp6=0, temp7=0, temp8=0, temp9=0, temp10=0, temp11=0, temp12=0, temp13=0, temp14=0, temp15=0, temp16=0, temp17=0, temp18=0;
        std::vector<std::string> analysis;
        std::vector<std::string> sr;
        std::vector<double> tot_mc_ev;
        std::vector<double> tot_norm_ev;
        std::vector<double> si_norm_ev;
        std::vector<double> si_er_stat;
        std::vector<double> si_er_syst;
        std::vector<double> si_er_tot;
        std::vector<double> cls_exp;
        std::vector<double> cls_exp_err;
        std::vector<double> cls_obs;
        std::vector<double> cls_obs_err;
        std::vector<double> bkg;
        std::vector<double> bkg_err;
        std::vector<double> obs;
        std::vector<double> s95exp;
        std::vector<double> likelihood;
	std::vector<double> r_value;
        std::ifstream infile(_CM_tot_result);
	int n = 0;
        while(std::getline(infile, line)){
         if(n>=1){
         if(line.empty())  break ;

            std::istringstream ss(line);
            ss>>temp1>>temp2>>temp3>>temp4>>dummy>>dummy>>dummy>>dummy>>temp5>>temp6>>temp7>>temp8>>temp11>>temp12>>temp13>>dummy>>dummy>>dummy>>dummy>>dummy>>temp18>>dummy>>temp10>>dummy>>dummy>>dummy>>dummy>>temp14>>temp15>>temp16>>temp17>>temp9;
            analysis.push_back(temp1);
            sr.push_back(temp2);
            tot_mc_ev.push_back(temp3);
            tot_norm_ev.push_back(temp4);
	    si_norm_ev.push_back(temp5);
	    si_er_stat.push_back(temp6);
	    si_er_syst.push_back(temp7);
	    si_er_tot.push_back(temp8);
	    likelihood.push_back(temp9);
	    r_value.push_back(temp10);
	    bkg.push_back(temp12);
	    bkg_err.push_back(temp13);
	    obs.push_back(temp11);
	    s95exp.push_back(temp18);
	    cls_obs.push_back(temp14);
	    cls_obs_err.push_back(temp15);
	    cls_exp.push_back(temp16);
	    cls_exp_err.push_back(temp17);




	   }
            n+=1;
}
	infile.close();







std::string output3;
std::string output4;



int p = 0;
for(const auto& elem : analysis ) {
    output3 = elem + "_" + sr[p];
   
    SetOutput( output3 + "_tot_mc_ev"  , tot_mc_ev[p]  );
    SetOutput( output3 + "_tot_norm_ev"  , tot_norm_ev[p]  );
    SetOutput( output3 + "_si_norm_ev"  , si_norm_ev[p]  );
    SetOutput( output3 + "_si_er_stat"  , si_er_stat[p]  );
    SetOutput( output3 + "_si_er_syst"  , si_er_syst[p]  );
    SetOutput( output3 + "_si_er_tot"  , si_er_tot[p]  );
    SetOutput( output3 + "_likelihood"  , likelihood[p]  ); 
    SetOutput( output3 + "_r_value"  , r_value[p]  ); 
    SetOutput( output3 + "_cls_obs_err"  , cls_obs_err[p]  ); 
    SetOutput( output3 + "_cls_obs"  , cls_obs[p]  ); 
    SetOutput( output3 + "_cls_exp_err"  , cls_exp_err[p]  ); 
    SetOutput( output3 + "_cls_exp"  , cls_exp[p]  ); 
    SetOutput( output3 + "_bkg"  , bkg[p]  ); 
    SetOutput( output3 + "_bkg_err"  , bkg_err[p]  ); 
    SetOutput( output3 + "_obs"  , obs[p]  ); 
    SetOutput( output3 + "_s95exp"  , s95exp[p]  ); 
   std::cout<< tot_mc_ev[p] << std::endl;
  p+=1 ;
}

    
}

}


void Fittino::CheckMATE3Calculator::ReadrResult() {

 if (!boost::filesystem::exists (_CM_r_result)){
        throw CalculatorException(_name, "CheckMateError_2");    
    }
 else{

     double r_value_ex;
     std::string line1;
     std::ifstream rfile(_CM_r_result);
     std::vector<std::string> parts;
     for (int i=0; i<4; i++)
        {
                std::getline(rfile, line1);
			if(boost::starts_with(line1, "Result for")){

    				 boost::split(parts, line1, boost::is_any_of(" "));
			         r_value_ex= std::stod (parts[3]);
  			         SetOutput( "r_value_exclusion"  , r_value_ex  );
			}
                std::cout << line1;
        }
     rfile.close();
}
}

void Fittino::CheckMATE3Calculator::CalculatePredictions() {


    _inputFile.Write();

    Executor executor( _executable, "CheckMATE" );
    executor.AddArgument( _inputFile.GetName() );
    executor.Execute();

    ReadResult();
    ReadrResult();


   _first = false;

}
