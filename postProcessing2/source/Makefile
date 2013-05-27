ROOTCFLAGS       = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS         = $(shell $(ROOTSYS)/bin/root-config --libs) -lRooFitCore -lRooFit -lHistPainter

BOOST            = -I/afs/naf.desy.de/group/atlas/software/lcg/external/Boost/1.42.0_python2.5/x86_64-slc5-gcc43-opt/include/boost-1_42/
SLHAEA           = -I../../

HBLIB	         = -lgfortran -L/afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/HB-15-04-13/ -lHB /afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/HS-24-04-13/HiggsSignals-1.0.0beta/libHS.a

LIBS             = $(ROOTLIBS) $(HBLIB) -L$(FITTINO)/tools/GetToyLHCChi2/ProfileLikelihood/ -lToyLHCChi2Provider 
SOURCES          = $(wildcard *.cpp)
HEADERS          = $(wildcard *.h)
OBJECTS_BASENAME = $(SOURCES:.cpp=.o)

CXX	         = g++
CXXFLAGS         = -g -Wall $(ROOTCFLAGS) $(BOOST) -I$(FITTINO)/tools/GetToyLHCChi2/ProfileLikelihood/ $(SLHAEA)

default: runChi2 runHS CreateImage EdgeDetection cleaner addHiggsBranches FindConfidenceInterval makePull testHS runFH defChi2 sort

-include $(SOURCES:.cpp=.d)

%.d: %.cpp
	@echo Generating dependency file ---------- $@ ----------
	@$(SHELL) -ec '$(CXX) -MM $(CXXFLAGS) $< \
	              | sed '\''s/\($*\)\.o[ :]*/\1.o $@ : /g'\'' > $@; \
	              [ -s $@ ] || rm -f $@'


defChi2: $(OBJECTS_BASENAME) defChi2.cxx
	$(CXX) $(CXXFLAGS) -o defChi2 $(OBJECTS_BASENAME) defChi2.cxx $(LIBS)

sort: $(OBJECTS_BASENAME) sort.cxx
	$(CXX) $(CXXFLAGS) -o sort $(OBJECTS_BASENAME) sort.cxx $(LIBS)


makePull: $(OBJECTS_BASENAME) makePull.cxx
	$(CXX) $(CXXFLAGS) -o makePull $(OBJECTS_BASENAME) makePull.cxx $(LIBS)



runFH: $(OBJECTS_BASENAME) runFH.cxx
	$(CXX) $(CXXFLAGS) -o runFH $(OBJECTS_BASENAME) runFH.cxx $(LIBS)


testHS: $(OBJECTS_BASENAME) testHS.cxx
	$(CXX) $(CXXFLAGS) -o testHS $(OBJECTS_BASENAME) testHS.cxx $(LIBS)


FindConfidenceInterval: $(OBJECTS_BASENAME) FindConfidenceInterval.cxx
	$(CXX) $(CXXFLAGS) -o FindConfidenceInterval $(OBJECTS_BASENAME) FindConfidenceInterval.cxx $(LIBS)


runChi2: $(OBJECTS_BASENAME) runChi2.cxx
	$(CXX) $(CXXFLAGS) -o runChi2 $(OBJECTS_BASENAME) runChi2.cxx $(LIBS)


runHS: $(OBJECTS_BASENAME) runHS.cxx
	$(CXX) $(CXXFLAGS) -o runHS $(OBJECTS_BASENAME) runHS.cxx $(LIBS)


CreateImage: $(OBJECTS_BASENAME) CreateImage.cxx
	$(CXX) $(CXXFLAGS) -o CreateImage $(OBJECTS_BASENAME) CreateImage.cxx $(LIBS)


EdgeDetection: $(OBJECTS_BASENAME) EdgeDetection.cxx
	$(CXX) $(CXXFLAGS) -o EdgeDetection $(OBJECTS_BASENAME) EdgeDetection.cxx $(LIBS)


cleaner: $(OBJECTS_BASENAME) clean.cxx
	$(CXX) $(CXXFLAGS) -o cleaner $(OBJECTS_BASENAME) clean.cxx $(LIBS)


addHiggsBranches: $(OBJECTS_BASENAME) addHiggsBranches.cxx
	$(CXX) $(CXXFLAGS) -o addHiggsBranches $(OBJECTS_BASENAME) addHiggsBranches.cxx $(LIBS)




%.o:  %.cpp  
	$(CXX) -c -o $@ $< $(CXXFLAGS)

clean:
	@rm -f *.o *.d *~ runChi2 runHS CreateImage EdgeDetection cleaner addHiggsBranches FindConfidenceInterval makePull testHS runFH defChi2 sort



