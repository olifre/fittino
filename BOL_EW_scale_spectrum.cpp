#include "BOL_EW_scale_spectrum.h"



BOL_EW_scale_spectrum::BOL_EW_scale_spectrum()  // constructor.
{

  this->particle_property_sets = new std::vector< BOL_particle_property_set* >;
  // this allocates the memory for a vector array of pointers for BOL_particle_property_set instances,
  // but does not allocate the memory for the instances.

  this->number_of_unknown_particles = 0;

}


BOL_EW_scale_spectrum::BOL_EW_scale_spectrum(BOL_EW_scale_spectrum* copy_source ) 
// copying constructor.
{

  this->particle_property_sets = new std::vector< BOL_particle_property_set* >;
  // this allocates the memory for a vector array of pointers for BOL_particle_property_set instances,
  // but does not allocate the memory for the instances.

  this->number_of_unknown_particles = copy_source->get_number_of_unknown_particles();

  for( int copying_counter = ( copy_source->get_particle_property_sets()->size() - 1 );
       copying_counter >= 0;
       copying_counter-- )  // for each particle in the spectrum to be copied...
    {

      this->add_particle_property_set( copy_source->get_particle_property_sets()->at( copying_counter )->get_PDG_code(),
				       copy_source->get_particle_property_sets()->at( copying_counter )->get_name(),
				       copy_source->get_particle_property_sets()->at( copying_counter )->counts_as_stable_invisible(),
				       copy_source->get_particle_property_sets()->at( copying_counter )->counts_as_jet(),
				       copy_source->get_particle_property_sets()->at( copying_counter )->counts_as_light_lepton(),
				       copy_source->get_particle_property_sets()->at( copying_counter )->counts_as_self_conjugate() );

    }

}



BOL_particle_property_set* BOL_EW_scale_spectrum::add_particle_property_set( int constructing_PDG_code,
									     std::string constructing_name,
									     bool constructing_counts_as_stable_invisible,
									     bool constructing_counts_as_jet,
									     bool constructing_counts_as_light_lepton,
									     bool constructing_counts_as_self_conjugate )
// this creates a new instance of a BOL_particle_property_set, adds a pointer to it to the list of pointers to instances of the
// BOL_particle_property_set class, & returns the pointer.  it is not responsible for checking that it has received a positive PDG code.
{

  BOL_particle_property_set* pointer_to_particle_to_be_added =new BOL_particle_property_set( constructing_PDG_code,
											     constructing_name,
											     constructing_counts_as_stable_invisible,
											     constructing_counts_as_jet,
											     constructing_counts_as_light_lepton,
											     constructing_counts_as_self_conjugate );

  this->particle_property_sets->push_back( pointer_to_particle_to_be_added );

  return pointer_to_particle_to_be_added;

}



BOL_particle_property_set* BOL_EW_scale_spectrum::add_unknown_particle_property_set( int constructing_PDG_code )
// this creates a new instance of a BOL_particle_property_set, with a name indicating that its PDG code was unknown to this point,
// not counting as stable-&-invisible, as a jet, as a light lepton or self-conjugate.  it then adds a pointer to it to the list of
// pointers to instances of the BOL_particle_property_set class, & returns the pointer.  if given a negative PDG code, this method
// swaps its sign.
{

  this->number_of_unknown_particles++;  // 1st, note that there is now another unknown particle in the spectrum.

  // sort out the name.
  std::ostringstream unknown_name_stream;
  unknown_name_stream << "unknown_particle_" << this->number_of_unknown_particles;

  std::string unknown_name_string = unknown_name_stream.str();

  if( constructing_PDG_code < 0 )  // if told to add an unknown antiparticle, add an unknown particle instead.
    {

      constructing_PDG_code *= -1;

    }

  // actually create the new particle property set & return a pointer to it.
  return (this->add_particle_property_set( constructing_PDG_code,
					   unknown_name_string,
					   false,  // unknown particles don't get to count as stable-&-invisible.
					   false,  // unknown particles don't get to count as jets.
					   false,  // unknown particles don't get to count as light leptons.
					   false ));  // unknown particles don't get to count as self-conjugate.

}


BOL_particle_property_set* BOL_EW_scale_spectrum::get_particle_property_set( int sought_PDG_code )
// this returns the pointer to the BOL_particle_property_set with the sought PDG code.  it returns NULL if the PDG code was not found.
// if provided with a negative PDG code, it returns a pointer to the particle property set with the positive PDG code, if it is found.
{

  BOL_particle_property_set* pointer_to_return = NULL;

  bool PDG_code_found_flag = false;


  if( sought_PDG_code < 0 )  // if told to look for an antiparticle, look for its particle instead.
    {

      sought_PDG_code *= -1;

    }


  // the loop actually goes backwards through the vector of particle property sets.
  int property_set_internal_position = ( this->particle_property_sets->size() - 1 );

  while( !PDG_code_found_flag && ( property_set_internal_position >= 0 ) )
    {

      if( this->particle_property_sets->at( property_set_internal_position )->get_PDG_code() == sought_PDG_code )
	{

	  PDG_code_found_flag = true;

	  pointer_to_return = this->particle_property_sets->at( property_set_internal_position );

	}

      property_set_internal_position--;  // go on to the next particle property set.

    }  // by the end of this while loop, either the PDG code has been found, & the pointer set to the property set with the PDG code,
       // or the loop went through all the elements & did not set the pointer to be anything other than NULL.

  return pointer_to_return;

}


double BOL_EW_scale_spectrum::get_PDG_coded_mass( int input_PDG_code )
// this checks to see if there is a particle property set with the input PDG code, or the positive PDG code if a negative PDG code is
// provided, then if there is, returns its mass, otherwise REALLY_WRONG_VALUE.
{

  double mass_to_return = REALLY_WRONG_VALUE;  // assume that the PDG code will not be found.

  if( input_PDG_code < 0 )  // if told to look for an antiparticle, look for its particle instead.
    {

      input_PDG_code *= -1;

    }

  if( this->get_particle_property_set( input_PDG_code ) != NULL )  // if there is a particle with this PDG code...
    {

      mass_to_return = this->get_particle_property_set( input_PDG_code )->get_mass();

    }

  return mass_to_return;

}


std::string BOL_EW_scale_spectrum::get_PDG_coded_name( int input_PDG_code )
// this checks to see if there is a particle property set with the input PDG code, then if there is, returns its name, otherwise
// REALLY_WRONG_VALUE.  this method accounts for negative PDG codes by returning the particle's name, prefixed with "anti-".
{

  std::string name_to_return = "error!";  // assume that the PDG code will not be found.

  if( input_PDG_code < 0 )  // if an antiparticle's name is being sought...
    {

      if( this->get_particle_property_set( -input_PDG_code ) != NULL )  // if there is a particle with this PDG code...
	{

	  name_to_return = this->get_particle_property_set( -input_PDG_code )->get_name();  // get the particle's name...
	  name_to_return.insert( 0, "anti-" );  // then shove "anti-" in front of it.

	}

    }
  else
    {

      if( this->get_particle_property_set( input_PDG_code ) != NULL )  // if there is a particle with this PDG code...
	{

	  name_to_return = this->get_particle_property_set( input_PDG_code )->get_name();  // get the particle's name.

	}

    }

  return name_to_return;

}


BOL_particle_property_set* BOL_EW_scale_spectrum::record_PDG_coded_mass( int input_PDG_code,
									 double input_mass )
// this records a mass for a particle specified by its PDG code.  if the antiparticle's PDG code is given, the mass is instead recorded
// for the particle.
{

  if( input_PDG_code < 0 )  // if an antiparticle was provided...
    {

      input_PDG_code *= -1;  // record for its particle instead.

    }

  BOL_particle_property_set::BOL_particle_property_set* sought_property_set = this->get_particle_property_set( input_PDG_code );

  if( sought_property_set != NULL )  // if there is a particle with this PDG code...
    {

      sought_property_set->set_mass( input_mass );  // set its mass.

    }
  else  // otherwise, create a new particle property set & set its mass.
    {

      this->add_unknown_particle_property_set( input_PDG_code )->set_mass( input_mass );

    }

  return sought_property_set;

}


BOL_particle_property_set* BOL_EW_scale_spectrum::record_PDG_coded_decay_width( int input_PDG_code,
										double input_decay_width )
// this records a decay width for a particle specified by its PDG code.  if the antiparticle's PDG code is given, the decay width is
// instead recorded for the particle.
{

  if( input_PDG_code < 0 )  // if an antiparticle was provided...
    {

      input_PDG_code *= -1;  // record for its particle instead.

    }

  BOL_particle_property_set* sought_property_set = this->get_particle_property_set( input_PDG_code );

  if( sought_property_set != NULL )  // if there is a particle with this PDG code...
    {

      sought_property_set->set_decay_width( input_decay_width );  // set its decay width.

    }
  else  // otherwise, create a new particle property set & set its decay width.
    {

      this->add_unknown_particle_property_set( input_PDG_code )->set_decay_width( input_decay_width );

    }

  return sought_property_set;

}


BOL_particle_property_set* BOL_EW_scale_spectrum::record_PDG_coded_direct_decay( int decayer_PDG_code,
										 int product_PDG_code_one,
										 int product_PDG_code_two,
										 double input_branching_ratio )
// this adds a 2-body decay to a particle property set with the specified PDG code, or if no particle property set with that PDG code
// exists, it creates a new property set & adds the decay to that.  if an antiparticle's PDG code is given, the decay for the particle
// (with decay product particles replaced by antiparticles & decay product antiparticles replaced by particles) is recorded instead.
{

  if( decayer_PDG_code < 0 )  // if an antiparticle was provided...
    {

      // flip the codes of all particles involved.
      decayer_PDG_code *= -1;
      product_PDG_code_one *= -1;
      product_PDG_code_two *= -1;

      // check to see if the spectrum knows the decay products & if they are self-conjugate,
      // in which case ensure that they have positive sign again.
      if( this->get_particle_property_set( product_PDG_code_one ) != NULL )
	{

	  if( ( product_PDG_code_one < 0 ) && this->get_particle_property_set( product_PDG_code_one )->counts_as_self_conjugate() )
	    {

	      product_PDG_code_one *= -1;

	    }

	}

      if( this->get_particle_property_set( product_PDG_code_two ) != NULL )
	{

	  if( ( product_PDG_code_two < 0 ) && this->get_particle_property_set( product_PDG_code_two )->counts_as_self_conjugate() )
	    {

	      product_PDG_code_two *= -1;

	    }

	}

    }





  BOL_particle_property_set* decayer_property_set = this->get_particle_property_set( decayer_PDG_code );

  if( decayer_property_set != NULL )  // if there is a particle with this PDG code...
    {

      decayer_property_set->add_direct_decay( product_PDG_code_one,
					      product_PDG_code_two,
					      input_branching_ratio );  // add the decay to the particle's properties.

    }
  else  // otherwise, create a new particle property set & add the decay.
    {

      this->add_unknown_particle_property_set( decayer_PDG_code )->add_direct_decay( product_PDG_code_one,
										     product_PDG_code_two,
										     input_branching_ratio );

    }

  return decayer_property_set;

}


BOL_particle_property_set* BOL_EW_scale_spectrum::record_PDG_coded_direct_decay( int decayer_PDG_code,
										 int product_PDG_code_one,
										 int product_PDG_code_two,
										 int product_PDG_code_three,
										 double input_branching_ratio )
// this adds a 3-body decay to a particle property set with the specified PDG code, or if no particle property set with that PDG code
// exists, it creates a new property set & adds the decay to that.  if an antiparticle's PDG code is given, the decay for the particle
// (with decay product particles replaced by antiparticles & decay product antiparticles replaced by particles) is recorded instead.
{

  if( decayer_PDG_code < 0 )  // if an antiparticle was provided...
    {

      // flip the codes of all particles involved.
      decayer_PDG_code *= -1;
      product_PDG_code_one *= -1;
      product_PDG_code_two *= -1;
      product_PDG_code_three *= -1;


      // check to see if the spectrum knows the decay products & if they are self-conjugate,
      // in which case ensure that they have positive sign again.
      if( this->get_particle_property_set( product_PDG_code_one ) != NULL )
	{

	  if( ( product_PDG_code_one < 0 )
	      && this->get_particle_property_set( product_PDG_code_one )->counts_as_self_conjugate() )
	    {

	      product_PDG_code_one *= -1;

	    }

	}

      if( this->get_particle_property_set( product_PDG_code_two ) != NULL )
	{

	  if( ( product_PDG_code_two < 0 )
	      && this->get_particle_property_set( product_PDG_code_two )->counts_as_self_conjugate() )
	    {

	      product_PDG_code_two *= -1;

	    }

	}

      if( this->get_particle_property_set( product_PDG_code_three ) != NULL )
	{

	  if( ( product_PDG_code_three < 0 )
	      && this->get_particle_property_set( product_PDG_code_three )->counts_as_self_conjugate() )
	    {

	      product_PDG_code_three *= -1;

	    }

	}

    }

  BOL_particle_property_set* decayer_property_set = this->get_particle_property_set( decayer_PDG_code );

  if( decayer_property_set != NULL )  // if there is a particle with this PDG code...
    {

      decayer_property_set->add_direct_decay( product_PDG_code_one,
					      product_PDG_code_two,
					      product_PDG_code_three,
					      input_branching_ratio );  // add the decay to the particle properties.

    }
  else  // otherwise, create a new particle property set & add the decay.
    {

      this->add_unknown_particle_property_set( decayer_PDG_code )->add_direct_decay( product_PDG_code_one,
										     product_PDG_code_two,
										     product_PDG_code_three,
										     input_branching_ratio );

    }

  return decayer_property_set;

}


std::string BOL_EW_scale_spectrum::get_decay_as_string( BOL_particle_decay::BOL_particle_decay* decay_to_have_as_string )
// this returns a string that is the decay with names as well as PDG codes.
{

  std::ostringstream decay_as_stringstream;

  decay_as_stringstream << "-> { ";

  int comma_count_to_insert = ( decay_to_have_as_string->get_decay_product_PDG_codes()->size() - 1 );

  for( std::list< int >::iterator decay_product_iterator = decay_to_have_as_string->get_decay_product_PDG_codes()->begin();
       decay_product_iterator != decay_to_have_as_string->get_decay_product_PDG_codes()->end();
       decay_product_iterator++ )
    {

      decay_as_stringstream << this->get_PDG_coded_name( *decay_product_iterator ) 
			    << " (" << *decay_product_iterator << ")";

      if( comma_count_to_insert > 0 )
	{

	  decay_as_stringstream << ", ";

	}

      comma_count_to_insert--;

    }

  decay_as_stringstream << " }";

  return decay_as_stringstream.str();

}


int BOL_EW_scale_spectrum::find_all_cascade_decays( double minimum_branching_ratio_to_keep )
// this goes through each possible set of final stable particles from each particle's decay.  if the branching ratio for any particular
// cascade decay goes below miminum_branching_ratio_to_keep, the cascade is deleted.
// N.B. it is up to the user to ensure an appropriate minimum branching ratio is applied!  if there are several identical final-state
// cascades that are just below the threshold but add together to be over the threshold, they will not be kept!  so the user needs to
// give a bit of leeway, such as picking an order of magnitude smaller a threshold.
// i'd put this into the BOL_particle_property_set class, but each particle needs to know about all the other particles.
// actually, currently it's not particularly useful, since experimental cuts will affect different cascades differently.
{

  if( minimum_branching_ratio_to_keep < 0.00001 )  // if this method was called with an insane argument...
    {

      // alert the user, for politeness.
      std::cout << std::endl << "WARNING!  find_all_cascade_decays was called with a minimum_branching_ratio_to_keep of less than"
		<< " 0.00001!  this could result in a VERY long wait, since there could be up to 10^5 or 10^6 decay chains for"
		<< " the gluino for example, and each of these 10^6 chains has to be compared to the other 10^6 - 1 chains"
		<< " leading to something like 10^12 comparisons.  in BOL's humble opinion, this is a real waste of time...";
      std::cout << std::endl << "(you might want to press ctrl-c to kill this program, and re-write the relevant bit of code.)";
      std::cout << std::endl;

    }


  int total_number_of_cascade_decays = 0;  // this keeps track of how many cascade decays we are recording.

  for( int cascader_counter = ( this->particle_property_sets->size() - 1 );
       cascader_counter >= 0;
       cascader_counter-- )  // for each particle in the spectrum...
    {

      BOL_particle_property_set::BOL_particle_property_set* current_cascader = this->particle_property_sets->at( cascader_counter );
      BOL_particle_property_set::BOL_particle_property_set* current_decay_product;

      bool cascader_finished = false;  // start by assuming that there are still unstable particles left in the cascade decay.
      //  int amount_of_cascades_from_here;

      // start with the basic direct decays of the particle.
      current_cascader->get_cascade_handler()->copy_decay_set( current_cascader->get_direct_decays() );

      while( !cascader_finished )  // until all the cascades have been done...
	{

	  cascader_finished = true;  // assume that this pass will show that this particle's cascades have all been finished.

	  if( !(current_cascader->get_cascade_decays()->empty()) )  // if there are decays for this particle...
	    {

	      // go through each (presumed unfinished) cascade decay for this particle.
	      std::list< BOL_particle_decay::BOL_particle_decay* >::iterator current_cascade_iterator =
		current_cascader->get_cascade_decays()->begin();
	      while( current_cascade_iterator != current_cascader->get_cascade_decays()->end() )
		{

		  if( (*current_cascade_iterator)->get_branching_ratio() < minimum_branching_ratio_to_keep )
		    // if this cascade has too low a branching ratio to begin with...
		    {

		      // delete the cascade.
		      delete (*current_cascade_iterator);
		      (*current_cascade_iterator) = NULL;
		      current_cascade_iterator = current_cascader->get_cascade_decays()->erase( current_cascade_iterator );

		    }
		  else
		    {

		      std::list< int >::iterator decay_iterator = (*current_cascade_iterator)->get_decay_product_PDG_codes()->begin();
		      bool found_unstable_decay_product = false;
		      while( !found_unstable_decay_product
			     && ( decay_iterator != (*current_cascade_iterator)->get_decay_product_PDG_codes()->end() ) )
			// until we find an unstable particle or we get to the end of the decay's list of particles...
			{

			  current_decay_product = this->get_particle_property_set( *decay_iterator );

			  // sometimes particles are recorded in the SHLA format with a negative mass,
			  // so here we have to check if the absolute masses are such that the decay would be kinematically allowed.
			  double decaying_mass = current_cascader->get_mass();
			  if( decaying_mass < 0.0 )
			    {

			      decaying_mass *= -1.0;

			    }

			  double product_mass = current_decay_product->get_mass();
			  if( product_mass < 0.0 )
			    {

			      product_mass *= -1.0;

			    }

			  if( !(current_decay_product->get_direct_decays()->empty())
			      && ( (decaying_mass  > product_mass )
				   || ( decaying_mass == REALLY_WRONG_VALUE ) ) )
			    // if this decay product is itself unstable...
			    // (as well as being lighter than the decaying particle, as a sanity check, which *should* prevent
			    // infinite loops from read-in garbage such as A decays to B & C, & B decays to A & C.)
			    // (the REALLY_WRONG_VALUE mass case is to allow unknown particles which have not had a mass recorded to
			    // decay.)
			    {

			      found_unstable_decay_product = true;  // note that we have found an unstable particle so we should stop
			                                            // looking for more in this particular set of decay products.

			      cascader_finished = false;
			      // note that we are not finished yet since we still have unstable particles to decay.

			      std::list< BOL_particle_decay::BOL_particle_decay* >* decays_to_insert;

			      if( !(current_decay_product->get_cascade_decays()->empty()) )
				// if this decay product already has had its cascade decays worked out...
				{

				  decays_to_insert = current_decay_product->get_cascade_decays();
				  // use the cascade decays as replacements for the unstable particle.

				}
			      else  // otherwise just use the direct decays.
				{

				  decays_to_insert = current_decay_product->get_direct_decays();

				}

			      // go through each decay.  it's easier to create a full new set of cascades & delete the original than
			      // to muck about with skipping a decay to keep for modifying the original cascade.
			      for( std::list< BOL_particle_decay::BOL_particle_decay* >::iterator decay_substitution_iterator =
				     decays_to_insert->begin();
				   decay_substitution_iterator != decays_to_insert->end();
				   decay_substitution_iterator++ )
				{

				  // add a new decay to the list of cascade decays with BR equal to the old BR times the BR for the
				  // unstable particle's decay which is being added.
				  double new_branching_ratio =
				    ( (*current_cascade_iterator)->get_branching_ratio() * (*decay_substitution_iterator)->get_branching_ratio() );

				  if( new_branching_ratio >= minimum_branching_ratio_to_keep )
				    // if the branching ratio for this cascade decay has not gotten too small...
				    {
				      BOL_particle_decay::BOL_particle_decay* cascade_duplicate =
					current_cascader->add_cascade_decay( *current_cascade_iterator );
				      cascade_duplicate->set_branching_ratio( new_branching_ratio );

				      // then replace the PDG code for the unstable particle in the decay with the set of PDG codes
				      // for its decay products.
				      std::list< int >::iterator replacing_iterator =
					cascade_duplicate->get_decay_product_PDG_codes()->begin();
				      bool already_replaced = false;
				      while( !already_replaced
					     && ( replacing_iterator != cascade_duplicate->get_decay_product_PDG_codes()->end() ) )
					{

					  if( *replacing_iterator == *decay_iterator )
					    // when we find the 1st occurrance of the unstable particle's PDG code in the new cascade
					    // decay...
					    {

					      // erase the unstable particle's PDG code.
					      replacing_iterator =
						cascade_duplicate->get_decay_product_PDG_codes()->erase( replacing_iterator );

					      // add the decay products of the decay which is replacing the unstable particle.
					      for( std::list< int >::iterator replacement_iterator =
						     (*decay_substitution_iterator)->get_decay_product_PDG_codes()->begin();
						   replacement_iterator !=
						     (*decay_substitution_iterator)->get_decay_product_PDG_codes()->end();
						   replacement_iterator++ )
						{

						  if( ( *decay_iterator < 0 )  // if we are replacing an antiparticle
						      && !(this->get_particle_property_set(
											   *replacement_iterator )->counts_as_self_conjugate()) )
						    // & this decay product is not self-conjugate
						    {

						      cascade_duplicate->get_decay_product_PDG_codes()->push_back(
														  -*replacement_iterator );
						      // add the appropriate decay product for the antiparticle.

						    }
						  else
						    {

						      cascade_duplicate->get_decay_product_PDG_codes()->push_back(
														  *replacement_iterator );

						    }

						}

					      already_replaced = true;
					      // note that the 1st occurrance of the unstable particle's PDG code has now been replaced.

					    }  // end of if block looking for the unstable particle to replace.

					  replacing_iterator++;  // move on to the next decay product.

					}  // end of while loop for replacing an unstable particle with a particular set of decay products.

				    }  // end of if block checking that the branching ratio has not gotten too small.

				}  // end of for loop going through all decays

			      // then delete the original cascade to prevent it being checked again.
			      delete (*current_cascade_iterator);
			      (*current_cascade_iterator) = NULL;
			      current_cascade_iterator = current_cascader->get_cascade_decays()->erase( current_cascade_iterator );

			    }  // end of if block checking if a particle in the cascade was unstable or not.

			  // if found_unstable_decay_product is true, decay_iterator is now pointing at a deleted cascade,
			  // so incrementing it is a Bad Idea.
			  if( !found_unstable_decay_product )
			    {

			      decay_iterator++;  // go next decay product in this decay if an unstable particle has not been found
			                         // (& thus replaced).

			    }

			}  // end of for loop going through each particle in the current cascade decay.

		      // if found_unstable_decay_product is true, current_cascade_iterator has already moved on to the next cascade,
		      // so incrementing will skip a cascade & may result in skipping past the last cascade, which is a Bad Thing.
		      if( !found_unstable_decay_product )
			{

			  current_cascade_iterator++;

			}

		    }  // end of if block checking if the cascade had a big enough branching ratio to even bother looking through it.

		} // end of while loop going through each cascade decay of a particle.

	    } // end of if block checking if the particle has decays or not.

	}  // end of while loop going until no cascades had any replacements.

      current_cascader->get_cascade_handler()->merge_identical_decays();  // sum together various chains that have identical final states.

      total_number_of_cascade_decays += current_cascader->get_cascade_decays()->size();

    }  // end of for loop going through each particle in the spectrum to sort out its cascade decays.

  return total_number_of_cascade_decays;

}


BOL_EW_scale_spectrum::~BOL_EW_scale_spectrum()  // destructor.  unfortunately this class allocates a lot of memory, in a complicated way.
// i hope that this destructor is correct.
{

  for( int vector_destructor = ( this->particle_property_sets->size() - 1 );
       vector_destructor >= 0;
       vector_destructor-- )  // go through each pointer in the std::vector.
    {

      // delete the allocated memory pointed at by each pointer.

      delete this->particle_property_sets->at( vector_destructor );
      this->particle_property_sets->at( vector_destructor ) = NULL;

    }

}


