
#include "TSystem.h"
#include "LHCCalculator.h"

void LHCCalculator::SetOutput( FloatStorage* out ){

  _out = out;

}


LHCCalculator::LHCCalculator(Mode mode){

  TString path="$FITTINO/tools/GetToyLHCChi2/ProfileLikelihood";
  gSystem->ExpandPathName(path);
  _dir=path;
  _mode = mode;

  if ( _mode == paper2012 ) {
    
    //    _fChi2 = new TFile( (_dir+"/data/LHCChi2Histogram_2011_7TeV_4.7ifb.root").c_str() );
    //    _hChi2 = (TH2D*) _fChi2->Get("hist" );

    _fChi2=new TFile((_dir+"/data/try10_comb.root").c_str(),"READ");
    _hChi2 = (TH2D*)_fChi2->Get("h_chi2_2D_comb");



  }
  else {

    vector<int> M0Values;
    M0Values.push_back(680);
    M0Values.push_back(860);
    M0Values.push_back(1080);
    M0Values.push_back(1200);
    M0Values.push_back(1400);
    M0Values.push_back(1500);
    M0Values.push_back(1962);
    M0Values.push_back(2500);

    _fChi2 = new TFile( (_dir+"/AllChi2Maps.root").c_str() );
    _hChi2 = (TH2D*) _fChi2->Get("h_chi2");

    for( uint iM0 = 0; iM0 < M0Values.size(); ++iM0 ) {

      char histname[30];
      sprintf(histname, "h_chi2_corr_offgrid_M0%i", M0Values[iM0]);
      _vCorr.push_back( (TH2D*) _fChi2->Get(histname) );

    }
    
  }

  _m0_max=_hChi2->GetXaxis()->GetBinCenter(_hChi2->GetXaxis()->GetLast()-1);
  _m12_max=_hChi2->GetYaxis()->GetBinCenter(_hChi2->GetYaxis()->GetLast()-1);

}

LHCCalculator::~LHCCalculator(){

  _fChi2->Close();

}


double LHCCalculator::GetChi2(){

  return _chi2;

}

void LHCCalculator::Calculate(){

  _m0      = _in->Get("P_M0");
  _m12     = _in->Get("P_M12");
  _a0      = _in->Get("P_A0");
  _tanBeta = _in->Get("P_TanBeta");

  if ( _mode == corr ) {

    _chi2 = _prov->GetChi2ContributionFix( _m0, _m12, _a0, _tanBeta, _hChi2, _vCorr );

  }
  else  if (_mode == paper2012){


    //    if( _m0 < 20 || _m0 > 3500 || _m12 < 100 ||_m12 > 1200 ) {
    if( _m0 < 20 || _m12 < 100 ||_m12 > 1200 ) {

      _chi2=0;

    }
    else if ( _m0>2500 ) {

      _chi2= _hChi2->Interpolate(2500, _m12);

    }
    else{

      _chi2= _hChi2->Interpolate(_m0, _m12);
	
    }

  }

  _in->Set("LHC_chi2", _chi2);


    //     if ( _m0 > _m0_max || _m12 > _m12_max ) {
    //       _chi2 = 0;
    //     }
    //     else {
    //       _chi2= _hChi2 -> Interpolate( _m0, _m12 );
    //       if ( _chi2<0 ){
    // 	_chi2 = 0;
    //       }



  



}



void LHCCalculator::SetInput( FloatStorage* in ) {

  _in = in;

}

void LHCCalculator::Print(){


  std::cout<<"LHC Calculator uses mode "<<_mode<<std::endl; 

}


std::string LHCCalculator::ModeName[]={"paper2012", "corr", "nocorr"};
