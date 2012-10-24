LIBS = -m64 `root-config --glibs` -lMinuit -lMathMore -lMathCore -lMatrix -lFoam -lRooFitCore -lRooFit -L/usr/X11R6/lib -lm -ldl -lstdc++ 

CXXFLAGS = -O3 -Wall -m64 --exceptions -I$(ROOTSYS)/include -I. -fPIC

all: runTest createChi2Histograms libToyLHCChi2Provider.so 

%.o : %.cxx
	$(CXX) $(CXXFLAGS) -c $< -o $@

libToyLHCChi2Provider.so: ToyLHCChi2Provider.o
	$(CXX) -shared -Wl,-soname,libToyLHCChi2Provider.so -o libToyLHCChi2Provider.so ToyLHCChi2Provider.o 

createChi2Histograms: $(CXXOBJS) createChi2Histograms.o libToyLHCChi2Provider.so 
	$(CXX) $(LIBS) createChi2Histograms.o $(CXXOBJS) -o createChi2Histograms -g -L. -lToyLHCChi2Provider

runTest: $(CXXOBJS) runTest.o libToyLHCChi2Provider.so 
	$(CXX) $(LIBS) runTest.o $(CXXOBJS) -o runTest -g -L. -lToyLHCChi2Provider

clean:
	rm -f *.o
	rm -f createChi2Histograms
	rm -f runTest
	rm -f *~
