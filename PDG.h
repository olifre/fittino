// defines for PDG codes (6 quarks,
//                        3 charged leptons,
//                        3 light neutrinos,
//                        4 gauge bosons,
//                        4 EWSB scalars,
//                        1 graviton,
//                        12 squarks,
//                        6 sleptons,
//                        6 sneutrinos,
//                        1 gluino,
//                        4 neutralinos,
//                        2 charginos,
//                        1 gravitino):


#define PDG_down_CODE                       1
#define PDG_up_CODE                         2
#define PDG_strange_CODE                    3
#define PDG_charm_CODE                      4
#define PDG_bottom_CODE                     5
#define PDG_top_CODE                        6
#define PDG_electron_CODE                  11
#define PDG_electron_neutrino_CODE         12
#define PDG_muon_CODE                      13
#define PDG_muon_neutrino_CODE             14
#define PDG_tau_lepton_CODE                15
#define PDG_tau_neutrino_CODE              16
#define PDG_gluon_CODE                     21
#define PDG_photon_CODE                    22
#define PDG_Z_CODE                         23
#define PDG_W_plus_CODE                    24
#define PDG_light_neutral_EWSB_scalar_CODE 25
#define PDG_heavy_neutral_EWSB_scalar_CODE 35
#define PDG_neutral_EWSB_pseudoscalar_CODE 36
#define PDG_charged_EWSB_scalar_CODE       37
#define PDG_graviton_CODE                  39
#define PDG_sdown_L_CODE              1000001
#define PDG_sup_L_CODE                1000002
#define PDG_sstrange_L_CODE           1000003
#define PDG_scharm_L_CODE             1000004
#define PDG_sbottom_one_CODE          1000005
#define PDG_stop_one_CODE             1000006
#define PDG_selectron_L_CODE          1000011
#define PDG_electron_sneutrino_L_CODE 1000012
#define PDG_smuon_L_CODE              1000013
#define PDG_muon_sneutrino_L_CODE     1000014
#define PDG_stau_one_CODE             1000015
#define PDG_tau_sneutrino_L_CODE      1000016
#define PDG_gluino_CODE               1000021
#define PDG_neutralino_one_CODE       1000022
#define PDG_neutralino_two_CODE       1000023
#define PDG_chargino_one_CODE         1000024
#define PDG_neutralino_three_CODE     1000025
#define PDG_neutralino_four_CODE      1000035
#define PDG_chargino_two_CODE         1000037
#define PDG_gravitino_CODE            1000039
#define PDG_sdown_R_CODE              2000001
#define PDG_sup_R_CODE                2000002
#define PDG_sstrange_R_CODE           2000003
#define PDG_scharm_R_CODE             2000004
#define PDG_sbottom_two_CODE          2000005
#define PDG_stop_two_CODE             2000006
#define PDG_selectron_R_CODE          2000011
#define PDG_electron_sneutrino_R_CODE 2000012
#define PDG_smuon_R_CODE              2000013
#define PDG_muon_sneutrino_R_CODE     2000014
#define PDG_stau_two_CODE             2000015
#define PDG_tau_sneutrino_R_CODE      2000016

// all these masses are in GeV and taken from the PDG on 2009-11-08.
#define PDG_down_MASS              0.00504
#define PDG_up_MASS                0.00255
#define PDG_strange_MASS           0.105
#define PDG_charm_MASS             1.27
#define PDG_bottom_MASS            4.20
#define PDG_top_MASS             171.3
#define PDG_electron_MASS          0.000510998910
#define PDG_electron_neutrino_MASS 0.0
#define PDG_muon_MASS              0.105658367
#define PDG_muon_neutrino_MASS     0.0
#define PDG_tau_lepton_MASS        1.77684
#define PDG_tau_neutrino_MASS      0.0
#define PDG_gluon_MASS             0.0
#define PDG_photon_MASS            0.0
#define PDG_Z_MASS                91.1876
#define PDG_W_plus_MASS           80.398

// N.B. there are some hard-coded decay widths and branching ratios, but not all, in the BOL_EW_scale_SM_spectrum constructor
// (and thus also in the BOL_EW_scale_MSSM_constructor) to do with the W & Z bosons.  all its decays were taken from the PDG on 2009-11-08.
#define PDG_Z_DECAY_WIDTH                       2.4952
#define PDG_Z_electron_antielectron_BR          0.03363
#define PDG_Z_muon_antimuon_BR                  0.03363
#define PDG_Z_tau_lepton_antilepton_BR          0.03370
#define PDG_Z_invisible_BR                      0.20
#define PDG_Z_electron_neutrino_antineutrino_BR ( PDG_Z_invisible_BR / 3.0 )  // this code assumes that the invisible decays
#define PDG_Z_muon_neutrino_antineutrino_BR     ( PDG_Z_invisible_BR / 3.0 )  // of Z bosons are equally divided between 
#define PDG_Z_tau_neutrino_antineutrino_BR      ( PDG_Z_invisible_BR / 3.0 )  // the 3 flavors of neutrino.
#define PDG_Z_charm_anticharm_BR                0.1203
#define PDG_Z_bottom_antibottom_BR              0.1512
#define PDG_Z_down_antidown_BR                  ( ( 0.6991 - 0.1203 - 0.1512 ) / 3.0 )  // this code assumes that the rest of the 
#define PDG_Z_up_antiup_BR                      ( ( 0.6991 - 0.1203 - 0.1512 ) / 3.0 )  // hadronic decay width of the Z boson is
#define PDG_Z_strange_antistrange_BR            ( ( 0.6991 - 0.1203 - 0.1512 ) / 3.0 )  // equally divided between down, up and strange
#define PDG_W_plus_DECAY_WIDTH                  2.141
#define PDG_W_plus_neutrino_antielectron_BR     0.1075
#define PDG_W_plus_neutrino_antimuon_BR         0.1057
#define PDG_W_plus_neutrino_tau_antilepton_BR   0.1125
// this code assumes that the BRs of the W^+ into charm + antidown & charm + antistrange account for all the BR of the charm + X,
// in the ratio ( |V_cd|^2 ) to ( |V_cs|^2 ):
#define PDG_W_plus_charm_antidown_BR            ( ( ( 0.23 * 0.23 ) / ( ( 1.04 * 1.04 ) + ( 0.23 * 0.23 ) ) ) * 0.334 )
#define PDG_W_plus_charm_antistrange_BR         ( ( ( 1.04 * 1.04 ) / ( ( 1.04 * 1.04 ) + ( 0.23 * 0.23 ) ) ) * 0.334 )
// this code assumes that the rest of the hadronic decay width of the W is divided between up + antidown and up + antistrange
// in the ratio ( |V_ud|^2 ) to ( |V_us|^2 ):
#define PDG_W_plus_up_antidown_BR     ( ( ( 0.97418 * 0.97418 ) / ( ( 0.97418 * 0.97418 ) + ( 0.2255 * 0.2255 ) ) ) * ( 0.6760 - 0.334 ) )
#define PDG_W_plus_up_antistrange_BR    ( ( ( 0.2255 * 0.2255 ) / ( ( 0.97418 * 0.97418 ) + ( 0.2255 * 0.2255 ) ) ) * ( 0.6760 - 0.334 ) )

// currently tau leptons are treated as stable by the constructor, but if they are to be implemented, these defines should be used.
// all these values were taken from the PDG on 2009-11-10.
#define PDG_tau_lepton_neutrinos_electron_BR      0.1785
#define PDG_tau_lepton_neutrinos_muon_BR          0.1736
// this code assumes that the rest of the decay width of the tau lepton is divided between down + antiup and strange + antiup in the 
// ratio ( |V_ud|^2 ) to ( |V_us|^2 ) as in the case of the decays of the W^+:
#define PDG_tau_lepton_neutrino_down_antiup_BR ( ( ( 0.97418 * 0.97418 ) / ( ( 0.97418 * 0.97418 ) + ( 0.2255 * 0.2255 ) ) ) * ( 1.0 - 0.1736 - 0.1785 ) )
#define PDG_tau_lepton_neutrino_strange_antiup_BR ( ( ( 0.2255 * 0.2255 ) / ( ( 0.97418 * 0.97418 ) + ( 0.2255 * 0.2255 ) ) ) * ( 1.0 - 0.1736 - 0.1785 ) )
