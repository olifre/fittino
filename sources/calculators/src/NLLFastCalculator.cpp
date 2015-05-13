#include <iostream>
#include <string>
#include <boost/lexical_cast.hpp>
#include <fstream>
#include <boost/algorithm/string.hpp>


#include "NLLFastCalculator.h"
#include "Executor.h"


Fittino::NLLFastCalculator::NLLFastCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

  SetName( "NLLFastCalculator" );
  SetTag( "NLLFast" );

  AddOutput( "ms_gg", _ms_gg );
  AddOutput( "mg_gg", _mg_gg );
  AddOutput( "lo_gg", _lo_gg );
  AddOutput( "nlo_gg", _nlo_gg );
  AddOutput( "nll_nlo_gg", _nll_nlo_gg );
  AddOutput( "d_mu_plus_gg", _d_mu_plus_gg );
  AddOutput( "d_mu_minus_gg", _d_mu_minus_gg );
  AddOutput( "d_pdf_plus_gg", _d_pdf_plus_gg );
  AddOutput( "d_pdf_minus_gg", _d_pdf_minus_gg );
  AddOutput( "d_as_plus_gg", _d_as_plus_gg );
  AddOutput( "d_as_minus_gg", _d_as_minus_gg );
  AddOutput( "k_nlo_gg", _k_nlo_gg );
  AddOutput( "k_nll_gg", _k_nll_gg );

  AddOutput( "ms_sb", _ms_sb );
  AddOutput( "mg_sb", _mg_sb );
  AddOutput( "lo_sb", _lo_sb );
  AddOutput( "nlo_sb", _nlo_sb );
  AddOutput( "nll_nlo_sb", _nll_nlo_sb );
  AddOutput( "d_mu_plus_sb", _d_mu_plus_sb );
  AddOutput( "d_mu_minus_sb", _d_mu_minus_sb );
  AddOutput( "d_pdf_plus_sb", _d_pdf_plus_sb );
  AddOutput( "d_pdf_minus_sb", _d_pdf_minus_sb );
  AddOutput( "d_as_plus_sb", _d_as_plus_sb );
  AddOutput( "d_as_minus_sb", _d_as_minus_sb );
  AddOutput( "k_nlo_sb", _k_nlo_sb );
  AddOutput( "k_nll_sb", _k_nll_sb );

  AddOutput( "ms_ss", _ms_ss );
  AddOutput( "mg_ss", _mg_ss );
  AddOutput( "lo_ss", _lo_ss );
  AddOutput( "nlo_ss", _nlo_ss );
  AddOutput( "nll_nlo_ss", _nll_nlo_ss );
  AddOutput( "d_mu_plus_ss", _d_mu_plus_ss );
  AddOutput( "d_mu_minus_ss", _d_mu_minus_ss );
  AddOutput( "d_pdf_plus_ss", _d_pdf_plus_ss );
  AddOutput( "d_pdf_minus_ss", _d_pdf_minus_ss );
  AddOutput( "d_as_plus_ss", _d_as_plus_ss );
  AddOutput( "d_as_minus_ss", _d_as_minus_ss );
  AddOutput( "k_nlo_ss", _k_nlo_ss );
  AddOutput( "k_nll_ss", _k_nll_ss );

  AddOutput( "ms_sg", _ms_sg );
  AddOutput( "mg_sg", _mg_sg );
  AddOutput( "lo_sg", _lo_sg );
  AddOutput( "nlo_sg", _nlo_sg );
  AddOutput( "nll_nlo_sg", _nll_nlo_sg );
  AddOutput( "d_mu_plus_sg", _d_mu_plus_sg );
  AddOutput( "d_mu_minus_sg", _d_mu_minus_sg );
  AddOutput( "d_pdf_plus_sg", _d_pdf_plus_sg );
  AddOutput( "d_pdf_minus_sg", _d_pdf_minus_sg );
  AddOutput( "d_as_plus_sg", _d_as_plus_sg );
  AddOutput( "d_as_minus_sg", _d_as_minus_sg );
  AddOutput( "k_nlo_sg", _k_nlo_sg );
  AddOutput( "k_nll_sg", _k_nll_sg );

}

Fittino::NLLFastCalculator::~NLLFastCalculator() {

}

void Fittino::NLLFastCalculator::CalculatePredictions() {

  

  Executor executorGG("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_gg");
  executorGG.AddArgument("gg");
  executorGG.AddArgument("cteq");
  executorGG.AddArgument("500");
  executorGG.AddArgument("500");
  executorGG.Execute();

  Executor executorSB("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sb");
  executorSB.AddArgument("sb");
  executorSB.AddArgument("cteq");
  executorSB.AddArgument("500");
  executorSB.AddArgument("500");
  executorSB.Execute();

  Executor executorSS("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_ss");
  executorSS.AddArgument("ss");
  executorSS.AddArgument("cteq");
  executorSS.AddArgument("500");
  executorSS.AddArgument("500");
  executorSS.Execute();

  Executor executorSG("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sg");
  executorSG.AddArgument("sg");
  executorSG.AddArgument("cteq");
  executorSG.AddArgument("500");
  executorSG.AddArgument("500");
  executorSG.Execute();



  std::fstream myfileGG;
  std::string line;

  myfileGG.open("/lustre/user/range/fittino/bin/gg.out");

  while( getline (myfileGG, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecGG;
    split( SplitVecGG, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecGG.size() > 12 ) {
       if( SplitVecGG[1] != "#" ) {
      
      	std::string MS_GG = SplitVecGG[1];
       	_ms_gg = boost::lexical_cast<double>(MS_GG);
    	std::cout << "MS_GG =" << _ms_gg  << std::endl;

    	std::string MG_GG = SplitVecGG[2];
    	_mg_gg = boost::lexical_cast<double>(MG_GG);
    	std::cout << "MG_GG = " << _mg_gg << std::endl;

    	std::string LO_GG = SplitVecGG[3];
    	_lo_gg = boost::lexical_cast<double>(LO_GG);
    	std::cout << "LO_GG = " << _lo_gg << std::endl;

    	std::string NLO_GG = SplitVecGG[4];
   	_nlo_gg = boost::lexical_cast<double>(NLO_GG);
    	std::cout << "NLO_GG = " << _nlo_gg << std::endl;

	std::string NLL_NLO_GG = SplitVecGG[5];
	_nll_nlo_gg = boost::lexical_cast<double>(NLL_NLO_GG);
   	std::cout << "NLL_NLO_GG = " << _nll_nlo_gg << std::endl;

   	std::string D_MU_PLUS_GG = SplitVecGG[6];
   	_d_mu_plus_gg = boost::lexical_cast<double>(D_MU_PLUS_GG);
    	std::cout << "d_mu+_gg = " << _d_mu_plus_gg << std::endl;
	
    	std::string D_MU_MINUS_GG = SplitVecGG[7];
    	_d_mu_minus_gg = boost::lexical_cast<double>(D_MU_MINUS_GG);
    	std::cout << "d_mu-_gg = " << _d_mu_minus_gg << std::endl;
	
    	std::string D_PDF_PLUS_GG = SplitVecGG[8];
    	_d_pdf_plus_gg = boost::lexical_cast<double>(D_PDF_PLUS_GG);
    	std::cout << "d_pdf+_gg = " << _d_pdf_plus_gg << std::endl;

    	std::string D_PDF_MINUS_GG = SplitVecGG[9];
    	_d_pdf_minus_gg = boost::lexical_cast<double>(D_PDF_MINUS_GG);
    	std::cout << "d_pdf-_gg = " << _d_pdf_minus_gg << std::endl;
	
    	std::string D_AS_PLUS_GG = SplitVecGG[10];
    	_d_as_plus_gg = boost::lexical_cast<double>(D_AS_PLUS_GG);
    	std::cout << "d_as+_gg = " << _d_as_plus_gg << std::endl;

    	std::string D_AS_MINUS_GG = SplitVecGG[11];
    	_d_as_minus_gg = boost::lexical_cast<double>(D_AS_MINUS_GG);
   	std::cout << "d_as-_gg = " << _d_as_minus_gg << std::endl;

    	std::string K_NLO_GG = SplitVecGG[12];
    	_k_nlo_gg = boost::lexical_cast<double>(K_NLO_GG);
    	std::cout << "k_nlo_gg = " << _k_nlo_gg << std::endl;

    	std::string K_NLL_GG = SplitVecGG[13];
    	_k_nll_gg = boost::lexical_cast<double>(K_NLL_GG);
    	std::cout << "k_nll_gg = " << _k_nll_gg << std::endl;
       }

      }
    }

  myfileGG.close();
  
  std::fstream myfileSB;

  myfileSB.open("/lustre/user/range/fittino/bin/sb.out");

  while( getline (myfileSB, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecSB;
    split( SplitVecSB, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecSB.size() > 12 ) {
      if( SplitVecSB[1] != "#" ) {

	std::string MS_SB = SplitVecSB[1];
        _ms_sb = boost::lexical_cast<double>(MS_SB);
	
	std::string MG_SB = SplitVecSB[2];
        _mg_sb = boost::lexical_cast<double>(MG_SB);
	
	std::string LO_SB = SplitVecSB[3];
        _lo_sb = boost::lexical_cast<double>(LO_SB);
        
	std::string NLO_SB = SplitVecSB[4];
        _nlo_sb = boost::lexical_cast<double>(NLO_SB);
        
	std::string NLL_NLO_SB = SplitVecSB[5];
        _nll_nlo_sb = boost::lexical_cast<double>(NLL_NLO_SB);
        	
	std::string D_MU_PLUS_SB = SplitVecSB[6];
        _d_mu_plus_sb = boost::lexical_cast<double>(D_MU_PLUS_SB);
        
	std::string D_MU_MINUS_SB = SplitVecSB[7];
        _d_mu_minus_sb = boost::lexical_cast<double>(D_MU_MINUS_SB);
        
	std::string D_PDF_PLUS_SB = SplitVecSB[8];
        _d_pdf_plus_sb = boost::lexical_cast<double>(D_PDF_PLUS_SB);
        
	std::string D_PDF_MINUS_SB = SplitVecSB[9];
        _d_pdf_minus_sb = boost::lexical_cast<double>(D_PDF_MINUS_SB);
        
	std::string D_AS_PLUS_SB = SplitVecSB[10];
        _d_as_plus_sb = boost::lexical_cast<double>(D_AS_PLUS_SB);
        
	std::string D_AS_MINUS_SB = SplitVecSB[11];
        _d_as_minus_sb = boost::lexical_cast<double>(D_AS_MINUS_SB);
        
	std::string K_NLO_SB = SplitVecSB[12];
        _k_nlo_sb = boost::lexical_cast<double>(K_NLO_SB);
        
	std::string K_NLL_SB = SplitVecSB[13];
        _k_nll_sb = boost::lexical_cast<double>(K_NLL_SB);
        

      }
    }
  }
  myfileSB.close();

  std::fstream myfileSS;

  myfileSS.open("/lustre/user/range/fittino/bin/ss.out");

  while( getline (myfileSS, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecSS;
    split( SplitVecSS, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecSS.size() > 12 ) {
      if( SplitVecSS[1] != "#" ) {

	std::string MS_SS = SplitVecSS[1];
        _ms_ss = boost::lexical_cast<double>(MS_SS);
        
	std::string MG_SS = SplitVecSS[2];
        _mg_ss = boost::lexical_cast<double>(MG_SS);
        
	std::string LO_SS = SplitVecSS[3];
        _lo_ss = boost::lexical_cast<double>(LO_SS);
        
	std::string NLO_SS = SplitVecSS[4];
        _nlo_ss = boost::lexical_cast<double>(NLO_SS);
        
	std::string NLL_NLO_SS = SplitVecSS[5];
        _nll_nlo_ss = boost::lexical_cast<double>(NLL_NLO_SS);
        
	std::string D_MU_PLUS_SS = SplitVecSS[6];
        _d_mu_plus_ss = boost::lexical_cast<double>(D_MU_PLUS_SS);
        
	std::string D_MU_MINUS_SS = SplitVecSS[7];
        _d_mu_minus_ss = boost::lexical_cast<double>(D_MU_MINUS_SS);
        
	std::string D_PDF_PLUS_SS = SplitVecSS[8];
        _d_pdf_plus_ss = boost::lexical_cast<double>(D_PDF_PLUS_SS);
        
	std::string D_PDF_MINUS_SS = SplitVecSS[9];
        _d_pdf_minus_ss = boost::lexical_cast<double>(D_PDF_MINUS_SS);
        
	std::string D_AS_PLUS_SS = SplitVecSS[10];
        _d_as_plus_ss = boost::lexical_cast<double>(D_AS_PLUS_SS);
        
	std::string D_AS_MINUS_SS = SplitVecSS[11];
        _d_as_minus_ss = boost::lexical_cast<double>(D_AS_MINUS_SS);
        
	std::string K_NLO_SS = SplitVecSS[12];
        _k_nlo_ss = boost::lexical_cast<double>(K_NLO_SS);
        
	std::string K_NLL_SS = SplitVecSS[13];
        _k_nll_ss = boost::lexical_cast<double>(K_NLL_SS);
        
      }
    }
  }
  myfileSS.close();
  
  std::fstream myfileSG;

  myfileSG.open("/lustre/user/range/fittino/bin/sg.out");

  while( getline (myfileSG, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecSG;
    split( SplitVecSG, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecSG.size() > 12 ) {
      if( SplitVecSG[1] != "#" ) {

	std::string MS_SG = SplitVecSG[1];
        _ms_sg = boost::lexical_cast<double>(MS_SG);
        
	std::string MG_SG = SplitVecSG[2];
        _mg_sg = boost::lexical_cast<double>(MG_SG);
        
	std::string LO_SG = SplitVecSG[3];
        _lo_sg = boost::lexical_cast<double>(LO_SG);
        
	std::string NLO_SG = SplitVecSG[4];
        _nlo_sg = boost::lexical_cast<double>(NLO_SG);
        
	std::string NLL_NLO_SG = SplitVecSG[5];
        _nll_nlo_sg = boost::lexical_cast<double>(NLL_NLO_SG);
        
	std::string D_MU_PLUS_SG = SplitVecSG[6];
        _d_mu_plus_sg = boost::lexical_cast<double>(D_MU_PLUS_SG);
        
	std::string D_MU_MINUS_SG = SplitVecSG[7];
        _d_mu_minus_sg = boost::lexical_cast<double>(D_MU_MINUS_SG);
        
	std::string D_PDF_PLUS_SG = SplitVecSG[8];
        _d_pdf_plus_sg = boost::lexical_cast<double>(D_PDF_PLUS_SG);
        
	std::string D_PDF_MINUS_SG = SplitVecSG[9];
        _d_pdf_minus_sg = boost::lexical_cast<double>(D_PDF_MINUS_SG);
        
	std::string D_AS_PLUS_SG = SplitVecSG[10];
        _d_as_plus_sg = boost::lexical_cast<double>(D_AS_PLUS_SG);
        
	std::string D_AS_MINUS_SG = SplitVecSG[11];
        _d_as_minus_sg = boost::lexical_cast<double>(D_AS_MINUS_SG);
        
	std::string K_NLO_SG = SplitVecSG[12];
        _k_nlo_sg = boost::lexical_cast<double>(K_NLO_SG);
        
	std::string K_NLL_SG = SplitVecSG[13];
        _k_nll_sg = boost::lexical_cast<double>(K_NLL_SG);
        
      }
    }
  }

  myfileSG.close();

}

  void Fittino::NLLFastCalculator::Initialize(){

  }
