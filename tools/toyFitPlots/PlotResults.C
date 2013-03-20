// File     PlotResults.C
//
// Usage    root -b PlotResults.C
//
// Authors  Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>

#include <iomanip>

// Definition of the chi2 function.
Double_t chi2Function(Double_t *x, Double_t *parameter)
{
   Double_t returnValue = 0;

   if (TMath::Power(2, 0.5 * parameter[1]) * TMath::Gamma(0.5 * parameter[1]))
   {
      returnValue = parameter[0] * (TMath::Power(x[0], 0.5 * parameter[1] - 1)
	    * TMath::Exp(-0.5 * x[0])
	    / (TMath::Power(2, 0.5 * parameter[1]) * TMath::Gamma(0.5 * parameter[1])));
   }

   return returnValue;
}

void PlotResults()
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

   // Fill the histograms.
   // Check if the specified input file exists.
   if (file)
      for (Int_t iEntry = 0; iEntry < tree->GetEntries(); ++iEntry)
      {
	 tree->GetEntry(iEntry);
	 for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
	    // Fill the histograms with the leaves of the tree.
	    histogram[iHistogram]->Fill(leaf[iHistogram]);
      }
   else
      // If the input file does not exist, fill the histograms with the best fit points,
      // respectively.
      for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
	 histogram[iHistogram]->Fill(histogramSetup[iHistogram]->GetBestFitPoint());

   // Calculate the error ranges.
   Double_t numberOf1sEntries = histogram[0]->GetEntries() / 100. * 68.2;
   Double_t numberOf2sEntries = histogram[0]->GetEntries() / 100. * 95.4;
   Int_t numberOfEntries = 0;
   for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
   {
      numberOfEntries = 0;
      TH1F* tmpHist = histogram[iHistogram]->Clone();
      while (numberOfEntries < numberOf1sEntries)
      {
	 numberOfEntries += tmpHist->GetBinContent(tmpHist->GetMaximumBin());
	 for (UInt_t iBin = (tmpHist->GetMaximumBin() - 1) * 10. + 1; iBin < (tmpHist->GetMaximumBin() - 1) * 10. + 11.; iBin++)
	 {
	    UInt_t iBin2 = (iBin - 1) / 10 + 1;
	    histogram1s[iHistogram]->SetBinContent(iBin, histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2));
	 }

	 tmpHist->SetBinContent(tmpHist->GetMaximumBin(), 0.);
      }

      numberOfEntries = 0;
      TH1F* tmpHist2 = histogram[iHistogram]->Clone();

      while (numberOfEntries < numberOf2sEntries)
      {
	 numberOfEntries += tmpHist2->GetBinContent(tmpHist2->GetMaximumBin());
	 for (UInt_t iBin = (tmpHist2->GetMaximumBin() - 1) * 10. + 1; iBin < (tmpHist2->GetMaximumBin() - 1) * 10. + 11.; iBin++)
	 {
	    UInt_t iBin2 = (iBin - 1) / 10 + 1;
	    histogram2s[iHistogram]->SetBinContent(iBin, histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2));
	 }

	 tmpHist2->SetBinContent(tmpHist2->GetMaximumBin(), 0.);
      }
   }

   //for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
   //{
   //   // For each histogram find the most probable value.
   //   mostProbableValue[iHistogram] = histogram[iHistogram]->GetBinCenter(histogram[iHistogram]->GetMaximumBin());
   //   mostProbableValueBin[iHistogram] = histogram[iHistogram]->GetMaximumBin();

   //   // Now calculate both the number of events which are smaller and bigger than the most
   //   // probable value.

   //   // For simplicity calculate these numbers as half the number of events in the maximum bin
   //   // (the bin containing the most events) and add the number of events in the bins greater and
   //   // lower the maximum bin, respectively.
   //   leftEventCounter[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //   rightEventCounter[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;

   //   // If the number of events in the maximum bin is odd, add 1 to the number of events right to
   //   // the maximum bin.
   //   if ((Int_t)histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) % 2 != 0)
   //      rightEventCounter[iHistogram] += 1;

   //   for (UInt_t iBin = 0; iBin < mostProbableValueBin[iHistogram]; ++iBin)
   //   {
   //      leftEventCounter[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //   }

   //   for (UInt_t iBin = mostProbableValueBin[iHistogram] + 1; iBin <= histogramSetup[iHistogram]->GetNBins() + 1; ++iBin)
   //   {
   //      rightEventCounter[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //   }

   //   // Uncomment for debugging.
   //   //eventCounter[iHistogram] = leftEventCounter[iHistogram] + rightEventCounter[iHistogram];
   //   //std::cout << iHistogram << " "   << leftEventCounter[iHistogram]
   //   //                        << " + " << rightEventCounter[iHistogram]
   //   //                        << " = " << eventCounter[iHistogram] << std::endl;

   //   // The 1 sigma limit should contain 68.2 % of the events left and right to the most probable
   //   // value, respectively. 
   //   sigma1numberOfRightEntries[iHistogram] = rightEventCounter[iHistogram] / 100. * 68.2;
   //   sigma1numberOfLeftEntries[iHistogram] = leftEventCounter[iHistogram] / 100. * 68.2;

   //   // The 2 sigma limit should contain 95.4 % of the events left and right to the most probable
   //   // value, respectively. 
   //   sigma2numberOfRightEntries[iHistogram] = rightEventCounter[iHistogram] / 100. * 95.4;
   //   sigma2numberOfLeftEntries[iHistogram] = leftEventCounter[iHistogram] / 100. * 95.4;

   //   // Count the number of events.
   //   numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;

   //   // Decide if the maximum bin contains already enough events for the 1 sigma limit.
   //   if (numberOfEntries[iHistogram] > sigma1numberOfLeftEntries[iHistogram])
   //   {
   //      Double_t binBegin = histogram[iHistogram]->GetBinLowEdge(mostProbableValueBin[iHistogram]);
   //      Double_t factor   = (numberOfEntries[iHistogram] - sigma1numberOfLeftEntries[iHistogram])
   //         / (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.);
   //      Double_t binWidth = histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.;
   //      sigma1LeftLimit[iHistogram] = binBegin + factor * binWidth;

   //      // Uncomment for debugging.
   //      //std::cout << iHistogram << " Calculating sigma 1 left limit from first bin " << sigma1LeftLimit[iHistogram] << std::endl;
   //   }
   //   else
   //   {
   //      numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //      for (UInt_t iBin = mostProbableValueBin[iHistogram] - 1; iBin >= 0; --iBin)
   //      {
   //         numberOfEntries[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //         if (numberOfEntries[iHistogram] > sigma1numberOfLeftEntries[iHistogram])
   //         {
   //            Double_t binWidth = histogram[iHistogram]->GetBinWidth(iBin);
   //            Double_t factor   =   (histogram[iHistogram]->GetBinContent(iBin) - (numberOfEntries[iHistogram] - sigma1numberOfLeftEntries[iHistogram]))
   //     	  / histogram[iHistogram]->GetBinContent(iBin);
   //            Double_t binBegin = histogram[iHistogram]->GetBinCenter(iBin) + (histogram[iHistogram]->GetBinWidth(iBin) / 2.);
   //            sigma1LeftLimit[iHistogram] = binBegin - factor * binWidth;
   //            break;
   //         }
   //      }
   //   }

   //   numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //   if (numberOfEntries[iHistogram] > sigma1numberOfRightEntries[iHistogram])
   //   {
   //      //std::cout << (numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram]) << std::endl;/// histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //      //std::cout << (numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram]) / (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) << std::endl;
   //      //std::cout << (numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram]) / (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) * (histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.) << std::endl;
   //      sigma1RightLimit[iHistogram] = mostProbableValue[iHistogram] +
   //         ((numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram]) /
   //          (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.)) *
   //         (histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.);
   //   }
   //   else
   //   {
   //      numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //      for (UInt_t iBin = mostProbableValueBin[iHistogram] + 1; iBin < histogramSetup[iHistogram]->GetNBins(); ++iBin)
   //      {
   //         numberOfEntries[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //         if (numberOfEntries[iHistogram] > sigma1numberOfRightEntries[iHistogram])
   //         {
   //            //std::cout << numberOfEntries[iHistogram] << std::endl;
   //            //std::cout << histogram[iHistogram]->GetBinCenter(iBin) - histogram[iHistogram]->GetBinWidth(iBin) / 2. << std::endl;
   //            //std::cout << (numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram]) << std::endl;/// histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //            sigma1RightLimit[iHistogram] = histogram[iHistogram]->GetBinCenter(iBin) - (histogram[iHistogram]->GetBinWidth(iBin) / 2.) + (histogram[iHistogram]->GetBinContent(iBin) - (numberOfEntries[iHistogram] - sigma1numberOfRightEntries[iHistogram])) / histogram[iHistogram]->GetBinContent(iBin) * (histogram[iHistogram]->GetBinWidth(iBin));
   //            break;
   //         }
   //      }
   //   }
   //   //std::cout << sigma1LeftLimit[iHistogram] << " " << sigma1RightLimit[iHistogram] << std::endl;

   //   for (UInt_t iBin = 1; iBin < histogram1s[iHistogram]->GetNbinsX(); iBin++)
   //   {
   //      UInt_t iBin2 = (iBin - 1) / 10 + 1;
   //      //std::cout << iBin << " " << iBin2 << " " << histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2) << std::endl;
   //      if (histogram1s[iHistogram]->GetBinCenter(iBin) > sigma1LeftLimit[iHistogram] && histogram1s[iHistogram]->GetBinCenter(iBin) < sigma1RightLimit[iHistogram])
   //      {
   //         histogram1s[iHistogram]->SetBinContent(iBin, histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2));
   //         //std::cout << iBin << " " << iBin2 << " " << histogram1s[iHistogram]->GetBinContent(iBin) << std::endl;
   //      }
   //      else
   //         histogram1s[iHistogram]->SetBinContent(iBin, 0.);
   //   }

   //   numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;

   //   //std::cout << sigma2numberOfLeftEntries[iHistogram] << std::endl;
   //   //std::cout << sigma2numberOfRightEntries[iHistogram] << std::endl;
   //   if (numberOfEntries[iHistogram] > sigma2numberOfLeftEntries[iHistogram])
   //   {
   //      sigma2LeftLimit[iHistogram] = (mostProbableValue[iHistogram] - histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.) +
   //         (numberOfEntries[iHistogram] - sigma2numberOfLeftEntries[iHistogram]) /
   //         (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) *
   //         (histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.);
   //      //std::cout << iHistogram << " Calculating sigma 2 left limit from first bin " << sigma2LeftLimit[iHistogram] << std::endl;
   //   }
   //   else
   //   {
   //      numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //      for (UInt_t iBin = mostProbableValueBin[iHistogram] - 1; iBin > 0; --iBin)
   //      {
   //         numberOfEntries[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //         if (numberOfEntries[iHistogram] > sigma2numberOfLeftEntries[iHistogram])
   //         {
   //            Double_t binWidth = histogram[iHistogram]->GetBinWidth(iBin);
   //            Double_t factor = (histogram[iHistogram]->GetBinContent(iBin) - (numberOfEntries[iHistogram] - sigma2numberOfLeftEntries[iHistogram])) / histogram[iHistogram]->GetBinContent(iBin);
   //            Double_t binBegin = histogram[iHistogram]->GetBinCenter(iBin) + (histogram[iHistogram]->GetBinWidth(iBin) / 2.);
   //            //std::cout << numberOfEntries[iHistogram] << std::endl;
   //            //std::cout << histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //            //std::cout << histogram[iHistogram]->GetBinCenter(iBin) - histogram[iHistogram]->GetBinWidth(iBin) / 2. << std::endl;
   //            //std::cout << binBegin << " - " << factor << " * " << binWidth << std::endl;/// histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //            sigma2LeftLimit[iHistogram] = binBegin - factor * binWidth;
   //            break;
   //         }
   //      }
   //   }

   //   numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //   if (numberOfEntries[iHistogram] > sigma2numberOfRightEntries[iHistogram])
   //   {
   //      //std::cout << (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram]) << std::endl;/// histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //      //std::cout << (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram]) / (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) << std::endl;
   //      //std::cout << (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram]) / (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) * (histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.) << std::endl;
   //      sigma2RightLimit[iHistogram] = mostProbableValue[iHistogram] +
   //         (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram]) /
   //         (histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.) *
   //         (histogram[iHistogram]->GetBinWidth(mostProbableValueBin[iHistogram]) / 2.);
   //   }
   //   else
   //   {
   //      numberOfEntries[iHistogram] = histogram[iHistogram]->GetBinContent(mostProbableValueBin[iHistogram]) / 2.;
   //      for (UInt_t iBin = mostProbableValueBin[iHistogram] + 1; iBin < histogramSetup[iHistogram]->GetNBins(); ++iBin)
   //      {
   //         numberOfEntries[iHistogram] += histogram[iHistogram]->GetBinContent(iBin);
   //         if (numberOfEntries[iHistogram] > sigma2numberOfRightEntries[iHistogram])
   //         {
   //            //std::cout << numberOfEntries[iHistogram] << std::endl;
   //            //std::cout << histogram[iHistogram]->GetBinCenter(iBin) - histogram[iHistogram]->GetBinWidth(iBin) / 2. << std::endl;
   //            //std::cout << (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram]) << std::endl;/// histogram[iHistogram]->GetBinContent(iBin) << std::endl;
   //            sigma2RightLimit[iHistogram] = histogram[iHistogram]->GetBinCenter(iBin) - (histogram[iHistogram]->GetBinWidth(iBin) / 2.) + (histogram[iHistogram]->GetBinContent(iBin) - (numberOfEntries[iHistogram] - sigma2numberOfRightEntries[iHistogram])) / histogram[iHistogram]->GetBinContent(iBin) * (histogram[iHistogram]->GetBinWidth(iBin));
   //            break;
   //         }
   //      }
   //   }
   //   //std::cout << sigma2LeftLimit[iHistogram] << " " << sigma2RightLimit[iHistogram] << std::endl;

   //   for (UInt_t iBin = 1; iBin < histogram2s[iHistogram]->GetNbinsX(); iBin++)
   //   {
   //      UInt_t iBin2 = (iBin - 1) / 10 + 1;
   //      //std::cout << iBin << " " << iBin2 << " " << histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2) << std::endl;
   //      if (histogram2s[iHistogram]->GetBinCenter(iBin) > sigma2LeftLimit[iHistogram] && histogram2s[iHistogram]->GetBinCenter(iBin) < sigma2RightLimit[iHistogram])
   //      {
   //         histogram2s[iHistogram]->SetBinContent(iBin, histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin2));
   //         //std::cout << iBin << " " << iBin2 << " " << histogram1s[iHistogram]->GetBinContent(iBin) << std::endl;
   //      }
   //      else
   //         histogram2s[iHistogram]->SetBinContent(iBin, 0.);
   //   }

   //   //std::cout << "-----" << std::endl;
   //}

   const Int_t n = 1;
   Double_t x[n], y[n], xError[n];
   TGraphAsymmErrors* measurement = 0;
   TGraphAsymmErrors* dummy = 0;

   TLine bestFitPointLine;
   TLine sigma1RightLimitLine;
   bestFitPointLine.SetLineStyle(7);

   for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
   {
      for (UInt_t iBin = 0; iBin < histogramSetup[iHistogram]->GetNBins() * 10.; iBin++)
      {
	 if (histogram1s[iHistogram]->GetBinContent(iBin) > 0.)
	 {
	    histogramSetup[iHistogram]->SetBestFitPointMinusError(fabs(histogramSetup[iHistogram]->GetBestFitPoint() - histogram1s[iHistogram]->GetBinLowEdge(iBin)));
	    break;
	 }
      }

      for (UInt_t iBin = histogramSetup[iHistogram]->GetNBins() * 10. + 1; iBin >= 0; iBin--)
      {
	 if (histogram1s[iHistogram]->GetBinContent(iBin) > 0.)
	 {
	    histogramSetup[iHistogram]->SetBestFitPointPlusError(fabs(histogramSetup[iHistogram]->GetBestFitPoint() - histogram1s[iHistogram]->GetBinLowEdge(iBin + 1)));
	    break;
	 }
      }

      // Draw the data point.
      x[0]      = histogramSetup[iHistogram]->GetDataValue();
      xError[0] = histogramSetup[iHistogram]->GetDataError();
      y[0] = histogram[iHistogram]->DrawNormalized()->GetMaximum() / 2.;
      measurement = new TGraphAsymmErrors(n, x, y, xError, xError);

      // Draw a line for the best fit point.
      dummy = new TGraphAsymmErrors(n, x, y, xError, xError);
      dummy->SetLineStyle(7);

      histogram[iHistogram]->SetFillStyle(0);
      histogram[iHistogram]->DrawNormalized("AXIS");
      if (histogramSetup[iHistogram]->GetHasData()) (histogram[iHistogram]->DrawNormalized())->SetMaximum((histogram[iHistogram]->DrawNormalized("SAME"))->GetMaximum()*1.25);
      else (histogram[iHistogram]->DrawNormalized())->SetMaximum((histogram[iHistogram]->DrawNormalized("SAME"))->GetMaximum()*1.15);
      histogram[iHistogram]->DrawNormalized("SAME");
      histogram2s[iHistogram]->SetLineWidth(0);
      histogram2s[iHistogram]->Draw("SAME");
      histogram1s[iHistogram]->SetLineWidth(0);
      histogram1s[iHistogram]->Draw("SAME");
      for (UInt_t iBin = 0; iBin < histogram[iHistogram]->GetNbinsX(); iBin++)
      {
	 if (histogramSetup[iHistogram]->GetBestFitPoint() >= histogram[iHistogram]->GetBinCenter(iBin) && histogramSetup[iHistogram]->GetBestFitPoint() < histogram[iHistogram]->GetBinCenter(iBin) + 0.5 * histogram[iHistogram]->GetBinWidth(iBin))
	 {
	    bestFitPointLine.DrawLine(histogramSetup[iHistogram]->GetBestFitPoint(), 0., histogramSetup[iHistogram]->GetBestFitPoint(), histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin));
	    //sigma1RightLimitLine.DrawLine(sigma1RightLimit[iHistogram], 0., sigma1RightLimit[iHistogram], histogram[iHistogram]->DrawNormalized()->GetBinContent(iBin));
	    break;
	 }
	 else if (histogramSetup[iHistogram]->GetBestFitPoint() >= histogram[iHistogram]->GetBinCenter(iBin) && histogramSetup[iHistogram]->GetBestFitPoint() < histogram[iHistogram]->GetBinCenter(iBin) + histogram[iHistogram]->GetBinWidth(iBin))
	 {
	    bestFitPointLine.DrawLine(histogramSetup[iHistogram]->GetBestFitPoint(), 0., histogramSetup[iHistogram]->GetBestFitPoint(), histogram[iHistogram]->DrawNormalized("SAME")->GetBinContent(iBin + 1));
	    //sigma1RightLimitLine.DrawLine(sigma1RightLimit[iHistogram], 0., sigma1RightLimit[iHistogram], histogram[iHistogram]->DrawNormalized()->GetBinContent(iBin + 1));
	    break;
	 }
      }
      histogram[iHistogram]->DrawNormalized("SAME");
      if (histogramSetup[iHistogram]->GetHasData()) measurement->Draw("EPSAME");

      //TF1 *gaus = 0;
      //TH1F* histTmp = histogram[iHistogram]->DrawNormalized("SAME");
      //histTmp->Fit("gaus");
      //TF1 *gaus = (TF1*)histTmp->GetFunction("gaus");
      //if (gaus)
      //{
      //   gaus->SetNpx(1000);
      //   //gaus->Draw("SAME");
      //}

      histogram[iHistogram]->DrawNormalized("AXISSAME");

      std::stringstream mantissastringstream,
	 exponentstringstream,
	 datamantissastringstream,
	 dataerrormantissastringstream,
	 dataexponentstringstream,
	 bestFitPointPlusErrorMantissaStringStream,
	 bestFitPointPlusErrorExponentStringStream,
	 bestFitPointMinusErrorMantissaStringStream,
	 bestFitPointMinusErrorExponentStringStream;

      TString mantissa,
	      exponent,
	      datamantissa,
	      dataerrormantissa,
	      dataexponent,
	      bestFitPointPlusErrorMantissa,
	      bestFitPointPlusErrorExponent,
	      bestFitPointMinusErrorMantissa,
	      bestFitPointMinusErrorExponent;

      //if (histogramSetup[iHistogram]->GetBestFitPoint() < 0.)
      //   histogramSetup[iHistogram]->GetBestFitPoint() *= -1.;

      exponentstringstream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPoint())));
      exponentstringstream >> exponent;

      mantissastringstream << std::setprecision(3) << std::showpoint
	 <<   histogramSetup[iHistogram]->GetBestFitPoint()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPoint()))));
      mantissastringstream >> mantissa;

      bestFitPointPlusErrorExponentStringStream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPointPlusError())));
      bestFitPointPlusErrorExponentStringStream >> bestFitPointPlusErrorExponent;

      bestFitPointMinusErrorExponentStringStream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPointMinusError())));
      bestFitPointMinusErrorExponentStringStream >> bestFitPointMinusErrorExponent;


      //bestFitPointPlusErrorMantissaStringStream << std::setprecision(histogramSetup[iHistogram]->GetDataPrecision() - 1) << std::showpoint
      bestFitPointPlusErrorMantissaStringStream << std::setprecision(2) << std::showpoint
	 <<   histogramSetup[iHistogram]->GetBestFitPointPlusError()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPointPlusError()))));
      bestFitPointPlusErrorMantissaStringStream >> bestFitPointPlusErrorMantissa;

      //bestFitPointMinusErrorMantissaStringStream << std::setprecision(histogramSetup[iHistogram]->GetDataPrecision() - 1) << std::showpoint
      bestFitPointMinusErrorMantissaStringStream << std::setprecision(2) << std::showpoint
	 << histogramSetup[iHistogram]->GetBestFitPointMinusError()
	 / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetBestFitPointMinusError()))));
      bestFitPointMinusErrorMantissaStringStream >> bestFitPointMinusErrorMantissa;

      if (histogramSetup[iHistogram]->GetHasData())
      {
	 dataexponentstringstream << TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetDataValue())));
	 dataexponentstringstream >> dataexponent;

	 datamantissastringstream << std::setprecision(histogramSetup[iHistogram]->GetDataPrecision()) << std::showpoint << histogramSetup[iHistogram]->GetDataValue() / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetDataValue()))));
	 datamantissastringstream >> datamantissa;

	 dataerrormantissastringstream << std::setprecision(histogramSetup[iHistogram]->GetDataPrecision()) << histogramSetup[iHistogram]->GetDataError() / TMath::Power(10, TMath::Floor(TMath::Log10(fabs(histogramSetup[iHistogram]->GetDataValue()))));
	 dataerrormantissastringstream >> dataerrormantissa;
      }

      // Draw a legend.
      TLegend legend( 0.65, 0.52, 0.85, 0.85 );
      legend.SetShadowColor(0);
      legend.SetLineColor(0);
      legend.SetTextSize(0.04);
      legend.SetFillColor(0);
      legend.AddEntry(histogram[iHistogram], "Toy Fits", "f");
      legend.AddEntry(histogram1s[iHistogram], "1 #sigma", "f");
      legend.AddEntry(histogram2s[iHistogram], "2 #sigma", "f");
      //if (gaus) legend.AddEntry(gaus, "Gaussian", "l");
      legend.AddEntry(dummy, "Best Fit Point", "l");
      legend.AddEntry(dummy, mantissa + " #times10^{" + exponent + "}" + " " + histogramSetup[iHistogram]->GetUnit(), "");
      legend.AddEntry(dummy,  "+ " +  bestFitPointPlusErrorMantissa + " #times10^{" + bestFitPointPlusErrorExponent + "}" + " " + histogramSetup[iHistogram]->GetUnit(), "");
      legend.AddEntry(dummy,  "-  " +  bestFitPointMinusErrorMantissa + " #times10^{" + bestFitPointMinusErrorExponent + "}" + " " + histogramSetup[iHistogram]->GetUnit(), "");
      legend.Draw();
      myText(0.66, 0.87, kBlack, model);

      // Draw a second legend.
      TLegend legend2( 0.19, 0.82, 0.36, 0.92 );
      legend2.SetShadowColor(0);
      legend2.SetLineColor(0);
      legend2.SetTextSize(0.04);
      legend2.SetFillColor(0);
      if (histogramSetup[iHistogram]->GetHasData())
	 legend2.AddEntry(measurement, "Data", "pl");
      if (histogramSetup[iHistogram]->GetHasData())
	 legend2.AddEntry(dummy, "(" + datamantissa + " #pm "
	       + dataerrormantissa + ")"
	       + " #times10^{" + dataexponent + "}"
	       + " " + histogramSetup[iHistogram]->GetUnit(), "");
      if (histogramSetup[iHistogram]->GetHasData()) legend2.Draw();

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
	 TPad *fittinoLogoPad = 0;
	 if (histogramSetup[iHistogram]->GetHasData()) fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.19, 0.60, 0.39, 0.80);
	 else fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.19, 0.72, 0.39, 0.92);
	 fittinoLogoPad->Draw("same");
	 fittinoLogoPad->cd();
	 fittinoLogo->Draw("xxx");
	 canvas->cd();
      }

      // Write the output to file.
      canvas->Update();
      canvas->SaveAs("ToyFits" + model  + histogramSetup[iHistogram]->GetName() + ".eps", "RECREATE");
   }

   // Plot the chi2 histogram.

   // Rename the chi2 histogram.
   histChi2 = (TH1F*)histogram[0]->Clone();

   // Define the expected chi2 distribution.
   TF1* chi2Function = new TF1("chi2",   chi2Function,  0., 100., 2);
   chi2Function->SetParNames("Constant", "NDF");
   chi2Function->SetParameter(0,  2.5); //FIXME
   chi2Function->SetParameter(1, 31.); //FIXME
   chi2Function->SetNpx(1000);
   chi2Function->GetXaxis()->SetTitle("#chi^{2}");
   chi2Function->GetYaxis()->SetTitle("Fractions");
   chi2Function->Draw("AXIS");

   // Fill a second histogram to indicate the integral corresponding to the p-value.
   histChi22->SetFillColor(kBlue - 6);
   histChi22->SetLineWidth(0);
   histChi22->SetLineColor(kBlue - 6);
   for (UInt_t iBin = 1; iBin < histChi22->GetNbinsX(); iBin++)
   {
      UInt_t iBin2 = (iBin - 1) / 10 + 1;
      if (histChi22->GetBinCenter(iBin) > histogramSetup[0]->GetBestFitPoint())
	 histChi22->SetBinContent(iBin, histChi2->DrawNormalized("SAME")->GetBinContent(iBin2));
      else
	 histChi22->SetBinContent(iBin, 0.);
   }

   // Draw everything.
   histChi22->Draw("SAME");
   histChi2->DrawNormalized("SAME");
   // Draw a line for the chi2 value of the best fit point.
   for (UInt_t iBin = 0; iBin < histChi2->GetNbinsX(); iBin++)
   {
      if (histogramSetup[0]->GetBestFitPoint() >= histChi2->GetBinCenter(iBin) && histogramSetup[0]->GetBestFitPoint() < histChi2->GetBinCenter(iBin) + 0.5 * histChi2->GetBinWidth(iBin))
      {
	 bestFitPointLine.DrawLine(histogramSetup[0]->GetBestFitPoint(), 0., histogramSetup[0]->GetBestFitPoint(), histChi2->DrawNormalized("SAME")->GetBinContent(iBin));
	 break;
      }
      else if (histogramSetup[0]->GetBestFitPoint() >= histChi2->GetBinCenter(iBin) && histogramSetup[0]->GetBestFitPoint() < histChi2->GetBinCenter(iBin) + histChi2->GetBinWidth(iBin))
      {
	 bestFitPointLine.DrawLine(histogramSetup[0]->GetBestFitPoint(), 0., histogramSetup[0]->GetBestFitPoint(), histChi2->DrawNormalized("SAME")->GetBinContent(iBin + 1)); break;
      }
   }
   chi2Function->Draw("SAME");
   // FIXME
   //chi2Function->Draw("AXISSAME");
   histChi2->Draw("AXISSAME");

   // Draw a legend.
   myText(0.62, 0.67, kBlack, model);
   TLegend legend( 0.62, 0.42, 0.82, 0.65 );
   legend.SetShadowColor(0);
   legend.SetLineColor(0);
   legend.SetTextSize(0.04);
   legend.SetFillColor(0);
   legend.AddEntry(histChi2, "Toy Fits", "f");
   //legend.AddEntry(chi2Function, "#chi^{2} (NDF = 33)", "l");
   //legend.AddEntry(chi2Function, "#chi^{2} (NDF = 32)", "l");
   legend.AddEntry(chi2Function, "#chi^{2} (NDF = 31)", "l");
   legend.AddEntry(dummy, "Best Fit point", "l");
   //legend.AddEntry(dummy, "34.0", "");
   //legend.AddEntry(dummy, "33.1", "");
   legend.AddEntry(dummy, "33.5", "");
   //legend.AddEntry(histChi22, "P = (29.6 #pm 1.4) %", "f");
   //legend.AddEntry(histChi22, "P = (31.7 #pm 1.5) %", "f");
   legend.AddEntry(histChi22, "P = (31.2 #pm 1.5) %", "f");
   legend.Draw();

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
      TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", 0.62, 0.72, 0.82, 0.92);
      fittinoLogoPad->Draw("same");
      fittinoLogoPad->cd();
      fittinoLogo->Draw("xxx");
      canvas->cd();
   }

   // Write the output to file.
   canvas->Update();
   canvas->SaveAs("ToyFits" + model + "Chi2.eps", "RECREATE");
   delete canvas;

   std::cout << std::endl;

   gSystem->Exit(0);
}
