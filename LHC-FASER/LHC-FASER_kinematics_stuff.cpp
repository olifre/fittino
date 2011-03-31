/*
 * LHC-FASER_kinematics_stuff.hpp
 *
 *  Created on: 02 Mar 2011
 *      Author: bol
 */

#include "LHC-FASER_kinematics_stuff.hpp"

namespace LHC_FASER
{


  lepton_acceptance_cut::lepton_acceptance_cut() :
    default_transverse_momentum_cut( 10.0 ),
    bin_size( 2.0 ),
    effective_squark_mass( 0.0 ),
    pseudorapidity_acceptance( 0.0 )
  {

    acceptance_bins.push_back( 0.0 );
    // this is to ensure that there is at least 1 entry for the transverse
    // momentum cut.

  }

  lepton_acceptance_cut::lepton_acceptance_cut( double const given_default_cut,
                                                double const given_bin_size ) :
    default_transverse_momentum_cut( given_default_cut ),
    bin_size( given_bin_size ),
    effective_squark_mass( 0.0 ),
    pseudorapidity_acceptance( 0.0 )
  {

    acceptance_bins.push_back( 0.0 );
    // this is to ensure that there is at least 1 entry for the transverse
    // momentum cut.

  }

  lepton_acceptance_cut::~lepton_acceptance_cut()
  {

    // does nothing.

  }


  void
  lepton_acceptance_cut::set_values( std::vector< double >* given_values )
  /* this takes a vector of doubles & stores the 1st value as the effective
   * squark mass, the 2nd as the pseudorapidity cut acceptance, & the rest
   * of the values as the transverse momentum cut bin acceptances.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: lepton_acceptance_cut::set_values() called."
    << "(this pointer = " << this << ")";
    std::cout << std::endl;**/

    if( 3 < given_values->size() )
      {

        std::vector< double >::const_iterator
        value_iterator = given_values->begin();
        effective_squark_mass = *value_iterator;
        ++value_iterator;

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: lepton_acceptance_cut::set_values() set"
        << " effective_squark_mass to be " << effective_squark_mass;
        std::cout << std::endl;**/

        pseudorapidity_acceptance = *value_iterator;
        ++value_iterator;

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: lepton_acceptance_cut::set_values() set"
        << " pseudorapidity_acceptance to be " << pseudorapidity_acceptance;
        std::cout << std::endl;
        int bin_counter = -1;**/

        acceptance_bins.clear();
        while( given_values->end() > value_iterator )
          {
            // debugging:
            /**std::cout
            << std::endl
            << "debugging: lepton_acceptance_cut::set_values() setting"
            << " bin " << ++bin_counter << " to be " << *value_iterator;
            std::cout << std::endl;**/

            acceptance_bins.push_back( *value_iterator );
            ++value_iterator;


          }

      }

  }


  double
  lepton_acceptance_cut::acceptance_at( double const given_energy,
                                        double const given_cut )
  const
  /* this interpolates the values in acceptance_bins to the requested value,
   * or returns pseudorapidity_acceptance if it's lower, scaled to the given
   * value for the transverse momentum cut.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: lepton_acceptance_cut::acceptance_at( "
    << given_energy << ", " << given_cut << " ) called";
    std::cout << std::endl;**/

    double return_value = 0.0;

    if( ( 0.0 < given_energy )
        &&
        ( 0.0 < given_cut ) )
      {

        double
        bin_fraction = ( given_energy * ( default_transverse_momentum_cut
                                        / ( given_cut * bin_size ) ) );
        // now bin_fraction is given_energy scaled to the given momentum cut,
        // in units of bin_size. importantly, bin_fraction > 0.0 still.

        int lower_bin = (int)bin_fraction;
        /* now lower_bin is 1 more than the lower bin for given_energy because
         * "bin -1" is the acceptance for 0.0 GeV, which is 0.0 by assumption.
         * "bin 0" is for 2.0 GeV by default, "bin 1" for 4.0 GeV, & so on.
         */
        bin_fraction -= (double)lower_bin;
        // now bin_fraction is the fraction of the bin along from lower_bin
        // that given_energy corresponds to.
        --lower_bin;
        // now lower_bin corresponds to the correct bin for given_energy.

        // debugging:
        /**std::cout
        << std::endl
        << "bin_fraction = " << bin_fraction
        << ", lower_bin = " << lower_bin
        << ", acceptance_bins.size() = " << acceptance_bins.size();
        std::cout << std::endl;**/

        if( -1 == lower_bin )
          // if we're in the region 0.0 GeV to bin_size GeV...
          {

            // debugging:
            /**std::cout
            << std::endl
            << "( -1 == lower_bin ) is true, bin_fraction = "
            << bin_fraction << ", acceptance_bins.front() = "
            << acceptance_bins.front();
            std::cout << std::endl;**/

            return_value = ( given_energy
                             * acceptance_bins.front() );
            // we assume that the acceptance at 0.0 GeV is 0.0, so the linear
            // interpolation is simple.

          }
        else if( ( 0 <= lower_bin )
                 &&
                 ( acceptance_bins.size() > ( lower_bin + 1 ) ) )
          // if we're in a region between 2 bin entries...
          {

            // debugging:
            /**std::cout
            << std::endl
            << "( ( ( 0 <= lower_bin ) &&"
            << " ( acceptance_bins.size() > ( lower_bin + 1 ) ) ) is true,"
            << " acceptance_bins.at( lower_bin ) = "
            << acceptance_bins.at( lower_bin )
            << ", bin_fraction = "
            << bin_fraction
            << ", acceptance_bins.at( ( lower_bin + 1 ) ) = "
            << acceptance_bins.at( ( lower_bin + 1 ) );
            std::cout << std::endl;**/

            return_value
            = ( acceptance_bins.at( lower_bin )
                + bin_fraction * ( acceptance_bins.at( ( lower_bin + 1 ) )
                                   - acceptance_bins.at( lower_bin ) ) );
            // we return a linear interpolation.

          }
        else if( acceptance_bins.size() <= ( lower_bin + 1 ) )
          // if we're in a region beyond the bins...
          {

            // debugging:
            /**std::cout
            << std::endl
            << "( acceptance_bins.size() <= ( lower_bin + 1 ) ) is true,"
            << " acceptance_bins.back() = " << acceptance_bins.back();
            std::cout << std::endl;**/

            return_value = acceptance_bins.back();
            // we assume the acceptance is dominated by the pseudorapidity cut
            // by this point, so is constant out to any higher energy.

          }

        // this is a sanity check that I have decided is unnecessary:
        /*if( pseudorapidity_acceptance < return_value )
          {

            return_value = pseudorapidity_acceptance;

          }*/

      }

    return return_value;

  }



  acceptance_grid::acceptance_grid(
                                  std::string const* const grid_file_location )
  {

    // read in the grid:

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: acceptance_grid::acceptance_grid( " << *grid_file_location
    << " ) called";
    std::cout << std::endl;**/

    if( NULL != grid_file_location )
      {

        // open the file:
        int const max_length_of_grid_file = 100000;
        CppSLHA::hash_commented_file_reader
        input_file_reader( grid_file_location,
                           max_length_of_grid_file,
                           false );
        /* a hundred thousand lines should be long enough for any grid file. if
         * read_in() is reading in more lines than that, it's probably because
         * of some file corruption.
         * also, if it's not enough, change it here.
         */

        std::string input_line_as_string;
        // prepare a string to parse the line.
        std::stringstream input_line_as_stream;
        // prepare a stringstream to parse the line.

        // the masses from the last line read & the currently-read line:
        double last_squark_mass = 0.0;
        double last_gluino_mass = 0.0;
        double current_squark_mass = 0.0;
        double current_gluino_mass = 0.0;
        std::vector< double > neutralino_masses;
        lowest_squark_mass = 0.0;
        lowest_gluino_mass = 0.0;

        double current_value;
        // the value currently being read in.

        bool grid_size_still_unknown = true;
        // we start out not knowing the step size for the grid (but we do
        // assume that it is a square grid).

        std::vector< double >* current_acceptance_vector = NULL;
        // this holds all the acceptance values for a grid point.
        std::vector< std::vector< double >* >*
        current_neutralino_vector = NULL;
        // this holds all the values for a set of points with the same
        // squark & gluino masses, but varying neutralino masses.
        std::vector< std::vector< std::vector< double >* >* >*
        current_gluino_vector = NULL;
        // this holds all the values for a set of points with the same
        // squark masses, but varying gluino masses.

        while( input_file_reader.read_line( &input_line_as_string ) )
          // the evaluation of the conditional reads in the next line.
          {

            // read in the line for interpretting:
            input_line_as_stream.clear();
            input_line_as_stream.str( input_line_as_string );

            // update what the masses for the last line were:
            last_squark_mass = current_squark_mass;
            last_gluino_mass = current_gluino_mass;

            input_line_as_stream >> current_squark_mass
                                 >> current_gluino_mass;
            input_line_as_stream >> current_value;
            if( grid_size_still_unknown )
              {
                neutralino_masses.push_back( current_value );
              }
            input_line_as_stream >> current_value;
            if( grid_size_still_unknown )
              {
                neutralino_masses.push_back( current_value );
              }

            current_acceptance_vector = new std::vector< double >();
            while( !(input_line_as_stream.eof()) )
              {

                input_line_as_stream >> current_value;
                current_acceptance_vector->push_back( current_value );

              }

            if( current_squark_mass > last_squark_mass )
              // if the squark mass has changed, we need a new vector for the
              // values for varying gluino masses.
              {

                // 1st record the last set of points with the same squark mass:
                if( NULL != current_gluino_vector )
                  // if we have a vector to add...
                  {

                    current_gluino_vector->push_back(
                                                   current_neutralino_vector );
                    values.push_back( current_gluino_vector );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "pushed back a neutralino vector of size "
                    << current_neutralino_vector->size()
                    << " and a gluino vector of size "
                    << current_gluino_vector->size();**/

                  }

                // prepare a new vector for the new squark mass:
                current_gluino_vector
                = new std::vector< std::vector< std::vector< double >* >* >();
                // prepare a new vector for the new gluino mass:
                current_neutralino_vector
                = new std::vector< std::vector< double >* >();

              }
            else if( current_gluino_mass > last_gluino_mass )
              /* if the gluino mass has changed (but the squark mass has not
               * changed, we need a new vector for the values for varying
               * neutralino masses.
               */
              {

                // 1st record the last set of points with the same gluino mass:
                current_gluino_vector->push_back( current_neutralino_vector );

                // debugging:
                /**std::cout
                << std::endl
                << "pushed back a neutralino vector of size "
                << current_neutralino_vector->size();**/

                // prepare a new vector for the new gluino mass:
                current_neutralino_vector
                = new std::vector< std::vector< double >* >();

              }

            if( !grid_size_still_unknown
                &&
                ( acceptance_columns > current_acceptance_vector->size() ) )
              {

                acceptance_columns = current_acceptance_vector->size();

                std::cout
                << std::endl
                << "LHC-FASER warning! read in an acceptance grid line that"
                << " is shorter than the previous one, so the grid is"
                << " \"ragged\"; hence *all* the lines for this grid will be"
                << " truncated to this smaller length.";
                std::cout << std::endl;

              }
            current_neutralino_vector->push_back( current_acceptance_vector );

            if( grid_size_still_unknown
                &&
                ( 0.0 < last_squark_mass )
                &&
                ( 0.0 < last_gluino_mass )
                &&
                ( ( current_squark_mass > last_squark_mass )
                  ||
                  ( current_gluino_mass > last_gluino_mass ) ) )
              // if we still need to work out the grid step size & we have read
              // in enough to do so...
              {

                acceptance_columns = current_acceptance_vector->size();

                // first we take note of the 1st point, which should have the
                // lowest co-ordinate values:
                lowest_squark_mass = last_squark_mass;
                lowest_gluino_mass = last_gluino_mass;

                // then we work out the grid step size:
                if( current_gluino_mass > last_gluino_mass )
                  // if it was the gluino mass that incremented...
                  {

                    scolored_mass_step_size
                    = ( current_gluino_mass - last_gluino_mass );

                  }
                else
                  // otherwise it was the squark mass that incremented...
                  {

                    scolored_mass_step_size
                    = ( current_squark_mass - last_squark_mass );

                  }

                // debugging:
                /**std::cout
                << std::endl
                << "scolored_mass_step_size = " << scolored_mass_step_size;**/

                // now we need to work out the neutralino mass ratios to the
                // lighter colored sparticle:
                double lowest_neutralino_mass = lowest_squark_mass;
                double middle_neutralino_mass = lowest_squark_mass;
                double highest_neutralino_mass = lowest_squark_mass;
                for( std::vector< double >::const_iterator
                     mass_iterator = neutralino_masses.begin();
                     neutralino_masses.end() > mass_iterator;
                     ++mass_iterator )
                  {

                    if( *mass_iterator < lowest_neutralino_mass )
                      {

                        highest_neutralino_mass = middle_neutralino_mass;
                        middle_neutralino_mass = lowest_neutralino_mass;
                        lowest_neutralino_mass = *mass_iterator;

                      }

                    if( ( *mass_iterator < middle_neutralino_mass )
                        &&
                        ( *mass_iterator > lowest_neutralino_mass ) )
                      {

                        highest_neutralino_mass = middle_neutralino_mass;
                        middle_neutralino_mass = *mass_iterator;

                      }

                    if( ( *mass_iterator < highest_neutralino_mass )
                        &&
                        ( *mass_iterator > middle_neutralino_mass ) )
                      {

                        highest_neutralino_mass = *mass_iterator;

                      }

                    double lighter_scolored_mass = last_squark_mass;
                    if( last_gluino_mass < last_squark_mass )
                      {

                        lighter_scolored_mass = last_gluino_mass;

                      }
                    low_neutralino_mass_ratio
                    = ( lowest_neutralino_mass / lighter_scolored_mass );
                    middle_neutralino_mass_ratio
                    = ( middle_neutralino_mass / lighter_scolored_mass );
                    high_neutralino_mass_ratio
                    = ( highest_neutralino_mass / lighter_scolored_mass );

                  }
                grid_size_still_unknown = false;

              }

          }  // end of while loop going over the lines of the file.

        // we still have to add the last vectors:
        acceptance_columns = current_acceptance_vector->size();
        current_gluino_vector->push_back( current_neutralino_vector );
        values.push_back( current_gluino_vector );

        // debugging:
        /**std::cout
        << std::endl
        << "pushed back last current_neutralino_vector of size "
        << current_neutralino_vector->size()
        << " & last current_gluino_vector of size "
        << current_gluino_vector->size();
        std::cout << std::endl;**/

        // the last masses should be the maximal values:
        highest_squark_mass = current_squark_mass;
        highest_gluino_mass = current_gluino_mass;

      }
    else
      // otherwise, a NULL pointer was given instead of a pointer to the
      // grid file name string.
      {

        std::cout
        << std::endl
        << "LHC-FASER::error! asked to open a file with a NULL pointer!";
        std::cout << std::endl;

      }

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: acceptance_grid::read_in() finished: "
    << std::endl << "lowest_squark_mass = " << lowest_squark_mass
    << std::endl << "highest_squark_mass = " << highest_squark_mass
    << std::endl << "lowest_gluino_mass = " << lowest_gluino_mass
    << std::endl << "highest_gluino_mass = " << highest_gluino_mass
    << std::endl << "low_neutralino_mass_ratio = " << low_neutralino_mass_ratio
    << std::endl << "middle_neutralino_mass_ratio = "
    << middle_neutralino_mass_ratio
    << std::endl << "high_neutralino_mass_ratio = "
    << high_neutralino_mass_ratio
    << std::endl << "value at ( " << lowest_squark_mass << ", "
    << lowest_gluino_mass << ", "
    << ( low_neutralino_mass_ratio * lowest_squark_mass ) << ", "
    << ( high_neutralino_mass_ratio * lowest_squark_mass ) << ", 0 ) is "
    << value_at( lowest_squark_mass,
                 lowest_gluino_mass,
                 ( low_neutralino_mass_ratio * lowest_squark_mass ),
                 ( high_neutralino_mass_ratio * lowest_squark_mass ),
                 0 )
    << std::endl << "value at ( "
    << ( 0.5 * ( lowest_squark_mass + highest_squark_mass ) + 0.2 ) << ", "
    << ( 0.5 * ( lowest_gluino_mass + highest_gluino_mass ) + 0.3 ) << ", "
    << ( ( low_neutralino_mass_ratio + 0.1 )
         * ( 0.5 * ( lowest_squark_mass + highest_squark_mass ) + 0.2 ) )
    << ", "
    << ( ( middle_neutralino_mass_ratio + 0.1 )
        * ( 0.5 * ( lowest_squark_mass + highest_squark_mass ) + 0.2 ) )
    << ", 0 ) is "
    << value_at( ( 0.5 * ( lowest_squark_mass + highest_squark_mass ) + 0.2 ),
                 ( 0.5 * ( lowest_gluino_mass + highest_gluino_mass ) + 0.3 ),
                 ( ( low_neutralino_mass_ratio + 0.1 )
                   * ( 0.5 * ( lowest_squark_mass + highest_squark_mass )
                       + 0.2 ) ),
                 ( ( middle_neutralino_mass_ratio + 0.1 )
                   * ( 0.5 * ( lowest_squark_mass + highest_squark_mass )
                       + 0.2 ) ),
                 0 )
    << std::endl << "printing out to test.dat";
    std::cout << std::endl;
    std::ofstream test_output;
    test_output.open( "test.dat" );
    double output_squark_mass;
    double output_gluino_mass;
    double output_lighter_scolored_mass;
    for( int squark_counter = 0;
         values.size() > squark_counter;
         ++squark_counter )
      {

        output_squark_mass
        = ( lowest_squark_mass
            + ( scolored_mass_step_size * squark_counter ) );

        for( int gluino_counter = 0;
            values.at( squark_counter )->size() > gluino_counter;
            ++gluino_counter )
          {

            output_gluino_mass
            = ( lowest_gluino_mass
                + ( scolored_mass_step_size * gluino_counter ) );

            if( output_gluino_mass < output_squark_mass )
              {

                output_lighter_scolored_mass = output_gluino_mass;

              }
            else
              {

                output_lighter_scolored_mass = output_squark_mass;

              }

            for( int neutralino_counter = 0;
                 6 > neutralino_counter;
                 ++neutralino_counter )
              {

                test_output
                << " " << output_squark_mass
                << " " << output_gluino_mass;
                if( 0 == neutralino_counter )
                  {

                    test_output
                    << " " << ( low_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( high_neutralino_mass_ratio
                                * output_lighter_scolored_mass );

                  }
                else if( 1 == neutralino_counter )
                  {

                    test_output
                    << " " << ( low_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( middle_neutralino_mass_ratio
                                * output_lighter_scolored_mass );

                  }
                else if( 2 == neutralino_counter )
                  {

                    test_output
                    << " " << ( low_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( low_neutralino_mass_ratio
                                * output_lighter_scolored_mass );
                  }
                else if( 3 == neutralino_counter )
                  {

                    test_output
                    << " " << ( middle_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( high_neutralino_mass_ratio
                                * output_lighter_scolored_mass );

                  }
                else if( 4 == neutralino_counter )
                  {

                    test_output
                    << " " << ( middle_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( middle_neutralino_mass_ratio
                                * output_lighter_scolored_mass );

                  }
                else if( 5 == neutralino_counter )
                  {

                    test_output
                    << " " << ( high_neutralino_mass_ratio
                                * output_lighter_scolored_mass )
                    << " " << ( high_neutralino_mass_ratio
                                * output_lighter_scolored_mass );

                  }

                for( std::vector< double >::const_iterator
                     acceptance_iterator
                     = values.at( squark_counter )->at( gluino_counter
                                        )->at( neutralino_counter )->begin();
                    values.at( squark_counter )->at( gluino_counter
                                             )->at( neutralino_counter )->end()
                    > acceptance_iterator;
                    ++acceptance_iterator )
                  {

                    test_output << " " << *acceptance_iterator;

                  }

                test_output << std::endl;

              }

          }

      }
    test_output.close();**/

  }

  acceptance_grid::~acceptance_grid()
  {

    // delete all the vectors held as pointers by the vector of vectors of
    // vectors:
    for( std::vector< std::vector< std::vector< std::vector< double
                                                           >* >* >* >::iterator
         gluino_vector_iterator = values.begin();
         values.end() > gluino_vector_iterator;
         ++gluino_vector_iterator )
      {

        for( std::vector< std::vector< std::vector< double >* >* >::iterator
               neutralino_vector_iterator = (*gluino_vector_iterator)->begin();
             (*gluino_vector_iterator)->end() > neutralino_vector_iterator;
             ++neutralino_vector_iterator )
          {

            for( std::vector< std::vector< double >* >::iterator
                   deletion_iterator = (*neutralino_vector_iterator)->begin();
                 (*neutralino_vector_iterator)->end() > deletion_iterator;
                 ++deletion_iterator )
              {

                delete *deletion_iterator;

              }

            delete *neutralino_vector_iterator;

          }

        delete *gluino_vector_iterator;

      }

  }


  double
  acceptance_grid::value_at( double const squark_mass,
                             double const gluino_mass,
                             double const first_neutralino_mass,
                             double const second_neutralino_mass,
                             int const acceptance_element,
                    bool const heavy_neutralino_edge_is_lighter_scolored_mass )
  const
  /* this finds the grid square which the given point is in, & then uses
   * LHC_FASER_global::square_bilinear_interpolation to get an interpolated
   * value, assuming that the heavy neutralino edge goes to 0.0 as the
   * heavier neutralino mass approaches the lighter scolored mass unless
   * heavy_neutralino_edge_is_lighter_scolored_mass is true, in which case
   * it interpolates to the lighter scolored mass.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: acceptance_grid::value_at( " << squark_mass
    << ", " << gluino_mass << ", " << first_neutralino_mass << ", "
    << second_neutralino_mass << ", " << acceptance_element << ", "
    << heavy_neutralino_edge_is_lighter_scolored_mass
    << " ) called.";
    std::cout << std::endl;**/

    if( ( acceptance_element < acceptance_columns )
        &&
        ( 0.0 < scolored_mass_step_size )
        &&
        ( squark_mass >= lowest_squark_mass )
        &&
        ( gluino_mass >= lowest_gluino_mass ) )
      {

        // 1st we find out which are the lighter sparticles:
        double lighter_scolored = squark_mass;
        if( gluino_mass < squark_mass )
          {

            lighter_scolored = gluino_mass;

          }
        double lighter_neutralino = first_neutralino_mass;
        double heavier_neutralino = second_neutralino_mass;
        if( second_neutralino_mass < first_neutralino_mass )
          {

            lighter_neutralino = second_neutralino_mass;
            heavier_neutralino = first_neutralino_mass;

          }
        lighter_neutralino *= ( 1.0 / lighter_scolored );
        heavier_neutralino *= ( 1.0 / lighter_scolored );
        // now lighter_neutralino & heavier_neutralino are mass ratios.

        // debugging:
        /**std::cout
        << std::endl
        << "lighter_scolored = " << lighter_scolored
        << std::endl
        << "lighter_neutralino = " << lighter_neutralino
        << std::endl
        << "heavier_neutralino = " << heavier_neutralino
        << std::endl
        << "low_neutralino_mass_ratio = " << low_neutralino_mass_ratio
        << std::endl
        << "middle_neutralino_mass_ratio = " << middle_neutralino_mass_ratio
        << std::endl
        << "high_neutralino_mass_ratio = " << high_neutralino_mass_ratio;
        std::cout << std::endl;**/

        if( ( 1.0 > lighter_neutralino )
            &&
            ( 1.0 > heavier_neutralino ) )
          {

            /* now we work out which elements of the values vector of vectors
             * of vectors to use.
             * N.B.! this bit is HIGHLY format-dependent, since the values are
             * read in in the order:
             * 1: light - heavy
             * 2: light - medium
             * 3: light - light
             * 4: medium - heavy
             * 5: medium - medium
             * 6: heavy - heavy
             * though these are stored in the vector as elements
             * 0, 1, 2, 3, 4, & 5, which is why the comments below seem to not
             * match the code.
             */
            if( low_neutralino_mass_ratio > lighter_neutralino )
              {

                if( low_neutralino_mass_ratio > heavier_neutralino )
                  {

                    return vector_element_at( squark_mass,
                                              gluino_mass,
                                              2,
                                              acceptance_element );

                    /*lower_left_point = 3;
                    lower_right_point = 3;
                    upper_right_point = 3;
                    upper_left_point = 3;*/

                  }
                else if( middle_neutralino_mass_ratio > heavier_neutralino )
                  {

                    return LHC_FASER_global::unit_linear_interpolation(
                                                         ( ( heavier_neutralino
                                                  - low_neutralino_mass_ratio )
                                               / ( middle_neutralino_mass_ratio
                                               - low_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   2,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   1,
                                                        acceptance_element ) );

                    /*lower_left_point = 3;
                    lower_right_point = 3;
                    upper_right_point = 2;
                    upper_left_point = 2;*/

                  }
                else if( high_neutralino_mass_ratio > heavier_neutralino )
                  {

                    return LHC_FASER_global::unit_linear_interpolation(
                                                         ( ( heavier_neutralino
                                               - middle_neutralino_mass_ratio )
                                                 / ( high_neutralino_mass_ratio
                                            - middle_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   1,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   0,
                                                        acceptance_element ) );

                    /*lower_left_point = 2;
                    lower_right_point = 2;
                    upper_right_point = 1;
                    upper_left_point = 1;*/

                  }
                else
                  {

                    double heavy_edge_value = 0.0;

                    if( heavy_neutralino_edge_is_lighter_scolored_mass )
                      {

                        if( gluino_mass < squark_mass )
                          {

                            heavy_edge_value = gluino_mass;

                          }
                        else
                          {

                            heavy_edge_value = squark_mass;

                          }

                      }

                    return LHC_FASER_global::unit_linear_interpolation(
                                                         ( ( heavier_neutralino
                                                 - high_neutralino_mass_ratio )
                                                                        / ( 1.0
                                              - high_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   1,
                                                          acceptance_element ),
                                                            heavy_edge_value );

                    /*lower_left_point = 1;
                    lower_right_point = 1;
                    upper_right_point = 0;
                    upper_left_point = 0;*/

                  }

              }
            else if( middle_neutralino_mass_ratio > lighter_neutralino )
              {

                if( middle_neutralino_mass_ratio > heavier_neutralino )
                  {

                    double lower_left_value = vector_element_at( squark_mass,
                                                                 gluino_mass,
                                                                 2,
                                                          acceptance_element );
                    double upper_right_value = vector_element_at( squark_mass,
                                                                  gluino_mass,
                                                                  4,
                                                          acceptance_element );
                    double upper_left_value = vector_element_at( squark_mass,
                                                                 gluino_mass,
                                                                 1,
                                                          acceptance_element );
                    double lower_right_value = ( lower_left_value
                                                 + upper_right_value
                                                 - upper_left_value );

                    return LHC_FASER_global::square_bilinear_interpolation(
                                                         ( ( lighter_neutralino
                                                  - low_neutralino_mass_ratio )
                                               / ( middle_neutralino_mass_ratio
                                               - low_neutralino_mass_ratio ) ),
                                                         ( ( heavier_neutralino
                                                  - low_neutralino_mass_ratio )
                                               / ( middle_neutralino_mass_ratio
                                               - low_neutralino_mass_ratio ) ),
                                                              lower_left_value,
                                                             lower_right_value,
                                                             upper_right_value,
                                                            upper_left_value );

                    /*lower_left_point = 3;
                    lower_right_point = -2;
                    upper_right_point = 5;
                    upper_left_point = 2;*/

                  }
                else if( high_neutralino_mass_ratio > heavier_neutralino )
                  {

                    return LHC_FASER_global::square_bilinear_interpolation(
                                                         ( ( lighter_neutralino
                                                  - low_neutralino_mass_ratio )
                                               / ( middle_neutralino_mass_ratio
                                               - low_neutralino_mass_ratio ) ),
                                                         ( ( heavier_neutralino
                                               - middle_neutralino_mass_ratio )
                                                 / ( high_neutralino_mass_ratio
                                            - middle_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   1,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   4,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   3,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   0,
                                                        acceptance_element ) );

                    /*lower_left_point = 2;
                    lower_right_point = 5;
                    upper_right_point = 4;
                    upper_left_point = 1;*/

                  }
                else
                  {

                    double heavy_edge_value = 0.0;

                    if( heavy_neutralino_edge_is_lighter_scolored_mass )
                      {

                        if( gluino_mass < squark_mass )
                          {

                            heavy_edge_value = gluino_mass;

                          }
                        else
                          {

                            heavy_edge_value = squark_mass;

                          }

                      }

                    return LHC_FASER_global::square_bilinear_interpolation(
                                                         ( ( lighter_neutralino
                                                  - low_neutralino_mass_ratio )
                                               / ( middle_neutralino_mass_ratio
                                               - low_neutralino_mass_ratio ) ),
                                                         ( ( heavier_neutralino
                                                 - high_neutralino_mass_ratio )
                                                                        / ( 1.0
                                              - high_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   0,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   3,
                                                          acceptance_element ),
                                                              heavy_edge_value,
                                                            heavy_edge_value );

                    /*lower_left_point = 1;
                    lower_right_point = 4;
                    upper_right_point = 0;
                    upper_left_point = 0;*/

                  }

              }
            else if( high_neutralino_mass_ratio > lighter_neutralino )
              {

                if( high_neutralino_mass_ratio > heavier_neutralino )
                  {

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "so, high_neutralino_mass_ratio > both > middle"
                    << std::endl;
                    std::cout << std::endl;**/

                    double lower_left_value = vector_element_at( squark_mass,
                                                                 gluino_mass,
                                                                 4,
                                                         acceptance_element );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "lower_left_value = " << lower_left_value;
                    std::cout << std::endl;**/

                    double upper_right_value = vector_element_at( squark_mass,
                                                                  gluino_mass,
                                                                  5,
                                                          acceptance_element );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "upper_right_value = " << upper_right_value;
                    std::cout << std::endl;**/

                    double upper_left_value = vector_element_at( squark_mass,
                                                                 gluino_mass,
                                                                 3,
                                                          acceptance_element );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "upper_left_value = " << upper_left_value;
                    std::cout << std::endl;**/

                    double lower_right_value = ( lower_left_value
                                                 + upper_right_value
                                                 - upper_left_value );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "lower_right_value = " << lower_right_value;
                    std::cout << std::endl;**/

                    return LHC_FASER_global::square_bilinear_interpolation(
                                                         ( ( lighter_neutralino
                                               - middle_neutralino_mass_ratio )
                                                 / ( high_neutralino_mass_ratio
                                            - middle_neutralino_mass_ratio ) ),
                                                         ( ( heavier_neutralino
                                               - middle_neutralino_mass_ratio )
                                                 / ( high_neutralino_mass_ratio
                                            - middle_neutralino_mass_ratio ) ),
                                                              lower_left_value,
                                                             lower_right_value,
                                                             upper_right_value,
                                                            upper_left_value );

                    /*lower_left_point = 5;
                    lower_right_point = -4;
                    upper_right_point = 6;
                    upper_left_point = 4;*/

                  }
                else
                  {

                    double heavy_edge_value = 0.0;

                    if( heavy_neutralino_edge_is_lighter_scolored_mass )
                      {

                        if( gluino_mass < squark_mass )
                          {

                            heavy_edge_value = gluino_mass;

                          }
                        else
                          {

                            heavy_edge_value = squark_mass;

                          }

                      }

                    return LHC_FASER_global::square_bilinear_interpolation(
                                                         ( ( lighter_neutralino
                                               - middle_neutralino_mass_ratio )
                                                 / ( high_neutralino_mass_ratio
                                            - middle_neutralino_mass_ratio ) ),
                                                         ( ( heavier_neutralino
                                                 - high_neutralino_mass_ratio )
                                                                        / ( 1.0
                                              - high_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   3,
                                                          acceptance_element ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   5,
                                                          acceptance_element ),
                                                              heavy_edge_value,
                                                            heavy_edge_value );

                    /*lower_left_point = 4;
                    lower_right_point = 6;
                    upper_right_point = 0;
                    upper_left_point = 0;*/

                  }

              }
            else
              {

                double heavy_edge_value = 0.0;

                if( heavy_neutralino_edge_is_lighter_scolored_mass )
                  {

                    if( gluino_mass < squark_mass )
                      {

                        heavy_edge_value = gluino_mass;

                      }
                    else
                      {

                        heavy_edge_value = squark_mass;

                      }

                  }

                return LHC_FASER_global::unit_linear_interpolation(
                                                         ( ( lighter_neutralino
                                                 - high_neutralino_mass_ratio )
                                                                    / ( 1.0
                                              - high_neutralino_mass_ratio ) ),
                                                vector_element_at( squark_mass,
                                                                   gluino_mass,
                                                                   5,
                                                          acceptance_element ),
                                                            heavy_edge_value );

                /*lower_left_point = 6;
                lower_right_point = 6;
                upper_right_point = 0;
                upper_left_point = 0;*/


              }  // at this point, the points have been assigned.

          }
        else
          {

            return CppSLHA::CppSLHA_global::really_wrong_value;

          }

      }
    else
      {

        return CppSLHA::CppSLHA_global::really_wrong_value;

      }

  }


  double
  acceptance_grid::vector_element_at( double const squark_mass,
                                      double const gluino_mass,
                                      int const neutralino_element,
                                      int const acceptance_element )
  const
  /* this takes the values for the element of the acceptance vector in the
   * specified element of the vector for neutralino masses requested for the
   * nearest points based on squark & gluino masses & interpolates to the given
   * masses.
   */
  {

    if( ( 0.0 < scolored_mass_step_size )
        &&
        ( squark_mass >= lowest_squark_mass )
        &&
        ( gluino_mass >= lowest_gluino_mass ) )
      {

        double
        x_steps
        = ( ( squark_mass - lowest_squark_mass ) / scolored_mass_step_size );
        int lower_left_x = (int)x_steps;

        if( values.size() > ( lower_left_x + 1 ) )
          // if the x co-ordinate is less than its maximal grid value...
          {

            double
            y_steps
            = ( ( gluino_mass - lowest_gluino_mass )
                / scolored_mass_step_size );
            int lower_left_y = (int)y_steps;

            if( values.at( lower_left_x )->size() > ( lower_left_y + 1 ) )
              // if the y co-ordinate is less than its maximal grid value...
              {

                return LHC_FASER_global::square_bilinear_interpolation(
                                                    ( x_steps - lower_left_x ),
                                                    ( y_steps - lower_left_y ),
                                    values.at( lower_left_x )->at( lower_left_y
                                                      )->at( neutralino_element
                                                   )->at( acceptance_element ),
                            values.at( ( lower_left_x + 1 ) )->at( lower_left_y
                                                      )->at( neutralino_element
                                                   )->at( acceptance_element ),
                    values.at( ( lower_left_x + 1 ) )->at( ( lower_left_y + 1 )
                                                      )->at( neutralino_element
                                                   )->at( acceptance_element ),
                            values.at( lower_left_x )->at( ( lower_left_y + 1 )
                                                      )->at( neutralino_element
                                                 )->at( acceptance_element ) );

              }
            else if( ( values.at( lower_left_x )->size()
                       == ( lower_left_y + 1 ) )
                     &&
                     ( (double)lower_left_y == y_steps ) )
              // otherwise, if it's on the maximal y edge...
              {

                return LHC_FASER_global::unit_linear_interpolation(
                                                    ( x_steps - lower_left_x ),
                                    values.at( lower_left_x )->at( lower_left_y
                                                      )->at( neutralino_element
                                                   )->at( acceptance_element ),
                            values.at( ( lower_left_x + 1 ) )->at( lower_left_y
                                                      )->at( neutralino_element
                                                 )->at( acceptance_element ) );

              }
            else
              // otherwise, it's off the grid:
              {

                return CppSLHA::CppSLHA_global::really_wrong_value;

              }

          }
        else if( ( values.size() == ( lower_left_x + 1 ) )
                 &&
                 ( (double)lower_left_x == x_steps ) )
          // otherwise, if it's on the maximal x edge...
          {

            double
            y_steps
            = ( ( gluino_mass - lowest_gluino_mass )
                / scolored_mass_step_size );
            int lower_left_y = (int)y_steps;

            if( values.at( lower_left_x )->size() > ( lower_left_y + 1 ) )
              // if the y co-ordinate is less than its maximal grid value...
              {

                return LHC_FASER_global::unit_linear_interpolation(
                                                    ( y_steps - lower_left_y ),
                                    values.at( lower_left_x )->at( lower_left_y
                                                      )->at( neutralino_element
                                                   )->at( acceptance_element ),
                            values.at( lower_left_x )->at( ( lower_left_y + 1 )
                                                      )->at( neutralino_element
                                                 )->at( acceptance_element ) );

              }
            else if( ( values.at( lower_left_x )->size()
                       == ( lower_left_y + 1 ) )
                     &&
                     ( (double)lower_left_y == y_steps ) )
              // otherwise, if it's on the maximal x & y corner...
              {

                return values.at( lower_left_x )->at( lower_left_y
                         )->at( neutralino_element )->at( acceptance_element );

              }
            else
              // otherwise, it's off the grid:
              {

                return CppSLHA::CppSLHA_global::really_wrong_value;

              }

          }
        else
          // otherwise, it's off the grid:
          {

            return CppSLHA::CppSLHA_global::really_wrong_value;

          }

      }
    else
      // otherwise, it's off the grid (or the grid step size was not positive,
      // which is still a problem...):
      {

        return CppSLHA::CppSLHA_global::really_wrong_value;

      }

  }



  acceptance_set::acceptance_set( std::string const* const grid_file_location,
                                 input_handler const* const given_shortcuts ) :
    shortcut( given_shortcuts )
  {

    std::string grid_file_name( *grid_file_location );
    grid_file_name.append( "/gluino+gluino_acceptance.dat");
    gluino_gluino_table = new acceptance_grid( &grid_file_name );
    grid_file_name.assign( *grid_file_location );
    grid_file_name.append( "/squark+gluino_acceptance.dat");
    squark_gluino_table = new acceptance_grid( &grid_file_name );
    grid_file_name.assign( *grid_file_location );
    grid_file_name.append( "/squark+antisquark_acceptance.dat");
    squark_antisquark_table = new acceptance_grid( &grid_file_name );
    grid_file_name.assign( *grid_file_location );
    grid_file_name.append( "/squark+squark_acceptance.dat");
    squark_squark_table = new acceptance_grid( &grid_file_name );

  }

  acceptance_set::~acceptance_set()
  {

    delete gluino_gluino_table;
    delete squark_gluino_table;
    delete squark_antisquark_table;
    delete squark_squark_table;

  }


  double
  acceptance_set::get_value(
                          signed_particle_shortcut_pair const* const scoloreds,
                             colored_cascade const* const first_sQCD_cascade,
                             colored_cascade const* const second_sQCD_cascade,
                             int const requested_column,
                    bool const heavy_neutralino_edge_is_lighter_scolored_mass )
  const
  /* this interpolates the requested column based on the squark, gluino, &
   * electroweakino masses. it fudges some cases that were not properly done in
   * the single-quark-flavor approximation.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "acceptance_set::get_value(...) called.";
    std::cout << std::endl;**/

    double appropriate_gluino_mass
    = shortcut->get_gluino()->get_absolute_mass();
    double appropriate_squark_mass;

    // gluino+gluino combinations:
    if( first_sQCD_cascade->is_gx()
        &&
        second_sQCD_cascade->is_gx() )
      {

        appropriate_squark_mass = shortcut->get_average_squarks4_mass();
        if( appropriate_gluino_mass > appropriate_squark_mass )
          {

            appropriate_squark_mass
            = ( appropriate_gluino_mass + ( 0.5 * appropriate_squark_mass ) );

          }

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gsx()
             &&
             second_sQCD_cascade->is_gx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_product()->get_absolute_mass();

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gx()
             &&
             second_sQCD_cascade->is_gsx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_product()->get_absolute_mass();

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gsx()
             &&
             second_sQCD_cascade->is_gsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );

        // debugging:
        /**std::cout
        << std::endl
        << "is gsx-gsx; appropriate_squark_mass = " << appropriate_squark_mass;
        std::cout << std::endl;**/

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    // squark+gluino combinations:
    else if( first_sQCD_cascade->is_sx()
             &&
             second_sQCD_cascade->is_gx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gx()
             &&
             second_sQCD_cascade->is_sx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sx()
             &&
             second_sQCD_cascade->is_gsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_decayer()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );
        if( appropriate_squark_mass > appropriate_gluino_mass )
          {

            appropriate_gluino_mass
            = ( appropriate_squark_mass + ( 0.5 * appropriate_gluino_mass ) );

          }

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gsx()
             &&
             second_sQCD_cascade->is_sx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_decayer()->get_absolute_mass() ) );
        if( appropriate_squark_mass > appropriate_gluino_mass )
          {

            appropriate_gluino_mass
            = ( appropriate_squark_mass + ( 0.5 * appropriate_gluino_mass ) );

          }

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgx()
             &&
             second_sQCD_cascade->is_gx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gx()
             &&
             second_sQCD_cascade->is_sgx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgx()
             &&
             second_sQCD_cascade->is_gsx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gsx()
             &&
             second_sQCD_cascade->is_sgx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgsx()
             &&
             second_sQCD_cascade->is_gx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gx()
             &&
             second_sQCD_cascade->is_sgsx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgsx()
             &&
             second_sQCD_cascade->is_gsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_gsx()
             &&
             second_sQCD_cascade->is_sgsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    // squark+squark combinations:
    else if( first_sQCD_cascade->is_sx()
             &&
             second_sQCD_cascade->is_sx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_decayer()->get_absolute_mass()
                 + second_sQCD_cascade->get_decayer()->get_absolute_mass() ) );
        if( appropriate_squark_mass > appropriate_gluino_mass )
          {

            appropriate_gluino_mass
            = ( appropriate_squark_mass + ( 0.5 * appropriate_gluino_mass ) );

          }

        if( scoloreds->first_is_not_antiparticle()
            &&
            scoloreds->second_is_not_antiparticle() )
          {

            return squark_squark_table->value_at( appropriate_squark_mass,
                                                  appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                  requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else if( ( scoloreds->first_is_not_antiparticle()
                   &&
                   !(scoloreds->second_is_not_antiparticle()) )
                 ||
                 ( !(scoloreds->first_is_not_antiparticle())
                   &&
                   scoloreds->second_is_not_antiparticle() ) )
          {

            return squark_antisquark_table->value_at( appropriate_squark_mass,
                                                      appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                      requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else
          {

            return 0.0;

          }

      }
    else if( first_sQCD_cascade->is_sgx()
             &&
             second_sQCD_cascade->is_sx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgsx()
             &&
             second_sQCD_cascade->is_sx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_decayer()->get_absolute_mass() ) );
        if( appropriate_squark_mass > appropriate_gluino_mass )
          {

            appropriate_gluino_mass
            = ( appropriate_squark_mass + ( 0.5 * appropriate_gluino_mass ) );

          }

        if( scoloreds->second_is_not_antiparticle() )
          {

            return squark_squark_table->value_at( appropriate_squark_mass,
                                                  appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                  requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else
          {

            return squark_antisquark_table->value_at( appropriate_squark_mass,
                                                      appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                      requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );


          }

      }
    else if( first_sQCD_cascade->is_sx()
             &&
             second_sQCD_cascade->is_sgx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_decayer()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgx()
             &&
             second_sQCD_cascade->is_sgx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_decayer()->get_absolute_mass()
                 + second_sQCD_cascade->get_decayer()->get_absolute_mass() ) );

        if( scoloreds->first_is_not_antiparticle()
            &&
            scoloreds->second_is_not_antiparticle() )
          {

            return squark_squark_table->value_at( appropriate_squark_mass,
                                                  appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                  requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else if( ( scoloreds->first_is_not_antiparticle()
                   &&
                   !(scoloreds->second_is_not_antiparticle()) )
                 ||
                 ( !(scoloreds->first_is_not_antiparticle())
                   &&
                   scoloreds->second_is_not_antiparticle() ) )
          {

            return squark_antisquark_table->value_at( appropriate_squark_mass,
                                                      appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                      requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else
          {

            return 0.0;

          }

      }
    else if( first_sQCD_cascade->is_sgsx()
             &&
             second_sQCD_cascade->is_sgx() )
      {

        appropriate_squark_mass
        = first_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sx()
             &&
             second_sQCD_cascade->is_sgsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_decayer()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );

        if( scoloreds->first_is_not_antiparticle()
            &&
            scoloreds->second_is_not_antiparticle() )
          {

            return squark_squark_table->value_at( appropriate_squark_mass,
                                                  appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                  requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else if( ( scoloreds->first_is_not_antiparticle()
                   &&
                   !(scoloreds->second_is_not_antiparticle()) )
                 ||
                 ( !(scoloreds->first_is_not_antiparticle())
                   &&
                   scoloreds->second_is_not_antiparticle() ) )
          {

            return squark_antisquark_table->value_at( appropriate_squark_mass,
                                                      appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                                      requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

          }
        else
          {

            return 0.0;

          }

      }
    else if( first_sQCD_cascade->is_sgx()
             &&
             second_sQCD_cascade->is_sgsx() )
      {

        appropriate_squark_mass
        = second_sQCD_cascade->get_product()->get_absolute_mass();

        return squark_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else if( first_sQCD_cascade->is_sgsx()
             &&
             second_sQCD_cascade->is_sgsx() )
      {

        appropriate_squark_mass
        = ( 0.5 * ( first_sQCD_cascade->get_product()->get_absolute_mass()
                 + second_sQCD_cascade->get_product()->get_absolute_mass() ) );

        return gluino_gluino_table->value_at( appropriate_squark_mass,
                                              appropriate_gluino_mass,
                          first_sQCD_cascade->get_EWino()->get_absolute_mass(),
                         second_sQCD_cascade->get_EWino()->get_absolute_mass(),
                                              requested_column,
                              heavy_neutralino_edge_is_lighter_scolored_mass );

      }
    else
      {

        return 0.0;

      }

  }



  jet_acceptance_value::jet_acceptance_value(
                                             acceptance_set const* given_table,
                                             int const given_acceptance_column,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                     colored_cascade const* const given_second_sQCD_cascade ) :
    jet_table( given_table ),
    acceptance_column( given_acceptance_column ),
    scolored_pair( given_pair ),
    first_sQCD_cascade( given_first_sQCD_cascade ),
    second_sQCD_cascade( given_second_sQCD_cascade ),
    stored_acceptance( 0.0 ),
    not_already_calculated( true )
  {

    // just an initialization list.

  }

  jet_acceptance_value::~jet_acceptance_value()
  {

    // does nothing.

  }



  lepton_acceptance_value::lepton_acceptance_value(
                                             acceptance_set const* given_table,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                     colored_cascade const* const given_second_sQCD_cascade ) :
    lepton_table( given_table ),
    scolored_pair( given_pair ),
    first_sQCD_cascade( given_first_sQCD_cascade ),
    second_sQCD_cascade( given_second_sQCD_cascade ),
    stored_acceptance(),
    not_already_calculated( true )
  {

    // just an initialization list.

  }

  lepton_acceptance_value::~lepton_acceptance_value()
  {

    // does nothing.

  }


  lepton_acceptance_cut const*
  lepton_acceptance_value::get_acceptance()
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: lepton_acceptance_value::get_acceptance() called."
    << std::endl << "not_already_calculated = " << not_already_calculated;
    std::cout << std::endl;
    int bin_counter = -2;**/

    if( not_already_calculated )
      {

        std::vector< double > acceptance_passer;
        int acceptance_counter = 0;
        double current_acceptance = lepton_table->get_value( scolored_pair,
                                                            first_sQCD_cascade,
                                                           second_sQCD_cascade,
                                                          acceptance_counter,
                                                             true );
        // the 1st element of the vector is the effective squark mass, so
        // should be extrapolated to the lighter scolored mass.

        // debugging:
        /**std::cout
        << std::endl
        << "starting current_acceptance = " << current_acceptance;
        std::cout << std::endl;**/

        while( 0.0 <= current_acceptance )
          {

            // debugging:
            /**std::cout
            << std::endl
            << "debugging: ( 0.0 <= current_acceptance ) is true:"
            << " current_acceptance = " << current_acceptance
            << " for bin energy " << ( 2.0 * ++bin_counter);
            std::cout << std::endl;**/

            acceptance_passer.push_back( current_acceptance );
            ++acceptance_counter;
            current_acceptance = lepton_table->get_value( scolored_pair,
                                                          first_sQCD_cascade,
                                                          second_sQCD_cascade,
                                                          acceptance_counter,
                                                          false );
            // the remaining elements of the vector are acceptances, so should
            // be extrapolated to zero.

            // debugging:
            /**std::cout
            << std::endl
            << "now current_acceptance = " << current_acceptance;
            std::cout << std::endl;**/

          }

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: lepton_acceptance_value::get_acceptance() about to call"
        << " stored_acceptance.set_values( &acceptance_passer )";
        std::cout << std::endl;**/

        stored_acceptance.set_values( &acceptance_passer );

        not_already_calculated = false;

      }

    return &stored_acceptance;

  }



  jet_acceptance_table::jet_acceptance_table(
                                      std::string const* const given_directory,
                                           std::string const* const given_name,
                                 input_handler const* const given_shortcuts ) :
    interface_readied_for_new_point( given_shortcuts->get_readier() ),
    table_name( *given_name ),
    acceptance_grids( given_directory,
                      given_shortcuts )
  {

    // just an initialization list.

  }

  jet_acceptance_table::~jet_acceptance_table()
  {

    for( std::vector< jet_acceptance_value* >::iterator
         deletion_iterator = acceptances.begin();
         acceptances.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

  }


  jet_acceptance_value*
  jet_acceptance_table::get_acceptance( int const given_acceptance_column,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
  {

    if( needs_to_prepare_for_this_point() )
      {

        for( std::vector< jet_acceptance_value* >::iterator
             deletion_iterator = acceptances.begin();
             acceptances.end() > deletion_iterator;
             ++deletion_iterator )
          {

            delete *deletion_iterator;

          }

        acceptances.clear();
        finish_preparing_for_this_point();

      }

    jet_acceptance_value* return_pointer = NULL;

    for( std::vector< jet_acceptance_value* >::iterator
         value_iterator = acceptances.begin();
         acceptances.end() > value_iterator;
         ++value_iterator )
      {

        if( (*value_iterator)->is_requested( given_acceptance_column,
                                             given_pair,
                                             given_first_sQCD_cascade,
                                             given_second_sQCD_cascade ) )
          {

            return_pointer = *value_iterator;
            value_iterator = acceptances.end();

          }

      }

    if( NULL == return_pointer )
      {

        return_pointer = new jet_acceptance_value( &acceptance_grids,
                                                   given_acceptance_column,
                                                   given_pair,
                                                   given_first_sQCD_cascade,
                                                   given_second_sQCD_cascade );

        acceptances.push_back( return_pointer );

      }


    return return_pointer;

  }


  lepton_acceptance_table::lepton_acceptance_table(
                                      std::string const* const given_directory,
                                             int const given_LHC_energy_in_TeV,
                                 input_handler const* const given_shortcuts ) :
    interface_readied_for_new_point( given_shortcuts->get_readier() ),
    LHC_energy_in_TeV( given_LHC_energy_in_TeV ),
    acceptance_grids( given_directory,
                      given_shortcuts )
  {

    // just an initialization list.

  }

  lepton_acceptance_table::~lepton_acceptance_table()
  {

    for( std::vector< lepton_acceptance_value* >::iterator
         deletion_iterator = acceptances.begin();
         acceptances.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

  }


  lepton_acceptance_value*
  lepton_acceptance_table::get_acceptance(
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
  {

    if( needs_to_prepare_for_this_point() )
      {

        for( std::vector< lepton_acceptance_value* >::iterator
             deletion_iterator = acceptances.begin();
             acceptances.end() > deletion_iterator;
             ++deletion_iterator )
          {

            delete *deletion_iterator;

          }

        acceptances.clear();
        finish_preparing_for_this_point();

      }

    lepton_acceptance_value* return_pointer = NULL;

    for( std::vector< lepton_acceptance_value* >::iterator
         value_iterator = acceptances.begin();
         acceptances.end() > value_iterator;
         ++value_iterator )
      {

        if( (*value_iterator)->is_requested( given_pair,
                                             given_first_sQCD_cascade,
                                             given_second_sQCD_cascade ) )
          {

            return_pointer = *value_iterator;
            value_iterator = acceptances.end();

          }

      }

    if( NULL == return_pointer )
      {

        return_pointer = new lepton_acceptance_value( &acceptance_grids,
                                                      given_pair,
                                                      given_first_sQCD_cascade,
                                                   given_second_sQCD_cascade );

        acceptances.push_back( return_pointer );

      }

    return return_pointer;

  }



  kinematics_table::kinematics_table(
                                  jet_acceptance_table* const given_jets_table,
                                      int const given_jet_acceptance_column,
                         lepton_acceptance_table* const given_leptons_table ) :
    jets_table( given_jets_table ),
    jet_acceptance_column( given_jet_acceptance_column ),
    leptons_table( given_leptons_table )
  {

    // just an initialization list.

  }

  kinematics_table::~kinematics_table()
  {

    // does nothing.

  }



  kinematics_table_set::kinematics_table_set(
                                             int const given_LHC_energy_in_TeV,
                                 std::string const* const given_grid_directory,
                               std::string const* const given_jet_subdirectory,
                             lepton_acceptance_table* const given_lepton_table,
                                 input_handler const* const given_shortcuts ) :
    LHC_energy_in_TeV( given_LHC_energy_in_TeV ),
    grid_directory( *given_grid_directory ),
    jet_grid_subdirectory( *given_grid_directory ),
    lepton_table( given_lepton_table ),
    shortcut( given_shortcuts )
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: kinematics_table_set::kinematics_table_set( "
    << given_LHC_energy_in_TeV << ", " << *given_grid_directory
    << ", " << *given_jet_subdirectory << ", " << given_lepton_table << ", "
    << given_shortcuts << ") about to make a new jet_acceptance_table( "
    << energy_name << ", " << *given_grid_directory << ", "
    << given_shortcuts << " )";
    std::cout << std::endl;**/
    jet_grid_subdirectory.append( "/jets/" );
    jet_grid_subdirectory.append( *given_jet_subdirectory );
    jet_table = new jet_acceptance_table( &jet_grid_subdirectory,
                                          given_grid_directory,
                                          given_shortcuts );
    jet_grid_subdirectory.assign( *given_jet_subdirectory );
    // we set jet_grid_subdirectory back to *given_jet_subdirectory for later
    // comparisons.

  }

  kinematics_table_set::~kinematics_table_set()
  {

    for( std::vector< kinematics_table* >::iterator
         deletion_iterator = kinematics_tables.begin();
         kinematics_tables.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

    delete jet_table;

  }


  kinematics_table*
  kinematics_table_set::get_table( int const given_acceptance_column )
  // this returns the kinematics_table for the requested setup.
  {

    kinematics_table* return_pointer = NULL;
    // this starts as NULL so that we know if it wasn't found among the
    // existing instances.

    for( std::vector< kinematics_table* >::iterator
         table_iterator = kinematics_tables.begin();
         kinematics_tables.end() > table_iterator;
         ++table_iterator )
      {

        if( given_acceptance_column == (*table_iterator)->get_column() )
          // if we find the requested column...
          {

            return_pointer = *table_iterator;
            // note the table to return.
            table_iterator = kinematics_tables.end();
            // stop looking.

          }

      }

    if( NULL == return_pointer )
      // if we didn't find an existing match, we make a new instance, store
      // it & return a pointer to it:
      {

        return_pointer = new kinematics_table( jet_table,
                                               given_acceptance_column,
                                               lepton_table );

        kinematics_tables.push_back( return_pointer );

      }

    return return_pointer;

  }



  kinematics_handler::kinematics_handler(
                                 input_handler const* const given_shortcuts ) :
    shortcut( given_shortcuts )
  {

    // just an initialization list

  }

  kinematics_handler::~kinematics_handler()
  {

    for( std::vector< kinematics_table_set* >::iterator
         deletion_iterator = table_sets.begin();
         table_sets.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

    for( std::vector< lepton_acceptance_table* >::iterator
         deletion_iterator = lepton_tables.begin();
         lepton_tables.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

  }


  kinematics_table_set*
  kinematics_handler::get_table_set( int const LHC_energy_in_TeV,
                              std::string const* const given_jet_subdirectory )
  {

    kinematics_table_set* return_pointer = NULL;
    // this starts as NULL so that we know if it wasn't found among the
    // existing instances.

    for( std::vector< kinematics_table_set* >::iterator
         set_iterator = table_sets.begin();
         table_sets.end() > set_iterator;
         ++set_iterator )
      {

        if( (*set_iterator)->is_requested( LHC_energy_in_TeV,
                                           given_jet_subdirectory ) )
          {

            return_pointer = *set_iterator;
            set_iterator = table_sets.end();
            // stop looking.

          }

      }

    if( NULL == return_pointer )
      // if we didn't find an existing match, we make a new instance, store
      // it & return a pointer to it:
      {

        std::string
        energy_name( *(shortcut->inspect_path_to_kinematics_grids()) );
        std::stringstream energy_stream( "" );
        energy_stream << "/" << LHC_energy_in_TeV << "TeV";
        energy_name.append( energy_stream.str() );

        // we have to check to see if the lepton_acceptance_table already
        // exists:
        lepton_acceptance_table* lepton_pointer = NULL;
        for( std::vector< lepton_acceptance_table* >::iterator
             lepton_iterator = lepton_tables.begin();
             lepton_tables.end() > lepton_iterator;
             ++lepton_iterator )
          {

            if( LHC_energy_in_TeV == (*lepton_iterator)->get_energy() )
              {

                lepton_pointer = *lepton_iterator;
                lepton_iterator = lepton_tables.end();

              }

          }
        if( NULL == lepton_pointer )
          {

            std::string lepton_grids( energy_name );
            lepton_grids.append( "/leptons/" );

            lepton_pointer = new lepton_acceptance_table( &lepton_grids,
                                                          LHC_energy_in_TeV,
                                                          shortcut );

            lepton_tables.push_back( lepton_pointer );

          }

        return_pointer = new kinematics_table_set( LHC_energy_in_TeV,
                                                   &energy_name,
                                                   given_jet_subdirectory,
                                                   lepton_pointer,
                                                   shortcut );

        table_sets.push_back( return_pointer );

      }

    return return_pointer;

  }

}  // end of LHC_FASER namespace.

