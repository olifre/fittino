// File     PlotToyFits2D.C
//
// Usage    root -b PlotToyFits2D.C
//          For custom output change the parameters in FileSettings.h accordingly
//
// Remarks  This macro requires a style definition which can be set in PlotSettings.C
//
// Authors  Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>

#include <iomanip>

void PlotToyFits2D()
{
   // Set the plot settings.
   gROOT->LoadMacro("PlotSettings.C");
   PlotSettings();

   // Set the file settings.
   gROOT->LoadMacro("FileSettings.C");
   FileSettings();

   // Set the histogram settings.
   gROOT->LoadMacro("HistogramSettings2D.C");
   HistogramSettings2D();

   UInt_t histogramCounter = 0;

   // Fill the histograms.
   // Check if the specified input file exists.
   if (file)
      for (Int_t iEntry = 0; iEntry < tree->GetEntries(); ++iEntry)
      {
         tree->GetEntry(iEntry);
         histogramCounter = 0;
         for (Int_t iHistogram1 = 0; iHistogram1 < numberOfObservables + numberOfParameters; ++iHistogram1)
            for (Int_t iHistogram2 = iHistogram1 + 1; iHistogram2 < numberOfObservables + numberOfParameters; ++iHistogram2)
            {
               // Fill the histograms with the leaves of the tree.
               histogram[histogramCounter]->Fill(leaf[iHistogram1], leaf[iHistogram2]);
               histogramCounter++;
            }
      }
   else
   {
      // If the input file does not exist, fill the histograms with the best fit points,
      // respectively.
      histogramCounter = 0;
      for (Int_t iHistogram1 = 0; iHistogram1 < numberOfObservables + numberOfParameters; ++iHistogram1)
         for (Int_t iHistogram2 = iHistogram1 + 1; iHistogram2 < numberOfObservables + numberOfParameters; ++iHistogram2)
         {
            histogram[histogramCounter]->Fill(histogramSetup[iHistogram1]->GetBestFitPoint(),
        	  histogramSetup[iHistogram2]->GetBestFitPoint());
            histogramCounter++;
         }
   }

   // Calculate the error ranges.
   Double_t numberOf1sEntries = histogram[0]->GetEntries() / 100. * 68.2;
   Double_t numberOf2sEntries = histogram[0]->GetEntries() / 100. * 95.4;

   Int_t numberOfEntries = 0;
   for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
   {
      numberOfEntries = 0;
      TH2F* tmpHist = (TH2F*)histogram[iHistogram]->Clone();
      while (numberOfEntries < numberOf1sEntries)
      {
         Int_t numberOfEntriesBefore = numberOfEntries;
         numberOfEntries += tmpHist->GetBinContent(tmpHist->GetMaximumBin());
         histogram1s[iHistogram]->SetBinContent(tmpHist->GetMaximumBin(), histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(tmpHist->GetMaximumBin()));
         tmpHist->SetBinContent(tmpHist->GetMaximumBin(), 0.);

         if ((numberOfEntries - numberOfEntriesBefore) == 0)
            break;
      }

      //for (UInt_t iBin = 0; iBin < histogramSetup[iHistogram]->GetNBins() * 10.; iBin++)
      //{
      //   if (histogram1s[iHistogram]->GetBinContent(iBin) > 0.)
      //   {
      //      histogramSetup[iHistogram]->SetBestFitPointMinusError(fabs(histogramSetup[iHistogram]->GetBestFitPoint() - histogram1s[iHistogram]->GetBinLowEdge(iBin)));
      //      break;
      //   }
      //}

      //for (UInt_t iBin = histogramSetup[iHistogram]->GetNBins() * 10. + 1; iBin >= 0; iBin--)
      //{
      //   if (histogram1s[iHistogram]->GetBinContent(iBin) > 0.)
      //   {
      //      histogramSetup[iHistogram]->SetBestFitPointPlusError(fabs(histogramSetup[iHistogram]->GetBestFitPoint() - histogram1s[iHistogram]->GetBinLowEdge(iBin + 1)));
      //      break;
      //   }
      //}

      numberOfEntries = 0;
      TH2F* tmpHist2 = (TH2F*)histogram[iHistogram]->Clone();

      while (numberOfEntries < numberOf2sEntries)
      {
         Int_t numberOfEntriesBefore = numberOfEntries;
         numberOfEntries += tmpHist2->GetBinContent(tmpHist2->GetMaximumBin());
         histogram2s[iHistogram]->SetBinContent(tmpHist2->GetMaximumBin(), histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(tmpHist2->GetMaximumBin()));
         tmpHist2->SetBinContent(tmpHist2->GetMaximumBin(), 0.);

         if ((numberOfEntries - numberOfEntriesBefore) == 0)
            break;
      }
   }

   histogramCounter = 0;
   for (Int_t iHistogram1 = 0; iHistogram1 < numberOfObservables + numberOfParameters; ++iHistogram1)
   {
      for (Int_t iHistogram2 = iHistogram1 + 1; iHistogram2 < numberOfObservables + numberOfParameters; ++iHistogram2)
      {
         // Draw a star for the best fit point.
         Double_t x1[1] = {histogramSetup[iHistogram1]->GetBestFitPoint()};
         Double_t y1[1] = {histogramSetup[iHistogram2]->GetBestFitPoint()};
         bestFitPoint = new TGraphAsymmErrors(1, x1, y1);
         bestFitPoint->SetMarkerSize(1.5);
         bestFitPoint->SetMarkerStyle(29);

         // Convert numerical values to strings.
         std::stringstream bestFitPointExponentStringStream1,
            bestFitPointExponentStringStream2,
            bestFitPointMantissaStringStream1,
            bestFitPointMantissaStringStream2;

         TString bestFitPointExponent1,
            bestFitPointExponent2,
            bestFitPointMantissa1,
            bestFitPointMantissa2;

         bestFitPointExponentStringStream1 << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram1]->GetBestFitPoint())));
         bestFitPointExponentStringStream1 >> bestFitPointExponent1;

         bestFitPointExponentStringStream2 << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram2]->GetBestFitPoint())));
         bestFitPointExponentStringStream2 >> bestFitPointExponent2;

         bestFitPointMantissaStringStream1 << std::setprecision(3) << histogramSetup[iHistogram1]->GetBestFitPoint() / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram1]->GetBestFitPoint()))));
         bestFitPointMantissaStringStream1 >> bestFitPointMantissa1;

         bestFitPointMantissaStringStream2 << std::setprecision(3) << histogramSetup[iHistogram2]->GetBestFitPoint() / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram2]->GetBestFitPoint()))));
         bestFitPointMantissaStringStream2 >> bestFitPointMantissa2;

         // Set the contour settings.
         Double_t levels[1] = {1.e-9};
         Int_t colors[1] = {kBlack};
         gStyle->SetPalette(1, colors);

         // Draw the histograms.
         histogram[histogramCounter]->SetContour(1, levels);
         histogram[histogramCounter]->Draw("CONT1AXIS");
         histogram2s[histogramCounter]->SetContour(1, levels);
         histogram2s[histogramCounter]->Draw("CONTSAME");
         histogram1s[histogramCounter]->SetContour(1, levels);
         histogram1s[histogramCounter]->Draw("CONTSAME");
         histogram[histogramCounter]->Draw("CONT1SAME");
         bestFitPoint->Draw("PSAME");

         // Draw a legend.
         TLegend legend(0.66, 0.64, 0.86, 0.92);
         legend.SetShadowColor(0);
         legend.SetLineColor(0);
         legend.SetTextSize(0.04);
         legend.SetFillColor(0);
         legend.AddEntry(histogram[histogramCounter], "Toy Fits", "f");
         legend.AddEntry(histogram1s[histogramCounter], "1 #sigma", "f");
         legend.AddEntry(histogram2s[histogramCounter], "2 #sigma", "f");
         legend.AddEntry(bestFitPoint, "Best Fit Point", "p");
         legend.AddEntry(bestFitPoint, bestFitPointMantissa1 + " #times10^{" + bestFitPointExponent1 + "}" + " " + histogramSetup[iHistogram1]->GetUnit(), "");
         legend.AddEntry(bestFitPoint, bestFitPointMantissa2 + " #times10^{" + bestFitPointExponent2 + "}" + " " + histogramSetup[iHistogram2]->GetUnit(), "");
         legend.Draw();

         // Draw the Fittino logo.
         TImage *fittinoLogo = 0;
         std::string logoPath = "../../logo/fittinologoWINTER1213_white.png";
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
            TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.19, 0.72, 0.39, 0.92);
            fittinoLogoPad->Draw("same");
            fittinoLogoPad->cd();
            fittinoLogo->Draw("xxx");
            canvas->cd();
            myText(0.19, 0.67, kBlack, model);
         }

         // Write the output to file.
         canvas->Update();
         canvas->SaveAs("ToyFits" + model  + histogramSetup[iHistogram1]->GetName() + histogramSetup[iHistogram2]->GetName() + ".eps", "RECREATE");
         histogramCounter++;
      }
   }

   delete canvas;

   gSystem->Exit(0);
}
