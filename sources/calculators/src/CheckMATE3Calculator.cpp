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

#include "ModelBase.h"
#include "Executor.h"
#include "LogicException.h"
#include "SimplePrediction.h"
#include "CheckMATE3Calculator.h"

    Fittino::CheckMATE3Calculator::CheckMATE3Calculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
:CalculatorBase( model, &ptree )
    ,_inputFile( ptree.get_child("InputFile"), model )
     {

        _executable = ptree.get<std::string>( "Executable" );
//	_executable2 = ptree.get<std::string>( "Executable" );
//        _inputFile = ptree.get<std::string>( "InputFile" );
        _first = true;
	_inputfile_test = ptree.get<std::string> ( "InputFileTest" );
	_CM_tot_result = ptree.get<std::string>( "results" );
	_old_result = ptree.get<std::string>( "old_result" );
    //    AddOutput( "ErrorIsDominatedByMonteCarloStatistics", _errorIsDominatedByMonteCarloStatistics );
    //    AddOutput( "TheModelCouldBeExcludedIfYouProvidedMoreInputEvents", _theModelCouldBeExcludedIfYouProvidedMoreInputEvents );
    //    AddOutput( "Excluded", _excluded ); 
         
    	Executor executor2( _executable, "CheckMATE" );
    	executor2.AddArgument( _inputfile_test );

       executor2.Execute();

  
        std::string dummy, temp1, temp2;
        std::string line;
        double temp3 = 0, temp4=0, temp5=0, temp6=0, temp7=0, temp8=0, temp9=0, temp10=0;
         std::vector<std::string> analysis;
         std::vector<std::string> sr;
//     	 std::string analysis_selection;
//std::vector<std::string> parts;
//std::ifstream inputfile( _inputFile.GetName() ); 
//boost::split( parts, inputfile, boost::is_any_of("  ") );
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
//for(int i=1 ; i<n ; i++){
    output = elem+"_"+sr[u];
    AddOutput( output + "_tot_norm_ev" );
    AddOutput( output + "_si_norm_ev" );
    AddOutput( output + "_si_er_stat" );
    AddOutput( output + "_si_er_syst" );
    AddOutput( output + "_si_er_tot" );
    AddOutput( output + "_tot_mc_ev"   );
    AddOutput( output + "_likelihood"   );
    AddOutput( output + "_r_value"   );

       SetOutput( output + "_tot_mc_ev"  , 0  );
    SetOutput( output + "_tot_norm_ev"  , 0 );
    SetOutput( output + "_si_norm_ev"  , 0  );
    SetOutput( output + "_si_er_stat"  , 0  );
    SetOutput( output + "_si_er_syst"  , 0  );
    SetOutput( output + "_si_er_tot"  , 0  );
    SetOutput( output + "_likelihood"  , 0  );
    SetOutput( output + "_r_value"  , 0  );



u +=1;

    

}


    }

Fittino::CheckMATE3Calculator::~CheckMATE3Calculator() {

} 

void Fittino::CheckMATE3Calculator::ReadResult() {


	std::string dummy, temp1, temp2;
        std::string line;
        double temp3 = 0, temp4=0, temp5=0, temp6=0, temp7=0, temp8=0, temp9=0, temp10=0;
        //int temp4 =0;
        std::vector<std::string> analysis;
        std::vector<std::string> sr;
        std::vector<double> tot_mc_ev;
        std::vector<double> tot_norm_ev;
        std::vector<double> si_norm_ev;
        std::vector<double> si_er_stat;
        std::vector<double> si_er_syst;
        std::vector<double> si_er_tot;
        std::vector<double> likelihood;
	std::vector<double> r_value;
        //std::vector<int> SQFam;
        std::ifstream infile(_CM_tot_result);
	int n = 0;
        while(std::getline(infile, line)){
         if(n>=1){
         if(line.empty())  break ;

            std::istringstream ss(line);
            ss>>temp1>>temp2>>temp3>>temp4>>dummy>>dummy>>dummy>>dummy>>temp5>>temp6>>temp7>>temp8>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>dummy>>temp10>>dummy>>temp9;
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
	   }
            n+=1;
}
	infile.close();
/*

       std::map<std::string, double> proXSLO05m;
   for (int i=0 ; i<process.size() ; i+=3){
     if(process[i]=="bb"|| process[i]=="tb"){
         std::cout << SQFam[i] << std::endl;
         temp5 = std::to_string(SQFam[i]);
         temp6 = process[i] + temp5;
          std::cout << temp6 << std::endl;
          proXSLO05m[temp6]=XSLO[i];
        }
      else{
        proXSLO05m[process[i]] = XSLO[i];
        }


      
        for( const auto& elem : proXSLO05m ) {
*/



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
   std::cout<< tot_mc_ev[p] << std::endl;
  p+=1 ;
}

    


}

void Fittino::CheckMATE3Calculator::CalculatePredictions() {

//  if ( boost::filesystem::exists( _inputFile.GetName() ) ) boost::filesystem::remove( _inputFile.GetName() );
//    if ( boost::filesystem::exists( _directory ) ) boost::filesystem::remove_all( _directory );

  _inputFile.Write();

    Executor executor( _executable, "CheckMATE" );
    executor.AddArgument( _inputFile.GetName() );
//    executor.AddArgument( _inputFile );
   executor.Execute();

    ReadResult();

//std::string output;
//std::string output2;

//for(int i=0 ; i<n ; i++){
//    output = analysis[i]+sr[i];
 //       SetOutput( output + "_tot_mc_ev", 0   );
           //std::cout<< tot_mc_ev[i] << std::endl;

//           }
//


   _first = false;

}
