#MICROMEGASDIR  = /afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/NPFitter.mm2.2/micromegas_2.2.CPC.i
#MICROMEGASDIR  = $(HOME)/theorycodes/micromegas_2.4.O
#MICROMEGASDIR  = $(HOME)/theorycodes/NPFitter.mm2.2/micromegas_2.2.CPC.i
MICROMEGASDIR = /afs/naf.desy.de/group/atlas/scratch/fittino/theorycodes/micromegas_2.4.5

include $(MICROMEGASDIR)/CalcHEP_src/FlagsForMake

MICROMEGASLIBS22 = $(MICROMEGASDIR)/sources/micromegas.a \
	  	   $(MICROMEGASDIR)/MSSM/lib/aLib.a \
		   $(MICROMEGASDIR)/MSSM/work/work_aux.a \
	   	   $(MICROMEGASDIR)/CalcHEP_src/lib/model_aux.so \
		   $(MICROMEGASDIR)/CalcHEP_src/lib/sqme_aux.so

MICROMEGASLIBS24 = $(MICROMEGASDIR)/sources/micromegas.a \
	  	   $(MICROMEGASDIR)/MSSM/lib/aLib.a \
		   $(MICROMEGASDIR)/MSSM/work/work_aux.a \
                   $(MICROMEGASDIR)/CalcHEP_src/lib/libSLHAplus.a \
                   $(MICROMEGASDIR)/CalcHEP_src/lib/sqme_aux.so \
                   $(MICROMEGASDIR)/CalcHEP_src/lib/dynamic_me.a \
		   $(MICROMEGASDIR)/CalcHEP_src/lib/num_c.a \
		   $(MICROMEGASDIR)/CalcHEP_src/lib/serv.a \
		   $(LX11)

#MICROMEGASLIBS   = $(MICROMEGASLIBS22)
MICROMEGASLIBS   = $(MICROMEGASLIBS24)

cLib = $(CALCHEP)/lib

CXXFLAGS += -I$(MICROMEGASDIR)/MSSM/lib -I$(MICROMEGASDIR)/sources

all: runmicromegas.cpp
	$(CXX) $(CXXFLAGS) runmicromegas.cpp -o runmicromegas $(MICROMEGASLIBS) $(lDL) -lm
