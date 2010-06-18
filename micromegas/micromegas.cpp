#include <iostream>

#include "micromegas.h"
#include "pmodel.h"

int main(int argc, char** argv)
{
  

  int readSMPar = 1;
  int err = readLesH("SPheno-sps1aprime.spc", readSMPar);
  if (err < 0) {
    std::cerr << "Micromegas failed to open Les Houches file" << std::endl;
    return err;
  }

  std::cout << "M1 = " << findValW("MG1") << std::endl;

  char lspName[128];
  err = sortOddParticles(lspName);
  if (err) {
    std::cerr << "Micromegas cannot calculate relic density for " << lspName << " LSPs" << std::endl;
    return err;
  }

  double Xf;
  int fast = 1;
  double Beps = 1e-6;
  double omegah2 = darkOmega(&Xf, fast, Beps);
  if (omegah2 < 0) {
    std::cerr << "Problem with DM relic density calculation" << std::endl;
    return omegah2;
  }

  std::cout << "omega h2 = " << omegah2 << std::endl;

  return 0;
}
