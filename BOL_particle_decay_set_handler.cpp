#include "BOL_particle_decay_set_handler.h"


BOL_particle_decay_set_handler* BOL_particle_decay_set_handler::become_copy_of(BOL_particle_decay_set_handler* decay_handler_to_copy )
// this copies a BOL_particle_decay_set_handler instance.
{

  BOL_particle_decay* pointer_to_decay_to_be_added;

  for( std::list< BOL_particle_decay* >::iterator decay_copying_iterator =
	 decay_handler_to_copy->get_decay_set()->begin();
       decay_copying_iterator != decay_handler_to_copy->get_decay_set()->end();
       decay_copying_iterator++ )
    {

      pointer_to_decay_to_be_added = new BOL_particle_decay( *decay_copying_iterator );

      this->decay_set->push_back( pointer_to_decay_to_be_added );

    }


  return this;			 

}
 

std::list< BOL_particle_decay* >* BOL_particle_decay_set_handler::copy_decay_set( std::list< BOL_particle_decay* >* decay_sets_to_copy )
// this copies a BOL_particle_decay_set_handler instance.
{
  
  BOL_particle_decay* pointer_to_decay_to_be_added;

  for( std::list< BOL_particle_decay* >::iterator decay_copying_iterator = decay_sets_to_copy->begin();
       decay_copying_iterator != decay_sets_to_copy->end();
       decay_copying_iterator++ )
    {

      pointer_to_decay_to_be_added = new BOL_particle_decay( *decay_copying_iterator );

      this->decay_set->push_back( pointer_to_decay_to_be_added );

    }

  return this->decay_set;

}


double BOL_particle_decay_set_handler::get_branching_ratio_for_exact_match( int product_PDG_code_one,
									    int product_PDG_code_two )
// this looks for the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated with the decay if
// found, or else 0.0 if not.
{

  double branching_ratio_to_return = 0.0;  // start by assuming that the decay won't be found.

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      if( (*kept_decay_iterator)->is_same_as( product_PDG_code_one,
					      product_PDG_code_two ) )  // if this decay matches the sought decay...
	{

	  branching_ratio_to_return += (*kept_decay_iterator)->get_branching_ratio();
	  // note the branching ratio to return (allowing for multiple occurrances of the decay in the set of decays).

	}

    }

  return branching_ratio_to_return;

}


double BOL_particle_decay_set_handler::get_branching_ratio_for_exact_match( int product_PDG_code_one,
									    int product_PDG_code_two,
									    int product_PDG_code_three )
// this looks for the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated with the decay if
// found, or else 0.0 if not.
{

  double branching_ratio_to_return = 0.0;  // start by assuming that the decay won't be found.

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      if( (*kept_decay_iterator)->is_same_as( product_PDG_code_one,
					      product_PDG_code_two,
					      product_PDG_code_three ) )  // if this decay matches the sought decay...
	{

	  branching_ratio_to_return += (*kept_decay_iterator)->get_branching_ratio();
	  // note the branching ratio to return (allowing for multiple occurrances of the decay in the set of decays).

	}

    }

  return branching_ratio_to_return;

}


double BOL_particle_decay_set_handler::get_branching_ratio_for_exact_match( std::list< int >* input_PDG_code_list )
// this looks for an exact match to the given set of PDG codes amongst this instance's decays, & returns the branching ratio associated
// with the decay if found, or else 0.0 if not.
{

  double branching_ratio_to_return = 0.0;  // start by assuming that the decay won't be found.

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      if( (*kept_decay_iterator)->is_same_as( input_PDG_code_list ) )  // if this decay matches the sought decay...
	{

	  branching_ratio_to_return += (*kept_decay_iterator)->get_branching_ratio();
	  // note the branching ratio to return (allowing for multiple occurrances of the decay in the set of decays).
	  
	}
      
    }
  
  return branching_ratio_to_return;

}


double BOL_particle_decay_set_handler::get_branching_ratio_for_subset( std::list< int >* sought_subset_PDG_code_list )
// this looks for the given set of PDG codes for matches to subsets amongst this instance's decays, without caring what the remainder
// (if any) of the particles in any decay is, & returns the aggregate branching ratio of all these decays.
{

  double branching_ratio_to_return = 0.0;  // start by assuming that the decay won't be found.

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      if( (*kept_decay_iterator)->has_as_subset( sought_subset_PDG_code_list ) )
	// if this decay has the sought PDG codes as a subset...
	{

	  branching_ratio_to_return += (*kept_decay_iterator)->get_branching_ratio();  // update the branching ratio to return.

	}

    }

  return branching_ratio_to_return;

}


double BOL_particle_decay_set_handler::get_branching_ratio_for_subset( std::list< int >* sought_subset_PDG_code_list,
								       std::list< int >* excluded_PDG_code_list )
// this looks for the given set of PDG codes for matches to subsets amongst this instance's decays, checking if any of the particles
// in the remainder (if any) in each decay appear on the exclusion list, & returns the aggregate branching ratio of all the decays
// which have the subset & do not have any excluded particles in the remainder.
{

  double branching_ratio_to_return = 0.0;  // start by assuming that the decay won't be found.

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      if( (*kept_decay_iterator)->has_as_subset( sought_subset_PDG_code_list,
						 excluded_PDG_code_list ) )
	// if this decay has the sought PDG codes as a subset & none of the excluded PDG codes...
	{

	  branching_ratio_to_return += (*kept_decay_iterator)->get_branching_ratio();  // update the branching ratio to return.

	}

    }

  return branching_ratio_to_return;

}


int BOL_particle_decay_set_handler::merge_identical_decays()
// this checks all the decays in the decay handler to see if there are identical sets of decay products, & then if there are,
// it adds the BR of every identical set after the 1st encountered to the 1st set's BR, & erases the other.
{

  int number_of_mergers = 0;

  for( std::list< BOL_particle_decay* >::iterator kept_decay_iterator = this->decay_set->begin();
       kept_decay_iterator != this->decay_set->end();
       kept_decay_iterator++ ) // go through each stored decay.
    {

      // go through each decay after (backwards, so actaully before) the one that will be kept.
      // this would be a for loop, except we have to initialize an iterator & advance it once before starting the loop.
      std::list< BOL_particle_decay* >::iterator checked_decay_iterator = kept_decay_iterator;
      if( checked_decay_iterator != this->decay_set->end() )  // if there are still decays to check...
	{

	  checked_decay_iterator++;  // don't check the decay against itself.

	}
      while( checked_decay_iterator != this->decay_set->end() )  // before we run out of decays to check against...
	{

	  if( (*checked_decay_iterator)->is_same_as( (*kept_decay_iterator)->get_decay_product_PDG_codes() ) )
	    // if the decays have the same decay products...
	    {

	      (*kept_decay_iterator)->set_branching_ratio(
							  ( (*kept_decay_iterator)->get_branching_ratio() + (*checked_decay_iterator)->get_branching_ratio() ) );
	      // update the BR of the decay that will be kept.

	      checked_decay_iterator = this->decay_set->erase( checked_decay_iterator );  // erase the other decay.

	      number_of_mergers++;

	    }
	  else
	    {

	      checked_decay_iterator++;  // go on to the next decay in the list to be checked.

	    }

	}

    }

  return number_of_mergers;

}


BOL_particle_decay_set_handler:: ~BOL_particle_decay_set_handler()  // destructor.  unfortunately this class allocates a lot of memory, in a complicated way.
// i hope that this destructor is correct.
{

  for( std::list< BOL_particle_decay* >::iterator list_destructor = this->decay_set->begin();
       list_destructor != this->decay_set->end();
       list_destructor++ )  // go through each pointer in the std::list.
    {

      // delete the allocated memory pointed at by each pointer.
      delete *list_destructor;
      *list_destructor = NULL;

    }

  delete this->decay_set;
  this->decay_set = NULL;

}
