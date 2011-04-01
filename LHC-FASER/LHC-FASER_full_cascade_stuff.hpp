/*
 * LHC-FASER_full_cascade_stuff.hpp
 *
 *  Created on: 30 Mar 2011
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

#ifndef LHC_FASER_FULL_CASCADE_STUFF_HPP_
#define LHC_FASER_FULL_CASCADE_STUFF_HPP_

#include "LHC-FASER_input_handling_stuff.hpp"
#include "LHC-FASER_sparticle_decay_stuff.hpp"
#include "LHC-FASER_kinematics_stuff.hpp"
#include "LHC-FASER_electroweak_cascade_stuff.hpp"

namespace LHC_FASER
{

  /* this class is for keeping track of a particular cascade decay of a colored
   * sparticle down to the last electroweak decay, such that it keeps track of
   * all the sparticles of a cascade decay. it is an abstract base class.
   */
  class full_cascade : public interface_readied_for_new_point
  {

  public:

    full_cascade(
            CppSLHA::particle_property_set const* const given_initial_scolored,
                  CppSLHA::particle_property_set const* const given_EW_decayer,
                  kinematics_handler* const given_kinematics,
                  input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    virtual
    ~full_cascade()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    CppSLHA::particle_property_set const*
    get_initial_scolored()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    CppSLHA::particle_property_set const*
    get_EW_decayer()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    kinematics_handler::sQCD_cascade_type
    get_cascade_type()
    const
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    get_BR()
    /* this calls update_self() if it needs to, taking care of its
     * interface_readied_for_new_point stuff, & returns the branching ratio
     * down to the electroweak decayer or 0.0, if either it's kinematically
     * disallowed or if the compound BR just gets too small.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    virtual void
    update_self()
    = 0;
    /* this should be overridden by functions which check if the cascade is
     * kinematically allowed, then multiply together the relevant BRs, then, if
     * the BR is not negligibly low, it sets up the lepton-acceptance-relevant
     * calculation stuff.
     */


  protected:

    CppSLHA::particle_property_set const* const initial_scolored;
    CppSLHA::particle_property_set const* const EW_decayer;
    // this can be an electroweakino or an electroweak vector or scalar boson.
    kinematics_handler* const kinematics;
    kinematics_handler::sQCD_cascade_type cascade_type;
    double sQCD_BR;
    input_handler const* const shortcut;

  };  // end of full_cascade class.


  // should put the various derived classes from full_cascade here:
  // gluino_directly_to_EW_cascade
  // squark_directly_to_EW_cascade
  // gluino_to_squark_to_EW_cascade
  // squark_to_gluino_to_EW_cascade
  // squark_to_gluino_to_squark_to_EW_cascade

  // need other stuff:
  // gluino_to_squark_collection
  // squark_to_gluino_collection
  // squark_to_gluino_to_squark_collection
  // further organization of the full_cascade collections
  // full_cascade_handler - holds all the full_cascades, gives out pointers to
  //                        a vector of valid full_cascades which is reset with
  //                        each updated point.


  // this class holds all the full_cascades & gives out pointers to a vector of
  // valid full_cascades which is reset with each updated point.
  class full_cascade_handler : public interface_readied_for_new_point
  {

  public:

    full_cascade_handler()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~full_cascade_handler()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    std::vector< full_cascade* > const*
    get_valid_cascades()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    std::vector< full_cascade* > valid_cascades;

    // collections of the full_cascades also.

    void
    find_all_valid_cascades()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };





  // inline functions:


  inline CppSLHA::particle_property_set const*
  full_cascade::get_initial_scolored()
  const
  {

    return initial_scolored;

  }

  inline CppSLHA::particle_property_set const*
  full_cascade::full_cascade::get_EW_decayer()
  const
  {

    return EW_decayer;

  }


  inline kinematics_handler::sQCD_cascade_type
  full_cascade::get_cascade_type()
  const
  {

    return cascade_type;

  }


  inline double
  full_cascade::get_BR()
  /* this calls update_self() if it needs to, taking care of its
   * interface_readied_for_new_point stuff, & returns the branching ratio
   * down to the electroweak decayer or 0.0, if either it's kinematically
   * disallowed or if the compound BR just gets too small.
   */
  {

    if( needs_to_prepare_for_this_point() )
      {

        update_self();
        finish_preparing_for_this_point();

      }

    return sQCD_BR;

  }

}  // end of LHC_FASER namespace.

#endif /* LHC_FASER_FULL_CASCADE_STUFF_HPP_ */
