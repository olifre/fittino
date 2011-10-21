#include "BOL_EW_scale_NMSSM_spectrum.h"

BOL_EW_scale_MSSM_spectrum::BOL_EW_scale_MSSM_spectrum() : BOL_EW_scale_SM_spectrum()  // constructor: this constructs a BOL_EW_scale_SM_spectrum & then adds the extra particles.
{

  std::string name_enterer;

  // rename SM EWSB scalar.
  name_enterer = "light_neutral_scalar_Higgs_boson";
  this->get_particle_property_set( PDG_light_neutral_EWSB_scalar_CODE )->set_name( name_enterer );

  // add heavy neutral electroweak-symmetry-breaking scalar boson.
  name_enterer = "heavy_neutral_scalar_Higgs_boson";
  this->add_particle_property_set( PDG_heavy_neutral_EWSB_scalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add neutral electroweak-symmetry-breaking pseudoscalar boson.
  name_enterer = "neutral_pseudoscalar_Higgs_boson";
  this->add_particle_property_set( PDG_neutral_EWSB_pseudoscalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add charged electroweak-symmetry-breaking scalar boson.
  name_enterer = "charged_scalar_Higgs_boson";
  this->add_particle_property_set( PDG_charged_EWSB_scalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add down squark associated with left-handed quarks.
  name_enterer = "down_squark_L";
  this->add_particle_property_set( PDG_sdown_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add up squark associated with left-handed quarks.
  name_enterer = "up_squark_L";
  this->add_particle_property_set( PDG_sup_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add strange squark associated with left-handed quarks.
  name_enterer = "strange_squark_L";
  this->add_particle_property_set( PDG_sstrange_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add charm squark associated with left-handed quarks.
  name_enterer = "charm_squark_L";
  this->add_particle_property_set( PDG_scharm_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add heavier bottom squark.
  name_enterer = "bottom_squark_two";
  this->add_particle_property_set( PDG_sbottom_two_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add heavier top squark.
  name_enterer = "top_squark_two";
  this->add_particle_property_set( PDG_stop_two_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add selectron associated with left-handed electrons.
  name_enterer = "selectron_L";
  this->add_particle_property_set( PDG_selectron_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add electron sneutrino associated with left-handed electron neutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  // currently, this code treats neutrinos as Dirac fermions, so sneutrinos also have self_conjugate_flag = false.
  name_enterer = "electron_sneutrino_L";
  this->add_particle_property_set( PDG_electron_sneutrino_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add smuon associated with left-handed muons.
  name_enterer = "smuon_L";
  this->add_particle_property_set( PDG_smuon_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add muon sneutrino associated with left-handed muon neutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  // currently, this code treats neutrinos as Dirac fermions, so sneutrinos also have self_conjugate_flag = false.
  name_enterer = "muon_sneutrino_L";
  this->add_particle_property_set( PDG_muon_sneutrino_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add heavier tau slepton.
  name_enterer = "stau_two";
  this->add_particle_property_set( PDG_stau_two_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add tau sneutrino associated with left-handed tau sneutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  name_enterer = "tau_sneutrino_L";
  this->add_particle_property_set( PDG_tau_sneutrino_L_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add gluino.
  name_enterer = "gluino";
  this->add_particle_property_set( PDG_gluino_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add lightest neutralino.
  // this constructor assumes that the LSP is the lightest neutralino.
  name_enterer = "neutralino_1";
  this->add_particle_property_set( PDG_neutralino_one_CODE, name_enterer,
				   true,  // does count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add 2nd lightest neutralino.
  name_enterer = "neutralino_2";
  this->add_particle_property_set( PDG_neutralino_two_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add 2nd heaviest neutralino.
  name_enterer = "neutralino_3";
  this->add_particle_property_set( PDG_neutralino_three_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add heaviest neutralino.
  name_enterer = "neutralino_4";
  this->add_particle_property_set( PDG_neutralino_four_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add lighter chargino.
  name_enterer = "chargino_1";
  this->add_particle_property_set( PDG_chargino_one_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add heavier chargino.
  name_enterer = "chargino_2";
  this->add_particle_property_set( PDG_chargino_two_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add down squark associated with right-handed quarks.
  name_enterer = "down_squark_R";
  this->add_particle_property_set( PDG_sdown_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add up squark associated with right-handed quarks.
  name_enterer = "up_squark_R";
  this->add_particle_property_set( PDG_sup_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add strange squark associated with right-handed quarks.
  name_enterer = "strange_squark_R";
  this->add_particle_property_set( PDG_sstrange_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add charm squark associated with right-handed quarks.
  name_enterer = "charm_squark_R";
  this->add_particle_property_set( PDG_scharm_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add lighter bottom squark.
  name_enterer = "bottom_squark_one";
  this->add_particle_property_set( PDG_sbottom_one_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add lighter top squark.
  name_enterer = "top_squark_one";
  this->add_particle_property_set( PDG_stop_one_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add selectron associated with right-handed electrons.
  name_enterer = "selectron_R";
  this->add_particle_property_set( PDG_selectron_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add electron sneutrino associated with right-handed electron neutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  // currently, this code treats neutrinos as Dirac fermions, so sneutrinos also have self_conjugate_flag = false.
  name_enterer = "electron_sneutrino_R";
  this->add_particle_property_set( PDG_electron_sneutrino_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add smuon associated with right-handed muons.
  name_enterer = "smuon_R";
  this->add_particle_property_set( PDG_smuon_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add muon sneutrino associated with right-handed muon neutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  // currently, this code treats neutrinos as Dirac fermions, so sneutrinos also have self_conjugate_flag = false.
  name_enterer = "muon_sneutrino_R";
  this->add_particle_property_set( PDG_muon_sneutrino_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add lighter tau slepton.
  name_enterer = "stau_one";
  this->add_particle_property_set( PDG_stau_one_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

  // add tau sneutrino associated with right-handed tau sneutrinos.
  // this constructor assumes that the LSP is not a sneutrino.
  // currently, this code treats neutrinos as Dirac fermions, so sneutrinos also have self_conjugate_flag = false.
  name_enterer = "tau_sneutrino_R";
  this->add_particle_property_set( PDG_tau_sneutrino_R_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   false );  // does not count as self-conjugate.
  // no known mass as yet.

}


BOL_particle_property_set* BOL_EW_scale_MSSM_spectrum::get_lighter_particle(
									    BOL_particle_property_set* compared_particle,
									    int comparison_PDG_code )
// this compares the masses of 2 particles & returns a pointer to the lighter particle's property set.
{

  BOL_particle_property_set* assumed_lighter = compared_particle;

  double assumed_lighter_mass = assumed_lighter->get_mass();

  if( assumed_lighter_mass < 0.0 )  // if this particle has a negative mass (maybe because of neutralino mass matrix conventions)...
    {

      assumed_lighter_mass *= -1.0;  // take the absolute mass instead.

    }

  BOL_particle_property_set* assumed_heavier = this->get_particle_property_set( comparison_PDG_code );

  double assumed_heavier_mass = assumed_heavier->get_mass();

  if( assumed_heavier_mass < 0.0 )  // if this particle has a negative mass (maybe because of neutralino mass matrix conventions)...
    {

      assumed_heavier_mass *= -1.0;  // take the absolute mass instead.

    }


  if( assumed_lighter_mass > assumed_heavier_mass )  // if the guess as to which was lighter was wrong...
    {

      assumed_lighter = assumed_heavier;  // correct the pointer to the lighter particle.

    }

  return assumed_lighter;

}


BOL_particle_property_set* BOL_EW_scale_MSSM_spectrum::update_stable_invisible()
// this checks the sneutrinos & lightest neutralino for which is lightest, & returns that, while also setting its is_stable_invisible
// to true, if this returned sparticle has an empty decay list.  this *can* be used to identify if the LSP is cosmologically allowed,
// by running ->counts_as_stable_invisible() on the pointer which this method returns,
// e.g. if this->update_stable_invisible()->counts_as_stable_invisible() is false, then the lightest cosmologically-acceptable
// (in the sense of being neutral to the color & electromagnetism forces) dark matter candidate is unstable, & thus cannot be
// dark matter (because it decays, into something, which, assuming R-parity is conserved in all the recorded decays, is presumably
// an electromagnetically- and/or color-charged sparticle as well as SM particles).
// actually, there is a crazy fringe case where that won't work: if for example the lightest sneutrino is lighter than the neutralinos,
// but the LSP is actually stop_1, and the lightest sneutrino mass is less than the charm mass heavier the stop_1 mass, and whichever
// spectrum generator that worked out the branching ratios didn't catch the 5-body decay into a neutrino, stop_1, positron, another
// neutrino, and an up quark through a virtual top, or the 3-body decay through the sneutrino-electron-chargino lepton-flavor-violating
// vertex followed by the V_td-suppressed chargino-stop-down vertex.  honestly though, i don't think it's the job of this code to catch
// such psychotic cases.
// this could be more comprehensive.  i might sort it out later.
{

  // start by assuming that the lightest neutralino is lighter than all the sneutrinos.
  BOL_particle_property_set* assumed_LSP = this->get_particle_property_set( PDG_neutralino_one_CODE );

  // compare against each sneutrino, noting the lighter particle each time.
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_electron_sneutrino_L_CODE );
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_muon_sneutrino_L_CODE );
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_tau_sneutrino_L_CODE );
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_electron_sneutrino_R_CODE );
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_muon_sneutrino_R_CODE );
  assumed_LSP = this->get_lighter_particle( assumed_LSP,
					    PDG_tau_sneutrino_R_CODE );

  if( assumed_LSP->get_PDG_code() != PDG_neutralino_one_CODE )
    // if, after that, it turns out that the lightest neutralino is not the LSP...
    {

      this->get_particle_property_set( PDG_neutralino_one_CODE )->make_count_as_stable_invisible( false );
      // flag the lightest neutralino as no longer escaping the detector.

    }

  if( !(assumed_LSP->get_direct_decays()->empty()) )  // if this supposed LSP has a list of decays...
    {

      assumed_LSP->make_count_as_stable_invisible( false );  // flag it as no longer escaping the detector.

    }

  return assumed_LSP;

}




