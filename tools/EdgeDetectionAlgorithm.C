/* $Id: */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EdgeDetectionAlgorithm.C                                         *
*                                                                              *
* Description This macro tries to find the (lower) edge of a given simply      *
*             connected area contained in a 2D histogram                       *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*	      published by the Free Software Foundation; either version 3 of   *
*	      the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

// DISCLAIMER: This code is still in an experimental stage. It almost certainly
// doesn't work without further ado. For the time being, unneeded intermediate
// steps are commented out.

void EdgeDetectionAlgorithm()
{
    // Load and set Atlas style.
    //gROOT->LoadMacro("../slhaparser/style/AtlasLabels.C");
    //gROOT->LoadMacro("../slhaparser/style/AtlasStyle.C");
    //gROOT->LoadMacro("../slhaparser/style/AtlasUtils.C");
    //SetAtlasStyle();

    // Set nice palette colors.
    gStyle->SetPalette(1);

    // Create a new canvas.
    TCanvas* canvas;
    canvas = new TCanvas("Canvas", "Canvas", 600, 600);

    // Open the input file.
    TFile* file = TFile::Open("/afs/naf.desy.de/user/s/sarrazin/public/Chi2Distribution.root", "READ");

    // Get the original image (original 2D histogram).
    TH2F* histImageOriginal = (TH2F*)file->Get("Chi2Distribution");

    // Save the original image.
    histImageOriginal->GetYaxis()->SetTitle("#chi^{2}");
    histImageOriginal->GetXaxis()->SetTitle("M_{0} [GeV]");
    histImageOriginal->GetXaxis()->SetNdivisions(506);
    histImageOriginal->Draw("COL");
    canvas->Update();
    canvas->SaveAs("ImageOriginal.eps", "RECREATE");

    // In the first step the contrast of the image is maximized in order to
    // facilitate the edge detection process. This is done by setting every
    // non-vanishing pixel to 1.
    TH2F* histImageHighContrast = (TH2F*)histImageOriginal->Clone();
    for (UInt_t iBinX = 0; iBinX < histImageOriginal->GetNbinsX() + 1; ++iBinX)
        for (UInt_t iBinY = 0; iBinY < histImageOriginal->GetNbinsY() + 1; ++iBinY)
        {
            if (histImageOriginal->GetBinContent(iBinX, iBinY) > 0.)
                histImageHighContrast->SetBinContent(iBinX, iBinY, 1.);
            else
                histImageHighContrast->SetBinContent(iBinX, iBinY, 0.);
        }

    // Save the high contrast image.
    //histImageHighContrast->GetYaxis()->SetTitle("#chi^{2}");
    //histImageHighContrast->GetXaxis()->SetTitle("M_{0} [GeV]");
    //histImageHighContrast->Draw("COL");
    //canvas->Update();
    //canvas->SaveAs("TemporaryDistribution.eps", "RECREATE");

    // In the second step apply Robert's Cross operator for the first time to
    // find the edges in the given image. Since the algorithm considers
    // outliers as distinct connected areas (and therefore keeps them)
    // additional cleaning steps are necessary.
    TH2F* histEdge = new TH2F("Edge", "Edge", 100, 0., 500, 100, 0., 15.);
    for (UInt_t iBinX = 0; iBinX < histImageHighContrast->GetNbinsX(); ++iBinX)
        for (UInt_t iBinY = 0; iBinY < histImageHighContrast->GetNbinsY(); ++iBinY)
        {
            histEdge->SetBinContent(
                                      iBinX, iBinY,
                                      fabs(histImageHighContrast->GetBinContent(iBinX, iBinY)
                                    - histImageHighContrast->GetBinContent(iBinX + 1, iBinY + 1))
                                    + fabs(histImageHighContrast->GetBinContent(iBinX + 1, iBinY)
                                    - histImageHighContrast->GetBinContent(iBinX, iBinY + 1))
                                   );
        }

    // Save the found edges.
    //histEdge->GetYaxis()->SetTitle("#chi^{2}");
    //histEdge->GetXaxis()->SetTitle("M_{0} [GeV]");
    //histEdge->Draw("COL");
    //canvas->Update();
    //canvas->SaveAs("Edges.eps", "RECREATE");

    // Now remove the outliers by substracting the pixels of the edges from the
    // high contrast image.
    TH2F* histImageHighContrastCleaned = (TH2F*)histImageHighContrast->Clone();
    for (UInt_t iBinX = 0; iBinX < histImageHighContrast->GetNbinsX() + 1; ++iBinX)
        for (UInt_t iBinY = 0; iBinY < histImageHighContrast->GetNbinsY() + 1; ++iBinY)
        {
            Double_t difference =   histImageHighContrast->GetBinContent(iBinX, iBinY)
                                  - histEdge->GetBinContent(iBinX, iBinY);
            if (difference < 0. || difference > 0.)
                histImageHighContrastCleaned->SetBinContent(
                                                            iBinX, iBinY,
                                                            histImageHighContrast->GetBinContent(iBinX, iBinY)
                                                           );
            else
                histImageHighContrastCleaned->SetBinContent(iBinX, iBinY, 0.);
        }

    //histImageHighContrastCleaned->GetYaxis()->SetTitle("#chi^{2}");
    //histImageHighContrastCleaned->GetXaxis()->SetTitle("M_{0} [GeV]");
    //histImageHighContrastCleaned->Draw("COL");
    //canvas->Update();
    //canvas->SaveAs("FilteredMask.eps", "RECREATE");

    // Now apply Robert's Cross operator again on the cleaned high contrast
    // image to obtain a clean edge.
    TH2F* histEdgeCleaned = new TH2F("EdgeCleaned", "EdgeCleaned", 100, 0., 500, 100, 0., 15.);
    for (UInt_t iBinX = 0; iBinX < histImageHighContrastCleaned->GetNbinsX(); ++iBinX)
        for (UInt_t iBinY = 0; iBinY < histImageHighContrastCleaned->GetNbinsY(); ++iBinY)
        {
            histEdgeCleaned->SetBinContent(
                                             iBinX, iBinY,
                                             fabs(histImageHighContrastCleaned->GetBinContent(iBinX, iBinY)
                                           - histImageHighContrastCleaned->GetBinContent(iBinX + 1, iBinY + 1))
                                           + fabs(histImageHighContrastCleaned->GetBinContent(iBinX + 1, iBinY)
                                           - histImageHighContrastCleaned->GetBinContent(iBinX, iBinY + 1))
                                          );
        }

    // Save the clean edge.
    //histEdgeCleaned->GetYaxis()->SetTitle("#chi^{2}");
    //histEdgeCleaned->GetXaxis()->SetTitle("M_{0} [GeV]");
    //histEdgeCleaned->GetXaxis()->SetNdivisions(506);
    //histEdgeCleaned->Draw("COL");
    //canvas->Update();
    //canvas->SaveAs("Edges2.eps", "RECREATE");

    // Calculate the nodes for the spline as the position of the (in
    // y-direction) lowest non-vanishing pixel.
    const UInt_t n = 100;
    Double_t x[n];
    Double_t y[n];
    UInt_t iX = 0;

    for (UInt_t iBinX = 0; iBinX < n; ++iBinX)
        for (UInt_t iBinY = 0; iBinY < n; ++iBinY)
        {
            if (histEdgeCleaned->GetBinContent(iBinX, iBinY) >= 1.)
            {
                x[iBinX] = iBinX * 5.;
                y[iBinX] = iBinY * 0.15;
                break;
            }
            else
            {
                x[iBinX] = iBinX * 5.;
                y[iBinX] = 14;
            }
        }

    // The last step aims at reducing the number of nodes in order to obtain a
    // smoother spline curve. Rows of adjacent points with the same y-value are
    // replaced by one point in the center of the row as shown below.
    //
    //              o         o        o         o
    //               o     ooo    =>    o      o
    //                ooooo                o
    //
    const UInt_t n1 = 34;
    Double_t x1[n1];
    Double_t y1[n1];
    UInt_t iX1 = 0;

    iX = 7;
    while(iX < n)
    {
       Double_t xRowBegin = x[iX];
       Double_t xRowEnd = xRowBegin;
       while (y[iX] == y[iX + 1])
       {
           xRowEnd = x[iX];
           iX++;
       }
       if (xRowBegin == xRowEnd)
       {
           x1[iX1] = xRowBegin;
           y1[iX1] = y[iX];
       }
       else
       {
           x1[iX1] = fabs((xRowEnd + xRowBegin) / 2.);
           y1[iX1] = y[iX];
       }
       iX = iX + 1;
       iX1++;
    }

    // Now create a TSpline from the specified points as nodes. The TSpline
    // constructor requires a pointer to a TGraph containing the nodes which
    // has to be created beforehand.
    TGraph* graph = new TGraph(n1, x1, y1);
    graph->GetYaxis()->SetTitle("#chi^{2}");
    graph->GetYaxis()->SetRangeUser(0., 15.);
    graph->GetXaxis()->SetTitle("M_{0} [GeV]");
    graph->GetXaxis()->SetRangeUser(0., 500.);
    graph->SetMarkerColor(kRed);
    graph->SetMarkerSize(0.);
    graph->Draw("AP");

    TSpline3 spline = TSpline3("Spline", graph);
    spline.SetLineColor(kRed);
    spline.SetLineWidth(4.);
    spline.SetNpx(1000);
    spline.Draw("SAME");

    canvas->Update();
    canvas->SaveAs("Spline.eps", "RECREATE");

    // Cleanup.
    delete graph;
    delete canvas;

    std::cout << std::endl;
    gSystem->Exit(0);
}
