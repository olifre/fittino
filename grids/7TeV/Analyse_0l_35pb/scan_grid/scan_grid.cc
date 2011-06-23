#include <iostream>
#include <fstream>
#include <TMath>

float llratio( float _nS, float _nS_unc, float _nBkg, float _nBkg_unc, float _nData, TString option ){

  float n = 0;

  if( option != "expected_sb" ){
    static TRandom3 random;

    // Relative uncertainty
    float Bkg_scale = 1;
    float S_scale = 1;
    while (1) {
      Bkg_scale = random.Gaus( 1, _nBkg_unc );
      if (Bkg_scale>0.) break;
    } 
    while (1) {
      S_scale = random.Gaus( 1, _nS_unc );
      if (S_scale>0.) break;
    }
  
    // Hypothese background or background+signal
    if( option == "b" ) n = (float) random.Poisson( _nBkg * Bkg_scale );
    if( option == "sb" ) n = (float) random.Poisson( _nBkg * Bkg_scale + _nS * S_scale );
  }
  if( option == "expected_sb" ) n = _nData;


  // Log likelihood ration (s+b)/b for Poisson
  float ll_sb = n * TMath::Log( _nS + _nBkg ) - ( _nS + _nBkg );
  float ll_b  = n * TMath::Log( _nBkg ) - _nBkg;

  return ( ll_sb - ll_b );
}


void scan_grid(){

  // Toy parameters
  const int nToys = 200;

  // Expected background yields und relative uncertainties for each region (Table 2)
  // when assymetric uncertainties, take largest one
  float nBkg_A = 118;
  float nBkg_B = 10;
  float nBkg_C = 88;
  float nBkg_D = 2.5;
  float nBkg_A_unc = TMath::Sqrt( float(25*25 + 32*32 + 12*12) )/nBkg_A;
  float nBkg_B_unc = TMath::Sqrt( float(4.3*4.3 + 4*4 + 1*1) )/nBkg_B;
  float nBkg_C_unc = TMath::Sqrt( float(18*18 + 26*26 + 9*9) )/nBkg_C;
  float nBkg_D_unc = TMath::Sqrt( float(1*1 + 1*1 + 0.2*0.2) )/nBkg_D;
  float nS = 0;
  float nS_unc = 0.30;

  // Output
  TFile* output = new TFile("scan_grid.root", "recreate");
  Float_t binsM0[18]  = { 20, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600 };
  Float_t binsM12[23]  = {  100, 150,  200,  225,  250, 275, 300, 325, 350, 375, 400, 450, 500, 550, 600, 650, 700, 750, 800, 900, 1000, 1100, 1200 };  
  TH2F *h_CLsb_2D = new TH2F( "h_CLsb_2D", "", 17, binsM0, 22, binsM12 );
  TH2F *h_CLb_2D = new TH2F( "h_CLb_2D", "", 17, binsM0, 22, binsM12 );
  TH2F *h_discovery_2D = new TH2F( "h_discovery_2D", "", 17, binsM0, 22, binsM12 );
  TH2F *h_chi2_2D = new TH2F( "h_chi2_2D", "", 17, binsM0, 22, binsM12 );

  // == Openning file with grid points
  ifstream gridfile ( "WriteGrid_mSUGRA.txt" );
  float M0, M12, msq, mg, A, B, C, D;
  while( gridfile >> M0 >> M12 >> msq >> mg >> A >> B >> C >> D ){

    // Expected signal
    cout << M0 <<"  "<< M12 <<"  "<< msq <<"  "<< mg <<"  "<< A <<"  "<< B <<"  "<< C << endl;
    float largCD = TMath::Max( C, D );
    float largAB = TMath::Max( A, B );
    nS = TMath::Max( largAB, largCD );
    
    // Expected background
    float nBkg, nBkg_unc;
    if( nS == A ){
      nBkg = nBkg_A;
      nBkg_unc = nBkg_A_unc;
    }
    if( nS == B ){
      nBkg = nBkg_B;
      nBkg_unc = nBkg_B_unc;
    }
    if( nS == C ){
      nBkg = nBkg_C;
      nBkg_unc = nBkg_C_unc;
    }
    if( nS == D ){
      nBkg = nBkg_D;
      nBkg_unc = nBkg_D_unc;
    }

    // Observation of background only in data
    float llratio_data = llratio( nS, nS_unc, nBkg, nBkg_unc, nBkg, "expected_sb" );
    cout << "llratio_data = " << llratio_data << endl;
    int nCLsb = 0, nCLb = 0;

    // Creation of subdirectory
    TString dir = Form( "%1.0f_%1.0f", M0, M12 );
    output->mkdir( dir );
    output->cd( dir );
    TH1F* h_llratio_sb = new TH1F( "h_llratio_sb", "", 10000, -200000, 200000 );
    TH1F* h_llratio_b = new TH1F( "h_llratio_b", "", 10000, -200000, 200000 );
    TH1F* h_CLsb = new TH1F( "h_CLsb", "", nToys+1, 0, nToys );
    TH1F* h_CLb = new TH1F( "h_CLb", "", nToys+1, 0, nToys );

    for( int i = 0; i < nToys; i++ ){
      float llratio_sb = llratio( nS, nS_unc, nBkg, nBkg_unc, nBkg, "sb" );
      float llratio_b = llratio( nS, nS_unc, nBkg, nBkg_unc, nBkg, "b" );
      h_llratio_sb->Fill( llratio_sb );
      h_llratio_b->Fill( llratio_b );
      //cout << "llratio_sb  llratio_b = " << llratio_sb <<"   "<< llratio_b << endl;

      if( llratio_sb < llratio_data ) nCLsb++;
      if( llratio_b < llratio_data ) nCLb++;

      if( i > 0 ){
	float intermCLsb = float(nCLsb)/float(i);
	float intermCLb = float(nCLb)/float(i);
	h_CLsb->SetBinContent( i, intermCLsb );
	h_CLb->SetBinContent( i, intermCLb );
      }
    }

    float CLsb = float(nCLsb)/float(nToys);
    float CLb = float(nCLb)/float(nToys);

    h_CLsb_2D->Fill( M0, M12, CLsb );
    h_CLb_2D->Fill( M0, M12, CLb );

    cout << "CLsb, CLb = " << CLsb <<"    "<< CLb << endl;
    if( CLsb > 0.05 ) h_discovery_2D->Fill( M0, M12, 1. );
    if( CLsb < 0.05 ) h_discovery_2D->Fill( M0, M12, 0. );

    float chi2 = 2 * TMath::ErfInverse(1 - 2*CLsb) * TMath::ErfInverse(1 - 2*CLsb);
    h_chi2_2D->Fill( M0, M12, chi2 );

    h_llratio_sb->Write();
    h_llratio_b->Write();
    h_CLsb->Write();
    h_CLb->Write();

  }
  gridfile.close();

  output->cd();
  h_CLsb_2D->Write();
  h_CLb_2D->Write();
  h_discovery_2D->Write();
  h_chi2_2D->Write();
  output->Close();


  return;
}
