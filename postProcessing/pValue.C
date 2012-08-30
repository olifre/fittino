


// == Values from the best fit point
Float_t bestFit_chi2;
Float_t bestFit_O_Bsg_npf;  
Float_t bestFit_O_dm_s_npf;
Float_t bestFit_O_Btn_npf;
Float_t bestFit_O_gmin2m_npf;
Float_t bestFit_O_omega;
Float_t bestFit_O_Massh0_npf;
Float_t bestFit_O_MassW_npf;
Float_t bestFit_O_sin_th_eff_npf;
Float_t bestFit_O_B_smm_npf;
Float_t bestFit_O_massTop;
Float_t bestFit_P_M0;
Float_t bestFit_P_M12;
Float_t bestFit_P_A0;
Float_t bestFit_P_TanBeta;
Float_t bestFit_P_massTop;
Float_t bestFit_P_M0H;
Float_t bestFit_P_M0Hu;
Float_t bestFit_P_M0Hd;
TNtuple* bestFit_ntpl = 0;

// == Values from the toys
Float_t chi2;
Float_t O_Bsg_npf;  
Float_t O_dm_s_npf;
Float_t O_Btn_npf;
Float_t O_gmin2m_npf;
Float_t O_omega;
Float_t O_Massh0_npf;
Float_t O_MassW_npf;
Float_t O_sin_th_eff_npf;
Float_t O_B_smm_npf;
Float_t O_massTop;
Float_t P_M0;
Float_t P_M12;
Float_t P_A0;
Float_t P_TanBeta;
Float_t P_massTop;
Float_t P_M0H;
Float_t P_M0Hu;
Float_t P_M0Hd;
vector<float> vM0_left, vM0_right;
vector<float> vM12_left, vM12_right;
vector<float> vA0_left, vA0_right;
vector<float> vTanBeta_left, vTanBeta_right;
vector<float> vmassTop_left, vmassTop_right;
vector<float> vM0H_left, vM0H_right;
vector<float> vM0Hu_left, vM0Hu_right;
vector<float> vM0Hd_left, vM0Hd_right;
float probableM0;
float probableM12;
float probableA0;
float probableTanBeta;
float probablemassTop;
float probableM0H;
float probableM0Hu;
float probableM0Hd;
TNtuple* ntpl = 0;
TH1F* probChi2 = new TH1F("probChi2", "", 100, 0, 1 );

// ==============================================
// == Fill arrays centered on the most probable point
void fillArrays( vector<float>& leftToys, vector<float>& rightToys, TString par, float probable ){
  for( Int_t itoy = 0; itoy < ntpl->GetEntries(); ++itoy )
    {
      ntpl->GetEntry( itoy );
      float P_par;
      if( par == "M0" ) P_par = P_M0;
      if( par == "M12" ) P_par = P_M12;
      if( par == "A0" ) P_par = P_A0;
      if( par == "TanBeta" ) P_par = P_TanBeta;
      if( par == "massTop" ) P_par = P_massTop;
      if( par == "M0H" ) P_par = P_M0H;
      if( par == "M0Hu" ) P_par = P_M0Hu;
      if( par == "M0Hd" ) P_par = P_M0Hd;      
      if( P_par < probable ) leftToys.push_back( P_par );
      else rightToys.push_back( P_par );
    }
  sort( rightToys.begin(), rightToys.end() );
  sort( leftToys.begin(), leftToys.end() );
  reverse( leftToys.begin(), leftToys.end() );
  return;
}


// ==============================================
// == Scan the toys population to estimate the 1sigma contour (68%)
void scanToys( vector<float> leftToys, vector<float> rightToys, TString par ){
  
  cout << " >>> " << par << endl;

  // == Starting from the most probable value to the left side
  float leftLimit, rightLimit;
  float leftFullFrac = 0.34, rightFullFrac = 0.34;
  int totSize = leftToys.size() + rightToys.size();
  int leftPoints = 0, rightPoints = 0;
  float leftFrac = 0, rightFrac = 0;
  
  for( Int_t itoy = 0; itoy < leftToys.size(); itoy++ )
    {
      leftFrac = float(leftPoints)/float(totSize);
      if( leftFrac < leftFullFrac ) leftPoints++;
      if( leftFrac >= leftFullFrac ){
	leftLimit = leftToys[itoy];
	break;
      }
    }

  // == if the left side is at the edge, enlarge the other side to compensate
  if( leftFrac < leftFullFrac ){
    leftLimit = leftToys[leftToys.size()-1];
    cout << "Collapse on left side, fraction only of " << leftFrac << endl;
    rightFullFrac = rightFullFrac + (leftFullFrac-leftFrac);
    cout << "Compensate by requesting " << rightFullFrac << " on the right side" << endl;
  }

  // == Starting from the most probable value to the right side
   for( Int_t itoy = 0; itoy < rightToys.size(); itoy++ ){
     rightFrac = float(rightPoints)/float(totSize);
     if( rightFrac < rightFullFrac ) rightPoints++;
     if( rightFrac >= rightFullFrac ){
       rightLimit = rightToys[itoy];
       break;
     }
   }
   cout << "1sigma limits for " << par << " = " << leftLimit << "    " << rightLimit << endl;
   return;
}



// ==============================================
//                MAIN FUNCTION
// Calculate the 1sigma limits and the pValue
// ==============================================

void pValue( TString ROOTfile )
{
  // == Model considered
  TString model = "";
  if( ROOTfile.Contains("NUHM1") ) model = "NUHM1";
  else if( ROOTfile.Contains("NUHM2") ) model = "NUHM2";
  else model = "msugra";

  // == Open the input file
  cout << " --- Opening input file --- " << endl;
  TFile f( ROOTfile );

  // == Get the ntuple of toys
  ntpl = (TNtuple*) f.Get("toyNtuple");
  ntpl->SetBranchAddress("chi2",&chi2 );
  ntpl->SetBranchAddress("P_M0",&P_M0 );
  ntpl->SetBranchAddress("P_M12",&P_M12 );
  ntpl->SetBranchAddress("P_A0",&P_A0 );
  //ntpl->SetBranchAddress("P_massTop", &P_massTop );
  ntpl->SetBranchAddress("P_TanBeta",&P_TanBeta );
  if( model == "NUHM1" ) ntpl->SetBranchAddress("P_M0H",&P_M0H );
   if( model == "NUHM2" ){
    ntpl->SetBranchAddress("P_M0Hu",&P_M0Hu );
    ntpl->SetBranchAddress("P_M0Hd",&P_M0Hd );
  }
  ntpl->SetBranchAddress("O_massTop",&O_massTop );
  ntpl->SetBranchAddress("O_Bsg_npf",&O_Bsg_npf );
  ntpl->SetBranchAddress("O_dm_s_npf",&O_dm_s_npf );
  ntpl->SetBranchAddress("O_Btn_npf",&O_Btn_npf );
  ntpl->SetBranchAddress("O_omega",&O_omega);
  ntpl->SetBranchAddress("O_gmin2m_npf",&O_gmin2m_npf);
  ntpl->SetBranchAddress("O_Massh0_npf",&O_Massh0_npf );
  ntpl->SetBranchAddress("O_MassW_npf",&O_MassW_npf );
  ntpl->SetBranchAddress("O_sin_th_eff_npf",&O_sin_th_eff_npf );
  ntpl->SetBranchAddress("O_B_smm_npf",&O_B_smm_npf );

  /*
 // == Get the ntuple of the best fit point
  bestFit_ntpl = (TNtuple*) f.Get("bestFitNtuple");
  bestFit_ntpl->SetBranchAddress("bestFit_P_M0",&bestFit_P_M0 );
  bestFit_ntpl->SetBranchAddress("bestFit_P_M12",&bestFit_P_M12 );
  bestFit_ntpl->SetBranchAddress("bestFit_P_A0",&bestFit_P_A0 );
  //bestFit_ntpl->SetBranchAddress("bestFit_P_massTop", &bestFit_P_massTop );
  bestFit_ntpl->SetBranchAddress("bestFit_P_TanBeta",&bestFit_P_TanBeta );
  if( model == "NUHM1" ) bestFit_ntpl->SetBranchAddress("bestFit_P_M0H",&bestFit_P_M0H );
   if( model == "NUHM2" ){
    bestFit_ntpl->SetBranchAddress("bestFit_P_M0Hu",&bestFit_P_M0Hu );
    bestFit_ntpl->SetBranchAddress("bestFit_P_M0Hd",&bestFit_P_M0Hd );
  }
  bestFit_ntpl->SetBranchAddress("bestFit_O_massTop",&bestFit_O_massTop );
  bestFit_ntpl->SetBranchAddress("bestFit_O_Bsg_npf",&bestFit_O_Bsg_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_dm_s_npf",&bestFit_O_dm_s_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_Btn_npf",&bestFit_O_Btn_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_omega",&bestFit_O_omega);
  bestFit_ntpl->SetBranchAddress("bestFit_O_gmin2m_npf",&bestFit_O_gmin2m_npf);
  bestFit_ntpl->SetBranchAddress("bestFit_O_Massh0_npf",&bestFit_O_Massh0_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_MassW_npf",&bestFit_O_MassW_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_sin_th_eff_npf",&bestFit_O_sin_th_eff_npf );
  bestFit_ntpl->SetBranchAddress("bestFit_O_B_smm_npf",&bestFit_O_B_smm_npf );
  */

  // == Get the position of the most probable point
  cout << " --- Position of the most probable point --- " << endl;
  ntpl->Draw("P_M0>>h_M0","P_M0<1000");
  ntpl->Draw("P_M12>>h_M12","P_M12<1000");
  ntpl->Draw("P_A0>>h_A0");
  ntpl->Draw("P_TanBeta>>h_TanBeta");
  //ntpl->Draw("P_massTop>>h_massTop");
  if( model == "NUHM1" ) ntpl->Draw("P_M0H>>h_M0H");
  if( model == "NUHM2" ){
    ntpl->Draw("P_M0Hu>>h_M0Hu");
    ntpl->Draw("P_M0Hd>>h_M0Hd");
  }
   probableM0 = h_M0->GetBinCenter(h_M0->GetMaximumBin());
   probableM12 = h_M12->GetBinCenter(h_M12->GetMaximumBin());
   probableA0 = h_A0->GetBinCenter(h_A0->GetMaximumBin());
   probableTanBeta = h_TanBeta->GetBinCenter(h_TanBeta->GetMaximumBin());
   //probablemassTop = h_massTop->GetBinCenter(h_massTop->GetMaximumBin());
  if( model == "NUHM1" )  probableM0H = h_M0H->GetBinCenter(h_M0H->GetMaximumBin());
  if( model == "NUHM2" ){
     probableM0Hu = h_M0Hu->GetBinCenter(h_M0Hu->GetMaximumBin());
     probableM0Hd = h_M0Hd->GetBinCenter(h_M0Hd->GetMaximumBin());
  }
  cout << "M0 = " << probableM0 << endl;
  cout << "M12 = " << probableM12 << endl;
  cout << "A0 = " << probableA0 << endl;
  cout << "TanBeta = " << probableTanBeta << endl;
  //cout << "massTop = " << probablemassTop << endl;
  if( model == "NUHM1" ) cout << "M0H = " << probableM0H << endl;
  if( model == "NUHM2" ){
    cout << "M0Hu = " << probableM0Hu << endl;
    cout << "M0Hd = " << probableM0Hd << endl;
   }
 
  // == Fill arrays centered on the most probable point
  cout << " --- Filling left-right arrays --- " << endl;
  fillArrays( vM0_left, vM0_right, "M0", probableM0 );
  fillArrays( vM12_left, vM12_right, "M12", probableM12 );
  fillArrays( vA0_left, vA0_right, "A0", probableA0 );
  fillArrays( vTanBeta_left, vTanBeta_right, "TanBeta", probableTanBeta );
  fillArrays( vmassTop_left, vmassTop_right, "massTop", probablemassTop );
  if( model == "NUHM1" ) fillArrays( vM0H_left, vM0H_right, "M0H", probableM0H );
  if( model == "NUHM2" ){
    fillArrays( vM0Hu_left, vM0Hu_right, "M0Hu", probableM0Hu );
    fillArrays( vM0Hd_left, vM0Hd_right, "M0Hd", probableM0Hd );
  }

  // == Scan the toys population to estimate the 1sigma contour (68%)
 cout << " --- Scaning left-right arrays --- " << endl;
 scanToys( vM0_left, vM0_right, "M0" );
 scanToys( vM12_left, vM12_right, "M12" );
 scanToys( vA0_left, vA0_right, "A0" );
 scanToys( vTanBeta_left, vTanBeta_right, "TanBeta" );
  //scanToys( vmassTop_left, vmassTop_right, "massTop" );
 if( model == "NUHM1" ) scanToys( vM0H_left, vM0H_right, "M0H" );
 if( model == "NUHM2" ){
     scanToys( vM0Hu_left, vM0Hu_right, "M0Hu" );
     scanToys( vM0Hd_left, vM0Hd_right, "M0Hd" );
  } 


 // == Calculate the p-value for the measured chi2
 int nAbove = 0;

 for( Int_t itoy = 0; itoy < ntpl->GetEntries(); ++itoy )
   {
     ntpl->GetEntry( itoy );
     if( chi2 >= 10.2 ) nAbove++;
     Float_t prob = TMath::Prob( chi2, 3 );
     probChi2->Fill( prob );
   }
 Float_t pVal = float(nAbove)/float(ntpl->GetEntries());
 Float_t uncpVal = TMath::Sqrt( pVal*(1-pVal) / 1000 );
 cout << " >>> p-value = " << 100*pVal << " +- " << 100*uncpVal << " % " << endl;
 probChi2->Draw();
 
 return;
}
