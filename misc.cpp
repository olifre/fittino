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

#include <TMath.h>
#include <TVectorD.h>
#include <TMatrixDSym.h>
#include <TMatrixDSymEigen.h>
#include <TRandom.h>

#include <misc.h>

CorrelationMatrix::CorrelationMatrix(const vector<MeasuredValue>* vec)
{
    fVector                  = vec;
    fCorrelationMatrix       = 0;
    fCovarianceMatrix        = 0;
    fInverseCovarianceMatrix = 0;
}


CorrelationMatrix::CorrelationMatrix(const CorrelationMatrix& another)
{
  //    fCorrelationMatrix = new TMatrixD(another.size(), another.size());
    *fCorrelationMatrix       = *(another.fCorrelationMatrix);
    *fCovarianceMatrix        = *(another.fCovarianceMatrix);
    *fInverseCovarianceMatrix = *(another.fInverseCovarianceMatrix);
    *this = another;
}


CorrelationMatrix::~CorrelationMatrix()
{
    if (fCorrelationMatrix)       delete fCorrelationMatrix;
    if (fCovarianceMatrix)        delete fCovarianceMatrix;
    if (fInverseCovarianceMatrix) delete fInverseCovarianceMatrix;
}


void CorrelationMatrix::add(unsigned int index1, unsigned int index2, double entry)
{
    if (!fCorrelationMatrix) fCorrelationMatrix = new TMatrixDSym(fVector->size());

    if (index1 >= fVector->size() || index2 >= fVector->size()) {
        cerr<<"CorrelationMatrix index out of range"<<endl;
	exit(EXIT_FAILURE);
    }

    (*fCorrelationMatrix)(index1, index2) = entry;
    (*fCorrelationMatrix)(index2, index1) = entry;
}


void CorrelationMatrix::add(const string& name1, const string& name2,
			    double entry)
{
    int index1 = -1, index2 = -1;
    for (unsigned int i=0; i<fVector->size(); i++) {
      if (!name1.compare((*fVector)[i].name)) index1 = i;
      if (!name2.compare((*fVector)[i].name)) index2 = i;
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

CorrelationMatrix& CorrelationMatrix::operator=(const CorrelationMatrix& source)
{
    fCorrelationMatrix = new TMatrixDSym(source.fVector->size());
    fCovarianceMatrix = new TMatrixDSym(source.fVector->size());
    fInverseCovarianceMatrix = new TMatrixDSym(source.fVector->size());

    fVector = source.fVector;
    *fCorrelationMatrix       = *(source.fCorrelationMatrix);
    *fCovarianceMatrix        = *(source.fCovarianceMatrix);
    *fInverseCovarianceMatrix = *(source.fInverseCovarianceMatrix);

    return *this;
}


double CorrelationMatrix::GetCorrelation(const string& name1, const string& name2) const
{
    int index1 = -1, index2 = -1;
    for (unsigned int i=0; i<fVector->size(); i++) {
        if ((*fVector)[i].name == name1) index1 = i;
        if ((*fVector)[i].name == name2) index2 = i;
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


double CorrelationMatrix::GetCovariance(const string& name1, const string& name2) const
{
    int index1 = -1, index2 = -1;
    for (unsigned int i=0; i<fVector->size(); i++) {
        if ((*fVector)[i].name == name1) index1 = i;
        if ((*fVector)[i].name == name2) index2 = i;
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

double   CorrelationMatrix::GetInverseCovariance(const string& name1, const string& name2) const
{

    int index1 = -1, index2 = -1;
    for (unsigned int i=0; i<fVector->size(); i++) {
        if ((*fVector)[i].name == name1) index1 = i;
        if ((*fVector)[i].name == name2) index2 = i;
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


void CorrelationMatrix::CalculateCovarianceMatrix()
{

  //cout << (*fVector)[0].value << endl;
  if (!fCovarianceMatrix) {
    fCovarianceMatrix = new TMatrixDSym(fVector->size());
  }
  if (!fInverseCovarianceMatrix) {
    fInverseCovarianceMatrix = new TMatrixDSym(fVector->size());
  } 
  
  for (unsigned int i=0; i<fVector->size(); i++) {
    for (unsigned int j=0; j<fVector->size(); j++) {
      (*fCovarianceMatrix)(i, j) = (*fCorrelationMatrix)(i, j) *
	(*fVector)[i].error * (*fVector)[j].error;
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
//  for (unsigned int i=0; i<fVector->size(); i++) {
//    for (unsigned int j=0; j<fVector->size(); j++) {
//      cout << "(" << i << "," << j << ")" << " " <<  (*fInverseCovarianceMatrix)(i, j) << endl;
//    }
//  }

}


TVectorD getCorrelatedRandomNumbers(const TVectorD& mean, const TMatrixDSym& covarianceMatrix)
{
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
