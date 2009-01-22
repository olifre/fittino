/***************************************************************************
                           IndividualvariablePullPlot.cpp
                           ---------------------

    This ROOT macro draws the constribution of each individual
    valriable to the chi^2

                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : January 20, 2009
    authors              : Philip Bechtle, Peter Wienemann
    email                : philip.bechtle@desy.de, peter.wienemann@desy.de
***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include "TStyle.h"
#include "TH1D.h"
#include "TH2D.h"
#include "TGraph.h"
#include "TGraphSmooth.h"
#include "TColor.h"
#include "TF1.h"
#include "TFile.h"
#include "TTree.h"
#include "TCanvas.h"
#include "TLeafD.h"
#include "TImage.h"
#include "TLegend.h"
#include "TLine.h"
#include "TLatex.h"
#include "TGaxis.h"
#include <string>
#include <vector>
#include <map>
using namespace std;

void IndividualVariablePullPlot (const string model = "",
				 const string data  = "",
				 const string logoPath = "" ) 
{

  // styles
  //gROOT->SetStyle("ATLAS");
  //gROOT->ForceStyle();
  gStyle->SetOptStat(0);
  gStyle->SetOptFit(0);


  // canvas
  TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 700, 900);
  gStyle->SetHistMinimumZero(1);
  c->SetBorderMode(0);
  c->SetTopMargin(0.06);
  c->SetBottomMargin(0.07);
  c->SetLeftMargin(0.60);
  c->SetRightMargin(0.02);
  c->SetGrid(1);
  
  // create data
  vector<double> pull;
  vector<string> name;
  vector<string> meas;
  vector<string> fitr;

  // GMSB Fit to real data
// Bsg_npf          = 1.117+-0.122474       (0.168288)    at theovalue = 1.13761
// dm_s_npf         = 1.11+-0.320156        (0.272438)    at theovalue = 1.02278
// Btn_npf          = 1.15+-0.4             (0.585144)    at theovalue = 0.915943
// B_sXsll_npf      = 0.99+-0.32            (0.00957275)  at theovalue = 0.993063
// Klnu_npf         = 1.008+-0.014          (0.625804)    at theovalue = 0.999239
// gmin2m_npf       = 3.02e-09+-9.02441e-10 (0.0281382)   at theovalue = 2.99461e-09
// MassW_npf        = 80.399+-0.0269258     (0.802427)    at theovalue = 80.3774
// sin_th_eff_npf   = 0.2324+-0.0012        (0.837317)    at theovalue = 0.231395
// GammaZ_npf       = 2495.2+-2.50799       (0.779191)    at theovalue = 2493.25
// R_l_npf          = 20.767+-0.025         (0.79184)     at theovalue = 20.7868
// R_b_npf          = 0.21629+-0.00066      (0.712712)    at theovalue = 0.21582
// R_c_npf          = 0.1721+-0.003         (0.02215)     at theovalue = 0.172166
// A_fbb_npf        = 0.0992+-0.0016        (2.87586)     at theovalue = 0.103801
// A_fbc_npf        = 0.0707+-0.0035        (0.997677)    at theovalue = 0.0741919
// A_b_npf          = 0.923+-0.02           (0.601536)    at theovalue = 0.935031
// A_c_npf          = 0.67+-0.027           (0.0625263)   at theovalue = 0.668312
// A_l_npf          = 0.1513+-0.0021        (1.56263)     at theovalue = 0.148018
// Massh0_npf         114.4                               >              113.256
// Omega_npf        = 0.1099+-0.013507      (0.0244983)   at theovalue = 0.110231
// A_tau_npf        = 0.1465+-0.0032        (0.474525)    at theovalue = 0.148018
// A_fbl_npf        = 0.01714+-0.00095      (0.745156)    at theovalue = 0.0164321
// sigma_had0_npf   = 41.54+-0.037          (3.66305)     at theovalue = 41.4045
// dm_k_npf         = 0.92+-0.14            (0.734042)    at theovalue = 1.02277
// DmsDmd_npf       = 1.09+-0.160312        (0.561576)    at theovalue = 0.999972
// alphaem          = 127.925+-0.016        (0.03125)     at theovalue = 127.924
// G_F              = 1.16639e-05+-1e-10    (0)           at theovalue = 1.16639e-05
// alphas           = 0.1176+-0.002         (0.01035)     at theovalue = 0.117579
// massZ            = 91.1875+-0.0021       (0.152381)    at theovalue = 91.1872
// massBottom       = 4.2+-0.17             (0.0135176)   at theovalue = 4.1977
// massTop          = 172.4+-1.2            (0.0154167)   at theovalue = 172.381
// massTau          = 1.77684+-0.00017      (0.0823529)   at theovalue = 1.77683
// massCharm        = 1.2+-0.11             (0)           at theovalue = 1.2            

  name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122         "); fitr.push_back("1.137      ");  pull.push_back(0.168288)  ; //  
  name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32           "); fitr.push_back("1.02       ");  pull.push_back(0.272438)  ; // -
  name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4            "); fitr.push_back("0.92       ");  pull.push_back(0.585144)  ; // -
  name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32           "); fitr.push_back("0.99       ");  pull.push_back(0.00957275); //  
  name.push_back("BR(K#to l#nu)");                meas.push_back("1.008 #pm 0.014         "); fitr.push_back("0.999      ");  pull.push_back(0.625804)  ; // -
  name.push_back("gmin2m_npf    "); meas.push_back("3.02^{-9} #pm 9.0^{10}  "); fitr.push_back("2.99^{-9}  ");  pull.push_back(0.0281382) ; // -
  name.push_back("MassW_npf     "); meas.push_back("80.399 #pm 0.027        "); fitr.push_back("80.377     ");  pull.push_back(0.802427)  ; // -
  name.push_back("sin_th_eff_npf"); meas.push_back("0.2324 #pm 0.0012       "); fitr.push_back("0.231395   ");  pull.push_back(0.837317)  ; // -
  name.push_back("GammaZ_npf    "); meas.push_back("2495.2 #pm 2.50799      "); fitr.push_back("2493.25    ");  pull.push_back(0.779191)  ; //  
  name.push_back("R_l_npf       "); meas.push_back("20.767 #pm 0.025        "); fitr.push_back("20.7868    ");  pull.push_back(0.79184)   ; //  
  name.push_back("R_b_npf       "); meas.push_back("0.21629 #pm 0.00066     "); fitr.push_back("0.21582    ");  pull.push_back(0.712712)  ; // -
  name.push_back("R_c_npf       "); meas.push_back("0.1721 #pm 0.003        "); fitr.push_back("0.172166   ");  pull.push_back(0.02215)   ; // -
  name.push_back("A_fbb_npf     "); meas.push_back("0.0992 #pm 0.0016       "); fitr.push_back("0.103801   ");  pull.push_back(2.87586)   ; //  
  name.push_back("A_fbc_npf     "); meas.push_back("0.0707 #pm 0.0035       "); fitr.push_back("0.0741919  ");  pull.push_back(0.997677)  ; //  
  name.push_back("A_b_npf       "); meas.push_back("0.923 #pm 0.02          "); fitr.push_back("0.935031   ");  pull.push_back(0.601536)  ; //  
  name.push_back("A_c_npf       "); meas.push_back("0.67 #pm 0.027          "); fitr.push_back("0.668312   ");  pull.push_back(0.0625263) ; // -
  name.push_back("A_l_npf       "); meas.push_back("0.1513 #pm 0.0021       "); fitr.push_back("0.148018   ");  pull.push_back(1.56263)   ; // -
  name.push_back("Massh0_npf    "); meas.push_back("< 114.4              "); fitr.push_back("113.256    ");  pull.push_back(0.3813)   ;	 // -
  name.push_back("Omega_npf     "); meas.push_back("0.1099 #pm 0.013507     "); fitr.push_back("0.110231   ");  pull.push_back(0.0244983) ; //  
  name.push_back("A_tau_npf     "); meas.push_back("0.1465 #pm 0.0032       "); fitr.push_back("0.148018   ");  pull.push_back(0.474525)  ; //  
  name.push_back("A_fbl_npf     "); meas.push_back("0.01714 #pm 0.00095     "); fitr.push_back("0.0164321  ");  pull.push_back(0.745156)  ; // -
  name.push_back("sigma_had0_npf"); meas.push_back("41.54 #pm 0.037         "); fitr.push_back("41.4045    ");  pull.push_back(3.66305)   ; // -
  name.push_back("dm_k_npf      "); meas.push_back("0.92 #pm 0.14           "); fitr.push_back("1.02277    ");  pull.push_back(0.734042)  ; //  
  name.push_back("DmsDmd_npf    "); meas.push_back("1.09 #pm 0.160312       "); fitr.push_back("0.999972   ");  pull.push_back(0.561576)  ; // -
  name.push_back("alphaem       "); meas.push_back("127.925 #pm 0.016       "); fitr.push_back("127.924    ");  pull.push_back(0.03125)   ; // -
  name.push_back("G_F           "); meas.push_back("1.16639e-05 #pm 1e-10   "); fitr.push_back("1.16639e-05");  pull.push_back(0)         ; //  
  name.push_back("alphas        "); meas.push_back("0.1176 #pm 0.002        "); fitr.push_back("0.117579   ");  pull.push_back(0.01035)   ; // -
  name.push_back("massZ         "); meas.push_back("91.1875 #pm 0.0021      "); fitr.push_back("91.1872    ");  pull.push_back(0.152381)  ; // -
  name.push_back("massBottom    "); meas.push_back("4.2 #pm 0.17            "); fitr.push_back("4.1977     ");  pull.push_back(0.0135176) ; // -
  name.push_back("massTop       "); meas.push_back("172.4 #pm 1.2           "); fitr.push_back("172.381    ");  pull.push_back(0.0154167) ; // -
  name.push_back("massTau       "); meas.push_back("1.77684 #pm 0.00017     "); fitr.push_back("1.77683    ");  pull.push_back(0.0823529) ; // -
  name.push_back("massCharm     "); meas.push_back("1.2 #pm 0.11            "); fitr.push_back("1.2        ");  pull.push_back(0)         ; //  

  
  if (pull.size()!=name.size()) {
    cout << "setup error" << endl;
    return;
  }

  // fill histogram
  string histTitle = model + " fit to " + data;
  cout << "creating histogram with title " << histTitle.c_str() << endl;
  TH1D* residualHist = new TH1D("residualHist",histTitle.c_str(),pull.size(),0,(int)pull.size());
  for (UInt_t i = 0; i<name.size(); i++) {
    residualHist->SetBinContent(i+1,pull[i]);
    string binName = name[i] + meas[i] + fitr[i];
    //    residualHist->GetXaxis()->SetBinLabel(i+1,binName.c_str());
    residualHist->GetXaxis()->SetBinLabel(i+1," ");
  }
  // residualHist->SetBarWidth(1.0);
  // residualHist->SetBarOffset(0.0);
  residualHist->SetMaximum(4.);
  residualHist->SetMinimum(0.);
  residualHist->SetFillColor(kBlue-2);
  residualHist->SetLineColor(kBlue+2);
  // residualHist->SetTitleSize(2.);
  // residualHist->SetTitleOffset(-1.0);
  residualHist->GetYaxis()->SetTitle("(Meas.-Fit)/ #sigma");
  residualHist->GetYaxis()->SetTitleOffset(0.8);
  residualHist->GetYaxis()->SetLabelOffset(0.0);
  residualHist->GetYaxis()->CenterTitle();
  residualHist->GetYaxis()->SetNdivisions(5);

  // draw the histogram
  residualHist->Draw("hbar2");

  // Draw labels on the y axis
  TLatex *t = new TLatex();  
  // t->SetTextAlign(32);
  t->SetTextSize(0.030);
  // t->SetTextFont(72);
  for (UInt_t i=0;i<pull.size();i++) {
    t->DrawLatex(-5.90,0.5+(double)i,name[i].c_str());
    t->DrawLatex(-3.90,0.5+(double)i,meas[i].c_str());
    t->DrawLatex(-1.05,0.5+(double)i,fitr[i].c_str());
  }

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
    const float xLowerEdge     = 0.77;
    const float yLowerEdge     = 0.90;
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
    //  TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.85, 0.85, 0.98, 0.85+d*fittinoLogo->GetHeight()/fittinoLogo->GetWidth());
    TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
    fittinoLogoPad->Draw("same");
    fittinoLogoPad->cd();
    fittinoLogo->Draw("xxx");
    c->cd();
  }
  
  
  c->Print("individualPullContrib.eps");
  if (logoPath!="") {     
    fittinoLogo->Delete();
  }
  
  return;

}
