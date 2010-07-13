
// this should prevent this class being included multiple times.
#ifndef ACGRID_HPP
#define ACGRID_HPP


// #include <stdio.h>
// #include <stdlib.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include<string>

#include "grid.h"

class ACgrid{

 private:
  //declaration of variables
  double *grid_array; //1-d pointer for 3-d dynamical array
  

  //declaration of prototypes
  int readGrid(std::string, int);
  

 public:

  //empty constructur. does nothing  
  ACgrid();
	
	
  //constructor
  ACgrid(std::string grid_file,int param_in);



  //Destructor
  ~ACgrid();


  //primitive functions we need
  inline int d2i(double d) const { 
    return int(d<0?d-.5:d+.5); 
  }


  inline double Sq (double x) const {
    return x*x;
  }

  inline int array_index(int x,int y,int z) const {
    return x * int(AC_array_size) * int(AC_array_size) + y* int(AC_array_size) +z;
  } 


  double value(double m1, double m2, double m3) const;

}; 



#endif
