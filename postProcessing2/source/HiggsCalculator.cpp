#include "HiggsCalculator.h"
#include <sstream>
#include <fstream>
#include <iostream>
#include <stdexcept>

HiggsCalculator::HiggsCalculator(FloatStorage* in, FloatStorage* out,  std::string obsSet, std::string theoMassUncStr ) {

  double theoMassUnc;

  std::stringstream ss;
  ss<<theoMassUncStr;
  ss>>theoMassUnc;

  std::cout<<"Using HS obsSet "<<obsSet<<" and theoMassUnc "<<theoMassUnc<<"."<<std::endl;

  _in = in;
  _out = out;

  _obsSet = obsSet;
  _nHiggsneut = 1;
  _nHiggsplus = 0;
  _tag="HS_";
  if ( _obsSet == "inclusive" ) {
    _tag+="_incl_";
    initialize_higgssignals_for_fittino_( &_nHiggsneut, &_nHiggsplus );

  }
  else if ( _obsSet == "category" ) {
    _tag+="_cat_";
    initialize_higgssignals_latestresults_( &_nHiggsneut, &_nHiggsplus );

  }
  else {

    throw std::runtime_error("Unknown HS obs set!");

  }

  //  _tag+="ar10000_";

  _tag+=theoMassUncStr+"_";

  _outputLevel = 0;
  setup_output_level_( &_outputLevel );

  _iteration = 0;
  setup_higgs_to_peaks_assignment_iterations_( &_iteration );

  _range = 2; 
  //_range = 10000;

  setup_assignmentrange_( &_range );

  _pdf_in = 2;
  setup_pdf_( &_pdf_in );

  _dMh[0] = theoMassUnc;
  _dMh[1] = theoMassUnc;
  _dMh[2] = theoMassUnc;

  higgssignals_neutral_input_massuncertainty_( _dMh );


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

  _hsmode = 1;
  _collider = 3;

  _mh = 125.5;
  _gammaTotal = 1;
  _g2hjss_s = 1;
  _g2hjss_p = 0;
  _g2hjcc_s=1;
  _g2hjcc_p=0;
  _g2hjbb_s=1;
  _g2hjbb_p=0;
  _g2hjtt_s=1;
  _g2hjtt_p=0;
  _g2hjmumu_s=1;
  _g2hjmumu_p=0;
  _g2hjtautau_s=1;
  _g2hjtautau_p=0;
  _g2hjWW=1;
  _g2hjZZ=1;
  _g2hjZga=1;
  _g2hjgaga=1;
  _g2hjgg=1;
  _g2hjggZ=1;
  _g2hjhiZ=1;
  _BR_hjinvisible=0;
  _BR_hjhihi=0;

  CallFunction();

  __io_MOD_get_number_of_observables( &_ntotal, &_npeakmu, &_npeakmh, &_nmpred, &_nanalyses );

  _out->Add( _tag+"dCS0",         _dCS[0] );   
  _out->Add( _tag+"ntotal",    _ntotal );
  _out->Add( _tag+"npeakmu",   _npeakmu );
  _out->Add( _tag+"npeakmh",   _npeakmh );
  _out->Add( _tag+"nmpred",    _nmpred );
  _out->Add( _tag+"nanalyses", _nanalyses );

  for( int i = 1; i <= _npeakmu; i++ ) {

    int ID;
    std::stringstream ss;
    __io_MOD_get_id_of_peakobservable(&i, &ID);
    ss << ID;
    _ID[ID] = ss.str();
    _out->Add( _tag+"mupred_"+_ID[ID] );
    _out->Add( _tag+"csqmu_"+_ID[ID] );
    _out->Add( _tag+"csqmh_"+_ID[ID] );
    _out->Add( _tag+"csqmax_"+_ID[ID] );
    _out->Add( _tag+"csqtot_"+_ID[ID] );

  }

  _out->Add( _tag+"Chisq" );
  _out->Add( _tag+"Chisq_mh" );
  _out->Add( _tag+"Chisq_mu" );
  _out->Add( _tag+"ndf" );
  _out->Add( _tag+"Pvalue" );

  _out->Add( _tag+"R_H_WW" );
  _out->Add( _tag+"R_H_ZZ" );
  _out->Add( _tag+"R_H_gaga" );
  _out->Add( _tag+"R_H_tautau" );
  _out->Add( _tag+"R_H_bb" );
  _out->Add( _tag+"R_VH_bb" );

  _out->Add( _tag+"HB_gamma_SM");

  ConfigureOutput();

}

HiggsCalculator::~HiggsCalculator(){

  finish_higgssignals_();

}






double HiggsCalculator::CalculateSinglehUncertainty( double dhbb,
						     double dhgg,
						     double g2hbb,
						     double g2hgg,
						     double massh ) {
 
  double singlehUncertainty;
  double vsmall = 1.e-16;
 
  if ( g2hgg <= vsmall && g2hbb <= vsmall ) {
 
    singlehUncertainty = 0.;
 
  }
  else {
     
    singlehUncertainty = ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh ) * dhgg
                       +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) * dhbb )
                       / ( g2hgg * __theory_collidersfunctions_MOD_lhc8_rh_gg( &massh )
                       +   g2hbb * __theory_collidersfunctions_MOD_lhc8_rh_bb( &massh ) );
     
  }
 
  return singlehUncertainty;
      
}




void HiggsCalculator::Calculate(){

  ConfigureInput();
  CallFunction();
  ConfigureOutput();

}

double HiggsCalculator::GetChi2(){

  return _Chisq;

}

void HiggsCalculator::SetInput(FloatStorage* in){

  _in = in;

}

void HiggsCalculator::SetOutput(FloatStorage* out){

  _out = out;

}

void HiggsCalculator::CallFunction(){

  double dhbb = 0.2;
  double dhgg = 0.147;
  double g2hjbb = _g2hjbb_s + _g2hjbb_p;
 
  _dCS[0] = CalculateSinglehUncertainty( dhbb, dhgg, g2hjbb, _g2hjgg, _mh ); // singleH

  setup_rate_uncertainties_( _dCS, _dBR );

  
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

  run_higgssignals_(&_hsmode, &_Chisq_mu, &_Chisq_mh,  &_Chisq, &_ndf, &_Pvalue);


}

void HiggsCalculator::ConfigureInput() {

  // == when the couplings were not saved in the ntuple: g2 = BF*Gamma / BF_SM*Gamma_SM 

//   _mh             = _in->Get("O_massh0");
//   _gammaTotal     = _in->Get("O_widthh0");
//   double gammaRatio = _gammaTotal / smgamma_h_( &_mh );
//   _g2hjss_s       = _in->Get("O_h0_To_Strange_Strange~_") / smbr_hss_( &_mh ) * gammaRatio;
//   _g2hjcc_s       = _in->Get("O_h0_To_Charm_Charm~_") / smbr_hcc_( &_mh ) * gammaRatio;
//   _g2hjbb_s       = _in->Get("O_HiggsScalarFermionCoupling3250505");
//   _g2hjtt_s       = _in->Get("O_HiggsScalarFermionCoupling3250606");
//   _g2hjmumu_s     = _in->Get("O_h0_To_Muon_Muon~_") / smbr_hmumu_( &_mh ) * gammaRatio;
//   _g2hjtautau_s   = _in->Get("O_HiggsScalarFermionCoupling3251515");
//   _g2hjWW         = _in->Get("O_HiggsBosonCoupling3252424");
//   _g2hjZZ         = _in->Get("O_HiggsBosonCoupling3252323");
//   _g2hjZga        = _in->Get("O_h0_To_Z_Gamma_") / smbr_hzgam_( &_mh ) * gammaRatio;
//   _g2hjgaga       = _in->Get("O_h0_To_Gamma_Gamma_") / smbr_hgamgam_( &_mh ) * gammaRatio;
//   _g2hjgg         = _in->Get("O_HiggsBosonCoupling3252121");
//   _g2hjggZ        = _in->Get("O_HiggsBosonCoupling425212123");
//   _g2hjhiZ        = _in->Get("O_HiggsBosonCoupling3252523");
//   _BR_hjinvisible = _in->Get("O_h0_To_Neutralino1_Neutralino1_");

  _mh             = _in->Get("FH_massh0");
  _gammaTotal     = _in->Get("FH_Z_GTot_Model")*smgamma_h_( &_mh )/_in->Get("FH_Z_GTot_SM");
  _g2hjss_s       = _in->Get("FH_Z_g2hss_s_GammaNorm");
  _g2hjcc_s       = _in->Get("FH_Z_g2hcc_s_GammaNorm");
  _g2hjbb_s       = _in->Get("FH_Z_bbh_Model")/_in->Get("FH_Z_bbh_SM");
  _g2hjtt_s       = _in->Get("FH_Z_tth_Model")/_in->Get("FH_Z_tth_SM");
  _g2hjmumu_s     = _in->Get("FH_Z_g2hmumu_s_GammaNorm");
  _g2hjtautau_s   = _in->Get("FH_Z_g2htautau_s_GammaNorm");
  _g2hjWW         = _in->Get("FH_Z_g2hWW_GammaNorm");
  _g2hjZZ         = _in->Get("FH_Z_g2hZZ_GammaNorm");
  _g2hjZga        = 1;
  _g2hjgaga       = _in->Get("FH_Z_g2hgaga_GammaNorm");
  _g2hjgg         = _in->Get("FH_Z_ggh_Model")/_in->Get("FH_Z_ggh_SM");
  _g2hjggZ        = 1;
  _g2hjhiZ        = 0;
  _BR_hjinvisible = _in->Get("FH_Z_G(h->n1n1)_Model")/_in->Get("FH_Z_GTot_Model");


}

void HiggsCalculator::ConfigureOutput(){

  _out->Set( _tag+"HB_gamma_SM", smgamma_h_( &_mh ) );

  _out->Set( _tag+"dCS0", _dCS[0] );

  _out->Set( _tag+"Chisq_mu", _Chisq_mu );
  _out->Set( _tag+"Chisq_mh", _Chisq_mh );
  _out->Set( _tag+"Chisq",    _Chisq    );
  _out->Set( _tag+"ndf",      _ndf      );
  _out->Set( _tag+"Pvalue",   _Pvalue   );
  
  int i = 1;

  get_rvalues_( &i, 
		&_collider,
		&_R_H_WW, 
		&_R_H_ZZ, 
		&_R_H_gaga,
		&_R_H_tautau,
		&_R_H_bb,
		&_R_VH_bb );

  _out->Set( _tag+"R_H_WW",      _R_H_WW     );
  _out->Set( _tag+"R_H_ZZ",      _R_H_ZZ     );
  _out->Set( _tag+"R_H_gaga",    _R_H_gaga   );
  _out->Set( _tag+"R_H_tautau",  _R_H_tautau );
  _out->Set( _tag+"R_H_bb",      _R_H_bb     );
  _out->Set( _tag+"R_VH_bb",     _R_VH_bb    );


  std::map< int, std::string >::iterator iter;

  for ( iter = _ID.begin(); iter != _ID.end(); iter++ ) {

    double mupred;
    int domH, nHcomb;
    int id = iter->first;
    __io_MOD_get_peakinfo_from_hsresults( &id, &mupred, &domH, &nHcomb );
    _out->Set( _tag+"mupred_" + iter->second, mupred );

    
    double csqmu, csqmh, csqmax, csqtot;
    __pc_chisq_MOD_get_peakchi2( &id, &csqmu, &csqmh, &csqmax, &csqtot); 
    _out->Set( _tag+"csqmu_"  + iter->second,  csqmu );
    _out->Set( _tag+"csqmh_"  + iter->second,  csqmh );
    _out->Set( _tag+"csqmax_" + iter->second,  csqmax);
    _out->Set( _tag+"csqtot_" + iter->second,  csqtot);


  }

}

// == Get correlated random numbers, given the correlation between the 16 channels
TVectorD HiggsCalculator::GetCorrelatedRandomNumbers(const TVectorD& mean,
						     const TMatrixDSym& covarianceMatrix,
						     int randomSeed ) {
  int n = mean.GetNoElements();

   const TMatrixDSymEigen matrix(covarianceMatrix);
   TMatrixD eigenVecMatrix = matrix.GetEigenVectors();
   TVectorD eigenValueVec = matrix.GetEigenValues();
   TVectorD y(n);
   TRandom3 r( randomSeed );
   for (int i=0; i<n; i++) {
      if (eigenValueVec(i) < 0) {
	std::cout << "getCorrelatedRandomNumbers: Covariance matrix is not non-negative definite" << std::endl;
	exit(EXIT_FAILURE);
      }
      y(i) = r.Gaus(0, TMath::Sqrt(eigenValueVec(i)));
   }
   TVectorD x(y);
   x *= eigenVecMatrix;
   x += mean;

   return x;
}

void HiggsCalculator::ReadCovarianceMatrices( bool verb, int useObs ){

  _cov_mu.ResizeTo( _npeakmu, _npeakmu );
  _cov_mh.ResizeTo( _npeakmu, _npeakmu );

  // Print out the matrices in text files
  __pc_chisq_MOD_print_cov_mu_to_file();
  __pc_chisq_MOD_print_cov_mh_to_file( &_nHiggsneut ); // check argument

  // Read the text files
  double col[_npeakmu];
  int line = 0;
  std::ifstream cov_mu_file( "cov_mu.txt" );
  while( cov_mu_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] >> col[16] >> col[17] >> col[18] >> col[19] >> col[20] >> col[21] >> col[22] >> col[23]>> col[24] >> col[25]){
    for( int icol=0; icol<_npeakmu; icol++ ) _cov_mu( line, icol ) = col[icol];
    line++;
  } cov_mu_file.close();
  
 line=0;
 std::ifstream cov_mh_file( "cov_mh.txt" );
  while( cov_mh_file >> col[0] >> col[1] >> col[2] >> col[3] >> col[4] >> col[5] >> col[6] >> col[7] >> col[8] >> col[9] >> col[10] >> col[11] >> col[12]  >> col[13] >> col[14] >>col[15] >> col[16] >> col[17] >> col[18] >> col[19] >> col[20] >> col[21] >> col[22] >> col[23]>> col[24] >> col[25]){
    for( int icol=0; icol<_npeakmu; icol++ ) _cov_mh( line, icol ) = col[icol];
    line++;
  } cov_mh_file.close();
  
}



// SmearObservationAroundInputPrediction
