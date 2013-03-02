{

  
  TString out_CHI2("$output_BPR");
  gSystem->ExpandPathName(out_CHI2);

  TChain chain("markovChain");
  chain.Add((out_CHI2+"/XXOBS/XXINPUT_final.root").Data());
  




}
