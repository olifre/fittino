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

#include <iostream>

#include "TCanvas.h"
#include "TFile.h"
#include "TGraph.h"
#include "TH2F.h"
#include "TKey.h"
#include "TList.h"
#include "TSpline.h"
#include "TStyle.h"
#include "TSystem.h"

void EdgeDetectionAlgorithm()
{
    // Setup parameters:
    // Name of the input file.
    const TString inputFileName = "Images.root";
    // Name of the output file.
    const TString outputFileName = "Splines.root";
    // Number of bins of the histograms in the input file.
    const UInt_t numberOfBins = 500;
    // Number of edge cleaning iterations. The edge detection algorithm is applied iteratively on
    // the image of the edge found in the previous step in order to remove outliers. If this number
    // is set to 0, the edge finding algorithm is not applied at all.
    const UInt_t numberOfCleaningSteps = 3;
    // Maximal value of the chi2 in the input file.
    const Double_t chi2Max = 50.;

    // Load and set Atlas style.
    //gROOT->LoadMacro("../slhaparser/style/AtlasLabels.C");
    //gROOT->LoadMacro("../slhaparser/style/AtlasStyle.C");
    //gROOT->LoadMacro("../slhaparser/style/AtlasUtils.C");
    //SetAtlasStyle();

    // Create a new canvas.
    TCanvas* canvas;
    canvas = new TCanvas("Canvas", "Canvas", 600, 600);

    // Set nice palette colors.
    gStyle->SetPalette(1);

    // Remove the statistics box.
    gStyle->SetOptStat(0); // Remove this statement when using Fittino style.

    // Open the input file.
    TFile* inputFile = TFile::Open(inputFileName, "READ");
    TFile outputFile = TFile(outputFileName, "RECREATE");

    // Loop over all images in the root file.
    TList* listOfKeys = (TList*)inputFile->GetListOfKeys();
    TIter next(listOfKeys);
    while (TKey* key = (TKey*) next())
    {
        TObject* object = key->ReadObj();
        if (object->InheritsFrom("TH2F"))
        {
            // Get the original image (original 2D histogram).
            TH2F* histImageOriginal = (TH2F*)object;

            //// Save the original image.
            //histImageOriginal->Draw("COL");
            //canvas->Update();
            //canvas->SaveAs("ImageOriginal" + (TString)histImageOriginal->GetName() + ".eps", "RECREATE");

            // In the first step the contrast of the image is maximized in order to
            // facilitate the edge detection process. This is done by setting every
            // non-vanishing pixel to 1.
            TH2F* histImageHighContrast = (TH2F*)histImageOriginal->Clone();
            for (Int_t iBinX = 0; iBinX < histImageOriginal->GetNbinsX() + 1; ++iBinX)
                for (Int_t iBinY = 0; iBinY < histImageOriginal->GetNbinsY() + 1; ++iBinY)
                {
                    if (histImageOriginal->GetBinContent(iBinX, iBinY) > 0.)
                        histImageHighContrast->SetBinContent(iBinX, iBinY, 1.);
                    else
                        histImageHighContrast->SetBinContent(iBinX, iBinY, 0.);
                }

            // Save the high contrast image.
            //histImageHighContrast->Draw("COL");
            //canvas->Update();
            //canvas->SaveAs("TemporaryDistribution" + (TString)histImageHighContrast->GetName() + ".eps", "RECREATE");

	    // In the second step apply Robert's Cross operator to find the edges in the given
	    // image. Since the algorithm considers outliers as distinct connected areas (and
	    // therefore keeps them) additional cleaning steps are necessary.
            TH2F* histEdge = (TH2F*)histImageOriginal->Clone();
            UInt_t iCleaningStep = 0;
            while (iCleaningStep < numberOfCleaningSteps)
            {
                for (Int_t iBinX = 0; iBinX < histImageHighContrast->GetNbinsX(); ++iBinX)
                    for (Int_t iBinY = 0; iBinY < histImageHighContrast->GetNbinsY(); ++iBinY)
                    {
                        histEdge->SetBinContent(
                                                  iBinX, iBinY,
                                                  fabs(histImageHighContrast->GetBinContent(iBinX, iBinY)
                                                - histImageHighContrast->GetBinContent(iBinX + 1, iBinY + 1))
                                                + fabs(histImageHighContrast->GetBinContent(iBinX + 1, iBinY)
                                                - histImageHighContrast->GetBinContent(iBinX, iBinY + 1))
                                               );
                    }
   
                // Now remove the outliers by substracting the pixels of the edges from the
                // high contrast image.
                for (Int_t iBinX = 0; iBinX < histImageHighContrast->GetNbinsX() + 1; ++iBinX)
                    for (Int_t iBinY = 0; iBinY < histImageHighContrast->GetNbinsY() + 1; ++iBinY)
                    {
                        Double_t difference =   histImageHighContrast->GetBinContent(iBinX, iBinY)
                                              - histEdge->GetBinContent(iBinX, iBinY);
                        if (difference < 0. || difference > 0.)
                           continue;
                        else
                            histImageHighContrast->SetBinContent(iBinX, iBinY, 0.);
                    }
                ++iCleaningStep;
            }

            //// Save the cleaned edge.
            //histEdge->Draw("COL");
            //canvas->Update();
            //canvas->SaveAs("Edge" + (TString)histImageOriginal->GetName() + ".eps", "RECREATE");

            // Calculate the nodes for the spline as the position of the (in
            // y-direction) lowest non-vanishing pixel.
             
            //const UInt_t n = histImageOriginal->GetNbinsX();
            Double_t x[numberOfBins];
            Double_t y[numberOfBins];
            UInt_t iX = 0;

            for (UInt_t iBinX = 0; iBinX < numberOfBins; ++iBinX)
                for (UInt_t iBinY = 0; iBinY < numberOfBins; ++iBinY)
                {
                    if (histEdge->GetBinContent(iBinX, iBinY) > 0.)
                    {
                        x[iBinX] = iBinX * ((histImageOriginal->GetXaxis()->GetXmax() - histImageOriginal->GetXaxis()->GetXmin()) / numberOfBins) + histImageOriginal->GetXaxis()->GetXmin();
                        y[iBinX] = iBinY * ((histImageOriginal->GetYaxis()->GetXmax() - histImageOriginal->GetYaxis()->GetXmin()) / numberOfBins) + histImageOriginal->GetYaxis()->GetXmin();
                        break;
                    }
                    else
                    {
                        x[iBinX] = iBinX * ((histImageOriginal->GetXaxis()->GetXmax() - histImageOriginal->GetXaxis()->GetXmin()) / numberOfBins) + histImageOriginal->GetXaxis()->GetXmin();
                        y[iBinX] = chi2Max;
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
            const UInt_t numberOfNodes = numberOfBins;
            Double_t nodesX[numberOfNodes];
            Double_t nodesY[numberOfNodes];

            //UInt_t iX1 = 0;
            iX = 0;
            while(iX < numberOfBins)
            {
               //Double_t xRowBegin = x[iX];
               //Double_t xRowEnd = xRowBegin;
               //while (y[iX] == y[iX + 1])
               //{
               //    xRowEnd = x[iX];
               //    iX++;
               //}
               //if (xRowBegin == xRowEnd)
               //{
               //    nodesX[iX1] = xRowBegin;
               //    nodesY[iX1] = y[iX];
               //}
               //else
               //{
               //    nodesX[iX1] = fabs((xRowEnd + xRowBegin) / 2.);
               //    nodesY[iX1] = y[iX];
               //}
               //iX = iX + 1;
               //iX1++;
               //std::cout << nodesX[iX] << " " << nodesY[iX] << std::endl;
               nodesX[iX] = x[iX];
               nodesY[iX] = y[iX];
               iX++;
            }

            // Now create a TSpline from the specified points as nodes. The TSpline
            // constructor requires a pointer to a TGraph containing the nodes which
            // has to be created beforehand.
            TGraph* graph = new TGraph(numberOfNodes, nodesX, nodesY);

            TSpline3 spline = TSpline3("Spline", graph);
	    spline.SetName( (TString)histImageOriginal->GetName() );
            spline.SetLineColor(kRed);
            spline.SetLineWidth(4);
            spline.SetNpx(1000);
            
            histImageOriginal->Draw("COL");
            spline.Draw("SAME");

            canvas->SaveAs("Result" + (TString)histImageOriginal->GetName() + ".eps", "RECREATE");

            spline.Write();

            // Cleanup.
            delete graph;
        }
    }
    outputFile.Close();

    std::cout << std::endl;
    gSystem->Exit(0);
}
