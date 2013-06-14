F77C=gfortran
F77CFLAGS=-ffixed-line-length-none

FHINCLUDE=-I/afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/FeynHiggs-2.9.4/x86_64-Linux/include
FHLIBS=-L/afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/FeynHiggs-2.9.4/x86_64-Linux/lib64 -lFH

default: FHeffC FHeffC2

FHeffC: FHeffC.F
	$(F77C) $(F77CFLAGS) $(FHINCLUDE) FHeffC.F -o FHeffC $(FHLIBS)

FHeffC2: FHeffC2.F
	$(F77C) $(F77CFLAGS) $(FHINCLUDE) FHeffC2.F -o FHeffC2 $(FHLIBS)


clean:
	rm -f FHeffC
	rm -f FHeffC2
