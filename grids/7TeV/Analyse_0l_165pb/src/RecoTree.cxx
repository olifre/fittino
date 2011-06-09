#define RecoTree_cxx
#include "RecoTree.h"


float RecoTree::Loop( TString signalRegion ){

  // Book some histograms and write them in a root file
  TFile* output = 0;
  
  int NumberOfJets;
  float ratio;

  if( signalRegion == "2jets" ){
    output = new TFile("2jets.root", "RECREATE" );
    NumberOfJets=2;
    ratio=0.3;
  }
  else if( signalRegion == "3jets" ){
    output = new TFile("3jets.root", "RECREATE" );
    NumberOfJets=3;
    ratio=0.25;
  }
  else if( signalRegion == "4jets" ){
    output = new TFile("4jets.root", "RECREATE" );
    NumberOfJets=4;
    ratio=0.25;
  }
  else {
    cout<<"unknown signal region"<<endl;
    exit(-1);
  }

  output->cd();

  TH1I* h_njets = new TH1I( "h_njets", "", 21, 0, 20 );
  TH1I* h_nel = new TH1I( "h_nel", "", 21, 0, 20 );
  TH1I* h_nmu = new TH1I( "h_nmu", "", 21, 0, 20 );
  TH1F* h_ptjets = new TH1F( "h_ptjets", "", 100, 0, 200 );
  TH1F* h_ptel = new TH1F( "h_ptel", "", 100, 0, 100 );
  TH1F* h_ptmu = new TH1F( "h_ptmu", "", 100, 0, 100 );
  TH1F* h_etajets = new TH1F( "h_etajets", "", 100, 0, 4 );
  TH1F* h_etael = new TH1F( "h_etael", "", 100, 0, 4 );
  TH1F* h_etamu = new TH1F( "h_etamu", "", 100, 0, 4 );
  TH1I* h_flagMedel = new TH1I( "h_flagMedel", "", 2, 0, 1 );

  TH1F* h_dR_jete = new TH1F( "h_dR_jete", "", 100, 0, 2 );
  TH1F* h_dR_ejet = new TH1F( "h_dR_ejet", "", 100, 0, 2 );
  TH1F* h_dR_mujet = new TH1F( "h_dR_mujet", "", 100, 0, 2 );
  
  TH1I* h_nel_presel = new TH1I( "h_nel_presel", "", 21, 0, 20 );
  TH1I* h_nmu_presel = new TH1I( "h_nmu_presel", "", 21, 0, 20 );
  TH1I* h_njets_presel = new TH1I( "h_njets_presel", "", 21, 0, 20 );

  TH1F* h_ptleadjets = new TH1F( "h_ptleadjets", "", 100, 0, 500 );
  TH1F* h_ptlastjets = new TH1F( "h_ptlastjets", "", 100, 0, 500 );
  TH1F* h_MET = new TH1F( "h_MET", "", 100, 0, 1000 );
  TH1F* h_dPhi = new TH1F( "h_dPhi", "", 100, 0, 3.5 );
  TH1F* h_meff = new TH1F( "h_meff", "", 31, 0, 3100 );
  TH1F* h_METmeff = new TH1F( "h_METmeff", "", 100, 0, 1 );


  TH1F* h_factor = new TH1F( "h_factor", "", 1001, 0, 1000 );
  TH1I* h_cutflow = new TH1I( "h_cutflow", "", 11, 0, 10 );
  TH1I* h_cutflow_eff = new TH1I( "h_cutflow_eff", "", 11, 0, 10 );
  TH1I* h_cutflow_cumeff = new TH1I( "h_cutflow_cumeff", "", 11, 0, 10 );
  int nbSignal[9] = {0};
  float totNormalised = 0;

  Long64_t nentries = fChain->GetEntriesFast();
  for ( Long64_t jentry = 0; jentry < nentries; jentry++ )
    {
      fChain->GetEntry(jentry);

      // Reconstructed objects
      vector< unsigned int >  rec_Jets;
      vector< unsigned int >  rec_Electrons;
      vector< unsigned int >  rec_Muons;
      
      ///////////////////// OBJECTS //////////////////////
      nbSignal[0]++;
      h_njets->Fill( Jet );
      h_nel->Fill( Electron );
      h_nmu->Fill( Muon );
      

      // Jets
      for( int ijet = 0; ijet < Jet; ijet++ ){
	
	h_ptjets->Fill( (*Jet_PT)[ijet] );
	if( (*Jet_PT)[ijet] <= 20 ) continue;	
	
	h_etajets->Fill( fabs((*Jet_Eta)[ijet]) );
	if( fabs((*Jet_Eta)[ijet]) >= 2.8 ) continue;
	
	rec_Jets.push_back( ijet );
	
      }
      
      // Electrons
      for( int iel = 0; iel < Electron; iel++ ){

	h_ptel->Fill( (*Electron_PT)[iel] );	
	if( (*Electron_PT)[iel] <= 20 ) continue;
	
	h_etael->Fill( fabs((*Electron_Eta)[iel]) );
	if( fabs((*Electron_Eta)[iel]) >= 2.47 ) continue;

	h_flagMedel->Fill( (*Electron_FlagMedium)[iel] );
	if( (*Electron_FlagMedium)[iel] != 1 ) continue;

	rec_Electrons.push_back( iel );
	  
      }

      // Muons
      for( int imu = 0; imu < Muon; imu++ ){

	h_ptmu->Fill( (*Muon_PT)[imu] );
	if( (*Muon_PT)[imu] <= 10 ) continue;
	
	h_etamu->Fill( fabs((*Muon_Eta)[imu]) );
	if( fabs((*Muon_Eta)[imu]) >= 2.4 ) continue;
	
	if ((*Muon_ID)[imu] != 1) continue;

	rec_Muons.push_back( imu );
      }


      //sort all reconstructed objects according to PT
      //in this Analysis only necessary for jets which should be correctly ordered by Delphes,
      // so not necessary at all ;)

//       vector< pair<double, int> >  v;
//       for (unsigned int i=0; i<rec_Muons.size(); i++){
// 	v.push_back(make_pair((*Muon_PT)[rec_Muons[i]],rec_Muons[i]));
//       }
//       sort(v.begin(), v.end());
//       for (unsigned int i=0; i<rec_Muons.size(); i++){
// 	rec_Muons[i]=v[i].second;
//       }
//       v.clear();

//       for (unsigned int i=0; i<rec_Jets.size(); i++){
// 	v.push_back(make_pair((*Jet_PT)[rec_Jets[i]],rec_Jets[i]));
//       }
//       sort(v.begin(), v.end());
//       for (unsigned int i=0; i<rec_Jets.size(); i++){
// 	rec_Jets[i]=v[i].second;
//       }
//       v.clear();      

//       for (unsigned int i=0; i<rec_Electrons.size(); i++){
// 	v.push_back(make_pair((*Electron_PT)[rec_Electrons[i]],rec_Electrons[i]));
//       }
//       sort(v.begin(), v.end());
//       for (unsigned int i=0; i<rec_Electrons.size(); i++){
// 	rec_Electrons[i]=v[i].second;
//       }
//       v.clear();      

  
      ////////////////// OVERLAP REMOVAL ///////////////

      // jet - electron

	for( unsigned int iel = 0; iel < rec_Electrons.size(); iel++ ){
	  
	  float elPt = (*Electron_PT)[rec_Electrons[iel]];
	  float elEta = (*Electron_Eta)[rec_Electrons[iel]];
	  float elPhi = (*Electron_Phi)[rec_Electrons[iel]];
	  float elE = (*Electron_E)[rec_Electrons[iel]];
	  
	  TLorentzVector lv_el;
	  lv_el.SetPtEtaPhiE( elPt, elEta, elPhi, elE );

	  for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	    
	    float jetPt = (*Jet_PT)[rec_Jets[ijet]];
	    float jetEta = (*Jet_Eta)[rec_Jets[ijet]];
	    float jetPhi = (*Jet_Phi)[rec_Jets[ijet]];
	    float jetE = (*Jet_E)[rec_Jets[ijet]];

	    TLorentzVector lv_jet;
	    lv_jet.SetPtEtaPhiE( jetPt, jetEta, jetPhi, jetE );
	    
	    float dR = lv_jet.DeltaR( lv_el );
	    h_dR_jete->Fill( dR );
	    if( dR < 0.2 ){
	      rec_Jets.erase( rec_Jets.begin() + ijet );
	      ijet--;
	    }
	  }
	}
	

      // Lepton - jet

      for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){

	float jetPt = (*Jet_PT)[rec_Jets[ijet]];
	float jetEta = (*Jet_Eta)[rec_Jets[ijet]];
	float jetPhi = (*Jet_Phi)[rec_Jets[ijet]];
	float jetE = (*Jet_E)[rec_Jets[ijet]];

	TLorentzVector lv_jet;
	lv_jet.SetPtEtaPhiE( jetPt, jetEta, jetPhi, jetE );
	  
	// Electron - jet

	for( unsigned int iel = 0; iel < rec_Electrons.size(); iel++ ){
	    
	  float elPt = (*Electron_PT)[rec_Electrons[iel]];
	  float elEta = (*Electron_Eta)[rec_Electrons[iel]];
	  float elPhi = (*Electron_Phi)[rec_Electrons[iel]];
	  float elE = (*Electron_E)[rec_Electrons[iel]];
	      
	  TLorentzVector lv_el;
	  lv_el.SetPtEtaPhiE( elPt, elEta, elPhi, elE );
	    
	  float dR = lv_jet.DeltaR( lv_el );
	  h_dR_ejet->Fill( dR );
	  if( dR < 0.4 ){
	    rec_Electrons.erase( rec_Electrons.begin() + iel );
	    iel--;
	  }
	}

	// Muon - jet

	for( unsigned int imu = 0; imu < rec_Muons.size(); imu++ ){
	  
	  float muPt = (*Muon_PT)[rec_Muons[imu]];
	  float muEta = (*Muon_Eta)[rec_Muons[imu]];
	  float muPhi = (*Muon_Phi)[rec_Muons[imu]];
	  float muE = (*Muon_E)[rec_Muons[imu]];
	    
	  TLorentzVector lv_mu;
	  lv_mu.SetPtEtaPhiE( muPt, muEta, muPhi, muE );
	    
	  float dR = lv_jet.DeltaR( lv_mu );
	  h_dR_mujet->Fill( dR );
	  if( dR < 0.4 ){
	    rec_Muons.erase( rec_Muons.begin() + imu );
	    imu--;
	  }
	}
      }


      ////////////////// EVENT SELECTION ///////////////
      
      // No lepton with PT>20
      for( unsigned int imu = 0; imu < rec_Muons.size(); imu++ ){
	float muPt = (*Muon_PT)[rec_Muons[imu]];
	if( muPt <= 20 ){
	  rec_Muons.erase( rec_Muons.begin() + imu );
	  imu--;
	}
      }

      h_nel_presel->Fill( rec_Electrons.size() );
      h_nmu_presel->Fill( rec_Muons.size() );
      if( rec_Muons.size() > 0 || rec_Electrons.size() > 0 ) continue;
      nbSignal[1]++;
      
      // Number of jets
      h_njets_presel->Fill( rec_Jets.size() );
      if (rec_Jets.size()<NumberOfJets) continue;
      nbSignal[2]++;

      // Missing ET
      float METphi= (*ETmis_Phi)[0];
      float METpt= (*ETmis_ET)[0];
      TVector2 v_MET;
      v_MET.SetMagPhi(METpt,METphi);      
      
      h_MET->Fill( METpt );
      if( METpt <= 130 ) continue;
      nbSignal[3]++;
      
      //leading jet PT
      float leading_jet_pt=(*Jet_PT)[rec_Jets[0]];
      h_ptleadjets->Fill( leading_jet_pt );
      if( leading_jet_pt <= 130 ) continue;
      nbSignal[4]++;
      
      //last jet PT
      float last_jet_pt=(*Jet_PT)[rec_Jets[NumberOfJets-1]];
      h_ptlastjets->Fill(last_jet_pt);
      if( last_jet_pt <= 40 ) continue;
      nbSignal[5]++;
      
      // Azimuthal distance between jet and MET
      float deltaPhi=1000;
      
      for (int ijet=0; ijet<3 && ijet<rec_Jets.size(); ijet++){
	
	float jet_phi=(*Jet_Phi)[rec_Jets[ijet]];
	float jet_pt=(*Jet_PT)[rec_Jets[ijet]];

	TVector2 v_jet;
	v_jet.SetMagPhi(jet_pt,jet_phi);
	
	float thisDeltaPhi = fabs(v_jet.DeltaPhi(v_MET));
	if (thisDeltaPhi<deltaPhi)  deltaPhi=thisDeltaPhi;
	
      }
	
      h_dPhi->Fill( deltaPhi );
      if( deltaPhi < 0.4 ) continue;
      nbSignal[6]++;

      // Effective mass and ratio
      float meff= METpt;

      for (unsigned int i=0; i<NumberOfJets; i++){

	meff=meff+(*Jet_PT)[rec_Jets[i]];
	
      }

      float ETmis_meff = METpt / meff;

      if (ETmis_meff<ratio) continue;
      h_METmeff->Fill( ETmis_meff );
      nbSignal[7]++;

      h_meff->Fill( meff );
      if (meff>1000) continue;
      nbSignal[8]++;

      
      // Count the number of signal events at the end of the cutflow
      if ( TMath::Finite( factor )  && TMath::IsNaN( factor ) == false ){
	totNormalised += factor;
	h_factor->Fill( factor );
      }
	
    }

  for( int icut = 0; icut < 9; icut++ ){
    h_cutflow->SetBinContent( icut, nbSignal[icut] );
    h_cutflow_cumeff->SetBinContent( icut, 100*(float)nbSignal[icut]/(float)nbSignal[0] );
    if( icut == 0 ) h_cutflow_eff->SetBinContent( icut, 100 );
    else if( nbSignal[icut-1] > 0 ) h_cutflow_eff->SetBinContent( icut, 100*(float)nbSignal[icut]/(float)nbSignal[icut-1] );
    else if( nbSignal[icut-1] == 0 ) h_cutflow_eff->SetBinContent( icut, 0 );
  }

  for( int icut = 0; icut < 9; icut++ )
    cout << "Cut #"<<icut<< " ...  #(evt) = " << nbSignal[icut] <<" ... Eff = " << h_cutflow_eff->GetBinContent( icut ) << " ... Tot Eff = " << h_cutflow_cumeff->GetBinContent( icut ) << endl; 
  
  
  h_njets->Write();
  h_nel->Write();
  h_nmu->Write();
  h_ptjets->Write();
  h_etajets->Write();
  h_ptel->Write();
  h_etael->Write();
  h_flagMedel->Write();
  h_ptmu->Write();
  h_etamu->Write();

  h_dR_jete->Write();
  h_dR_ejet->Write();
  h_dR_mujet->Write();

  h_nel_presel->Write();
  h_nmu_presel->Write();
  h_ptleadjets->Write();
  h_ptlastjets->Write();
  h_njets_presel->Write();
  h_MET->Write();
  h_dPhi->Write();
  h_meff->Write();
  h_METmeff->Write();

  h_factor->Write();
  h_cutflow->Write();
  h_cutflow_eff->Write();
  h_cutflow_cumeff->Write();
  
  output->Write();
  output->Close();
  
  return totNormalised;
}



  
