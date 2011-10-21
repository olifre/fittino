
#include "old_CppSLHA.h"


std::string old_CppSLHA::SLHA_double( double given_double )
// this prepares a string that is the ASCII version of a double, in the form necessary for an SLHA file (Fortran E16.8).
// 1st character: either - for negative numbers, of a blank space for positive numbers,
// 2nd character: the 1st digit,
// 3rd character: the decimal point,
// 4th-11th characters: the 1st 8 digits following the decimal point,
// 12th character: E
// 13th character: + or -, depending on the sign of the exponent,
// 14th, 15th & 16th characters: the absolute value of the exponent, with a preceding 0s to fill to 3 characters.
// SPheno almost uses this format, but only prints 2 digits of the exponent.
{

  std::stringstream return_string_builder( "" );

  double formatted_mantissa = given_double;

  int formatted_exponent = 0;

  if( given_double < 0.0 )
    {

      formatted_mantissa = -given_double;

      return_string_builder << "-";

    }
  else
    {

      return_string_builder << " ";

    }

  while( formatted_mantissa >= 10.0 )
    {

      formatted_mantissa *= 0.1;

      formatted_exponent++;

    }

  while( ( formatted_mantissa < 1.0 )
	 && ( formatted_mantissa > 0.0 ) )
    {

      formatted_mantissa *= 10.0;

      formatted_exponent--;

    }

  // this should set the stream to format numbers in fixed-digit notation, then set it to having 8 digits after the decimal point.
  return_string_builder.setf( std::ios::fixed, std::ios::floatfield );
  return_string_builder.precision( 8 );

  return_string_builder << formatted_mantissa;  // then write the mantissa.

  return_string_builder << "E";

  if( formatted_exponent < 0 )
    {

      return_string_builder << "-";

      formatted_exponent *= -1;

    }
  else
    {

      return_string_builder << "+";

    }
  if( formatted_exponent < 100 )
    {

      return_string_builder << "0";

    }
  if( formatted_exponent < 10 )
    {

      return_string_builder << "0";

    }

  return_string_builder << formatted_exponent;  // since the exponent is an integer, it shouldn't get formatted in scientific format.

  return return_string_builder.str();

}


std::string old_CppSLHA::SLHA_int( int given_int, int given_size )
// this prepares a string that is the ASCII version of an int, in the form necessary for an SLHA file
// (Fortran Iw, where w is an integer, which is given as given_size).  the string is given_size characters long.
{

  std::stringstream return_string_builder( "" );

  int absolute_value = given_int;

  if( given_int < 0 )
    {

      absolute_value *= -1;

    }

  int actual_size = ( 1 + (int)(log10( (double)(absolute_value) )) );

  if( ( actual_size + 1 ) > given_size )
    // if the size needed (the number of digits + 1 for the space / minus sign) is bigger than the requested string size...
    {

      return_string_builder << "error!  SLHA_int( " << given_int << ", " << given_size
			    << " ) could not fit the integer into the given size!";  // report an error message.

    }
  else
    {

      for( int space_inserter = 0;
	   space_inserter < ( given_size - actual_size - 1 );
	   space_inserter++ )
	{

	  return_string_builder << " ";

	}

      if( given_int < 0 )
	{

	  return_string_builder << "-";

	}
      else
	{

	  return_string_builder << " ";

	}

    }

  return_string_builder << absolute_value;

  return return_string_builder.str();

}




old_CppSLHA::old_CppSLHA( std::string given_SLHA_file_name )  // the constructor requires a file to open.
  {

    // the constructor sets all entries to -10^10 (apart from off-diagonal YU, YD, YE, AU, AD & AE, which get set to zero)
    // & also allocates the memory for the particle spectrum.
    // then it actually opens the file, reads in the data it finds, & closes the file again.
    this->SLHA_file_name = given_SLHA_file_name;
    this->particle_spectrum = new BOL_EW_scale_MSSM_spectrum();
    this->allocated_spectrum_memory = true;  // note that this instance allocated memory, so needs to deallocate it with its destructor.


    this->read_file();  // finally read in the file & update the stored data.  read_file() also calls reset() which sets all entries
                        // to -10^10 except for the off-diagonal entries in YU, YD, YE, AU, AD & AE, which are set to 0.0, & the spectrum
                        // is deleted then freshly initialized.

  }

old_CppSLHA::old_CppSLHA( std::string given_SLHA_file_name, BOL_EW_scale_spectrum* given_spectrum )
  // this constructor requires a file to open, & this one takes a pre-existing BOL_EW_scale_spectrum,
  // which is how one can implement the NMSSM or similar.
  {

    if( given_spectrum == NULL )
      // this constructor prepares an instance that is meant to read in the SLHA file data into a
      // BOL_EW_scale_spectrum::BOL_EW_scale_spectrum instance which is held somewhere else in the code.  thus it does not want to be
      // involved in the allocation & deallocation of the memory for the BOL_EW_scale_spectrum::BOL_EW_scale_spectrum instance, & so it
      // checks that its memory has already been allocated, forcing the programmer to think about memory allocation & deallocation.
      // (this constructor calls read_file() which deletes the instance & sets the pointer to a new memory allocation anyway, so the
      // BOL_EW_scale_spectrum::BOL_EW_scale_spectrum instance better be there!)
      {

	std::cout
	  << std::endl << "error!  this old_CppSLHA constructor, with given file name \"" << given_SLHA_file_name
	  << "\" and given pointer to a BOL_EW_scale_spectrum::BOL_EW_scale_spectrum instance found that the pointer was a NULL pointer.";
	std::cout << std::endl << "this constructor really doesn't want to do the memory management when given such a pointer."
		  << "  instead, it is taking the easy way out & calling exit( EXIT_FAILURE )."
		  << "  sorry about the inevitable memory leaks...";
	std::cout << std::endl;

	exit( EXIT_FAILURE );

      }
    else
      {

	this->SLHA_file_name = given_SLHA_file_name;
	this->particle_spectrum = given_spectrum;
	this->allocated_spectrum_memory = false;  // note that this instance did NOT allocate memory,
                                                  // so should NOT deallocate it with its destructor.

	this->read_file();  // finally read in the file & update the stored data.  read_file() also calls reset() which sets all entries
                            // to -10^10 except for the off-diagonal entries in YU, YD, YE, AU, AD & AE, which are set to 0.0, & the
                            // spectrum is deleted then freshly initialized.

      }

  }

old_CppSLHA::old_CppSLHA( old_CppSLHA* copy_source )
  // this constructor copies another instance.
  {

    this->SLHA_file_name = copy_source->get_SLHA_file_name();
    this->particle_spectrum = new BOL_EW_scale_spectrum( copy_source->get_particle_spectrum() );
    this->allocated_spectrum_memory = true;  // note that this instance DID allocate memory,
                                             // so SHOULD deallocate it with its destructor.

    this->model_selection = copy_source->get_MODSEL();
    this->SUSY_scale = copy_source->get_Q();
    this->EWSB_scalar_mixing_angle = copy_source->get_ALPHA();

    for( int initializing_counter = 0;
	 initializing_counter < 23;
	 initializing_counter++ )
      {

	if( initializing_counter < 6 )
	  {

	    this->minimal_parameters[ initializing_counter ] = copy_source->get_MINPAR( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 21 )
	  {

	    this->extra_parameters[ initializing_counter ] = copy_source->get_EXTPAR( initializing_counter );

	  }

	if( initializing_counter < 7 )
	  {

	    this->Standard_Model_inputs[ initializing_counter ] = copy_source->get_SMINPUTS( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 3 )
	  {

	    this->gauge_couplings[ initializing_counter ] = copy_source->get_GAUGE( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 20 )
	  {

	    this->soft_mass_terms[ initializing_counter ] = copy_source->get_MSOFT( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 4 )
	  {

	    this->EWSB_scalar_mixing_parameters[ initializing_counter ] = copy_source->get_HMIX( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 23 )
	  {

	    this->SPheno_low_energy_observables[ initializing_counter ] = copy_source->get_SPHENOLOWENERGY( ( initializing_counter + 1 ) );

	  }

	if( initializing_counter < 4 )
	  {

	    for( int array_second_index_initializer = 0;
		 array_second_index_initializer < 4;
		 array_second_index_initializer++ )
	      {

		neutralino_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
	                                                            = copy_source->get_NMIX( ( initializing_counter + 1 ),
											     ( array_second_index_initializer + 1 ) );

		if( ( initializing_counter < 3 )
		    && ( array_second_index_initializer < 3 ) )
		  {

		    up_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_YU( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );
		    down_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_YD( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );
		    charged_lepton_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_YE( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );
		    up_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_AU( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );
		    down_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_AD( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );
		    charged_lepton_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_AE( ( initializing_counter + 1 ),
											   ( array_second_index_initializer + 1 ) );

		  }

		if( ( initializing_counter < 2 )
		    && ( array_second_index_initializer < 2 ) )
		  {

		    stop_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_STOPMIX( ( initializing_counter + 1 ),
												( array_second_index_initializer + 1 ) );
		    sbottom_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_SBOTMIX( ( initializing_counter + 1 ),
												( array_second_index_initializer + 1 ) );
		    stau_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_STAUMIX( ( initializing_counter + 1 ),
												( array_second_index_initializer + 1 ) );
		    chargino_U_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_UMIX( ( initializing_counter + 1 ),
											     ( array_second_index_initializer + 1 ) );
		    chargino_V_mixing_matrix[ initializing_counter ][ array_second_index_initializer ]
		                                                    = copy_source->get_VMIX( ( initializing_counter + 1 ),
											     ( array_second_index_initializer + 1 ) );

		  }

	      }

	  }

      }

  }



bool old_CppSLHA::reset()
// this resets all entries to -10^10 except for the entries in YU, YD, YE, AU, AD & AE, which are reset to 0.0.
{

  bool return_bool = false;

  this->model_selection = (int)(REALLY_WRONG_VALUE);
  this->SUSY_scale = REALLY_WRONG_VALUE;
  this->EWSB_scalar_mixing_angle = REALLY_WRONG_VALUE;

  for( int initializing_counter = 0;
       initializing_counter < 23;
       initializing_counter++ )
    {

      if( initializing_counter < 6 )
	{

	  this->minimal_parameters[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 21 )
	{

	  this->extra_parameters[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 7 )
	{

	  this->Standard_Model_inputs[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 3 )
	{

	  this->gauge_couplings[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 20 )
	{

	  this->soft_mass_terms[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 4 )
	{

	  this->EWSB_scalar_mixing_parameters[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 23 )
	{

	  this->SPheno_low_energy_observables[ initializing_counter ] = REALLY_WRONG_VALUE;

	}

      if( initializing_counter < 4 )
	{

	  for( int array_second_index_initializer = 0;
	       array_second_index_initializer < 4;
	       array_second_index_initializer++ )
	    {

	      neutralino_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;

	      if( ( initializing_counter < 3 )
		  && ( array_second_index_initializer < 3 ) )
		{

		  //if( initializing_counter == array_second_index_initializer )
		  //{
		  //
		  //up_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  //down_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  //charged_lepton_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  //up_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  //down_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  //charged_lepton_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] =
		  //			                                                                              REALLY_WRONG_VALUE;
		  //
		  //}
		  //else
		  //{

		  up_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;
		  down_type_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;
		  charged_lepton_Yukawa_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;
		  up_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;
		  down_type_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;
		  charged_lepton_soft_trilinear_term_matrix[ initializing_counter ][ array_second_index_initializer ] = 0.0;

		  //}

		}

	      if( ( initializing_counter < 2 )
		  && ( array_second_index_initializer < 2 ) )
		{

		  stop_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  sbottom_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  stau_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  chargino_U_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;
		  chargino_V_mixing_matrix[ initializing_counter ][ array_second_index_initializer ] = REALLY_WRONG_VALUE;

		}

	    }

	}

    }

  if( this->particle_spectrum != NULL )
    {

      delete this->particle_spectrum;

      return_bool = true;

    }

  this->particle_spectrum = new BOL_EW_scale_MSSM_spectrum();

  return return_bool;

}


double old_CppSLHA::get_BLOCK( std::string requested_BLOCK )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  double return_value = REALLY_WRONG_VALUE;

  if( requested_BLOCK.compare( "MODSEL" ) == 0 )  // N.B. MODSEL should be an integer, but i'd rather not have to make a special case.
                                                  // the user can cast the double back to an int without problem, i'm sure.
    {

      return_value = (double)(this->get_MODSEL());

    }
  else if( requested_BLOCK.compare( "ALPHA" ) == 0 )
    {

      return_value = this->get_ALPHA();

    }
  else if( requested_BLOCK.compare( "Q" ) == 0 )
    {

      return_value = this->get_Q();

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for get_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_MODSEL_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK MODSEL   # Model selection" << std::endl << "    1    " << this->get_MODSEL() << std::endl;

  return return_string_builder.str();

}


std::string old_CppSLHA::get_ALPHA_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK ALPHA   # Effective Higgs mixing angle" << std::endl
			<< "         " <<  old_CppSLHA::SLHA_double( this->get_ALPHA() ) << "   # alpha" << std::endl;

  return return_string_builder.str();

}


void old_CppSLHA::set_BLOCK( std::string requested_BLOCK, double set_value )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  if( requested_BLOCK.compare( "MODSEL" ) == 0 )
    {

      this->model_selection = (int)set_value;

    }
  else if( requested_BLOCK.compare( "ALPHA" ) == 0 )
    {

      this->EWSB_scalar_mixing_angle = set_value;

    }
  else if( requested_BLOCK.compare( "Q" ) == 0 )
    {

      this->SUSY_scale = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for set_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


double old_CppSLHA::get_BLOCK( std::string requested_BLOCK, int requested_element )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  double return_value = REALLY_WRONG_VALUE;

  if( requested_BLOCK.compare( "MINPAR" ) == 0 )
    {

      return_value = this->get_MINPAR( requested_element );

    }
  else if( requested_BLOCK.compare( "EXTPAR" ) == 0 )
    {

      return_value = this->get_EXTPAR( requested_element );

    }
  else if( requested_BLOCK.compare( "SMINPUTS" ) == 0 )
    {

      return_value = this->get_SMINPUTS( requested_element );

    }
  else if( requested_BLOCK.compare( "GAUGE" ) == 0 )
    {

      return_value = this->get_GAUGE( requested_element );

    }
  else if( requested_BLOCK.compare( "MSOFT" ) == 0 )
    {

      return_value = this->get_MSOFT( requested_element );

    }
  else if( requested_BLOCK.compare( "MASS" ) == 0 )
    {

      return_value = this->get_MASS( requested_element );

    }
  else if( requested_BLOCK.compare( "HMIX" ) == 0 )
    {

      return_value = this->get_HMIX( requested_element );

    }
  else if( requested_BLOCK.compare( "SPHENOLOWENERGY" ) == 0 )
    {

      return_value = this->get_SPHENOLOWENERGY( requested_element );

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for get_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


double old_CppSLHA::get_MINPAR( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 6 ) )
    {

      return_value = this->minimal_parameters[ ( requested_element - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_MINPAR( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}

std::string old_CppSLHA::get_MINPAR_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK MINPAR   # Input parameters " << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_MINPAR( 1 ) ) << "   # the common scalar soft mass" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_MINPAR( 2 ) ) << "   # the common gaugino soft mass" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_MINPAR( 3 ) ) << "   # tangent of beta at the Z mass" << std::endl
    << "     4   " << old_CppSLHA::SLHA_double( this->get_MINPAR( 4 ) ) << "   # the sign of the mu parameter" << std::endl
    << "     5   " << old_CppSLHA::SLHA_double( this->get_MINPAR( 5 ) ) << "   # the common scalar soft trilinear mass" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_EXTPAR( int requested_element )  // EXTPAR has a zero element, so the enumeration is slightly different to MSOFT.
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element >= 0 )
      && ( requested_element <= 3 ) )
    {

      return_value = this->extra_parameters[ ( requested_element - 0 ) ];

    }
  else if( ( requested_element > 20 )
	   && ( requested_element <= 22 ) )
    {

      return_value = this->extra_parameters[ ( requested_element - 17 ) ];

    }
  else if( ( requested_element > 30 )
	   && ( requested_element <= 36 ) )
    {

      return_value = this->extra_parameters[ ( requested_element - 25 ) ];

    }
  else if( ( requested_element > 40 )
	   && ( requested_element <= 49 ) )
    {

      return_value = this->extra_parameters[ ( requested_element - 29 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_EXTPAR( " << requested_element << " ) asked for an element out of range.";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_EXTPAR_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK EXTPAR   # soft SUSY breaking masses for non-minimal/non-universal models" << std::endl
    << "     0   " << old_CppSLHA::SLHA_double( this->get_EXTPAR(  0 ) ) << "   # the scale for these parameters" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_EXTPAR(  1 ) ) << "   # M_1" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_EXTPAR(  2 ) ) << "   # M_2" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_EXTPAR(  3 ) ) << "   # M_3" << std::endl
    << "    21   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 21 ) ) << "   # M^2_(H,d)" << std::endl
    << "    22   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 22 ) ) << "   # M^2_(H,u)" << std::endl
    << "    31   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 31 ) ) << "   # M_(L,11)" << std::endl
    << "    32   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 32 ) ) << "   # M_(L,22)" << std::endl
    << "    33   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 33 ) ) << "   # M_(L,33)" << std::endl
    << "    34   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 34 ) ) << "   # M_(E,11)" << std::endl
    << "    35   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 35 ) ) << "   # M_(E,22)" << std::endl
    << "    36   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 36 ) ) << "   # M_(E,33)" << std::endl
    << "    41   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 41 ) ) << "   # M_(Q,11)" << std::endl
    << "    42   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 42 ) ) << "   # M_(Q,22)" << std::endl
    << "    43   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 43 ) ) << "   # M_(Q,33)" << std::endl
    << "    44   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 44 ) ) << "   # M_(U,11)" << std::endl
    << "    45   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 45 ) ) << "   # M_(U,22)" << std::endl
    << "    46   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 46 ) ) << "   # M_(U,33)" << std::endl
    << "    47   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 47 ) ) << "   # M_(D,11)" << std::endl
    << "    48   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 48 ) ) << "   # M_(D,22)" << std::endl
    << "    49   " << old_CppSLHA::SLHA_double( this->get_EXTPAR( 49 ) ) << "   # M_(D,33)" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_SMINPUTS( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 7 ) )
    {

      return_value = this->Standard_Model_inputs[ ( requested_element - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_SMINPUTS( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_SMINPUTS_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
<< "BLOCK SMINPUTS  # SM parameters" << std::endl
<< "     1   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 1 ) ) << "  # 1/alpha_EM at the Z mass in the MSbar scheme" << std::endl
<< "     2   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 2 ) ) << "  # the Fermi constant G_F in GeV^(-2)" << std::endl
<< "     3   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 3 ) ) << "  # 1/alpha_s at the Z mass in the MSbar scheme" << std::endl
<< "     4   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 4 ) ) << "  # the pole mass of the Z boson" << std::endl
<< "     5   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 5 ) ) << "  # the bottom quark mass at itself in the MSbar scheme" << std::endl
<< "     6   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 6 ) ) << "  # the pole mass of the top quark" << std::endl
<< "     7   " << old_CppSLHA::SLHA_double( this->get_SMINPUTS( 7 ) ) << "  # the pole mass of the tau lepton" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_GAUGE( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 3 ) )
    {

      return_value = this->gauge_couplings[ ( requested_element - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_GAUGE( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_GAUGE_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK GAUGE Q= " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl
			<< "     1   " << old_CppSLHA::SLHA_double( this->get_GAUGE( 1 ) ) << "   # g'(Q) in the DRbar scheme" << std::endl
			<< "     2   " << old_CppSLHA::SLHA_double( this->get_GAUGE( 2 ) ) << "   # g(Q) in the DRbar scheme" << std::endl
			<< "     3   " << old_CppSLHA::SLHA_double( this->get_GAUGE( 3 ) ) << "   # g_3(Q) in the DRbar scheme" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_MSOFT( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 3 ) )
    {

      return_value = this->soft_mass_terms[ ( requested_element - 1 ) ];

    }
  else if( ( requested_element > 20 )
	   && ( requested_element <= 22 ) )
    {

      return_value = this->soft_mass_terms[ ( requested_element - 18 ) ];

    }
  else if( ( requested_element > 30 )
	   && ( requested_element <= 36 ) )
    {

      return_value = this->soft_mass_terms[ ( requested_element - 26 ) ];

    }
  else if( ( requested_element > 40 )
	   && ( requested_element <= 49 ) )
    {

      return_value = this->soft_mass_terms[ ( requested_element - 30 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_MSOFT( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_MSOFT_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK MSOFT Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # soft SUSY breaking masses at Q" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  1 ) ) << "   # M_1" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  2 ) ) << "   # M_2" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  3 ) ) << "   # M_3" << std::endl
    << "    21   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 21 ) ) << "   # M^2_(H,d)" << std::endl
    << "    22   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 22 ) ) << "   # M^2_(H,u)" << std::endl
    << "    31   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 31 ) ) << "   # M_(L,11)" << std::endl
    << "    32   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 32 ) ) << "   # M_(L,22)" << std::endl
    << "    33   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 33 ) ) << "   # M_(L,33)" << std::endl
    << "    34   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 34 ) ) << "   # M_(E,11)" << std::endl
    << "    35   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 35 ) ) << "   # M_(E,22)" << std::endl
    << "    36   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 36 ) ) << "   # M_(E,33)" << std::endl
    << "    41   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 41 ) ) << "   # M_(Q,11)" << std::endl
    << "    42   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 42 ) ) << "   # M_(Q,22)" << std::endl
    << "    43   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 43 ) ) << "   # M_(Q,33)" << std::endl
    << "    44   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 44 ) ) << "   # M_(U,11)" << std::endl
    << "    45   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 45 ) ) << "   # M_(U,22)" << std::endl
    << "    46   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 46 ) ) << "   # M_(U,33)" << std::endl
    << "    47   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 47 ) ) << "   # M_(D,11)" << std::endl
    << "    48   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 48 ) ) << "   # M_(D,22)" << std::endl
    << "    49   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 49 ) ) << "   # M_(D,33)" << std::endl;

  return return_string_builder.str();

}


std::string old_CppSLHA::get_EXTPAR_from_MSOFT_as_string()  // this writes the MSOFT BLOCK as the EXTPAR BLOCK, using the Q which was read in.
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK EXTPAR   # soft SUSY breaking masses for non-minimal/non-universal models" << std::endl
    << "     0   " << old_CppSLHA::SLHA_double( this->get_Q()         ) << "   # the scale for these parameters" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  1 ) ) << "   # M_1" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  2 ) ) << "   # M_2" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  3 ) ) << "   # M_3" << std::endl
    << "    21   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 21 ) ) << "   # M^2_(H,d)" << std::endl
    << "    22   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 22 ) ) << "   # M^2_(H,u)" << std::endl
    << "    31   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 31 ) ) << "   # M_(L,11)" << std::endl
    << "    32   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 32 ) ) << "   # M_(L,22)" << std::endl
    << "    33   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 33 ) ) << "   # M_(L,33)" << std::endl
    << "    34   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 34 ) ) << "   # M_(E,11)" << std::endl
    << "    35   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 35 ) ) << "   # M_(E,22)" << std::endl
    << "    36   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 36 ) ) << "   # M_(E,33)" << std::endl
    << "    41   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 41 ) ) << "   # M_(Q,11)" << std::endl
    << "    42   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 42 ) ) << "   # M_(Q,22)" << std::endl
    << "    43   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 43 ) ) << "   # M_(Q,33)" << std::endl
    << "    44   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 44 ) ) << "   # M_(U,11)" << std::endl
    << "    45   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 45 ) ) << "   # M_(U,22)" << std::endl
    << "    46   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 46 ) ) << "   # M_(U,33)" << std::endl
    << "    47   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 47 ) ) << "   # M_(D,11)" << std::endl
    << "    48   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 48 ) ) << "   # M_(D,22)" << std::endl
    << "    49   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 49 ) ) << "   # M_(D,33)" << std::endl;

  return return_string_builder.str();

}


std::string old_CppSLHA::get_EXTPAR_from_MSOFT_as_string( double given_scale )
// this writes the MSOFT BLOCK as the EXTPAR BLOCK, with the given scale.
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK EXTPAR   # soft SUSY breaking masses for non-minimal/non-universal models" << std::endl
    << "     0   " << old_CppSLHA::SLHA_double(           given_scale ) << "   # the scale for these parameters" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  1 ) ) << "   # M_1" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  2 ) ) << "   # M_2" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_MSOFT(  3 ) ) << "   # M_3" << std::endl
    << "    21   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 21 ) ) << "   # M^2_(H,d)" << std::endl
    << "    22   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 22 ) ) << "   # M^2_(H,u)" << std::endl
    << "    31   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 31 ) ) << "   # M_(L,11)" << std::endl
    << "    32   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 32 ) ) << "   # M_(L,22)" << std::endl
    << "    33   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 33 ) ) << "   # M_(L,33)" << std::endl
    << "    34   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 34 ) ) << "   # M_(E,11)" << std::endl
    << "    35   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 35 ) ) << "   # M_(E,22)" << std::endl
    << "    36   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 36 ) ) << "   # M_(E,33)" << std::endl
    << "    41   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 41 ) ) << "   # M_(Q,11)" << std::endl
    << "    42   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 42 ) ) << "   # M_(Q,22)" << std::endl
    << "    43   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 43 ) ) << "   # M_(Q,33)" << std::endl
    << "    44   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 44 ) ) << "   # M_(U,11)" << std::endl
    << "    45   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 45 ) ) << "   # M_(U,22)" << std::endl
    << "    46   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 46 ) ) << "   # M_(U,33)" << std::endl
    << "    47   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 47 ) ) << "   # M_(D,11)" << std::endl
    << "    48   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 48 ) ) << "   # M_(D,22)" << std::endl
    << "    49   " << old_CppSLHA::SLHA_double( this->get_MSOFT( 49 ) ) << "   # M_(D,33)" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_MASS( int requested_element )
{

  double return_value = this->particle_spectrum->get_PDG_coded_mass( requested_element );

  if( return_value == REALLY_WRONG_VALUE )
    {

      std::cout << std::endl << "error!  get_MASS( " << requested_element << " ) asked for a mass that was not in the SLHA file.";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_MASS_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK MASS   # " << std::endl;

  int number_of_property_sets_to_write = this->particle_spectrum->get_particle_property_sets()->size();
  BOL_particle_property_set* set_being_written; 

  for( int particle_counter = 0; particle_counter < number_of_property_sets_to_write; particle_counter++ )
    // for each stored particle property set...
    {

      set_being_written = this->particle_spectrum->get_particle_property_sets()->at( particle_counter );

      return_string_builder << " " << old_CppSLHA::SLHA_int( set_being_written->get_PDG_code(), 9 )
			    << "   " << old_CppSLHA::SLHA_double( set_being_written->get_mass() )
			    << "   # " << set_being_written->get_name() << std::endl;

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_HMIX( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 4 ) )
    {

      return_value = this->EWSB_scalar_mixing_parameters[ ( requested_element - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_HMIX( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_HMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK HMIX Q= " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # Higgs mixing parameters" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_HMIX( 1 ) ) << "   # mu" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_HMIX( 2 ) ) << "   # tangent of beta at scale Q" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_HMIX( 3 ) ) << "   # v(Q)" << std::endl
    << "     4   " << old_CppSLHA::SLHA_double( this->get_HMIX( 4 ) ) << "   # m^2_A(Q)" << std::endl;

  return return_string_builder.str();

}


double old_CppSLHA::get_SPHENOLOWENERGY( int requested_element )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element > 0 )
      && ( requested_element <= 7 ) )
    {

      return_value = this->SPheno_low_energy_observables[ ( requested_element - 1 ) ];

    }
  else if( ( requested_element > 9 )
	   && ( requested_element <= 22 ) )
    {

      return_value = this->SPheno_low_energy_observables[ ( requested_element - 3 ) ];

    }
  else if( requested_element == 30 )
    {

      return_value = this->SPheno_low_energy_observables[ 19 ];

    }
  else if( ( requested_element > 39 )
	   && ( requested_element <= 42 ) )
    {

      return_value = this->SPheno_low_energy_observables[ ( requested_element - 20 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_SPHENOLOWENERGY( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_SPHENOLOWENERGY_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "BLOCK SPHENOLOWENERGY  # low energy observables as calculated by SPheno" << std::endl
    << "     1   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  1 ) ) << "   # BR(b -> s gamma)" << std::endl
    << "     2   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  2 ) ) << "   # BR(b -> s mu+ mu-)" << std::endl
    << "     3   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  3 ) ) << "   # BR(b -> s nu nu)" << std::endl
    << "     4   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  4 ) ) << "   # BR(Bs -> mu+ mu-)" << std::endl
    << "     5   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  5 ) ) << "   # BR(B_u -> tau nu)" << std::endl
    << "     6   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  6 ) ) << "   # |Delta(M_Bd)| [ps^-1] " << std::endl
    << "     7   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY(  7 ) ) << "   # |Delta(M_Bs)| [ps^-1] " << std::endl
    << "    10   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 10 ) ) << "   # Delta(g-2)_electron" << std::endl
    << "    11   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 11 ) ) << "   # Delta(g-2)_muon" << std::endl
    << "    12   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 12 ) ) << "   # Delta(g-2)_tau" << std::endl
    << "    13   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 13 ) ) << "   # electric dipole moment of the electron" << std::endl
    << "    14   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 14 ) ) << "   # electric dipole moment of the muon" << std::endl
    << "    15   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 15 ) ) << "   # electric dipole moment of the tau" << std::endl
    << "    16   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 16 ) ) << "   # Br(mu -> e gamma)" << std::endl
    << "    17   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 17 ) ) << "   # Br(tau -> e gamma)" << std::endl
    << "    18   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 18 ) ) << "   # Br(tau -> mu gamma)" << std::endl
    << "    19   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 19 ) ) << "   # Br(mu -> 3 e)" << std::endl
    << "    20   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 20 ) ) << "   # Br(tau -> 3 e)" << std::endl
    << "    21   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 21 ) ) << "   # Br(tau -> 3 mu)" << std::endl
    << "    30   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 30 ) ) << "   # Delta(rho_parameter)" << std::endl
    << "    40   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 40 ) ) << "   # BR(Z -> e mu)" << std::endl
    << "    41   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 41 ) ) << "   # BR(Z -> e tau)" << std::endl
    << "    42   " << old_CppSLHA::SLHA_double( this->get_SPHENOLOWENERGY( 42 ) ) << "   # BR(Z -> mu tau)" << std::endl;

  return return_string_builder.str();

}


void old_CppSLHA::set_BLOCK( std::string requested_BLOCK, int requested_element, double set_value )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  if( requested_BLOCK.compare( "MINPAR" ) == 0 )
    {

      set_MINPAR( requested_element, set_value );

    }
  else if( requested_BLOCK.compare( "EXTPAR" ) == 0 )
    {

      set_EXTPAR( requested_element, set_value );

    }
  else if( requested_BLOCK.compare( "SMINPUTS" ) == 0 )
    {

      set_SMINPUTS( requested_element, set_value );

    }
  else if( requested_BLOCK.compare( "GAUGE" ) == 0 )
    {

      set_GAUGE( requested_element, set_value );

    }
  else if( requested_BLOCK.compare( "MSOFT" ) == 0 )
    {

      set_MSOFT( requested_element, set_value );

    }
  else if( requested_BLOCK.compare( "MASS" ) == 0 )
    {

      set_MASS( requested_element, set_value );

    } 
  else if( requested_BLOCK.compare( "HMIX" ) == 0 )
    {

      set_HMIX( requested_element, set_value );

    }     
  else if( requested_BLOCK.compare( "SPHENOLOWENERGY" ) == 0 )
    {

      set_SPHENOLOWENERGY( requested_element, set_value );

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for set_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_MINPAR( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 6 ) )
    {

      this->minimal_parameters[ ( requested_element - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_MINPAR( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_EXTPAR( int requested_element, double set_value )
{

  if( ( requested_element >= 0 )
      && ( requested_element <= 3 ) )
    {

      this->extra_parameters[ ( requested_element - 0 ) ] = set_value;

    }
  else if( ( requested_element > 20 )
	   && ( requested_element <= 22 ) )
    {

      this->extra_parameters[ ( requested_element - 17 ) ] = set_value;

    }
  else if( ( requested_element > 30 )
	   && ( requested_element <= 36 ) )
    {

      this->extra_parameters[ ( requested_element - 25 ) ] = set_value;

    }
  else if( ( requested_element > 40 )
	   && ( requested_element <= 49 ) )
    {

      this->extra_parameters[ ( requested_element - 29 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_EXTPAR( " << requested_element << " ) asked for an element out of range";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_SMINPUTS( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 7 ) )
    {

      this->Standard_Model_inputs[ ( requested_element - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_SMINPUTS( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_GAUGE( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 3 ) )
    {

      this->gauge_couplings[ ( requested_element - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_GAUGE( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_MSOFT( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 3 ) )
    {

      this->soft_mass_terms[ ( requested_element - 1 ) ] = set_value;

    }
  else if( ( requested_element > 20 )
	   && ( requested_element <= 22 ) )
    {

      this->soft_mass_terms[ ( requested_element - 18 ) ] = set_value;

    }
  else if( ( requested_element > 30 )
	   && ( requested_element <= 36 ) )
    {

      this->soft_mass_terms[ ( requested_element - 26 ) ] = set_value;

    }
  else if( ( requested_element > 40 )
	   && ( requested_element <= 49 ) )
    {

      this->soft_mass_terms[ ( requested_element - 30 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_MSOFT( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_HMIX( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 4 ) )
    {

      this->EWSB_scalar_mixing_parameters[ ( requested_element - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_HMIX( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_SPHENOLOWENERGY( int requested_element, double set_value )
{

  if( ( requested_element > 0 )
      && ( requested_element <= 7 ) )
    {

      this->SPheno_low_energy_observables[ ( requested_element - 1 ) ] = set_value;

    }
  else if( ( requested_element > 9 )
	   && ( requested_element <= 22 ) )
    {

      this->SPheno_low_energy_observables[ ( requested_element - 3 ) ] = set_value;

    }
  else if( requested_element == 30 )
    {

      this->SPheno_low_energy_observables[ 19 ] = set_value;

    }
  else if( ( requested_element > 39 )
	   && ( requested_element <= 42 ) )
    {

      this->SPheno_low_energy_observables[ ( requested_element - 20 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_SPHENOLOWENERGY( " << requested_element << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


double old_CppSLHA::get_BLOCK( std::string requested_BLOCK, int requested_element_one, int requested_element_two )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  double return_value = REALLY_WRONG_VALUE;

  if( requested_BLOCK.compare( "YU" ) == 0 )
    {

      return_value = get_YU( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "YD" ) == 0 )
    {

      return_value = get_YD( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "YE" ) == 0 )
    {

      return_value = get_YE( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "AU" ) == 0 )
    {

      return_value = get_AU( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "AD" ) == 0 )
    {

      return_value = get_AD( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "AE" ) == 0 )
    {

      return_value = get_AE( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "STOPMIX" ) == 0 )
    {

      return_value = get_STOPMIX( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "SBOTMIX" ) == 0 )
    {

      return_value = get_SBOTMIX( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "STAUMIX" ) == 0 )
    {

      return_value = get_STAUMIX( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "NMIX" ) == 0 )
    {

      return_value = get_NMIX( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "UMIX" ) == 0 )
    {

      return_value = get_UMIX( requested_element_one, requested_element_two );

    }
  else if( requested_BLOCK.compare( "VMIX" ) == 0 )
    {

      return_value = get_VMIX( requested_element_one, requested_element_two );

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for get_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


double old_CppSLHA::get_YU( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->up_type_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_YU( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_YU_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK YU Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{

	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_YU( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " Y_u at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " Y_c at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " Y_t at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_YD( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->down_type_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_YD( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_YD_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK YD Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_YD( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " Y_d at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " Y_s at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " Y_b at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_YE( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->charged_lepton_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_YE( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_YE_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK YE Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_YE( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " Y_e at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " Y_mu at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " Y_tau at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_AU( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->up_type_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_AU( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_AU_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK AU Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_AU( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " A_u at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " A_c at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " A_t at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_AD( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->down_type_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_AD( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_AD_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK AD Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_AD( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " A_d at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " A_s at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " A_b at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_AE( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      return_value = this->charged_lepton_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_AE( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_AE_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK AE Q=  " << old_CppSLHA::SLHA_double( this->get_Q() ) << "   # (SUSY scale)" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 3;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 3;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_AE( element_one_counter, element_two_counter ) ) << "   #";

	  if( ( element_one_counter == 1 )
	      && ( element_two_counter == 1 ) )
	    {

	      return_string_builder << " A_e at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 2 )
		   && ( element_two_counter == 2 ) )
	    {

	      return_string_builder << " A_mu at scale Q in the DRbar scheme";

	    }
	  else if( ( element_one_counter == 3 )
		   && ( element_two_counter == 3 ) )
	    {

	      return_string_builder << " A_tau at scale Q in the DRbar scheme";

	    }

	  return_string_builder << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_STOPMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      return_value = this->stop_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_STOPMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_STOPMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK STOPMIX   # stop mixing matrix R_stop" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 2;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 2;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_STOPMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_SBOTMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      return_value = this->sbottom_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_SBOTMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_SBOTMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK SBOTMIX   # sbottom mixing matrix R_sbottom" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 2;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 2;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_SBOTMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_STAUMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      return_value = this->stau_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_STAUMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_STAUMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK STAUMIX   # stau mixing matrix R_stau" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 2;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 2;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_STAUMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_NMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 4 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 4 ) )
    {

      return_value = this->neutralino_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_NMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_NMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK NMIX   # neutralino mixing matrix N" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 4;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 4;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_NMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_UMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      return_value = this->chargino_U_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_UMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_UMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK UMIX   # chargino mixing matrix U" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 2;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 2;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_UMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


double old_CppSLHA::get_VMIX( int requested_element_one, int requested_element_two )
{

  double return_value = REALLY_WRONG_VALUE;

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      return_value = this->chargino_V_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ];

    }
  else
    {

      std::cout << std::endl << "error!  get_VMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

  return return_value;

}


std::string old_CppSLHA::get_VMIX_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder << "BLOCK VMIX   # chargino mixing matrix V" << std::endl;

  for( int element_one_counter = 1;
       element_one_counter <= 2;
       element_one_counter++ )
    {

      for( int element_two_counter = 1;
	   element_two_counter <= 2;
	   element_two_counter++ )
	{
	    
	  return_string_builder << " " << old_CppSLHA::SLHA_int( element_one_counter, 2 ) << " " << old_CppSLHA::SLHA_int( element_two_counter, 2 ) << "   " << old_CppSLHA::SLHA_double( this->get_VMIX( element_one_counter, element_two_counter ) ) << "   #" << std::endl;

	}

    }

  return return_string_builder.str();

}


void old_CppSLHA::set_BLOCK( std::string requested_BLOCK, int requested_element_one, int requested_element_two, double set_value )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  if( requested_BLOCK.compare( "YU" ) == 0 )
    {

      set_YU( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "YD" ) == 0 )
    {

      set_YD( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "YE" ) == 0 )
    {

      set_YE( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "AU" ) == 0 )
    {

      set_AU( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "AD" ) == 0 )
    {

      set_AD( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "AE" ) == 0 )
    {

      set_AE( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "STOPMIX" ) == 0 )
    {

      set_STOPMIX( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "SBOTMIX" ) == 0 )
    {

      set_SBOTMIX( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "STAUMIX" ) == 0 )
    {

      set_STAUMIX( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "NMIX" ) == 0 )
    {

      set_NMIX( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "UMIX" ) == 0 )
    {

      set_UMIX( requested_element_one, requested_element_two, set_value );

    }
  else if( requested_BLOCK.compare( "VMIX" ) == 0 )
    {

      set_VMIX( requested_element_one, requested_element_two, set_value );

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for set_BLOCK( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_YU( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->up_type_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_YU( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_YD( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->down_type_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_YD( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_YE( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->charged_lepton_Yukawa_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_YE( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_AU( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->up_type_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_AU( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_AD( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->down_type_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_AD( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_AE( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 3 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 3 ) )
    {

      this->charged_lepton_soft_trilinear_term_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_AE( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_STOPMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      this->stop_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_STOPMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_SBOTMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      this->sbottom_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_SBOTMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_STAUMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      this->stau_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_STAUMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_NMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 4 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 4 ) )
    {

      this->neutralino_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_NMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_UMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      this->chargino_U_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_UMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


void old_CppSLHA::set_VMIX( int requested_element_one, int requested_element_two, double set_value )
{

  if( ( requested_element_one > 0 )
      && ( requested_element_one <= 2 )
      && ( requested_element_two > 0 )
      && ( requested_element_two <= 2 ) )
    {

      this->chargino_V_mixing_matrix[ ( requested_element_one - 1 ) ][ ( requested_element_two - 1 ) ] = set_value;

    }
  else
    {

      std::cout << std::endl << "error!  set_VMIX( " << requested_element_one << ", "
		<< requested_element_two << " ) asked for an element out of range"
		<< " (note: the range is that of the SLHA format: from 1 to n rather than from 0 to n-1).";
      std::cout << std::endl;

      std::cout << std::endl << "because of this, calling exit( EXIT_FAILURE ).  sorry about the inevitable memory leaks...";
      std::cout << std::endl;
      exit( EXIT_FAILURE );

    }

}


std::string old_CppSLHA::get_BLOCK_as_string( std::string requested_BLOCK )
{

  std::transform( requested_BLOCK.begin(),
		  requested_BLOCK.end(),
		  requested_BLOCK.begin(),
		  old_CppSLHA::safeToUpperThing<std::toupper> );

  std::string return_string = "error!  unknown BLOCK requested from get_BLOCK_as_string()\n";

  if( requested_BLOCK.compare( "MODSEL" ) == 0 )
    {

      return_string = this->get_MODSEL_as_string();

    }
  else if( requested_BLOCK.compare( "MINPAR" ) == 0 )
    {

      return_string = this->get_MINPAR_as_string();

    }
  else if( requested_BLOCK.compare( "EXTPAR" ) == 0 )
    {

      return_string = this->get_EXTPAR_as_string();

    }
  else if( requested_BLOCK.compare( "SMINPUTS" ) == 0 )
    {

      return_string = this->get_SMINPUTS_as_string();

    }
  else if( requested_BLOCK.compare( "GAUGE" ) == 0 )
    {

      return_string = this->get_GAUGE_as_string();

    }
  else if( requested_BLOCK.compare( "YU" ) == 0 )
    {

      return_string = this->get_YU_as_string();

    }
  else if( requested_BLOCK.compare( "YD" ) == 0 )
    {

      return_string = this->get_YD_as_string();

    }
  else if( requested_BLOCK.compare( "YE" ) == 0 )
    {

      return_string = this->get_YE_as_string();

    }
  else if( requested_BLOCK.compare( "AU" ) == 0 )
    {

      return_string = this->get_AU_as_string();

    }
  else if( requested_BLOCK.compare( "AD" ) == 0 )
    {

      return_string = this->get_AD_as_string();

    }
  else if( requested_BLOCK.compare( "AE" ) == 0 )
    {

      return_string = this->get_AE_as_string();

    }
  else if( requested_BLOCK.compare( "MSOFT" ) == 0 )
    {

      return_string = this->get_MSOFT_as_string();

    }
  else if( requested_BLOCK.compare( "MASS" ) == 0 )
    {

      return_string = this->get_MASS_as_string();

    }
  else if( requested_BLOCK.compare( "ALPHA" ) == 0 )
    {

      return_string = this->get_ALPHA_as_string();

    }
  else if( requested_BLOCK.compare( "HMIX" ) == 0 )
    {

      return_string = this->get_HMIX_as_string();

    }
  else if( requested_BLOCK.compare( "STOPMIX" ) == 0 )
    {

      return_string = this->get_STOPMIX_as_string();

    }
  else if( requested_BLOCK.compare( "SBOTMIX" ) == 0 )
    {

      return_string = this->get_SBOTMIX_as_string();

    }
  else if( requested_BLOCK.compare( "STAUMIX" ) == 0 )
    {

      return_string = this->get_STAUMIX_as_string();

    }
  else if( requested_BLOCK.compare( "NMIX" ) == 0 )
    {

      return_string = this->get_NMIX_as_string();

    }
  else if( requested_BLOCK.compare( "UMIX" ) == 0 )
    {

      return_string = this->get_UMIX_as_string();

    }
  else if( requested_BLOCK.compare( "VMIX" ) == 0 )
    {

      return_string = this->get_VMIX_as_string();

    }
  else if( requested_BLOCK.compare( "DECAY" ) == 0 )
    {

      return_string = this->get_DECAY_as_string();

    }
  else if( requested_BLOCK.compare( "SPHENOLOWENERGY" ) == 0 )
    {

      return_string = this->get_SPHENOLOWENERGY_as_string();

    }
  else
    {

      std::cout << std::endl << "error!  unknown BLOCK for get_BLOCK_as_string( \"" << requested_BLOCK << "\" ) requested!";
      std::cout << std::endl;

    }

  return return_string;

}


std::string old_CppSLHA::get_DECAY_as_string()
{

  std::stringstream return_string_builder;

  return_string_builder
    << "# the DECAY section" << std::endl
    << "# PDG = PDG particle ID" << std::endl
    << "# Width = decay width in GeV" << std::endl
    << "# BR = branching ratio" << std::endl
    << "# NDA = number of decay products" << std::endl
    << "# ID1 = PDG particle ID of 1st decay product" << std::endl
    << "# ID2 = PDG particle ID of 2nd decay product" << std::endl
    << "# ID3 = PDG particle ID of 3rd decay product" << std::endl;

  int number_of_property_sets_to_write = this->particle_spectrum->get_particle_property_sets()->size();
  BOL_particle_property_set* set_being_written; 

  for( int particle_counter = 0; particle_counter < number_of_property_sets_to_write; particle_counter++ )
    // for each stored particle property set...
    {

      set_being_written = this->particle_spectrum->get_particle_property_sets()->at( particle_counter );

      return_string_builder
	<< "#" <<std::endl
	<< "#         PDG            Width" << std::endl
	<< "DECAY " << old_CppSLHA::SLHA_int( set_being_written->get_PDG_code(), 9 )
	<<  "   " << old_CppSLHA::SLHA_double( set_being_written->get_decay_width() )
	<< "   # " << set_being_written->get_name() << " decays" << std::endl
	<< "#   BR               NDA         ID1       ID2       ID3" << std::endl;
      //  xxx+1.23456789E+123   12   123456789 123456789 123456789  #

      for( std::list< BOL_particle_decay* >::iterator direct_decay_iterator =
	     set_being_written->get_direct_decays()->begin();
	   direct_decay_iterator != set_being_written->get_direct_decays()->end();
	   direct_decay_iterator++ )  // for each decay channel of this particle...
	{

	  return_string_builder
	    << "   " << old_CppSLHA::SLHA_double( (*direct_decay_iterator)->get_branching_ratio() )  // write the BR
	    << "   " << old_CppSLHA::SLHA_int( (*direct_decay_iterator)->get_decay_product_PDG_codes()->size(), 2 )
	    // & the number of decay products.
	    << "   ";

	  for( std::list< int >::iterator decay_product_iterator = (*direct_decay_iterator)->get_decay_product_PDG_codes()->begin();
	       decay_product_iterator != (*direct_decay_iterator)->get_decay_product_PDG_codes()->end();
	       decay_product_iterator++ )  // for each decay product...
	    {

	      return_string_builder << old_CppSLHA::SLHA_int( *decay_product_iterator, 9 ) << " ";  // print the PDG code.

	    }

	  return_string_builder << "  # BR for " <<  set_being_written->get_name() << " ->";  // comment the human-readable version.

	  for( std::list< int >::iterator decay_product_iterator = (*direct_decay_iterator)->get_decay_product_PDG_codes()->begin();
	       decay_product_iterator != (*direct_decay_iterator)->get_decay_product_PDG_codes()->end();
	       decay_product_iterator++ )  // for each decay product...
	    {

	      return_string_builder << " " << this->particle_spectrum->get_PDG_coded_name( *decay_product_iterator );

	    }

	  return_string_builder << std::endl;

	}

    }

  return_string_builder << "# end of DECAY section" << std::endl << "#" << std::endl;

  return return_string_builder.str();

}


bool old_CppSLHA::read_file()  // this reads in the SLHA file and returns true if it was successful.
{

  this->reset();

  bool successful_reading = false;

  std::cout << std::endl << "old_CppSLHA::read_file() (using \"" << SLHA_file_name << "\") has been called" << std::endl;

  // open the file.
  std::ifstream* input_file = new std::ifstream();
  input_file->open( SLHA_file_name.c_str() );

  if( input_file->is_open() )  // if the file was successfully opened...
    {

      std::string input_line_as_string = "before input";  // prepare the string used for holding the line read.
      std::istringstream input_line_as_stream( input_line_as_string );  // prepare an istringstream to parse the line.
      std::string word_being_read = "unread";  // prepare a string to be the word being read.
      char character_being_read = 'x';  // prepare a character for checking for the commenting character #.
      int position_of_character_in_line = 0;  // prepare a number to track how far along a line we have gone looking for a #.

      int line_count = 0;  // a counter for the number of lines read.

      // a set of integers & doubles for holding the data from a line or lines before recording the data,
      // plus a dummy string for ditching stuff like "Q=".
      int formatting_integer_one;
      int formatting_integer_two;
      int formatting_integer_three;
      int currently_decaying_particle;
      int current_number_of_decay_products;
      double formatting_double;
      std::string formatting_string;

      BLOCK_enum current_BLOCK = UNKNOWN;  // a counter to keep track of which BLOCK is being read.

      while( !( input_file->eof() )
	     && ( line_count < 10000 ) )
	// while inputline is not ``equal'' to EOF or we have not gone more than 10000 lines in (which should be long enough for the
	// SLHA file)...
	{

	  std::getline( *input_file, input_line_as_string );
	  // take in a line (should only read up to a newline character, & not include it) & assign it to the string input_line_as_string.

	  if( input_line_as_string.compare( "" ) != 0 )
	    // ignoring blank lines... (string.compare() returns 0 if the comparison is good.)
	    {
		
	      // check to see if the 1st non-whitespace character is a letter, a number or a #

	      position_of_character_in_line = 0;

	      character_being_read = input_line_as_string[ position_of_character_in_line ];

	      while( character_being_read == ' ' )
		{

		  position_of_character_in_line++;

		  character_being_read = input_line_as_string[ position_of_character_in_line ];

		}

	      if( character_being_read != '#' )  // if we have not found a comment mark before anything else but whitespace...
		{

		  std::transform( input_line_as_string.begin(),
				  input_line_as_string.end(),
				  input_line_as_string.begin(),
				  toupper );  // convert all the lowercase letters in the line to uppercase.

		  input_line_as_stream.str( input_line_as_string );  // reset the istringstream.
		    
		  if( input_line_as_string.compare( position_of_character_in_line,
						    5,
						    "BLOCK" ) == 0 )  // if we have found the declaration line of a BLOCK...
		    {

		      input_line_as_stream.ignore( ( position_of_character_in_line + 5 ) );
		      // skip the whitespace + BLOCK of this istringstream.

		      input_line_as_stream >> word_being_read;

		      if( word_being_read.compare( "MODSEL" ) == 0 )  // if the BLOCK is MODSEL...
			{

			  current_BLOCK = MODSEL;  // note that we are reading the MODSEL BLOCK.

			}
		      else if( word_being_read.compare( "MINPAR" ) == 0 )  // if the BLOCK is MINPAR...
			{
			  
			  current_BLOCK = MINPAR;  // note that we are reading the MINPAR BLOCK.

			}
		      else if( word_being_read.compare( "EXTPAR" ) == 0 )  // if the BLOCK is EXTPAR...
			{
			  
			  current_BLOCK = EXTPAR;  // note that we are reading the EXTPAR BLOCK.

			}
		      else if( word_being_read.compare( "SMINPUTS" ) == 0 )  // if the BLOCK is SMINPUTS...
			{
			  
			  current_BLOCK = SMINPUTS;  // note that we are reading the SMINPUTS BLOCK.

			}
		      else if( word_being_read.compare( "GAUGE" ) == 0 )  // if the BLOCK is GAUGE...
			{
			  
			  current_BLOCK = GAUGE;  // note that we are reading the GAUGE BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "YU" ) == 0 )  // if the BLOCK is YU...
			{
			  
			  current_BLOCK = YU;  // note that we are reading the YU BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "YD" ) == 0 )  // if the BLOCK is YD...
			{
			  
			  current_BLOCK = YD;  // note that we are reading the YD BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "YE" ) == 0 )  // if the BLOCK is YE...
			{
			  
			  current_BLOCK = YE;  // note that we are reading the YE BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "AU" ) == 0 )  // if the BLOCK is AU...
			{
			  
			  current_BLOCK = AU;  // note that we are reading the AU BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "AD" ) == 0 )  // if the BLOCK is AD...
			{
			  
			  current_BLOCK = AD;  // note that we are reading the AD BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "AE" ) == 0 )  // if the BLOCK is AE...
			{
			  
			  current_BLOCK = AE;  // note that we are reading the AE BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "MSOFT" ) == 0 )  // if the BLOCK is MSOFT...
			{
			  
			  current_BLOCK = MSOFT;  // note that we are reading the MSOFT BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "MASS" ) == 0 )  // if the BLOCK is MASS...
			{
			  
			  current_BLOCK = MASS;  // note that we are reading the MASS BLOCK.

			}
		      else if( word_being_read.compare( "ALPHA" ) == 0 )  // if the BLOCK is ALPHA...
			{
			  
			  current_BLOCK = ALPHA;  // note that we are reading the ALPHA BLOCK.

			}
		      else if( word_being_read.compare( "HMIX" ) == 0 )  // if the BLOCK is HMIX...
			{

			  current_BLOCK = HMIX;  // note that we are reading the HMIX BLOCK.

			  input_line_as_stream >> formatting_string >> this->SUSY_scale;

			}
		      else if( word_being_read.compare( "STOPMIX" ) == 0 )  // if the BLOCK is STOPMIX...
			{

			  current_BLOCK = STOPMIX;  // note that we are reading the STOPMIX BLOCK.

			}
		      else if( word_being_read.compare( "SBOTMIX" ) == 0 )  // if the BLOCK is SBOTMIX...
			{

			  current_BLOCK = SBOTMIX;  // note that we are reading the SBOTMIX BLOCK.
		
			}
		      else if( word_being_read.compare( "STAUMIX" ) == 0 )  // if the BLOCK is STAUMIX...
			{

			  current_BLOCK = STAUMIX;  // note that we are reading the STAUMIX BLOCK.

			}
		      else if( word_being_read.compare( "NMIX" ) == 0 )  // if the BLOCK is NMIX...
			{

			  current_BLOCK = NMIX;  // note that we are reading the NMIX BLOCK.

			}
		      else if( word_being_read.compare( "UMIX" ) == 0 )  // if the BLOCK is UMIX...
			{

			  current_BLOCK = UMIX;  // note that we are reading the UMIX BLOCK.

			}
		      else if( word_being_read.compare( "VMIX" ) == 0 )  // if the BLOCK is VMIX...
			{

			  current_BLOCK = VMIX;  // note that we are reading the VMIX BLOCK.
		
			}
		      else if( word_being_read.compare( "SPHENOLOWENERGY" ) == 0 )  // if the BLOCK is SPHENOLOWENERGY...
			{

			  current_BLOCK = SPHENOLOWENERGY;  // note that we are reading the SPHENOLOWENERGY BLOCK.
		
			}
		      else  // otherwise, we are reading a BLOCK about which we don't care (in this version of the code).
			{
			    
			  current_BLOCK = UNKNOWN;

			}

		    }
		  else if( input_line_as_string.compare( position_of_character_in_line,
							 5,
							 "DECAY" ) == 0 )  // otherwise, maybe we are about to read in a decay...
		    {

		      current_BLOCK = DECAY;

		      input_line_as_stream.ignore( ( position_of_character_in_line + 5 ) );
		      // skip the whitespace + DECAY of this istringstream.

		      input_line_as_stream >> currently_decaying_particle >> formatting_double;

		      this->particle_spectrum->record_PDG_coded_decay_width( currently_decaying_particle,
									     formatting_double );

		    }
		  else if( current_BLOCK == MODSEL )  // otherwise, we could be reading the MODSEL BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two;

		      this->model_selection = formatting_integer_two;

		    }
		  else if( current_BLOCK == MINPAR )  // otherwise, we could be reading the MINPAR BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_MINPAR( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == EXTPAR )  // otherwise, we could be reading the EXTPAR BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_EXTPAR( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == SMINPUTS )  // otherwise, we could be reading the SMINPUTS BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_SMINPUTS( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == GAUGE )  // otherwise, we could be reading the GAUGE BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_GAUGE( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == YU )  // otherwise, we could be reading the YU BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_YU( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == YD )  // otherwise, we could be reading the YD BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_BLOCK( "YD", formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == YE )  // otherwise, we could be reading the YE BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_YE( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == AU )  // otherwise, we could be reading the AU BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_AU( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == AD )  // otherwise, we could be reading the AD BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_AD( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == AE )  // otherwise, we could be reading the AE BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_AE( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == MSOFT )  // otherwise, we could be reading the MSOFT BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_MSOFT( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == MASS )  // otherwise, we could be reading the MASS BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->particle_spectrum->record_PDG_coded_mass( formatting_integer_one,
								      formatting_double );
		      // record the mass according to its PDG code.

		    }
		  else if( current_BLOCK == ALPHA )  // otherwise, we could be reading the ALPHA BLOCK...
		    {

		      input_line_as_stream >> formatting_double;

		      this->EWSB_scalar_mixing_angle = formatting_double;

		    }
		  else if( current_BLOCK == HMIX )  // otherwise, we could be reading the HMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_HMIX( formatting_integer_one, formatting_double );

		    }
		  else if( current_BLOCK == STOPMIX )  // otherwise, we could be reading the STOPMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_STOPMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == SBOTMIX )  // otherwise, we could be reading the SBOTMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_SBOTMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == STAUMIX )  // otherwise, we could be reading the STAUMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_STAUMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == NMIX )  // otherwise, we could be reading the NMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_NMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == UMIX )  // otherwise, we could be reading the UMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_UMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == VMIX )  // otherwise, we could be reading the VMIX BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_double;

		      this->set_VMIX( formatting_integer_one, formatting_integer_two, formatting_double );

		    }
		  else if( current_BLOCK == DECAY )  // or we could be reading a DECAY.
		    {

		      input_line_as_stream >> formatting_double >> current_number_of_decay_products;
		      // read in as far as knowing how many decay products there are.

		      if( current_number_of_decay_products == 2 )  // if it is a 2-body decay...
			{

			  input_line_as_stream >> formatting_integer_one >> formatting_integer_two;  // read in the decay products.

			  this->particle_spectrum->record_PDG_coded_direct_decay( currently_decaying_particle,
										  formatting_integer_one,
										  formatting_integer_two,
										  formatting_double );
			  // record a 2-body decay.

			}
		      else if( current_number_of_decay_products == 3 )  // if it is a 3-body decay...
			{

			  input_line_as_stream >> formatting_integer_one >> formatting_integer_two >> formatting_integer_three;
			  // read in the decay products.

			  this->particle_spectrum->record_PDG_coded_direct_decay( currently_decaying_particle,
										  formatting_integer_one,
										  formatting_integer_two,
										  formatting_integer_three,
										  formatting_double );
			  // record a 3-body decay.

			}
		      else  // otherwise it was a 1-body-decay (nonsensical in this context) or a 4-or-more-body decay,
			// & coping with this has not been implemented.
			{

			  std::cout << std::endl << "Warning!  CppSLHA has encountered a "
				    << current_number_of_decay_products << "-body decay in the SLHA file \"" << SLHA_file_name
				    << "\" and has not recorded it." << std::endl;

			}

		    }
		  else if( current_BLOCK == SPHENOLOWENERGY )  // otherwise, we could be reading the SPHENOLOWENERGY BLOCK...
		    {

		      input_line_as_stream >> formatting_integer_one >> formatting_double;

		      this->set_SPHENOLOWENERGY( formatting_integer_one, formatting_double );

		    }
		  else  // otherwise, we are reading something like a BLOCK about which we don't care (in this version of the code).
		    {

		      current_BLOCK = UNKNOWN;

		    }

		}  // otherwise it has been commented out, so ignore the line.

	    }

	  line_count++;

	}

      input_file->close();

      successful_reading = true;

    }  // end of if block checking that the SLHA file was successfully opened.
  else
    {

      std::cout << std::endl << "error!  the file \"" << SLHA_file_name << "\" could not be opened!" << std::endl;

      // successful_reading = false; // well, it initializes as false, so this line is unnecessary.
      // it's here, commented out, as a reminder.

    }

    
  // clean up.
  delete input_file;

  return successful_reading;

}


bool old_CppSLHA::read_file( std::string new_SLHA_file_name )  // this reads in the specified SLHA file and returns true if it was successful.
{

  std::cout << std::endl << "old_CppSLHA::read_file( \"" << new_SLHA_file_name << "\" ) called";
    std::cout << " - warning, all previously held data in this instance has been discarded.";
  std::cout << std::endl;

  this->SLHA_file_name = new_SLHA_file_name;

  return this->read_file();

}


// bool old_CppSLHA::write_file( std::string output_SLHA_file_name )
// // this writes out all the BLOCKs to a file with the given name (DECAY counts as a BLOCK name in this case).
// {

//   std::ofstream* output_file = new std::ofstream();

//   output_file->open( output_SLHA_file_name.c_str() );

//   *output_file << "# this was generated automatically by a program using BOL's CppSLHA #" << std::endl;
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "MODSEL" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "MINPAR" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "EXTPAR" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "SMINPUTS" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "GAUGE" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "YU" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "YD" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "YE" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "AU" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "AD" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "AE" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "MSOFT" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "MASS" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "ALPHA" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "HMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "STOPMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "SBOTMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "STAUMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "NMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "UMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "VMIX" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "DECAY" );
//   *output_file << "#-------------------------------------------#" << std::endl << spectrum->get_BLOCK_as_string( "SPHENOLOWENERGY" );
//   *output_file << "#-------------------------------------------#" << std::endl;

//   *output_file << std::endl;  // put an extra newline at the end, just for kicks.


//   // now close the file.
//   output_file->close();


//   // clean up.
//   delete output_file;
//   output_file = 0;

// };


void old_CppSLHA::write_file( std::string output_SLHA_file_name, std::list< std::string >* list_of_BLOCKS )
// this writes out the BLOCKs from the supplied list to a file with the given name (DECAY counts as a BLOCK name in this case).
{

  std::ofstream* output_file = new std::ofstream();

  output_file->open( output_SLHA_file_name.c_str() );

  for( std::list< std::string >::iterator BLOCK_iterator = list_of_BLOCKS->begin();
       BLOCK_iterator != list_of_BLOCKS->end();
       BLOCK_iterator++ )  // go through the supplied list.
    {

      *output_file << get_BLOCK_as_string( *BLOCK_iterator );  // write each BLOCK.

    }

  *output_file << std::endl;  // put an extra newline at the end, just for kicks.


  // now close the file.
  output_file->close();


  // clean up.
  delete output_file;
  output_file = 0;

}



// STUFF FOR TESTING PURPOSES!

int old_CppSLHA::write_particle_spectrum( double minimum_branching_ratio_to_keep, std::string output_file_name )
// this writes all the stored spectrum data to a file with the provided name.  it returns the number of particle property sets written.
{

  std::cout << std::endl << "old_CppSLHA::write_particle_spectrum() has been called" << std::endl;

  std::cout << std::endl << "found " << this->particle_spectrum->find_all_cascade_decays( minimum_branching_ratio_to_keep ) << " cascade decays" << std::endl;

  std::ofstream* output_file = new std::ofstream();

  output_file->open( output_file_name.c_str() );

  *output_file << "# this is a file with the data from a CppSLHA instance #" << std::endl;

  BOL_particle_property_set* set_being_written; 

  // int PDG_code_being_written;

  int number_of_property_sets_to_write = this->particle_spectrum->get_particle_property_sets()->size();
  for( int particle_counter = 0; particle_counter < number_of_property_sets_to_write; particle_counter++ )
    // for each stored particle property set...
    {

      // write out the properties.
      set_being_written = this->particle_spectrum->get_particle_property_sets()->at( particle_counter );

      *output_file << std::endl << " stored particle " << particle_counter
		   << ": PDG code " << set_being_written->get_PDG_code()
		   << ", name " << set_being_written->get_name()
		   << ", mass " << set_being_written->get_mass()
		   << ", decay width " << set_being_written->get_decay_width();
      if( set_being_written->counts_as_stable_invisible() )
	{

	  *output_file << ", counts as stable and invisible";

	}
      else
	{

	  *output_file << ", does not count as stable and invisible";

	}
      if( set_being_written->counts_as_jet() )
	{

	  *output_file << ", counts as a jet";

	}
      else
	{

	  *output_file << ", does not count as a jet";

	}
      if( set_being_written->counts_as_light_lepton() )
	{

	  *output_file << ", counts as a light lepton";

	}
      else
	{

	  *output_file << ", does not count as a light lepton";

	}
      if( set_being_written->counts_as_self_conjugate() )
	{

	  *output_file << ", counts as self-conjugate";

	}
      else
	{

	  *output_file << ", does not count as self-conjugate";

	}

      *output_file << std::endl << " direct decays (" << set_being_written->get_direct_decays()->size() << "):" << std::endl;

      for( std::list< BOL_particle_decay* >::iterator direct_decay_iterator =
	     set_being_written->get_direct_decays()->begin();
	   direct_decay_iterator != set_being_written->get_direct_decays()->end();
	   direct_decay_iterator++ )
	{

	  *output_file << "(" << (*direct_decay_iterator)->get_decay_product_PDG_codes()->size() << "-body)";

	  for( std::list< int >::iterator decay_product_iterator = (*direct_decay_iterator)->get_decay_product_PDG_codes()->begin();
	       decay_product_iterator != (*direct_decay_iterator)->get_decay_product_PDG_codes()->end();
	       decay_product_iterator++ )
	    {

	      *output_file << " " << *decay_product_iterator << " ("
			   << this->particle_spectrum->get_PDG_coded_name( *decay_product_iterator ) << ")";


	    }

	  *output_file << " BR:" << (*direct_decay_iterator)->get_branching_ratio() << std::endl;

	}

      *output_file << std::endl << " cascade decays (" << set_being_written->get_cascade_decays()->size() << "):" << std::endl;

      for( std::list< BOL_particle_decay* >::iterator cascade_decay_iterator =
	     set_being_written->get_cascade_decays()->begin();
	   cascade_decay_iterator != set_being_written->get_cascade_decays()->end();
	   cascade_decay_iterator++ )
	{

	  *output_file << "(" << (*cascade_decay_iterator)->get_decay_product_PDG_codes()->size() << "-body)";

	  for( std::list< int >::iterator decay_product_iterator = (*cascade_decay_iterator)->get_decay_product_PDG_codes()->begin();
	       decay_product_iterator != (*cascade_decay_iterator)->get_decay_product_PDG_codes()->end();
	       decay_product_iterator++ )
	    {

	      *output_file << " " << *decay_product_iterator << " ("
			   << this->particle_spectrum->get_PDG_coded_name( *decay_product_iterator ) << ")";

	    }

	  *output_file << " BR:" << (*cascade_decay_iterator)->get_branching_ratio() << std::endl;

	}

    }

  std::cout << std::endl << "finished BOL_EW_scale_spectrum data, now writing the extra stuff.";
  std::cout << std::endl;
  *output_file << std::endl << std::endl;
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "MODSEL" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "MINPAR" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "EXTPAR" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "SMINPUTS" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "GAUGE" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "YU" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "YD" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "YE" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "AU" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "AD" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "AE" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "MSOFT" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "MASS" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "ALPHA" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "HMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "STOPMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "SBOTMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "STAUMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "NMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "UMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "VMIX" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "DECAY" );
  *output_file << "---------------------------------------------" << std::endl << this->get_BLOCK_as_string( "SPHENOLOWENERGY" );
  *output_file << "---------------------------------------------" << std::endl;


  // now close the file.
  output_file->close();


  // clean up.
  delete output_file;
  output_file = 0;

  return number_of_property_sets_to_write;

}
// END OF TESTING METHOD!


old_CppSLHA::~old_CppSLHA()  // destructor
  {

    if( allocated_spectrum_memory )  // if the constructor allocated memory for the spectrum...
      {

	delete particle_spectrum;  // deallocate the memory.

      }  // otherwise, the CppSLHA instance was passed a pointer to some pre-existing spectrum,
         // which should not be deleted by this destructor.

  }
