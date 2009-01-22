#include "TChain.h"
#include "TCanvas.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TList.h"
#include "TLine.h"
#include "TImage.h"
#include "TObjArray.h"
#include "iostream"
#include <vector>
#include <string>
using namespace std;

void PlotParameterOverlay (const string filename = "PullDistributions.sum.root",
			   const string parX  = "M0",
			   const string parY  = "M12",
			   const double lowX  = 0.,
			   const double highX = 3000.,
			   const double lowY  = 0.,
			   const double highY = 1000.,
			   const string backgroundImageName = "",
			   const string logoPath = "",
			   const string treename = "tree" )
{

  gStyle->SetOptStat(0);
  gStyle->SetOptFit(0);
  gStyle->SetPalette(1);

  TFile* file = new TFile(filename.c_str(), "read");
  if ( !file ) {
    printf("Problem accessing file %s\n", filename);
    return;
  }
  
  TTree* tree = (TTree*)file->Get(treename.c_str());
  if ( !tree ) {
    printf("Problem accessing tree %s\n", treename);
    return;
  }
  
  const double topMargin    = 0.05;
  const double bottomMargin = 0.15;
  const double leftMargin   = 0.15;
  const double rightMargin  = 0.05;
  const double histWidth  = 1. - leftMargin - rightMargin;
  const double histHeight = 1. - topMargin  - bottomMargin;
  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 700);
  c->SetBorderMode(0);
  c->SetTopMargin   (topMargin   );
  c->SetBottomMargin(bottomMargin);
  c->SetLeftMargin  (leftMargin  );
  c->SetRightMargin (rightMargin );
  
  TH2D* parDistHist = new TH2D("parDistHist","parDistHist",200,lowX,highX,200,lowY,highY);

  const string varList = parY+":"+parX+">>parDistHist";
  tree->Draw(varList.c_str());//,"7.<TanBeta && TanBeta<13."); 
  //  TH2F* parDistHist = gROOT->FindObject("parDistHist");
  parDistHist->SetTitle("");
  const string xAxisTitle = "M_{0} (GeV)";
  const string yAxisTitle = "M_{1/2} (GeV)";
  parDistHist->GetXaxis()->SetTitle(xAxisTitle.c_str());
  parDistHist->GetYaxis()->SetTitle(yAxisTitle.c_str());
  parDistHist->GetXaxis()->CenterTitle();
  parDistHist->GetXaxis()->SetTitleSize(0.05);
  parDistHist->GetXaxis()->SetTitleOffset(1.2);
  parDistHist->GetXaxis()->SetLabelSize(0.05);
  parDistHist->GetYaxis()->SetLabelSize(0.05);
  parDistHist->GetYaxis()->CenterTitle();
  parDistHist->GetYaxis()->SetTitleSize(0.05);
  parDistHist->GetYaxis()->SetTitleOffset(1.4);


  // eventually get the background Image
  TImage *backgroundImage = 0;
  if (backgroundImageName!="") {
    // get the fittino logo
    backgroundImage = TImage::Open(backgroundImageName.c_str());
    if (!backgroundImage) {
      printf("Could not open the fittino logo at %s\n exit\n",backgroundImageName.c_str());
      return;
    }
    //    backgroundImage->SetConstRatio(1);
    backgroundImage->SetImageQuality(TAttImage::kImgBest);
    
   const float canvasHeight   = c->GetWindowHeight();
   const float canvasWidth    = c->GetWindowWidth();
   const float canvasAspectRatio = canvasHeight/canvasWidth;
   // const float width          = 0.22;
   const float xLowerEdge     = leftMargin;
   const float yLowerEdge     = bottomMargin;
   const float xUpperEdge     = xLowerEdge+histWidth;
   //   const float yUpperEdge     = yLowerEdge+width*backgroundImage->GetHeight()/backgroundImage->GetWidth()/canvasAspectRatio;
   const float yUpperEdge     = yLowerEdge+histHeight;
   cout << " xLowerEdge  = " << xLowerEdge << "\n"
	 << " yLowerEdge  = " << yLowerEdge << "\n"
	 << " xUpperEdge  = " << xUpperEdge << "\n"
	 << " yUpperEdge  = " << yUpperEdge << "\n"
	 << " Imagewidth  = " << backgroundImage->GetWidth() << "\n"
	 << " Imageheight = " << backgroundImage->GetHeight() << "\n"
	 << " canvasHeight= " << canvasHeight << "\n"
	 << " canvasWidth = " << canvasWidth  << "\n"
	 << endl;
   TPad *backgroundImagePad = new TPad("backgroundImagePad", "backgroundImagePad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
   backgroundImagePad->Draw("same");
   backgroundImagePad->cd();
    backgroundImage->Draw("xxx");
    c->cd();
  }
   
  // draw the parameter distribution
  parDistHist->Draw("contsame");

  // eventually draw the Fittino Logo
  TImage *fittinoLogo = 0;
  if (logoPath!="") {
    // get the fittino logo
    fittinoLogo = TImage::Open(logoPath.c_str());
    if (!fittinoLogo) {
      printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
      return;
    }
    fittinoLogo->SetConstRatio(1);
    fittinoLogo->SetImageQuality(TAttImage::kImgBest);
    
    const float canvasHeight   = c->GetWindowHeight();
    const float canvasWidth    = c->GetWindowWidth();
    const float canvasAspectRatio = canvasHeight/canvasWidth;
    const float width          = 0.22;
    const float xLowerEdge     = 0.02;
    const float yLowerEdge     = 0.88;
    const float xUpperEdge     = xLowerEdge+width;
    const float yUpperEdge     = yLowerEdge+width*fittinoLogo->GetHeight()/fittinoLogo->GetWidth()/canvasAspectRatio;
    cout << " xLowerEdge  = " << xLowerEdge << "\n"
	 << " yLowerEdge  = " << yLowerEdge << "\n"
	 << " xUpperEdge  = " << xUpperEdge << "\n"
	 << " yUpperEdge  = " << yUpperEdge << "\n"
	 << " Imagewidth  = " << fittinoLogo->GetWidth() << "\n"
	 << " Imageheight = " << fittinoLogo->GetHeight() << "\n"
	 << " canvasHeight= " << canvasHeight << "\n"
	 << " canvasWidth = " << canvasWidth  << "\n"
	 << endl;
    TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
    fittinoLogoPad->Draw("same");
    fittinoLogoPad->cd();
    fittinoLogo->Draw("xxx");
    c->cd();
  }
   
  const string outputFileName = "ParameterOverlay_"+parY+"_vs_"+parX+".eps";
  c->Print(outputFileName.c_str());

  if (logoPath!="") {     
    fittinoLogo->Delete();
  }
  if (backgroundImageName!="") {     
    backgroundImage->Delete();
  }


  return;

}
