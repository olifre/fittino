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

	// Derzeit von Hand auf eins gesetzt, muessen spaeter in den Fit
	effvalues.nbb  = 1;
	effvalues.nww  = 1;
	effvalues.nb   = 1;
	effvalues.nw   = 1;
	effvalues.ngg  = 1;
	effvalues.rbb  = 1;
	effvalues.rww  = 1;
	effvalues.rgg  = 1;
	effvalues.rw   = 1;
	effvalues.rb   = 1;

	// Effekte der obigen Variablen AUS
	effvalues.override_unitarity = 1;
	
	// Standardmodellwerte der PDG

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
	cout<<"Initialisiere Hadronische CS...";
	init_hadronic_cs_( &smvalues );
	cout<<"done"<<endl;
	cout<<"Initialisiere Breiten...";
	initsmwidths_( &smvalues );
	cout<<"done"<<endl;
	cout<<endl<<"Starte Scan..."<<endl<<endl;

	cout<<setw(12)<<"fb";
	cout<<setw(12)<<"VBF (CS)"<<setw(12)<<"VBF (Err)"<<setw(12)<<"VBF (Chi)";
	cout<<setw(12)<<"WH  (CS)"<<setw(12)<<"WH  (Err)"<<setw(12)<<"WH  (Chi)";
	cout<<setw(12)<<"Time(s)"<<endl;

	for( int i = 0; i <= 20; i++ )
	{
	  clock_t start, end;
	  start = clock();
	  effvalues.fb = 1e-4/20.0*(double)i;
	 
	  double VBF, VBF_err, VBF_chi;
	  double WH,  WH_err,  WH_chi;
	  udcsb_jjh_( &smvalues, &effvalues, &VBF, &VBF_err, &VBF_chi);
	  HWRadiation_( &smvalues, &effvalues, &WH, &WH_err, &WH_chi );
	  cout<<scientific<<setprecision(4)<<setw(12)<<effvalues.fb;
	  cout<<scientific<<setw(12)<<VBF<<setw(12)<<VBF_err<<setw(12)<<VBF_chi;
	  cout<<scientific<<setw(12)<<WH<<setw(12)<<WH_err<<setw(12)<<WH_chi;
	  end = clock();
	  cout<<setw(12)<<(end-start)/CLOCKS_PER_SEC<<endl;
	};
	

	return 0;
};
