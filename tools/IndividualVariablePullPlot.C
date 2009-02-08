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
  gStyle->SetCanvasColor(0);

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

  // 0 0   using obs Bsg_npf =        1.117+-0.122474       (0.16793)       at theovalue = 1.13757
  // 1 1   using obs dm_s_npf =       1.11+-0.320156        (0.272472)      at theovalue = 1.02277
  // 3 3   using obs Btn_npf =        1.15+-0.4             (0.585147)      at theovalue = 0.915941
  // 4 4   using obs B_sXsll_npf =    0.99+-0.32            (0.00958694)    at theovalue = 0.993068
  // 5 5   using obs Klnu_npf =       1.008+-0.014          (0.625805)      at theovalue = 0.999239
  // 6 6   using obs gmin2m_npf =     3.02e-09+-9.02441e-10 (0.0283529)     at theovalue = 2.99441e-09
  // 7 7   using obs MassW_npf =      80.399+-0.0269258     (0.783597)      at theovalue = 80.3779
  // 8 8   using obs sin_th_eff_npf = 0.2324+-0.0012        (0.839658)      at theovalue = 0.231392
  // 9 9   using obs GammaZ_npf =     2495.2+-2.50799       (0.0466908)     at theovalue = 2495.08
  // 10 10 using obs R_l_npf =        20.767+-0.025         (0.96356)       at theovalue = 20.7429
  // 11 11 using obs R_b_npf =        0.21629+-0.00066      (0.400333)      at theovalue = 0.216026
  // 12 12 using obs R_c_npf =        0.1721+-0.003         (0.03595)       at theovalue = 0.172208
  // 13 13 using obs A_fbb_npf =      0.0992+-0.0016        (2.88566)       at theovalue = 0.103817
  // 14 14 using obs A_fbc_npf =      0.0707+-0.0035        (1.00116)       at theovalue = 0.074204
  // 15 15 using obs A_b_npf =        0.923+-0.02           (0.601613)      at theovalue = 0.935032
  // 16 16 using obs A_c_npf =        0.67+-0.027           (0.0621656)     at theovalue = 0.668322
  // 17 17 using obs A_l_npf =        0.1513+-0.0021        (1.55209)       at theovalue = 0.148041
  // 18 lower bound  Massh0_npf       114.4                         >                     113.266	         
  // 19 19 using obs Omega_npf =      0.1099+-0.013507      (0.00558672)    at theovalue = 0.109975
  // 20 20 using obs A_tau_npf =      0.1465+-0.0032        (0.481441)      at theovalue = 0.148041
  // 21 21 using obs A_fbl_npf =      0.01714+-0.00095      (0.739983)      at theovalue = 0.016437
  // 22 22 using obs sigma_had0_npf = 41.54+-0.037          (1.49357)       at theovalue = 41.4847
  // 23 23 using obs dm_k_npf =       0.92+-0.14            (0.733964)      at theovalue = 1.02275
  // 26 26 using obs DmsDmd_npf =     1.09+-0.160312        (0.561576)      at theovalue = 0.999972
  // 27 27 using obs alphaem =        127.925+-0.016        (0)             at theovalue = 127.925
  // 28 28 using obs G_F =            1.16637e-05+-1e-10    (0)             at theovalue = 1.16637e-05
  // 29 29 using obs alphas =         0.1176+-0.002         (0)             at theovalue = 0.1176
  // 30 30 using obs massZ =          91.1875+-0.0021       (0)             at theovalue = 91.1875
  // 31 31 using obs massBottom =     4.2+-0.17             (0)             at theovalue = 4.2
  // 32 32 using obs massTop =        172.4+-1.2            (0)             at theovalue = 172.4
  // 33 33 using obs massTau =        1.77684+-0.00017      (0)             at theovalue = 1.77684
  // 34 34 using obs massCharm =      1.2+-0.11             (0)             at theovalue = 1.2           
  
  // mSUGRA (10 paras)
  //Bsg_npf        = 1.117+-0.122474       (0.839753) 	 at theovalue = 1.01415
  //dm_s_npf       = 1.11+-0.320156        (0.243694) 	 at theovalue = 1.03198
  //Btn_npf        = 1.15+-0.4             (0.478271) 	 at theovalue = 0.958691
  //B_sXsll_npf    = 0.99+-0.32            (0.00391203)	 at theovalue = 0.988748
  //Klnu_npf       = 1.008+-0.014          (0.597855) 	 at theovalue = 0.99963
  //gmin2m_npf     = 3.02e-09+-9.02441e-10 (0.535321) 	 at theovalue = 2.5369e-09
  //MassW_npf      = 80.399+-0.0269258     (0.6753) 	 at theovalue = 80.3808
  //sin_th_eff_npf = 0.2324+-0.0012        (0.841958) 	 at theovalue = 0.23139
  //GammaZ_npf     = 2495.2+-2.50799       (0.0162282) 	 at theovalue = 2495.16
  //R_l_npf        = 20.767+-0.025         (0.93888) 	 at theovalue = 20.7435
  //R_b_npf        = 0.21629+-0.00066      (0.382667) 	 at theovalue = 0.216037
  //R_c_npf        = 0.1721+-0.003         (0.03431) 	 at theovalue = 0.172203
  //A_fbb_npf      = 0.0992+-0.0016        (2.89251) 	 at theovalue = 0.103828
  //A_fbc_npf      = 0.0707+-0.0035        (1.0044) 	 at theovalue = 0.0742154
  //A_b_npf        = 0.923+-0.02           (0.599688) 	 at theovalue = 0.934994
  //A_c_npf        = 0.67+-0.027           (0.0620163) 	 at theovalue = 0.668326
  //A_l_npf        = 0.1513+-0.0021        (1.54174) 	 at theovalue = 0.148062
  //Massh0_npf     at 114.4                                           > 113.223
  //Omega_npf      = 0.1099+-0.013507      (0.10401) 	 at theovalue = 0.108495
  //A_tau_npf      = 0.1465+-0.0032        (0.488231) 	 at theovalue = 0.148062
  //A_fbl_npf      = 0.01714+-0.00095      (0.734903) 	 at theovalue = 0.0164418
  //sigma_had0_npf = 41.54+-0.037          (1.52035) 	 at theovalue = 41.4837
  //dm_k_npf       = 0.92+-0.14            (0.799217) 	 at theovalue = 1.03189
  //DmsDmd_npf     = 1.09+-0.160312        (0.562134) 	 at theovalue = 0.999883
  //alphaem        = 127.925+-0.016        (0.125) 	 at theovalue = 127.923
  //G_F            = 1.16637e-05+-1e-10    (0) 	         at theovalue = 1.16637e-05
  //alphas         = 0.1176+-0.002         (0) 	         at theovalue = 0.1176
  //massZ          = 91.1875+-0.0021       (0.0571429) 	 at theovalue = 91.1874
  //massBottom     = 4.2+-0.17             (0) 	         at theovalue = 4.2
  //massTop        = 172.4+-1.2            (0) 	         at theovalue = 172.4
  //massTau        = 1.77684+-0.00017      (0) 	         at theovalue = 1.77684
  //massCharm      = 1.2+-0.11             (0) 	         at theovalue = 1.2
  
  //name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           "); fitr.push_back("1.138         ");  pull.push_back(0.16793)    ; //  
  //name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             "); fitr.push_back("1.02          ");  pull.push_back(0.272472)   ; // -
  //name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              "); fitr.push_back("0.92          ");  pull.push_back(0.585147)   ; // -
  //name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             "); fitr.push_back("0.99          ");  pull.push_back(0.00958694) ; //  
  //name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           "); fitr.push_back("0.999         ");  pull.push_back(0.625805)   ; // -
  //name.push_back("(g-2)_{#mu}   ");               meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.99 10^{-09} ");  pull.push_back(0.0283529)  ; // -
  //name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          "); fitr.push_back("80.378        ");  pull.push_back(0.783597)   ; // -
  //name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         "); fitr.push_back("0.2314        ");  pull.push_back(0.839658)   ; // -
  //name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           "); fitr.push_back("2495.08       ");  pull.push_back(0.0466908)  ; //  
  //name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          "); fitr.push_back("20.743        ");  pull.push_back(0.96356)    ; //  
  //name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       "); fitr.push_back("0.21603       ");  pull.push_back(0.400333)   ; // -
  //name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          "); fitr.push_back("0.1722        ");  pull.push_back(0.03595)    ; // -
  //name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         "); fitr.push_back("0.1038        ");  pull.push_back(2.88566)    ; //  
  //name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         "); fitr.push_back("0.0742        ");  pull.push_back(1.00116)    ; //  
  //name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            "); fitr.push_back("0.935         ");  pull.push_back(0.601613)   ; //  
  //name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            "); fitr.push_back("0.67          ");  pull.push_back(0.0621656)  ; // -
  //name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         "); fitr.push_back("0.1480        ");  pull.push_back(1.55209)    ; // -
  //name.push_back("m_{h}         ");               meas.push_back("114.4                     "); fitr.push_back("113.3         ");  pull.push_back(0.378)      ; // -
  //name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         "); fitr.push_back("0.1100        ");  pull.push_back(0.00558672) ; //  
  //name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         "); fitr.push_back("0.1480        ");  pull.push_back(0.481441)   ; //  
  //name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       "); fitr.push_back("0.01644       ");  pull.push_back(0.739983)   ; // -
  //name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            "); fitr.push_back("41.48         ");  pull.push_back(1.49357)    ; // -
  //name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             "); fitr.push_back("1.02          ");  pull.push_back(0.733964)   ; //  
  //name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             "); fitr.push_back("1.00          ");  pull.push_back(0.561576)   ; // -
  //name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         "); fitr.push_back("127.925       ");  pull.push_back(0)          ; // -
  //name.push_back("G_{F}         ");               meas.push_back("1.16637 10^{-5} #pm 10^{-10}"); fitr.push_back("1.16637 10^{-5}   ");  pull.push_back(0)          ; //  
  //name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         "); fitr.push_back("0.1176	   ");  pull.push_back(0)          ; // -
  //name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        "); fitr.push_back("91.1875       ");  pull.push_back(0)          ; // -
  //name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              "); fitr.push_back("4.2	   ");  pull.push_back(0)          ; // -
  //name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             "); fitr.push_back("172.4	   ");  pull.push_back(0)          ; // -
  //name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684       ");  pull.push_back(0)          ; // -
  //name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2           ");  pull.push_back(0)          ; //  

  name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           "); fitr.push_back("1.014      "); pull.push_back(0.839753)   ; //  
  name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             "); fitr.push_back("1.03       "); pull.push_back(0.243694)   ; // -
  name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              "); fitr.push_back("0.96       "); pull.push_back(0.478271)   ; // -
  name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             "); fitr.push_back("0.99       "); pull.push_back(0.00391203) ; //  
  name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           "); fitr.push_back("1.000      "); pull.push_back(0.597855)   ; // -
  name.push_back("(g-2)_{#mu}   ");            meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.54 10^{-09}"); pull.push_back(0.535321) ; // -
  name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          "); fitr.push_back("80.381     "); pull.push_back(0.6753)     ; // -
  name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         "); fitr.push_back("0.2314     "); pull.push_back(0.841958)   ; // -
  name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           "); fitr.push_back("2495.2     "); pull.push_back(0.0162282)  ; //  
  name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          "); fitr.push_back("20.744     "); pull.push_back(0.93888)    ; //  
  name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       "); fitr.push_back("0.21604    "); pull.push_back(0.382667)   ; // -
  name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          "); fitr.push_back("0.1722     "); pull.push_back(0.03431)    ; // -
  name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         "); fitr.push_back("0.1038     "); pull.push_back(2.89251)    ; //  
  name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         "); fitr.push_back("0.0742     "); pull.push_back(1.0044)     ; //  
  name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            "); fitr.push_back("0.935      "); pull.push_back(0.599688)   ; //  
  name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            "); fitr.push_back("0.67       "); pull.push_back(0.0620163)  ; // -
  name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         "); fitr.push_back("0.1481     "); pull.push_back(1.54174)    ; // -
  name.push_back("m_{h}         ");               meas.push_back("114.4                     "); fitr.push_back("113.2      "); pull.push_back(0.3923)     ; // -
  name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         "); fitr.push_back("0.1085     "); pull.push_back(0.10401)    ; //  
  name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         "); fitr.push_back("0.1481     "); pull.push_back(0.488231)   ; //  
  name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       "); fitr.push_back("0.01644    "); pull.push_back(0.734903)   ; // -
  name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            "); fitr.push_back("41.48      "); pull.push_back(1.52035)    ; // -
  name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             "); fitr.push_back("1.03       "); pull.push_back(0.799217)   ; //  
  name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             "); fitr.push_back("1.00       "); pull.push_back(0.562134)   ; // -
  name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         "); fitr.push_back("127.923    "); pull.push_back(0.125)      ; // -
  name.push_back("G_{F}         ");             meas.push_back("1.16637 10^{-5} #pm 10^{-10}"); fitr.push_back("1.16637 10^{-05}"); pull.push_back(0)     ; //  
  name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         "); fitr.push_back("0.1176     "); pull.push_back(0)          ; // -
  name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        "); fitr.push_back("91.1874    "); pull.push_back(0.0571429)  ; // -
  name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              "); fitr.push_back("4.2        "); pull.push_back(0)          ; // -
  name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             "); fitr.push_back("172.4      "); pull.push_back(0)          ; // -
  name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684    "); pull.push_back(0)          ; // -
  name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2        "); pull.push_back(0)          ; //  
  
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
    t->DrawLatex(-5.90,0.2+(double)i,name[i].c_str());
    t->DrawLatex(-3.90,0.2+(double)i,meas[i].c_str());
    t->DrawLatex(-1.05,0.2+(double)i,fitr[i].c_str());
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
