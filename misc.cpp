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
#include <TRandom3.h>
#include <math.h>

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

double  BilinearInterpolator(double m0, double m12, int bin, std::map< std::pair<int,int>, TH1F*>& xs)
{
  //  std::cout << "m0 = " << m0 << "     m12 = " << m12 << std::endl;

  double m0_1 = 0;
  double m0_2 = 0;
  double m12_1 = 0;
  double m12_2 = 0;

  std::map<std::pair<int,int>, TH1F*>::const_iterator it;

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
  //  std::pair<double, double> p;

  if (m0 == m0max && m12 == m12max) {
    p.first = m0max;
    p.second = m12max;
    return xs[p]->GetBinContent(bin);
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

  p.first = (int)x1;
  p.second = (int)y1;
  double z11 = xs[p]->GetBinContent(bin);

  p.first = (int)x1;
  p.second = (int)y2;
  double z12 = xs[p]->GetBinContent(bin);

  p.first = (int)x2;
  p.second = (int)y1;
  double z21 = xs[p]->GetBinContent(bin);

  p.first = (int)x2;
  p.second = (int)y2;
  double z22 = xs[p]->GetBinContent(bin);

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


double
BicubicInterpolator( double x_value, // M_0, when used for Die Frage
		     double y_value, // M_1/2, when used for Die Frage
		     int requested_bin,
		     std::map< std::pair< int, int >, TH1F* >& data_grid )
/* this is an extension by Ben O'Leary (benjamin.oleary@gmail.com) to
 * BilinearInterpolator above to use a fit to cubic polynomials as an
 * interpolation on a grid of histograms.
 */
{

  // debugging:
  //  std::cout << "m0 = " << x_value << "     m12 = " << y_value << std::endl;

  // check boundaries (assumes ordering in input file)
  std::map< std::pair< int, int >, TH1F* >::const_iterator
  grid_iterator = data_grid.begin();
  int minimum_x = grid_iterator->first.first;
  int minimum_y = grid_iterator->first.second;
  grid_iterator = data_grid.end();
  grid_iterator--;
  int maximum_x = grid_iterator->first.first;
  int maximum_y = grid_iterator->first.second;

  /*
  std::cout << "m0min = " << minimum_x << std::endl;
  std::cout << "m0max = " << maximum_x << std::endl;
  std::cout << "m12min = " << minimum_y  << std::endl;
  std::cout << "m12max = " << maximum_y << std::endl;
  */

  if( ( minimum_x > x_value )
      ||
      ( minimum_y > y_value ) )
    {

      std::cerr << "BicubicInterpolator: Parameter point outside grid range"
		<< std::endl;

      return -1000;  // in this case add "infinity" to chi^2

    }
  else if( ( maximum_x < x_value )
	   ||
	   ( maximum_y < y_value ) )
    {

      std::cerr << "BicubicInterpolator: Parameter point outside grid range"
		<< std::endl;

      return -1;  // in this case add 0 to chi^2

  }

  // we fit cubics along x-lines to produce 4 points of the line y = y_value:

  int far_lower_x = minimum_x;
  // the lesser of the 2 nearest grid line x-values less than x_value.
  int near_lower_x = minimum_x;
  // the greater of the 2 nearest grid line x-values less than x_value.
  int near_upper_x = maximum_x;
  // the lesser of the 2 nearest grid line x-values greater than x_value.
  int far_upper_x = maximum_x;
  // the greater of the 2 nearest grid line x-values greater than x_value.

  int far_lower_y = minimum_y;
  // the lesser of the 2 nearest grid line y-values less than y_value.
  int near_lower_y = minimum_y;
  // the greater of the 2 nearest grid line y-values less than y_value.
  int near_upper_y = maximum_y;
  // the lesser of the 2 nearest grid line y-values greater than y_value.
  int far_upper_y = maximum_y;
  // the greater of the 2 nearest grid line y-values greater than y_value.

  // the 4 values at the points of the line y = y_value are stored in the
  // following variables:
  double far_lower_cubic_value = NAN;
  double near_lower_cubic_value = NAN;
  double near_upper_cubic_value = NAN;
  double far_upper_cubic_value = NAN;

  std::pair< int, int > grid_point;


  /* now we have to decide whether we can use full cubics for the interpolation,
   * or if we have to restrict it to a quadratic in 1 or the other variable
   * because we are too close to the edge of the grid. we do this while
   * looking for the nearest grid points to the requested value.
   */

  // grid_iterator at the moment is at the last recorded point.

  bool all_x_lines_found = false;
  bool all_y_lines_found = false;

  while( ( data_grid.begin() != grid_iterator )
	 &&
	 !( all_x_lines_found
	    &&
	    all_y_lines_found ) )
    // go through the grid (until either we reach the end of the std::map or
    // we find BOTH all 4 x-values & all 4 y-values)...
    {

      grid_iterator--;
      // go back another step from the end.

      if( !all_x_lines_found )
        {

          if( grid_iterator->first.first > x_value )
            // if, at this step, we are still to the right of the requested
            // point...
            {

              if( grid_iterator->first.first < near_upper_x )
	        // if we have moved to a line closer to the requested point...
                {

	          far_upper_x = near_upper_x;
	          // the farther right line should move 1 line left, before
	          // we forget this line.

	          near_upper_x = grid_iterator->first.first;
	          // now the nearer right line should move 1 line left, to
	          // this line.

	        }

	    }
          /* otherwise, now near_upper_x should be the lowest x-value higher
           * than x_value which was found in the grid, & far_upper_x should be
           * the next largest x-value.
           * now we look to see if we have found the other 2 x-values:
           */
          else if( grid_iterator->first.first > near_lower_x )
	    // if we've gone left past x_value, BUT near_lower_x is to our
	    // left (& it begins at the left-most x-value)...
	    {

	      near_lower_x = grid_iterator->first.first;

	    }
          /* otherwise, now near_lower_x should be the highest x-value lower
           * than x_value which was found in the grid, while the upper
           * x-values are as they should be.
           * now we look to see if we have found the final x-value:
           */
          else if( ( grid_iterator->first.first > far_lower_x )
	           &&
	           ( grid_iterator->first.first < near_lower_x ) )
	    /* if we've gone left past x_value, AND near_lower_x is to our
             * right (so we are not at its value exactly), AND far_lower_x is
             * to our left (& it begins at the left-most x-value)...
	     */
	    {

	      far_lower_x = grid_iterator->first.first;
	      all_x_lines_found = true;
	      // note that we have found all the x-values necessary.

	    }

        }

      // we also do the same for the y-values:

      if( !all_y_lines_found )
        {

          if( grid_iterator->first.second > y_value )
	    // if, at this step, we are still above the requested point...
	    {

	      if( grid_iterator->first.second < near_upper_y )
	        // if we have moved to a line closer to the requested point...
	        {

	          far_upper_y = near_upper_y;
	          // the farther up line should move 1 line down, before we
	          // forget this line.

                  near_upper_y = grid_iterator->first.second;
	          // now the nearer above line should move 1 line down, to this
	          // line.

                }

            }
          /* otherwise, now near_upper_y should be the lowest y-value higher than
            * y_value which was found in the grid, & far_upper_y should be the
            *     next largest y-value.
           * now we look to see if we have found the other 2 y-values:
          */
          else if( grid_iterator->first.second > near_lower_y )
	    // if we've gone down past y_value, BUT near_lower_y is beneath us
	    // (& it begins at the lowest y-value)...
            {

              near_lower_y = grid_iterator->first.second;

            }
          /* otherwise, now near_lower_y should be the highest y-value lower than
            * y_value which was found in the grid, while the upper y-values are as
            * they should be.
           * now we look to see if we have found the final y-value:
          */
          else if( ( grid_iterator->first.second > far_lower_y )
                     &&
                     ( grid_iterator->first.second < near_lower_y ) )
	    /* if we've gone down past y_value, AND near_lower_y is above us
              * (so we are not at its value exactly), AND far_lower_y is beneath us
              * (& it begins at the lowest y-value)...
            */
            {

              far_lower_y = grid_iterator->first.second;
              all_y_lines_found = true;
	      // note that we have found all the y-values necessary.

            }

        }

    }  // end of while loop looking for the 4 x-values & 4 y-values.


  // debugging:
  /*std::cout << std::endl << "debugging! x-values: " << far_lower_x
	    << ", " << near_lower_x << ", " << near_upper_x
	    << ", " << far_upper_x;
  std::cout << std::endl << "and y-values: " << far_lower_y
	    << ", " << near_lower_y << ", " << near_upper_y
	    << ", " << far_upper_y;*/


  // now we determine if we have any of the special cases:

  if( near_lower_x == x_value )
    // if the requested point lies directly on a grid x-value...
    {

      if( near_lower_y == y_value )
	// if we were asked for a point exactly on a grid point...
	{

	  grid_point = make_pair( near_lower_x,
				  near_lower_y );
	  return data_grid[ grid_point ]->GetBinContent( requested_bin );
	  // return the value held in the grid histogram directly.

	}
      else
	// otherwise, prepare the y-value cubic equation directly from grid
	// values:
	{

	  grid_point = make_pair( near_lower_x,
				  far_lower_y );
	  far_lower_cubic_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );

	  grid_point = make_pair( near_lower_x,
				  near_lower_y );
	  near_lower_cubic_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );

	  grid_point = make_pair( near_lower_x,
				  near_upper_y );
	  near_upper_cubic_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );

	  grid_point = make_pair( near_lower_x,
				  far_upper_y );
	  far_upper_cubic_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );

	}

    }
  else if( near_lower_y == y_value )
    /* if the requested point lies directly on a grid y-value, but not a
     * grid x-value, fit to a cubic on the x-values:
     * (& we swap x-values with y-values to get y-value bin sizes correct.)
     */
    {

      grid_point = make_pair( far_lower_x,
			      near_lower_y );
      far_lower_cubic_value
	= data_grid[ grid_point ]->GetBinContent( requested_bin );

      grid_point = make_pair( near_lower_x,
			      near_lower_y );
      near_lower_cubic_value
	= data_grid[ grid_point ]->GetBinContent( requested_bin );

      grid_point = make_pair( near_upper_x,
			      near_lower_y );
      near_upper_cubic_value
	= data_grid[ grid_point ]->GetBinContent( requested_bin );

      grid_point = make_pair( far_upper_x,
			      near_lower_y );
      far_upper_cubic_value
	= data_grid[ grid_point ]->GetBinContent( requested_bin );

      far_lower_y = far_lower_x;
      near_lower_y = near_lower_x;
      near_upper_y = near_upper_x;
      far_upper_y = far_upper_x;
      y_value = x_value;

    }
  else
    // otherwise we have to check if we are too close to the grid edge to use a
    // full cubic in x-values:
    {

      if( far_lower_x >= near_lower_x )
	// if we are too close to the grid's left edge, we use a quadratic,
	// ignoring far_lower_x.
	{

	  grid_point = make_pair( near_upper_x,
				  far_lower_y );
	  double left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_lower_y );
	  double origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  far_lower_y );
	  double right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_lower_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                            near_upper_x,
                                                            left_value,
                                                            near_lower_x,
                                                            origin_value,
                                                            far_upper_x,
                                                            right_value );

	  grid_point = make_pair( near_upper_x,
				  near_lower_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_lower_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  near_lower_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_lower_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                             near_upper_x,
                                                             left_value,
                                                             near_lower_x,
                                                             origin_value,
                                                             far_upper_x,
                                                             right_value );

	  grid_point = make_pair( near_upper_x,
				  near_upper_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_upper_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  near_upper_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_upper_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                             near_upper_x,
                                                             left_value,
                                                             near_lower_x,
                                                             origin_value,
                                                             far_upper_x,
                                                             right_value );

	  grid_point = make_pair( near_upper_x,
				  far_upper_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_upper_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  far_upper_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_upper_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                            near_upper_x,
                                                            left_value,
                                                            near_lower_x,
                                                            origin_value,
                                                            far_upper_x,
                                                            right_value );

	}
      else if( far_upper_x <= near_upper_x )
	// if we are too close to the grid's right edge, we use a quadratic,
	// ignoring far_upper_x.
	{

	  grid_point = make_pair( far_lower_x,
				  far_lower_y );
	  double left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_lower_y );
	  double origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  far_lower_y );
	  double right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_lower_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                            far_lower_x,
                                                            left_value,
                                                            near_lower_x,
                                                            origin_value,
                                                            near_upper_x,
                                                            right_value );

	  grid_point = make_pair( far_lower_x,
				  near_lower_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_lower_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  near_lower_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_lower_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                             far_lower_x,
                                                             left_value,
                                                             near_lower_x,
                                                             origin_value,
                                                             near_upper_x,
                                                             right_value );

	  grid_point = make_pair( far_lower_x,
				  near_upper_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_upper_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  near_upper_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_upper_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                             far_lower_x,
                                                             left_value,
                                                             near_lower_x,
                                                             origin_value,
                                                             near_upper_x,
                                                             right_value );

	  grid_point = make_pair( far_lower_x,
				  far_upper_y );
	  left_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_upper_y );
	  origin_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  far_upper_y );
	  right_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_upper_cubic_value = BOL_QuadraticInterpolate( x_value,
                                                            far_lower_x,
                                                            left_value,
                                                            near_lower_x,
                                                            origin_value,
                                                            near_upper_x,
                                                            right_value );

	}
      else
	// otherwise, use a full cubic in the x-values:
	{

	  // debugging:
	  /*std::cout << std::endl
		    << "far_lower_cubic from " << far_lower_x
		    << ", " << far_lower_y;
		    std::cout << std::endl;*/

	  grid_point = make_pair( far_lower_x,
				  far_lower_y );
	  double far_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_lower_y );
	  double near_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  far_lower_y );
	  double near_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  far_lower_y );
	  double far_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_lower_cubic_value = BOL_CubicInterpolate( x_value,
                                                        far_lower_x,
                                                        far_lower_value,
                                                        near_lower_x,
                                                        near_lower_value,
                                                        near_upper_x,
                                                        near_upper_value,
                                                        far_upper_x,
                                                        far_upper_value );

	  // debugging:
	  /*std::cout << std::endl
		    << "near_lower_cubic from " << far_lower_x
		    << ", " << near_lower_y;
		    std::cout << std::endl;*/

	  grid_point = make_pair( far_lower_x,
				  near_lower_y );
	  far_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_lower_y );
	  near_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  near_lower_y );
	  near_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  near_lower_y );
	  far_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_lower_cubic_value = BOL_CubicInterpolate( x_value,
                                                         far_lower_x,
                                                         far_lower_value,
                                                         near_lower_x,
                                                         near_lower_value,
                                                         near_upper_x,
                                                         near_upper_value,
                                                         far_upper_x,
                                                         far_upper_value );

	  // debugging:
	  /*std::cout << std::endl
		    << "near_upper_cubic from " << far_lower_x
		    << ", " << near_upper_y;
		    std::cout << std::endl;*/

	  grid_point = make_pair( far_lower_x,
				  near_upper_y );
	  far_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  near_upper_y );
	  near_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  near_upper_y );
	  near_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  near_upper_y );
	  far_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  near_upper_cubic_value = BOL_CubicInterpolate( x_value,
                                                         far_lower_x,
                                                         far_lower_value,
                                                         near_lower_x,
                                                         near_lower_value,
                                                         near_upper_x,
                                                         near_upper_value,
                                                         far_upper_x,
                                                         far_upper_value );

	  // debugging:
	  /*std::cout << std::endl
		    << "far_upper_cubic from " << far_lower_x
		    << ", " << far_upper_y;
		    std::cout << std::endl;*/

	  grid_point = make_pair( far_lower_x,
				  far_upper_y );
	  far_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_lower_x,
				  far_upper_y );
	  near_lower_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( near_upper_x,
				  far_upper_y );
	  near_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  grid_point = make_pair( far_upper_x,
				  far_upper_y );
	  far_upper_value
	    = data_grid[ grid_point ]->GetBinContent( requested_bin );
	  far_upper_cubic_value = BOL_CubicInterpolate( x_value,
                                                        far_lower_x,
                                                        far_lower_value,
                                                        near_lower_x,
                                                        near_lower_value,
                                                        near_upper_x,
                                                        near_upper_value,
                                                        far_upper_x,
                                                        far_upper_value );

	}

    }
  // at this point we have a set of 4 interpolated values on a line with 4
  // coordinate values.

  // now we check to see if we are too close to an edge in the y-direction:

  if( far_lower_y >= near_lower_y )
    // if we are too close to the grid's lower edge, we use a quadratic,
    // ignoring far_lower_y.
    {

      return BOL_QuadraticInterpolate( y_value,
				       near_upper_y,
				       near_upper_cubic_value,
				       near_lower_y,
				       near_lower_cubic_value,
				       far_upper_y,
				       far_upper_cubic_value );

    }
  else if( far_upper_y <= near_upper_y )
    // if we are too close to the grid's upper edge, we use a quadratic,
    // ignoring far_upper_y.
    {

      return BOL_QuadraticInterpolate( y_value,
				       far_lower_y,
				       far_lower_cubic_value,
				       near_lower_y,
				       near_lower_cubic_value,
				       near_upper_y,
				       near_upper_cubic_value );

    }
  else
    // otherwise, use a full cubic:
    {

      return BOL_CubicInterpolate( y_value,
				   far_lower_y,
				   far_lower_cubic_value,
				   near_lower_y,
				   near_lower_cubic_value,
				   near_upper_y,
				   near_upper_cubic_value,
				   far_upper_y,
				   far_upper_cubic_value );

    }

}

double
BOL_QuadraticInterpolate( double input_z,
			  // the distance along from origin_z to be
			  // interpolated.
			  // the lower-value co-ordinate & its value:
			  double left_z,
			  double left_value,
			  // the origin-value co-ordinate & its value:
			  double origin_z,
			  double origin_value,
			  // the higher-value co-ordinate & its value:
			  double right_z,
			  double right_value )
/* this is to aid BicubicInterpolate by fitting a quadratic function to the
 * given arguments in order & returning the interpolated value.
 * (Ben O'Leary (benjamin.oleary@gmail.com) to be blamed for this function.)
 * this will break if any 2 of { left_z, origin_z, right_z } or all 3 are
 * equal, but I should not ever have done that in BicubicInterpolate().
 */
{

  // debugging:
  /*std::cout << std::endl << "debugging! BOL_QuadraticInterpolate( "
	    << input_z << ", " << left_z << ", " << left_value
	    << ", " << origin_z << ", " << origin_value << ", "
	    << right_z << ", " << right_value << " ) called.";
	    std::cout << std::endl;*/


  if( input_z == origin_z )
    {

      return origin_value;

    }
  else if( !( right_z > left_z ) )
    {

      std::cout << std::endl << "BOL_QuadraticInterpolate error!" << std::endl;
      std::cout << "!( right_z > left_z )" << std::endl;
      return NAN;

    }
  /*else if( input_z == left_z )
    // this should never happen. :P
    {

      return left_value;

    }
  else if( input_z == right_z )
    // this should never happen. :P
    {

      return right_value;

      }*/
  else
    {

      double delta_left = ( left_z - origin_z );
      double delta_right = ( right_z - origin_z );
      double delta_z = ( input_z - origin_z );

      double constant_coefficient = origin_value;

      double left_difference = ( left_value - origin_value );
      double right_difference = ( right_value - origin_value );

      // debugging:
      /*std::cout << std::endl << "delta_left = " << delta_left;
	std::cout << std::endl << "delta_right = " << delta_right;
	std::cout << std::endl << "delta_z = " << delta_z;
	std::cout << std::endl << "constant_coefficient = " << constant_coefficient;
	std::cout << std::endl << "left_difference = " << left_difference;
	std::cout << std::endl << "right_difference = " << right_difference;
	std::cout << std::endl;*/

      double quadratic_coefficient
	= ( ( left_difference * delta_right
	      - right_difference * delta_left )
	    / ( delta_left * delta_right
		* ( delta_left - delta_right ) ) );

      double linear_coefficient
	= ( ( left_difference / delta_left )
	    - delta_left * quadratic_coefficient );

      // debugging:
      /*std::cout << std::endl << "constant_coefficient = " << constant_coefficient;
	std::cout << std::endl << "linear_coefficient = " << linear_coefficient;
	std::cout << std::endl << "quadratic_coefficient = " << quadratic_coefficient;
	std::cout << std::endl << "result = "
	<< ( constant_coefficient
	+ delta_z * linear_coefficient
	+ delta_z * delta_z * quadratic_coefficient );
	std::cout << std::endl;*/

      return ( constant_coefficient
	       + delta_z * linear_coefficient
	       + delta_z * delta_z * quadratic_coefficient );

    }

}

double
BOL_CubicInterpolate( double input_z,
		      // the distance along from near_left_z to be interpolated.
		      // the lowest-value co-ordinate & its value:
		      double far_left_z,
		      double far_left_value,
		      // the 2nd-lowest-value co-ordinate & its value:
		      double near_left_z,
		      double near_left_value,
		      // the 2nd-highest-value co-ordinate & its value:
		      double near_right_z,
		      double near_right_value,
		      // the highest-value co-ordinate & its value:
		      double far_right_z,
		      double far_right_value )
/* this is to aid BicubicInterpolate by fitting a cubic function to the
 * given arguments in order & returning the interpolated value.
 * (Ben O'Leary (benjamin.oleary@gmail.com) to be blamed for this function.)
 * this will break if any 2 or more of
 * { far_left_z, near_left_z, near_right_z, far_right_z } are equal,
 * but I should not ever have done that in BicubicInterpolate().
 */
{

  // debugging:
  /*std::cout << std::endl << "debugging! BOL_CubicInterpolate( "
	    << input_z << ", " << far_left_z << ", " << far_left_value
	    << ", " << near_left_z << ", " << near_left_value << ", "
	    << near_right_z << ", " << near_right_value << ", " << far_right_z
	    << ", " << far_right_value << " ) called.";
	    std::cout << std::endl;*/

  if( input_z == near_left_z )
    {

      return near_left_value;

    }
  else if( !( ( far_right_z > near_right_z )
	      &&
	      ( near_right_z > near_left_z )
	      &&
	      ( near_left_z > far_left_z ) ) )
    {

      std::cout << std::endl << "BOL_CubicInterpolate error!" << std::endl;
      std::cout << "!( ( far_right_z > near_right_z )" << std::endl;
      std::cout << "&&" << std::endl;
      std::cout << "( near_right_z > near_left_z )" << std::endl;
      std::cout << "&&" << std::endl;
      std::cout << "( near_left_z > far_left_z ) )" << std::endl;
      return NAN;

    }
  /*else if( input_z == far_left_z )
    // this should never happen. :P
    {

      return far_left_value;

    }
  else if( input_z == near_right_z )
    // this should never happen. :P
    {

      return near_right_value;

      }
  else if( input_z == far_right_z )
    // this should never happen. :P
    {

      return far_right_value;

      }*/
  else
    {

      double delta_far_left = ( far_left_z - near_left_z );
      double delta_near_right = ( near_right_z - near_left_z );
      double delta_far_right = ( far_right_z - near_left_z );
      double delta_z = ( input_z - near_left_z );

      double constant_coefficient = near_left_value;

      double far_left_difference = ( far_left_value - near_left_value );
      double near_right_difference = ( near_right_value - near_left_value );
      double far_right_difference = ( far_right_value - near_left_value );

      // debugging:
      /*std::cout << std::endl << "delta_far_left = " << delta_far_left;
	std::cout << std::endl << "delta_near_right = " << delta_near_right;
	std::cout << std::endl << "delta_far_right = " << delta_far_right;
	std::cout << std::endl << "delta_z = " << delta_z;
	std::cout << std::endl << "constant_coefficient = " << constant_coefficient;
	std::cout << std::endl << "far_left_difference = " << far_left_difference;
	std::cout << std::endl << "near_right_difference = " << near_right_difference;
	std::cout << std::endl << "far_right_difference = " << far_right_difference;
	std::cout << std::endl;*/

      double cubic_coefficient
	= ( ( ( ( ( far_left_difference * delta_near_right
		    - near_right_difference * delta_far_left )
		  * ( delta_near_right - delta_far_right ) )
		/ ( delta_near_right * delta_far_left ) )
	      + ( ( ( near_right_difference * delta_far_right
		      - far_right_difference * delta_near_right )
		    * ( delta_near_right - delta_far_left ) )
		  / ( delta_near_right * delta_far_right ) ) )
	    / ( ( delta_far_right - delta_near_right )
		* ( delta_near_right - delta_far_left )
		* ( delta_near_right + delta_far_left )
		+ ( delta_near_right - delta_far_left )
		* ( delta_near_right - delta_far_right )
		* ( delta_near_right + delta_far_right ) ) );

      double quadratic_coefficient
	= ( ( ( near_right_difference
		- delta_near_right * delta_near_right
		* delta_near_right * cubic_coefficient ) * delta_far_right
	      - ( far_right_difference
		  - delta_far_right * delta_far_right
		  * delta_far_right * cubic_coefficient ) * delta_near_right )
	    / ( delta_near_right * delta_far_right
		* ( delta_near_right - delta_far_right ) ) );

      double linear_coefficient
	= ( ( near_right_difference / delta_near_right )
	    - delta_near_right * delta_near_right * cubic_coefficient
	    - delta_near_right * quadratic_coefficient );

      // debugging:
      /*std::cout << std::endl << "constant_coefficient = " << constant_coefficient;
	std::cout << std::endl << "linear_coefficient = " << linear_coefficient;
	std::cout << std::endl << "quadratic_coefficient = " << quadratic_coefficient;
	std::cout << std::endl << "cubic_coefficient = " << cubic_coefficient;
	std::cout << std::endl << "result = "
	<< ( constant_coefficient
	+ delta_z * linear_coefficient
	+ delta_z * delta_z * quadratic_coefficient
	+ delta_z * delta_z * delta_z * cubic_coefficient );
	std::cout << std::endl;*/

      return ( constant_coefficient
	       + delta_z * linear_coefficient
	       + delta_z * delta_z * quadratic_coefficient
	       + delta_z * delta_z * delta_z * cubic_coefficient );

    }

}


double LogLikelihoodRatio(const TH1F* hs, const TH1F* hb, const TH1F* hd, double relsigsys, double relbkgdsys, const char* option)
{
// <option> can be either "data", "b", "sb", "expected_b" or
// "expected_sb"

  static TRandom3 random;

  int nbinss = hs->GetNbinsX();
  int nbinsb = hb->GetNbinsX();
  int nbinsd = hd->GetNbinsX();
  if (nbinss != nbinsb || nbinsd != nbinss || nbinss<1) {
    std::cout << "binning broken" << std::endl;
    exit(1);
  }

  double b_scale = 1.;
  double s_scale = 1.;
  while (1) {
    b_scale = random.Gaus(1, relbkgdsys);
    if (b_scale>0.) break;
  } 
  while (1) {
    s_scale = random.Gaus(1, relsigsys);
    if (s_scale>0.) break;
  }
  //  std::cout << "b_scale = " << b_scale << " s_scale = " << s_scale << std::endl;
  double loglikelihood_b  = 0;
  double loglikelihood_sb = 0;

  for (int bin=1; bin<=nbinss; bin++) {

    double b = hb->GetBinContent(bin);
    double s = hs->GetBinContent(bin);
    double d = hd->GetBinContent(bin);

    double n = 0;
    double toyb = 0;
    double toysb = 0;
    double numb = 0;
    double numsb = 0;

    if (!strcmp(option, "data"))
      n = d;
    else if (!strcmp(option, "b")) {
      toyb = (double)random.Poisson(b*b_scale);
      // toyb = (double)random.Gaus(b*b_scale, TMath::Sqrt(b*b_scale));
      n = toyb;
    }
    else if (!strcmp(option, "sb")) {
      //      toysb = (double)random.Poisson(s*s_scale) +  (double)random.Poisson(b*b_scale);
      toysb = (double)random.Poisson(s*s_scale + b*b_scale);
      //      toysb = (double)random.Gaus(s*s_scale, TMath::Sqrt(s*s_scale)) +  (double)random.Gaus(b*b_scale,  TMath::Sqrt(b*b_scale));
      //toysb = (double)random.Gaus(s*s_scale + b*b_scale, TMath::Sqrt(s*s_scale + b*b_scale));
      n = toysb;
    }
    else if (!strcmp(option, "expected_b"))
      n = b;
    else if (!strcmp(option, "expected_sb"))
      n = s + b;
    else {
      std::cerr<<"LogLikelihoodRatio: Unknown option "<<option<<std::endl;
      exit(EXIT_FAILURE);
    }

    numb  = TMath::Max(b, 1e-6);
    numsb = TMath::Max(s + b, 1e-6);    

    if (n < 0) n = 0;

    // subtraction of TMath::LnGamma(n + 1) is not necessary
    // in loglikelihood_sb and loglikelihood_b because
    // it disappears in the difference
    // loglikelihood_sb - loglikelihood_b
    loglikelihood_sb += -numsb + n * TMath::Log(numsb);
    loglikelihood_b  += -numb  + n * TMath::Log(numb);
  }

  return loglikelihood_sb - loglikelihood_b;
}
