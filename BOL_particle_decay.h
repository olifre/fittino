// Ben O'Leary, 11th January 2010.  NOT FOR PUBLIC DISTRIBUTION.  If this code has been included in a public release,
// covered by the GNU license agreement or similar, then this warning is obviously a holdover from pre-release,
// & should be disregarded in favor of the release agreement.

// this is the .h file for a set of C++ classes that are basically just for containing & manipulating the data for a spectrum of
// particles, read in from an SLHA-format file.  it was intended to be used with the classes in BOL_EW_scale_spectrum.h.


/*********************************************************************
 *                                                                   *
 * IMPORTANT!                                                        *
 *                                                                   *
 * welcome, person who has decided to read this file.                *
 *                                                                   *
 * i hope that you will find these classes easy to use.  i have      *
 * tried to make the variable names self-explanatory, & hope that    *
 * the comments are adequate to explain the logic of the code.       *
 *                                                                   *
 * all dimensionful quantities in the code are assumed to be in GeV. *
 *                                                                   *
 * this file was written to be used in conjuction with the classes   *
 * in BOL_EW_scale_spectrum.h, but maybe they're useful on their   *
 * own too.  they're in a file separately for neatness.              *
 *                                                                   *
 *********************************************************************/


// this should prevent this class being included multiple times.

#ifndef BOL_PARTICLE_DECAY_H
#define BOL_PARTICLE_DECAY_H

// other defines:

#define REALLY_WRONG_VALUE -10000000000.0

// includes:

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <vector>
#include <list>
#include <string>
#include <sstream>



class BOL_particle_decay
// this is a class to hold a variable-length set of PDG codes that represent the possible decay products of a particle.
// instances of this class do not know which particle decays into these sets, rather they belong to a BOL_particle_property_set instance.
{

 protected:

  std::list< int >* decay_product_PDG_codes;
  // it is most convenient to have a std::list to hold the decays, as shown in BOL_EW_scale_spectrum::find_all_cascade_decays().

  double branching_ratio;


 public:

  BOL_particle_decay( int product_PDG_code_one,
		      int product_PDG_code_two,
		      double input_branching_ratio ) // constructor for a 2-body decay.
    ;


  BOL_particle_decay( int product_PDG_code_one,
		      int product_PDG_code_two,
		      int product_PDG_code_three,
		      double input_branching_ratio )  // constructor for a 3-body decay.
    ;

  // further constructors (4-body, 5-body, & so forth) are a bit of a waste of time.


  BOL_particle_decay( BOL_particle_decay* particle_decay_to_copy ) // copying constructor.
    ;


  // getters, setters and other inline functions:

  inline std::list< int >* get_decay_product_PDG_codes()
    {

      return this->decay_product_PDG_codes;

    };


  inline double get_branching_ratio()
    {

      return this->branching_ratio;

    };
  

  inline BOL_particle_decay* set_branching_ratio( double input_branching_ratio )
    {
    
      this->branching_ratio = input_branching_ratio;
    
      return this;
    
    };
  

  inline bool has_as_subset( std::list< int >* sought_subset_PDG_code_list )
    // compares the decay products against a variable amount of given PDG codes.
    {
    
      std::list< int > empty_exclusion_list;

      return this->has_as_subset( sought_subset_PDG_code_list, &empty_exclusion_list );
    
    };
  

  // non-inline functions (in .cpp file):

  bool has_this_PDG_code( int input_PDG_code )
    // checks to see if the sought particle is among the decay products.
    ;
  

  bool has_as_subset( std::list< int >* sought_subset_PDG_code_list,
		      std::list< int >* excluded_PDG_code_list )
    // compares the decay products against a variable amount of given PDG codes, along with a list of excluded PDG codes.
    ;


  bool is_same_as( int product_PDG_code_one,
		   int product_PDG_code_two )
    // compares the decay products against a pair of given PDG codes.
    ;


  bool is_same_as( int product_PDG_code_one,
		   int product_PDG_code_two,
		   int product_PDG_code_three )
    // compares the decay products against a set of 3 given PDG codes.
    ;
  

  bool is_same_as( std::list< int >* input_PDG_code_list )
    // compares the decay products against a variable amount of given PDG codes.
    ;

  
  ~BOL_particle_decay()  // destructor.
    ;

};


#endif
