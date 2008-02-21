double sqr(double a) {
  return a*a;
}


double edge1(double m1, double m2) {
  return m1 + m2;
}


double edge2(double m1, double m2) {
  return TMath::Abs(m1 - m2);
}


double edge3(double m0, double m1, double m2) {
  double tmpvalue = (sqr(m1) - sqr(m2)) * (sqr(m2) - sqr(m0))
                     /(sqr(m2));
  if (tmpvalue > 0) {
    return TMath::Sqrt(tmpvalue);
  } else {
    return -1;
  }
}

double edge4(double m0, double m1, double m2, double m3) {
  double tmpvalue = (sqr(m3) - sqr(m1)) *(sqr(m2) - sqr(m0))
                    /(sqr(m2));
  if (tmpvalue > 0) {
    return TMath::Sqrt(tmpvalue);
  } else {
    return -1;
  }
}

double edge5(double m0, double m1, double m2, double m3) {
  double tmpvalue = (((sqr(m3)+ sqr(m1))*(sqr(m1)
			- sqr(m2))
                      *(sqr(m2)
                         - sqr(m0))
                      - (sqr(m3)
                         - sqr(m1))
                      *TMath::Sqrt(
                         sqr((sqr(m1)
                               + sqr(m2)))
                         *sqr((sqr(m2)
                               + sqr(m0)))
                         -16.*sqr(m1)
                         *sqr(sqr(m2))
                         *sqr(m0)
                         )
                      + 2.*sqr(m2)
                      *(sqr(m3)
                         - sqr(m1))
                      *(sqr(m1)
                            - sqr(m0))
                      )
                      /(4.*sqr(m2
                               *m1))
                      );
  if (tmpvalue > 0) {
    return TMath::Sqrt(tmpvalue);
  } else {
    return -1;
  }
}

double edge6(double m0, double m1, double m2, double m3) {
  double tmpvalue = (
                     sqr(m0)
                     +(sqr(m1)
		       -sqr(m2))
                     /(2*sqr(m1))
                     *((sqr(m3)
			-sqr(m1)
			-sqr(m0))
		       +TMath::Sqrt((sqr(m3)
				     -sqr((m1
					   -m0)))
				    *(sqr(m3)
				      -sqr((m1
					    +m0)))))
		     
                     );
  if (tmpvalue > 0) {
    return TMath::Sqrt(tmpvalue);
  } else {
    return -1;
  }
}


double edge7(double m0, double m1, double m2, double m3) {
  double tmpvalue = (
                     sqr(m0)
                     +(sqr(m1)
		       -sqr(m2))
                     /(2*sqr(m2))
                     *((sqr(m2)
			-sqr(m3)
			+sqr(m0))
		       +TMath::Sqrt((sqr(m2)
				     -sqr((m3
					   -m0)))
				    *(sqr(m2)
				      -sqr((m3
					    +m0)))))
                     );
  if (tmpvalue > 0) {
    return TMath::Sqrt(tmpvalue);
  } else {
    return -1;
  }
}

void EndpointTheoErrorCorrelations() {
  double mSquarkL, mSquarkR, mSleptonL, mSleptonR, mStau1;
  double mGluino, mNeutralino1, mNeutralino2, mNeutralino4;

  double rmSquarkL, rmSquarkR, rmSleptonL, rmSleptonR, rmStau1;
  double rmGluino, rmNeutralino1, rmNeutralino2, rmNeutralino4;

  mSquarkL = 672;
  mSquarkR = 650;
  mSleptonL = 231;
  mSleptonR = 156;
  mStau1 = 151;
  mGluino = 720;
  mNeutralino1 = 118;
  mNeutralino2 = 223;
  mNeutralino4 = 490;

  TRandom3 rand;

  TFile* file = new TFile("EdgeDistributions.root", "recreate");

  double val = edge3(mNeutralino1, mNeutralino2, mSleptonR);
  TH1F* h_ll_max = new TH1F("m_ll_max", "", 100, val*0.95, val*1.05);
  val = edge3(mNeutralino1, mSquarkL, mNeutralino2);
  TH1F* h_llq_max = new TH1F("m_llq_max", "", 100, val*0.95, val*1.05);
  val = edge5(mNeutralino1, mNeutralino2, mSleptonR, mSquarkL);
  TH1F* h_llq_min = new TH1F("m_llq_min", "", 100, val*0.95, val*1.05);
  val = edge3(mSleptonR, mSquarkL, mNeutralino2);
  TH1F* h_lq_low = new TH1F("m_lq_low", "", 100, val*0.95, val*1.05);
  val = edge4(mNeutralino1, mNeutralino2, mSleptonR, mSquarkL);
  TH1F* h_lq_high = new TH1F("m_lq_high", "", 100, val*0.95, val*1.05);
  val = edge3(mNeutralino1, mNeutralino2, mStau1);
  TH1F* h_tautau_max = new TH1F("m_tautau_max", "", 100, val*0.95, val*1.05);
  val = edge2(mSquarkR, mNeutralino1);
  TH1F* h_diff_squarkR_neutralino1 = new TH1F("m_diff_squarkR_neutralino1", "", 100, val*0.95, val*1.05);

  TTree* tree = new TTree("edges","Edge Positions");

  double m_ll_max, m_llq_max, m_llq_min, m_lq_low, m_lq_high;
  double m_tautau_max, m_diff_squarkR_neutralino1;
  
  tree->Branch("m_ll_max", &m_ll_max, "m_ll_max/D");
  tree->Branch("m_llq_max", &m_llq_max, "m_llq_max/D");
  tree->Branch("m_llq_min", &m_llq_min, "m_llq_min/D");
  tree->Branch("m_lq_low", &m_lq_low, "m_lq_low/D");
  tree->Branch("m_lq_high", &m_lq_high, "m_lq_high/D");
  tree->Branch("m_tautau_max", &m_tautau_max, "m_tautau_max/D");
  tree->Branch("m_diff_squarkR_neutralino1", &m_diff_squarkR_neutralino1,
	       "m_diff_squarkR_neutralino1/D");

  for (int i=0; i<100000; i++) {
    rmSquarkL = rand.Gaus(mSquarkL, mSquarkL*0.01);
    rmSquarkR = rand.Gaus(mSquarkR, mSquarkR*0.01);
    rmSleptonL = rand.Gaus(mSleptonL, mSleptonL*0.005);
    rmSleptonR = rand.Gaus(mSleptonR, mSleptonR*0.005);
    rmStau1 = rand.Gaus(mStau1, mStau1*0.005);
    rmGluino = rand.Gaus(mGluino, mGluino*0.005);
    rmNeutralino1 = rand.Gaus(mNeutralino1, mNeutralino1*0.005);
    rmNeutralino2 = rand.Gaus(mNeutralino2, mNeutralino2*0.005);
    rmNeutralino4 = rand.Gaus(mNeutralino4, mNeutralino4*0.005);

    m_ll_max = edge3(rmNeutralino1, rmNeutralino2, rmSleptonR);
    m_llq_max = edge3(rmNeutralino1, rmSquarkL, rmNeutralino2);
    m_llq_min = edge5(rmNeutralino1, rmNeutralino2, rmSleptonR, rmSquarkL);
    m_lq_low = edge3(rmSleptonR, rmSquarkL, rmNeutralino2);
    m_lq_high = edge4(rmNeutralino1, rmNeutralino2, rmSleptonR, rmSquarkL);
    m_tautau_max = edge3(rmNeutralino1, rmNeutralino2, rmStau1);
    m_diff_squarkR_neutralino1 = edge2(rmSquarkR, rmNeutralino1);

    h_ll_max->Fill( m_ll_max );
    h_llq_max->Fill( m_llq_max );
    h_llq_min->Fill( m_llq_min );
    h_lq_low->Fill( m_lq_low );
    h_lq_high->Fill( m_lq_high );
    h_tautau_max->Fill( m_tautau_max );
    h_diff_squarkR_neutralino1->Fill( m_diff_squarkR_neutralino1 );

    tree->Fill();
  }

  tree->Write();
  file->Write();
  file->Close();
}
