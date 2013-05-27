#include "HiggsCalculator.h"
#include <iostream>

int main(){


  int _nHiggsneut = 1;
  int _nHiggsplus = 0;
  int _outputLevel = 0;

  
  initialize_higgssignals_latestresults_( &_nHiggsneut, &_nHiggsplus );
  setup_output_level_( &_outputLevel );

  int _iteration = 0;
  setup_higgs_to_peaks_assignment_iterations_( &_iteration );

  double _range = 2;
  setup_assignmentrange_( &_range );

  int _pdf_in = 2;
  setup_pdf_( &_pdf_in );

  double _dMh[3];
  _dMh[0] = 3.0;
  _dMh[1] = 3.0;
  _dMh[2] = 3.0;
  higgssignals_neutral_input_massuncertainty_( _dMh );

  double _dCS[5];
  double _dBR[5];
  _dCS[0] = 0.200;
  _dCS[1] = 0.028;
  _dCS[2] = 0.037;
  _dCS[3] = 0.051;
  _dCS[4] = 0.120;
  _dBR[0] = 0.054;
  _dBR[1] = 0.048;
  _dBR[2] = 0.048;
  _dBR[3] = 0.061;
  _dBR[4] = 0.028;
  setup_rate_uncertainties_( _dCS, _dBR );

  double _mh = 125;
  double _gammaTotal = 4.6e-3;
  double _g2hjss_s = 1;
  double _g2hjss_p = 0;
  double _g2hjcc_s=1;
  double _g2hjcc_p=0;
  double _g2hjbb_s=1;
  double _g2hjbb_p=0;
  double _g2hjtt_s=1;
  double _g2hjtt_p=0;
  double _g2hjmumu_s=1;
  double _g2hjmumu_p=0;
  double _g2hjtautau_s=1;
  double _g2hjtautau_p=0;
  double _g2hjWW=1;
  double _g2hjZZ=1;
  double _g2hjZga=1;
  double _g2hjgaga=1;
  double _g2hjgg=1;
  double _g2hjggZ=1;
  double _g2hjhiZ=0;
  double _BR_hjinvisible=0;
  double _BR_hjhihi=0;


  _gammaTotal =  smgamma_h_( &_mh );

//  1
//     + ( g2hjss_s - 1 ) * data.Get("smbr_hss")
//     + ( g2hjcc_s - 1 ) * data.Get("smbr_hcc")
//     + ( g2hjbb_s - 1 ) * data.Get("smbr_hbb")
//     + ( g2hjtt_s - 1 ) * data.Get("smbr_htoptop")
//     + ( g2hjmumu_s - 1 ) * data.Get("smbr_hmumu")
//     + ( g2hjtautau_s - 1 ) * data.Get("smbr_htautau")
//     + ( g2hjWW - 1 ) * data.Get("smbr_hww")
//     + ( g2hjZZ - 1 ) * data.Get("smbr_hzz")
//     + ( g2hjZga - 1 ) * data.Get("smbr_hzgam")
//     + ( g2hjgaga - 1 ) * data.Get("smbr_hgamgam")
//     + ( g2hjgg - 1 ) * data.Get("smbr_hgg") ;



  higgsbounds_neutral_input_effc_( &_mh,
				   &_gammaTotal, 
				   &_g2hjss_s,
				   &_g2hjss_p,
				   &_g2hjcc_s,
				   &_g2hjcc_p,
				   &_g2hjbb_s,
				   &_g2hjbb_p,
				   &_g2hjtt_s,
				   &_g2hjtt_p,
				   &_g2hjmumu_s,
				   &_g2hjmumu_p,
				   &_g2hjtautau_s,
				   &_g2hjtautau_p,
				   &_g2hjWW,
				   &_g2hjZZ,
				   &_g2hjZga,
				   &_g2hjgaga,
				   &_g2hjgg,
				   &_g2hjggZ,
				   &_g2hjhiZ,
				   &_BR_hjinvisible,
				   &_BR_hjhihi);

  int _hsmode = 1;
  double _Chisq=0;
  double _Chisq_mh=0;
  double _Chisq_mu=0;
  double _Pvalue=0;
  int    _ndf=0;
  run_higgssignals_(&_hsmode, &_Chisq_mu, &_Chisq_mh,  &_Chisq, &_ndf, &_Pvalue);

  std::cout<<"chi2 "<<_Chisq<<std::endl;

  int i = 1;
  int _collider = 3;
  double _R_H_WW =0;
  double _R_H_ZZ=0;
  double _R_H_gaga=0;
  double _R_H_tautau=0;
  double _R_H_bb=0;
  double _R_VH_bb=0; 
  get_rvalues_( &i, 
		&_collider,
		&_R_H_WW, 
		&_R_H_ZZ, 
		&_R_H_gaga,
		&_R_H_tautau,
		&_R_H_bb,
		&_R_VH_bb );

  std::cout<<"width "<<_gammaTotal<<std::endl;
  std::cout<<"WW "<<_R_H_WW<<std::endl;
  std::cout<<"ZZ "<<_R_H_ZZ<<std::endl;
  std::cout<<"gaga "<<_R_H_gaga<<std::endl;
  std::cout<<"tautau "<<_R_H_tautau<<std::endl;
  std::cout<<"bb "<<_R_H_bb<<std::endl;
  std::cout<<"VH_bb "<<_R_VH_bb<<std::endl;
  
  


}
