
// This ROOT macro plots the markov chains produced by Fittino 
// in the projections of the CMSSM high-scale parameters. 
// The asymed statistics is bayesian. Shame on me. An alternative 
// frequentist interpretation will follow soon. 

#include "TStyle.h"
#include "TROOT.h"
#include "TLegend.h"
#include "TFile.h"
#include "TMath.h"
#include "TDirectory.h"
#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TObjArray.h"
#include "TImage.h"
#include "iostream"
#include "fstream"
#include "string"
#include "vector"
using namespace std;

void Plot2SigmaMarkovContours (const string model = "CMSSM",
			       const bool   doAlsoSM = false,
			       const int    drawCross = 0,
			       const string logoPath = "",
			       const string nameTag = "",
			       const string file1="file1",
			       const string fileTag1="Tag1",
			       const string file2="file2",
			       const string fileTag2="Tag2",
			       const string file3="file3",
			       const string fileTag3="Tag3",
			       const string file4="file4",
			       const string fileTag4="Tag4",
			       const string file5="file5",
			       const string fileTag5="Tag5",
			       const string file6="file6",
			       const string fileTag6="Tag6",
			       float M12_up = -1,
			       float M12_down = -1,
			       float M0_up = -1,
			       float M0_down = -1,
			       float A0_up = -1,
			       float A0_down = -1,
			       float TanBeta_up = -1,
			       float TanBeta_down = -1,
			       float leg1 = 0.58,
			       float leg2 = 0.84,
			       float leg3 = 0.96,
			       float leg4 = 0.99 )
{
  
  // setups
  //gROOT->SetStyle("Plain");
  gStyle->SetPalette(1);
  gStyle->SetOptStat(0);
  gStyle->SetFrameFillColor(10);
  gStyle->SetPadColor(10);
  gStyle->SetCanvasColor(10); // light grey: 18


  gStyle->SetTextFont(62);
  gStyle->SetTextSize(0.06); 


  TCanvas* canvas = new TCanvas();
  canvas->SetBorderMode(0);
  canvas->SetTopMargin(0.06);
  canvas->SetBottomMargin(0.15);
  //canvas->SetBottomMargin(0.12);
  canvas->SetLeftMargin(0.15);
  //canvas->SetLeftMargin(0.10);
  if( model == "NONUNIVSIMPLIFIED" ) canvas->SetRightMargin(0.10);
  else canvas->SetRightMargin(0.05);

  bool doublelogplot = false;
  
  // sort files
  vector<string> fileNames;
  vector<string> fileNameTags;
  for (int i = 0; i < 6; i++) {
    string thisFile;
    if (i==0 && file1!="file1") {
      fileNames.push_back(file1);
      fileNameTags.push_back(fileTag1);
    }
    if (i==1 && file2!="file2") { 
      fileNames.push_back(file2);
      fileNameTags.push_back(fileTag2);
    }
    if (i==2 && file3!="file3") { 
      fileNames.push_back(file3);
      fileNameTags.push_back(fileTag3);
    }
    if (i==3 && file4!="file4") { 
      fileNames.push_back(file4);
      fileNameTags.push_back(fileTag4);
    }
    if (i==4 && file5!="file5") { 
      fileNames.push_back(file5);
      fileNameTags.push_back(fileTag5);
    }
    if (i==5 && file6!="file6") { 
      fileNames.push_back(file6);
      fileNameTags.push_back(fileTag6);
    }
  }
  const int nFiles = fileNames.size();

  // set colors and line styles
  vector<int> colors1a;
  vector<int> colors1b;
  vector<int> colors2a;
  vector<int> colors2b;
  vector<int> styles;
  vector<int> fstyles;
  for (int i = 0; i < nFiles; i++) {
    styles.push_back(i+1);
    //    fstyles.push_back(i+3001);
    fstyles.push_back(1001);
    colors2a.push_back(kBlue-10+i);
    colors1a.push_back(kRed-8+i);
    colors2b.push_back(kBlue-2+i);
    colors1b.push_back(kRed-2+i);
  }  

  // open files
  TFile* files[nFiles];
  for (int i = 0; i < nFiles; i++) {
    files[i] = new TFile(fileNames[i].c_str(),"READ");
    if (!files[i]) {
      cout << "file " << fileNames[i] << " not found" << endl;
      return;
    }
  }  
  
  // define model
  vector<string> variables;
  vector<string> variableNames;
  if (model == "CMSSM") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12");
    variables.push_back("P_M0");
    variables.push_back("P_A0");
    variables.push_back("P_massTop");
    variableNames.push_back("tan#beta");
    variableNames.push_back("M_{1/2} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("m(top) (GeV)");
  } 
  else if( model == "NUHM1" ){
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12");
    variables.push_back("P_M0");
    variables.push_back("P_A0");
    variables.push_back("P_M0H");
    variables.push_back("P_massTop");
    variableNames.push_back("tan#beta");
    variableNames.push_back("M_{1/2} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("M_{0,H} (GeV)");
    variableNames.push_back("m(top) (GeV)");
  }
  else if( model == "NUHM2" ){
    variables.push_back("P_TanBeta");
    variables.push_back("P_A0");
    variables.push_back("P_M12");
    variables.push_back("P_M0");
    variables.push_back("P_M0Hu");
    variables.push_back("P_M0Hd");
    variables.push_back("P_massTop");
    variableNames.push_back("tan#beta");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("M_{1/2} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("M_{0,Hu} (GeV)");
    variableNames.push_back("M_{0,Hd} (GeV)");
    variableNames.push_back("m(top) (GeV)");
  }

  else if (model=="CMSSMmassTop") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_M12");
    variables.push_back("P_M0");
    variables.push_back("P_A0");
    variables.push_back("P_massTop");
    variableNames.push_back("tan#beta");
    variableNames.push_back("M_{12} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("m(top) (GeV)");
  }
  else if (model == "GMSB") {
    variables.push_back("P_TanBeta");
    variables.push_back("P_Lambda"); 
    variables.push_back("P_Mmess");
    variables.push_back("P_cGrav");
    variableNames.push_back("tan#beta");
    variableNames.push_back("#Lambda (GeV)");
    variableNames.push_back("M_{mess} (GeV)");
    variableNames.push_back("C_{grav} (GeV)");
  }
  else if (model=="Pheno") {
    variables.push_back("af_direct");
    variables.push_back("O_massNeutralino1_nofit");
    variables.push_back("O_Omega_npf"); 
    variables.push_back("O_massStau1_nofit"); 
    variables.push_back("O_Omega_npf_nofit"); 
    variableNames.push_back("#sigma_{SI} (pb)");
    variableNames.push_back("m_{#chi^{0}_{1}} (GeV)");
    variableNames.push_back("#Omega h^{2}");
    variableNames.push_back("m_{#tilde{#tau}_{1}} (GeV)");
    variableNames.push_back("#Omega h^{2}");
  }
  else if( model == "XMSUGRA" ){
    // XMSUGRA
    variables.push_back("P_M0");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_A0");
    variables.push_back("P_TanBeta");
    variableNames.push_back("M_{0} (GeV)");
    variableNames.push_back("M_{1} (GeV)");
    variableNames.push_back("M_{2} (GeV)");
    variableNames.push_back("M_{3} (GeV)");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("tan#beta");
  }
  else if( model == "NONUNIVSIMPLIFIED" ){
    // NONUNIVSIMPLIFIED
    variables.push_back("P_TanBeta");
    variables.push_back("P_A0");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_M0H");
    variables.push_back("P_M05");
    variables.push_back("P_M010");
    variableNames.push_back("tan#beta");
    variableNames.push_back("A_{0} (GeV)");
    variableNames.push_back("M_{1/2} (GeV)");
    //variableNames.push_back("M_{1} (GeV)");
    variableNames.push_back("M_{2} (GeV)");
    variableNames.push_back("M_{3} (GeV)");
    variableNames.push_back("M_{H}^{2} (GeV)");
    //variableNames.push_back("M_{0,H} (GeV)");
    variableNames.push_back("M_{0} (GeV)");
    //variableNames.push_back("M_{0,5} (GeV)");
    variableNames.push_back("M_{0,10} (GeV)");
  }
  else if (model == "MSSM18") {
    variables.push_back("P_MSelectronL");
    variables.push_back("P_MSelectronR");
    variables.push_back("P_MStauL");
    variables.push_back("P_MStauR");
    variables.push_back("P_MSupL");
    variables.push_back("P_MSupR");
    variables.push_back("P_MSbottomR");
    variables.push_back("P_MStopL");
    variables.push_back("P_MStopR");
    variables.push_back("P_TanBeta");
    variables.push_back("P_Mu");
    variables.push_back("P_Xtau");
    variables.push_back("P_Xtop");
    variables.push_back("P_Xbottom");
    variables.push_back("P_M1");
    variables.push_back("P_M2");
    variables.push_back("P_M3");
    variables.push_back("P_massA0");
    variableNames.push_back("M_{#tilde{e}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{e}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{#tau}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{#tau}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{u}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{u}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{b}_{R}} (GeV)");
    variableNames.push_back("M_{#tilde{t}_{L}} (GeV)");
    variableNames.push_back("M_{#tilde{t}_{R}} (GeV)");
    variableNames.push_back("tan#beta");
    variableNames.push_back("#mu (GeV)"); 
    variableNames.push_back("X_{#tau} (GeV)");
    variableNames.push_back("X_{t} (GeV)");
    variableNames.push_back("X_{b} (GeV)");
    variableNames.push_back("M_{1} (GeV)");
    variableNames.push_back("M_{2} (GeV)");
    variableNames.push_back("M_{3} (GeV)");
    variableNames.push_back("m_{A} (GeV)");
    //    variableNames.push_back("M_{#tilde{d}_{R}} (GeV)");
  } else {
    cout << "model " << model << " unknown" << endl; 
    return;
  }

  if (doAlsoSM) {
    variables.push_back("P_alphas");
    variables.push_back("P_alphaem");
    variables.push_back("P_massZ"); 
    variables.push_back("P_massTop");
    variables.push_back("P_G_F");    
    variableNames.push_back("#alpha_{s}");
    variableNames.push_back("#alpha_{em}");
    variableNames.push_back("m_{Z} (Gev)");
    variableNames.push_back("m_{t} (GeV)");
    variableNames.push_back("G_F (Gev^{-2})");
  }



  // assume for the time being that the first file contains the largest uncertainties
  for (unsigned int iVariable1 = 0; iVariable1 < variables.size(); iVariable1++) {
    for (unsigned int iVariable2 = iVariable1 +1; iVariable2 < variables.size(); iVariable2++) {


      if ( ( variables[iVariable1] == "O_massNeutralino1_nofit" &&
	     variables[iVariable1] == "af_direct" ) ||
	   ( variables[iVariable2] == "af_direct" &&
	     variables[iVariable2] == "O_massNeutralino1_nofit" ) ) {
	doublelogplot = true;
      }

      // draw the canvas      
      string histName = "emptyHist_" + variables[iVariable2] + "_" + variables[iVariable1];
      TH2D* hist = (TH2D*)files[0]->Get(histName.c_str());
      // TH2D* hist = new TH2D("test","",300,0.,300000.,80,0.,80.);
      if (!hist) {
	cout << "histogram " << histName << " not found" << endl;
	continue;
      }
      cout << "drawing histogram " << histName << endl;

      if( model == "NONUNIVSIMPLIFIED" )
	{	
	  if( M12_up != -1 ){
	    if( variables[iVariable1] == "P_M1" ) hist->GetYaxis()->SetLimits( M12_down, M12_up );
	    if( variables[iVariable2] == "P_M1" ) hist->GetXaxis()->SetLimits( M12_down, M12_up );
	  }
	  if( M0_up != -1 ){
	    if( variables[iVariable1] == "P_M0H" ) hist->GetYaxis()->SetLimits( M0_down, M0_up );
	    if( variables[iVariable2] == "P_M0H" ) hist->GetXaxis()->SetLimits( M0_down, M0_up );
	  }
	}
      
      if( model == "CMSSM" || model == "CMSSMmassTop")
	{
	  if( M12_up != -1 ){
	    if( variables[iVariable1] == "P_M12" ) hist->GetYaxis()->SetLimits( M12_down, M12_up );
	    if( variables[iVariable2] == "P_M12" ) hist->GetXaxis()->SetLimits( M12_down, M12_up );
	  }
	  if( M0_up != -1 ){
	    if( variables[iVariable1] == "P_M0" ) hist->GetYaxis()->SetLimits( M0_down, M0_up );
	    if( variables[iVariable2] == "P_M0" ) hist->GetXaxis()->SetLimits( M0_down, M0_up );
	  }
	}
      
      if( A0_up != -1 ){
	if( variables[iVariable1] == "P_A0" ) hist->GetYaxis()->SetLimits( A0_down, A0_up );
	if( variables[iVariable2] == "P_A0" ) hist->GetXaxis()->SetLimits( A0_down, A0_up );
      }
      if( TanBeta_up != -1 ){
        if( variables[iVariable1] == "P_TanBeta" ) hist->GetYaxis()->SetLimits( TanBeta_down, TanBeta_up );
        if( variables[iVariable2] == "P_TanBeta" ) hist->GetXaxis()->SetLimits( TanBeta_down, TanBeta_up );
      }

      
      TH2D* emptyHist = 0;

      if (doublelogplot) {
	emptyHist = new TH2D("emptyHist", "",
			     hist->GetNbinsX(),
			     TMath::Power(10, hist->GetXaxis()->GetXmin()),
			     TMath::Power(10, hist->GetXaxis()->GetXmax()),
			     hist->GetNbinsY(),
			     TMath::Power(10, hist->GetYaxis()->GetXmin()),
			     TMath::Power(10, hist->GetYaxis()->GetXmax()));

	hist->GetXaxis()->SetLabelColor(kWhite);
	hist->GetXaxis()->SetAxisColor(kWhite);
	hist->GetYaxis()->SetLabelColor(kWhite);
	hist->GetYaxis()->SetAxisColor(kWhite);
      }

      hist->GetXaxis()->CenterTitle(1);
      hist->GetXaxis()->SetTitle(variableNames[iVariable2].c_str());
      hist->GetYaxis()->CenterTitle(1);
      hist->GetYaxis()->SetTitleOffset(1.15);
      hist->GetYaxis()->SetTitle(variableNames[iVariable1].c_str());
      hist->SetTitle("");
      hist->GetXaxis()->SetTitleOffset(1);
      //      hist->GetXaxis()->SetTitle(variableNames[iVariable1]);
      hist->GetXaxis()->SetTitleFont(62);
      hist->GetYaxis()->SetTitleFont(62);
      hist->GetXaxis()->SetTitleSize(0.045); 
      hist->GetYaxis()->SetTitleSize(0.045);

      hist->GetXaxis()->SetLabelFont(62);
      hist->GetYaxis()->SetLabelFont(62);
      hist->GetXaxis()->SetLabelSize(0.045);
      hist->GetYaxis()->SetLabelSize(0.045);

      hist->Draw();

      if (doublelogplot) {
	emptyHist->GetXaxis()->Draw();
	emptyHist->GetYaxis()->Draw();
      }

      // Create a legend
      TLegend *legend = new TLegend( leg1, leg2, leg3, leg4 );
      //TLegend *legend = new TLegend(0.58,0.84,0.96,0.99,"");
      legend->SetTextSize(0.04);

      // loop over the existing files and draw the contour planes
      for (int iFile = 0; iFile < nFiles; iFile++) {
	// draw the contours
	int iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_2D2s";
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetFillStyle(fstyles[iFile]);
	  contour->SetFillColor(colors2a[iFile]);
	  contour->SetLineColor(colors2b[iFile]);
	  if (contour->GetN()>15) {
	    contour->Draw("fsame");
	  }
	  iContour++;
	}
	iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_1D1s";
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetFillStyle(fstyles[iFile]);
	  contour->SetFillColor(colors1a[iFile]);
	  contour->SetLineColor(colors1b[iFile]);
	  if (contour->GetN()>15) {
	    contour->Draw("fsame");
	  }
	  iContour++;
	}
      }
      // loop over the existing files again and draw the contour boundaries
      for (int iFile = 0; iFile < nFiles; iFile++) {
	// draw the contours
	int iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_2D2s";
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetFillStyle(fstyles[iFile]);
	  contour->SetFillColor(colors2a[iFile]);
	  contour->SetLineColor(colors2b[iFile]);
	  if (contour->GetN()>15) {
	    //cout << "drawing contour " << contourName << endl;
	    contour->Draw("same");
	  }
	  if (iContour == 0) {
	    string legendEntry = "2D 95% CL " + fileNameTags[iFile];
	    legend->AddEntry(contour, legendEntry.c_str(), "l");
	  }
	  iContour++;
	}
	iContour = 0;
	while (1) {
	  char contourNumber[256];
	  sprintf(contourNumber,"%i",iContour);
	  string contourName = "contour_" 
	    + variables[iVariable2] + "_" 
	    + variables[iVariable1] + "_" 
	    + contourNumber + "_1D1s";
	  TGraph* contour = (TGraph*)files[iFile]->Get(contourName.c_str());
	  if (!contour) {
	    break;
	  }
	  contour->SetLineWidth(2);
	  contour->SetLineStyle(styles[iFile]);
	  contour->SetFillStyle(fstyles[iFile]);
	  contour->SetFillColor(colors1a[iFile]);
	  contour->SetLineColor(colors1b[iFile]);
	  if (contour->GetN()>15) {
	    //cout << "drawing contour " << contourName << endl;
	    contour->Draw("same");
	  }
	  if (iContour == 0) {
	    string legendEntry = "1D 68% CL " + fileNameTags[iFile];
	    legend->AddEntry(contour, legendEntry.c_str(), "l");
	  }
	  iContour++;
	}
	iContour = 0;


	// eventually draw the cross
	if (iFile == 0 ) 
	  {
	    // Get the position of the minimum and draw a marker
	    //TObjArray *splittedText = TString(fileNames[iFile]).Tokenize("/");
	    //TString link = "/scratch/hh/current/atlas/users/prudent/fittino/postProcessing/PP/step7_plot/2DparametersPlots/";
	    //TString markovFitsResults = link + ((TObjString*) splittedText->At(6))->GetString() + "/markovFitsResults.txt";
	    //TString command = "cp " + markovFitsResults + " .";
	    //system( command );
	    system( "./arrange.sh markovFitsResults.txt > markovFitsResults_temp.txt");
	    //cout << "For the fit: " << endl << markovFitsResults << endl;

	    TString var1 = variables[iVariable1];
	    TString var2 = variables[iVariable2];
	    TString varName;
	    Double_t Ymin=-1, Xmin=-1, min;
	    ifstream _markovFitsResults ( "markovFitsResults_temp.txt" );
	    while( _markovFitsResults >> varName >> min ){
	      if( varName == var2 ) Xmin = min;
	      if( varName == var1 ) Ymin = min;
	    }
	    _markovFitsResults.close();
	    cout << "Cross drawn at: " << " x = " << Xmin << " y = " << Ymin << endl;
	    system( "rm markovFitsResults_temp.txt");

	      TMarker cross ( Xmin, Ymin, 29 );
	      cross.SetMarkerSize( 2.5 );
	      cross.Draw();
	  }
      

      }
      
      // get the fittino logo
      TImage *fittinoLogo = 0;
      if (logoPath!="") {
	fittinoLogo = TImage::Open(logoPath.c_str());
	if (!(logoPath=="")) {
	  if (!fittinoLogo) {
	    printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
	    return;
	  }
	  fittinoLogo->SetConstRatio(1);
	  fittinoLogo->SetImageQuality(TAttImage::kImgBest);
	}
      }
      // add the fittino logo
      if (fittinoLogo) {
	const float canvasHeight   = canvas->GetWindowHeight();
	const float canvasWidth    = canvas->GetWindowWidth();
	const float canvasAspectRatio = canvasHeight/canvasWidth;
	const float width          = 0.16;
	const float xLowerEdge     = 0.02;
	const float yLowerEdge     = 0.80;

	  const float xUpperEdge     = xLowerEdge+width;
	  float default_yUpperEdge = yLowerEdge+width*fittinoLogo->GetHeight()/fittinoLogo->GetWidth()/canvasAspectRatio;
	  float yUpperEdge;
	  if( default_yUpperEdge > 1 ) yUpperEdge = 1;
	  else yUpperEdge = default_yUpperEdge;

	  //cout << " xLowerEdge  = " << xLowerEdge << "\n"
	  //<< " yLowerEdge  = " << yLowerEdge << "\n"
	  //<< " xUpperEdge  = " << xUpperEdge << "\n"
	  //<< " yUpperEdge  = " << yUpperEdge << "\n"
	  //<< " Imagewidth  = " << fittinoLogo->GetWidth() << "\n"
	  //<< " Imageheight = " << fittinoLogo->GetHeight() << "\n"
	  //<< " canvasHeight= " << canvasHeight << "\n"
	  //<< " canvasWidth = " << canvasWidth  << "\n"
	  //<< endl;
	//TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.85, 0.85, 0.98, 0.85+d*fittinoLogo->GetHeight()/fittinoLogo->GetWidth());
	TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
	fittinoLogoPad->Draw("same");
	fittinoLogoPad->cd();
	fittinoLogo->Draw("xxx");
	canvas->cd();
      }
      

      // Draw the legend
      legend->Draw("same");      

      // write output histogram
      string outputName = "markovChain2D2sContours_" 
	+ variables[iVariable2] + "_" 
	+ variables[iVariable1] + "_" + nameTag + ".eps";
      canvas->Print(outputName.c_str());
      outputName = "markovChain2D2sContours_" 
	+ variables[iVariable2] + "_" 
	+ variables[iVariable1] + "_" + nameTag + ".gif";
      canvas->Print(outputName.c_str());

      if (fittinoLogo) {
	fittinoLogo->Delete();
      }

      canvas->Clear();
      
    }
  }
  


  for (int i = 0; i < nFiles; i++) {
    files[i]->Close();
  }



  return;

}
