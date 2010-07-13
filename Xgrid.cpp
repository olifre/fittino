#include "Xgrid.h"

	//empty constructor. does nothing.
Xgrid::Xgrid(){
		
	}
	
	
	//constructor
Xgrid::Xgrid(std::string grid_file,int param_in, int dim_set){

	//set grid dimensions according to specified set. default: cross section grid
		if (dim_set == 1){
			
			X_first =  set1_X_first;
			X_last =  set1_X_last;
			X_density =  set1_X_density;
			X_array_size = set1_X_array_size;
			
			Ntabs = 3;
			
		} else if (dim_set == 2){
			
			X_first =  set2_X_first;
			X_last =  set2_X_last;
			X_density =  set2_X_density;
			X_array_size = set2_X_array_size;
			
			Ntabs = e_distribution_bins + 3;
			
		} else {
			printf("Error: grid dimension sunknown.");
			return;
		}
		
	//allocize array
		grid_array = new double[int(X_array_size)*int(X_array_size)]; 


	       if(grid_array != NULL) 	{
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
Xgrid::~Xgrid(){

	//deallocize array

			delete [] grid_array ;
         }






	
//just for grid file maintenance and scan-plots

void Xgrid::WriteGridGnuplotstyle(std::string file){
	
	
	//built ofstream
	std::ofstream out(file.c_str(), std::ios::in | std::ios::out | std::ios::trunc); 
	
				
	for (int m1=0; m1 < X_array_size*X_density; m1+=10) {
		for(int m2=0; m2<X_array_size*X_density; m2+=10){

			out << m1+X_first << "\t" << m2+X_first << "\t" << this->grid_array[array_index(int(m1/X_density),int(m2/X_density))] << std::endl;	
				
			if(m2 == (X_array_size-1)*X_density) {
				out << std::endl; 			//obligatory free line for gnuplot
			}
		}	
	}
	
	
	
	
	std::cout << X_array_size << " Gnuplotstyle grid File written: " << file << std::endl;

}








int Xgrid::readGrid(std::string file, int param){
	char line[1024];
	char tab[size_of_array][32];		//<-- 100 is hard coded here. should be changed fore dynamicall data type at some point!!!!
	double tabs[size_of_array];
	
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
		
			
	in.getline(line,1024);
	std::stringstream ss (std::stringstream::in | std::stringstream::out);
	ss << line; //line in stringstream schreiben
	for (int j = 0 ; j < size_of_array ; j++) {
			ss.getline(tab[j], 32, '\t');
			tabs[j]=atof(tab[j]);
		}
		
		if (tabs[0] != 0 && tabs[1] != 0 && tabs[2] != 0 			//values ok?
			&& int(tabs[0]) >= X_first && int(tabs[0]) <= X_last && int(tabs[1]) >= X_first && int(tabs[0]) <= X_last )	//values within array boundaries?
		{
	
			//Test Output
// 			std::cout << tabs[0] << "\t" << tabs[1] << "\t" << tabs[10] << std::endl;	

				
			this->grid_array[array_index(int((tabs[0]-X_first)/X_density),int((tabs[1]-X_first)/X_density))] = tabs[2+param];	
						

		}
		
	}
	
	
	//Close file after reading
	in.close();
	
// 	std::cout << "Grid File ( " << file << " ) loaded." << std::endl;

	return 1;
}




double Xgrid::value(double m1, double m2) const {
	int rounded_m1 = d2i(m1);	//round input. we need integers for the array  access.
	int rounded_m2 = d2i(m2);	//
	int m1_remainder = rounded_m1 % X_density; //we need this to calculate distance to the four corners
	int m2_remainder = rounded_m2 % X_density;
	int m1down = rounded_m1 - m1_remainder; 
	int m1up = m1down + X_density;
	int m2down = rounded_m2 - m2_remainder;
	int m2up = m2down + X_density;
	double weights[4];	// array for the four weights
	double weights_sum;	// sum of the four weights
	double values[4];	//values at the 4 corners
	double return_value = 0;	//weighted mean - to be returned.
	
	
	//Make sure we have information there for the asked point. Otherwise: return -1.
	if (m1 > X_last || m1 < X_first || m2 > X_last || m2 < X_first){
/*		std::cout << "No x-section information available for this point" <<std::endl;*/
		return -1;					
	}
	
	

	//Calculate weights for 4 nearest corners using "inverse distance"
	weights[0] = 1./(Sq((m1-m1down)/X_density)+Sq((m2-m2down)/X_density));
	weights[1] = 1./(Sq(1.-double(m1-m1down)/X_density)+Sq(double(m2-m2down)/X_density));
	weights[2] = 1./(Sq(double(m1-m1down)/X_density)+Sq(1.-double(m2-m2down)/X_density));
	weights[3] = 1./(Sq(1.-double(m1-m1down)/X_density)+Sq(1.-double(m2-m2down)/X_density));		

	//normalize weights
	weights_sum = weights[0] + weights[1] + weights[2] + weights[3];
	for(int j=0;j<=3;j++){
		weights[j]=weights[j]/weights_sum;
		
		if (weights[j] != weights[j]) { //avoid overflow for 1/infinity
			weights[j] = 1.;
		}
	}
	
	
	
	//Get values for the for corners.
	values[0] = this->grid_array[array_index(int((m1down-X_first)/X_density), int((m2down-X_first)/X_density))];
	values[1] = this->grid_array[array_index(int((m1up-X_first)/X_density), int((m2down-X_first)/X_density))];
	values[2] = this->grid_array[array_index(int((m1down-X_first)/X_density), int((m2up-X_first)/X_density))];
	values[3] = this->grid_array[array_index(int((m1up-X_first)/X_density), int((m2up-X_first)/X_density))];

	
	
	//now we can calculate the weighted mean
	for(int j=0;j<=3;j++){
		
		if (values[j] < 0.0000001) { weights[j] = 0; }
		
		return_value+=weights[j]*values[j];	
	}
	
	
	return return_value;
}




