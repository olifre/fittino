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

#include <stdlib.h>
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

void CorrelationMatrix::AddCovariance(const string& name1, const string& name2, double entry) {
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

   AddCovariance(index1, index2, entry);
   AddCovariance(index2, index1, entry);
}


void CorrelationMatrix::AddCovariance(unsigned int index1, unsigned int index2, double entry) {
  if (!fCovarianceMatrix) {
    fCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
    for (unsigned int i = 0; i < fMeasuredVector->size(); i++) {
      for (unsigned int j = 0; j < fMeasuredVector->size(); j++) {
	(*fCovarianceMatrix)(i, j) = 0.0;
      }
    }
  }
  
  if (index1 >= fMeasuredVector->size() || index2 >= fMeasuredVector->size()) {
    cerr<<"CovarianceMatrix index out of range"<<endl;
    exit(EXIT_FAILURE);
  }
  
  (*fCovarianceMatrix)(index1, index2) += entry;
  (*fCovarianceMatrix)(index2, index1) += entry;
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

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fCovarianceMatrix)(i,j) = (*fCovarianceMatrix)(i,j)*10000000; // rescale covariance matrix with 1e+7 to avoid problems with small entries during inversion 
      }
   }

   *fInverseCovarianceMatrix = *fCovarianceMatrix;

   //cout << "inverting covariancematrix:" << endl;
   //double det;
   fInverseCovarianceMatrix->Invert(/*&det*/);

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fInverseCovarianceMatrix)(i,j) = (*fInverseCovarianceMatrix)(i,j)*10000000; 
      }
   }
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fCovarianceMatrix)(i,j) = (*fCovarianceMatrix)(i,j)/10000000; 
      }
   }

   //cout << "covariancematrix inverted:" << endl;
   //  for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
   //    for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
   //      cout << "(" << i << "," << j << ")" << " " <<  (*fInverseCovarianceMatrix)(i, j) << endl;
   //    }
   //  }

}

void CorrelationMatrix::AddFullCovarianceMatrix(const CorrelationMatrix& addedCovarianceMatrix)
{

   if (!fCovarianceMatrix) {
      cout << "creating covariance matrix" << endl;
      fCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
      for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
	 for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	    (*fCovarianceMatrix)(i, j) = 0.0;
	 }
      }
   }

   // cout << "adding covariance entries" << endl;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 // cout << "adding covariance " << i << " " << j << endl;
	 (*fCovarianceMatrix)(i,j) += addedCovarianceMatrix.GetCovariance(i,j);
      }
   }

   return;
}

void CorrelationMatrix::TransformCovarianceMatrixIntoCorrelationMatrix()
{

   if (!fCorrelationMatrix) {
      fCorrelationMatrix = new TMatrixDSym(fMeasuredVector->size());
   }
   if (!fCovarianceMatrix) {
      cout << "Asking to transform non-existing covariance matrix into correlation matrix" << endl;
      exit(EXIT_FAILURE);
   }

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 (*fCorrelationMatrix)(i, j) = (*fCovarianceMatrix)(i, j) /
	    ((*fMeasuredVector)[i].error * (*fMeasuredVector)[j].error);
	 //      cout << "(" << i << "," << j << ")" << " " <<  (*fCovarianceMatrix)(i, j) << endl;
      }
      //    cout << endl;
   }


   return;
}

void CorrelationMatrix::CalculateInverseCovarianceMatrix() 
{
   if (!fInverseCovarianceMatrix) {
      fInverseCovarianceMatrix = new TMatrixDSym(fMeasuredVector->size());
   }
   if (!fCovarianceMatrix) {
      cout << "Asking to transform non-existing covariance matrix into inverse covariance matrix" << endl;
      exit(EXIT_FAILURE);
   }

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fCovarianceMatrix)(i,j) = (*fCovarianceMatrix)(i,j)*10000000; // rescale covariance matrix with 1e+7 to avoid problems with small entries during inversion 
      }
   }

   *fInverseCovarianceMatrix = *fCovarianceMatrix;

   //double det;
   fInverseCovarianceMatrix->Invert(/*&det*/);

   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fInverseCovarianceMatrix)(i,j) = (*fInverseCovarianceMatrix)(i,j)*10000000; 
      }
   }
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
         (*fCovarianceMatrix)(i,j) = (*fCovarianceMatrix)(i,j)/10000000; 
      }
   }

   return;
}

bool CorrelationMatrix::TestCovarianceMatrixExistence()
{
   if (!fCovarianceMatrix) {
      return false;
   } else {
      return true;
   }

}


void CorrelationMatrix::Print() {
   if (!fCorrelationMatrix) {
      cout << "Correlation matrix does not exist" << endl;
      return;
   }
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

void CorrelationMatrix::PrintCovariance() {
   if (!fCovarianceMatrix) {
      cout << "Covariance matrix does not exist" << endl;
      return;
   }
   cout << "printing covariance matrix:" << endl;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 //cout.precision(2);
	 //cout.setf(ios::fixed,ios::floatfield); 
	 cout << (*fCovarianceMatrix)(i, j) << " ";
      }
      cout << endl;
   }
}

void CorrelationMatrix::PrintInverseCovariance() {
   if (!fInverseCovarianceMatrix) {
      cout << "Inverse covariance matrix does not exist" << endl;
      return;
   }
   cout << "printing inverse covariance matrix:" << endl;
   for (unsigned int i=0; i<fMeasuredVector->size(); i++) {
      for (unsigned int j=0; j<fMeasuredVector->size(); j++) {
	 //cout.precision(2);
	 //cout.setf(ios::fixed,ios::floatfield); 
	 cout << (*fInverseCovarianceMatrix)(i, j) << " ";
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

double  BilinearInterpolator(double m0, double m12, std::map< std::pair<int,int>, double>& xs)
{
  //  std::cout << "m0 = " << m0 << "     m12 = " << m12 << std::endl;

  double m0_1 = 0;
  double m0_2 = 0;
  double m12_1 = 0;
  double m12_2 = 0;

  std::map<std::pair<int,int>, double>::const_iterator it;

  // check boundaries (assumes ordering in input file)
  it = xs.begin();
  int m0min = it->first.first;
  int m12min = it->first.second;
  it = xs.end();
  it--;
  int m0max = it->first.first;
  int m12max = it->first.second;

  /*
  std::cout << "m0min = " << m0min << std::endl;
  std::cout << "m0max = " << m0max << std::endl;
  std::cout << "m12min = " << m12min << std::endl;
  std::cout << "m12max = " << m12max << std::endl;
  */

  if (m0 < m0min || m0 > m0max || m12 < m12min || m12 > m12max) {
    std::cerr << "Parameter point outside grid range" << std::endl;
    if (m0 < m0min || m12 < m12min) return -1000; // in this case add infinity to chi2
    else return -1; // in this case add 0 to chi2
  }

  // find m0_1, m0_2, m12_1 and m12_2
  for (it=xs.begin(); it != xs.end(); it++) {
    if (it->first.first > m0) {
      m0_2 = it->first.first;
      it--;
      m0_1 = it->first.first;
      it++;
      while (it->first.second < m12) {
        it++;
      }
      m12_2 = it->first.second;
      it--;
      m12_1 = it->first.second;
      break;
    }
  }

  std::pair<int, int> p;

  if (m0 == m0max && m12 == m12max) {
    p.first = m0max;
    p.second = m12max;
    return xs[p];
  }


  if (m0 == m0max) {
    m0_2 = m0max;
    it = xs.end();
    it--;
    while (it->first.first == m0max) {
      it--;
    }
    m0_1 = it->first.first;
    it = xs.end();
    it--;
    while (it->first.second > m12) {
      it--;
    }
    m12_1 = it->first.second;
    it++;
    m12_2 = it->first.second;
  }

  if (m12 == m12min) {
    m12_1 = m12min;
    it = xs.begin();
    it++;
    while (it->first.second == m12min) {
      it++;
    }
    m12_2 = it->first.second;
    it--;
    while (it->first.first > m0) {
      it--;
    }
    m12_1 = it->first.second;
    it++;
    m12_2 = it->first.second;
  }

  /*
  std::cout << "m0_1 = " << m0_1 << std::endl;
  std::cout << "m0_2 = " << m0_2 << std::endl;
  std::cout << "m12_1 = " << m12_1 << std::endl;
  std::cout << "m12_2 = " << m12_2 << std::endl;
  */

  double x1 = m0_1;
  double x2 = m0_2;
  double y1 = m12_1;
  double y2 = m12_2;

  p.first = x1;
  p.second = y1;
  double z11 = xs[p];

  p.first = x1;
  p.second = y2;
  double z12 = xs[p];

  p.first = x2;
  p.second = y1;
  double z21 = xs[p];

  p.first = x2;
  p.second = y2;
  double z22 = xs[p];

  /*
  std::cout << "xs11 = " << z11 << std::endl;
  std::cout << "xs12 = " << z12 << std::endl;
  std::cout << "xs21 = " << z21 << std::endl;
  std::cout << "xs22 = " << z22 << std::endl;
  */

  double x = m0;
  double y = m12;

  double val =  1.0 / ( (x2 - x1) * (y2 - y1) )
    * (  (x-x1)*(y-y1)*z22 + (x2-x)*(y-y1)*z12
         + (x-x1)*(y2-y)*z21 + (x2-x)*(y2-y)*z11 );

  return val;
}
