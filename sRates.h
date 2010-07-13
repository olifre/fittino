//global includes

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <valarray>


//locale includes
#include "CppSLHA.h"
#include "Xgrid.h"
#include "ACgrid.h"
#include "grid.h"
#include "PDG.h"



// this should prevent this class being included multiple times.
#ifndef SRATES_HPP
#define SRATES_HPP



class sRates{


 private:
	
  //Cross Section grids
  Xgrid *gg_grid;
  Xgrid *sg_grid;
  Xgrid *ss_grid;
  Xgrid *sd_grid;
  Xgrid *stop_grid;
	
  //NLO K Factors grids
  Xgrid *gg_K_grid;
  Xgrid *sg_K_grid;
  Xgrid *ss_K_grid; //quark + quark
  Xgrid *sb_K_grid; //quark + antiquark
  Xgrid *ss_LO_grid; //quark + quark LO from prospino
  Xgrid *sb_LO_grid; //quark + antiquark LO from prospino
  Xgrid *stop_K_grid;
	
		
  //jet acceptance grids
  ACgrid *ss_AC_grid_ETmiss;
  ACgrid *ss_AC_grid_j1_pt;
  ACgrid *ss_AC_grid_j1_eta;
  ACgrid *ss_AC_grid_j2_pt;
  ACgrid *ss_AC_grid_j2_eta;
  ACgrid *sg_AC_grid_ETmiss;
  ACgrid *sg_AC_grid_j1_pt;
  ACgrid *sg_AC_grid_j1_eta;
  ACgrid *sg_AC_grid_j2_pt;
  ACgrid *sg_AC_grid_j2_eta;
  ACgrid *gg_AC_grid_ETmiss;
  ACgrid *gg_AC_grid_j1_pt;
  ACgrid *gg_AC_grid_j1_eta;
  ACgrid *gg_AC_grid_j2_pt;
  ACgrid *gg_AC_grid_j2_eta;
		
  //lepton acceptance grids
  Xgrid *ss_lepton_grid_eta;
  Xgrid *gg_lepton_grid_eta;
  std::valarray<Xgrid*> ss_lepton_grids_pt;
  std::valarray<Xgrid*> gg_lepton_grids_pt;
		
  BOL_EW_scale_MSSM_spectrum* spectrum;  // create a new BOL_EW_scale_MSSM_spectrum instance for the reader.
		
		
  int spectrum_loaded;
  int grids_loaded;
  int lepton_grids_loaded;
		
  //output as pb/fb/nb ?
  double factor;
		
  //some masses
  // 		double mneutralino1, mneutralino2, msleptonL, msleptonR, mgluino;		<-- put them private!!
  double M0, M12, TANB, A0, SIGNMU;
  double SBOTMIX_cos;
  double STOPMIX_cos;
		
  //some variables for NLO stuff
  double K_gg, K_sg, K_sg_L, K_sg_R, K_ss_av,K_ss_L, K_ss_R, K_ss_stop1, K_ss_stop2, K_ss_sbottom1, K_ss_sbottom2, K_ss_stop_L, K_ss_stop_R ;
  bool UseNLO;

				
  //prototypes
  double near_lepton_pt_cut(double,double,int,int);
  double far_lepton_pt_cut(double,double,int,int);
		
		
 public:	
		
  //some masses
  double mneutralino1, mneutralino2, msleptonL, msleptonR, mgluino, msquark_av, msquark_L, msquark_R, msbotton1, msbotton2, mstop1, mstop2;
		
		
  //prototypes
  double Two_OSSF_leptons(); 	
  double Two_OSSF_leptons_cuts(int nocuts=0);	
  int information_available_ossf();	


  //Constructor 
  sRates(std::string unit, bool nlo_in = true);  
	
	
  // Constructor with string for path to grids & string for filename for SLHA file. In fittino rates are handeld in fb! std::string input "pb"/"fb"
  sRates( std::string SLHA_filename , std::string unit, bool nlo_in = true); 
	
	
  //Copy Constructor
  sRates(const sRates&);
	
		
  //Destructor
  ~sRates();
	
	
  //Read Grids
  void readGrids();
	
	
  //Read lepton Grids
  void readLeptonGrids();
	
	
  //Read LHE file using BOL reader
  int readSLHA(std::string SLHA_file_name);
	
	
  //are we able to provide sigma x acceptance (xBR) information?
  int information_available(double msquark_in, double mgluino_in, double mneutralino );
	
	
  //are we able to provide sigma x acceptance (xBR) information? for LHE input & fully_inclusive signature
  int information_available();
	
	
  //Get overall cSparticle CrossSection for (msquark, mgluino)
  double fully_inclusive(double msquark_in, double mgluino_in);
	
	
  //Get overall cSparticle CrossSection for msquark & mgluino from SLHA spectrum
  double fully_inclusive();
	
	
  //Get overall cSparticle CrossSection for (msquark, mgluino) using approximate jet & missing ET cut efficiencies. This includes sbotton contribution with msbotton = msquark
  double fully_inclusive_with_cuts(double msquark_in, double mgluino_in, double mneutralino1_in );
	
	
  //Get overall cSparticle CrossSection for msquark & mgluino from SLHA spectrum using approximate jet & missing ET cut efficiencies. Treat q_L & q_R with different masses .
  double fully_inclusive_with_cuts();

	
  //Get overall cSparticle CrossSection for msbotton1/msbotton2 & mgluino from SLHA spectrum using approximate jet & missing ET cut efficiencies. /// NOT NEEDED ATM
  double fully_inclusive_four_sbottons_with_cuts();

	
  //set the k factors for all channels
  void set_k_factors();
	
	
	
  /////////////////////////////////
  // which process is dominant?
  /////////////////////////////////
	
	
  //which process is dominant?
  int dominant(double msquark_in, double mgluino_in);
	
	
  //which process is dominant? -- SLHA input
  int dominant(); 
	
	
  void print_channel_yield(); 
	
	
  /////////////////////////////////
  // mass getters
  /////////////////////////////////
	
	
  //get masses/mass averages from LHE file
  inline double m_gluino () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded!" << std::endl;
      return -1;
    }
			
    return mgluino;
  }
	
  inline double m_sbotton1 () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded!" << std::endl;
      return -1;
    }
			
    return spectrum->get_particle_property_set(PDG_sbottom_one_CODE)->get_mass();
  }
	
	
  inline double m_sbotton2 () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded!" << std::endl;
      return -1;
    }
			
    return spectrum->get_particle_property_set(PDG_sbottom_two_CODE)->get_mass();
  }
	
	
  inline double m_neutralino1 () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded!" << std::endl;
      return -1;
    }
			
    return spectrum->get_particle_property_set(PDG_neutralino_one_CODE)->get_mass();
  }
	
	
  inline double m_squark_all_light () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded!" << std::endl;
      return -1;
    }
			
    double msquark = 0.;
		
    msquark += spectrum->get_particle_property_set(1000001)->get_mass();
    msquark += spectrum->get_particle_property_set(1000002)->get_mass();
    msquark += spectrum->get_particle_property_set(1000003)->get_mass();
    msquark += spectrum->get_particle_property_set(1000004)->get_mass();
    msquark += spectrum->get_particle_property_set(2000001)->get_mass();
    msquark += spectrum->get_particle_property_set(2000002)->get_mass();
    msquark += spectrum->get_particle_property_set(2000003)->get_mass();
    msquark += spectrum->get_particle_property_set(2000004)->get_mass();
		
    msquark = msquark/8.;
		
    return msquark;
  }
	
	
  inline double m_squark_all_light_L () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    double msquark = 0.;
		
    msquark += spectrum->get_particle_property_set(1000001)->get_mass();
    msquark += spectrum->get_particle_property_set(1000002)->get_mass();
    msquark += spectrum->get_particle_property_set(1000003)->get_mass();
    msquark += spectrum->get_particle_property_set(1000004)->get_mass();
		
    msquark = msquark/4.;
		
    return msquark;
  }
	
	
  inline double m_squark_all_light_R () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    double msquark = 0.;
		
    msquark += spectrum->get_particle_property_set(2000001)->get_mass();
    msquark += spectrum->get_particle_property_set(2000002)->get_mass();
    msquark += spectrum->get_particle_property_set(2000003)->get_mass();
    msquark += spectrum->get_particle_property_set(2000004)->get_mass();
		
    msquark = msquark/4.;
		
    return msquark;
  }
	
	
	
  /////////////////////////////////
  // GUT Input getters
  /////////////////////////////////
	
	
  inline double m0_input () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    return this->M0;
  }
	
  inline double m12_input () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    return this->M12;
  }
	
  inline double tanb_input () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    return this->TANB;
  }
	
  inline double signmu_input () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    return this->SIGNMU;
  }
	
  inline double A0_input () {
    if  (spectrum_loaded == 0) {
      std::cout << "no SLHA file loaded" << std::endl;
      return -1;
    }
			
    return this->A0;
  }
	
		

	
}; //End sRates class


#endif
