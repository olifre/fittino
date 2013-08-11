#include <cstdlib>
#include <iostream>
#include <iomanip>
#include <cstring>

// Zur Zeitmessung
#include <time.h>
#include <LHAPDF/LHAPDF.h>

#include "CrossSection_had.h"
#include "decay.h"
#include "VBF.h"

using namespace std;

int main( int argc, char ** argv )
{
	if( argc != 2 )
	{
		cout<<"Usage: testprog <PDFSET>"<<endl;
		return 0;
	};
	string pdfset = string(argv[1]);

	cout<<"Using PDF-Set: "<<pdfset<<endl;

	sminputs  smvalues;
	effinputs effvalues;
  
	/* SM-Kopplungen und Weinberg-Winkel */

	effvalues.fbb  = 0;
	effvalues.fww  = 0;
	effvalues.fgg  = 0;
	effvalues.fb   = 0;
	effvalues.fw   = 0;
	effvalues.fuph = 0;
	effvalues.fdoh = 0;
	effvalues.fchh = 0;
	effvalues.fsth = 0;
	effvalues.ftoh = 0;
	effvalues.fboh = 0;
	effvalues.felh = 0;
	effvalues.fmuh = 0;
	effvalues.ftah = 0;
	effvalues.ghyy = 0;
  
	smvalues.mel    = 0.511e-3;
	smvalues.mmu    = 0.10565;
	smvalues.mta    = 1.777;
	smvalues.mup    = 0.0023;
	smvalues.mdo    = 0.0048;
	smvalues.mch    = 1.275;
	smvalues.mst    = 0.095;
	smvalues.mto    = 173.5;
	smvalues.mbo    = 4.18;

	smvalues.mz     = 91.1876;
	smvalues.mw     = 80.385;
	smvalues.mh     = 125;

	smvalues.alphae = 0.0078186;
	smvalues.alphas = 0.11819;
	smvalues.sw     = 0.48079;

	smvalues.vud    = 0.97483;
	smvalues.vus    = 0.2229;
	smvalues.vub    = 0.0036;
	smvalues.vcd    = 0.23;
	smvalues.vcs    = 0.97389;
	smvalues.vcb    = 40.9e-3;
	smvalues.vtd    = 8.4e-3;
	smvalues.vts    = 42.9e-3;
	smvalues.vtb    = 0.89;
	smvalues.vev    = smvalues.mw*smvalues.sw/sqrt(4.0*3.14159*smvalues.alphae)*2.0;
	smvalues.s      = pow( 7000,2 );

	// Standardmodell-Higgs-Breiten nach CERN LHC Higgs Cross-Section Working Group (Yellow Report Pages)

	smvalues.br_h_bb      = 0.577;
	smvalues.br_h_cc      = 0.0291;
	smvalues.br_h_ss      = 0.015;      //Wert angenommen
	smvalues.br_h_mm      = 2.2e-4;
	smvalues.br_h_tautau  = 0.0632;
	smvalues.br_h_zz      = 0.0264;
        smvalues.br_h_ww      = 0.215;
        smvalues.br_h_yy      = 2.28e-3;
	smvalues.br_h_gg      = 0.0857;
	smvalues.sm_width     = 4.07e-3;
	smvalues.sm_width_err = 0.16e-3;
	smvalues.br_h_yz      = 1.54e-3;

	smvalues.err_h_bb     = 0.577*0.033;
	smvalues.err_h_cc     = 0.0291*0.122;
	smvalues.err_h_ss     = 0.015*0.05;  //Wert angenommen
        smvalues.err_h_mm     = 2.2e-4*0.06;
        smvalues.err_h_tautau = 0.0632*0.058;
	smvalues.err_h_zz     = 0.0264*0.043;
        smvalues.err_h_ww     = 0.215*0.043;
	smvalues.err_h_yy     = 2.28e-3*0.05;
	smvalues.err_h_gg     = 0.0857*0.1;
	smvalues.err_h_yz     = 1.54e-3*0.09;
	LHAPDF::initPDFSet( pdfset, LHAPDF::LHGRID, 0 );

	/* Initialize run */
	cout<<"Initialisiere Kopplungen... ";
	update_effinputs_( &smvalues, &effvalues ); //Calculates Triple-Vertex Couplings in effvalues
	cout<<"done"<<endl;
	cout<<"Initialisiere VBF SM-Werte...";
	vbf_init_cs_( &smvalues );
	cout<<"done"<<endl;
	cout<<"Initialisiere Hadronische CS...";
	init_hadronic_cs_( &smvalues );
	cout<<"done"<<endl;
	cout<<"Initialisiere Standardmodell-Breiten...";
	initsmwidths_( &smvalues );
	cout<<"done"<<endl;
	cout<<endl<<"Starte Scan..."<<endl<<endl;

	cout<<setw(12)<<"fww"<<setw(12)<<"VBF"<<setw(12)<<"VBF_ERR"<<setw(12)<<"VBF_CHI";
	cout<<setw(12)<<"bg-hb"<<setw(12)<<"bg-hb-ERR"<<setw(12)<<"bg-hb-CHI";
        cout<<setw(12)<<"HW"<<setw(12)<<"HW_ERR"<<setw(12)<<"HW_CHI";
	cout<<setw(12)<<"HZ"<<setw(12)<<"HZ_ERR"<<setw(12)<<"HZ_CHI";
	cout<<setw(12)<<"BR(H->ZZ*)"<<setw(12)<<"HZZ_ERR"<<setw(12)<<"HZZ_CHI";
	cout<<setw(12)<<"BR(H->WW*)"<<setw(12)<<"HWW_ERR"<<setw(12)<<"HWW_CHI";
	cout<<setw(12)<<"BR(H->GG*)"<<setw(12)<<"HGG_ERR"<<setw(12)<<"HGG_CHI";
	cout<<setw(12)<<"BR(H->yy)"<<setw(12)<<"Hyy_ERR"<<setw(12)<<"Hyy_CHI";
	cout<<setw(12)<<"BR(H->bb)"<<setw(12)<<"Hbb_ERR"<<setw(12)<<"Hbb_CHI";
	cout<<setw(12)<<"BR(H->zy)"<<setw(12)<<"Hzy_ERR"<<setw(12)<<"HZY_CHI";
	cout<<setw(12)<<"Width(H)"<<setw(12)<<"Err_W(H)"<<setw(12)<<"Time(s)"<<endl;

	for( int i = 0; i <= 10; i++ )
	{
	  clock_t start, end;
	  start = clock();
	  effvalues.fww = (1.0e-10)*pow( 10.0 ,(double)i );
	  update_effinputs_( &smvalues, &effvalues );
	  
	  double vbfratio, hzratio, hwratio, Brhww, Brhzz, bgratio;
	  double err_vbfratio, err_hzratio, err_hwratio, err_Brhww, err_Brhzz, err_bgratio;
	  double chi_vbfratio, chi_hzratio, chi_hwratio, chi_Brhww, chi_Brhzz, chi_bgratio;
	  double BR_Hzz, BR_Hzz_Err, BR_Hzz_Chi;
	  double BR_Hww, BR_Hww_Err, BR_Hww_Chi;
	  double BR_Hgg, BR_Hgg_Err, BR_Hgg_Chi;
	  double BR_Hyy, BR_Hyy_Err, BR_Hyy_Chi;
	  double BR_Hbb, BR_Hbb_Err, BR_Hbb_Chi;
	  double BR_Hzy, BR_Hzy_Err, BR_Hzy_Chi;
	  double TH, TH_Err, TH_Chi;

	  cout<<scientific<<setprecision(4)<<setw(12)<<effvalues.fww;
	  initeffwidths_( &smvalues, &effvalues );
	  ratio_vbf_2flav_( &smvalues, &effvalues, &vbfratio, &err_vbfratio, &chi_vbfratio );
 	  ratio_pphz_( &smvalues, &effvalues, &hzratio, &err_hzratio, &chi_hzratio );
          ratio_pphw_( &smvalues, &effvalues, &hwratio, &err_hwratio, &chi_hwratio );
	  ratio_bg_bh_(&smvalues, &effvalues, &bgratio, &err_bgratio, &chi_bgratio );
	  br_hww_(     &smvalues, &effvalues, &BR_Hww,  &BR_Hww_Err,  &BR_Hww_Chi  );
          br_hzz_(     &smvalues, &effvalues, &BR_Hzz,  &BR_Hzz_Err,  &BR_Hzz_Chi  );
          br_hglgl_(   &smvalues, &effvalues, &BR_Hgg,  &BR_Hgg_Err,  &BR_Hgg_Chi  );
          br_hgaga_(   &smvalues, &effvalues, &BR_Hyy,  &BR_Hyy_Err,  &BR_Hyy_Chi  );
	  br_hbb_(     &smvalues, &effvalues, &BR_Hbb,  &BR_Hbb_Err,  &BR_Hbb_Chi  );
	  br_hgaz_(    &smvalues, &effvalues, &BR_Hzy,  &BR_Hzy_Err,  &BR_Hzy_Chi  );
	  totalwidth_( &smvalues, &effvalues, &TH, &TH_Err, &TH_Chi );
	  cout<<setprecision(4)<<scientific<<setw(12)<<vbfratio<<setw(12)<<err_vbfratio<<setw(12)<<chi_vbfratio;
	  cout<<setprecision(4)<<scientific<<setw(12)<<bgratio<<setw(12)<<err_bgratio<<setw(12)<<chi_bgratio;
	  cout<<setprecision(4)<<scientific<<setw(12)<<hwratio<<setw(12)<<err_hwratio<<setw(12)<<chi_hwratio;
	  cout<<setprecision(4)<<scientific<<setw(12)<<hzratio<<setw(12)<<err_hzratio<<setw(12)<<chi_hzratio;
	  cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hzz<<setw(12)<<BR_Hzz_Err<<setw(12)<<BR_Hzz_Chi;
          cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hww<<setw(12)<<BR_Hww_Err<<setw(12)<<BR_Hww_Chi;
          cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hgg<<setw(12)<<BR_Hgg_Err<<setw(12)<<BR_Hgg_Chi;
          cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hyy<<setw(12)<<BR_Hyy_Err<<setw(12)<<BR_Hyy_Chi;
	  cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hbb<<setw(12)<<BR_Hbb_Err<<setw(12)<<BR_Hbb_Chi;
	  cout<<setprecision(4)<<scientific<<setw(12)<<BR_Hzy<<setw(12)<<BR_Hzy_Err<<setw(12)<<BR_Hzy_Err;
	  cout<<setprecision(4)<<scientific<<setw(12)<<TH<<setw(12)<<TH_Err;
	  end = clock();
	  cout<<setw(12)<<(end-start)/CLOCKS_PER_SEC<<endl;
	};
	

	return 0;
};
