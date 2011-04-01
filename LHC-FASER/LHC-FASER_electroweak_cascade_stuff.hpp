/*
 * LHC-FASER_cascades_stuff.hpp
 *
 *  Created on: 17 Dec 2010
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

#ifndef LHC_FASER_ELECTROWEAK_CASCADE_STUFF_HPP_
#define LHC_FASER_ELECTROWEAK_CASCADE_STUFF_HPP_

#include "LHC-FASER_kinematics_stuff.hpp"
#include "LHC-FASER_lepton_distributions.hpp"

namespace LHC_FASER
{

  /* this is an abstract base class for objects that calculate a set of
   * acceptances & update their respective values.
   */
  class channel_calculator
  {

  public:

    channel_calculator( double const given_primary_cut,
                        double const given_secondary_cut,
                        double const given_jet_cut,
                        lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                        bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                        bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                        input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    virtual
    ~channel_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    void
    update_numbers()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    bool not_already_calculated;

    double const primary_cut;
    double const secondary_cut;
    double const jet_cut;
    lepton_acceptance_value* const kinematics;
    CppSLHA::particle_property_set const* const decaying_scolored;
    bool const scolored_is_not_antiparticle;
    CppSLHA::particle_property_set const* const decaying_EWino;
    bool const EWino_is_not_antiparticle;
    CppSLHA::particle_property_set const* const mediating_particle;
    input_handler const* const shortcut;
    lepton_energy_distribution* current_distribution;

    /* this controls how fine the summation of the trapezia is for the
     * approximation of the integral of the product of the lepton energy
     * distribution with the acceptance:
     */
    static int const integration_bins = 10;

    virtual void
    calculate()
    = 0
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    integrate_acceptance( double const given_cut,
                  lepton_energy_distribution const* const lepton_distribution )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  /* this is a derived class that implements the channel where the
   * "decaying neutralino" is actually the lightest neutralino & hence assumed
   * to be stable
   */
  class lightest_neutralino : public channel_calculator
  {

  public:

    lightest_neutralino( double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~lightest_neutralino()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const no_jets_no_leptons;

    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  /* this is a derived class that implements the channel
   * decaying neutralino -> smuon or selectron -> lightest neutralino.
   * it also includes ... -> antismuon or antiselectron -> ... assuming that
   * the charge-conjugate process is identical for these purposes. it does
   * *not*, however, account for both chiralities of sfermion.
   */
  class charge_summed_neutralino_to_semu : public channel_calculator
  {

  public:

    charge_summed_neutralino_to_semu( double const given_primary_cut,
                                      double const given_secondary_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                    bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                                    input_handler const* const given_shortcuts,
                                   double* const given_OSSF_minus_OSDF_leptons,
                                      double* const given_no_jets_two_leptons,
                                      double* const given_no_jets_one_lepton,
                                      double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~charge_summed_neutralino_to_semu()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const OSSF_minus_OSDF_leptons;
    double* const no_jets_two_leptons;

    double* const no_jets_one_lepton;

    double* const no_jets_no_leptons;

    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  /* this is a derived class that implements the channel
   * decaying neutralino -> stau -> lightest neutralino.
   * it also includes ... -> antistau -> ... assuming that
   * the charge-conjugate process is identical for these purposes. it does
   * *not*, however, account for both chiralities of sfermion.
   */
  class charge_summed_neutralino_to_stau : public channel_calculator
  {

  public:

    charge_summed_neutralino_to_stau( double const given_primary_cut,
                                      double const given_secondary_cut,
                                      double const given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                    bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                                    input_handler const* const given_shortcuts,
                                      double* const given_two_jets_no_leptons,
                                      double* const given_one_jet_one_muon,
                                      double* const given_one_jet_one_electron,
                                      double* const given_no_jets_two_muons,
                                     double* const given_no_jets_two_electrons,
                             double* const given_no_jets_one_muon_one_electron,
                                      double* const given_one_jet_no_leptons,
                                      double* const given_no_jets_one_muon,
                                      double* const given_no_jets_one_electron,
                                      double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~charge_summed_neutralino_to_stau()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;
    double* const one_jet_one_muon;
    double* const one_jet_one_electron;
    double* const no_jets_two_muons;
    double* const no_jets_two_electrons;
    double* const no_jets_one_muon_one_electron;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying neutralino -> Z -> lightest neutralino
  class charge_summed_neutralino_to_Z : public channel_calculator
  {

  public:

    charge_summed_neutralino_to_Z( double const given_primary_cut,
                                   double const given_secondary_cut,
                                   double const given_jet_cut,
                            lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                    bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                                   input_handler const* const given_shortcuts,
                                   double* const given_two_jets_no_leptons,
                                   double* const given_one_jet_one_muon,
                                   double* const given_one_jet_one_electron,
                                   double* const given_OSSF_minus_OSDF_leptons,
                                   double* const given_no_jets_two_muons,
                                   double* const given_no_jets_two_electrons,
                             double* const given_no_jets_one_muon_one_electron,
                                   double* const given_one_jet_no_leptons,
                                   double* const given_no_jets_one_muon,
                                   double* const given_no_jets_one_electron,
                                   double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~charge_summed_neutralino_to_Z()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;
    double* const one_jet_one_muon;
    double* const one_jet_one_electron;
    double* const OSSF_minus_OSDF_leptons;
    double* const no_jets_two_muons;
    double* const no_jets_two_electrons;
    double* const no_jets_one_muon_one_electron;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying neutralino -> neutral EWSB scalar -> lightest neutralino
  class neutralino_to_Higgs : public channel_calculator
  {

  public:

    neutralino_to_Higgs( double const given_primary_cut,
                         double const given_secondary_cut,
                         double const given_jet_cut,
                         lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                         bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                         bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                         input_handler const* const given_shortcuts,
                         double* const given_two_jets_no_leptons,
                         double* const given_one_jet_one_negative_muon,
                         double* const given_one_jet_one_negative_electron,
                         double* const given_one_jet_one_positive_muon,
                         double* const given_one_jet_one_positive_electron,
                         double* const given_OSSF_minus_OSDF_leptons,
                         double* const given_no_jets_two_muons,
                         double* const given_no_jets_two_electrons,
           double* const given_no_jets_one_negative_muon_one_positive_electron,
           double* const given_no_jets_one_positive_muon_one_negative_electron,
                         double* const given_one_jet_no_leptons,
                         double* const given_no_jets_one_negative_muon,
                         double* const given_no_jets_one_negative_electron,
                         double* const given_no_jets_one_positive_muon,
                         double* const given_no_jets_one_positive_electron,
                         double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~neutralino_to_Higgs()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;
    double* const one_jet_one_negative_muon;
    double* const one_jet_one_negative_electron;
    double* const one_jet_one_positive_muon;
    double* const one_jet_one_positive_electron;
    double* const OSSF_minus_OSDF_leptons;
    double* const no_jets_two_muons;
    double* const no_jets_two_electrons;
    double* const no_jets_one_negative_muon_one_positive_electron;
    double* const no_jets_one_positive_muon_one_negative_electron;

    double* const one_jet_no_leptons;
    double* const no_jets_one_negative_muon;
    double* const no_jets_one_negative_electron;
    double* const no_jets_one_positive_muon;
    double* const no_jets_one_positive_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying neutralino -> lightest neutralino via a 3-body decay.
  class charge_summed_neutralino_three_body : public channel_calculator
  {

  public:

    charge_summed_neutralino_three_body( double const given_primary_cut,
                                         double const given_secondary_cut,
                                         double const given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                    bool const given_EWino_is_not_antiparticle,
                                    input_handler const* const given_shortcuts,
                                       double* const given_two_jets_no_leptons,
                                         double* const given_one_jet_one_muon,
                                      double* const given_one_jet_one_electron,
                                   double* const given_OSSF_minus_OSDF_leptons,
                                         double* const given_no_jets_two_muons,
                                     double* const given_no_jets_two_electrons,
                             double* const given_no_jets_one_muon_one_electron,
                                        double* const given_one_jet_no_leptons,
                                         double* const given_no_jets_one_muon,
                                      double* const given_no_jets_one_electron,
                                     double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~charge_summed_neutralino_three_body()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;
    double* const one_jet_one_muon;
    double* const one_jet_one_electron;
    double* const OSSF_minus_OSDF_leptons;
    double* const no_jets_two_muons;
    double* const no_jets_two_electrons;
    double* const no_jets_one_muon_one_electron;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> smuon or selectron -> lightest neutralino
  class chargino_to_semu : public channel_calculator
  {

  public:

    chargino_to_semu( double const given_primary_cut,
                      double const given_secondary_cut,
                      lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                      bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                      bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                      input_handler const* const given_shortcuts,
                      double* const given_no_jets_one_lepton,
                      double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_semu()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const no_jets_one_lepton;

    double* const no_jets_no_leptons;

    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> stau -> lightest neutralino
  class chargino_to_stau : public channel_calculator
  {

  public:

    chargino_to_stau( double const given_primary_cut,
                      double const given_secondary_cut,
                      double const given_jet_cut,
                      lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                      bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                      bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                      input_handler const* const given_shortcuts,
                      double* const given_one_jet_no_leptons,
                      double* const given_no_jets_one_muon,
                      double* const given_no_jets_one_electron,
                      double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_stau()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> muon or electron sneutrino -> lightest neutralino
  class chargino_to_emu_sneutrino : public channel_calculator
  {

  public:

    chargino_to_emu_sneutrino( double const given_primary_cut,
                               double const given_secondary_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                               bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                               bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                               input_handler const* const given_shortcuts,
                               double* const given_no_jets_one_lepton,
                               double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_emu_sneutrino()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const no_jets_one_lepton;

    double* const no_jets_no_leptons;

    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> tau sneutrino -> lightest neutralino
  class chargino_to_tau_sneutrino : public channel_calculator
  {

  public:

    chargino_to_tau_sneutrino( double const given_primary_cut,
                               double const given_secondary_cut,
                               double const given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                               bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                               bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                               input_handler const* const given_shortcuts,
                               double* const given_one_jet_no_leptons,
                               double* const given_no_jets_one_muon,
                               double* const given_no_jets_one_electron,
                               double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_tau_sneutrino()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> W -> lightest neutralino
  class chargino_to_W : public channel_calculator
  {

  public:

    chargino_to_W( double const given_primary_cut,
                   double const given_secondary_cut,
                   double const given_jet_cut,
                   lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                   bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                   bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                   input_handler const* const given_shortcuts,
                   double* const given_two_jets_no_leptons,
                   double* const given_one_jet_no_leptons,
                   double* const given_no_jets_one_muon,
                   double* const given_no_jets_one_electron,
                   double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_W()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> charged EWSB scalar -> lightest neutralino
  class chargino_to_Higgs : public channel_calculator
  {

  public:

    chargino_to_Higgs( double const given_primary_cut,
                       double const given_secondary_cut,
                       double const given_jet_cut,
                       lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                       bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                       bool const given_EWino_is_not_antiparticle,
          CppSLHA::particle_property_set const* const given_mediating_particle,
                       input_handler const* const given_shortcuts,
                       double* const given_two_jets_no_leptons,
                       double* const given_one_jet_no_leptons,
                       double* const given_no_jets_one_muon,
                       double* const given_no_jets_one_electron,
                       double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_to_Higgs()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };

  // this is a derived class that implements the channel
  // decaying chargino -> lightest neutralino via a 3-body decay.
  class chargino_three_body : public channel_calculator
  {

  public:

    chargino_three_body( double const given_primary_cut,
                         double const given_secondary_cut,
                         double const given_jet_cut,
                         lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                         bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                         bool const given_EWino_is_not_antiparticle,
                         input_handler const* const given_shortcuts,
                         double* const given_two_jets_no_leptons,
                         double* const given_one_jet_no_leptons,
                         double* const given_no_jets_one_muon,
                         double* const given_no_jets_one_electron,
                         double* const given_no_jets_no_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~chargino_three_body()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    double* const two_jets_no_leptons;

    double* const one_jet_no_leptons;
    double* const no_jets_one_muon;
    double* const no_jets_one_electron;

    double* const no_jets_no_leptons;


    void
    calculate()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  };


  // this holds pointers to all the channel_calculator instances associated
  // with a particular cascade acceptance value as well as the value itself.
  class cascade_acceptance_value
  {

  public:

    cascade_acceptance_value( double const given_starting_value )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~cascade_acceptance_value()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    double
    get_value()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double* const
    get_value_pointer()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    void
    add_channel( channel_calculator* given_channel )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    double acceptance_value;
    bool not_already_calculated;

    std::vector< channel_calculator* > channels;

  };


  /* this sets up all the open channel_calculators & registers them with their
   * appropriate cascade_acceptance_values, uses the cascade_acceptance_values
   * to return values for various acceptances.
   * this does not keep track of different charges of lepton separately. I
   * intend to write another class to do that some day, when a relevant signal
   * needs it.
   */
  class charge_summed_cascade_calculator
  {

  public:

    charge_summed_cascade_calculator( double const given_primary_cut,
                                      double const given_secondary_cut,
                                      double const given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                    bool const given_EWino_is_not_antiparticle,
                                   input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~charge_summed_cascade_calculator()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    bool
    is_requested( double const given_primary_cut,
                  double const given_secondary_cut,
                  double const given_jet_cut,
                  lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                  bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                  bool const given_EWino_is_not_antiparticle )
    /* this returns true if the relevant cuts, the kinematics, & the sparticles
     * match those held. relevant cuts are those over 0.0, any cuts of 0.0 or
     * less are assumed to be irrelevant to the signal requesting these values,
     * so this calculator can be given to the signal.
     */
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_OSSF_minus_OSDF_acceptance()
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_acceptance( int const number_of_jets,
                    int const number_of_leptons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_muon_acceptance( int const number_of_jets,
                         int const number_of_muons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    double
    get_electron_acceptance( int const number_of_jets,
                             int const number_of_electrons )
    /* code after the classes in this .hpp file, or in the .cpp file. */;


  protected:

    std::vector< channel_calculator* > channels;

    cascade_acceptance_value OSSF_minus_OSDF_leptons;
    cascade_acceptance_value two_jets_no_leptons;
    cascade_acceptance_value one_jet_one_muon;
    cascade_acceptance_value one_jet_one_electron;
    cascade_acceptance_value no_jets_two_muons;
    cascade_acceptance_value no_jets_two_electrons;
    cascade_acceptance_value no_jets_one_muon_one_electron;

    cascade_acceptance_value one_jet_no_leptons;
    cascade_acceptance_value no_jets_one_muon;
    cascade_acceptance_value no_jets_one_electron;

    cascade_acceptance_value no_jets_no_leptons;

    // this stuff needs to be stored to identify the
    // charge_summed_cascade_calculator
    double const primary_cut;
    double const secondary_cut;
    double const jet_cut;
    lepton_acceptance_value* const kinematics;
    CppSLHA::particle_property_set const* const decaying_scolored;
    bool const scolored_is_not_antiparticle;
    CppSLHA::particle_property_set const* const decaying_EWino;
    bool const EWino_is_not_antiparticle;

  };


  // this class passes out pointers to cascade_calculators for given
  // kinematics & decaying sparticles.
  class cascade_handler : public interface_readied_for_new_point
  {

  public:

    cascade_handler( input_handler const* const given_shortcuts )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

    ~cascade_handler()
    /* code after the classes in this .hpp file, or in the .cpp file. */;


    charge_summed_cascade_calculator*
    get_charge_summed_calculator( double given_primary_cut,
                                  double given_secondary_cut,
                                  double given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
                 CppSLHA::particle_property_set const* const decaying_scolored,
                                  bool const scolored_is_not_antiparticle,
                    CppSLHA::particle_property_set const* const decaying_EWino,
                                  bool const EWino_is_not_antiparticle )
    /* code after the classes in this .hpp file, or in the .cpp file. */;

  protected:

    input_handler const* const shortcut;

    std::vector< charge_summed_cascade_calculator* > calculators;

  };





  // inline functions:


  inline void
  channel_calculator::update_numbers()
  {

    // debugging:
    /**std::cout
    << std::endl
    << "debugging: channel_calculator::update_numbers() called."
    << std::endl << "this = " << this
    << std::endl << "not_already_calculated = " << not_already_calculated;
    std::cout << std::endl;**/

    if( not_already_calculated )
      {

        calculate();
        not_already_calculated = false;

      }

  }



  inline void
  lightest_neutralino::calculate()
  {

    // debugging:
    /**std::cout
    << std::endl
    << "lightest_neutralino::calculate() called. before adding,"
    << " *no_jets_no_leptons = " << *no_jets_no_leptons;
    std::cout << std::endl;**/

    *no_jets_no_leptons += 1.0;

    // debugging:
    /**std::cout
    << std::endl
    << "after adding, *no_jets_no_leptons = " << *no_jets_no_leptons;
    std::cout << std::endl;**/

  }



  inline double
  cascade_acceptance_value::get_value()
  {

    if( not_already_calculated )
      {

        for( std::vector< channel_calculator* >::iterator
             channel_iterator = channels.begin();
             channels.end() > channel_iterator;
             ++channel_iterator )
          {

            // debugging:
            /**std::cout
            << std::endl
            << "debugging: " << *channel_iterator << "->update_numbers()";
            std::cout << std::endl;**/

            (*channel_iterator)->update_numbers();

          }

        not_already_calculated = false;

      }

    return acceptance_value;

  }

  inline double* const
  cascade_acceptance_value::get_value_pointer()
  {

    return &acceptance_value;

  }

  inline void
  cascade_acceptance_value::add_channel( channel_calculator* given_channel )
  {

    channels.push_back( given_channel );

  }



  inline bool
  charge_summed_cascade_calculator::is_requested( double given_primary_cut,
                                                  double given_secondary_cut,
                                                  double given_jet_cut,
                               lepton_acceptance_value* const given_kinematics,
           CppSLHA::particle_property_set const* const given_decaying_scolored,
                                 bool const given_scolored_is_not_antiparticle,
              CppSLHA::particle_property_set const* const given_decaying_EWino,
                                   bool const given_EWino_is_not_antiparticle )
  /* this returns true if the relevant cuts, the kinematics, & the sparticles
   * match those held. relevant cuts are those over 0.0, any cuts of 0.0 or
   * less are assumed to be irrelevant to the signal requesting these values,
   * so this calculator can be given to the signal.
   */
  {

    if( ( ( given_primary_cut == primary_cut )
          ||
          ( given_primary_cut <= 0.0 ) )
        &&
        ( ( given_secondary_cut == secondary_cut )
          ||
          ( given_secondary_cut <= 0.0 ) )
        &&
        ( ( given_jet_cut == jet_cut )
          ||
          ( given_jet_cut <= 0.0 ) )
        &&
        ( given_kinematics == kinematics )
        &&
        ( given_decaying_scolored == decaying_scolored )
        &&
        ( given_scolored_is_not_antiparticle == scolored_is_not_antiparticle )
        &&
        ( given_decaying_EWino == decaying_EWino )
        &&
        ( given_EWino_is_not_antiparticle == EWino_is_not_antiparticle ) )
      {

        return true;

      }
    else
      {

        return false;

      }

  }


  inline double
  charge_summed_cascade_calculator::get_OSSF_minus_OSDF_acceptance()
  {

    return OSSF_minus_OSDF_leptons.get_value();

  }

}

#endif /* LHC_FASER_ELECTROWEAK_CASCADE_STUFF_HPP_ */
