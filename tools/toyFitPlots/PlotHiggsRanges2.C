PlotHiggsRanges2()
{
    gROOT->LoadMacro("style/AtlasLabels.C");
    gROOT->LoadMacro("style/AtlasStyle.C");
    gROOT->LoadMacro("style/AtlasUtils.C");

    SetAtlasStyle();

    gStyle->SetNdivisions(0, "Y");

    const Int_t n = 6;
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

    //double leftvalue0[6] = {9.64750537e-01,
    //                        8.07048293e-01,
    //                        7.28399354e-01,
    //                        9.49332755e-01,
    //                        7.62247151e-01,
    //                        1.
    //                       };

    //double rightvalue0[6] ={1.10317939e+00,
    //                        1.65561989e+00,
    //                        1.52292604e+00,
    //                        2.71290740e+00,
    //                        1.66223396e+00,
    //                        1. 
    //                       };

    //double leftvalue[6] = {1.03161436e+00,
    //                       1.08467270e+00,
    //                       1.06184762e+00,
    //                       1.38378311e+00,
    //                       1.10543698e+00,
    //                       1.
    //                      };

    //double rightvalue[6] ={1.03401647e+00,
    //                       1.26070630e+00,
    //                       1.06881302e+00,
    //                       1.90431226e+00,
    //                       1.17248906e+00,
    //                       1. 
    //                      };

    double leftvalue0[6] = {1.00086035e+00,
                            8.95699973e-01,
                            7.45963507e-01,
                            8.78837793e-01,
                            7.32181184e-01,
                            1.
                           };

    double rightvalue0[6] ={1.07796949e+00,
                            1.42582680e+00,
                            1.50977497e+00,
                            1.81309609e+00,
                            1.49729105e+00,
                            1. 
                           };

    double leftvalue[6] = {1.02614702e+00,
                           1.12393829e+00,
                           1.01730337e+00,
                           1.19831167e+00,
                           9.93884923e-01,
                           1.
                          };

    double rightvalue[6] ={1.04145465e+00,
                           1.15071830e+00,
                           1.11964748e+00,
                           1.34483222e+00,
                           1.11556896e+00,
                           1. 
                          };

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

    x0[5] = 1.;
    y0[5] = -4.; 
    BRMinima0[5] = 0.58;
    BRMaxima0[5] = 3.5;

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

    x[5] = 1.;
    y[5] = -4.; 
    BRMinima[5] = 0.35;
    BRMaxima[5] = 1.0;

    TGraphAsymmErrors* ranges = new TGraphAsymmErrors(n, x, y, BRMinima, BRMaxima);
    TGraphAsymmErrors* ranges0 = new TGraphAsymmErrors(n, x0, y0, BRMinima0, BRMaxima0);

    TCanvas* canvas = new TCanvas("Canvas", "Canvas", 800, 600);
    ranges0->GetYaxis()->SetRangeUser(-1., 5.);
    ranges0->GetXaxis()->SetTitle("(BR^{CMSSM} / BR^{CMSSM}(h #rightarrow WW)) / (BR^{SM} / BR^{SM}(h #rightarrow WW))");
    ranges0->SetLineWidth(20.);
    ranges->SetLineWidth(20.);
    ranges->SetLineColor(kBlue - 2);
    ranges->SetMarkerColor(kBlue - 2);
    ranges0->SetLineColor(kBlue - 6);
    ranges0->SetMarkerColor(kBlue - 6);
    ranges->SetMarkerSize(0.);
    ranges0->SetMarkerSize(0.);

    ranges0->Draw("APE1");

    TLine line;
    line.DrawLine(1.,-1.,1.,5.);
    ranges0->Draw("PE1SAME");

    TH1F* dummyhist = new TH1F("Dummy", "Dummy", 2, 0., 2.);
    dummyhist->SetFillColor(kBlue - 2);
    dummyhist->SetLineColor(kBlue - 2);

    TH1F* dummyhist0 = new TH1F("Dummy0", "Dummy0", 2, 0., 2.);
    dummyhist0->SetFillColor(kBlue - 6);
    dummyhist0->SetLineColor(kBlue - 6);

    //TLegend legend( 0.67, 0.43, 0.87, 0.54 );
    TLegend legend( 0.67, 0.49, 0.87, 0.60 );
    legend.SetShadowColor(0);
    legend.SetLineColor(0);
    legend.SetTextSize(0.05);
    legend.SetFillColor(0);
    //legend.AddEntry(dummyhist, "m_{h} = 126 GeV", "f");
    legend.AddEntry(dummyhist, "1D 1#sigma ", "f");
    //legend.AddEntry(dummyhist, "m_{h} = 115 GeV", "f");
    //legend.AddEntry(dummyhist0, "m_{h} #pm 3 GeV", "f");
    legend.AddEntry(dummyhist0, "1D 2#sigma", "f");
    legend.Draw();

    ranges->Draw("PE1SAME");
    //graph->Draw("PSAME");
    myText(0.015, 0.80, kBlack, "h #rightarrow #tau#tau");
    myText(0.015, 0.67, kBlack, "h #rightarrow bb");
    myText(0.015, 0.54, kBlack, "h #rightarrow cc");
    myText(0.015, 0.41, kBlack, "h #rightarrow #gamma#gamma");
    myText(0.015, 0.28, kBlack, "h #rightarrow ZZ");

    myText(0.68, 0.660, kBlack, "CMSSM");
    myText(0.68, 0.610, kBlack, "LHC");
    //myText(0.68, 0.560, kBlack, "HiggsBounds");
    //myText(0.72, 0.550, kBlack, "m_{h} = 115 GeV");
    //myText(0.72, 0.560, kBlack, "m_{h} = 126 GeV");

    TImage *fittinoLogo = 0;
    //std::string logoPath = "./fittinologoSPRING12.png";
    std::string logoPath = "../../logo/fittinologo.png";
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

    //canvas->SaveAs("BRRatioRangesLHC2.eps");
    canvas->SaveAs("BRRatioRangesLHC2H126.eps");

    gSystem->Exit(0);
}
