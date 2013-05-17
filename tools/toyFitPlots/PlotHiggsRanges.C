
// File     PlotHiggsRanges.C
//
// Usage    root -b PlotHiggsRanges.C
//
// Authors  Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>


#include <iostream>
#include <vector>

#include "TROOT.h"
#include "TFile.h"
#include "TStyle.h"
#include "TGraphAsymmErrors.h"
#include "TCanvas.h"
#include "TAxis.h"
#include "TH1F.h"
#include "TLine.h"
#include "TImage.h"
#include "TAttImage.h"
#include "TSystem.h"
#include "TLegend.h"

#include "style/AtlasStyle.h"
#include "style/AtlasLabels.h"
#include "style/AtlasUtils.h"

void PlotHiggsRanges()
{
   // General settings.
   //TString plotType = "BranchingRatios";
   //TString plotType = "PartialWidths";
   //TString plotType = "RValues";
   TString plotType = "RatioFractions";

   TFile* file = TFile::Open( "~sarrazin/public/confidenceInterval3.root", "READ" );

   // Style settings.
   gROOT->LoadMacro("style/AtlasLabels.C");
   gROOT->LoadMacro("style/AtlasStyle.C");
   gROOT->LoadMacro("style/AtlasUtils.C");

   SetAtlasStyle();

   gStyle->SetNdivisions(0, "Y");

   // Specify the leaves in the plot.
   //const Int_t numberOfLeaves = 7;

   if (plotType == "BranchingRatios")
   {
      const Int_t numberOfLeaves = 11;
      std::vector<Float_t>* leaf[10] = {};
   }
   else if (plotType == "PartialWidths")
   {
      const Int_t numberOfLeaves = 7;
      std::vector<Float_t>* leaf[6] = {};
   }
   else if (plotType == "RValues")
   {
      const Int_t numberOfLeaves = 7;
      std::vector<Float_t>* leaf[6] = {};
   }
   else if (plotType == "RatioFractions")
   {
      const Int_t numberOfLeaves = 6;
      std::vector<Float_t>* leaf[5] = {};
   }

   //std::vector<std::vector<Float_t>>* test;

   TTree* tree = 0;

   if (file)
   {
      tree = (TTree*)file->Get("markovChain");

      if (plotType == "BranchingRatios")
      {
	 //tree->SetBranchAddress("O_h0_To_Z_Gamma_norm",               &leaf[0]);
	 //tree->SetBranchAddress("O_h0_To_Z_Z_norm_fromG2",            &leaf[1]);
	 //tree->SetBranchAddress("O_h0_To_W_W_norm_fromG2",            &leaf[2]);
	 //tree->SetBranchAddress("O_h0_To_Gamma_Gamma_norm",           &leaf[3]);
	 //tree->SetBranchAddress("O_h0_To_Gluon_Gluon_norm_fromG2",    &leaf[4]);
	 //tree->SetBranchAddress("O_h0_To_Bottom_Bottom~_norm_fromG2", &leaf[5]);
	 //tree->SetBranchAddress("O_h0_To_Charm_Charm~_norm",          &leaf[6]);
	 //tree->SetBranchAddress("O_h0_To_Strange_Strange~_norm",      &leaf[7]);
	 //tree->SetBranchAddress("O_h0_To_Tau_Tau~_norm_fromG2",       &leaf[8]);
	 //tree->SetBranchAddress("O_h0_To_Muon_Muon~_norm",            &leaf[9]);

	 tree->SetBranchAddress("O_h0_To_Z_Gamma_norm",               &leaf[0]);
	 tree->SetBranchAddress("O_h0_To_Z_Z_norm",                   &leaf[1]);
	 tree->SetBranchAddress("O_h0_To_W_W_norm",                   &leaf[2]);
	 tree->SetBranchAddress("O_h0_To_Gamma_Gamma_norm",           &leaf[3]);
	 tree->SetBranchAddress("O_h0_To_Gluon_Gluon_norm",           &leaf[4]);
	 tree->SetBranchAddress("O_h0_To_Bottom_Bottom~_norm",        &leaf[5]);
	 tree->SetBranchAddress("O_h0_To_Charm_Charm~_norm",          &leaf[6]);
	 tree->SetBranchAddress("O_h0_To_Strange_Strange~_norm",      &leaf[7]);
	 tree->SetBranchAddress("O_h0_To_Tau_Tau~_norm",              &leaf[8]);
	 tree->SetBranchAddress("O_h0_To_Muon_Muon~_norm",            &leaf[9]);

      }
      else if (plotType == "PartialWidths")
      {
	 //tree->SetBranchAddress("O_HiggsBosonCoupling3252322_fromBR",         &leaf[0]); // hZgamma
	 tree->SetBranchAddress("O_HiggsBosonCoupling3252323",                  &leaf[0]); // hZZ
	 tree->SetBranchAddress("O_HiggsBosonCoupling3252424",                  &leaf[1]); // hWW
	 //tree->SetBranchAddress("O_HiggsBosonCoupling3252222_fromBR",         &leaf[2]); // hgammagamma
	 tree->SetBranchAddress("O_HiggsBosonCoupling3252121",                  &leaf[2]); // hgg
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250606",          &leaf[3]); // htt
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250505",          &leaf[4]); // hbb
	 //tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250404_fromBR", &leaf[6]); // hcc
	 //tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250303_fromBR", &leaf[7]); // hss
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3251515",          &leaf[5]); // htautau
	 //tree->SetBranchAddress("O_HiggsScalarFermionCoupling3251313_fromBR", &leaf[9]); // hmumu
      }
      else if (plotType == "RValues")
      {
	 tree->SetBranchAddress("HS_R_H_ZZ",     &leaf[0]);
	 tree->SetBranchAddress("HS_R_H_WW",     &leaf[1]);
	 tree->SetBranchAddress("HS_R_H_gaga",   &leaf[2]);
	 tree->SetBranchAddress("HS_R_VH_bb",    &leaf[3]);
	 tree->SetBranchAddress("HS_R_H_bb",     &leaf[4]);
	 tree->SetBranchAddress("HS_R_H_tautau", &leaf[5]);
      }
      else if (plotType == "RatioFractions")
      {
	 //tree->SetBranchAddress("O_HiggsBosonCoupling3252323_hZZ",       &leaf[0]); // hZZ
	 tree->SetBranchAddress("O_HiggsBosonCoupling3252424_hZZ",         &leaf[0]); // hWW
	 tree->SetBranchAddress("O_HiggsBosonCoupling3252121_hZZ",         &leaf[1]); // hgg
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250606_hZZ", &leaf[2]); // htt
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3250505_hZZ", &leaf[3]); // hbb
	 tree->SetBranchAddress("O_HiggsScalarFermionCoupling3251515_hZZ", &leaf[4]); // htautau
      }
      else
      {
	 std::cout << "ERROR: Unknown type of plot." << std::endl;
	 gSystem->Exit(0);
      }
   }
   else
   {
      std::cout << "ERROR: Input file does not exist." << std::endl;
      gSystem->Exit(0);
   }

   const Int_t n = numberOfLeaves;
   Double_t x[n], y[n];
   Double_t x0[n], y0[n];
   for (Int_t i = 0; i < n-1; i++) {
      x0[i] = 1.;
      x[i] = 1.;
      y0[i] = i;
      y[i] = i;
   }
   Double_t BRMinima[n];
   Double_t BRMaxima[n];
   Double_t BRMinima0[n];
   Double_t BRMaxima0[n];
   for (Int_t i = 0; i < n-1; i++) {
      BRMinima0[i] = 0.01;
      BRMaxima0[i] = 0.02;
      BRMinima[i] = 0.01;
      BRMaxima[i] = 0.02;
   }

   double leftvalue0[10];
   double rightvalue0[10];
   double leftvalue[10];
   double rightvalue[10];
   double x1[10];

   if (file)
      for (Int_t iEntry = 0; iEntry < tree->GetEntries(); ++iEntry)
      {
	 tree->GetEntry(iEntry);

	 for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
	    leftvalue0[j] = leaf[j]->at(0);

	 leftvalue0[numberOfLeaves - 1] = 1.;

	 for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
	    leftvalue[j] = leaf[j]->at(1);

	 leftvalue[numberOfLeaves - 1] = 1.;

	 for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
	    x1[j] = leaf[j]->at(2);

	 x1[numberOfLeaves - 1] = 10.;

	 for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
	    rightvalue[j] = leaf[j]->at(3);

	 rightvalue[numberOfLeaves - 1] = 1.;

	 for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
	    rightvalue0[j] = leaf[j]->at(4);

	 rightvalue0[numberOfLeaves - 1] = 1.;

      }

   for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
   {
      x0[j] = (leftvalue0[j] + rightvalue0[j]) / 2.;
      BRMinima0[j] = fabs(leftvalue0[j]-x0[j]);
      BRMaxima0[j] = fabs(rightvalue0[j]-x0[j]);
   }

   x0[numberOfLeaves - 1] = 1.;
   y0[numberOfLeaves - 1] = -10.; 
   BRMinima0[numberOfLeaves - 1] = 0.56;
   BRMaxima0[numberOfLeaves - 1] = 0.76;

   for (unsigned int j = 0; j < numberOfLeaves - 1; j++)
   {
      x[j] = (leftvalue[j] + rightvalue[j]) / 2.;
      BRMinima[j] = fabs(leftvalue[j]-x[j]);
      BRMaxima[j] = fabs(rightvalue[j]-x[j]);
   }

   x[numberOfLeaves - 1] = 1.;
   y[numberOfLeaves - 1] = -10.; 
   BRMinima[numberOfLeaves - 1] = 0.45;
   BRMaxima[numberOfLeaves - 1] = 0.46;

   TGraphAsymmErrors* ranges = new TGraphAsymmErrors(n, x, y, BRMinima, BRMaxima);
   TGraphAsymmErrors* ranges0 = new TGraphAsymmErrors(n, x0, y0, BRMinima0, BRMaxima0);

   // Make the plots.
   TCanvas* canvas = new TCanvas("Canvas", "Canvas", 800, 600);

   ranges->SetLineWidth(20);
   ranges->SetLineColor(kBlue - 2);
   ranges->SetMarkerColor(kBlue - 2);
   ranges->SetMarkerSize(0.);

   ranges0->GetYaxis()->SetRangeUser(-1., numberOfLeaves - 1);
   ranges0->SetLineWidth(20);
   ranges0->SetLineColor(kBlue - 6);
   ranges0->SetMarkerColor(kBlue - 6);
   ranges0->SetMarkerSize(0.);
   if ( plotType == "BranchingRatios" ) ranges0->GetXaxis()->SetTitle("BR^{CMSSM} / BR^{SM}");
   //if ( plotType == "PartialWidths" )   ranges0->GetXaxis()->SetTitle("#Gamma^{CMSSM} / #Gamma^{SM}");
   if ( plotType == "PartialWidths" )   ranges0->GetXaxis()->SetTitle("g^{2 CMSSM} / g^{2 SM}");
   //if ( plotType == "PartialWidths" )   ranges0->GetXaxis()->SetTitle("(g^{2})^{CMSSM} / (g^{2})^{SM}");
   if ( plotType == "RValues" )         ranges0->GetXaxis()->SetTitle("(#sigma #times BR)^{CMSSM} / (#sigma #times BR)^{SM}");
   if ( plotType == "RatioFractions" )  ranges0->GetXaxis()->SetTitle("(g^{2 CMSSM} / g^{2 SM}) / (g_{hZZ}^{2 CMSSM} / g_{hZZ}^{2 SM})");

   ranges0->Draw("APE1");

   // Draw a vertical black line at the SM expectation.
   TLine line;
   line.DrawLine(1.,-1.,1.,numberOfLeaves - 1.);

   ranges0->Draw("PE1SAME");
   ranges->Draw("PE1SAME");

   // Draw a red line at the best fit point.
   Double_t y1[11] = {0.,
      1.,
      2.,
      3.,
      4.,
      5.,
      6.,
      7.,
      8.,
      9.,
      9.
   };

   Double_t xErrorUp[11] = {0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002
   };

   Double_t xErrorLow[11] = {0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002,
      0.002
   };

   TGraphAsymmErrors* graph = new TGraphAsymmErrors(10, x1, y1, xErrorUp, xErrorLow);
   graph->SetMarkerColor(kRed);
   graph->SetMarkerSize(0);
   graph->SetLineWidth(20);
   graph->SetLineColor(kRed);
   graph->Draw("PE1SAME");

   // Draw a legend.
   TH1F* dummyhist = new TH1F("Dummy", "Dummy", 2, 0., 2.);
   dummyhist->SetFillColor(kBlue - 2);
   dummyhist->SetLineColor(kBlue - 2);

   TH1F* dummyhist0 = new TH1F("Dummy0", "Dummy0", 2, 0., 2.);
   dummyhist0->SetFillColor(kBlue - 6);
   dummyhist0->SetLineColor(kBlue - 6);

   TH1F* dummyhist1 = new TH1F("Dummy1", "Dummy1", 2, 0., 2.);
   dummyhist1->SetLineColor(kRed);

   TLegend legend( 0.65, 0.34, 0.85, 0.50 );
   legend.SetShadowColor(0);
   legend.SetLineColor(0);
   legend.SetTextSize(0.05);
   legend.SetFillColor(0);
   legend.AddEntry(dummyhist1, "Best fit point", "l");
   legend.AddEntry(dummyhist,  "1D 1#sigma", "f");
   legend.AddEntry(dummyhist0, "1D 2#sigma", "f");
   legend.Draw();

   // Set the y-axis labels.
   if ( plotType == "BranchingRatios" )
   {
      Double_t topLabel = 0.87;
      Double_t bottomLabel = 0.22;
   }
   else if ( plotType == "PartialWidths" )
   {
      Double_t topLabel = 0.83;
      Double_t bottomLabel = 0.25;
   }
   else if ( plotType == "RValues" )
   {
      Double_t topLabel = 0.83;
      Double_t bottomLabel = 0.26;
   }
   else if ( plotType == "RatioFractions" )
   {
      Double_t topLabel = 0.81;
      Double_t bottomLabel = 0.27;
   }

   Double_t increment = (topLabel - bottomLabel) / ( numberOfLeaves - 2 );
   if ( plotType == "BranchingRatios" )
   {
      myText(0.015, topLabel, kBlack, "h #rightarrow #mu#mu");
      myText(0.015, topLabel - 1 * increment, kBlack, "h #rightarrow #tau#tau");
      myText(0.015, topLabel - 2 * increment, kBlack, "h #rightarrow ss");
      myText(0.015, topLabel - 3 * increment, kBlack, "h #rightarrow cc");
      myText(0.015, topLabel - 4 * increment, kBlack, "h #rightarrow bb");
      myText(0.015, topLabel - 5 * increment, kBlack, "h #rightarrow gg");
      myText(0.015, topLabel - 6 * increment, kBlack, "h #rightarrow #gamma#gamma");
      myText(0.015, topLabel - 7 * increment, kBlack, "h #rightarrow WW");
      myText(0.015, topLabel - 8 * increment, kBlack, "h #rightarrow ZZ");
      myText(0.015, topLabel - 9 * increment, kBlack, "h #rightarrow Z#gamma");
   }
   else if ( plotType == "PartialWidths" )
   {
      myText(0.035, topLabel,                 kBlack, "h#tau#tau");
      myText(0.035, topLabel - 1 * increment, kBlack, "hbb");
      myText(0.035, topLabel - 2 * increment, kBlack, "htt");
      myText(0.035, topLabel - 3 * increment, kBlack, "hgg");
      myText(0.035, topLabel - 4 * increment, kBlack, "hWW");
      myText(0.035, topLabel - 5 * increment, kBlack, "hZZ");
   }
   else if ( plotType == "RValues" )
   {
      myText(0.015, topLabel, kBlack, "h #rightarrow #tau#tau");
      myText(0.015, topLabel - 1 * increment, kBlack, "h #rightarrow bb");
      myText(0.015, topLabel - 2 * increment, kBlack, "Vh #rightarrow bb");
      myText(0.015, topLabel - 3 * increment, kBlack, "h #rightarrow #gamma#gamma");
      myText(0.015, topLabel - 4 * increment, kBlack, "h #rightarrow WW");
      myText(0.015, topLabel - 5 * increment, kBlack, "h #rightarrow ZZ");
   }
   else if ( plotType == "RatioFractions" )
   {
      myText(0.035, topLabel,                 kBlack, "h#tau#tau");
      myText(0.035, topLabel - 1 * increment, kBlack, "hbb");
      myText(0.035, topLabel - 2 * increment, kBlack, "htt");
      myText(0.035, topLabel - 3 * increment, kBlack, "hgg");
      myText(0.035, topLabel - 4 * increment, kBlack, "hWW");
   }

   // Specify the model.
   myText(0.66, 0.64, kBlack, "CMSSM");
   myText(0.66, 0.59, kBlack, "All Observables");
   myText(0.66, 0.54, kBlack, "#Deltam_{h} = 3 GeV");

   // Draw the logo.
   TImage *fittinoLogo = 0;
   std::string logoPath = "../../logo/fittinologo_PREL.png";
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
      TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.66, 0.71, 0.88, 0.91);
      fittinoLogoPad->Draw("same");
      fittinoLogoPad->cd();
      fittinoLogo->Draw("xxx");
      canvas->cd();
   }

   // Save the canvas as eps files.
   if      ( plotType == "BranchingRatios" ) canvas->SaveAs("branchingRatiosHDecay_CMSSM_allObs_cat_dmh30.eps");
   else if ( plotType == "PartialWidths" )   canvas->SaveAs("partialWidths_CMSSM_allObs_cat_dmh30.eps");
   else if ( plotType == "RValues" )         canvas->SaveAs("rValues_CMSSM_allObs_cat_dmh30.eps");
   else if ( plotType == "RatioFractions" )  canvas->SaveAs("ratioFractions_CMSSM_allObs_cat_dmh30.eps");
   else                                      canvas->SaveAs("Default.eps");

   gSystem->Exit(0);
}

// Old values.

//double leftvalue0[10] = {4.38877059e-01,
//                         4.54090903e-01,
//                         6.48403478e-01,
//                         6.03761961e-01,
//                         1.04638960e+00,
//                         6.26923075e-01,
//                         6.69177108e-01,
//                         6.94872957e-01,
//                         7.09751333e-01,
//                         1.
//                        };

//double rightvalue0[10] ={1.21577659e+00,
//                         1.10223691e+00,
//                         8.84435828e-01,
//                         7.84781017e-01,
//                         1.23190657e+00,
//                         8.83221975e-01,
//                         9.02969101e-01,
//                         9.12641685e-01,
//                         9.32456413e-01,
//                         1. 
//                        };

////double leftvalue0[10] = {6.57921034e-01,
////                         6.57921034e-01,
////                         9.04289294e-01,
////                         7.79793308e-01,
////                         9.72106034e-01,
////                         8.06934574e-01,
////                         7.94924569e-01,
////                         8.10762682e-01,
////                         8.28131155e-01,
////                         1.
////                        };

////double rightvalue0[10] ={1.23451141e+00,
////                         1.13032828e+00,
////                         9.63070238e-01,
////                         8.93531288e-01,
////                         1.24063153e+00,
////                         1.03141364e+00,
////                         1.01449877e+00,
////                         1.02310721e+00,
////                         1.04541152e+00,
////                         1. 
////                        };

//double leftvalue[10] = {6.34961462e-01,
//                        6.14391135e-01,
//                        6.68037378e-01,
//                        6.05317407e-01,
//                        1.09031785e+00,
//                        6.53306611e-01,
//                        6.97383701e-01,
//                        7.20366885e-01,
//                        7.35753077e-01,
//                        1.
//                       };

//double rightvalue[10] ={8.14601568e-01,
//                        7.87925398e-01,
//                        8.49719655e-01,
//                        7.73701565e-01,
//                        1.16999257e+00,
//                        8.38677380e-01,
//                        8.57558155e-01,
//                        8.71001872e-01,
//                        8.89755730e-01,
//                        1. 
//                       };

////double leftvalue[10] = {8.33491605e-01,
////                        8.11520392e-01,
////                        9.07506261e-01,
////                        8.07999141e-01,
////                        1.06007609e+00,
////                        8.80103115e-01,
////                        8.67190439e-01,
////                        8.80184312e-01,
////                        8.99184879e-01,
////                        1.
////                       };

////double rightvalue[10] ={9.39854362e-01,
////                        9.03996870e-01,
////                        9.46282461e-01,
////                        8.48322569e-01,
////                        1.12034216e+00,
////                        9.31241969e-01,
////                        9.16199035e-01,
////                        9.28051164e-01,
////                        9.48090926e-01,
////                        1. 
////                       };

//// old
////double leftvalue[10] = {5.72282257e-01,
////                        5.69866464e-01,
////                        6.77725093e-01,
////                        5.84038414e-01,
////                        1.02890091e+00,
////                        6.61967859e-01,
////                        7.03666689e-01,
////                        7.17718492e-01,
////                        7.32217558e-01,
////                        1.
////                       };

////double rightvalue[10] ={1.01804185e+00,
////                        9.71339773e-01,
////                        9.47393406e-01,
////                        8.52846988e-01,
////                        1.14649772e+00,
////                        9.87595148e-01,
////                        9.89666635e-01,
////                        9.82439912e-01,
////                        1.00228223e+00,
////                        1. 
////                       };

////double leftvalue[10] = {8.87392073e-01,
////                        8.67325062e-01,
////                        9.87235952e-01,
////                        8.65696369e-01,
////                        9.89279918e-01,
////                        9.93626076e-01,
////                        9.63583117e-01,
////                        9.57335911e-01,
////                        9.76536830e-01,
////                        1.
////                       };

////double rightvalue[10] ={1.05561312e+00,
////                        1.01288106e+00,
////                        1.02948949e+00,
////                        9.08531521e-01,
////                        1.05806679e+00,
////                        1.05240796e+00,
////                        1.03223100e+00,
////                        1.02393750e+00,
////                        1.04458004e+00,
////                        1. 
////                       };
