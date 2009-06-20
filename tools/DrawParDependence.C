void DrawParDependence(const char* filename,
		       double chi2cut = 4.0,
		       const char* treename = "markovChain")
{
    TFile* file = new TFile(filename, "read");
    if ( !file ) {
      printf("Problem accessing file %s\n", filename);
      return;
    }
    
    TTree* tree = (TTree*)file->Get(treename);
    if ( !tree ) {
      printf("Problem accessing tree %s\n", treename);
      return;
    }
    
    int nLeaves = tree->GetListOfLeaves()->GetEntriesFast();

    std::vector<string> obs;
    std::vector<string> par;

    for (int iLeaf = 0; iLeaf < nLeaves; iLeaf++) {
      const TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);

      if ( ! strncmp("O_", leaf->GetName(), 2) ) {
	obs.push_back(leaf->GetName());
      }
      else if ( ! strncmp("P_", leaf->GetName(), 2) ) {
	par.push_back(leaf->GetName());
      }

    }

    char varcmd[1000];
    char chi2cmd[100];
    char outputfilename[1000];

    for ( int io=0; io<obs.size(); io++ ) {
      for ( int ip=0; ip<par.size(); ip++ ) {

	sprintf(varcmd, "%s:%s", obs[io].c_str(), par[ip].c_str());
	sprintf(chi2cmd, "chi2 < %f", chi2cut);

	tree->Draw(varcmd, chi2cmd, "box");

	sprintf(outputfilename, "%sVs%s.jpg", obs[io].c_str(), par[ip].c_str());

	c1.Print(outputfilename);
      }
    }

}
