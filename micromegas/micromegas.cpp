#include <iostream>
#include <string>

#include "micromegas.h"
#include "pmodel.h"

int main(int argc, char** argv)
{
  if (argc != 3) {
    std::cerr << "usage: micromegas <Les Houches file> <Les Houches output file to append to>" << std::endl;
    return 1;
  }

  char* slhafilename = new char[strlen(argv[1])];
  strcpy(slhafilename, argv[1]);

  char* outfilename = new char[strlen(argv[2])];
  strcpy(outfilename, argv[2]);

  std::cout << "micromegas: reading Les Houches file " << slhafilename << std::endl;
  std::cout << "            append micromegas block to file " << outfilename << std::endl;

  int readSMPar = 1;
  int err = readLesH(slhafilename, readSMPar);
  if (err < 0) {
    std::cerr << "micromegas failed to open Les Houches file" << std::endl;
    return err;
  }

  char lspName[128];
  err = sortOddParticles(lspName);
  if (err) {
    std::cerr << "micromegas cannot calculate relic density for " << lspName << " LSPs" << std::endl;
    return err;
  }

  double Xf;
  int fast = 1;
  double Beps = 1e-6;
  double omegah2 = darkOmega(&Xf, fast, Beps);
  if (omegah2 < 0) {
    std::cerr << "Problem with DM relic density calculation" << std::endl;
    return 1;
  }

  std::cout << "omega h^2 = " << omegah2 << std::endl;

  char command[128];
  sprintf(command, "echo 'Block MicrOMEGAs # MicrOMEGAs observables' >> %s\n",
	  outfilename);
  system(command);

  sprintf(command, "echo '    1    %.8E   # Omega h^2' >> %s\n", omegah2,
	  outfilename);
  system(command);

  return 0;
}
