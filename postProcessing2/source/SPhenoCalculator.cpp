

#include "SPhenoCalculator.h"

#include <fstream>
#include <sstream>
#include <iostream>
#include <string>
#include <limits>


SPhenoCalculator::SPhenoCalculator(){

  _out=0;

}


SPhenoCalculator::~SPhenoCalculator(){

}


void SPhenoCalculator::SetInput(FloatStorage* in){

  _in=in;


}

void SPhenoCalculator::SetOutput(FloatStorage* out){
  
  _out=out;
  _out->Add("SPheno_success");

  _out->Add("SPheno_stopmix_1_1");
  _out->Add("SPheno_stopmix_1_2");
  _out->Add("SPheno_stopmix_2_1");
  _out->Add("SPheno_stopmix_2_2");

  _out->Add("SPheno_staumix_1_1");
  _out->Add("SPheno_staumix_1_2");
  _out->Add("SPheno_staumix_2_1");
  _out->Add("SPheno_staumix_2_2");


  _out->Add("SPheno_alpha");
  _out->Add("SPheno_dalpha");

  _out->Add("SPheno_mu");
  _out->Add("SPheno_TanBeta");
  _out->Add("SPheno_v");
  _out->Add("SPheno_m2A");

  _out->Add("SPheno_m2Hd");
  _out->Add("SPheno_m2Hu");
  _out->Add("SPheno_mQ33");
  _out->Add("SPheno_mU33");
  _out->Add("SPheno_mD33");

  _out->Add("SPheno_At");
  _out->Add("SPheno_Ab");
  _out->Add("SPheno_Atau");

  _out->Add("SPheno_gamma_stau1");
  _out->Add("SPheno_gamma_stau2");

  _out->Add("SPheno_gamma_charg1");
  _out->Add("SPheno_gamma_charg2");

  _out->Add("SPheno_gamma_stop1");
  _out->Add("SPheno_gamma_stop2");

  _out->Add("SPheno_gamma_neut2");
  _out->Add("SPheno_gamma_neut3");
  _out->Add("SPheno_gamma_neut4");




}

int SPhenoCalculator::Calculate(){

  _out->Set("SPheno_success", 0);

  system("mv LesHouches.in.last LesHouches.in.last2");
  system("mv SPheno.spc.last SPheno.spc.last2");

  system("mv LesHouches.in LesHouches.in.last");
  system("mv SPheno.spc SPheno.spc.last");

  int rc=0;
  rc=WriteSLHA();
  
  if (rc) return rc;
  
  rc=system("./SPheno");

  if (rc) return rc;
  
  rc=ReadSLHA();

  if (rc) return rc;

  _out->Set("SPheno_success", 1);
  return 0;

}

int SPhenoCalculator::WriteSLHA(){

  fstream LesHouchesOutFile;
  LesHouchesOutFile.open ("LesHouches.in",ofstream::out);
  LesHouchesOutFile.setf(std::ios::scientific, std::ios::floatfield);

  if (!LesHouchesOutFile.is_open()) {
    std::cout<< "error opening LesHouches.in" << std::endl;
    return 1;
  }


  LesHouchesOutFile<<"BLOCK MODSEL                 # Select model"<<std::endl;
  LesHouchesOutFile<<"    1 1                      # mSugra"<<std::endl;
  LesHouchesOutFile<<"BLOCK SMINPUTS               # Standard Model inputs"<<std::endl;
  LesHouchesOutFile<<"    1 1.289520e+02 # 1/alpha_em (fixed)"<<std::endl;
  LesHouchesOutFile<<"    2  1.166379e-05 # G_F (fixed)"<<std::endl;
  LesHouchesOutFile<<"    3  1.184000e-01 # alpha_s (fixed)"<<std::endl;
  LesHouchesOutFile<<"    4  9.118760e+01 # mZ (fixed)"<<std::endl;
  LesHouchesOutFile<<"    5  4.180000e+00 # mb(mb) (fixed)"<<std::endl;

  //  LesHouchesOutFile<<"    6  1.737608e+02 # mtop"<<std::endl;
  LesHouchesOutFile<<"    6  "<<_in->Get("P_massTop")<<" # mtop"<<std::endl;

  LesHouchesOutFile<<"    7  1.776820e+00 # mtau (fixed)"<<std::endl;
  LesHouchesOutFile<<"    24  1.275000e+00 # mcharm (fixed)"<<std::endl;
  LesHouchesOutFile<<"   23  9.500000e-02 # m_s(2 GeV), MSbar"<<std::endl;
  LesHouchesOutFile<<"    13  1.056584e-01 # mmuon"<<std::endl;
  LesHouchesOutFile<<"BLOCK MINPAR                 # Input parameters"<<std::endl;

  //   LesHouchesOutFile<<"    3  1.602284e+01 # tanb"<<std::endl;
  //   LesHouchesOutFile<<"    1  2.061781e+02 # M0"<<std::endl;
  //   LesHouchesOutFile<<"    2  7.220545e+02 # M12"<<std::endl;
  //   LesHouchesOutFile<<"    5  -1.616255e+02 # A0"<<std::endl;
  LesHouchesOutFile<<"    3  "<<_in->Get("P_TanBeta")<<" # tanb"<<std::endl;
  LesHouchesOutFile<<"    1  "<<_in->Get("P_M0")<<" # M0"<<std::endl;
  LesHouchesOutFile<<"    2  "<<_in->Get("P_M12")<<" # M12"<<std::endl;
  LesHouchesOutFile<<"    5  "<<_in->Get("P_A0")<<" # A0"<<std::endl;
  
  LesHouchesOutFile<<"    4  1.000000e+00 # sign(mu) (fixed)"<<std::endl;
  LesHouchesOutFile<<"BLOCK EXTPAR                 # Input parameters"<<std::endl;
  LesHouchesOutFile<<"BLOCK SPHENOINPUT"<<std::endl;
  LesHouchesOutFile<<"    1  0                  # error level"<<std::endl;
  LesHouchesOutFile<<"    2  0                  # if 1, then SPA conventions are used"<<std::endl;
  LesHouchesOutFile<<"   11  1                  # calculate branching ratios"<<std::endl;
  LesHouchesOutFile<<"   12  1.00000000E-04     # write only branching ratios larger than this value"<<std::endl;
  LesHouchesOutFile<<"   21  0                  # calculate cross section"<<std::endl;
  LesHouchesOutFile<<"   22  1.000000e+03     # cms energy in GeV"<<std::endl;
  LesHouchesOutFile<<"   23  0.000000e+00     # polarisation of incoming e- beam"<<std::endl;
  LesHouchesOutFile<<"   24  0.000000e+00     # polarisation of incoming e+ beam"<<std::endl;
  LesHouchesOutFile<<"   25  1                  # ISR is calculated"<<std::endl;
  LesHouchesOutFile<<"   26  1.00000000E-05     # write only cross sections larger than this value [fb]"<<std::endl;
  LesHouchesOutFile<<"   31  -1.00000000E+00     # m_GUT, if < 0 than it determined via g_1=g_2"<<std::endl;
  LesHouchesOutFile<<"   32  0                  # require strict unification g_1=g_2=g_3 if '1' is set"<<std::endl;
  LesHouchesOutFile<<"   80  1     # SPheno Exit with non-zero-value for sure!!"<<std::endl;
 
  LesHouchesOutFile.close();
  return 0;

}


int SPhenoCalculator::ReadSLHA(){

  std::ifstream inFile("SPheno.spc");

  
  if (!inFile){
    std::cout<<"cant open SPheno.spc"<<std::endl;
  
    return 1;
  }

  _coll.read(inFile);

  inFile.close();


  _out->Set("SPheno_stopmix_1_1", _coll.at("stopmix").at("1", "1").at(2));
  _out->Set("SPheno_stopmix_1_2", _coll.at("stopmix").at("1", "2").at(2));
  _out->Set("SPheno_stopmix_2_1", _coll.at("stopmix").at("2", "1").at(2));
  _out->Set("SPheno_stopmix_2_2", _coll.at("stopmix").at("2", "2").at(2));

  _out->Set("SPheno_staumix_1_1", _coll.at("staumix").at("1", "1").at(2));
  _out->Set("SPheno_staumix_1_2", _coll.at("staumix").at("1", "2").at(2));
  _out->Set("SPheno_staumix_2_1", _coll.at("staumix").at("2", "1").at(2));
  _out->Set("SPheno_staumix_2_2", _coll.at("staumix").at("2", "2").at(2));
  

  SLHAea::Block::const_iterator line = _coll.at("alpha").begin()+1;
  _out->Set("SPheno_alpha", line->at(0));

  _out->Set("SPheno_mu", _coll.at("Hmix").at("1").at(1));
  _out->Set("SPheno_TanBeta", _coll.at("Hmix").at("2").at(1));
  _out->Set("SPheno_v", _coll.at("Hmix").at("3").at(1));
  _out->Set("SPheno_m2A", _coll.at("Hmix").at("4").at(1));

  _out->Set("SPheno_m2Hd", _coll.at("MSOFT").at("21").at(1));
  _out->Set("SPheno_m2Hu", _coll.at("MSOFT").at("22").at(1));
  _out->Set("SPheno_mQ33", _coll.at("MSOFT").at("43").at(1));
  _out->Set("SPheno_mU33", _coll.at("MSOFT").at("46").at(1));
  _out->Set("SPheno_mD33", _coll.at("MSOFT").at("49").at(1));

  _out->Set("SPheno_At", _coll.at("Au").at("3", "3").at(2));
  _out->Set("SPheno_Ab", _coll.at("Ad").at("3", "3").at(2));
  _out->Set("SPheno_Atau", _coll.at("Ae").at("3", "3").at(2));

  _out->Set("SPheno_gamma_stau1", _coll.at("1000015").at("DECAY").at(2));
  _out->Set("SPheno_gamma_stau2", _coll.at("2000015").at("DECAY").at(2));

  _out->Set("SPheno_gamma_charg1", _coll.at("1000024").at("DECAY").at(2));
  _out->Set("SPheno_gamma_charg2", _coll.at("1000037").at("DECAY").at(2));

  _out->Set("SPheno_gamma_stop1",  _coll.at("1000006").at("DECAY").at(2));
  _out->Set("SPheno_gamma_stop2",  _coll.at("2000006").at("DECAY").at(2));

  _out->Set("SPheno_gamma_neut2",  _coll.at("1000023").at("DECAY").at(2));
  _out->Set("SPheno_gamma_neut3",  _coll.at("1000025").at("DECAY").at(2));
  _out->Set("SPheno_gamma_neut4",  _coll.at("1000035").at("DECAY").at(2));

  
  
  _coll.clear();


  return 0;

}

