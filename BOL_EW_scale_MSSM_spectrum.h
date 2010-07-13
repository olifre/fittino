
#ifndef BOL_EW_SCALE_MSSM_SPECTRUM_H
#define BOL_EW_SCALE_MSSM_SPECTRUM_H



#include "BOL_EW_scale_SM_spectrum.h"

class BOL_EW_scale_MSSM_spectrum : public BOL_EW_scale_SM_spectrum
{

 public:

  BOL_EW_scale_MSSM_spectrum();  // constructor: this constructs a BOL_EW_scale_SM_spectrum & then adds the extra particles.

  BOL_particle_property_set* get_lighter_particle(BOL_particle_property_set::BOL_particle_property_set* compared_particle,
						  int comparison_PDG_code )
    // this compares the masses of 2 particles & returns a pointer to the lighter particle's property set.
    ;


  BOL_particle_property_set* update_stable_invisible()
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
    ;

};


#endif
