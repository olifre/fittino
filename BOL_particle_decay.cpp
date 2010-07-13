#include "BOL_particle_decay.h"


BOL_particle_decay::BOL_particle_decay( int product_PDG_code_one,
		      int product_PDG_code_two,
		      double input_branching_ratio ) // constructor for a 2-body decay.
  {

    this->decay_product_PDG_codes = new std::list< int >;

    this->decay_product_PDG_codes->push_back( product_PDG_code_one );
    this->decay_product_PDG_codes->push_back( product_PDG_code_two );
    this->branching_ratio = input_branching_ratio;

  }


BOL_particle_decay::BOL_particle_decay( int product_PDG_code_one,
		      int product_PDG_code_two,
		      int product_PDG_code_three,
		      double input_branching_ratio )  // constructor for a 3-body decay.
  {

    this->decay_product_PDG_codes = new std::list< int >;

    this->decay_product_PDG_codes->push_back( product_PDG_code_one );
    this->decay_product_PDG_codes->push_back( product_PDG_code_two );
    this->decay_product_PDG_codes->push_back( product_PDG_code_three );
    this->branching_ratio = input_branching_ratio;

  }



BOL_particle_decay::BOL_particle_decay(BOL_particle_decay* particle_decay_to_copy ) // copying constructor.
  {

    this->decay_product_PDG_codes = new std::list< int >;

    for( std::list< int >::iterator decay_PDG_codes_iterator = particle_decay_to_copy->get_decay_product_PDG_codes()->begin();
	 decay_PDG_codes_iterator != particle_decay_to_copy->get_decay_product_PDG_codes()->end();
	 decay_PDG_codes_iterator++  )
      {

	this->decay_product_PDG_codes->push_back( *decay_PDG_codes_iterator );

      }

    this->branching_ratio = particle_decay_to_copy->get_branching_ratio();

  }





bool BOL_particle_decay::has_this_PDG_code( int input_PDG_code )  // checks to see if the sought particle is among the decay products.
{

  bool return_bool = false;  // assume that the particle is not in the set of decay products.


  // check each of the decay products, & if it has the sought PDG code, note that.
  for( std::list< int >::iterator list_searcher = this->decay_product_PDG_codes->begin();
       list_searcher != this->decay_product_PDG_codes->end();
       list_searcher++ )
    {

      if( *list_searcher == input_PDG_code )
	{

	  return_bool = true;

	}

    }

  return return_bool;  // return the result of the search.

}

bool BOL_particle_decay::is_same_as( int product_PDG_code_one,
				     int product_PDG_code_two )  // compares the decay products against a pair of given PDG codes.
{

  bool comparison_to_return = false;  // assume that the input list does not match the decay product list.

  if( this->decay_product_PDG_codes->size() == 2 )  // if the decay product list is at least the right length...
    {

      // make a small list of the input codes & pass it to the general case is_same_as().
      std::list< int >* input_PDG_codes_as_list = new std::list< int >;
      input_PDG_codes_as_list->push_back( product_PDG_code_one );
      input_PDG_codes_as_list->push_back( product_PDG_code_two );

      comparison_to_return = this->is_same_as( input_PDG_codes_as_list );

      // clean up.
      delete input_PDG_codes_as_list;
      input_PDG_codes_as_list = NULL;

    }

  return comparison_to_return;

}


bool BOL_particle_decay::is_same_as( int product_PDG_code_one,
				     int product_PDG_code_two,
				     int product_PDG_code_three )  // compares the decay products against a set of 3 given PDG codes.
{

  bool comparison_to_return = false;  // assume that the input list does not match the decay product list.

  if( this->decay_product_PDG_codes->size() == 3 )  // if the decay product list is at least the right length...
    {

      // make a small list of the input codes & pass it to the general case is_same_as().
      std::list< int >* input_PDG_codes_as_list = new std::list< int >;
      input_PDG_codes_as_list->push_back( product_PDG_code_one );
      input_PDG_codes_as_list->push_back( product_PDG_code_two );
      input_PDG_codes_as_list->push_back( product_PDG_code_three );

      comparison_to_return = this->is_same_as( input_PDG_codes_as_list );

      // clean up.
      delete input_PDG_codes_as_list;
      input_PDG_codes_as_list = NULL;

    }

  return comparison_to_return;

}


bool BOL_particle_decay::is_same_as( std::list< int >* input_PDG_code_list )
                                                            // compares the decay products against a variable amount of given PDG codes.
{

  bool comparison_to_return = false;  // assume that the input list does not match the decay product list.

  if( ( input_PDG_code_list->size() == this->decay_product_PDG_codes->size() )
	&& this->has_as_subset( input_PDG_code_list ) ) // if the numbers match up & the given set is a subset, they are the same.
    {
      
      comparison_to_return = true;
      
    }

  return comparison_to_return;
    
}


bool BOL_particle_decay::has_as_subset( std::list< int >* sought_subset_PDG_code_list,
					std::list< int >* excluded_PDG_code_list )
// compares the decay products against a variable amount of given PDG codes, along with a list of excluded PDG codes.
{

  bool comparison_to_return = false;  // assume that the input list does not match the decay product list.

  if( sought_subset_PDG_code_list->size() <= this->decay_product_PDG_codes->size() ) 
                                                                              // check that the numbers of PDG codes to check match up.
    {

      // if the input list is at least not longer than this decay, start by assuming that the subset will be found.
      comparison_to_return = true;
      //   bool PDG_codes_found_flag = true;

      // create a list of PDG codes which can have codes removed, to prevent confusion over comparison of duplicates in either list.
      std::list< int >* list_of_PDG_codes_to_check_off = new std::list< int >;
      for( std::list< int >::iterator list_filler = this->decay_product_PDG_codes->begin();
	   list_filler != this->decay_product_PDG_codes->end();
	   list_filler++ )
	{

	  list_of_PDG_codes_to_check_off->push_back( *list_filler );

	}

      // loop (backwards) through all the provided PDG codes, checking that each is accounted for once,
      // removing checked PDG codes from the list.
      std::list< int >::iterator sought_subset_PDG_code_list_iterator = sought_subset_PDG_code_list->begin();
      while( comparison_to_return
	     && ( sought_subset_PDG_code_list_iterator != sought_subset_PDG_code_list->end() ) )
	{

	  // search through the list until either the sought PDG code is found, or the end is reached.
	  bool PDG_code_unfound_flag = true;
	  std::list< int >::iterator list_searcher = list_of_PDG_codes_to_check_off->begin();
	  while( PDG_code_unfound_flag
		 && ( list_searcher != list_of_PDG_codes_to_check_off->end() ) )
	    {

	      // if the PDG code is found in the list, remove it & note that it was found.
	      if( *list_searcher == *sought_subset_PDG_code_list_iterator )
		{

		  PDG_code_unfound_flag = false;

		  list_searcher = list_of_PDG_codes_to_check_off->erase( list_searcher );

		}
	      else  // otherwise, go on to the next element.
		{

		  list_searcher++;

		}

	    }


	  // if the previous loop did not check off the sought PDG code,
	  // note that it was not found so the sets of PDG codes do not match, so this method should return false.
	  if( PDG_code_unfound_flag )
	    {

	      comparison_to_return = false;

	    }

	  sought_subset_PDG_code_list_iterator++;  // go on to the next sought PDG code.

	}


      // now go through the list of remaining PDG codes (the excess to the list sought), checking to see if any are on the list of
      // excluded PDG codes.
      if( comparison_to_return && !(excluded_PDG_code_list->empty()) )  // if the subset was found, & there are PDG codes to exclude...
	{

	  std::list< int >::iterator excluded_PDG_code_list_iterator = excluded_PDG_code_list->begin();
	  while( comparison_to_return
		 && ( excluded_PDG_code_list_iterator != excluded_PDG_code_list->end() ) )
	    {

	      // search through the list until either the excluded PDG code is found, or the end is reached.
	      //      bool PDG_code_unfound_flag = true;
	      std::list< int >::iterator list_searcher = list_of_PDG_codes_to_check_off->begin();
	      while( comparison_to_return
		     && ( list_searcher != list_of_PDG_codes_to_check_off->end() ) )
		{

		  if( *list_searcher == *excluded_PDG_code_list_iterator )  // if the remainder list has an excluded particle...
		    {

		      comparison_to_return = false;  // note this.

		    }
		  else  // otherwise, go on to the next element.
		    {

		      list_searcher++;

		    }

		}

	      excluded_PDG_code_list_iterator++;  // go on to the next sought PDG code.

	    }

	}


      // clean up.
      delete list_of_PDG_codes_to_check_off;
      list_of_PDG_codes_to_check_off = NULL;

    }

  return comparison_to_return;
    
}


BOL_particle_decay::~BOL_particle_decay()  // destructor.
  {

    delete decay_product_PDG_codes;
    decay_product_PDG_codes = NULL;

  }

