/* file CheckVacuum.h
 * Header containing class CheckVacuum. This class reads in a data file 
 * containing vacuum stability information from Vevacious and gives 
 * a result for a given parameter point. 
 * In essence it takes the data file and given the 5 parameters m_0 m_1/2
 * tan(beta) sign(mu) and A_0 it gives you the lifetime/stability of the 
 * desired phenomenological minimum. 
 *
 * Created on: Feb 26, 2014
 *      Author: Jose Eliel Camargo-Molina (Elielx AT gmail.com)
 *      Copyright 2014 J. E. Camargo-Molina
 */



#include <cstdio>
#include <cstdlib>
#include <stdexcept>
#include <vector>
#include <iostream>
#include <fstream>
#include <cmath>
#include <algorithm>


class CheckVacuum

  {
    //Matrix containing data from grid.   
    std::vector < std::vector < double > > DataMatrix;
    //Ranges of parameters in the grid, determined automatically from data.
    double mzeroRange, mhalfRange, TanBRange, AzeroRange; 
    double Entry (double mzero_in, double mhalf_in, double TanB_in, double SignMu_in , double Azero_in, int index ); 
    
    
    public: 
      // Constructor where the filename of the data file is given. 
      CheckVacuum (std::string); 
    
      //function that outputs  stability data for given parameter point
      double Lifetime (double mzero_in, double mhalf_in, double TanB_in, double SignMu_in , double Azero_in)
      { return Entry( mzero_in, mhalf_in, TanB_in, SignMu_in , Azero_in, 6); }
      int Stability (double mzero_in, double mhalf_in, double TanB_in, double SignMu_in , double Azero_in)
      { return Entry( mzero_in, mhalf_in, TanB_in, SignMu_in , Azero_in, 5); } 
                                                                                                          
  
  };



    

inline CheckVacuum::CheckVacuum (std::string Datafile) 
    
    {
  
	std::ifstream StabilityDataFile(Datafile.c_str());           // Opening and reading data file from grid.
    
	if(!StabilityDataFile) // Check if file is opened.
      {
                std::cout<<"Error opening stability data file"<<std::endl;
                exit(EXIT_FAILURE);  //abort program
      }
   
   

    
	while( StabilityDataFile.good() )
	{
	  std::vector<double> Parpoint;  // Vector to hold MINPAR + Stability + lifetime
    
	  double mzero, mhalf, TanB, SignMu, Azero, StableQ, Lifetime;                  // MINPAR parameters, Stability and lifetime
      
	  StabilityDataFile >> mzero >> mhalf >> TanB >> SignMu >> Azero >> StableQ >> Lifetime; // Reading from data file into variables
	  Parpoint.push_back(mzero);                 // saving variables into vector Parpoint
	  Parpoint.push_back(mhalf);
	  Parpoint.push_back(TanB);
	  Parpoint.push_back(SignMu);
	  Parpoint.push_back(Azero);
	  Parpoint.push_back(StableQ);
	  Parpoint.push_back(Lifetime);
      
	  DataMatrix.push_back(Parpoint);           // Storing Vector into DataMatrix
  
   
 
	} 
  
  
    //Finding range of parameters from data for weighted distance.
    
	  std::vector<double> mzeroData, mhalfData, TanBData, AzeroData;
	  
	  for(int k=0;k< DataMatrix.size();k++)
	  {
	    mzeroData.push_back(DataMatrix[k][0]);
	    mhalfData.push_back(DataMatrix[k][1]);
	      TanBData.push_back(DataMatrix[k][2]);
	      AzeroData.push_back(DataMatrix[k][4]);
	  }

	  mzeroRange = *max_element(mzeroData.begin(),mzeroData.end());
	  mhalfRange = *max_element(mhalfData.begin(),mhalfData.end());
	  TanBRange = *max_element(TanBData.begin(),TanBData.end());
	  AzeroRange = *max_element(AzeroData.begin(),AzeroData.end());
    
  
      }
      
      
      inline double CheckVacuum::Entry (double mzero_in, double mhalf_in, double TanB_in, double SignMu_in , double Azero_in, int index)
    
    {
	// Finding the closest points in the .dat file to the input point to check
     
	std::vector<double> Distances;
  
	for (int j=0;j< DataMatrix.size();j++)
	{
	double Distance=0;
	double SignMuCondition=DataMatrix[j][3]- SignMu_in; //Checks if input point and data have the same sign(mu)
	if(SignMuCondition == 0) // if they do, calculate normalized distance. 
	{
		Distance = std::pow(DataMatrix[j][0]-mzero_in,2) / std::pow(mzeroRange,2) +
				   std::pow(DataMatrix[j][1]-mhalf_in,2) / std::pow(mhalfRange,2) +
				   std::pow(DataMatrix[j][2]-TanB_in,2) / std::pow(TanBRange,2) +
				   std::pow(DataMatrix[j][4]- Azero_in,2) / std::pow(AzeroRange,2);
	}
	else
	{
	Distance= 130000000;
	}
      
	Distances.push_back(Distance);
	}
    
	int minDistance = std::distance( Distances.begin(), std::min_element( Distances.begin(), Distances.end() ) ); 
  
	return DataMatrix[minDistance][index];      // Outputs the lifetime for the closest point in the grid.
  
      }
    