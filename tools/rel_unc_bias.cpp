void rel_unc_bias () {
   //
   // To see the output of this macro, click  here. 
   //
   gROOT->Reset();
   gStyle->SetPadTopMargin(0.07);
   gStyle->SetErrorX(0); 
   //gStyle->SetErrorY(0.0000001); 
   c1 = new TCanvas("c1","errors",200,10,700,500);
   padgraph = new TPad("pad1","",0.,0.,1.,1.);
   padlogo  = new TPad("pad2","",0.8,0.86,0.99,1.00,0,0,0);
   // c1->SetGrid();
   padgraph->Draw();
   padgraph->cd();

      // create a 2-d histogram to define the range
   TH2F *hr = new TH2F("hr","",19,0.,19.,20,-0.4,0.4);
   hr->SetXTitle("       Parameter");
   hr->SetYTitle("Relative uncertainties and bias");
   //   hr->SetMarkerStyle(20);
   // hr->SetOption("marker");
   hr->GetXaxis()->CenterTitle();
   hr->GetYaxis()->CenterTitle();
   hr->GetXaxis()->SetLabelSize(0.07);
   hr->GetXaxis()->SetTitleSize(0.07);
   gStyle->SetTitleYSize(0.07);
   hr->GetXaxis()->SetTitleOffset(1.5);
   hr->GetYaxis()->SetLabelSize(0.07);
   hr->GetYaxis()->SetTitleSize(0.05);
   hr->GetYaxis()->SetTitleOffset(1.2);
   hr->GetXaxis()->LabelsOption("v");
   hr->GetXaxis()->SetBinLabel(1,"tanBeta");
   hr->GetXaxis()->SetBinLabel(2,"Mu");
   hr->GetXaxis()->SetBinLabel(3,"Xtau");
   hr->GetXaxis()->SetBinLabel(4,"MSeR");
   hr->GetXaxis()->SetBinLabel(5,"MStauR");
   hr->GetXaxis()->SetBinLabel(6,"MSeL");
   hr->GetXaxis()->SetBinLabel(7,"MStauL");
   hr->GetXaxis()->SetBinLabel(8,"Xt");
   hr->GetXaxis()->SetBinLabel(9,"Xb");
   hr->GetXaxis()->SetBinLabel(10,"MSuR");
   hr->GetXaxis()->SetBinLabel(11,"MSbR");
   hr->GetXaxis()->SetBinLabel(12,"MStR");
   hr->GetXaxis()->SetBinLabel(13,"MSuL");
   hr->GetXaxis()->SetBinLabel(14,"MStL");
   hr->GetXaxis()->SetBinLabel(15,"M1");
   hr->GetXaxis()->SetBinLabel(16,"M2");
   hr->GetXaxis()->SetBinLabel(17,"M3");
   hr->GetXaxis()->SetBinLabel(18,"MArun");
   hr->GetXaxis()->SetBinLabel(19,"mt");
   hr->GetXaxis()->LabelsOption("v");
   hr->Draw();

   // create theo unc. graph
   Int_t n2 = 19;
   Float_t x2[]  = {0.35,1.35,2.35,3.35,4.35,5.35,6.35,7.35,8.35,9.35,10.35,
                    11.35,12.35,13.35,14.35,15.35,16.35,17.35,18.35};
   Float_t y2[]  = { 0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 ,
		     0.0 };

   Float_t ex2[] = {.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,
		    .0,.0,.0,.0,.0,.0,.0,.0,.0};
   Float_t ey2[] = {0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2, 
		    0.2 };









   gr2 = new TGraphErrors(n2,x2,y2,ex2,ey2);
   gr2->SetLineColor(kRed);  
   gr2->SetLineWidth(1);  
   gr2->SetMarkerColor(kRed);
   gr2->SetMarkerSize(0);
   gr2->SetMarkerStyle(0);
   gr2->Draw("E");

   // create no theo unc. graph
   Int_t n1 = 19;
   //   Float_t x1[]  = {0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,
   //                 11.5,12.5,13.5,14.5,15.5,16.5,17.5,18.5};
   Float_t x1[]  = {0.65,1.65,2.65,3.65,4.65,5.65,6.65,7.65,8.65,9.65,10.65,
                    11.65,12.65,13.65,14.65,15.65,16.65,17.65,18.65};
   Float_t y1[]  = { 0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0,
		     0.0 };
   Float_t ex1[] = {.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,
		    .0,.0,.0,.0,.0,.0,.0,.0,.0};
   Float_t ey1[] = { 0.2 ,     
		     0.2 , 
		     0.2 , 
		     0.2 , 
		     0.2 , 
		     0.2 , 
		     0.2 , 
		     0.2 , 
		     0.2 ,     
		     0.2 ,     
		     0.2 , 
		     0.2 , 
		     0.2 ,     
		     0.2 ,     
		     0.2 , 
		     0.2 , 
		     0.2 ,     
		     0.2 , 
		     0.2 };
   gStyle->SetErrorX(2.); 
   gr1 = new TGraphErrors(n1,x1,y1,ex1,ey1);
   gr1->SetLineColor(kBlue);  
   gr1->SetLineWidth(1);  
   gr1->SetMarkerColor(kBlack);
   gr1->SetMarkerSize(1);
   gr1->SetMarkerStyle(1);
   gr1->SetMarkerSize(1);

//   gr1->SetMarkerStyle(1); //a small dot
//   gr1->SetMarkerSize(10);  //to get large tick marks (3 times the default)
//   gr1->Draw("a");     //will draw the graph with the error bars
//   gr1->SetMarkerStyle(21);//choose the real marker
//   gr1->SetMarkerSize(1);  //with the right size
//   //   gr1->Draw("pX");        //draw the marker only

   // gr1->SetErrorX(1);
   gr1->Draw("E");

   // hr->Draw("same");

   TLatex* latex1 = new TLatex(0.19, 0.27, "Insert comment");
   latex1->SetTextSize(0.06);
   latex1->SetTextColor(kRed);
   latex1->SetNDC();
   latex1->Draw();
   TLatex* latex2 = new TLatex(0.59, 0.27, "Insert comment");
   latex2->SetTextSize(0.06);
   latex2->SetTextColor(kBlue);
   latex2->SetNDC();
   latex2->Draw();
   TLatex* latex3 = new TLatex(0.39, 0.94, "Insert title");
   latex3->SetTextSize(0.06);
   latex3->SetTextColor(kBlack);
   latex3->SetNDC();
   latex3->Draw();


   padlogo->Draw();
   padlogo->cd();
   // superimpose Fittino Logo
   TImage *img = TImage::Open("logo_fittino.png");
   if (!img) {
	    printf("Could not create an image... exitn");
	    return;
   }
   img->SetConstRatio(0);
   img->SetImageQuality(TAttImage::kImgBest);
   img->Draw("same");

   c1->Update();
   c1->Print("rel_unc_bias.eps");


}
