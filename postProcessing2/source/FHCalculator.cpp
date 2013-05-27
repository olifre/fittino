

#include "FHCalculator.h"
#include <sstream>
#include <fstream>
#include <iostream>


FHCalculator::FHCalculator(){

  _out=0;
  
  _couplings_row.push_back("g2hWW");
  _couplings_row.push_back("g2hZZ");
  _couplings_row.push_back("g2hgg");
  _couplings_row.push_back("g2hgaga");
  _couplings_row.push_back("g2hZga");
  _couplings_row.push_back("g2hggZ");
  _couplings_row.push_back("g2hbb_s");
  _couplings_row.push_back("g2hbb_p");
  _couplings_row.push_back("g2htautau_s");
  _couplings_row.push_back("g2htautau_p");
  _couplings_row.push_back("g2htoptop_s");
  _couplings_row.push_back("g2htoptop_p");
  _couplings_row.push_back("g2hss_s");
  _couplings_row.push_back("g2hss_p");
  _couplings_row.push_back("g2hmumu_s");
  _couplings_row.push_back("g2hmumu_p");
  _couplings_row.push_back("g2hcc_s");
  _couplings_row.push_back("g2hcc_p");

  _couplings_col.push_back("FHCoup");
  _couplings_col.push_back("GammaNorm");
  _couplings_col.push_back("SMGamma");
  _couplings_col.push_back("SMg2val");

  _rates1_row.push_back("G(h->n1n1)");
  _rates1_row.push_back("ggh2");
  _rates1_row.push_back("StSth");
  _rates1_row.push_back("tHmFH");
  
  _rates1_col.push_back("Model");

  _rates2_row.push_back("GTot");
  _rates2_row.push_back("ggh");
  _rates2_row.push_back("bbh");
  _rates2_row.push_back("btagbh");
  _rates2_row.push_back("qqh");
  _rates2_row.push_back("Wh");
  _rates2_row.push_back("Zh");
  _rates2_row.push_back("tth");

  _rates2_col.push_back("Model");
  _rates2_col.push_back("SM");


  

}

FHCalculator::~FHCalculator(){


}

void FHCalculator::SetOutput(FloatStorage* out){

  _out = out;

  Add(_couplings_row, _couplings_col,  "FH_U");
  Add(_rates1_row, _rates1_col,  "FH_U");
  Add(_rates2_row, _rates2_col,  "FH_U");
  Add(_couplings_row, _couplings_col,  "FH_Z");
  Add(_rates1_row, _rates1_col,  "FH_Z");
  Add(_rates2_row, _rates2_col,  "FH_Z");

  _out->Add("FH_success");
  _out->Add("FH_massh0");
  _out->Add("FH_massH0");
  _out->Add("FH_massA0");
  _out->Add("FH_massHp");

  _out->Add("FH_DeltaRho");
  _out->Add("FH_MWMSSM");
  _out->Add("FH_MWSM");
  _out->Add("FH_SW2effMSSM");
  _out->Add("FH_SW2effSM");
  _out->Add("FH_gminus2mu");
  _out->Add("FH_EDMeTh");
  _out->Add("FH_EDMn");
  _out->Add("FH_EDMHg");
  _out->Add("FH_bsgammaMSSM");
  _out->Add("FH_bsgammaSM");
  _out->Add("FH_DeltaMsMSSM");
  _out->Add("FH_DeltaMsSM");
  _out->Add("FH_BsmumuMSSM");
  _out->Add("FH_BsmumuSM");

  _out->Add("FH_stopmix_1_1");
  _out->Add("FH_stopmix_1_2");
  _out->Add("FH_stopmix_2_1");
  _out->Add("FH_stopmix_2_2");

  _out->Add("FH_staumix_1_1");
  _out->Add("FH_staumix_1_2");
  _out->Add("FH_staumix_2_1");
  _out->Add("FH_staumix_2_2");

  _out->Add("FH_alpha");
  _out->Add("FH_dalpha");

  


}


void FHCalculator::Add(const std::vector<std::string>& row, const std::vector<std::string>& col, std::string tag){

  for (unsigned int i=0; i<row.size(); i++){

    for (unsigned int j=0; j<col.size(); j++){

      _out->Add(tag+"_"+row[i]+"_"+col[j]);

    }

  }

}

void FHCalculator::Fill(const std::vector<std::string>& row, const std::vector<std::string>& col, std::string tag){

  for (unsigned int i=0; i<row.size(); i++){

    for (unsigned int j=0; j<col.size(); j++){
    
      _out->Set(tag+"_"+row[i]+"_"+col[j], _coll.at("").at(row[i]).at(j+1));

    }

  }

}

int FHCalculator::ReadCouplingsFile(std::string fileName, std::string tag){

  std::ifstream inFile(fileName.c_str());

  
  if (!inFile){
    std::cout<<"cant open "<<fileName<<std::endl;
  
    return 1;
  }

  _coll.read(inFile);

  inFile.close();
  
  Fill(_couplings_row, _couplings_col, tag);
  Fill(_rates1_row, _rates1_col, tag);
  Fill(_rates2_row, _rates2_col, tag);
  
  _coll.clear();

  return 0;


}


int FHCalculator::ReadSLHAFile(std::string fileName){


  std::ifstream inFile(fileName.c_str());
  
  if (!inFile){
    std::cout<<"cant open "<<fileName<<std::endl;

   return 1;
  }

  _coll.read(inFile);

  inFile.close();

  _out->Set("FH_massh0", _coll.at("MASS").at("25").at(1));
  _out->Set("FH_massH0", _coll.at("MASS").at("35").at(1));
  _out->Set("FH_massA0", _coll.at("MASS").at("36").at(1));
  _out->Set("FH_massHp", _coll.at("MASS").at("37").at(1));
  
  _out->Set("FH_DeltaRho", _coll.at("PRECOBS").at("1").at(1));
  _out->Set("FH_MWMSSM", _coll.at("PRECOBS").at("2").at(1));
  _out->Set("FH_MWSM", _coll.at("PRECOBS").at("3").at(1));
  _out->Set("FH_SW2effMSSM", _coll.at("PRECOBS").at("4").at(1));
  _out->Set("FH_SW2effSM", _coll.at("PRECOBS").at("5").at(1));
  _out->Set("FH_gminus2mu", _coll.at("PRECOBS").at("11").at(1));
  _out->Set("FH_EDMeTh", _coll.at("PRECOBS").at("21").at(1));
  _out->Set("FH_EDMn", _coll.at("PRECOBS").at("22").at(1));
  _out->Set("FH_EDMHg", _coll.at("PRECOBS").at("23").at(1));
  _out->Set("FH_bsgammaMSSM", _coll.at("PRECOBS").at("31").at(1));
  _out->Set("FH_bsgammaSM", _coll.at("PRECOBS").at("32").at(1));
  _out->Set("FH_DeltaMsMSSM", _coll.at("PRECOBS").at("33").at(1));
  _out->Set("FH_DeltaMsSM", _coll.at("PRECOBS").at("34").at(1));
  _out->Set("FH_BsmumuMSSM", _coll.at("PRECOBS").at("35").at(1));
  _out->Set("FH_BsmumuSM", _coll.at("PRECOBS").at("36").at(1));

  
  _out->Set("FH_stopmix_1_1", _coll.at("STOPMIX").at("1", "1").at(2));
  _out->Set("FH_stopmix_1_2", _coll.at("STOPMIX").at("1", "2").at(2));
  _out->Set("FH_stopmix_2_1", _coll.at("STOPMIX").at("2", "1").at(2));
  _out->Set("FH_stopmix_2_2", _coll.at("STOPMIX").at("2", "2").at(2));

  _out->Set("FH_staumix_1_1", _coll.at("STAUMIX").at("1", "1").at(2));
  _out->Set("FH_staumix_1_2", _coll.at("STAUMIX").at("1", "2").at(2));
  _out->Set("FH_staumix_2_1", _coll.at("STAUMIX").at("2", "1").at(2));
  _out->Set("FH_staumix_2_2", _coll.at("STAUMIX").at("2", "2").at(2));

  

  

  SLHAea::Block::const_iterator line = _coll["ALPHA"].begin()+1;
  _out->Set("FH_alpha", line->at(0));
  line = _coll["DALPHA"].begin()+1;
  _out->Set("FH_dalpha", line->at(0));
  
  _coll.clear();

  return 0;
  
}





int FHCalculator::Calculate(){

  _out->Set("FH_success", 0);

  system("mv effectivecouplings_UHiggs.dat.last effectivecouplings_UHiggs.dat.last2");
  system("mv effectivecouplings_ZHiggs.dat.last effectivecouplings_ZHiggs.dat.last2");
  system("mv SPheno.spc.fh.last SPheno.spc.fh.last2");

  system("mv effectivecouplings_UHiggs.dat effectivecouplings_UHiggs.dat.last");
  system("mv effectivecouplings_ZHiggs.dat effectivecouplings_ZHiggs.dat.last");
  system("mv SPheno.spc.fh SPheno.spc.fh.last");

  int rc=0;

  rc=system("./FHeffC > /dev/null 2>&1");
  if (rc) return rc;

  rc=ReadCouplingsFile("effectivecouplings_UHiggs.dat", "FH_U");
  if (rc) return rc;

  rc=ReadCouplingsFile("effectivecouplings_ZHiggs.dat", "FH_Z");
  if (rc) return rc;

  rc=ReadSLHAFile("SPheno.spc.fh");
  if (rc) return rc;

  _out->Set("FH_success", 1);
  return 0;
  

}


  





