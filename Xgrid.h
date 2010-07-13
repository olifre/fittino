
// this should prevent this class being included multiple times.
#ifndef XGRID_HPP
#define XGRID_HPP

#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <sstream>

#include "grid.h"


class Xgrid{

 private:
  //declaration of variables
  double *grid_array;


  //declaration of prototypes
  int readGrid(std::string,int param = 0);

  //dimensions of grid
  int X_first, X_last, X_density, X_array_size, Ntabs;
	
	
 public:
  //declaration of variables
	
  //declaration of prototypes


  //empty constructor. does nothing.
  Xgrid();
	
	
  //constructor
  Xgrid(std::string grid_file,int param_in = 0, int dim_set = 1);


  //Destructor
  ~Xgrid();


  //primitive functions we need
  inline int d2i(double d) const { 
    return int(d<0?d-.5:d+.5); 
  }


  inline double Sq (double x) const {
    return x*x;
  }

  inline int array_index(int x,int y) const {
		
    return x * int(X_array_size) + y ;
		
  } 


  double value(double m1, double m2) const; 


  //just for grid file maintenance and scan-plots

  void WriteGridGnuplotstyle(std::string file);


}; //end grid class

#endif
