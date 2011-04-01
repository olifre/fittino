/*
 * LHC-FASER_kinematics_stuff.hpp
 *
 *  Created on: 15 Dec 2010
 *      Authors: Ben O'Leary (benjamin.oleary@gmail.com)
 *               Jonas Lindert (jonas.lindert@googlemail.com)
 *               Carsten Robens (carsten.robens@gmx.de)
 *      Copyright 2010 Ben O'Leary, Jonas Lindert, Carsten Robens
 *
 *      This file is part of LHC-FASER.
 *
 *      LHC-FASER is free software: you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
 *      the Free Software Foundation, either version 3 of the License, or
 *      (at your option) any later version.
 *
 *      LHC-FASER is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *      GNU General Public License for more details.
 *
 *      You should have received a copy of the GNU General Public License
 *      along with LHC-FASER.  If not, see <http://www.gnu.org/licenses/>.
 *
 *      The GNU General Public License should be in GNU_public_license.txt
 *      the files of LHC-FASER are:
 *      LHC-FASER.hpp
 *      LHC-FASER.cpp
 *      LHC-FASER_electroweak_cascade_stuff.hpp
 *      LHC-FASER_electroweak_cascade_stuff.cpp
 *      LHC-FASER_full_cascade_stuff.hpp
 *      LHC-FASER_full_cascade_stuff.cpp
 *      LHC-FASER_global_stuff.hpp
 *      LHC-FASER_global_stuff.cpp
 *      LHC-FASER_input_handling_stuff.hpp
 *      LHC-FASER_input_handling_stuff.cpp
 *      LHC-FASER_kinematics_stuff.hpp
 *      LHC-FASER_kinematics_stuff.cpp
 *      LHC-FASER_lepton_distributions.hpp
 *      LHC-FASER_lepton_distributions.cpp
 *      LHC-FASER_signal_calculator_stuff.hpp
 *      LHC-FASER_signal_calculator_stuff.cpp
 *      LHC-FASER_signal_data_collection_stuff.hpp
 *      LHC-FASER_signal_data_collection_stuff.cpp
 *      LHC-FASER_sparticle_decay_stuff.hpp
 *      LHC-FASER_sparticle_decay_stuff.cpp
 *      and README.LHC-FASER.txt which describes the package.
 *
 *      LHC-FASER also requires CppSLHA. It should be found in a subdirectory
 *      included with this package.
 *
 *      LHC-FASER also requires grids of lookup values. These should also be
 *      found in a subdirectory included with this package.
 */

#ifndef LHC_FASER_KINEMATICS_STUFF_HPP_
#define LHC_FASER_KINEMATICS_STUFF_HPP_

#include "LHC-FASER_input_handling_stuff.hpp"
#include "LHC-FASER_cross-section_stuff.hpp"


/* this file contains all the code relevant to obtaining the acceptance for
 * jet transverse momentum plus missing transverse momentum and lepton
 * transverse momentum and pseudorapidity cuts.
 *
 * if the format of the grid files changes, a lot of the code here has to
 * change too. the following are format-dependent:
 * - lepton_acceptance_histogram::lepton_acceptance_histogram()
 *   (the default constructor)
 * - all of the acceptance_grid class.
 * - all of the acceptance_set class, in particular
 *   -- acceptance_set::get_value()
 */

namespace LHC_FASER
{

  /* this stores the binned lepton transverse momentum acceptance values &
   * returns interpolated values (given a transverse momentum cut to scale to).
   * it also stores the effective squark mass & the pseudorapidity cut
   * acceptance.
   */
  class lepton_acceptance_cut
  {

  public:

    lepton_acceptance_cut()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    lepton_acceptance_cut( double const given_default_cut,
                           double const given_bin_size )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~lepton_acceptance_cut()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    void
    set_values( std::vector< double >* given_values )
    /* this takes a vector of doubles & stores the 1st value as the effective
     * squark mass, the 2nd as the pseudorapidity cut acceptance, & the rest
     * of the values as the transverse momentum cut bin acceptances.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_effective_squark_mass()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    acceptance_at( double const given_energy,
                   double const given_cut )
    const
    /* this interpolates the values in acceptance_bins to the requested value,
     * or returns pseudorapidity_acceptance if it's lower, scaled to the given
     * value for the transverse momentum cut.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    double const default_transverse_momentum_cut;
    // by default, the transverse momentum cut is 10 GeV.

    double effective_squark_mass;
    std::vector< double > acceptance_bins;
    double const bin_size;
    double pseudorapidity_acceptance;

  };



  /* this class reads in a file in the assumed format, stores it, & gives out
   * interpolated values. it was written with acceptances for leptons in mind,
   * to be adapted for jets plus missing transverse momentum as a special case,
   * with data files in the format
   * squark_mass gluino_mass lighter_neutralino_mass heavier_neutralino_mass
   * (continued) then either
   * 42 lepton acceptance values (effective squark mass, pseudorapitidy cut
   * acceptance, then 40 bins for transverse momentum cut acceptances)
   * or
   * 7 acceptance values for different choices of which jets+MET combination to
   * use
   * then newline.
   */
  class acceptance_grid
  {

  public:

    acceptance_grid( std::string const* const grid_file_location )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~acceptance_grid()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    value_at( double const squark_mass,
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
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    int
    get_number_of_acceptance_columns()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_lowest_squark_mass()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_highest_squark_mass()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_lowest_gluino_mass()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_highest_gluino_mass()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    double scolored_mass_step_size;
    double lowest_squark_mass;
    double highest_squark_mass;
    double lowest_gluino_mass;
    double highest_gluino_mass;
    double low_neutralino_mass_ratio;
    double middle_neutralino_mass_ratio;
    double high_neutralino_mass_ratio;
    std::vector< std::vector< std::vector< std::vector< double >* >* >* >
    values;
    int acceptance_columns;

    double
    vector_element_at( double const squark_mass,
                       double const gluino_mass,
                       int const neutralino_element,
                       int const acceptance_element )
    const
    // this interpolates the values for the element of the vector for
    // neutralino masses requested on the squark & gluino masses.
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };



  /* this class holds acceptance_grid instances for looking up acceptances &
   * returns the interpolated values by looking up the masses of its
   * sparticles. this class, as well as acceptance_grid, has to be changed if
   * the format of the acceptance grids changes.
   */
  class acceptance_set
  {

  public:

    acceptance_set( std::string const* const grid_file_location,
                    input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~acceptance_set()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    get_value( signed_particle_shortcut_pair const* const scoloreds,
               colored_cascade const* const first_sQCD_cascade,
               colored_cascade const* const second_sQCD_cascade,
               int const requested_column,
               bool const heavy_neutralino_edge_is_lighter_scolored_mass )
    const
    /* this interpolates the requested column based on the squark, gluino, &
     * electroweakino masses. it fudges some cases that were not properly done
     * in the single-quark-flavor approximation.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    acceptance_grid* gluino_gluino_table;
    acceptance_grid* squark_gluino_table;
    acceptance_grid* squark_antisquark_table;
    acceptance_grid* squark_squark_table;
    input_handler const* const shortcut;

  };



  // instances of this class are 1-shot objects that ask their acceptance_set
  // to interpolate for their setup & then store the value for reference.
  class jet_acceptance_value
  {

  public:

    jet_acceptance_value( acceptance_set const* given_table,
                          int const given_acceptance_column,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~jet_acceptance_value()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    get_acceptance()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    bool
    is_requested( int const given_acceptance_column,
                  signed_particle_shortcut_pair const* const given_pair,
                  colored_cascade const* const given_first_sQCD_cascade,
                  colored_cascade const* const given_second_sQCD_cascade )
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;



  protected:

    acceptance_set const* jet_table;
    int const acceptance_column;
    signed_particle_shortcut_pair const* const scolored_pair;
    colored_cascade const* const first_sQCD_cascade;
    colored_cascade const* const second_sQCD_cascade;
    double stored_acceptance;
    bool not_already_calculated;

  };


  // instances of this class are 1-shot objects that ask their acceptance_set
  // to interpolate for their setup & then store the value for reference.
  class lepton_acceptance_value
  {

  public:

    lepton_acceptance_value( acceptance_set const* given_table,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~lepton_acceptance_value()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    lepton_acceptance_cut const*
    get_acceptance()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    is_requested( signed_particle_shortcut_pair const* const given_pair,
                  colored_cascade const* const given_first_sQCD_cascade,
                  colored_cascade const* const given_second_sQCD_cascade )
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    acceptance_set const* lepton_table;
    signed_particle_shortcut_pair const* const scolored_pair;
    colored_cascade const* const first_sQCD_cascade;
    colored_cascade const* const second_sQCD_cascade;
    lepton_acceptance_cut stored_acceptance;
    bool not_already_calculated;

  };


  // this class holds an acceptance_set with a string identifying the type of
  // jet signal which the acceptances are for.
  class jet_acceptance_table : public interface_readied_for_new_point
  {

  public:

    jet_acceptance_table( std::string const* const given_directory,
                          std::string const* const given_name,
                          input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~jet_acceptance_table()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    std::string const*
    get_name()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    jet_acceptance_value*
    get_acceptance( int const given_acceptance_column,
                    signed_particle_shortcut_pair const* const given_pair,
                    colored_cascade const* const given_first_sQCD_cascade,
                    colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    std::string table_name;
    acceptance_set acceptance_grids;
    std::vector< jet_acceptance_value* > acceptances;

  };

  // this class holds an acceptance_set with an int identifying the LHC energy
  // which the kinematics are for.
  class lepton_acceptance_table : public interface_readied_for_new_point
  {

  public:

    lepton_acceptance_table( std::string const* const given_directory,
                             int const given_LHC_energy_in_TeV,
                             input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~lepton_acceptance_table()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    int
    get_energy()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    lepton_acceptance_value*
    get_acceptance( signed_particle_shortcut_pair const* const given_pair,
                    colored_cascade const* const given_first_sQCD_cascade,
                    colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    int const LHC_energy_in_TeV;
    acceptance_set acceptance_grids;
    std::vector< lepton_acceptance_value* > acceptances;

  };




  /* this class holds pointers to a jet_acceptance_table & a
   * lepton_acceptance_table for looking up the jets plus missing transverse
   * momentum acceptance with an int for which column to use & the lepton
   * acceptances, & gives out pointers from the jet_acceptance_table & the
   * lepton_acceptance_table to the value-calculating instances they produce
   * (which are all released & re-created with every update for a new point).
   */
  class kinematics_table
  {

  public:

    kinematics_table( jet_acceptance_table* const given_jets_table,
                      int const given_jet_acceptance_column,
                      lepton_acceptance_table* const given_leptons_table )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~kinematics_table()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    int
    get_column()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    jet_acceptance_value*
    get_jet_acceptance( signed_particle_shortcut_pair const* const given_pair,
                        colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    lepton_acceptance_value*
    get_lepton_acceptance(
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    jet_acceptance_table* const jets_table;
    int const jet_acceptance_column;
    lepton_acceptance_table* const leptons_table;

  };

  /* this class holds several kinematics_table instances as lookup tables for
   * various colored sparticle combinations, & returns pointers to them for
   * given kinematics_identifer pointers. it holds the lepton_acceptance_table
   * instances directly, giving pointers to them to its kinematics_table
   * instances.
   */
  class kinematics_table_set
  {

  public:

    kinematics_table_set( int const given_LHC_energy_in_TeV,
                          std::string const* const given_grid_directory,
                          std::string const* const given_jet_subdirectory,
                          lepton_acceptance_table* const given_lepton_table,
                          input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~kinematics_table_set()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    kinematics_table*
    get_table( int const given_acceptance_column )
    // this returns the kinematics_table for the requested column.
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    is_requested( int const given_LHC_energy_in_TeV,
                  std::string const* const given_jet_subdirectory )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    input_handler const* const shortcut;

    int const LHC_energy_in_TeV;
    std::string const grid_directory;
    std::string jet_grid_subdirectory;

    lepton_acceptance_table* lepton_table;
    jet_acceptance_table* jet_table;
    std::vector< kinematics_table* > kinematics_tables;

  };


  // this holds a set of kinematics_table_set instances & returns pointers to
  // them based on the given LHC energy & signal name.
  class kinematics_handler
  {

  public:

    kinematics_handler( input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~kinematics_handler()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    kinematics_table*
    get_table( int const LHC_energy_in_TeV,
               std::string const* const given_jet_subdirectory,
               int const given_acceptance_column )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    lepton_acceptance_table*
    get_lepton_acceptance_table( int const LHC_energy_in_TeV )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    enum sQCD_cascade_type
    {

      sx,
      gx,
      sgx,
      gsx,
      sgsx

    };


  protected:

    input_handler const* const shortcut;

    std::vector< kinematics_table_set* > table_sets;
    std::vector< lepton_acceptance_table* > lepton_tables;

    kinematics_table_set*
    get_table_set( int const LHC_energy_in_TeV,
                   std::string const* const given_jet_subdirectory )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };





  // inline functions:


  inline double
  lepton_acceptance_cut::get_effective_squark_mass()
  const
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: lepton_acceptance_cut::get_effective_squark_mass() called.";
    std::cout << std::endl;**/

    return effective_squark_mass;

  }



  inline int
  acceptance_grid::get_number_of_acceptance_columns()
  const
  {

    return acceptance_columns;

  }

  inline double
  acceptance_grid::get_lowest_squark_mass()
  const
  {

    return lowest_squark_mass;

  }

  inline double
  acceptance_grid::get_highest_squark_mass()
  const
  {

    return  highest_squark_mass;

  }

  inline double
  acceptance_grid::get_lowest_gluino_mass()
  const
  {

    return  lowest_gluino_mass;

  }

  inline double
  acceptance_grid::get_highest_gluino_mass()
  const
  {

    return  highest_gluino_mass;

  }



  inline double
  jet_acceptance_value::get_acceptance()
  {

    if( not_already_calculated )
      {

        stored_acceptance = jet_table->get_value( scolored_pair,
                                                  first_sQCD_cascade,
                                                  second_sQCD_cascade,
                                                  acceptance_column,
                                                  false );
        not_already_calculated = false;

      }

    return stored_acceptance;

  }


  inline bool
  jet_acceptance_value::is_requested( int const given_acceptance_column,
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
  const
  {

    if( ( given_acceptance_column == acceptance_column )
        &&
        ( given_pair == scolored_pair )
        &&
        ( given_first_sQCD_cascade == first_sQCD_cascade )
        &&
        ( given_second_sQCD_cascade == second_sQCD_cascade ) )
      {

        return true;

      }
    else
      {

        return false;

      }

  }



  inline bool
  lepton_acceptance_value::is_requested(
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
  const
  {

    if( ( given_pair == scolored_pair )
        &&
        ( given_first_sQCD_cascade == first_sQCD_cascade )
        &&
        ( given_second_sQCD_cascade == second_sQCD_cascade ) )
      {

        return true;

      }
    else
      {

        return false;

      }

  }



  inline std::string const*
  jet_acceptance_table::get_name()
  const
  {

    return &table_name;

  }



  inline int
  lepton_acceptance_table::get_energy()
  const
  {

    return LHC_energy_in_TeV;

  }



  inline jet_acceptance_value*
  kinematics_table::get_jet_acceptance(
                         signed_particle_shortcut_pair const* const given_pair,
                         colored_cascade const* const given_first_sQCD_cascade,
                       colored_cascade const* const given_second_sQCD_cascade )
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: kinematics_table::get_jet_acceptance(...) called,";
    std::cout << std::endl;**/

    return jets_table->get_acceptance( jet_acceptance_column,
                                       given_pair,
                                       given_first_sQCD_cascade,
                                       given_second_sQCD_cascade );

  }

  inline lepton_acceptance_value*
  kinematics_table::get_lepton_acceptance(
                       signed_particle_shortcut_pair const* const given_pair,
                       colored_cascade const* const given_first_sQCD_cascade,
                     colored_cascade const* const given_second_sQCD_cascade )
  {

    return leptons_table->get_acceptance( given_pair,
                                          given_first_sQCD_cascade,
                                          given_second_sQCD_cascade );

  }


  inline int
  kinematics_table::get_column()
  const
  {

    return jet_acceptance_column;

  }



  inline bool
  kinematics_table_set::is_requested( int const given_LHC_energy_in_TeV,
                              std::string const* const given_jet_subdirectory )
  {

    if( ( given_LHC_energy_in_TeV == LHC_energy_in_TeV )
        &&
        ( 0 == given_jet_subdirectory->compare( jet_grid_subdirectory ) ) )
      {

        return true;

      }
    else
      {

        return false;

      }

  }



  inline kinematics_table*
  kinematics_handler::get_table( int const LHC_energy_in_TeV,
                               std::string const* const given_jet_subdirectory,
                                 int const given_acceptance_column )
  {

    return get_table_set( LHC_energy_in_TeV,
                given_jet_subdirectory )->get_table( given_acceptance_column );

  }

}  // end of LHC_FASER namespace.

#endif /* LHC_FASER_KINEMATICS_STUFF_HPP_ */
