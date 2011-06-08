#define RecoTree_cxx
#include "RecoTree.h"


float RecoTree::Loop( TString signalRegion )
{
  // Book some histograms and write them in a root file
  TFile* output = 0;
  if( signalRegion == "A" ) output = new TFile( output_A, "RECREATE" );
  if( signalRegion == "B" ) output = new TFile( output_B, "RECREATE" );
  if( signalRegion == "C" ) output = new TFile( output_C, "RECREATE" );
  if( signalRegion == "D" ) output = new TFile( output_D, "RECREATE" );
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
  TH1F* h_sumptmu = new TH1F( "h_sumptmu","", 100, 0, 20 );

  TH1F* h_dR_jete = new TH1F( "h_dR_jete", "", 100, 0, 2 );
  TH1F* h_dR_ejet = new TH1F( "h_dR_ejet", "", 100, 0, 2 );
  TH1F* h_dR_mujet = new TH1F( "h_dR_mujet", "", 100, 0, 2 );

  TH1I* h_nel_presel = new TH1I( "h_nel_presel", "", 21, 0, 20 );
  TH1I* h_nmu_presel = new TH1I( "h_nmu_presel", "", 21, 0, 20 );

  TH1F* h_ptleadjets = new TH1F( "h_ptleadjets", "", 100, 0, 500 );
  TH1I* h_njets_presel = new TH1I( "h_njets_presel", "", 21, 0, 20 );
  TH1F* h_MET = new TH1F( "h_MET", "", 100, 0, 1000 );
  TH1F* h_dPhi = new TH1F( "h_dPhi", "", 100, 0, 3.5 );
  TH1F* h_meff = new TH1F( "h_meff", "", 100, 0, 3000 );
  TH1F* h_METmeff = new TH1F( "h_METmeff", "", 100, 0, 1 );
  TH1F* h_mT2 = new TH1F( "h_mT2", "", 100, 0, 1000 );

  TH1F* h_factor = new TH1F( "h_factor", "", 1001, 0, 1000 );

  TH1I* h_cutflow = new TH1I( "h_cutflow", "", 11, 0, 10 );
  TH1I* h_cutflow_eff = new TH1I( "h_cutflow_eff", "", 11, 0, 10 );
  TH1I* h_cutflow_cumeff = new TH1I( "h_cutflow_cumeff", "", 11, 0, 10 );
  int nbSignal[10] = {0};
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
      if( Jet > 0 ){
	for( int ijet = 0; ijet < Jet; ijet++ ){

	   h_ptjets->Fill( (*Jet_PT)[ijet] );
	  if( (*Jet_PT)[ijet] < 20 ) continue;	

	   h_etajets->Fill( fabs((*Jet_Eta)[ijet]) );
	  if( fabs((*Jet_Eta)[ijet]) > 2.5 ) continue;

	  rec_Jets.push_back( ijet );
	}
      }
      // Electrons
      if( Electron > 0 ){
	for( int iel = 0; iel < Electron; iel++ ){

	   h_ptel->Fill( (*Electron_PT)[iel] );	
	  if( (*Electron_PT)[iel] < 10 ) continue;

	   h_etael->Fill( fabs((*Electron_Eta)[iel]) );
	  if( fabs((*Electron_Eta)[iel]) > 2.47 ) continue;
	   h_flagMedel->Fill( (*Electron_FlagMedium)[iel] );
	  if( (*Electron_FlagMedium)[iel] != 1 ) continue;

	  rec_Electrons.push_back( iel );
	}
      }
      // Muons
      if( Muon > 0 ){
	for( int imu = 0; imu < Muon; imu++ ){

	   h_ptmu->Fill( (*Muon_PT)[imu] );
	  if( (*Muon_PT)[imu] < 10 ) continue;

	   h_etamu->Fill( fabs((*Muon_Eta)[imu]) );
	  if( fabs((*Muon_Eta)[imu]) > 2.4 ) continue;

	   h_sumptmu->Fill( (*Muon_SumPt)[imu] );
	  if( (*Muon_SumPt)[imu] > 1.8 ) continue;

	  if ((*Muon_ID)[imu] != 1) continue;

	  rec_Muons.push_back( imu );
	}
      }

  
      ////////////////// OVERLAP REMOVAL ///////////////

      // jet - electron

      if( rec_Electrons.size() > 0 && rec_Jets.size() > 0 ){

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
      }
      
      // Electrons in crack region 
      
      bool crack = 0;
      for( unsigned int iel = 0; iel < rec_Electrons.size(); iel++ ){
	if( fabs((*Electron_Eta)[rec_Electrons[iel]]) > 1.37 && 
	    fabs((*Electron_Eta)[rec_Electrons[iel]]) < 1.52 ) crack = 1;
      }
      if( crack ) continue;
      nbSignal[1]++;

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
	
	// No lepton
	 h_nel_presel->Fill( rec_Electrons.size() );
	 h_nmu_presel->Fill( rec_Muons.size() );
	 if( rec_Muons.size() > 0 || rec_Electrons.size() > 0 ) continue;
	 nbSignal[2]++;

	// Jets pt
	for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	  if( (*Jet_PT)[rec_Jets[ijet]] < 40 ) rec_Jets.erase( rec_Jets.begin() + ijet );
	}
	
	// Highest pT pre-selected jets
	vector < float > rec_ptjets ( 3, -1000. );
	// #1
	for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	  float jetPt = (*Jet_PT)[rec_Jets[ijet]];
	  if( jetPt > rec_ptjets[0] ) rec_ptjets[0] = jetPt;
	}
	// #2
	for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	  float jetPt = (*Jet_PT)[rec_Jets[ijet]];
	  if( jetPt > rec_ptjets[1] && jetPt < rec_ptjets[0] ) rec_ptjets[1] = jetPt;
	}
	// #3
	for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	  float jetPt = (*Jet_PT)[rec_Jets[ijet]];
	  if( jetPt > rec_ptjets[2] && jetPt < rec_ptjets[1] ) rec_ptjets[2] = jetPt;
	}

	 h_ptleadjets->Fill( rec_ptjets[0] );
	 if( rec_ptjets[0] < 120 ) continue;
	 nbSignal[3]++;

	// Number jets
	 h_njets_presel->Fill( rec_Jets.size() );
	 if( signalRegion == "A" && rec_Jets.size() < 2 ) continue;
	 if( signalRegion == "B" && rec_Jets.size() < 2 ) continue;
	 if( signalRegion == "C" && rec_Jets.size() < 3 ) continue;
	 if( signalRegion == "D" && rec_Jets.size() < 3 ) continue;
	 nbSignal[4]++;

	// Missing ET
	 h_MET->Fill( (*ETmis_ET)[0] );
	if( (*ETmis_ET)[0] < 100 ) continue;
	nbSignal[5]++;

	// Jet quality
	// ??????

	// Vertices
	// ??????

	// Three higher pT jets, pre-selected or not
	vector < int > jets ( 3, -1 );
	vector < float > ptjets ( 3, -1000. );
	vector < float > dphijets ( 3, 1000. );
	// #1
	for( int ijet = 0; ijet < Jet; ijet++ ){
	  float thisjetpt = (*Jet_PT)[ijet];
	  if( thisjetpt < 40 ) continue;
	  if( thisjetpt > ptjets[0] && jets[0] == -1 ){
	    jets[0] = ijet;
	    ptjets[0] = thisjetpt;
	    dphijets[0] = (*Jet_Phi)[ijet];
	  }
	  if( jets[0] != -1 ) break;
	}
	// #2
	if( Jet > 1 ){
	for( unsigned int ijet = 0; ijet < Jet; ijet++ ){
	  float thisjetpt = (*Jet_PT)[ijet];
	  if( thisjetpt < 40 ) continue;
	  if( thisjetpt > ptjets[1] && ijet != jets[0] && jets[0] != -1 && jets[1] == -1 && jets[2] == -1 ){
	    jets[1] = ijet;
	    ptjets[1] = thisjetpt;
	    dphijets[1] = (*Jet_Phi)[ijet];
	  }
	  if( jets[1] != -1 ) break;
	}
	}
	// #3
	if( Jet > 2 ){
	for( unsigned int ijet = 0; ijet < Jet; ijet++ ){
	  float thisjetpt = (*Jet_PT)[ijet];
	  if( thisjetpt < 40 ) continue;
	  if( thisjetpt > ptjets[2] && ijet != jets[0] && ijet != jets[1] &&
	      jets[0] != -1 && jets[1] != -1 && jets[2] == -1 ){
	    jets[2] = ijet;
	    ptjets[2] = thisjetpt;
	    dphijets[2] = (*Jet_Phi)[ijet];
	  }
	  if( jets[2] != -1 ) break;
	}
	}

	// Azimuthal distance between jet and MET
	float deltaPhi = 1000;
	for( unsigned int ijet = 0; ijet < dphijets.size(); ijet++ ){
	  if( ptjets[ijet] == -1000 ) continue;
	  float _deltaPhi = fabs( dphijets[ijet] - (*ETmis_Phi)[0] );
	  if( _deltaPhi > 3.141592 ) _deltaPhi = fabs( _deltaPhi - 2*TMath::Pi() );
	  if( _deltaPhi < deltaPhi ) 
	    deltaPhi = _deltaPhi;
	}
	 h_dPhi->Fill( deltaPhi );
	if( deltaPhi < 0.4 ) continue;
	nbSignal[6]++;

	// Effective mass
	float meff = -1000;
	if( signalRegion == "A" ) meff = (*ETmis_ET)[0] + rec_ptjets[0] + rec_ptjets[1];
	if( signalRegion == "C" ) meff = (*ETmis_ET)[0] + rec_ptjets[0] + rec_ptjets[1] + rec_ptjets[2];
	if( signalRegion == "D" ) meff = (*ETmis_ET)[0] + rec_ptjets[0] + rec_ptjets[1] + rec_ptjets[2];
	
	 h_meff->Fill( meff );
	if( signalRegion == "A" && meff < 500 ) continue;
	if( signalRegion == "C" && meff < 500 ) continue;
	if( signalRegion == "D" && meff < 1000 ) continue;
	nbSignal[7]++;

	// ETmis / meff
	float ETmis_meff = (*ETmis_ET)[0] / meff;
	 h_METmeff->Fill( ETmis_meff );
	if( signalRegion == "A" && ETmis_meff < 0.3 ) continue;
	if( signalRegion == "C" && ETmis_meff < 0.25 ) continue;
	if( signalRegion == "D" && ETmis_meff < 0.25 ) continue;
	nbSignal[8]++;

	// Transverse masse2
	float mT2 = 0;
	// http://iopscience.iop.org/1126-6708/2008/12/063/pdf/1126-6708_2008_12_063.pdf (page 6)

	// check first and second higher pT jets are selected
	bool leadingJetOk = 0;
	bool secondJetOk = 0;
	for( unsigned int ijet = 0; ijet < rec_Jets.size(); ijet++ ){
	  if( rec_Jets[ijet] == jets[0] ) leadingJetOk = 1;
	  if( rec_Jets[ijet] == jets[1] ) secondJetOk = 1;
	}
	if( leadingJetOk == 0 || secondJetOk == 0 ) continue;
	nbSignal[9]++;

	// Jets vector p1, p2 = { mass=0, px, py };
	double p1[3] = { 0., (*Jet_Px)[jets[0]], (*Jet_Py)[jets[0]] };
	double p2[3] = { 0., (*Jet_Px)[jets[1]], (*Jet_Py)[jets[1]] };

	// Missing impuls, for null mass
	double pmiss[3] = { 0., (*ETmis_Px)[0], (*ETmis_Py)[0] };
	double mn = 0;
	mt2_bisect::mt2 mt2_event;
	mt2_event.set_momenta( p1, p2, pmiss );
	mt2_event.set_mn( mn );
	mT2 = mt2_event.get_mt2();
	h_mT2->Fill( mT2 );
	if( signalRegion == "B" && mT2 < 300 ) continue;
	nbSignal[10]++;

	// Count the number of signal events at the end of the cutflow
	if ( TMath::Finite( factor )  && TMath::IsNaN( factor ) == false ){
	  totNormalised += factor;
	  h_factor->Fill( factor );
	}
	
	rec_Jets.clear();
	rec_Electrons.clear();
	rec_Muons.clear();
	rec_ptjets.clear();
	jets.clear();
	ptjets.clear();
	dphijets.clear();
    }

  for( int icut = 0; icut < 10; icut++ ){
    h_cutflow->SetBinContent( icut, nbSignal[icut] );
    h_cutflow_cumeff->SetBinContent( icut, 100*(float)nbSignal[icut]/(float)nbSignal[0] );
    if( icut == 0 ) h_cutflow_eff->SetBinContent( icut, 100 );
    else if( nbSignal[icut-1] > 0 ) h_cutflow_eff->SetBinContent( icut, 100*(float)nbSignal[icut]/(float)nbSignal[icut-1] );
    else if( nbSignal[icut-1] == 0 ) h_cutflow_eff->SetBinContent( icut, 0 );
  }

  for( int icut = 0; icut < 10; icut++ )
    cout << "Cut #"<<icut<< " ...  #(evt) = " << nbSignal[icut] <<" ... Eff = " << h_cutflow_eff->GetBinContent( icut ) << " ... Tot Eff = " << h_cutflow_cumeff->GetBinContent( icut ) << endl; 
  



  h_factor->Write();
  h_cutflow->Write();
  h_cutflow_eff->Write();
  h_cutflow_cumeff->Write();
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
  h_sumptmu->Write();
  h_dR_jete->Write();
  h_dR_ejet->Write();
  h_dR_mujet->Write();
  h_nel_presel->Write();
  h_nmu_presel->Write();
  h_ptleadjets->Write();
  h_njets_presel->Write();
  h_MET->Write();
  h_dPhi->Write();
  h_meff->Write();
  h_METmeff->Write();
  h_mT2->Write();
  
  output->Write();
  output->Close();

  return totNormalised;
}



  
