// Ben O'Leary, 8th December 2009.  NOT FOR PUBLIC DISTRIBUTION.  If this code has been included in a public release,
// covered by the GNU license agreement or similar, then this warning is obviously a holdover from pre-release,
// & should be disregarded in favor of the release agreement.

// this is the .hpp file for a set of C++ classes that are basically just the set of masses of a particle (+ sparticle) spectrum,
// stored as a variable-sized vector array of BOL_particle_property_set instances (see BOL_particle_data.hpp).
// there is an internal ordering, but data are sought by means of the PDG MC codes for particles.
// (there is a possibility that i will implement lookup-by-name, but that's probably too much work to be worth it.)


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
 * following some stuff i read in a book, i have tried to stick to   *
 * object-oriented principles, & thus tried to make my classes       *
 * closed to modification, but open to extension.  hence, if you are *
 * intending to modify this code to accommodate a spectrum for a     *
 * different extension of the Standard Model, please have a look at  *
 * how the BOL_EW_scale_MSSM_spectrum class extends the              *
 * BOL_EW_scale_SM_spectrum class, & how the                         *
 * BOL_EW_scale_NMSSM_spectrum class extends the                     *
 * BOL_EW_scale_MSSM_spectrum class. 
 * PLEASE NOTE that i have just used the PDG MC codes that the       *
 * authors of Fittino used for the NMSSM particles (which, in turn,  *
 * came from that made up by Werner Porod for use in SPheno), since, *
 * as far as i know, they have not yet been assigned.                *
 * AS AN EXAMPLE, i have given the 2 extra scalar boson states       *
 * numbers 45 & 46 (neutral scalar & pseudoscalar), & the 5th        *
 * neutralino number 1000045.                                        * 
 *                                                                   *
 * also, a note on antiparticles: the BOL_EW_scale_spectrum class    *
 * only holds data for the particles with positive PDG MC codes.     *
 * the antiparticles, which have the negative versions of the PDG MC *
 * codes for the particles, are assumed to have exactly the same     *
 * mass and decay width, and to decay into exactly the same decays   *
 * but with particles replaced by their antiparticles and            *
 * antiparticles replaced with their particles, as their particles.  *
 * accessing a property set with the antiparticle PDG MC code will   *
 * result in receiving the property set of the particle with         *
 * positive PDG MC code.  it is up to the user to deal with any      *
 * antiparticle-specific stuff.  e.g., maybe going down a sbottom    *
 * chain where it decays to a negative chargino (-1000024) and then  *
 * looking for the chargino decays to a sneutrino and the lepton     *
 * with the correct charge.  particles which are also their own      *
 * antiparticles have counts_as_self_conjugate_flag as true, and all *
 * the methods should correctly relabel negative PDG MC codes for    *
 * these particles back to the positive versions.                    *
 *                                                                   *
 *********************************************************************/


// this should prevent this class being included multiple times.

#ifndef BOL_EW_SCALE_SPECTRUM_H
#define BOL_EW_SCALE_SPECTRUM_H


// other defines:

#define REALLY_WRONG_VALUE -10000000000.0


/*********************************************************************
 *                                                                   *
 * important!                                                        *
 *                                                                   *
 * the internal ordering of the particles IS NOT THE ORDER IN WHICH  *
 * THE PARTICLES APPEAR BELOW IN THE #define BIT for the PDG MC      *
 * codes.  the ordering is defined by the constructor and doesn't    *
 * actually matter, unless one has modified the code to look         *
 * in the std::vector arrays directly, which is BAD PRACTICE!        *
 * all these classes were built around the idea of looking up by     *
 * PDG MC code.                                                      *
 *                                                                   *
 *********************************************************************/

// includes:

#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <vector>
#include <list>
#include <string>
#include <sstream>

#include "BOL_particle_property_set.h"
#include "PDG.h" 



class BOL_EW_scale_spectrum
// instances of this class are basically vector arrays of instances of the BOL_particle_property_set class.
// this class handles unexpected input by adding extra particles for PDG codes that it hadn't know about so
// far (calling them "unknown_particle_1", "unknown_particle_2", "unknown_particle_3"...).
{

protected: 
  // this stuff is to be inherited by classes such as BOL_EW_scale_SM_spectrum & BOL_EW_scale_MSSM_spectrum.

  std::vector<BOL_particle_property_set* >* particle_property_sets;
  // this is a pointer to a vector array of pointers to BOL_particle_property_set instances.
  // i think a std::vector is marginally more efficient than a std::list, especially since there
  // should be no need to ever insert a decay anywhere other than the end of the std::vector.
  // also, i think it's easier to read stuff without iterators.

  int number_of_unknown_particles;


public:


  //constructor
  BOL_EW_scale_spectrum();

  //copy constructor  
  BOL_EW_scale_spectrum(BOL_EW_scale_spectrum* copy_source );  

  //getter
  inline int get_number_of_unknown_particles()
  {
    return this->number_of_unknown_particles;
  };

  //getter
  inline std::vector< BOL_particle_property_set* >* get_particle_property_sets()
  {
    return this->particle_property_sets;
  };



  BOL_particle_property_set* add_particle_property_set(int constructing_PDG_code,
						       std::string constructing_name,
						       bool constructing_counts_as_stable_invisible,	
						       bool constructing_counts_as_jet,
						       bool constructing_counts_as_light_lepton,
						       bool constructing_counts_as_self_conjugate );


  
  BOL_particle_property_set* add_unknown_particle_property_set( int constructing_PDG_code )
  // this creates a new instance of a BOL_particle_property_set, with a name indicating that its PDG code was unknown to this point,
  // not counting as stable-&-invisible, as a jet, as a light lepton or self-conjugate.  it then adds a pointer to it to the list of
  // pointers to instances of the BOL_particle_property_set class, & returns the pointer.  if given a negative PDG code, this method
  // swaps its sign.
  ;


  BOL_particle_property_set* get_particle_property_set( int sought_PDG_code )
  // this returns the pointer to the BOL_particle_property_set with the sought PDG code.  it returns NULL if the PDG code was not found.
  // if provided with a negative PDG code, it returns a pointer to the particle property set with the positive PDG code, if it is found.
  ;


  double get_PDG_coded_mass( int input_PDG_code )
  // this checks to see if there is a particle property set with the input PDG code, or the positive PDG code if a negative PDG code is
  // provided, then if there is, returns its mass, otherwise REALLY_WRONG_VALUE.
  ;


  std::string get_PDG_coded_name( int input_PDG_code )
  // this checks to see if there is a particle property set with the input PDG code, then if there is, returns its name, otherwise
  // REALLY_WRONG_VALUE.  this method accounts for negative PDG codes by returning the particle's name, prefixed with "anti-".
  ;


  BOL_particle_property_set* record_PDG_coded_mass( int input_PDG_code,
									       double input_mass )
  // this records a mass for a particle specified by its PDG code.  if the antiparticle's PDG code is given, the mass is instead recorded
  // for the particle.
  ;


  BOL_particle_property_set* record_PDG_coded_decay_width( int input_PDG_code,
							   double input_decay_width )
  // this records a decay width for a particle specified by its PDG code.  if the antiparticle's PDG code is given, the decay width is
  // instead recorded for the particle.
  ;


  BOL_particle_property_set* record_PDG_coded_direct_decay( int decayer_PDG_code,
							    int product_PDG_code_one,
							    int product_PDG_code_two,
							    double input_branching_ratio )
  // this adds a 2-body decay to a particle property set with the specified PDG code, or if no particle property set with that PDG code
  // exists, it creates a new property set & adds the decay to that.  if an antiparticle's PDG code is given, the decay for the particle
  // (with decay product particles replaced by antiparticles & decay product antiparticles replaced by particles) is recorded instead.
  ;


  BOL_particle_property_set* record_PDG_coded_direct_decay( int decayer_PDG_code,
							    int product_PDG_code_one,
							    int product_PDG_code_two,
							    int product_PDG_code_three,
							    double input_branching_ratio )
    // this adds a 3-body decay to a particle property set with the specified PDG code, or if no particle property set with that PDG code
  // exists, it creates a new property set & adds the decay to that.  if an antiparticle's PDG code is given, the decay for the particle
  // (with decay product particles replaced by antiparticles & decay product antiparticles replaced by particles) is recorded instead.
  ;


  std::string get_decay_as_string(BOL_particle_decay* decay_to_have_as_string )
	                                                      // this returns a string that is the decay with names as well as PDG codes.
  ;


  int find_all_cascade_decays( double minimum_branching_ratio_to_keep )
  // this goes through each possible set of final stable particles from each particle's decay.  if the branching ratio for any particular
  // cascade decay goes below miminum_branching_ratio_to_keep, the cascade is deleted.
  // N.B. it is up to the user to ensure an appropriate minimum branching ratio is applied!  if there are several identical final-state
  // cascades that are just below the threshold but add together to be over the threshold, they will not be kept!  so the user needs to
  // give a bit of leeway, such as picking an order of magnitude smaller a threshold.
  // i'd put this into the BOL_particle_property_set class, but each particle needs to know about all the other particles.
  // actually, currently it's not particularly useful, since experimental cuts will affect different cascades differently.
  ;


  ~BOL_EW_scale_spectrum();  // destructor.  unfortunately this class allocates a lot of memory, in a complicated way.
                            // i hope that this destructor is correct.
  

};


#endif
