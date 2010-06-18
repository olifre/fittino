MICROMEGASDIR  = $(HOME)/theorycodes/NPFitter.mm2.2/micromegas_2.2.CPC.i
MICROMEGASLIBS = $(MICROMEGASDIR)/sources/micromegas.a \
	  	 $(MICROMEGASDIR)/MSSM/lib/aLib.a \
		 $(MICROMEGASDIR)/MSSM/work/work_aux.a \
	   	 $(MICROMEGASDIR)/CalcHEP_src/lib/model_aux.so \
		 $(MICROMEGASDIR)/CalcHEP_src/lib/sqme_aux.so

CXXFLAGS += -I$(MICROMEGASDIR)/MSSM/lib -I$(MICROMEGASDIR)/sources

include $(MICROMEGASDIR)/CalcHEP_src/FlagsForMake
cLib = $(CALCHEP)/lib

all: micromegas.cpp
	$(CXX) $(CXXFLAGS) micromegas.cpp -o micromegas $(MICROMEGASLIBS) $(lDL) -lm