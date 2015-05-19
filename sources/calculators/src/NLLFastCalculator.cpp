#include <iostream>
#include <string>
#include <boost/lexical_cast.hpp>
#include <fstream>
#include <boost/algorithm/string.hpp>
#include <math.h>

#include "ModelBase.h"
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

  AddOutput( "ms_st1", _ms_st1 );
  AddOutput( "lo_st1", _lo_st1 );
  AddOutput( "nlo_st1", _nlo_st1 );
  AddOutput( "nll_nlo_st1", _nll_nlo_st1 );
  AddOutput( "d_mu_plus_st1", _d_mu_plus_st1 );
  AddOutput( "d_mu_minus_st1", _d_mu_minus_st1 );
  AddOutput( "d_pdf_plus_st1", _d_pdf_plus_st1 );
  AddOutput( "d_pdf_minus_st1", _d_pdf_minus_st1 );
  AddOutput( "d_as_plus_st1", _d_as_plus_st1 );
  AddOutput( "d_as_minus_st1", _d_as_minus_st1 );
  AddOutput( "k_nlo_st1", _k_nlo_st1 );
  AddOutput( "k_nll_st1", _k_nll_st1 );

  AddOutput( "ms_st2", _ms_st2 );
  AddOutput( "lo_st2", _lo_st2 );
  AddOutput( "nlo_st2", _nlo_st2 );
  AddOutput( "nll_nlo_st2", _nll_nlo_st2 );
  AddOutput( "d_mu_plus_st2", _d_mu_plus_st2 );
  AddOutput( "d_mu_minus_st2", _d_mu_minus_st2 );
  AddOutput( "d_pdf_plus_st2", _d_pdf_plus_st2 );
  AddOutput( "d_pdf_minus_st2", _d_pdf_minus_st2 );
  AddOutput( "d_as_plus_st2", _d_as_plus_st2 );
  AddOutput( "d_as_minus_st2", _d_as_minus_st2 );
  AddOutput( "k_nlo_st2", _k_nlo_st2 );
  AddOutput( "k_nll_st2", _k_nll_st2 );

  AddOutput( "ms_sb1", _ms_sb1 );
  AddOutput( "lo_sb1", _lo_sb1 );
  AddOutput( "nlo_sb1", _nlo_sb1 );
  AddOutput( "nll_nlo_sb1", _nll_nlo_sb1 );
  AddOutput( "d_mu_plus_sb1", _d_mu_plus_sb1 );
  AddOutput( "d_mu_minus_sb1", _d_mu_minus_sb1 );
  AddOutput( "d_pdf_plus_sb1", _d_pdf_plus_sb1 );
  AddOutput( "d_pdf_minus_sb1", _d_pdf_minus_sb1 );
  AddOutput( "d_as_plus_sb1", _d_as_plus_sb1 );
  AddOutput( "d_as_minus_sb1", _d_as_minus_sb1 );
  AddOutput( "k_nlo_sb1", _k_nlo_sb1 );
  AddOutput( "k_nll_sb1", _k_nll_sb1 );

  AddOutput( "ms_sb2", _ms_sb2 );
  AddOutput( "lo_sb2", _lo_sb2 );
  AddOutput( "nlo_sb2", _nlo_sb2 );
  AddOutput( "nll_nlo_sb2", _nll_nlo_sb2 );
  AddOutput( "d_mu_plus_sb2", _d_mu_plus_sb2 );
  AddOutput( "d_mu_minus_sb2", _d_mu_minus_sb2 );
  AddOutput( "d_pdf_plus_sb2", _d_pdf_plus_sb2 );
  AddOutput( "d_pdf_minus_sb2", _d_pdf_minus_sb2 );
  AddOutput( "d_as_plus_sb2", _d_as_plus_sb2 );
  AddOutput( "d_as_minus_sb2", _d_as_minus_sb2 );
  AddOutput( "k_nlo_sb2", _k_nlo_sb2 );
  AddOutput( "k_nll_sb2", _k_nll_sb2 );

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

  double G = _model->GetCollectionOfQuantities().At("SPheno_Mass_~g")->GetValue();
  std::string g;
  g = boost::lexical_cast<std::string>(G);
  std::cout << "SPheno_Mass_~g: " << g << std::endl;

  double T1 = _model->GetCollectionOfQuantities().At("SPheno_Mass_~t1")->GetValue();
  std::string t1;
  t1 = boost::lexical_cast<std::string>(T1);
  std::cout << "SPheno_Mass_~t1: " << t1 << std::endl;

  double T2 = _model->GetCollectionOfQuantities().At("SPheno_Mass_~t2")->GetValue();
  std::string t2;
  t2 = boost::lexical_cast<std::string>(T2);
  std::cout << "SPheno_Mass_~t2: " << t2 << std::endl;

  double B1 = _model->GetCollectionOfQuantities().At("SPheno_Mass_~b1")->GetValue();
  std::string b1;
  b1 = boost::lexical_cast<std::string>(B1);
  std::cout << "SPheno_Mass_~b1: " << b1 << std::endl;

  double B2 = _model->GetCollectionOfQuantities().At("SPheno_Mass_~b2")->GetValue();
  std::string b2;
  b2 = boost::lexical_cast<std::string>(B2);
  std::cout << "SPheno_Mass_~b2: " << b2 << std::endl;

  double CR = _model->GetCollectionOfQuantities().At("SPheno_Mass_~cR")->GetValue();
  std::string cR;
  cR = boost::lexical_cast<std::string>(CR);
  std::cout << "SPheno_Mass_~cR: " << cR << std::endl;

  double CL = _model->GetCollectionOfQuantities().At("SPheno_Mass_~cL")->GetValue();
  std::string cL;
  cL = boost::lexical_cast<std::string>(CL);
  std::cout << "SPheno_Mass_~cL: " << cL << std::endl;

  double SR = _model->GetCollectionOfQuantities().At("SPheno_Mass_~sR")->GetValue();
  std::string sR;
  sR = boost::lexical_cast<std::string>(SR);
  std::cout << "SPheno_Mass_~sR: " << sR << std::endl;

  double SL = _model->GetCollectionOfQuantities().At("SPheno_Mass_~sL")->GetValue();
  std::string sL;
  sL = boost::lexical_cast<std::string>(SL);
  std::cout << "SPheno_Mass_~sL: " << sL << std::endl;

  double DR = _model->GetCollectionOfQuantities().At("SPheno_Mass_~dR")->GetValue();
  std::string dR;
  dR = boost::lexical_cast<std::string>(DR);
  std::cout << "SPheno_Mass_~dR: " << dR << std::endl;

  double DL = _model->GetCollectionOfQuantities().At("SPheno_Mass_~dL")->GetValue();
  std::string dL;
  dL = boost::lexical_cast<std::string>(DL);
  std::cout << "SPheno_Mass_~dL: " << dL << std::endl;

  double UR = _model->GetCollectionOfQuantities().At("SPheno_Mass_~uR")->GetValue();
  std::string uR;
  uR = boost::lexical_cast<std::string>(UR);
  std::cout << "SPheno_Mass_~uR: " << uR << std::endl;

  double UL = _model->GetCollectionOfQuantities().At("SPheno_Mass_~uL")->GetValue();
  std::string uL;
  uL = boost::lexical_cast<std::string>(UL);
  std::cout << "SPheno_Mass_~uL: " << uL << std::endl;

  double SQUARK = ((B1 + B2 + CR + CL + SR + SL + DR + DL + UR +UL) / 10);
  std::string squark;
  squark = boost::lexical_cast<std::string>(SQUARK);
  std::cout << "squark_Mass: " << squark << std::endl;

  Executor executorGG("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_gg");
  executorGG.AddArgument("gg");
  executorGG.AddArgument("cteq");
  executorGG.AddArgument( squark );
  executorGG.AddArgument( g );
  executorGG.Execute();

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


  Executor executorSB("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sb");
  executorSB.AddArgument("sb");
  executorSB.AddArgument("cteq");
  executorSB.AddArgument( squark );
  executorSB.AddArgument( g );
  executorSB.Execute();

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
 
  Executor executorST1("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_st1");
  executorST1.AddArgument("st");
  executorST1.AddArgument("cteq");
  executorST1.AddArgument( t1 );
  executorST1.Execute();

  std::fstream myfileST1;

  myfileST1.open("/lustre/user/range/fittino/bin/st.out");

  while( getline (myfileST1, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecST1;
    split( SplitVecST1, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecST1.size() > 12 ) {
      if( SplitVecST1[1] != "#" ) {

	std::string MS_ST1 = SplitVecST1[1];
        _ms_st1 = boost::lexical_cast<double>(MS_ST1);

	std::string LO_ST1 = SplitVecST1[2];
        _lo_st1 = boost::lexical_cast<double>(LO_ST1);

	std::string NLO_ST1 = SplitVecST1[3];
        _nlo_st1 = boost::lexical_cast<double>(NLO_ST1);

	std::string NLL_NLO_ST1 = SplitVecST1[4];
        _nll_nlo_st1 = boost::lexical_cast<double>(NLL_NLO_ST1);

	std::string D_MU_PLUS_ST1 = SplitVecST1[5];
        _d_mu_plus_st1 = boost::lexical_cast<double>(D_MU_PLUS_ST1);

	std::string D_MU_MINUS_ST1 = SplitVecST1[6];
        _d_mu_minus_st1 = boost::lexical_cast<double>(D_MU_MINUS_ST1);

	std::string D_PDF_PLUS_ST1 = SplitVecST1[7];
        _d_pdf_plus_st1 = boost::lexical_cast<double>(D_PDF_PLUS_ST1);

	std::string D_PDF_MINUS_ST1 = SplitVecST1[8];
        _d_pdf_minus_st1 = boost::lexical_cast<double>(D_PDF_MINUS_ST1);

	std::string D_AS_PLUS_ST1 = SplitVecST1[9];
	_d_as_plus_st1 = boost::lexical_cast<double>(D_AS_PLUS_ST1);

	std::string D_AS_MINUS_ST1 = SplitVecST1[10];
        _d_as_minus_st1 = boost::lexical_cast<double>(D_AS_MINUS_ST1);

	std::string K_NLO_ST1 = SplitVecST1[11];
        _k_nlo_st1 = boost::lexical_cast<double>(K_NLO_ST1);

	std::string K_NLL_ST1 = SplitVecST1[12];
        _k_nll_st1 = boost::lexical_cast<double>(K_NLL_ST1);

      }
    }
  }
  myfileST1.close();


  Executor executorST2("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_st2");
  executorST2.AddArgument("st");
  executorST2.AddArgument("cteq");
  executorST2.AddArgument( t2 );
  executorST2.Execute();

  std::fstream myfileST2;

  myfileST2.open("/lustre/user/range/fittino/bin/st.out");

  while( getline (myfileST2, line) ){

  typedef std::vector< std::string > split_vector_type;

  split_vector_type SplitVecST2;
  split( SplitVecST2, line, boost::is_any_of(" "), boost::token_compress_on);

  if( SplitVecST2.size() > 12 ) {
    if( SplitVecST2[1] != "#" ) {
  
  	std::string MS_ST2 = SplitVecST2[1];
	_ms_st2 = boost::lexical_cast<double>(MS_ST2);

  	std::string LO_ST2 = SplitVecST2[2];
	_lo_st2 = boost::lexical_cast<double>(LO_ST2);

  	std::string NLO_ST2 = SplitVecST2[3];
          _nlo_st2 = boost::lexical_cast<double>(NLO_ST2);

  	std::string NLL_NLO_ST2 = SplitVecST2[4];
	_nll_nlo_st2 = boost::lexical_cast<double>(NLL_NLO_ST2);

  	std::string D_MU_PLUS_ST2 = SplitVecST2[5];
	_d_mu_plus_st2 = boost::lexical_cast<double>(D_MU_PLUS_ST2);

  	std::string D_MU_MINUS_ST2 = SplitVecST2[6];
	_d_mu_minus_st2 = boost::lexical_cast<double>(D_MU_MINUS_ST2);
      
  	std::string D_PDF_PLUS_ST2 = SplitVecST2[7];
	_d_pdf_plus_st2 = boost::lexical_cast<double>(D_PDF_PLUS_ST2);
      
  	std::string D_PDF_MINUS_ST2 = SplitVecST2[8];
	_d_pdf_minus_st2 = boost::lexical_cast<double>(D_PDF_MINUS_ST2);
	
  	std::string D_AS_PLUS_ST2 = SplitVecST2[9];
  	_d_as_plus_st2 = boost::lexical_cast<double>(D_AS_PLUS_ST2);

  	std::string D_AS_MINUS_ST2 = SplitVecST2[10];
	_d_as_minus_st2 = boost::lexical_cast<double>(D_AS_MINUS_ST2);

  	std::string K_NLO_ST2 = SplitVecST2[11];
	_k_nlo_st2 = boost::lexical_cast<double>(K_NLO_ST2);

  	std::string K_NLL_ST2 = SplitVecST2[12];
	_k_nll_st2 = boost::lexical_cast<double>(K_NLL_ST2);

    }
  }
  }
  myfileST2.close();

  Executor executorSB1("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sb1");
  executorSB1.AddArgument("st");
  executorSB1.AddArgument("cteq");
  executorSB1.AddArgument( b1 );
  executorSB1.Execute();

  std::fstream myfileSB1;

  myfileSB1.open("/lustre/user/range/fittino/bin/st.out");

  while( getline (myfileSB1, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecSB1;
    split( SplitVecSB1, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecSB1.size() > 12 ) {
      if( SplitVecSB1[1] != "#" ) {

	std::string MS_SB1 = SplitVecSB1[1];
        _ms_sb1 = boost::lexical_cast<double>(MS_SB1);

	std::string LO_SB1 = SplitVecSB1[2];
        _lo_sb1 = boost::lexical_cast<double>(LO_SB1);

	std::string NLO_SB1 = SplitVecSB1[3];
        _nlo_sb1 = boost::lexical_cast<double>(NLO_SB1);

	std::string NLL_NLO_SB1 = SplitVecSB1[4];
        _nll_nlo_sb1 = boost::lexical_cast<double>(NLL_NLO_SB1);
	
	std::string D_MU_PLUS_SB1 = SplitVecSB1[5];
        _d_mu_plus_sb1 = boost::lexical_cast<double>(D_MU_PLUS_SB1);

	std::string D_MU_MINUS_SB1 = SplitVecSB1[6];
        _d_mu_minus_sb1 = boost::lexical_cast<double>(D_MU_MINUS_SB1);

	std::string D_PDF_PLUS_SB1 = SplitVecSB1[7];
        _d_pdf_plus_sb1 = boost::lexical_cast<double>(D_PDF_PLUS_SB1);

	std::string D_PDF_MINUS_SB1 = SplitVecSB1[8];
        _d_pdf_minus_sb1 = boost::lexical_cast<double>(D_PDF_MINUS_SB1);

	std::string D_AS_PLUS_SB1 = SplitVecSB1[9];
        _d_as_plus_sb1 = boost::lexical_cast<double>(D_AS_PLUS_SB1);

	std::string D_AS_MINUS_SB1 = SplitVecSB1[10];
        _d_as_minus_sb1 = boost::lexical_cast<double>(D_AS_MINUS_SB1);

	std::string K_NLO_SB1 = SplitVecSB1[11];
        _k_nlo_sb1 = boost::lexical_cast<double>(K_NLO_SB1);

	std::string K_NLL_SB1 = SplitVecSB1[12];
        _k_nll_sb1 = boost::lexical_cast<double>(K_NLL_SB1);

      }
    }
  }
  myfileSB1.close();

  Executor executorSB2("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sb2");
  executorSB2.AddArgument("st");
  executorSB2.AddArgument("cteq");
  executorSB2.AddArgument( b2 );
  executorSB2.Execute();

  std::fstream myfileSB2;

  myfileSB2.open("/lustre/user/range/fittino/bin/st.out");

  while( getline (myfileSB2, line) ){

    typedef std::vector< std::string > split_vector_type;

    split_vector_type SplitVecSB2;
    split( SplitVecSB2, line, boost::is_any_of(" "), boost::token_compress_on);

    if( SplitVecSB2.size() > 12 ) {
      if( SplitVecSB2[1] != "#" ) {

	std::string MS_SB2 = SplitVecSB2[1];
        _ms_sb2 = boost::lexical_cast<double>(MS_SB2);

	std::string LO_SB2 = SplitVecSB2[2];
        _lo_sb2 = boost::lexical_cast<double>(LO_SB2);

	std::string NLO_SB2 = SplitVecSB2[3];
        _nlo_sb2 = boost::lexical_cast<double>(NLO_SB2);
	
	std::string NLL_NLO_SB2 = SplitVecSB2[4];
        _nll_nlo_sb2 = boost::lexical_cast<double>(NLL_NLO_SB2);

	std::string D_MU_PLUS_SB2 = SplitVecSB2[5];
        _d_mu_plus_sb2 = boost::lexical_cast<double>(D_MU_PLUS_SB2);

	std::string D_MU_MINUS_SB2 = SplitVecSB2[6];
        _d_mu_minus_sb2 = boost::lexical_cast<double>(D_MU_MINUS_SB2);

	std::string D_PDF_PLUS_SB2 = SplitVecSB2[7];
        _d_pdf_plus_sb2 = boost::lexical_cast<double>(D_PDF_PLUS_SB2);

	std::string D_PDF_MINUS_SB2 = SplitVecSB2[8];
        _d_pdf_minus_sb2 = boost::lexical_cast<double>(D_PDF_MINUS_SB2);

	std::string D_AS_PLUS_SB2 = SplitVecSB2[9];
        _d_as_plus_sb2 = boost::lexical_cast<double>(D_AS_PLUS_SB2);

	std::string D_AS_MINUS_SB2 = SplitVecSB2[10];
        _d_as_minus_sb2 = boost::lexical_cast<double>(D_AS_MINUS_SB2);

	std::string K_NLO_SB2 = SplitVecSB2[11];
        _k_nlo_sb2 = boost::lexical_cast<double>(K_NLO_SB2);

	std::string K_NLL_SB2 = SplitVecSB2[12];
        _k_nll_sb2 = boost::lexical_cast<double>(K_NLL_SB2);

      }
    }
  }
  myfileSB2.close();

  Executor executorSS("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_ss");
  executorSS.AddArgument("ss");
  executorSS.AddArgument("cteq");
  executorSS.AddArgument( squark );
  executorSS.AddArgument( g );
  executorSS.Execute();

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

  Executor executorSG("/lustre/fittino/group/external/SL6/NLL-fast/NLL-fast-2.1/nllfast-2.1", "nllfast_sg");
  executorSG.AddArgument("sg");
  executorSG.AddArgument("cteq");
  executorSG.AddArgument( squark );
  executorSG.AddArgument( g );
  executorSG.Execute();

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
