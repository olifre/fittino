
#include "HiggsCalculator.h"
#include "FloatStorage.h"
#include "TFile.h"
#include <TTree.h>

int main( int argc, char* argv[] ) {

  int nHiggsneut = 1;
  int nHiggsplus = 0;
  initialize_higgssignals_for_fittino_( &nHiggsneut, &nHiggsplus );


  std::string name = argv[1];

  TFile* f = new TFile( name.c_str() );

  TTree* inTree = (TTree*) f->Get("markovChain");

  TFile* g = new TFile( "out.root", "RECREATE");

  TTree* outTree = new TTree(inTree->GetName(), inTree->GetTitle());

  FloatStorage data(outTree);
  data.Connect(inTree);


  data.Add("smbr_hss");
  data.Add("smbr_hcc");
  data.Add("smbr_hbb");
  data.Add("smbr_htoptop");
  data.Add("smbr_hmumu");
  data.Add("smbr_htautau");
  data.Add("smbr_hww");
  data.Add("smbr_hzz");
  data.Add("smbr_hzgam");
  data.Add("smbr_hgamgam");
  data.Add("smbr_hgg");
  data.Add("smgamma_h");

  data.Add("O_widthh0_norm");
  data.Add("O_h0_To_Strange_Strange~_norm");  
  data.Add("O_h0_To_Charm_Charm~_norm");    
  data.Add("O_h0_To_Bottom_Bottom~_norm");  
  data.Add("O_h0_To_Muon_Muon~_norm");      
  data.Add("O_h0_To_Tau_Tau~_norm");        
  data.Add("O_h0_To_W_W_norm"); 
  data.Add("O_h0_To_Z_Z_norm");
  data.Add("O_h0_To_Z_Gamma_norm");
  data.Add("O_h0_To_Gamma_Gamma_norm");
  data.Add("O_h0_To_Gluon_Gluon_norm");

  data.Add("O_HiggsScalarFermionCoupling3250303_fromBR");
  data.Add("O_HiggsScalarFermionCoupling3250404_fromBR");
  data.Add("O_HiggsScalarFermionCoupling3250505_fromBR");
  data.Add("O_HiggsScalarFermionCoupling3251313_fromBR");
  data.Add("O_HiggsScalarFermionCoupling3251515_fromBR");
  data.Add("O_HiggsBosonCoupling3252424_fromBR");
  data.Add("O_HiggsBosonCoupling3252323_fromBR");
  data.Add("O_HiggsBosonCoupling3252322_fromBR");
  data.Add("O_HiggsBosonCoupling3252222_fromBR");
  data.Add("O_HiggsBosonCoupling3252121_fromBR");
  data.Add("O_h0_To_Bottom_Bottom~_norm_fromG2");
  data.Add("O_h0_To_Tau_Tau~_norm_fromG2");
  data.Add("O_h0_To_W_W_norm_fromG2");
  data.Add("O_h0_To_Z_Z_norm_fromG2");
  data.Add("O_h0_To_Gluon_Gluon_norm_fromG2");

  data.Add("O_widthh0_norm_recalc");

  data.Add("O_HiggsScalarFermionCoupling3250505_hZZ");
  data.Add("O_HiggsScalarFermionCoupling3250606_hZZ");
  data.Add("O_HiggsScalarFermionCoupling3251515_hZZ");
  data.Add("O_HiggsBosonCoupling3252424_hZZ");
  data.Add("O_HiggsBosonCoupling3252323_hZZ");
  data.Add("O_HiggsBosonCoupling3252121_hZZ");



  for (unsigned int i=0; i<inTree->GetEntries(); i++){

    inTree->GetEntry(i);

    double mh = data.Get("O_massh0");

    // SM BRs

    data.Set("smbr_hss", smbr_hss_( &mh ) );
    data.Set("smbr_hcc", smbr_hcc_( &mh )  );
    data.Set("smbr_hbb", smbr_hbb_( &mh ) );
    data.Set("smbr_htoptop", smbr_htoptop_( &mh ) );
    data.Set("smbr_hmumu", smbr_hmumu_( &mh ) );
    data.Set("smbr_htautau", smbr_htautau_( &mh ) );
    data.Set("smbr_hww", smbr_hww_( &mh ) );
    data.Set("smbr_hzz", smbr_hzz_( &mh ) );
    data.Set("smbr_hzgam", smbr_hzgam_( &mh ) );
    data.Set("smbr_hgamgam", smbr_hgamgam_( &mh ) );
    data.Set("smbr_hgg", smbr_hgg_( &mh ) );
    data.Set("smgamma_h", smgamma_h_( &mh ) );


    // normed BRs

    data.Set("O_widthh0_norm", 
	     data.Get("O_widthh0") / data.Get("smgamma_h") );

    data.Set( "O_h0_To_Strange_Strange~_norm",
	      data.Get("O_h0_To_Strange_Strange~_") / data.Get("smbr_hss") );  

    data.Set("O_h0_To_Charm_Charm~_norm",
	     data.Get("O_h0_To_Charm_Charm~_") / data.Get("smbr_hcc") );    

    data.Set("O_h0_To_Bottom_Bottom~_norm",
	     data.Get("O_h0_To_Bottom_Bottom~_") / data.Get("smbr_hbb") );  

    data.Set("O_h0_To_Muon_Muon~_norm",
	     data.Get("O_h0_To_Muon_Muon~_") / data.Get("smbr_hmumu") );      

    data.Set("O_h0_To_Tau_Tau~_norm", 
	     data.Get("O_h0_To_Tau_Tau~_") / data.Get("smbr_htautau") );        
    
    data.Set("O_h0_To_W_W_norm",
	     data.Get("O_h0_To_W_W_") / data.Get("smbr_hww") );
 
    data.Set("O_h0_To_Z_Z_norm",
	     data.Get("O_h0_To_Z_Z_") / data.Get("smbr_hzz") );

    data.Set("O_h0_To_Z_Gamma_norm",
	     data.Get("O_h0_To_Z_Gamma_") / data.Get("smbr_hzgam") );
    
    data.Set("O_h0_To_Gamma_Gamma_norm",
	     data.Get("O_h0_To_Gamma_Gamma_") / data.Get("smbr_hgamgam") );

    data.Set("O_h0_To_Gluon_Gluon_norm", 
	     data.Get("O_h0_To_Gluon_Gluon_") / data.Get("smbr_hgg") );

    
    // g2 from BR


    data.Set("O_HiggsScalarFermionCoupling3250303_fromBR",
	     data.Get("O_h0_To_Strange_Strange~_norm") * data.Get("O_widthh0_norm") );

    data.Set("O_HiggsScalarFermionCoupling3250404_fromBR",
	     data.Get("O_h0_To_Charm_Charm~_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsScalarFermionCoupling3250505_fromBR",
	     data.Get("O_h0_To_Bottom_Bottom~_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsScalarFermionCoupling3251313_fromBR",
	     data.Get("O_h0_To_Muon_Muon~_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsScalarFermionCoupling3251515_fromBR",
	     data.Get("O_h0_To_Tau_Tau~_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsBosonCoupling3252424_fromBR",
	     data.Get("O_h0_To_W_W_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsBosonCoupling3252323_fromBR",
	     data.Get("O_h0_To_Z_Z_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsBosonCoupling3252322_fromBR",
	     data.Get("O_h0_To_Z_Gamma_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsBosonCoupling3252222_fromBR",
	     data.Get("O_h0_To_Gamma_Gamma_norm") * data.Get("O_widthh0_norm") );    

    data.Set("O_HiggsBosonCoupling3252121_fromBR",
	     data.Get("O_h0_To_Gluon_Gluon_norm") * data.Get("O_widthh0_norm") );    

    // BR from g2
    
    data.Set("O_h0_To_Bottom_Bottom~_norm_fromG2",
	     data.Get("O_HiggsScalarFermionCoupling3250505") /  data.Get("O_widthh0_norm") );

    data.Set("O_h0_To_Tau_Tau~_norm_fromG2",
	     data.Get("O_HiggsScalarFermionCoupling3251515") /  data.Get("O_widthh0_norm") );
    
    data.Set("O_h0_To_W_W_norm_fromG2",
	     data.Get("O_HiggsBosonCoupling3252424") /  data.Get("O_widthh0_norm") );

    data.Set("O_h0_To_Z_Z_norm_fromG2",
	     data.Get("O_HiggsBosonCoupling3252323") /  data.Get("O_widthh0_norm") );

    data.Set("O_h0_To_Gluon_Gluon_norm_fromG2",
	     data.Get("O_HiggsBosonCoupling3252121") /  data.Get("O_widthh0_norm") );



    // das sind die Kopplungen so wie wir sie HS übergeben haben
    double  g2hjss_s = data.Get("O_HiggsScalarFermionCoupling3250303_fromBR");
    double  g2hjcc_s = data.Get("O_HiggsScalarFermionCoupling3250404_fromBR");
    double  g2hjbb_s  = data.Get("O_HiggsScalarFermionCoupling3250505");
    double  g2hjtt_s  = data.Get("O_HiggsScalarFermionCoupling3250606");
    double  g2hjmumu_s  = data.Get("O_HiggsScalarFermionCoupling3251313_fromBR");
    double  g2hjtautau_s  = data.Get("O_HiggsScalarFermionCoupling3251515");
    double  g2hjWW  = data.Get("O_HiggsBosonCoupling3252424");
    double  g2hjZZ  = data.Get("O_HiggsBosonCoupling3252323");
    double  g2hjZga  = data.Get("O_HiggsBosonCoupling3252322_fromBR");
    double  g2hjgaga  = data.Get("O_HiggsBosonCoupling3252222_fromBR");
    double  g2hjgg  = data.Get("O_HiggsBosonCoupling3252121");

    // + g2hjggZ, aber dafuer gibt es keine smbr_ funktion in HB... 


    // couplings normalized to hZZ
    data.Set("O_HiggsScalarFermionCoupling3250505_hZZ",
	     data.Get("O_HiggsScalarFermionCoupling3250505") / g2hjZZ );

    data.Set("O_HiggsScalarFermionCoupling3250606_hZZ",
	     data.Get("O_HiggsScalarFermionCoupling3250606") / g2hjZZ );

    data.Set("O_HiggsScalarFermionCoupling3251515_hZZ",
	     data.Get("O_HiggsScalarFermionCoupling3251515") / g2hjZZ );

    data.Set("O_HiggsBosonCoupling3252121_hZZ",
	     data.Get("O_HiggsBosonCoupling3252121") / g2hjZZ );
    
    data.Set("O_HiggsBosonCoupling3252424_hZZ",
	     data.Get("O_HiggsBosonCoupling3252424") / g2hjZZ );
    

    double GammaTotal =   1
      + ( g2hjss_s - 1 ) * data.Get("smbr_hss")
      + ( g2hjcc_s - 1 ) * data.Get("smbr_hcc")
      + ( g2hjbb_s - 1 ) * data.Get("smbr_hbb")
      + ( g2hjtt_s - 1 ) * data.Get("smbr_htoptop")
      + ( g2hjmumu_s - 1 ) * data.Get("smbr_hmumu")
      + ( g2hjtautau_s - 1 ) * data.Get("smbr_htautau")
      + ( g2hjWW - 1 ) * data.Get("smbr_hww")
      + ( g2hjZZ - 1 ) * data.Get("smbr_hzz")
      + ( g2hjZga - 1 ) * data.Get("smbr_hzgam")
      + ( g2hjgaga - 1 ) * data.Get("smbr_hgamgam")
      + ( g2hjgg - 1 ) * data.Get("smbr_hgg") ;
    
    data.Set("O_widthh0_norm_recalc", GammaTotal);
    
    
    outTree->Fill();
  }


  g->Write();
  g->Close();
  
  finish_higgssignals_();

}
