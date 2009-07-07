#include <map>
#include <TFile.h>
#include <TTree.h>
#include <TLeaf.h>
#include <TLeafD.h>
#include <TMath.h>
#include <TH2F.h>
#include <TLine.h>
#include <TPad.h>
#include <TCanvas.h>

void DrawParDependence(const char* filename, 
		       int lumi,
		       double chi2cut = 4.0,
		       const char* treename = "markovChain")
{

    TCanvas* c1 = new TCanvas();

    std::map<std::string, double> value;
    std::map<std::string, double> error;

    value["O_alphaem"] = 127.925;
    value["O_alphas"] = 0.1176;
    value["O_G_F"] = 1.16637e-5;
    value["O_massBottom"] = 4.20;
    value["O_massCharm"] = 1.2;
    value["O_massTau"] = 1.77684;
    value["O_massTop"] = 172.4;
    value["O_massW"] = 80.3789;
    value["O_massZ"] = 91.1875;
    value["O_brratio_1"] = 0.0762483;
    value["O_weighted_1"] = 359.458;
    value["O_massh0"] = 109.582;
    value["O_Bsg_npf"] = 0.912458;
    value["O_dm_s_npf"] = 1.04897;
    value["O_Btn_npf"] = 0.964095;
    value["O_B_sXsll_npf"] = 0.982954;
    value["O_Klnu_npf"] = 0.999679;
    value["O_gmin2m_npf"] = 29.6965e-10;
    value["O_sin_th_eff_npf"] = 0.231347;
    value["O_GammaZ_npf"] = 2495.45;
    value["O_R_l_npf"] = 20.7433;
    value["O_R_b_npf"] = 0.216056;
    value["O_R_c_npf"] = 0.17219;
    value["O_A_fbb_npf"] = 0.104068;
    value["O_A_fbc_npf"] = 0.0743971;
    value["O_A_b_npf"] = 0.935023;
    value["O_A_c_npf"] = 0.668441;
    value["O_A_l_npf"] = 0.148399;
    value["O_Omega_npf"] = 0.194704;
    value["O_A_tau_npf"] = 0.148399;
    value["O_A_fbl_npf"] = 0.0165167;
    value["O_sigma_had0_npf"] = 41.4862;
    value["O_dm_k_npf"] = 1.04844;
    value["O_DmsDmd_npf"] = 0.999848;

    if ( lumi == 1 ) {
      // LHC only, 1 fb-1
      value["O_edge_type_3_alias_3"] = 83.3605;
      value["O_edge_type_8_alias_1"] = 530.995;
      value["O_edge_type_100_alias_2"] = 80.4331;
      value["O_edge_type_101_alias_4"] = 452.076;
      value["O_edge_type_102_alias_7"] = 215.565;
      value["O_edge_type_105_alias_5"] = 318.577;
      value["O_edge_type_106_alias_6"] = 396.045;
    }
    else if ( lumi == 10 ) {
      // LHC only, 10 fb-1
      value["O_edge_type_2_alias_1"] = 507.652;
      value["O_edge_type_8_alias_2"] = 530.995;
      value["O_edge_type_100_alias_3"] = 80.4331;
      value["O_edge_type_3_alias_4"] = 280.578;
      value["O_edge_type_3_alias_5"] = 83.3605;
      value["O_edge_type_101_alias_6"] = 452.076;
      value["O_edge_type_105_alias_7"] = 318.577;
      value["O_edge_type_106_alias_8"] = 396.045;
      value["O_edge_type_102_alias_9"] = 215.565;;
      value["O_edge_type_5_alias_10"] = 195.907;
      value["O_weighted_2"] = 84.0452;
    }
    else if ( lumi == 300 ) {
      // LHC only, 300 fb-1
      value["O_massChargino1"] = 180.176;
      value["O_edge_type_8_alias_1"] = 148.816;
      value["O_edge_type_2_alias_2"] = 507.652;
      value["O_edge_type_8_alias_3"] = 530.995;
      value["O_edge_type_2_alias_4"] = 88.6786;
      value["O_edge_type_2_alias_5"] = 56.7889;
      value["O_edge_type_100_alias_6"] = 80.4331;
      value["O_edge_type_3_alias_7"] = 280.578;
      value["O_edge_type_3_alias_8"] = 83.3605;
      value["O_edge_type_101_alias_9"] = 452.076;
      value["O_edge_type_105_alias_10"] = 318.577;
      value["O_edge_type_106_alias_11"] = 396.045;
      value["O_edge_type_102_alias_12"] = 215.565;
      value["O_edge_type_5_alias_13"] = 195.907;
      value["O_brratio_2"] = 0.168414;
    }

    ////////////////////////////////////////////////////////////

    error["O_G_F"] = 1e-10;
    error["O_massBottom"] = 0.25;
    error["O_massCharm"] = 0.2;
    error["O_massTau"] = 0.00017;
    error["O_massW"] = 0.025;
    error["O_massZ"] = 0.0021;
    error["O_alphaem"] = 0.016;
    error["O_alphas"] = 0.002;
    error["O_Bsg_npf"] = 0.1224;
    error["O_dm_s_npf"] = 0.3202;
    error["O_Btn_npf"] = 0.40;
    error["O_B_sXsll_npf"] = 0.32;
    error["O_Klnu_npf"] = 0.014;
    error["O_gmin2m_npf"] = 9.0244e-10;
    error["O_sin_th_eff_npf"] = 0.0012;
    error["O_GammaZ_npf"] = 2.508;
    error["O_R_l_npf"] = 0.025;
    error["O_R_b_npf"] = 0.00066;
    error["O_R_c_npf"] = 0.003;
    error["O_A_fbb_npf"] = 0.0016;
    error["O_A_fbc_npf"] = 0.0035;
    error["O_A_b_npf"] = 0.020;
    error["O_A_c_npf"] = 0.027;
    error["O_A_l_npf"] = 0.0021;
    error["O_Omega_npf"] = 0.0135;
    error["O_A_tau_npf"] = 0.0032;
    error["O_A_fbl_npf"] = 0.00095;
    error["O_sigma_had0_npf"] = 0.037;
    error["O_dm_k_npf"] = 0.14;
    error["O_DmsDmd_npf"] = 0.1603;

    if ( lumi == 1 ) {
      // LHC only, 1 fb-1
      error["O_massTop"] = 1.9;
      error["O_brratio_1"] = 0.012;
      error["O_edge_type_3_alias_3"] = 15.7;
      error["O_edge_type_8_alias_1"] = 34.6;
      error["O_edge_type_100_alias_2"] = 1.71;
      error["O_edge_type_101_alias_4"] = 18.0;
      error["O_edge_type_102_alias_7"] = 27.0;
      error["O_edge_type_105_alias_5"] = 11.0;
      error["O_edge_type_106_alias_6"] = 11.3;
      error["O_weighted_1"] = 43;
    }
    else if ( lumi == 10 ) {
      // LHC only, 10 fb-1
      error["O_massTop"] = 1.0;
      error["O_massh0"] = 1.4;
      error["O_brratio_1"] = 0.009;
      error["O_edge_type_2_alias_1"] = 11.0;
      error["O_edge_type_8_alias_2"] = 12.9;
      error["O_edge_type_100_alias_3"] = 0.51;
      error["O_edge_type_3_alias_4"] = 12.6;
      error["O_edge_type_3_alias_5"] = 9.2;
      error["O_edge_type_101_alias_6"] = 4.8;
      error["O_edge_type_105_alias_7"] = 3.8;
      error["O_edge_type_106_alias_8"] = 4.9;
      error["O_edge_type_102_alias_9"] = 4.9;
      error["O_edge_type_5_alias_10"] = 19.7;
      error["O_brratio_1"] = 0.0085;
      error["O_weighted_1"] = 14.1;
      error["O_weighted_2"] = 5.5;
    }
    else if ( lumi == 300 ) {
      // LHC only, 300 fb-1
      error["O_massTop"] = 1.0;
      error["O_massh0"] = 0.14;
      error["O_massChargino1"] = 11.5;
      error["O_edge_type_8_alias_1"] = 6.2;
      error["O_edge_type_2_alias_2"] = 10.6;
      error["O_edge_type_8_alias_3"] = 11.4;
      error["O_edge_type_2_alias_4"] = 1.6;
      error["O_edge_type_2_alias_5"] = 2.5;
      error["O_edge_type_100_alias_6"] = 0.09;
      error["O_edge_type_3_alias_7"] = 2.3;
      error["O_edge_type_3_alias_8"] = 8.4;
      error["O_edge_type_101_alias_9"] = 2.7;
      error["O_edge_type_105_alias_10"] = 1.8;
      error["O_edge_type_106_alias_11"] = 2.2;
      error["O_edge_type_102_alias_12"] = 1.9;
      error["O_edge_type_5_alias_13"] = 3.7;
      error["O_brratio_1"] = 0.0081;
      error["O_brratio_2"] = 0.078;
      error["O_weighted_1"] = 4.4;
    }


    TFile* file = new TFile(filename, "read");
    if ( !file ) {
      printf("Problem accessing file %s\n", filename);
      return;
    }
    
    TTree* tree = (TTree*)file->Get(treename);
    if ( !tree ) {
      printf("Problem accessing tree %s\n", treename);
      return;
    }
    
    int nLeaves = tree->GetListOfLeaves()->GetEntriesFast();

    std::vector<string> obs;
    std::vector<string> par;

    for (int iLeaf = 0; iLeaf < nLeaves; iLeaf++) {
      const TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);

      if ( ! strncmp("O_", leaf->GetName(), 2) ) {
	obs.push_back(leaf->GetName());
      }
      else if ( ! strncmp("P_", leaf->GetName(), 2) ) {
	par.push_back(leaf->GetName());
      }

    }

    char varcmd[1000];
    char chi2cmd[100];
    char outputfilename[1000];

    std::map<std::string, double> quanmap;

    for ( unsigned int ip=0; ip<par.size(); ip++ ) {

      quanmap.clear();

      for ( unsigned int io=0; io<obs.size(); io++ ) {

	if ( obs[io].find("nofit") < obs[io].size() ) continue;

	sprintf(varcmd, "%s:%s", obs[io].c_str(), par[ip].c_str());
	sprintf(chi2cmd, "chi2 < %f", chi2cut);

	tree->Draw(varcmd, chi2cmd, "box");

	double nbinsX = tree->GetHistogram()->GetNbinsX();
	double nbinsY = tree->GetHistogram()->GetNbinsY();
	double xmin = tree->GetHistogram()->GetXaxis()->GetXmin();
	double xmax = tree->GetHistogram()->GetXaxis()->GetXmax();

	double ycen = value[obs[io]];
	double ymin = value[obs[io]] - error[obs[io]];
	double ymax = value[obs[io]] + error[obs[io]];

	double nymin = value[obs[io]]
	               - 1.2 * TMath::Sqrt(chi2cut) * error[obs[io]];
	double nymax = value[obs[io]]
	               + 1.2 * TMath::Sqrt(chi2cut) * error[obs[io]];

	//double min = tree->GetHistogram()->GetYaxis()->GetXmin();
	//double max = tree->GetHistogram()->GetYaxis()->GetXmax();

	char xtitle[1000];
	char ytitle[1000];

	strcpy(xtitle, tree->GetHistogram()->GetXaxis()->GetTitle());
	strcpy(ytitle, tree->GetHistogram()->GetYaxis()->GetTitle());


	TH2F* histo = new TH2F("histo", "", nbinsX, xmin, xmax,
			       nbinsY, nymin, nymax);

	histo->SetXTitle(xtitle);
	histo->SetYTitle(ytitle);

	sprintf(varcmd, "%s:%s>>histo", obs[io].c_str(), par[ip].c_str());

	gPad->Clear();

	tree->Draw(varcmd, chi2cmd, "box");

	double abscorr = TMath::Abs(histo->GetCorrelationFactor());

	double quantity = abscorr * (tree->GetMaximum(obs[io].c_str()) - tree->GetMinimum(obs[io].c_str())) / error[obs[io].c_str()];

	quanmap[obs[io].c_str()] = quantity;

	TLine* linemin = new TLine(xmin,ymin, xmax, ymin);
	linemin->SetLineColor(kRed);
	linemin->SetLineWidth(2);
	linemin->Draw();

	TLine* linemax = new TLine(xmin,ymax, xmax, ymax);
	linemax->SetLineColor(kRed);
	linemax->SetLineWidth(2);
	linemax->Draw();

	TLine* linecen = new TLine(xmin,ycen, xmax, ycen);
	linecen->SetLineColor(kBlue);
	linecen->SetLineStyle(2);
	linecen->SetLineWidth(2);
	linecen->Draw();

	sprintf(outputfilename, "%sVs%s.jpg", obs[io].c_str(), par[ip].c_str());

	c1->Print(outputfilename);

	histo->Delete();

      }

      /*
      std::cout << "Most sensitive observables for " << par[ip]
		<< ":" << std::endl;

      double maxquan = -1;
      std::string maxquanname;
      for ( int io=0; io<obs.size(); io++ ) {
	if ( quanmap[obs[io]] > maxquan ) {
	  maxquan = quanmap[obs[io]];
	  maxquanname = obs[io];
	}
      }

      std::cout << maxquanname << " (" << maxquan << ")" << std::endl;

      double max2quan = -1;
      std::string max2quanname;
      for ( int io=0; io<obs.size(); io++ ) {
	if ( quanmap[obs[io]] > max2quan && obs[io].compare(maxquanname) ) {
	  max2quan = quanmap[obs[io]];
	  max2quanname = obs[io];
	}
      }

      std::cout << max2quanname << " (" << max2quan << ")" << std::endl;

      double max3quan = -1;
      std::string max3quanname;
      for ( int io=0; io<obs.size(); io++ ) {
	if ( quanmap[obs[io]] > max3quan && obs[io].compare(maxquanname) 
	     && obs[io].compare(max2quanname) ) {
	  max3quan = quanmap[obs[io]];
	  max3quanname = obs[io];
	}
      }

      std::cout << max3quanname << " (" << max3quan << ")" << std::endl;
      */
    }

}
