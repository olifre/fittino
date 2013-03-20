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

#include "FileSettings.h"

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
#include <iomanip>
using namespace std;

void IndividualVariablePullPlot (const string modelName = "",
      const string data  = "",
      const string logoPath = "" ) 
{
   // Set the plot settings.
   gROOT->LoadMacro("PlotSettings.C");
   PlotSettings();

   // Set the file settings.
   gROOT->LoadMacro("FileSettings.C");
   FileSettings();

   // Set the histogram settings.
   gROOT->LoadMacro("HistogramSettings.C");
   HistogramSettings();

   // styles
   //gROOT->SetStyle("ATLAS");
   //gROOT->ForceStyle();
   gStyle->SetOptStat(0);
   gStyle->SetOptFit(0);
   gStyle->SetCanvasColor(0);

   // canvas
   TCanvas* c = new TCanvas("c", "Fittino Parameter Distribution", 0, 0, 800, 600);
   gStyle->SetHistMinimumZero(1);
   c->SetBorderMode(0);
   c->SetTopMargin(0.06);
   c->SetTopMargin(0.2);
   //c->SetBottomMargin(0.07);
   c->SetBottomMargin(0.11);
   c->SetLeftMargin(0.65);
   c->SetRightMargin(0.02);
   c->SetGrid(1);

   // create data
   vector<double> pull;
   vector<string> name;
   vector<string> meas;
   vector<string> fitr;


   // OLD GMSB
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

   // OLD mSUGRA (10 paras)
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

   // new mSUGRA
   //# 0 0   using obs DmsDmd_npf        = 1.09+-0.160312        (0.562223)      at theovalue = 0.999869        
   //# 1 1   using obs dm_s_npf          = 1.11+-0.320156        (0.244466)      at theovalue = 1.03173          
   //# 26 26 using obs dm_k_npf          = 0.92+-0.14            (0.797586)      at theovalue = 1.03166            
   //# 3 3   using obs Klnu_npf          = 1.008+-0.014          (0.599506)      at theovalue = 0.999607             
   //# 5 5   using obs B_sXsll_npf       = 0.99+-0.32            (0.00438419)    at theovalue = 0.988597          
   //# 7 7   using obs Btn_npf           = 1.15+-0.4             (0.484654)      at theovalue = 0.956139          
   //# 8 8   using obs Bsg_npf           = 1.117+-0.122474       (0.885326)      at theovalue = 1.00857          
   //# 9 9   using obs gmin2m_npf        = 3.02e-09+-9.02441e-10 (0.517838)      at theovalue = 2.55268e-09        
   //# 10 10 using obs Omega_npf         = 0.1099+-0.013507      (0.117409)      at theovalue = 0.111486         
   //# 11 11 using obs MassW_npf         = 80.399+-0.0269258     (0.700666)      at theovalue = 80.3801             
   //# 12 12 using obs sin_th_eff_npf    = 0.2324+-0.0012        (0.838742)      at theovalue = 0.231394          
   //# 13 13 using obs GammaZ_npf        = 2495.2+-2.50799       (0.0319778)     at theovalue = 2495.12           
   //# 14 14 using obs R_l_npf           = 20.767+-0.025         (0.94096)       at theovalue = 20.7435            
   //# 15 15 using obs R_b_npf           = 0.21629+-0.00066      (0.382288)      at theovalue = 0.216038            
   //# 16 16 using obs R_c_npf           = 0.1721+-0.003         (0.0342567)     at theovalue = 0.172203            
   //# 17 17 using obs A_fbb_npf         = 0.0992+-0.0016        (2.87925)       at theovalue = 0.103807            
   //# 18 18 using obs A_fbc_npf         = 0.0707+-0.0035        (0.999616)      at theovalue = 0.0741987            
   //# 19 19 using obs A_b_npf           = 0.923+-0.02           (0.599736)      at theovalue = 0.934995           
   //# 20 20 using obs A_c_npf           = 0.67+-0.027           (0.0625096)     at theovalue = 0.668312            
   //# 21 21 using obs A_l_npf           = 0.1513+-0.0021        (1.55623)       at theovalue = 0.148032            
   //# 23 23 using obs A_tau_npf         = 0.1465+-0.0032        (0.478725)      at theovalue = 0.148032              
   //# 24 24 using obs A_fbl_npf         = 0.01714+-0.00095      (0.742014)      at theovalue = 0.0164351            
   //# 25 25 using obs sigma_had0_npf    = 41.54+-0.037          (1.51492)       at theovalue = 41.4839             
   //# 22 using lower  Massh0_npf at       114.4                                              > 113.287             
   //# 27 27 using obs alphaem           = 127.925+-0.016        (0.08125)       at theovalue = 127.924               
   //# 28 28 using obs G_F               = 1.16637e-05+-1e-10    (0)             at theovalue = 1.16637e-05              
   //# 29 29 using obs alphas            = 0.1176+-0.002         (0.06885)       at theovalue = 0.117738              
   //# 30 30 using obs massZ             = 91.1875+-0.0021       (0.17619)       at theovalue = 91.1871             
   //# 31 31 using obs massBottom        = 4.2+-0.17             (0)             at theovalue = 4.2              
   //# 32 32 using obs massTop           = 172.4+-1.2            (0.016)         at theovalue = 172.381             
   //# 33 33 using obs massTau           = 1.77684+-0.00017      (0)             at theovalue = 1.77684            
   //# 34 34 using obs massCharm         = 1.27+-0.11            (0.636364)      at theovalue = 1.2                
   //#  chisq = 20.6349 with 31 observables (0 correlated), 8 parameters and 4 bounds

   // # 26 26 using obs DmsDmd_npf =   1.09+-0.160312       (0.561769)       at theovalue = 0.999942   
   // # 1 1 using obs dm_s_npf =       1.11+-0.320156       (0.272466)       at theovalue = 1.02277       
   // # 23 23 using obs dm_k_npf =     0.92+-0.14           (0.73414)        at theovalue = 1.02278       
   // # 5 5 using obs Klnu_npf =       1.008+-0.014         (0.626762)       at theovalue = 0.999225         
   // # 4 4 using obs B_sXsll_npf =    0.99+-0.32           (0.00874819)     at theovalue = 0.992799         
   // # 3 3 using obs Btn_npf =        1.15+-0.4            (0.588765)       at theovalue = 0.914494         
   // # 0 0 using obs Bsg_npf =        1.117+-0.122474      (0.0617859)      at theovalue = 1.10943         
   // # 6 6 using obs gmin2m_npf =     3.02e-09+-9.02441e-10(0.0772269)      at theovalue = 2.95031e-09         
   // # 7 7 using obs MassW_npf =      80.399+-0.0269258    (0.874662)       at theovalue = 80.3754          
   // # 8 8 using obs sin_th_eff_npf = 0.2324+-0.0012       (0.822892)       at theovalue = 0.231413          
   // # 9 9 using obs GammaZ_npf =     2495.2+-2.50799      (0.105463)       at theovalue = 2494.94          
   // # 10 10 using obs R_l_npf =      20.767+-0.025        (0.9598)         at theovalue = 20.743            
   // # 11 11 using obs R_b_npf =      0.21629+-0.00066     (0.404136)       at theovalue = 0.216023            
   // # 12 12 using obs R_c_npf =      0.1721+-0.003        (0.0364033)      at theovalue = 0.172209            
   // # 13 13 using obs A_fbb_npf =    0.0992+-0.0016       (2.8158)         at theovalue = 0.103705           
   // # 14 14 using obs A_fbc_npf =    0.0707+-0.0035       (0.976515)       at theovalue = 0.0741178           
   // # 15 15 using obs A_b_npf =      0.923+-0.02          (0.601279)       at theovalue = 0.935026            
   // # 16 16 using obs A_c_npf =      0.67+-0.027          (0.0644607)      at theovalue = 0.66826             
   // # 17 17 using obs A_l_npf =      0.1513+-0.0021       (1.62749)        at theovalue = 0.147882           
   // # 20 20 using obs A_tau_npf =    0.1465+-0.0032       (0.431959)       at theovalue = 0.147882            
   // # 21 21 using obs A_fbl_npf =    0.01714+-0.00095     (0.776976)       at theovalue = 0.0164019             
   // # 22 22 using obs sigma_had0_npf=41.54+-0.037         (1.51697)        at theovalue = 41.4839              
   // # 18 using lower boMassh0_npf at 114.4                                              > 113.255            
   // # 27 27 using obs alphaem =      127.925+-0.016       (0.16875)        at theovalue = 127.922             
   // # 28 28 using obs G_F =          1.16637e-05+-1e-10   (0)              at theovalue = 1.16637e-05          
   // # 29 29 using obs alphas =       0.1176+-0.002        (0.09895)        at theovalue = 0.117402             
   // # 30 30 using obs massZ =        91.1875+-0.0021      (0.128571)       at theovalue = 91.1872              
   // # 31 31 using obs massBottom =   4.2+-0.17            (0)              at theovalue = 4.2              
   // # 32 32 using obs massTop =      172.4+-1.2           (0.0354167)      at theovalue = 172.442           
   // # 33 33 using obs massTau =      1.77684+-0.00017     (0)              at theovalue = 1.77684         
   // # 34 34 using obs massCharm =    1.2+-0.11            (0)              at theovalue = 1.2           
   // #  chisq = 19.4073 with 30 observables (0 correlated), 8 parameters and 4 bounds

   //  // new GMSB
   //  name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             ");    fitr.push_back("1.00          ");       pull.push_back(0.561769)    ; // -
   //  name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             ");    fitr.push_back("1.02          ");       pull.push_back(0.272466)    ; // -
   //  name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             ");    fitr.push_back("1.02          ");       pull.push_back(0.73414)     ; //  
   //  name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           ");    fitr.push_back("0.999         ");       pull.push_back(0.626762)    ; // -
   //  name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             ");    fitr.push_back("0.99          ");       pull.push_back(0.00874819)  ; //  
   //  name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              ");    fitr.push_back("0.91          ");       pull.push_back(0.588765)    ; // -
   //  name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           ");    fitr.push_back("1.109         ");       pull.push_back(0.0617859)   ; //  
   //  name.push_back("(g-2)_{#mu}   ");               meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.95 10^{-9}  ");       pull.push_back(0.0772269)   ; // -
   //  name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          ");    fitr.push_back("80.375        ");       pull.push_back(0.874662)    ; // -
   //  name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         ");    fitr.push_back("0.2314        ");       pull.push_back(0.822892)    ; // -
   //  name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           ");    fitr.push_back("2494.9        ");       pull.push_back(0.105463)    ; //  
   //  name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          ");    fitr.push_back("20.743        ");       pull.push_back(0.9598)      ; //  
   //  name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       ");    fitr.push_back("0.21602       ");       pull.push_back(0.404136)    ; // -
   //  name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          ");    fitr.push_back("0.1722        ");       pull.push_back(0.0364033)   ; // -
   //  name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         ");    fitr.push_back("0.1037        ");       pull.push_back(2.8158)      ; //  
   //  name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         ");    fitr.push_back("0.0741        ");       pull.push_back(0.976515)    ; //  
   //  name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            ");    fitr.push_back("0.935         ");       pull.push_back(0.601279)    ; //  
   //  name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            ");    fitr.push_back("0.67          ");       pull.push_back(0.0644607)   ; // -
   //  name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         ");    fitr.push_back("0.1479        ");       pull.push_back(1.62749)     ; // -
   //  name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         ");    fitr.push_back("0.1479        ");       pull.push_back(0.431959)    ; //  
   //  name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       ");    fitr.push_back("0.01640       ");       pull.push_back(0.776976)    ; // -
   //  name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            ");    fitr.push_back("41.48         ");       pull.push_back(1.51697)     ; // -
   //  name.push_back("m_{h} >       ");               meas.push_back("114.4                     ");    fitr.push_back("113.3         ");       pull.push_back(0.382)       ; // -
   //  name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         ");    fitr.push_back("127.922       ");       pull.push_back(0.16875)     ; // -
   //  name.push_back("G_{F}         ");               meas.push_back("1.16637 10^{-5} #pm 10^{-10}");  fitr.push_back("1.16637 10^{-5}");      pull.push_back(0)           ; //  
   //  name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         ");    fitr.push_back("0.1174        ");       pull.push_back(0.09895)     ; // -
   //  name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        ");    fitr.push_back("91.1872       ");       pull.push_back(0.128571)    ; // -
   //  name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              ");    fitr.push_back("4.2           ");       pull.push_back(0)           ; // -
   //  name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             ");    fitr.push_back("172.4         ");       pull.push_back(0.0354167)   ; // -
   //  // name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         "); fitr.push_back("              ");       pull.push_back(0)           ; //  
   //  // name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684       ");       pull.push_back(0)           ; // -
   //  // name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2");       pull.push_back(0); //  

   //// new mSUGRA
   //name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             ");    fitr.push_back("1.00         ");       pull.push_back(0.562223)    ; // -
   //name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             ");    fitr.push_back("1.03         ");       pull.push_back(0.244466)    ; // -
   //name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             ");    fitr.push_back("1.03         ");       pull.push_back(0.797586)    ; //  
   //name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           ");    fitr.push_back("1.000        ");       pull.push_back(0.599506)    ; // -
   //name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             ");    fitr.push_back("0.99         ");       pull.push_back(0.00438419)  ; //  
   //name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              ");    fitr.push_back("0.96         ");       pull.push_back(0.484654)    ; // -
   //name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           ");    fitr.push_back("1.009        ");       pull.push_back(0.885326)    ; //  
   //name.push_back("(g-2)_{#mu}   ");               meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.55 10^{-9} ");       pull.push_back(0.517838)    ; // -
   //name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         ");    fitr.push_back("0.1115       ");       pull.push_back(0.117409)    ; //  
   //name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          ");    fitr.push_back("80.380       ");       pull.push_back(0.700666)    ; // -
   //name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         ");    fitr.push_back("0.2314       ");       pull.push_back(0.838742)    ; // -
   //name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           ");    fitr.push_back("2495.1       ");       pull.push_back(0.0319778)   ; //  
   //name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          ");    fitr.push_back("20.746       ");       pull.push_back(0.94096)     ; //  
   //name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       ");    fitr.push_back("0.21604      ");       pull.push_back(0.382288)    ; // -
   //name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          ");    fitr.push_back("0.1722       ");       pull.push_back(0.0342567)   ; // -
   //name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         ");    fitr.push_back("0.1038       ");       pull.push_back(2.87925)     ; //  
   //name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         ");    fitr.push_back("0.0742       ");       pull.push_back(0.999616)    ; //  
   //name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            ");    fitr.push_back("0.935        ");       pull.push_back(0.599736)    ; //  
   //name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            ");    fitr.push_back("0.67         ");       pull.push_back(0.0625096)   ; // -
   //name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         ");    fitr.push_back("0.1480       ");       pull.push_back(1.55623)     ; // -
   //name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         ");    fitr.push_back("0.1480       ");       pull.push_back(0.478725)    ; //  
   //name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       ");    fitr.push_back("0.01644      ");       pull.push_back(0.742014)    ; // -
   //name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            ");    fitr.push_back("41.48        ");       pull.push_back(1.51492)     ; // -
   //name.push_back("m_{h} >       ");               meas.push_back("114.4                     ");    fitr.push_back("113.3        ");       pull.push_back(0.371)       ; // -
   //name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         ");    fitr.push_back("127.924      ");       pull.push_back(0.08125)     ; // -
   //name.push_back("G_{F}         ");               meas.push_back("1.16637 10^{-5} #pm 10^{-10}");  fitr.push_back("1.16637 10^{-5}");     pull.push_back(0)           ; //  
   //name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         ");    fitr.push_back("0.1177       ");       pull.push_back(0.06885)     ; // -
   //name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        ");    fitr.push_back("91.1871      ");       pull.push_back(0.17619)     ; // -
   //name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              ");    fitr.push_back("4.2          ");       pull.push_back(0)           ; // -
   //name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             ");    fitr.push_back("172.4        ");       pull.push_back(0.016)       ; // -
   // name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684      ");       pull.push_back(0)           ; // -
   // name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2          ");       pull.push_back(0.636364)    ; //  

   //  // old GMSB
   //  name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           "); fitr.push_back("1.138         ");  pull.push_back(0.16793)    ; //  
   //  name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             "); fitr.push_back("1.02          ");  pull.push_back(0.272472)   ; // -
   //  name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              "); fitr.push_back("0.92          ");  pull.push_back(0.585147)   ; // -
   //  name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             "); fitr.push_back("0.99          ");  pull.push_back(0.00958694) ; //  
   //  name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           "); fitr.push_back("0.999         ");  pull.push_back(0.625805)   ; // -
   //  name.push_back("(g-2)_{#mu}   ");               meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.99 10^{-09} ");  pull.push_back(0.0283529)  ; // -
   //  name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          "); fitr.push_back("80.378        ");  pull.push_back(0.783597)   ; // -
   //  name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         "); fitr.push_back("0.2314        ");  pull.push_back(0.839658)   ; // -
   //  name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           "); fitr.push_back("2495.08       ");  pull.push_back(0.0466908)  ; //  
   //  name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          "); fitr.push_back("20.743        ");  pull.push_back(0.96356)    ; //  
   //  name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       "); fitr.push_back("0.21603       ");  pull.push_back(0.400333)   ; // -
   //  name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          "); fitr.push_back("0.1722        ");  pull.push_back(0.03595)    ; // -
   //  name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         "); fitr.push_back("0.1038        ");  pull.push_back(2.88566)    ; //  
   //  name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         "); fitr.push_back("0.0742        ");  pull.push_back(1.00116)    ; //  
   //  name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            "); fitr.push_back("0.935         ");  pull.push_back(0.601613)   ; //  
   //  name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            "); fitr.push_back("0.67          ");  pull.push_back(0.0621656)  ; // -
   //  name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         "); fitr.push_back("0.1480        ");  pull.push_back(1.55209)    ; // -
   //  name.push_back("m_{h}         ");               meas.push_back("114.4                     "); fitr.push_back("113.3         ");  pull.push_back(0.378)      ; // -
   //  name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         "); fitr.push_back("0.1100        ");  pull.push_back(0.00558672) ; //  
   //  name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         "); fitr.push_back("0.1480        ");  pull.push_back(0.481441)   ; //  
   //  name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       "); fitr.push_back("0.01644       ");  pull.push_back(0.739983)   ; // -
   //  name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            "); fitr.push_back("41.48         ");  pull.push_back(1.49357)    ; // -
   //  name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             "); fitr.push_back("1.02          ");  pull.push_back(0.733964)   ; //  
   //  name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             "); fitr.push_back("1.00          ");  pull.push_back(0.561576)   ; // -
   //  name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         "); fitr.push_back("127.925       ");  pull.push_back(0)          ; // -
   //  name.push_back("G_{F}         ");               meas.push_back("1.16637 10^{-5} #pm 10^{-10}"); fitr.push_back("1.16637 10^{-5}   ");  pull.push_back(0)          ; //  
   //  name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         "); fitr.push_back("0.1176	   ");  pull.push_back(0)          ; // -
   //  name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        "); fitr.push_back("91.1875       ");  pull.push_back(0)          ; // -
   //  name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              "); fitr.push_back("4.2	   ");  pull.push_back(0)          ; // -
   //  name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             "); fitr.push_back("172.4	   ");  pull.push_back(0)          ; // -
   //  name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684       ");  pull.push_back(0)          ; // -
   //  name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2           ");  pull.push_back(0)          ; //  

   // old mSUGRA
   //name.push_back("BR(b#rightarrow s#gamma)");     meas.push_back("1.117 #pm 0.122           "); fitr.push_back("1.014      "); pull.push_back(0.839753)   ; //  
   //name.push_back("#Delta(m_{s})");                meas.push_back("1.11 #pm 0.32             "); fitr.push_back("1.03       "); pull.push_back(0.243694)   ; // -
   //name.push_back("BR(b#rightarrow #tau#nu)");     meas.push_back("1.15 #pm 0.4              "); fitr.push_back("0.96       "); pull.push_back(0.478271)   ; // -
   //name.push_back("BR(B_{s}#rightarrow X_{s}ll)"); meas.push_back("0.99 #pm 0.32             "); fitr.push_back("0.99       "); pull.push_back(0.00391203) ; //  
   //name.push_back("BR(K#rightarrow l#nu) ");       meas.push_back("1.008 #pm 0.014           "); fitr.push_back("1.000      "); pull.push_back(0.597855)   ; // -
   //name.push_back("(g-2)_{#mu}   ");            meas.push_back("3.02 10^{-9} #pm 9.0 10^{-10}"); fitr.push_back("2.54 10^{-09}"); pull.push_back(0.535321) ; // -
   //name.push_back("m_{W}         ");               meas.push_back("80.399 #pm 0.027          "); fitr.push_back("80.381     "); pull.push_back(0.6753)     ; // -
   //name.push_back("sin#theta_{eff}");              meas.push_back("0.2324 #pm 0.0012         "); fitr.push_back("0.2314     "); pull.push_back(0.841958)   ; // -
   //name.push_back("#Gamma_{Z}    ");               meas.push_back("2495.2 #pm 2.51           "); fitr.push_back("2495.2     "); pull.push_back(0.0162282)  ; //  
   //name.push_back("R_{l}           ");             meas.push_back("20.767 #pm 0.025          "); fitr.push_back("20.744     "); pull.push_back(0.93888)    ; //  
   //name.push_back("R_{b}           ");             meas.push_back("0.21629 #pm 0.00066       "); fitr.push_back("0.21604    "); pull.push_back(0.382667)   ; // -
   //name.push_back("R_{c}           ");             meas.push_back("0.1721 #pm 0.003          "); fitr.push_back("0.1722     "); pull.push_back(0.03431)    ; // -
   //name.push_back("A_{b}^{fb}      ");             meas.push_back("0.0992 #pm 0.0016         "); fitr.push_back("0.1038     "); pull.push_back(2.89251)    ; //  
   //name.push_back("A_{c}^{fb}      ");             meas.push_back("0.0707 #pm 0.0035         "); fitr.push_back("0.0742     "); pull.push_back(1.0044)     ; //  
   //name.push_back("A_{b}           ");             meas.push_back("0.923 #pm 0.02            "); fitr.push_back("0.935      "); pull.push_back(0.599688)   ; //  
   //name.push_back("A_{c}           ");             meas.push_back("0.67 #pm 0.027            "); fitr.push_back("0.67       "); pull.push_back(0.0620163)  ; // -
   //name.push_back("A_{l}           ");             meas.push_back("0.1513 #pm 0.0021         "); fitr.push_back("0.1481     "); pull.push_back(1.54174)    ; // -
   //name.push_back("m_{h}         ");               meas.push_back("114.4                     "); fitr.push_back("113.2      "); pull.push_back(0.3923)     ; // -
   //name.push_back("#Omega_{DM}   ");               meas.push_back("0.1099 #pm 0.0135         "); fitr.push_back("0.1085     "); pull.push_back(0.10401)    ; //  
   //name.push_back("A_{#tau}      ");               meas.push_back("0.1465 #pm 0.0032         "); fitr.push_back("0.1481     "); pull.push_back(0.488231)   ; //  
   //name.push_back("A_{l}^{fb}    ");               meas.push_back("0.01714 #pm 0.00095       "); fitr.push_back("0.01644    "); pull.push_back(0.734903)   ; // -
   //name.push_back("#sigma_{had}^{0}");             meas.push_back("41.54 #pm 0.04            "); fitr.push_back("41.48      "); pull.push_back(1.52035)    ; // -
   //name.push_back("#Delta_{m_{K}}");               meas.push_back("0.92 #pm 0.14             "); fitr.push_back("1.03       "); pull.push_back(0.799217)   ; //  
   //name.push_back("#Delta_{m_{s}}/#Delta_{m_{d}}");meas.push_back("1.09 #pm 0.16             "); fitr.push_back("1.00       "); pull.push_back(0.562134)   ; // -
   //name.push_back("#alpha_{em}^{-1}");             meas.push_back("127.925 #pm 0.016         "); fitr.push_back("127.923    "); pull.push_back(0.125)      ; // -
   //name.push_back("G_{F}         ");             meas.push_back("1.16637 10^{-5} #pm 10^{-10}"); fitr.push_back("1.16637 10^{-05}"); pull.push_back(0)     ; //  
   //name.push_back("#alpha_{s}    ");               meas.push_back("0.1176 #pm 0.0020         "); fitr.push_back("0.1176     "); pull.push_back(0)          ; // -
   //name.push_back("m_{Z}         ");               meas.push_back("91.1875 #pm 0.0021        "); fitr.push_back("91.1874    "); pull.push_back(0.0571429)  ; // -
   //name.push_back("m_{b}         ");               meas.push_back("4.2 #pm 0.17              "); fitr.push_back("4.2        "); pull.push_back(0)          ; // -
   //name.push_back("m_{t}         ");               meas.push_back("172.4 #pm 1.2             "); fitr.push_back("172.4      "); pull.push_back(0)          ; // -
   //name.push_back("m_{#tau}      ");               meas.push_back("1.77684 #pm 0.00017       "); fitr.push_back("1.77684    "); pull.push_back(0)          ; // -
   //name.push_back("m_{c}         ");               meas.push_back("1.2 #pm 0.11              "); fitr.push_back("1.2        "); pull.push_back(0)          ; //  


   Double_t pullSum = 0.;
   // Loop over all obserbables.
   // Currently the observable indices range from 1 to 9 as specified in FileSettings.C and
   // HistogramSettings.C.
   for (Int_t iObservable = 1; iObservable <= 9 ; ++iObservable)
   {
      // Fill the observable name.
      string observableName((histogramSetup[iObservable]->GetAxisLabel()).Data());
      name.push_back(observableName);

      // Fill the measured values.
      stringstream dataMantissaStringStream,
		   dataErrorMantissaStringStream,
		   dataExponentStringStream;

      dataExponentStringStream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iObservable]->GetDataValue())));
      string dataexponent(dataExponentStringStream.str());

      dataMantissaStringStream << std::setprecision(histogramSetup[iObservable]->GetDataPrecision()) << std::showpoint
	 <<   histogramSetup[iObservable]->GetDataValue()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iObservable]->GetDataValue()))));
      string datamantissa(dataMantissaStringStream.str());

      dataErrorMantissaStringStream << std::setprecision(histogramSetup[iObservable]->GetDataPrecision())
	 <<   histogramSetup[iObservable]->GetDataError()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iObservable]->GetDataValue()))));
      string dataerrormantissa(dataErrorMantissaStringStream.str());

      string measuredValue = "(" + datamantissa + " #pm "
	 + dataerrormantissa + ")"
	 + " #times10^{" + dataexponent + "}";
      meas.push_back(measuredValue);

      // Fill the best fit values.
      stringstream mantissaStringStream,
		   exponentStringStream;

      exponentStringStream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iObservable]->GetBestFitPoint())));
      string exponent(exponentStringStream.str());

      mantissaStringStream << std::setprecision(3) << std::showpoint
	 <<   histogramSetup[iObservable]->GetBestFitPoint()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iObservable]->GetBestFitPoint()))));
      string mantissa(mantissaStringStream.str());

      string bestFitValue = mantissa + " #times10^{" + exponent + "}";
      fitr.push_back(bestFitValue);

      // Fill the pull value.
      double pullValue = fabs(histogramSetup[iObservable]->GetDataValue() -
	    histogramSetup[iObservable]->GetBestFitPoint())
	 / histogramSetup[iObservable]->GetDataError();
      cout << observableName << " " << pullValue << " " << TMath::Power(pullValue, 2) << endl;
      pullSum + = TMath::Power(pullValue, 2);
      pull.push_back(pullValue);
   }
   cout << pullSum << endl;

   if (pull.size()!=name.size()) {
      cout << "setup error" << endl;
      return;
   }

   // fill histogram
   string histTitle = modelName + " fit to " + data;
   cout << "creating histogram with title " << histTitle.c_str() << endl;
   TH1D* residualHist = new TH1D("residualHist",histTitle.c_str(),pull.size(),0,(int)pull.size());
   for (UInt_t i = 0; i<name.size(); i++) {
      residualHist->SetBinContent(i+1,pull[i]);
      string binName = name[i] + meas[i] + fitr[i];
      //    residualHist->GetXaxis()->SetBinLabel(i+1,binName.c_str());
      residualHist->GetXaxis()->SetBinLabel(i+1," ");
   }
   //residualHist->SetBarWidth(1.0);
   //residualHist->SetBarOffset(0.0);
   residualHist->SetMaximum(3.);
   residualHist->SetMinimum(0.);
   //residualHist->SetFillColor(kBlue-2);
   residualHist->SetFillColor(kBlue-6);
   //residualHist->SetLineColor(kBlue+2);
   //residualHist->SetTitleSize(2.);
   //residualHist->SetTitleOffset(-1.0);
   residualHist->GetYaxis()->SetTitle("|Meas.-Fit|/ #sigma");
   //residualHist->GetYaxis()->SetTitleOffset(0.8);
   //residualHist->GetYaxis()->SetLabelOffset(0.0);
   residualHist->GetYaxis()->SetTitleOffset(1.0);
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
      t->DrawLatex(-5.70,0.2+(double)i,name[i].c_str());
      t->DrawLatex(-4.00,0.2+(double)i,meas[i].c_str());
      t->DrawLatex(-1.50,0.2+(double)i,fitr[i].c_str());
   }

   myText(0.76, 0.87, kBlack, model);
   //myText(0.62, 0.87, kBlack, "Hallo");

   // Draw the Fittino logo.
   TImage *fittinoLogo = 0;
   std::string logoPath = "./fittinologoWINTER1213_white.png";
   if (logoPath!="") {
      fittinoLogo = TImage::Open(logoPath.c_str());
      if (!fittinoLogo) {
	 printf("Could not open the fittino logo at %s\n exit\n",logoPath.c_str());
	 return;
      }
      fittinoLogo->SetConstRatio(1);
      fittinoLogo->SetImageQuality(TAttImage::kImgBest);

      const float canvasHeight   = canvas->GetWindowHeight();
      const float canvasWidth    = canvas->GetWindowWidth();
      const float canvasAspectRatio = canvasHeight/canvasWidth;
      const float width          = 0.22;
      const float xLowerEdge     = 0.02;
      const float yLowerEdge     = 0.88;
      const float xUpperEdge     = xLowerEdge+width;
      const float yUpperEdge     = yLowerEdge+width*fittinoLogo->GetHeight()/fittinoLogo->GetWidth()/canvasAspectRatio;
      TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0., 0.8, 0.2, 1.);
      fittinoLogoPad->Draw("same");
      fittinoLogoPad->cd();
      fittinoLogo->Draw("xxx");
      canvas->cd();
   }

   c->Print("individualPullContrib.eps");
   if (logoPath!="") {
      fittinoLogo->Delete();
   }

   gSystem->Exit(0);
}
