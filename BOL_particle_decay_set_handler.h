#ifndef BOL_PARTICLE_DECAY_SET_HANDLER_H
#define BOL_PARTICLE_DECAY_SET_HANDLER_H

#include "BOL_particle_decay.h"


class BOL_particle_decay_set_handler  // an instance of this class holds a list of BOL_particle_decay instances.
// it handles the addition of decays to the BOL_particle_property_set instance, & might gain more
// methods if i think of any that would be useful.
{

 protected:

  std::list< BOL_particle_decay* >* decay_set;  // i think a std::list is best here, for merge_identical_decays().


 public:

  inline BOL_particle_decay_set_handler()  // constructor.
    {
      decay_set = new std::list< BOL_particle_decay* >;
    };



  // getters, setters and other inline functions:

  inline BOL_particle_decay* add_decay( int product_PDG_code_one,
					int product_PDG_code_two,
					double input_branching_ratio )
    // this creates a new BOL_particle_decay with the input, then adds a pointer to it to the vector of pointers to the BOL_particle_decay
    // instances of this BOL_particle_property_set.  N.B.: this does not check that the decay does not already exist for this particle!
    {

      BOL_particle_decay* pointer_to_decay_to_be_added
	= new BOL_particle_decay( product_PDG_code_one,
				  product_PDG_code_two,
				  input_branching_ratio );

      this->decay_set->push_back( pointer_to_decay_to_be_added );

      return pointer_to_decay_to_be_added;
      
    };


  inline BOL_particle_decay* add_decay( int product_PDG_code_one,
					int product_PDG_code_two,
					int product_PDG_code_three,
					double input_branching_ratio )
    // this creates a new BOL_particle_decay with the input, then adds a pointer to it to the vector of pointers to the BOL_particle_decay
    // instances of this BOL_particle_property_set.  N.B.: this does not check that the decay does not already exist for this particle!
    {

      BOL_particle_decay* pointer_to_decay_to_be_added =
	new BOL_particle_decay( product_PDG_code_one,
				product_PDG_code_two,
				product_PDG_code_three,
				input_branching_ratio );

      this->decay_set->push_back( pointer_to_decay_to_be_added );

      return pointer_to_decay_to_be_added;

    };


  inline BOL_particle_decay* add_decay(BOL_particle_decay* decay_to_be_copied )
    // this creates a new BOL_particle_decay with the input, then adds a pointer to it to the vector of pointers to the BOL_particle_decay
    // instances of this BOL_particle_property_set.  N.B.: this does not check that the decay does not already exist for this particle!
    {

      BOL_particle_decay* pointer_to_decay_to_be_added =
	new BOL_particle_decay( decay_to_be_copied );
      
      this->decay_set->push_back( pointer_to_decay_to_be_added );

      return pointer_to_decay_to_be_added;

    };

  // add_decay for 4- or 5-body decays or even more complicated decays is a bit of a waste of time.


  inline std::list< BOL_particle_decay* >* get_decay_set()
    {

      return this->decay_set;

    };


  // non-inline functions (in .cpp file):

  BOL_particle_decay_set_handler* become_copy_of( BOL_particle_decay_set_handler* decay_handler_to_copy )
    // this copies a BOL_particle_decay_set_handler instance.
    ;


  std::list< BOL_particle_decay* >* copy_decay_set(std::list< BOL_particle_decay* >* decay_sets_to_copy )
    // this copies a BOL_particle_decay_set_handler instance.
    ;


  double get_branching_ratio_for_exact_match( int product_PDG_code_one,
					      int product_PDG_code_two )
    // this looks for the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated with the decay
    // if found, or else 0.0 if not.
    ;


  double get_branching_ratio_for_exact_match( int product_PDG_code_one,
					      int product_PDG_code_two,
					      int product_PDG_code_three )
    // this looks for the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated with the decay
    // if found, or else 0.0 if not.
    ;


  double get_branching_ratio_for_exact_match( std::list< int >* input_PDG_code_list )
    // this looks for an exact match to the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated
    // with the decay if found, or else 0.0 if not.
    ;


  double get_branching_ratio_for_subset( std::list< int >* sought_subset_PDG_code_list )
    // this looks for the given set of PDG codes for matches to subsets amongst this instance's decays, without caring what the remainder
    // (if any) of the particles in any decay is, & returns the aggregate branching ratio of all these decays.
    ;


  double get_branching_ratio_for_subset( std::list< int >* sought_subset_PDG_code_list,
					 std::list< int >* excluded_PDG_code_list )
    // this looks for the given set of PDG codes for matches to subsets amongst this instance's decays, checking if any of the particles
    // in the remainder (if any) in each decay appear on the exclusion list, & returns the aggregate branching ratio of all the decays
    // which have the subset & do not have any excluded particles in the remainder.
    ;
  
  
  int merge_identical_decays()
    // this checks all the decays in the decay handler to see if there are identical sets of decay products, & then if there are, it adds
    // the BR of every identical set after the 1st encountered to the 1st set's BR, & erases the other.
    ;
  

  ~BOL_particle_decay_set_handler()
    // destructor.  unfortunately this class allocates a lot of memory, in a complicated way.
    // i hope that this destructor is correct.
    ;

};

#endif

