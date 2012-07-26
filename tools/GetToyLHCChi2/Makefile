LIBS = -m64 `root-config --glibs` -lMinuit -lMathCore -lMatrix -L/usr/X11R6/lib -lm -ldl -lstdc++ 

CXXFLAGS = -O3 -Wall -m64 --exceptions -I$(ROOTSYS)/include -I. -fPIC

all: runTest libToyLHCChi2Provider.so 

%.o : %.cxx
	$(CXX) $(CXXFLAGS) -c $< -o $@

libToyLHCChi2Provider.so: ToyLHCChi2Provider.o
	$(CXX) -shared -Wl,-soname,libToyLHCChi2Provider.so -o libToyLHCChi2Provider.so ToyLHCChi2Provider.o 

runTest: $(CXXOBJS) runTest.o libToyLHCChi2Provider.so 
	$(CXX) $(LIBS) runTest.o $(CXXOBJS) -o runTest -g -L. -lToyLHCChi2Provider

clean:
	rm -f *.o
	rm -f runTest
	rm -f *~
