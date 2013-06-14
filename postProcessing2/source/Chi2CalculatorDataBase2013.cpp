#include <stdexcept>
#include "Chi2CalculatorDataBase2013.h"
#include "HiggsCalculator.h"
#include "LHCCalculator.h"
#include <stdexcept>

Chi2CalculatorDataBase2013::Chi2CalculatorDataBase2013() {

}


Chi2CalculatorDataBase2013::~Chi2CalculatorDataBase2013() {

}


Chi2Calculator Chi2CalculatorDataBase2013::GetPaper2013_LEO() {

  Chi2Calculator calc;

  Observable Bsmm( "O_B_smm_npf", 3.2E-9);
  Bsmm.SetPrecision(2);
  Bsmm.SetUnit(1e-9);
  Bsmm.SetTitle("BR(B_{s}#rightarrow #mu^{+}#mu^{-}) / 10^{-9}");
  Bsmm.AddExpUnc( 1.5E-9 );
  Bsmm.AddTheoUnc( 0.76E-9 );
  calc.AddObservable( Bsmm );

  Observable Btn( "O_Btn_npf", 0.72E-4);
  Btn.SetPrecision(2);
  Btn.SetUnit(1e-4);
  Btn.SetTitle("BR(b#rightarrow #tau#nu) / 10^{-4}");
  Btn.AddExpUnc( 0.27E-4 );  
  Btn.AddExpUnc( 0.11E-4 );  
  Btn.AddTheoUnc( 0.07E-4 );  
  calc.AddObservable( Btn );

  Observable Bsg( "O_Bsg_npf", 3.55E-4);
  Bsg.SetPrecision(2);
  Bsg.SetUnit(1e-4);
  Bsg.SetTitle("BR(b#rightarrow s#gamma) / 10^{-4}");
  Bsg.AddExpUnc( 0.24E-4 );
  Bsg.AddExpUnc( 0.09E-4 );
  Bsg.AddTheoUnc( 0.23E-4 );  
  calc.AddObservable( Bsg );

//   Observable Bsg( "O_Bsg_npf", 3.43E-4);
//   Bsg.SetPrecision(2);
//   Bsg.SetUnit(1e-4);
//   Bsg.SetTitle("BR(b#rightarrow s#gamma) / 10^{-4}");
//   Bsg.AddExpUnc( 0.21E-4 );
//   Bsg.AddExpUnc( 0.07E-4 );
//   Bsg.AddTheoUnc( 0.23E-4 );  
//   calc.AddObservable( Bsg );


  Observable dms( "O_dm_s_npf",	17.719);
  dms.SetPrecision(3);
  dms.SetTitle("#Delta m_{s} / ps^{-1}");
  dms.AddExpUnc( 0.043 );
  dms.AddTheoUnc( 4.2);
  calc.AddObservable( dms );

  Observable gmin2( "O_gmin2m_npf", 28.7E-10);
  gmin2.SetPrecision(1);
  gmin2.SetTitle("(a_{#mu} - a_{#mu}^{SM}) / 10^{-10}");
  gmin2.SetUnit(1e-10);
  gmin2.AddExpUnc( 8.0E-10 );
  gmin2.AddTheoUnc( 2.0E-10 );
  calc.AddObservable( gmin2 );
  
  Observable MassW( "O_MassW_npf", 80.385);
  MassW.SetPrecision(3);
  MassW.SetTitle("m_{W} / GeV");
  MassW.AddExpUnc( 0.015);
  MassW.AddTheoUnc( 0.010 );
  calc.AddObservable( MassW );

  Observable sinTheta( "O_sin_th_eff_npf", 0.23113);
  sinTheta.SetPrecision(5);
  sinTheta.SetTitle("sin^{2}#theta_{eff}^{l}");
  sinTheta.AddExpUnc( 0.00021 );
  calc.AddObservable( sinTheta );
  
  Observable massChargino( "O_massChargino1", 102.5 ); 
  massChargino.AddTheoUnc(1.0);
  massChargino.SetIsLowerLimit(true, false);   //FIXME
  massChargino.SetPrecision(1);
  massChargino.SetTitle("m_{#chi^{+}} / GeV");
  calc.AddObservable( massChargino );

  Observable omega( "O_omega", 0.1187);
  omega.SetPrecision(4);
  omega.SetTitle("#Omega_{CDM}h^{2}");
  omega.AddExpUnc( 0.0017 );
  omega.AddTheoUnc( 0.01187 );
  calc.AddObservable( omega );

  Observable massTop( "O_massTop", 173.18);
  massTop.SetPrecision(2);
  massTop.SetTitle("m_{t}");
  massTop.AddExpUnc( 0.94 );
  calc.AddObservable( massTop );

  calc.AddChi2Contribution("globalHiggsChi2");

  AstroCalculator* astro = new AstroCalculator("225d");
  calc.SetAstroCalculator(astro);

  return calc;

}

Chi2Calculator Chi2CalculatorDataBase2013::GetChi2Calculator( std::string name, std::string HS ) {


  if (HS!="category" && HS!="inclusive"){

    throw std::runtime_error("Unknown HS obs set.");

  }


  Chi2Calculator calc = GetPaper2013_LEO();
  
  if ( name == "NoHiggsNoLHC" ) {

    calc.SetMaxChi2(12+6); 
    return calc;

  }
  else if ( name =="onlyHS"){

    Chi2Calculator calc2;

    calc2.SetMaxChi2(55);

    calc2.AddChi2Contribution("HS_Chisq"); 

    return calc2;

  }
  else if ( name =="NoHiggs"){

  
    LHCCalculator * lhc = new LHCCalculator(LHCCalculator::corr);
    calc.SetLHCCalculator(lhc);
    calc.SetMaxChi2(12+6);

  }
  else if ( name =="NoHiggsRates"){
  
    LHCCalculator * lhc = new LHCCalculator(LHCCalculator::corr);
    calc.SetLHCCalculator(lhc);
    calc.SetMaxChi2(21);
    calc.SetMinChi2(13);
    
    Observable massh( "O_massh0", 125.5 );
    massh.AddExpUnc( 2.0 );
    massh.AddTheoUnc( 3.0 );
    calc.AddObservable( massh );

  }
  else if ( name == "allObs" ) {

    //     Observable massh( "O_Massh0_npf", 126.0 );
    //     massh.AddExpUnc( 2.0 );
    //     massh.AddTheoUnc( 3.0 );
    //     calc.AddObservable( massh );

    LHCCalculator * lhc = new LHCCalculator(LHCCalculator::corr);
    calc.SetLHCCalculator(lhc);
    calc.AddChi2Contribution("HS_Chisq"); 

    if (HS=="category"){

      calc.SetMaxChi2(57);
      calc.SetMinChi2(49);

    }
    else if (HS=="inclusive"){
      
      calc.SetMaxChi2(44+6);
      
    }

  }
  else if ( name == "noLHC" ) {

    calc.SetMaxChi2(55);
    calc.AddChi2Contribution("HS_Chisq"); 

  }
  else {

    throw std::runtime_error("Obs set not known in 2013");

  }
  
  return calc;

}

//   calc.SetUseLHC( true );
//   calc.GetLHCCalculator()->SetMode(LHCCalculator::corr);

//   calc.SetUseHiggsSignals( true );

//   calc.SetMaxChi2(75);

//   calc.SetName("default");
