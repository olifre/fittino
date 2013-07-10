# vbfhad :  VBF.o
# 	gcc -Wall -o vbfprog vbfprog.o VBF.o -Wl,-rpath=/afs/atlass01.physik.uni-bonn.de/user/sarrazin/Downloads/lhapdf-5.8.9/install/lib -L/afs/atlass01.physik.uni-bonn.de/user/sarrazin/Downloads/lhapdf-5.8.9/install/lib -lstdc++ -lLHAPDF -lgsl -lgslcblas -lm 

default: VBF.o CrossSectionHad.o decay.o CrossSection.o

CrossSectionHad.o : CrossSection_had.cc
	gcc -I/afs/atlass01.physik.uni-bonn.de/user/sarrazin/Downloads/lhapdf-5.8.9/install/include -c CrossSection_had.cc -o CrossSectionHad.o

CrossSection.o : CrossSection.cc
	g++ -c -Wall CrossSection.cc

VBF.o : VBF.cc
	gcc -Wall -I/afs/atlass01.physik.uni-bonn.de/user/sarrazin/Downloads/lhapdf-5.8.9/install/include -c VBF.cc -o VBF.o

decay.o: decay.cc
	gcc -Wall -c decay.cc -o decay.o 
clean:
	rm -f VBF.o CrossSectionHad.o decay.o CrossSection.o


