#include "BOL_particle_property_set.h"


BOL_particle_property_set::BOL_particle_property_set( int constructing_PDG_code,
						      std::string constructing_name,
						      bool constructing_counts_as_stable_invisible,
						      bool constructing_counts_as_jet,
						      bool constructing_counts_as_light_lepton,
						      bool constructing_counts_as_self_conjugate )
// constructor, allocates memory for the name & the vector of BOL_particle_decay instances.
{

  this->PDG_code = constructing_PDG_code;

  this->name = constructing_name;

  this->counts_as_stable_invisible_flag = constructing_counts_as_stable_invisible;

  this->counts_as_jet_flag = constructing_counts_as_jet;

  this->counts_as_light_lepton_flag = constructing_counts_as_light_lepton;

  this->counts_as_self_conjugate_flag = constructing_counts_as_self_conjugate;

  this->mass = REALLY_WRONG_VALUE; 
  // this is to note that a mass has not been given for this particle property set,
  // as opposed to guessing whether it should be really massless, or if its mass was never given.

  this->decay_width = REALLY_WRONG_VALUE;
  // this is to note that a decay width has not been given for this particle property set,
  // as opposed to guessing whether it should be really stable,
  // or if its decay width was never given.

  this->direct_decays = new BOL_particle_decay_set_handler;

  this->cascade_decays = new BOL_particle_decay_set_handler;

}



BOL_particle_property_set::~BOL_particle_property_set()  // destructor.
{
  delete this->direct_decays;
  this->direct_decays = NULL;

  delete this->cascade_decays;
  this->cascade_decays = NULL;
}

