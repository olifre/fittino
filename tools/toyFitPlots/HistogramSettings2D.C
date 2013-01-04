#include "HistogramSettings2D.h"

void HistogramSettings2D()
{
   for (Int_t iHistogram = 0; iHistogram < numberOfHistograms; ++iHistogram)
      histogramSetup[iHistogram] = new HistogramSetup();

   histogramSetup[0]->SetName         ("Chi2");
   histogramSetup[0]->SetAxisLabel    ("#chi^{2}");
   histogramSetup[0]->SetUnit         ("");
   histogramSetup[0]->SetNBins        (40);
   histogramSetup[0]->SetLeftLimit    (0.);
   histogramSetup[0]->SetRightLimit   (100.);
   histogramSetup[0]->SetHasData      (kFALSE);
   histogramSetup[0]->SetDataValue    (0.);
   histogramSetup[0]->SetDataError    (0.);
   histogramSetup[0]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[0]->SetBestFitPoint(34.0);
   if (model == "NUHM1") histogramSetup[0]->SetBestFitPoint(33.1);
   if (model == "NUHM2") histogramSetup[0]->SetBestFitPoint(33.5);

   histogramSetup[1]->SetName         ("Bsg"                      );
   histogramSetup[1]->SetAxisLabel    ("BR(b #rightarrow s#gamma)");
   histogramSetup[1]->SetUnit         (""                         );
   histogramSetup[1]->SetNBins        (30                         );
   histogramSetup[1]->SetLeftLimit    (1.5e-4                     );
   histogramSetup[1]->SetRightLimit   (4.5e-4                     );
   histogramSetup[1]->SetHasData      (kTRUE                      );
   histogramSetup[1]->SetDataValue    (3.55e-4                    );
   histogramSetup[1]->SetDataError    (0.53e-4                    );
   histogramSetup[1]->SetDataPrecision(3                          );
   if (model == "CMSSM") histogramSetup[1]->SetBestFitPoint(0.000278938);
   if (model == "NUHM1") histogramSetup[1]->SetBestFitPoint(0.000299343);
   if (model == "NUHM2") histogramSetup[1]->SetBestFitPoint(0.000296331);

   histogramSetup[2]->SetName         ("DmBs");
   histogramSetup[2]->SetAxisLabel    ("#Deltam_{B_{s}} [ps^{-1}]");
   histogramSetup[2]->SetUnit         ("ps^{-1}");
   histogramSetup[2]->SetNBins        (40);
   histogramSetup[2]->SetLeftLimit    (11.);
   histogramSetup[2]->SetRightLimit   (31.);
   histogramSetup[2]->SetHasData      (kTRUE);
   histogramSetup[2]->SetDataValue    (17.7);
   histogramSetup[2]->SetDataError    (4.2);
   histogramSetup[2]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[2]->SetBestFitPoint(20.9744);
   if (model == "NUHM1") histogramSetup[2]->SetBestFitPoint(21.3692);
   if (model == "NUHM2") histogramSetup[2]->SetBestFitPoint(21.3902);

   histogramSetup[3]->SetName         ("Btn");
   histogramSetup[3]->SetAxisLabel    ("BR(B #rightarrow #tau#nu)");
   histogramSetup[3]->SetUnit         ("");
   histogramSetup[3]->SetNBins        (30);
   histogramSetup[3]->SetLeftLimit    (0.);
   histogramSetup[3]->SetRightLimit   (0.15e-3);
   histogramSetup[3]->SetHasData      (kTRUE);
   histogramSetup[3]->SetDataValue    (0.72e-4);
   histogramSetup[3]->SetDataError    (0.29e-4);
   histogramSetup[3]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[3]->SetBestFitPoint(7.83322e-05);
   if (model == "NUHM1") histogramSetup[3]->SetBestFitPoint(7.98717e-05);
   if (model == "NUHM2") histogramSetup[3]->SetBestFitPoint(7.98760e-05);

   histogramSetup[4]->SetName         ("Omega");
   histogramSetup[4]->SetAxisLabel    ("#Omega_{CDM}h^{2}");
   histogramSetup[4]->SetUnit         ("");
   histogramSetup[4]->SetNBins        (50);
   histogramSetup[4]->SetLeftLimit    (0.);
   histogramSetup[4]->SetRightLimit   (0.25);
   histogramSetup[4]->SetHasData      (kTRUE);
   histogramSetup[4]->SetDataValue    (0.1123);
   histogramSetup[4]->SetDataError    (0.0118);
   histogramSetup[4]->SetDataPrecision(4);
   if (model == "CMSSM") histogramSetup[4]->SetBestFitPoint(0.109373);
   if (model == "NUHM1") histogramSetup[4]->SetBestFitPoint(0.109829);
   if (model == "NUHM2") histogramSetup[4]->SetBestFitPoint(0.115162);

   histogramSetup[5]->SetName         ("GMin2Muon");
   histogramSetup[5]->SetAxisLabel    ("a_{#mu}^{exp} - a_{#mu}^{SM}");
   histogramSetup[5]->SetUnit         ("");
   histogramSetup[5]->SetNBins        (40);
   histogramSetup[5]->SetLeftLimit    (-3.e-9);
   histogramSetup[5]->SetRightLimit   (5.e-9);
   histogramSetup[5]->SetHasData      (kTRUE);
   histogramSetup[5]->SetDataValue    (28.7e-10);
   histogramSetup[5]->SetDataError    (8.2e-10);
   histogramSetup[5]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[5]->SetBestFitPoint(4.70382e-10);
   if (model == "NUHM1") histogramSetup[5]->SetBestFitPoint(1.41860e-09);
   if (model == "NUHM2") histogramSetup[5]->SetBestFitPoint(1.14851e-09);

   histogramSetup[6]->SetName         ("Massh0");
   histogramSetup[6]->SetAxisLabel    ("m_{h} [GeV]");
   histogramSetup[6]->SetUnit         ("GeV");
   histogramSetup[6]->SetNBins        (32);
   histogramSetup[6]->SetLeftLimit    (115.);
   histogramSetup[6]->SetRightLimit   (131.);
   histogramSetup[6]->SetHasData      (kTRUE);
   histogramSetup[6]->SetDataValue    (126.0);
   histogramSetup[6]->SetDataError    (3.6);
   histogramSetup[6]->SetDataPrecision(4);
   if (model == "CMSSM") histogramSetup[6]->SetBestFitPoint(123.675);
   if (model == "NUHM1") histogramSetup[6]->SetBestFitPoint(121.879);
   if (model == "NUHM2") histogramSetup[6]->SetBestFitPoint(122.230);

   histogramSetup[7]->SetName         ("MassW");
   histogramSetup[7]->SetAxisLabel    ("m_{W} [GeV]");
   histogramSetup[7]->SetUnit         ("GeV");
   histogramSetup[7]->SetNBins        (40);
   histogramSetup[7]->SetLeftLimit    (80.3);
   histogramSetup[7]->SetRightLimit   (80.5);
   histogramSetup[7]->SetHasData      (kTRUE);
   histogramSetup[7]->SetDataValue    (80.385);
   histogramSetup[7]->SetDataError    (0.018);
   histogramSetup[7]->SetDataPrecision(5);
   if (model == "CMSSM") histogramSetup[7]->SetBestFitPoint(80.3953);
   if (model == "NUHM1") histogramSetup[7]->SetBestFitPoint(80.3804);
   if (model == "NUHM2") histogramSetup[7]->SetBestFitPoint(80.3866);

   histogramSetup[8]->SetName         ("SinThetaEff");
   histogramSetup[8]->SetAxisLabel    ("sin^{2}#theta_{eff}");
   histogramSetup[8]->SetUnit         ("");
   histogramSetup[8]->SetNBins        (20);
   histogramSetup[8]->SetLeftLimit    (0.2308);
   histogramSetup[8]->SetRightLimit   (0.2318);
   histogramSetup[8]->SetHasData      (kTRUE);
   histogramSetup[8]->SetDataValue    (0.23113);
   histogramSetup[8]->SetDataError    (0.00021);
   histogramSetup[8]->SetDataPrecision(5);
   if (model == "CMSSM") histogramSetup[8]->SetBestFitPoint(0.231326);
   if (model == "NUHM1") histogramSetup[8]->SetBestFitPoint(0.231408);
   if (model == "NUHM2") histogramSetup[8]->SetBestFitPoint(0.231374);

   histogramSetup[9]->SetName         ("Bsmm");
   histogramSetup[9]->SetAxisLabel    ("BR(B_{s} #rightarrow #mu#mu)");
   histogramSetup[9]->SetUnit         ("");
   histogramSetup[9]->SetNBins        (30);
   histogramSetup[9]->SetLeftLimit    (1.5e-9);
   histogramSetup[9]->SetRightLimit   (7.5e-9);
   histogramSetup[9]->SetHasData      (kTRUE);
   histogramSetup[9]->SetDataValue    (3.2e-9);
   histogramSetup[9]->SetDataError    (1.5e-9);
   histogramSetup[9]->SetDataPrecision(2);
   if (model == "CMSSM") histogramSetup[9]->SetBestFitPoint(4.38858e-09);
   if (model == "NUHM1") histogramSetup[9]->SetBestFitPoint(3.56042e-09);
   if (model == "NUHM2") histogramSetup[9]->SetBestFitPoint(3.57790e-09);

   histogramSetup[10]->SetName         ("A0");
   histogramSetup[10]->SetAxisLabel    ("A_{0} [GeV]");
   histogramSetup[10]->SetUnit         ("GeV");
   histogramSetup[10]->SetNBins        (32);
   histogramSetup[10]->SetLeftLimit    (-9500.);
   histogramSetup[10]->SetRightLimit   (6500.);
   histogramSetup[10]->SetHasData      (kFALSE);
   histogramSetup[10]->SetDataValue    (0.);
   histogramSetup[10]->SetDataError    (0.);
   histogramSetup[10]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[10]->SetBestFitPoint(-2225.83);
   if (model == "NUHM1") histogramSetup[10]->SetBestFitPoint(-1620.76);
   if (model == "NUHM2") histogramSetup[10]->SetBestFitPoint(-1551.15);

   histogramSetup[11]->SetName         ("M0");
   histogramSetup[11]->SetAxisLabel    ("M_{0} [GeV]");
   histogramSetup[11]->SetUnit         ("GeV");
   histogramSetup[11]->SetNBins        (44);
   histogramSetup[11]->SetLeftLimit    (-300.);
   histogramSetup[11]->SetRightLimit   (4100.);
   histogramSetup[11]->SetHasData      (kFALSE);
   histogramSetup[11]->SetDataValue    (0.);
   histogramSetup[11]->SetDataError    (0.);
   histogramSetup[11]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[11]->SetBestFitPoint(730.665);
   if (model == "NUHM1") histogramSetup[11]->SetBestFitPoint(45.2239);
   if (model == "NUHM2") histogramSetup[11]->SetBestFitPoint(34.3480);

   histogramSetup[12]->SetName         ("M12");
   histogramSetup[12]->SetAxisLabel    ("M_{1/2} [GeV]");
   histogramSetup[12]->SetUnit         ("GeV");
   histogramSetup[12]->SetNBins        (31);
   histogramSetup[12]->SetLeftLimit    (0.);
   histogramSetup[12]->SetRightLimit   (3100.);
   histogramSetup[12]->SetHasData      (kFALSE);
   histogramSetup[12]->SetDataValue    (0.);
   histogramSetup[12]->SetDataError    (0);
   histogramSetup[12]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[12]->SetBestFitPoint(880.471);
   if (model == "NUHM1") histogramSetup[12]->SetBestFitPoint(442.154);
   if (model == "NUHM2") histogramSetup[12]->SetBestFitPoint(502.106);

   histogramSetup[13]->SetName         ("TanBeta");
   histogramSetup[13]->SetAxisLabel    ("tan#beta");
   histogramSetup[13]->SetUnit         ("");
   histogramSetup[13]->SetNBins        (30);
   histogramSetup[13]->SetLeftLimit    (-10.);
   histogramSetup[13]->SetRightLimit   (110.);
   histogramSetup[13]->SetHasData      (kFALSE);
   histogramSetup[13]->SetDataValue    (0.);
   histogramSetup[13]->SetDataError    (0.);
   histogramSetup[13]->SetDataPrecision(3.);
   if (model == "CMSSM") histogramSetup[13]->SetBestFitPoint(32.7065);
   if (model == "NUHM1") histogramSetup[13]->SetBestFitPoint(9.27587);
   if (model == "NUHM2") histogramSetup[13]->SetBestFitPoint(10.2639);

   histogramSetup[14]->SetName         ("MassTop");
   histogramSetup[14]->SetAxisLabel    ("m_{t} [GeV]");
   histogramSetup[14]->SetUnit         ("GeV");
   histogramSetup[14]->SetNBins        (21);
   histogramSetup[14]->SetLeftLimit    (168.);
   histogramSetup[14]->SetRightLimit   (189.);
   histogramSetup[14]->SetHasData      (kFALSE);
   histogramSetup[14]->SetDataValue    (0.);
   histogramSetup[14]->SetDataError    (0.);
   histogramSetup[14]->SetDataPrecision(3);
   if (model == "CMSSM") histogramSetup[14]->SetBestFitPoint(173.768);
   if (model == "NUHM1") histogramSetup[14]->SetBestFitPoint(174.222);
   if (model == "NUHM2") histogramSetup[14]->SetBestFitPoint(174.446);

   if (model == "NUHM1") histogramSetup[15]->SetName         ("M0H");
   if (model == "NUHM2") histogramSetup[15]->SetName         ("M0Hu");
   if (model == "NUHM1") histogramSetup[15]->SetAxisLabel    ("M_{H}^{2} [GeV^{2}]");
   if (model == "NUHM2") histogramSetup[15]->SetAxisLabel    ("M_{Hu}^{2} [GeV^{2}]");
   histogramSetup[15]->SetUnit         ("GeV^{2}");
   histogramSetup[15]->SetNBins        (30);
   histogramSetup[15]->SetLeftLimit    (-13000000.);
   histogramSetup[15]->SetRightLimit   (17000000.);
   histogramSetup[15]->SetHasData      (kFALSE);
   histogramSetup[15]->SetDataValue    (0.);
   histogramSetup[15]->SetDataError    (0.);
   histogramSetup[15]->SetDataPrecision(0);
   if (model == "NUHM1") histogramSetup[15]->SetBestFitPoint(-470043);
   if (model == "NUHM2") histogramSetup[15]->SetBestFitPoint(-470043);

   histogramSetup[16]->SetName         ("M0Hd");
   histogramSetup[16]->SetAxisLabel    ("M_{Hd}^{2} [GeV^{2}]");
   histogramSetup[16]->SetUnit         ("GeV^{2}");
   histogramSetup[16]->SetNBins        (28);
   histogramSetup[16]->SetLeftLimit    (-8000000.);
   histogramSetup[16]->SetRightLimit   (22000000.);
   histogramSetup[16]->SetHasData      (kFALSE);
   histogramSetup[16]->SetDataValue    (0.);
   histogramSetup[16]->SetDataError    (0.);
   histogramSetup[16]->SetDataPrecision(0);
   if (model == "NUHM2") histogramSetup[16]->SetBestFitPoint(117594);

   UInt_t histogramCounter = 0;

   for (Int_t iHistogram1 = 0; iHistogram1 < numberOfObservables+numberOfParameters; ++iHistogram1)
   {
      for (Int_t iHistogram2 = iHistogram1+1; iHistogram2 < numberOfObservables+numberOfParameters; ++iHistogram2)
      {
         histogram[histogramCounter] = new TH2F(histogramSetup[iHistogram1]->GetName() +
                                                histogramSetup[iHistogram2]->GetName(),
   	                                        histogramSetup[iHistogram1]->GetName() +
                                                histogramSetup[iHistogram2]->GetName(),
   	                                        histogramSetup[iHistogram1]->GetNBins(),
   	                                        histogramSetup[iHistogram1]->GetLeftLimit(),
   	                                        histogramSetup[iHistogram1]->GetRightLimit(),
   	                                        histogramSetup[iHistogram2]->GetNBins(),
   	                                        histogramSetup[iHistogram2]->GetLeftLimit(),
   	                                        histogramSetup[iHistogram2]->GetRightLimit());

         histogram1s[histogramCounter] = new TH2F(histogramSetup[iHistogram1]->GetName() +
                                                  histogramSetup[iHistogram2]->GetName() + "1s",
   	                                          histogramSetup[iHistogram1]->GetName() +
                                                  histogramSetup[iHistogram2]->GetName() + "1s",
   	                                          histogramSetup[iHistogram1]->GetNBins(),
   	                                          histogramSetup[iHistogram1]->GetLeftLimit(),
   	                                          histogramSetup[iHistogram1]->GetRightLimit(),
   	                                          histogramSetup[iHistogram2]->GetNBins(),
   	                                          histogramSetup[iHistogram2]->GetLeftLimit(),
   	                                          histogramSetup[iHistogram2]->GetRightLimit());
   
         histogram2s[histogramCounter] = new TH2F(histogramSetup[iHistogram1]->GetName() +
                                                  histogramSetup[iHistogram2]->GetName() + "2s",
   	                                          histogramSetup[iHistogram1]->GetName() +
                                                  histogramSetup[iHistogram2]->GetName() + "2s",
   	                                          histogramSetup[iHistogram1]->GetNBins(),
   	                                          histogramSetup[iHistogram1]->GetLeftLimit(),
   	                                          histogramSetup[iHistogram1]->GetRightLimit(),
   	                                          histogramSetup[iHistogram2]->GetNBins(),
   	                                          histogramSetup[iHistogram2]->GetLeftLimit(),
   	                                          histogramSetup[iHistogram2]->GetRightLimit());
   
         histogram[histogramCounter]->GetXaxis()->SetTitle(histogramSetup[iHistogram1]->GetAxisLabel());
         histogram[histogramCounter]->GetYaxis()->SetTitle(histogramSetup[iHistogram2]->GetAxisLabel());
         histogram[histogramCounter]->GetZaxis()->SetTitle("Fractions");

         histogram[histogramCounter]->SetFillStyle(0);

         histogram1s[histogramCounter]->SetFillColor(kBlue - 6);
         histogram1s[histogramCounter]->SetLineColor(kBlue - 6);

         histogram2s[histogramCounter]->SetFillColor(kBlue - 9);
         histogram2s[histogramCounter]->SetLineColor(kBlue - 9);

         gStyle->SetNdivisions(508);

         histogramCounter++;
      }
   }
}
