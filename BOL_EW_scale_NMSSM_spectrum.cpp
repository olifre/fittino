#include "BOL_EW_scale_NMSSM_spectrum.h"

BOL_EW_scale_NMSSM_spectrum::BOL_EW_scale_NMSSM_spectrum() : BOL_EW_scale_MSSM_spectrum()  // constructor: this constructs a BOL_EW_scale_MSSM_spectrum
							// & then adds the extra particles.
{

  // these PDG MC codes ARE NOT OFFICIAL.  they are here for demonstrative purposes only.
#define PDG_singlet_scalar_CODE 45
#define PDG_singlet_pseudoscalar_CODE 46
#define PDG_neutralino_five_CODE 1000045

  std::string name_enterer;

  // add an extra EWSB scalar.  note that if the scalar sector has a state that is mainly singlet, it is unlikely to be intermediate
  // in mass to the states that are mainly not singlet, but all that matters is that now there need to be 3 scalar bosons, & 2 have
  // already had property sets allocated to them, so another needs to be allocated.  the actual proportions of flavor eigenstates can
  // be implemented by adding mixing matrices to property sets, but that is not yet implemented.
  name_enterer = "middle_scalar_Higgs_boson";
  this->add_particle_property_set( PDG_singlet_scalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // add an extra EWSB pseudoscalar.  see above for comment on the irrelevance of flavor eigenstates.
  name_enterer = "light_pseudoscalar_Higgs_boson";
  this->add_particle_property_set( PDG_singlet_pseudoscalar_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.

  // rename the MSSM EWSB pseudoscalar.
  name_enterer = "heavy_pseudoscalar_Higgs_boson";
  this->get_particle_property_set( PDG_neutral_EWSB_pseudoscalar_CODE )->set_name( name_enterer );

  // add a fifth neutralino (since with the addition of the singlino the neutralino sector has 5 neutralinos).  see above for comment
  // on the irrelevance of flavor eigenstates.
  name_enterer = "neutralino_5";
  this->add_particle_property_set( PDG_neutralino_five_CODE,
				   name_enterer,
				   false,  // does not count as stable-&-invisible.
				   false,  // does not count as a jet.
				   false,  // does not count as a light lepton.
				   true );  // does count as self-conjugate.
  // no known mass as yet.


}




