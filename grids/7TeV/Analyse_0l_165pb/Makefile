
CFLAGS = $(shell root-config --cflags)
LIBS   = $(shell root-config --libs)
GLIBS  = $(shell root-config --glibs)

RecoTree: src/RecoTree.cxx  RecoTree.cc src/RecoTree.h 
	g++ -o RecoTree  src/RecoTree.cxx RecoTree.cc $(CFLAGS) $(LIBS) $(GLIBS)

clean:
	rm RecoTree
