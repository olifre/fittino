#include <stdexcept>
#include "Chi2CalculatorDataBase2012.h"
#include "HiggsCalculator.h"
#include "LHCCalculator.h"

Chi2CalculatorDataBase2012::Chi2CalculatorDataBase2012(){

}

Chi2CalculatorDataBase2012::~Chi2CalculatorDataBase2012(){

}

Chi2Calculator Chi2CalculatorDataBase2012::GetPaper2012_LHCmh() {

  Chi2Calculator calc;
  calc.SetMaxChi2( 30 );  

  Observable gmin2( "O_gmin2m_npf", 28.7E-10);
  gmin2.AddExpUnc( 8.0E-10 ); 
  gmin2.AddTheoUnc( 2.0E-10 ); 
  calc.AddObservable( gmin2 );
  
  Observable omega( "O_omega", 0.1123);
  omega.AddExpUnc( 0.0035 ); 
  omega.AddTheoUnc( 0.01123 );
  calc.AddObservable( omega );

  Observable Bsmm( "O_B_smm_npf", 4.5E-9);
  Bsmm.AddExpUnc( 0.3E-9 );
  Bsmm.SetIsUpperLimit(true, false);
  calc.AddObservable( Bsmm );

  Observable Btn( "O_Btn_npf", 1.67E-4);
  Btn.AddExpUnc( 0.39E-4 );  
  calc.AddObservable( Btn );

  Observable Bsg( "O_Bsg_npf", 3.55E-4);
  Bsg.AddExpUnc( 0.24E-4 );
  Bsg.AddExpUnc( 0.09E-4 );
  Bsg.AddTheoUnc( 0.23E-4 );
  calc.AddObservable( Bsg );

  Observable dms( "O_dm_s_npf",	17.78);
  dms.AddExpUnc( 0.12 );
  dms.AddTheoUnc( 5.2 );
  calc.AddObservable( dms );

  Observable MassW( "O_MassW_npf", 80.385 );
  MassW.AddExpUnc( 0.015);
  MassW.AddTheoUnc( 0.010  );
  calc.AddObservable( MassW );

  Observable sinTheta( "O_sin_th_eff_npf", 0.23113 );
  sinTheta.AddExpUnc( 0.00021 );
  calc.AddObservable( sinTheta );

  Observable massChargino( "O_massChargino1", 102.5 ); 
  massChargino.SetIsLowerLimit(true, true);
  calc.AddObservable( massChargino );

  Observable massh( "O_Massh0_npf", 126.0 );
  massh.AddExpUnc( 2.0 );
  massh.AddTheoUnc( 3.0 );
  calc.AddObservable( massh );

  LHCCalculator* lhc = new LHCCalculator(LHCCalculator::paper2012);
  calc.SetLHCCalculator(lhc);

  AstroCalculator* astro = new AstroCalculator("100d");
  calc.SetAstroCalculator(astro);

  return calc;

}

Chi2Calculator Chi2CalculatorDataBase2012::GetChi2Calculator(std::string name){

  Chi2Calculator calc = GetPaper2012_LHCmh();
  
  if ( name == "paper2012_LHCmh" ) {
    
  }
  else {

    throw std::runtime_error("Obs set not known in 2012");

  }

  return calc;

}



//   Observable massh_ll( "O_massh0", 114.5); 
//   massh_ll.SetIsLowerLimit(true, true);
//   calc.AddObservable( massh_ll);

//   Observable massh_ul( "O_massh0", 130.5 );
//   massh_ul.SetIsUpperLimit(true, true);
//   calc.AddObservable( massh_ul);



//   HiggsCalculator* higgs = calc.GetHiggsCalculator(); 
//   higgs = new HiggsCalculator("inclusive");


//   Observable massTop( "O_massTop", 173.2);
//   massTop.AddExpUnc( 1.34 );
//   calc.AddObservable( massTop );

  
//   calc.SetUseHiggsBounds( false );
//   calc.SetUseHiggsSignals( false );  

//   calc.SetUseAstroFit( true );

//   calc.SetMaxChi2(-1);

//   calc.SetName("paper2012_LEO");

