
//This very simple macro hopefully helps to create TCutG objects with the graphics editor. 
//Start root and load the root file with the NTuple you want to skim, e.g.: root -l MarkovChainNtupfile.root
//Load this file: .L CreateCutObject.C
//Draw the variables you want use for skimming, e.g. markovChain->Draw("chi2:P_M0", "chi2<35")
//In the canvas, click on View->ToolBar. Select the graphical cut tool on the right hand side.
//One short mouse click determines the first point of the polygon.
//Successive further mouse clicks determine the edges of the polygon.
//For the last edge double click, then the polygon will automatically be closed.
//Use this function to save the cut you have just drawn in a root file, e.g.: CreateCutObject("AllObs2010Cuts.root", "M0Cut")
//Go on with the next variable: markovChain->Draw("chi2:P_M12", "chi2<35")...


void CreateCutObject(string cutfile, string cutname){

  TCutG *mycutg;                                                                                                                                                                                  

  mycutg = (TCutG*)gROOT->GetListOfSpecials()->FindObject("CUTG");

  mycutg->SetName(cutname.c_str());

  TFile f(cutfile.c_str(), "update");

  mycutg->Write(); 

  f.Close();

  _file0->cd();

}
