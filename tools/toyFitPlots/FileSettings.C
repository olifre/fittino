//
// @file    FileSettings.C
//
// @author  Mathias Uhlenbrock

#include "FileSettings.h"

void FileSettings()
{
   file = TFile::Open(inputFile, "READ");

   if (file)
   {
      tree = (TTree*)file->Get(treeName);
      tree->SetBranchAddress("chi2",             &leaf[0]);
      tree->SetBranchAddress("O_Bsg_npf",        &leaf[1]);
      tree->SetBranchAddress("O_dm_s_npf",       &leaf[2]);
      tree->SetBranchAddress("O_Btn_npf",        &leaf[3]);
      tree->SetBranchAddress("O_omega",          &leaf[4]);
      tree->SetBranchAddress("O_gmin2m_npf",     &leaf[5]);
      tree->SetBranchAddress("O_Massh0_npf",     &leaf[6]);
      tree->SetBranchAddress("O_MassW_npf",      &leaf[7]);
      tree->SetBranchAddress("O_sin_th_eff_npf", &leaf[8]);
      tree->SetBranchAddress("O_B_smm_npf",      &leaf[9]);
      tree->SetBranchAddress("P_A0",             &leaf[10]);
      tree->SetBranchAddress("P_M0",             &leaf[11]);
      tree->SetBranchAddress("P_M12",            &leaf[12]);
      tree->SetBranchAddress("P_TanBeta",        &leaf[13]);
      tree->SetBranchAddress("O_massTop",        &leaf[14]);
      if (model == "NUHM1")
      {
         tree->SetBranchAddress("P_M0H", &leaf[15]);
      }
      else if (model == "NUHM2")
      {
         tree->SetBranchAddress("P_M0Hu", &leaf[15]);
         tree->SetBranchAddress("P_M0Hd", &leaf[16]);
      }
   }
}
