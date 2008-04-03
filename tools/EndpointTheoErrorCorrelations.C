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

double weighted(double br_1, double edge_1, double br_2, double edge_2) {
   double tmpvalue = (br_1*edge_1+br_2*edge_2)/(br_1+br_2);
   if (tmpvalue > 0) {
      return tmpvalue;
   }
   else {
      return -1;
   }
}

void EndpointTheoErrorCorrelations() {
  double mh0, mTop, mSquarkL, mSquarkR, mSleptonL, mSleptonR, mStau1, mSbottom1, mSbottom2, mStop1;
  double mGluino, mChargino1, mNeutralino1, mNeutralino2, mNeutralino4;

  double rmh0, rmTop, rmSquarkL, rmSquarkR, rmSleptonL, rmSleptonR, rmStau1, rmSbottom1, rmSbottom2, rmStop1;
  double rmGluino, rmChargino1, rmNeutralino1, rmNeutralino2, rmNeutralino4;

  double brsum_1 = 0.0488056;
  double brprod_3 = 0.00593123;
  double brprod_4 = 0.0376179;
  double brprod_8 = 0.0494843;

  mh0 = 1.09074052E+02;
  mTop = 1.70900000E+02;
  mSquarkL = 5.68355070E+02;
  mSquarkR = 5.51105492E+02;
  mSleptonL = 2.02483231E+02; 
  mSleptonR = 1.44076151E+02;
  mStau1 = 1.34677655E+02;
  mSbottom1 = 5.18206272E+02;
  mSbottom2 = 5.50567969E+02;
  mStop1 = 4.01522856E+02;
  mGluino = 6.07249292E+02;
  mChargino1 = 1.79918740E+02;
  mNeutralino1 = 9.70785061E+01;
  mNeutralino2 = 1.80364535E+02;
  mNeutralino4 = 3.76981481E+02;

  TRandom3 rand;

  TFile* file = new TFile("EdgeDistributions.root", "recreate");

  //------------------------------------------------------------

  double val = mh0;
  TH1F* h_h0 = new TH1F("m_h0", "", 100, val*0.95, val*1.05);
  val = mTop;
  TH1F* h_Top = new TH1F("m_Top", "", 100, val*0.95, val*1.05);
  val = mChargino1;
  TH1F* h_Chargino1 = new TH1F("m_Chargino1", "", 100, val*0.95, val*1.05);

  val = edge2(mSleptonL, mNeutralino1);
  TH1F* h_diff_sleptonL_neutralino1 = new TH1F("m_diff_sleptonL_neutralino1", "", 100, val*0.95, val*1.05);
  val = edge2(mGluino, mNeutralino1);
  TH1F* h_diff_gluino_neutralino1 = new TH1F("m_diff_gluino_neutralino1", "", 100, val*0.95, val*1.05);
  val = edge2(mSquarkR, mNeutralino1);
  TH1F* h_diff_squarkR_neutralino1 = new TH1F("m_diff_squarkR_neutralino1", "", 100, val*0.95, val*1.05);
  val = edge2(mGluino, mSbottom1);
  TH1F* h_diff_gluino_sbottom1 = new TH1F("m_diff_gluino_sbottom1", "", 100, val*0.95, val*1.05);
  val = edge2(mGluino, mSbottom2);
  TH1F* h_diff_gluino_sbottom2 = new TH1F("m_diff_gluino_sbottom2", "", 100, val*0.95, val*1.05);

  val = edge3(mNeutralino1, mNeutralino2, mSleptonR);
  TH1F* h_ll_max_neu2 = new TH1F("m_ll_max_neu2", "", 100, val*0.95, val*1.05);
  val = edge3(mNeutralino1, mNeutralino4, mSleptonL);
  TH1F* h_ll_max_neu4 = new TH1F("m_ll_max_neu4", "", 100, val*0.95, val*1.05);
  val = edge3(mNeutralino1, mNeutralino2, mStau1);
  TH1F* h_tautau_max = new TH1F("m_tautau_max", "", 100, val*0.95, val*1.05);
  val = edge3(mNeutralino1, mSquarkL, mNeutralino2);
  TH1F* h_llq_max = new TH1F("m_llq_max", "", 100, val*0.95, val*1.05);
  val = edge3(mSleptonR, mSquarkL, mNeutralino2);
  TH1F* h_lq_low = new TH1F("m_lq_low", "", 100, val*0.95, val*1.05);

  val = edge4(mNeutralino1, mNeutralino2, mSleptonR, mSquarkL);
  TH1F* h_lq_high = new TH1F("m_lq_high", "", 100, val*0.95, val*1.05);
 
  val = edge5(mNeutralino1, mNeutralino2, mSleptonR, mSquarkL);
  TH1F* h_llq_min = new TH1F("m_llq_min", "", 100, val*0.95, val*1.05);
  val = edge5(mNeutralino1, mNeutralino2, mSleptonR, mSbottom1);
  TH1F* h_llb_min = new TH1F("m_llb_min", "", 100, val*0.95, val*1.05);

  double edge6 = edge6(mTop, mStop1, mChargino1, mGluino);
  //val = edge6(mTop, mStop1, mChargino1, mGluino);
  //TH1F* h_tb_stop1 = new TH1F("m_tb_stop1", "", 100, val*0.95, val*1.05);

  double edge7 = edge7(mTop, mGluino, mSbottom1, mChargino1);
  //val = edge7(mTop, mGluino, mSbottom1, mChargino1);
  //TH1F* h_tb_sbottom1 = new TH1F("m_tb_sbottom1", "", 100, val*0.95, val*1.05);

  val = weighted(brsum_1, edge6, brprod_8, edge7);
  TH1F* h_tb_W = new TH1F("h_tb_W", "", 100, val*0.95, val*1.05);

  val = weighted(brprod_4, mSbottom1, brprod_3, mSbottom2);
  TH1F* h_massSbottom_W = new TH1F("h_massSbottom_W", "", 100, val*0.95, val*1.05);

  //------------------------------------------------------------
 
  TTree* tree = new TTree("edges","Edge Positions");

  //------------------------------------------------------------

  double m_h0, m_Top, m_Chargino1;
  double m_diff_sleptonL_neutralino1, m_diff_gluino_neutralino1, m_diff_squarkR_neutralino1, m_diff_gluino_sbottom1, m_diff_gluino_sbottom2;
  double m_ll_max_neu2, m_ll_max_neu4, m_tautau_max, m_llq_max, m_lq_low;
  double m_lq_high;
  double m_llq_min, m_llb_min;
  double m_tb_stop1;
  double m_tb_sbottom1;
  double m_tb_W;
  double m_massSbottom_W;

  //------------------------------------------------------------

  tree->Branch("m_h0", &m_h0, "m_h0/D");
  tree->Branch("m_Top", &m_Top, "m_Top/D");
  tree->Branch("m_Chargino1", &m_Chargino1, "m_Chargino1/D");
  
  tree->Branch("m_diff_sleptonL_neutralino1", &m_diff_sleptonL_neutralino1,
	       "m_diff_sleptonL_neutralino1/D");
  tree->Branch("m_diff_gluino_neutralino1", &m_diff_gluino_neutralino1,
	       "m_diff_gluino_neutralino1/D");
  tree->Branch("m_diff_squarkR_neutralino1", &m_diff_squarkR_neutralino1,
	       "m_diff_squarkR_neutralino1/D");
  tree->Branch("m_diff_gluino_sbottom1", &m_diff_gluino_sbottom1,
	       "m_diff_gluino_sbottom1/D");
  tree->Branch("m_diff_gluino_sbottom2", &m_diff_gluino_sbottom2,
	       "m_diff_gluino_sbottom2/D");

  tree->Branch("m_ll_max_neu2", &m_ll_max_neu2, "m_ll_max_neu2/D");
  tree->Branch("m_ll_max_neu4", &m_ll_max_neu4, "m_ll_max_neu4/D");
  tree->Branch("m_tautau_max", &m_tautau_max, "m_tautau_max/D");
  tree->Branch("m_llq_max", &m_llq_max, "m_llq_max/D");
  tree->Branch("m_lq_low", &m_lq_low, "m_lq_low/D");

  tree->Branch("m_lq_high", &m_lq_high, "m_lq_high/D");

  tree->Branch("m_llq_min", &m_llq_min, "m_llq_min/D");
  tree->Branch("m_llb_min", &m_llb_min, "m_llb_min/D");

  //tree->Branch("m_tb_stop1", &m_tb_stop1, "m_tb_stop1/D");

  //tree->Branch("m_tb_sbottom1", &m_tb_sbottom1, "m_tb_sbottom1/D");

  tree->Branch("m_tb_W", &m_tb_W, "m_tb_W/D");

  tree->Branch("m_massSbottom_W", &m_massSbottom_W, "m_massSbottom_W/D");

  for (int i=0; i<100000; i++) {
    rmh0 = rand.Gaus(mh0, mh0*0.005);
    rmTop = rand.Gaus(mTop, mTop*0.01);
    rmSquarkL = rand.Gaus(mSquarkL, mSquarkL*0.01);
    rmSquarkR = rand.Gaus(mSquarkR, mSquarkR*0.01);
    rmSleptonL = rand.Gaus(mSleptonL, mSleptonL*0.005);
    rmSleptonR = rand.Gaus(mSleptonR, mSleptonR*0.005);
    rmStau1 = rand.Gaus(mStau1, mStau1*0.005);
    rmSbottom1 = rand.Gaus(mSbottom1, mSbottom1*0.01);
    rmSbottom2 = rand.Gaus(mSbottom2, mSbottom2*0.01);
    rmStop1 = rand.Gaus(mStop1, mStop1*0.01);
    rmGluino = rand.Gaus(mGluino, mGluino*0.01);
    rmChargino1 = rand.Gaus(mChargino1, mChargino1*0.005);
    rmNeutralino1 = rand.Gaus(mNeutralino1, mNeutralino1*0.005);
    rmNeutralino2 = rand.Gaus(mNeutralino2, mNeutralino2*0.005);
    rmNeutralino4 = rand.Gaus(mNeutralino4, mNeutralino4*0.005);

    //------------------------------------------------------------

    m_h0 = rmh0;
    m_Top = rmTop;
    m_Chargino1 = rmChargino1;

    m_diff_sleptonL_neutralino1 = edge2(rmSleptonL, rmNeutralino1);
    m_diff_gluino_neutralino1 = edge2(rmGluino, rmNeutralino1);
    m_diff_squarkR_neutralino1 = edge2(rmSquarkR, rmNeutralino1);
    m_diff_gluino_sbottom1 = edge2(rmGluino, rmSbottom1);
    m_diff_gluino_sbottom2 = edge2(rmGluino, rmSbottom2);

    m_ll_max_neu2 = edge3(rmNeutralino1, rmNeutralino2, rmSleptonR);
    m_ll_max_neu4 = edge3(rmNeutralino1, rmNeutralino4, rmSleptonL);
    m_tautau_max = edge3(rmNeutralino1, rmNeutralino2, rmStau1);
    m_llq_max = edge3(rmNeutralino1, rmSquarkL, rmNeutralino2);
    m_lq_low = edge3(rmSleptonR, rmSquarkL, rmNeutralino2);

    m_lq_high = edge4(rmNeutralino1, rmNeutralino2, rmSleptonR, rmSquarkL);

    m_llq_min = edge5(rmNeutralino1, rmNeutralino2, rmSleptonR, rmSquarkL);
    m_llb_min = edge5(rmNeutralino1, rmNeutralino2, rmSleptonR, rmSbottom1);
    
    m_tb_stop1 = edge6(rmTop, rmStop1, rmChargino1, rmGluino);

    m_tb_sbottom1 = edge7(rmTop, rmGluino, rmSbottom1, rmChargino1);

    m_tb_W = weighted(brsum_1, m_tb_stop1, brprod_8, m_tb_sbottom1);

    m_massSbottom_W = weighted(brprod_4, rmSbottom1, brprod_3, rmSbottom2);

    //------------------------------------------------------------

    h_h0->Fill( m_h0 );
    h_Top->Fill( m_Top );
    h_Chargino1->Fill( m_Chargino1 );

    h_diff_sleptonL_neutralino1->Fill( m_diff_sleptonL_neutralino1 );
    h_diff_gluino_neutralino1->Fill( m_diff_gluino_neutralino1 );
    h_diff_squarkR_neutralino1->Fill( m_diff_squarkR_neutralino1 );
    h_diff_gluino_sbottom1->Fill( m_diff_gluino_sbottom1 );
    h_diff_gluino_sbottom2->Fill( m_diff_gluino_sbottom2 );

    h_ll_max_neu2->Fill( m_ll_max_neu2 );
    h_ll_max_neu4->Fill( m_ll_max_neu4 );
    h_tautau_max->Fill( m_tautau_max );
    h_llq_max->Fill( m_llq_max );
    h_lq_low->Fill( m_lq_low );

    h_lq_high->Fill( m_lq_high );

    h_llq_min->Fill( m_llq_min );
    h_llb_min->Fill( m_llb_min );

    //h_tb_stop1->Fill( m_tb_stop1 );

    //h_tb_sbottom1->Fill( m_tb_sbottom1 );

    h_tb_W->Fill( m_tb_W );

    h_massSbottom_W->Fill( m_massSbottom_W );

    //------------------------------------------------------------

    tree->Fill();
  }

  tree->Write();
  file->Write();
  file->Close();
}
