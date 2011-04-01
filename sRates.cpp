#include "sRates.h"


 int d2i(double d) { 
    return int(d<0?d-.5:d+.5); 
  }


//Get the bin number of the lepton pt_cut with lepton energy closest to the requested energy. This is a seperate function. not method of any class.
int bin_closest_to_energy(double E) {
	
  double to_be_returned = 0;
  int  intE = d2i(E);
	
  if (intE % e_distribution_bin_width == 0){
		
    to_be_returned = (int)((intE/e_distribution_bin_width)-1); 
		
  } else if (intE % e_distribution_bin_width <= e_distribution_bin_width/2. ) {
		
    to_be_returned =  (int)((intE - intE % e_distribution_bin_width)/e_distribution_bin_width-1) ;
		
  } else if (intE % e_distribution_bin_width > e_distribution_bin_width/2. ){
		
    to_be_returned =  (int)((intE + intE % e_distribution_bin_width)/e_distribution_bin_width-1);
	
  } 
			
  //check that we don't have negative values. if so just set to zero.
	
  // 	std::cout << " X " << to_be_returned << std::endl;
	
  if (to_be_returned < 0){
    to_be_returned = 0;
		
  }

  return (int) to_be_returned;
}

//triangular near lepton distribution (normalized for a certain number of bins)	
//for type 1: for q_L -> l_R or q_R -> l_L (different)	type 2: q_L -> l_L or q_R -> l_R (same)
double near_lepton_distribution(double ENmin, double ENmax, double x, int type ,int getnorm =0){
	
  double normalization = 1;
  
  if (getnorm == 0) {
    
    double new_normalzation = 0;
    
    for (int E = (int)((bin_closest_to_energy(ENmin)+1)*e_distribution_bin_width); E <= (int)((bin_closest_to_energy(ENmax)+1)*e_distribution_bin_width); E+=e_distribution_bin_width){
			
      new_normalzation += near_lepton_distribution(ENmin,ENmax,E,type,1);
		
    }
	
    normalization = new_normalzation;
		
  }
	
  if (x < ENmin || x > ENmax) {
		
    return 0;
		
  } else {
		
		
    if (type == 1) {
		
      return (2.*(x - ENmin)/pow((ENmax-ENmin),2))/normalization;
	
    } else if (type == 2) {
						
      return (2.*(ENmax - x)/pow((ENmax-ENmin),2))/normalization;
			
    } else {
			
      return 0;
    }
  }
		
		
}




//flat + squared far lepton distribution (normalized for a certain number of bins)	for type 1: for q_L -> l_R or q_R -> l_L (opp)	type 2: q_L -> l_L or q_R -> l_R (same)
//from mathematica notepad
// opposite
// ==============
// (Enmax^2/2 - Enmax Enmin + Enmin^2/2) UnitStep[-Et + Ethk] UnitStep[Et - Etlk] 
// 		+ (EN^2/2 - EN Enmin + Enmin^2/2 - (EN Et ml)/(2 Etl) + (Enmin Et ml)/(2 Etl) - (EN Etl ml)/(2 Et) + (Enmin Etl ml)/(2 Et) + ml^2/4 + (Et^2 ml^2)/(8 Etl^2) + (Etl^2 ml^2)/(8 Et^2)) UnitStep[Et - Ethk] UnitStep[-Et + Etmax] 
// 		+ (EN^2/2 - EN Enmin + Enmin^2/2 - (EN Et ml)/(2 Etl) + (Enmin Et ml)/(2 Etl) - (EN Etl ml)/(2 Et) + (Enmin Etl ml)/(2 Et) + ml^2/4 + (Et^2 ml^2)/(8 Etl^2) + (Etl^2 ml^2)/(8 Et^2)) UnitStep[-Et + Etlk] UnitStep[Et - Etmin]
// 
// 	
// same
// ========
// 		(Enmax^2/2 - Enmax Enmin + Enmin^2/2) UnitStep[-Et + Ethk] UnitStep[Et - Etlk] 
// 		+ (-(EN^2/2) + EN Enmax - Enmax Enmin + Enmin^2/2 + (EN Et ml)/(2 Etl) - (Enmax Et ml)/(2 Etl) + (EN Etl ml)/(2 Et) - (  Enmax Etl ml)/(2 Et) - ml^2/4 - (Et^2 ml^2)/(8 Etl^2) - (Etl^2 ml^2)/(8 Et^2)) UnitStep[Et - Ethk] UnitStep[-Et + Etmax] 
// 		+ (-(EN^2/2) + EN Enmax - Enmax Enmin + Enmin^2/2 + (EN Et ml)/(2 Etl) - (Enmax Et ml)/(2 Etl) + (EN Etl ml)/(2 Et) - (Enmax Etl ml)/(2 Et) - ml^2/4 - (Et^2 ml^2)/(8 Etl^2) - (Etl^2 ml^2)/(8 Et^2)) UnitStep[-Et + Etlk] UnitStep[Et - Etmin]
//
 		
double far_lepton_distribution(double EFmin, double EFmax, double EFlkink, double EFhkink, double ENmin, double ENmax, double EN, double EFl, double ml, double x, int type ,int getnorm =0){
	
	
  double normalization = 1;
	
  if (getnorm == 0) {
	
    double new_normalzation = 0;
		
    for (int E = (int)((bin_closest_to_energy(EFmin)+1)*e_distribution_bin_width); E <= EFmax; E+=e_distribution_bin_width){
			
      new_normalzation += far_lepton_distribution(EFmin, EFmax, EFlkink, EFhkink, ENmin, ENmax, EN, EFl, ml, E,type,1);
		
						
    }
	
    normalization = new_normalzation;
		
    // 		std::cout << normalization << std::endl;		
  }
		
	
  if (x < EFmin || x > EFmax) {
		
    return 0;
		
  } else if (x >= EFmin && x <= EFlkink){
		
    if (type == 1) {
		
      return (EN*EN/2. - EN*ENmin + ENmin*ENmin/2. - (EN*x*ml)/(2.*EFl) + (ENmin*x*ml)/(2.*EFl) - (EN*EFl*ml)/(2.*x) + (ENmin*EFl*ml)/(2.*x) + ml*ml/4. + (x*x*ml*ml)/(8.*EFl*EFl) + (EFl*EFl*ml*ml)/(8.*x*x))/normalization;
			
    } else if (type == 2) {
			
      return (-(EN*EN/2) + EN*ENmax - ENmax*ENmin + ENmin*ENmin/2. + (EN*x*ml)/(2.*EFl) - (ENmax*x*ml)/(2.*EFl) + (EN*EFl*ml)/(2.*x) - (ENmax*EFl*ml)/(2.*x) - ml*ml/4. - (x*x* ml*ml)/(8.*EFl*EFl) - (EFl*EFl*ml*ml)/(8.*x*x))/normalization;
		
    } else {
			
      return 0;
    }
	
  } else if (x >= EFlkink && x <= EFhkink){
		
    return (ENmax*ENmax/2. - ENmax*ENmin + ENmin*ENmin/2.)/normalization;
		
  } else if (x >= EFhkink && x <= EFmax){
		
    if (type == 1) {
		
      return (EN*EN/2. - EN*ENmin + ENmin*ENmin/2. - (EN*x*ml)/(2.*EFl) + (ENmin*x*ml)/(2.*EFl) - (EN*EFl*ml)/(2.*x) + (ENmin*EFl*ml)/(2.*x) + ml*ml/4. + (x*x*ml*ml)/(8.*EFl*EFl) + (EFl*EFl * ml*ml)/(8.*x*x))/normalization;
			
    } else if (type == 2) {
			
      return (-(EN*EN/2.) + EN*ENmax - ENmax*ENmin + ENmin*ENmin/2. + (EN*x*ml)/(2.*EFl) - (ENmax*x*ml)/(2.*EFl) + (EN*EFl*ml)/(2.*x) - (ENmax*EFl*ml)/(2.*x) - ml*ml/4. - (x*x*ml*ml)/(8.*EFl*EFl) - (EFl*EFl * ml*ml)/(8.*x*x))/normalization;
		
    } else {
			
      return 0;
    }
		
  } else {
		
    return 0.;
		
  }
			  
		
}


		
		





double sRates::near_lepton_pt_cut(double msquark,double mslepton,int process, int type){
	
  // 	std::cout << mslepton << std::endl;
	
  double pt_cut = 0; //to be returned
	
  double M_n2 = mneutralino2;
	
  // 	double M_n2 = 152.8;
	
  double ENmin = 1./(2.*msquark)*(pow(M_n2,2.) - pow(mslepton,2.))  ;
  double ENmax = msquark/2.*(1.-pow(mslepton,2)/pow(M_n2,2));
	
  // 	double ENmin = 0 ;
  // 	double ENmax = 100;
	
  // 	std::cout << ENmin << std::endl;
  // 	std::cout << ENmax << std::endl;

	
  //Load leptons into array. 					<-- I should directly access the grids to save time/memory. change at some point.
  std::vector<double> energy_grid;
  energy_grid.resize(e_distribution_bins);
	
  for (int i = 0 ; i < e_distribution_bins ; i++){
		
		
    if (process == 1){
		
      energy_grid[i] = this->ss_lepton_grids_pt[i]->value( msquark, mgluino);
		
    } else if (process == 2) {
			
      energy_grid[i] = this->gg_lepton_grids_pt[i]->value( msquark, mgluino);
			
    } else {
			
      std::cout << "Error. Leptons not available!" << std::endl;
			
    }
		
  }
				

	
  for (int E = (int)((bin_closest_to_energy(ENmin)+1)*e_distribution_bin_width); E <= (int)((bin_closest_to_energy(ENmax)+1)*e_distribution_bin_width); E+=e_distribution_bin_width){
			
    double pt_cut_E = 0;
		 
    if ( E <= e_distribution_bin_width*e_distribution_bins ){
			
      pt_cut_E = energy_grid[bin_closest_to_energy(E)];
		     
			
    } //if lepton energy bigger then biggest value we have in grid -> convolute with maximal value we have. Should be ~1.
    else if (E > e_distribution_bin_width*e_distribution_bins){
			
      pt_cut_E = energy_grid[bin_closest_to_energy(e_distribution_bin_width*e_distribution_bins)];
						
    }
		
	
    //weight pt_cuts by energy distribution
    pt_cut += near_lepton_distribution(ENmin,ENmax,E,type) * pt_cut_E;
	
	
    // 	std::cout << E << " " << near_lepton_distribution(ENmin,ENmax,E,type) << " " << pt_cut << " " << ENmin << " " << ENmax << " " << process << " " << mslepton << " " << type << std::endl;
  }
	
		
  //test-output
  // 	for (int E = (int)((bin_closest_to_energy(1)+1)*e_distribution_bin_width); E <= (int)((bin_closest_to_energy(100)+1)*e_distribution_bin_width); E+=e_distribution_bin_width){
  // 			
  // 		double pt_cut_E = 0;
  // 		 
  // 		if ( E <= e_distribution_bin_width*e_distribution_bins ){
  // 			
  // 			pt_cut_E = energy_grid[bin_closest_to_energy(E)];
  // 		     
  // 			
  // 		} //if lepton energy bigger then biggest value we have in grid -> convolute with maximal value we have. Should be ~1.
  // 		else if (E > e_distribution_bin_width*e_distribution_bins){
  // 			
  // 			pt_cut_E = energy_grid[bin_closest_to_energy(e_distribution_bin_width*e_distribution_bins)];
  // 						
  // 		}
  // 		
  // 	
  // 		//weight pt_cuts by energy distribution
  // 		pt_cut += near_lepton_distribution(ENmin,ENmax,E,type) * pt_cut_E;
  // 	
  // 	
  // 		std::cout << E << " " << near_lepton_distribution(ENmin,ENmax,E,type) << " " << pt_cut << " " << pt_cut_E << " " << process << " " << type << std::endl;
  // 	}
  //End Test
	
	
	
  return pt_cut;
}





double sRates::far_lepton_pt_cut(double msquark,double mslepton, int process, int type){
	
  double pt_cut = 0; //to be returned
	
  double M_n1 = mneutralino1;
  double M_n2 = mneutralino2;
	
  // 	M_n2 = 152.8;
  // 	MslR = 142.8 ;
  // 	M_n1 = 50;
	
  double EFmax = msquark/2.*(1.-pow(M_n1,2)/pow(mslepton,2));
  double EFmin = 1./(2.*msquark)*(pow(mslepton,2.) - pow(M_n1,2.))  ;
  double EFlkink = ( ( ( M_n2 * M_n2 ) / ( 2 * msquark * mslepton * mslepton ) ) * ( mslepton * mslepton - M_n1 * M_n1 ) );
  double EFhkink = ( ( msquark / ( 2 * M_n2 * M_n2 ) ) * ( mslepton * mslepton - M_n1 * M_n1 ) );
  double ENmin = 1./(2.*msquark)*(pow(M_n2,2.) - pow(mslepton,2.))  ;
  double ENmax = msquark/2.*(1.-pow(mslepton,2)/pow(M_n2,2));
  double EN = ( ( msquark * msquark + M_n2* M_n2 ) / ( 2. * msquark ) );
  double EFl = ( ( mslepton * mslepton - M_n1 * M_n1 ) / ( 2. * mslepton ) );
	
  // 	std::cout << "ENmin " << ENmin << std::endl;
  // 	std::cout << "ENmax " << ENmax << std::endl;
  // 	std::cout << "EFmax " << EFmax << std::endl;
  // 	std::cout << "EFmin " << EFmin << std::endl;
  // 	std::cout << "EFdrop " << EFdrop << std::endl;
	


	
  //Load leptons into array. 					<-- I should directly access the grids to save time/memory. change at some point.
  double energy_grid[e_distribution_bins];
	
  for (int i = 0 ; i < e_distribution_bins ; i++){
		
    if (process == 1){
		
      energy_grid[i] = this->ss_lepton_grids_pt[i]->value( msquark, this->m_gluino());
		
    } else if (process == 2){
			
      energy_grid[i] = this->gg_lepton_grids_pt[i]->value( msquark, this->m_gluino());
			
    } else {
			
      std::cout << "Error. Leptons not available!" << std::endl;
			
    }
	
  }
	
	
	
  for (int E = (int)((bin_closest_to_energy(EFmin)+1)*e_distribution_bin_width); E <= EFmax; E+=e_distribution_bin_width){
			
    double pt_cut_E = 0;
		 
    // 		std::cout << "X " << E << std::endl;
		
    if ( E <= e_distribution_bin_width*e_distribution_bins ){
			
      pt_cut_E = energy_grid[bin_closest_to_energy(E)];
		     
			
    } //if lepton energy bigger then biggest value we have in grid -> convolute with maximal value we have. Should be ~1.
    else if (E > e_distribution_bin_width*e_distribution_bins){
			
      pt_cut_E = energy_grid[bin_closest_to_energy(e_distribution_bin_width*e_distribution_bins)];
						
    }
		
	
    //weight pt_cuts by energy distribution
    pt_cut += far_lepton_distribution(EFmin, EFmax, EFlkink, EFhkink, ENmin, ENmax, EN, EFl, mslepton, E,type) * pt_cut_E;
		
		
  }
		

	
  return pt_cut;
}



double sRates::Two_OSSF_leptons(){
	
	
  //Make sure spectrum and cross section grids are loaded
  if  (spectrum_loaded == 0 || grids_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  } //check availability of acceptances and xsection
  else if ( this->information_available_ossf() != 1 ){
    std::cout << "No ossf x-section x BR information available for this point!" <<std::endl;
    return -2;
  } 
	
	
  return this->Two_OSSF_leptons_cuts(1);
}




double sRates::Two_OSSF_leptons_cuts(int nocuts){
	
  double rate = 0;	//to be returned
	
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0 || lepton_grids_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  } //check availability of acceptances and xsection
  else if ( this->information_available_ossf() != 1 ){
    std::cout << "No ossf x-section x BR information available for this point!" <<std::endl;
    return -2;
  } 
	
  //some lists we need
  std::list< int > lepton;
  lepton.push_back(PDG_electron_CODE);
	
  std::list< int > slepton_R;
  slepton_R.push_back(PDG_selectron_R_CODE);
	
  std::list< int > slepton_L;
  slepton_L.push_back(PDG_selectron_L_CODE);
	
  std::list< int > sup_L;
  sup_L.push_back(PDG_sup_L_CODE);
	
  std::list< int > sdown_L;
  sdown_L.push_back(PDG_sdown_L_CODE);
	
  std::list< int > neu2;
  neu2.push_back(PDG_neutralino_two_CODE);
	
  std::list< int > sb1;
  sb1.push_back(PDG_sbottom_one_CODE);
  std::list< int > sb2;
  sb2.push_back(PDG_sbottom_two_CODE);
  std::list< int > st1;
  st1.push_back(PDG_stop_one_CODE);
  std::list< int > st2;
  st2.push_back(PDG_stop_two_CODE);
	
  //as we are already there lets get the correspong third generation mixing angles;
  double sbotmix_cos = SBOTMIX_cos;
  double sbotmix_sin = sqrt(1.-pow(SBOTMIX_cos,2));
  double stopmix_cos = STOPMIX_cos;
  double stopmix_sin = sqrt(1.-pow(SBOTMIX_cos,2));
	

  // 	double sbotmix_cos = 0.0;
  // 	double sbotmix_sin = 0.0;
  // 	double stopmix_cos = 0.0;
  // 	double stopmix_sin = 0.0;
	

	
  //calculate BRs
  ////////////////
	
  // slepton -> lepton chi1
  double BR_slepton_lepton_R = spectrum->get_particle_property_set(PDG_selectron_R_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&lepton);
  double BR_slepton_lepton_L = spectrum->get_particle_property_set(PDG_selectron_L_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&lepton);
	
  // chi2^0 -> slepton lepton
  double BR_chi2_slepton_R = 4.*spectrum->get_particle_property_set(PDG_neutralino_two_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&slepton_R); //4: charge + flavour
  double BR_chi2_slepton_L = 4.*spectrum->get_particle_property_set(PDG_neutralino_two_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&slepton_L); //4: charge + flavour
	
	
  // squark_L -> chi2 jet (averaged)
  double BR_squark_L_chi2 = 0;
  std::vector< int > PDG_left_squarks;
  PDG_left_squarks.push_back(1000001);
  PDG_left_squarks.push_back(1000002);
  PDG_left_squarks.push_back(1000003);
  PDG_left_squarks.push_back(1000004);
  // 	PDG_left_squarks.push_back(1000005);
	
  for (int i=0 ; i < int(PDG_left_squarks.size()); i++){
		
    BR_squark_L_chi2 += spectrum->get_particle_property_set(PDG_left_squarks[i])->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);
		
  }
  BR_squark_L_chi2 = BR_squark_L_chi2/PDG_left_squarks.size();
	
	
  // squark_R -> chi2 jet (averaged)
  double BR_squark_R_chi2 = 0;
  std::vector< int > PDG_right_squarks;
  PDG_right_squarks.push_back(2000001);
  PDG_right_squarks.push_back(2000002);
  PDG_right_squarks.push_back(2000003);
  PDG_right_squarks.push_back(2000004);
  // 	PDG_left_squarks.push_back(1000005);
	
  for (int i=0 ; i < int(PDG_left_squarks.size()); i++){
		
    BR_squark_R_chi2 += spectrum->get_particle_property_set(PDG_right_squarks[i])->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);
		
  }
  BR_squark_R_chi2 = BR_squark_R_chi2/PDG_left_squarks.size();
	
	
  //sbotton1/2, stop1/stop2 -> chi2 jet
  double BR_sbotton1_chi2 = spectrum->get_particle_property_set(PDG_sbottom_one_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);
  double BR_sbotton2_chi2 = spectrum->get_particle_property_set(PDG_sbottom_two_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);
  double BR_stop1_chi2 = spectrum->get_particle_property_set(PDG_stop_one_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);
  double BR_stop2_chi2 = spectrum->get_particle_property_set(PDG_stop_two_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&neu2);

	
	
  //put BRs for squarks together 	for slepton_R
  double BR_squark_L_ossf_R = BR_squark_L_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;
  double BR_squark_R_ossf_R = BR_squark_R_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;
  double BR_sbotton1_ossf_R = BR_sbotton1_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;
  double BR_sbotton2_ossf_R = BR_sbotton2_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;
  double BR_stop1_ossf_R = BR_stop1_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;
  double BR_stop2_ossf_R = BR_stop2_chi2*BR_chi2_slepton_R*BR_slepton_lepton_R;

	
  //put BRs for squarks together 	for slepton_L
  double BR_squark_L_ossf_L = BR_squark_L_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
  double BR_squark_R_ossf_L = BR_squark_R_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
  double BR_sbotton1_ossf_L = BR_sbotton1_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
  double BR_sbotton2_ossf_L = BR_sbotton2_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
  double BR_stop1_ossf_L = BR_stop1_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
  double BR_stop2_ossf_L = BR_stop2_chi2*BR_chi2_slepton_L*BR_slepton_lepton_L;
	
	
  // 	std::cout << BR_squark_L_ossf_L << " " << BR_squark_R_ossf_L << " " << BR_sbotton1_ossf_L << " " << BR_sbotton2_ossf_L << " " << BR_stop1_ossf_L << " " << BR_stop2_ossf_L << std::endl;
	
	
  // gluino -> squark_L jet (summed)		( gluino -> squark_R decay chains are neglected )
  double BR_gluino_ossf = 0;
  double BR_gluino_ossf_R = 0;
  double BR_gluino_ossf_L = 0;
	
  BR_gluino_ossf += 4.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sup_L);	//4: charge + flavour up-type
  BR_gluino_ossf += 4.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sdown_L);	//4: charge + flavour down-type
  BR_gluino_ossf_R = BR_gluino_ossf*BR_squark_L_ossf_R;
  BR_gluino_ossf_L = BR_gluino_ossf*BR_squark_L_ossf_L;
	

  // gluino -> sbotton12/stop12 -> chi20
  double BR_gluino_ossf_sbotton1_R = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sb1)*BR_sbotton1_ossf_R; //2: charge
  double BR_gluino_ossf_sbotton2_R = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sb2)*BR_sbotton2_ossf_R; //2: charge
  double BR_gluino_ossf_stop1_R = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&st1)*BR_stop1_ossf_R; //2: charge
  double BR_gluino_ossf_stop2_R = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&st2)*BR_stop2_ossf_R; //2: charge
  double BR_gluino_ossf_sbotton1_L = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sb1)*BR_sbotton1_ossf_L; //2: charge
  double BR_gluino_ossf_sbotton2_L = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&sb2)*BR_sbotton2_ossf_L; //2: charge
  double BR_gluino_ossf_stop1_L = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&st1)*BR_stop1_ossf_L; //2: charge
  double BR_gluino_ossf_stop2_L = 2.*spectrum->get_particle_property_set(PDG_gluino_CODE)->get_direct_decay_handler()->get_branching_ratio_for_subset(&st2)*BR_stop2_ossf_L; //2: charge
	

  //Test-Output BR

  // 	std::cout << "BR. LR: " << BR_squark_L_ossf_R << "\t RR:" << BR_squark_R_ossf_R << "\t LL:" << BR_squark_L_ossf_L << "\t RL:" << BR_squark_R_ossf_L << std::endl;	
	
	
  //calculate jet+missingET cuts
  double AC_jet12_missing_ET_ss_L = ss_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_L, mgluino, mneutralino1);
				
  double AC_jet12_missing_ET_ss_R = ss_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_R, mgluino, mneutralino1);
	
  double AC_jet12_missing_ET_ss_av = ss_AC_grid_j1_pt->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_av, mgluino, mneutralino1);
	
  double AC_jet12_missing_ET_sg_L = sg_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j1_eta->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j2_pt->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j2_eta->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_ETmiss->value(msquark_L, mgluino, mneutralino1);
				
  double AC_jet12_missing_ET_sg_R = sg_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j1_eta->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j2_pt->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j2_eta->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_ETmiss->value(msquark_R, mgluino, mneutralino1);
				
  double AC_jet12_missing_ET_gg =	gg_AC_grid_j1_pt->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j1_eta->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j2_pt->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j2_eta->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_ETmiss->value(msquark_av, mgluino, mneutralino1);		
	
  double AC_jet12_missing_ET_ss_sbotton1 = ss_AC_grid_j1_pt->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msbotton1, mgluino, mneutralino1);
	
  double AC_jet12_missing_ET_ss_sbotton2 = ss_AC_grid_j1_pt->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msbotton2, mgluino, mneutralino1);
	
  double AC_jet12_missing_ET_ss_stop1 = ss_AC_grid_j1_pt->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(mstop1, mgluino, mneutralino1);
	
  double AC_jet12_missing_ET_ss_stop2 = ss_AC_grid_j1_pt->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(mstop2, mgluino, mneutralino1);
	
	
	
  //calculate lepton cuts
  double ss_eta_from_squark_L_cut = this->ss_lepton_grid_eta->value(msquark_L,mgluino);
  double ss_eta_from_squark_R_cut = this->ss_lepton_grid_eta->value(msquark_R,mgluino);
  double gg_eta_from_squark_L_cut = this->gg_lepton_grid_eta->value(msquark_L,mgluino);
  double gg_eta_from_squark_R_cut = this->gg_lepton_grid_eta->value(msquark_R,mgluino);
  double ss_eta_from_sbotton1_cut = this->ss_lepton_grid_eta->value(msbotton1,mgluino);
  double ss_eta_from_sbotton2_cut = this->ss_lepton_grid_eta->value(msbotton2,mgluino);
  double ss_eta_from_stop1_cut = this->ss_lepton_grid_eta->value(mstop1,mgluino);
  double ss_eta_from_stop2_cut = this->ss_lepton_grid_eta->value(mstop2,mgluino);
  double gg_eta_from_sbotton1_cut = this->gg_lepton_grid_eta->value(msbotton1,mgluino);
  double gg_eta_from_sbotton2_cut = this->gg_lepton_grid_eta->value(msbotton2,mgluino);
  double gg_eta_from_stop1_cut = this->gg_lepton_grid_eta->value(mstop1,mgluino);
  double gg_eta_from_stop2_cut = this->gg_lepton_grid_eta->value(mstop2,mgluino);
	

  //syntax: pt_cut(msquark, mslepton, 1:near/2:far, 1:different chirality/2:same chirality)
  double ss_pt_near_from_squark_L_cut_R = this->near_lepton_pt_cut(msquark_L,msleptonR,1,1);
  double ss_pt_near_from_squark_R_cut_R = this->near_lepton_pt_cut(msquark_R,msleptonR,1,2);
  double ss_pt_far_from_squark_L_cut_R = this->far_lepton_pt_cut(msquark_L,msleptonR,1,1);
  double ss_pt_far_from_squark_R_cut_R = this->far_lepton_pt_cut(msquark_R,msleptonR,1,2);
  double gg_pt_near_from_squark_L_cut_R = this->near_lepton_pt_cut(msquark_L,msleptonR,2,1);
  double gg_pt_near_from_squark_R_cut_R = this->near_lepton_pt_cut(msquark_R,msleptonR,2,2);
  double gg_pt_far_from_squark_L_cut_R = this->far_lepton_pt_cut(msquark_L,msleptonR,2,1);
  double gg_pt_far_from_squark_R_cut_R = this->far_lepton_pt_cut(msquark_R,msleptonR,2,2);

  double ss_pt_near_from_squark_L_cut_L = this->near_lepton_pt_cut(msquark_L,msleptonL,1,2);
  double ss_pt_near_from_squark_R_cut_L = this->near_lepton_pt_cut(msquark_R,msleptonL,1,1);
  double ss_pt_far_from_squark_L_cut_L = this->far_lepton_pt_cut(msquark_L,msleptonL,1,2);
  double ss_pt_far_from_squark_R_cut_L = this->far_lepton_pt_cut(msquark_R,msleptonL,1,1);
  double gg_pt_near_from_squark_L_cut_L = this->near_lepton_pt_cut(msquark_L,msleptonL,2,2);
  double gg_pt_near_from_squark_R_cut_L = this->near_lepton_pt_cut(msquark_R,msleptonL,2,1);
  double gg_pt_far_from_squark_L_cut_L = this->far_lepton_pt_cut(msquark_L,msleptonL,2,2);
  double gg_pt_far_from_squark_R_cut_L = this->far_lepton_pt_cut(msquark_R,msleptonL,2,1);

  //sbotton_1_R/L	
  double ss_pt_near_from_sbotton1R_cut_R = this->near_lepton_pt_cut(msbotton1,msleptonR,1,2);
  double ss_pt_far_from_sbotton1R_cut_R = this->far_lepton_pt_cut(msbotton1,msleptonR,1,2);
  double ss_pt_near_from_sbotton1R_cut_L = this->near_lepton_pt_cut(msbotton1,msleptonL,1,1);
  double ss_pt_far_from_sbotton1R_cut_L = this->far_lepton_pt_cut(msbotton1,msleptonL,1,1);
  double ss_pt_near_from_sbotton1L_cut_R = this->near_lepton_pt_cut(msbotton1,msleptonR,1,1);
  double ss_pt_far_from_sbotton1L_cut_R = this->far_lepton_pt_cut(msbotton1,msleptonR,1,1);
  double ss_pt_near_from_sbotton1L_cut_L = this->near_lepton_pt_cut(msbotton1,msleptonL,1,2);
  double ss_pt_far_from_sbotton1L_cut_L = this->far_lepton_pt_cut(msbotton1,msleptonL,1,2);
  double gg_pt_near_from_sbotton1R_cut_R = this->near_lepton_pt_cut(msbotton1,msleptonR,2,2);
  double gg_pt_far_from_sbotton1R_cut_R = this->far_lepton_pt_cut(msbotton1,msleptonR,2,2);
  double gg_pt_near_from_sbotton1R_cut_L = this->near_lepton_pt_cut(msbotton1,msleptonL,2,1);
  double gg_pt_far_from_sbotton1R_cut_L = this->far_lepton_pt_cut(msbotton1,msleptonL,2,1);
  double gg_pt_near_from_sbotton1L_cut_R = this->near_lepton_pt_cut(msbotton1,msleptonR,2,1);
  double gg_pt_far_from_sbotton1L_cut_R = this->far_lepton_pt_cut(msbotton1,msleptonR,2,1);
  double gg_pt_near_from_sbotton1L_cut_L = this->near_lepton_pt_cut(msbotton1,msleptonL,2,2);
  double gg_pt_far_from_sbotton1L_cut_L = this->far_lepton_pt_cut(msbotton1,msleptonL,2,2);
	
  //sbotton_2_R/L	
  double ss_pt_near_from_sbotton2R_cut_R = this->near_lepton_pt_cut(msbotton2,msleptonR,1,2);
  double ss_pt_far_from_sbotton2R_cut_R = this->far_lepton_pt_cut(msbotton2,msleptonR,1,2);
  double ss_pt_near_from_sbotton2R_cut_L = this->near_lepton_pt_cut(msbotton2,msleptonL,1,1);
  double ss_pt_far_from_sbotton2R_cut_L = this->far_lepton_pt_cut(msbotton2,msleptonL,1,1);
  double ss_pt_near_from_sbotton2L_cut_R = this->near_lepton_pt_cut(msbotton2,msleptonR,1,1);
  double ss_pt_far_from_sbotton2L_cut_R = this->far_lepton_pt_cut(msbotton2,msleptonR,1,1);
  double ss_pt_near_from_sbotton2L_cut_L = this->near_lepton_pt_cut(msbotton2,msleptonL,1,2);
  double ss_pt_far_from_sbotton2L_cut_L = this->far_lepton_pt_cut(msbotton2,msleptonL,1,2);
  double gg_pt_near_from_sbotton2R_cut_R = this->near_lepton_pt_cut(msbotton2,msleptonR,2,2);
  double gg_pt_far_from_sbotton2R_cut_R = this->far_lepton_pt_cut(msbotton2,msleptonR,2,2);
  double gg_pt_near_from_sbotton2R_cut_L = this->near_lepton_pt_cut(msbotton2,msleptonL,2,1);
  double gg_pt_far_from_sbotton2R_cut_L = this->far_lepton_pt_cut(msbotton2,msleptonL,2,1);
  double gg_pt_near_from_sbotton2L_cut_R = this->near_lepton_pt_cut(msbotton2,msleptonR,2,1);
  double gg_pt_far_from_sbotton2L_cut_R = this->far_lepton_pt_cut(msbotton2,msleptonR,2,1);
  double gg_pt_near_from_sbotton2L_cut_L = this->near_lepton_pt_cut(msbotton2,msleptonL,2,2);
  double gg_pt_far_from_sbotton2L_cut_L = this->far_lepton_pt_cut(msbotton2,msleptonL,2,2);
	
  //stop_1_R/L	
  double ss_pt_near_from_stop1R_cut_R = this->near_lepton_pt_cut(mstop1,msleptonR,1,2);
  double ss_pt_far_from_stop1R_cut_R = this->far_lepton_pt_cut(mstop1,msleptonR,1,2);
  double ss_pt_near_from_stop1R_cut_L = this->near_lepton_pt_cut(mstop1,msleptonL,1,1);
  double ss_pt_far_from_stop1R_cut_L = this->far_lepton_pt_cut(mstop1,msleptonL,1,1);
  double ss_pt_near_from_stop1L_cut_R = this->near_lepton_pt_cut(mstop1,msleptonR,1,1);
  double ss_pt_far_from_stop1L_cut_R = this->far_lepton_pt_cut(mstop1,msleptonR,1,1);
  double ss_pt_near_from_stop1L_cut_L = this->near_lepton_pt_cut(mstop1,msleptonL,1,2);
  double ss_pt_far_from_stop1L_cut_L = this->far_lepton_pt_cut(mstop1,msleptonL,1,2);
  double gg_pt_near_from_stop1R_cut_R = this->near_lepton_pt_cut(mstop1,msleptonR,2,2);
  double gg_pt_far_from_stop1R_cut_R = this->far_lepton_pt_cut(mstop1,msleptonR,2,2);
  double gg_pt_near_from_stop1R_cut_L = this->near_lepton_pt_cut(mstop1,msleptonL,2,1);
  double gg_pt_far_from_stop1R_cut_L = this->far_lepton_pt_cut(mstop1,msleptonL,2,1);
  double gg_pt_near_from_stop1L_cut_R = this->near_lepton_pt_cut(mstop1,msleptonR,2,1);
  double gg_pt_far_from_stop1L_cut_R = this->far_lepton_pt_cut(mstop1,msleptonR,2,1);
  double gg_pt_near_from_stop1L_cut_L = this->near_lepton_pt_cut(mstop1,msleptonL,2,2);
  double gg_pt_far_from_stop1L_cut_L = this->far_lepton_pt_cut(mstop1,msleptonL,2,2);
	
  //stop_2_R/L	
  double ss_pt_near_from_stop2R_cut_R = this->near_lepton_pt_cut(mstop2,msleptonR,1,2);
  double ss_pt_far_from_stop2R_cut_R = this->far_lepton_pt_cut(mstop2,msleptonR,1,2);
  double ss_pt_near_from_stop2R_cut_L = this->near_lepton_pt_cut(mstop2,msleptonL,1,1);
  double ss_pt_far_from_stop2R_cut_L = this->far_lepton_pt_cut(mstop2,msleptonL,1,1);
  double ss_pt_near_from_stop2L_cut_R = this->near_lepton_pt_cut(mstop2,msleptonR,1,1);
  double ss_pt_far_from_stop2L_cut_R = this->far_lepton_pt_cut(mstop2,msleptonR,1,1);
  double ss_pt_near_from_stop2L_cut_L = this->near_lepton_pt_cut(mstop2,msleptonL,1,2);
  double ss_pt_far_from_stop2L_cut_L = this->far_lepton_pt_cut(mstop2,msleptonL,1,2);
  double gg_pt_near_from_stop2R_cut_R = this->near_lepton_pt_cut(mstop2,msleptonR,2,2);
  double gg_pt_far_from_stop2R_cut_R = this->far_lepton_pt_cut(mstop2,msleptonR,2,2);
  double gg_pt_near_from_stop2R_cut_L = this->near_lepton_pt_cut(mstop2,msleptonL,2,1);
  double gg_pt_far_from_stop2R_cut_L = this->far_lepton_pt_cut(mstop2,msleptonL,2,1);
  double gg_pt_near_from_stop2L_cut_R = this->near_lepton_pt_cut(mstop2,msleptonR,2,1);
  double gg_pt_far_from_stop2L_cut_R = this->far_lepton_pt_cut(mstop2,msleptonR,2,1);
  double gg_pt_near_from_stop2L_cut_L = this->near_lepton_pt_cut(mstop2,msleptonL,2,2);
  double gg_pt_far_from_stop2L_cut_L = this->far_lepton_pt_cut(mstop2,msleptonL,2,2);

	
  //set all unwanted accepatncies to 1. we do it this way because no cuts shouldn't be the standard call.		<-- this should be done differently
  if (nocuts == 1){ //no cuts at all
    AC_jet12_missing_ET_ss_L = 1.;
    AC_jet12_missing_ET_ss_R = 1.;
    AC_jet12_missing_ET_ss_av = 1.;
    AC_jet12_missing_ET_sg_L = 1.;
    AC_jet12_missing_ET_sg_R = 1.;
    AC_jet12_missing_ET_gg = 1.;
    AC_jet12_missing_ET_ss_sbotton1 = 1.;
    AC_jet12_missing_ET_ss_sbotton2 = 1.;
    AC_jet12_missing_ET_ss_stop1 = 1.;
    AC_jet12_missing_ET_ss_stop2 = 1.;
    ss_eta_from_squark_L_cut = 1.;
    ss_eta_from_squark_R_cut = 1.;
    gg_eta_from_squark_L_cut = 1.;
    gg_eta_from_squark_R_cut = 1.;
    ss_eta_from_sbotton1_cut = 1.;
    ss_eta_from_sbotton2_cut = 1.;
    ss_eta_from_stop1_cut = 1.;
    ss_eta_from_stop2_cut = 1.;
    gg_eta_from_sbotton1_cut = 1.;
    gg_eta_from_sbotton2_cut = 1.;
    gg_eta_from_stop1_cut = 1.;
    gg_eta_from_stop2_cut = 1.;
    ss_pt_near_from_squark_L_cut_R = 1.;
    ss_pt_near_from_squark_R_cut_R = 1.;
    ss_pt_far_from_squark_L_cut_R = 1.;
    ss_pt_far_from_squark_R_cut_R = 1.;
    gg_pt_near_from_squark_L_cut_R = 1.;
    gg_pt_near_from_squark_R_cut_R = 1.;
    gg_pt_far_from_squark_L_cut_R = 1.;
    gg_pt_far_from_squark_R_cut_R = 1.;
    ss_pt_near_from_squark_L_cut_L = 1.;
    ss_pt_near_from_squark_R_cut_L = 1.;
    ss_pt_far_from_squark_L_cut_L = 1.;
    ss_pt_far_from_squark_R_cut_L = 1.;
    gg_pt_near_from_squark_L_cut_L = 1.;
    gg_pt_near_from_squark_R_cut_L = 1.;
    gg_pt_far_from_squark_L_cut_L = 1.;
    gg_pt_far_from_squark_R_cut_L = 1.;
    ss_pt_near_from_sbotton1R_cut_R = 1.;
    ss_pt_far_from_sbotton1R_cut_R = 1.;
    ss_pt_near_from_sbotton1R_cut_L = 1.;
    ss_pt_far_from_sbotton1R_cut_L = 1.;
    ss_pt_near_from_sbotton1L_cut_R = 1.;
    ss_pt_far_from_sbotton1L_cut_R = 1.;
    ss_pt_near_from_sbotton1L_cut_L = 1.;
    ss_pt_far_from_sbotton1L_cut_L = 1.;
    gg_pt_near_from_sbotton1R_cut_R = 1.;
    gg_pt_far_from_sbotton1R_cut_R = 1.;
    gg_pt_near_from_sbotton1R_cut_L = 1.;
    gg_pt_far_from_sbotton1R_cut_L = 1.;
    gg_pt_near_from_sbotton1L_cut_R = 1.;
    gg_pt_far_from_sbotton1L_cut_R = 1.;
    gg_pt_near_from_sbotton1L_cut_L = 1.;
    gg_pt_far_from_sbotton1L_cut_L = 1.;
    ss_pt_near_from_sbotton2R_cut_R = 1.;
    ss_pt_far_from_sbotton2R_cut_R = 1.;
    ss_pt_near_from_sbotton2R_cut_L = 1.;
    ss_pt_far_from_sbotton2R_cut_L = 1.;
    ss_pt_near_from_sbotton2L_cut_R = 1.;
    ss_pt_far_from_sbotton2L_cut_R = 1.;
    ss_pt_near_from_sbotton2L_cut_L = 1.;
    ss_pt_far_from_sbotton2L_cut_L = 1.;
    gg_pt_near_from_sbotton2R_cut_R = 1.;
    gg_pt_far_from_sbotton2R_cut_R = 1.;
    gg_pt_near_from_sbotton2R_cut_L = 1.;
    gg_pt_far_from_sbotton2R_cut_L = 1.;
    gg_pt_near_from_sbotton2L_cut_R = 1.;
    gg_pt_far_from_sbotton2L_cut_R = 1.;
    gg_pt_near_from_sbotton2L_cut_L = 1.;
    gg_pt_far_from_sbotton2L_cut_L = 1.;
    ss_pt_near_from_stop1R_cut_R = 1.;
    ss_pt_far_from_stop1R_cut_R = 1.;
    ss_pt_near_from_stop1R_cut_L = 1.;
    ss_pt_far_from_stop1R_cut_L = 1.;
    ss_pt_near_from_stop1L_cut_R = 1.;
    ss_pt_far_from_stop1L_cut_R = 1.;
    ss_pt_near_from_stop1L_cut_L = 1.;
    ss_pt_far_from_stop1L_cut_L = 1.;
    gg_pt_near_from_stop1R_cut_R = 1.;
    gg_pt_far_from_stop1R_cut_R = 1.;
    gg_pt_near_from_stop1R_cut_L = 1.;
    gg_pt_far_from_stop1R_cut_L = 1.;
    gg_pt_near_from_stop1L_cut_R = 1.;
    gg_pt_far_from_stop1L_cut_R = 1.;
    gg_pt_near_from_stop1L_cut_L = 1.;
    gg_pt_far_from_stop1L_cut_L = 1.;
    ss_pt_near_from_stop2R_cut_R = 1.;
    ss_pt_far_from_stop2R_cut_R = 1.;
    ss_pt_near_from_stop2R_cut_L = 1.;
    ss_pt_far_from_stop2R_cut_L = 1.;
    ss_pt_near_from_stop2L_cut_R = 1.;
    ss_pt_far_from_stop2L_cut_R = 1.;
    ss_pt_near_from_stop2L_cut_L = 1.;
    ss_pt_far_from_stop2L_cut_L = 1.;
    gg_pt_near_from_stop2R_cut_R = 1.;
    gg_pt_far_from_stop2R_cut_R = 1.;
    gg_pt_near_from_stop2R_cut_L = 1.;
    gg_pt_far_from_stop2R_cut_L = 1.;
    gg_pt_near_from_stop2L_cut_R = 1.;
    gg_pt_far_from_stop2L_cut_R = 1.;
    gg_pt_near_from_stop2L_cut_L = 1.;
    gg_pt_far_from_stop2L_cut_L = 1.;

  }
  if (nocuts == 2){ //only lepton cuts
    AC_jet12_missing_ET_ss_L = 1.; 
    AC_jet12_missing_ET_ss_R = 1.; 
    AC_jet12_missing_ET_ss_av = 1.; 
    AC_jet12_missing_ET_sg_L = 1.; 
    AC_jet12_missing_ET_sg_R = 1.; 
    AC_jet12_missing_ET_gg = 1.; 	
  }


	

  //Test-Output//
	
  // 	std::cout << "ss_eta_from_squark_L_cut\t" << this->ss_lepton_grid_eta->value(msquark_L,mgluino) << std::endl;
  // 	std::cout << "ss_eta_from_squark_R_cut\t" << this->ss_lepton_grid_eta->value(msquark_R,mgluino) << std::endl;
  // 	std::cout << "ss_pt_near_from_squark_L_cut\t" << this->near_lepton_pt_cut(msquark_L,msleptonR,1,1) << std::endl;
  // 	std::cout << "ss_pt_near_from_squark_R_cut\t" << this->near_lepton_pt_cut(msquark_R,msleptonR,1,2) << std::endl;
  // 	std::cout << "ss_pt_far_from_squark_L_cut\t" << this->far_lepton_pt_cut(msquark_L,msleptonR,1,1) << std::endl;
  // 	std::cout << "ss_pt_far_from_squark_R_cut\t" << this->far_lepton_pt_cut(msquark_R,msleptonR,1,2) << std::endl;
  // 	std::cout << "gg_eta_from_squark_L_cut\t" << this->gg_lepton_grid_eta->value(msquark_R,mgluino) << std::endl;
  // 	std::cout << "gg_eta_from_squark_R_cut\t" << this->gg_lepton_grid_eta->value(msquark_R,mgluino) << std::endl;
  // 	std::cout << "gg_pt_near_from_squark_L_cut\t" << this->near_lepton_pt_cut(msquark_R,msleptonR,2,1) << std::endl;
  // 	std::cout << "gg_pt_near_from_squark_R_cut\t" << this->near_lepton_pt_cut(msquark_R,msleptonR,2,2) << std::endl;
  // 	std::cout << "gg_pt_far_from_squark_L_cut\t" << this->far_lepton_pt_cut(msquark_R,msleptonR,2,1) << std::endl;
  // 	std::cout << "gg_pt_far_from_squark_R_cut\t" << this->far_lepton_pt_cut(msquark_R,msleptonR,2,2) << std::endl;
  // 	
  // 	std::cout << "ss_eta_from_squark_L_cut_L\t" << this->ss_lepton_grid_eta->value(msquark_L,mgluino) << std::endl;
  // 	std::cout << "ss_eta_from_squark_R_cut_L\t" << this->ss_lepton_grid_eta->value(msquark_R,mgluino) << std::endl;
  // 	std::cout << "ss_pt_near_from_squark_L_cut_L\t" << this->near_lepton_pt_cut(msquark_L,msleptonL,1,2) << std::endl;
  // 	std::cout << "ss_pt_near_from_squark_R_cut_L\t" << this->near_lepton_pt_cut(msquark_R,msleptonL,1,1) << std::endl;
  // 	std::cout << "ss_pt_far_from_squark_L_cut_L\t" << this->far_lepton_pt_cut(msquark_L,msleptonL,1,2) << std::endl;
  // 	std::cout << "ss_pt_far_from_squark_R_cut_L\t" << this->far_lepton_pt_cut(msquark_R,msleptonL,1,1) << std::endl;
  // 	std::cout << "gg_eta_from_squark_L_cut_L\t" << this->gg_lepton_grid_eta->value(msquark_L,mgluino) << std::endl;
  // 	std::cout << "gg_eta_from_squark_R_cut_L\t" << this->gg_lepton_grid_eta->value(msquark_L,mgluino) << std::endl;
  // 	std::cout << "gg_pt_near_from_squark_L_cut_L\t" << this->near_lepton_pt_cut(msquark_R,msleptonL,2,2) << std::endl;
  // 	std::cout << "gg_pt_near_from_squark_R_cut_L\t" << this->near_lepton_pt_cut(msquark_R,msleptonL,2,1) << std::endl;
  // 	std::cout << "gg_pt_far_from_squark_L_cut_L\t" << this->far_lepton_pt_cut(msquark_R,msleptonL,2,2) << std::endl;
  // 	std::cout << "gg_pt_far_from_squark_R_cut_L\t" << this->far_lepton_pt_cut(msquark_R,msleptonL,2,1) << std::endl;
	
	
	
  //get NLO k factors
  set_k_factors();
	
	
  //calculate sigma*BR*Acceptance
  rate+=2.*gg_grid->value(msquark_av,mgluino)*K_gg	//sigma		//2: two gluinos
    *AC_jet12_missing_ET_gg		//jet_mssingET cuts
    *(
      gg_eta_from_squark_L_cut*gg_eta_from_squark_L_cut*gg_pt_near_from_squark_L_cut_R*gg_pt_far_from_squark_L_cut_R			//lepton cuts for slepton_R from squark_L
      *BR_gluino_ossf_R 	//BR
      +
      gg_eta_from_squark_L_cut*gg_eta_from_squark_L_cut*gg_pt_near_from_squark_L_cut_L*gg_pt_far_from_squark_L_cut_L                  //lepton cuts for slepton_L from squark_L
      *BR_gluino_ossf_L    //BR
      +
      + //gluino -> sbotton1 -> slepton_R
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_R*gg_pt_far_from_sbotton1R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton1 inkl L/R mixing
       + gg_pt_near_from_sbotton1L_cut_R*gg_pt_far_from_sbotton1L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_R    //BR 
      + //gluino -> sbotton1 -> slepton_L
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_L*gg_pt_far_from_sbotton1R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton1 inkl L/R mixing
       + gg_pt_near_from_sbotton1L_cut_L*gg_pt_far_from_sbotton1L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_L    //BR 
      + //gluino -> sbotton2 -> slepton_R
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_R*gg_pt_far_from_sbotton2R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_R*gg_pt_far_from_sbotton2L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_R    //BR  
      + //gluino -> sbotton2 -> slepton_L
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_L*gg_pt_far_from_sbotton2R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_L*gg_pt_far_from_sbotton2L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_L    //BR  
      + //gluino -> stop1 -> slepton_R
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_R*gg_pt_far_from_stop1R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_R*gg_pt_far_from_stop1L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_R    //BR  
      + //gluino -> stop1 -> slepton_L
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_L*gg_pt_far_from_stop1R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_L*gg_pt_far_from_stop1L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_L    //BR  
      + //gluino -> stop2 -> slepton_R
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_R*gg_pt_far_from_stop2R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_R*gg_pt_far_from_stop2L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_R    //BR
      + //gluino -> stop2 -> slepton_L
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_L*gg_pt_far_from_stop2R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_L*gg_pt_far_from_stop2L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_L    //BR 	
      );
	
	
  // ~g~q_R 
  rate+=sg_grid->value(msquark_R,mgluino)*K_sg_R		//sigma
    *AC_jet12_missing_ET_sg_R	//jet_mssingET cuts
    *(
      gg_eta_from_squark_R_cut*gg_eta_from_squark_R_cut*gg_pt_near_from_squark_R_cut_R*gg_pt_far_from_squark_R_cut_R			//lepton cuts
      *BR_gluino_ossf_R 	//BR
      +
      gg_eta_from_squark_R_cut*gg_eta_from_squark_R_cut*gg_pt_near_from_squark_R_cut_L*gg_pt_far_from_squark_R_cut_L                  //lepton cuts
      *BR_gluino_ossf_L       //BR
      + //gluino -> sbotton1 -> slepton_R
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_R*gg_pt_far_from_sbotton1R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton1 inkl L/R mixing
       + gg_pt_near_from_sbotton1L_cut_R*gg_pt_far_from_sbotton1L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_R    //BR 
      + //gluino -> sbotton1 -> slepton_L
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_L*gg_pt_far_from_sbotton1R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton1 inkl L/R mixing
       + ss_pt_near_from_sbotton1L_cut_L*gg_pt_far_from_sbotton1L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_L    //BR 
      + //gluino -> sbotton2 -> slepton_R
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_R*gg_pt_far_from_sbotton2R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_R*gg_pt_far_from_sbotton2L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_R    //BR  
      + //gluino -> sbotton2 -> slepton_L
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_L*gg_pt_far_from_sbotton2R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_L*gg_pt_far_from_sbotton2L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_L    //BR  
      + //gluino -> stop1 -> slepton_R
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_R*gg_pt_far_from_stop1R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_R*gg_pt_far_from_stop1L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_R    //BR  
      + //gluino -> stop1 -> slepton_L
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_L*gg_pt_far_from_stop1R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_L*gg_pt_far_from_stop1L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_L    //BR  
      + //gluino -> stop2 -> slepton_R
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_R*gg_pt_far_from_stop2R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_R*gg_pt_far_from_stop2L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_R    //BR
      + //gluino -> stop2 -> slepton_L
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_L*gg_pt_far_from_stop2R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_L*gg_pt_far_from_stop2L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_L    //BR 	 	
      )
    + sg_grid->value(msquark_R,mgluino)*K_sg_R	//sigma
    *AC_jet12_missing_ET_sg_R	//jet_mssingET cuts
    *(
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_R*ss_pt_far_from_squark_R_cut_R			//lepton cuts
      *BR_squark_R_ossf_R 	//BR
      +
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_L*ss_pt_far_from_squark_R_cut_L                  //lepton cuts
      *BR_squark_R_ossf_L    //BR
      );


	
  // ~g~q_L 
  rate+=sg_grid->value(msquark_L,mgluino)*K_sg_L		//sigma
    *AC_jet12_missing_ET_sg_L	//jet_mssingET cuts
    *(
      gg_eta_from_squark_L_cut*gg_eta_from_squark_L_cut*gg_pt_near_from_squark_L_cut_R*gg_pt_far_from_squark_L_cut_R			//lepton cuts
      *BR_gluino_ossf_R 	//BR
      +
      gg_eta_from_squark_L_cut*gg_eta_from_squark_L_cut*gg_pt_near_from_squark_L_cut_L*gg_pt_far_from_squark_L_cut_L                  //lepton cuts
      *BR_gluino_ossf_L       //BR
      + //gluino -> sbotton1 -> slepton_R
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_R*gg_pt_far_from_sbotton1R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton1 inkl L/R mixing
       + gg_pt_near_from_sbotton1L_cut_R*gg_pt_far_from_sbotton1L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_R    //BR 
      + //gluino -> sbotton1 -> slepton_L
      gg_eta_from_sbotton1_cut*gg_eta_from_sbotton1_cut*
      (gg_pt_near_from_sbotton1R_cut_L*gg_pt_far_from_sbotton1R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton1 inkl L/R mixing
       + gg_pt_near_from_sbotton1L_cut_L*gg_pt_far_from_sbotton1L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton1_L    //BR 
      + //gluino -> sbotton2 -> slepton_R
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_R*gg_pt_far_from_sbotton2R_cut_R*pow(sbotmix_sin,2)		//lepton cuts for slepton_R from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_R*gg_pt_far_from_sbotton2L_cut_R*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_R    //BR  
      + //gluino -> sbotton2 -> slepton_L
      gg_eta_from_sbotton2_cut*gg_eta_from_sbotton2_cut*
      (gg_pt_near_from_sbotton2R_cut_L*gg_pt_far_from_sbotton2R_cut_L*pow(sbotmix_sin,2)		//lepton cuts for slepton_L from sbotton2 inkl L/R mixing
       + gg_pt_near_from_sbotton2L_cut_L*gg_pt_far_from_sbotton2L_cut_L*pow(sbotmix_cos,2) )	
      *BR_gluino_ossf_sbotton2_L    //BR  
      + //gluino -> stop1 -> slepton_R
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_R*gg_pt_far_from_stop1R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_R*gg_pt_far_from_stop1L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_R    //BR  
      + //gluino -> stop1 -> slepton_L
      gg_eta_from_stop1_cut*gg_eta_from_stop1_cut*
      (gg_pt_near_from_stop1R_cut_L*gg_pt_far_from_stop1R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop1 inkl L/R mixing
       + gg_pt_near_from_stop1L_cut_L*gg_pt_far_from_stop1L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop1_L    //BR  
      + //gluino -> stop2 -> slepton_R
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_R*gg_pt_far_from_stop2R_cut_R*pow(stopmix_sin,2)		//lepton cuts for slepton_R from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_R*gg_pt_far_from_stop2L_cut_R*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_R    //BR
      + //gluino -> stop2 -> slepton_L
      gg_eta_from_stop2_cut*gg_eta_from_stop2_cut*
      (gg_pt_near_from_stop2R_cut_L*gg_pt_far_from_stop2R_cut_L*pow(stopmix_sin,2)		//lepton cuts for slepton_L from stop2 inkl L/R mixing
       + gg_pt_near_from_stop2L_cut_L*gg_pt_far_from_stop2L_cut_L*pow(stopmix_cos,2) )	
      *BR_gluino_ossf_stop2_L    //BR 	 
      )
    + sg_grid->value(msquark_L,mgluino)*K_sg_L	//sigma
    *AC_jet12_missing_ET_sg_L	//jet_mssingET cuts
    *(
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_R*ss_pt_far_from_squark_L_cut_R			//lepton cuts		
      *BR_squark_L_ossf_R  	//BR
      +
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_L*ss_pt_far_from_squark_L_cut_L                  //lepton cuts           
      *BR_squark_L_ossf_L    //BR
      );
	

  // ~q_L~q_L 		//s-channel sbottons substracted
  rate+=(ss_grid->value(msquark_L,mgluino)*K_ss_L-stop_grid->value(msquark_L,mgluino)*K_ss_stop_L)						//sigma
    *AC_jet12_missing_ET_ss_L											//jet_mssingET cuts
    *(
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_R*ss_pt_far_from_squark_L_cut_R			//lepton cuts
      *2.*BR_squark_L_ossf_R												//BR
      +
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_L*ss_pt_far_from_squark_L_cut_L                  //lepton cuts
      *2.*BR_squark_L_ossf_L
      );
		
	
  // ~q_R~q_R 		//s-channel sbottons substracted
  rate+=(ss_grid->value(msquark_R,mgluino)*K_ss_R-stop_grid->value(msquark_R,mgluino)*K_ss_stop_R)	//sigma
    *AC_jet12_missing_ET_ss_R									//jet_mssingET cuts
    *(
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_R*ss_pt_far_from_squark_R_cut_R			//lepton cuts
      *2.*BR_squark_R_ossf_R												//BR
      +
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_L*ss_pt_far_from_squark_R_cut_L                  //lepton cuts
      *2.*BR_squark_R_ossf_L                                                                                          //BR    
      );	
	

  // ~q_L~q_R & ~q_R~q_L
  rate+=2.*sd_grid->value(msquark_av,mgluino)*K_ss_av	//sigma
    *AC_jet12_missing_ET_ss_av
    *(
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_R*ss_pt_far_from_squark_L_cut_R			//lepton cuts
      *BR_squark_L_ossf_R 		//BR
      +
      ss_eta_from_squark_L_cut*ss_eta_from_squark_L_cut*ss_pt_near_from_squark_L_cut_L*ss_pt_far_from_squark_L_cut_L                 //lepton cuts
      *BR_squark_L_ossf_L             //BR
      )
    + 2.*sd_grid->value(msquark_av,mgluino)*K_ss_av	//sigma
    *AC_jet12_missing_ET_ss_av
    *(
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_R*ss_pt_far_from_squark_R_cut_R			//lepton cuts
      *BR_squark_R_ossf_R	//BR
      +
      ss_eta_from_squark_R_cut*ss_eta_from_squark_R_cut*ss_pt_near_from_squark_R_cut_L*ss_pt_far_from_squark_R_cut_L                 //lepton cuts
      *BR_squark_R_ossf_L     //BR
      );

	
  // ~sbotton1~sbotton1
  rate+=stop_grid->value(msbotton1,mgluino)*K_ss_sbottom1						//sigma
    *AC_jet12_missing_ET_ss_sbotton1											//jet_mssingET cuts
    *(
      ss_eta_from_sbotton1_cut*ss_eta_from_sbotton1_cut*
      (ss_pt_near_from_sbotton1R_cut_R*ss_pt_far_from_sbotton1R_cut_R*pow(sbotmix_sin,2)		//lepton cuts inkl L/R mixing
       + ss_pt_near_from_sbotton1L_cut_R*ss_pt_far_from_sbotton1L_cut_R*pow(sbotmix_cos,2) )					
      *2.*BR_sbotton1_ossf_R												//BR
      +
      ss_eta_from_sbotton1_cut*ss_eta_from_sbotton1_cut*
      (ss_pt_near_from_sbotton1R_cut_R*ss_pt_far_from_sbotton1R_cut_R*pow(sbotmix_sin,2)		//lepton cuts inkl L/R mixing
       +ss_pt_near_from_sbotton1L_cut_R*ss_pt_far_from_sbotton1L_cut_R*pow(sbotmix_cos,2))
      *2.*BR_sbotton1_ossf_L
      );
	
	
	
  // ~sbotton2~sbotton2
  rate+=stop_grid->value(msbotton2,mgluino)*K_ss_sbottom2						//sigma
    *AC_jet12_missing_ET_ss_sbotton2											//jet_mssingET cuts
    *(
      ss_eta_from_sbotton2_cut*ss_eta_from_sbotton2_cut*
      (ss_pt_near_from_sbotton2R_cut_R*ss_pt_far_from_sbotton2R_cut_R*pow(sbotmix_sin,2)		//lepton cuts inkl L/R mixing
       + ss_pt_near_from_sbotton2L_cut_R*ss_pt_far_from_sbotton2L_cut_R*pow(sbotmix_cos,2))					
      *2.*BR_sbotton2_ossf_R												//BR
      +
      ss_eta_from_sbotton2_cut*ss_eta_from_sbotton2_cut*
      (ss_pt_near_from_sbotton2R_cut_R*ss_pt_far_from_sbotton2R_cut_R*pow(sbotmix_sin,2)		//lepton cuts inkl L/R mixing
       + ss_pt_near_from_sbotton2L_cut_R*ss_pt_far_from_sbotton2L_cut_R*pow(sbotmix_cos,2))
      *2.*BR_sbotton2_ossf_L
      );
	
	
  // ~stop1~stop2
  rate+=stop_grid->value(mstop1,mgluino)*K_ss_stop1						//sigma
    *AC_jet12_missing_ET_ss_stop1											//jet_mssingET cuts
    *(
      ss_eta_from_stop1_cut*ss_eta_from_stop1_cut*
      (ss_pt_near_from_stop1R_cut_R*ss_pt_far_from_stop1R_cut_R*pow(stopmix_sin,2)			//lepton cuts inkl L/R mixing
       + ss_pt_near_from_stop1L_cut_R*ss_pt_far_from_stop1L_cut_R*pow(stopmix_cos,2))					
      *2.*BR_stop1_ossf_R												//BR
      +
      ss_eta_from_stop1_cut*ss_eta_from_stop1_cut*
      (ss_pt_near_from_stop1R_cut_R*ss_pt_far_from_stop1R_cut_R*pow(stopmix_sin,2)			//lepton cuts inkl L/R mixing
       +ss_pt_near_from_stop1L_cut_R*ss_pt_far_from_stop1L_cut_R*pow(stopmix_cos,2))
      *2.*BR_stop1_ossf_L
      );
	
  // ~stop2~stop2
  rate+=stop_grid->value(mstop2,mgluino)*K_ss_stop2						//sigma
    *AC_jet12_missing_ET_ss_stop2											//jet_mssingET cuts
    *(
      ss_eta_from_stop2_cut*ss_eta_from_stop2_cut*
      (ss_pt_near_from_stop2R_cut_R*ss_pt_far_from_stop2R_cut_R*pow(stopmix_sin,2)			//lepton cuts inkl L/R mixing
       + ss_pt_near_from_stop2L_cut_R*ss_pt_far_from_stop2L_cut_R*pow(stopmix_cos,2))					
      *2.*BR_stop2_ossf_R												//BR
      +
      ss_eta_from_stop2_cut*ss_eta_from_stop2_cut*
      (ss_pt_near_from_stop2R_cut_R*ss_pt_far_from_stop2R_cut_R*pow(stopmix_sin,2)			//lepton cuts inkl L/R mixing
       + ss_pt_near_from_stop2L_cut_R*ss_pt_far_from_stop2L_cut_R*pow(stopmix_cos,2))
      *2.*BR_stop2_ossf_L
      );
	
	
	
	
	
	
  return rate*factor ;
}

int sRates::information_available_ossf(){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    return -5;
  }
		
  if (information_available() < 0 ){
    return -1;
  }

		
		
  if( 		(
		 (mneutralino1 < msleptonR &&  msleptonR < mneutralino2) ||
		 (mneutralino1 < msleptonL &&  msleptonL < mneutralino2)   
		 )
		&&  mneutralino2 < this->m_squark_all_light_L() 
		// 				  && msleptonL > mneutralino2 			//make sure slepton_L is heavier then neutralino2. I should include the other way round or both accessible soon.
		// 				  && (mneutralino2-mneutralino1)		//make sure no on-shell Z can be produced here. At some point all possible on-shell Z should be included. ATM: 											Veto on leptons from on-shell Z decays. Should be possible.
		  
		) {		
				
    return 1;
			
  } else {
			
    return -1;
						
  }
		
}



//Constructor 
sRates::sRates(std::string unit, bool nlo_in )  
//Initialization list
  : gg_grid( new Xgrid() ) , sg_grid(new Xgrid()) , ss_grid(new Xgrid()) , sd_grid(new Xgrid()) , stop_grid(new Xgrid()) , 
    spectrum(new BOL_EW_scale_MSSM_spectrum::BOL_EW_scale_MSSM_spectrum())
	
{
  if (unit == "pb") { 
    factor = 1.;
  } else if (unit == "fb") {
    factor = 1000.;
  } else if (unit == "nb") {
    factor = 1./1000.;
  } else {
    std::cout << "unit has to be pb/fb/nb. sRates NOT initialized." << std::endl;
    return;
  }
  UseNLO = nlo_in;
		
  //init masses
  mneutralino1 = 0;
  mneutralino2 = 0;
  msleptonL = 0;
  msleptonR = 0;
  mgluino = 0;
  msquark_av = 0;
  msquark_L = 0;
  msquark_R = 0;
  msbotton1 = 0;
  msbotton2 = 0;
  mstop1 = 0;
  mstop2 = 0;

					
  spectrum_loaded = 0;
  grids_loaded = 0;
  lepton_grids_loaded = 0;
  std::cout << "sRates object initialized." << std::endl;
  return;
		
}

	
	
	
// Constructor with string for path to grids & string for filename for SLHA file. In fittino rates are handeld in fb! std::string input "pb"/"fb"
sRates::sRates( std::string SLHA_filename , std::string unit, bool nlo_in) 
//Initialization list
  : gg_grid( new Xgrid() ) , sg_grid(new Xgrid()) , ss_grid(new Xgrid()) , sd_grid(new Xgrid()), stop_grid(new Xgrid()) 
  , spectrum(new BOL_EW_scale_MSSM_spectrum::BOL_EW_scale_MSSM_spectrum())
	
{

  mneutralino1 = 0;
  mneutralino2 = 0;
  msleptonL = 0;
  msleptonR = 0;
  mgluino = 0;
  msquark_av = 0;
  msquark_L = 0;
  msquark_R = 0;
  msbotton1 = 0;
  msbotton2 = 0;
  mstop1 = 0;
  mstop2 = 0;
		


  if (unit == "pb") { 
    factor = 1.;
  } else if (unit == "fb") {
    factor = 1000.;
  } else if (unit == "nb") {
    factor = 1./1000.;
  } else {
    std::cout << "unit has to be pb/fb/nb. sRates NOT initialized." << std::endl;
    return;
  }
  UseNLO = nlo_in;
		
		
  this->readSLHA( SLHA_filename );
		
  this->readGrids();
		
		
  std::cout << "==sRates object initialized. LHE file & grids loaded.==" << std::endl;
		
}
	
	
	
//Copy Constructor
sRates::sRates(const sRates&)
  : gg_grid( new Xgrid() ) , sg_grid(new Xgrid()) , ss_grid(new Xgrid()) , sd_grid(new Xgrid()), stop_grid(new Xgrid()) , 
    spectrum(new BOL_EW_scale_MSSM_spectrum::BOL_EW_scale_MSSM_spectrum())
{
		
  spectrum_loaded = 0;
  grids_loaded = 0;
  factor = 1;
		
		
  mneutralino1 = 0;
  mneutralino2 = 0;
  msleptonL = 0;
  msleptonR = 0;
  mgluino = 0;
  msquark_av = 0;
  msquark_L = 0;
  msquark_R = 0;
  msbotton1 = 0;
  msbotton2 = 0;
  mstop1 = 0;
  mstop2 = 0;
		
		
}
	
	
		
//Destructor
sRates::~sRates()
{
		
  if (grids_loaded) {
    delete gg_grid;
    delete sg_grid;
    delete ss_grid;
    delete sd_grid;
    delete stop_grid;

    delete gg_K_grid;
    delete sg_K_grid;
    delete ss_K_grid;
    delete sb_K_grid;
    delete ss_LO_grid;
    delete sb_LO_grid;
    delete stop_K_grid;

	
    delete ss_AC_grid_ETmiss;
    delete ss_AC_grid_j1_pt;
    delete ss_AC_grid_j1_eta;
    delete ss_AC_grid_j2_pt;
    delete ss_AC_grid_j2_eta;
    delete sg_AC_grid_ETmiss;
    delete sg_AC_grid_j1_pt;
    delete sg_AC_grid_j1_eta;
    delete sg_AC_grid_j2_pt;
    delete sg_AC_grid_j2_eta;
    delete gg_AC_grid_ETmiss;
    delete gg_AC_grid_j1_pt;
    delete gg_AC_grid_j1_eta;
    delete gg_AC_grid_j2_pt;
    delete gg_AC_grid_j2_eta;
  }
		
  if (lepton_grids_loaded) {
    delete ss_lepton_grid_eta;
    delete gg_lepton_grid_eta;
		
    for (int i = 0; i < e_distribution_bins	; i++){			
			
      delete ss_lepton_grids_pt[i];
			
    }
				
    for (int i = 0; i < e_distribution_bins	; i++){			
			
      delete gg_lepton_grids_pt[i];
			
    }
		
  }
		
  if (spectrum_loaded){
    delete spectrum;
  }
	
}



	
	
	
//Read Grids
void sRates::readGrids(){					//<-- Include Error Handling at some point
  gg_grid = new Xgrid(filename_gg_grid);
  sg_grid = new Xgrid(filename_sg_grid);
  ss_grid = new Xgrid(filename_ss_grid);
  sd_grid = new Xgrid(filename_sd_grid);
  stop_grid = new Xgrid(filename_stop_grid);

	
  gg_K_grid = new Xgrid(filename_gg_K_factors,2,2);
  sg_K_grid = new Xgrid(filename_sg_K_factors,2,2);
  ss_K_grid = new Xgrid(filename_ss_K_factors,2,2);
  sb_K_grid = new Xgrid(filename_sb_K_factors,2,2);
  ss_LO_grid = new Xgrid(filename_ss_K_factors,0,2);
  sb_LO_grid = new Xgrid(filename_sb_K_factors,0,2);
  stop_K_grid = new Xgrid(filename_stop_K_factors,2,2);
	
	
  ss_AC_grid_ETmiss = new ACgrid(filename_ss_AC_grid,1);
  ss_AC_grid_j1_pt = new ACgrid(filename_ss_AC_grid,2);
  ss_AC_grid_j1_eta = new ACgrid(filename_ss_AC_grid,3);
  ss_AC_grid_j2_pt = new ACgrid(filename_ss_AC_grid,2);
  ss_AC_grid_j2_eta = new ACgrid(filename_ss_AC_grid,3);
  sg_AC_grid_ETmiss = new ACgrid(filename_sg_AC_grid,1);
  sg_AC_grid_j1_pt = new ACgrid(filename_sg_AC_grid,2);
  sg_AC_grid_j1_eta = new ACgrid(filename_sg_AC_grid,3);
  sg_AC_grid_j2_pt = new ACgrid(filename_sg_AC_grid,4);
  sg_AC_grid_j2_eta = new ACgrid(filename_sg_AC_grid,5);
  gg_AC_grid_ETmiss  = new ACgrid(filename_gg_AC_grid,1);
  gg_AC_grid_j1_pt = new ACgrid(filename_gg_AC_grid,2);
  gg_AC_grid_j1_eta = new ACgrid(filename_gg_AC_grid,3);
  gg_AC_grid_j2_pt = new ACgrid(filename_gg_AC_grid,4);
  gg_AC_grid_j2_eta = new ACgrid(filename_gg_AC_grid,5);
		
		
  grids_loaded = 1;
  std::cout << "Cross section and jet acceptance grids loaded" << std::endl;
}
	
	
	
//Read lepton Grids
void sRates::readLeptonGrids(){					//<-- Include Error Handling at some point
  ss_lepton_grid_eta = new Xgrid(filename_ss_lepton_grid,0,2);
  gg_lepton_grid_eta = new Xgrid(filename_gg_lepton_grid,0,2);
		
  //loop over all energies for pt cuts	
  //e_distribution_bins is defined in sRates_leptons.hpp
		
  ss_lepton_grids_pt.resize(e_distribution_bins);
  for (int i = 0; i < e_distribution_bins	; i++){			
			
    ss_lepton_grids_pt[i] = new Xgrid(filename_ss_lepton_grid,i+1,2);

  }
					
  gg_lepton_grids_pt.resize(e_distribution_bins);
  for (int i = 0; i < e_distribution_bins	; i++){			
			
    gg_lepton_grids_pt[i] = new Xgrid(filename_gg_lepton_grid,i+1,2);

  }
		
  lepton_grids_loaded = 1;
  std::cout << "Lepton grids loaded" << std::endl;
}
	


int sRates::readSLHA(std::string SLHA_file_name){
  int return_value;
		
		
  //reset masses
  mneutralino1 = 0;
  mneutralino2 = 0;
  msleptonL = 0;
  msleptonR = 0;
  mgluino = 0;
		
		
		
  /*		//if there already is a spectrum. make sure to reset it.
    if (this->spectrum_loaded == 1){
		
			
    this->spectrum->reset();
    //delete this->spectrum;
    //spectrum_loaded = 0;
    }*/		

  // 		this->spectrum = new BOL_LHC_MSSM_spectrum::BOL_LHC_MSSM_spectrum();		//we use the already in the constructor created spectrum
		
  // 		BOL_SLHA_reader::BOL_SLHA_reader *reader = new BOL_SLHA_reader( this->spectrum );  // create a BOL_SLHA_reader instance to read in the SLHA file.
		
  old_CppSLHA::old_CppSLHA* reader = new old_CppSLHA::old_CppSLHA( SLHA_file_name, spectrum );
				
  // 		if (reader->read_file( SLHA_file_name ) != 0 ){
  if (reader->read_file( SLHA_file_name ) != 0 ){	
			
    spectrum_loaded = 1;
			
    //this->spectrum->find_all_cascade_decays(0.0001);
    // 			this->spectrum->update_stable_invisible();
		
			
			
    //set masses
    mneutralino1 =  m_neutralino1();
    mneutralino2 = double(spectrum->get_particle_property_set(1000023)->get_mass());
    msleptonL = double(spectrum->get_particle_property_set(1000011)->get_mass());
    msleptonR = double(spectrum->get_particle_property_set(2000011)->get_mass());
    mgluino =  double(spectrum->get_particle_property_set(PDG_gluino_CODE)->get_mass());
    msquark_av = double(this->m_squark_all_light());
    msquark_L = double(this->m_squark_all_light_L());
    msquark_R = double(this->m_squark_all_light_R());
    msbotton1 = double(spectrum->get_particle_property_set(1000005)->get_mass());
    msbotton2 = double(spectrum->get_particle_property_set(2000005)->get_mass());
    mstop1 = double(spectrum->get_particle_property_set(1000006)->get_mass());
    mstop2 = double(spectrum->get_particle_property_set(2000006)->get_mass());

    //and other parameters
    M0 = double(reader->get_BLOCK("MINPAR",1));
    M12 = double(reader->get_BLOCK("MINPAR",2));
    A0 = double(reader->get_BLOCK("MINPAR",5));
    TANB = double(reader->get_BLOCK("MINPAR",3));
    SIGNMU = double(reader->get_BLOCK("MINPAR",4));
    SBOTMIX_cos = double(reader->get_BLOCK("SBOTMIX",1,1));
    STOPMIX_cos = double(reader->get_BLOCK("STOPMIX",1,1));

					
    //return 1 if file has been read in
    return_value = 1;
		
  } else { 		
    //delete MSSM spectrum if we were unable to read SLHA file	//rather make sure it's reseted
    // 			delete spectrum;			;
    // 			this->spectrum->reset();
			
    //make sure we make spektrum as not loaed.
    spectrum_loaded = 0;
		
    //return 0 if no file has been read in
    return_value = 0;
		
  }
		
  //delete reader after read-in
  delete reader; 
				
		
  return return_value;
}	
	
	
int sRates::information_available(double msquark_in, double mgluino_in, double mneutralino ){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 ) {
    std::cout << "no grids loaded!" << std::endl;
    return -1;
  } else if (gg_grid->value(msquark_in,mgluino_in) < 0 || sg_grid->value(msquark_in,mgluino_in) < 0 || ss_grid->value(msquark_in,mgluino_in) < 0  || sd_grid->value(msquark_in,mgluino_in) < 0){
    return -1;
  } else if (ss_AC_grid_j1_pt->value(msquark_in, mgluino_in, mneutralino) < 0 || sg_AC_grid_j2_pt->value(msquark_in, mgluino_in, mneutralino) < 0 || gg_AC_grid_j1_pt->value(msquark_in, mgluino_in, mneutralino) < 0  || sd_grid->value(msquark_in,mgluino_in) < 0){
    return -1;
  } else if (msquark_in > mgluino_in || mneutralino > msquark_in-200. ) {
    return -1;
  }
		
	
  return 1;
}
	
int sRates::information_available(){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    return -5;
  }
		
		
  // 		std::cout << spectrum->get_particle_property_set(1000022)->get_direct_decays()->size() << std::endl;
		
  //check availability of acceptances and xsection
  if ( !spectrum->get_particle_property_set(1000022)->counts_as_stable_invisible() ) {
			
    return -1;
		
  } else if ( gg_grid->value(msquark_L,mgluino) < 0 || sg_grid->value(msquark_L,mgluino) < 0 || ss_grid->value(msquark_L,mgluino) < 0  || 
	      sd_grid->value(msquark_L,mgluino) < 0 || gg_grid->value(msquark_R,mgluino) < 0 || sg_grid->value(msquark_R,mgluino) < 0 || 
	      ss_grid->value(msquark_R,mgluino) < 0  || sd_grid->value(msquark_R,mgluino) < 0){
			
    return -1;
				
  } else if ( ss_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1) < 0 || sg_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1) < 0 ||
	      gg_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1) < 0 ||  ss_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1) < 0 || 
	      sg_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1) < 0 || gg_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1) < 0 ){
				
    return -1;
				
  } else if (msquark_L > mgluino || msquark_R > mgluino || mneutralino1+200 > msquark_L || mneutralino1+200 > msquark_R || 
	     msbotton1 > mgluino || msbotton2 > mgluino || mneutralino1+200 > msbotton1 || mneutralino1+200 > msbotton2 ||
	     mstop1 > mgluino || mstop2 > mgluino || mneutralino1+200 > mstop1 || mneutralino1+200 > mstop2
	     ) {
				
    return -1;
			
  } 
		
				
  // these is no objection why we shouldn't be able to offer information. So let's assume we are able....			
  return 1;
		
		
}
	
double sRates::fully_inclusive(double msquark_in, double mgluino_in){
  //Make sure grid files are loaded
  if  (grids_loaded == 0) {
    std::cout << "no grids loaded!" << std::endl;
    return -1;
  }
		
  double sum = 0;	
		
		
  //check that we have cross section information for this point
  if (gg_grid->value(msquark_in,mgluino_in) < 0 || sg_grid->value(msquark_in,mgluino_in) < 0 || ss_grid->value(msquark_in,mgluino_in) < 0 || sd_grid->value(msquark_in,mgluino_in) < 0) {
    std::cout << "No x-section information available for this point!" <<std::endl;
    return -2;
  }

		
  if (UseNLO == true){
    K_ss_av = (ss_K_grid->value(msquark_in,mgluino_in)*ss_LO_grid->value(msquark_in,mgluino_in) + sb_K_grid->value(msquark_in,mgluino_in)*sb_LO_grid->value(msquark_in,mgluino_in))/
      (ss_LO_grid->value(msquark_in,mgluino_in) + sb_LO_grid->value(msquark_in,mgluino_in));
    K_gg = gg_K_grid->value(msquark_in,mgluino_in);
    K_sg = gg_K_grid->value(msquark_in,mgluino_in);
  } else {
    K_ss_av = 1;
    K_gg = 1;
    K_sg = 1;
  }	
			
		
		
  // 		std::cout << K_squark_av << std::endl;
	
  sum+=gg_grid->value(msquark_in,mgluino_in)*K_gg;
  sum+=2.*sg_grid->value(msquark_in,mgluino_in)*K_sg; 	// ~g~q_L & ~g~q_R
  sum+=2.*ss_grid->value(msquark_in,mgluino_in)*K_ss_av;	// ~q_L~q_L & ~q_R~q_R
  sum+=2.*sd_grid->value(msquark_in,mgluino_in)*K_ss_av;	// ~q_L~q_R & ~q_R~q_L
		
		
  return sum*factor;
}

double sRates::fully_inclusive(){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  } 
		
  return fully_inclusive(this->m_squark_all_light() , this->m_gluino());
}
	

	
double sRates::fully_inclusive_with_cuts(double msquark_in, double mgluino_in, double mneutralino1_in ){
  //Make sure grid files are loaded
  if  (grids_loaded == 0) {
    std::cout << "no grids loaded!" << std::endl;
    return -1;
  } else if ( this->information_available(msquark_in,mgluino_in,mneutralino1_in) != 1 ){
    std::cout << "No x-section information available for this point!" <<std::endl;
    return -2;
  } 
	
  double sum = 0;	//to be returned
		
		
  //get acceptancies
  double AC_jet_1_ss = ss_AC_grid_j1_pt->value(msquark_in, mgluino_in, mneutralino1_in)*ss_AC_grid_j1_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_jet_2_ss = ss_AC_grid_j2_pt->value(msquark_in, mgluino_in, mneutralino1_in)*ss_AC_grid_j2_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_jet_1_sg = sg_AC_grid_j1_pt->value(msquark_in, mgluino_in, mneutralino1_in)*sg_AC_grid_j1_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_jet_2_sg = sg_AC_grid_j2_pt->value(msquark_in, mgluino_in, mneutralino1_in)*sg_AC_grid_j2_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_jet_1_gg = gg_AC_grid_j1_pt->value(msquark_in, mgluino_in, mneutralino1_in)*gg_AC_grid_j1_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_jet_2_gg = gg_AC_grid_j2_pt->value(msquark_in, mgluino_in, mneutralino1_in)*gg_AC_grid_j2_eta->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_missing_ET_ss = ss_AC_grid_ETmiss->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_missing_ET_sg = sg_AC_grid_ETmiss->value(msquark_in, mgluino_in, mneutralino1_in);
  double AC_missing_ET_gg = gg_AC_grid_ETmiss->value(msquark_in, mgluino_in, mneutralino1_in); 				
		
				
  //Test Output
  // 		cout << AC_jet_1_ss << endl;
  // 		cout << AC_jet_2_ss << endl; 
  // 		cout << AC_jet_1_sg << endl;
  // 		cout << AC_jet_2_sg << endl;
  // 		cout << AC_jet_1_gg << endl;
  // 		cout << AC_jet_2_gg << endl; 
  // 		cout << AC_missing_ET_ss << endl; 
  // 		cout << AC_missing_ET_sg << endl;
  // 		cout << AC_missing_ET_gg << endl; 
		
		
  set_k_factors();
		
		
		
  sum+=AC_jet_1_gg*AC_jet_2_gg*AC_missing_ET_gg*gg_grid->value(msquark_in,mgluino_in)*K_gg;
  sum+=2.*AC_jet_1_sg*AC_jet_2_sg*AC_missing_ET_sg*sg_grid->value(msquark_in,mgluino_in)*K_sg; 	// ~g~q_L & ~g~q_R
  sum+=2.*AC_jet_1_ss*AC_jet_2_ss*AC_missing_ET_ss*ss_grid->value(msquark_in,mgluino_in)*K_ss_av;	// ~q_L~q_L & ~q_R~q_R
  sum+=2.*AC_jet_1_ss*AC_jet_2_ss*AC_missing_ET_ss*sd_grid->value(msquark_in,mgluino_in)*K_ss_av;	// ~q_L~q_R & ~q_R~q_L
		
		
  return sum*factor;
}



double sRates::fully_inclusive_with_cuts(){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  } //check availability of acceptances and xsection
  else if ( this->information_available() != 1 ){
    std::cout << "No x-section information available for this point!" <<std::endl;
    return -2;
  } 
		

  double sum = 0;	//to be returned			
		
			
		
  //get accpectances
  double AC_ss_L = ss_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_L, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_L, mgluino, mneutralino1);

  double AC_ss_R = ss_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_R, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_R, mgluino, mneutralino1);

  double AC_ss_av = ss_AC_grid_j1_pt->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msquark_av, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msquark_av, mgluino, mneutralino1);

  double AC_sg_L = sg_AC_grid_j1_pt->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j1_eta->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j2_pt->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_j2_eta->value(msquark_L, mgluino, mneutralino1)*sg_AC_grid_ETmiss->value(msquark_L, mgluino, mneutralino1);

  double AC_sg_R = sg_AC_grid_j1_pt->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j1_eta->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j2_pt->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_j2_eta->value(msquark_R, mgluino, mneutralino1)*sg_AC_grid_ETmiss->value(msquark_R, mgluino, mneutralino1);
		
  double AC_gg = gg_AC_grid_j1_pt->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j1_eta->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j2_pt->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_j2_eta->value(msquark_av, mgluino, mneutralino1)*gg_AC_grid_ETmiss->value(msquark_av, mgluino, mneutralino1);

  double AC_ss_sbotton1 = ss_AC_grid_j1_pt->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msbotton1, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msbotton1, mgluino, mneutralino1);

  double AC_ss_sbotton2 = ss_AC_grid_j1_pt->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(msbotton2, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(msbotton2, mgluino, mneutralino1);
		
  double AC_ss_stop1 = ss_AC_grid_j1_pt->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(mstop1, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(mstop1, mgluino, mneutralino1);

  double AC_ss_stop2 = ss_AC_grid_j1_pt->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j1_eta->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j2_pt->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_j2_eta->value(mstop2, mgluino, mneutralino1)*ss_AC_grid_ETmiss->value(mstop2, mgluino, mneutralino1);
		
		
  //set k factors
  set_k_factors();
		
		
  //calculate sigma*accpectance for light flavour squarks
  sum+=AC_gg*gg_grid->value(msquark_av,mgluino)*K_gg;
  sum+=AC_sg_L*sg_grid->value(msquark_L,mgluino)*K_sg_L; 	// ~g~q_L 
  sum+=AC_sg_R*sg_grid->value(msquark_R,mgluino)*K_sg_R; 	// ~g~q_R 
  sum+=AC_ss_L*ss_grid->value(msquark_L,mgluino)*K_ss_L;		// ~q_L~q_L 
  sum+=AC_ss_R*ss_grid->value(msquark_R,mgluino)*K_ss_R;		// ~q_R~q_R 
  sum+=2.*AC_ss_av*sd_grid->value(msquark_av,mgluino)*K_ss_av;	// ~q_L~q_R & ~q_R~q_L
		
				
		
  //add sigma*accpectance for sbotton1, sbotton2, stop1, stop2
		
  //first substract sbotton s-channel contribution with mass msquark_L/msquark_R as this is also included in the light squark grids.
  sum-=AC_ss_L*stop_grid->value(msquark_L,mgluino)*stop_K_grid->value(msquark_L,mgluino);
  sum-=AC_ss_R*stop_grid->value(msquark_R,mgluino)*stop_K_grid->value(msquark_R,mgluino);
		
  //now add s-channel distributions with the right masses: msbotton1, msbotton2, mstop1, mstop2.
  sum+=AC_ss_sbotton1*stop_grid->value(msbotton1,mgluino)*K_ss_sbottom1;	// ~sbotton1~sbotton1
  sum+=AC_ss_sbotton2*stop_grid->value(msbotton2,mgluino)*K_ss_sbottom2;	// ~sbotton2~sbotton2
  sum+=AC_ss_stop1*stop_grid->value(mstop1,mgluino)*K_ss_stop1;		// ~stop1~stop1
  sum+=AC_ss_stop2*stop_grid->value(mstop2,mgluino)*K_ss_stop2;		// ~stop2~stop2
		
				
  //return			
  return sum*factor;
		
		
}

//Get overall cSparticle CrossSection for msbotton1/msbotton2 & mgluino from SLHA spectrum using approximate jet & missing ET cut efficiencies. /// NOT NEEDED ATM
double sRates::fully_inclusive_four_sbottons_with_cuts(){
  //Make sure grid files are loaded
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  } //check availability of acceptances and xsection
  else if ( !this->information_available() ){
    std::cout << "No x-section information available for this point!" <<std::endl;
    return -2;
  } 
		
  //get masses from LHE spectrum
  double sum = 0;	//to be returned			
		
  double msbotton_av = (msbotton1 + msbotton2)/2.;
		
			
  double AC_jet_1_gg = gg_AC_grid_j1_pt->value(msbotton_av, mgluino, mneutralino1)*gg_AC_grid_j1_eta->value(msbotton_av, mgluino, mneutralino1);
  double AC_jet_2_gg = gg_AC_grid_j2_pt->value(msbotton_av, mgluino, mneutralino1)*gg_AC_grid_j2_eta->value(msbotton_av, mgluino, mneutralino1);
  double AC_missing_ET_gg = gg_AC_grid_ETmiss->value(msbotton_av, mgluino, mneutralino1);
		
		
  //BR
  std::list< int > bs;
  bs.push_back(5);
  bs.push_back(-5);
		
  double BR_g_bb = spectrum->get_particle_property_set(PDG_gluino_CODE)->get_cascade_handler()->get_branching_ratio_for_subset(&bs);
		
	
  sum+=BR_g_bb*BR_g_bb*gg_grid->value(msquark_av,mgluino)*AC_jet_1_gg*AC_jet_2_gg*AC_missing_ET_gg;
				
		
  //return			
  return sum*factor;
		
		
}




void sRates::set_k_factors(){
  if (UseNLO == true){
    K_ss_av = (ss_K_grid->value(msquark_av,mgluino)*ss_LO_grid->value(msquark_av,mgluino) + sb_K_grid->value(msquark_av,mgluino)*sb_LO_grid->value(msquark_av,mgluino))/
      (ss_LO_grid->value(msquark_av,mgluino) + sb_LO_grid->value(msquark_av,mgluino));
    K_ss_R = (ss_K_grid->value(msquark_R,mgluino)*ss_LO_grid->value(msquark_R,mgluino) + sb_K_grid->value(msquark_R,mgluino)*sb_LO_grid->value(msquark_R,mgluino))/
      (ss_LO_grid->value(msquark_R,mgluino) + sb_LO_grid->value(msquark_R,mgluino));
    K_ss_L = (ss_K_grid->value(msquark_L,mgluino)*ss_LO_grid->value(msquark_L,mgluino) + sb_K_grid->value(msquark_L,mgluino)*sb_LO_grid->value(msquark_L,mgluino))/
      (ss_LO_grid->value(msquark_L,mgluino) + sb_LO_grid->value(msquark_L,mgluino));
    K_ss_stop1 = stop_K_grid->value(mstop1,mgluino);
    K_ss_stop2 = stop_K_grid->value(mstop2,mgluino);
    K_ss_stop_L = stop_K_grid->value(msquark_L,mgluino);
    K_ss_stop_R = stop_K_grid->value(msquark_R,mgluino);
    K_ss_sbottom1 = stop_K_grid->value(msbotton1,mgluino);
    K_ss_sbottom2 = stop_K_grid->value(msbotton2,mgluino);
    K_gg = gg_K_grid->value(msquark_av,mgluino);
    K_sg = gg_K_grid->value(msquark_av,mgluino);
    K_sg_R = gg_K_grid->value(msquark_R,mgluino);
    K_sg_L = gg_K_grid->value(msquark_L,mgluino);
  } else {
    K_ss_av = 1.;
    K_ss_R = 1.;
    K_ss_L = 1.;
    K_ss_stop1 = 1.;
    K_ss_stop2 = 1.;
    K_ss_stop_L = 1.;
    K_ss_stop_R = 1.;
    K_ss_sbottom1 = 1.;
    K_ss_sbottom2 = 1.;
    K_gg = 1.;
    K_sg = 1.;
    K_sg_R = 1.;
    K_sg_L = 1.;
  }
  return;	
}



int sRates::dominant(double msquark_in, double mgluino_in){
		
  if ( gg_grid->value(msquark_in,mgluino_in) > 2.*sg_grid->value(msquark_in,mgluino_in) && gg_grid->value(msquark_in,mgluino_in) > (2.*ss_grid->value(msquark_in,mgluino_in)+2.*sd_grid->value(msquark_in,mgluino_in)) ) {
    return 1;
  } else if ( 2.*sg_grid->value(msquark_in,mgluino_in) >  gg_grid->value(msquark_in,mgluino_in) && 2.*sg_grid->value(msquark_in,mgluino_in) > (2.*ss_grid->value(msquark_in,mgluino_in)+2.*sd_grid->value(msquark_in,mgluino_in)) ) {
    return 2;
  } else if  ( (2.*ss_grid->value(msquark_in,mgluino_in)+2.*sd_grid->value(msquark_in,mgluino_in)) > 2.*sg_grid->value(msquark_in,mgluino_in) && (2.*ss_grid->value(msquark_in,mgluino_in)+2.*sd_grid->value(msquark_in,mgluino_in)) > gg_grid->value(msquark_in,mgluino_in) ) {
    return 3;
  } else {
    std::cout << "something's wrong! " << std::endl;
    return 0;
  }
	
}

int sRates::dominant() {
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
    return -1;
  }		
		
  return dominant(this->m_squark_all_light(), this->m_gluino());
}

void sRates::print_channel_yield() {
		
  if  (grids_loaded == 0 || spectrum_loaded == 0) {
    std::cout << "no grids or no spectrum loaded!" << std::endl;
		
    return;
  }	
		
  set_k_factors();
		
  std::cout<< "gg:\t" << gg_grid->value(msquark_av,mgluino)*K_gg << std::endl;
  std::cout<< "sLg:\t" << sg_grid->value(msquark_L,mgluino)*K_sg_L  << std::endl;
  std::cout<< "sRg:\t" << sg_grid->value(msquark_R,mgluino)*K_sg_R  << std::endl;
  std::cout<< "sd:\t" << 2.*sd_grid->value(msquark_av,mgluino)*K_ss_av  << std::endl;
  std::cout<< "sLsL:\t" << (ss_grid->value(msquark_L,mgluino) - stop_grid->value(msquark_L,mgluino))*stop_K_grid->value(msquark_L,mgluino) + stop_grid->value(msbotton1,mgluino)*K_ss_sbottom1 << std::endl;
  std::cout<< "sRsR:\t" << (ss_grid->value(msquark_R,mgluino) - stop_grid->value(msquark_R,mgluino))*stop_K_grid->value(msquark_R,mgluino) + stop_grid->value(msbotton2,mgluino)*K_ss_sbottom2 << std::endl;
  std::cout<< "sb1sb1:\t" << stop_grid->value(msbotton1,mgluino)*K_ss_sbottom1  << std::endl;
  std::cout<< "sb2sb2:\t" << stop_grid->value(msbotton2,mgluino)*K_ss_sbottom2  << std::endl;
  std::cout<< "st1st1:\t" << stop_grid->value(mstop1,mgluino)*K_ss_stop1  << std::endl;
  std::cout<< "st2st2:\t" << stop_grid->value(mstop2,mgluino)*K_ss_stop2  << std::endl;
	

	
  return;
}

		
	
	
	
	
	
	
	
	
	

	
	
	
	



























