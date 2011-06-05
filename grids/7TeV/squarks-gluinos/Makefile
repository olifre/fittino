
CFLAGS = $(shell root-config --cflags)
LIBS   = $(shell root-config --libs)
GLIBS  = $(shell root-config --glibs)

RecoTree: src/RecoTree.cxx mt2-1.01a/mt2_bisect.cpp RecoTree.cc src/RecoTree.h mt2-1.01a/mt2_bisect.h
	g++ -o RecoTree mt2-1.01a/mt2_bisect.cpp src/RecoTree.cxx RecoTree.cc $(CFLAGS) $(LIBS) $(GLIBS)

clean:
	rm RecoTree
