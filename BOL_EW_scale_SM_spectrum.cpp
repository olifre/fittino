#include "BOL_EW_scale_SM_spectrum.h"

BOL_EW_scale_SM_spectrum::BOL_EW_scale_SM_spectrum() : BOL_EW_scale_spectrum() 
						  // constructor: creates an instance of the BOL_EW_scale_spectrum class
						  // & then adds in the SM particles
{

  std::string name_enterer;

  // add down quark.
  name_enterer = "down_quark";
  this->add_particle_property_set( PDG_down_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_down_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add up quark.
  name_enterer = "up_quark";
  this->add_particle_property_set( PDG_up_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_up_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add strange quark.
  name_enterer = "strange_quark";
  this->add_particle_property_set( PDG_strange_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_strange_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add charm quark.
  name_enterer = "charm_quark";
  this->add_particle_property_set( PDG_charm_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_charm_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add bottom quark.
  name_enterer = "bottom_quark";
  this->add_particle_property_set( PDG_bottom_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_bottom_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add top quark.
  name_enterer = "top_quark";
  this->add_particle_property_set( PDG_top_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_top_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for quarks decaying.

  // add electron.
  name_enterer = "electron";
  this->add_particle_property_set( PDG_electron_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   true,  // does count as a light lepton.
				   false )->set_mass( PDG_electron_MASS );  // does not count as self-conjugate.
  this->get_particle_property_set( PDG_electron_CODE )->set_decay_width( 0.0 );

  // add electron neutrino.  currently, this code treats neutrinos as Dirac fermions, so are have self_conjugate_flag = false.
  name_enterer = "electron_neutrino";
  this->add_particle_property_set( PDG_electron_neutrino_CODE,
				   name_enterer,
				   true,  // does count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_electron_neutrino_MASS );  // does not count as self-conjugate.
  this->get_particle_property_set( PDG_electron_neutrino_CODE )->set_decay_width( 0.0 );
  // this code also doesn't care about the mismatch between flavor & mass eigenstates for neutrinos, nor the decays of the heavier ones.

  // add muon.
  name_enterer = "muon";
  this->add_particle_property_set( PDG_muon_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   true,  // does count as a light lepton.
				   false )->set_mass( PDG_muon_MASS );  // does not count as self-conjugate.
  // this constructor doesn't account for muons decaying.

  // add muon neutrino.  currently, this code treats neutrinos as Dirac fermions, so are have self_conjugate_flag = false.
  name_enterer = "muon_neutrino";
  this->add_particle_property_set( PDG_muon_neutrino_CODE,
				   name_enterer,
				   true,  // does count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_muon_neutrino_MASS );  // does not count as self-conjugate.
  this->get_particle_property_set( PDG_muon_neutrino_CODE )->set_decay_width( 0.0 );
  // this code also doesn't care about the mismatch between flavor & mass eigenstates for neutrinos, nor the decays of the heavier ones.

  // add tau lepton.
  name_enterer = "tau_lepton";
  this->add_particle_property_set( PDG_tau_lepton_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_tau_lepton_MASS );  // does not count as self-conjugate.

  // add tau neutrino.  currently, this code treats neutrinos as Dirac fermions, so are have self_conjugate_flag = false.
  name_enterer = "tau_neutrino";
  this->add_particle_property_set( PDG_tau_neutrino_CODE,
				   name_enterer,
				   true,  // does count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_tau_neutrino_MASS );  // does not count as self-conjugate.
  this->get_particle_property_set( PDG_tau_neutrino_CODE )->set_decay_width( 0.0 );
  // this code also doesn't care about the mismatch between flavor & mass eigenstates for neutrinos, nor the decays of the heavier ones.

  // add gluon.
  name_enterer = "gluon";
  this->add_particle_property_set( PDG_gluon_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   true,  // does count as a jet.
				   false,  // does not count as a light lepton.
				   true )->set_mass( PDG_gluon_MASS );  // does count as self-conjugate.
  this->get_particle_property_set( PDG_gluon_CODE )->set_decay_width( 0.0 );

  // add photon.
  name_enterer = "photon";
  this->add_particle_property_set( PDG_photon_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true )->set_mass( PDG_photon_MASS );  // does count as self-conjugate.
  this->get_particle_property_set( PDG_photon_CODE )->set_decay_width( 0.0 );

  // add Z boson.  all its decays are taken from the PDG on 2009-11-08.
  name_enterer = "Z_boson";
  this->add_particle_property_set( PDG_Z_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true )->set_mass( PDG_Z_MASS );  // does count as self-conjugate.
  this->get_particle_property_set( PDG_Z_CODE )->set_decay_width( PDG_Z_DECAY_WIDTH  );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_electron_CODE,
				       -PDG_electron_CODE,
				       PDG_Z_electron_antielectron_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_muon_CODE,
				       -PDG_muon_CODE,
				       PDG_Z_muon_antimuon_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_tau_lepton_CODE,
				       -PDG_tau_lepton_CODE,
				       PDG_Z_tau_lepton_antilepton_BR );
  // assume the invisible decays of Z are equally divided between the 3 flavors of neutrino:
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_electron_neutrino_CODE,
				       -PDG_electron_neutrino_CODE,
				       PDG_Z_electron_neutrino_antineutrino_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_muon_neutrino_CODE,
				       -PDG_muon_neutrino_CODE,
				       PDG_Z_muon_neutrino_antineutrino_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_tau_neutrino_CODE,
				       -PDG_tau_neutrino_CODE,
				       PDG_Z_tau_neutrino_antineutrino_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_charm_CODE,
				       -PDG_charm_CODE,
				       PDG_Z_charm_anticharm_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_bottom_CODE,
				       -PDG_bottom_CODE,
				       PDG_Z_bottom_antibottom_BR );
  // assume the rest of the hadronic decay width of the Z is equally divided between down, up and strange:
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_down_CODE,
				       -PDG_down_CODE,
				       PDG_Z_down_antidown_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_up_CODE,
				       -PDG_up_CODE,
				       PDG_Z_up_antiup_BR );
  this->record_PDG_coded_direct_decay( PDG_Z_CODE,
				       PDG_strange_CODE,
				       -PDG_strange_CODE,
				       PDG_Z_strange_antistrange_BR );

  // add W boson.  all its decays are taken from the PDG on 2009-11-08.
  name_enterer = "W_plus_boson";
  this->add_particle_property_set( PDG_W_plus_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false )->set_mass( PDG_W_plus_MASS );  // does not count as self-conjugate.
  this->get_particle_property_set( PDG_W_plus_CODE )->set_decay_width( PDG_W_plus_DECAY_WIDTH );
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_electron_neutrino_CODE,
				       -PDG_electron_CODE,
				       PDG_W_plus_neutrino_antielectron_BR );
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_muon_neutrino_CODE,
				       -PDG_muon_CODE,
				       PDG_W_plus_neutrino_antimuon_BR );
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_tau_neutrino_CODE,
				       -PDG_tau_lepton_CODE,
				       PDG_W_plus_neutrino_tau_antilepton_BR );
  // assume that the BRs into charm + antidown & charm + antistrange account for all the BR of the charm + X,
  // in the ratio ( |V_cd|^2 ) to ( |V_cs|^2 ):
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_charm_CODE,
				       -PDG_down_CODE,
				       PDG_W_plus_charm_antidown_BR );
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_charm_CODE,
				       -PDG_strange_CODE,
				       PDG_W_plus_charm_antistrange_BR );
  // assume the rest of the hadronic decay width of the W is divided between up + antidown and up + antistrange
  // in the ratio ( |V_ud|^2 ) to ( |V_us|^2 ):
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_up_CODE,
				       -PDG_down_CODE,
				       PDG_W_plus_up_antidown_BR );
  this->record_PDG_coded_direct_decay( PDG_W_plus_CODE,
				       PDG_up_CODE,
				       -PDG_strange_CODE,
				       PDG_W_plus_up_antistrange_BR );

  // add electroweak-symmetry-breaking scalar boson.
  name_enterer = "Higgs_boson";
  this->add_particle_property_set( PDG_light_neutral_EWSB_scalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

}


