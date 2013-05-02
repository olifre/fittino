PlotHiggsRanges()
{
    gROOT->LoadMacro("style/AtlasLabels.C");
    gROOT->LoadMacro("style/AtlasStyle.C");
    gROOT->LoadMacro("style/AtlasUtils.C");

    SetAtlasStyle();

    gStyle->SetNdivisions(0, "Y");
    const Int_t n = 10;
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

    double leftvalue0[10] = {4.38877059e-01,
                             4.54090903e-01,
                             6.48403478e-01,
                             6.03761961e-01,
                             1.04638960e+00,
                             6.26923075e-01,
                             6.69177108e-01,
                             6.94872957e-01,
                             7.09751333e-01,
                             1.
                            };

    double rightvalue0[10] ={1.21577659e+00,
                             1.10223691e+00,
                             8.84435828e-01,
                             7.84781017e-01,
                             1.23190657e+00,
                             8.83221975e-01,
                             9.02969101e-01,
                             9.12641685e-01,
                             9.32456413e-01,
                             1. 
                            };

    //double leftvalue0[10] = {6.57921034e-01,
    //                         6.57921034e-01,
    //                         9.04289294e-01,
    //                         7.79793308e-01,
    //                         9.72106034e-01,
    //                         8.06934574e-01,
    //                         7.94924569e-01,
    //                         8.10762682e-01,
    //                         8.28131155e-01,
    //                         1.
    //                        };

    //double rightvalue0[10] ={1.23451141e+00,
    //                         1.13032828e+00,
    //                         9.63070238e-01,
    //                         8.93531288e-01,
    //                         1.24063153e+00,
    //                         1.03141364e+00,
    //                         1.01449877e+00,
    //                         1.02310721e+00,
    //                         1.04541152e+00,
    //                         1. 
    //                        };



    double leftvalue[10] = {6.34961462e-01,
                            6.14391135e-01,
                            6.68037378e-01,
                            6.05317407e-01,
                            1.09031785e+00,
                            6.53306611e-01,
                            6.97383701e-01,
                            7.20366885e-01,
                            7.35753077e-01,
                            1.
                           };

    double rightvalue[10] ={8.14601568e-01,
                            7.87925398e-01,
                            8.49719655e-01,
                            7.73701565e-01,
                            1.16999257e+00,
                            8.38677380e-01,
                            8.57558155e-01,
                            8.71001872e-01,
                            8.89755730e-01,
                            1. 
                           };

    //double leftvalue[10] = {8.33491605e-01,
    //                        8.11520392e-01,
    //                        9.07506261e-01,
    //                        8.07999141e-01,
    //                        1.06007609e+00,
    //                        8.80103115e-01,
    //                        8.67190439e-01,
    //                        8.80184312e-01,
    //                        8.99184879e-01,
    //                        1.
    //                       };

    //double rightvalue[10] ={9.39854362e-01,
    //                        9.03996870e-01,
    //                        9.46282461e-01,
    //                        8.48322569e-01,
    //                        1.12034216e+00,
    //                        9.31241969e-01,
    //                        9.16199035e-01,
    //                        9.28051164e-01,
    //                        9.48090926e-01,
    //                        1. 
    //                       };

    // old
    //double leftvalue[10] = {5.72282257e-01,
    //                        5.69866464e-01,
    //                        6.77725093e-01,
    //                        5.84038414e-01,
    //                        1.02890091e+00,
    //                        6.61967859e-01,
    //                        7.03666689e-01,
    //                        7.17718492e-01,
    //                        7.32217558e-01,
    //                        1.
    //                       };

    //double rightvalue[10] ={1.01804185e+00,
    //                        9.71339773e-01,
    //                        9.47393406e-01,
    //                        8.52846988e-01,
    //                        1.14649772e+00,
    //                        9.87595148e-01,
    //                        9.89666635e-01,
    //                        9.82439912e-01,
    //                        1.00228223e+00,
    //                        1. 
    //                       };

    //double leftvalue[10] = {8.87392073e-01,
    //                        8.67325062e-01,
    //                        9.87235952e-01,
    //                        8.65696369e-01,
    //                        9.89279918e-01,
    //                        9.93626076e-01,
    //                        9.63583117e-01,
    //                        9.57335911e-01,
    //                        9.76536830e-01,
    //                        1.
    //                       };

    //double rightvalue[10] ={1.05561312e+00,
    //                        1.01288106e+00,
    //                        1.02948949e+00,
    //                        9.08531521e-01,
    //                        1.05806679e+00,
    //                        1.05240796e+00,
    //                        1.03223100e+00,
    //                        1.02393750e+00,
    //                        1.04458004e+00,
    //                        1. 
    //                       };

    x0[8] = (leftvalue0[8] + rightvalue0[8]) / 2.;
    BRMinima0[8] = fabs(leftvalue0[8]-x0[8]);
    BRMaxima0[8] = fabs(rightvalue0[8]-x0[8]);

    x0[7] = (leftvalue0[7] + rightvalue0[7]) / 2.;
    BRMinima0[7] = fabs(leftvalue0[7]-x0[7]);
    BRMaxima0[7] = fabs(rightvalue0[7]-x0[7]);

    x0[6] = (leftvalue0[6] + rightvalue0[6]) / 2.;
    BRMinima0[6] = fabs(leftvalue0[6]-x0[6]);
    BRMaxima0[6] = fabs(rightvalue0[6]-x0[6]);

    x0[5] = (leftvalue0[5] + rightvalue0[5]) / 2.;
    BRMinima0[5] = fabs(leftvalue0[5]-x0[5]);
    BRMaxima0[5] = fabs(rightvalue0[5]-x0[5]);

    x0[4] = (leftvalue0[4] + rightvalue0[4]) / 2.;
    BRMinima0[4] = fabs(leftvalue0[4]-x0[4]);
    BRMaxima0[4] = fabs(rightvalue0[4]-x0[4]);

    x0[3] = (leftvalue0[3] + rightvalue0[3]) / 2.;
    BRMinima0[3] = fabs(leftvalue0[3]-x0[3]);
    BRMaxima0[3] = fabs(rightvalue0[3]-x0[3]);

    x0[2] = (leftvalue0[2] + rightvalue0[2]) / 2.;
    BRMinima0[2] = fabs(leftvalue0[2]-x0[2]);
    BRMaxima0[2] = fabs(rightvalue0[2]-x0[2]);

    x0[1] = (leftvalue0[1] + rightvalue0[1]) / 2.;
    BRMinima0[1] = fabs(leftvalue0[1]-x0[1]);
    BRMaxima0[1] = fabs(rightvalue0[1]-x0[1]);

    x0[0] = (leftvalue0[0] + rightvalue0[0]) / 2.;
    BRMinima0[0] = fabs(leftvalue0[0]-x0[0]);
    BRMaxima0[0] = fabs(rightvalue0[0]-x0[0]);

    x0[9] = 1.;
    y0[9] = -10.; 
    BRMinima0[9] = 0.56;
    BRMaxima0[9] = 0.76;

    x[8] = (leftvalue[8] + rightvalue[8]) / 2.;
    BRMinima[8] = fabs(leftvalue[8]-x[8]);
    BRMaxima[8] = fabs(rightvalue[8]-x[8]);

    x[7] = (leftvalue[7] + rightvalue[7]) / 2.;
    BRMinima[7] = fabs(leftvalue[7]-x[7]);
    BRMaxima[7] = fabs(rightvalue[7]-x[7]);

    x[6] = (leftvalue[6] + rightvalue[6]) / 2.;
    BRMinima[6] = fabs(leftvalue[6]-x[6]);
    BRMaxima[6] = fabs(rightvalue[6]-x[6]);

    x[5] = (leftvalue[5] + rightvalue[5]) / 2.;
    BRMinima[5] = fabs(leftvalue[5]-x[5]);
    BRMaxima[5] = fabs(rightvalue[5]-x[5]);

    x[4] = (leftvalue[4] + rightvalue[4]) / 2.;
    BRMinima[4] = fabs(leftvalue[4]-x[4]);
    BRMaxima[4] = fabs(rightvalue[4]-x[4]);

    x[3] = (leftvalue[3] + rightvalue[3]) / 2.;
    BRMinima[3] = fabs(leftvalue[3]-x[3]);
    BRMaxima[3] = fabs(rightvalue[3]-x[3]);

    x[2] = (leftvalue[2] + rightvalue[2]) / 2.;
    BRMinima[2] = fabs(leftvalue[2]-x[2]);
    BRMaxima[2] = fabs(rightvalue[2]-x[2]);

    x[1] = (leftvalue[1] + rightvalue[1]) / 2.;
    BRMinima[1] = fabs(leftvalue[1]-x[1]);
    BRMaxima[1] = fabs(rightvalue[1]-x[1]);

    x[0] = (leftvalue[0] + rightvalue[0]) / 2.;
    BRMinima[0] = fabs(leftvalue[0]-x[0]);
    BRMaxima[0] = fabs(rightvalue[0]-x[0]);

    x[9] = 1.;
    y[9] = -10.; 
    BRMinima[9] = 0.45;
    BRMaxima[9] = 0.46;

    TGraphAsymmErrors* ranges = new TGraphAsymmErrors(n, x, y, BRMinima, BRMaxima);
    TGraphAsymmErrors* ranges0 = new TGraphAsymmErrors(n, x0, y0, BRMinima0, BRMaxima0);

    //Double_t x1[9] = {0.,
    //                  0.,
    //                  0.,
    //                  0.,
    //                  0.,
    //                  0.,
    //                  0.,
    //                  0.,
    //                  0. 
    //                 };
 

    Double_t x1[9] = {0.74,
                      0.72,
                      0.75,
                      0.69,
                      1.13,
                      0.74,
                      0.76,
                      0.79,
                      0.81
                     };
    
    // old
    //Double_t x1[9] = {0.83,
    //                  0.80,
    //                  0.84,
    //                  0.75,
    //                  1.08,
    //                  0.85,
    //                  0.88,
    //                  0.88,
    //                  0.90
    //                 };

    Double_t y1[9] = {0.,
                      1.,
                      2.,
                      3.,
                      4.,
                      5.,
                      6.,
                      7.,
                      8.
                     };

    TGraph* graph = new TGraph(9, x1, y1);

    TCanvas* canvas = new TCanvas("Canvas", "Canvas", 800, 600);
    ranges0->GetYaxis()->SetRangeUser(-1., 9.);
    ranges0->GetXaxis()->SetTitle("BR^{CMSSM} / BR^{SM}");
    ranges0->SetLineWidth(20.);
    ranges->SetLineWidth(20.);
    ranges->SetLineColor(kBlue - 2);
    ranges->SetMarkerColor(kBlue - 2);
    ranges0->SetLineColor(kBlue - 6);
    ranges0->SetMarkerColor(kBlue - 6);
    ranges->SetMarkerSize(0.);
    ranges0->SetMarkerSize(0.);

    ranges0->Draw("APE1");
    //ranges->Draw("APE1");

    TLine line;
    line.DrawLine(1.,-1.,1.,9.);
    ranges0->Draw("PE1SAME");

    TH1F* dummyhist = new TH1F("Dummy", "Dummy", 2, 0., 2.);
    dummyhist->SetFillColor(kBlue - 2);
    dummyhist->SetLineColor(kBlue - 2);

    TH1F* dummyhist0 = new TH1F("Dummy0", "Dummy0", 2, 0., 2.);
    dummyhist0->SetFillColor(kBlue - 6);
    dummyhist0->SetLineColor(kBlue - 6);
    
    TLegend legend( 0.67, 0.43, 0.87, 0.54 );
    //TLegend legend( 0.67, 0.49, 0.87, 0.60 );
    legend.SetShadowColor(0);
    legend.SetLineColor(0);
    legend.SetTextSize(0.05);
    legend.SetFillColor(0);
    //legend.AddEntry(dummyhist, "m_{h} = 126 GeV", "f");
    legend.AddEntry(dummyhist, "m_{h} = 115 GeV", "f");
    legend.AddEntry(dummyhist0, "m_{h} #pm 3 GeV", "f");
    legend.Draw();

    ranges->Draw("PE1SAME");
    //graph->Draw("PSAME");
    myText(0.015, 0.86, kBlack, "h #rightarrow #mu#mu");
    myText(0.015, 0.78, kBlack, "h #rightarrow #tau#tau");
    myText(0.015, 0.70, kBlack, "h #rightarrow ss");
    myText(0.015, 0.62, kBlack, "h #rightarrow cc");
    myText(0.015, 0.54, kBlack, "h #rightarrow bb");
    myText(0.015, 0.46, kBlack, "h #rightarrow gg");
    myText(0.015, 0.38, kBlack, "h #rightarrow #gamma#gamma");
    myText(0.015, 0.30, kBlack, "h #rightarrow WW");
    myText(0.015, 0.22, kBlack, "h #rightarrow ZZ");

    myText(0.68, 0.660, kBlack, "CMSSM");
    myText(0.68, 0.610, kBlack, "LHC");
    myText(0.68, 0.560, kBlack, "HiggsBounds");
    //myText(0.72, 0.550, kBlack, "m_{h} = 115 GeV");
    //myText(0.72, 0.600, kBlack, "m_{h} = 126 GeV");

    TImage *fittinoLogo = 0;
    std::string logoPath = "../../logo/fittinologoSPRING12.png";
    if (logoPath!="") {
      // get the fittino logo
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
      cout << " xLowerEdge  = " << xLowerEdge << "\n"
           << " yLowerEdge  = " << yLowerEdge << "\n"
           << " xUpperEdge  = " << xUpperEdge << "\n"
           << " yUpperEdge  = " << yUpperEdge << "\n"
           << " Imagewidth  = " << fittinoLogo->GetWidth() << "\n"
           << " Imageheight = " << fittinoLogo->GetHeight() << "\n"
           << " canvasHeight= " << canvasHeight << "\n"
           << " canvasWidth = " << canvasWidth  << "\n"
           << endl;
      TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.68, 0.71, 0.88, 0.91);
      //TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.85, 0.85, 0.98, 0.85+fittinoLogo->GetHeight()/fittinoLogo->GetWidth());
      //TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
      fittinoLogoPad->Draw("same");
      fittinoLogoPad->cd();
      fittinoLogo->Draw("xxx");
      canvas->cd();
    }

    canvas->SaveAs("BRRangesLHC2.eps");
    //canvas->SaveAs("BRRangesLHC2H126.eps");
    //canvas->SaveAs("BRRangesNUHM1.eps");

    gSystem->Exit(0);
}
