default: decay.o CrossSectionHad.o inputs.o VBF.o

testprog : testprog.o decay.o CrossSectionHad.o inputs.o VBF.o
	gcc -Wall -o testprog testprog.o VBF.o inputs.o CrossSectionHad.o decay.o -Wl,-rpath=/net/home/lxtsfs1/tpe/bheller/Programme/LHAPDF/lib -L/net/home/lxtsfs1/tpe/bheller/Programme/LHAPDF/lib -lstdc++ -lLHAPDF -lgsl -lgslcblas\
         -lm -fopenmp


testprog.o: testprog.cc VBF.o CrossSectionHad.o inputs.o decay.o
	gcc -c -Wall -o testprog.o -I/net/home/lxtsfs1/tpe/bheller/Programme/LHAPDF/include -c testprog.cc

decay.o : decay.cc
	gcc -c -Wall decay.cc -o decay.o

CrossSectionHad.o : CrossSectionHad.cc
	gcc -c -Wall -I/net/home/lxtsfs1/tpe/bheller/Programme/LHAPDF/include CrossSectionHad.cc -o CrossSectionHad.o
 
inputs.o : inputs.cc
	gcc -c -Wall inputs.cc -o inputs.o

VBF.o : VBF.cc
	gcc -c -Wall -I/net/home/lxtsfs1/tpe/bheller/Programme/LHAPDF/include VBF.cc -o VBF.o

clean: 
	rm -f inputs.o CrossSectionHad.o decay.o VBF.o testprog.o testprog
