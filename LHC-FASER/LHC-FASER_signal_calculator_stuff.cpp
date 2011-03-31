/*
 * LHC-FASER_signal_calculator_stuff.cpp
 *
 *  Created on: 17 Nov 2010
 *      Author: bol
 */

#include "LHC-FASER_signal_calculator_stuff.hpp"

namespace LHC_FASER
{

  signal_calculator::signal_calculator(
                                 signal_shortcuts* const given_shortcuts,
                           cross_section_table_set* const given_cross_sections,
                                   kinematics_table* const given_kinematics ) :
    signal_shortcut_pointer( given_shortcuts ),
    shortcut( given_shortcuts->get_input_shortcuts() ),
    cross_sections( given_cross_sections ),
    kinematics( given_kinematics ),
    cascades( given_shortcuts->get_cascade_handler() )
  {

    // just an initialization list. N.B.: derived classes have to set up the
    // std::vector of std::pairs "channels" themselves!

  }

  signal_calculator::~signal_calculator()
  {

    // we have to delete the pairs (but not the pointers within the pairs):
    for( std::vector< std::pair< sQCD_to_EWino*,
                                 cross_section_table* >* >::iterator
         deletion_iterator = channels.begin();
         channels.end() > deletion_iterator;
         ++deletion_iterator )
      {

        delete *deletion_iterator;

      }

  }



  signal_handler::signal_handler( std::string const given_signal_name,
                                  signal_shortcuts* const given_shortcuts,
                               double const given_cross_section_unit_factor ) :
    interface_readied_for_new_point( given_shortcuts->get_input_shortcuts(
                                                            )->get_readier() ),
    signal_name( given_signal_name ),
    shortcut( given_shortcuts ),
    cross_section_unit_factor( given_cross_section_unit_factor )
  {

    // debugging
    /**std::cout
    << std::endl
    << "debugging: signal_handler::signal_handler( " << given_signal_name
    << ", " << given_shortcuts << " ) called.";
    std::cout << std::endl;**/


    rate_calculator = NULL;
    // we start by ensuring that the pointer is NULL.

    std::string jet_grid_name( "error" );
    // this is used for telling the kinematics table which jet acceptance grids
    // to use.

    int character_skipper = 0;

    if( 0 == signal_name.compare( 0,
                                  12,
                                  "Atlas4jMET0l" ) )
      // if the signal is the Atlas 4-jet, missing transverse momentum,
      // 0 leptons event rate...
      {

        character_skipper += 12;

        int beam_energy;

        if( 0 == signal_name.compare( character_skipper,
                                      ( character_skipper + 4 ),
                                      "7TeV" ) )
          //for a beam energy of 7 TeV...
          {

            beam_energy = 7;
            character_skipper += 4;

          }
        else if( 0 == signal_name.compare( character_skipper,
                                           ( character_skipper + 5 ),
                                           "10TeV" ) )
          //for a beam energy of 10 TeV...
          {

            beam_energy = 10;
            character_skipper += 5;

          }
        else if( 0 == signal_name.compare( character_skipper,
                                           ( character_skipper + 5 ),
                                           "14TeV" ) )
          //for a beam energy of 14 TeV...
          {

            beam_energy = 14;
            character_skipper += 5;

          }
        else
          {

            std::cout
            << std::endl
            << "LHC-FASER::error! signal_handler::signal_handler( "
            << given_signal_name << ", "<<  given_shortcuts << " ) was passed"
            << " a name it does not know (if it starts with \"Atlas4jMET0l\","
            << " then \"7TeV\", \"10TeV\" or \"14TeV\" are expected as the"
            << " next characters). its calculator is being set to return only "
            << CppSLHA::CppSLHA_global::really_wrong_value_string << " for"
            << " every point.";

            rate_calculator = new really_wrong_calculator( shortcut );

          }

        if( NULL == rate_calculator )
          {

            jet_grid_name.assign( "Atlas4jMET" );
            std::string three_jet_name( "Atlas3jMET" );

            double lepton_cut = 10.0;
            // the default Atlas4jMET0l lepton transverse momentum cut is
            // 10.0 GeV.

            if( 0 == signal_name.compare( character_skipper,
                                          ( character_skipper + 3 ),
                                          "pTl" ) )
              // if the next 3 characters denote a non-default lepton
              // transverse momentum cut...
              {

                character_skipper += 3;
                std::stringstream lepton_cut_stream( signal_name );
                lepton_cut_stream.ignore( character_skipper );
                lepton_cut_stream >> lepton_cut;

              }

            /* the arguments of "4" in the
             * shortcut->get_kinematics_handler()->get_table( ..., 4 )s are
             * format-dependent: the grid files have several cut options, &
             * "4" should be the correct option for this signal.
             */
            rate_calculator
            = new Atlas4jMET0l_calculator( lepton_cut,
                                           shortcut,
                                           shortcut->get_cross_section_handler(
                                               )->get_table_set( beam_energy ),
                                           shortcut->get_kinematics_handler(
                                                     )->get_table( beam_energy,
                                                                &jet_grid_name,
                                                                4 ),
                                           shortcut->get_kinematics_handler(
                                                     )->get_table( beam_energy,
                                                               &three_jet_name,
                                                                   4 ) );

          }

      }
    else if( 0 == signal_name.compare( 0,
                                       12,
                                       "Atlas3jMET1l" ) )
      // if the signal is the Atlas 3-jet, missing transverse momentum,
      // 1 lepton event rate...
      {

        character_skipper += 12;

        int beam_energy;

        if( 0 == signal_name.compare( character_skipper,
                                      ( character_skipper + 4 ),
                                      "7TeV" ) )
          //for a beam energy of 7 TeV...
          {

            beam_energy = 7;
            character_skipper += 4;

          }
        else if( 0 == signal_name.compare( character_skipper,
                                           ( character_skipper + 5 ),
                                           "10TeV" ) )
          //for a beam energy of 14 TeV...
          {

            beam_energy = 10;
            character_skipper += 5;

          }
        else if( 0 == signal_name.compare( character_skipper,
                                           ( character_skipper + 5 ),
                                           "14TeV" ) )
          //for a beam energy of 14 TeV...
          {

            beam_energy = 14;
            character_skipper += 5;

          }
        else
          {

            std::cout
            << std::endl
            << "LHC-FASER::error! signal_handler::signal_handler( "
            << given_signal_name << ", "<<  given_shortcuts << " ) was passed"
            << " a name it does not know (if it starts with \"Atlas3jMET1l\","
            << " then \"7TeV\", \"10TeV\" or \"14TeV\" are expected as the"
            << " next characters). its calculator is being set to return only "
            << CppSLHA::CppSLHA_global::really_wrong_value_string << " for"
            << " every point.";

            rate_calculator = new really_wrong_calculator( shortcut );

          }

        if( NULL == rate_calculator )
          {

            jet_grid_name.assign( "Atlas3jMET" );

            double passing_lepton_cut = 20.0;
            // the default Atlas3jMET1l lepton transverse momentum cut is
            // 20.0 GeV for the hardest lepton.
            double failing_lepton_cut = 10.0;
            // the default Atlas3jMET1l lepton transverse momentum cut is
            // 10.0 GeV for all other leptons to *fail*.

            int passing_lepton_cut_position = signal_name.find( "pTl" );

            if( std::string::npos != passing_lepton_cut_position )
              // if we find that the user has specified a primary lepton cut...
              {

                /* we assume that if there's a "pTl", the next characters
                 * define the lepton cut up to another occurance of "pTl" or
                 * some whitespace. e.g. either "pTl23pTl15" or "pTl23"
                 */

                int failing_lepton_cut_position
                = signal_name.find( "pTl",
                                    passing_lepton_cut_position );
                std::string passing_cut_as_string;

                if( std::string::npos != failing_lepton_cut_position )
                  // if we find that the user has specified a secondary lepton
                  // cut...
                  {

                    std::string failing_cut_as_string( signal_name,
                                         ( failing_lepton_cut_position + 3 ) );

                    passing_cut_as_string.assign( signal_name,
                                           ( passing_lepton_cut_position + 3 ),
                                                  ( failing_lepton_cut_position
                                             - passing_lepton_cut_position ) );

                    std::stringstream
                    failing_lepton_cut_stream( failing_cut_as_string );
                    failing_lepton_cut_stream >> failing_lepton_cut;

                  }
                else
                  {

                    passing_cut_as_string.assign( signal_name,
                                         ( passing_lepton_cut_position + 3 ),
                                                  signal_name.size() );

                  }

                std::stringstream
                passing_lepton_cut_stream( passing_cut_as_string );
                passing_lepton_cut_stream >> passing_lepton_cut;

              }

            /* the arguments of "4" in the
             * shortcut->get_kinematics_handler()->get_table( ..., 4 )s are
             * format-dependent: the grid files have several cut options, &
             * "4" should be the correct option for this signal.
             */
            rate_calculator
            = new Atlas3jMET1l_calculator( passing_lepton_cut,
                                           failing_lepton_cut,
                                           shortcut,
                                           shortcut->get_cross_section_handler(
                                               )->get_table_set( beam_energy ),
                                           shortcut->get_kinematics_handler(
                                                     )->get_table( beam_energy,
                                                                &jet_grid_name,
                                                                   4 ) );

          }

      }
    else if( 0 == signal_name.compare( "CMS2jMETanyl14TeV" ) )
      // if the signal is the Atlas 4-jet, missing transverse momentum,
      // 0 leptons event rate, for a beam energy of 14 TeV...
      {

        //
        std::cout
        << std::endl
        << "LHC-FASER::error! signal_handler::signal_handler( "
        << given_signal_name << ", "<<  given_shortcuts << " ) was passed"
        << " CMS2jMETanyl14TeV, but unfortunately it has not yet been"
        << " implemented. its calculator is being set to return only "
        << CppSLHA::CppSLHA_global::really_wrong_value_string
        << " for every point instead.";

        rate_calculator = new really_wrong_calculator( shortcut );

      }
    else if( 0 == signal_name.compare( "sigma_breakdown_test" ) )
      // if the signal is the test to see if the cross-section breakdown works
      // as it should...
      {

        rate_calculator
        = new sigma_breakdown_test_calculator( shortcut,
                                           shortcut->get_cross_section_handler(
                                                       )->get_table_set( 7 ) );

      }
    else
      // otherwise, a malformed signal name was passed:
      {

        std::cout
        << std::endl
        << "LHC-FASER::error! signal_handler::signal_handler( "
        << signal_name << ", " <<  given_shortcuts << " ) was passed a"
        << " name it does not know ( \"" << signal_name
        << "\" ). its calculator is being set to return only "
        << CppSLHA::CppSLHA_global::really_wrong_value_string << " for"
        << " every point.";
        std::cout << std::endl;

        rate_calculator = new really_wrong_calculator( shortcut );

      }

  }

  signal_handler::~signal_handler()
  {

    delete rate_calculator;

  }



  Atlas4jMET0l_calculator::Atlas4jMET0l_calculator(
                                                 double const given_lepton_cut,
                                       signal_shortcuts* const given_shortcuts,
                           cross_section_table_set* const given_cross_sections,
                             kinematics_table* const given_four_jet_kinematics,
                         kinematics_table* const given_three_jet_kinematics ) :
    signal_calculator( given_shortcuts,
                       given_cross_sections,
                       given_four_jet_kinematics ),
    lepton_cut( given_lepton_cut ),
    three_jet_kinematics( given_three_jet_kinematics )
  {

    // here we set up all the sparticle_production_combinations relevant to the
    // signal:
    for( std::vector< signed_particle_shortcut_pair* >::const_iterator
         production_iterator
         = shortcut->get_sparticle_production_combinations()->begin();
         shortcut->get_sparticle_production_combinations()->end()
         > production_iterator;
         ++production_iterator )
      {

        channels.push_back( new std::pair< sQCD_to_EWino*,
                                           cross_section_table* >(
                                   signal_shortcut_pointer->get_sQCD_to_EWinos(
                                                          *production_iterator,
                                                    shortcut->get_empty_list(),
                                                shortcut->get_not_in_jets5() ),
                         cross_sections->get_table( *production_iterator ) ) );

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: pushed back sQCD_to_EWino { "
        << *(channels.back()->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
        << ", "
        << *(channels.back()->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
        << " } with cross_section_table "
        << channels.back()->second;
        std::cout << std::endl;**/

      }

  }

  Atlas4jMET0l_calculator::~Atlas4jMET0l_calculator()
  {

    // does nothing.

  }


  bool
  Atlas4jMET0l_calculator::calculate( double* const signal_value,
                                      double* const uncertainty_factor )
  /* this calculates the event rate for the signal & puts its value in
   * signal_value, & puts an estimate for the uncertainty into
   * uncertainty_factor, & returns true if it did all this successfully.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: Atlas4jMET0l_calculator::calculate( "
    << signal_value << ", " << uncertainty_factor << " ) called.";
    std::cout << std::endl;**/

    // start by setting the signal value to 0.0:
    *signal_value = 0.0;

    double subchannel_cross_section_times_acceptance;
    // this holds the total rate per scolored_to_EWinos subchannel.
    double subchannel_just_no_leptons_value;
    /* this holds the acceptance for the subchannel's electroweakinos producing
     * no leptons which cause the event to be rejected, regardless of how many
     * jets they produce.
     */
    double subchannel_threshold_cross_section;
    // this is used for deciding which subchannels are significant enough that
    // we continue to work out their full acceptances.
    double sQCD_decayed_4j_acceptance;
    double sQCD_decayed_3j_acceptance;
    /* these hold the acceptance per combination of "sQCD-stable" sparticles
     * (e.g. sdown_L pair after gluino pair if m_sdL < m_go, sup_R pair after
     * gluino pair if m_suR < m_go,
     * sbottom_one pair after gluino pair after sup_L + gluino if
     * m_suL > m_go > m_sb1). they are for when 4 or 3 jets of the 4 needed
     * to pass the cut come from the jets produced *before* the cascades.
     */
    //double sQCD_decayed_2j_acceptance;
    //double sQCD_decayed_1j_acceptance;
    //double sQCD_decayed_0j_acceptance;
    /* in principle, there are also contributions from when the "sQCD decays"
     * produce only the hardest 2 jets, or only the hardest jet, or no jets at
     * all the pass the cut, or when the hardest jet comes from an electroweak
     * cascade decay, but we're assuming that they're negligible.
     */

    charge_summed_cascade_calculator* first_cascade;
    charge_summed_cascade_calculator* second_cascade;

    double const softer_jet_cut = 40.0;

    // debugging:
    /**std::cout
    << std::endl
    << "about to enter loop over pairs of"
    << " { sQCD_to_EWino*, cross_section_table* }";
    std::cout << std::endl;**/

    // loop over all the combinations of gluinos &/or squarks:
    for( std::vector< std::pair< sQCD_to_EWino*,
                                 cross_section_table* >* >::iterator
         channel_iterator = channels.begin();
         channels.end() > channel_iterator;
         ++channel_iterator )
      {

        // debugging:
        /**std::cout
        << std::endl
        << *((*channel_iterator)->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
        << " + "
        << *((*channel_iterator)->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
        << ", cross-section = " << (*channel_iterator)->second->get_value();
        std::cout << std::endl;**/

        if( LHC_FASER_global::negligible_sigma
            < (*channel_iterator)->second->get_value() )
          {

            // debugging:
            /**std::cout
            << std::endl
            << "about to call (*channel_iterator)->first->get_sQCD_end()";
            std::cout << std::endl;**/

            std::vector< scoloreds_to_EWinos* > const*
            subchannels = (*channel_iterator)->first->get_sQCD_end();
            subchannel_threshold_cross_section
            = ( LHC_FASER_global::negligible_sigma
                / ( 2.0 * (double)(subchannels->size()) ) );
            // this should mean we never throw away more than
            // 0.5 * LHC_FASER_global::negligible_sigma of cross-section.

            // debugging:
            /**std::cout
            << std::endl
            << "(*channel_iterator)->first->get_sQCD_end() size = "
            << subchannels->size();
            std::cout << std::endl;
            std::cout << "elements over 0.001 = ";
            std::cout << std::endl;
            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                if( (*subchannel_iterator)->get_BR_product() > 0.001 )
                  {

                    std::cout
                    << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                  )->get_first_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "+" << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                 )->get_second_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "BR = "
                    << (*subchannel_iterator)->get_BR_product()
                    << std::endl;

                  }

              }
            std::cout << std::endl;**/

            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                subchannel_cross_section_times_acceptance
                = ( (*channel_iterator)->second->get_value()
                    * (*subchannel_iterator)->get_BR_product() );

                // debugging:
                /**std::cout
                << std::endl
                << "subchannel "
                << *((*subchannel_iterator)->get_scoloreds(
                                                          )->get_first_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_first_cascade()->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_first_cascade()->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                << std::endl
                << "+"
                << std::endl
                << *((*subchannel_iterator)->get_scoloreds(
                                                         )->get_second_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_second_cascade()->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_second_cascade()->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                << std::endl
                << " sigma = " << (*channel_iterator)->second->get_value()
                << ", sQCD BR = " << (*subchannel_iterator)->get_BR_product()
                << " => sigma * sQCD BR = "
                << subchannel_cross_section_times_acceptance
                << " (needs to be > " << subchannel_threshold_cross_section
                << " to proceed)";
                std::cout << std::endl;**/

                if( subchannel_threshold_cross_section
                    < subchannel_cross_section_times_acceptance )
                  // if it's still worth carrying on with the channel's
                  // cascades...
                  {

                    // we set up the cascade calculators:

                    first_cascade
                    = cascades->get_charge_summed_calculator( -1.0
                         /* we don't care about leptons *passing* this cut. */,
                                                              lepton_cut
                          /* we *do* care about leptons *failing* this cut. */,
                                                              softer_jet_cut
                                                     /* cut for extra jets. */,
                                             kinematics->get_lepton_acceptance(
                                                          (*subchannel_iterator
                                                            )->get_scoloreds(),
                                                          (*subchannel_iterator
                                                        )->get_first_cascade(),
                                                          (*subchannel_iterator
                                                     )->get_second_cascade() ),
                                     (*subchannel_iterator)->get_first_cascade(
                                                              )->get_product(),
                                                          (*subchannel_iterator
                                   )->first_end_scolored_is_not_antiparticle(),
                                     (*subchannel_iterator)->get_first_cascade(
                                                                )->get_EWino(),
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() );

                    second_cascade
                    = cascades->get_charge_summed_calculator( -1.0
                         /* we don't care about leptons *passing* this cut. */,
                                                              lepton_cut
                          /* we *do* care about leptons *failing* this cut. */,
                                                              softer_jet_cut
                                                     /* cut for extra jets. */,
                                             kinematics->get_lepton_acceptance(
                                                          (*subchannel_iterator
                                                            )->get_scoloreds(),
                                                          (*subchannel_iterator
                                                        )->get_first_cascade(),
                                                          (*subchannel_iterator
                                                     )->get_second_cascade() ),
                                    (*subchannel_iterator)->get_second_cascade(
                                                              )->get_product(),
                                                          (*subchannel_iterator
                                  )->second_end_scolored_is_not_antiparticle(),
                                    (*subchannel_iterator)->get_second_cascade(
                                                                )->get_EWino(),
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() );


                    // then we take the case of 4 jets passing the cuts before
                    // the cascades:
                    sQCD_decayed_4j_acceptance
                    = kinematics->get_jet_acceptance(
                                       (*subchannel_iterator)->get_scoloreds(),
                                   (*subchannel_iterator)->get_first_cascade(),
                                   (*subchannel_iterator)->get_second_cascade()
                                                           )->get_acceptance();
                    /* this includes BRs from produced colored sparticles down
                     * to the electroweakinos from the decays of the final
                     * colored sparticles.
                     */

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "4j acceptance = " << sQCD_decayed_4j_acceptance;
                    std::cout << std::endl;**/

                    // now we apply the acceptance after the cascades:
                    subchannel_just_no_leptons_value
                    = ( ( first_cascade->get_acceptance( 0
                                           /* 0 extra jets passing the cut. */,
                                                         0
                                             /* 0 leptons passing the cut. */ )
                          + first_cascade->get_acceptance( 1
                                           /* 1 extra jets passing the cut. */,
                                                           0
                                             /* 0 leptons passing the cut. */ )
                          + first_cascade->get_acceptance( 2
                                           /* 2 extra jets passing the cut. */,
                                                           0
                                           /* 0 leptons passing the cut. */ ) )
                          * ( second_cascade->get_acceptance( 0,
                                                              0 )
                              + second_cascade->get_acceptance( 1,
                                                                0 )
                              + second_cascade->get_acceptance( 2,
                                                                0 ) ) );
                    // we multiply the chances for each cascade to be
                    // acceptable together.
                    sQCD_decayed_4j_acceptance
                    *= subchannel_just_no_leptons_value;

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "no extra jets, no leptons acceptance = "
                    << subchannel_just_no_leptons_value
                    << ", product = " << sQCD_decayed_4j_acceptance;
                    std::cout << std::endl;**/

                    // then we take the case of exactly 3 jets passing the cuts
                    // before the cascades:
                    sQCD_decayed_3j_acceptance
                    = ( three_jet_kinematics->get_jet_acceptance(
                                       (*subchannel_iterator)->get_scoloreds(),
                                   (*subchannel_iterator)->get_first_cascade(),
                                   (*subchannel_iterator)->get_second_cascade()
                                                            )->get_acceptance()
                        - sQCD_decayed_4j_acceptance );
                    /* this includes BRs from produced colored sparticles down
                     * to the electroweakinos from the decays of the final
                     * colored sparticles.
                     */

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "just 3j acceptance = " << sQCD_decayed_3j_acceptance;
                    std::cout << std::endl;**/

                    // now we apply the acceptance after the cascades:
                    sQCD_decayed_3j_acceptance
                    *= ( subchannel_just_no_leptons_value
                         - ( first_cascade->get_acceptance( 0,
                                                            0 )
                             * second_cascade->get_acceptance( 0,
                                                               0 ) ) );
                    // chance of each cascade - chance of not enough jets
                    // despite correct number of leptons.

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "1 extra jet, no leptons acceptance = "
                    << ( subchannel_just_no_leptons_value
                        - ( first_cascade->get_acceptance( 0,
                                                           0 )
                            * second_cascade->get_acceptance( 0,
                                                              0 ) ) )
                    << ", product = " << sQCD_decayed_3j_acceptance;
                    std::cout << std::endl;**/

                    subchannel_cross_section_times_acceptance
                    *= ( sQCD_decayed_4j_acceptance
                         + sQCD_decayed_3j_acceptance );

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "total acceptance = "
                    << ( sQCD_decayed_4j_acceptance
                        + sQCD_decayed_3j_acceptance );
                    std::cout << std::endl;**/

                    // we add these configurations to the channel acceptance:
                    *signal_value += subchannel_cross_section_times_acceptance;

                    if( shortcut->is_verbose() )
                      // if we're on the lookout for errors & warnings...
                      {

                        if( ( ( (*channel_iterator)->second->get_value()
                                * (*subchannel_iterator)->get_BR_product() )
                               < subchannel_cross_section_times_acceptance )
                            ||
                            ( 0.0
                              > subchannel_cross_section_times_acceptance ) )
                          // if the acceptance was outside the acceptable
                          // range...
                          {

                            std::cout
                            << std::endl
                            << "LHC-FASER::error! somehow the "
                            << *((*subchannel_iterator)->get_scoloreds(
                                                          )->get_first_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                            << " + "
                            << *((*subchannel_iterator)->get_scoloreds(
                                                         )->get_second_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                            << " (gluinos decaying to "
                            << *((*subchannel_iterator)->get_first_cascade(
                                                                )->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                            << " & "
                            << *((*subchannel_iterator)->get_second_cascade(
                                                                )->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                            << ") cascading to "
                            << *((*subchannel_iterator)->get_first_cascade(
                                                                  )->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                            << " + "
                            << *((*subchannel_iterator)->get_second_cascade(
                                                                  )->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                            << " production channel had cross-section times"
                            << " branching ratio times acceptance of "
                            << subchannel_cross_section_times_acceptance
                            << " (hence acceptance times BR = "
                            << ( subchannel_cross_section_times_acceptance
                                 / (*channel_iterator)->second->get_value() )
                            << ").";
                            std::cout << std::endl;

                          }

                      }  // end of error message if statement.


                    // debugging:
                    /**std::cout
                    << std::endl
                    << "total subchannel sigma * BR = "
                    << subchannel_cross_section_times_acceptance;
                    std::cout << std::endl;**/

                  }  // end of if the subchannel's sQCD-to-EWino cross-section
                     // is not negligible.

              } // end of loop over scoloreds_to_EWinos.

          }
        // end of if channel's cross-section is large enough to bother with.

        // debugging:
        /**std::cout
        << std::endl
        << "total sigma * BR so far = " << *signal_value;
        std::cout << std::endl;**/

      } // end of loop over sQCD_to_EWinos.

    // currently, we do the uncertainty very roughly:
    *uncertainty_factor
    = ( *signal_value * signal_shortcut_pointer->get_uncertainty() );

    return true;

  }



  Atlas3jMET1l_calculator::Atlas3jMET1l_calculator(
                                                double const given_passing_cut,
                                                double const given_failing_cut,
                                       signal_shortcuts* const given_shortcuts,
                           cross_section_table_set* const given_cross_sections,
                                   kinematics_table* const given_kinematics ) :
    signal_calculator( given_shortcuts,
                       given_cross_sections,
                       given_kinematics ),
    passing_lepton_cut( given_passing_cut ),
    failing_lepton_cut( given_failing_cut )
  {

    // here we set up all the sparticle_production_combinations relevant to the
    // signal:
    for( std::vector< signed_particle_shortcut_pair* >::const_iterator
         production_iterator
         = shortcut->get_sparticle_production_combinations()->begin();
         shortcut->get_sparticle_production_combinations()->end()
         > production_iterator;
         ++production_iterator )
      {

        channels.push_back( new std::pair< sQCD_to_EWino*,
                                           cross_section_table* >(
                                   signal_shortcut_pointer->get_sQCD_to_EWinos(
                                                          *production_iterator,
                                                    shortcut->get_empty_list(),
                                                shortcut->get_not_in_jets5() ),
                         cross_sections->get_table( *production_iterator ) ) );

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: pushed back sQCD_to_EWino { "
        << *(channels.back()->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
        << ", "
        << *(channels.back()->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
        << " } with cross_section_table "
        << channels.back()->second;
        std::cout << std::endl;**/

      }

  }

  Atlas3jMET1l_calculator::~Atlas3jMET1l_calculator()
  {

    // does nothing.

  }


  bool
  Atlas3jMET1l_calculator::calculate( double* const signal_value,
                                      double* const uncertainty_factor )
  /* this calculates the event rate for the signal & puts its value in
   * signal_value, & puts an estimate for the uncertainty into
   * uncertainty_factor, & returns true if it did all this successfully.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: Atlas3jMET1l_calculator::calculate( "
    << signal_value << ", " << uncertainty_factor << " ) called.";
    std::cout << std::endl;**/

    // start by setting the signal value to 0.0:
    *signal_value = 0.0;

    double subchannel_cross_section_times_acceptance;
    // this holds the total rate per scolored_to_EWinos subchannel.
    double subchannel_just_one_lepton_value;
    /* this holds the acceptance for the subchannel's electroweakinos producing
     * exactly 1 lepton which cause the event to be rejected, regardless of how
     * many jets they produce.
     */
    double subchannel_threshold_cross_section;
    // this is used for deciding which subchannels are significant enough that
    // we continue to work out their full acceptances.
    double sQCD_decayed_3j_acceptance;
    /* this holds the acceptance per combination of "sQCD-stable" sparticles
     * (e.g. sdown_L pair after gluino pair if m_sdL < m_go, sup_R pair after
     * gluino pair if m_suR < m_go,
     * sbottom_one pair after gluino pair after sup_L + gluino if
     * m_suL > m_go > m_sb1). they are for when 4 or 3 jets of the 4 needed
     * to pass the cut come from the jets produced *before* the cascades.
     */
    //double sQCD_decayed_2j_acceptance;
    //double sQCD_decayed_1j_acceptance;
    //double sQCD_decayed_0j_acceptance;
    /* in principle, there are also contributions from when the "sQCD decays"
     * produce only the hardest 2 jets, or only the hardest jet, or no jets at
     * all the pass the cut, or when the hardest jet comes from an electroweak
     * cascade decay, but we're assuming that they're negligible.
     */

    charge_summed_cascade_calculator* first_cascade;
    charge_summed_cascade_calculator* second_cascade;

    // debugging:
    /**std::cout
    << std::endl
    << "about to enter loop over pairs of"
    << " { sQCD_to_EWino*, cross_section_table* }";
    std::cout << std::endl;**/

    // loop over all the combinations of gluinos &/or squarks:
    for( std::vector< std::pair< sQCD_to_EWino*,
                                 cross_section_table* >* >::iterator
         channel_iterator = channels.begin();
         channels.end() > channel_iterator;
         ++channel_iterator )
      {

        // debugging:
        /**std::cout
        << std::endl
        << *((*channel_iterator)->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
        << " + "
        << *((*channel_iterator)->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
        << ", cross-section = " << (*channel_iterator)->second->get_value();
        std::cout << std::endl;**/

        if( LHC_FASER_global::negligible_sigma
            < (*channel_iterator)->second->get_value() )
          {

            // debugging:
            /**std::cout
            << std::endl
            << "about to call (*channel_iterator)->first->get_sQCD_end()";
            std::cout << std::endl;**/

            std::vector< scoloreds_to_EWinos* > const*
            subchannels = (*channel_iterator)->first->get_sQCD_end();
            subchannel_threshold_cross_section
            = ( LHC_FASER_global::negligible_sigma
                / ( 2.0 * (double)(subchannels->size()) ) );
            // this should mean we never throw away more than
            // 0.5 * LHC_FASER_global::negligible_sigma of cross-section.

            // debugging:
            /**std::cout
            << std::endl
            << "(*channel_iterator)->first->get_sQCD_end() size = "
            << subchannels->size();
            std::cout << std::endl;
            std::cout << "elements over 0.001 = ";
            std::cout << std::endl;
            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                if( (*subchannel_iterator)->get_BR_product() > 0.001 )
                  {

                    std::cout
                    << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                  )->get_first_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "+" << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                 )->get_second_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "BR = "
                    << (*subchannel_iterator)->get_BR_product()
                    << std::endl;

                  }

              }
            std::cout << std::endl;**/

            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                subchannel_cross_section_times_acceptance
                = ( (*channel_iterator)->second->get_value()
                    * (*subchannel_iterator)->get_BR_product() );

                // debugging:
                /**std::cout
                << std::endl
                << "subchannel "
                << *((*subchannel_iterator)->get_scoloreds(
                                                          )->get_first_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_first_cascade()->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_first_cascade()->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                << std::endl
                << "+"
                << std::endl
                << *((*subchannel_iterator)->get_scoloreds(
                                                         )->get_second_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_second_cascade()->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                << " => "
                << *((*subchannel_iterator)->get_second_cascade()->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                << std::endl
                << " sigma = " << (*channel_iterator)->second->get_value()
                << ", sQCD BR = " << (*subchannel_iterator)->get_BR_product()
                << " => sigma * sQCD BR = "
                << subchannel_cross_section_times_acceptance
                << " (needs to be > " << subchannel_threshold_cross_section
                << " to proceed)";
                std::cout << std::endl;**/

                if( subchannel_threshold_cross_section
                    < subchannel_cross_section_times_acceptance )
                  // if it's still worth carrying on with the channel's
                  // cascades...
                  {

                    // we set up the cascade calculators:

                    first_cascade
                    = cascades->get_charge_summed_calculator(
                                                            passing_lepton_cut,
                                                            failing_lepton_cut,
                                                              -1.0
                        /* we don't care about extra jets from the cascade. */,
                                             kinematics->get_lepton_acceptance(
                                                          (*subchannel_iterator
                                                            )->get_scoloreds(),
                                                          (*subchannel_iterator
                                                        )->get_first_cascade(),
                                                          (*subchannel_iterator
                                                     )->get_second_cascade() ),
                                     (*subchannel_iterator)->get_first_cascade(
                                                              )->get_product(),
                                                          (*subchannel_iterator
                                   )->first_end_scolored_is_not_antiparticle(),
                                     (*subchannel_iterator)->get_first_cascade(
                                                                )->get_EWino(),
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() );

                    second_cascade
                    = cascades->get_charge_summed_calculator(
                                                            passing_lepton_cut,
                                                            failing_lepton_cut,
                                                              -1.0
                        /* we don't care about extra jets from the cascade. */,
                                             kinematics->get_lepton_acceptance(
                                                          (*subchannel_iterator
                                                            )->get_scoloreds(),
                                                          (*subchannel_iterator
                                                        )->get_first_cascade(),
                                                          (*subchannel_iterator
                                                     )->get_second_cascade() ),
                                    (*subchannel_iterator)->get_second_cascade(
                                                              )->get_product(),
                                                          (*subchannel_iterator
                                  )->second_end_scolored_is_not_antiparticle(),
                                    (*subchannel_iterator)->get_second_cascade(
                                                                )->get_EWino(),
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() );


                    // now we take the case of exactly 3 jets passing the cuts:
                    sQCD_decayed_3j_acceptance
                    = kinematics->get_jet_acceptance(
                                       (*subchannel_iterator)->get_scoloreds(),
                                   (*subchannel_iterator)->get_first_cascade(),
                                   (*subchannel_iterator)->get_second_cascade()
                                                           )->get_acceptance();
                    /* this includes BRs from produced colored sparticles down
                     * to the electroweakinos from the decays of the final
                     * colored sparticles.
                     */

                    // now we apply the acceptance after the cascades:
                    subchannel_just_one_lepton_value
                    = ( ( first_cascade->get_acceptance( 0
                                           /* 0 extra jets passing the cut. */,
                                                         1
                                              /* 1 lepton passing the cut. */ )
                          + first_cascade->get_acceptance( 1
                                           /* 1 extra jets passing the cut. */,
                                                           1
                                              /* 1 lepton passing the cut. */ )
                          + first_cascade->get_acceptance( 2
                                           /* 2 extra jets passing the cut. */,
                                                           1
                                            /* 1 lepton passing the cut. */ ) )
                        * ( second_cascade->get_acceptance( 0,
                                                            0 )
                            + second_cascade->get_acceptance( 1,
                                                              0 )
                            + second_cascade->get_acceptance( 2,
                                                              0 ) )
                        + ( first_cascade->get_acceptance( 0,
                                                           0 )
                            + first_cascade->get_acceptance( 1,
                                                             0 )
                            + first_cascade->get_acceptance( 2,
                                                             0 ) )
                          * ( second_cascade->get_acceptance( 0,
                                                              1 )
                              + second_cascade->get_acceptance( 1,
                                                                1 )
                              + second_cascade->get_acceptance( 2,
                                                                1 ) ) );
                    /* chance for 1st cascade to produce the lepton * chance
                     * of 2nd to not produce any further leptons (which would
                     * cause the event to be rejected) + chance of lepton from
                     * 2nd cascade * chance of no lepton from 1st cascade.
                     */
                    sQCD_decayed_3j_acceptance
                    *= subchannel_just_one_lepton_value;

                    subchannel_cross_section_times_acceptance
                    *= sQCD_decayed_3j_acceptance;

                    // debugging:
                    /**std::cout
                    << std::endl
                    << "total acceptance = "
                    << sQCD_decayed_3j_acceptance;
                    std::cout << std::endl;**/

                    // we add these configurations to the channel acceptance:
                    *signal_value += subchannel_cross_section_times_acceptance;

                    if( shortcut->is_verbose() )
                      // if we're on the lookout for errors & warnings...
                      {

                        if( ( ( (*channel_iterator)->second->get_value()
                                * (*subchannel_iterator)->get_BR_product() )
                               < subchannel_cross_section_times_acceptance )
                            ||
                            ( 0.0
                              > subchannel_cross_section_times_acceptance ) )
                          // if the acceptance was outside the acceptable
                          // range...
                          {

                            std::cout
                            << std::endl
                            << "LHC-FASER::error! somehow the "
                            << *((*subchannel_iterator)->get_scoloreds(
                                                          )->get_first_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                            << " + "
                            << *((*subchannel_iterator)->get_scoloreds(
                                                         )->get_second_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                            << " (gluinos decaying to "
                            << *((*subchannel_iterator)->get_first_cascade(
                                                                )->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                            << " & "
                            << *((*subchannel_iterator)->get_second_cascade(
                                                                )->get_product(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                            << ") cascading to "
                            << *((*subchannel_iterator)->get_first_cascade(
                                                                  )->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                            << " + "
                            << *((*subchannel_iterator)->get_second_cascade(
                                                                  )->get_EWino(
                                                       )->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                            << " production channel had cross-section times"
                            << " branching ratio times acceptance of "
                            << subchannel_cross_section_times_acceptance
                            << " (hence acceptance times BR = "
                            << ( subchannel_cross_section_times_acceptance
                                 / (*channel_iterator)->second->get_value() )
                            << ").";
                            std::cout << std::endl;

                          }

                      }  // end of error message if statement.


                    // debugging:
                    /**std::cout
                    << std::endl
                    << "total subchannel sigma * BR = "
                    << subchannel_cross_section_times_acceptance;
                    std::cout << std::endl;**/

                  }  // end of if the subchannel's sQCD-to-EWino cross-section
                     // is not negligible.

              } // end of loop over scoloreds_to_EWinos.

          }
        // end of if channel's cross-section is large enough to bother with.

        // debugging:
        /**std::cout
        << std::endl
        << "total sigma * BR so far = " << *signal_value;
        std::cout << std::endl;**/

      } // end of loop over sQCD_to_EWinos.

    // currently, we do the uncertainty very roughly:
    *uncertainty_factor
    = ( *signal_value * signal_shortcut_pointer->get_uncertainty() );

    return true;

  }



  sigma_breakdown_test_calculator::sigma_breakdown_test_calculator(
                                       signal_shortcuts* const given_shortcuts,
                        cross_section_table_set* const given_cross_sections ) :
    signal_calculator( given_shortcuts,
                       given_cross_sections,
                       NULL )
  {

    // here we set up all the sparticle_production_combinations relevant to the
    // signal:
    for( std::vector< signed_particle_shortcut_pair* >::const_iterator
         production_iterator
         = shortcut->get_sparticle_production_combinations()->begin();
         shortcut->get_sparticle_production_combinations()->end()
         > production_iterator;
         ++production_iterator )
      {

        channels.push_back( new std::pair< sQCD_to_EWino*,
                                           cross_section_table* >(
                                   signal_shortcut_pointer->get_sQCD_to_EWinos(
                                                          *production_iterator,
                                                    shortcut->get_empty_list(),
                                                  shortcut->get_empty_list()/*,
                                              shortcut->get_not_in_jets5()*/ ),
                         cross_sections->get_table( *production_iterator ) ) );

        // debugging:
        /**std::cout
        << std::endl
        << "debugging: pushed back sQCD_to_EWino { "
        << *(channels.back()->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
        << ", "
        << *(channels.back()->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                     channels.back()->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
        << " } with cross_section_table "
        << channels.back()->second;
        std::cout << std::endl;**/

      }

  }

  sigma_breakdown_test_calculator::~sigma_breakdown_test_calculator()
  {

    // does nothing.

  }


  bool
  sigma_breakdown_test_calculator::calculate( double* const signal_value,
                                             double* const uncertainty_factor )
  /* this calculates the event rate for the signal & puts its value in
   * signal_value, & puts an estimate for the uncertainty into
   * uncertainty_factor, & returns true if it did all this successfully.
   */
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: sigma_breakdown_test_calculator::calculate("
    << signal_value << ", " << uncertainty_factor << ") called."
    << " only showing subchannels with sigma * BR > 0.1.";
    std::cout << std::endl;**/

    // start by setting the signal value to 0.0:
    *signal_value = 0.0;

    double subchannel_cross_section_times_acceptance;
    // this holds the total rate per scolored_to_EWinos subchannel.
    double channel_cross_section_times_acceptance;
    // this holds the total rate per sQCD_to_EWino channel.
    double subchannel_threshold_cross_section;
    // this is used for deciding which subchannels are significant enough that
    // we continue to work out their full acceptances.
    double channel_BR_sum;
    // this is used for checking if the BRs for a channel add up to 1.0 or
    // close enough to it.

    // debugging:
    /**std::cout
    << std::endl
    << "about to enter loop over pairs of"
    << " { sQCD_to_EWino*, cross_section_table* }";
    std::cout << std::endl;**/

    // loop over all the combinations of gluinos &/or squarks:
    for( std::vector< std::pair< sQCD_to_EWino*,
                                 cross_section_table* >* >::iterator
         channel_iterator = channels.begin();
         channels.end() > channel_iterator;
         ++channel_iterator )
      {

        channel_cross_section_times_acceptance = 0.0;
        channel_BR_sum = 0.0;

        if( -1.0 < (*channel_iterator)->second->get_value() )
          // should always show this.
          {

            // debugging:
            /**std::cout
            << std::endl
            << *((*channel_iterator)->first->get_scolored_pair(
                                  )->get_first_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                              )->first_is_not_antiparticle() ))
            << " + "
            << *((*channel_iterator)->first->get_scolored_pair(
                                 )->get_second_pointer()->get_name_or_antiname(
                                 (*channel_iterator)->first->get_scolored_pair(
                                             )->second_is_not_antiparticle() ))
            << ", cross-section = "
            << (*channel_iterator)->second->get_value();
            std::cout << std::endl;**/

          }

        if( LHC_FASER_global::negligible_sigma
            < (*channel_iterator)->second->get_value() )
          {

            // debugging:
            /**std::cout
            << std::endl
            << "about to call (*channel_iterator)->first->get_sQCD_end()";
            std::cout << std::endl;**/

            std::vector< scoloreds_to_EWinos* > const*
            subchannels = (*channel_iterator)->first->get_sQCD_end();
            subchannel_threshold_cross_section
            = ( LHC_FASER_global::negligible_sigma
                / ( 2.0 * (double)(subchannels->size()) ) );

            // debugging:
            /**std::cout
            << std::endl
            << "(*channel_iterator)->first->get_sQCD_end() size = "
            << subchannels->size()
            << std::endl
            << "threshold BR is now "
            << ( subchannel_threshold_cross_section
                 / (*channel_iterator)->second->get_value() );
            std::cout << std::endl;
            std::cout << "elements = ";
            std::cout << std::endl;**/
            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                channel_BR_sum += (*subchannel_iterator)->get_BR_product();

                if( /*subchannel_threshold_cross_section*/ 0.01
                    < (*subchannel_iterator)->get_BR_product()
                      * (*channel_iterator)->second->get_value() )
                  {

                    /**std::cout
                    << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                  )->get_first_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "+" << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                 )->get_second_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "BR = "
                    << (*subchannel_iterator)->get_BR_product()
                    << std::endl;**/

                  }

              }
            std::cout
            << std::endl
            << "channel_BR_sum = " << channel_BR_sum;
            std::cout << std::endl;/**/

            for( std::vector< scoloreds_to_EWinos* >::const_iterator
                 subchannel_iterator = subchannels->begin();
                 subchannels->end() > subchannel_iterator;
                 ++subchannel_iterator )
              {

                subchannel_cross_section_times_acceptance
                = ( (*channel_iterator)->second->get_value()
                    * (*subchannel_iterator)->get_BR_product() );

                // debugging:
                /**if( subchannel_threshold_cross_section
                    < subchannel_cross_section_times_acceptance )
                  // if it's still worth carrying on with the channel's
                  // cascades...
                  {

                    std::cout
                    << std::endl
                    << "subchannel "
                    << *((*subchannel_iterator)->get_scoloreds(
                                                          )->get_first_pointer(
                                                       )->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                              )->first_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                 )->first_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_first_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                        )->first_EWino_is_not_antiparticle() ))
                    << std::endl
                    << "+"
                    << std::endl
                    << *((*subchannel_iterator)->get_scoloreds(
                                 )->get_second_pointer()->get_name_or_antiname(
                                         (*subchannel_iterator)->get_scoloreds(
                                             )->second_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                        )->get_product()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                )->second_end_scolored_is_not_antiparticle() ))
                    << " => "
                    << *((*subchannel_iterator)->get_second_cascade(
                                          )->get_EWino()->get_name_or_antiname(
                                                          (*subchannel_iterator
                                       )->second_EWino_is_not_antiparticle() ))
                    << std::endl
                    << " sigma = " << (*channel_iterator)->second->get_value()
                    << ", sQCD BR = "
                    << (*subchannel_iterator)->get_BR_product()
                    << " => sigma * sQCD BR = "
                    << subchannel_cross_section_times_acceptance
                    << " (needs to be > " << subchannel_threshold_cross_section
                    << " to proceed)";
                    std::cout << std::endl;

                  }**/

                if( subchannel_threshold_cross_section
                    < subchannel_cross_section_times_acceptance )
                  // if it's still worth carrying on with the channel's
                  // cascades...
                  {

                    // we add these configurations to the channel acceptance:
                    *signal_value += subchannel_cross_section_times_acceptance;
                    channel_cross_section_times_acceptance
                    += subchannel_cross_section_times_acceptance;

                    // debugging:
                    /*std::cout
                    << std::endl
                    << "total subchannel sigma * BR = "
                    << subchannel_cross_section_times_acceptance;
                    std::cout << std::endl;*/

                  }  // end of if the subchannel's sQCD-to-EWino cross-section
                     // is not negligible.

              } // end of loop over scoloreds_to_EWinos.

          }
        // end of if channel's cross-section is large enough to bother with.

        // debugging:
        std::cout
        << std::endl
        << "channel sigma = " << channel_cross_section_times_acceptance
        << std::endl
        << "total sigma * BR so far = " << *signal_value;
        std::cout << std::endl;

      } // end of loop over sQCD_to_EWinos.

    // currently, we do the uncertainty very roughly:
    *uncertainty_factor
    = ( *signal_value * signal_shortcut_pointer->get_uncertainty() );

    return true;

  }

}  // end of LHC_FASER namespace.
