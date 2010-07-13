#include "ACgrid.h"



//empty constructor. does nothing.
ACgrid::ACgrid(){
  
}
	
	
//constructor
ACgrid::ACgrid(std::string grid_file,int param_in){
  
  //allocize array
  grid_array = new double[int(AC_array_size)*int(AC_array_size)*int(AC_array_size)]; 
  
  
  if(grid_array != NULL){
    //Memory allocation successfull
    
		
  } else {
    
    printf("Memory allocation failed. Exiting....");
    return;
  }
  

  //Read Grid from File and write in array
  if (!readGrid(grid_file,param_in)){
    std::cout << "EROOR! Grid array has not been created." << std::endl;
  }
  
} //End Constructor



//Destructor
ACgrid::~ACgrid(){
  
  //deallocize 3-d array
  
  delete [] grid_array ;
}


int ACgrid::readGrid(std::string file, int param ){
  char line[512];
  char tab[10][32];
  double tabs[10];
  
  //built ifstream
  std::ifstream in(file.c_str());
	
	
	
	
  //Loop File
  while(!in.eof())
    {
      
      //check if file is good
      if (in.good() !=1){
	std::cout << "IO error! NOT able to read grid file: " << file << std::endl;
	return 0;		
      }
      
		
      in.getline(line,512);
      std::stringstream ss (std::stringstream::in | std::stringstream::out);
      ss << line; //line in stringstream schreiben
      for (int j = 0 ; j < 10 ; j++) {
	ss.getline(tab[j], 32, '\t');
	tabs[j]=atof(tab[j]);
      }
      
      if (tabs[0] != 0 && tabs[1] != 0  			//values ok?
	  && int(tabs[0]) >= AC_first && int(tabs[0]) <= AC_last && int(tabs[1]) >= AC_first && int(tabs[0]) <= AC_last )	//values within array boundaries?
	{
	  this->grid_array[array_index(int((tabs[0]-AC_first)/AC_density),int((tabs[1]-AC_first)/AC_density),int((tabs[2]-AC_first)/AC_density))] = tabs[param+2];	
	  
	  
	  // 			cout << int(tabs[0]) << "\t" << int(tabs[1])  << "\t" << tabs[2] << "\t" << tabs[param+2] << endl;			//Test Output
	}
      
    }
  
	
  //Close file after reading
  in.close();
  
  // 	std::cout << "Grid File ( " << file << "(" << param << ") ) loaded." << std::endl;
  
  return 1;
}


double ACgrid::value(double m1, double m2, double m3) const {
	int rounded_m1 = d2i(m1);	//round input. we need integers for the array  access.
	int rounded_m2 = d2i(m2);	//
	int rounded_m3 = d2i(m3);	//
	int m1_remainder = rounded_m1 % AC_density; //we need this to calculate distance to the four corners
	int m2_remainder = rounded_m2 % AC_density;
	int m3_remainder = rounded_m3 % AC_density;
	int m1down = rounded_m1 - m1_remainder; 
	int m1up = m1down + AC_density;
	int m2down = rounded_m2 - m2_remainder;
	int m2up = m2down + AC_density;
	int m3down = rounded_m3 - m3_remainder;
	int m3up = m3down + AC_density;
	double weights[8];	// array for the four weights
	double weights_sum;	// sum of the four weights
	double values[8];	//values at the 4 corners
	double return_value = 0;	//weighted mean - to be returned.
	
	
	//Make sure we have information there for the asked point. Otherwise: return -1.		<-- include neutralino
	if (m1 > AC_last || m1 < AC_first_colored || m2 > AC_last || m2 < AC_first_colored || m3 > AC_last-150. || m3 < AC_first ){
/*		std::cout << "No x-section information available for this point" <<std::endl;*/
		return -1;					
	} else if (m3+200 > m1 || m3+200 > m2) {
		return -1;
	}
	
	

	//Calculate weights for 8 nearest corners using "inverse distance"
	weights[0] = 1./(Sq(double(m1-m1down)/AC_density)+Sq(double(m2-m2down)/AC_density)+Sq(double(m3-m3down)/AC_density));
	weights[1] = 1./(Sq(1.-double(m1-m1down)/AC_density)+Sq(double(m2-m2down)/AC_density)+Sq(double(m3-m3down)/AC_density));
	weights[2] = 1./(Sq(double(m1-m1down)/AC_density)+Sq(1.-double(m2-m2down)/AC_density)+Sq(double(m3-m3down)/AC_density));
	weights[3] = 1./(Sq(1.-double(m1-m1down)/AC_density)+Sq(1.-double(m2-m2down)/AC_density)+Sq(double(m3-m3down)/AC_density));		
	weights[4] = 1./(Sq((m1-m1down)/AC_density)+Sq((m2-m2down)/AC_density)+Sq(1.-double(m3-m3down)/AC_density));
	weights[5] = 1./(Sq(1.-double(m1-m1down)/AC_density)+Sq(double(m2-m2down)/AC_density)+Sq(1.-double(m3-m3down)/AC_density));
	weights[6] = 1./(Sq(double(m1-m1down)/AC_density)+Sq(1.-double(m2-m2down)/AC_density)+Sq(1.-double(m3-m3down)/AC_density));
	weights[7] = 1./(Sq(1.-double(m1-m1down)/AC_density)+Sq(1.-double(m2-m2down)/AC_density)+Sq(1.-double(m3-m3down)/AC_density));		


	//make sure we do not access msquark > mgluino at the upper cube corners
		if (m1up > m2down) {
			weights[1] = 0;
			weights[5] = 0;
		}


	//normalize weights
	weights_sum = weights[0] + weights[1] + weights[2] + weights[3] + weights[4] + weights[5] + weights[6] + weights[7];
	for(int j=0;j<=7;j++){
		weights[j]=weights[j]/weights_sum;
		
		if (weights[j] != weights[j]) { //avoid overflow for 1/infinity
			weights[j] = 1.;
		}

// 		cout << weights[j] << endl;
	}
	

	//Get values for the for corners.
	values[0] = this->grid_array[array_index(int((m1down-AC_first)/AC_density),int((m2down-AC_first)/AC_density),int((m3down-AC_first)/AC_density))];
	values[1] = this->grid_array[array_index(int((m1up-AC_first)/AC_density),int((m2down-AC_first)/AC_density),int((m3down-AC_first)/AC_density))];
	values[2] = this->grid_array[array_index(int((m1down-AC_first)/AC_density),int((m2up-AC_first)/AC_density),int((m3down-AC_first)/AC_density))];
	values[3] = this->grid_array[array_index(int((m1up-AC_first)/AC_density),int((m2up-AC_first)/AC_density),int((m3down-AC_first)/AC_density))];
	values[4] = this->grid_array[array_index(int((m1down-AC_first)/AC_density),int((m2down-AC_first)/AC_density),int((m3up-AC_first)/AC_density))];
	values[5] = this->grid_array[array_index(int((m1up-AC_first)/AC_density),int((m2down-AC_first)/AC_density),int((m3up-AC_first)/AC_density))];
	values[6] = this->grid_array[array_index(int((m1down-AC_first)/AC_density),int((m2up-AC_first)/AC_density),int((m3up-AC_first)/AC_density))];
	values[7] = this->grid_array[array_index(int((m1up-AC_first)/AC_density),int((m2up-AC_first)/AC_density),int((m3up-AC_first)/AC_density))];
	

	//now we can calculate the weighted mean
	for(int j=0;j<=7;j++){

// 		cout << values[j] << " " << weights[j] << endl;

		if (values[j] < 0.0000001 || values[j] > 1) { weights[j] = 0; }		

		return_value+=weights[j]*values[j];	
	}
	
	
	return return_value;
}






