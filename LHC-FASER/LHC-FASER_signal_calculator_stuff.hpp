/*
 * LHC-FASER_signal_calculator_stuff.hpp
 *
 *  Created on: 17 Nov 2010
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

#ifndef LHC_FASER_SIGNAL_CALCULATOR_STUFF_HPP_
#define LHC_FASER_SIGNAL_CALCULATOR_STUFF_HPP_

#include "LHC-FASER_global_stuff.hpp"
#include "LHC-FASER_signal_data_collection_stuff.hpp"


/* NOTES FOR WRITING NEW SIGNALS:
 *
 * I have tried to make it as straightforward as possible to write new signals,
 * but inevitably there is going to have to be some new code written for each
 * new signal. Until I get around to writing a better version of these notes,
 * you'll have to go by the existing signals as examples.
 *
 * Things to remember:
 * - make sure that exclusive_BR_handler::always_neglected_decays doesn't
 *   interfere with the new signal. exclusive_BR_handler returns a NULL pointer
 *   if the decay is in always_neglected_decays.
 * - remember to include antiparticles in jets_to_tag & jets_to_neglect.
 * - fire hot, hot hurt.
 */

namespace LHC_FASER
{

  /* this is an abstract base class to do the actual calculation of the value
   * of the event rate for a signal. the main differences in derived classes
   * are what values they access from the handlers, how they put them
   * together, & how they estimate the uncertainty factor.
   */
  class signal_calculator
  {

  public:

    signal_calculator( signal_shortcuts* const given_shortcuts,
                       cross_section_table_set* const given_cross_sections,
                       kinematics_table* const given_kinematics )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    virtual
    ~signal_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    virtual bool
    calculate( double* signal_value,
               double* uncertainty_factor )
    = 0;
    /* this calculates the event rate for the signal & puts its value in
     * signal_value, & puts an estimate for the uncertainty into
     * uncertainty_factor, & returns true if it did all this successfully.
     *
     *
     * the flow for signal_calculator::calculate() is:
     * sets up a set of channels (once per calculator instance)
     * - each of these channels associates with a cross-section table
     *
     * once per new point, each channel:
     * - checks its cross-section - if it's high enough, it proceeds
     * - obtains the sQCD_to_EWinos for its scoloreds
     * - checks the scew BRs - if they're high enough, it proceeds
     * - obtains its jet acceptance from its kinematics table, checks
     *   cross-section * scew BRs * jet acceptance, if high enough, proceeds
     * - obtains lepton acceptance from kinematics table, passes it with scew
     *   pairs to cascade handler, now has lepton & additional jet acceptances
     * - puts it all together
     * then all the channel totals are added together
     */


  protected:

    signal_shortcuts* const signal_shortcut_pointer;

    input_handler const* const shortcut;

    // each signal needs to look up specific tables, based on the beam energy:
    cross_section_table_set* cross_sections;
    kinematics_table* kinematics;

    // each signal needs to be able to get cascade acceptances:
    cascade_handler* cascades;

    /* I decided to divide each signal into a set of channels, based on the
     * directly-produced sparticles. for each new point, each channel has a
     * number of ways to decay to electroweakinos: the squark which the gluino
     * decays to if it does decay, & the electroweakinos appearing in each
     * cascade decay from the decay of the last colored sparticle in the
     * cascade, for each of the 2 cascades. each channel is thus held as a
     * pairing of a sQCD_to_EWino pointer with a cross_section_table pointer.
     */
    std::vector< std::pair< sQCD_to_EWino*,
                            cross_section_table* >* > channels;

  };  // end of signal_calculator class.


  /* this is a class to handle each individual signal to be calculated.
   * it accesses numbers common to different signals through the
   * cross_section_handler, kinematics_handler & cascade_handler classes.
   * it takes a string encoding what it should calculate, & constructs a
   * signal_calculator object to actually calculate the signal with the
   * given handlers. it also takes care of updating the signal & storing its
   * value & estimated uncertainty.
   */
  class signal_handler : public interface_readied_for_new_point
  {

  public:

    signal_handler( std::string const given_signal_name,
                    signal_shortcuts* const given_shortcuts,
                    double const given_cross_section_unit_factor )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~signal_handler()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    inline std::string const*
    get_name()
    const
    {

     return &signal_name;

    }

    inline double
    get_value()
    {

      // debugging:
      /**std::cout
      << std::endl
      << "debugging: signal_handler::get_value() called."
      << " needs_to_prepare_for_this_point() = "
      << needs_to_prepare_for_this_point();
      std::cout << std::endl;**/

      // if the signal has not been calculated for this point, update
      // signal_value before returning it:
      if( needs_to_prepare_for_this_point() )
        {

          rate_calculator->calculate( &signal_value,
                                      &uncertainty_factor );
          signal_value *= cross_section_unit_factor;
          finish_preparing_for_this_point();

        }

      return signal_value;

    }

    inline double
    get_upper_uncertainty()
    {

      return ( get_value() * ( uncertainty_factor - 1.0 ) );

    }

    inline double
    get_lower_uncertainty()
    {

      return ( get_value() * ( 1.0 - ( 1.0 / uncertainty_factor ) ) );

    }

    inline double
    get_upper_value()
    {

      return ( get_value() * uncertainty_factor );

    }

    inline double
    get_lower_value()
    {

      return ( get_value() / uncertainty_factor );

    }

    inline double
    get_log_uncertainty()
    {

      // if the signal has not been calculated for this point, update
      // uncertainty_factor before returning it:
      if( needs_to_prepare_for_this_point() )
        {

          rate_calculator->calculate( &signal_value,
                                      &uncertainty_factor );
          finish_preparing_for_this_point();

        }

      return log( uncertainty_factor );

    }


  protected:

    std::string signal_name;

    signal_calculator* rate_calculator;
    signal_shortcuts* const shortcut;

    bool already_calculated_for_this_point;
    double signal_value;
    double uncertainty_factor;
    double cross_section_unit_factor;
    // this is to allow for the user to specify event rates in fb, pb or nb.

  };  // end of signal_handler class.


  /* this is a derived class which just always returns
   * CppSLHA::CppSLHA_global::really_wrong_value as its value. it is used for
   * malformed signal names.
   */
  class really_wrong_calculator : public signal_calculator
  {

  public:

    really_wrong_calculator( signal_shortcuts* const given_shortcuts ) :
      signal_calculator( given_shortcuts,
                         NULL,
                         NULL )
    {

      // just an initialization list.

    }

    virtual
    ~really_wrong_calculator()
    {

      // does nothing.

    }


    bool
    calculate( double* signal_value,
               double* uncertainty_factor )
    /* this always returns false, & always sets signal_value &
     * uncertainty_factor to CppSLHA::CppSLHA_global::really_wrong_value.
     */
    {

      // debugging:
      /**std::cout
      << std::endl
      << "debugging: really_wrong_calculator::calculate( "
      << signal_value << ", " << uncertainty_factor << " ) called.";
      std::cout << std::endl;**/

      *signal_value = CppSLHA::CppSLHA_global::really_wrong_value;
      *uncertainty_factor = CppSLHA::CppSLHA_global::really_wrong_value;

      return false;

    }

  };

  /* this is a derived class to test whether I break down the production
   * channels & recombine them correctly. all acceptances are set to 1.0 so
   * that I should just recover the total cross-section.
   */
  class sigma_breakdown_test_calculator : public signal_calculator
  {

  public:

    sigma_breakdown_test_calculator( signal_shortcuts* const given_shortcuts,
                          cross_section_table_set* const given_cross_sections )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~sigma_breakdown_test_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    calculate( double* const signal_value,
               double* const uncertainty_factor )
    /* this calculates the event rate for the signal & puts its value in
     * signal_value, & puts an estimate for the uncertainty into
     * uncertainty_factor, & returns true if it did all this successfully.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  //protected:

    // nothing.

  };  // end of sigma_breakdown_test_calculator class.

  /* this is a derived class to calculate the "Atlas 4 jets plus missing
   * transverse momentum plus 0 leptons" signal.
   * it takes the kinematics from the Atlas4jMET grid & combines them with
   * cascade decays leading to 0 leptons passing the cut.
   */
  class Atlas4jMET0l_calculator : public signal_calculator
  {

  public:

    Atlas4jMET0l_calculator( double const given_lepton_cut,
                             signal_shortcuts* const given_shortcuts,
                           cross_section_table_set* const given_cross_sections,
                             kinematics_table* const given_four_jet_kinematics,
                           kinematics_table* const given_three_jet_kinematics )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~Atlas4jMET0l_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    calculate( double* const signal_value,
               double* const uncertainty_factor )
    /* this calculates the event rate for the signal & puts its value in
     * signal_value, & puts an estimate for the uncertainty into
     * uncertainty_factor, & returns true if it did all this successfully.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    double const lepton_cut;
    // the lepton transverse momentum cut is easy enough to scale that we can
    // let the user specify it.
    kinematics_table* const three_jet_kinematics;
    /* the 4-jet signal is complicated enough that we also consider only 3 of
     * the 4 required hard jets coming from (showered) decays to
     * electroweakinos, with the 4th coming from a cascade decay of the
     * electroweakinos. hence we need an extra kinematics set (though it is
     * only used for direct jet acceptance).
     */

  };  // end of Atlas4jMET0l_calculator class.

  /* this is a derived class to calculate the "Atlas 3 jets plus missing
   * transverse momentum plus exactly 1 lepton" signal.
   * it takes the kinematics from the Atlas3jMET grid & combines them with
   * cascade decays leading to 1 lepton passing the cut.
   */
  class Atlas3jMET1l_calculator : public signal_calculator
  {

  public:

    Atlas3jMET1l_calculator( double const given_passing_cut,
                             double const given_failing_cut,
                             signal_shortcuts* const given_shortcuts,
                           cross_section_table_set* const given_cross_sections,
                             kinematics_table* const given_kinematics )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~Atlas3jMET1l_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    calculate( double* const signal_value,
               double* const uncertainty_factor )
    /* this calculates the event rate for the signal & puts its value in
     * signal_value, & puts an estimate for the uncertainty into
     * uncertainty_factor, & returns true if it did all this successfully.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    // the lepton transverse momentum cut is easy enough to scale that we can
    // let the user specify them:
    double const passing_lepton_cut;
    // this is the cut that the hardest lepton must pass.
    double const failing_lepton_cut;
    // this is the cut that every lepton but the hardest lepton must fail.

  };  // end of Atlas3jMET1l_calculator class.


}  // end of LHC_FASER namespace.

#endif /* LHC_FASER_SIGNAL_CALCULATOR_STUFF_HPP_ */
