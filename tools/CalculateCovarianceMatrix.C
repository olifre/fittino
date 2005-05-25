/***************************************************************************
                          CalculateCovarianceMatrix.C 
                             -------------------
    This ROOT macro estimates mean values and standard deviations
    including their statistical uncertainties for entries
    of a ROOT tree such as that contained in the
    PullDistributions.root file produced by Fittino if pull
    distributions are calculated. In addition the complete
    covariance and correlation matrices are estimated.
                             -------------------
    $Id$
    $Name$
                             -------------------
    begin                : February 19, 2005
    authors              : Philip Bechtle, Peter Wienemann
    email                : philip.bechtle@desy.de, peter.wienemann@desy.de
 ***************************************************************************/
 
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

void CalculateCovarianceMatrix(const char* filename = "TreeSum.root", const char* treename = "tree")
{
    TFile* file = new TFile(filename, "read");
    TTree* tree = (TTree*)file->Get(treename);

    Int_t nEntries = tree->GetEntries();

    Int_t nLeaves = tree->GetListOfLeaves()->GetEntriesFast();

    Double_t* par = new Double_t[nLeaves];

    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
	leaf->SetAddress(&par[iLeaf]);
    }

    TArrayD     mean(nLeaves);
    TArrayD     meanUncertainty(nLeaves);
    TArrayD     stdDevUncertainty(nLeaves);
    TArrayD     stdDevUncertainty2(nLeaves);
    TMatrixD    covMatrix(nLeaves, nLeaves);  // no TMatrixDSym since it is not
    TMatrixD    corrMatrix(nLeaves, nLeaves); // available for old ROOT releases
    TMatrixD    corrUncertaintyMatrix(nLeaves, nLeaves);

    TLeafD *leaf1, *leaf2;
    for (Int_t iLeaf1=0; iLeaf1<nLeaves; iLeaf1++) {

	leaf1 = (TLeafD*)(tree->GetListOfLeaves()->At(iLeaf1));

	for (Int_t iLeaf2=iLeaf1; iLeaf2<nLeaves; iLeaf2++) {

	    leaf2 = (TLeafD*)(tree->GetListOfLeaves()->At(iLeaf2));

//	      printf("--------------------------------------------------\n");
//	      printf("Choosing leaf combination %d %d:\n", iLeaf1, iLeaf2);

	    Double_t par1Sum = 0;
	    Double_t par2Sum = 0;
	    Double_t par1SqrSum = 0;
	    Double_t par2SqrSum = 0;
	    Double_t par1par2Sum = 0;
	    for (Int_t i=0; i<nEntries; i++) {
		tree->GetEntry(i);

		Double_t par1 =  par[iLeaf1];
		Double_t par2 =  par[iLeaf2];
		par1Sum += par1;
		par2Sum += par2;
		par1SqrSum += par1 * par1;
		par2SqrSum += par2 * par2;
		par1par2Sum += par1 * par2;
	    } 

	    Double_t mean1 = par1Sum / nEntries;
	    Double_t mean2 = par2Sum / nEntries;
	    Double_t var1  = nEntries / (nEntries - 1) *
		             (par1SqrSum / nEntries - mean1 * mean1);
	    Double_t var2  = nEntries / (nEntries - 1) *
		             (par2SqrSum / nEntries - mean2 * mean2);
	    Double_t cov12 = nEntries / (nEntries - 1) *
		             (par1par2Sum / nEntries - mean1 * mean2);
	    Double_t corr12 = cov12 / TMath::Sqrt(var1 * var2);
	    Double_t stdDevVar1 = var1 / (2 * (nEntries - 1));
	    Double_t stdDevVar2 = var2 / (2 * (nEntries - 1));
	    Double_t corr12Var = 1.0 / nEntries * ( 1 - corr12 * corr12 ) *
		                 ( 1 - corr12 * corr12 );

//	      printf("Mean %s = %f +- %f\n", leaf1->GetName(), mean1,
//		     TMath::Sqrt(var1 / nEntries));
//	      printf("Mean %s = %f +- %f\n", leaf2->GetName(), mean2,
//		     TMath::Sqrt(var2 / nEntries));
//	      printf("Covariance of %s and %s = %f\n", leaf1->GetName(),
//		     leaf2->GetName(), cov12);
//	      printf ("StdDev %s = %f +- %f\n", leaf1->GetName(),
//		      TMath::Sqrt(var1), TMath::Sqrt(stdDevVar1));
//	      printf ("StdDev %s = %f +- %f\n", leaf2->GetName(),
//		      TMath::Sqrt(var2), TMath::Sqrt(stdDevVar2));
//	      printf("Correlation of %s and %s = %f +- %f\n", leaf1->GetName(),
//		     leaf2->GetName(), corr12, TMath::Sqrt(corr12Var));

	    if (iLeaf1 == iLeaf2) {
	        mean[iLeaf1] = mean1;
		meanUncertainty[iLeaf1] = TMath::Sqrt(var1 / nEntries);
		stdDevUncertainty[iLeaf1] = TMath::Sqrt(stdDevVar1);
	    }
	    covMatrix(iLeaf1, iLeaf2) = cov12;
	    corrMatrix(iLeaf1, iLeaf2) = corr12;
	    corrUncertaintyMatrix(iLeaf1, iLeaf2) = TMath::Sqrt(corr12Var);
	}
    }

    const TMatrixDEigen matrix(covMatrix);
    TVectorD eigenValueVec = matrix.GetEigenValues();
    for (Int_t v=0; v<eigenValueVec.GetNoElements(); v++) {
        if (eigenValueVec(v) < 0) cerr<<"WARNING: Covariance matrix is not non-negative definite"<<endl;
    }

    FILE* outFile = fopen("covarianceMatrix.txt", "w+");
    if (!outFile) {
	fprintf(stderr, "Cannot open file for covariance matrix\n");
    }

    fprintf(outFile, "Parameter estimation from %d tree entries:\n\n", nEntries);

    fprintf(outFile, "Fitted parameters:\n");
    fprintf(outFile, "==================\n");
    fprintf(outFile, "\n");
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
	fprintf(outFile, "%20s %15f(%15f)  +-  %15f(%15f)\n", leaf->GetName(),
		mean[iLeaf], meanUncertainty[iLeaf], TMath::Sqrt(covMatrix(iLeaf, iLeaf)),
		stdDevUncertainty[iLeaf]);
    }
    fprintf(outFile, "\n");

    fprintf(outFile, "Covariance matrix:\n");
    fprintf(outFile, "==================\n");
    fprintf(outFile, "\n\t");
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
	fprintf(outFile, "%s\t", leaf->GetName());
    }
    fprintf(outFile, "\n");
    for (Int_t iLeaf1=0; iLeaf1<nLeaves; iLeaf1++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf1);
	fprintf(outFile, "%s\t", leaf->GetName());
	for (Int_t iLeaf2=0; iLeaf2<nLeaves; iLeaf2++) {
	    if (iLeaf1 <= iLeaf2)
		fprintf(outFile, "%f\t", covMatrix(iLeaf1, iLeaf2));
	    else
		fprintf(outFile, "%f\t", covMatrix(iLeaf2, iLeaf1));
	}
	fprintf(outFile, "\n\n");
    }


    fprintf(outFile, "Correlation matrix:\n");
    fprintf(outFile, "===================\n");
    fprintf(outFile, "\n\t");
    for (Int_t iLeaf=0; iLeaf<nLeaves; iLeaf++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf);
	fprintf(outFile, "%s\t", leaf->GetName());
    }
    fprintf(outFile, "\n");
    for (Int_t iLeaf1=0; iLeaf1<nLeaves; iLeaf1++) {
	TLeafD* leaf = (TLeafD*)tree->GetListOfLeaves()->At(iLeaf1);
	fprintf(outFile, "%s\t", leaf->GetName());
	for (Int_t iLeaf2=0; iLeaf2<nLeaves; iLeaf2++) {
	    if (iLeaf1 <= iLeaf2)
		fprintf(outFile, "%.3f(%.3f)\t", corrMatrix(iLeaf1, iLeaf2),
			corrUncertaintyMatrix(iLeaf1, iLeaf2));
	    else
		fprintf(outFile, "%.3f(%.3f)\t", corrMatrix(iLeaf2, iLeaf1),
			corrUncertaintyMatrix(iLeaf2, iLeaf1));
	}
	fprintf(outFile, "\n");
    }
    fclose(outFile);
}
