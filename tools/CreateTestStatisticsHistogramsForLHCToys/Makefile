
CFLAGS = $(shell root-config --cflags)
LIBS   = $(shell root-config --libs)
GLIBS  = $(shell root-config --glibs)

createHistograms:   createHistograms.cxx
	g++ -o createHistograms createHistograms.cxx $(CFLAGS) $(LIBS) $(GLIBS)

clean:
		rm createHistograms
