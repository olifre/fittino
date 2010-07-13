#ifndef BOL_PARTICLE_PROPERTY_SET_H
#define BOL_PARTICLE_PROPERTY_SET_H


#include "BOL_particle_decay_set_handler.h"


class BOL_particle_property_set
// instances of this class hold all the relevant data about a type of particle,
// typically gleaned from a SLHA-format output file from a spectrum generator, such as SPheno.
// this code assumes CP invariance, so antiparticles have the same masses as their particles,
// and the same decay widths and branching ratios into the conjugate decays.
{

 protected:

  int PDG_code;  // see codes at the start of this file.  note that antiparticles get negative versions of the particle codes.

  double mass;

  std::string name;

  double decay_width;

  bool counts_as_stable_invisible_flag;
  // if true, escapes from the LHC detectors, such as neutrinos or lightest neutralinos.

  bool counts_as_jet_flag; 
  // if true, basically "is a quark or a gluon"

  bool counts_as_light_lepton_flag;
  // if true, basically "is an electron or a muon"

  bool counts_as_self_conjugate_flag; 
  // if true, the particle is also its own antiparticle as far as this code is concerned.

  BOL_particle_decay_set_handler* direct_decays;
  // this handles all the direct decays of this particle.

  BOL_particle_decay_set_handler* cascade_decays;
  // this handles all the cascade decays of this particle.


 public:

  BOL_particle_property_set( int constructing_PDG_code,
			     std::string constructing_name,
			     bool constructing_counts_as_stable_invisible,
			     bool constructing_counts_as_jet,
			     bool constructing_counts_as_light_lepton,
			     bool constructing_counts_as_self_conjugate )
    // constructor, allocates memory for the name & the vector of BOL_particle_decay instances.
    ;


  // getters, setters and other inline functions 

  inline int get_PDG_code()
    {
      return this->PDG_code;
    };


  inline double get_mass()
    {
      return this->mass;
    };


  inline BOL_particle_property_set* set_mass( double input_mass )
    {
      this->mass = input_mass;
      return this;
    };


  inline double get_decay_width()
    {
      return this->decay_width;
    };


  inline BOL_particle_property_set* set_decay_width( double input_decay_width )
    {
      this->decay_width = input_decay_width;
      return this;
    };


  inline std::string get_name()
    {
      return this->name;
    };


  inline BOL_particle_property_set* set_name( std::string input_name )
    {
      this->name = input_name;
      return this;
    };



  inline std::list< BOL_particle_decay* >* get_direct_decays()
    {
      return this->direct_decays->get_decay_set();
    };


  inline BOL_particle_decay_set_handler* get_direct_decay_handler()
    {
      return this->direct_decays;
    };


  inline std::list<BOL_particle_decay* >* get_cascade_decays()
    {
      return this->cascade_decays->get_decay_set();
    };


  inline BOL_particle_decay_set_handler* get_cascade_handler()
    {
      return this->cascade_decays;
    };


  inline bool make_count_as_stable_invisible( bool should_be_stable_invisible )
    // this might have to be set because a sneutrino might be the LSP instead of the lightest neutralino.
    {
      this->counts_as_stable_invisible_flag = should_be_stable_invisible;
      return this->counts_as_stable_invisible_flag;
    };


  inline bool counts_as_stable_invisible()
    {
      return this->counts_as_stable_invisible_flag;
    };


  inline bool counts_as_jet()
    {
      return this->counts_as_jet_flag;
    };


  inline bool counts_as_light_lepton()
    {
      return this->counts_as_light_lepton_flag;
    };


  inline bool counts_as_self_conjugate()
    {
      return this->counts_as_self_conjugate_flag;
    };



  inline BOL_particle_decay* add_direct_decay( int product_PDG_code_one,
					       int product_PDG_code_two,
					       double input_branching_ratio )
    {
      return (this->direct_decays->add_decay( product_PDG_code_one,
					      product_PDG_code_two,
					      input_branching_ratio ));
    };


  inline BOL_particle_decay* add_cascade_decay( int product_PDG_code_one,
						int product_PDG_code_two,
						double input_branching_ratio )
    {
      return (this->cascade_decays->add_decay( product_PDG_code_one,
					       product_PDG_code_two,
					       input_branching_ratio ));
    };


  inline BOL_particle_decay* add_direct_decay( int product_PDG_code_one,
					       int product_PDG_code_two,
					       int product_PDG_code_three,
					       double input_branching_ratio )
    {
      return (this->direct_decays->add_decay( product_PDG_code_one,
					      product_PDG_code_two,
					      product_PDG_code_three,
					      input_branching_ratio ));
    };


  inline BOL_particle_decay* add_cascade_decay( int product_PDG_code_one,
						int product_PDG_code_two,
						int product_PDG_code_three,
						double input_branching_ratio )
    {
      return (this->cascade_decays->add_decay( product_PDG_code_one,
					       product_PDG_code_two,
					       product_PDG_code_three,
					       input_branching_ratio ));
    };


  inline BOL_particle_decay* add_direct_decay( BOL_particle_decay::BOL_particle_decay* decay_to_be_copied )
    {
      return (this->direct_decays->add_decay( decay_to_be_copied ));
    };


  inline BOL_particle_decay* add_cascade_decay( BOL_particle_decay::BOL_particle_decay* decay_to_be_copied )
    {
      return (this->cascade_decays->add_decay( decay_to_be_copied ));
    };

  // add_decay for 4- or 5-body decays or even more complicated decays is a bit of a waste of time.



  ~BOL_particle_property_set()  // destructor.
    ;
};

#endif
