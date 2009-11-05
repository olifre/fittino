void DrawLHCmSUGRAPrecisionVsLumi() {

    double lumi[3] = {1, 10, 300};
    double relTanBetaPrec[3] = {37, 8.4, 3.5};
    double relA0Prec[3] = {742.1, 52.9, 11.1};
    double relM0Prec[3] = {4.2, 2.1, 0.39};
    double relM12Prec[3] = {2.7, 0.48, 0.12};

    TGraph* gTanBeta = new TGraph(3, lumi, relTanBetaPrec);
    TGraph* gA0 = new TGraph(3, lumi, relA0Prec);
    TGraph* gM0 = new TGraph(3, lumi, relM0Prec);
    TGraph* gM12 = new TGraph(3, lumi, relM12Prec);

    gPad->SetLogx();
    gPad->SetLogy();

    gA0->SetMinimum(0.05);
    gA0->SetMaximum(2000);

    gA0->SetLineColor(kGreen);
    gA0->SetMarkerColor(kGreen);
    gA0->Draw("lpa");

    gA0->GetXaxis()->SetTitle("Luminosity (fb^{-1})");
    gA0->GetYaxis()->SetTitle("Relative precision (%)");

    gTanBeta->SetLineColor(kMagenta);
    gTanBeta->SetMarkerColor(kMagenta);
    gTanBeta->Draw("lp");

    gM0->SetLineColor(kRed);
    gM0->SetMarkerColor(kRed);
    gM0->Draw("lp");

    gM12->SetLineColor(kBlue);
    gM12->SetMarkerColor(kBlue);
    gM12->Draw("lp");

    TLatex* tA0 = new TLatex(120, 20, "A_{0}");
    tA0->SetTextColor(kGreen);
    tA0->Draw();

    TLatex* tTanBeta = new TLatex(120, 5, "tan #beta");
    tTanBeta->SetTextColor(kMagenta);
    tTanBeta->Draw();

    TLatex* tM0 = new TLatex(120, 0.8, "M_{0}");
    tM0->SetTextColor(kRed);
    tM0->Draw();

    TLatex* tM12 = new TLatex(120, 0.2, "M_{1/2}");
    tM12->SetTextColor(kBlue);
    tM12->Draw();

    gPad->Print("LHCmSUGRAPrecisionVsLumi.eps");
}
