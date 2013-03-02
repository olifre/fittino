{

  
  TString out_CHI2("$output_CHI2");
  gSystem->ExpandPathName(out_CHI2);

  TChain chain("markovChain");
  chain.Add((out_CHI2+"/XXOBS/XXINPUT.root").Data());
  




}
