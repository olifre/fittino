#include "TTree.h"
#include "TLeaf.h"
#include <limits>



/* void GetChain(){ */

  
/*   TChain* markovChain = new TChain("markovChain"); */
/*   TChain* metadata = new TChain("metadata"); */


/* } */


int GetMinimumIndex(TTree* tree, std::string columnname) {


  TLeaf* leaf = tree->GetLeaf(columnname.c_str());
  if (!leaf) {
    return 0;
  }

  int _nentries = tree->GetEntries();

  TBranch* branch = leaf->GetBranch();
  Double_t cmin = std::numeric_limits<float>::max();
  Long64_t index = 0;

  for (Long64_t i = 0; i < _nentries; ++i) {

    branch->GetEntry(i);
    for (Int_t j = 0;j < leaf->GetLen(); ++j) {
      Double_t val = leaf->GetValue(j);
      if (val < cmin) {
	cmin = val;
	index = i;
      }
    }
  }

/*   tree->GetEntry(index); */
/*   return cmin; */

  return index;

}


