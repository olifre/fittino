#include "yy.h"

//Filenames of cross section grids
//LO grids mstw08
#define filename_gg_grid yyGridPath+"/xgrid/mstw2008/gg.dat"
#define filename_sg_grid yyGridPath+"/xgrid/mstw2008/sg.dat"
#define filename_ss_grid yyGridPath+"/xgrid/mstw2008/ss.dat"
#define filename_sd_grid yyGridPath+"/xgrid/mstw2008/sd.dat"
#define filename_stop_grid yyGridPath+"/xgrid/mstw2008/stop.dat"

//NLO K factors
#define filename_gg_K_factors yyGridPath+"/xgrid/mstw2008/NLO/gg_NLO.dat"
#define filename_sg_K_factors yyGridPath+"/xgrid/mstw2008/NLO/sg_NLO.dat"
#define filename_ss_K_factors yyGridPath+"/xgrid/mstw2008/NLO/ss_NLO.dat"
#define filename_sb_K_factors yyGridPath+"/xgrid/mstw2008/NLO/sb_NLO.dat"
#define filename_stop_K_factors yyGridPath+"/xgrid/mstw2008/NLO/stop_NLO.dat"

//Filenames of acceptance grids
#define filename_gg_AC_grid yyGridPath+"/ACgrids/TwoJetsMissingET/gg_accept.dat"
#define filename_sg_AC_grid yyGridPath+"/ACgrids/TwoJetsMissingET/sg_accept.dat"
#define filename_ss_AC_grid yyGridPath+"/ACgrids/TwoJetsMissingET/ss_accept.dat"

//Filenames & parameters of lepton acceptance grids
#define filename_gg_lepton_grid yyGridPath+"/Lgrids/ossf/gg_lepton_accept.dat"
#define filename_ss_lepton_grid yyGridPath+"/Lgrids/ossf/ss_lepton_accept.dat"
#define e_distribution_bins 40
#define e_distribution_bin_width 2

//dimension of the cross-section grid. may be changed.
#define set1_X_first 200
#define set1_X_last 2000
#define set1_X_density 10
#define set1_X_array_size (set1_X_last-set1_X_first)/set1_X_density + 1

//dimension of the lepton acceptance grid. may be changed.
#define set2_X_first 200
#define set2_X_last 2000
#define set2_X_density 50
#define set2_X_array_size (set2_X_last-set2_X_first)/set2_X_density + 1
#define size_of_array 100

//dimension of the acceptance grids. may be changed.
#define AC_first   0
#define AC_first_colored   200
#define AC_last 2000
#define AC_density 50
#define AC_array_size (AC_last-AC_first)/AC_density + 1
