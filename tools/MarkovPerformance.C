{
   TFile* file1 = new TFile("fittino.out.markov.lhc_obs+le_obs1.diffstart1/MarkovChainNtupFile.sum.root");
   TFile* file2 = new TFile("fittino.out.markov.lhc_obs+le_obs1.diffstart3/MarkovChainNtupFile.sum.root");

   TTree* tree1 = static_cast<TTree*>file1->Get("markovChain");
   TTree* tree2 = static_cast<TTree*>file2->Get("markovChain");

   Int_t nEntries1 = static_cast<Int_t>tree1->GetEntries();
   Int_t nEntries2 = static_cast<Int_t>tree2->GetEntries();

   Float_t a01;
   Float_t m01;
   Float_t tanbeta1;
   Float_t n1;
   tree1->SetBranchAddress("A0", &a01);
   tree1->SetBranchAddress("M0", &m01);
   tree1->SetBranchAddress("TanBeta", &tanbeta1);
   tree1->SetBranchAddress("n", &n1);

   Float_t a02;
   Float_t m02;
   Float_t tanbeta2;
   Float_t n2;
   tree2->SetBranchAddress("A0", &a02);
   tree2->SetBranchAddress("M0", &m02);
   tree2->SetBranchAddress("TanBeta", &tanbeta2);
   tree2->SetBranchAddress("n", &n2);

   //TH2F* performance_histo1 = new TH2F("performance_histo1", "name1", 10000, 0, 10, 10000, -900, -200);
   //TH2F* performance_histo2 = new TH2F("performance_histo2", "name2", 10000, 0, 10, 10000, -900, -200);

   //TH2F* performance_histo1 = new TH2F("performance_histo1", "", 10000, 0, 100, 10000, 70, 130);
   //TH2F* performance_histo2 = new TH2F("performance_histo2", "", 10000, 0, 100, 10000, 70, 130);

   TH2F* performance_histo1 = new TH2F("performance_histo1", "", 100, 0, 500, 100, 0, 30);
   TH2F* performance_histo2 = new TH2F("performance_histo2", "", 100, 0, 500, 100, 0, 30);

   for (unsigned int iEntry1=0; iEntry1<nEntries1; iEntry1++) {

      tree1->GetEntry(iEntry1);
    
      Int_t increment = 3;
      for (unsigned int i=0; i<100; i++) {
      
         if (n1<increment && increment-3<n1) {
            n1=increment;
            break;
         }
         increment = increment+3;
      
      } 

      performance_histo1->Fill(n1+1.5,tanbeta1);
      //performance_histo1->Fill(n1+0.5,m01);
   
   }

   for (unsigned int iEntry2=0; iEntry2<nEntries2; iEntry2++) {

      tree2->GetEntry(iEntry2);

      Int_t increment = 3;
      for (unsigned int i=0; i<100; i++) {
      
         if (n2<increment && increment-3<n2) {
            n2=increment;
            break;
         }
         increment = increment+3;
      
      }
      performance_histo2->Fill(n2,tanbeta2);
      //performance_histo2->Fill(n2,m02);
   
   }

   performance_histo1->SetStats(kFALSE);
   performance_histo1->SetLineColor(kBlue);
   performance_histo1->GetXaxis()->CenterTitle();
   performance_histo1->GetYaxis()->CenterTitle();
   performance_histo1->GetXaxis()->SetTitle("n");
   //performance_histo1->GetYaxis()->SetTitle("M_{0} (GeV)");
   performance_histo1->GetYaxis()->SetTitle("tan#beta");
   //performance_histo1->SetMarkerStyle(21);
   //performance_histo1->SetMarkerSize(0.4);
   performance_histo1->Draw("box");

   performance_histo2->SetStats(kFALSE);
   performance_histo2->SetLineColor(kRed);
   //performance_histo2->SetMarkerStyle(21);
   //performance_histo2->SetMarkerSize(0.4);
   performance_histo2->Draw("boxsame");

   TLegend *leg = new TLegend(0.68,0.68,0.85,0.85);
   //leg->SetHeader("        M_{0} initial value");
   //leg->AddEntry(performance_histo1, "93 GeV", "p");
   //leg->AddEntry(performance_histo2, "86 GeV", "p");
   leg->SetHeader("        tan#beta initial value");
   leg->AddEntry(performance_histo1, "11 GeV", "p");
   leg->AddEntry(performance_histo2, " 8 GeV", "p");
   leg->SetFillStyle(0);
   leg->Draw();

   //delete tree;
   //delete file;

   //TCanvas* = new TCanvas();
}
