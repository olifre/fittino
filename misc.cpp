/***************************************************************************
                                   misc.cpp
                             -------------------    
    Miscellaneous definitions of general use.
    -------------------
    $Id$
    $Name$
    -------------------
    begin                : February 02, 2004
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

#include <misc.h>
#include <TMath.h>
#include <TMatrixDSym.h>
#include <TMatrixDSymEigen.h>
#include <TRandom.h>
#include <TVectorD.h>

CorrelationMatrix::CorrelationMatrix() { 
   fMeasuredVector          = 0;
   fTagMap                  = 0;
   fInverseCovarianceMatrix = 0; 
   fCorrelationMatrix       = 0; 
   fCovarianceMatrix        = 0; 
}

CorrelationMatrix::CorrelationMatrix(const vector<MeasuredValue>* measuredvector) {
   fMeasuredVector          = measuredvector;
   fTagMap                  = 0;
   fInverseCovarianceMatrix = 0;
   fCorrelationMatrix       = 0;
   fCovarianceMatrix        = 0;
}

CorrelationMatrix::CorrelationMatrix(const vector<MeasuredValue>* measuredvector, TagMap* tagmap) {
   fMeasuredVector          = measuredvector;
   fTagMap                  = tagmap;
   fInverseCovarianceMatrix = 0; 
   fCorrelationMatrix       = 0;
   fCovarianceMatrix        = 0;
}

CorrelationMatrix::CorrelationMatrix(const CorrelationMatrix& another) {
   //fCorrelationMatrix = new TMatrixD(another.size(), another.size());
   *fCorrelationMatrix       = *(another.fCorrelationMatrix);
   *fCovarianceMatrix        = *(another.fCovarianceMatrix);
   *fInverseCovarianceMatrix = *(another.fInverseCovarianceMatrix);
   *this = another;
}

CorrelationMatrix::~CorrelationMatrix() {
   if (fCorrelationMatrix)       delete fCorrelationMatrix;
   if (fCovarianceMatrix)        delete fCovarianceMatrix;
   if (fInverseCovarianceMatrix) delete fInverseCovarianceMatrix;
}

const double& CorrelationMatrix::operator()(int rown, int coln) const {
   return (const double&)((*fCorrelationMatrix)(rown, coln));
}

CorrelationMatrix& CorrelationMatrix::operator=(const CorrelationMatrix& source) {
   fCorrelationMatrix = new TMatrixDSym(source.fMeasuredVector->size());
   fCovarianceMatrix = new TMatrixDSym(source.fMeasuredVector->size());
   fInverseCovarianceMatrix = new TMatrixDSym(source.fMeasuredVector->size());

   fMeasuredVector = source.fMeasuredVector;
   *fCorrelationMatrix       = *(source.fCorrelationMatrix);
   *fCovarianceMatrix        = *(source.fCovarianceMatrix);
   *fInverseCovarianceMatrix = *(source.fInverseCovarianceMatrix);

   return *this;
}

const TMatrixDSym& CorrelationMatrix::GetCovarianceMatrix() const {
   return *fCovarianceMatrix;
}

double CorrelationMatrix::GetCorrelation(const string& name1, const string& name2) const {
   int index1 = -1, index2 = -1;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      if ((*fMeasuredVector)[i].name == name1) index1 = i;
      if ((*fMeasuredVector)[i].name == name2) index2 = i;
   }

   if (index1 < 0) {
      cerr<<"value "<<name1<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }
   if (index2 < 0) {
      cerr<<"value "<<name2<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }

   return (*fCorrelationMatrix)(index1, index2);
}

double CorrelationMatrix::GetCorrelation(unsigned int index1, unsigned int index2) const {
   return (*fCorrelationMatrix)(index1,index2);
}

double CorrelationMatrix::GetCovariance(const string& name1, const string& name2) const {
   int index1 = -1, index2 = -1;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      if ((*fMeasuredVector)[i].name == name1) index1 = i;
      if ((*fMeasuredVector)[i].name == name2) index2 = i;
   }

   if (index1 < 0) {
      cerr<<"value "<<name1<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }
   if (index2 < 0) {
      cerr<<"value "<<name2<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }

   return (*fCovarianceMatrix)(index1, index2);
}

double CorrelationMatrix::GetCovariance(unsigned int index1, unsigned int index2) const {
   return (*fCovarianceMatrix)(index1, index2);
}

double CorrelationMatrix::GetInverseCovariance(const string& name1, const string& name2) const {

   int index1 = -1, index2 = -1;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      if ((*fMeasuredVector)[i].name == name1) index1 = i;
      if ((*fMeasuredVector)[i].name == name2) index2 = i;
   }

   if (index1 < 0) {
      cerr<<"value "<<name1<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }
   if (index2 < 0) {
      cerr<<"value "<<name2<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }

   return (*fInverseCovarianceMatrix)(index1, index2);

}

double CorrelationMatrix::GetInverseCovariance(unsigned int index1, unsigned int index2) const {
   return (*fInverseCovarianceMatrix)(index1, index2);
}

void CorrelationMatrix::add(const string& name1, const string& name2, double entry) {
   int index1 = -1, index2 = -1;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      if (!name1.compare((*fMeasuredVector)[i].name)) index1 = i;
      if (!name2.compare((*fMeasuredVector)[i].name)) index2 = i;
   }

   if (index1 < 0) {
      cerr<<"value "<<name1<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }
   if (index2 < 0) {
      cerr<<"value "<<name2<<" not found"<<endl;
      exit(EXIT_FAILURE);
   }

   add(index1, index2, entry);
   add(index2, index1, entry);
}

void CorrelationMatrix::add(unsigned int index1, unsigned int index2, double entry) {
   if (!fCorrelationMatrix) fCorrelationMatrix = new TMatrixDSym(fMeasuredVector->size());

   if (index1 >= fMeasuredVector->size() || index2 >= fMeasuredVector->size()) {
      cerr<<"CorrelationMatrix index out of range"<<endl;
      exit(EXIT_FAILURE);
   }

   (*fCorrelationMatrix)(index1, index2) = entry;
   (*fCorrelationMatrix)(index2, index1) = entry;
}

void CorrelationMatrix::Calculate() {
   fCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
   /* filling covariance matrix with zeros */
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 (*fCovarianceMatrix)(i, j) = 0.0;
      }
   }

   /* calculating diagonal entries of covariance matrix */
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      (*fCovarianceMatrix)(i, i) = ((*fMeasuredVector)[i].error)*((*fMeasuredVector)[i].error);
   }

   /* calculating next to diagonal elements of covariance matrix */
   for (TagMap::iterator mapentry = fTagMap->begin(); mapentry != fTagMap->end(); mapentry++) {
      for (unsigned int i=0; i<mapentry->second.size(); i++) {
	 for (unsigned int j=i+1; j<mapentry->second.size(); j++) {
	    (*fCovarianceMatrix)(mapentry->second[i]->position, mapentry->second[j]->position) += mapentry->second[i]->correrror[mapentry->first]*mapentry->second[j]->correrror[mapentry->first];
	 }
      }
   }

   /* calculating correlation matrix */
   fCorrelationMatrix = new TMatrixDSym(fMeasuredVector->size());
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 (*fCorrelationMatrix)(i, j) = (*fCovarianceMatrix)(i, j)/(sqrt((*fCovarianceMatrix)(i, i))*sqrt((*fCovarianceMatrix)(j, j)));
      }
   }
}

void CorrelationMatrix::CalculateCovarianceMatrix() {

   //cout << (*fMeasuredVector)[0].value << endl;
   if (!fCovarianceMatrix) {
      fCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
   }
   if (!fInverseCovarianceMatrix) {
      fInverseCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
   } 

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 (*fCovarianceMatrix)(i, j) = (*fCorrelationMatrix)(i, j) *
	    (*fMeasuredVector)[i].error * (*fMeasuredVector)[j].error;
	 //      cout << "(" << i << "," << j << ")" << " " <<  (*fCovarianceMatrix)(i, j) << endl;
      }
      //    cout << endl;
   }

   //  cout << "now checking:" << endl;
   //cout << "correlation:" << (*fCorrelationMatrix)(0, 0) << endl;
   //cout << "covariance :" << (*fCovarianceMatrix)(0, 0) << endl;

   *fInverseCovarianceMatrix = *fCovarianceMatrix;

   double det;
   //cout << "inverting covariancematrix:" << endl;
   fInverseCovarianceMatrix->Invert(&det);
   //cout << "covariancematrix inverted:" << endl;
   //  for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
   //    for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
   //      cout << "(" << i << "," << j << ")" << " " <<  (*fInverseCovarianceMatrix)(i, j) << endl;
   //    }
   //  }

}

void CorrelationMatrix::Print() {
   cout << "printing correlation matrix:" << endl;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 //cout.precision(2);
	 //cout.setf(ios::fixed,ios::floatfield); 
	 cout << (*fCorrelationMatrix)(i, j) << " ";
      }
      cout << endl;
   }
}

TVectorD getCorrelatedRandomNumbers(const TVectorD& mean, const TMatrixDSym& covarianceMatrix) {
   int n = mean.GetNoElements();

   const TMatrixDSymEigen matrix(covarianceMatrix);
   TMatrixD eigenVecMatrix = matrix.GetEigenVectors();
   TVectorD eigenValueVec = matrix.GetEigenValues();

   TVectorD y(n);
   for (int i=0; i<n; i++) {
      if (eigenValueVec(i) < 0) {
	 cerr << "getCorrelatedRandomNumbers: Covariance matrix is not non-negative definite" << endl;
	 exit(EXIT_FAILURE);
      }
      y(i) = gRandom->Gaus(0, TMath::Sqrt(eigenValueVec(i)));
   }

   TVectorD x(y);
   x *= eigenVecMatrix;
   x += mean;

   return x;
}
