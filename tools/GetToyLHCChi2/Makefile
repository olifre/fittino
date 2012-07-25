# APEffUncert

LIBS = -m64 `root-config --glibs` -lMinuit -lMathCore -lMatrix -L/usr/X11R6/lib -lm -ldl -lstdc++ 

CXXFLAGS = -O3 -Wall -m64 --exceptions -I$(ROOTSYS)/include -I.

all: runTest 

%.o : %.cxx
	$(CXX) $(CXXFLAGS) -c $< -o $@

runTest: $(CXXOBJS) ToyLHCChi2Provider.o runTest.o 
	$(CXX) $(LIBS) runTest.o $(CXXOBJS) -o runTest -g ToyLHCChi2Provider.o

clean:
	rm -f *.o
	rm -f runTest
	rm -f *~
